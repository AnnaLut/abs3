.head 0 +  Application Description: +-------------------------------------------+
! Отдельный модуль создания файла лицензии  !
! для подзадачи КЛИЕНТ-БАНК. Параметр: имя  !
! текстового файла (МФО.Txt), создает рядом !
! с этим файлом файл лицензии (МФО.Lcw).    !
!-------------------------------------------!
! Структура файла МФО.Txt: (строки 28 байт) !
! код ОКПО клиента       - С,10;            !
! "электронный" код      - С,4;             !
! номер подключения      - N,4;             !
! дата действия лицензии - С,8 (ГГГГММДД);  !
! признак конца строки	 - B,2 (CRLF).      !
!-------------------------------------------!
! Структура файла МФО.Lcw:                  !
! 1-байт  - маска для XOR;                  !
! блоки:                                    !
! 1-байт  - длина текста(N);                !
! N-байт  - код ОКПО клиента;               !
! 4-байта - "электронный" код клиента;      !
! 4-байта - номер подключения;              !
! 8-байт  - дата действия лицензии.         !
+-------------------------------------------+
.head 1 -  Outline Version - 4.0.26
.head 1 +  Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000B50000 002C000000020000 0003000000FFFFFF FFFFFFFFFFFCFFFF
0040: FFE9FFFFFFFFFFFF FF000000007C0200 004D010000010000 0000000000010000
0060: 000F4170706C6963 6174696F6E497465 6D00000000
.enddata
.data DT_MAKERUNDLG
0000: 00000000000D443A 5C4C637749434B2E 4578650E443A5C21 4C49434943542E64
0020: 6C6C0E443A5C214C 49434943542E6170 6300000101011D51 3A5C424152533938
0040: 5C4C494252415259 5C214C4943494354 2E72756E1D513A5C 4241525339385C4C
0060: 4942524152595C21 4C49434943542E64 6C6C1D513A5C4241 525339385C4C4942
0080: 524152595C214C49 434943542E617063 00000101011D513A 5C4241525339385C
00A0: 4C4942524152595C 214C49434943542E 6170641D513A5C42 41525339385C4C49
00C0: 42524152595C214C 49434943542E646C 6C1D513A5C424152 5339385C4C494252
00E0: 4152595C214C4943 4943542E61706300 000101011D513A5C 4241525339385C4C
0100: 4942524152595C21 4C49434943542E61 706C1D513A5C4241 525339385C4C4942
0120: 524152595C214C49 434943542E646C6C 1D513A5C42415253 39385C4C49425241
0140: 52595C214C494349 43542E6170630000 010101
.enddata
.head 2 -  Outline Window State: Normal
.head 2 +  Outline Window Location and Size
.data VIEWINFO
0000: 6600040003002D00 0000000000000000 0000B71E5D0E0500 1D00FFFF4D61696E
0020: 0000000000000000 0000000000000000 0000003B00010000 00000000000000E9
0040: 1E800A00008600FF FF496E7465726E61 6C2046756E637469 6F6E730000000000
0060: 0000000000000000 0000000000003200 0100000000000000 0000E91E800A0000
0080: DF00FFFF56617269 61626C6573000000 0000000000000000 0000000000000000
00A0: 3000010000000000 00000000F51E100D 0000F400FFFF436C 6173736573000000
00C0: 0000000000000000 0000000000000000
.enddata
.data VIEWSIZE
0000: D000
.enddata
.head 3 -  Left:   -0.013"
.head 3 -  Top:    0.0"
.head 3 -  Width:  8.013"
.head 3 -  Height: 4.969"
.head 2 +  Options Box Location
.data VIEWINFO
0000: 1018B80BB80B2500
.enddata
.data VIEWSIZE
0000: 0800
.enddata
.head 3 -  Visible? Yes
.head 3 -  Left:   4.15"
.head 3 -  Top:    1.885"
.head 3 -  Width:  3.8"
.head 3 -  Height: 2.073"
.head 2 +  Class Editor Location
.head 3 -  Visible? No
.head 3 -  Left:   0.575"
.head 3 -  Top:    0.094"
.head 3 -  Width:  5.063"
.head 3 -  Height: 2.719"
.head 2 +  Tool Palette Location
.head 3 -  Visible? No
.head 3 -  Left:   6.388"
.head 3 -  Top:    0.729"
.head 2 -  Fully Qualified External References? Yes
.head 2 -  Reject Multiple Window Instances? No
.head 2 -  Enable Runtime Checks Of External References? Yes
.head 2 -  Use Release 4.0 Scope Rules? No
.head 1 +  Libraries
.head 2 -  File Include: Vtdos.apl
.head 1 +  Global Declarations
.head 2 +  Window Defaults
.head 3 +  Tool Bar
.head 4 -  Display Style? Etched
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: System Default
.head 4 -  Text Color: System Default
.head 4 -  Background Color: System Default
.head 3 +  Form Window
.head 4 -  Display Style? Etched
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: System Default
.head 4 -  Text Color: System Default
.head 4 -  Background Color: System Default
.head 3 +  Dialog Box
.head 4 -  Display Style? Etched
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: System Default
.head 4 -  Text Color: System Default
.head 4 -  Background Color: System Default
.head 3 +  Top Level Table Window
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: System Default
.head 4 -  Text Color: System Default
.head 4 -  Background Color: System Default
.head 3 +  Data Field
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Multiline Field
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Spin Field
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Background Text
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Pushbutton
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 3 +  Radio Button
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Check Box
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Option Button
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 3 +  Group Box
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Child Table Window
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  List Box
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Combo Box
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Line
.head 4 -  Line Color: Use Parent
.head 3 +  Frame
.head 4 -  Border Color: Use Parent
.head 4 -  Background Color: 3D Face Color
.head 3 +  Picture
.head 4 -  Border Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 2 +  Formats
.head 3 -  Number: 0'%'
.head 3 -  Number: #0
.head 3 -  Number: ###000
.head 3 -  Number: ###000;'($'###000')'
.head 3 -  Date/Time: hh:mm:ss AMPM
.head 3 -  Date/Time: M/d/yy
.head 3 -  Date/Time: MM-dd-yy
.head 3 -  Date/Time: dd-MMM-yyyy
.head 3 -  Date/Time: MMM d, yyyy
.head 3 -  Date/Time: MMM d, yyyy hh:mm AMPM
.head 3 -  Date/Time: MMMM d, yyyy hh:mm AMPM
.head 2 +  External Functions
.head 2 +  Constants
.data CCDATA
0000: 3000000000000000 0000000000000000 00000000
.enddata
.data CCSIZE
0000: 1400
.enddata
.head 3 +  System
.head 3 -  User
.head 2 -  Resources
.head 2 +  Variables
.head 3 -  String: s1
.head 3 -  ! String: s2
.head 3 -  String: s3
.head 3 -  String: s4
.head 3 -  File Handle: fh1
.head 3 -  File Handle: fh2
.head 3 -  String: sLo
.head 3 -  ! String: sDirSpec
.head 3 -  ! Number: nAttribute
.head 3 -  String: sFiles[*]
.head 3 -  ! Number: nSizes[*]
.head 3 -  ! Date/Time: dtDateTimes[*]
.head 3 -  ! Number: nAttributes[*]
.head 3 -  Boolean: bFirst
.head 3 -  Boolean: bNu
.head 3 -  Number: nSeed
.head 3 -  Number: nU1
.head 3 -  Number: nKs
.head 3 -  String: sFlcw
.head 2 +  Internal Functions
.head 3 +  Function: SalNumberXOR
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Number:
.head 4 +  Parameters
.head 5 -  Number: n1
.head 5 -  Number: n2
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Return (n1 & (-1-n2)) | (n2 & (-1-n1))
.head 3 +  Function: MessageNoWait
.head 4 -  Description: Информационное сообщение с заданным
ожиданием (Марийко Б.Г.)
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: sTex	! Текст сообщения
.head 5 -  String: sZagol	! Заголовок сообщения
.head 5 -  Number: nKs	! К-во секунд задержки
		! (0 - с остановкой)
