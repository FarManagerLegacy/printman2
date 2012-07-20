(********************************************************
* FARKEYS.PAS
* Inside KeyName for FAR Manager 1.70
*
* Copyright (c) 1996-2000 Eugene Roshal
* Copyrigth (c) 2000-2002 FAR group
*
* $Revision: 1.21 24.05.2002 $
* Translated by Vasily V. Moshninov
*********************************************************)

unit farkeys;

interface

const
// enum BaseDefKeyboard
  KEY_CTRL                 =$01000000;
  KEY_ALT                  =$02000000;
  KEY_SHIFT                =$04000000;
  KEY_RCTRL                =$10000000;
  KEY_RALT                 =$20000000;

  KEY_BRACKET              =byte('[');
  KEY_BACKBRACKET          =byte(']');
  KEY_COMMA                =byte(',');
  KEY_QUOTE                =byte('"');
  KEY_DOT                  =byte('.');
  KEY_SLASH                =byte('/');
  KEY_COLON                =byte(':');
  KEY_BACKSLASH            =byte('\');

  KEY_BS                   =$00000008;
  KEY_TAB                  =$00000009;
  KEY_ENTER                =$0000000D;
  KEY_ESC                  =$0000001B;
  KEY_SPACE                =$00000020;

  KEY_MASKF                =$00000FFF;

  KEY_BREAK                =$00000103;

  KEY_PGUP                 =$00000121;
  KEY_PGDN                 =$00000122;
  KEY_END                  =$00000123;
  KEY_HOME                 =$00000124;
  KEY_LEFT                 =$00000125;
  KEY_UP                   =$00000126;
  KEY_RIGHT                =$00000127;
  KEY_DOWN                 =$00000128;
  KEY_INS                  =$0000012D;
  KEY_DEL                  =$0000012E;

  KEY_LWIN                 =$0000015B;
  KEY_RWIN                 =$0000015C;
  KEY_APPS                 =$0000015D;

  KEY_NUMPAD0              =$00000160;
  KEY_NUMPAD1              =$00000161;
  KEY_NUMPAD2              =$00000162;
  KEY_NUMPAD3              =$00000163;
  KEY_NUMPAD4              =$00000164;
  KEY_NUMPAD5              =$00000165;
  KEY_CLEAR                =KEY_NUMPAD5;
  KEY_NUMPAD6              =$00000166;
  KEY_NUMPAD7              =$00000167;
  KEY_NUMPAD8              =$00000168;
  KEY_NUMPAD9              =$00000169;

  KEY_MULTIPLY             =$0000016A;
  KEY_ADD                  =$0000016B;
  KEY_SUBTRACT             =$0000016D;
  KEY_DIVIDE               =$0000016F;

  KEY_F1                   =$00000170;
  KEY_F2                   =$00000171;
  KEY_F3                   =$00000172;
  KEY_F4                   =$00000173;
  KEY_F5                   =$00000174;
  KEY_F6                   =$00000175;
  KEY_F7                   =$00000176;
  KEY_F8                   =$00000177;
  KEY_F9                   =$00000178;
  KEY_F10                  =$00000179;
  KEY_F11                  =$0000017A;
  KEY_F12                  =$0000017B;

  KEY_CTRLALTSHIFTPRESS    =$00000201;
  KEY_CTRLALTSHIFTRELEASE  =$00000202;

  KEY_MSWHEEL_UP           =$00000203;
  KEY_MSWHEEL_DOWN         =$00000204;

  KEY_END_FKEY             =$00000FFF;

  KEY_NONE                 =$00001001;
  KEY_IDLE                 =$00001002;
  KEY_END_SKEY             =$0000FFFF;
  KEY_LAST_BASE            =KEY_END_SKEY;

// num AddDefKeyboard
  KEY_CTRLSHIFT            =KEY_CTRL or KEY_SHIFT;
  KEY_ALTSHIFT             =KEY_ALT or KEY_SHIFT;
  KEY_CTRLALT              =KEY_CTRL or KEY_ALT;

  KEY_CTRL0                =KEY_CTRL+byte('0');
  KEY_CTRL1                =KEY_CTRL+byte('1');
  KEY_CTRL2                =KEY_CTRL+byte('2');
  KEY_CTRL3                =KEY_CTRL+byte('3');
  KEY_CTRL4                =KEY_CTRL+byte('4');
  KEY_CTRL5                =KEY_CTRL+byte('5');
  KEY_CTRL6                =KEY_CTRL+byte('6');
  KEY_CTRL7                =KEY_CTRL+byte('7');
  KEY_CTRL8                =KEY_CTRL+byte('8');
  KEY_CTRL9                =KEY_CTRL+byte('9');

  KEY_RCTRL0               =KEY_RCTRL+byte('0');
  KEY_RCTRL1               =KEY_RCTRL+byte('1');
  KEY_RCTRL2               =KEY_RCTRL+byte('2');
  KEY_RCTRL3               =KEY_RCTRL+byte('3');
  KEY_RCTRL4               =KEY_RCTRL+byte('4');
  KEY_RCTRL5               =KEY_RCTRL+byte('5');
  KEY_RCTRL6               =KEY_RCTRL+byte('6');
  KEY_RCTRL7               =KEY_RCTRL+byte('7');
  KEY_RCTRL8               =KEY_RCTRL+byte('8');
  KEY_RCTRL9               =KEY_RCTRL+byte('9');

  KEY_CTRLA                =KEY_CTRL+byte('A');
  KEY_CTRLB                =KEY_CTRL+byte('B');
  KEY_CTRLC                =KEY_CTRL+byte('C');
  KEY_CTRLD                =KEY_CTRL+byte('D');
  KEY_CTRLE                =KEY_CTRL+byte('E');
  KEY_CTRLF                =KEY_CTRL+byte('F');
  KEY_CTRLG                =KEY_CTRL+byte('G');
  KEY_CTRLH                =KEY_CTRL+byte('H');
  KEY_CTRLI                =KEY_CTRL+byte('I');
  KEY_CTRLJ                =KEY_CTRL+byte('J');
  KEY_CTRLK                =KEY_CTRL+byte('K');
  KEY_CTRLL                =KEY_CTRL+byte('L');
  KEY_CTRLM                =KEY_CTRL+byte('M');
  KEY_CTRLN                =KEY_CTRL+byte('N');
  KEY_CTRLO                =KEY_CTRL+byte('O');
  KEY_CTRLP                =KEY_CTRL+byte('P');
  KEY_CTRLQ                =KEY_CTRL+byte('Q');
  KEY_CTRLR                =KEY_CTRL+byte('R');
  KEY_CTRLS                =KEY_CTRL+byte('S');
  KEY_CTRLT                =KEY_CTRL+byte('T');
  KEY_CTRLU                =KEY_CTRL+byte('U');
  KEY_CTRLV                =KEY_CTRL+byte('V');
  KEY_CTRLW                =KEY_CTRL+byte('W');
  KEY_CTRLX                =KEY_CTRL+byte('X');
  KEY_CTRLY                =KEY_CTRL+byte('Y');
  KEY_CTRLZ                =KEY_CTRL+byte('Z');

  KEY_CTRLBRACKET          =KEY_CTRL or KEY_BRACKET;
  KEY_CTRLBACKBRACKET      =KEY_CTRL or KEY_BACKBRACKET;
  KEY_CTRLCOMMA            =KEY_CTRL or KEY_COMMA;
  KEY_CTRLQUOTE            =KEY_CTRL or KEY_QUOTE;
  KEY_CTRLDOT              =KEY_CTRL or KEY_DOT;

  KEY_ALT0                 =KEY_ALT+byte('0');
  KEY_ALT1                 =KEY_ALT+byte('1');
  KEY_ALT2                 =KEY_ALT+byte('2');
  KEY_ALT3                 =KEY_ALT+byte('3');
  KEY_ALT4                 =KEY_ALT+byte('4');
  KEY_ALT5                 =KEY_ALT+byte('5');
  KEY_ALT6                 =KEY_ALT+byte('6');
  KEY_ALT7                 =KEY_ALT+byte('7');
  KEY_ALT8                 =KEY_ALT+byte('8');
  KEY_ALT9                 =KEY_ALT+byte('9');

  KEY_ALTADD               =KEY_ALT or KEY_ADD;
  KEY_ALTDOT               =KEY_ALT or KEY_DOT;
  KEY_ALTCOMMA             =KEY_ALT or KEY_COMMA;
  KEY_ALTMULTIPLY          =KEY_ALT or KEY_MULTIPLY;

  KEY_ALTA                 =KEY_ALT+byte('A');
  KEY_ALTB                 =KEY_ALT+byte('B');
  KEY_ALTC                 =KEY_ALT+byte('C');
  KEY_ALTD                 =KEY_ALT+byte('D');
  KEY_ALTE                 =KEY_ALT+byte('E');
  KEY_ALTF                 =KEY_ALT+byte('F');
  KEY_ALTG                 =KEY_ALT+byte('G');
  KEY_ALTH                 =KEY_ALT+byte('H');
  KEY_ALTI                 =KEY_ALT+byte('I');
  KEY_ALTJ                 =KEY_ALT+byte('J');
  KEY_ALTK                 =KEY_ALT+byte('K');
  KEY_ALTL                 =KEY_ALT+byte('L');
  KEY_ALTM                 =KEY_ALT+byte('M');
  KEY_ALTN                 =KEY_ALT+byte('N');
  KEY_ALTO                 =KEY_ALT+byte('O');
  KEY_ALTP                 =KEY_ALT+byte('P');
  KEY_ALTQ                 =KEY_ALT+byte('Q');
  KEY_ALTR                 =KEY_ALT+byte('R');
  KEY_ALTS                 =KEY_ALT+byte('S');
  KEY_ALTT                 =KEY_ALT+byte('T');
  KEY_ALTU                 =KEY_ALT+byte('U');
  KEY_ALTV                 =KEY_ALT+byte('V');
  KEY_ALTW                 =KEY_ALT+byte('W');
  KEY_ALTX                 =KEY_ALT+byte('X');
  KEY_ALTY                 =KEY_ALT+byte('Y');
  KEY_ALTZ                 =KEY_ALT+byte('Z');

  KEY_CTRLSHIFTADD         =KEY_CTRL or KEY_SHIFT or KEY_ADD;
  KEY_CTRLSHIFTSUBTRACT    =KEY_CTRL or KEY_SHIFT or KEY_SUBTRACT;
  KEY_CTRLSHIFTDOT         =KEY_CTRL or KEY_SHIFT or KEY_DOT;
  KEY_CTRLSHIFTSLASH       =KEY_CTRL or KEY_SHIFT or KEY_SLASH;

  KEY_CTRLSHIFT0           =KEY_CTRL or KEY_SHIFT+byte('0');
  KEY_CTRLSHIFT1           =KEY_CTRL or KEY_SHIFT+byte('1');
  KEY_CTRLSHIFT2           =KEY_CTRL or KEY_SHIFT+byte('2');
  KEY_CTRLSHIFT3           =KEY_CTRL or KEY_SHIFT+byte('3');
  KEY_CTRLSHIFT4           =KEY_CTRL or KEY_SHIFT+byte('4');
  KEY_CTRLSHIFT5           =KEY_CTRL or KEY_SHIFT+byte('5');
  KEY_CTRLSHIFT6           =KEY_CTRL or KEY_SHIFT+byte('6');
  KEY_CTRLSHIFT7           =KEY_CTRL or KEY_SHIFT+byte('7');
  KEY_CTRLSHIFT8           =KEY_CTRL or KEY_SHIFT+byte('8');
  KEY_CTRLSHIFT9           =KEY_CTRL or KEY_SHIFT+byte('9');

  KEY_RCTRLSHIFT0          =KEY_RCTRL or KEY_SHIFT+byte('0');
  KEY_RCTRLSHIFT1          =KEY_RCTRL or KEY_SHIFT+byte('1');
  KEY_RCTRLSHIFT2          =KEY_RCTRL or KEY_SHIFT+byte('2');
  KEY_RCTRLSHIFT3          =KEY_RCTRL or KEY_SHIFT+byte('3');
  KEY_RCTRLSHIFT4          =KEY_RCTRL or KEY_SHIFT+byte('4');
  KEY_RCTRLSHIFT5          =KEY_RCTRL or KEY_SHIFT+byte('5');
  KEY_RCTRLSHIFT6          =KEY_RCTRL or KEY_SHIFT+byte('6');
  KEY_RCTRLSHIFT7          =KEY_RCTRL or KEY_SHIFT+byte('7');
  KEY_RCTRLSHIFT8          =KEY_RCTRL or KEY_SHIFT+byte('8');
  KEY_RCTRLSHIFT9          =KEY_RCTRL or KEY_SHIFT+byte('9');

  KEY_CTRLSHIFTA           =KEY_CTRL or KEY_SHIFT+byte('A');
  KEY_CTRLSHIFTB           =KEY_CTRL or KEY_SHIFT+byte('B');
  KEY_CTRLSHIFTC           =KEY_CTRL or KEY_SHIFT+byte('C');
  KEY_CTRLSHIFTD           =KEY_CTRL or KEY_SHIFT+byte('D');
  KEY_CTRLSHIFTE           =KEY_CTRL or KEY_SHIFT+byte('E');
  KEY_CTRLSHIFTF           =KEY_CTRL or KEY_SHIFT+byte('F');
  KEY_CTRLSHIFTG           =KEY_CTRL or KEY_SHIFT+byte('G');
  KEY_CTRLSHIFTH           =KEY_CTRL or KEY_SHIFT+byte('H');
  KEY_CTRLSHIFTI           =KEY_CTRL or KEY_SHIFT+byte('I');
  KEY_CTRLSHIFTJ           =KEY_CTRL or KEY_SHIFT+byte('J');
  KEY_CTRLSHIFTK           =KEY_CTRL or KEY_SHIFT+byte('K');
  KEY_CTRLSHIFTL           =KEY_CTRL or KEY_SHIFT+byte('L');
  KEY_CTRLSHIFTM           =KEY_CTRL or KEY_SHIFT+byte('M');
  KEY_CTRLSHIFTN           =KEY_CTRL or KEY_SHIFT+byte('N');
  KEY_CTRLSHIFTO           =KEY_CTRL or KEY_SHIFT+byte('O');
  KEY_CTRLSHIFTP           =KEY_CTRL or KEY_SHIFT+byte('P');
  KEY_CTRLSHIFTQ           =KEY_CTRL or KEY_SHIFT+byte('Q');
  KEY_CTRLSHIFTR           =KEY_CTRL or KEY_SHIFT+byte('R');
  KEY_CTRLSHIFTS           =KEY_CTRL or KEY_SHIFT+byte('S');
  KEY_CTRLSHIFTT           =KEY_CTRL or KEY_SHIFT+byte('T');
  KEY_CTRLSHIFTU           =KEY_CTRL or KEY_SHIFT+byte('U');
  KEY_CTRLSHIFTV           =KEY_CTRL or KEY_SHIFT+byte('V');
  KEY_CTRLSHIFTW           =KEY_CTRL or KEY_SHIFT+byte('W');
  KEY_CTRLSHIFTX           =KEY_CTRL or KEY_SHIFT+byte('X');
  KEY_CTRLSHIFTY           =KEY_CTRL or KEY_SHIFT+byte('Y');
  KEY_CTRLSHIFTZ           =KEY_CTRL or KEY_SHIFT+byte('Z');

  KEY_CTRLSHIFTBRACKET     =KEY_CTRL or KEY_SHIFT or KEY_BRACKET;
  KEY_CTRLSHIFTBACKSLASH   =KEY_CTRL or KEY_SHIFT or KEY_BACKSLASH;
  KEY_CTRLSHIFTBACKBRACKET =KEY_CTRL or KEY_SHIFT or KEY_BACKBRACKET;

  KEY_ALTSHIFT0            =KEY_ALT or KEY_SHIFT+byte('0');
  KEY_ALTSHIFT1            =KEY_ALT or KEY_SHIFT+byte('1');
  KEY_ALTSHIFT2            =KEY_ALT or KEY_SHIFT+byte('2');
  KEY_ALTSHIFT3            =KEY_ALT or KEY_SHIFT+byte('3');
  KEY_ALTSHIFT4            =KEY_ALT or KEY_SHIFT+byte('4');
  KEY_ALTSHIFT5            =KEY_ALT or KEY_SHIFT+byte('5');
  KEY_ALTSHIFT6            =KEY_ALT or KEY_SHIFT+byte('6');
  KEY_ALTSHIFT7            =KEY_ALT or KEY_SHIFT+byte('7');
  KEY_ALTSHIFT8            =KEY_ALT or KEY_SHIFT+byte('8');
  KEY_ALTSHIFT9            =KEY_ALT or KEY_SHIFT+byte('9');

  KEY_ALTSHIFTA            =KEY_ALT or KEY_SHIFT+byte('A');
  KEY_ALTSHIFTB            =KEY_ALT or KEY_SHIFT+byte('B');
  KEY_ALTSHIFTC            =KEY_ALT or KEY_SHIFT+byte('C');
  KEY_ALTSHIFTD            =KEY_ALT or KEY_SHIFT+byte('D');
  KEY_ALTSHIFTE            =KEY_ALT or KEY_SHIFT+byte('E');
  KEY_ALTSHIFTF            =KEY_ALT or KEY_SHIFT+byte('F');
  KEY_ALTSHIFTG            =KEY_ALT or KEY_SHIFT+byte('G');
  KEY_ALTSHIFTH            =KEY_ALT or KEY_SHIFT+byte('H');
  KEY_ALTSHIFTI            =KEY_ALT or KEY_SHIFT+byte('I');
  KEY_ALTSHIFTJ            =KEY_ALT or KEY_SHIFT+byte('J');
  KEY_ALTSHIFTK            =KEY_ALT or KEY_SHIFT+byte('K');
  KEY_ALTSHIFTL            =KEY_ALT or KEY_SHIFT+byte('L');
  KEY_ALTSHIFTM            =KEY_ALT or KEY_SHIFT+byte('M');
  KEY_ALTSHIFTN            =KEY_ALT or KEY_SHIFT+byte('N');
  KEY_ALTSHIFTO            =KEY_ALT or KEY_SHIFT+byte('O');
  KEY_ALTSHIFTP            =KEY_ALT or KEY_SHIFT+byte('P');
  KEY_ALTSHIFTQ            =KEY_ALT or KEY_SHIFT+byte('Q');
  KEY_ALTSHIFTR            =KEY_ALT or KEY_SHIFT+byte('R');
  KEY_ALTSHIFTS            =KEY_ALT or KEY_SHIFT+byte('S');
  KEY_ALTSHIFTT            =KEY_ALT or KEY_SHIFT+byte('T');
  KEY_ALTSHIFTU            =KEY_ALT or KEY_SHIFT+byte('U');
  KEY_ALTSHIFTV            =KEY_ALT or KEY_SHIFT+byte('V');
  KEY_ALTSHIFTW            =KEY_ALT or KEY_SHIFT+byte('W');
  KEY_ALTSHIFTX            =KEY_ALT or KEY_SHIFT+byte('X');
  KEY_ALTSHIFTY            =KEY_ALT or KEY_SHIFT+byte('Y');
  KEY_ALTSHIFTZ            =KEY_ALT or KEY_SHIFT+byte('Z');

  KEY_ALTSHIFTBRACKET      =KEY_ALT or KEY_SHIFT or KEY_BRACKET;
  KEY_ALTSHIFTBACKBRACKET  =KEY_ALT or KEY_SHIFT or KEY_BACKBRACKET;

  KEY_CTRLALT0             =KEY_CTRL or KEY_ALT+byte('0');
  KEY_CTRLALT1             =KEY_CTRL or KEY_ALT+byte('1');
  KEY_CTRLALT2             =KEY_CTRL or KEY_ALT+byte('2');
  KEY_CTRLALT3             =KEY_CTRL or KEY_ALT+byte('3');
  KEY_CTRLALT4             =KEY_CTRL or KEY_ALT+byte('4');
  KEY_CTRLALT5             =KEY_CTRL or KEY_ALT+byte('5');
  KEY_CTRLALT6             =KEY_CTRL or KEY_ALT+byte('6');
  KEY_CTRLALT7             =KEY_CTRL or KEY_ALT+byte('7');
  KEY_CTRLALT8             =KEY_CTRL or KEY_ALT+byte('8');
  KEY_CTRLALT9             =KEY_CTRL or KEY_ALT+byte('9');

  KEY_CTRLALTA             =KEY_CTRL or KEY_ALT+byte('A');
  KEY_CTRLALTB             =KEY_CTRL or KEY_ALT+byte('B');
  KEY_CTRLALTC             =KEY_CTRL or KEY_ALT+byte('C');
  KEY_CTRLALTD             =KEY_CTRL or KEY_ALT+byte('D');
  KEY_CTRLALTE             =KEY_CTRL or KEY_ALT+byte('E');
  KEY_CTRLALTF             =KEY_CTRL or KEY_ALT+byte('F');
  KEY_CTRLALTG             =KEY_CTRL or KEY_ALT+byte('G');
  KEY_CTRLALTH             =KEY_CTRL or KEY_ALT+byte('H');
  KEY_CTRLALTI             =KEY_CTRL or KEY_ALT+byte('I');
  KEY_CTRLALTJ             =KEY_CTRL or KEY_ALT+byte('J');
  KEY_CTRLALTK             =KEY_CTRL or KEY_ALT+byte('K');
  KEY_CTRLALTL             =KEY_CTRL or KEY_ALT+byte('L');
  KEY_CTRLALTM             =KEY_CTRL or KEY_ALT+byte('M');
  KEY_CTRLALTN             =KEY_CTRL or KEY_ALT+byte('N');
  KEY_CTRLALTO             =KEY_CTRL or KEY_ALT+byte('O');
  KEY_CTRLALTP             =KEY_CTRL or KEY_ALT+byte('P');
  KEY_CTRLALTQ             =KEY_CTRL or KEY_ALT+byte('Q');
  KEY_CTRLALTR             =KEY_CTRL or KEY_ALT+byte('R');
  KEY_CTRLALTS             =KEY_CTRL or KEY_ALT+byte('S');
  KEY_CTRLALTT             =KEY_CTRL or KEY_ALT+byte('T');
  KEY_CTRLALTU             =KEY_CTRL or KEY_ALT+byte('U');
  KEY_CTRLALTV             =KEY_CTRL or KEY_ALT+byte('V');
  KEY_CTRLALTW             =KEY_CTRL or KEY_ALT+byte('W');
  KEY_CTRLALTX             =KEY_CTRL or KEY_ALT+byte('X');
  KEY_CTRLALTY             =KEY_CTRL or KEY_ALT+byte('Y');
  KEY_CTRLALTZ             =KEY_CTRL or KEY_ALT+byte('Z');

  KEY_CTRLALTBRACKET       =KEY_CTRL or KEY_ALT or KEY_BRACKET;
  KEY_CTRLALTBACKBRACKET   =KEY_CTRL or KEY_ALT or KEY_BACKBRACKET;

  KEY_CTRLF1               =KEY_CTRL or KEY_F1;
  KEY_CTRLF2               =KEY_CTRL or KEY_F2;
  KEY_CTRLF3               =KEY_CTRL or KEY_F3;
  KEY_CTRLF4               =KEY_CTRL or KEY_F4;
  KEY_CTRLF5               =KEY_CTRL or KEY_F5;
  KEY_CTRLF6               =KEY_CTRL or KEY_F6;
  KEY_CTRLF7               =KEY_CTRL or KEY_F7;
  KEY_CTRLF8               =KEY_CTRL or KEY_F8;
  KEY_CTRLF9               =KEY_CTRL or KEY_F9;
  KEY_CTRLF10              =KEY_CTRL or KEY_F10;
  KEY_CTRLF11              =KEY_CTRL or KEY_F11;
  KEY_CTRLF12              =KEY_CTRL or KEY_F12;

  KEY_SHIFTF1              =KEY_SHIFT or KEY_F1;
  KEY_SHIFTF2              =KEY_SHIFT or KEY_F2;
  KEY_SHIFTF3              =KEY_SHIFT or KEY_F3;
  KEY_SHIFTF4              =KEY_SHIFT or KEY_F4;
  KEY_SHIFTF5              =KEY_SHIFT or KEY_F5;
  KEY_SHIFTF6              =KEY_SHIFT or KEY_F6;
  KEY_SHIFTF7              =KEY_SHIFT or KEY_F7;
  KEY_SHIFTF8              =KEY_SHIFT or KEY_F8;
  KEY_SHIFTF9              =KEY_SHIFT or KEY_F9;
  KEY_SHIFTF10             =KEY_SHIFT or KEY_F10;
  KEY_SHIFTF11             =KEY_SHIFT or KEY_F11;
  KEY_SHIFTF12             =KEY_SHIFT or KEY_F12;

  KEY_ALTF1                =KEY_ALT or KEY_F1;
  KEY_ALTF2                =KEY_ALT or KEY_F2;
  KEY_ALTF3                =KEY_ALT or KEY_F3;
  KEY_ALTF4                =KEY_ALT or KEY_F4;
  KEY_ALTF5                =KEY_ALT or KEY_F5;
  KEY_ALTF6                =KEY_ALT or KEY_F6;
  KEY_ALTF7                =KEY_ALT or KEY_F7;
  KEY_ALTF8                =KEY_ALT or KEY_F8;
  KEY_ALTF9                =KEY_ALT or KEY_F9;
  KEY_ALTF10               =KEY_ALT or KEY_F10;
  KEY_ALTF11               =KEY_ALT or KEY_F11;
  KEY_ALTF12               =KEY_ALT or KEY_F12;

  KEY_CTRLSHIFTF1          =KEY_CTRL or KEY_SHIFT or KEY_F1;
  KEY_CTRLSHIFTF2          =KEY_CTRL or KEY_SHIFT or KEY_F2;
  KEY_CTRLSHIFTF3          =KEY_CTRL or KEY_SHIFT or KEY_F3;
  KEY_CTRLSHIFTF4          =KEY_CTRL or KEY_SHIFT or KEY_F4;
  KEY_CTRLSHIFTF5          =KEY_CTRL or KEY_SHIFT or KEY_F5;
  KEY_CTRLSHIFTF6          =KEY_CTRL or KEY_SHIFT or KEY_F6;
  KEY_CTRLSHIFTF7          =KEY_CTRL or KEY_SHIFT or KEY_F7;
  KEY_CTRLSHIFTF8          =KEY_CTRL or KEY_SHIFT or KEY_F8;
  KEY_CTRLSHIFTF9          =KEY_CTRL or KEY_SHIFT or KEY_F9;
  KEY_CTRLSHIFTF10         =KEY_CTRL or KEY_SHIFT or KEY_F10;
  KEY_CTRLSHIFTF11         =KEY_CTRL or KEY_SHIFT or KEY_F11;
  KEY_CTRLSHIFTF12         =KEY_CTRL or KEY_SHIFT or KEY_F12;

  KEY_ALTSHIFTF1           =KEY_ALT or KEY_SHIFT or KEY_F1;
  KEY_ALTSHIFTF2           =KEY_ALT or KEY_SHIFT or KEY_F2;
  KEY_ALTSHIFTF3           =KEY_ALT or KEY_SHIFT or KEY_F3;
  KEY_ALTSHIFTF4           =KEY_ALT or KEY_SHIFT or KEY_F4;
  KEY_ALTSHIFTF5           =KEY_ALT or KEY_SHIFT or KEY_F5;
  KEY_ALTSHIFTF6           =KEY_ALT or KEY_SHIFT or KEY_F6;
  KEY_ALTSHIFTF7           =KEY_ALT or KEY_SHIFT or KEY_F7;
  KEY_ALTSHIFTF8           =KEY_ALT or KEY_SHIFT or KEY_F8;
  KEY_ALTSHIFTF9           =KEY_ALT or KEY_SHIFT or KEY_F9;
  KEY_ALTSHIFTF10          =KEY_ALT or KEY_SHIFT or KEY_F10;
  KEY_ALTSHIFTF11          =KEY_ALT or KEY_SHIFT or KEY_F11;
  KEY_ALTSHIFTF12          =KEY_ALT or KEY_SHIFT or KEY_F12;

  KEY_CTRLALTF1            =KEY_CTRL or KEY_ALT or KEY_F1;
  KEY_CTRLALTF2            =KEY_CTRL or KEY_ALT or KEY_F2;
  KEY_CTRLALTF3            =KEY_CTRL or KEY_ALT or KEY_F3;
  KEY_CTRLALTF4            =KEY_CTRL or KEY_ALT or KEY_F4;
  KEY_CTRLALTF5            =KEY_CTRL or KEY_ALT or KEY_F5;
  KEY_CTRLALTF6            =KEY_CTRL or KEY_ALT or KEY_F6;
  KEY_CTRLALTF7            =KEY_CTRL or KEY_ALT or KEY_F7;
  KEY_CTRLALTF8            =KEY_CTRL or KEY_ALT or KEY_F8;
  KEY_CTRLALTF9            =KEY_CTRL or KEY_ALT or KEY_F9;
  KEY_CTRLALTF10           =KEY_CTRL or KEY_ALT or KEY_F10;
  KEY_CTRLALTF11           =KEY_CTRL or KEY_ALT or KEY_F11;
  KEY_CTRLALTF12           =KEY_CTRL or KEY_ALT or KEY_F12;

  KEY_CTRLHOME             =KEY_CTRL or KEY_HOME;
  KEY_CTRLUP               =KEY_CTRL or KEY_UP;
  KEY_CTRLPGUP             =KEY_CTRL or KEY_PGUP;
  KEY_CTRLLEFT             =KEY_CTRL or KEY_LEFT;
  KEY_CTRLRIGHT            =KEY_CTRL or KEY_RIGHT;
  KEY_CTRLEND              =KEY_CTRL or KEY_END;
  KEY_CTRLDOWN             =KEY_CTRL or KEY_DOWN;
  KEY_CTRLPGDN             =KEY_CTRL or KEY_PGDN;
  KEY_CTRLINS              =KEY_CTRL or KEY_INS;
  KEY_CTRLDEL              =KEY_CTRL or KEY_DEL;

  KEY_SHIFTHOME            =KEY_SHIFT or KEY_HOME;
  KEY_SHIFTUP              =KEY_SHIFT or KEY_UP;
  KEY_SHIFTPGUP            =KEY_SHIFT or KEY_PGUP;
  KEY_SHIFTLEFT            =KEY_SHIFT or KEY_LEFT;
  KEY_SHIFTRIGHT           =KEY_SHIFT or KEY_RIGHT;
  KEY_SHIFTEND             =KEY_SHIFT or KEY_END;
  KEY_SHIFTDOWN            =KEY_SHIFT or KEY_DOWN;
  KEY_SHIFTPGDN            =KEY_SHIFT or KEY_PGDN;
  KEY_SHIFTINS             =KEY_SHIFT or KEY_INS;
  KEY_SHIFTDEL             =KEY_SHIFT or KEY_DEL;

  KEY_ALTHOME              =KEY_ALT or KEY_HOME;
  KEY_ALTUP                =KEY_ALT or KEY_UP;
  KEY_ALTPGUP              =KEY_ALT or KEY_PGUP;
  KEY_ALTLEFT              =KEY_ALT or KEY_LEFT;
  KEY_ALTRIGHT             =KEY_ALT or KEY_RIGHT;
  KEY_ALTEND               =KEY_ALT or KEY_END;
  KEY_ALTDOWN              =KEY_ALT or KEY_DOWN;
  KEY_ALTPGDN              =KEY_ALT or KEY_PGDN;
  KEY_ALTINS               =KEY_ALT or KEY_INS;
  KEY_ALTDEL               =KEY_ALT or KEY_DEL;

  KEY_CTRLSHIFTHOME        =KEY_CTRL or KEY_SHIFT or KEY_HOME;
  KEY_CTRLSHIFTUP          =KEY_CTRL or KEY_SHIFT or KEY_UP;
  KEY_CTRLSHIFTPGUP        =KEY_CTRL or KEY_SHIFT or KEY_PGUP;
  KEY_CTRLSHIFTLEFT        =KEY_CTRL or KEY_SHIFT or KEY_LEFT;
  KEY_CTRLSHIFTRIGHT       =KEY_CTRL or KEY_SHIFT or KEY_RIGHT;
  KEY_CTRLSHIFTEND         =KEY_CTRL or KEY_SHIFT or KEY_END;
  KEY_CTRLSHIFTDOWN        =KEY_CTRL or KEY_SHIFT or KEY_DOWN;
  KEY_CTRLSHIFTPGDN        =KEY_CTRL or KEY_SHIFT or KEY_PGDN;
  KEY_CTRLSHIFTINS         =KEY_CTRL or KEY_SHIFT or KEY_INS;
  KEY_CTRLSHIFTDEL         =KEY_CTRL or KEY_SHIFT or KEY_DEL;

  KEY_ALTSHIFTHOME         =KEY_ALT or KEY_SHIFT or KEY_HOME;
  KEY_ALTSHIFTUP           =KEY_ALT or KEY_SHIFT or KEY_UP;
  KEY_ALTSHIFTPGUP         =KEY_ALT or KEY_SHIFT or KEY_PGUP;
  KEY_ALTSHIFTLEFT         =KEY_ALT or KEY_SHIFT or KEY_LEFT;
  KEY_ALTSHIFTRIGHT        =KEY_ALT or KEY_SHIFT or KEY_RIGHT;
  KEY_ALTSHIFTEND          =KEY_ALT or KEY_SHIFT or KEY_END;
  KEY_ALTSHIFTDOWN         =KEY_ALT or KEY_SHIFT or KEY_DOWN;
  KEY_ALTSHIFTPGDN         =KEY_ALT or KEY_SHIFT or KEY_PGDN;
  KEY_ALTSHIFTINS          =KEY_ALT or KEY_SHIFT or KEY_INS;
  KEY_ALTSHIFTDEL          =KEY_ALT or KEY_SHIFT or KEY_DEL;

  KEY_CTRLALTHOME          =KEY_CTRL or KEY_ALT or KEY_HOME;
  KEY_CTRLALTUP            =KEY_CTRL or KEY_ALT or KEY_UP;
  KEY_CTRLALTPGUP          =KEY_CTRL or KEY_ALT or KEY_PGUP;
  KEY_CTRLALTLEFT          =KEY_CTRL or KEY_ALT or KEY_LEFT;
  KEY_CTRLALTRIGHT         =KEY_CTRL or KEY_ALT or KEY_RIGHT;
  KEY_CTRLALTEND           =KEY_CTRL or KEY_ALT or KEY_END;
  KEY_CTRLALTDOWN          =KEY_CTRL or KEY_ALT or KEY_DOWN;
  KEY_CTRLALTPGDN          =KEY_CTRL or KEY_ALT or KEY_PGDN;
  KEY_CTRLALTINS           =KEY_CTRL or KEY_ALT or KEY_INS;

  KEY_CTRLNUMPAD0          =KEY_CTRL or KEY_NUMPAD0;
  KEY_CTRLNUMPAD1          =KEY_CTRL or KEY_NUMPAD1;
  KEY_CTRLNUMPAD2          =KEY_CTRL or KEY_NUMPAD2;
  KEY_CTRLNUMPAD3          =KEY_CTRL or KEY_NUMPAD3;
  KEY_CTRLNUMPAD4          =KEY_CTRL or KEY_NUMPAD4;
  KEY_CTRLNUMPAD5          =KEY_CTRL or KEY_NUMPAD5;
  KEY_CTRLNUMPAD6          =KEY_CTRL or KEY_NUMPAD6;
  KEY_CTRLNUMPAD7          =KEY_CTRL or KEY_NUMPAD7;
  KEY_CTRLNUMPAD8          =KEY_CTRL or KEY_NUMPAD8;
  KEY_CTRLNUMPAD9          =KEY_CTRL or KEY_NUMPAD9;

  KEY_SHIFTNUMPAD0         =KEY_SHIFT or KEY_NUMPAD0;
  KEY_SHIFTNUMPAD1         =KEY_SHIFT or KEY_NUMPAD1;
  KEY_SHIFTNUMPAD2         =KEY_SHIFT or KEY_NUMPAD2;
  KEY_SHIFTNUMPAD3         =KEY_SHIFT or KEY_NUMPAD3;
  KEY_SHIFTNUMPAD4         =KEY_SHIFT or KEY_NUMPAD4;
  KEY_SHIFTNUMPAD5         =KEY_SHIFT or KEY_NUMPAD5;
  KEY_SHIFTNUMPAD6         =KEY_SHIFT or KEY_NUMPAD6;
  KEY_SHIFTNUMPAD7         =KEY_SHIFT or KEY_NUMPAD7;
  KEY_SHIFTNUMPAD8         =KEY_SHIFT or KEY_NUMPAD8;
  KEY_SHIFTNUMPAD9         =KEY_SHIFT or KEY_NUMPAD9;

  KEY_CTRLSHIFTNUMPAD0     =KEY_CTRL or KEY_SHIFT or KEY_NUMPAD0;
  KEY_CTRLSHIFTNUMPAD1     =KEY_CTRL or KEY_SHIFT or KEY_NUMPAD1;
  KEY_CTRLSHIFTNUMPAD2     =KEY_CTRL or KEY_SHIFT or KEY_NUMPAD2;
  KEY_CTRLSHIFTNUMPAD3     =KEY_CTRL or KEY_SHIFT or KEY_NUMPAD3;
  KEY_CTRLSHIFTNUMPAD4     =KEY_CTRL or KEY_SHIFT or KEY_NUMPAD4;
  KEY_CTRLSHIFTNUMPAD5     =KEY_CTRL or KEY_SHIFT or KEY_NUMPAD5;
  KEY_CTRLSHIFTNUMPAD6     =KEY_CTRL or KEY_SHIFT or KEY_NUMPAD6;
  KEY_CTRLSHIFTNUMPAD7     =KEY_CTRL or KEY_SHIFT or KEY_NUMPAD7;
  KEY_CTRLSHIFTNUMPAD8     =KEY_CTRL or KEY_SHIFT or KEY_NUMPAD8;
  KEY_CTRLSHIFTNUMPAD9     =KEY_CTRL or KEY_SHIFT or KEY_NUMPAD9;

  KEY_CTRLALTNUMPAD0       =KEY_CTRL or KEY_ALT or KEY_NUMPAD0;
  KEY_CTRLALTNUMPAD1       =KEY_CTRL or KEY_ALT or KEY_NUMPAD1;
  KEY_CTRLALTNUMPAD2       =KEY_CTRL or KEY_ALT or KEY_NUMPAD2;
  KEY_CTRLALTNUMPAD3       =KEY_CTRL or KEY_ALT or KEY_NUMPAD3;
  KEY_CTRLALTNUMPAD4       =KEY_CTRL or KEY_ALT or KEY_NUMPAD4;
  KEY_CTRLALTNUMPAD5       =KEY_CTRL or KEY_ALT or KEY_NUMPAD5;
  KEY_CTRLALTNUMPAD6       =KEY_CTRL or KEY_ALT or KEY_NUMPAD6;
  KEY_CTRLALTNUMPAD7       =KEY_CTRL or KEY_ALT or KEY_NUMPAD7;
  KEY_CTRLALTNUMPAD8       =KEY_CTRL or KEY_ALT or KEY_NUMPAD8;
  KEY_CTRLALTNUMPAD9       =KEY_CTRL or KEY_ALT or KEY_NUMPAD9;

  KEY_ALTSHIFTNUMPAD0      =KEY_ALT or KEY_SHIFT or KEY_NUMPAD0;
  KEY_ALTSHIFTNUMPAD1      =KEY_ALT or KEY_SHIFT or KEY_NUMPAD1;
  KEY_ALTSHIFTNUMPAD2      =KEY_ALT or KEY_SHIFT or KEY_NUMPAD2;
  KEY_ALTSHIFTNUMPAD3      =KEY_ALT or KEY_SHIFT or KEY_NUMPAD3;
  KEY_ALTSHIFTNUMPAD4      =KEY_ALT or KEY_SHIFT or KEY_NUMPAD4;
  KEY_ALTSHIFTNUMPAD5      =KEY_ALT or KEY_SHIFT or KEY_NUMPAD5;
  KEY_ALTSHIFTNUMPAD6      =KEY_ALT or KEY_SHIFT or KEY_NUMPAD6;
  KEY_ALTSHIFTNUMPAD7      =KEY_ALT or KEY_SHIFT or KEY_NUMPAD7;
  KEY_ALTSHIFTNUMPAD8      =KEY_ALT or KEY_SHIFT or KEY_NUMPAD8;
  KEY_ALTSHIFTNUMPAD9      =KEY_ALT or KEY_SHIFT or KEY_NUMPAD9;

  KEY_CTRLSLASH            =KEY_CTRL or KEY_SLASH;
  KEY_CTRLBACKSLASH        =KEY_CTRL or KEY_BACKSLASH;
  KEY_CTRLCLEAR            =KEY_CTRL or KEY_CLEAR;
  KEY_CTRLADD              =KEY_CTRL or KEY_ADD;
  KEY_SHIFTADD             =KEY_SHIFT or KEY_ADD;

  KEY_CTRLSUBTRACT         =KEY_CTRL or KEY_SUBTRACT;
  KEY_ALTSUBTRACT          =KEY_ALT or KEY_SUBTRACT;
  KEY_SHIFTSUBTRACT        =KEY_SHIFT or KEY_SUBTRACT;
  KEY_CTRLMULTIPLY         =KEY_CTRL or KEY_MULTIPLY;

  KEY_CTRLBS               =KEY_CTRL or KEY_BS;
  KEY_ALTBS                =KEY_ALT or KEY_BS;
  KEY_CTRLSHIFTBS          =KEY_CTRL or KEY_SHIFT or KEY_BS;
  KEY_SHIFTBS              =KEY_SHIFT or KEY_BS;

  KEY_CTRLSHIFTTAB         =KEY_CTRL or KEY_SHIFT or KEY_TAB;
  KEY_CTRLTAB              =KEY_CTRL or KEY_TAB;
  KEY_SHIFTTAB             =KEY_SHIFT or KEY_TAB;

  KEY_CTRLENTER            =KEY_CTRL or KEY_ENTER;
  KEY_SHIFTENTER           =KEY_SHIFT or KEY_ENTER;
  KEY_ALTSHIFTENTER        =KEY_ALT or KEY_SHIFT or KEY_ENTER;
  KEY_CTRLALTENTER         =KEY_CTRL or KEY_ALT or KEY_ENTER;
  KEY_CTRLSHIFTENTER       =KEY_CTRL or KEY_SHIFT or KEY_ENTER;

  KEY_CTRLAPPS             =KEY_CTRL or KEY_APPS;
  KEY_ALTAPPS              =KEY_ALT or KEY_APPS;
  KEY_SHIFTAPPS            =KEY_SHIFT or KEY_APPS;
  KEY_CTRLSHIFTAPPS        =KEY_CTRL or KEY_SHIFT or KEY_APPS;
  KEY_ALTSHIFTAPPS         =KEY_ALT or KEY_SHIFT or KEY_APPS;
  KEY_CTRLALTAPPS          =KEY_CTRL or KEY_ALT or KEY_APPS;

  KEY_CTRLSPACE            =KEY_CTRL or KEY_SPACE;
  KEY_SHIFTSPACE           =KEY_SHIFT or KEY_SPACE;
  KEY_CTRLSHIFTSPACE       =KEY_CTRL or KEY_SHIFT or KEY_SPACE;

  KEY_ALT_BASE             =KEY_ALT;
  KEY_ALTSHIFT_BASE        =KEY_ALTSHIFT;

implementation

end.
