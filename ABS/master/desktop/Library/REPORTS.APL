.head 0 +  Application Description: ! REPORTS.APL
! /////////////////////////////////////////////////////////////////////////////////////////////////
! ООО Унити-Барс  ( C )  1998
! Разработчик: Влад Сивяков
! Последнее изменение: 17 августа 1998, 11:30
! /////////////////////////////////////////////////////////////////////////////////////////////////
! Библиотека интерфейса для Crystal Repotrs Engine:
!	--- dlg_CRW		Диалог - список зарегистрированнных
!				в системе CRW и вызов их.
! /////////////////////////////////////////////////////////////////////////////////////////////////
! Библиотека интерфейса для Diamond Repotrs Engine:
!	--- dlg_DRW		Диалог - список зарегистрированнных
!				в системе DRW и вызов их.
! /////////////////////////////////////////////////////////////////////////////////////////////////
.head 1 -  Outline Version - 4.0.26
.head 1 +  Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650200010000
0020: 0000000000000000 002C000000020000 0003000000FFFFFF FFFFFFFFFFFCFFFF
0040: FFE4FFFFFFFFFFFF FF000000007C0200 004D010000010000 0000000000010000
0060: 000F4170706C6963 6174696F6E497465 6D00000000
.enddata
.data DT_MAKERUNDLG
0000: 02000000001C513A 5C4261727339385C 4C6962726172795C 47656E63746C2E65
0020: 78651C513A5C4261 727339385C4C6962 726172795C47656E 63746C2E646C6C1C
0040: 513A5C4261727339 385C4C6962726172 795C47656E63746C 2E61706300000101
0060: 011C513A5C426172 7339385C4C696272 6172795C47656E63 746C2E72756E1C51
0080: 3A5C426172733938 5C4C696272617279 5C47656E63746C2E 646C6C1C513A5C42
00A0: 61727339385C4C69 62726172795C4765 6E63746C2E617063 000001010119513A
00C0: 5C4261727339385C 42494E5C5265706F 7274732E61706418 513A5C4261727339
00E0: 385C42494E5C4765 6E63746C2E646C6C 18513A5C42617273 39385C42494E5C47
0100: 656E63746C2E6170 6300000101011C51 3A5C426172733938 5C4C696272617279
0120: 5C47656E63746C2E 61706C1C513A5C42 61727339385C4C69 62726172795C4765
0140: 6E63746C2E646C6C 1C513A5C42617273 39385C4C69627261 72795C47656E6374
0160: 6C2E617063000001 0101
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
0000: 0218B80BB80B2500
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
.head 2 -  File Include: GenCTL.apl
.head 2 -  Dynalib: Absapi.apd
.head 2 -  Dynalib: Global.apd
.head 2 -  File Include: Vttblwin.apl
.head 2 -  File Include: Genbutn.apl
.head 2 -  Dynalib: Dfltrapi.apd
.head 2 -  File Include: Vtmeter.apl
.head 2 -  File Include: Winbars2.apl
.head 2 -  File Include: Vtwin.apl
.head 2 -  !
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
.head 3 +  Library name: CRPE32.DLL
.head 4 +  ! Function: PEOpenEngine
.head 5 -  Description: Открывает энджин
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 -  Parameters
.head 4 +  ! Function: PECloseEngine
.head 5 -  Description: Закрывает энджин
.head 5 -  Export Ordinal: 0
.head 5 -  Returns
.head 5 -  Parameters
.head 4 +  ! Function: PEOpenPrintJob
.head 5 -  Description: Открывает .RPT
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPSTR
.head 4 +  ! Function: PEStartPrintJob
.head 5 -  Description: Запускает джоб на выполнение
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  ! Job Handle
.head 6 -  Number: SHORT
.head 6 -  ! WaitOrNot
.head 6 -  Number: INT
.head 4 +  ! Function: PEClosePrintJob
.head 5 -  Description: Закрывает джоб
.head 5 -  Export Ordinal: 0
.head 5 -  Returns
.head 5 +  Parameters
.head 6 -  Number: SHORT
.head 4 +  ! Function: PEOutputToWindow
.head 5 -  Description: Выводит в окно
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  ! Job Handle
.head 6 -  Number: SHORT
.head 6 -  ! Windows Handle
.head 6 -  String: LPSTR
.head 6 -  ! Left
.head 6 -  Number: INT
.head 6 -  ! Top
.head 6 -  Number: INT
.head 6 -  ! Width
.head 6 -  Number: INT
.head 6 -  ! Height
.head 6 -  Number: INT
.head 6 -  ! Style
.head 6 -  Number: DWORD
.head 6 -  ! PWindow
.head 6 -  Number: HANDLE
.head 4 +  ! Function: PEGetNthTableLogOnInfo
.head 5 -  Description: Получает логоновую информацию N-й таблицы
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  ! Job
.head 6 -  Number: SHORT
.head 6 -  ! #Table
.head 6 -  Number: SHORT
.head 6 -  ! LogonInfo
.head 6 +  structPointer
.head 7 -  ! StructLength
.head 7 -  Number: WORD
.head 7 -  String: byte[128]
.head 7 -  String: byte[128]
.head 7 -  String: byte[128]
.head 7 -  String: byte[128]
.head 4 +  ! Function: PEPrintReport
.head 5 -  Description: Выводит репорт куда положено
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: SHORT
.head 5 +  Parameters
.head 6 -  ! RPT name
.head 6 -  String: LPSTR
.head 6 -  ! To Printer?
.head 6 -  Number: INT
.head 6 -  ! To Window?
.head 6 -  Number: INT
.head 6 -  ! Windows Handle
.head 6 -  String: LPSTR
.head 6 -  ! Left
.head 6 -  Number: INT
.head 6 -  ! Top
.head 6 -  Number: INT
.head 6 -  ! Width
.head 6 -  Number: INT
.head 6 -  ! Height
.head 6 -  Number: INT
.head 6 -  ! Style
.head 6 -  Number: DWORD
.head 6 -  ! PWindow
.head 6 -  Number: HANDLE
.head 4 +  ! Function: PELogOnServer
.head 5 -  Description: Логонится на сервер
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPSTR
.head 6 +  structPointer
.head 7 -  ! StructLength
.head 7 -  Number: WORD
.head 7 -  String: char[128]
.head 7 -  String: char[128]
.head 7 -  String: char[128]
.head 7 -  String: char[128]
.head 4 +  ! Function: PEGetErrorCode
.head 5 -  Description: Возвращает код последней ошибки
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: SHORT
.head 5 +  Parameters
.head 6 -  Number: SHORT
.head 4 +  ! Function: PEGetErrorText
.head 5 -  Description: Возвращает текст ошибки
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  Number: SHORT
.head 6 -  String: HSTRING
.head 6 -  Number: SHORT
.head 4 -  !
.head 4 -  ! Open & Close PrintEngine
.head 4 -  !
.head 4 +  Function: PEOpenEngine
.head 5 -  Description: Initializing the Crystal Reports Engine
.head 5 -  Export Ordinal: 6
.head 5 +  Returns
.head 6 -  Boolean: BOOL
.head 5 -  Parameters
.head 4 +  Function: PECanCloseEngine
.head 5 -  Description: If we can close Crystal Reports Engine now
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Boolean: BOOL
.head 5 -  Parameters
.head 4 +  Function: PECloseEngine
.head 5 -  Description: Close the Print Engine
.head 5 -  Export Ordinal: 6
.head 5 -  Returns
.head 5 -  Parameters
.head 4 -  !
.head 4 -  ! Open & Close PrintJob
.head 4 -  !
.head 4 +  Function: PEOpenPrintJob
.head 5 -  Description: Open a Crystal report
.head 5 -  Export Ordinal: 9
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  String: LPSTR
.head 4 +  Function: PEClosePrintJob
.head 5 -  Description: Close the print job
.head 5 -  Export Ordinal: 10
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 4 -  !
.head 4 -  ! Start & Cancel PrintJob
.head 4 -  !
.head 4 +  Function: PEPrintReport
.head 5 -  Description: Just print the report - no other PE calls are needed
.head 5 -  Export Ordinal: 38
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  String: LPSTR
.head 6 -  Boolean: BOOL
.head 6 -  Boolean: BOOL
.head 6 -  String: LPSTR
.head 6 -  Number: WORD
.head 6 -  Number: WORD
.head 6 -  Number: WORD
.head 6 -  Number: WORD
.head 6 -  Number: DWORD
.head 6 -  Window Handle: HWND
.head 4 +  Function: PEStartPrintJob
.head 5 -  Description: Initiate the printing of the report
.head 5 -  Export Ordinal: 11
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  Boolean: BOOL
.head 4 -  !
.head 4 -  ! Window
.head 4 -  !
.head 4 +  Function: PEOutputToWindow
.head 5 -  Description: Set the output destination to a window
.head 5 -  Export Ordinal: 17
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  String: LPSTR
.head 6 -  Number: WORD
.head 6 -  Number: WORD
.head 6 -  Number: WORD
.head 6 -  Number: WORD
.head 6 -  Number: LONG
.head 6 -  Window Handle: HWND
.head 4 +  Function: PEGetWindowHandle
.head 5 -  Description: Возвращает заголовок окна выполненной задачи
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: HANDLE
.head 5 +  Parameters
.head 6 -  Number: SHORT
.head 4 +  Function: PEZoomPreviewWindow
.head 5 -  Description: Set Zoom for destination window
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  Number: WORD
.head 4 -  !
.head 4 -  ! Printer
.head 4 -  !
.head 4 +  Function: PEOutputToPrinter
.head 5 -  Description: Set the output destination to the printer
.head 5 -  Export Ordinal: 40
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  Number: WORD
.head 4 +  Function: PESelectPrinter
.head 5 -  Description: Selects current printer
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  String: LPSTR
.head 6 -  String: LPSTR
.head 6 -  String: LPSTR
.head 6 -  Number: HANDLE
.head 4 -  !
.head 4 +  Function: PEGetSQLQuery
.head 5 -  Description: Get the SQL query of a SQL type report
.head 5 -  Export Ordinal: 75
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  Receive Number: LPINT
.head 6 -  Receive Number: LPINT
.head 4 +  Function: PESetSQLQuery
.head 5 -  Description: Overwritting the existing SQL query of a SQL type report
.head 5 -  Export Ordinal: 76
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  String: LPSTR
.head 4 +  Function: PEGetHandleString
.head 5 -  Description: Get the handle of the string - used in conjunction with PEGetSQLQuery
.head 5 -  Export Ordinal: 37
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: LONG
.head 6 -  Receive String: LPSTR
.head 6 -  Number: WORD
.head 4 +  Function: PEGetErrorCode
.head 5 -  Description: Get error code - used after each PE call for debugging purpose
.head 5 -  Export Ordinal: 35
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 4 +  Function: PESetNthSortField
.head 5 -  Description: Change the record sort order
.head 5 -  Export Ordinal: 23
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  Number: WORD
.head 6 -  String: LPSTR
.head 6 -  Number: WORD
.head 4 +  Function: PELogonServer
.head 5 -  Description: Logon to server - so that all reports can use this connection
.head 5 -  Export Ordinal: 62
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  String: LPSTR
.head 6 +  structPointer
.head 7 -  Number: WORD
.head 7 -  String: char[128]
.head 7 -  String: char[128]
.head 7 -  String: char[128]
.head 7 -  String: char[128]
.head 4 -  !
.head 4 -  ! Formula Handling
.head 4 -  !
.head 4 +  Function: PEGetNFormulas
.head 5 -  Description: Get the number of formulas in the current report
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 4 +  Function: PEGetNthFormula
.head 5 -  Description: Get the contents of Nth formulae
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  Number: WORD
.head 6 -  Receive Number: LPULONG
.head 6 -  Receive Number: LPINT
.head 6 -  Receive Number: LPULONG
.head 6 -  Receive Number: LPINT
.head 4 +  Function: PEGetFormula
.head 5 -  Description: Get the contents of formulae
.head 5 -  Export Ordinal: 29
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  Number: WORD
.head 6 -  String: LPSTR
.head 6 -  Receive Number: LPINT
.head 6 -  Receive Number: LPINT
.head 4 +  Function: PESetFormula
.head 5 -  Description: Changes the specified formula to the formula string you supply
.head 5 -  Export Ordinal: 30
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  String: LPSTR
.head 6 -  String: LPSTR
.head 4 +  Function: PECheckFormula
.head 5 -  Description: Checks the specified formula
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  String: LPSTR
.head 4 +  Function: PEGetSelectionFormula
.head 5 -  Description: Get the selection formula of the report
.head 5 -  Export Ordinal: 31
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  Receive Number: LPINT
.head 6 -  Receive Number: LPINT
.head 4 +  Function: PESetSelectionFormula
.head 5 -  Description: Set the selection criteria of the report
.head 5 -  Export Ordinal: 32
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  String: LPSTR
.head 4 -  !
.head 4 -  ! Tables control
.head 4 -  !
.head 4 +  Function: PEGetNthTableLocation
.head 5 -  Description: Get the nth table location
.head 5 -  Export Ordinal: 59
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  Number: WORD
.head 6 +  structPointer
.head 7 -  Number: WORD
.head 7 -  Receive String: LPSTR
.head 4 +  Function: PESetNthTableLocation
.head 5 -  Description: Change the nth table's location
.head 5 -  Export Ordinal: 60
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 +  structPointer
.head 7 -  Number: WORD
.head 7 -  String: LPSTR
.head 4 +  Function: PEGetNthTableLogonInfo
.head 5 -  Description: Get the nth table's logon info
.head 5 -  Export Ordinal: 57
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  Number: WORD
.head 6 +  structPointer
.head 7 -  Number: WORD
.head 7 -  Receive String: char[128]
.head 7 -  Receive String: char[128]
.head 7 -  Receive String: char[128]
.head 7 -  String: char[128]
.head 4 +  Function: PESetNthTableLogonInfo
.head 5 -  Description: Set the nth table's logon info
.head 5 -  Export Ordinal: 58
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  Number: WORD
.head 6 +  structPointer
.head 7 -  Number: WORD
.head 7 -  Receive String: char[128]
.head 7 -  Receive String: char[128]
.head 7 -  Receive String: char[128]
.head 7 -  String: char[128]
.head 6 -  Boolean: BOOL
.head 4 +  Function: PELogoffServer
.head 5 -  Description: Logoff server - close the current connection
.head 5 -  Export Ordinal: 63
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  String: HSTRING
.head 6 +  structPointer
.head 7 -  Number: WORD
.head 7 -  String: char[128]
.head 7 -  String: char[128]
.head 7 -  String: char[128]
.head 7 -  String: char[128]
.head 4 +  Function: PEGetNTables
.head 5 -  Description: Get the number of tables in the current report
.head 5 -  Export Ordinal: 53
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 4 +  Function: PEGetNthTableType
.head 5 -  Description: Function used to determine what type of a report this is: SQL or PC
.head 5 -  Export Ordinal: 54
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  Number: WORD
.head 6 +  structPointer
.head 7 -  Number: WORD
.head 7 -  Receive String: char[64]
.head 7 -  Receive String: char[255]
.head 7 -  Receive Number: WORD
.head 4 -  !
.head 4 -  ! Section Control
.head 4 -  !
.head 4 +  Function: PEGetNSections
.head 5 -  Description: Get the number of sections in the current report
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 4 +  Function: PEGetSectionCode
.head 5 -  Description: Get the section code
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  Number: WORD
.head 4 -  !
.head 4 -  ! Subreport control
.head 4 -  !
.head 4 +  Function: PEGetNSubreportsInSection
.head 5 -  Description: Get # of Subreports inside the section
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  Number: WORD
.head 4 +  Function: PEGetNthSubreportInSection
.head 5 -  Description: Get the handle of Nth Subreport inside the section
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: LONG
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  Number: WORD
.head 6 -  Number: WORD
.head 4 +  Function: PEGetSubreportInfo
.head 5 -  Description: Get the info of Nth Subreport inside the section
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  Number: LONG
.head 6 +  structPointer
.head 7 -  Number: WORD
.head 7 -  Receive String: char[128]
.head 4 +  Function: PEOpenSubreport
.head 5 -  Description: Opens Subreport
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 6 -  String: LPSTR
.head 4 +  Function: PECloseSubreport
.head 5 -  Description: Closes Subreport
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: WORD
.head 5 +  Parameters
.head 6 -  Number: WORD
.head 2 +  Constants
.data CCDATA
0000: 3000000000000000 0000000000000000 00000000
.enddata
.data CCSIZE
0000: 1400
.enddata
.head 3 +  System
.head 3 +  User
.head 2 -  Resources
.head 2 +  Variables
.data RESOURCE 0 0 1 1289360983
0000: 6C00000031000000 0000000000000000 0200000400000015 000000E803040000
0020: FF3F1900A0000002 040000FFFF001D00 0000010D0000FE00 FF832A00000002FB
0040: 00FF0F
.enddata
.head 2 +  Internal Functions
.head 3 +  ! Function: ShowReports			! __exported
.head 4 -  Description: 
.head 4 -  Returns 
.head 4 +  Parameters 
.head 5 -  Number: nReport
.head 4 -  Static Variables 
.head 4 -  Local variables 
.head 4 +  Actions 
.head 5 -  Call ShowCRW (nReport)
.head 3 +  Function: ShowCRW		! __exported
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Number: nReport
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  ! Call SalMessageBox( SalNumberToStrX( SalWindowHandleToNumber( hSql() ), 0 ), 'Debug hSql()!', 0)
.head 5 -  Call SalModalDialog( dlg_CRW, hWndForm, nReport)
.head 3 +  Function: ShowDRW		! __exported
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Number: nReport
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  ! Call SalMessageBox( SalNumberToStrX( SalWindowHandleToNumber( hSql() ), 0 ), 'Debug hSql()!', 0)
.head 5 -  Call SalModalDialog( dlg_DRW, hWndForm, nReport)
.head 2 -  Named Menus
.head 2 +  Class Definitions
.data RESOURCE 0 0 1 2840244134
0000: 7200000056000000 0000000000000000 0200000100FFFF01 00160000436C6173
0020: 73566172004F7574 6C696E6552006567 496E666F11003C00 000F63006C734572
0040: 726F7243006F6E74 726F6C3800C00000 0200000083020400 0000FFFF04040000
0060: 010D0000FE00FF03
.enddata
.head 2 +  Default Classes
.head 3 -  MDI Window: cBaseMDI
.head 3 -  Form Window:
.head 3 -  Dialog Box:
.head 3 -  Table Window:
.head 3 -  Quest Window:
.head 3 -  Data Field: clsMoneyField
.head 3 -  Spin Field:
.head 3 -  Multiline Field:
.head 3 -  Pushbutton: cpbCancel
.head 3 -  Radio Button:
.head 3 -  Option Button:
.head 3 -  Check Box:
.head 3 -  Child Table: clsSortedTable
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
.head 2 -  Application Actions
.head 1 -  !
.head 1 +  Dialog Box: dlg_CRW
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Файлы отчётов
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  13.017"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 6.583"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Crystal Reports
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: Default
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  Pushbutton: pbOK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выполнить
.head 4 -  Window Location and Size
.head 5 -  Left:   3.283"
.head 5 -  Top:    5.655"
.head 5 -  Width:  1.8"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalWaitCursor( TRUE )
.head 6 -  !
.head 6 -  ! Открываем репорт
.head 6 -  !
.head 6 -  ! Set strCRW =  "D:\\REPORTS\\" || tblCRWs.colName
.head 6 -  Call SalFileGetCurrentDirectory( strCRW )
.head 6 -  Call SalMessageBox( strCRW, 'Debug', 0)
.head 6 -  Set strCRW =  "Q:\\BARS98\\REPORTS\\" || tblCRWs.colName
.head 6 -  Set hPEJob = PEOpenPrintJob(strCRW )
.head 6 +  If hPEJob = 0
.head 7 -  Call SalMessageBox( "CRPE01003: Не могу открыть файл:
"|| strCRW, "Ошибка", MB_Ok+MB_IconExclamation )
.head 6 +  If PEGetNthTableType(hPEJob, 0, 324, strDLL, strDescriptiveName, nDBType) != 1
.head 7 -  Call SalMessageBox('CRPE01002: Не могу получить имя DLL !', "Ошибка", MB_Ok)
.head 6 -  !
.head 6 -  ! Устанавливаем LogonInfo всем таблицам
.head 6 -  ! (ВНИМАНИЕ!!! не будет работать, если в оригинальном репорте несколько разных серверов и/или баз данных!!!)
.head 6 -  ! на разные таблицы (внутри одного сервера и БД) не распространяется, естественно
.head 6 -  !
.head 6 -  Set nTable = 0
.head 6 +  Loop
.head 7 +  If PEGetNthTableLogonInfo( hPEJob, nTable, 128*4+2, strServer, strDB, strUser, strPwd ) = 0
.head 8 -  Break
.head 7 -  ! Set n = PEGetNthTableLocation( hPEJob, nTable, 128+2, strLoc )
.head 7 -  Set strDB = SqlDatabase
.head 7 -  Set strServer = GetHost()
.head 7 -  Set strUser = SqlUser
.head 7 -  Set strPwd = SqlPassword
.head 7 -  ! Call SalMessageBox("db:" ||strDB||"
srv:"||strServer||"
usr:"||strUser||"
pwd:"||strPwd,"", MB_Ok)
.head 7 +  If PESetNthTableLogonInfo ( hPEJob, nTable, 128*4+2, strServer, strDB, strUser, strPwd, TRUE ) = 0
.head 8 -  Call SalMessageBox( "CRPE01004: Внутренняя ошибка установки LogonInfo.", "Ошибка", MB_OK )
.head 8 -  Break
.head 7 -  Set nTable = nTable+1
.head 6 -  !
.head 6 -  ! Устанавливаем LogonInfo всем таблицам, расположенным в SubReports
.head 6 -  !
.head 6 -  Set nSections = PEGetNSections(hPEJob)
.head 6 +  If nSections < 65535
.head 7 -  Set nSection = 0
.head 7 +  Loop
.head 8 +  If nSection >= nSections
.head 9 -  Break
.head 8 -  Set nSectionCode = PEGetSectionCode( hPEJob, nSection )
.head 8 +  ! If n = 0
.head 9 -  Break 
.head 8 -  ! Call SalMessageBox( SalNumberToStrX( nSectionCode, 0 ), SalNumberToStrX( nSection, 0 ), MB_OK )
.head 8 -  Set nSubReports = PEGetNSubreportsInSection( hPEJob, nSectionCode )
.head 8 -  Set nSubReport = 0
.head 8 +  Loop
.head 9 +  If nSubReport >= nSubReports
.head 10 -  Break
.head 9 -  Set nSubReportCode = PEGetNthSubreportInSection( hPEJob, nSectionCode, nSubReport )
.head 9 +  If PEGetSubreportInfo( hPEJob, nSubReportCode, 128+2, strSubReportName ) = FALSE
.head 10 -  Call SalMessageBox( "CRPE01009: Внутренняя ошибка получения SubreportInfo.", "Ошибка", MB_OK )
.head 10 -  Break
.head 9 -  Set hSubReportJob =  PEOpenSubreport( hPEJob, strSubReportName )
.head 9 +  If hSubReportJob = 0
.head 10 -  Call SalMessageBox( "CRPE01010: Внутренняя ошибка открытия Subreport:"|| strSubReportName ||".", "Ошибка", MB_OK )
.head 10 -  Break
.head 9 -  Set nTable = 0
.head 9 +  Loop
.head 10 +  If PEGetNthTableLogonInfo( hSubReportJob, nTable, 128*4+2, strServer, strDB, strUser, strPwd ) = 0
.head 11 -  Break
.head 10 -  ! Set n = PEGetNthTableLocation( hPEJob, nTable, 128+2, strLoc )
.head 10 -  Set strDB = SqlDatabase
.head 10 -  Set strServer = GetHost()
.head 10 -  Set strUser = SqlUser
.head 10 -  Set strPwd = SqlPassword
.head 10 -  ! Call SalMessageBox("db:" ||strDB||"
srv:"||strServer||"
usr:"||strUser||"
pwd:"||strPwd,"", MB_Ok)
.head 10 +  If PESetNthTableLogonInfo ( hSubReportJob, nTable, 128*4+2, strServer, strDB, strUser, strPwd, TRUE ) = 0 !
.head 11 -  Call SalMessageBox( "CRPE01008: Внутренняя ошибка установки LogonInfo в Subreport:"|| strSubReportName ||".", "Ошибка", MB_OK )
.head 11 -  Break
.head 10 -  Set nTable = nTable+1
.head 9 +  ! If PECloseSubreport( hSubReportJob ) = FALSE
.head 10 -  Call SalMessageBox( "CRPE01011: Внутренняя ошибка закрытия Subreport:"|| strSubReportName ||".", "Ошибка", MB_OK )
.head 10 -  Break 
.head 9 -  Set nSubReport = nSubReport + 1
.head 8 -  Set nSection = nSection+1
.head 6 -  !
.head 6 -  ! Установка Formulas
.head 6 -  !
.head 6 +  If SalModalDialog( dlg_SetCRWParam, hWndForm, hPEJob ) = TRUE
.head 7 -  Set n = SalModalDialog( dlg_SetCRWDestination, hWndForm)
.head 7 +  If n != FALSE
.head 8 +  ! If PELogonServer( strDLL, 128*4+2, strServer, strDB, strUser, strPwd ) = 0		! // ненужно, если запускали SetNthTableLogonInfo
.head 9 -  Call SalMessageBox( "CRPE01007: Ошибка подсоединения к серверу.", "Ошибка", MB_OK )
.head 8 -  ! Set n = PEGetErrorCode(hPEJob)
.head 8 +  If n=1
.head 9 +  If PEOutputToWindow( hPEJob, tblCRWs.colDescription, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT,0, hWndNULL) = 0
.head 10 -  Call SalMessageBox( "CRPE01005: Внутренняя ошибка установки направления вывода отчёта (окно).", "Ошибка", MB_OK )
.head 8 +  Else If n=2
.head 9 +  If PEOutputToPrinter( hPEJob, 1) = 0
.head 10 -  Call SalMessageBox( "CRPE01014: Внутренняя ошибка установки направления вывода отчёта (принтер).", "Ошибка", MB_OK )
.head 9 +  Else
.head 10 +  If SalPrtSetup( strDevice, strDriver, strPort, TRUE ) = FALSE
.head 11 -  Call SalMessageBox( "CRPE01017: Внутренняя ошибка выбора принтера (Centura).", "Ошибка", MB_OK )
.head 10 +  Else
.head 11 +  If PESelectPrinter( hPEJob, strDriver, strDevice, strPort, 0 ) = FALSE
.head 12 -  Call SalMessageBox( "CRPE01016: Внутренняя ошибка выбора принтера (CRPE).", "Ошибка", MB_OK )
.head 8 +  Else If n=4
.head 9 -  Call SalMessageBox( "Вывод в файл не реализован - вывожу в окно", "Внимание", MB_OK )
.head 9 +  If PEOutputToWindow( hPEJob, tblCRWs.colDescription, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT,0, hWndNULL) = 0
.head 10 -  Call SalMessageBox( "CRPE01015: Внутренняя ошибка установки направления вывода отчёта (файл).", "Ошибка", MB_OK )
.head 8 +  Else
.head 9 -  Call SalMessageBox( "CRPE01018: Странное направление вывода отчёта!", "Ошибка", MB_OK )
.head 8 +  If PEStartPrintJob( hPEJob, TRUE ) = 0
.head 9 -  Set n = PEGetErrorCode(hPEJob)
.head 9 -  Call SalMessageBox( "CRPE01006: Ошибка запуска отчёта ("|| SalNumberToStrX(n,0) ||").", "Ошибка", MB_OK )
.head 6 +  ! Else
.head 7 -  Call SalMessageBox("Отменено.", "Информация", MB_OK)
.head 6 -  Set n = PELogoffServer( strDLL, 128*4+2, strServer, strDB, strUser, strPwd )
.head 6 -  Set n = PEGetWindowHandle( hPEJob )
.head 6 -  Set hwPE = SalNumberToWindowHandle( PEGetWindowHandle( hPEJob ) )
.head 6 -  Call PEZoomPreviewWindow( hPEJob, 2 )
.head 6 -  Call SalCenterWindow( hwPE )
.head 6 -  Call PEClosePrintJob( hPEJob )
.head 6 -  Set n = n
.head 6 -  Call SalWaitCursor( FALSE )
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.483"
.head 5 -  Top:    5.655"
.head 5 -  Width:  1.8"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog( hWndForm, -1 )
.head 3 +  Pushbutton: pbHelp
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbHelp
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   7.583"
.head 5 -  Top:    5.655"
.head 5 -  Width:  1.8"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Message Actions
.head 3 +  Child Table: tblCRWs
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: clsSortedTable
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.217"
.head 6 -  Top:    0.119"
.head 6 -  Width:  12.467"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 5.452"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  View: Class Default
.head 5 -  Allow Row Sizing? Class Default
.head 5 -  Lines Per Row: Class Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: Class Default
.head 5 -  Discardable? Class Default
.head 4 +  Contents
.head 5 +  Column: colID
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: N
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  0.567"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colName
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Файл
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  3.767"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colDescription
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Описание
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  7.25"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 4 -  Functions
.head 4 -  Window Variables
.head 4 +  Message Actions
.head 5 +  ! On SAM_Create
.head 6 -  Call SalSendClassMessage( SAM_Create, wParam, lParam )
.head 6 -  ! Call Init()
.head 5 +  On SAM_DoubleClick
.head 6 -  Call SalSendMsg( pbOK, SAM_Click, 0, 0 )
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Number: nReport
.head 2 +  Window Variables
.head 3 -  Window Handle: hwPE
.head 3 -  Number: n
.head 3 -  Number: nTable
.head 3 -  Number: nSections
.head 3 -  Number: nSection
.head 3 -  Number: nSectionCode
.head 3 -  Number: nSubReports
.head 3 -  Number: nSubReport
.head 3 -  Number: nSubReportCode
.head 3 -  String: strSubReportName
.head 3 -  Number: hSubReportJob
.head 3 -  Number: hPEJob
.head 3 -  String: strDLL
.head 3 -  String: strServer
.head 3 -  String: strDB
.head 3 -  String: strUser
.head 3 -  String: strPwd
.head 3 -  String: strCRW
.head 3 -  String: strDescriptiveName
.head 3 -  String: strLoc
.head 3 -  Number: nDBType
.head 3 -  Sql Handle: hsqlTmp
.head 3 -  ! printers
.head 3 -  String: strDevice
.head 3 -  String: strDriver
.head 3 -  String: strPort
.head 2 +  Message Actions
.head 3 +  On SAM_CreateComplete
.head 4 -  ! Call SetSql(hSql())
.head 4 -  Set strSQL = 'SELECT description, id, name
INTO :hWndForm.colDescription, :hWndForm.colID, :hWndForm.colName
FROM reports
WHERE (id <100) '
.head 4 +  If nReport != 0
.head 5 -  Set strSQL = strSQL || ' AND (id = ' || SalNumberToStrX(nReport,0) || ')'
.head 4 -  Set strSQL = T(strSQL)
.head 4 -  ! Call SalMessageBox( SalNumberToStrX( SalWindowHandleToNumber( hSql() ), 0 ), 'Debug hSql()!', 0)
.head 4 -  Call tblCRWs.SetSql( strSQL, hSql() )
.head 4 -  Call tblCRWs.BuildFieldList('description, id, name')
.head 4 -  ! Call SalMessageBox("!", "refresh", MB_Ok)
.head 4 -  Call tblCRWs.Refresh ( )
.head 4 -  ! Call SalMessageBox("!", "after refresh", MB_Ok)
.head 4 -  ! Call SalTblPopulate( tblCRWs, hSql(), strSQL, TBL_FillAll )
.head 4 -  ! Call SalMessageBox("!", "disconnect 1", MB_Ok)
.head 4 -  Call SqlDisconnect( hSql() )
.head 4 -  ! Call SalMessageBox("!", "disconnect 2", MB_Ok)
.head 4 +  If SalWindowHandleToNumber( hSqlAux() ) != 0
.head 5 -  Call SqlDisconnect( hSqlAux() )
.head 4 -  ! Call SalMessageBox("!", "opening engine", MB_Ok)
.head 4 -  Call SalWaitCursor( TRUE )
.head 4 -  Set n = PEOpenEngine(  )
.head 4 -  Call SalWaitCursor( FALSE )
.head 4 +  If n != 1
.head 5 -  Call SalMessageBox( "CRPE01001: Не могу стартовать библиотеку CRPE", "Ошибка", MB_Ok+MB_IconExclamation )
.head 4 -  ! Call SalMessageBox("!", "engine opened", MB_Ok)
.head 4 +  If (nReport != 0) AND (nReport != 100)
.head 5 -  Call SalSendMsg( pbOK, SAM_Click, 0, 0 )
.head 3 +  On SAM_Destroy
.head 4 -  Set n = 2
.head 4 +  Loop
.head 5 +  If n > 0
.head 6 -  ! Call SalMessageBox( "NO!", "Информация", MB_OK )
.head 6 -  Set n = n-1
.head 5 +  Else
.head 6 -  Break
.head 4 -  Call PECloseEngine(  )
.head 4 -  ! Call SalMessageBox("Re-Logon 1!", "", MB_OK)
.head 4 -  Call SqlConnect( hsqlTmp )
.head 4 -  ! Call SalMessageBox("Set SQL 1!", "", MB_OK)
.head 4 -  Call SetSql( hsqlTmp)
.head 4 -  ! Call SalMessageBox("Re-Logon 2!", "", MB_OK)
.head 4 -  Call SqlConnect( hsqlTmp )
.head 4 -  ! Call SalMessageBox("Set SQL 2!", "", MB_OK)
.head 4 -  Call SetSqlAux( hsqlTmp)
.head 4 -  Set n = n
.head 1 +  Dialog Box: dlg_SetCRWParam
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title:
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  7.85"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 3.095"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description:
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: Default
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  Multiline Field: mlHeader
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
.head 5 -  Vertical Scroll? Yes
.head 5 -  Window Location and Size
.head 6 -  Left:   0.083"
.head 6 -  Top:    0.488"
.head 6 -  Width:  7.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 1.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 4 -  Message Actions
.head 3 +  Multiline Field: mlValue
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  String Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Border? Yes
.head 5 -  Word Wrap? Yes
.head 5 -  Vertical Scroll? No
.head 5 -  Window Location and Size
.head 6 -  Left:   0.083"
.head 6 -  Top:    1.655"
.head 6 -  Width:  7.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.417"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 4 -  Message Actions
.head 3 -  Background Text: Установление параметров отчёта
.head 4 -  Resource Id: 48190
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.883"
.head 5 -  Top:    0.095"
.head 5 -  Width:  6.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Center
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Pushbutton: pbNext
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вперёд &>>
.head 4 -  Window Location and Size
.head 5 -  Left:   1.883"
.head 5 -  Top:    2.155"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set strUsefulFormulaText[nFormula] = mlValue
.head 6 -  Call ShowFormula( nFormula+1 )
.head 3 +  Pushbutton: pbPrev
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: &<< Назад
.head 4 -  Window Location and Size
.head 5 -  Left:   0.583"
.head 5 -  Top:    2.155"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set strUsefulFormulaText[nFormula] = mlValue
.head 6 -  Call ShowFormula( nFormula-1 )
.head 3 +  Pushbutton: pbOK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выполнить
.head 4 -  Window Location and Size
.head 5 -  Left:   3.183"
.head 5 -  Top:    2.155"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set strUsefulFormulaText[nFormula] = mlValue
.head 6 -  Set nUsefulFormulaIndex = 0
.head 6 -  Call SalArrayGetUpperBound( strUsefulFormulaHeader, 1, nFormula )
.head 6 +  Loop
.head 7 +  If nUsefulFormulaIndex = nFormula
.head 8 -  Break
.head 7 -  Set strFormulaName = strUsefulFormulaName[nUsefulFormulaIndex]
.head 7 -  Set strFormulaText = strUsefulFormulaText[nUsefulFormulaIndex]
.head 7 -  Set nSqlRes = PESetFormula( hPEJob, strFormulaName, strFormulaText )
.head 7 -  ! Call SalMessageBox( strFormulaText || " -- " ||SalNumberToStrX(nSqlRes, 0) || " -- " ||SalNumberToStrX(PEGetErrorCode( hPEJob ), 0), strFormulaName, MB_OK)
.head 7 -  Set nUsefulFormulaIndex = nUsefulFormulaIndex+1
.head 6 -  Call SalEndDialog( hWndForm, TRUE )
.head 3 +  Pushbutton: pbRestore
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbRefresh
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вернуть
.head 4 -  Window Location and Size
.head 5 -  Left:   4.483"
.head 5 -  Top:    2.155"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set strUsefulFormulaText[nFormula] = strUsefulFormulaTextOld[nFormula]
.head 6 -  Call ShowFormula(nFormula)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.783"
.head 5 -  Top:    2.155"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog( hWndForm, FALSE )
.head 2 +  Functions
.head 3 +  Function: ShowFormula
.head 4 -  Description: Показывает N-ную формулу
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Number: nF
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: n1
.head 4 +  Actions
.head 5 -  Set nFormula = nF
.head 5 -  Set mlHeader = strUsefulFormulaHeader[nF]
.head 5 -  Set mlValue = strUsefulFormulaText[nF]
.head 5 -  Call SalSetWindowText( hWndForm, strUsefulFormulaWindowHeader[nF] )
.head 5 +  If nF = 0
.head 6 -  Call SalDisableWindow( pbPrev )
.head 5 +  Else
.head 6 -  Call SalEnableWindow( pbPrev )
.head 5 -  Call SalArrayGetUpperBound( strUsefulFormulaHeader, 1, n1 )
.head 5 +  If nF = n1-1
.head 6 -  Call SalDisableWindow( pbNext )
.head 5 +  Else
.head 6 -  Call SalEnableWindow( pbNext )
.head 2 +  Window Parameters
.head 3 -  Number: hPEJob
.head 2 +  Window Variables
.head 3 -  Number: nUsefulFormulaIndex
.head 3 -  Number: nUsefulFormula [0:*]
.head 3 -  String: strUsefulFormulaName [0:*]
.head 3 -  String: strUsefulFormulaText [0:*]
.head 3 -  String: strUsefulFormulaTextOld [0:*]
.head 3 -  String: strUsefulFormulaHeader [0:*]
.head 3 -  String: strUsefulFormulaWindowHeader [0:*]
.head 3 -  Number: nFormulas
.head 3 -  Number: nFormula
.head 3 -  Number: nFormulaName
.head 3 -  Number: nFormulaNameL
.head 3 -  Number: nFormulaText
.head 3 -  Number: nFormulaTextL
.head 3 -  String: strFormulaName
.head 3 -  String: strFormulaText
.head 3 -  Number: nPosOfDelimiter
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalWaitCursor( FALSE )
.head 4 -  !
.head 4 -  ! Обзор всех Formulas
.head 4 -  !
.head 4 -  Set nFormulas = PEGetNFormulas( hPEJob )
.head 4 -  Set nFormula = 0
.head 4 -  Set nUsefulFormulaIndex = 0
.head 4 +  Loop
.head 5 +  If nFormula >= nFormulas
.head 6 -  Break
.head 5 -  Call PEGetNthFormula( hPEJob, nFormula, nFormulaName, nFormulaNameL, nFormulaText, nFormulaTextL )
.head 5 -  ! Получаем имя переменной
.head 5 +  If SalStrSetBufferLength( strFormulaName, nFormulaNameL ) = FALSE
.head 6 -  Call SalMessageBox( "CRPE01011: Внутренняя ошибка установления длины переменной  номер "|| SalNumberToStrX( nFormulaName, 0 )||" ("|| SalNumberToStrX( nFormulaNameL, 0 )||").", "Ошибка", MB_OK )
.head 6 -  Break
.head 5 +  If PEGetHandleString( nFormulaName, strFormulaName, nFormulaNameL ) = FALSE
.head 6 -  Call SalMessageBox( "CRPE01012: Внутренняя ошибка получения переменной номер "|| SalNumberToStrX( nFormulaName, 0 )||".", "Ошибка", MB_OK )
.head 6 -  Break
.head 5 -  ! Получаем текст переменной
.head 5 +  If SalStrSetBufferLength( strFormulaText, nFormulaTextL ) = FALSE
.head 6 -  Call SalMessageBox( "CRPE01013: Внутренняя ошибка установления длины переменной  номер "|| SalNumberToStrX( nFormulaText, 0 )||" ("|| SalNumberToStrX( nFormulaTextL, 0 )||").", "Ошибка", MB_OK )
.head 6 -  Break
.head 5 +  If PEGetHandleString( nFormulaText, strFormulaText, nFormulaTextL ) = FALSE
.head 6 -  Call SalMessageBox( "CRPE01014: Внутренняя ошибка получения переменной номер "|| SalNumberToStrX( nFormulaText, 0 )||".", "Ошибка", MB_OK )
.head 6 -  Break
.head 5 +  If SalStrScan( strFormulaText, "//--") = 0
.head 6 -  ! Resizing arrays
.head 6 -  Call SalArraySetUpperBound( nUsefulFormula, 1, nUsefulFormulaIndex+1 )
.head 6 -  Call SalArraySetUpperBound( strUsefulFormulaName, 1, nUsefulFormulaIndex+1 )
.head 6 -  Call SalArraySetUpperBound( strUsefulFormulaText, 1, nUsefulFormulaIndex+1 )
.head 6 -  Call SalArraySetUpperBound( strUsefulFormulaTextOld, 1, nUsefulFormulaIndex+1 )
.head 6 -  Call SalArraySetUpperBound( strUsefulFormulaHeader, 1, nUsefulFormulaIndex+1 )
.head 6 -  Call SalArraySetUpperBound( strUsefulFormulaWindowHeader, 1, nUsefulFormulaIndex+1 )
.head 6 -  ! Номер полезной формулы
.head 6 -  Set nUsefulFormula[nUsefulFormulaIndex] = nFormula
.head 6 -  ! Имя полезной формулы
.head 6 -  Set strUsefulFormulaName[nUsefulFormulaIndex] = strFormulaName
.head 6 -  ! Заголовок полезной формулы
.head 6 -  Set nPosOfDelimiter = SalStrScan(strFormulaText, "
//--")
.head 6 -  Set strUsefulFormulaWindowHeader[nUsefulFormulaIndex] = SalStrMidX( strFormulaText, 4, nPosOfDelimiter-4 )
.head 6 -  Set strFormulaText = SalStrRightX( strFormulaText, SalStrLength( strFormulaText )-nPosOfDelimiter-2 )
.head 6 -  !
.head 6 -  Set nPosOfDelimiter = SalStrScan(strFormulaText, "
")
.head 6 -  Set strUsefulFormulaHeader[nUsefulFormulaIndex] = SalStrMidX( strFormulaText, 4, nPosOfDelimiter-4 )
.head 6 -  Set strFormulaText = SalStrRightX( strFormulaText, SalStrLength( strFormulaText )-nPosOfDelimiter-2 )
.head 6 -  !
.head 6 -  Set strUsefulFormulaText[nUsefulFormulaIndex] = strFormulaText
.head 6 -  Set strUsefulFormulaTextOld[nUsefulFormulaIndex] = strFormulaText
.head 6 -  ! Call SalMessageBox(strUsefulFormulaName[nUsefulFormulaIndex]|| "
----------------------------------------
" || strUsefulFormulaText[nUsefulFormulaIndex], strUsefulFormulaHeader[nUsefulFormulaIndex], MB_OK)
.head 6 -  Set nUsefulFormulaIndex = nUsefulFormulaIndex+1
.head 5 -  Set nFormula = nFormula+1
.head 4 +  If nUsefulFormulaIndex = 0
.head 5 -  Call SalSendMsg( pbOK, SAM_Click, 0, 0 )
.head 4 +  Else
.head 5 -  Call ShowFormula(0)
.head 3 +  On SAM_Destroy
.head 4 -  Call SalWaitCursor( TRUE )
.head 1 +  Dialog Box: dlg_SetCRWDestination
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Направление вывода
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  3.517"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 2.583"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description:
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: Default
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 -  Group Box: Направление вывода
.head 4 -  Resource Id: 12921
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.583"
.head 5 -  Top:    0.238"
.head 5 -  Width:  2.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.0"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Radio Button: rbOutWindow
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Окно
.head 4 -  Window Location and Size
.head 5 -  Left:   0.683"
.head 5 -  Top:    0.405"
.head 5 -  Width:  1.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 -  Message Actions
.head 3 +  Radio Button: rbOutPrinter
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Принтер
.head 4 -  Window Location and Size
.head 5 -  Left:   0.683"
.head 5 -  Top:    0.655"
.head 5 -  Width:  1.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 -  Message Actions
.head 3 +  Radio Button: rbOutFile
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: В файл
.head 4 -  Window Location and Size
.head 5 -  Left:   0.683"
.head 5 -  Top:    0.905"
.head 5 -  Width:  1.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbOK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выполнить
.head 4 -  Window Location and Size
.head 5 -  Left:   0.383"
.head 5 -  Top:    1.488"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog( hWndForm, rbOutWindow+rbOutPrinter*2+rbOutFile*4 )
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.883"
.head 5 -  Top:    1.488"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog( hWndForm, FALSE )
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 -  Window Variables
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalWaitCursor( FALSE )
.head 3 +  On SAM_Destroy
.head 4 -  Call SalWaitCursor( TRUE )
.head 1 +  Dialog Box: dlg_DRW
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Файлы отчётов (DRW)
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  13.017"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 6.583"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Diamond Reports
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: Default
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  Pushbutton: pbOK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выполнить
.head 4 -  Window Location and Size
.head 5 -  Left:   3.283"
.head 5 -  Top:    5.655"
.head 5 -  Width:  1.8"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalWaitCursor( TRUE )
.head 6 -  !
.head 6 -  ! Объявляем все глобальные переменные
.head 6 -  Set _DefaultFormat = "->000"
.head 6 -  Set _PageLength=35
.head 6 -  Set _PageWidth=80
.head 6 -  Set _ExportTo = "TEXT"
.head 6 -  Set _bShowDebug = TRUE
.head 6 -  Set _strQuery = ""
.head 6 -  Set _strCountQuery = ""
.head 6 -  Set _strEmptyLine = "~"
.head 6 -  Set _strComment = ";"
.head 6 -  !
.head 6 -  ! Очищаем массивы
.head 6 -  Call SalArraySetUpperBound ( strHostVar, 1, 0 )
.head 6 -  Set strHostVar[0,0] = "0"
.head 6 -  Set strHostVar[0,4] = ""
.head 6 -  Call SalArraySetUpperBound ( strSections, 1, 0 )
.head 6 -  ! Закрываем файл
.head 6 -  Call VSFileReadLine( hfTpl, FALSE )
.head 6 -  Set bCanWork = TRUE
.head 6 -  Set nMaxDepth = 0
.head 6 -  Set strDRWOut = ""
.head 6 -  !
.head 6 -  ! Открываем файл шаблона
.head 6 -  !
.head 6 -  Set strDRW =  "..\\REPORTS\\" || tblDRWs.colName
.head 6 -  ! Set strDRW =  "D:\\REPORTS\\TEST1.TPL"
.head 6 +  If SalFileOpen( hfTpl, strDRW, OF_Read )
.head 7 -  ! Откываем окно дебаггинга
.head 7 +  If NOT VisWinIsWindow( hwProgress )
.head 8 -  Set hwProgress = SalCreateWindow( dlg_DRWProgress, hWndMDI )
.head 7 -  Call SalUpdateWindow( dlg_DRWProgress )
.head 7 -  Call SalCenterWindow( dlg_DRWProgress )
.head 7 -  Call SalYieldStartMessages( hwProgress )
.head 7 -  Call ShowErr( SalNumberToStrX( SalWindowHandleToNumber( dlg_DRWProgress.pbCancel ), 0 ), "ERROR_INITIALIZE")
.head 7 -  !
.head 7 -  Set bReportIsRunning = TRUE
.head 7 -  Set nTplRow = 1
.head 7 -  Set strCurrentSection = ''
.head 7 -  Set strInnerSection = ''
.head 7 -  Set bQueryIsInited = FALSE
.head 7 -  ! Цикл по всем строкам шаблона
.head 7 +  Loop
.head 8 -  Set strOneLine = VSFileReadLine( hfTpl, TRUE )
.head 8 +  If nTplRow = 1
.head 9 -  Set _strComment = SalStrLeftX( strOneLine, 1 )
.head 8 -  Call SetAction ("Читаем строку <" || SalNumberToStrX(nTplRow,0) || "> файла <" || strDRW || ">...")
.head 8 -  ! Пока не закончился файл
.head 8 +  If strOneLine != "<EOF>"
.head 9 -  ! Ищем начало комментария и, если есть, режем строку
.head 9 +  If _strComment != ""
.head 10 -  Set nOffset = SalStrScan(strOneLine, _strComment)
.head 10 +  If nOffset != -1
.head 11 -  Set strOneLine = SalStrLeftX(strOneLine, nOffset)
.head 9 -  Set strOneLineTrim = SalStrTrimX(strOneLine)
.head 9 +  If strOneLineTrim != ""
.head 10 -  ! Call SalMessageBox("<" || strOneLineTrim || ">", "", 0)
.head 10 -  ! Строки, содержащие только символ непустой строки, преобразуем в пробельную
.head 10 +  If strOneLineTrim = _strEmptyLine
.head 11 -  Set strOneLine = " "
.head 11 -  Set strOneLineTrim = " "
.head 10 -  Set strTemplate[nTplRow] = strOneLine
.head 10 -  ! Разбор строки
.head 10 +  If (SalStrLeftX(strOneLineTrim,1) = "<") AND (SalStrScan(strOneLineTrim, ">") != -1)
.head 11 -  ! Это начало или конец секции
.head 11 -  Set nOffset = SalStrScan(strOneLineTrim, ">")
.head 11 +  If (SalStrMidX(strOneLineTrim,1,1) = "/")
.head 12 -  ! Это конец секции
.head 12 -  Set strTrySection = SalStrUpperX( SalStrMidX(strOneLineTrim, 2, nOffset-2) )
.head 12 +  If strTrySection = strInnerSection
.head 13 -  Set strCurrentSection = SalStrRightX(strCurrentSection, SalStrLength(strCurrentSection) - SalStrLength(strInnerSection)-1)
.head 13 +  If strCurrentSection = ''
.head 14 -  Set strInnerSection = ''
.head 13 +  Else
.head 14 -  Set strInnerSection = SalStrLeftX(strCurrentSection, SalStrScan( strCurrentSection, '\\\\' ))
.head 12 +  Else
.head 13 -  Call ShowErr( "Файл " || strDRW || ": Строка " || SalNumberToStrX(nTplRow,0) || ":
Обнаружена команда закрытия секции <"|| strTrySection ||">.
Не было такой секции!", "DRW00002")
.head 11 +  Else
.head 12 -  ! Это начало секции
.head 12 -  Set strTrySection = SalStrUpperX( SalStrMidX(strOneLineTrim, 1, nOffset-1) )
.head 12 -  !
.head 12 -  ! Пытаемся найти имя управляющей переменной
.head 12 -  !
.head 12 -  Set nOffset = SalStrScan(strOneLineTrim, "@")
.head 12 -  Set strTryVar = ""
.head 12 +  If nOffset != -1
.head 13 -  Call ParseExpression( strOneLineTrim, nOffset, strTryVar, strTryDefault )
.head 12 -  Set bSectionIsCorrect = TRUE
.head 12 +  If strInnerSection = ""
.head 13 +  If strTrySection = "REPORT"
.head 14 -  !
.head 13 +  Else
.head 14 -  Set bSectionIsCorrect = FALSE
.head 14 -  Call ShowErr( "Файл " || strDRW || ": Строка " || SalNumberToStrX(nTplRow,0) || ":
Cекция <" || strCurrentSection || "> не должна содержать секцию  <" || strTrySection ||"> !", "DRW00003")
.head 12 +  Else If strInnerSection = "REPORT"
.head 13 +  If strTrySection = "GLOBAL"
.head 14 -  !
.head 13 +  Else If (SalStrScan(strTrySection, "PAGEHEAD") = 0)
.head 14 -  Set nRet = InsSection( '#-' || SalNumberToStrX(SalStrToNumber(SalStrMidX(strTrySection, 8, 1) ), 0)  || '-H')
.head 14 +  If nRet != 0
.head 15 -  Set nParsingSection = nRet
.head 14 +  Else
.head 15 -  Set bSectionIsCorrect = FALSE
.head 15 -  Call ShowErr( "Файл " || strDRW || ": Строка " || SalNumberToStrX(nTplRow,0) || ":
Секция  <" || strTrySection || "> повторяется!", "DRW00000")
.head 13 +  Else If (SalStrScan(strTrySection, "PAGEFOOT") = 0)
.head 14 -  Set nRet = InsSection( '#-' || SalNumberToStrX(SalStrToNumber(SalStrMidX(strTrySection, 8, 1) ), 0)  || '-F')
.head 14 +  If nRet != 0
.head 15 -  Set nParsingSection = nRet
.head 14 +  Else
.head 15 -  Set bSectionIsCorrect = FALSE
.head 15 -  Call ShowErr( "Файл " || strDRW || ": Строка " || SalNumberToStrX(nTplRow,0) || ":
Секция  <" || strTrySection || "> повторяется!", "DRW00000")
.head 13 +  Else If (SalStrScan(strTrySection, "HEAD") = 0)
.head 14 -  Set nSectionDepth = SalStrToNumber(SalStrMidX(strTrySection, 4, 1) )
.head 14 +  If nMaxDepth < nSectionDepth
.head 15 -  Set nMaxDepth = nSectionDepth
.head 14 -  Set nRet = InsSection( SalNumberToStrX(nSectionDepth, 0) || '-' || SalNumberToStrX(SalStrToNumber(SalStrMidX(strTrySection, 6, 1) ), 0)  || '-H')
.head 14 +  If nRet != 0
.head 15 -  Set nParsingSection = nRet
.head 14 +  Else
.head 15 -  Set bSectionIsCorrect = FALSE
.head 15 -  Call ShowErr( "Файл " || strDRW || ": Строка " || SalNumberToStrX(nTplRow,0) || ":
Секция  <" || strTrySection || "> повторяется!", "DRW00000")
.head 14 +  If (nSectionDepth != 0) AND (strTryVar = "")
.head 15 -  Set bSectionIsCorrect = FALSE
.head 15 -  Call ShowErr( "Файл " || strDRW || ": Строка " || SalNumberToStrX(nTplRow,0) || ":
Секция  <" || strTrySection || "> должна содержать в заголовке имя переменной, по которой изменяется группа!", "DRW00000")
.head 14 +  Else
.head 15 -  Set strSections[nParsingSection, 2] = strTryVar
.head 15 -  Set strSections[nParsingSection, 3] = ""
.head 13 +  Else If (SalStrScan(strTrySection, "FOOT") = 0)
.head 14 -  Set nSectionDepth = SalStrToNumber(SalStrMidX(strTrySection, 4, 1) )
.head 14 +  If nMaxDepth < nSectionDepth
.head 15 -  Set nMaxDepth = nSectionDepth
.head 14 -  Set nRet = InsSection( SalNumberToStrX(nSectionDepth, 0) || '-' || SalNumberToStrX(SalStrToNumber(SalStrMidX(strTrySection, 6, 1) ), 0)  || '-F')
.head 14 +  If nRet != 0
.head 15 -  Set nParsingSection = nRet
.head 14 +  Else
.head 15 -  Set bSectionIsCorrect = FALSE
.head 15 -  Call ShowErr( "Файл " || strDRW || ": Строка " || SalNumberToStrX(nTplRow,0) || ":
Секция  <" || strTrySection || "> повторяется!", "DRW00000")
.head 13 +  Else If (SalStrScan(strTrySection, "DETAILS") = 0)
.head 14 -  Set nRet = InsSection( 'D-' || SalNumberToStrX(SalStrToNumber(SalStrMidX(strTrySection, 7, 1) ), 0))
.head 14 +  If nRet != 0
.head 15 -  Set nParsingSection = nRet
.head 14 +  Else
.head 15 -  Set bSectionIsCorrect = FALSE
.head 15 -  Call ShowErr( "Файл " || strDRW || ": Строка " || SalNumberToStrX(nTplRow,0) || ":
Секция  <" || strTrySection || "> повторяется!", "DRW00000")
.head 13 +  Else
.head 14 -  Set bSectionIsCorrect = FALSE
.head 14 -  Call ShowErr( "Файл " || strDRW || ": Строка " || SalNumberToStrX(nTplRow,0) || ":
Cекция <" || strCurrentSection || "> не должна содержать секцию <" || strTrySection ||"> !", "DRW00003")
.head 12 +  Else If strInnerSection = "GLOBAL"
.head 13 +  If strTrySection = "DEFAULTS"
.head 14 -  !
.head 13 +  Else If strTrySection = "VAR"
.head 14 -  !
.head 13 +  Else If strTrySection = "QUERY"
.head 14 -  !
.head 13 +  Else
.head 14 -  Set bSectionIsCorrect = FALSE
.head 14 -  Call ShowErr( "Файл " || strDRW || ": Строка " || SalNumberToStrX(nTplRow,0) || ":
Cекция <" || strCurrentSection || "> не должна содержать секцию <" || strTrySection ||"> !", "DRW00003")
.head 12 +  Else
.head 13 -  Set bSectionIsCorrect = FALSE
.head 13 -  Call ShowErr( "Файл " || strDRW || ": Строка " || SalNumberToStrX(nTplRow,0) || ":
Cекция <" || strCurrentSection || "> не должна содержать секцию <" || strTrySection ||"> !", "DRW00003")
.head 12 +  If bSectionIsCorrect
.head 13 -  Set strInnerSection = strTrySection
.head 13 -  Set strCurrentSection = strTrySection || "\\" || strCurrentSection
.head 10 +  Else
.head 11 -  ! Это НЕ начало и НЕ конец секции
.head 11 +  If (SalStrScan(strTrySection, "PAGEHEAD") = 0)
 OR (SalStrScan(strTrySection, "PAGEFOOT") = 0)
 OR (SalStrScan(strTrySection, "HEAD") = 0)
 OR (SalStrScan(strTrySection, "FOOT") = 0)
 OR (SalStrScan(strTrySection, "DETAILS") = 0)
.head 12 +  If SalStrLength(strSections[nParsingSection, 1]) != 0
.head 13 -  Set strSections[nParsingSection, 1] = strSections[nParsingSection, 1] || "
"
.head 12 -  Set strSections[nParsingSection, 1] = strSections[nParsingSection, 1] || strOneLine
.head 11 +  Else
.head 12 -  !
.head 12 -  Set nOffset = SalStrScan(strOneLineTrim, "=")
.head 12 -  Set strTryVar = SalStrUpperX( SalStrTrimX(SalStrLeftX(strOneLineTrim, nOffset)) )
.head 12 -  Set strTryValue = SalStrRightX(strOneLineTrim, SalStrLength(strOneLineTrim)-nOffset-1)
.head 12 -  Set strTryValueTrim = SalStrTrimX(strTryValue)
.head 12 -  Set nTryValue =  SalStrToNumber(strTryValue)
.head 12 -  !
.head 12 +  If (strInnerSection = "") OR (strInnerSection = "REPORT") OR (strInnerSection = "GLOBAL")
.head 13 -  Set bSectionIsCorrect = FALSE
.head 13 -  Call ShowErr("Файл " || strDRW || ": Строка " || SalNumberToStrX(nTplRow,0) || ":
Cекция <" || strCurrentSection ||"> не может иметь переменных!", "DRW00004")
.head 12 +  Else If strInnerSection = "DEFAULTS"
.head 13 +  If strTryVar = "DEFAULTFORMAT"
.head 14 -  Call ParseFormat( strTryValueTrim, 0, _DefaultFormat, 0)
.head 13 +  Else If strTryVar = "PAGELENGTH"
.head 14 -  Set _PageLength = nTryValue
.head 13 +  Else If strTryVar = "PAGEWIDTH"
.head 14 -  Set _PageWidth = nTryValue
.head 13 +  Else If strTryVar = "EXPORTTO"
.head 14 -  Set nRet = SalStrTokenize( strTryValueTrim, "", ",", strFileName )
.head 14 -  Set _ExportTo = strFileName[0]
.head 14 -  Set strDRWOut = strFileName[1]
.head 14 +  If (_ExportTo = "DBF") AND (nRet >= 3)
.head 15 -  Call ShowErr("Не реализовано!", "DRW90000")
.head 13 +  Else If strTryVar = "SHOWDEBUG"
.head 14 -  Set _bShowDebug = VSStrToBool(strTryValueTrim)
.head 13 +  Else If strTryVar = "INITGLOBALS"
.head 14 -  Call InitGlobals()
.head 13 +  Else If strTryVar = "EMPTYLINE"
.head 14 -  Set _strEmptyLine = strTryValueTrim
.head 13 +  Else
.head 14 -  Set bSectionIsCorrect = FALSE
.head 14 -  Call ShowErr("Файл " || strDRW || ": Строка " || SalNumberToStrX(nTplRow,0) || ":
Некорректная переменная: \"" || strTryVar ||"\" для секции <" || strCurrentSection || "> !", "DRW00005")
.head 12 +  Else If strInnerSection = "QUERY"
.head 13 -  Set _strQuery = _strQuery || "
" || strOneLine
.head 12 +  Else If strInnerSection = "VAR"
.head 13 +  If Not bQueryIsInited
.head 14 +  If _strQuery = ""
.head 15 -  Call ShowErr("Секция <VAR> должна следовать ПОСЛЕ секции <QUERY>!", "DRW00006")
.head 14 +  Else
.head 15 -  Call InitQuery()
.head 13 -  Set nHostVarIndex = InsHostVar( VSStrTail(strTryVar, 1) )
.head 13 +  If nHostVarIndex != 0
.head 14 -  ! OK to set subst & format
.head 14 -  Set nMaskLen = 0
.head 14 +  If SalStrLeftX(strTryValueTrim, 1) = "@"			! Значит, есть expression/formula
.head 15 -  Set nMaskLen = ParseExpression( strTryValueTrim, 0, strHV, strTryDefault )
.head 15 -  Set strHV = SalStrUpperX( strHV )
.head 15 -  Set strHostVar[nHostVarIndex,2] = strHV
.head 15 -  Set strHostVar[nHostVarIndex,1] = strTryDefault
.head 14 -  ! Call ShowErr(
"var:	" || strTryVar || "
expr:	" || strHV || "
def:	" || strTryDefault || "
format:	" || strHVFormat, "!")
.head 14 -  Set nMaskLen = ParseFormat( strTryValueTrim, nMaskLen, strHVFormat, 0 )
.head 14 -  ! Call ShowErr("BUG - incorrect nMaskLen", "")
.head 14 +  If nMaskLen != 0
.head 15 -  Set strHostVar[nHostVarIndex,3] = strHVFormat
.head 12 +  Else
.head 13 -  Call ShowErr("Текст внутри секции <" || strInnerSection || "> не допускается!", "DRW00000")
.head 10 -  !
.head 9 -  Set nTplRow = nTplRow+1
.head 8 +  Else
.head 9 -  Break
.head 7 -  ! Закрываем файл шаблона
.head 7 -  Call SalFileClose( hfTpl )
.head 7 -  ! Дополнительная обработка Query
.head 7 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 7 -  ! Дополнительная обработка текстов всех секций
.head 7 -  Set nSectionIndex = 1
.head 7 -  Set nSubstedVar = 1
.head 7 -  ! Цикл по всем секциям
.head 7 +  Loop
.head 8 +  If nSectionIndex > SalStrToNumber(strSections[0,0])
.head 9 -  Break
.head 8 -  ! strLin = Временное хранилище текста секции
.head 8 -  Set strLin = strSections[nSectionIndex, 1]
.head 8 -  Call SetAction ("Дополнительная обработка текстов секции <" || strLin || ">...")
.head 8 -  ! Преобразуем все подстроки "//CRLF" на пробел
.head 8 +  Loop replacer
.head 9 -  Set nOffset = SalStrScan(strLin, "//
")
.head 9 +  If nOffset = -1
.head 10 -  Break replacer
.head 9 -  Set strLin = SalStrReplaceX( strLin, nOffset, 4, " " )
.head 8 -  ! !!!         предварительный разбор текстов секций на предмет содержания хост-переменных вместе со своими форматами.
.head 8 -  ! !!!          В текстах секций заменяются на простые строки типа @SUBSTVAR001
.head 8 -  Set nOffset =0
.head 8 +  Loop replacer2
.head 9 +  If nOffset > SalStrLength(strLin)
.head 10 -  Break replacer2
.head 9 +  If SalStrMidX(strLin, nOffset, 1) = "@"
.head 10 -  Set nMaskLen = ParseExpression( strLin, nOffset, strHV, strTryDefault )
.head 10 -  Set strHV = SalStrUpperX( strHV )
.head 10 -  Set strHostVar[nHostVarIndex,1] = strTryDefault
.head 10 -  Set nNewMaskLen = ParseFormat( strLin, nOffset+nMaskLen, strHVFormat, nMaskLen )
.head 10 -  ! Указан ли формат (или брать унаследованный)
.head 10 +  If nNewMaskLen = nMaskLen
.head 11 -  Set strHVFormat = GetVarValue( strHV, 3 )
.head 11 -  Set nNewMaskLen = SalStrToNumber( SalStrMidX(strHVFormat, 2, 3) )
.head 11 +  If nNewMaskLen = 0
.head 12 -  Set nNewMaskLen = nMaskLen
.head 10 -  Set nMaskLen = nNewMaskLen
.head 10 -  Set nSubstedVarIndex = InsHostVar( "SUBSTVAR" || SalStrRightX("000" || SalNumberToStrX( nSubstedVar,0), 3 ))
.head 10 -  Set strHostVar[nSubstedVarIndex, 2] = strHV
.head 10 -  Set strHostVar[nSubstedVarIndex, 3] = strHVFormat
.head 10 -  Call SalStrReplace( strLin, nOffset, nMaskLen, "@SUBSTVAR" || SalStrRightX("000" || SalNumberToStrX( nSubstedVar,0), 3), strLin )
.head 10 -  Set nSubstedVar = nSubstedVar + 1
.head 10 -  Set nOffset = nOffset + 11
.head 9 -  Set nOffset = nOffset + 1
.head 8 -  Set strSections[nSectionIndex, 1] = strLin
.head 8 -  Set nSectionIndex = nSectionIndex+1
.head 7 -  ! Заполняем параметры
.head 7 -  Call SalModalDialog( dlg_SetDRWParam, hWndForm )
.head 7 -  ! Разбираемся с именем выходного файла
.head 7 +  If strDRWOut = ""
.head 8 -  Set nRet = SalStrTokenize( strDRW, "", "\\", strFileName )
.head 8 -  Set nOffset = VSStrScan( strFileName[nRet-1], ".")
.head 8 +  If nRet != 0
.head 9 -  Set strDRWOut = GetPrnDir(  ) || SalStrLeftX( strFileName[nRet-1], nOffset )
.head 8 +  If _ExportTo = "TEXT"
.head 9 -  Set strDRWOut = strDRWOut || ".TXT"
.head 8 +  Else If _ExportTo = "DBF"
.head 9 -  Set strDRWOut = strDRWOut || ".DBF"
.head 8 +  Else
.head 9 -  Set strDRWOut = strDRWOut || ".OUT"
.head 7 -  ! Открываем файл выхода
.head 7 +  If _ExportTo = "TEXT"
.head 8 -  Call SalFileOpen( hfOut, strDRWOut, OF_Create | OF_ReadWrite )
.head 7 -  Else If _ExportTo = "DBF"
.head 7 -  ! Правим окно дебаггинга
.head 7 +  If NOT _bShowDebug
.head 8 -  Call SalGetWindowSize( hwProgress, n1, n2 )
.head 8 -  Call SalSetWindowSize( hwProgress, n1, 1.75 )
.head 7 -  ! Обработка запроса COUNT(*)
.head 7 -  Call SetAction ("Выполняю вспомогательный запрос COUNT(*)...")
.head 7 +  If SqlPrepareAndExecute( hSql(), _strCountQuery )
.head 8 -  Call SqlFetchNext( hSql(), nRet )
.head 8 -  Set dlg_DRWProgress.dfTotalRecords = _TotalRecords
.head 8 -  ! Обработка собственно запроса
.head 8 -  Call SetAction ("Передаю основной запрос на обработку серверу...")
.head 8 +  If SqlPrepareAndExecute( hSql(), _strQuery )
.head 9 -  Set nCurLineOnPage = 1
.head 9 -  Set _CurrentRecord = 1
.head 9 -  Set _PageNumber = 1
.head 9 -  Set lstrReport = ""
.head 9 -  ! Главный цикл движения по resultset
.head 9 -  Call SqlFetchNext( hSql(), nRet )
.head 9 +  If nRet != FETCH_EOF
.head 10 -  Call ShowSections( 0, lstrReport )
.head 10 +  If bCanWork
.head 11 -  Call SetAction( "Отчёт выполнен." )
.head 11 -  Set dlg_DRWProgress.mlProgress = lstrReport
.head 11 -  ! Call SalMessageBox(lstrReport, "!", MB_Ok)
.head 9 +  Else
.head 10 -  Call SetAction( "Отчёт выполнен - запрос не вернул никаких данных." )
.head 8 +  Else
.head 9 -  Call ShowErr("Запрос некорректен.", "DRW00007")
.head 9 -  Call CloseAction( )
.head 8 -  !
.head 8 -  ! Call SalDestroyWindow( hwProgress )
.head 8 +  If bCanWork
.head 9 -  Call SalSetWindowText( dlg_DRWProgress, "Отчёт выполнен." )
.head 9 -  Call SalSetWindowText( dlg_DRWProgress.pbCancel, "Закрыть" )
.head 8 -  Call SalYieldStopMessages(  )
.head 8 -  Call ShowErr( SalNumberToStrX( SalWindowHandleToNumber( hWndNULL ), 0 ), "ERROR_INITIALIZE")
.head 7 +  Else
.head 8 -  Call ShowErr("Вспомогательный запрос некорректен.", "DRW00000")
.head 8 -  Call CloseAction( )
.head 7 -  Set bReportIsRunning = FALSE
.head 7 +  If _ExportTo = "TEXT"
.head 8 -  Call SalFileClose( hfOut )
.head 7 -  Else If _ExportTo = "DBF"
.head 6 +  Else
.head 7 -  Call ShowErr( "Не могу открыть файл: <" || strDRW || ">", "DRW00001")
.head 6 -  Call SalWaitCursor( FALSE )
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.483"
.head 5 -  Top:    5.655"
.head 5 -  Width:  1.8"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog( hWndForm, -1 )
.head 3 +  Pushbutton: pbHelp
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbHelp
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   7.583"
.head 5 -  Top:    5.655"
.head 5 -  Width:  1.8"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Message Actions
.head 3 +  Child Table: tblDRWs
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: clsSortedTable
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.217"
.head 6 -  Top:    0.119"
.head 6 -  Width:  12.467"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 5.452"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  View: Class Default
.head 5 -  Allow Row Sizing? Class Default
.head 5 -  Lines Per Row: Class Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: Class Default
.head 5 -  Discardable? Class Default
.head 4 +  Contents
.head 5 +  Column: colID
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: N
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  0.567"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colName
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Файл
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  3.767"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colDescription
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Описание
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  7.25"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 4 -  Functions
.head 4 -  Window Variables
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendClassMessage( SAM_Create, wParam, lParam )
.head 6 -  ! Call Init()
.head 5 +  On SAM_DoubleClick
.head 6 -  Call SalSendMsg( pbOK, SAM_Click, 0, 0 )
.head 2 +  Functions
.head 3 +  Function: SetAction
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  String: str1
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If bCanWork
.head 6 -  Set dlg_DRWProgress.dfAction = str1
.head 6 -  Call SalUpdateWindow( dlg_DRWProgress )
.head 3 +  Function: CloseAction
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SalDestroyWindow( dlg_DRWProgress )
.head 3 +  Function: VSFileReadLine
.head 4 -  Description: Читает строку из файла
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  File Handle: hf1
.head 5 -  Boolean: bActualRead
.head 4 +  Static Variables
.head 5 -  String: strBuffer
.head 4 +  Local variables
.head 5 -  String: str1
.head 5 -  Number: nBytesToRead
.head 5 -  Number: nOffset
.head 5 -  Boolean: bCoudRead
.head 4 +  Actions
.head 5 +  If bActualRead
.head 6 -  Set str1 = ""
.head 6 -  Set nBytesToRead = 100
.head 6 +  Loop
.head 7 -  Set strBuffer = strBuffer || str1
.head 7 -  Set nOffset = SalStrScan( strBuffer, "
" )
.head 7 +  If nOffset = -1
.head 8 +  If SalFileRead( hf1, str1, nBytesToRead ) = 0
.head 9 -  Set nOffset = SalStrLength( strBuffer )
.head 9 -  Set bCoudRead = FALSE
.head 9 -  Break
.head 8 +  Else
.head 9 -  Set bCoudRead = TRUE
.head 7 +  Else
.head 8 -  Break
.head 6 -  Set str1 = SalStrLeftX( strBuffer, nOffset )
.head 6 -  Set strBuffer = SalStrRightX( strBuffer,  SalStrLength( strBuffer )-nOffset-2 )
.head 6 +  If (str1 = "") AND (strBuffer = "") AND NOT bCoudRead
.head 7 -  Return "<EOF>"
.head 6 +  Else
.head 7 -  Return str1
.head 5 +  Else
.head 6 -  Set strBuffer = ""
.head 6 -  Return ""
.head 3 +  Function: VSGetOneWord
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  String: strOriginal
.head 5 -  Receive Number: nStartingOffset
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nLength
.head 5 -  Number: i
.head 4 +  Actions
.head 5 -  Set nLength = SalStrLength(strOriginal)
.head 5 +  While (nStartingOffset <= nLength) AND (SalStrScan( " ,
", SalStrMidX( strOriginal, nStartingOffset, 1 )) != -1)
.head 6 -  Set nStartingOffset = nStartingOffset+1
.head 5 -  Set i = nStartingOffset
.head 5 +  While (nStartingOffset <= nLength) AND (SalStrScan( " ,
", SalStrMidX( strOriginal, nStartingOffset, 1 )) = -1)
.head 6 -  Set nStartingOffset = nStartingOffset+1
.head 5 -  Set nStartingOffset = nStartingOffset+1
.head 5 -  Return SalStrMidX(strOriginal, i, nStartingOffset - i-1)
.head 3 +  Function: InsHostVar
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Number:
.head 4 +  Parameters
.head 5 -  String: strName
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nRow
.head 4 +  Actions
.head 5 -  Set nRow = 1
.head 5 +  While (nRow <= SalStrToNumber(strHostVar[0,0])) AND (strHostVar[nRow,0] != strName)
.head 6 -  Set nRow = nRow+1
.head 5 +  If nRow > SalStrToNumber(strHostVar[0,0])
.head 6 -  Set strHostVar[0,0] = SalNumberToStrX(nRow, 0)
.head 6 -  Set strHostVar[nRow,0] = strName
.head 6 -  Set strHostVar[nRow,3] = _DefaultFormat
.head 5 -  Return nRow
.head 3 +  Function: InsSection
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Number:
.head 4 +  Parameters
.head 5 -  String: strName
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nRow
.head 4 +  Actions
.head 5 -  Set nRow = 1
.head 5 +  While (nRow <= SalStrToNumber(strSections[0,0])) AND (strSections[nRow,0] != strName)
.head 6 -  Set nRow = nRow+1
.head 5 +  If nRow > SalStrToNumber(strSections[0,0])
.head 6 -  Set strSections[0,0] = SalNumberToStrX(nRow, 0)
.head 6 -  Set strSections[nRow,0] = strName
.head 6 -  Return nRow
.head 5 +  Else
.head 6 -  Return 0
.head 3 +  Function: InitQuery
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nOffsetFROM
.head 4 +  Actions
.head 5 -  Set nOffsetFROM = SalStrScan( _strQuery, "FROM" )
.head 5 +  If nOffsetFROM != -1
.head 6 -  ! Разбор Query с целью найти host-vars
.head 6 -  Set nOffset = SalStrScan( _strQuery, "INTO" )
.head 6 +  If nOffset != -1
.head 7 -  Set _strCountQuery = "SELECT COUNT(*) " || SalStrMidX(_strQuery, nOffsetFROM, nOffset - nOffsetFROM) || " INTO :_TotalRecords "
.head 7 -  Set nOffset = nOffset + 4
.head 7 +  Loop
.head 8 -  Set nOldOffset = nOffset
.head 8 -  Set strOneWordTrim = SalStrUpperX( SalStrTrimX(VSGetOneWord( _strQuery, nOffset )) )
.head 8 +  If (strOneWordTrim = "WHERE") OR (strOneWordTrim = "")
.head 9 -  Set nOffset = SalStrScan(_strQuery, "ORDER BY")
.head 9 +  If nOffset = -1
.head 10 -  Set nOffset = SalStrLength(_strQuery)
.head 9 -  Set _strCountQuery = _strCountQuery || SalStrMidX(_strQuery, nOldOffset, nOffset - nOldOffset)
.head 9 -  Break
.head 8 +  Else
.head 9 +  If SalStrLeftX(strOneWordTrim,1) != "@"
.head 10 -  Call ShowErr("Host-переменная в секции <INTO> некорректна - должна начинаться на \"@\"", "DRW00008")
.head 9 +  Else
.head 10 -  Set nHostVarIndex = InsHostVar( VSStrTail(strOneWordTrim, 1 ))
.head 10 +  If nHostVarIndex = 0
.head 11 -  Call ShowErr('Дублируется Host-переменная в секции <INTO>', "DRW00008")
.head 10 +  Else
.head 11 -  Set strHostVarVerbose = " :strHostVar["|| SalNumberToStrX(nHostVarIndex,0)||",1]"
.head 11 -  Set _strQuery = SalStrReplaceX( _strQuery, nOldOffset+1, nOffset - nOldOffset-2, strHostVarVerbose )
.head 11 -  Set nOffset = nOldOffset + SalStrLength(strHostVarVerbose) +1
.head 7 -  Set bQueryIsInited = TRUE
.head 7 -  Return TRUE
.head 6 +  Else
.head 7 -  Call SalMessageBox("Нет \"INTO\" в запросе - не могу обработать запрос", "DRW00009", MB_Ok)
.head 7 -  Return FALSE
.head 5 +  Else
.head 6 -  Call SalMessageBox("Нет \"FROM\" в запросе - не могу обработать запрос", "DRW00000", MB_Ok)
.head 6 -  Return FALSE
.head 3 +  Function: InitGlobals
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: str1
.head 4 +  Actions
.head 5 -  ! Обработка запроса глобальных переменных
.head 5 -  Call SetAction ("Выполняю вспомогательный запрос...")
.head 5 -  Set strGlobalsQuery = "SELECT par, val, comm FROM params INTO :strTryVar, :strTryValueTrim, :strTryValue"
.head 5 +  If SqlPrepareAndExecute( hSql(), strGlobalsQuery )
.head 6 +  Loop
.head 7 +  If NOT SqlFetchNext( hSql(), nRet )
.head 8 -  Break
.head 7 -  Set strTryVar = "_" || SalStrUpperX(strTryVar)
.head 7 -  Set nHostVarIndex = InsHostVar( strTryVar )
.head 7 -  Set strHostVar[nHostVarIndex, 1] = strTryValueTrim
.head 5 +  Else
.head 6 -  Call ShowErr("Вспомогательный запрос некорректен.", "DRW00000")
.head 5 -  Call InsHostVar( "PAGENUMBER" )
.head 5 -  Call InsHostVar( "TOTALPAGES" )
.head 5 -  Set nHostVarIndex = InsHostVar( "TODAY" )
.head 5 -  Call SalDateToStr( SalDateCurrent(  ), str1 )
.head 5 -  Set strHostVar[nHostVarIndex, 1] = str1
.head 3 +  Function: GetNextSection
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  ! Строка в виде '1-_-H'
.head 5 -  String: strMask
.head 5 -  Receive Number: nIndex
.head 4 +  Static Variables
.head 5 -  Number: nStartingIndex
.head 5 -  String: strOldMask
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If strMask != strOldMask
.head 6 -  Set nStartingIndex = 0
.head 6 -  Set strOldMask = strMask
.head 5 -  Set nStartingIndex = nStartingIndex+1
.head 5 +  Loop
.head 6 +  If nStartingIndex > SalStrToNumber(strSections[0,0])
.head 7 -  Return ''
.head 6 -  !
.head 6 +  If SalStrScan(strSections[nStartingIndex,0], strMask) != -1
.head 7 -  Set nIndex = nStartingIndex
.head 7 -  Return strSections[nStartingIndex,1]
.head 6 -  Set nStartingIndex = nStartingIndex+1
.head 3 +  Function: InsertDataIntoSection
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  String: strOriginal
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: str0
.head 5 -  String: str1
.head 5 -  String: strR
.head 5 -  Number: nLen
.head 5 -  String: strVarName
.head 5 -  ! strSubst[0,0] - количество заменяемых переменных
.head 5 -  ! strSubst[*,0] - хост-переменная
.head 5 -  ! strSubst[*,1] - с какого символа заменять
.head 5 -  String: strSubst[0:*,0:2]
.head 5 -  Number: nIndex
.head 5 -  Boolean: bAnythingToDo
.head 5 -  String: strTPL
.head 5 -  ! если nLoop = 2 то надо запустить очищалку шаблона - только рамочки и имена хост-переменных
.head 5 -  Number: nLoop
.head 4 +  Actions
.head 5 -  Set str0 = strOriginal
.head 5 -  Set str1 = ''
.head 5 -  Set nIndex = 0
.head 5 -  ! Call SalMessageBox(str0, "Оригинал", MB_Ok)
.head 5 -  !
.head 5 +  Loop parser
.head 6 -  Set nOffset = SalStrScan( str0, "@" )
.head 6 +  If nOffset = -1
.head 7 -  Set str1 = str1 || str0
.head 7 -  Break parser
.head 6 +  Else
.head 7 -  Set nLen = 1
.head 7 -  Set str1 = str1 || SalStrLeftX(str0, nOffset)
.head 7 -  Set str0 = VSStrTail(str0, nOffset)
.head 7 -  Set nOffset = ParseExpression( str0, 0, strVarName, strTryDefault )
.head 7 -  ! Set strVarName = SalStrLeftX(str0, nOffset)
.head 7 -  Set str0 = SalStrRightX(str0, SalStrLength(str0)-nOffset)
.head 7 -  Set strVarName = SalStrUpperX( strVarName )
.head 7 +  If strVarName = "PAGENUMBER"
.head 8 -  Set strR = FormatN(_PageNumber, GetVarValue(strVarName,3))
.head 7 +  Else If strVarName = "TOTALPAGES"
.head 8 -  Set strR = FormatS("0", GetVarValue(strVarName,3))
.head 7 +  Else If strVarName = "CURRENTRECORD"
.head 8 -  Set strR = FormatN(_CurrentRecord, GetVarValue(strVarName,3))
.head 7 +  Else
.head 8 -  Set strR = ApplyFormat(GetVarValue(strVarName,1), GetVarValue(strVarName,3))
.head 7 -  Set nIndex = nIndex+1
.head 7 -  Set strSubst[nIndex, 0] = strR
.head 7 -  Set strSubst[nIndex, 1] = SalNumberToStrX(SalStrLength(str1),0)
.head 7 -  Set strSubst[nIndex, 2] = SalStrMidX(GetVarValue(strVarName,3), 2,3)
.head 7 -  Set str1 = str1 || " "
.head 5 -  Set strSubst[0,0] = SalNumberToStrX(nIndex,0)
.head 5 -  Set strTPL = str1
.head 5 -  Set bAnythingToDo = TRUE
.head 5 -  Set strR = ""
.head 5 -  Set nLoop = 0
.head 5 +  While bAnythingToDo
.head 6 -  Set nLoop = nLoop+1
.head 6 +  If nLoop = 2
.head 7 -  Set strTPL = StrClear( strTPL )
.head 6 -  Set nIndex = SalStrToNumber(strSubst[0,0])
.head 6 -  Set str1 = strTPL
.head 6 -  Set bAnythingToDo = FALSE
.head 6 +  Loop
.head 7 +  If nIndex = 0
.head 8 -  Break
.head 7 -  Set nOffset = SalStrScan(strSubst[nIndex,0], "
")
.head 7 +  If nOffset =-1
.head 8 -  Set nOffset = SalStrLength(strSubst[nIndex,0])
.head 7 -  Set str0 = SalStrLeftX(strSubst[nIndex,0], nOffset)
.head 7 -  Set strSubst[nIndex,0] = VSStrTail(strSubst[nIndex,0], nOffset+2)
.head 7 +  If strSubst[nIndex,0] != ""
.head 8 -  Set bAnythingToDo = TRUE
.head 7 +  If str0 = ""
.head 8 -  Set str0 = SalStrRepeatX( " ", SalStrToNumber(strSubst[nIndex,2]) )
.head 7 -  Set str1 = SalStrReplaceX( str1, SalStrToNumber(strSubst[nIndex,1]), 1, str0 )
.head 7 -  Set nIndex = nIndex-1
.head 6 -  Set strR = strR || str1 || "
"
.head 5 -  !
.head 5 -  ! Call SalMessageBox(strR, "Результат", MB_Ok)
.head 5 -  Set strR = SalStrLeftX(strR, SalStrLength(strR)-2)
.head 5 -  Return strR
.head 3 +  Function: StrClear
.head 4 -  Description: Рубает из строки все символы, кроме вертикальных линий, заменяя остальное на пробелы
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  String: strO
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nChar
.head 5 -  String: str1
.head 5 -  String: str2
.head 4 +  Actions
.head 5 -  Set str1 = strO
.head 5 +  While str1 != ""
.head 6 -  Set nChar = SalStrLop( str1 )
.head 6 +  If nChar = 64
.head 7 -  Set str2 = str2 || "@" || SalStrLeftX(str1, 11)
.head 7 -  Set str1 = VSStrTail(str1, 11)
.head 6 +  Else If (nChar = 33) OR (nChar = 124) OR (nChar = 179) OR (nChar = 186)
.head 7 -  Set str2 = str2 || SalNumberToChar( nChar )
.head 6 +  Else If (nChar = 43)
.head 7 -  Set str2 = str2 || "!"
.head 6 +  Else If (nChar = 180) OR (nChar = 181) OR (nChar = 184) OR (nChar = 191) OR (nChar = 194) OR (nChar = 195) OR (nChar = 197) OR (nChar = 198) OR (nChar = 209) OR (nChar = 213) OR (nChar = 216) OR (nChar = 218)
.head 7 -  Set str2 = str2 || SalNumberToChar( 179 )
.head 6 +  Else If (nChar = 182) OR (nChar = 183) OR (nChar = 185) OR (nChar = 187) OR (nChar = 199) OR (nChar = 201) OR (nChar = 203) OR (nChar = 204) OR (nChar = 206) OR (nChar = 210) OR (nChar = 214) OR (nChar = 215)
.head 7 -  Set str2 = str2 || SalNumberToChar( 186 )
.head 6 +  Else
.head 7 -  Set str2 = str2 || " "
.head 5 -  Return str2
.head 3 +  Function: CountLinesInSection
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Number:
.head 4 +  Parameters
.head 5 -  String: strOriginal
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nResult
.head 5 -  String: str1
.head 5 -  Number: nOffset
.head 4 +  Actions
.head 5 +  If strOriginal = ''
.head 6 -  Return 0
.head 5 -  Set nResult = 1
.head 5 -  Set str1 = strOriginal
.head 5 +  Loop
.head 6 -  Set nOffset = SalStrScan( str1, "
" )
.head 6 +  If nOffset = -1
.head 7 -  Break
.head 6 +  Else
.head 7 -  Set nResult = nResult+1
.head 7 -  Set str1 = SalStrRightX(str1, SalStrLength(str1)-nOffset-1)
.head 5 -  Return nResult
.head 3 +  Function: GetVarValue
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  String: strVar
.head 5 -  ! nType: 1=Value, 3=Format
.head 5 -  Number: nType
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strSubst
.head 4 +  Actions
.head 5 -  Set strVar = SalStrUpperX( strVar )
.head 5 -  Set nHostVarIndex = 1
.head 5 +  Loop
.head 6 +  If nHostVarIndex > SalStrToNumber(strHostVar[0,0])
.head 7 -  Call ShowErr("Нет переменной:
"|| strVar, "DRW00010")
.head 7 -  Return ""
.head 6 +  If strVar = strHostVar[nHostVarIndex,0]
.head 7 +  If nType = 1
.head 8 -  Set strSubst = strHostVar[nHostVarIndex,2]
.head 7 +  Else
.head 8 -  Set strSubst = ""
.head 7 +  If strSubst = ""
.head 8 -  Return strHostVar[nHostVarIndex,nType]
.head 7 +  Else
.head 8 +  If SalStrLeftX(strHostVar[nHostVarIndex,2], 4) = "(SUM"
.head 9 -  Return strHostVar[nHostVarIndex,nType]
.head 8 +  Else
.head 9 -  Return GetVarValue(strSubst, nType)
.head 6 -  Set nHostVarIndex = nHostVarIndex+1
.head 3 +  Function: ApplyFormat
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  String: strData
.head 5 -  String: strFormat
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strR
.head 5 -  Boolean: bOutSign
.head 5 -  Boolean: bConvertWin2DOS
.head 5 -  Number: nTotalLength
.head 5 -  String: strAdjust
.head 5 -  Number: nRLength
.head 5 -  Number: nAddToRight
.head 5 -  Number: nAddToLeft
.head 5 -  ! 0=Number; 1=Date/Time; 2=String
.head 5 -  Number: nDataType
.head 5 -  Number: nData
.head 5 -  String: strDig
.head 5 -  Number: nDig
.head 5 -  String: str1
.head 5 -  String: str2
.head 5 -  String: strData2
.head 4 +  Actions
.head 5 -  !
.head 5 -  ! Call SalMessageBox("<" || strData || ">", "<" || strFormat || ">", MB_Ok)
.head 5 -  Set bOutSign = FALSE
.head 5 -  Set bConvertWin2DOS = TRUE
.head 5 -  Set strData2 = SalStrLeftX( strFormat, 1 )
.head 5 +  If (strData2 = "$") OR (strData2 = "&")
.head 6 -  Set nDataType = 2
.head 5 +  ! Else If (strData2 = "+") OR (strData2 = "-")
.head 6 -  Set nDataType = 0
.head 5 +  Else
.head 6 -  Set strData2 = strData
.head 6 +  If SalStrIsValidNumber( strData )
.head 7 -  Set nDataType = 0
.head 6 +  Else If SalStrIsValidDateTime(strData2)
.head 7 -  Set strData = strData2
.head 7 -  Set nDataType = 1
.head 6 +  Else
.head 7 -  Set nDataType = 2
.head 5 -  ! Call SalMessageBox("Format: <" || strFormat || ">
Data: <" || strData || ">
Type: <" || SalNumberToStrX(nDataType,0) || ">
", "debug", MB_Ok)
.head 5 +  If strFormat = ""
.head 6 -  Set strFormat = _DefaultFormat
.head 5 -  Set nTotalLength = SalStrToNumber(SalStrMidX(strFormat, 2, 3))
.head 5 -  Set strAdjust = SalStrMidX(strFormat,1,1)
.head 5 -  Set strR = ""
.head 5 +  Select Case nDataType
.head 6 +  Case 0
.head 7 -  Set strDig = "0"
.head 7 +  If SalStrMidX(strFormat,0,1) = "+"
.head 8 -  Set bOutSign = TRUE
.head 7 +  Else If SalStrMidX(strFormat,0,1) = "$"
.head 8 -  Set bConvertWin2DOS = FALSE
.head 7 +  If SalStrMidX(strFormat, 5, 1) = "."
.head 8 +  If SalStrMidX(strFormat, 6, 1) = "@"
.head 9 -  Set strDig = GetVarValue(SalStrUpperX( VSStrTail(strFormat, 7) ), 1)
.head 8 +  Else
.head 9 -  Set strDig = (VSStrTail(strFormat, 6) )
.head 8 +  If NOT SalStrIsValidNumber(strDig)
.head 9 -  Call ShowErr("Выражение <" || VSStrTail(strFormat, 6) || ">, значение <" || strDig || ">:
Количество десятичных знаков должно быть числом!", "DRW00000")
.head 9 -  Set strDig = "0"
.head 7 -  Set nDig = SalStrToNumber(strDig)
.head 7 -  Set nData = SalStrToNumber(strData)
.head 7 -  Set strR = SalNumberToStrX(nData/SalNumberPower(10, nDig), nDig)
.head 7 +  If bOutSign AND (nData >= 0)
.head 8 -  Set strR = "+" || strR
.head 7 -  Break
.head 6 +  Case 1
.head 7 -  Set strR = SalStrMidX(strFormat, 6, SalStrLength(strFormat)-7 )
.head 7 -  Set strR = SalFmtFormatDateTime( SalStrToDate( strData ), strR )
.head 7 -  ! Call SalMessageBox("strR = " || strR, "debug", MB_Ok)
.head 7 -  Break
.head 6 +  Case 2
.head 7 -  Set strR = SalStrTrimX(strData)
.head 7 +  If bConvertWin2DOS
.head 8 -  Set strR = StrWinToDosX( strR )
.head 7 -  Break
.head 5 -  ! AND (strAdjust != "*") vvvvvvvvvvvvvvvvvvvvvvvvvvvv
.head 5 +  If (nTotalLength != 0)
.head 6 -  Set str1 = ""
.head 6 +  Loop
.head 7 -  Set str2 = StrGetToCRLFNoMoreThanLimit(strR, nTotalLength)
.head 7 -  Set nRLength = SalStrLength(str2)
.head 7 +  If strAdjust = "<"
.head 8 -  Set nAddToRight = nTotalLength - nRLength
.head 7 +  Else If (strAdjust = ">") OR (strAdjust = "*")
.head 8 -  Set nAddToLeft = nTotalLength - nRLength
.head 7 +  Else If strAdjust = "%"
.head 8 -  Set nAddToLeft = SalNumberRound( (nTotalLength - nRLength)/2 )
.head 8 -  Set nAddToRight = SalNumberRound( (nTotalLength - nRLength-0.5)/2 )
.head 7 +  Else If strAdjust = "="
.head 8 -  Set nAddToLeft = 0
.head 8 +  If strR != ""
.head 9 -  Set str2 = StrJustify(str2, nTotalLength)
.head 9 -  Set nAddToRight = 0
.head 8 +  Else
.head 9 -  Set nAddToRight = nTotalLength - nRLength
.head 7 -  Set str1 = str1 || SalStrRepeatX( " ", nAddToLeft ) || str2 || SalStrRepeatX( " ", nAddToRight )
.head 7 +  If strR = ""
.head 8 -  Break
.head 7 +  Else
.head 8 -  Set str1 = str1 || "
"
.head 6 -  Set strR = str1
.head 5 -  ! Call SalMessageBox("<" || strR || ">", "Результат", MB_Ok)
.head 5 -  Return strR
.head 3 +  Function: StrJustify
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  String: strO
.head 5 -  Number: nDesiredLength
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nSpaces[*]
.head 5 -  Number: nSpCounter
.head 5 -  Number: nOffset
.head 5 -  ! по сколько пробелов вставлять обычно
.head 5 -  Number: nSpaces1
.head 5 -  ! сколько раз вставлять nSpaces+1 пробелов
.head 5 -  Number: nSpaces2
.head 4 +  Actions
.head 5 -  Set nSpCounter = 0
.head 5 -  Set nOffset = 0
.head 5 +  While nOffset < SalStrLength(strO)
.head 6 +  If SalStrMidX(strO, nOffset, 1) = " "
.head 7 -  Set nSpaces[nSpCounter] = nOffset
.head 7 -  Set nSpCounter = nSpCounter + 1
.head 6 -  Set nOffset = nOffset + 1
.head 5 +  If nSpCounter = 0
.head 6 -  Return strO || SalStrRepeatX(" ", nDesiredLength - SalStrLength(strO))
.head 5 +  Else
.head 6 -  ! сколько пробелов вставлять в каждый разрыв
.head 6 -  Set nSpaces2 = SalNumberMod( nDesiredLength - SalStrLength(strO), nSpCounter)
.head 6 -  Set nSpaces1 = ( nDesiredLength - SalStrLength(strO) - nSpaces2 ) / nSpCounter
.head 6 -  Set nSpCounter = nSpCounter - 1
.head 6 +  While nSpCounter != -1
.head 7 +  If nSpaces2 != 0
.head 8 -  Set strO = SalStrReplaceX( strO, nSpaces[nSpCounter], 1, SalStrRepeatX( " ", nSpaces1+2 ) )
.head 8 -  Set nSpaces2 = nSpaces2 - 1
.head 7 +  Else
.head 8 -  Set strO =  SalStrReplaceX( strO, nSpaces[nSpCounter], 1, SalStrRepeatX( " ", nSpaces1+1 ) )
.head 7 -  Set nSpCounter = nSpCounter - 1
.head 6 -  Return strO
.head 3 +  Function: StrGetToCRLFNoMoreThanLimit
.head 4 -  Description: Возвращает начало строки до первого CR/LF, но не более указанного кол-ва символов
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  Receive String: strO
.head 5 -  Number: nLimit
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nOffset
.head 5 -  String: strR
.head 4 +  Actions
.head 5 -  Set nOffset = SalStrScan( strO, "
")
.head 5 +  If (nOffset != -1) AND (nOffset < nLimit)
.head 6 -  Set strR = SalStrLeftX(strO, nOffset)
.head 6 -  Set strO = VSStrTail(strO, nOffset - 1)
.head 6 -  Return strR
.head 5 +  Else If SalStrLength(strO) <= nLimit
.head 6 -  Set strR = strO
.head 6 -  Set strO = ""
.head 6 -  Return strR
.head 5 +  Else
.head 6 -  Set nOffset = nLimit
.head 6 +  Loop
.head 7 +  If SalStrMidX(strO, nOffset, 1) = " "
.head 8 -  Set strR = SalStrLeftX(strO, nOffset)
.head 8 -  Set strO = VSStrTail(strO, nOffset + 1)
.head 8 -  Break
.head 7 +  Else
.head 8 -  Set nOffset = nOffset -1
.head 8 +  If nOffset = -1
.head 9 -  Set strR = SalStrLeftX(strO, nLimit)
.head 9 -  Set strO = VSStrTail(strO, nLimit)
.head 9 -  Break
.head 6 -  Return strR
.head 3 +  Function: FormatN
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  Number: nData
.head 5 -  String: strFormat
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Return ApplyFormat(SalNumberToStrX(nData,10), strFormat)
.head 3 +  Function: FormatS
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  String: strData
.head 5 -  String: strFormat
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Return ApplyFormat(strData, strFormat)
.head 3 +  Function: ParseExpression
.head 4 -  Description: Выдёргивает одно выражение
.head 4 +  Returns
.head 5 -  ! Возвращает длину шаблона
.head 5 -  Number: nLength
.head 4 +  Parameters
.head 5 -  String: strOriginal
.head 5 -  ! nStartPos должно указывать на первый символ "@"
.head 5 -  Number: nStartPos
.head 5 -  Receive String: strExpression
.head 5 -  Receive String: strDefaultValue
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: str0
.head 5 -  Number: nChar
.head 5 -  Number: nBrackets
.head 5 -  String: str1
.head 5 -  Number: nLen
.head 4 +  Actions
.head 5 -  Set nBrackets = 0
.head 5 -  Set str0 = SalStrRightX(strOriginal, SalStrLength(strOriginal)-nStartPos-1)
.head 5 -  Set strExpression = ""
.head 5 -  Set strDefaultValue = ""
.head 5 -  ! Ищем формулу/выражение/хост-переменную
.head 5 +  If SalStrLeftX( str0, 1 ) = "?"
.head 6 -  Set strExpression = "?"
.head 6 -  Set str0 = VSStrTail( str0, 1 )
.head 6 -  ! Это то, что спрашиваем
.head 6 -  If SalStrLeftX( str0, 1 ) = '{'
.head 6 -  Set nLen = VSStrScan( str0, "}" )
.head 6 -  Set strExpression = "?" || SalStrMidX( str0, 1, nLen-1 )
.head 6 -  Set str0 = VSStrTail( str0, nLen+1 )
.head 6 -  ! Это то, какое значение по умолчанию
.head 6 -  If SalStrLeftX( str0, 1 ) = '{'
.head 6 -  Set nLen = VSStrScan( str0, "}" )
.head 6 -  Set strDefaultValue = SalStrMidX( str0, 1, nLen-1 )
.head 6 -  Set str0 = VSStrTail( str0, nLen+1 )
.head 5 +  Else
.head 6 +  Loop
.head 7 +  If str0 = ""
.head 8 -  Break
.head 7 -  Set nChar = SalStrLop( str0 )
.head 7 +  If nChar = 40
.head 8 -  Set nBrackets = nBrackets+1
.head 8 -  Set strExpression = strExpression || SalNumberToChar(nChar)
.head 7 +  Else If nChar = 41
.head 8 +  If nBrackets = 0
.head 9 -  Break
.head 8 +  Else
.head 9 -  Set nBrackets = nBrackets-1
.head 9 -  Set strExpression = strExpression || SalNumberToChar(nChar)
.head 7 +  Else If ((nChar >=65) AND (nChar <=90)) OR ((nChar >=48) AND (nChar <=57)) OR ((nChar >=97) AND (nChar <=122)) OR (nChar = 95)
.head 8 -  Set strExpression = strExpression || SalNumberToChar(nChar)
.head 7 +  Else If nBrackets != 0
.head 8 -  Set strExpression = strExpression || SalNumberToChar(nChar)
.head 7 +  Else
.head 8 -  Break
.head 5 -  Set nLen = SalStrLength(strOriginal) - SalStrLength(str0) - nStartPos - 1
.head 5 +  If str0 = ""
.head 6 -  Set nLen = nLen+1
.head 5 -  Return nLen
.head 3 +  Function: ParseFormat
.head 4 -  Description: Выдёргивает один формат выражения
.head 4 +  Returns
.head 5 -  ! Возвращает длину шаблона
.head 5 -  Number: nLength
.head 4 +  Parameters
.head 5 -  String: strOriginal
.head 5 -  ! nStartPos должно указывать на первый символ формата, либо на пробел
.head 5 -  Number: nStartPos
.head 5 -  Receive String: strFormat
.head 5 -  Number: nAddLen
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: str0
.head 5 -  Number: nChar
.head 5 -  String: strLen
.head 5 -  String: strDecimals
.head 5 -  Number: nDiez
.head 5 -  Number: nTPLLength
.head 4 +  Actions
.head 5 -  Set str0 = VSStrTail(strOriginal, nStartPos)
.head 5 -  Set strFormat = ""
.head 5 -  ! Ищем знак или префикс конвертирования
.head 5 -  Set nChar = SalStrLop( str0 )
.head 5 +  If nChar = 43
.head 6 -  Set strFormat = strFormat || "+"
.head 6 -  Set nChar = SalStrLop( str0 )
.head 5 +  Else If nChar = 36
.head 6 -  Set strFormat = strFormat || "$"
.head 6 -  Set nChar = SalStrLop( str0 )
.head 5 +  Else If nChar = 38
.head 6 -  Set strFormat = strFormat || "&"
.head 6 -  Set nChar = SalStrLop( str0 )
.head 5 +  Else If nChar = 45
.head 6 -  Set strFormat = strFormat || "-"
.head 6 -  Set nChar = SalStrLop( str0 )
.head 5 +  Else
.head 6 -  Set strFormat = strFormat || "-"
.head 5 -  ! Ищем знак выравнивания
.head 5 +  If (nChar = 62) OR (nChar = 61) OR (nChar = 42) OR (nChar = 60) OR (nChar = 37)
.head 6 -  Set strFormat = strFormat || SalNumberToChar(nChar)
.head 6 -  Set nChar = SalStrLop( str0 )
.head 5 +  Else
.head 6 -  Set strFormat = strFormat || "*"
.head 5 -  Set strFormat = strFormat || "000"
.head 5 -  Set strLen = ""
.head 5 -  Set strDecimals = ""
.head 5 -  ! Ищем длину
.head 5 +  While (nChar >=48) AND (nChar <=57)
.head 6 -  Set strLen = strLen || SalNumberToChar(nChar)
.head 6 -  Set nChar = SalStrLop( str0 )
.head 5 +  If nChar = 39				! дата
.head 6 -  Set nChar = SalStrLop( str0 )
.head 6 +  While nChar !=39
.head 7 -  Set strDecimals = strDecimals || SalNumberToChar(nChar)
.head 7 -  Set nChar = SalStrLop( str0 )
.head 6 +  If SalFmtIsValidPicture( strDecimals, FMT_Pic_DateTime )
.head 7 -  Set strFormat = strFormat || "'" || strDecimals || "'"
.head 6 +  Else
.head 7 -  Call ShowErr( "Файл " || strDRW || ": Строка " || SalNumberToStrX(nTplRow,0) || ":
Выражение  <" || strDecimals || "> не является корректным форматом для даты!", "DRW00000")
.head 5 +  Else If nChar = 46				! десятичная точка
.head 6 -  Set strFormat = strFormat || "."
.head 6 -  Set nChar = SalStrLop( str0 )
.head 6 +  If nChar = 64				! десятичная переменная
.head 7 -  Set strFormat = strFormat || "@"
.head 7 -  Set str0 = VSStrTail( str0, ParseExpression( str0, -1, strDecimals, strTryDefault ))
.head 6 +  Else !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! десятичные знаки
.head 7 +  While (nChar >=48) AND (nChar <=57)
.head 8 -  Set strDecimals = strDecimals || SalNumberToChar(nChar)
.head 8 -  Set nChar = SalStrLop( str0 )
.head 6 -  Set strFormat = strFormat || strDecimals
.head 5 -  ! Считаем диезы
.head 5 -  Set nDiez = 0
.head 5 +  While nChar = 35
.head 6 -  Set nDiez = nDiez+1
.head 6 -  Set nChar = SalStrLop( str0 )
.head 5 -  Set nTPLLength = SalStrLength(strOriginal) - nStartPos - SalStrLength(str0) - 1 + nAddLen
.head 5 -  ! - nDiez ????????????
.head 5 +  If str0 = ''
.head 6 -  Set nTPLLength = nTPLLength +1
.head 5 +  If nDiez != 0
.head 6 -  Set strLen = SalStrRightX("000" || SalNumberToStrX(nTPLLength,0), 3)
.head 5 +  Else
.head 6 -  Set strLen = SalStrRightX("000" || strLen, 3)
.head 5 -  Call SalStrReplace( strFormat, 2, 3, strLen, strFormat )
.head 5 -  Return nTPLLength
.head 3 +  Function: ShowSections
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nGroup
.head 5 -  Receive Long String: lstrReport
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: str1
.head 5 -  Number: nCurrentSection
.head 5 -  String: strControlVar
.head 5 -  String: strOldControlValue
.head 5 -  String: strNewControlValue
.head 5 -  Boolean: bEOF
.head 5 -  Number: nDummy
.head 5 -  Long String: lstrHeader
.head 5 -  Long String: lstrInner
.head 5 -  Long String: lstrTmp
.head 5 -  Long String: lstrFooter
.head 5 -  Number: nVarIndex
.head 4 +  Actions
.head 5 +  If nGroup <= nMaxDepth
.head 6 -  ! Получаем имя управляющей переменной и её старое значение
.head 6 +  If (nGroup != 0)
.head 7 -  Call GetNextSection(SalNumberToStrX(nGroup,0) || "-_-H", nCurrentSection)
.head 7 -  Set strControlVar = strSections[nCurrentSection, 2]
.head 7 -  Set strOldControlValue = GetVarValue( strControlVar, 1 )
.head 7 -  Call GetNextSection("", nDummy)
.head 6 -  ! Обнуляем значения всех переменных, которые зависят от сумм внутренних групп
.head 6 -  Set nVarIndex = 1
.head 6 +  While nVarIndex <= SalStrToNumber( strHostVar[0,0] )
.head 7 +  If IsVarDependsOnGroup(strHostVar[nVarIndex, 2], nGroup)
.head 8 -  Set strHostVar[nVarIndex, 1] = "0"
.head 7 -  Call Inc(nVarIndex)
.head 6 -  ! Изобразить все внутренние секции
.head 6 -  Call SetAction( "Изображаем подсекции группы " || strSections[nCurrentSection, 0])
.head 6 -  Set lstrInner = ""
.head 6 +  Loop
.head 7 +  If NOT bCanWork
.head 8 -  Return FALSE
.head 7 -  Set bEOF = ShowSections (nGroup+1, lstrTmp)
.head 7 -  Set lstrInner = lstrInner || lstrTmp
.head 7 +  If Not bEOF
.head 8 -  Break
.head 7 +  If (nGroup != 0)
.head 8 -  Set strNewControlValue = GetVarValue(strControlVar,1)
.head 8 +  If strNewControlValue != strOldControlValue
.head 9 -  Break
.head 7 +  ! Else
.head 8 -  Break
.head 6 -  Call GoBack()
.head 6 -  ! Изобразить заголовки этой секции
.head 6 -  Call SetAction( "Изображаем заголовки группы " || strSections[nCurrentSection, 0])
.head 6 -  Call ShowSectionsOfType (SalNumberToStrX(nGroup,0) || "-_-H", lstrHeader)
.head 6 -  ! Изобразить подвалы этой секции
.head 6 -  Call SetAction( "Изображаем подвалы группы " || strSections[nCurrentSection, 0])
.head 6 -  Call ShowSectionsOfType(SalNumberToStrX(nGroup,0) || "-_-F", lstrFooter)
.head 6 -  Call GoForward()
.head 6 -  !
.head 6 +  If strNewControlValue != strOldControlValue
.head 7 -  Set strSections[nCurrentSection, 3] = strNewControlValue
.head 7 -  Set strOldControlValue = strNewControlValue
.head 6 -  !
.head 6 -  Set lstrReport = lstrHeader || lstrInner || lstrFooter
.head 6 -  !
.head 6 -  Return bEOF
.head 5 +  Else
.head 6 -  Set dlg_DRWProgress.dfRecord = _CurrentRecord
.head 6 +  If _TotalRecords != 0
.head 7 -  Call dlg_DRWProgress.ccProgress.SetProgress(_CurrentRecord*100/_TotalRecords)
.head 6 -  Call SalUpdateWindow( dlg_DRWProgress )
.head 6 -  Call SalIdleKick(  )
.head 6 -  Call SetAction( "Изображаем секции деталей")
.head 6 -  Set lstrInner = ""
.head 6 -  Call ShowSectionsOfType( "D-_", lstrTmp )
.head 6 -  Set lstrInner = lstrInner || lstrTmp
.head 6 -  Call GetNextSection("", nDummy)
.head 6 -  ! Set dlg_DRWProgress.mlProgress = lstrReport
.head 6 -  Set lstrReport = lstrInner
.head 6 -  Return GoForward()
.head 3 +  Function: IsVarDependsOnGroup
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: strVarFormula
.head 5 -  Number: nGroup
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  ! Call SalMessageBox("var: " || strVarFormula , "", MB_Ok)
.head 5 +  If SalStrUpperX(SalStrLeftX(strVarFormula, 4)) = "(SUM"
.head 6 +  If SalStrToNumber(SalStrMidX(strVarFormula, 3, 1)) >= nGroup
.head 7 -  Return TRUE
.head 5 -  Return FALSE
.head 3 +  Function: ShowSectionsOfType
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  String: strMask
.head 5 -  Receive Long String: lstrReport
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nDummy
.head 5 -  String: strSectionText
.head 5 -  Number: nOffset1
.head 4 +  Actions
.head 5 -  ! Секций одного типа (Group + Head/Foot или Details) может быть много
.head 5 +  Loop DRWsection
.head 6 -  Set strSectionText = GetNextSection(strMask, nDummy)
.head 6 +  If strSectionText = ''
.head 7 -  Break DRWsection
.head 6 -  ! Строк в одной секции может быть много
.head 6 +  Loop DRWOneLine
.head 7 +  If strSectionText = ""
.head 8 -  Break DRWOneLine
.head 7 -  Set nOffset1 = SalStrScan(strSectionText, "
")
.head 7 +  If nOffset1 = -1
.head 8 -  Set nOffset1 = SalStrLength(strSectionText)
.head 7 -  Set strLin = SalStrLeftX(strSectionText, nOffset1)
.head 7 -  Set strSectionText = VSStrTail(strSectionText, nOffset1+2)
.head 7 -  Set strLin = InsertDataIntoSection(strLin)
.head 7 +  If _bShowDebug
.head 8 -  Set lstrReport = lstrReport || "
" || strLin
.head 7 +  If _ExportTo = "TEXT"
.head 8 -  Call SalFilePutStr( hfOut, strLin )
.head 7 -  Else If _ExportTo = "DBF"
.head 7 -  Else
.head 7 -  !
.head 3 +  Function: GoForward
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nRet
.head 5 -  Number: nRow
.head 5 -  String: strTMP
.head 4 +  Actions
.head 5 +  If strHostVar[0,4] = "YES"
.head 6 -  Set nRow = 1
.head 6 +  Loop
.head 7 +  If nRow > SalStrToNumber(strHostVar[0,0])
.head 8 -  Break
.head 7 -  Set strHostVar[nRow,1] = strHostVar[nRow,4]
.head 7 -  Set nRow = nRow+1
.head 6 -  Set strHostVar[0,4] = ""
.head 6 -  Set _CurrentRecord = _CurrentRecord +1
.head 6 -  Return TRUE
.head 5 +  Else
.head 6 -  Set nRow = 1
.head 6 +  Loop
.head 7 +  If nRow > SalStrToNumber(strHostVar[0,0])
.head 8 -  Break
.head 7 +  If SalStrLeftX(strHostVar[nRow,0], 4) = "(SUM"
.head 8 -  If SalStrToNumber(SalStrMidX(strHostVar[nRow,0], 4, 1)) < nSectionDepth
.head 8 -  Set strHostVar[nRow, 1] = SalNumberToStrX(SalStrToNumber(strHostVar[nRow, 1]) + SalStrToNumber(GetVarValue( SalStrMidX(strHostVar[nRow,0], 6, SalStrLength(strHostVar[nRow,0])-6), 1 )), 10)
.head 8 -  Call ShowErr(strHostVar[nRow, 1], "!")
.head 7 -  Set strTMP = strHostVar[nRow,1]
.head 7 -  Set strHostVar[nRow,4] = strHostVar[nRow,1]
.head 7 -  Set strHostVar[nRow,4] = strTMP
.head 7 -  Set nRow = nRow+1
.head 6 +  If SqlFetchNext( hSql(), nRet )
.head 7 +  If nRet = FETCH_EOF
.head 8 -  Return FALSE
.head 7 +  Else
.head 8 -  Set _CurrentRecord = _CurrentRecord +1
.head 8 -  Return TRUE
.head 6 +  Else
.head 7 -  Return FALSE
.head 3 +  Function: GoBack
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nRow
.head 5 -  String: strTMP
.head 4 +  Actions
.head 5 -  Set nRow = 1
.head 5 +  Loop
.head 6 +  If nRow > SalStrToNumber(strHostVar[0,0])
.head 7 -  Break
.head 6 -  Set strTMP = strHostVar[nRow,1]
.head 6 -  Set strHostVar[nRow,1] = strHostVar[nRow,4]
.head 6 -  Set strHostVar[nRow,4] = strTMP
.head 6 -  Set nRow = nRow+1
.head 5 -  Set _CurrentRecord = _CurrentRecord -1
.head 5 -  Set strHostVar[0,4] = "YES"
.head 5 -  Return TRUE
.head 2 +  Window Parameters
.head 3 -  Number: nReport
.head 2 +  Window Variables
.head 3 -  ! Окно трассировки
.head 3 -  Window Handle: hwProgress
.head 3 -  Boolean: bCanWork
.head 3 -  Boolean: bReportIsRunning
.head 3 -  ! Всё, что касается файлов IN/OUT
.head 3 -  !
.head 3 -  ! Имя файла шаблона
.head 3 -  String: strDRW
.head 3 -  ! Хендл файла шаблона
.head 3 -  File Handle: hfTpl
.head 3 -  ! Токены имени файла выхода
.head 3 -  String: strFileName[0:*]
.head 3 -  ! Имя файла выхода
.head 3 -  String: strDRWOut
.head 3 -  ! Хендл файла выхода
.head 3 -  File Handle: hfOut
.head 3 -  ! Всё, что касается одной строки шаблона
.head 3 -  String: strOneLine
.head 3 -  String: strOneLineTrim
.head 3 -  String: strOneWordTrim
.head 3 -  Number: nTplRow
.head 3 -  !
.head 3 -  Number: nOffset
.head 3 -  Number: nOldOffset
.head 3 -  String: strTemplate[0:*]
.head 3 -  String: strCurrentSection
.head 3 -  String: strInnerSection
.head 3 -  String: strTrySection
.head 3 -  String: strTryVar
.head 3 -  String: strTryValue
.head 3 -  String: strTryValueTrim
.head 3 -  String: strTryDefault
.head 3 -  Number: nTryValue
.head 3 -  Boolean: bSectionIsCorrect
.head 3 -  Number: nHostVarIndex
.head 3 -  Number: nParsingSection
.head 3 -  String: strHostVarVerbose
.head 3 -  Boolean: bQueryIsInited
.head 3 -  Number: nSectionIndex
.head 3 -  Number: nRet
.head 3 -  ! Boolean: bShowPageHeader
.head 3 -  Number: nCurLineOnPage
.head 3 -  String: strLin
.head 3 -  String: strHV
.head 3 -  String: strHVFormat
.head 3 -  Number: n1
.head 3 -  Number: n2
.head 3 -  Number: nMaskLen
.head 3 -  Number: nNewMaskLen
.head 3 -  Number: nSubstedVar
.head 3 -  Number: nSubstedVarIndex
.head 3 -  Number: nSectionDepth
.head 3 -  Number: nMaxDepth
.head 3 -  String: strGlobalsQuery
.head 3 -  Long String: lstrReport
.head 3 -  ! Массивы переменных и секций
.head 3 -  ! Элемент №0,0 хранит длину
.head 3 -  ! Элемент №0,4 хранит "YES", если был произведен мягкий FetchPrevious
.head 3 -  ! strHostVar[*,0] - имя хост-переменной
.head 3 -  ! strHostVar[*,1] - Её значение
.head 3 -  ! strHostVar[*,2] - Формула, по которой вычисляется данная переменная
.head 3 -  ! strHostVar[*,3] - Формат переменной
.head 3 -  ! strHostVar[*,4] - Старое значение для обхода SqlFetchPrevious
.head 3 -  String: strHostVar[0:*,0:4]
.head 3 -  ! strSections[*,0] ='1-0-H' (№ секции - № вариации - Header или Footer (H/F))
.head 3 -  ! Тип секции		Номер секции
.head 3 -  ! Внешний для репорта	0
.head 3 -  ! Details Section		D
.head 3 -  ! Page Header/Footer	#
.head 3 -  ! Группы			1,2,...
.head 3 -  ! strSections[*,1] = Длинная текстовая строка шаблона
.head 3 -  ! strSections[*,2] = переменная, изменение которой инициирует разрыв этой секции
.head 3 -  ! strSections[*,3] = старое значение переменной, изменение которой инициирует разрыв этой секции
.head 3 -  String: strSections[0:*,0:3]
.head 3 -  !
.head 3 -  ! Глобальные переменные для отчёта
.head 3 -  !
.head 3 -  Boolean: _bShowDebug
.head 3 -  String: _DefaultFormat
.head 3 -  String: _ExportTo
.head 3 -  Number: _PageLength
.head 3 -  Number: _PageWidth
.head 3 -  Number: _PageNumber
.head 3 -  String: _strQuery
.head 3 -  String: _strCountQuery
.head 3 -  String: _strEmptyLine
.head 3 -  String: _strComment
.head 3 -  Number: _CurrentRecord
.head 3 -  Number: _TotalRecords
.head 2 +  Message Actions
.head 3 +  On SAM_CreateComplete
.head 4 -  Set strSQL = 'SELECT description, id, name
INTO :hWndForm.colDescription, :hWndForm.colID, :hWndForm.colName
FROM reports
WHERE (id >= 100)'
.head 4 -  ! Call SalMessageBox(strSQL, "!", MB_Ok)
.head 4 +  If (nReport != 0) AND (nReport != 100)
.head 5 -  Set strSQL = strSQL || ' AND (id = ' || SalNumberToStrX(nReport,0) || ')'
.head 4 -  Set strSQL = T(strSQL)
.head 4 -  Call tblDRWs.BuildFieldList('description, id, name')
.head 4 -  Call tblDRWs.SetSql( strSQL, hSql() )
.head 4 +  ! If hSql() = 0x0
.head 5 -  Call ShowErr("hSql()=0 !", "!")
.head 4 -  ! Call SalMessageBox("!", "refresh", MB_Ok)
.head 4 -  Call tblDRWs.Refresh ( )
.head 4 -  ! Call SalMessageBox("!", "after refresh", MB_Ok)
.head 4 -  ! Call SalTblPopulate( tblDRWs, hSql(), strSQL, TBL_FillAll )
.head 4 +  If (nReport != 100) AND (nReport != 0)
.head 5 -  Call SalSendMsg( pbOK, SAM_Click, 0, 0 )
.head 1 +  Dialog Box: dlg_SetDRWParam
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title:
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  7.85"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 3.095"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description:
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: Default
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  Multiline Field: mlHeader
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
.head 5 -  Vertical Scroll? Yes
.head 5 -  Window Location and Size
.head 6 -  Left:   0.083"
.head 6 -  Top:    0.488"
.head 6 -  Width:  7.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 1.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 4 -  Message Actions
.head 3 +  Multiline Field: mlValue
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  String Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Border? Yes
.head 5 -  Word Wrap? Yes
.head 5 -  Vertical Scroll? No
.head 5 -  Window Location and Size
.head 6 -  Left:   0.083"
.head 6 -  Top:    1.655"
.head 6 -  Width:  7.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.417"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 4 -  Message Actions
.head 3 -  Background Text: Установление параметров отчёта
.head 4 -  Resource Id: 23805
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.883"
.head 5 -  Top:    0.095"
.head 5 -  Width:  6.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Center
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Pushbutton: pbNext
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вперёд &>>
.head 4 -  Window Location and Size
.head 5 -  Left:   1.883"
.head 5 -  Top:    2.155"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set strUsefulFormulaText[nFormula] = mlValue
.head 6 -  Call ShowFormula( nFormula+1 )
.head 3 +  Pushbutton: pbPrev
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: &<< Назад
.head 4 -  Window Location and Size
.head 5 -  Left:   0.583"
.head 5 -  Top:    2.155"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set strUsefulFormulaText[nFormula] = mlValue
.head 6 -  Call ShowFormula( nFormula-1 )
.head 3 +  Pushbutton: pbOK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выполнить
.head 4 -  Window Location and Size
.head 5 -  Left:   3.183"
.head 5 -  Top:    2.155"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set strUsefulFormulaText[nFormula] = mlValue
.head 6 -  Set nUsefulFormulaIndex = 0
.head 6 -  Call SalArrayGetUpperBound( strUsefulFormulaHeader, 1, nFormula )
.head 6 +  Loop
.head 7 +  If nUsefulFormulaIndex = nFormula
.head 8 -  Break
.head 7 -  Set strFormulaName = strUsefulFormulaName[nUsefulFormulaIndex]
.head 7 -  Set strFormulaText = strUsefulFormulaText[nUsefulFormulaIndex]
.head 7 -  Set dlg_DRW.strHostVar[nFormula,1] = strFormulaText
.head 7 -  ! Call SalMessageBox( strFormulaText || " -- " ||SalNumberToStrX(nSqlRes, 0) || " -- " ||SalNumberToStrX(PEGetErrorCode( hPEJob ), 0), strFormulaName, MB_OK)
.head 7 -  Set nUsefulFormulaIndex = nUsefulFormulaIndex+1
.head 6 -  Call SalEndDialog( hWndForm, TRUE )
.head 3 +  Pushbutton: pbRestore
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbRefresh
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вернуть
.head 4 -  Window Location and Size
.head 5 -  Left:   4.483"
.head 5 -  Top:    2.155"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set strUsefulFormulaText[nFormula] = strUsefulFormulaTextOld[nFormula]
.head 6 -  Call ShowFormula(nFormula)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.783"
.head 5 -  Top:    2.155"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog( hWndForm, FALSE )
.head 2 +  Functions
.head 3 +  Function: ShowFormula
.head 4 -  Description: Показывает N-ную формулу
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Number: nF
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: n1
.head 4 +  Actions
.head 5 -  Set nFormula = nF
.head 5 -  Set mlHeader = strUsefulFormulaHeader[nF]
.head 5 -  Set mlValue = strUsefulFormulaText[nF]
.head 5 -  Call SalSetWindowText( hWndForm, strUsefulFormulaWindowHeader[nF] )
.head 5 +  If nF = 0
.head 6 -  Call SalDisableWindow( pbPrev )
.head 5 +  Else
.head 6 -  Call SalEnableWindow( pbPrev )
.head 5 -  Call SalArrayGetUpperBound( strUsefulFormulaHeader, 1, n1 )
.head 5 +  If nF = n1-1
.head 6 -  Call SalDisableWindow( pbNext )
.head 5 +  Else
.head 6 -  Call SalEnableWindow( pbNext )
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  Number: nUsefulFormulaIndex
.head 3 -  Number: nUsefulFormula [0:*]
.head 3 -  String: strUsefulFormulaName [0:*]
.head 3 -  String: strUsefulFormulaText [0:*]
.head 3 -  String: strUsefulFormulaTextOld [0:*]
.head 3 -  String: strUsefulFormulaHeader [0:*]
.head 3 -  String: strUsefulFormulaWindowHeader [0:*]
.head 3 -  Number: nFormulas
.head 3 -  Number: nFormula
.head 3 -  Number: nFormulaName
.head 3 -  Number: nFormulaNameL
.head 3 -  Number: nFormulaText
.head 3 -  Number: nFormulaTextL
.head 3 -  String: strFormulaName
.head 3 -  String: strFormulaText
.head 3 -  Number: nPosOfDelimiter
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalWaitCursor( FALSE )
.head 4 -  !
.head 4 -  ! Обзор всех Formulas
.head 4 -  !
.head 4 -  Set nFormulas = SalStrToNumber( dlg_DRW.strHostVar[0,0] )
.head 4 -  Set nFormula = 0
.head 4 -  Set nUsefulFormulaIndex = 0
.head 4 +  Loop
.head 5 +  If nFormula >= nFormulas
.head 6 -  Break
.head 5 -  ! Получаем текст переменной
.head 5 -  Set strFormulaText = dlg_DRW.strHostVar[nFormula,2]
.head 5 +  If SalStrScan( strFormulaText, "?") = 0
.head 6 -  ! Resizing arrays
.head 6 -  Call SalArraySetUpperBound( nUsefulFormula, 1, nUsefulFormulaIndex+1 )
.head 6 -  Call SalArraySetUpperBound( strUsefulFormulaName, 1, nUsefulFormulaIndex+1 )
.head 6 -  Call SalArraySetUpperBound( strUsefulFormulaText, 1, nUsefulFormulaIndex+1 )
.head 6 -  Call SalArraySetUpperBound( strUsefulFormulaTextOld, 1, nUsefulFormulaIndex+1 )
.head 6 -  Call SalArraySetUpperBound( strUsefulFormulaHeader, 1, nUsefulFormulaIndex+1 )
.head 6 -  Call SalArraySetUpperBound( strUsefulFormulaWindowHeader, 1, nUsefulFormulaIndex+1 )
.head 6 -  ! Номер полезной формулы
.head 6 -  Set nUsefulFormula[nUsefulFormulaIndex] = nFormula
.head 6 -  ! Имя полезной формулы
.head 6 -  ! Set strUsefulFormulaName[nUsefulFormulaIndex] = strFormulaName
.head 6 -  ! Заголовок полезной формулы
.head 6 -  Set strUsefulFormulaHeader[nUsefulFormulaIndex] = StrDosToWinX( VSStrTail(dlg_DRW.strHostVar[nFormula,2], 1) )
.head 6 -  Set strFormulaText = StrDosToWinX( dlg_DRW.strHostVar[nFormula,1] )
.head 6 -  Call ShowErr(
"formula#:	" || SalNumberToStrX(nFormula,0) || "
text:		" || strFormulaText, "!!")
.head 6 -  !
.head 6 -  Set strUsefulFormulaText[nUsefulFormulaIndex] = strFormulaText
.head 6 -  Set strUsefulFormulaTextOld[nUsefulFormulaIndex] = strFormulaText
.head 6 -  ! Call SalMessageBox(strUsefulFormulaName[nUsefulFormulaIndex]|| "
----------------------------------------
" || strUsefulFormulaText[nUsefulFormulaIndex], strUsefulFormulaHeader[nUsefulFormulaIndex], MB_OK)
.head 6 -  Set nUsefulFormulaIndex = nUsefulFormulaIndex+1
.head 5 -  Set nFormula = nFormula+1
.head 4 +  If nUsefulFormulaIndex = 0
.head 5 -  Call SalSendMsg( pbOK, SAM_Click, 0, 0 )
.head 4 +  Else
.head 5 -  Call ShowFormula(0)
.head 3 +  On SAM_Destroy
.head 4 -  Call SalWaitCursor( TRUE )
.head 1 +  Dialog Box: dlg_DRWProgress
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Выполняю отчёт...
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modeless
.head 3 -  Window Location and Size
.head 4 -  Left:   0.013"
.head 4 -  Top:    0.01"
.head 4 -  Width:  13.267"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 7.143"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description:
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: Default
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 -  Group Box: Выполнено
.head 4 -  Resource Id: 1350
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.083"
.head 5 -  Top:    0.071"
.head 5 -  Width:  11.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfAction
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
.head 6 -  Left:   0.183"
.head 6 -  Top:    0.571"
.head 6 -  Width:  11.4"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Custom Control: ccProgress
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cMeter
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  DLL Name:
.head 5 -  MS Windows Class Name:
.head 5 -  Style:  Class Default
.head 5 -  ExStyle:  Class Default
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.2"
.head 6 -  Top:    0.917"
.head 6 -  Width:  11.383"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.333"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Border? Class Default
.head 5 -  Etched Border? Class Default
.head 5 -  Hollow? Class Default
.head 5 -  Vertical Scroll? Class Default
.head 5 -  Horizontal Scroll? Class Default
.head 5 -  Tab Stop? Class Default
.head 5 -  Tile To Parent? Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  DLL Settings
.head 4 -  Message Actions
.head 3 +  Multiline Field: mlProgress
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 32760
.head 5 -  String Type: Long String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Border? Yes
.head 5 -  Word Wrap? No
.head 5 -  Vertical Scroll? Yes
.head 5 -  Window Location and Size
.head 6 -  Left:   0.083"
.head 6 -  Top:    1.405"
.head 6 -  Width:  13.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 5.333"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Courier New Cyr
.head 5 -  Font Size: 11
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Остановить
.head 4 -  Window Location and Size
.head 5 -  Left:   11.783"
.head 5 -  Top:    0.155"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If (NOT dlg_DRW.bReportIsRunning) OR (SalMessageBox("Прекратить выполнение отчёта?", "Вопрос", MB_YesNo) = IDYES)
.head 7 -  Set dlg_DRW.bCanWork = FALSE
.head 7 -  Call SalSendMsg( hWndForm, SAM_Close, 0, 0 )
.head 3 +  Pushbutton: pbHelp
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbHelp
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   11.783"
.head 5 -  Top:    0.738"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Message Actions
.head 3 -  Background Text: Запись:
.head 4 -  Resource Id: 1351
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   7.183"
.head 5 -  Top:    0.262"
.head 5 -  Width:  1.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfRecord
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   8.583"
.head 6 -  Top:    0.238"
.head 6 -  Width:  1.2"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfTotalRecords
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   10.383"
.head 6 -  Top:    0.238"
.head 6 -  Width:  1.2"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: из
.head 4 -  Resource Id: 1352
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   9.783"
.head 5 -  Top:    0.262"
.head 5 -  Width:  0.5"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Center
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 -  Window Variables
.head 2 -  Message Actions
