.head 0 +  Application Description: ! BARS005.APL - функции по Финансовому Мониторингу
! ООО Унити-Барс  (C)  2004
! Чупахина Н.А.
! ///////////////////////////////////////////////
.head 1 -  Outline Version - 4.0.26
.head 1 +  Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000CD0000 002C000000030000 00030000000E0300 000B000000F8FFFF
0040: FFE2FFFFFF200000 0015000000EA0200 00D7010000010000 0001000000010000
0060: 000F4170706C6963 6174696F6E497465 6D01000000075769 6E646F7773
.enddata
.data DT_MAKERUNDLG
0000: 0200000000001C51 3A5C424152533938 5C4C494252415259 5C4162736170692E
0020: 646C6C1C513A5C42 41525339385C4C49 42524152595C4162 736170692E617063
0040: 00000101011C513A 5C4241525339385C 4C4942524152595C 4162736170692E72
0060: 756E1C513A5C4241 525339385C4C4942 524152595C416273 6170692E646C6C1C
0080: 513A5C4241525339 385C4C4942524152 595C416273617069 2E61706300000101
00A0: 01175C4241525339 385C42494E5C6261 72733030352E6170 64165C4241525339
00C0: 385C42494E5C4162 736170692E646C6C 165C424152533938 5C42494E5C416273
00E0: 6170692E61706300 00010101001C513A 5C4241525339385C 4C4942524152595C
0100: 4162736170692E64 6C6C1C513A5C4241 525339385C4C4942 524152595C416273
0120: 6170692E61706300 00010101
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
0000: 0518B80BB80B2500
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
.head 2 -  Dynalib: Global.apd
.head 2 -  Dynalib: Absapi.apd
.head 2 -  Dynalib: docview.apd
.head 2 -  Dynalib: nsiapi.apd
.head 2 -  File Include: Gentbl.apl
.head 2 -  File Include: GENTBLD.APL
.head 2 -  File Include: GENLIST.APL
.head 2 -  File Include: Vttblwin.apl
.head 2 -  File Include: XSALCPT.APL
.head 2 -  Dynalib: custacnt.apd
.head 2 -  File Include: VTCOMM.APL
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
.head 4 -  Font Name: Arial Cyr
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: System Default
.head 4 -  Background Color: System Window Color
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
.head 4 -  Font Name: Arial Cyr
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: System Window Color
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
.head 3 -  Input: 99/99/99
.head 3 -  Number: ###00000
.head 3 -  Date/Time: dd/MM/yyyy
.head 3 -  Date/Time: dd/MM/yy
.head 3 -  Date/Time: dd
.head 3 -  Date/Time: dd-MM-yyyy
.head 3 -  Date/Time: ddMMyy
.head 3 -  Date/Time: dd/MM/yyyy hhhh:mm:ss
.head 2 +  External Functions
.head 2 +  Constants
.data CCDATA
0000: 3000000000000000 0000000000000000 00000000
.enddata
.data CCSIZE
0000: 1400
.enddata
.head 3 +  System
.head 3 +  User
.head 2 +  Resources
.head 3 +  Icon: icon_Folder1
.head 4 -  File Name: \Bars98\Resource\Ico\Folder.ico
.head 3 +  Icon: icon_Folder2
.head 4 -  File Name: \Bars98\Resource\Ico\Folderop.ico
.head 2 +  Variables
.head 3 -  Window Handle: hWin0
.head 3 -  Window Handle: hWin1
.head 3 -  Window Handle: hWin2
.head 3 -  Number: nFetchRes
.head 2 +  Internal Functions
.head 3 -  !
.head 3 +  Function: Ini005
.head 4 -  Description: Коструктор
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 -  Actions
.head 3 +  Function: Sel005                !__exported
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Window Handle: hWndParent
.head 5 -  Number: nMode
.head 5 -  Number: nPar
.head 5 -  String: strPar1
.head 5 -  String: strPar2
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  Select Case nMode
.head 6 -  ! Фин. Мониторинг
.head 6 +  Case 0
.head 7 +  If not IsWindow(hWin0)
.head 8 -  Call SalCreateWindow(Tbl_FMDoc, hWndParent, nPar, strPar1, strPar2)
.head 7 +  Else
.head 8 -  Call SalBringWindowToTop(hWin0)
.head 7 -  Break
.head 6 -  ! Курсы валют
.head 6 +  Case 1
.head 7 +  If not IsWindow(hWin1)
.head 8 -  Call SalCreateWindow(Tbl_CurRates, hWndParent, nPar, strPar1, strPar2)
.head 7 +  Else
.head 8 -  Call SalBringWindowToTop(hWin1)
.head 7 -  Break
.head 6 -  ! Фин. Мониторинг: импорт файла террористов
.head 6 +  Case 2
.head 7 -  ! Call SalModalDialog(dlg_ImportReft, hWndMDI)
.head 7 -  ! Break
.head 7 +  If not IsWindow(hWin0)
.head 8 -  Call SalCreateWindow(frm_ImportReft, hWndParent)
.head 7 +  Else
.head 8 -  Call SalBringWindowToTop(hWin0)
.head 7 -  Break
.head 6 +  Default
.head 7 -  Break
.head 2 +  Named Menus
.head 2 +  Class Definitions
.data RESOURCE 0 0 1 25218691
0000: 37010000A2000000 0000000000000000 0200000200FFFF01 00160000436C6173
0020: 73566172004F7574 6C696E6552006567 496E666F22003C00 000A630047656E46
0040: 696C746500727400 00000400001E0002 0400C10001000000 3F8001F800000037
0060: 040001F00D000000 FF1F110000DC0002 00FF7F1570000000 0100FFFF21018022
0080: 000001C200000B63 47F8444669B30004 00770200F601004F 800100FE008D0400
00A0: 010DFD00FF371100 02F700FFDF15DC00 0100FF7F
.enddata
.head 2 +  Default Classes
.head 3 -  MDI Window: cBaseMDI
.head 3 -  Form Window:
.head 3 -  Dialog Box:
.head 3 -  Table Window:
.head 3 -  Quest Window:
.head 3 -  Data Field:
.head 3 -  Spin Field:
.head 3 -  Multiline Field:
.head 3 -  Pushbutton: ctb_pbOk
.head 3 -  Radio Button: cRadioButtonLabeled
.head 3 -  Option Button:
.head 3 -  Check Box: cCheckBoxLabeled
.head 3 -  Child Table:
.head 3 -  Quest Child Window: cQuickDatabase
.head 3 -  List Box:
.head 3 -  Combo Box: cGenComboBox_NumId
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
.head 1 -  ! Формы ФМ
.head 1 +  Table Window: Tbl_FMDoc
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Перегляд і відбір до Фінансового Моніторингу документів
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Class Default
.head 2 -  Visible? Class Default
.head 2 -  Display Settings
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? Class Default
.head 3 -  Initial State: Class Default
.head 3 -  Maximizable? Class Default
.head 3 -  Minimizable? Class Default
.head 3 -  System Menu? Class Default
.head 3 -  Resizable? Class Default
.head 3 -  Window Location and Size
.head 4 -  Left:   1.1"
.head 4 -  Top:    0.917"
.head 4 -  Width:  13.0"
.head 4 -  Width Editable? Class Default
.head 4 -  Height: Class Default
.head 4 -  Height Editable? Class Default
.head 3 -  Font Name: Class Default
.head 3 -  Font Size: Class Default
.head 3 -  Font Enhancement: Class Default
.head 3 -  Text Color: Class Default
.head 3 -  Background Color: Class Default
.head 3 -  View: Class Default
.head 3 -  Allow Row Sizing? Class Default
.head 3 -  Lines Per Row: Class Default
.head 2 -  Memory Settings
.head 3 -  Maximum Rows in Memory: 30000
.head 3 -  Discardable? Class Default
.head 2 -  Description: Отбор документов в финансовый мониторинг
.head 2 -  Named Menus
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Class Default
.head 4 -  Location? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Size: 0.87"
.head 4 -  Size Editable? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Bold-Strikeout
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 3 +  Contents
.head 4 +  Pushbutton: pbIns
.head 5 -  Class Child Ref Key: 33
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbDel
.head 5 -  Class Child Ref Key: 34
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbRefresh
.head 5 -  Class Child Ref Key: 35
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbUpdate
.head 5 -  Class Child Ref Key: 36
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 58402
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  7.75"
.head 6 -  Begin Y:  0.0"
.head 6 -  End X:  7.75"
.head 6 -  End Y:  0.45"
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 -  Line
.head 5 -  Resource Id: 28214
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  6.7"
.head 6 -  Begin Y:  0.0"
.head 6 -  End X:  6.7"
.head 6 -  End Y:  0.45"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 +  Pushbutton: pbSearch
.head 5 -  Class Child Ref Key: 38
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbFilter
.head 5 -  Class Child Ref Key: 44
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 +  If bFM_DFLTR
.head 8 +  If SetQueryDFilterEx(cDF)
.head 9 -  Call SalPostMsg(hWndForm, UM_Populate, 0, 0)
.head 7 +  Else
.head 8 +  If SetQueryFilterEx(cF)
.head 9 -  Call SalPostMsg(hWndForm, UM_Populate, 0, 0)
.head 4 +  Pushbutton: pbDetails
.head 5 -  Class Child Ref Key: 39
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 40
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 58403
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  0.0"
.head 6 -  End X:  Class Default
.head 6 -  End Y:  0.45"
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 +  Pushbutton: pbExit
.head 5 -  Class Child Ref Key: 42
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   7.85"
.head 6 -  Top:    0.071"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 58404
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  0.0"
.head 6 -  End X:  Class Default
.head 6 -  End Y:  0.45"
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 -  !
.head 4 +  Pushbutton: pbNew	! Відправити
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbBrowse
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.0"
.head 6 -  Top:    0.071"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\DOC_OUT.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = "Відправити"
.head 6 +  On SAM_Click
.head 7 -  Set i = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, i, ROW_Selected, 0)
.head 8 -  Call SalTblSetContext(hWndForm, i)
.head 8 +  If hWndForm.Tbl_FMDoc.colStatusId != 'B' AND hWndForm.Tbl_FMDoc.colStatusId != 'D' AND 
  (hWndForm.Tbl_FMDoc.colVid2 != '' OR hWndForm.Tbl_FMDoc.colVid3 != '') AND bParNew
.head 9 -  ! If colAgentId = nUserId OR colAgentId = NUMBER_Null OR nPar1 = 1
.head 9 -  Set hWndForm.Tbl_FMDoc.colStatusId_New = 'N'
.head 9 -  Call hWndForm.Tbl_FMDoc.colStatus.SetSelectById(hWndForm.Tbl_FMDoc.colStatusId_New)
.head 9 -  Call SalTblSetRowFlags(hWndForm, i, ROW_Edited, TRUE)
.head 9 -  Call SalSendMsg(hWndForm, SAM_RowSetContext, 0, 0)
.head 4 +  Pushbutton: pbIn	! Внести (повідомити)
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbChilds
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.44"
.head 6 -  Top:    0.071"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\APPLY.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = "Внести (повідомити)"
.head 6 +  On SAM_Click
.head 7 +  If bParComm
.head 8 +  If not SalModalDialog(dlg_FMComments, hWndForm, sComments)
.head 9 -  Return TRUE
.head 7 -  Set i = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, i, ROW_Selected, 0)
.head 8 -  Call SalTblSetContext(hWndForm, i)
.head 8 -  ! если статус не D (Iмпортована)
     и (     можно редактировать параметры и параметры заполнены
        или нельзя редактировать параметры)
.head 8 +  If hWndForm.Tbl_FMDoc.colStatusId != 'D' AND 
  ((hWndForm.Tbl_FMDoc.colVid2 != '' OR hWndForm.Tbl_FMDoc.colVid3 != '') AND not bParNotFMPar OR bParNotFMPar)
.head 9 +  If (hWndForm.Tbl_FMDoc.colAgentId = nUserId OR hWndForm.Tbl_FMDoc.colAgentId = NUMBER_Null) AND bParIn
.head 10 +  If bParComm
.head 11 -  Set colComments = sComments
.head 10 -  Set hWndForm.Tbl_FMDoc.colStatusId_New = 'I'
.head 10 -  Call hWndForm.Tbl_FMDoc.colStatus.SetSelectById(hWndForm.Tbl_FMDoc.colStatusId_New)
.head 10 -  Call SalTblSetRowFlags(hWndForm, i, ROW_Edited, TRUE)
.head 10 -  Call SalSendMsg(hWndForm, SAM_RowSetContext, 0, 0)
.head 4 +  Pushbutton: pbBack	! Вилучити
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbChilds
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.88"
.head 6 -  Top:    0.071"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\APP1.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = "Вилучити"
.head 6 +  On SAM_Click
.head 7 -  Set i = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, i, ROW_Selected, 0)
.head 8 -  Call SalTblSetContext(hWndForm, i)
.head 8 +  If hWndForm.Tbl_FMDoc.colStatusId != 'B' AND hWndForm.Tbl_FMDoc.colStatusId != 'D'
.head 9 -  ! Если Разрешено pbBack и (Повідомив сам пользователь или пользователю разрешено Редакт. пар-ры любого usera)
.head 9 +  If bParBack AND (hWndForm.Tbl_FMDoc.colAgentId = nUserId OR bParEditPar)
.head 10 -  Set hWndForm.Tbl_FMDoc.colStatusId_New = 'B'
.head 10 -  Call hWndForm.Tbl_FMDoc.colStatus.SetSelectById(hWndForm.Tbl_FMDoc.colStatusId_New)
.head 10 -  Call SalTblSetRowFlags(hWndForm, i, ROW_Edited, TRUE)
.head 10 -  Call SalSendMsg(hWndForm, SAM_RowSetContext, 0, 0)
.head 4 +  Pushbutton: pbWait	! Відкласти
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbChilds
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   5.32"
.head 6 -  Top:    0.071"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\CLOCK-2.BMP
.head 5 -  Picture Transparent Color: Magenta
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = "Відкласти"
.head 6 +  On SAM_Click
.head 7 -  Set i = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, i, ROW_Selected, 0)
.head 8 -  Call SalTblSetContext(hWndForm, i)
.head 8 +  If hWndForm.Tbl_FMDoc.colStatusId != 'D'
.head 9 +  If (hWndForm.Tbl_FMDoc.colAgentId = nUserId OR hWndForm.Tbl_FMDoc.colAgentId = NUMBER_Null) AND bParWait
.head 10 -  Set hWndForm.Tbl_FMDoc.colStatusId_New = 'S'
.head 10 -  Call hWndForm.Tbl_FMDoc.colStatus.SetSelectById(hWndForm.Tbl_FMDoc.colStatusId_New)
.head 10 -  Call SalTblSetRowFlags(hWndForm, i, ROW_Edited, TRUE)
.head 10 -  Call SalSendMsg(hWndForm, SAM_RowSetContext, 0, 0)
.head 9 +  Else
.head 10 +  If bParWait AND bParEditPar
.head 11 -  Set hWndForm.Tbl_FMDoc.colStatusId_New = 'S'
.head 11 -  Call hWndForm.Tbl_FMDoc.colStatus.SetSelectById(hWndForm.Tbl_FMDoc.colStatusId_New)
.head 11 -  Call SalTblSetRowFlags(hWndForm, i, ROW_Edited, TRUE)
.head 11 -  Call SalSendMsg(hWndForm, SAM_RowSetContext, 0, 0)
.head 4 +  Pushbutton: pbFMPar	! Параметри
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbBrowse
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   5.76"
.head 6 -  Top:    0.071"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Параметри'
.head 6 +  On SAM_Click
.head 7 -  Set nRow = SalTblQueryContext(hWndForm)
.head 7 +  If (hWndForm.Tbl_FMDoc.colRef != NUMBER_Null or
    hWndForm.Tbl_FMDoc.colRec != NUMBER_Null) AND 
   SalTblQueryRowFlags(hWndForm, nRow, ROW_Edited) = FALSE
.head 8 +  If SalModalDialog(Dlg_FMPar, hWndMDI, 
IifN(nParEdit AND (
     hWndForm.Tbl_FMDoc.colStatusId =''  AND bParIn OR 
     hWndForm.Tbl_FMDoc.colStatusId!='B' AND 
     hWndForm.Tbl_FMDoc.colStatusId!='D' AND bParEditPar OR
     ( hWndForm.Tbl_FMDoc.colStatusId='N' OR 
       hWndForm.Tbl_FMDoc.colStatusId='T' OR
       hWndForm.Tbl_FMDoc.colStatusId='I' OR 
       hWndForm.Tbl_FMDoc.colStatusId='S' OR 
       hWndForm.Tbl_FMDoc.colStatusId='R') AND 
     ( hWndForm.Tbl_FMDoc.colAgentId=nUserId OR 
       hWndForm.Tbl_FMDoc.colAgentId=NUMBER_Null OR 
       bParEditPar) ), 1, 0), hWndForm.Tbl_FMDoc.colId, 
hWndForm.Tbl_FMDoc.colRef,  hWndForm.Tbl_FMDoc.colRec, 
hWndForm.Tbl_FMDoc.colMfoa, hWndForm.Tbl_FMDoc.colNlsa, hWndForm.Tbl_FMDoc.colNama,
hWndForm.Tbl_FMDoc.colMfob, hWndForm.Tbl_FMDoc.colNlsb, hWndForm.Tbl_FMDoc.colNamb,
hWndForm.Tbl_FMDoc.colDatD, hWndForm.Tbl_FMDoc.colS,
hWndForm.Tbl_FMDoc.colKv,   hWndForm.Tbl_FMDoc.colKv2, hWndForm.Tbl_FMDoc.colLcv, 
hWndForm.Tbl_FMDoc.colNazn, hWndForm.Tbl_FMDoc.colDig, 
hWndForm.Tbl_FMDoc.colVid1, hWndForm.Tbl_FMDoc.colVid2, hWndForm.Tbl_FMDoc.colComm2, 
hWndForm.Tbl_FMDoc.colVid3, hWndForm.Tbl_FMDoc.colComm3, 
hWndForm.Tbl_FMDoc.colMode, hWndForm.Tbl_FMDoc.colRnkA, hWndForm.Tbl_FMDoc.colRnkB,
hWndForm.Tbl_FMDoc.colOkpoA, hWndForm.Tbl_FMDoc.colOkpoB)
.head 9 -  Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
.head 4 +  Pushbutton: pbHistory	! Історія змін
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbChilds
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   6.2"
.head 6 -  Top:    0.071"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\BOOKS1.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Історія змін'
.head 6 +  On SAM_Click
.head 7 +  If colId != NUMBER_Null
.head 8 -  ! Call FunNSIEditFFiltered('FINMON_QUE_MODIFICATION',1,
' FINMON_QUE_MODIFICATION.REF=' || Str(colRef) ||
' ORDER BY FINMON_QUE_MODIFICATION.MOD_DATE')
.head 8 -  Call SalCreateWindow(Tbl_FMHistory, hWndMDI, hWndForm.Tbl_FMDoc.colId, 
  IifN(hWndForm.Tbl_FMDoc.colRef!=NUMBER_Null, hWndForm.Tbl_FMDoc.colRef, hWndForm.Tbl_FMDoc.colRec))
.head 4 +  Pushbutton: pbUnStop	! Розблокувати документ
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbBrowse
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   6.8"
.head 6 -  Top:    0.071"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\A_BKLD.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Розблокувати документ'
.head 6 +  On SAM_Click
.head 7 +  If colOtm > 0 or colBlk = 131313
.head 8 +  ! If colStatusId = 'N' OR colStatusId = 'T' OR colStatusId = 'D'
.head 9 -           Call SalMessageBox("Документ " || 
  IifS(hWndForm.Tbl_FMDoc.colRef!=NUMBER_Null, "REF", "REC") || 
  IifS(hWndForm.Tbl_FMDoc.colRef!=NUMBER_Null, Str(hWndForm.Tbl_FMDoc.colRef), Str(hWndForm.Tbl_FMDoc.colRec)) || 
  " не може бути розблоковано, " || PutCrLf() || 
  "бо він має статус " || IifS(colStatusId='N' OR colStatusId='T', "'До відправки'", "'Імпортована'") || ".", 
  "Увага!", MB_IconExclamation | MB_Ok)
