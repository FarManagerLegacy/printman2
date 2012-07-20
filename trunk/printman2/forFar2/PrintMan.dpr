(*
  Print Manаger 2 - плагин Менеждер печати 2
  Copyright (c) 2009, [ niarbrnd ]
  Roman A. Dyachkov
*)

{$APPTYPE CONSOLE}
{$MINENUMSIZE 4}
library hello;

uses system,sysutils,windows,pluginw,Printers,winspool,Registry;
const
  PName = 'PrintMan2';
type
  TMessage = (MTitle, MTitleMenu, MButton);

var
  FARAPI: TPluginStartupInfo;
  FRegRoot,PLastPrinter:string;

function GetMsg(MsgId: TMessage): PFarChar;
begin
  result:= FARAPI.GetMsg(FARAPI.ModuleNumber, integer(MsgId));
end;
procedure ReadSettings;  //получаем настройки плагина
var
    vKey :TRegistry;
  begin
    vKey:=TRegistry.Create;
    vKey.RootKey := HKEY_CURRENT_USER;
    if not vKey.OpenKeyReadOnly(FRegRoot+'\'+PName)  then
      Exit;
    try
      if vKey.ValueExists('LastSelectPrinter') then
        PLastPrinter:= vKey.ReadString('LastSelectPrinter'); //получаем принтер на который выполнялась предыдущая печать
      vKey.CloseKey;
    finally
      vKey.Free;
    end;
end;

procedure mess (strMess: PFarChar);    // используется для отладки и вывода сообщений об ошибках
var
  Msg: array[0..3] of PFarChar;

begin

  Msg[0]:= PFarChar(strMess);
  Msg[1]:= PFarChar(strMess);
  Msg[2]:= #01#00;                   // separator line
  Msg[3]:= GetMsg(MButton);

  FARAPI.Message(FARAPI.ModuleNumber,             // PluginNumber
                 FMSG_WARNING or FMSG_LEFTALIGN,  // Flags
                'Contents',                       // HelpTopic
                 @Msg,                            // Items
                 4,                               // ItemsNumber
                 1);                              // ButtonsNumber

end;

function WriteSettings(Param:string;Value:string):boolean;
  var
    vKey :TRegistry;
  begin
    result:=false;
    vKey:=TRegistry.Create;
    vKey.RootKey := HKEY_CURRENT_USER;
    try
      if vKey.OpenKey (FRegRoot+'\'+PName,True)  then
        begin
          vKey.WriteString(Param,Value);
          vKey.CloseKey;
          result:=true;
        end;

    finally
      vKey.Free;
    end;
  end;

procedure SetStartupInfoW(var psi: TPluginStartupInfo); stdcall;
begin
  Move(psi, FARAPI, SizeOf(FARAPI));
  FRegRoot:=FARAPI.RootKey;
end;

var
  PluginMenuStrings: array[0..0] of PwideChar;

procedure GetPluginInfoW(var pi: TPluginInfo); stdcall;
begin
  pi.StructSize:= SizeOf(pi);
  pi.Flags:= PF_EDITOR;

  PluginMenuStrings[0]:= GetMsg(MTitle);
  pi.PluginMenuStrings:= @PluginMenuStrings;
  pi.PluginMenuStringsNumber:= 1;
  pi.
  //pi.SysID:=1851870544; //Указфываем SYSID равный SYSID плагина идущего в поставке Far
  //pi.PluginConfigStrings:= @PluginMenuStrings;
  //pi.PluginConfigStringsNumber:= 1;
end;

//function GetPanelFolder(active:boolean): PFarChar;
//begin
//  Result:= Far
//end;

function OpenPluginW(OpenFrom: integer; Item: integer): THandle; stdcall;

var

  Msg:array[0..127] of TFarMenuItem;
  resultmenu: integer;
  pinfo:TPanelInfo;
  curdirstr,curfilename:string;
  curstringseltext:pchar;
  strcurstringseltext:string;
  prnfile: file;
  buffer: array [0..127] of Char;
  Read,iCurrLine: Integer;
  ei: TEditorInfo;
  egs: TEditorGetString;
  isSelectEndString: boolean;

  PluginINFO: TPluginStartupInfo;
  PPI: TPluginPanelItem;
  bcurdir: array [0..127] of Char;

  FDevice: PChar;
  FPrinterHandle: THandle;
  DOC:DOC_INFO_1;
  dwBytesWritten:Cardinal;

begin
  result:=INVALID_HANDLE_VALUE; //Устанавливаем для возвращения в последнее состояние после исполнения плагина
  ReadSettings;
  fillchar(msg ,128*SizeOf(TFarMenuItem),#0);
  //for i := 0 to Printer.Printers.Count-1 do
  //  begin
  //    Str(Msg[i].textptr, Printer.Printers.Strings[i]);
  //    if Printer.Printers.Strings[i]=PLastPrinter then
  //      msg[i].Selected:=1;
  //  end;
  resultmenu:= farapi.Menu( FARAPI.ModuleNumber,
              -1,-1, 0,FMENU_WRAPMODE,
              GetMsg(MTitleMenu),// Заголовок меню
              nil, 'Contents', nil, nil, @Msg,  // Items
              Printer.Printers.Count);

  if  resultmenu > -1 then
  begin
    if not WriteSettings('LastSelectPrinter',Printer.Printers.Strings[resultmenu]) then
      mess('Error save last selected printed');
    GetMem(FDevice, 128);
    FDevice:=pchar(Printer.Printers.Strings[resultmenu]);
  if OpenPrinter(FDevice, FPrinterHandle, nil) then
    begin
  //запущен ли плагин из редактора
    //mess ('opened printer');
    if OpenFrom= OPEN_EDITOR then
      begin
        FARAPI.EditorControl(ECTL_GETINFO,@ei);
        //есть ли выделенный фрагмент
        if ei.BlockType <> BTYPE_None then
          begin

            iCurrLine:=ei.BlockStartLine-1;
            ///
            doc.pDocName:='Print Manager';
            doc.pOutputFile:=nil;
            doc.pDatatype:='RAW';
            // Начало документа
            if StartDocPrinter( FPrinterHandle, 1, @DOC) = 0 then
              begin
                ClosePrinter( FPrinterHandle );
                Exit
              end;
            // Начало страницы.
            if not StartPagePrinter( FPrinterHandle )  then
              begin
                EndDocPrinter( FPrinterHandle );
                ClosePrinter( FPrinterHandle );
                Exit
              end;
            // Посылаем данные на принтер.
            ///
            repeat
              iCurrLine:=iCurrLine+1;
              isSelectEndString:=False;
              egs.StringNumber:=iCurrLine;
              FARAPI.EditorControl(ECTL_GETSTRING,@egs);
              if egs.SelStart=-1 then
                Break;
              if (egs.SelEnd=-1) or (egs.SelEnd>egs.StringLength) then
                begin
                  egs.SelEnd:=egs.StringLength;
                  isSelectEndString:=True;
                  if egs.SelEnd < egs.SelStart then
                    egs.SelEnd:=egs.SelStart;
                end;

              strcurstringseltext:=copy(egs.StringText,egs.SelStart+1,egs.SelEnd-egs.SelStart);
              if isSelectEndString then strcurstringseltext:=strcurstringseltext+#13#10;
              Getmem(curstringseltext,length(strcurstringseltext));
              curstringseltext:=pchar(strcurstringseltext);
              if not WritePrinter( FPrinterHandle, curstringseltext, length(curstringseltext), dwBytesWritten ) then
                begin
                  CloseFile(prnfile);
                  EndPagePrinter( FPrinterHandle );
                  EndDocPrinter( FPrinterHandle );
                  ClosePrinter( FPrinterHandle );
                  mess ('error send data to printer');
                  exit
                end;
            until iCurrLine>ei.TotalLines;
          if not EndPagePrinter( FPrinterHandle ) then
          begin
            mess ('error end page');
            EndDocPrinter( FPrinterHandle );
            ClosePrinter( FPrinterHandle );
            exit
          end;
        // Информируем спулер о конце документа.
        if not EndDocPrinter( FPrinterHandle ) then
          begin
            mess ('error end doc');
            ClosePrinter( FPrinterHandle );
            exit
          end;
          // Закрываем дескриптор принтера.
          ClosePrinter(FPrinterHandle)
          ///
          end;
      end
    else  //иначе плагин вызван не из редактора
      begin
        FillChar(pinfo,sizeof(pinfo),0);
        //farapi.Control (INVALID_HANDLE_VALUE,FCTL_GETPANELINFO,1,@pinfo);
        PluginINFO.Control(PANEL_ACTIVE,FCTL_GETPANELDIR,1024,@bcurdir);
        //curdirstr:=pinfo.curdir;
        //curfilename:=pinfo.PanelItems[pinfo.CurrentItem].FindData.cFileName ;
        PluginINFO.Control(PANEL_ACTIVE,FCTL_GETCURRENTPANELITEM,1024,@PPI);
        curfilename:=ppi.FindData.cFileName;

        if ppi.FindData.dwFileAttributes <> 16 then
        begin
          doc.pDocName:='Print Manager';
          doc.pOutputFile:=nil;
          doc.pDatatype:='RAW';
          // Начало документа
          if StartDocPrinter( FPrinterHandle, 1, @DOC) = 0 then
            begin
              ClosePrinter( FPrinterHandle );
              Exit
            end;
          // Начало страницы.
          if not StartPagePrinter( FPrinterHandle )  then
            begin
              EndDocPrinter( FPrinterHandle );
              ClosePrinter( FPrinterHandle );
              Exit
            end;
          // Посылаем данные на принтер.
          AssignFile(prnfile, curdirstr + '\' + curfilename); //Открываем файл для чтения
          Reset(prnfile, 1);
          //mess ('send data to printer');
          repeat
            BlockRead(prnfile, buffer, SizeOf(buffer), Read);
            if( WritePrinter( FPrinterHandle, @buffer, Read, dwBytesWritten )= False ) then
              begin
                CloseFile(prnfile);
                EndPagePrinter( FPrinterHandle );
                EndDocPrinter( FPrinterHandle );
                ClosePrinter( FPrinterHandle );
                mess ('error send data to printer');
                exit
              end;
          until EOF(prnfile) or (Read <> SizeOf(buffer));
          CloseFile(prnfile);
          // Конец страницы.
          if not EndPagePrinter( FPrinterHandle ) then
            begin
              mess ('error end page');
              EndDocPrinter( FPrinterHandle );
              ClosePrinter( FPrinterHandle );
              exit
            end;
          // Информируем спулер о конце документа.
          if not EndDocPrinter( FPrinterHandle ) then
            begin
              ClosePrinter( FPrinterHandle );
              exit
            end;
          // Закрываем дескриптор принтера.
          ClosePrinter(FPrinterHandle)
        end
      end;
    end
  end
end;

exports
  SetStartupInfoW,
  GetPluginInfoW,
  OpenPluginW;
end.