.head 5 -  Number: nMode	! Режим сообщения
		! 0 - обычное сообщение
		! 1 - аварийное сообщение
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Return SalModalDialog( dlg_MessageNoWait, hWndForm, sTex,
            sZagol, nKs, nMode )
.head 3 +  Function: ShProcess
.head 4 -  Description: Показ процесса работы
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Return SalModalDialog( Process, hWndNULL )
.head 2 -  Named Menus
.head 2 -  Class Definitions
.head 2 +  Default Classes
.head 3 -  MDI Window: cBaseMDI
.head 3 -  Form Window:
.head 3 -  Dialog Box:
.head 3 -  Table Window:
.head 3 -  Quest Window:
.head 3 -  Data Field:
.head 3 -  Spin Field:
.head 3 -  Multiline Field:
.head 3 -  Pushbutton:
.head 3 -  Radio Button:
.head 3 -  Option Button:
.head 3 -  Check Box:
.head 3 -  Child Table:
.head 3 -  Quest Child Window: cQuickDatabase
.head 3 -  List Box:
.head 3 -  Combo Box:
.head 3 -  Picture:
.head 3 -  Vertical Scroll Bar:
.head 3 -  Horizontal Scroll Bar:
.head 3 -  Column:
.head 3 -  Background Text:
.head 3 -  Group Box:
.head 3 -  Line:
.head 3 -  Frame:
.head 3 -  Custom Control:
.head 2 +  Application Actions
.head 3 +  On SAM_AppStartup
.head 4 +  If nArgCount = 2
.head 5 -  Call ShProcess()
.head 4 +  Else
.head 5 -  Call MessageNoWait('Отсутствует параметр (имя ' ||
       'текстового файла).', 'LcwICK.Exe: ОШИБКА', 16, 1)