.head 9 -           Return TRUE
.head 8 +  ! If colStatusId = 'D' AND 
   SalDateConstruct(SalDateYear(colAgentDat+2), SalDateMonth(colAgentDat+2), SalDateDay(colAgentDat+2), 0, 0, 0) > 
   SalDateConstruct(SalDateYear(SalDateCurrent()), SalDateMonth(SalDateCurrent()), SalDateDay(SalDateCurrent()), 0, 0, 0)
.head 9 -      Call SalMessageBox("Документ " || 
  IifS(hWndForm.Tbl_FMDoc.colRef!=NUMBER_Null, "REF", "REC") || 
  IifS(hWndForm.Tbl_FMDoc.colRef!=NUMBER_Null, Str(hWndForm.Tbl_FMDoc.colRef), Str(hWndForm.Tbl_FMDoc.colRec)) || 
  " не може бути розблоковано, " || PutCrLf() || 
  "бо не минув термін.", 
  "Увага!", MB_IconExclamation | MB_Ok)
.head 9 -      Return TRUE
.head 8 +  ! If colPDat + 2 < SalDateCurrent()
.head 9 -                   Call SalMessageBox("Документ " || Str(colRef) || " не може бути розблоковано, " || PutCrLf() || 
  "бо не минув термін.", 
  "Увага!", MB_IconExclamation | MB_Ok)
.head 9 -                   Return TRUE
.head 8 +  If IDYES = SalMessageBox("Розблокувати документ " || 
  IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, "REC", "REF") || 
  IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, Str(hWndForm.Tbl_FMDoc.colRec), Str(hWndForm.Tbl_FMDoc.colRef)) || " для оплати?", "Увага!", MB_IconQuestion | MB_YesNo)
.head 9 +  If not SqlPLSQLCommand(hSql(), "p_fm_unblock(hWndForm.Tbl_FMDoc.colRef, hWndForm.Tbl_FMDoc.colRec)")
.head 10 -  Call SqlRollbackEx(hSql(), "FM. Не удалось разблокировать документ " || 
     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, "REC", "REF") || 
     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, Str(hWndForm.Tbl_FMDoc.colRec), Str(hWndForm.Tbl_FMDoc.colRef)) || " для оплаты")
.head 9 +  Else
.head 10 -  Call SqlCommitEx(hSql(), "FM. Разблокирован для оплаты документ " || 
     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, "REC", "REF") || 
     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, Str(hWndForm.Tbl_FMDoc.colRec), Str(hWndForm.Tbl_FMDoc.colRef)) )
.head 10 -  Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
.head 9 +  ! If colOtm > 0
.head 10 +         If NOT SqlPrepareAndExecute(hSql(), "UPDATE fm_ref_que SET otm=0 WHERE ref=:colRef")
.head 11 -         Call SqlRollbackEx(hSql(), "FM. Не удалось разблокировать документ " || 
     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, "REC", "REF") || 
     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, Str(hWndForm.Tbl_FMDoc.colRec), Str(hWndForm.Tbl_FMDoc.colRef)) || " для оплаты")
.head 10 +         Else 
.head 11 -         Set nRow = SalTblQueryContext(hWndForm)
.head 11 -         Call XSalTblSetRowBackColor(hWndForm, nRow, COLOR_White)
.head 11 -         Set colOtm = 0
.head 11 -         Call SalDisableWindow(pbUnStop)
.head 11 -         Call SalDisableWindow(pbRefT)
.head 11 +         If nFM_GRP2
.head 12 +         If not  SqlPrepareAndExecute(hSql(), 
"insert into oper_visa (ref, dat, userid, groupid, status)
 values (:hWndForm.Tbl_FMDoc.colRef, sysdate, :nUserId, :nFM_GRP2, 2)")
.head 13 -         Call SqlRollback(hSql())
.head 11 -         Call SqlCommitEx(hSql(), "FM. Разблокирован для оплаты документ " || 
     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, "REC", "REF") || 
     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, Str(hWndForm.Tbl_FMDoc.colRec), Str(hWndForm.Tbl_FMDoc.colRef)) )
.head 9 +  ! Else If colBlk = 131313
.head 10 +         If NOT SqlPrepareAndExecute(hSql(), "UPDATE arc_rrp SET blk=0 WHERE rec=:colRec")
.head 11 -         Call SqlRollbackEx(hSql(), "FM. Не удалось разблокировать документ " || 
     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, "REC", "REF") || 
     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, Str(hWndForm.Tbl_FMDoc.colRec), Str(hWndForm.Tbl_FMDoc.colRef)) || " для оплаты")
.head 10 +         Else 
.head 11 -  ! Set nRow = SalTblQueryContext(hWndForm)
.head 11 -  ! Call XSalTblSetRowBackColor(hWndForm, nRow, COLOR_White)
.head 11 -  ! Set colOtm = NUMBER_Null
.head 11 -  ! Call SalDisableWindow(pbUnStop)
.head 11 -         Call SqlCommitEx(hSql(), "FM. Разблокирован для оплаты документ " || 
     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, "REC", "REF") || 
     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, Str(hWndForm.Tbl_FMDoc.colRec), Str(hWndForm.Tbl_FMDoc.colRef)) )
.head 11 -         Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
.head 4 +  Pushbutton: pbRefT	! Перегляд даних з переліку осіб, підозрюваних у тероризмі
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbChilds
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   7.24"
.head 6 -  Top:    0.071"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\USER.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Перегляд даних з переліку осіб, підозрюваних у тероризмі'
.head 6 +  On SAM_Click
.head 7 -  Call FunNSIEditFFiltered("V_FINMON_REFT", 1, "c1="||Str(hWndForm.Tbl_FMDoc.colOtm))
.head 4 -  Line
.head 5 -  Resource Id: 37590
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  8.4"
.head 6 -  Begin Y:  0.0"
.head 6 -  End X:  8.4"
.head 6 -  End Y:  0.45"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 -  Background Text: Документів всього:
.head 5 -  Resource Id: 48604
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Window Location and Size
.head 6 -  Left:   8.5"
.head 6 -  Top:    0.131"
.head 6 -  Width:  2.5"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.2"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Justify: Right
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Dark Blue
.head 5 -  Background Color: Default
.head 4 +  Data Field: dfDocCount
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Editable? No
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   11.1"
.head 7 -  Top:    0.095"
.head 7 -  Width:  1.2"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.25"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? Yes
.head 6 -  Justify: Left
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Bold
.head 6 -  Text Color: Dark Blue
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 -  !
.head 4 -  Line
.head 5 -  Resource Id: 43701
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  0.0"
.head 6 -  Begin Y:  0.45"
.head 6 -  End X:  50.0"
.head 6 -  End Y:  0.45"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: Default
.head 4 +  Pushbutton: pbShowRules
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbOk
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.086"
.head 6 -  Top:    0.5"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \bars98\RESOURCE\BMP\LOOK.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Довідник правил'
.head 6 +  On SAM_Click
.head 7 +  If colRules
.head 8 -  Call FunNSIEditFFiltered('FM_RULES', 1, 'id in (' || colRules || ')')
.head 4 +  Pushbutton: pbFMFilter
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbFilter
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.514"
.head 6 -  Top:    0.5"
.head 6 -  Width:  0.4"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Фільтр по правилам ФМ'
.head 6 +  On SAM_Click
.head 7 +  If GetFMFilter()
.head 8 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 4 -  Background Text: Дата валютування
.head 5 -  Resource Id: 43700
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.2"
.head 6 -  Top:    0.6"
.head 6 -  Width:  2.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Justify: Right
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Dark Blue
.head 5 -  Background Color: Default
.head 4 +  Data Field: bgVDat
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cLabelControl
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Editable? Class Default
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   Default
.head 7 -  Top:    Default
.head 7 -  Width:  Class Default
.head 7 -  Width Editable? Class Default
.head 7 -  Height: Class Default
.head 7 -  Height Editable? Class Default
.head 6 -  Visible? Class Default
.head 6 -  Border? Class Default
.head 6 -  Justify: Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Font Name: Class Default
.head 6 -  Font Size: Class Default
.head 6 -  Font Enhancement: Class Default
.head 6 -  Text Color: Class Default
.head 6 -  Background Color: Class Default
.head 6 -  Input Mask: Class Default
.head 5 -  Message Actions
.head 4 +  Data Field: dfVDat1
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Editable? No
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   3.25"
.head 7 -  Top:    0.55"
.head 7 -  Width:  1.4"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.25"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? Yes
.head 6 -  Justify: Center
.head 6 -  Format: Date
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Bold
.head 6 -  Text Color: Dark Blue
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 -  Background Text: -
.head 5 -  Resource Id: 40346
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.65"
.head 6 -  Top:    0.595"
.head 6 -  Width:  0.2"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Justify: Center
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 4 +  Data Field: dfVDat2
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Editable? No
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   4.9"
.head 7 -  Top:    0.55"
.head 7 -  Width:  1.4"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.25"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? Yes
.head 6 -  Justify: Center
.head 6 -  Format: Date
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Bold
.head 6 -  Text Color: Dark Blue
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 +  Data Field: dfRuleName
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Editable? No
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   6.5"
.head 7 -  Top:    0.595"
.head 7 -  Width:  20.0"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.25"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? No
.head 6 -  Justify: Left
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Bold
.head 6 -  Text Color: Dark Blue
.head 6 -  Background Color: 3D Face Color
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 2 +  Contents
.head 3 +  Column: colRules
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Правила
ФМ
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 100
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.0"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colId
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colRef
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Референс
документа
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.4"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colRec
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: REC
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colStatusId
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colStatusId_New
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colStatus
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenColComboBox_StrId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Статус
документа
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call colStatus.Init(hWndItem)
.head 6 -  Call colStatus.Populate(hSql(), "STATUS", "NAME", "FINMON_QUE_STATUS", "")
.head 3 +  Column: colTT
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
ОП
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: String
.head 4 -  Justify: Center
.head 4 -  Width:  0.6"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colNd
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Номер
документа
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: String
.head 4 -  Justify: Class Default
.head 4 -  Width:  1.4"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colDatD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
документа
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.2"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: dd/MM/yyyy
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colSEqv
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сума док.
(екв.)
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.6"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Decimal
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colNlsa
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Рахунок А
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: String
.head 4 -  Justify: Class Default
.head 4 -  Width:  1.4"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colNama
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
Счета А
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: String
.head 4 -  Justify: Class Default
.head 4 -  Width:  1.4"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colSs
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сума А
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: String
.head 4 -  Justify: Right
.head 4 -  Width:  1.4"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colKv
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colLcv
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вал А
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: String
.head 4 -  Justify: Center
.head 4 -  Width:  0.6"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colMfoa
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: МФО А
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: String
.head 4 -  Justify: Class Default
.head 4 -  Width:  1.0"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colNlsb
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Рахунок В
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: String
.head 4 -  Justify: Class Default
.head 4 -  Width:  1.4"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colNamb
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
Счета В
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: String
.head 4 -  Justify: Class Default
.head 4 -  Width:  1.4"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colS2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colS2s
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сума В
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: String
.head 4 -  Justify: Right
.head 4 -  Width:  1.4"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colKv2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colLcv2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вал В
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: String
.head 4 -  Justify: Center
.head 4 -  Width:  0.6"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colMfob
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: МФО В
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: String
.head 4 -  Justify: Class Default
.head 4 -  Width:  1.0"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colSK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: СКП
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Center
.head 4 -  Width:  0.6"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colVDat
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
валютування
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.2"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Date
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colNazn
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Призначення платежу
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: String
.head 4 -  Justify: Class Default
.head 4 -  Width:  3.0"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colBranch
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Відділення
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  2.0"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colDig
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colDig2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colVid1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Vid1
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colVid2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ознака
обов'язк.
моніторінгу
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colComm2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Comm2
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colVid3
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ознака
внутр..
моніторінгу
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colComm3
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Comm3
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colMode
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Mode
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colAgentId
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: AgentId
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Class Default
.head 4 -  Width:  2.0"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colAgentFIO
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Повідомив
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  2.0"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colAgentDat
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
реєстрації
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.6"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: DateTime
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colComments
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Коментар
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 254
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colRnkA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: RnkA
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colRnkB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: RnkB
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colSOS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  Default
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colDocCount
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  Default
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 -  ! colOtm - признак блокировки документа по ФМ
.head 3 +  Column: colOtm
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: № особи 
в переліку осіб
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colPDat
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Date
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colOkpoA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colOkpoB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 -  ! colBlk - код юлокировки в arc_rrp
.head 3 +  Column: colBlk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colNmka
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Клієнт А
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  2.0"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colNmkb
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Клієнт Б
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  2.0"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 2 +  Functions
.head 3 +  Function: GetFMFilter
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Set dDat1 = dfVDat1
.head 5 -  Set dDat2 = dfVDat2
.head 5 +  If not SalModalDialog(dlg_FMFilter, hWndForm, dDat1, dDat2, sFMRulesList, nFMRulesApply)
.head 6 -  Set sFMRulesList = STRING_Null
.head 6 -  Return FALSE
.head 5 -  Set dfVDat1 = dDat1
.head 5 -  Set dfVDat2 = dDat2
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 +  If not SqlPLSQLCommand(hSql(), "p_fm_checkrules(dfVDat1,dfVDat2,sFMRulesList)")
.head 6 -  Call SqlRollback(hSql())
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 -  Call SqlCommit(hSql())
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  Return TRUE
.head 2 +  Window Parameters
.head 3 -  Number: nParEdit ! 0 - ReadOnly, 1 - Edit
.head 3 -  String: sParShow
.head 3 -  ! sParShow:
  N-Show pbNew  - Відправити
  I-Show pbIn   - Внести (Повідомити)
  B-Show pbBack - Вилучити
  W-Show pbWait - Відкласти
  5-Not Show pbFMPar
  6-Not Show pbHistory
  7-редактировать пар-ры любого юзера, иначе-только свои "отказать", "отложить", править пар-ры
  O-операционист, спрятать колонку "Статус"
  C-по кнопке "Внести (повідомити)" необходимо заполнить комментарий
.head 3 -  String: sFilter
.head 2 +  Window Variables
.head 3 -  : cDF
.head 4 -  Class: cGenDFilterEx
.head 3 -  : cF
.head 4 -  Class: cGenFilterEx
.head 3 -  Number: nUserId
.head 3 -  Date/Time: dBDat
.head 3 -  Date/Time: dDat1
.head 3 -  Date/Time: dDat2
.head 3 -  Number: nFM_GRP2
.head 3 -  Boolean: bFM_DFLTR
.head 3 -  Boolean: bFM_HRULES
.head 3 -  Number: nIndex
.head 3 -  Number: nMaxDig
.head 3 -  Number: nRow
.head 3 -  Number: nOrderBy
.head 3 -  Window Handle: hColumn
.head 3 -  Number: i
.head 3 -  Number: nRulesCount
.head 3 -  String: sComments
.head 3 -  Boolean: bParNew
.head 3 -  Boolean: bParIn
.head 3 -  Boolean: bParBack
.head 3 -  Boolean: bParWait
.head 3 -  Boolean: bParNotFMPar
.head 3 -  Boolean: bParNotHistory
.head 3 -  Boolean: bParEditPar
.head 3 -  Boolean: bParOper
.head 3 -  Boolean: bParComm
.head 3 -  Boolean: bParUnBlock
.head 3 -  Boolean: bParRefT
.head 3 -  String: sStrSelect
.head 3 -  String: sStrInto
.head 3 -  String: sStrFrom
.head 3 -  String: sStrFilter
.head 3 -  String: sStrFilterVdat
.head 3 -  String: sFMRulesFilter
.head 3 -  String: sFMRulesList
.head 3 -  Number: nFMRulesApply[*]
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  !
.head 4 -  Set dBDat      = GetBankDate()
.head 4 -  Set nUserId    = GetUserId()
.head 4 -  Set nFM_GRP2   = GetGlobalOptionEx('FM_GRP2')
.head 4 -  Set bFM_DFLTR  = GetGlobalOptionEx('FM_DFLTR')=1
.head 4 -  Set bFM_HRULES = GetGlobalOptionEx('FM_HRULES') = 1
.head 4 -  Set nOrderBy = 1
.head 4 -  Set bParNew        = IifN(SalStrScan(sParShow,'N')=-1,0,1) ! Разрешить pbNew
.head 4 -  Set bParIn         = IifN(SalStrScan(sParShow,'I')=-1,0,1) ! Разрешить pbIn
.head 4 -  Set bParBack       = IifN(SalStrScan(sParShow,'B')=-1,0,1) ! Разрешить pbBack
.head 4 -  Set bParWait       = IifN(SalStrScan(sParShow,'S')=-1,0,1) ! Разрешить pbWait
.head 4 -  Set bParNotFMPar   = IifN(SalStrScan(sParShow,'5')=-1,0,1) ! Запретить pbFMPar
.head 4 -  Set bParNotHistory = IifN(SalStrScan(sParShow,'6')=-1,0,1) ! Запретить pbHistory
.head 4 -  Set bParEditPar    = IifN(SalStrScan(sParShow,'7')=-1,0,1) ! 1-Редакт. пар-ры любого usera, 0(7 нет)-только свои
.head 4 -  Set bParOper       = IifN(SalStrScan(sParShow,'O')=-1,0,1) ! операционист, спрятать колонку "Статус"
.head 4 -  Set bParComm       = IifN(SalStrScan(sParShow,'C')=-1,0,1) ! по кнопке "Внести (повідомити)" необходимо заполнить комментарий
.head 4 -  Set bParUnBlock    = IifN(SalStrScan(sParShow,'U')=-1,0,1) ! Разрешить разблокировать документ
.head 4 -  Set bParRefT       = IifN(SalStrScan(sParShow,'T')=-1,0,1) ! Разрешить смотреть инф. по террористу
.head 4 -  Call SalDisableWindow(pbUnStop)
.head 4 -  Call SalDisableWindow(pbRefT)
.head 4 +  If not nParEdit
.head 5 -  Call SalDisableWindow(pbNew)
.head 5 -  Call SalDisableWindow(pbIn)
.head 5 -  Call SalDisableWindow(pbBack)
.head 5 -  Call SalDisableWindow(pbWait)
.head 4 +  Else
.head 5 +  If not bParNew
.head 6 -  Call SalDisableWindow(pbNew)
.head 5 +  If not bParIn
.head 6 -  Call SalDisableWindow(pbIn)
.head 5 +  If not bParBack
.head 6 -  Call SalDisableWindow(pbBack)
.head 5 +  If not bParWait
.head 6 -  Call SalDisableWindow(pbWait)
.head 4 +  If bParNotFMPar
.head 5 -  Call SalDisableWindow(pbFMPar)
.head 4 +  If bParNotHistory
.head 5 -  Call SalDisableWindow(pbHistory)
.head 4 +  If bParOper
.head 5 -  Call SalHideWindow(colStatus)
.head 5 -  Call SalHideWindow(colOtm)
.head 5 -  Call SalDisableWindow(pbUnStop)
.head 5 -  Call SalDisableWindow(pbRefT)
.head 4 +  Else
.head 5 +  If GetGlobalOption('BANKTYPE') = 'SBER'
.head 6 -  Call SalShowWindow(colVid2)
.head 6 -  Call SalShowWindow(colVid3)
.head 4 +  If not bParUnBlock
.head 5 -  Call SalDisableWindow(pbUnStop)
.head 4 +  If not bParRefT
.head 5 -  Call SalDisableWindow(pbRefT)
.head 5 -  Call SalHideWindow(colOtm)
.head 4 -  !
.head 4 -  Call SqlPrepareAndExecute(hSql(), "select dat_next_u(:dBDat,-1) into :dfVDat1 from dual")
.head 4 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 4 -  Set dfVDat2 = dfVDat1
.head 4 -  !
.head 4 -  Set nRulesCount = 0
.head 4 -  Set sFMRulesList = ""
.head 4 -  Set sFMRulesFilter = ""
.head 4 -  Call SqlPrepareAndExecute(hSql(), "select id into :i from fm_rules")
.head 4 +  While SqlFetchNext(hSql(), nFetchRes)
.head 5 -  Set nFMRulesApply[i] = 0
.head 5 -  Set nRulesCount = nRulesCount + 1
.head 4 +  If not nRulesCount
.head 5 -  Call SalHideWindow(colRules)
.head 5 -  Call SalHideWindow(pbShowRules)
.head 5 -  Call SalHideWindow(pbFMFilter)
.head 5 -  Call SalHideWindowAndLabel(bgVDat)
.head 5 -  Call SalHideWindow(dfVDat1)
.head 5 -  Call SalHideWindow(dfVDat2)
.head 4 -  !
.head 4 -  Set hWndForm.Tbl_FMDoc.nTabInstance = 1
.head 4 -  Set hWndForm.Tbl_FMDoc.nFlags = GT_NoDel | GT_NoIns
.head 4 -  Set hWndForm.Tbl_FMDoc.fFilterAtStart = TRUE
.head 4 -  Set hWndForm.Tbl_FMDoc.strFilterTblName = 'V_FINMON_QUE'
.head 4 -  Set hWndForm.Tbl_FMDoc.strPrintFileName = 'FM_DOC'
.head 4 -  Set sStrSelect =
"SELECT v_finmon_que.id, v_finmon_que.ref, v_finmon_que.rec, v_finmon_que.tt, v_finmon_que.nd, v_finmon_que.datd, v_finmon_que.pdat, 
        v_finmon_que.nlsa, v_finmon_que.s,  v_finmon_que.kv,  v_finmon_que.lcv,  v_finmon_que.mfoa, v_finmon_que.nam_a, 
        v_finmon_que.nlsb, v_finmon_que.s2, v_finmon_que.kv2, v_finmon_que.lcv2, v_finmon_que.mfob, v_finmon_que.nam_b, 
        v_finmon_que.sk, v_finmon_que.vdat, v_finmon_que.nazn,
        v_finmon_que.tobo, v_finmon_que.sos, v_finmon_que.id_a, v_finmon_que.id_b, 
        v_finmon_que.dig, v_finmon_que.dig2, v_finmon_que.status, 
        v_finmon_que.opr_vid1, v_finmon_que.opr_vid2, v_finmon_que.comm_vid2, 
        v_finmon_que.opr_vid3, v_finmon_que.comm_vid3, v_finmon_que.monitor_mode, 
        v_finmon_que.agent_id, v_finmon_que.fio, v_finmon_que.in_date, v_finmon_que.rnk_a, v_finmon_que.rnk_b, 
        v_finmon_que.blk, v_finmon_que.otm, v_finmon_que.comments,
        gl.p_icurval(nvl(v_finmon_que.kv,980), nvl(v_finmon_que.s,0), v_finmon_que.vdat)/100,
        v_finmon_que.nmka, v_finmon_que.nmkb, 1"
