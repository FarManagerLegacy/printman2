(*
  Print Manger - плагин Менеждер печати
  Copyright (c) 2009, [ niarbrnd ]
  Roman A. Dyachkov
*)

{$APPTYPE CONSOLE}
{$MINENUMSIZE 4}
library hello;

uses system,sysutils,windows,plugin,Printers,winspool,Registry;
const
  PName = 'PrintMan2';
type
  TMessage = (MTitle, MTitleMenu, MButton);

var
  FARAPI: TPluginStartupInfo;
  kb: TKeyBarTitles;
  FRegRoot,PLastPrinter:string;

function GetMsg(MsgId: TMessage): PChar;
begin
  result:= FARAPI.GetMsg(FARAPI.ModuleNumber, integer(MsgId));
end;
procedure ReadSettings;
var
    vKey :TRegistry;
  begin
    vKey:=TRegistry.Create;
    vKey.RootKey := HKEY_CURRENT_USER;
    if not vKey.OpenKeyReadOnly(FRegRoot+'\'+PName)  then
      Exit;
    try
      if vKey.ValueExists('LastSelectPrinter') then
        PLastPrinter:= vKey.ReadString('LastSelectPrinter');
      vKey.CloseKey;
    finally
      vKey.Free;
    end;
end;

procedure mess (strMess: string);
var
  Msg: array[0..6] of PChar;

begin

  Msg[0]:= pchar(strMess);
  Msg[1]:= pchar(strMess);
  Msg[2]:= pchar(strMess);
  Msg[3]:= pchar(strMess);
  Msg[4]:= pchar(strMess);
  Msg[5]:= #01#00;                   // separator line
  Msg[6]:= GetMsg(MButton);

  FARAPI.Message(FARAPI.ModuleNumber,             // PluginNumber
                 FMSG_WARNING or FMSG_LEFTALIGN,  // Flags
                'Contents',                       // HelpTopic
                 @Msg,                            // Items
                 7,                               // ItemsNumber
                 1);                              // ButtonsNumber

end;

function WriteSettings(Param:string;Value:string):boolean;
  var
    vKey :TRegistry;
  begin
    result:=false;
    vKey:=TRegistry.Create;
    vKey.RootKey := HKEY_CURRENT_USER;
    //mess (Value);

    try
      //if vKey.ValueExists('LastSelectPrinter') then
      //  PLastPrinter:= vKey.ReadString('LastSelectPrinter');
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


procedure GetOpenPluginInfo (hplugin: thandle; var opi: TOpenPluginInfo); stdcall;

begin
  fillchar(kb,sizeof(kb),#0);
  kb.ShiftTitles[6]:= 'Prn';
  kb.AltTitles[4]:= 'Prn';
  opi.StructSize:= SizeOf(opi);
  opi.Flags:=OPIF_USEFILTER;
  opi.HostFile:=nil;
  opi.CurDir:='';
  opi.Format:='';
  opi.PanelTitle:='';
  opi.InfoLines:=nil;
  opi.InfoLinesNumber:=0;
  opi.DescrFiles:=nil;
  opi.DescrFilesNumber:=0;
  opi.PanelModesArray:=nil;
  opi.PanelModesNumber:=0;
  opi.StartPanelMode:=0;
  opi.StartSortMode:=SM_DEFAULT;
  opi.StartSortOrder:=0;
  opi.ShortcutData:=nil;
  opi.Reserved:=0;
  opi.keybar:=@kb;
end;

procedure SetStartupInfo(var psi: TPluginStartupInfo); stdcall;
begin
  Move(psi, FARAPI, SizeOf(FARAPI));
  FRegRoot:=FARAPI.RootKey;
end;

var
  PluginMenuStrings: array[0..0] of PChar;

procedure GetPluginInfo(var pi: TPluginInfo); stdcall;
begin
  pi.StructSize:= SizeOf(pi);
  pi.Flags:= PF_EDITOR;

  PluginMenuStrings[0]:= GetMsg(MTitle);
  pi.PluginMenuStrings:= @PluginMenuStrings;
  pi.PluginMenuStringsNumber:= 1;
  pi.SysID:=1851870544;
  //pi.PluginConfigStrings:= @PluginMenuStrings;
  //pi.PluginConfigStringsNumber:= 1;
end;

function OpenPlugin(OpenFrom: integer; Item: integer): THandle; stdcall;

var

  Msg:array[0..127] of TFarMenuItem;
  i,resultmenu: integer;
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

//  pcbNeeded: DWORD;
  FDevice: PChar;
//  FPort: PChar;
//  FDriver: PChar;
  FPrinterHandle: THandle;
//  FDeviceMode: THandle;
  DOC:DOC_INFO_1;
//  lpData:pchar;
  dwBytesWritten:Cardinal;

begin
  result:=INVALID_HANDLE_VALUE;
  ReadSettings;
  fillchar(msg ,128*SizeOf(TFarMenuItem),#0);
  for i := 0 to Printer.Printers.Count-1 do
    begin
      StrPCopy(Msg[i].Text, Printer.Printers.Strings[i]);
      if Printer.Printers.Strings[i]=PLastPrinter then
        msg[i].Selected:=true;
    end;
  resultmenu:= farapi.Menu( FARAPI.ModuleNumber,
              -1,-1, 0,FMENU_WRAPMODE,
              GetMsg(MTitleMenu),// Заголовок меню
              nil, 'Contents', nil, nil, @Msg,  // Items
              Printer.Printers.Count);

  if  resultmenu > -1 then
  begin
    //farapi.RootKey
    if not WriteSettings('LastSelectPrinter',Printer.Printers.Strings[resultmenu]) then
      mess('Error save last selected printed');
    GetMem(FDevice, 128);
//    GetMem(FDriver, 128);
//    GetMem(FPort, 128);
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
            if( StartPagePrinter( FPrinterHandle ) = False) then
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
              //for i:=0 to length(curstringseltext)-1 do
                if( WritePrinter( FPrinterHandle, curstringseltext, length(curstringseltext), dwBytesWritten )= False ) then
                  begin
                    CloseFile(prnfile);
                    EndPagePrinter( FPrinterHandle );
                    EndDocPrinter( FPrinterHandle );
                    ClosePrinter( FPrinterHandle );
                    mess ('error send data to printer');
                    exit
                  end;
            until iCurrLine>ei.TotalLines;
          if( EndPagePrinter( FPrinterHandle )= False ) then
          begin
            //mess ('error end page');
            EndDocPrinter( FPrinterHandle );
            ClosePrinter( FPrinterHandle );
            exit
          end;
        // Информируем спулер о конце документа.
        if( EndDocPrinter( FPrinterHandle )= False ) then
          begin
            //mess ('error end doc');
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
        farapi.Control (INVALID_HANDLE_VALUE,FCTL_GETPANELINFO,@pinfo);
    //MessageBox( 0 , pinfo.CurDir + '\' +  pinfo.PanelItems[pinfo.CurrentItem].FindData.cFileName , 'Look', MB_OK);
        curdirstr:=pinfo.CurDir;
        curfilename:=pinfo.PanelItems[pinfo.CurrentItem].FindData.cFileName ;
    //AssignFile ( myfile, curdirstr + '\' + curfilename);
    //MessageBox( 0 ,pchar(curdirstr + '\' + curfilename), 'Look', MB_OK);
        if pinfo.PanelItems[pinfo.CurrentItem].FindData.dwFileAttributes <> 16 then
        begin
          (*AssignFile(prnfile, curdirstr + '\' + curfilename);
          Reset(prnfile, 1);
      // specify printer port
          AssignFile(port, Printer.Printers.Strings[resultmenu]);
          Rewrite(port, 1);
          repeat
            BlockRead(prnfile, buffer, SizeOf(buffer), Read);
            BlockWrite(port, buffer, Read);
       // Application.ProcessMessages;
          until EOF(prnfile) or (Read <> SizeOf(buffer));
          CloseFile(prnfile);
          CloseFile(port)
          *)
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
    if( StartPagePrinter( FPrinterHandle ) = False) then
      begin
        EndDocPrinter( FPrinterHandle );
        ClosePrinter( FPrinterHandle );
        Exit
      end;
    // Посылаем данные на принтер.

    AssignFile(prnfile, curdirstr + '\' + curfilename);
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
    //mess ('end page');
    CloseFile(prnfile);
    // Конец страницы.
    if( EndPagePrinter( FPrinterHandle )= False ) then
      begin
        mess ('error end page');
        EndDocPrinter( FPrinterHandle );
        ClosePrinter( FPrinterHandle );
        exit
      end;
    // Информируем спулер о конце документа.
    if( EndDocPrinter( FPrinterHandle )= False ) then
      begin
        //mess ('error end doc');
        ClosePrinter( FPrinterHandle );
        exit
      end;
// Закрываем дескриптор принтера.
      ClosePrinter(FPrinterHandle)
        end
      end;
      //mess ('result');
    end
  end
end;

exports
  SetStartupInfo,
  GetOpenPluginInfo,
  GetPluginInfo,
  OpenPlugin;
end.