.head 1 +  Dialog Box: Process
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Создание файла лицензии
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? No
.head 2 -  Display Settings
.head 3 -  Display Style? Etched
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   3.788"
.head 4 -  Top:    0.906"
.head 4 -  Width:  3.214"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 1.417"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Bold
.head 3 -  Text Color: Black
.head 3 -  Background Color: White
.head 2 -  Description: Окно для показа процесса создания .Lcw
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? No
.head 4 -  Size: Default
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Black
.head 4 -  Background Color: White
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  Data Field: TextP
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.386"
.head 6 -  Top:    0.179"
.head 6 -  Width:  2.4"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.726"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Center
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Courier
.head 5 -  Font Size: 40
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Black
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 -  Window Variables
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow(Process)
.head 4 -  Set TextP = '0'
.head 3 +  On SAM_CreateComplete
.head 4 +  If VisDosEnumFiles(strArgArray[1], FA_Standard, sFiles) = 1
.head 5 +  If SalFileOpen(fh1, strArgArray[1], OF_Read) 
.head 6 -  Set bFirst = FALSE
.head 6 -  Set bNu = TRUE
.head 6 -  Set nKs = 0
.head 6 +  While SalFileRead(fh1, sLo, 28) > 25
.head 7 -  Set nKs = nKs+1
.head 7 -  Set TextP = SalNumberToStrX(nKs, 0)
.head 7 +  If not bFirst
.head 8 -  Set bFirst = TRUE
.head 8 -  Set sFlcw = SalStrLeftX(strArgArray[1],
    SalStrLength(strArgArray[1]) - 3) || 'Lcw'
.head 8 +  If SalFileOpen(fh2, sFlcw, OF_Create | OF_Write) 
.head 9 -  Call SalNumberRandInit(SalDateMinute(
     SalDateCurrent()))
.head 9 -  Set nSeed = SalNumberMod(SalNumberRandom(), 256)
.head 9 +  If SalFileWrite(fh2, SalNumberToChar(nSeed), 1) != 1
.head 10 -  Call SalFileClose(fh2)
.head 10 -  Call SalFileOpen(fh2,s1,OF_Delete)
.head 10 -  Call SalMessageBox('1. Невозможно создать файл '
     || sFlcw, 'Ошибка', MB_Ok | MB_IconHand)
.head 10 -  Break
.head 7 -  Set s3 = SalNumberToChar(SalStrLength(SalStrTrimX(
    SalStrLeftX(sLo, 10))))
.head 7 -  Set s1 = s3 || SalStrTrimX(SalStrLeftX(sLo, 38)) ||
    SalStrMidX(sLo, 10, 16)
.head 7 +  While SalStrLength(s1) > 0
.head 8 -  Set nSeed = SalNumberMod(nSeed+1, 256)
.head 8 -  Call SalStrFirstC(s1, nU1)
.head 8 -  Set s4 = SalNumberToChar(SalNumberXOR(nU1, nSeed))
.head 8 +  If SalStrLength(s4) = 0
.head 9 -  Call SalFilePutChar(fh2, 0)
.head 8 +  Else
.head 9 +  If SalFileWrite(fh2, s4, 1) != 1
.head 10 -  Call SalFileClose(fh2)
.head 10 -  Call SalFileOpen(fh2, sFlcw, OF_Delete)
.head 10 -  Call SalMessageBox('3. Невозможно создать файл '
     || sFlcw, 'Ошибка', MB_Ok | MB_IconHand)