.head 4 -  Set sStrInto =
"  INTO :hWndForm.Tbl_FMDoc.colId,   :hWndForm.Tbl_FMDoc.colRef,  :hWndForm.Tbl_FMDoc.colRec,:hWndForm.Tbl_FMDoc.colTT, :hWndForm.Tbl_FMDoc.colNd,  
        :hWndForm.Tbl_FMDoc.colDatD, :hWndForm.Tbl_FMDoc.colPDat, 
        :hWndForm.Tbl_FMDoc.colNlsa, :hWndForm.Tbl_FMDoc.colS,  :hWndForm.Tbl_FMDoc.colKv,  :hWndForm.Tbl_FMDoc.colLcv,  :hWndForm.Tbl_FMDoc.colMfoa, :hWndForm.Tbl_FMDoc.colNama,
        :hWndForm.Tbl_FMDoc.colNlsb, :hWndForm.Tbl_FMDoc.colS2, :hWndForm.Tbl_FMDoc.colKv2, :hWndForm.Tbl_FMDoc.colLcv2, :hWndForm.Tbl_FMDoc.colMfob, :hWndForm.Tbl_FMDoc.colNamb,
        :hWndForm.Tbl_FMDoc.colSK,   :hWndForm.Tbl_FMDoc.colVDat, :hWndForm.Tbl_FMDoc.colNazn,
        :hWndForm.Tbl_FMDoc.colBranch, :hWndForm.Tbl_FMDoc.colSOS, 
        :hWndForm.Tbl_FMDoc.colOkpoA, :hWndForm.Tbl_FMDoc.colOkpoB, 
        :hWndForm.Tbl_FMDoc.colDig,  :hWndForm.Tbl_FMDoc.colDig2, :hWndForm.Tbl_FMDoc.colStatusId, 
        :hWndForm.Tbl_FMDoc.colVid1, :hWndForm.Tbl_FMDoc.colVid2, :hWndForm.Tbl_FMDoc.colComm2, 
        :hWndForm.Tbl_FMDoc.colVid3, :hWndForm.Tbl_FMDoc.colComm3, :hWndForm.Tbl_FMDoc.colMode, 
        :hWndForm.Tbl_FMDoc.colAgentId, :hWndForm.Tbl_FMDoc.colAgentFIO, :hWndForm.Tbl_FMDoc.colAgentDat, 
        :hWndForm.Tbl_FMDoc.colRnkA, :hWndForm.Tbl_FMDoc.colRnkB, 
        :hWndForm.Tbl_FMDoc.colBlk,  :hWndForm.Tbl_FMDoc.colOtm,  :hWndForm.Tbl_FMDoc.colComments,
        :hWndForm.Tbl_FMDoc.colSEqv, :hWndForm.Tbl_FMDoc.colNmka, :hWndForm.Tbl_FMDoc.colNmkb, :hWndForm.Tbl_FMDoc.colDocCount"
.head 4 -  Set sStrFrom =
"  FROM v_finmon_que "
.head 4 -  Set nMaxDig = DigInit()
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 4 +  If bFM_DFLTR
.head 5 -  Call cDF.Init(strFilterTblName, strFilterTblName)
.head 4 +  Else
.head 5 -  Call cF.Init(strFilterTblName, strFilterTblName)
.head 3 +  On SAM_CreateComplete
.head 4 +  If nRulesCount
.head 5 +  If not bFM_HRULES
.head 6 -  Call GetFMFilter()
.head 4 +  Else
.head 5 +  If bFM_DFLTR
.head 6 -  Call hWndForm.Tbl_FMDoc.cDF.cNewFilter.NewString('', -1, 'PDAT', -1, 'v_finmon_que', '=', SalFmtFormatDateTime(SalDateCurrent(), 'dd/MM/yyyy'), 'Документы введенные сегодня ')
.head 5 +  Else
.head 6 -  Call hWndForm.Tbl_FMDoc.cF.NewString('', -1, 'PDAT', -1, 'v_finmon_que', '=', SalFmtFormatDateTime(SalDateCurrent(), 'dd/MM/yyyy'), 'Документы введенные сегодня ')
.head 4 -  Call SalSendClassMessage(SAM_CreateComplete, 0, 0)
.head 3 +  On UM_Populate
.head 4 +  If fFilterAtStart
.head 5 +  If bFM_DFLTR
.head 6 +  If SetQueryDFilterEx(cDF)
.head 7 -  Set fFilterAtStart = NOT fFilterAtStart
.head 5 +  Else
.head 6 +  If SetQueryFilterEx(cF)
.head 7 -  Set fFilterAtStart = NOT fFilterAtStart
.head 4 +  If NOT fFilterAtStart
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 -  Call SalTblDefineSplitWindow(hWndForm, 0, FALSE)
.head 5 -  ! sStrFilterVdat - Фильтр на даты ФМ
.head 5 -  Set sStrFilterVdat = IifS(nRulesCount=0, "", IifS(dfVDat1=dfVDat2, 
    "v_finmon_que.vdat = :dfVDat1", 
    "v_finmon_que.vdat between :dfVDat1 and :dfVDat2") )
.head 5 -  ! sFMRulesFilter - Фильр на правила ФМ
.head 5 +  If sFMRulesList
.head 6 -  Call SalShowWindow(colRules)
.head 6 -  Set strDSql = sStrSelect || ", r.rules" ||
    sStrInto || ", :hWndForm.Tbl_FMDoc.colRules" ||
    sStrFrom || ", tmp_fm_checkrules r"
.head 6 -  Set sFMRulesFilter = "v_finmon_que.ref = r.ref and r.id = user_id"
.head 6 -  ! если правило одно, показываемего наименование
.head 6 +  If SalStrScan(sFMRulesList, ',') = -1
.head 7 -  Call SqlPrepareAndExecute(hSql(), "select name into :dfRuleName from fm_rules where id = :sFMRulesList")
.head 7 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 6 +  Else
.head 7 -  Set dfRuleName = ''
.head 5 +  Else
.head 6 -  Call SalHideWindow(colRules)
.head 6 -  Set strDSql = sStrSelect || sStrInto || sStrFrom
.head 6 -  Set sFMRulesFilter = ""
.head 6 -  Set dfRuleName = ''
.head 5 -  ! sStrFilter - Фильтр на таблицу
.head 5 +  If bFM_DFLTR
.head 6 -  Set sStrFilter = cDF.GetFilterWhereClause(FALSE)
.head 5 +  Else
.head 6 -  Set sStrFilter = cF.GetFilterWhereClause(FALSE)
.head 5 -  Set sStrFilter = IifS(sStrFilter='', "", "(" || sStrFilter || ")")  
.head 5 -  ! Формируем весь фильтр
.head 5 -  ! sFilter - фильтр из ком.строки вызова
.head 5 -  Set sStrFilter = sStrFilter || IifS(sStrFilter='', "", IifS(sFilter='', "", " and ")) || IifS(sFilter='', "", "(" || sFilter || ")")  
.head 5 -  Set sStrFilter = sStrFilter || IifS(sStrFilter='', "", IifS(sStrFilterVdat='', "", " and ")) || sStrFilterVdat
.head 5 -  Set sStrFilter = sStrFilter || IifS(sStrFilter='', "", IifS(sFMRulesFilter='', "", " and ")) || sFMRulesFilter
.head 5 -  !
.head 5 -  Set strDSql = strDSql ||
    IifS(sStrFilter='', "", " where " || sStrFilter) ||
    " ORDER BY v_finmon_que.ref, v_finmon_que.rec"
.head 5 -  Call SaveInfoToLog(strDSql)
.head 5 -  Call BindList.ActivateBinds()
.head 5 -  Call SalTblPopulate(hWndForm, hSql(), strDSql, TBL_FillAll)
.head 5 -  Call VisTblAutoSizeColumn(hWndForm, hWndNULL)
.head 5 -  Set dfDocCount = SalTblColumnSum(hWndForm, SalTblQueryColumnID(colDocCount), 0, 0)
.head 5 -  Call SalTblSetContext(hWndForm, 0)
.head 5 -  Call SalSendMsg(hWndForm, SAM_RowSetContext, 0, 0)
.head 5 -  Call SalWaitCursor(FALSE)
.head 4 +  Else
.head 5 -  Call SalDestroyWindow( hWndForm )
.head 3 +  On UM_Update
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Call SaveInfoToLog(MSG_SaveDataRef() || ' ' || strTitleAux)
.head 4 -  Set nRow = TBL_MinRow
.head 4 +  While SalTblFindNextRow(hWndForm, nRow, ROW_Edited, 0)
.head 5 -  Call SalTblSetContext(hWndForm, nRow)
.head 5 -  Set strSqlUpdate =
"p_fm_set_status(hWndForm.Tbl_FMDoc.colRef, hWndForm.Tbl_FMDoc.colRec, 
 hWndForm.Tbl_FMDoc.colStatusId_New, hWndForm.Tbl_FMDoc.colComments, hWndForm.Tbl_FMDoc.colBlk)"
.head 5 +  If SqlPLSQLCommand(hSql(), strSqlUpdate)
.head 6 -  Call SqlCommitEx(hSql(), "FM. Установлен статус '" || hWndForm.Tbl_FMDoc.colStatusId_New || "' для документа " || 
     IifS(hWndForm.Tbl_FMDoc.colRef!=NUMBER_Null, "REF", "REC") || 
     IifS(hWndForm.Tbl_FMDoc.colRef!=NUMBER_Null, Str(hWndForm.Tbl_FMDoc.colRef), Str(hWndForm.Tbl_FMDoc.colRec)) )
.head 5 +  Else
.head 6 -  Call SqlRollbackEx(hSql(), "FM. Не удалось изменить статус документа " || 
     IifS(hWndForm.Tbl_FMDoc.colRef!=NUMBER_Null, "REF", "REC") || 
     IifS(hWndForm.Tbl_FMDoc.colRef!=NUMBER_Null, Str(hWndForm.Tbl_FMDoc.colRef), Str(hWndForm.Tbl_FMDoc.colRec)) )
