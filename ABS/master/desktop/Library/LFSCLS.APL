.head 0 +  Application Description: Библиотека визуальных и функциональных классов
для работы со списком функций, выполняемых автоматически.
(С) Унити-БАРС, 1999-2000
Created:       Самойленко В.С.
Last modified: 31.03.2000 - work with sets of functions.
.head 1 -  Outline Version - 4.0.26
.head 1 +  Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000E70000 002C000000020000 0003000000FFFFFF FFFFFFFFFFF8FFFF
0040: FFE1FFFFFFFFFFFF FF000000007C0200 004D010000010000 0000000000010000
0060: 000F4170706C6963 6174696F6E497465 6D01000000075769 6E646F7773
.enddata
.data DT_MAKERUNDLG
0000: 030000000015513A 5C43454E54555241 5C6E65776170702E 65786515513A5C43
0020: 454E545552415C6E 65776170702E646C 6C15513A5C43454E 545552415C6E6577
0040: 6170702E61706300 0001010115513A5C 43454E545552415C 6E65776170702E72
0060: 756E15513A5C4345 4E545552415C6E65 776170702E646C6C 15513A5C43454E54
0080: 5552415C6E657761 70702E6170630000 01010118513A5C42 41525339385C4249
00A0: 4E5C4C6673636C73 2E61706418513A5C 4241525339385C42 494E5C6E65776170
00C0: 702E646C6C18513A 5C4241525339385C 42494E5C6E657761 70702E6170630001
00E0: 01010115513A5C43 454E545552415C6E 65776170702E6170 6C15513A5C43454E
0100: 545552415C6E6577 6170702E646C6C15 513A5C43454E5455 52415C6E65776170
0120: 702E617063000001 0101
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
0000: 0318B80BB80B2500
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
.head 2 -  Dynalib: AbsApi.apd
.head 2 -  File Include: GenButn.apl
.head 2 -  File Include: GenFcls.apl
.head 2 -  File Include: Genfiltr.apl
.head 2 -  File Include: Genemnu.apl
.head 2 -  File Include: Vtmeter.apl
.head 2 -  File Include: Ttp32.apl
.head 2 -  File Include: Rs_objs.apl
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
.head 3 +  User
.head 2 +  Resources
.head 2 -  Variables
.head 2 +  Internal Functions
.head 2 -  Named Menus
.head 2 +  Class Definitions
.data RESOURCE 0 0 1 3707403569
0000: 79010000D3000000 0000000000000000 0200000300FFFF01 00160000436C6173
0020: 73566172004F7574 6C696E6552006567 496E666F1D003C00 00074C0069737453
0040: 65748600C0000005 0000008302040000 00FFFFE404000002 FE00FF8308000000
0060: 02FB00FF0F0C0000 00E0010D000000FF 3F1900A000000304 0000FFFF00018022
0080: 0000000100000000 0A6347656E460069 6C746572740000EC 0004009D020001FD
00A0: 008380010000007F 046300010D00FFFF C11100000002FD00 FF071500000001F7
00C0: 00FF1F0180040200 0002000000070052 735469746C651EA0 0000000100006702
00E0: 0400FFFF01
.enddata
.head 3 -  ! ------------------------------------------------------------------
.head 3 -  ! Визуальные и функциональные классы для  работы со списками функций
.head 3 -  ! ------------------------------------------------------------------
.head 3 +  Child Table Class: ListFncSet
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:  
.head 6 -  Top:   
.head 6 -  Width:  1.2"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.833"
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
.head 5 -  Maximum Rows in Memory: 1000
.head 5 -  Discardable? No
.head 4 -  Next Class Child Key: 13
.head 4 -  List in Tool Palette? Yes
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Description: Visual Child Table class with additional functionality for managing with BARS's set of functions
.head 4 +  Derived From
.head 5 -  Class: RsTable
.head 4 +  Contents
.head 5 +  Column: FuncId
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 3
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: FuncId
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  Default
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
.head 5 +  Column: FuncName
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 9
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  Default
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
.head 5 +  Column: FuncActivity
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 4
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: V
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  Default
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
.head 5 +  Column: FuncPosition
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 5
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: FuncPosition
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  Default
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
.head 5 +  Column: FuncComments
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 6
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Коментарий
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  Default
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
.head 5 +  Column: FuncCallString
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 8
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: FuncCallString
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 250
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  Default
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
.head 5 +  Column: FuncStatus
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 7
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Статус
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  Default
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
.head 6 +  List Values
.head 7 -  Text: Idle
.head 7 -  Text: Running...
.head 7 -  Text: Failed
.head 7 -  Text: Done
.head 7 -  Text: Ignored
.head 6 -  Message Actions
.head 5 +  Column: FuncRoleName
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 13
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: FuncRoleName
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  Default
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
.head 4 -  Class Variables
.head 4 +  Instance Variables
.head 5 -  Number: SetId
.head 5 -  String: SetName
.head 5 -  String: SetComments
.head 5 -  : DB
.head 6 -  Class: cABSConnect
.head 5 -  : ListFilter
.head 6 -  Class: cGenFilter
.head 5 -  Number: nCount
.head 4 +  Functions
.head 5 +  Function: Constructor
.head 6 -  Description: Perform all necessary preoperations for object existance
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: IdentityCodeOfSet
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: bFetchRes
.head 6 +  Actions
.head 7 -  Call XConnectGetParams(DB)
.head 7 -  ! После подключения к АБС эту часть можно удалить
.head 7 -  ! Call DB.Define("bars","bars","bars",TRUE)
.head 7 -  ! Конец
.head 7 -  Call DB.Connect()
.head 7 -  Set SetId = IdentityCodeOfSet
.head 7 -  Set nCount = 0
.head 7 -  Call SqlPrepareAndExecute( DB.hSql(), '
SELECT 	Name,Comments
FROM 	List_Set
INTO 	:SetName,:SetComments
WHERE	Id =  :SetId ')
.head 7 -  Call SqlFetchNext( DB.hSql(), bFetchRes )
.head 7 -  Call ListFilter.Init( 'OPERLIST', 'o' )
.head 5 +  Function: Destructor
.head 6 -  Description: Clear traces of object
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Call DB.Disconnect()
.head 5 +  Function: Fill
.head 6 -  Description: Perform filling of table from DB according to Set_Id
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: strFilter
.head 6 +  Actions
.head 7 -  Call SalWaitCursor( TRUE )
.head 7 -  !
.head 7 -  Set strFilter = ListFilter.GetFilterWhereClause( FALSE )
.head 7 -  !
.head 7 +  If SetId != -1
.head 8 +  If strFilter
.head 9 -  Set strFilter = ' AND ' || strFilter
.head 8 -  Call SalTblPopulate( hWndItem, DB.hSql(),"
SELECT 	substr(o.funcname,1,254)  ,FS.Func_Id,o.name,FS.Func_Position,FS.Func_Activity,FS.Func_Comments,'Idle',o.rolename
FROM     	operlist o, List_FuncSet FS
INTO      	:FuncCallString,:FuncId,:FuncName,:FuncPosition,:FuncActivity,:FuncComments,:FuncStatus,:FuncRoleName
WHERE 	Set_Id =:SetId 
AND	o.codeoper = FS.Func_Id " || strFilter || "
ORDER BY FS.Func_Position", TBL_FillAll)
.head 7 +  Else
.head 8 +  If strFilter
.head 9 -  Set strFilter = ' WHERE ' || strFilter
.head 8 -  Call SalTblPopulate( hWndItem, DB.hSql(),"
SELECT 	o.funcname, o.codeoper, o.name, 'Idle', o.rolename
FROM operlist o
INTO  :FuncCallString, :FuncId, :FuncName, :FuncStatus, :FuncRoleName " ||
strFilter || 
"ORDER BY o.codeoper", TBL_FillAll)
.head 7 -  Call SalWaitCursor( FALSE )
.head 5 +  Function: FillMinusSet
.head 6 -  Description: Perform filling of table from DB according to Set_Id
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: MinusSetId
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: strFilter
.head 6 +  Actions
.head 7 -  Call SalWaitCursor( TRUE )
.head 7 -  !
.head 7 -  Set strFilter = ListFilter.GetFilterWhereClause( FALSE )
.head 7 +  If strFilter
.head 8 -  Set strFilter = ' AND ' || strFilter
.head 7 -  !
.head 7 +  If SetId != -1
.head 8 -  Call SalTblPopulate( hWndItem, DB.hSql(),  '
SELECT 	o.funcname,FS.Func_Id,o.name,FS.Func_Position,FS.Func_Activity,FS.Func_Comments,\'Idle\',o.rolename
FROM    operlist o, List_FuncSet FS
INTO    :FuncCallString,:FuncId,:FuncName,:FuncPosition,:FuncActivity,:FuncComments,:FuncStatus,:FuncRoleName
WHERE 	FS.Set_Id 	= :SetId
AND 	o.codeoper 	= FS.Func_Id ' ||
strFilter ||
' AND	FS.Func_Id	NOT IN (
				SELECT	Func_Id
				FROM	List_FuncSet
				WHERE	Set_Id = :MinusSetId )
ORDER BY Func_Position ', TBL_FillAll)
.head 7 +  Else
.head 8 -  Call SalTblPopulate( hWndItem, DB.hSql(),  '
SELECT 	o.funcname,o.codeoper,o.name,\'Idle\',o.rolename
FROM    operlist o 
INTO    :FuncCallString,:FuncId,:FuncName,:FuncStatus,:FuncRoleName 
WHERE	o.codeoper	NOT IN (
				SELECT	Func_Id
				FROM	List_FuncSet
				WHERE	Set_Id = :MinusSetId ) ' ||
strFilter ||
' ORDER BY o.codeoper ', TBL_FillAll)
.head 7 -  Call SalWaitCursor( FALSE )
.head 5 +  Function: Adjust
.head 6 -  Description: Purpose to perform adjusting visual table to DB table
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nIndex
.head 7 -  Number: nFuncId
.head 7 -  Number: nAct
.head 7 -  Number: nPos
.head 7 -  String: sCom
.head 7 -  String: sFuncId
.head 7 -  String: sAct
.head 6 +  Actions
.head 7 -  Call SqlPrepareAndExecute( DB.hSql(),'
DELETE
FROM 	List_FuncSet
WHERE 	Set_Id = :SetId' )
.head 7 -  Set nIndex = TBL_MinRow
.head 7 +  Loop
.head 8 +  If SalTblFindNextRow( hWndItem, nIndex,0, 0 )
.head 9 -  Call SalTblSetContext( hWndItem , nIndex )
.head 9 -  Call SalTblGetColumnText ( hWndItem , 1 , sFuncId )
.head 9 -  Set nFuncId = SalStrToNumber ( sFuncId )
.head 9 -  Call SalTblGetColumnText ( hWndItem , 3 , sAct )
.head 9 -  Set nAct = SalStrToNumber ( sAct )
.head 9 -  Call SalTblGetColumnText ( hWndItem , 5 , sCom )
.head 9 -  Set nPos = nIndex + 1
.head 9 -  Call SqlPrepareAndExecute( DB.hSql(),    '
            	INSERT INTO List_FuncSet
                (	Func_Id,Set_Id,Func_Activity,Func_Position,Func_Comments)
                VALUES
                (	:nFuncId ,	:SetId,:nAct,:nPos,:sCom)  ')
.head 8 +  Else
.head 9 -  Break
.head 7 -  Call SqlCommit(DB.hSql())
.head 5 +  ! Function: EvaluateSet
.head 6 -  Description: Purpose to run sequence of functions which composed from set
according to their position
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Boolean: fReturn
.head 7 -  Number: nError
.head 7 -  Number: nErrorPos
.head 7 -  Number: nReturn
.head 7 -  Number: nIndex
.head 7 -  String: strReturn
.head 7 -  Date/Time: dtReturn
.head 7 -  Window Handle: hWndReturn
.head 6 +  Actions
.head 7 -  Set fReturn = TRUE
.head 7 -  Set nIndex = TBL_MinRow
.head 7 +  Loop
.head 8 +  If SalTblFindNextRow( hWndItem, nIndex, 0, 0 )
.head 9 -  Call SalTblSetFocusRow( hWndItem, nIndex )
.head 9 -  Call SalTblSetContext( hWndItem , nIndex )
.head 9 +  If hWndItem.FuncActivity
.head 10 -  Call SaveInfoToLog( 'Старт выполнения функции списка ' || hWndItem.FuncName )
.head 10 -  Call SalTblSetCellTextColor( hWndItem.FuncStatus, COLOR_Blue, FALSE )
.head 10 -  Set hWndItem.FuncStatus = 'Running...'
.head 10 +  If SalCompileAndEvaluate( hWndItem.FuncCallString , nError , nErrorPos, nReturn, strReturn, dtReturn, hWndReturn, FALSE, SalContextCurrent ( ) )
.head 11 -  Call SqlCommitEx(DB.hSql(), 'Функция - ' || hWndItem.FuncName)
.head 11 -  Call SalTblSetCellTextColor( hWndItem.FuncStatus, COLOR_DarkGreen, FALSE )
.head 11 -  Set hWndItem.FuncStatus = 'Done'
.head 10 +  Else
.head 11 -  Call SalTblSetCellTextColor( hWndItem.FuncStatus, COLOR_DarkRed, FALSE )
.head 11 -  Set hWndItem.FuncStatus = 'Failed'
.head 11 -  Set fReturn = FALSE
.head 9 +  Else
.head 10 -  Call SalTblSetCellTextColor( hWndItem.FuncStatus, COLOR_Magenta, FALSE )
.head 10 -  Set hWndItem.FuncStatus = 'Ignore'
.head 8 +  Else
.head 9 -  Break
.head 7 +  If fReturn
.head 8 -  Return TRUE
.head 7 +  Else
.head 8 -  Return FALSE
.head 5 +  Function: AddFunc
.head 6 -  Description: Purpose is to add function to current functions' set
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  Number: nFuncId
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nPos
.head 7 -  Number: nFetchRes
.head 7 -  String: sName
.head 7 -  String: sCallString
.head 6 +  Actions
.head 7 -  Set nPos = SalTblInsertRow( hWndItem, TBL_MaxRow )
.head 7 -  Call SalTblSetContext( hWndItem, nPos )
.head 7 -  Call SalTblSetColumnText( hWndItem,1 , SalNumberToStrX( nFuncId, 0 ) )
.head 7 -  Call SalTblSetColumnText( hWndItem,3 , SalNumberToStrX( 0, 0 ) )
.head 7 -  Call SalTblSetColumnText( hWndItem,4 , SalNumberToStrX( nPos, 0 ) )
.head 7 -  Call SalTblSetColumnText( hWndItem,5 , '' )
.head 7 -  Call SalTblSetColumnText( hWndItem,7 , 'Idle' )
.head 7 -  Call SqlPrepareAndExecute( DB.hSql(), '
SELECT name , funcname
FROM operlist
INTO :sName,:sCallString
WHERE codeoper = :nFuncId' )
.head 7 -  Call SqlFetchNext( DB.hSql(), nFetchRes )
.head 7 -  Call SalTblSetColumnText( hWndItem,2 , sName )
.head 7 -  Call SalTblSetColumnText( hWndItem,6 , sCallString )
.head 5 +  Function: RemFunc
.head 6 -  Description: Purpose to remove function from functions' set
determine function to it position in set
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  Number: nFuncPos
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Call SalTblDeleteRow( hWndItem, nFuncPos, TBL_NoAdjust )
.head 5 +  ! Function: EvaluateFunc
.head 6 -  Description: Purpose to run function which are from set
according to their position
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: nPos
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Boolean: fReturn
.head 7 -  Number: nError
.head 7 -  Number: nErrorPos
.head 7 -  Number: nReturn
.head 7 -  String: strReturn
.head 7 -  Date/Time: dtReturn
.head 7 -  Window Handle: hWndReturn
.head 6 +  Actions
.head 7 -  Set fReturn = TRUE
.head 7 -  Call SalTblSetFocusRow( hWndItem, nPos )
.head 7 -  Call SalTblSetContext( hWndItem , nPos )
.head 7 +  If hWndItem.FuncActivity
.head 8 -  Call SaveInfoToLog( 'Старт выполнения функции списка ' || hWndItem.FuncName )
.head 8 -  Call SalTblSetCellTextColor( hWndItem.FuncStatus, COLOR_Blue, FALSE )
.head 8 -  Set hWndItem.FuncStatus = 'Running...'
.head 8 +  If SalCompileAndEvaluate( hWndItem.FuncCallString , nError , nErrorPos, nReturn, strReturn, dtReturn, hWndReturn, FALSE, SalContextCurrent ( ) )
.head 9 -  Call SqlCommitEx(DB.hSql(), 'Функция - ' || hWndItem.FuncName)
.head 9 -  Call SalTblSetCellTextColor( hWndItem.FuncStatus, COLOR_DarkGreen, FALSE )
.head 9 -  Set hWndItem.FuncStatus = 'Done'
.head 8 +  Else
.head 9 -  Call SalTblSetCellTextColor( hWndItem.FuncStatus, COLOR_DarkRed, FALSE )
.head 9 -  Set hWndItem.FuncStatus = 'Failed'
.head 9 -  Set fReturn = FALSE
.head 7 +  Else
.head 8 -  Call SalTblSetCellTextColor( hWndItem.FuncStatus, COLOR_Magenta, FALSE )
.head 8 -  Set hWndItem.FuncStatus = 'Ignore'
.head 5 +  Function: RestorePosition
.head 6 -  Description: Purpose is to restore position in visual tab column Func_Position
according to visual represent of rows
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nPos
.head 6 +  Actions
.head 7 -  Set nPos = TBL_MinRow
.head 7 +  Loop
.head 8 +  If SalTblFindNextRow( hWndItem, nPos,0, 0 )
.head 9 -  Call SalTblSetContext( hWndItem , nPos )
.head 9 -  Call SalTblSetColumnText ( hWndItem , 4 , SalNumberToStrX( nPos,0 )  )
.head 8 +  Else
.head 9 -  Break
.head 5 +  Function: MoveDown
.head 6 -  Description: Purpose is to move down selected functions
.head 6 -  Returns
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sColumnValueUp
.head 7 -  String: sColumnValueDown
.head 7 -  Number: nIndex
.head 7 -  Number: nNumber
.head 7 -  Number: nMax
.head 6 +  Actions
.head 7 -  Set nIndex = TBL_MinRow
.head 7 +  Loop
.head 8 +  If NOT SalTblFindNextRow( hWndItem, nIndex, ROW_Selected, 0 )
.head 9 -  Break
.head 7 -  Set nMax = nIndex
.head 7 +  Loop
.head 8 +  If NOT SalTblFindNextRow( hWndItem, nMax, 0, 0 )
.head 9 -  Break
.head 7 +  Loop
.head 8 +  If nIndex < nMax
.head 9 -  Set nNumber = 1
.head 9 +  Loop
.head 10 +  If nNumber !=4
.head 11 -  Call SalTblSetContext( hWndItem , nIndex )
.head 11 -  Call SalTblGetColumnText ( hWndItem , nNumber ,sColumnValueDown )
.head 11 -  Call SalTblSetContext( hWndItem , nIndex+1 )
.head 11 -  Call SalTblGetColumnText ( hWndItem , nNumber ,sColumnValueUp )
.head 11 -  Call SalTblSetContext( hWndItem , nIndex+1 )
.head 11 -  Call SalTblSetColumnText ( hWndItem , nNumber ,sColumnValueDown )
.head 11 -  Call SalTblSetContext( hWndItem , nIndex )
.head 11 -  Call SalTblSetColumnText ( hWndItem , nNumber ,sColumnValueUp )
.head 10 -  Set nNumber=nNumber+1
.head 10 +  If nNumber=7
.head 11 -  Break
.head 9 -  Call SalTblSetRowFlags(hWndItem , nIndex, ROW_Selected, FALSE )
.head 9 -  Call SalTblSetRowFlags(hWndItem, nIndex+1, ROW_Selected, TRUE )
.head 8 +  If NOT SalTblFindPrevRow( hWndItem, nIndex, ROW_Selected, 0 )
.head 9 -  Break
.head 7 -  Call SalTblSetFocusRow( hWndItem, nIndex+1 )
.head 5 +  Function: MoveUp
.head 6 -  Description: Purpose is to move up selected functions
.head 6 -  Returns
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sColumnValueUp
.head 7 -  String: sColumnValueDown
.head 7 -  Number: nIndex
.head 7 -  Number: nNumber
.head 6 +  Actions
.head 7 -  Set nNumber = TBL_MinRow
.head 7 +  Loop
.head 8 +  If SalTblFindNextRow( hWndItem, nNumber, ROW_Selected, 0 )
.head 9 +  If nNumber > 0
.head 10 -  Set nIndex = 1
.head 10 +  Loop
.head 11 +  If nIndex !=4
.head 12 -  Call SalTblSetContext( hWndItem , nNumber )
.head 12 -  Call SalTblGetColumnText ( hWndItem , nIndex ,sColumnValueUp )
.head 12 -  Call SalTblSetContext( hWndItem , nNumber-1 )
.head 12 -  Call SalTblGetColumnText ( hWndItem , nIndex ,sColumnValueDown )
.head 12 -  Call SalTblSetContext( hWndItem , nNumber-1 )
.head 12 -  Call SalTblSetColumnText ( hWndItem , nIndex ,sColumnValueUp )
.head 12 -  Call SalTblSetContext( hWndItem , nNumber )
.head 12 -  Call SalTblSetColumnText ( hWndItem , nIndex ,sColumnValueDown )
.head 11 -  Set nIndex = nIndex+1
.head 11 +  If nIndex=7
.head 12 -  Break
.head 10 -  Call SalTblSetRowFlags(hWndItem , nNumber, ROW_Selected, FALSE )
.head 10 -  Call SalTblSetRowFlags(hWndItem, nNumber - 1, ROW_Selected, TRUE )
.head 8 +  Else
.head 9 -  Break
.head 7 -  Call SalTblSetFocusRow( hWndItem, nNumber-1 )
.head 4 +  Message Actions
.head 5 +  On SAM_FetchRowDone
.head 6 -  Set nCount = nCount + 1
.head 3 +  Child Table Class: ListSet
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:  
.head 6 -  Top:   
.head 6 -  Width:  1.2"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.833"
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
.head 5 -  Maximum Rows in Memory: 300
.head 5 -  Discardable? No
.head 4 -  Next Class Child Key: 3
.head 4 -  List in Tool Palette? Yes
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Description: Visual Child Table class with additional functionality for managing with BARS's set of functions
.head 4 +  Derived From
.head 5 -  Class: RsTable
.head 4 +  Contents
.head 5 +  Column: SetId
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 1
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  Default
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
.head 5 +  Column: SetName
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 2
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование множества
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  Default
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
.head 5 +  Column: SetComments
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 3
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Комментарий
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  Default
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
.head 4 +  Class Variables
.head 5 -  : DB
.head 6 -  Class: cABSConnect
.head 4 -  Instance Variables
.head 4 +  Functions
.head 5 +  Function: Constructor
.head 6 -  Description: Perform all necessary preoperations for object existance
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: bFetchRes
.head 6 +  Actions
.head 7 -  Call XConnectGetParams(DB)
.head 7 -  ! После подключения к АБС эту часть можно удалить
.head 7 -  ! Call DB.Define("bars","bars","bars",TRUE)
.head 7 -  ! Конец
.head 7 -  Call DB.Connect()
.head 7 -  Call SalTblPopulate( hWndItem, DB.hSql(),  '
SELECT 	Id,Name,Comments
FROM     	List_Set
INTO	:SetId,:SetName,:SetComments
ORDER BY Id ',TBL_FillNormal)
.head 5 +  Function: Destructor
.head 6 -  Description: Clear traces of object
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Call DB.Disconnect()
.head 5 +  Function: New
.head 6 -  Description: Purpose to create a new set
.head 6 +  Returns
.head 7 -  Number:
.head 6 +  Parameters
.head 7 -  String: SetName
.head 7 -  String: SetComments
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nFetchRes
.head 7 -  Number: nReturn
.head 6 +  Actions
.head 7 -  Call SqlPrepareAndExecute(DB.hSql(),'
INSERT INTO List_Set
(Name,Comments)
VALUES
( :SetName,:SetComments ) ' )
.head 7 -  Call SqlPrepareAndExecute(DB.hSql(),'
SELECT max(Id)
INTO :nReturn
FROM List_Set ' )
.head 7 -  Call SqlFetchNext( DB.hSql(), nFetchRes )
.head 7 -  Call SqlCommit(DB.hSql())
.head 7 -  Return nReturn
.head 5 +  Function: NewAs
.head 6 -  Description: Purpose to create a new set with bigining set of functions
.head 6 +  Returns
.head 7 -  Number:
.head 6 +  Parameters
.head 7 -  String: SetName
.head 7 -  String: SetComments
.head 7 -  Number: AsSetId
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: SetId
.head 7 -  Number: nFetchRes
.head 6 +  Actions
.head 7 -  Call SqlPrepareAndExecute(DB.hSql(),'
INSERT INTO List_Set
(Name,Comments)
VALUES
( :SetName,:SetComments) ')
.head 7 -  Call SqlPrepareAndExecute(DB.hSql(),'
SELECT max(Id)
INTO :SetId
FROM List_Set ' )
.head 7 -  Call SqlFetchNext( DB.hSql(), nFetchRes )
.head 7 -  Call SqlPrepareAndExecute(DB.hSql(),'
INSERT INTO List_FuncSet
(Set_Id,Func_Activity,Func_Comments,Func_Id)
SELECT :SetId,0,\' \',Func_Id
FROM List_FuncSet
WHERE Set_Id = :AsSetId ')
.head 7 -  Call SqlCommit(DB.hSql())
.head 7 -  Return SetId
.head 5 +  Function: Delete
.head 6 -  Description: Purpose to delete set from the list of available
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: SetId
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Boolean: fReturn
.head 6 +  Actions
.head 7 -  Set fReturn = TRUE
.head 7 -  Call SqlPrepareAndExecute( DB.hSql(), '
DELETE
FROM List_FuncSet
WHERE Set_Id = :SetId' )
.head 7 -  Call SqlPrepareAndExecute( DB.hSql(), '
DELETE
FROM List_Set
WHERE Id = :SetId ' )
.head 7 +  If NOT SqlCommit(DB.hSql())
.head 8 -  Set fReturn = FALSE
.head 4 -  Message Actions
.head 3 +  Dialog Box Class: cfwListFuncSetExec
.head 4 -  Title:
.head 4 -  Accesories Enabled? Yes
.head 4 -  Visible? Class Default
.head 4 -  Display Settings
.head 5 -  Display Style? Class Default
.head 5 -  Visible at Design time? Yes
.head 5 -  Type of Dialog: Class Default
.head 5 -  Window Location and Size
.head 6 -  Left:  
.head 6 -  Top:   
.head 6 -  Width:  5.557"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 5.595"
.head 6 -  Height Editable? Class Default
.head 5 -  Absolute Screen Location? Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 4 -  Next Class Child Key: 0
.head 4 -  List in Tool Palette? Yes
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Description: Purpose to provide user of functions' sets with base point for
constructing  set executable applications
.head 4 +  Tool Bar
.head 5 -  Display Settings
.head 6 -  Display Style? Class Default
.head 6 -  Location? Class Default
.head 6 -  Visible? No
.head 6 -  Size: Class Default
.head 6 -  Size Editable? Class Default
.head 6 -  Font Name: Class Default
.head 6 -  Font Size: Class Default
.head 6 -  Font Enhancement: Class Default
.head 6 -  Text Color: Class Default
.head 6 -  Background Color: Class Default
.head 5 -  Contents
.head 4 +  Contents
.head 5 +  Child Table: tblExecuted
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 1
.head 6 -  Class: ListFncSet
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Display Settings
.head 7 -  Window Location and Size
.head 8 -  Left:   0.083"
.head 8 -  Top:    0.738"
.head 8 -  Width:  5.3"
.head 8 -  Width Editable? Class Default
.head 8 -  Height: 3.271"
.head 8 -  Height Editable? Class Default
.head 7 -  Visible? Class Default
.head 7 -  Font Name: Class Default
.head 7 -  Font Size: Class Default
.head 7 -  Font Enhancement: Class Default
.head 7 -  Text Color: Class Default
.head 7 -  Background Color: Class Default
.head 7 -  View: Class Default
.head 7 -  Allow Row Sizing? Class Default
.head 7 -  Lines Per Row: Class Default
.head 6 -  Memory Settings
.head 7 -  Maximum Rows in Memory: Class Default
.head 7 -  Discardable? Class Default
.head 6 +  Contents
.head 7 +  Column: FuncId
.head 8 -  Class Child Ref Key: 3
.head 8 -  Class ChildKey: 2
.head 8 -  Class: ListFncSet
.head 8 -  Property Template:
.head 8 -  Class DLL Name:
.head 8 -  Title:
.head 8 -  Visible? Class Default
.head 8 -  Editable? Class Default
.head 8 -  Maximum Data Length: Class Default
.head 8 -  Data Type: Class Default
.head 8 -  Justify: Class Default
.head 8 -  Width:  0.886"
.head 8 -  Width Editable? Class Default
.head 8 -  Format: Class Default
.head 8 -  Country: Class Default
.head 8 -  Input Mask: Class Default
.head 8 -  Cell Options
.head 9 -  Cell Type? Class Default
.head 9 -  Multiline Cell? Class Default
.head 9 -  Cell DropDownList
.head 10 -  Sorted? Class Default
.head 10 -  Vertical Scroll? Class Default
.head 10 -  Auto Drop Down? Class Default
.head 10 -  Allow Text Editing? Class Default
.head 9 -  Cell CheckBox
.head 10 -  Check Value:
.head 10 -  Uncheck Value:
.head 10 -  Ignore Case? Class Default
.head 8 -  List Values
.head 8 -  Message Actions
.head 7 +  Column: FuncName
.head 8 -  Class Child Ref Key: 9
.head 8 -  Class ChildKey: 3
.head 8 -  Class: ListFncSet
.head 8 -  Property Template:
.head 8 -  Class DLL Name:
.head 8 -  Title:
.head 8 -  Visible? Class Default
.head 8 -  Editable? Class Default
.head 8 -  Maximum Data Length: Class Default
.head 8 -  Data Type: Class Default
.head 8 -  Justify: Class Default
.head 8 -  Width:  2.286"
.head 8 -  Width Editable? Class Default
.head 8 -  Format: Class Default
.head 8 -  Country: Class Default
.head 8 -  Input Mask: Class Default
.head 8 -  Cell Options
.head 9 -  Cell Type? Class Default
.head 9 -  Multiline Cell? Class Default
.head 9 -  Cell DropDownList
.head 10 -  Sorted? Class Default
.head 10 -  Vertical Scroll? Class Default
.head 10 -  Auto Drop Down? Class Default
.head 10 -  Allow Text Editing? Class Default
.head 9 -  Cell CheckBox
.head 10 -  Check Value:
.head 10 -  Uncheck Value:
.head 10 -  Ignore Case? Class Default
.head 8 -  List Values
.head 8 -  Message Actions
.head 7 +  Column: FuncActivity
.head 8 -  Class Child Ref Key: 4
.head 8 -  Class ChildKey: 4
.head 8 -  Class: ListFncSet
.head 8 -  Property Template:
.head 8 -  Class DLL Name:
.head 8 -  Title:
.head 8 -  Visible? Class Default
.head 8 -  Editable? Class Default
.head 8 -  Maximum Data Length: Class Default
.head 8 -  Data Type: Class Default
.head 8 -  Justify: Class Default
.head 8 -  Width:  0.333"
.head 8 -  Width Editable? Class Default
.head 8 -  Format: Class Default
.head 8 -  Country: Class Default
.head 8 -  Input Mask: Class Default
.head 8 -  Cell Options
.head 9 -  Cell Type? Class Default
.head 9 -  Multiline Cell? Class Default
.head 9 -  Cell DropDownList
.head 10 -  Sorted? Class Default
.head 10 -  Vertical Scroll? Class Default
.head 10 -  Auto Drop Down? Class Default
.head 10 -  Allow Text Editing? Class Default
.head 9 -  Cell CheckBox
.head 10 -  Check Value:
.head 10 -  Uncheck Value:
.head 10 -  Ignore Case? Class Default
.head 8 -  List Values
.head 8 -  Message Actions
.head 7 +  Column: FuncPosition
.head 8 -  Class Child Ref Key: 5
.head 8 -  Class ChildKey: 5
.head 8 -  Class: ListFncSet
.head 8 -  Property Template:
.head 8 -  Class DLL Name:
.head 8 -  Title:
.head 8 -  Visible? Class Default
.head 8 -  Editable? Class Default
.head 8 -  Maximum Data Length: Class Default
.head 8 -  Data Type: Class Default
.head 8 -  Justify: Class Default
.head 8 -  Width:  0.217"
.head 8 -  Width Editable? Class Default
.head 8 -  Format: Class Default
.head 8 -  Country: Class Default
.head 8 -  Input Mask: Class Default
.head 8 -  Cell Options
.head 9 -  Cell Type? Class Default
.head 9 -  Multiline Cell? Class Default
.head 9 -  Cell DropDownList
.head 10 -  Sorted? Class Default
.head 10 -  Vertical Scroll? Class Default
.head 10 -  Auto Drop Down? Class Default
.head 10 -  Allow Text Editing? Class Default
.head 9 -  Cell CheckBox
.head 10 -  Check Value:
.head 10 -  Uncheck Value:
.head 10 -  Ignore Case? Class Default
.head 8 -  List Values
.head 8 -  Message Actions
.head 7 +  Column: FuncComments
.head 8 -  Class Child Ref Key: 6
.head 8 -  Class ChildKey: 6
.head 8 -  Class: ListFncSet
.head 8 -  Property Template:
.head 8 -  Class DLL Name:
.head 8 -  Title:
.head 8 -  Visible? No
.head 8 -  Editable? Class Default
.head 8 -  Maximum Data Length: Class Default
.head 8 -  Data Type: Class Default
.head 8 -  Justify: Class Default
.head 8 -  Width:  0.217"
.head 8 -  Width Editable? Class Default
.head 8 -  Format: Class Default
.head 8 -  Country: Class Default
.head 8 -  Input Mask: Class Default
.head 8 -  Cell Options
.head 9 -  Cell Type? Class Default
.head 9 -  Multiline Cell? Class Default
.head 9 -  Cell DropDownList
.head 10 -  Sorted? Class Default
.head 10 -  Vertical Scroll? Class Default
.head 10 -  Auto Drop Down? Class Default
.head 10 -  Allow Text Editing? Class Default
.head 9 -  Cell CheckBox
.head 10 -  Check Value:
.head 10 -  Uncheck Value:
.head 10 -  Ignore Case? Class Default
.head 8 -  List Values
.head 8 -  Message Actions
.head 7 +  Column: FuncCallString
.head 8 -  Class Child Ref Key: 8
.head 8 -  Class ChildKey: 7
.head 8 -  Class: ListFncSet
.head 8 -  Property Template:
.head 8 -  Class DLL Name:
.head 8 -  Title:
.head 8 -  Visible? Class Default
.head 8 -  Editable? Class Default
.head 8 -  Maximum Data Length: Class Default
.head 8 -  Data Type: Class Default
.head 8 -  Justify: Class Default
.head 8 -  Width:  0.217"
.head 8 -  Width Editable? Class Default
.head 8 -  Format: Class Default
.head 8 -  Country: Class Default
.head 8 -  Input Mask: Class Default
.head 8 -  Cell Options
.head 9 -  Cell Type? Class Default
.head 9 -  Multiline Cell? Class Default
.head 9 -  Cell DropDownList
.head 10 -  Sorted? Class Default
.head 10 -  Vertical Scroll? Class Default
.head 10 -  Auto Drop Down? Class Default
.head 10 -  Allow Text Editing? Class Default
.head 9 -  Cell CheckBox
.head 10 -  Check Value:
.head 10 -  Uncheck Value:
.head 10 -  Ignore Case? Class Default
.head 8 -  List Values
.head 8 -  Message Actions
.head 7 +  Column: FuncStatus
.head 8 -  Class Child Ref Key: 7
.head 8 -  Class ChildKey: 8
.head 8 -  Class: ListFncSet
.head 8 -  Property Template:
.head 8 -  Class DLL Name:
.head 8 -  Title:
.head 8 -  Visible? Yes
.head 8 -  Editable? Class Default
.head 8 -  Maximum Data Length: Class Default
.head 8 -  Data Type: Class Default
.head 8 -  Justify: Class Default
.head 8 -  Width:  1.067"
.head 8 -  Width Editable? Class Default
.head 8 -  Format: Class Default
.head 8 -  Country: Class Default
.head 8 -  Input Mask: Class Default
.head 8 -  Cell Options
.head 9 -  Cell Type? Class Default
.head 9 -  Multiline Cell? Class Default
.head 9 -  Cell DropDownList
.head 10 -  Sorted? Class Default
.head 10 -  Vertical Scroll? Class Default
.head 10 -  Auto Drop Down? Class Default
.head 10 -  Allow Text Editing? Class Default
.head 9 -  Cell CheckBox
.head 10 -  Check Value:
.head 10 -  Uncheck Value:
.head 10 -  Ignore Case? Class Default
.head 8 -  List Values
.head 8 -  Message Actions
.head 7 +  Column: FuncRoleName
.head 8 -  Class Child Ref Key: 13
.head 8 -  Class ChildKey: 13
.head 8 -  Class: ListFncSet
.head 8 -  Property Template:
.head 8 -  Class DLL Name:
.head 8 -  Title:
.head 8 -  Visible? Class Default
.head 8 -  Editable? Class Default
.head 8 -  Maximum Data Length: Class Default
.head 8 -  Data Type: Class Default
.head 8 -  Justify: Class Default
.head 8 -  Width:  Class Default
.head 8 -  Width Editable? Class Default
.head 8 -  Format: Class Default
.head 8 -  Country: Class Default
.head 8 -  Input Mask: Class Default
.head 8 -  Cell Options
.head 9 -  Cell Type? Class Default
.head 9 -  Multiline Cell? Class Default
.head 9 -  Cell DropDownList
.head 10 -  Sorted? Class Default
.head 10 -  Vertical Scroll? Class Default
.head 10 -  Auto Drop Down? Class Default
.head 10 -  Allow Text Editing? Class Default
.head 9 -  Cell CheckBox
.head 10 -  Check Value:
.head 10 -  Uncheck Value:
.head 10 -  Ignore Case? Class Default
.head 8 -  List Values
.head 8 -  Message Actions
.head 6 -  Functions
.head 6 -  Window Variables
.head 6 -  Message Actions
.head 5 +  Data Field: dfSetName
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 14
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Data
.head 7 -  Maximum Data Length: Default
.head 7 -  Data Type: String
.head 7 -  Editable? No
.head 6 -  Display Settings
.head 7 -  Window Location and Size
.head 8 -  Left:   0.083"
.head 8 -  Top:    0.071"
.head 8 -  Width:  5.3"
.head 8 -  Width Editable? Yes
.head 8 -  Height: 0.25"
.head 8 -  Height Editable? Yes
.head 7 -  Visible? Yes
.head 7 -  Border? Yes
.head 7 -  Justify: Center
.head 7 -  Format: Unformatted
.head 7 -  Country: Default
.head 7 -  Font Name: Default
.head 7 -  Font Size: Default
.head 7 -  Font Enhancement: Default
.head 7 -  Text Color: Default
.head 7 -  Background Color: 3D Highlight Color
.head 7 -  Input Mask: Unformatted
.head 6 -  Message Actions
.head 5 +  Data Field: dfSetComments
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 15
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Data
.head 7 -  Maximum Data Length: Default
.head 7 -  Data Type: String
.head 7 -  Editable? No
.head 6 -  Display Settings
.head 7 -  Window Location and Size
.head 8 -  Left:   0.083"
.head 8 -  Top:    0.405"
.head 8 -  Width:  5.3"
.head 8 -  Width Editable? Yes
.head 8 -  Height: 0.25"
.head 8 -  Height Editable? Yes
.head 7 -  Visible? Yes
.head 7 -  Border? Yes
.head 7 -  Justify: Left
.head 7 -  Format: Unformatted
.head 7 -  Country: Default
.head 7 -  Font Name: Default
.head 7 -  Font Size: Default
.head 7 -  Font Enhancement: Default
.head 7 -  Text Color: Default
.head 7 -  Background Color: 3D Highlight Color
.head 7 -  Input Mask: Unformatted
.head 6 -  Message Actions
.head 5 +  Custom Control: mProgressMeter
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 9
.head 6 -  Class: cMeter
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Display Settings
.head 7 -  DLL Name:
.head 7 -  MS Windows Class Name:
.head 7 -  Style:  Class Default
.head 7 -  ExStyle:  Class Default
.head 7 -  Title:
.head 7 -  Window Location and Size
.head 8 -  Left:   0.1"
.head 8 -  Top:    4.063"
.head 8 -  Width:  5.3"
.head 8 -  Width Editable? Class Default
.head 8 -  Height: 0.417"
.head 8 -  Height Editable? Class Default
.head 7 -  Visible? No
.head 7 -  Border? Class Default
.head 7 -  Etched Border? Class Default
.head 7 -  Hollow? Class Default
.head 7 -  Vertical Scroll? Class Default
.head 7 -  Horizontal Scroll? Class Default
.head 7 -  Tab Stop? Class Default
.head 7 -  Tile To Parent? Class Default
.head 7 -  Font Name: Class Default
.head 7 -  Font Size: Class Default
.head 7 -  Font Enhancement: Class Default
.head 7 -  Text Color: 3D Shadow Color
.head 7 -  Background Color: 3D Face Color
.head 7 -  DLL Settings
.head 6 -  Message Actions
.head 5 +  Pushbutton: pbExecute
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 10
.head 6 -  Class: cpbExecute
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Выполнить
.head 6 -  Window Location and Size
.head 7 -  Left:   2.1"
.head 7 -  Top:    4.063"
.head 7 -  Width:  1.3"
.head 7 -  Width Editable? Class Default
.head 7 -  Height: Class Default
.head 7 -  Height Editable? Class Default
.head 6 -  Visible? Class Default
.head 6 -  Keyboard Accelerator: Class Default
.head 6 -  Font Name: Class Default
.head 6 -  Font Size: Class Default
.head 6 -  Font Enhancement: Class Default
.head 6 -  Picture File Name:
.head 6 -  Picture Transparent Color: Class Default
.head 6 -  Image Style: Class Default
.head 6 -  Text Color: Class Default
.head 6 -  Background Color: Class Default
.head 6 +  Message Actions
.head 7 +  On SAM_Click
.head 8 -  Call SalHideWindow( pbExecute )
.head 8 -  Call SalShowWindow( mProgressMeter )
.head 8 -  Call SalShowWindow( pbCancel )
.head 8 -  Call Execute()
.head 8 -  Call SalHideWindow( pbCancel )
.head 8 -  Call SalHideWindow( mProgressMeter )
.head 8 -  Call SalShowWindow( pbOk )
.head 8 -  Call SalSetFocus( pbOk )
.head 5 +  Pushbutton: pbCancel
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 11
.head 6 -  Class: cpbCancel
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Window Location and Size
.head 7 -  Left:   2.1"
.head 7 -  Top:    4.563"
.head 7 -  Width:  1.3"
.head 7 -  Width Editable? Class Default
.head 7 -  Height: Class Default
.head 7 -  Height Editable? Class Default
.head 6 -  Visible? No
.head 6 -  Keyboard Accelerator: Class Default
.head 6 -  Font Name: Class Default
.head 6 -  Font Size: Class Default
.head 6 -  Font Enhancement: Class Default
.head 6 -  Picture File Name:
.head 6 -  Picture Transparent Color: Class Default
.head 6 -  Image Style: Class Default
.head 6 -  Text Color: Class Default
.head 6 -  Background Color: Class Default
.head 6 +  Message Actions
.head 7 +  On SAM_Click
.head 8 -  Set fInterrupted = TRUE
.head 5 +  Pushbutton: pbOk
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 12
.head 6 -  Class: cpbOk
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: ОК
.head 6 -  Window Location and Size
.head 7 -  Left:   2.1"
.head 7 -  Top:    4.563"
.head 7 -  Width:  1.3"
.head 7 -  Width Editable? Class Default
.head 7 -  Height: Class Default
.head 7 -  Height Editable? Class Default
.head 6 -  Visible? No
.head 6 -  Keyboard Accelerator: Class Default
.head 6 -  Font Name: Class Default
.head 6 -  Font Size: Class Default
.head 6 -  Font Enhancement: Class Default
.head 6 -  Picture File Name:
.head 6 -  Picture Transparent Color: Class Default
.head 6 -  Image Style: Class Default
.head 6 -  Text Color: Class Default
.head 6 -  Background Color: Class Default
.head 6 +  Message Actions
.head 7 +  On SAM_Click
.head 8 -  Call Destructor()
.head 8 -  Call SalEndDialog( hWndForm, nReturnCode )
.head 4 -  Derived From
.head 4 -  Class Variables
.head 4 +  Instance Variables
.head 5 -  Number: nMode		!Mode property may be:
			1 - Auto mode
			0 - Half auto mode, which allow to user select
or deselect  some function for execution without saving in database
.head 5 -  Number: nReturnCode	!Return code which may be:
			0 - everything OK
			1 - there were an errors during execution
			2 - there were an ignored functions and no failed
			3 - set is empty
			4 - execution process was interupted
.head 5 -  Boolean: fInterrupted
.head 4 +  Functions
.head 5 +  Function: Constructor
.head 6 -  Description: Purpose to initialize object
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: npSetId
.head 7 -  Number: npMode
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Boolean: bR
.head 6 +  Actions
.head 7 -  Set nMode = npMode
.head 7 -  Set bR=TRUE
.head 7 +  If NOT tblExecuted.Constructor(npSetId)
.head 8 -  Set bR=FALSE
.head 7 +  If NOT tblExecuted.Fill()
.head 8 -  Set bR=FALSE
.head 7 -  Set dfSetName = tblExecuted.SetName
.head 7 -  Set dfSetComments = tblExecuted.SetComments
.head 7 -  Return bR
.head 5 +  Function: Destructor
.head 6 -  Description: Purpose to clear traces of object
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Boolean: bR
.head 6 +  Actions
.head 7 -  Set bR=TRUE
.head 7 +  If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
.head 8 -  Call XRoleUnset(tblExecuted.DB.hSql(),'FListRun('||SalNumberToStrX(tblExecuted.SetId,0)||','||SalNumberToStrX(nMode,0)||')')
.head 7 +  If NOT tblExecuted.Destructor()
.head 8 -  Set bR=FALSE
.head 7 -  Return bR
.head 5 +  Function: ExecuteAccordingToMode
.head 6 -  Description: Purpose to execute set according to mode
.head 6 -  Returns
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  ! Если в список пуст, то сразу закрываем окно выполнения списка
.head 7 +  If tblExecuted.nCount=0
.head 8 -  Set nReturnCode  = 0
.head 8 -  Call SalEndDialog( hWndForm, nReturnCode )
.head 7 +  Select Case nMode
.head 8 +  Case 0
.head 9 -  Call SalSetFocus(pbExecute)
.head 9 -  Break
.head 8 +  Case 1
.head 9 -  Call SalSendMsg( pbExecute, SAM_Click, 0, 0 )
.head 9 -  Break
.head 8 +  Default
.head 9 -  Break
.head 5 +  Function: Execute
.head 6 -  Description: Purpose to execute a set with managing resulting value
.head 6 -  Returns
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nIndex
.head 7 -  Number: nFetchRes
.head 7 -  !
.head 7 -  Number: nError
.head 7 -  Number: nErrorPos
.head 7 -  String: strReturn
.head 7 -  Number: nReturn
.head 7 -  Date/Time: dtReturn
.head 7 -  Window Handle: hWndReturn
.head 7 -  !
.head 7 -  Boolean: fWasIgnored
.head 7 -  Boolean: fWasFailed
.head 6 +  Actions
.head 7 -  Set fInterrupted = FALSE
.head 7 -  Set fWasFailed   = FALSE
.head 7 -  Set fWasIgnored  = FALSE
.head 7 -  Set nIndex       = TBL_MinRow
.head 7 -  Set nReturnCode  = 0
.head 7 +  If tblExecuted.nCount
.head 8 +  If NOT SalYieldQueryState(  )
.head 9 -  Call SalYieldEnable( TRUE )
.head 8 -  Call SalYieldStartMessages( pbCancel )
.head 8 +  Loop
.head 9 +  If fInterrupted
.head 10 -  Call SalYieldStopMessages( )
.head 9 +  If NOT SalTblFindNextRow( tblExecuted, nIndex, 0, 0 )
.head 10 -  Break
.head 9 -  Call SalTblSetFocusRow( tblExecuted, nIndex )
.head 9 -  Call SalTblSetContext( tblExecuted , nIndex )
.head 9 +  If tblExecuted.FuncActivity AND NOT fInterrupted
.head 10 -  Call SaveInfoToLog( 'Старт выполнения функции списка ' || tblExecuted.FuncName )
.head 10 -  Call SalTblSetCellTextColor( tblExecuted.FuncStatus, COLOR_Blue, FALSE )
.head 10 -  Set tblExecuted.FuncStatus = 'Running...'
.head 10 +  If tblExecuted.FuncRoleName != ''
.head 11 -  Call XRoleSet( tblExecuted.DB.hSql(), tblExecuted.FuncName, tblExecuted.FuncRoleName )
.head 10 +  If SalCompileAndEvaluate( tblExecuted.FuncCallString , nError , nErrorPos, nReturn, strReturn, dtReturn, hWndReturn, FALSE, SalContextCurrent ( ) )
.head 11 -  Call SqlCommitEx( tblExecuted.DB.hSql(), 'Функция - ' ||  tblExecuted.FuncName)
.head 11 -  Call SalTblSetCellTextColor( tblExecuted.FuncStatus, COLOR_DarkGreen, FALSE )
.head 11 -  Set tblExecuted.FuncStatus = 'Done'
.head 10 +  Else
.head 11 -  Call SalTblSetCellTextColor( tblExecuted.FuncStatus, COLOR_DarkRed, FALSE )
.head 11 -  Set tblExecuted.FuncStatus = 'Failed'
.head 11 -  Set fWasFailed = TRUE
.head 9 +  Else
.head 10 -  Call SalTblSetCellTextColor( tblExecuted.FuncStatus, COLOR_Magenta, FALSE )
.head 10 -  Set tblExecuted.FuncStatus = 'Ignore'
.head 10 -  Set fWasIgnored = TRUE
.head 9 -  Call mProgressMeter.SetProgress( SalNumberRound( (nIndex+1)*100/tblExecuted.nCount ) )
.head 9 -  Call SalUpdateWindow( hWndForm.cfwListFuncSetExec.tblExecuted )
.head 8 +  If SalYieldQueryState(  )
.head 9 -  Call SalYieldStopMessages( )
.head 8 -  !
.head 8 +  If fInterrupted
.head 9 -  Set nReturnCode = 4
.head 8 +  Else If fWasFailed
.head 9 -  Set nReturnCode = 1
.head 8 +  Else If fWasIgnored
.head 9 -  Set nReturnCode = 2
.head 7 +  Else
.head 8 -  Set nReturnCode = 3
.head 7 -  Return nReturnCode
.head 4 -  Message Actions
.head 3 -  ! ------------------------------------------------------------------
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
.head 2 -  Application Actions