.head 10 -  Set bNu = FALSE
.head 10 -  Break
.head 7 +  If not bNu
.head 8 -  Break
.head 6 -  Call SalFileClose(fh1)
.head 6 +  If bNu
.head 7 -  Call SalFileClose(fh2)
.head 7 -  Call MessageNoWait('Записано в файл ' || sFlcw ||
     ' строк: ' || SalNumberToStrX(nKs, 0),
     'СФОРМИРОВАН ФАЙЛ ЛИЦЕНЗИИ ' || sFlcw, 7, 0)
.head 5 +  Else
.head 6 -  Call SalMessageBox('4. Невозможно открыть файл ' ||
     strArgArray[1], 'Ошибка', MB_Ok | MB_IconHand)
.head 5 -  Call SalEndDialog(Process, 0)
.head 1 +  Dialog Box: dlg_MessageNoWait
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title:
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? No
.head 2 -  Display Settings
.head 3 -  Display Style? Etched
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   3.613"
.head 4 -  Top:    1.156"
.head 4 -  Width:  6.229"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 2.262"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Bold
.head 3 -  Text Color: White
.head 3 -  Background Color: Red
.head 2 -  Description: Вывод сообщения без ожидания
(задается интервал остановки)
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? No
.head 4 -  Size: Default
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Red
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  Multiline Field: mlMsgTxt
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  String Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Border? No
.head 5 -  Word Wrap? Yes
.head 5 -  Vertical Scroll? No
.head 5 -  Window Location and Size
.head 6 -  Left:   0.086"
.head 6 -  Top:    -0.01"
.head 6 -  Width:  6.1"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 1.75"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: 11
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: White
.head 5 -  Background Color: Red
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Call SalSetFocus(pbOk)
.head 3 +  Pushbutton: pbOk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ok
.head 4 -  Window Location and Size
.head 5 -  Left:   -0.014"
.head 5 -  Top:    1.655"
.head 5 -  Width:  6.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.333"
.head 5 -  Height Editable? No
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: White
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If nTz > 0
.head 7 -  Call SalTimerKill(dlg_MessageNoWait, 1)
.head 6 -  Call SalEndDialog(dlg_MessageNoWait, 0)
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  String: sText
.head 3 -  String: sHeader
.head 3 -  Number: nTz
.head 3 -  Number: n01
.head 2 +  Window Variables
.head 3 -  Number: nTm
.head 3 -  String: sTm
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Set nTm = 0
.head 4 -  Call SalCenterWindow(dlg_MessageNoWait)
.head 4 -  Set sTm = 'Ok'
.head 4 +  If nTz > 0
.head 5 -  Set sTm = sTm || ' (' || SalNumberToStrX(nTz, 0) || ')'
.head 4 -  Call SalSetWindowText(hWndForm, ' ' || sHeader)
.head 4 -  Call SalSetWindowText(pbOk, sTm)
.head 4 -  Call SalSetFocus(pbOk)
.head 4 -  Set mlMsgTxt = sText
.head 4 +  If n01 = 0 !! Обычное сообщение
.head 5 -  Call SalColorSet(mlMsgTxt, COLOR_IndexWindowText,
     COLOR_Black)
.head 5 -  Call SalColorSet(mlMsgTxt, COLOR_IndexWindow, COLOR_Gray)
.head 5 -  Call SalColorSet(hWndForm, COLOR_IndexWindow, COLOR_Gray)
.head 4 +  Else If n01 = 1 !! Аварийное сообщение
.head 5 -  Call SalColorSet(mlMsgTxt, COLOR_IndexWindowText,
     COLOR_White)
.head 5 -  Call SalColorSet(mlMsgTxt, COLOR_IndexWindow, COLOR_Red)
.head 5 -  Call SalColorSet(hWndForm, COLOR_IndexWindow, COLOR_Red)
.head 5 -  Call SalMessageBeep(MB_IconAsterisk)
.head 4 +  If nTz > 0
.head 5 -  Call SalTimerSet(dlg_MessageNoWait, 1, 1000)
.head 3 +  On SAM_Timer
.head 4 +  If nTz > 0
.head 5 -  Set nTm = nTm + 1
.head 5 +  If nTm > nTz
.head 6 -  Call SalSendMsg(pbOk, SAM_Click, 0, 0)
.head 5 +  Else
.head 6 -  Call SalSetWindowText(pbOk, 'Ok (' ||
     SalNumberToStrX(nTz-nTm, 0) || ')')