.head 4 -  Call SalPostMsg(hWndForm, UM_Populate, 0, 0)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_FetchRowDone
.head 4 -  ! Раскрасить таблицу по SOS
.head 4 +  If colRef
.head 5 +  Select Case colSOS
.head 6 -  Case DOC_PAY_BACK
.head 6 +  Case DOC_PAY_STORNO
.head 7 -  Call VisTblSetRowColor(hWndForm, lParam, COLOR_Red)
.head 7 -  Break
.head 6 +  Case DOC_PAY_BOOKED
.head 7 -  Call VisTblSetRowColor(hWndForm, lParam, COLOR_DarkGreen)
.head 7 -  Break
.head 6 +  Case DOC_PAY_FEATURE
.head 7 -  Call VisTblSetRowColor(hWndForm, lParam, COLOR_Blue)
.head 7 -  Break
.head 6 +  Default
.head 7 -  Break
.head 4 -  ! Раскрасить колонку статуса 
.head 4 +  If colStatusId != ''
.head 5 -  Call colStatus.SetSelectById(colStatusId)
.head 4 +  If colStatusId = 'N' OR  colStatusId = 'T'
.head 5 -  Call SalTblSetCellTextColor(hWndForm.Tbl_FMDoc.colStatus, COLOR_DarkGreen, FALSE)
.head 4 +  Else If colStatusId = 'I'
.head 5 -  Call SalTblSetCellTextColor(hWndForm.Tbl_FMDoc.colStatus, COLOR_Blue, FALSE)
.head 4 +  Else If colStatusId = 'S'
.head 5 -  Call SalTblSetCellTextColor(hWndForm.Tbl_FMDoc.colStatus, COLOR_DarkBlue, FALSE)
.head 4 +  Else If colStatusId = 'R'
.head 5 -  Call SalTblSetCellTextColor(hWndForm.Tbl_FMDoc.colStatus, COLOR_DarkRed, FALSE)
.head 4 +  Else If colStatusId = 'B' OR colStatusId = 'D'
.head 5 -  Call SalTblSetCellTextColor(hWndForm.Tbl_FMDoc.colStatus, COLOR_DarkGray, FALSE)
.head 4 +  If colOtm > 0 or colBlk = 131313 or colBlk = 131312
.head 5 -  Call XSalTblSetRowBackColor(hWndForm, lParam, SalColorFromRGB(255,200,200))
.head 4 -  Set colSs  = Dig4(colS/100,  colDig,  4)
.head 4 -  Set colS2s = Dig4(colS2/100, colDig2, 4)
.head 3 +  On SAM_RowSetContext
.head 4 +  If nParEdit
.head 5 +  If bParNew
.head 6 -  Call SalEnableWindow(pbNew)
.head 5 +  If bParIn
.head 6 -  Call SalEnableWindow(pbIn)
.head 5 +  If bParBack
.head 6 -  Call SalEnableWindow(pbBack)
.head 5 +  If bParWait
.head 6 -  Call SalEnableWindow(pbWait)
.head 5 -  !
.head 5 +  ! If colStatusId = 'B' OR colStatusId = 'D'
.head 6 -         Call SalDisableWindow(pbNew)
.head 6 -         Call SalDisableWindow(pbIn)
.head 6 -         Call SalDisableWindow(pbBack)
.head 6 -         Call SalDisableWindow(pbWait)
.head 5 +  If colStatusId = ''
.head 6 -  Call SalDisableWindow(pbBack)
.head 5 +  Else If colStatusId = 'B'
.head 6 -  Call SalDisableWindow(pbBack)
.head 5 +  Else If colStatusId = 'D'
.head 6 -  Call SalDisableWindow(pbNew)
.head 6 -  Call SalDisableWindow(pbIn)
.head 6 -  Call SalDisableWindow(pbBack)
.head 6 -  Call SalDisableWindow(pbWait)
.head 5 +  Else If colStatusId = 'I'
.head 6 -  Call SalDisableWindow(pbIn)
.head 5 +  Else If colStatusId = 'S'
.head 6 -  Call SalDisableWindow(pbWait)
.head 5 +  Else If colStatusId = 'N' OR colStatusId = 'T'
.head 6 -  Call SalDisableWindow(pbNew)
.head 6 -  Call SalDisableWindow(pbIn)
.head 6 -  Call SalDisableWindow(pbBack)
.head 6 -  Call SalDisableWindow(pbWait)
.head 5 -  !
.head 5 +  If colVid2 = '' AND colVid3 = '' AND NOT bParNotFMPar
.head 6 -  Call SalDisableWindow(pbNew)
.head 6 -  Call SalDisableWindow(pbIn)
.head 5 -  !
.head 5 -  If colAgentId = nUserId OR colAgentId = NUMBER_Null
.head 5 +  Else If NOT bParEditPar
.head 6 -  Call SalDisableWindow(pbIn)
.head 6 -  Call SalDisableWindow(pbBack)
.head 6 -  Call SalDisableWindow(pbWait)
.head 5 -  !
.head 5 +  If not bParOper
.head 6 +  If colOtm > 0 or colBlk = 131313
.head 7 -  Call SalEnableWindow(pbUnStop)
.head 7 +  If colOtm > 0
.head 8 -  Call SalEnableWindow(pbRefT)
.head 6 +  Else
.head 7 -  Call SalDisableWindow(pbUnStop)
.head 7 -  Call SalDisableWindow(pbRefT)
.head 5 -  !
.head 5 +  If not bParUnBlock
.head 6 -  Call SalDisableWindow(pbUnStop)
.head 5 +  If not bParRefT
.head 6 -  Call SalDisableWindow(pbRefT)
.head 3 +  On SAM_ColumnSelectClick
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set nOrderBy = NOT nOrderBy
.head 4 -  Set hColumn = SalNumberToWindowHandle(wParam)
.head 4 -  Call SalTblSetColumnFlags(hColumn, COL_Selected, FALSE)
.head 4 +  If SalNumberToWindowHandle(wParam) = SalTblGetColumnWindow(hWndForm, SalTblQueryColumnID(colSs), COL_GetID)
.head 5 -  Set wParam = SalWindowHandleToNumber(SalTblGetColumnWindow(hWndForm, SalTblQueryColumnPos(colS), COL_GetID))
.head 4 +  If SalNumberToWindowHandle(wParam) = SalTblGetColumnWindow(hWndForm, SalTblQueryColumnID(colS2s), COL_GetID)
.head 5 -  Set wParam = SalWindowHandleToNumber(SalTblGetColumnWindow(hWndForm, SalTblQueryColumnPos(colS2), COL_GetID))
.head 4 -  Set hColumn = SalNumberToWindowHandle(wParam)
.head 4 -  Call SalTblSortRows(hWndForm, SalTblQueryColumnID(hColumn), nOrderBy)
.head 4 -  Call SalTblSetFocusRow(hWndForm, 0)
.head 4 -  Call SalSendMsg(hWndForm, SAM_RowSetContext, 0, 0)
.head 4 -  !
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_RowHeaderClick
.head 4 +  If colOtm > 0 or colBlk = 131313 or colBlk = 131312
.head 5 -  Call XSalTooltipSetColors(COLOR_Black, SalColorFromRGB(255,200,200))
.head 5 -  Call XSalTooltipShow(hWndForm, 'Блоковано на оплату')
.head 5 -  Call XSalTooltipSetColors(COLOR_Black, COLOR_White)
.head 3 +  On SAM_DoubleClick
.head 4 +  If colRef > 0
.head 5 -  Call DocViewContentsEx(hWndMDI, Tbl_FMDoc.colRef)
.head 4 +  Else If colRec > 0
.head 5 -  Call DocViewContents(hWndMDI, Tbl_FMDoc.colRec)
.head 3 +  On UM_Print
.head 4 +  If strPrintFileName
.head 5 -  Call SalGetWindowText(hWndForm, strOldTitle, 99)
.head 5 -  Call TablePrint(hWndForm, strOldTitle, GetPrnDir() || '\\' || strPrintFileName, '')
.head 1 +  Table Window: Tbl_FMHistory
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Історія змін
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Class Default
.head 2 -  Visible? Class Default
.head 2 -  Display Settings
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? Class Default
.head 3 -  Initial State: Class Default
.head 3 -  Maximizable? Class Default
.head 3 -  Minimizable? Class Default
.head 3 -  System Menu? Class Default
.head 3 -  Resizable? Class Default
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  13.7"
.head 4 -  Width Editable? Class Default
.head 4 -  Height: Class Default
.head 4 -  Height Editable? Class Default
.head 3 -  Font Name: Class Default
.head 3 -  Font Size: Class Default
.head 3 -  Font Enhancement: Class Default
.head 3 -  Text Color: Class Default
.head 3 -  Background Color: Class Default
.head 3 -  View: Class Default
.head 3 -  Allow Row Sizing? Class Default
.head 3 -  Lines Per Row: Class Default
.head 2 -  Memory Settings
.head 3 -  Maximum Rows in Memory: Class Default
.head 3 -  Discardable? Class Default
.head 2 -  Description:
.head 2 -  Named Menus
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Class Default
.head 4 -  Location? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Size: Class Default
.head 4 -  Size Editable? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 3 +  Contents
.head 4 +  Pushbutton: pbIns
.head 5 -  Class Child Ref Key: 33
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbDel
.head 5 -  Class Child Ref Key: 34
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbRefresh
.head 5 -  Class Child Ref Key: 35
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbUpdate
.head 5 -  Class Child Ref Key: 36
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 30878
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 +  Pushbutton: pbSearch
.head 5 -  Class Child Ref Key: 38
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbFilter
.head 5 -  Class Child Ref Key: 44
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbDetails
.head 5 -  Class Child Ref Key: 39
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 40
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 30879
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 +  Pushbutton: pbExit
.head 5 -  Class Child Ref Key: 42
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 30880
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 2 +  Contents
.head 3 +  Column: colMDate
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
модифікації
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.6"
.head 4 -  Width Editable? Yes
.head 4 -  Format: DateTime
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colMType
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Тип
модификации
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.4"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colMTypeName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Назва
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.0"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colUserId
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ІД
користувача
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  Default
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colUserName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ПІБ
користувача
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.0"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colMValue
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Старе значення
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 1000
.head 4 -  Data Type: Long String
.head 4 -  Justify: Left
.head 4 -  Width:  4.0"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Number: nId
.head 3 -  Number: nND
.head 2 -  Window Variables
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Set hWndForm.Tbl_FMHistory.nFlags = GT_ReadOnly
.head 4 -  Set hWndForm.Tbl_FMHistory.strPrintFileName = 'FM_HIST'
.head 4 -  Set hWndForm.Tbl_FMHistory.strTitleAux = 'док.№ ' || Str(nND)
.head 4 -  Set hWndForm.Tbl_FMHistory.strSqlPopulate = 
"SELECT f.mod_date, f.mod_type, t.mod_name, 
        f.user_id, f.user_name, substr(f.mod_value,1,1000) 
 INTO :hWndForm.Tbl_FMHistory.colMDate, :hWndForm.Tbl_FMHistory.colMType, 
      :hWndForm.Tbl_FMHistory.colMTypeName, :hWndForm.Tbl_FMHistory.colUserId, 
      :hWndForm.Tbl_FMHistory.colUserName, :hWndForm.Tbl_FMHistory.colMValue 
 FROM finmon_que_modification f, finmon_que_modtype t 
 WHERE f.mod_type=t.mod_type AND f.id=:hWndForm.Tbl_FMHistory.nId"
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On UM_Populate
.head 4 -  Call SqlSetLongBindDatatype(7, 22)
.head 4 -  Call SalSendClassMessage(UM_Populate, 0, 0)
.head 4 -  Call VisTblAutoSizeColumn(hWndForm, hWndNULL)
.head 1 +  Dialog Box: Dlg_FMPar
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Параметри фінансового моніторингу
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  10.0"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.5"
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
.head 3 +  Data Field: dfMfoA
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
.head 6 -  Left:   0.1"
.head 6 -  Top:    0.08"
.head 6 -  Width:  1.2"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfNlsA
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
.head 6 -  Left:   1.3"
.head 6 -  Top:    0.083"
.head 6 -  Width:  1.8"
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
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfNamA
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
.head 6 -  Left:   3.1"
.head 6 -  Top:    0.083"
.head 6 -  Width:  6.7"
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
.head 3 +  Data Field: dfMfoB
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
.head 6 -  Left:   0.1"
.head 6 -  Top:    0.333"
.head 6 -  Width:  1.2"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfNlsB
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
.head 6 -  Left:   1.3"
.head 6 -  Top:    0.333"
.head 6 -  Width:  1.8"
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
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfNamB
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
.head 6 -  Left:   3.1"
.head 6 -  Top:    0.333"
.head 6 -  Width:  6.7"
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
.head 3 +  Data Field: dfPDat
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Date/Time
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.1"
.head 6 -  Top:    0.619"
.head 6 -  Width:  1.2"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: dd/MM/yyyy
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfS
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
.head 6 -  Left:   1.3"
.head 6 -  Top:    0.619"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfKv
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
.head 6 -  Left:   3.1"
.head 6 -  Top:    0.619"
.head 6 -  Width:  0.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfNazn
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
.head 6 -  Left:   3.7"
.head 6 -  Top:    0.619"
.head 6 -  Width:  6.1"
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
.head 3 -  Group Box: Ознаки повідомлення
.head 4 -  Resource Id: 36829
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.067"
.head 5 -  Top:    1.0"
.head 5 -  Width:  9.7"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 3.4"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Check Box: cbDFM_02
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cCheckBoxLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Обов'язковий моніторинг
.head 4 -  Window Location and Size
.head 5 -  Left:   0.3"
.head 5 -  Top:    1.2"
.head 5 -  Width:  3.0"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEnableWindow(pbSave)
.head 6 -  Set cbDFM_02 = TRUE
.head 6 +  If cbDFM_02
.head 7 -  Set cbDFM_03 = FALSE
.head 7 -  Set dfDFM_03 = ''
.head 7 -  Set dfNameDFM_03 = ''
.head 7 -  Set dfCommDFM_03 = ''
.head 7 -  Call SalSendMsg(dfDFM_03, SAM_User, 0, 0)
.head 7 -  Call SalDisableWindow(dfDFM_03)
.head 7 -  Call SalDisableWindow(dfCommDFM_03)
.head 7 -  Call SalDisableWindow(pbDFM_03)
.head 7 -  Set rbDFM_02A = TRUE
.head 7 -  Set rbDFM_02B = TRUE
.head 7 +  If nParEdit
.head 8 -  Call SalEnableWindow(dfDFM_02)
.head 8 -  Call SalEnableWindow(dfCommDFM_02)
.head 8 -  Call SalEnableWindow(pbDFM_02)
.head 3 +  Radio Button: rbDFM_02A
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cRadioButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сторона А
.head 4 -  Window Location and Size
.head 5 -  Left:   0.6"
.head 5 -  Top:    1.452"
.head 5 -  Width:  1.4"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEnableWindow(pbSave)
.head 6 +  If rbDFM_02A OR rbDFM_02B
.head 7 -  Set cbDFM_02 = TRUE
.head 7 -  Call SalEnableWindow(dfDFM_02)
.head 7 -  Call SalEnableWindow(dfCommDFM_02)
.head 7 -  Call SalEnableWindow(pbDFM_02)
.head 7 +  If dfDFM_02 != '' and dfDFM_02 != '0000'
.head 8 -  Call SalEnableWindow(pbAddDFM_02)
.head 7 +  If rbDFM_02A AND rbDFM_02B
.head 8 -  Set cbDFM_03 = FALSE
.head 8 -  Set dfDFM_03 = ''
.head 8 -  Set dfNameDFM_03 = ''
.head 8 -  Set dfCommDFM_03 = ''
.head 8 -  Call SalSendMsg(dfDFM_03, SAM_User, 0, 0)
.head 8 -  Call SalDisableWindow(dfDFM_03)
.head 8 -  Call SalDisableWindow(dfCommDFM_03)
.head 8 -  Call SalDisableWindow(pbDFM_03)
.head 8 -  Call SalDisableWindow(pbAddDFM_03)
.head 3 +  Radio Button: rbDFM_03A
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cRadioButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сторона А
.head 4 -  Window Location and Size
.head 5 -  Left:   0.6"
.head 5 -  Top:    2.25"
.head 5 -  Width:  1.4"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEnableWindow(pbSave)
.head 6 +  If rbDFM_03A OR rbDFM_03B
.head 7 -  Set cbDFM_03 = TRUE
.head 7 -  Call SalEnableWindow(dfDFM_03)
.head 7 -  Call SalEnableWindow(dfCommDFM_03)
.head 7 -  Call SalEnableWindow(pbDFM_03)
.head 7 +  If dfDFM_03 != '' and dfDFM_03 != '000'
.head 8 -  Call SalEnableWindow(pbAddDFM_03)
.head 7 +  If rbDFM_03A AND rbDFM_03B
.head 8 -  Set cbDFM_02 = FALSE
.head 8 -  Set dfDFM_02 = ''
.head 8 -  Set dfNameDFM_02 = ''
.head 8 -  Set dfCommDFM_02 = ''
.head 8 -  Call SalSendMsg(dfDFM_02, SAM_User, 0, 0)
.head 8 -  Call SalDisableWindow(dfDFM_02)
.head 8 -  Call SalDisableWindow(dfCommDFM_02)
.head 8 -  Call SalDisableWindow(pbDFM_02)
.head 8 -  Call SalDisableWindow(pbAddDFM_02)
.head 3 +  Check Box: cbDFM_03
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cCheckBoxLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Внутрішній моніторинг
.head 4 -  Window Location and Size
.head 5 -  Left:   0.3"
.head 5 -  Top:    2.0"
.head 5 -  Width:  3.0"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEnableWindow(pbSave)
.head 6 -  Set cbDFM_03 = TRUE
.head 6 +  If cbDFM_03
.head 7 -  Set cbDFM_02 = FALSE
.head 7 -  Set dfDFM_02 = ''
.head 7 -  Set dfNameDFM_02 = ''
.head 7 -  Set dfCommDFM_02 = ''
.head 7 -  Call SalSendMsg(dfDFM_02, SAM_User, 0, 0)
.head 7 -  Call SalDisableWindow(dfDFM_02)
.head 7 -  Call SalDisableWindow(dfCommDFM_02)
.head 7 -  Call SalDisableWindow(pbDFM_02)
.head 7 -  Set rbDFM_03A = TRUE
.head 7 -  Set rbDFM_03B = TRUE
.head 7 +  If nParEdit
.head 8 -  Call SalEnableWindow(dfDFM_03)
.head 8 -  Call SalEnableWindow(dfCommDFM_03)
.head 8 -  Call SalEnableWindow(pbDFM_03)
.head 3 +  Radio Button: rbDFM_02B
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cRadioButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сторона Б
.head 4 -  Window Location and Size
.head 5 -  Left:   0.6"
.head 5 -  Top:    1.7"
.head 5 -  Width:  1.4"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEnableWindow(pbSave)
.head 6 +  If rbDFM_02A OR rbDFM_02B
.head 7 -  Set cbDFM_02 = TRUE
.head 7 -  Call SalEnableWindow(dfDFM_02)
.head 7 -  Call SalEnableWindow(dfCommDFM_02)
.head 7 -  Call SalEnableWindow(pbDFM_02)
.head 7 +  If dfDFM_02 != '' and dfDFM_02 != '0000'
.head 8 -  Call SalEnableWindow(pbAddDFM_02)
.head 7 +  If rbDFM_02A AND rbDFM_02B
.head 8 -  Set cbDFM_03 = FALSE
.head 8 -  Set dfDFM_03 = ''
.head 8 -  Set dfNameDFM_03 = ''
.head 8 -  Set dfCommDFM_03 = ''
.head 8 -  Call SalSendMsg(dfDFM_03, SAM_User, 0, 0)
.head 8 -  Call SalDisableWindow(dfDFM_03)
.head 8 -  Call SalDisableWindow(dfCommDFM_03)
.head 8 -  Call SalDisableWindow(pbDFM_03)
.head 8 -  Call SalDisableWindow(pbAddDFM_03)
.head 3 +  Radio Button: rbDFM_03B
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cRadioButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сторона Б
.head 4 -  Window Location and Size
.head 5 -  Left:   0.6"
.head 5 -  Top:    2.5"
.head 5 -  Width:  1.4"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEnableWindow(pbSave)
.head 6 +  If rbDFM_03A OR rbDFM_03B
.head 7 -  Set cbDFM_03 = TRUE
.head 7 -  Call SalEnableWindow(dfDFM_03)
.head 7 -  Call SalEnableWindow(dfCommDFM_03)
.head 7 -  Call SalEnableWindow(pbDFM_03)
.head 7 +  If dfDFM_03 != '' and dfDFM_03 != '000'
.head 8 -  Call SalEnableWindow(pbAddDFM_03)
.head 7 +  If rbDFM_03A AND rbDFM_03B
.head 8 -  Set cbDFM_02 = FALSE
.head 8 -  Set dfDFM_02 = ''
.head 8 -  Set dfNameDFM_02 = ''
.head 8 -  Set dfCommDFM_02 = ''
.head 8 -  Call SalSendMsg(dfDFM_02, SAM_User, 0, 0)
.head 8 -  Call SalDisableWindow(dfDFM_02)
.head 8 -  Call SalDisableWindow(dfCommDFM_02)
.head 8 -  Call SalDisableWindow(pbDFM_02)
.head 8 -  Call SalDisableWindow(pbAddDFM_02)
.head 3 +  Data Field: dfDFM_02
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 4
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.5"
.head 6 -  Top:    1.2"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_AnyEdit
.head 6 -  Call SalEnableWindow(pbSave)
.head 5 +  On SAM_Validate
.head 6 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 6 -  Return VALIDATE_Ok
.head 5 +  On SAM_User
.head 6 +  If dfDFM_02 = ''
.head 7 -  Set dfDFM_02 = '0000'
.head 6 +  If dfDFM_02
.head 7 -  Call SqlPrepareAndExecute(hSql(), 
"SELECT substr(name,1,254) INTO :dfNameDFM_02 
 FROM K_DFM02 WHERE code=:dfDFM_02")
.head 7 +  If NOT SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set dfDFM_02 = ''
.head 8 -  Set dfNameDFM_02 = ''
.head 6 +  If nId
.head 7 +  If dfDFM_02 = '0000' or dfDFM_02 = ''
.head 8 -  Call SalDisableWindow(pbAddDFM_02)
.head 7 +  Else
.head 8 -  Call SalEnableWindow(pbAddDFM_02)
.head 3 +  Data Field: dfNameDFM_02
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
.head 6 -  Left:   4.55"
.head 6 -  Top:    1.202"
.head 6 -  Width:  4.65"
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
.head 3 +  Pushbutton: pbDFM_02
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbHelp
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   9.25"
.head 5 -  Top:    1.2"
.head 5 -  Width:  0.35"
.head 5 -  Width Editable? No
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? No
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
.head 4 -  Picture Transparent Color: White
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
.head 5 +  On SAM_Click
.head 6 +  If FunNSIGetFiltered("K_DFM02", "", " code is not null and (d_close is null or d_close > bankdate) ORDER BY code",sPK, sPKName)
.head 7 -  Set dfDFM_02 = sPK
.head 7 -  Set dfNameDFM_02 = sPKName
.head 7 -  Call SalEnableWindow(pbSave)
.head 7 +  If nId
.head 8 +  If dfDFM_02 = '0000' or dfDFM_02 = ''
.head 9 -  Call SalDisableWindow(pbAddDFM_02)
.head 8 +  Else
.head 9 -  Call SalEnableWindow(pbAddDFM_02)
.head 3 +  Data Field: dfCommDFM_02
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 254
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.5"
.head 6 -  Top:    1.5"
.head 6 -  Width:  5.7"
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
.head 4 +  Message Actions
.head 5 +  On SAM_AnyEdit
.head 6 -  Call SalEnableWindow(pbSave)
.head 3 +  Pushbutton: pbAddDFM_02
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbFilter
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   9.233"
.head 5 -  Top:    1.5"
.head 5 -  Width:  0.35"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\POP.BMP
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Додатково')
.head 5 +  On SAM_Click
.head 6 -  Call SalModalDialog(Dlg_AddVid, hWndForm, nId, 2, nParEdit)
.head 3 +  Data Field: dfDFM_03
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 3
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.5"
.head 6 -  Top:    2.0"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_AnyEdit
.head 6 -  Call SalEnableWindow(pbSave)
.head 5 +  On SAM_Validate
.head 6 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 6 -  Return VALIDATE_Ok
.head 5 +  On SAM_User
.head 6 +  If dfDFM_03 = ''
.head 7 -  Set dfDFM_03 = '000'
.head 6 +  If dfDFM_03
.head 7 -  Call SqlPrepareAndExecute(hSql(), 
"SELECT substr(name,1,254) INTO :dfNameDFM_03 
 FROM K_DFM03 WHERE code=:dfDFM_03")
.head 7 +  If NOT SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set dfDFM_03 = ''
.head 8 -  Set dfNameDFM_03 = ''
.head 6 +  If nId
.head 7 +  If dfDFM_03 = '000' or dfDFM_03 = ''
.head 8 -  Call SalDisableWindow(pbAddDFM_03)
.head 7 +  Else
.head 8 -  Call SalEnableWindow(pbAddDFM_03)
.head 3 +  Data Field: dfNameDFM_03
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
.head 6 -  Left:   4.55"
.head 6 -  Top:    2.0"
.head 6 -  Width:  4.65"
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
.head 3 +  Pushbutton: pbDFM_03
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbHelp
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   9.25"
.head 5 -  Top:    2.0"
.head 5 -  Width:  0.35"
.head 5 -  Width Editable? No
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? No
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
.head 4 -  Picture Transparent Color: White
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
.head 5 +  On SAM_Click
.head 6 +  If FunNSIGetFiltered("K_DFM03", "", " code is not null and (d_close is null or d_close > bankdate) ORDER BY code", sPK, sPKName)
.head 7 -  Set dfDFM_03 = sPK
.head 7 -  Set dfNameDFM_03 = sPKName
.head 7 -  Call SalEnableWindow(pbSave)
.head 7 +  If nId
.head 8 +  If dfDFM_03 = '000' or dfDFM_03 = ''
.head 9 -  Call SalDisableWindow(pbAddDFM_03)
.head 8 +  Else
.head 9 -  Call SalEnableWindow(pbAddDFM_03)
.head 3 +  Data Field: dfCommDFM_03
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 254
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.5"
.head 6 -  Top:    2.3"
.head 6 -  Width:  5.7"
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
.head 4 +  Message Actions
.head 5 +  On SAM_AnyEdit
.head 6 -  Call SalEnableWindow(pbSave)
.head 3 +  Pushbutton: pbAddDFM_03
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbFilter
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   9.267"
.head 5 -  Top:    2.298"
.head 5 -  Width:  0.35"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\POP.BMP
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Додатково')
.head 5 +  On SAM_Click
.head 6 -  Call SalModalDialog(Dlg_AddVid, hWndForm, nId, 3, nParEdit)
.head 3 -  Group Box: Режим моніторингу клієнтів
.head 4 -  Resource Id: 3322
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.067"
.head 5 -  Top:    2.8"
.head 5 -  Width:  9.7"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.1"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Radio Button: rbA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cRadioButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сторона А
.head 4 -  Window Location and Size
.head 5 -  Left:   0.3"
.head 5 -  Top:    3.0"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEnableWindow(pbSave)
.head 6 -  Call SalEnableWindow(pbCustomerA)
.head 6 -  Set dfOkpoB = STRING_Null
.head 6 -  Set dfRnkB  = NUMBER_Null
.head 6 -  Set dfNameB = STRING_Null
.head 6 -  Call SalDisableWindow(pbCustomerB)
.head 6 -  Set cbDFM_02 = TRUE
.head 6 -  Call SalSendMsg(cbDFM_02, SAM_Click, 0, 0)
.head 6 -  Call SalEnableWindow(cbDFM_02)
.head 6 -  Call SalEnableWindow(cbDFM_03)
.head 6 -  Call SalHideWindow(rbDFM_02A)
.head 6 -  Call SalHideWindow(rbDFM_02B)
.head 6 -  Call SalHideWindow(rbDFM_03A)
.head 6 -  Call SalHideWindow(rbDFM_03B)
.head 3 +  Radio Button: rbB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cRadioButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сторона Б
.head 4 -  Window Location and Size
.head 5 -  Left:   0.3"
.head 5 -  Top:    3.3"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEnableWindow(pbSave)
.head 6 -  Call SalEnableWindow(pbCustomerB)
.head 6 -  Set dfOkpoA = STRING_Null
.head 6 -  Set dfRnkA  = NUMBER_Null
.head 6 -  Set dfNameA = STRING_Null
.head 6 -  Call SalDisableWindow(pbCustomerA)
.head 6 -  Set cbDFM_02 = TRUE
.head 6 -  Call SalSendMsg(cbDFM_02, SAM_Click, 0, 0)
.head 6 -  Call SalEnableWindow(cbDFM_02)
.head 6 -  Call SalEnableWindow(cbDFM_03)
.head 6 -  Call SalHideWindow(rbDFM_02A)
.head 6 -  Call SalHideWindow(rbDFM_02B)
.head 6 -  Call SalHideWindow(rbDFM_03A)
.head 6 -  Call SalHideWindow(rbDFM_03B)
.head 3 +  Radio Button: rbAB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cRadioButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Обидва
.head 4 -  Window Location and Size
.head 5 -  Left:   0.3"
.head 5 -  Top:    3.6"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEnableWindow(pbSave)
.head 6 -  Call SalEnableWindow(pbCustomerA)
.head 6 -  Call SalEnableWindow(pbCustomerB)
.head 6 -  Call SalShowWindow(rbDFM_02A)
.head 6 -  Call SalShowWindow(rbDFM_02B)
.head 6 -  Call SalShowWindow(rbDFM_03A)
.head 6 -  Call SalShowWindow(rbDFM_03B)
.head 6 -  Set cbDFM_02  = TRUE
.head 6 -  Set rbDFM_02A = TRUE
.head 6 -  Set rbDFM_02B = TRUE
.head 6 -  Call SalSendMsg(rbDFM_02A, SAM_Click, 0, 0)
.head 3 +  Data Field: dfOkpoA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 14
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.5"
.head 6 -  Top:    3.0"
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
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'ЗКПО-А')
.head 3 +  Data Field: dfRnkA
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
.head 6 -  Left:   4.75"
.head 6 -  Top:    3.0"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 +  If not SalIsNull(dfRnkA)
.head 7 -  Call getClientByRnk(dfRnkA, dfOkpoA, dfNameA)
.head 6 +  Else
.head 7 -  Call getClientByAcc(dfMfoA, dfNlsA, nKv, dfRnkA, dfNameA, dfOkpoA)
.head 6 +  If SalIsNull(dfRnkA)
.head 7 -  Call getClientByOkpo(sId_A, dfRnkA, dfNameA, dfOkpoA)
.head 3 +  Data Field: dfNameA
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
.head 6 -  Left:   5.8"
.head 6 -  Top:    3.0"
.head 6 -  Width:  3.4"
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
.head 3 +  ! ctb_pbHelp: pbCustomerA
.winattr class Pushbutton:
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbHelp
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   9.25"
.head 5 -  Top:    3.0"
.head 5 -  Width:  0.43"
.head 5 -  Width Editable? No
.head 5 -  Height: 0.317"
.head 5 -  Height Editable? No
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F1
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.end
.head 4 +             Message Actions 
.head 5 +             On SAM_TooltipSetText
.head 6 -             Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
.head 5 +             On SAM_Click
.head 6 +             If FunNSIGetFiltered("V_CUSTOMER_FM", "", " okpo is not null ORDER BY nmk", sPK, sPKName)
.head 7 -             Set dfRnkA = Val(sPK)
.head 7 -             Call SalSendMsg(dfRnkA, SAM_Create, 0, 0)
.head 7 -             Call SalEnableWindow(pbSave)
.head 3 +  Pushbutton: pbCustomerA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbHelp
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   9.25"
.head 5 -  Top:    3.0"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
.head 4 -  Picture Transparent Color: White
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
.head 5 +  On SAM_Click
.head 6 +  If FunNSIGetFiltered("V_CUSTOMER_FM", "", " okpo is not null ORDER BY nmk", sPK, sPKName)
.head 7 -  Set dfRnkA = Val(sPK)
.head 7 -  Call SalSendMsg(dfRnkA, SAM_Create, 0, 0)
.head 7 -  Call SalEnableWindow(pbSave)
.head 3 +  Data Field: dfOkpoB
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
.head 6 -  Left:   3.5"
.head 6 -  Top:    3.3"
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
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'ЗКПО-Б')
.head 3 +  Data Field: dfRnkB
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
.head 6 -  Left:   4.75"
.head 6 -  Top:    3.298"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 +  If not SalIsNull(dfRnkB)
.head 7 -  Call getClientByRnk(dfRnkB, dfOkpoB, dfNameB)
.head 6 +  Else
.head 7 -  Call getClientByAcc(dfMfoB, dfNlsB, nKv2, dfRnkB, dfNameB, dfOkpoB)
.head 6 +  If SalIsNull(dfRnkB)
.head 7 -  Call getClientByOkpo(sId_B, dfRnkB, dfNameB, dfOkpoB)
.head 3 +  Data Field: dfNameB
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
.head 6 -  Left:   5.8"
.head 6 -  Top:    3.298"
.head 6 -  Width:  3.4"
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
.head 3 +  ! ctb_pbHelp: pbCustomerB
.winattr class Pushbutton:
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbHelp
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   9.25"
.head 5 -  Top:    3.298"
.head 5 -  Width:  0.43"
.head 5 -  Width Editable? No
.head 5 -  Height: 0.317"
.head 5 -  Height Editable? No
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F1
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.end
.head 4 +             Message Actions 
.head 5 +             On SAM_TooltipSetText
.head 6 -             Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
.head 5 +             On SAM_Click
.head 6 +             If FunNSIGetFiltered("V_CUSTOMER_FM", "", " okpo is not null ORDER BY nmk", sPK, sPKName)
.head 7 -             Set dfRnkB = Val(sPK)
.head 7 -             Call SalSendMsg(dfRnkB, SAM_Create, 0, 0)
.head 7 -             Call SalEnableWindow(pbSave)
.head 3 +  Pushbutton: pbCustomerB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbHelp
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   9.25"
.head 5 -  Top:    3.298"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
.head 4 -  Picture Transparent Color: White
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
.head 5 +  On SAM_Click
.head 6 +  If FunNSIGetFiltered("V_CUSTOMER_FM", "", " okpo is not null ORDER BY nmk", sPK, sPKName)
.head 7 -  Set dfRnkB = Val(sPK)
.head 7 -  Call SalSendMsg(dfRnkB, SAM_Create, 0, 0)
.head 7 -  Call SalEnableWindow(pbSave)
.head 3 -  Background Text: Код виду фінансової операції
.head 4 -  Resource Id: 123
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.3"
.head 5 -  Top:    4.05"
.head 5 -  Width:  3.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfDFM_01
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 15
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.5"
.head 6 -  Top:    4.0"
.head 6 -  Width:  5.7"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_AnyEdit
.head 6 -  Call SalEnableWindow(pbSave)
.head 5 +  On SAM_User
.head 6 +  If dfDFM_01 = ''
.head 7 -  Set dfDFM_01 = '000000000000000'
.head 5 +  ! On SAM_Validate
.head 6 -  ! проверка правильности заполнения
(сравнить со значениями из справочников)
.head 6 +                                                          If NOT SqlPrepareAndExecute(hSql(), 
"SELECT code FROM k_dfm01a WHERE code=substr(:dfDFM_01,1,1)") 
OR NOT SqlFetchNext(hSql(), nFetchRes)
.head 7 -                                                          Call Debug('ERROR!')
.head 6 -                                                          Return VALIDATE_Ok
.head 3 +  Pushbutton: pbDFM_01
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbHelp
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   9.25"
.head 5 -  Top:    4.0"
.head 5 -  Width:  0.35"
.head 5 -  Width Editable? No
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? No
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
.head 4 -  Picture Transparent Color: White
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
.head 5 +  On SAM_Click
.head 6 -  Set sKodDFM01 = dfDFM_01
.head 6 +  If SalModalDialog(Dlg_FMKod, hWndForm, nParEdit, sKodDFM01)
.head 7 -  Set dfDFM_01 = sKodDFM01
.head 7 -  Call SalEnableWindow(pbSave)
.head 3 +  Pushbutton: pbSave
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Зберегти
.head 4 -  Window Location and Size
.head 5 -  Left:   1.5"
.head 5 -  Top:    4.6"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
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
.head 6 +  If cbDFM_02 AND dfDFM_02 = ''
.head 7 -  Call SalMessageBox("Не заповнено дані для обов'язкового моніторингу !", "Помилка", MB_Ok | MB_IconExclamation)
.head 7 -  Call SalSetFocus(dfDFM_02)
.head 7 -  Return FALSE
.head 6 +  If cbDFM_03
.head 7 +  If dfDFM_03 = ''
.head 8 -  Call SalMessageBox("Не заповнено дані для внутрішнього моніторингу !", "Помилка", MB_Ok | MB_IconExclamation)
.head 8 -  Call SalSetFocus(dfDFM_03)
.head 8 -  Return FALSE
.head 7 +  Else If dfDFM_03 = '900' AND dfCommDFM_03 = ''
.head 8 -  Call SalMessageBox("Не заповнено коментар для коду 900 внутрішнього моніторингу !", "Помилка", MB_Ok | MB_IconExclamation)
.head 8 -  Call SalSetFocus(dfCommDFM_03)
.head 8 -  Return FALSE
.head 6 +  If dfDFM_01 != '' AND (NOT SqlPrepareAndExecute(hSql(), 
"SELECT code FROM k_dfm01a WHERE code=substr(:dfDFM_01,1,1)") 
OR NOT SqlFetchNext(hSql(), nFetchRes)
OR NOT SqlPrepareAndExecute(hSql(), 
"SELECT code FROM k_dfm01a WHERE code=substr(:dfDFM_01,2,1)") 
OR NOT SqlFetchNext(hSql(), nFetchRes)
OR NOT SqlPrepareAndExecute(hSql(), 
"SELECT code FROM k_dfm01b WHERE code=substr(:dfDFM_01,3,1)") 
OR NOT SqlFetchNext(hSql(), nFetchRes)
OR NOT SqlPrepareAndExecute(hSql(), 
"SELECT code FROM k_dfm01b WHERE code=substr(:dfDFM_01,4,1)") 
OR NOT SqlFetchNext(hSql(), nFetchRes)
OR NOT SqlPrepareAndExecute(hSql(), 
"SELECT code FROM k_dfm01c WHERE code=substr(:dfDFM_01,5,1)") 
OR NOT SqlFetchNext(hSql(), nFetchRes)
OR NOT SqlPrepareAndExecute(hSql(), 
"SELECT code FROM k_dfm01c WHERE code=substr(:dfDFM_01,6,1)") 
OR NOT SqlFetchNext(hSql(), nFetchRes)
OR NOT SqlPrepareAndExecute(hSql(), 
"SELECT code FROM k_dfm01d WHERE code=substr(:dfDFM_01,7,4)") 
OR NOT SqlFetchNext(hSql(), nFetchRes)
OR NOT SqlPrepareAndExecute(hSql(), 
"SELECT code FROM k_dfm01d WHERE code=substr(:dfDFM_01,11,4)") 
OR NOT SqlFetchNext(hSql(), nFetchRes)
OR NOT SqlPrepareAndExecute(hSql(), 
"SELECT code FROM k_dfm01e WHERE code=substr(:dfDFM_01,15,1)") 
OR NOT SqlFetchNext(hSql(), nFetchRes) )
.head 7 -  Call SalMessageBox("Невірно заповнено код виду фінансової операції !", "Помилка", MB_Ok | MB_IconExclamation)
.head 7 -  Call SalSetFocus(dfDFM_01)
.head 7 -  Return FALSE
.head 6 +  If SqlPrepareAndExecute(hSql(), "SELECT count(*) INTO :nCount FROM finmon_que WHERE id=:nId")
.head 7 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 7 -  Set nMode = 
IifN(rbA=TRUE, 1, 
IifN(rbB=TRUE, 2, 
IifN(rbAB=TRUE,
  IifN(rbDFM_02A=TRUE AND rbDFM_03B=TRUE,4,
  IifN(rbDFM_02B=TRUE AND rbDFM_03A=TRUE,5,3)),nMode)))
.head 7 +  If nCount
.head 8 +  If NOT SqlPrepareAndExecute(hSql(), 
"UPDATE finmon_que 
 SET opr_vid1=:dfDFM_01, opr_vid2=:dfDFM_02, comm_vid2=:dfCommDFM_02, 
     opr_vid3=:dfDFM_03, comm_vid3=:dfCommDFM_03, 
     monitor_mode=:nMode, status=decode(status,'R','I',status), 
     rnk_a=:dfRnkA, rnk_b=:dfRnkB 
 WHERE id=:nId")
.head 9 -  Call SqlRollback(hSql())
.head 9 -  Return TRUE
.head 8 +  If dfDFM_02 = '0000'
.head 9 +  If not SqlPrepareAndExecute(hSql(), "delete from finmon_que_vid2 where id=:nId")
.head 10 -  Call SqlRollback(hSql())
.head 10 -  Return TRUE
.head 8 +  If dfDFM_03 = '000'
.head 9 +  If not SqlPrepareAndExecute(hSql(), "delete from finmon_que_vid3 where id=:nId")
.head 10 -  Call SqlRollback(hSql())
.head 10 -  Return TRUE
.head 7 +  Else
.head 8 +  If NOT SqlPrepareAndExecute(hSql(), 
"INSERT INTO finmon_que(ref,rec,status,opr_vid1,opr_vid2,comm_vid2,opr_vid3,comm_vid3,monitor_mode,agent_id,rnk_a,rnk_b) 
 VALUES(:nRef,:nRec,'I',:dfDFM_01,:dfDFM_02,:dfCommDFM_02,:dfDFM_03,:dfCommDFM_03,:nMode,:nUserId,:dfRnkA,:dfRnkB)")
.head 9 -  Call SqlRollback(hSql())
.head 9 -  Return TRUE
.head 7 -  Call SqlCommit(hSql())
.head 6 -  Call SalEndDialog(hWndForm,1)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Відмінити
.head 4 -  Window Location and Size
.head 5 -  Left:   6.7"
.head 5 -  Top:    4.595"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.448"
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
.head 6 -  Call SalEndDialog(hWndForm,0)
.head 2 +  Functions
.head 3 +  Function: getClientByRnk
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nRnk
.head 5 -  Receive String: sRetOkpo
.head 5 -  Receive String: sRetName
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If nRnk != NUMBER_Null
.head 6 +  If not SqlPrepareAndExecute(hSql(), 
"select okpo, nmk into :sRetOkpo, :sRetName 
   from customer
  where rnk = :nRnk")
.head 7 -  Return FALSE
.head 6 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 7 -  Return FALSE
.head 5 -  Return TRUE
.head 3 +  Function: getClientByAcc
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: sMfo
.head 5 -  String: sNls
.head 5 -  Number: nVal
.head 5 -  Receive Number: nRetRnk
.head 5 -  Receive String: sRetName
.head 5 -  Receive String: sRetOkpo
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nFind
.head 4 +  Actions
.head 5 -  Set nRetRnk  = NUMBER_Null
.head 5 -  Set sRetName = STRING_Null
.head 5 -  Set sRetOkpo = STRING_Null
.head 5 +  If sMfo = GetBankMfo() and sNls != STRING_Null and nVal != NUMBER_Null
.head 6 +  If not SqlPrepareAndExecute(hSql(), 
"select c.rnk, c.nmk, c.okpo into :nRetRnk, :sRetName, :sRetOkpo
   from customer c, accounts a
  where a.nls = :sNls and a.kv = :nVal
    and a.rnk = c.rnk")
.head 7 -  Return FALSE
.head 6 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 7 -  Return FALSE
.head 5 -  Return TRUE
.head 3 +  Function: getClientByOkpo
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: sOkpo
.head 5 -  Receive Number: nRetRnk
.head 5 -  Receive String: sRetName
.head 5 -  Receive String: sRetOkpo
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nFind
.head 4 +  Actions
.head 5 -  Set nRetRnk  = NUMBER_Null
.head 5 -  Set sRetName = STRING_Null
.head 5 -  Set sRetOkpo = sOkpo
.head 5 +  If sOkpo != STRING_Null
.head 6 -  Set nFind = 0
.head 6 +  If not SqlPrepareAndExecute(hSql(), 
"select c.rnk, c.nmk, c.okpo into :nRetRnk, :sRetName, :sRetOkpo
   from customer c
  where c.okpo = :sOkpo")
.head 7 -  Return FALSE
.head 6 +  While SqlFetchNext(hSql(), nFetchRes)
.head 7 -  Set nFind = nFind + 1
.head 6 +  If nFind > 1
.head 7 -  Set nRetRnk  = NUMBER_Null
.head 7 -  Set sRetName = STRING_Null
.head 7 -  Set sRetOkpo = sOkpo
.head 5 -  Return TRUE
.head 2 +  Window Parameters
.head 3 -  Number: nParEdit	! 1-EDIT, 0-READ_ONLY/
.head 3 -  Number: nId
.head 3 -  Number: nRef
.head 3 -  Number: nRec
.head 3 -  String: sMfoA
.head 3 -  String: sNlsA
.head 3 -  String: sNamA
.head 3 -  String: sMfoB
.head 3 -  String: sNlsB
.head 3 -  String: sNamB
.head 3 -  Date/Time: dPDat
.head 3 -  Number: nS		! сумма в копейках
.head 3 -  Number: nKv
.head 3 -  Number: nKv2
.head 3 -  String: sKv
.head 3 -  String: sNazn
.head 3 -  Number: nDig
.head 3 -  String: sVid1
.head 3 -  String: sVid2
.head 3 -  String: sComm2
.head 3 -  String: sVid3
.head 3 -  String: sComm3
.head 3 -  Number: nMode
.head 3 -  Number: nRnkA
.head 3 -  Number: nRnkB
.head 3 -  String: sId_A		! OkpoA (id_a from oper)
.head 3 -  String: sId_B		! OkpoB (id_b from oper)
.head 2 +  Window Variables
.head 3 -  Number: nUserId
.head 3 -  String: sFormat
.head 3 -  String: sPK
.head 3 -  String: sPKName
.head 3 -  String: sKodDFM01
.head 3 -  Number: nCount
.head 3 -  String: sTmp
.head 3 -  Number: nAcc
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 -  Set nUserId = GetUserId()
.head 4 +  If NOT nParEdit
.head 5 -  Call SalDisableWindow(cbDFM_02)
.head 5 -  Call SalDisableWindow(dfDFM_02)
.head 5 -  Call SalDisableWindow(pbDFM_02)
.head 5 -  Call SalDisableWindow(dfCommDFM_02)
.head 5 -  Call SalDisableWindow(cbDFM_03)
.head 5 -  Call SalDisableWindow(dfDFM_03)
.head 5 -  Call SalDisableWindow(pbDFM_03)
.head 5 -  Call SalDisableWindow(dfCommDFM_03)
.head 5 -  Call SalDisableWindow(dfDFM_01)
.head 5 -  Call SalDisableWindow(rbA)
.head 5 -  Call SalDisableWindow(rbDFM_02A)
.head 5 -  Call SalDisableWindow(rbDFM_03A)
.head 5 -  Call SalDisableWindow(rbB)
.head 5 -  Call SalDisableWindow(rbDFM_02B)
.head 5 -  Call SalDisableWindow(rbDFM_03B)
.head 5 -  Call SalDisableWindow(rbAB)
.head 5 -  Call SalDisableWindow(dfOkpoA)
.head 5 -  Call SalDisableWindow(dfOkpoB)
.head 5 -  Call SalDisableWindow(pbCustomerA)
.head 5 -  Call SalDisableWindow(pbCustomerB)
.head 4 +  If nMode = NUMBER_Null 
.head 5 -  Set cbDFM_02 = TRUE
.head 5 -  Call SalDisableWindow(dfDFM_03)
.head 5 -  Call SalDisableWindow(dfCommDFM_03)
.head 5 -  Call SalDisableWindow(pbDFM_03)
.head 5 -  Call SalDisableWindow(pbAddDFM_03)
.head 5 -  Call SalDisableWindow(pbAddDFM_02)
.head 4 +  Else If nMode < 3
.head 5 -  Call SalHideWindow(rbDFM_02A)
.head 5 -  Call SalHideWindow(rbDFM_02B)
.head 5 -  Call SalHideWindow(rbDFM_03A)
.head 5 -  Call SalHideWindow(rbDFM_03B)
.head 5 +  If sVid3 != '' AND sVid3 != '000'
.head 6 -  Set cbDFM_03 = TRUE
.head 6 -  Call SalDisableWindow(dfDFM_02)
.head 6 -  Call SalDisableWindow(dfCommDFM_02)
.head 6 -  Call SalDisableWindow(pbDFM_02)
.head 6 -  Call SalDisableWindow(pbAddDFM_02)
.head 5 +  Else
.head 6 -  Set cbDFM_02 = TRUE
.head 6 -  Call SalDisableWindow(dfDFM_03)
.head 6 -  Call SalDisableWindow(dfCommDFM_03)
.head 6 -  Call SalDisableWindow(pbDFM_03)
.head 6 -  Call SalDisableWindow(pbAddDFM_03)
.head 4 -  Set dfMfoA = sMfoA
.head 4 -  Set dfNlsA = sNlsA
.head 4 -  Set dfNamA = sNamA
.head 4 -  Set dfMfoB = sMfoB
.head 4 -  Set dfNlsB = sNlsB
.head 4 -  Set dfNamB = sNamB
.head 4 -  Set dfPDat = dPDat
.head 4 -  Set dfS    = nS * SalNumberPower(10,-nDig)
.head 4 -  Set dfKv   = sKv
.head 4 -  Set dfNazn = sNazn
.head 4 -  Set dfDFM_01 = sVid1
.head 4 -  Call SalSendMsg(dfDFM_01, SAM_User, 0, 0)
.head 4 -  Set dfDFM_02 = sVid2
.head 4 -  Set dfCommDFM_02 = sComm2
.head 4 -  Call SalSendMsg(dfDFM_02, SAM_User, 0, 0)
.head 4 -  Set dfDFM_03 = sVid3
.head 4 -  Set dfCommDFM_03 = sComm3
.head 4 -  Call SalSendMsg(dfDFM_03, SAM_User, 0, 0)
.head 4 +  If dfMfoA != dfMfoB
.head 5 -  Call SalHideWindow(rbDFM_02A)
.head 5 -  Call SalHideWindow(rbDFM_02B)
.head 5 -  Call SalHideWindow(rbDFM_03A)
.head 5 -  Call SalHideWindow(rbDFM_03B)
.head 5 -  Call SalDisableWindow(rbA)
.head 5 -  Call SalDisableWindow(rbB)
.head 5 -  Call SalDisableWindow(rbAB)
.head 5 +  If dfMfoB = GetBankMfo()
.head 6 -  Set rbB = TRUE
.head 5 +  Else
.head 6 -  Set rbA = TRUE
.head 4 +  Else
.head 5 +  If nMode = 1
.head 6 -  Set rbA = TRUE
.head 5 +  Else If nMode = 2
.head 6 -  Set rbB = TRUE
.head 5 +  Else
.head 6 -  Set rbAB = TRUE
.head 6 +  If nMode = 3
.head 7 +  If Val(dfDFM_02)
.head 8 -  Set cbDFM_02  = TRUE
.head 8 -  Set rbDFM_02A = TRUE
.head 8 -  Set rbDFM_02B = TRUE
.head 8 -  Call SalDisableWindow(dfDFM_03)
.head 8 -  Call SalDisableWindow(dfCommDFM_03)
.head 8 -  Call SalDisableWindow(pbDFM_03)
.head 8 -  Call SalDisableWindow(pbAddDFM_03)
.head 7 +  Else
.head 8 -  Set cbDFM_03  = TRUE
.head 8 -  Set rbDFM_03A = TRUE
.head 8 -  Set rbDFM_03B = TRUE
.head 8 -  Call SalDisableWindow(dfDFM_02)
.head 8 -  Call SalDisableWindow(dfCommDFM_02)
.head 8 -  Call SalDisableWindow(pbDFM_02)
.head 8 -  Call SalDisableWindow(pbAddDFM_02)
.head 6 +  Else If nMode = 4
.head 7 -  Set cbDFM_02  = TRUE
.head 7 -  Set rbDFM_02A = TRUE
.head 7 -  Set cbDFM_03  = TRUE
.head 7 -  Set rbDFM_03B = TRUE
.head 6 +  Else If nMode = 5
.head 7 -  Set cbDFM_02  = TRUE
.head 7 -  Set rbDFM_02B = TRUE
.head 7 -  Set cbDFM_03  = TRUE
.head 7 -  Set rbDFM_03A = TRUE
.head 4 +  If rbA
.head 5 -  Call SalDisableWindow(dfOkpoB)
.head 5 -  Call SalDisableWindow(pbCustomerB)
.head 4 +  If rbB
.head 5 -  Call SalDisableWindow(dfOkpoA)
.head 5 -  Call SalDisableWindow(pbCustomerA)
.head 4 -  Set dfRnkA = nRnkA
.head 4 -  Set dfRnkB = nRnkB
.head 4 -  Call SalDisableWindow(pbSave)
.head 4 -  Set sFormat = '#0.' || SalStrRepeatX('0', IifN(nDig!=NUMBER_Null, nDig, 2))
.head 4 -  Call SalFmtSetPicture(dfS, sFormat)
.head 4 -  Call SalSetFocus(pbCancel)
.head 1 +  Dialog Box: Dlg_FMKod
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Код виду фінансової операції
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  8.9"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.8"
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
.head 3 -  Background Text: Код виду фінансової операції
.head 4 -  Resource Id: 124
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.131"
.head 5 -  Width:  3.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Dark Blue
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cLabelControl
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Class Default
.head 5 -  Data Type: Class Default
.head 5 -  Editable? Class Default
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   Default
.head 6 -  Top:    Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Border? Class Default
.head 5 -  Justify: Class Default
.head 5 -  Format: Class Default
.head 5 -  Country: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Input Mask: Class Default
.head 4 -  Message Actions
.head 3 +  Data Field: dfKod
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
.head 6 -  Left:   3.15"
.head 6 -  Top:    0.095"
.head 6 -  Width:  2.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Dark Blue
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  !
.head 3 -  Group Box: Форма розрахунку
.head 4 -  Resource Id: 125
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.4"
.head 5 -  Width:  8.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.9"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: що надається
.head 4 -  Resource Id: 9031
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.3"
.head 5 -  Top:    0.7"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgAKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cLabelControl
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Class Default
.head 5 -  Data Type: Class Default
.head 5 -  Editable? Class Default
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   Default
.head 6 -  Top:    Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Border? Class Default
.head 5 -  Justify: Class Default
.head 5 -  Format: Class Default
.head 5 -  Country: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Input Mask: Class Default
.head 4 -  Message Actions
.head 3 +  Data Field: dfAKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 1
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    0.65"
.head 6 -  Width:  0.6"
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
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 5 +  On SAM_AnyEdit
.head 6 -  Call SalEnableWindow(pbSave)
.head 5 +  On SAM_Validate
.head 6 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 6 -  Call CreateKod()
.head 6 -  Return VALIDATE_Ok
.head 5 +  On SAM_User
.head 6 +  If dfAKod
.head 7 -  Call SqlPrepareAndExecute(hSql(), 
"SELECT name INTO :dfAName FROM K_DFM01a WHERE code=:dfAKod")
.head 7 +  If NOT SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set dfAKod = ''
.head 8 -  Set dfAName = ''
.head 3 +  Data Field: dfAName
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
.head 6 -  Left:   3.15"
.head 6 -  Top:    0.655"
.head 6 -  Width:  5.0"
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
.head 3 +  Pushbutton: pbAKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbHelp
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   8.2"
.head 5 -  Top:    0.655"
.head 5 -  Width:  0.35"
.head 5 -  Width Editable? No
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? No
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
.head 4 -  Picture Transparent Color: White
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
.head 5 +  On SAM_Click
.head 6 +  If FunNSIGetFiltered("K_DFM01A", "", " code is not null and (d_close is null or d_close > bankdate) ORDER BY code", sPK, sPKName)
.head 7 -  Set dfAKod = sPK
.head 7 -  Set dfAName = sPKName
.head 7 -  Call SalEnableWindow(pbSave)
.head 7 -  Call CreateKod()
.head 3 -  Background Text: що отримується
.head 4 -  Resource Id: 9032
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.3"
.head 5 -  Top:    1.0"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgBKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cLabelControl
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Class Default
.head 5 -  Data Type: Class Default
.head 5 -  Editable? Class Default
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   Default
.head 6 -  Top:    Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Border? Class Default
.head 5 -  Justify: Class Default
.head 5 -  Format: Class Default
.head 5 -  Country: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Input Mask: Class Default
.head 4 -  Message Actions
.head 3 +  Data Field: dfBKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 1
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    0.95"
.head 6 -  Width:  0.6"
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
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 5 +  On SAM_AnyEdit
.head 6 -  Call SalEnableWindow(pbSave)
.head 5 +  On SAM_Validate
.head 6 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 6 -  Call CreateKod()
.head 6 -  Return VALIDATE_Ok
.head 5 +  On SAM_User
.head 6 +  If dfBKod
.head 7 -  Call SqlPrepareAndExecute(hSql(), 
"SELECT name INTO :dfBName FROM K_DFM01a WHERE code=:dfBKod")
.head 7 +  If NOT SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set dfBKod = ''
.head 8 -  Set dfBName = ''
.head 3 +  Data Field: dfBName
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
.head 6 -  Left:   3.15"
.head 6 -  Top:    0.952"
.head 6 -  Width:  5.0"
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
.head 3 +  Pushbutton: pbBKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbHelp
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   8.2"
.head 5 -  Top:    0.952"
.head 5 -  Width:  0.35"
.head 5 -  Width Editable? No
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? No
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
.head 4 -  Picture Transparent Color: White
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
.head 5 +  On SAM_Click
.head 6 +  If FunNSIGetFiltered("K_DFM01A", "", " code is not null and (d_close is null or d_close > bankdate) ORDER BY code", sPK, sPKName)
.head 7 -  Set dfBKod= sPK
.head 7 -  Set dfBName = sPKName
.head 7 -  Call SalEnableWindow(pbSave)
.head 7 -  Call CreateKod()
.head 3 -  !
.head 3 -  Group Box: Вид активу
.head 4 -  Resource Id: 38378
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    1.35"
.head 5 -  Width:  8.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.9"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: що одержується
.head 4 -  Resource Id: 19335
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.3"
.head 5 -  Top:    1.65"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgCKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cLabelControl
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Class Default
.head 5 -  Data Type: Class Default
.head 5 -  Editable? Class Default
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   Default
.head 6 -  Top:    Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Border? Class Default
.head 5 -  Justify: Class Default
.head 5 -  Format: Class Default
.head 5 -  Country: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Input Mask: Class Default
.head 4 -  Message Actions
.head 3 +  Data Field: dfCKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 1
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    1.6"
.head 6 -  Width:  0.6"
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
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 5 +  On SAM_AnyEdit
.head 6 -  Call SalEnableWindow(pbSave)
.head 5 +  On SAM_Validate
.head 6 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 6 -  Call CreateKod()
.head 6 -  Return VALIDATE_Ok
.head 5 +  On SAM_User
.head 6 +  If dfCKod
.head 7 -  Call SqlPrepareAndExecute(hSql(), 
"SELECT name INTO :dfCName FROM K_DFM01b WHERE code=:dfCKod")
.head 7 +  If NOT SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set dfCKod = ''
.head 8 -  Set dfCName = ''
.head 3 +  Data Field: dfCName
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
.head 6 -  Left:   3.15"
.head 6 -  Top:    1.595"
.head 6 -  Width:  5.0"
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
.head 3 +  Pushbutton: pbCKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbHelp
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   8.2"
.head 5 -  Top:    1.595"
.head 5 -  Width:  0.35"
.head 5 -  Width Editable? No
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? No
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
.head 4 -  Picture Transparent Color: White
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
.head 5 +  On SAM_Click
.head 6 +  If FunNSIGetFiltered("K_DFM01B", "", " code is not null and (d_close is null or d_close > bankdate) ORDER BY code", sPK, sPKName)
.head 7 -  Set dfCKod = sPK
.head 7 -  Set dfCName = sPKName
.head 7 -  Call SalEnableWindow(pbSave)
.head 7 -  Call CreateKod()
.head 3 -  Background Text: що передається
.head 4 -  Resource Id: 19340
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.3"
.head 5 -  Top:    1.95"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgDKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cLabelControl
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Class Default
.head 5 -  Data Type: Class Default
.head 5 -  Editable? Class Default
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   Default
.head 6 -  Top:    Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Border? Class Default
.head 5 -  Justify: Class Default
.head 5 -  Format: Class Default
.head 5 -  Country: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Input Mask: Class Default
.head 4 -  Message Actions
.head 3 +  Data Field: dfDKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 1
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    1.9"
.head 6 -  Width:  0.6"
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
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 5 +  On SAM_AnyEdit
.head 6 -  Call SalEnableWindow(pbSave)
.head 5 +  On SAM_Validate
.head 6 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 6 -  Call CreateKod()
.head 6 -  Return VALIDATE_Ok
.head 5 +  On SAM_User
.head 6 +  If dfDKod
.head 7 -  Call SqlPrepareAndExecute(hSql(), 
"SELECT name INTO :dfDName FROM K_DFM01b WHERE code=:dfDKod")
.head 7 +  If NOT SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set dfDKod = ''
.head 8 -  Set dfDName = ''
.head 3 +  Data Field: dfDName
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
.head 6 -  Left:   3.15"
.head 6 -  Top:    1.905"
.head 6 -  Width:  5.0"
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
.head 3 +  Pushbutton: pbDKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbHelp
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   8.2"
.head 5 -  Top:    1.905"
.head 5 -  Width:  0.35"
.head 5 -  Width Editable? No
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? No
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
.head 4 -  Picture Transparent Color: White
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
.head 5 +  On SAM_Click
.head 6 +  If FunNSIGetFiltered("K_DFM01B", "", " code is not null and (d_close is null or d_close > bankdate) ORDER BY code", sPK, sPKName)
.head 7 -  Set dfDKod= sPK
.head 7 -  Set dfDName = sPKName
.head 7 -  Call SalEnableWindow(pbSave)
.head 7 -  Call CreateKod()
.head 3 -  !
.head 3 -  Group Box: Місцезнаходження об'єкта
.head 4 -  Resource Id: 38379
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    2.3"
.head 5 -  Width:  8.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.9"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: що одержується
.head 4 -  Resource Id: 19339
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.3"
.head 5 -  Top:    2.6"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgEKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cLabelControl
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Class Default
.head 5 -  Data Type: Class Default
.head 5 -  Editable? Class Default
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   Default
.head 6 -  Top:    Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Border? Class Default
.head 5 -  Justify: Class Default
.head 5 -  Format: Class Default
.head 5 -  Country: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Input Mask: Class Default
.head 4 -  Message Actions
.head 3 +  Data Field: dfEKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 1
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    2.55"
.head 6 -  Width:  0.6"
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
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 5 +  On SAM_AnyEdit
.head 6 -  Call SalEnableWindow(pbSave)
.head 5 +  On SAM_Validate
.head 6 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 6 -  Call CreateKod()
.head 6 -  Return VALIDATE_Ok
.head 5 +  On SAM_User
.head 6 +  If dfEKod
.head 7 -  Call SqlPrepareAndExecute(hSql(), 
"SELECT name INTO :dfEName FROM K_DFM01c WHERE code=:dfEKod")
.head 7 +  If NOT SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set dfEKod = ''
.head 8 -  Set dfEName = ''
.head 3 +  Data Field: dfEName
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
.head 6 -  Left:   3.15"
.head 6 -  Top:    2.548"
.head 6 -  Width:  5.0"
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
.head 3 +  Pushbutton: pbEKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbHelp
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   8.2"
.head 5 -  Top:    2.548"
.head 5 -  Width:  0.35"
.head 5 -  Width Editable? No
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? No
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
.head 4 -  Picture Transparent Color: White
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
.head 5 +  On SAM_Click
.head 6 +  If FunNSIGetFiltered("K_DFM01C", "", " code is not null and (d_close is null or d_close > bankdate) ORDER BY code", sPK, sPKName)
.head 7 -  Set dfEKod = sPK
.head 7 -  Set dfEName = sPKName
.head 7 -  Call SalEnableWindow(pbSave)
.head 7 -  Call CreateKod()
.head 3 -  Background Text: що передається
.head 4 -  Resource Id: 19338
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.3"
.head 5 -  Top:    2.9"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgFKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cLabelControl
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Class Default
.head 5 -  Data Type: Class Default
.head 5 -  Editable? Class Default
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   Default
.head 6 -  Top:    Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Border? Class Default
.head 5 -  Justify: Class Default
.head 5 -  Format: Class Default
.head 5 -  Country: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Input Mask: Class Default
.head 4 -  Message Actions
.head 3 +  Data Field: dfFKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 1
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    2.85"
.head 6 -  Width:  0.6"
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
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 5 +  On SAM_AnyEdit
.head 6 -  Call SalEnableWindow(pbSave)
.head 5 +  On SAM_Validate
.head 6 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 6 -  Call CreateKod()
.head 6 -  Return VALIDATE_Ok
.head 5 +  On SAM_User
.head 6 +  If dfFKod
.head 7 -  Call SqlPrepareAndExecute(hSql(), 
"SELECT name INTO :dfFName FROM K_DFM01c WHERE code=:dfFKod")
.head 7 +  If NOT SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set dfFKod = ''
.head 8 -  Set dfFName = ''
.head 3 +  Data Field: dfFName
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
.head 6 -  Left:   3.15"
.head 6 -  Top:    2.845"
.head 6 -  Width:  5.0"
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
.head 3 +  Pushbutton: pbFKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbHelp
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   8.2"
.head 5 -  Top:    2.845"
.head 5 -  Width:  0.35"
.head 5 -  Width Editable? No
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? No
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
.head 4 -  Picture Transparent Color: White
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
.head 5 +  On SAM_Click
.head 6 +  If FunNSIGetFiltered("K_DFM01C", "", " code is not null and (d_close is null or d_close > bankdate) ORDER BY code", sPK, sPKName)
.head 7 -  Set dfFKod= sPK
.head 7 -  Set dfFName = sPKName
.head 7 -  Call SalEnableWindow(pbSave)
.head 7 -  Call CreateKod()
.head 3 -  !
.head 3 -  Group Box: Об'єкт операції
.head 4 -  Resource Id: 38376
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    3.25"
.head 5 -  Width:  8.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.9"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: що одержується
.head 4 -  Resource Id: 19337
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.3"
.head 5 -  Top:    3.55"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgGKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cLabelControl
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Class Default
.head 5 -  Data Type: Class Default
.head 5 -  Editable? Class Default
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   Default
.head 6 -  Top:    Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Border? Class Default
.head 5 -  Justify: Class Default
.head 5 -  Format: Class Default
.head 5 -  Country: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Input Mask: Class Default
.head 4 -  Message Actions
.head 3 +  Data Field: dfGKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 4
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    3.5"
.head 6 -  Width:  0.6"
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
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 5 +  On SAM_AnyEdit
.head 6 -  Call SalEnableWindow(pbSave)
.head 5 +  On SAM_Validate
.head 6 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 6 -  Call CreateKod()
.head 6 -  Return VALIDATE_Ok
.head 5 +  On SAM_User
.head 6 +  If dfGKod
.head 7 -  Call SqlPrepareAndExecute(hSql(), 
"SELECT substr(name,1,254) INTO :dfGName 
 FROM K_DFM01d WHERE code=:dfGKod")
.head 7 +  If NOT SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set dfGKod = ''
.head 8 -  Set dfGName = ''
.head 3 +  Data Field: dfGName
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
.head 6 -  Left:   3.15"
.head 6 -  Top:    3.5"
.head 6 -  Width:  5.0"
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
.head 3 +  Pushbutton: pbGKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbHelp
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   8.2"
.head 5 -  Top:    3.5"
.head 5 -  Width:  0.35"
.head 5 -  Width Editable? No
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? No
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
.head 4 -  Picture Transparent Color: White
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
.head 5 +  On SAM_Click
.head 6 +  If FunNSIGetFiltered("K_DFM01D", "", " code is not null and (d_close is null or d_close > bankdate) ORDER BY code", sPK, sPKName)
.head 7 -  Set dfGKod = sPK
.head 7 -  Set dfGName = sPKName
.head 7 -  Call SalEnableWindow(pbSave)
.head 7 -  Call CreateKod()
.head 3 -  Background Text: що передається
.head 4 -  Resource Id: 19336
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.3"
.head 5 -  Top:    3.85"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgJKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cLabelControl
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Class Default
.head 5 -  Data Type: Class Default
.head 5 -  Editable? Class Default
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   Default
.head 6 -  Top:    Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Border? Class Default
.head 5 -  Justify: Class Default
.head 5 -  Format: Class Default
.head 5 -  Country: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Input Mask: Class Default
.head 4 -  Message Actions
.head 3 +  Data Field: dfJKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 4
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    3.8"
.head 6 -  Width:  0.6"
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
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 5 +  On SAM_AnyEdit
.head 6 -  Call SalEnableWindow(pbSave)
.head 5 +  On SAM_Validate
.head 6 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 6 -  Call CreateKod()
.head 6 -  Return VALIDATE_Ok
.head 5 +  On SAM_User
.head 6 +  If dfJKod
.head 7 -  Call SqlPrepareAndExecute(hSql(), 
"SELECT substr(name,1,254) INTO :dfJName 
 FROM K_DFM01d WHERE code=:dfJKod")
.head 7 +  If NOT SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set dfJKod = ''
.head 8 -  Set dfJName = ''
.head 3 +  Data Field: dfJName
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
.head 6 -  Left:   3.15"
.head 6 -  Top:    3.798"
.head 6 -  Width:  5.0"
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
.head 3 +  Pushbutton: pbJKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbHelp
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   8.2"
.head 5 -  Top:    3.798"
.head 5 -  Width:  0.35"
.head 5 -  Width Editable? No
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? No
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
.head 4 -  Picture Transparent Color: White
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
.head 5 +  On SAM_Click
.head 6 +  If FunNSIGetFiltered("K_DFM01D", "", " code is not null and (d_close is null or d_close > bankdate) ORDER BY code", sPK, sPKName)
.head 7 -  Set dfJKod= sPK
.head 7 -  Set dfJName = sPKName
.head 7 -  Call SalEnableWindow(pbSave)
.head 7 -  Call CreateKod()
.head 3 -  !
.head 3 -  Group Box: Відкриття або закриття рахунку
.head 4 -  Resource Id: 38377
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    4.2"
.head 5 -  Width:  8.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.6"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfIKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 1
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    4.45"
.head 6 -  Width:  0.6"
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
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 5 +  On SAM_AnyEdit
.head 6 -  Call SalEnableWindow(pbSave)
.head 5 +  On SAM_Validate
.head 6 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 6 -  Call CreateKod()
.head 6 -  Return VALIDATE_Ok
.head 5 +  On SAM_User
.head 6 +  If dfIKod
.head 7 -  Call SqlPrepareAndExecute(hSql(), 
"SELECT name INTO :dfIName FROM K_DFM01e WHERE code=:dfIKod")
.head 7 +  If NOT SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set dfIKod = ''
.head 8 -  Set dfIName = ''
.head 3 +  Data Field: dfIName
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
.head 6 -  Left:   3.15"
.head 6 -  Top:    4.452"
.head 6 -  Width:  5.0"
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
.head 3 +  Pushbutton: pbIKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbHelp
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   8.2"
.head 5 -  Top:    4.452"
.head 5 -  Width:  0.35"
.head 5 -  Width Editable? No
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? No
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
.head 4 -  Picture Transparent Color: White
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
.head 5 +  On SAM_Click
.head 6 +  If FunNSIGetFiltered("K_DFM01E", "", " code is not null and (d_close is null or d_close > bankdate) ORDER BY code", sPK, sPKName)
.head 7 -  Set dfIKod = sPK
.head 7 -  Set dfIName = sPKName
.head 7 -  Call SalEnableWindow(pbSave)
.head 7 -  Call CreateKod()
.head 3 -  !
.head 3 +  Pushbutton: pbSave
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Зберегти
.head 4 -  Window Location and Size
.head 5 -  Left:   0.6"
.head 5 -  Top:    4.9"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
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
.head 6 -  Set sKodDFM01 = dfKod
.head 6 -  Call SalEndDialog(hWndForm,1)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Відмінити
.head 4 -  Window Location and Size
.head 5 -  Left:   6.65"
.head 5 -  Top:    4.905"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.448"
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
.head 6 -  Call SalDestroyWindow(hWndForm)
.head 6 -  Call SalEndDialog(hWndForm,0)
.head 2 +  Functions
.head 3 +  Function: CreateKod
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Set dfKod = 
  IifS(dfAKod!='', dfAKod, ' ') || IifS(dfBKod!='', dfBKod, ' ') || 
  IifS(dfCKod!='', dfCKod, ' ') || IifS(dfDKod!='', dfDKod, ' ') || 
  IifS(dfEKod!='', dfEKod, ' ') || IifS(dfFKod!='', dfFKod, ' ') || 
  IifS(dfGKod!='', dfGKod, '     ') || IifS(dfJKod!='', dfJKod, '     ') || 
  IifS(dfIKod!='', dfIKod, ' ')
.head 2 +  Window Parameters
.head 3 -  Number: nParEdit
.head 3 -  Receive String: sKodDFM01
.head 2 +  Window Variables
.head 3 -  String: sPK
.head 3 -  String: sPKName
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 -  Call SalDisableWindow(pbSave)
.head 4 +  If NOT nParEdit
.head 5 -  Call SalDisableWindow(dfAKod)
.head 5 -  Call SalDisableWindow(dfBKod)
.head 5 -  Call SalDisableWindow(dfCKod)
.head 5 -  Call SalDisableWindow(dfDKod)
.head 5 -  Call SalDisableWindow(dfEKod)
.head 5 -  Call SalDisableWindow(dfFKod)
.head 5 -  Call SalDisableWindow(dfGKod)
.head 5 -  Call SalDisableWindow(dfJKod)
.head 5 -  Call SalDisableWindow(dfIKod)
.head 5 -  Call SalDisableWindow(pbAKod)
.head 5 -  Call SalDisableWindow(pbBKod)
.head 5 -  Call SalDisableWindow(pbCKod)
.head 5 -  Call SalDisableWindow(pbDKod)
.head 5 -  Call SalDisableWindow(pbEKod)
.head 5 -  Call SalDisableWindow(pbFKod)
.head 5 -  Call SalDisableWindow(pbGKod)
.head 5 -  Call SalDisableWindow(pbJKod)
.head 5 -  Call SalDisableWindow(pbIKod)
.head 4 -  Set dfKod  = sKodDFM01
.head 4 -  Set dfAKod = SalStrMidX(sKodDFM01, 0, 1)
.head 4 -  Set dfBKod = SalStrMidX(sKodDFM01, 1, 1)
.head 4 -  Set dfCKod = SalStrMidX(sKodDFM01, 2, 1)
.head 4 -  Set dfDKod = SalStrMidX(sKodDFM01, 3, 1)
.head 4 -  Set dfEKod = SalStrMidX(sKodDFM01, 4, 1)
.head 4 -  Set dfFKod = SalStrMidX(sKodDFM01, 5, 1)
.head 4 -  Set dfGKod = SalStrMidX(sKodDFM01, 6, 4)
.head 4 -  Set dfJKod = SalStrMidX(sKodDFM01, 10, 4)
.head 4 -  Set dfIKod = SalStrMidX(sKodDFM01, 14, 1)
.head 1 -  ! Установка курсов покупки/продажи валют
.head 1 +  Table Window: Tbl_CurRates
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Установка курсов покупки/продажи валют
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Class Default
.head 2 -  Visible? Class Default
.head 2 -  Display Settings
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? Class Default
.head 3 -  Initial State: Class Default
.head 3 -  Maximizable? Class Default
.head 3 -  Minimizable? Class Default
.head 3 -  System Menu? Class Default
.head 3 -  Resizable? Class Default
.head 3 -  Window Location and Size
.head 4 -  Left:   1.375"
.head 4 -  Top:    1.146"
.head 4 -  Width:  7.45"
.head 4 -  Width Editable? Class Default
.head 4 -  Height: 5.143"
.head 4 -  Height Editable? Class Default
.head 3 -  Font Name: Class Default
.head 3 -  Font Size: Class Default
.head 3 -  Font Enhancement: Class Default
.head 3 -  Text Color: Class Default
.head 3 -  Background Color: Class Default
.head 3 -  View: Class Default
.head 3 -  Allow Row Sizing? Class Default
.head 3 -  Lines Per Row: Class Default
.head 2 -  Memory Settings
.head 3 -  Maximum Rows in Memory: Class Default
.head 3 -  Discardable? Class Default
.head 2 -  Description:
.head 2 -  Named Menus
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Class Default
.head 4 -  Location? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Size: 2.274"
.head 4 -  Size Editable? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 3 +  Contents
.head 4 +  Pushbutton: pbIns
.head 5 -  Class Child Ref Key: 33
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbDel
.head 5 -  Class Child Ref Key: 34
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbRefresh
.head 5 -  Class Child Ref Key: 35
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbUpdate
.head 5 -  Class Child Ref Key: 36
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 10833
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 +  Pushbutton: pbSearch
.head 5 -  Class Child Ref Key: 38
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbFilter
.head 5 -  Class Child Ref Key: 44
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbDetails
.head 5 -  Class Child Ref Key: 39
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 40
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 10834
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 +  Pushbutton: pbExit
.head 5 -  Class Child Ref Key: 42
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 10835
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 -  Group Box: Предыдущий банковский день
.head 5 -  Resource Id: 32039
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Window Location and Size
.head 6 -  Left:   -0.017"
.head 6 -  Top:    0.488"
.head 6 -  Width:  7.3"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 1.333"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 4 -  Group Box: Текущий банковский день
.head 5 -  Resource Id: 32040
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Window Location and Size
.head 6 -  Left:   -0.017"
.head 6 -  Top:    1.821"
.head 6 -  Width:  7.3"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 1.107"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 4 +  Data Field: df1
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Editable? No
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   5.283"
.head 7 -  Top:    1.929"
.head 7 -  Width:  1.9"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.25"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? No
.head 6 -  Justify: Right
.head 6 -  Format: dd/MM/yyyy
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Bold
.head 6 -  Text Color: Royal Blue
.head 6 -  Background Color: 3D Face Color
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 +  Data Field: df2
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Editable? No
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   5.25"
.head 7 -  Top:    0.619"
.head 7 -  Width:  1.9"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.25"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? No
.head 6 -  Justify: Right
.head 6 -  Format: dd/MM/yyyy
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Bold
.head 6 -  Text Color: Royal Blue
.head 6 -  Background Color: 3D Face Color
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 +  Data Field: dfCur
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Editable? No
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   1.817"
.head 7 -  Top:    0.726"
.head 7 -  Width:  1.267"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.25"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? No
.head 6 -  Justify: Left
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Bold
.head 6 -  Text Color: Royal Blue
.head 6 -  Background Color: 3D Face Color
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 +  Data Field: dfCurB
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Editable? No
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   1.817"
.head 7 -  Top:    1.012"
.head 7 -  Width:  1.267"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.31"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? No
.head 6 -  Justify: Left
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Bold
.head 6 -  Text Color: Royal Blue
.head 6 -  Background Color: 3D Face Color
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 +  Data Field: dfCurS
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Editable? No
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   1.817"
.head 7 -  Top:    1.345"
.head 7 -  Width:  1.267"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.202"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? No
.head 6 -  Justify: Left
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Bold
.head 6 -  Text Color: Royal Blue
.head 6 -  Background Color: 3D Face Color
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 -  Background Text: Курс НБУ
.head 5 -  Resource Id: 32041
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.383"
.head 6 -  Top:    0.762"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Justify: Left
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 4 -  Background Text: Курс покупки
.head 5 -  Resource Id: 32043
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.383"
.head 6 -  Top:    1.036"
.head 6 -  Width:  1.2"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Justify: Left
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 4 -  Background Text: Курс продажи
.head 5 -  Resource Id: 32042
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.383"
.head 6 -  Top:    1.31"
.head 6 -  Width:  1.267"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Justify: Left
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 2 +  Contents
.head 3 +  Column: colKV
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colLCV
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
валюты
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Center
.head 4 -  Width:  1.0"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colBSum
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Базовая
сумма
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Center
.head 4 -  Width:  1.0"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colRatO
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Курс НБУ
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.6"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colRatB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Курс
покупки
.head 4 -  Visible? Class Default
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.683"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colRatS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Курс
продажи
.head 4 -  Visible? Class Default
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.717"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Unformatted
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Class Default
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Number: nPar
.head 3 -  String: sPar1
.head 3 -  String: sPar2
.head 2 +  Window Variables
.head 3 -  Date/Time: dBDat
.head 3 -  Number: nMaxDig
.head 3 -  Number: nRow
.head 3 -  Number: nOrderBy
.head 3 -  Window Handle: hColumn
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 -  Set dBDat = GetBankDate()
.head 4 -  Set df1 = GetBankDate()
.head 4 +  If SqlPrepareAndExecute(hSql(), "SELECT max(fdat) INTO :Tbl_CurRates.df2 FROM fdat WHERE fdat<bankdate")
.head 5 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 4 -  Set nOrderBy = 1
.head 4 -  Set Tbl_CurRates.nFlags = GT_NoDel | GT_NoIns
.head 4 -  Call SalDisableWindow( pbDetails )
.head 4 -  Set Tbl_CurRates.strFilterTblName = 'CUR_RATES'
.head 4 -  Set Tbl_CurRates.strPrintFileName = 'CUR_RATES'
.head 4 -  Set Tbl_CurRates.strSqlPopulate = 
"SELECT t.kv, t.lcv, CUR_RATES.bsum, CUR_RATES.rate_o, CUR_RATES.rate_b, CUR_RATES.rate_s 
 INTO :Tbl_CurRates.colKV, :Tbl_CurRates.colLCV, :Tbl_CurRates.colBSum, 
      :Tbl_CurRates.colRatO, :Tbl_CurRates.colRatB, :Tbl_CurRates.colRatS 
 FROM tabval t, CUR_RATES 
 WHERE t.kv=CUR_RATES.kv AND CUR_RATES.vdate=:Tbl_CurRates.dBDat"
.head 4 -  Set Tbl_CurRates.strSqlUpdate = 
"UPDATE cur_rates 
 SET rate_b=:Tbl_CurRates.colRatB, rate_s=:Tbl_CurRates.colRatS
 WHERE kv=:Tbl_CurRates.colKV and vdate=:Tbl_CurRates.dBDat"
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On SAM_RowSetContext
.head 4 +  If SqlPrepareAndExecute(hSql(), 
"SELECT rate_o, rate_b, rate_s 
 INTO :Tbl_CurRates.dfCur, :Tbl_CurRates.dfCurB, :Tbl_CurRates.dfCurS
 FROM cur_rates WHERE vdate=(SELECT max(fdat) from fdat WHERE fdat<bankdate)
 AND kv=:Tbl_CurRates.colKV")
.head 5 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 1 +  Dialog Box: Dlg_AddVid
.head 2 -  Class: cGenericTableDlg
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title:
.head 2 -  Accesories Enabled? Class Default
.head 2 -  Visible? Class Default
.head 2 -  Display Settings
.head 3 -  Display Style? Class Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Class Default
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Height: 3.7"
.head 4 -  Height Editable? Class Default
.head 3 -  Absolute Screen Location? Class Default
.head 3 -  Font Name: Class Default
.head 3 -  Font Size: Class Default
.head 3 -  Font Enhancement: Class Default
.head 3 -  Text Color: Class Default
.head 3 -  Background Color: Class Default
.head 2 -  Description:
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Class Default
.head 4 -  Location? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Size: Class Default
.head 4 -  Size Editable? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 3 +  Contents
.head 4 +  Pushbutton: pbIns
.head 5 -  Class Child Ref Key: 11
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbDel
.head 5 -  Class Child Ref Key: 12
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbRefresh
.head 5 -  Class Child Ref Key: 20
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbUpdate
.head 5 -  Class Child Ref Key: 15
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 1177
.head 5 -  Class Child Ref Key: 19
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 +  Pushbutton: pbSearch
.head 5 -  Class Child Ref Key: 13
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbFilter
.head 5 -  Class Child Ref Key: 23
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 14
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 1178
.head 5 -  Class Child Ref Key: 21
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 +  Pushbutton: pbOk
.head 5 -  Class Child Ref Key: 16
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbExit
.head 5 -  Class Child Ref Key: 17
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 1179
.head 5 -  Class Child Ref Key: 22
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 2 +  Contents
.head 3 +  Child Table: tbl
.head 4 -  Class Child Ref Key: 8
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenericTableDlg
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 2.8"
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
.head 5 +  Column: colVid
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: 4
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Center
.head 6 -  Width:  0.8"
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 +  Message Actions
.head 7 +  On SAM_SetFocus
.head 8 -  Set sTmpVid = MyValue
.head 8 +  If SalTblQueryRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_New)
.head 9 -  Call SalStatusSetText(hWndForm, 'F4-вибрати з довідника')
.head 8 +  Else
.head 9 -  Call SalStatusSetText(hWndForm, '')
.head 7 +  On SAM_AnyEdit
.head 8 +  If not SalTblQueryRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_New)
.head 9 -  Set colVid = sTmpVid
.head 7 +  On SAM_Validate
.head 8 +  If not SalIsNull(hWndItem)
.head 9 -  Call SqlPrepareAndExecute(hSql(), 
"select name into :tbl.colName from k_dfm0"|| Str(nKod) || " where code=:tbl.colVid")
.head 9 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 10 -  Call SalMessageBox('Невідомий код!', 'Увага!', MB_IconStop | MB_Ok)
.head 10 -  Return VALIDATE_Cancel
.head 8 -  Return VALIDATE_Ok
.head 7 +  On SAM_DoubleClick
.head 8 -  Set nRow = SalTblQueryContext(hWndForm)
.head 8 +  If SalTblQueryRowFlags(hWndForm, nRow, ROW_New)
.head 9 +  If FunNSIGetFiltered("K_DFM0" || Str(nKod), 'name', ' 1=1 order by code', s1, s2)
.head 10 -  Set colVid = s1
.head 10 -  Set colName = s2
.head 9 -  Call SalSetFocus(hWndForm)
.head 9 -  Call SalTblSetFocusRow(hWndForm, nRow)
.head 9 -  Call SalTblSetFocusCell(hWndForm, nRow, colVid, 0, 0)
.head 7 +  On VTM_KeyDown
.head 8 +  If wParam = VK_F4
.head 9 -  Call SalSendMsg(hWndItem, SAM_DoubleClick, 0, 0)
.head 7 +  On SAM_KillFocus
.head 8 -  Call SalStatusSetText(hWndForm, '')
.head 5 +  Column: colName
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Назва
.head 6 -  Visible? Class Default
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Long String
.head 6 -  Justify: Class Default
.head 6 -  Width:  4.0"
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colComm
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Коментар
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: 254
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  4.0"
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 4 -  Functions
.head 4 +  Window Variables
.head 5 -  Number: nRow
.head 5 -  String: s1
.head 5 -  String: s2
.head 4 +  Message Actions
.head 5 -  On SAM_DoubleClick
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Number: nId
.head 3 -  Number: nKod
.head 3 -  Boolean: bEdit	! 1-Edit, 0-ReadOnly
.head 2 +  Window Variables
.head 3 -  String: sTmpVid
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSetWindowText(hWndForm, "Ознаки повідомлення, " || IifS(nKod=2, 
  "Обов'язковий моніторинг", 
  "Внутрішній моніторинг"))
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Set strSqlPopulate = 
"select f.vid, k.name, f.comm
 into :Dlg_AddVid.tbl.colVid, 
      :Dlg_AddVid.tbl.colName,
      :Dlg_AddVid.tbl.colComm
 from finmon_que_vid" || Str(nKod) || " f, k_dfm0" || Str(nKod) || " k
 where f.vid=k.code and f.id=:Dlg_AddVid.nId
 order by f.vid"
.head 4 -  Set strSqlInsert = 
"insert into finmon_que_vid" || Str(nKod) || "(id, vid, comm)
 values(:Dlg_AddVid.nId, :Dlg_AddVid.tbl.colVid, :Dlg_AddVid.tbl.colComm)"
.head 4 -  Set strSqlUpdate = 
"update finmon_que_vid" || Str(nKod) || "
 set comm=:Dlg_AddVid.tbl.colComm
 where id=:Dlg_AddVid.nId and vid=:Dlg_AddVid.tbl.colVid"
.head 4 -  Set strSqlDelete = 
"delete from finmon_que_vid" || Str(nKod) || "
 where id=:Dlg_AddVid.nId and vid=:Dlg_AddVid.tbl.colVid"
.head 4 -  Call SalDisableWindow(pbPrint)
.head 4 -  Call SalDisableWindow(pbOk)
.head 4 +  If not bEdit
.head 5 -  Set nFlags = GT_ReadOnly
.head 5 -  Call SalDisableWindow(tbl.colVid)
.head 5 -  Call SalDisableWindow(tbl.colComm)
.head 4 +  If nKod = 2
.head 5 -  Call SalSetMaxDataLength(tbl.colVid, 4)
.head 4 +  Else If nKod = 3
.head 5 -  Call SalSetMaxDataLength(tbl.colVid, 3)
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 1 +  Dialog Box: dlg_FMComments
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Коментар
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  5.8"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 2.5"
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
.head 3 +  Multiline Field: mlComm
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 254
.head 5 -  String Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Border? Yes
.head 5 -  Word Wrap? Yes
.head 5 -  Vertical Scroll? Yes
.head 5 -  Window Location and Size
.head 6 -  Left:   0.1"
.head 6 -  Top:    0.05"
.head 6 -  Width:  5.5"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 1.3"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 4 -  Message Actions
.head 3 -  Frame
.head 4 -  Resource Id: 24741
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    1.4"
.head 5 -  Width:  5.5"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.7"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: Default
.head 4 -  Background Color: Default
.head 3 +  Pushbutton: pbSave
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbUpdate
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Записати
.head 4 -  Window Location and Size
.head 5 -  Left:   2.9"
.head 5 -  Top:    1.55"
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
.head 6 +  If mlComm
.head 7 -  Set sComment = mlComm
.head 7 -  Call SalEndDialog(hWndForm, TRUE)
.head 6 +  Else
.head 7 -  Call SalMessageBox('Не заповнено коментар!', 'Увага!', MB_IconExclamation)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Відмінити
.head 4 -  Window Location and Size
.head 5 -  Left:   4.2"
.head 5 -  Top:    1.55"
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
.head 6 -  Call SalEndDialog(hWndForm, FALSE)
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Receive String: sComment
.head 2 -  Window Variables
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 1 +  Form Window: frm_ImportReft
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Імпорт файлу терористів
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? Yes
.head 3 -  Initial State: Normal
.head 3 -  Maximizable? Yes
.head 3 -  Minimizable? Yes
.head 3 -  System Menu? Yes
.head 3 -  Resizable? Yes
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  6.35"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 2.0"
.head 4 -  Height Editable? Yes
.head 3 -  Form Size
.head 4 -  Width:  Default
.head 4 -  Height: Default
.head 4 -  Number of Pages: Dynamic
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description:
.head 2 -  Named Menus
.head 2 -  Menu
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
.head 3 -  Group Box: Файл для імпорту
.head 4 -  Resource Id: 6885
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.05"
.head 5 -  Width:  6.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.8"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfFileName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 100
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.2"
.head 6 -  Top:    0.35"
.head 6 -  Width:  4.5"
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
.head 3 +  Pushbutton: pbGetPath
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вибрати
.head 4 -  Window Location and Size
.head 5 -  Left:   4.8"
.head 5 -  Top:    0.35"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.298"
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
.head 6 +  If SalDlgOpenFile(hWndForm, 'Open File', strFilters, 2, nIndex, strFile, dfPath)
.head 7 -  Set dfFileName = dfPath
.head 3 -  Frame
.head 4 -  Resource Id: 6886
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.9"
.head 5 -  Width:  6.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.7"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: Default
.head 4 -  Background Color: Default
.head 3 +  Pushbutton: pbOk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Імпорт
.head 4 -  Window Location and Size
.head 5 -  Left:   3.5"
.head 5 -  Top:    1.0"
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
.head 6 +  If IDYES = SalMessageBox("Виконати імпорт файлу терористів " || dfFileName || " ?", "Увага!", MB_IconQuestion | MB_YesNo)
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 +  If not SqlPrepareAndExecute(hSql(), "delete from fm_imp_file")
.head 8 -  Call SqlRollback(hSql())
.head 7 +  Else
.head 8 -  Call SqlCommit(hSql())
.head 8 +  If PutFileToClob(hSql(), dfFileName, 'fm_imp_file', 'id', 'file_data',
1, STRING_Null, STRING_Null, 1)
.head 9 +  If not SqlPLSQLCommand(hSql(), "p_fm_imp_file(nFileId)")
.head 10 -  Call SqlRollback(hSql())
.head 9 +  Else
.head 10 -  Call SalMessageBox("Виконано імпорт файлу " || dfFileName, "Інформація", MB_IconAsterisk | MB_Ok)
.head 10 -  Call SqlCommitEx(hSql(), "Выполнен импорт файла террористов " || dfFileName)
.head 10 -  Call SqlPrepareAndExecute(hSql(), "select count(*) into :nCount from finmon_reft_inperr where id = :nFileId")
.head 10 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 10 +  If nCount
.head 11 +  If IDYES = SalMessageBox("Файл імпортовано з помилками." || PutCrLf() || "Показати помилкові рядки?", "Увага!", MB_IconQuestion | MB_YesNo)
.head 12 -  Call FunNSIEditFFiltered('finmon_reft_inperr', 1, 'id=' || Str(nFileId))
.head 6 -  Call SalWaitCursor(FALSE)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Відмінити
.head 4 -  Window Location and Size
.head 5 -  Left:   4.8"
.head 5 -  Top:    1.0"
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
.head 6 -  Call SalDestroyWindow(hWndForm)
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  String: strFilters[2]
.head 3 -  Number: nIndex
.head 3 -  String: strFile
.head 3 -  String: dfPath
.head 3 -  Number: nFileId
.head 3 -  Number: nCount
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 1 +  ! Dialog Box: dlg_FMFilter_
.winattr
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Вибір правил ФМ
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  8.3"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 6.7"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.end
.head 2 -     Description: 
.head 2 +     Tool Bar 
.head 3 -     Contents 
.head 2 +     Contents 
.head 3 -     Line 
.head 3 -     Background Text: Період відбору документів
.head 3 -     Background Text: з
.head 3 +     Data Field: dfVDat1
.head 4 +     Message Actions 
.head 5 +     On SAM_Validate
.head 6 +     If not SalIsNull(dfVDat1)
.head 7 +     If not SalIsValidDateTime(dfVDat1)
.head 8 -     Call SalMessageBox("Невірний формат дати!", "Увага!", 0)
.head 8 -     Return VALIDATE_Cancel
.head 6 -     Return VALIDATE_Ok
.head 3 -     Background Text: по
.head 3 +     Data Field: dfVDat2
.head 4 +     Message Actions 
.head 5 +     On SAM_Validate
.head 6 +     If not SalIsNull(dfVDat2)
.head 7 +     If not SalIsValidDateTime(dfVDat2)
.head 8 -     Call SalMessageBox("Невірний формат дати!", "Увага!", 0)
.head 8 -     Return VALIDATE_Cancel
.head 6 -     Return VALIDATE_Ok
.head 3 -     Line 
.head 3 +     Child Table: tblRules
.head 4 +     Contents 
.head 5 +     Column: colApply
.head 6 -     List Values 
.head 6 -     Message Actions 
.head 5 +     Column: colId
.head 6 -     List Values 
.head 6 -     Message Actions 
.head 5 +     Column: colName
.head 6 -     List Values 
.head 6 -     Message Actions 
.head 5 +     Column: colVName
.head 6 -     List Values 
.head 6 -     Message Actions 
.head 4 -     Functions 
.head 4 -     Window Variables 
.head 4 +     Message Actions 
.head 5 +     On UM_Populate
.head 6 -     Call SalTblSetTableFlags(hWndForm, TBL_Flag_SingleSelection, TRUE)
.head 6 -     Call SalTblPopulate(hWndForm, hSql(), 
"select id, name, v_name
   into :colId, :colName, :colVName
   from fm_rules
  where v_name is not null
  order by id", TBL_FillAll)
.head 6 -     Call SalTblSetContext(hWndForm, 0)
.head 6 -     Call SalTblSetRowFlags(hWndForm, 0, ROW_Selected, TRUE)
.head 5 +     On SAM_FetchRowDone
.head 6 -     Set colApply = TRUE
.head 3 +     Check Box: cbApplyFilter
.head 4 -     Message Actions 
.head 3 +     Check Box: cbApplyFilter
.head 4 -     Message Actions 
.head 3 -     Line 
.head 3 +     Pushbutton: pbOk
.head 4 +     Message Actions 
.head 5 +     On SAM_Click
.head 6 +     If SalIsNull(dfVDat1)
.head 7 -     Call SalMessageBox("Не вказано дату!", "Увага!", 0)
.head 7 -     Return FALSE
.head 6 +     If SalIsNull(dfVDat2)
.head 7 -     Call SalMessageBox("Не вказано дату!", "Увага!", 0)
.head 7 -     Return FALSE
.head 6 -     Set dDat1 = dfVDat1
.head 6 -     Set dDat2 = dfVDat2
.head 6 -     Set sRuleName = ''
.head 6 -     Set sVName = ''
.head 6 +     If cbApplyFilter
.head 7 -     Set sRuleName = tblRules.colName
.head 7 -     Set sVName = tblRules.colVName
.head 6 -     Call SalEndDialog(hWndForm, TRUE)
.head 3 +     Pushbutton: pbCancel
.head 4 +     Message Actions 
.head 5 +     On SAM_Click
.head 6 -     Call SalEndDialog(hWndForm, FALSE)
.head 2 -     Functions 
.head 2 +     Window Parameters 
.head 3 -     Receive Date/Time: dDat1
.head 3 -     Receive Date/Time: dDat2
.head 3 -     Receive String: sRuleName
.head 3 -     Receive String: sVName
.head 2 -     Window Variables 
.head 2 +     Message Actions 
.head 3 +     On SAM_Create
.head 4 -     Call PrepareWindowEx(hWndForm)
.head 4 -     Set dfVDat1 = dDat1
.head 4 -     Set dfVDat2 = dDat2
.head 4 -     Set cbApplyFilter = TRUE
.head 4 -     Call SalSetFocus(tblRules)
.head 4 -     Call SalSendMsg(tblRules, UM_Populate, 0, 0)
.head 1 +  Dialog Box: dlg_FMFilter
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Вибір правил ФМ
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  8.3"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 6.5"
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
.head 3 -  Line
.head 4 -  Resource Id: 31891
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  0.0"
.head 5 -  Begin Y:  0.05"
.head 5 -  End X:  9.0"
.head 5 -  End Y:  0.05"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Etched
.head 4 -  Line Thickness: 1
.head 4 -  Line Color: Default
.head 3 -  Background Text: Період відбору документів
.head 4 -  Resource Id: 31892
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.2"
.head 5 -  Width:  5.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: з
.head 4 -  Resource Id: 31893
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.55"
.head 5 -  Width:  1.0"
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
.head 3 +  Data Field: dfVDat1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Date/Time
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   1.2"
.head 6 -  Top:    0.5"
.head 6 -  Width:  2.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: dd/MM/yyyy
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Validate
.head 6 +  If not SalIsNull(dfVDat1)
.head 7 +  If not SalIsValidDateTime(dfVDat1)
.head 8 -  Call SalMessageBox("Невірний формат дати!", "Увага!", 0)
.head 8 -  Return VALIDATE_Cancel
.head 6 -  Return VALIDATE_Ok
.head 3 -  Background Text: по
.head 4 -  Resource Id: 31894
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.0"
.head 5 -  Top:    0.512"
.head 5 -  Width:  1.0"
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
.head 3 +  Data Field: dfVDat2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Date/Time
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   5.1"
.head 6 -  Top:    0.5"
.head 6 -  Width:  2.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: dd/MM/yyyy
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Validate
.head 6 +  If not SalIsNull(dfVDat2)
.head 7 +  If not SalIsValidDateTime(dfVDat2)
.head 8 -  Call SalMessageBox("Невірний формат дати!", "Увага!", 0)
.head 8 -  Return VALIDATE_Cancel
.head 6 -  Return VALIDATE_Ok
.head 3 -  Line
.head 4 -  Resource Id: 31895
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  0.0"
.head 5 -  Begin Y:  5.2"
.head 5 -  End X:  9.0"
.head 5 -  End Y:  5.2"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Etched
.head 4 -  Line Thickness: 1
.head 4 -  Line Color: Default
.head 3 +  Child Table: tblRules
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.1"
.head 6 -  Top:    1.05"
.head 6 -  Width:  8.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 3.6"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  View: Table
.head 5 -  Allow Row Sizing? No
.head 5 -  Lines Per Row: Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: Default
.head 5 -  Discardable? Yes
.head 4 +  Contents
.head 5 +  Column: colApply
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Вибрати
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Check Box
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value: 1
.head 8 -  Uncheck Value: 0
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colId
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
правила
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  1.0"
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
.head 6 -  Title: Назва правила
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  5.2"
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
.head 5 +  Column: colVName
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: view
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  2.0"
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
.head 4 +  Functions
.head 5 +  Function: GetRules
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  String:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sRulesList
.head 7 -  Number: nRow
.head 6 +  Actions
.head 7 -  Set sRulesList = ''
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 -  Set nFMRulesApply[colId] = colApply
.head 8 +  If colApply
.head 9 -  Set sRulesList = sRulesList || IifS(sRulesList='', '', ',') || Str(colId)
.head 7 -  Return sRulesList
.head 5 +  Function: SetApply
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Boolean: bApply
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 6 +  Actions
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 -  Set colApply = bApply
.head 7 -  Return TRUE
.head 4 -  Window Variables
.head 4 +  Message Actions
.head 5 +  On UM_Populate
.head 6 -  Call SalTblSetTableFlags(hWndForm, TBL_Flag_SingleSelection, TRUE)
.head 6 -  Call SalTblPopulate(hWndForm, hSql(),
"select id, name, v_name
   into :colId, :colName, :colVName
   from fm_rules
  where v_name is not null
  order by id", TBL_FillAll)
.head 6 -  Call SalTblSetContext(hWndForm, 0)
.head 6 -  Call SalTblSetRowFlags(hWndForm, 0, ROW_Selected, TRUE)
.head 5 +  On SAM_FetchRowDone
.head 6 -  Set colApply = nFMRulesApply[colId]
.head 3 +  Check Box: cbApplyFilter
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cCheckBoxLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Відмітити для всіх правил
.head 4 -  Window Location and Size
.head 5 -  Left:   0.083"
.head 5 -  Top:    4.8"
.head 5 -  Width:  8.0"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call tblRules.SetApply(cbApplyFilter)
.head 3 -  Line
.head 4 -  Resource Id: 31896
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  0.0"
.head 5 -  Begin Y:  0.9"
.head 5 -  End X:  9.0"
.head 5 -  End Y:  0.9"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Etched
.head 4 -  Line Thickness: 1
.head 4 -  Line Color: Default
.head 3 +  Pushbutton: pbOk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Застосувати
.head 4 -  Window Location and Size
.head 5 -  Left:   5.0"
.head 5 -  Top:    5.45"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
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
.head 6 +  If SalIsNull(dfVDat1)
.head 7 -  Call SalMessageBox("Не вказано дату!", "Увага!", 0)
.head 7 -  Return FALSE
.head 6 +  If SalIsNull(dfVDat2)
.head 7 -  Call SalMessageBox("Не вказано дату!", "Увага!", 0)
.head 7 -  Return FALSE
.head 6 -  Set dDat1 = dfVDat1
.head 6 -  Set dDat2 = dfVDat2
.head 6 -  Set sRules = tblRules.GetRules()
.head 6 -  Call SalEndDialog(hWndForm, TRUE)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Відмінити
.head 4 -  Window Location and Size
.head 5 -  Left:   6.5"
.head 5 -  Top:    5.45"
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
.head 6 -  Call SalEndDialog(hWndForm, FALSE)
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Receive Date/Time: dDat1
.head 3 -  Receive Date/Time: dDat2
.head 3 -  Receive String: sRules
.head 3 -  Receive Number: nFMRulesApply[*]
.head 2 -  Window Variables
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Set dfVDat1 = dDat1
.head 4 -  Set dfVDat2 = dDat2
.head 4 -  Set cbApplyFilter = FALSE
.head 4 -  Call SalSetFocus(tblRules)
.head 4 -  Call SalSendMsg(tblRules, UM_Populate, 0, 0)
