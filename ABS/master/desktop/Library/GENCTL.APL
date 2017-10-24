.head 0 +  Application Description: ! GENCTL.APL
! /////////////////////////////////////////////////////////////////////////////////////////////////
! ООО Унити-Барс  ( C )  1997
! Разработчик: Влад Сивяков
! Последнее изменение: 12 мая 1998, 17:37
! /////////////////////////////////////////////////////////////////////////////////////////////////
! Контролы для работы с суммами валют:
!	--- clsSortedTable
!	--- clsMoneyColumn
!	--- clsMoneyField
! /////////////////////////////////////////////////////////////////////////////////////////////////
! Функции:
!	--- CurrencyValue		Считает курс валюты на дату
! /////////////////////////////////////////////////////////////////////////////////////////////////
.head 1 -  Outline Version - 4.0.26
.head 1 +  Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000990000 002C000000020000 0003000000FFFFFF FFFFFFFFFFFCFFFF
0040: FFE6FFFFFFFFFFFF FF000000007C0200 004D010000010000 0000000000010000
0060: 000F4170706C6963 6174696F6E497465 6D00000000
.enddata
.data DT_MAKERUNDLG
0000: 02000000001C513A 5C4261727339385C 4C6962726172795C 47656E63746C2E65
0020: 78651C513A5C4261 727339385C4C6962 726172795C47656E 63746C2E646C6C1C
0040: 513A5C4261727339 385C4C6962726172 795C47656E63746C 2E61706300000101
0060: 011C513A5C426172 7339385C4C696272 6172795C47656E63 746C2E72756E1C51
0080: 3A5C426172733938 5C4C696272617279 5C47656E63746C2E 646C6C1C513A5C42
00A0: 61727339385C4C69 62726172795C4765 6E63746C2E617063 000001010118513A
00C0: 5C4261727339385C 42494E5C47656E63 746C2E6170641851 3A5C426172733938
00E0: 5C42494E5C47656E 63746C2E646C6C18 513A5C4261727339 385C42494E5C4765
0100: 6E63746C2E617063 00000101011C513A 5C4261727339385C 4C6962726172795C
0120: 47656E63746C2E61 706C1C513A5C4261 727339385C4C6962 726172795C47656E
0140: 63746C2E646C6C1C 513A5C4261727339 385C4C6962726172 795C47656E63746C
0160: 2E61706300000101 01
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
0000: 0818B80BB80B2500
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
.head 2 -  File Include: Vttblwin.apl
.head 2 -  File Include: Genbutn.apl
.head 2 -  File Include: Vtarray.apl
.head 2 -  Dynalib: Global.apd
.head 2 -  Dynalib: Dfltrapi.apd
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
.head 4 -  Number: CW_USEDEFAULT = 0x8000
.head 2 -  Resources
.head 2 +  Variables
.data RESOURCE 0 0 1 2110467478
0000: 1E00000011000000 0000000000000000 0200000100000022 000000E003040000
0020: 00FF3F
.enddata
.head 3 -  String: strSQL
.head 3 -  Number: nSqlRes
.head 3 -  Number: nTemp
.head 2 +  Internal Functions
.head 3 +  Function: CurrencyValue		! __exported
.head 4 -  Description: Вычисляет курс валюты на дату
.head 4 +  Returns
.head 5 -  Number: nError			! 0 = OK;
				! 1 = Использовали будущий курс (дата возвращается во втором параметре)
				! 2 = Вернули значение из nParam
.head 4 +  Parameters
.head 5 -  Number: nCurrencyCode
.head 5 -  Number: nSum
.head 5 -  Date/Time: dtDesiredDate
.head 5 -  Receive Number: nValue
.head 5 -  Number: nRateType		! Какой из курсов возвращать: (0 = O; 1 = B; 2 = S)
.head 5 -  Boolean: bUseFuture		! Возвращать ли ближайший будущий курс
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nUseFuture
.head 5 -  Date/Time: dtFixedDate
.head 5 -  String: strFixedDate
.head 4 +  Actions
.head 5 +  If bUseFuture
.head 6 -  Set nUseFuture = 1
.head 5 +  Else
.head 6 -  Set nUseFuture = 0
.head 5 -  ! Set dtFixedDate = SalDateConstruct(SalDateYear(dtDesiredDate), SalDateMonth(dtDesiredDate), SalDateDay(dtDesiredDate), 0, 0, 0)
.head 5 -  ! !!! uncomment !!!
.head 5 +  If SalStrUpperX(SalStrTrimX(GetDBMS())) = "ORACLE"
.head 6 -  Call SqlPrepareAndExecute (hSql(),
('SELECT gl.p_icurval (:nCurrencyCode, :nSum, :dtDesiredDate, :nRateType, :nUseFuture)
FROM dual INTO :nValue'))
.head 5 +  Else
.head 6 -  Set strFixedDate = SalStrRightX("00"||SalNumberToStrX(SalDateMonth(dtDesiredDate), 0),2)||"-"||SalStrRightX("00"||SalNumberToStrX(SalDateDay(dtDesiredDate), 0),2)||"-"||SalNumberToStrX(SalDateYear(dtDesiredDate)-1900, 0)
.head 6 -  Call SqlRetrieve (hSql(), 'p_icurval', ' :nCurrencyCode, :nSum, :strFixedDate, :nRateType, :nUseFuture', ':nValue')
.head 6 -  Call SqlExecute (hSql())
.head 5 -  ! !!!
.head 5 -  ! Call SqlRetrieve (hSql(), 'p_icurval', ' :nCurrencyCode, :nSum, :dtFixedDate, :nRateType, :nUseFuture', ':nValue')
.head 5 -  !
.head 5 -  !
.head 5 -  Call SqlFetchNext( hSql(), nSqlRes )
.head 5 +  If nValue < 0
.head 6 -  Set nValue = 0
.head 6 -  Return -1
.head 5 +  Else
.head 6 -  Return 0
.head 3 +  Function: ShowErr				! __exported
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  String: strErrorText
.head 5 -  String: strModule
.head 4 +  Static Variables
.head 5 -  : hErrorControl
.head 6 -  Class: clsErrorControl
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call hErrorControl.ShowError( strErrorText, strModule )
.head 3 +  Function: Dec				! __exported
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Receive Number: n
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Set n = n-1
.head 3 +  Function: Inc				! __exported
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Receive Number: n
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Set n = n+1
.head 3 +  Function: VSStrTail				! __exported
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  String: strOriginal
.head 5 -  Number: nOffset
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Return SalStrRightX(strOriginal, SalStrLength(strOriginal)-nOffset)
.head 3 +  Function: VSStrHead				! __exported
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  String: strOriginal
.head 5 -  Number: nOffset
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Return SalStrLeftX(strOriginal, SalStrLength(strOriginal)-nOffset)
.head 3 +  Function: VSStrToBool			! __exported
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: strO
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If SalStrIsValidNumber( strO )
.head 6 +  If SalStrToNumber( strO ) > 0
.head 7 -  Return TRUE
.head 6 +  Else
.head 7 -  Return FALSE
.head 5 +  Else
.head 6 -  Set strO = SalStrUpperX( strO )
.head 6 +  If (strO = "YES")
.head 7 -  Return TRUE
.head 6 +  Else If (strO = "NO")
.head 7 -  Return FALSE
.head 5 -  Call ShowErr("Не могу привести выражение <"|| strO ||"> к BOOLEAN.", "FUN00000")
.head 5 -  Return FALSE
.head 3 +  Function: VSStrScan			! __exported
.head 4 -  Description: Ищет подстроку в строке, как и SalStrScan.
Единственная разница - если ничего не нашли, то возвращаем не -1, а SalStrLength()
.head 4 +  Returns
.head 5 -  Number:
.head 4 +  Parameters
.head 5 -  String: str1
.head 5 -  String: str2
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: n1
.head 4 +  Actions
.head 5 -  Set n1 = SalStrScan(str1, str2)
.head 5 +  If n1 = -1
.head 6 -  Return SalStrLength(str1)
.head 5 +  Else
.head 6 -  Return n1
.head 3 +  Function: VSStrTrim
.head 4 -  Description: Грохает не только Leading/trailing spaces, но и trailing CRLFs
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  String: strO
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Set strO = SalStrTrimX(strO)
.head 5 -  ! Call SalMessageBox("!!!"|| VSStrTail(strO, 2)|| "!!!", "!", MB_Ok)
.head 5 +  While SalStrRightX(strO, 2) = "
"
.head 6 -  ! Call SalMessageBox("!!!"|| VSStrTail(strO, 2)|| "!!!", "!", MB_Ok)
.head 6 -  Set strO = VSStrHead(strO, 2)
.head 5 -  Return strO
.head 2 -  Named Menus
.head 2 +  Class Definitions
.data RESOURCE 0 0 1 2840244134
0000: 7200000056000000 0000000000000000 0200000100FFFF01 00160000436C6173
0020: 73566172004F7574 6C696E6552006567 496E666F11003C00 000F63006C734572
0040: 726F7243006F6E74 726F6C3800C00000 0200000083020400 0000FFFF04040000
0060: 010D0000FE00FF03
.enddata
.head 3 +  Child Table Class: clsSortedTable
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
.head 5 -  Maximum Rows in Memory: 2000
.head 5 -  Discardable? No
.head 4 -  Next Class Child Key: 0
.head 4 -  List in Tool Palette? Yes
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Description: Грид с сортировкой по колонкам
.head 4 -  Derived From
.head 4 -  Contents
.head 4 -  Class Variables
.head 4 +  Instance Variables
.head 5 -  Number: nKeyColumn
.head 5 -  Window Handle: wKeyColumn
.head 5 -  Number: nSortOrder		! 0=Asc; 1=Desc
.head 5 -  !
.head 5 -  Number: nCurrentRow
.head 5 -  Number: nCurrentCol
.head 5 -  Window Handle: wCurrentCol
.head 5 -  Number: ntmpSort
.head 5 -  String: strHead
.head 5 -  String: strHead2
.head 5 -  Window Handle: wButton
.head 5 -  String: strColumns[2, 50]
.head 5 -  String: strExtColumns[3, 20]
.head 5 -  String: strFilters[4,10]
.head 5 -  String: strResult
.head 5 -  Window Handle: hwChild
.head 5 -  Number: i
.head 5 -  String: strQuery
.head 5 -  Sql Handle: hLastSql
.head 5 -  Number: nLookupColumn
.head 5 -  String: strLookupValue
.head 5 -  Boolean: bWasCtrl
.head 5 -  Boolean: bToBeRefreshed
.head 5 -  String: strSortOrder
.head 4 +  Functions
.head 5 +  Function: BuildFieldList
.head 6 -  Description:
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  String: strFields
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: i
.head 7 -  Number: j
.head 7 -  Number: nOffset
.head 7 -  String: str1
.head 7 -  String: str2
.head 6 +  Actions
.head 7 -  Set hwChild = SalGetFirstChild( hWndItem, TYPE_TableColumn )
.head 7 -  Set i = 0
.head 7 -  Set str1 = strFields
.head 7 +  While hwChild != hWndNULL
.head 8 -  ! Заменяем CR/LF на пробел и делаем TRIM
.head 8 -  Call SalTblGetColumnTitle (hwChild , str2, 100 )
.head 8 -  Set j = 0
.head 8 +  Loop replacer
.head 9 -  Set j = SalStrScan( str2, "
" )
.head 9 +  If j = -1
.head 10 -  Break replacer
.head 9 -  Set str2 = SalStrReplaceX( str2, j, 2, " " )
.head 9 -  ! Call SalMessageBox(str2, "Debug", MB_Ok)
.head 8 -  Set strColumns[1,i] = SalStrTrimX( str2 )
.head 8 -  !
.head 8 +  If strColumns[1,i] != '(untitled)'
.head 9 -  Set nOffset = SalStrScan(str1, ",")
.head 9 +  If nOffset = -1
.head 10 -  Set strColumns[0,i] =SalStrTrimX( str1 )
.head 10 -  Break
.head 9 +  Else
.head 10 -  Set strColumns[0,i] = SalStrTrimX( SalStrLeftX( str1, nOffset ) )
.head 10 -  Set str1 = SalStrRightX( str1, SalStrLength( str1 )-nOffset-1 )
.head 9 -  ! Call SalMessageBox( strColumns[1,i],  strColumns[0,i], MB_Ok)
.head 8 -  Set hwChild = SalGetNextChild(  hwChild, TYPE_TableColumn )
.head 8 -  Set i = i+1
.head 5 +  Function: BuildExtField
.head 6 -  Description:
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  String: strField
.head 7 -  String: strFieldDesc
.head 7 -  String: strQuery
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: i
.head 6 +  Actions
.head 7 -  Set i = SalStrToNumber(strExtColumns[0,0])+1
.head 7 -  Set strExtColumns[0,0] = SalNumberToStrX(i, 0)
.head 7 -  Set strExtColumns[0,i] = strField
.head 7 -  Set strExtColumns[1,i] = strFieldDesc
.head 7 -  Set strExtColumns[2,i] = strQuery
.head 7 -  !
.head 7 -  ! Call ShowErr("Field N:	" || SalNumberToStrX(i, 0) || "
Field name:	" || strExtColumns[0,i] || "
Field desc:	" || strExtColumns[1,i] || "
Query:	" || strExtColumns[2,i], "!")
.head 5 +  Function: SetSql
.head 6 -  Description: Заполняем переменные экземпляра
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  String: strParam
.head 7 -  Sql Handle: hSqlHandle
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set hLastSql = hSqlHandle
.head 7 -  Set strQuery = strParam
.head 5 +  Function: Refresh
.head 6 -  Description:
.head 6 -  Returns
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: strFullQuery
.head 7 -  String: strTempQuery
.head 7 -  Number: n1
.head 7 -  Number: n2
.head 7 -  Number: nTemplates
.head 7 -  Boolean: bWasWaitCursor
.head 6 +  Actions
.head 7 -  ! Устанавливаем курсор ожидания. Если уже было, то в конце функции останется TRUE
.head 7 -  Set bWasWaitCursor = NOT SalWaitCursor( TRUE )
.head 7 -  ! Если надо перенаселить
.head 7 -  Set bToBeRefreshed = TRUE
.head 7 +  While bToBeRefreshed
.head 8 -  Set bToBeRefreshed = FALSE
.head 8 +  If strQuery != ""
.head 9 -  ! Вычисляем strSQL
.head 9 -  Set nTemplates = 0
.head 9 -  Set strTempQuery = strQuery
.head 9 +  Loop
.head 10 -  Set n1 = SalStrScan( strTempQuery, "@FILTER" )
.head 10 +  If n1 != -1
.head 11 -  Set nTemplates = nTemplates+1
.head 11 +  If SalStrMidX( strTempQuery, n1+1, 1 ) = "A"
.head 12 -  Set strFullQuery = strFullQuery || SalStrLeftX( strTempQuery, n1 )
.head 12 -  Set strTempQuery = SalStrRightX(strTempQuery, SalStrLength(strTempQuery)-n1-8)
.head 11 +  Else
.head 12 -  Set strFullQuery = strFullQuery || SalStrLeftX( strTempQuery, n1 )
.head 12 -  Set strTempQuery = SalStrRightX(strTempQuery, SalStrLength(strTempQuery)-n1-7)
.head 10 +  Else
.head 11 -  Set strFullQuery = strFullQuery || strTempQuery
.head 11 -  Break
.head 9 +  If nTemplates = 0
.head 10 -  Set strFullQuery = strQuery
.head 9 -  ! Call SalMessageBox(strFullQuery, "table debug", MB_Ok)
.head 9 -  ! Населяем
.head 9 -  Call SalTblPopulate(hWndForm, hLastSql, strFullQuery, TBL_FillAll )
.head 9 -  ! Call SalTblPopulate(hWndForm, hLastSql, strFullQuery, TBL_FillNormal )
.head 7 -  Call SalWaitCursor( bWasWaitCursor )
.head 7 -  Call ..AfterRefreshHook(  )
.head 5 +  Function: SetSortOrder
.head 6 -  Description:
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  String: str1
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set strSortOrder = str1
.head 5 +  Function: AfterRefreshHook
.head 6 -  Description:
.head 6 -  Returns
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 -  Actions
.head 5 +  Function: SortByColumn
.head 6 -  Description:
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  Number: nCol
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Call SalWaitCursor( TRUE )
.head 7 -  ! Удаляем текст
.head 7 +  If wKeyColumn !=hWndNULL
.head 8 -  Call SalTblGetColumnTitle (wKeyColumn, strHead, 100)
.head 8 -  Call SalStrRight( strHead, 3, strHead2)
.head 8 +  If strHead2 = '(+)' or strHead2 = '(-)'
.head 9 -  Set strHead = SalStrLeftX( strHead, SalStrLength(strHead) - 4 )
.head 9 -  Call SalTblSetColumnTitle( wKeyColumn, strHead )
.head 7 -  !
.head 7 -  ! Set nCurrentCol = SalSendMsg ( wParam, SAM_QueryDataMaster, 0, 0 ) - 1
.head 7 -  ! If nCurrentCol = -1
.head 7 -  Set wCurrentCol = SalNumberToWindowHandle( nCol )
.head 7 -  Set nCurrentCol = SalTblQueryColumnID( wCurrentCol )
.head 7 +  If nCurrentCol = nKeyColumn
.head 8 -  Set nSortOrder = 1 - nSortOrder
.head 7 +  Else
.head 8 -  Set nKeyColumn = nCurrentCol
.head 8 -  Set wKeyColumn = wCurrentCol
.head 8 -  Set nSortOrder = 1
.head 7 -  ! Устанавливаем заголовок
.head 7 -  Call SalTblGetColumnTitle (wKeyColumn, strHead, 100)
.head 7 +  If nSortOrder = 1
.head 8 -  Set strHead2 = '(+)'
.head 7 +  Else
.head 8 -  Set strHead2 = '(-)'
.head 7 -  Call SalTblSetColumnTitle( wKeyColumn, strHead || ' ' || strHead2 )
.head 7 -  !
.head 7 +  If Not SalTblSortRows( hWndForm, nKeyColumn, nSortOrder )
.head 8 -  Call SalMessageBox( 'STBL01001: Не могу произвести сортировку!', 'Ошибка', MB_Ok )
.head 7 -  Call VisTblClearColumnSelection (hWndForm)
.head 7 -  !
.head 7 -  Call SalTblSetFocusRow( hWndForm, 0)
.head 7 -  Call SalTblSetContext( hWndForm, 0 )
.head 7 -  Call SalTblSetRowFlags( hWndForm, 0, ROW_Selected, TRUE)
.head 7 -  Call SalPostMsg( hWndForm, SAM_RowSetContext, 0, 0 )
.head 7 -  !
.head 7 -  Call SalWaitCursor( FALSE )
.head 5 +  Function: ReSort
.head 6 -  Description:
.head 6 -  Returns
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Call SalWaitCursor( TRUE )
.head 7 +  If nKeyColumn
.head 8 +  If Not SalTblSortRows( hWndForm, nKeyColumn, nSortOrder )
.head 9 -  Call SalMessageBox( 'STBL01001: Не могу произвести сортировку!', 'Ошибка', MB_Ok )
.head 7 -  Call SalWaitCursor( FALSE )
.head 5 +  Function: Link
.head 6 -  Description:
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  Window Handle: wBut
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set wButton = wBut
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set nKeyColumn = 0
.head 6 -  Set wKeyColumn = hWndNULL
.head 6 -  Set nSortOrder = 2
.head 6 -  Call SalTblSetTableFlags( hWndForm, TBL_Flag_SelectableCols, TRUE )
.head 6 -  ! Set strFilters[0,0] = ""
.head 6 -  ! Set bStopOnEmptyFilter = FALSE
.head 5 +  On SAM_DoLink
.head 6 -  Call Link( SalNumberToWindowHandle( lParam ) )
.head 5 +  On SAM_ColumnSelectClick
.head 6 -  ! Call SalMessageBox(SalNumberToStrX(wParam,0), "", MB_OK)
.head 6 -  Call SortByColumn ( wParam )
.head 5 +  On SAM_FetchRowDone
.head 6 -  Call SalSendMsgToChildren( hWndForm, SAM_FetchRowDone, 0, 0 )
.head 5 +  On SAM_DoubleClick
.head 6 +  If (wButton != hWndNULL) AND (lParam < TBL_MaxRow) AND SalTblAnyRows( hWndForm, 0, 0 )
.head 7 -  Call SalSendMsg( wButton, SAM_Click, 0, 0 )
.head 5 +  On WM_Char
.head 6 +  If wParam=6	! Ctrl/F
.head 7 +  If GetTblSearchValEx( hWndForm, nLookupColumn, strLookupValue, SRCH_UseHiddenNamed )
.head 8 -  Set nCurrentRow = VisTblFindString( hWndForm, 0, SalTblGetColumnWindow( hWndForm, nLookupColumn, COL_GetID ), strLookupValue )
.head 8 +  If nCurrentRow != -1
.head 9 -  Call SalTblSetFocusRow( hWndForm, nCurrentRow )
.head 8 +  Else
.head 9 -  Call SalMessageBox("STBL01002:Строка
"|| strLookupValue || "
не найдена в колонке номер " || SalNumberToStrX( nLookupColumn,0), "Информация", MB_Ok)
.head 6 +  If wParam=7	! Ctrl/G
.head 7 -  Call SalTblQueryFocus ( hWndForm, nCurrentRow, hwChild )
.head 7 -  Set nCurrentRow = VisTblFindString( hWndForm, nCurrentRow+1, SalTblGetColumnWindow( hWndForm, nLookupColumn, COL_GetID ), strLookupValue )
.head 7 +  If nCurrentRow != -1
.head 8 -  Call SalTblSetFocusRow( hWndForm, nCurrentRow )
.head 7 +  Else
.head 8 -  Call SalMessageBox("STBL01003:Строка
"|| strLookupValue || "
не найдена в колонке номер " || SalNumberToStrX( nLookupColumn,0), "Table dbg", MB_Ok)
.head 6 +  If wParam=18	! Ctrl/R
.head 7 -  Call Refresh(  )
.head 6 -  ! Call SalMessageBox("w="||SalNumberToStrX(wParam,0), "l="||SalNumberToStrX(lParam,0), MB_OK)
.head 5 +  On WM_KeyDown
.head 6 -  ! Call SalMessageBox("w="||SalNumberToStrX(wParam,0), "l="||SalNumberToStrX(lParam,0), MB_OK)
.head 6 +  If wParam = 17
.head 7 -  Set bWasCtrl = TRUE
.head 6 +  If (wParam >= 49) AND (wParam <= 57)
.head 7 +  If bWasCtrl
.head 8 -  Set bWasCtrl = FALSE
.head 8 -  Set hwChild = SalTblGetColumnWindow( hWndItem, wParam-48, COL_GetID )
.head 8 +  If hwChild != hWndNULL
.head 9 -  Call SortByColumn(SalWindowHandleToNumber( hwChild ))
.head 5 +  On WM_KeyUp
.head 6 +  If wParam = 17
.head 7 -  Set bWasCtrl = FALSE
.head 5 +  On SAM_CacheFull
.head 6 -  Call SalMessageBox( "Слишком большое количество строк.", "Предупреждение", MB_YesNo )
.head 3 +  Column Class: clsMoneyColumn
.head 4 -  Title:
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: String
.head 4 -  Justify: Right
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  List in Tool Palette? Yes
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
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
.head 4 -  Description: Колонка для изображения сумм разных валют
.head 4 +  Derived From
.head 5 -  Class: clsErrorControl
.head 4 -  Class Variables
.head 4 +  Instance Variables
.head 5 -  Number: nSum
.head 5 -  Number: nDig
.head 5 -  String: strSum
.head 5 -  String: strDig
.head 5 -  Number: ncolSum
.head 5 -  Number: ncolDig
.head 5 -  Boolean: bWasInit
.head 5 -  ! Цветовые значения
.head 5 -  Number: n1stColorValue
.head 5 -  Number: n1stColor
.head 5 -  Number: n2ndColorValue
.head 5 -  Number: n2ndColor
.head 4 +  Functions
.head 5 +  Function: Bind
.head 6 -  Description: Устанавливает линки с колонками суммы и глубины
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  Window Handle: hwcolSum
.head 7 -  Window Handle: hwcolDig
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 +  If (hwcolSum != hWndNULL) AND (hwcolDig != hWndNULL)
.head 8 -  Set ncolSum = SalTblQueryColumnID ( hwcolSum )
.head 8 -  Set ncolDig = SalTblQueryColumnID ( hwcolDig )
.head 8 -  Set bWasInit = TRUE
.head 7 +  Else
.head 8 -  Call ShowError( 'Нет таких колонок в этой таблице!', 'CMNC01001' )
.head 5 +  Function: SetColors
.head 6 -  Description: Устанавливает цвета и значения ИСХОДНОГО bind-поля, при которых этими цветами красим
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  Number: n1Val
.head 7 -  Number: n1Color
.head 7 -  Number: n2Val
.head 7 -  Number: n2Color
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set n1stColor = n1Color
.head 7 -  Set n1stColorValue = n1Val
.head 7 -  Set n2ndColor = n2Color
.head 7 -  Set n2ndColorValue = n2Val
.head 4 -  List Values
.head 4 +  Message Actions
.head 5 +  On SAM_FetchRowDone
.head 6 +  If bWasInit
.head 7 -  Call SalTblGetColumnText( hWndForm, ncolSum, strSum )
.head 7 -  Call SalTblGetColumnText( hWndForm, ncolDig, strDig )
.head 7 +  If (strSum != '') AND (strDig != '')
.head 8 -  Set nSum = SalStrToNumber( strSum )
.head 8 -  Set nDig = SalStrToNumber( strDig )
.head 8 +  If SalStrUpperX(SalStrTrimX(GetDBMS())) = "ORACLE"
.head 9 -  Set nTemp = nSum/SalNumberPower(10, nDig)
.head 9 -  Call SqlPrepareAndExecute( hSqlAux2(),
"SELECT TO_CHAR( :nTemp, '999G999G999G999D" || SalStrRepeatX( '9', nDig ) || "')" ||
" INTO :strSQL FROM DUAL ")
.head 9 -  Call SqlFetchNext (hSqlAux2(), nTemp)
.head 9 -  Set MyValue = strSQL
.head 8 +  Else
.head 9 -  ! Set MyValue = SalFmtFormatNumber( nSum / SalNumberPower(10, nDig), '0,' || SalStrRepeatX( '0', nDig ) )
.head 9 -  Set MyValue = SalFmtFormatNumber(
  nSum / SalNumberPower(10, nDig)
, '0,' || SalStrRepeatX( '0', nDig ) )
.head 7 +  If nSum < n1stColorValue
.head 8 -  Call SalTblSetCellTextColor( hWndItem, n1stColor, TRUE )
.head 7 +  Else If nSum > n2ndColorValue
.head 8 -  Call SalTblSetCellTextColor( hWndItem, n2ndColor, TRUE )
.head 6 +  Else
.head 7 -  Call ShowError( 'Не была произведена инициализация!', 'CMNC02001' )
.head 5 +  ! On SAM_Create
.head 6 -  Set n1stColor = COLOR_Default
.head 6 -  Set n2ndColor = COLOR_Default
.head 6 -  Set n1stColorValue = 0
.head 6 -  Set n2ndColorValue = 0
.head 3 +  Data Field Class: clsMoneyField
.head 4 -  Data
.head 5 -  Maximum Data Length: Class Default
.head 5 -  Data Type: Class Default
.head 5 -  Editable? Class Default
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:  
.head 6 -  Top:   
.head 6 -  Width:  0.833"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.25"
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
.head 4 -  List in Tool Palette? Yes
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Description: DataField, умеющий себя отображать из копеек в обычном виде
.head 4 -  Derived From
.head 4 -  Class Variables
.head 4 +  Instance Variables
.head 5 -  Number: nSum
.head 5 -  Number: nDig
.head 5 -  ! Цветовые значения
.head 5 -  Number: n1stColorValue
.head 5 -  Number: n1stColor
.head 5 -  Number: n2ndColorValue
.head 5 -  Number: n2ndColor
.head 4 +  Functions
.head 5 +  Function: SetColors
.head 6 -  Description: Устанавливает цвета и значения ИСХОДНОГО bind-поля, при которых этими цветами красим
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  Number: n1Val
.head 7 -  Number: n1Color
.head 7 -  Number: n2Val
.head 7 -  Number: n2Color
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set n1stColor = n1Color
.head 7 -  Set n1stColorValue = n1Val
.head 7 -  Set n2ndColor = n2Color
.head 7 -  Set n2ndColorValue = n2Val
.head 4 +  Message Actions
.head 5 +  On SAM_AnyEdit
.head 6 -  Set nSum = SalStrToNumber( MyValue ) * SalNumberPower(10, nDig)
.head 6 -  ! Call SalMessageBox ( SalNumberToStrX ( nSum, 0), SalNumberToStrX ( nDig, 0 ), MB_Ok)
.head 5 +  On SAM_DoInit
.head 6 +  If SalStrUpperX(SalStrTrimX(GetDBMS())) = "ORACLE"
.head 7 -  Set nTemp = nSum/SalNumberPower(10, nDig)
.head 7 -  Call SqlPrepareAndExecute( hSqlAux2(),
"SELECT TO_CHAR( :nTemp, '999G999G999G999D" || SalStrRepeatX( '9', nDig ) || "')" ||
" INTO :MyValue FROM DUAL ")
.head 7 -  Call SqlFetchNext (hSqlAux2(), nTemp)
.head 7 -  ! Call SqlImmediate(
"SELECT TO_CHAR( :nTemp, '999G999G999G999D" || SalStrRepeatX( '9', nDig ) || "'" ||
", ' NLS_NUMERIC_CHARACTERS=''" ||
sDecimal, ''') INTO :MyValue FROM DUAL ")
.head 6 +  Else
.head 7 -  Set MyValue = SalFmtFormatNumber(
  nSum / SalNumberPower(10, nDig)
, '0,' || SalStrRepeatX( '0', nDig ) )
.head 6 +  If nSum < n1stColorValue
.head 7 -  Call SalColorSet( hWndItem, COLOR_IndexWindowText, n1stColor )
.head 6 +  Else If nSum > n2ndColorValue
.head 7 -  Call SalColorSet( hWndItem, COLOR_IndexWindowText, n2ndColor )
.head 6 +  Else
.head 7 -  Call SalColorSet( hWndItem, COLOR_IndexWindowText, COLOR_Default )
.head 5 +  On SAM_Create
.head 6 +  If nDig = NUMBER_Null
.head 7 -  Set nDig = 2
.head 6 -  Set n1stColor = COLOR_Default
.head 6 -  Set n2ndColor = COLOR_Default
.head 6 -  Set n1stColorValue = 0
.head 6 -  Set n2ndColorValue = 0
.head 3 +  Functional Class: clsErrorControl
.head 4 -  Description: ! ////////////////////////////////////////////////// VS 28.JUL.1998 /////////////////////////////////////////////////////////////
! Обработчик ошибок
!	умеет изображать диалог с текстом ошибки
!	Знает наизусть модули, написанные by VS
!	хранит значение HideNextError
! ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
.head 4 -  Derived From
.head 4 -  Class Variables
.head 4 +  Instance Variables
.head 5 -  Window Handle: hpbCancelNotificator
.head 4 +  Functions
.head 5 +  Function: ShowError
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Number: nRet
.head 6 +  Parameters
.head 7 -  String: strErrorText
.head 7 -  String: strModuleInfo
.head 6 +  Static Variables
.head 7 -  String: strLastError
.head 7 -  Boolean: bHideNextError
.head 6 +  Local variables
.head 7 -  Window Handle: hw1
.head 6 +  Actions
.head 7 +  If strModuleInfo = "ERROR_INITIALIZE"
.head 8 -  Set hw1 =  SalNumberToWindowHandle( SalStrToNumber( strErrorText ) )
.head 8 -  Set hpbCancelNotificator = hw1
.head 7 +  Else
.head 8 +  If NOT((strLastError = strModuleInfo) AND bHideNextError)
.head 9 +  If SalModalDialog( dlg_Error, hWndForm, strErrorText, strModuleInfo, hpbCancelNotificator ) = 0
.head 10 -  Set bHideNextError = TRUE
.head 9 +  Else
.head 10 -  Set bHideNextError = FALSE
.head 9 -  Set strLastError = strModuleInfo
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
.head 1 +  Dialog Box: dlg_Error
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
.head 4 -  Width:  6.667"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 2.615"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: ! //////////////
! Диалог для изображения текста ошибок
!	используется в классе clsErrorControl
! //////////////
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
.head 4 -  Title: Ok!
.head 4 -  Window Location and Size
.head 5 -  Left:   2.414"
.head 5 -  Top:    1.729"
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
.head 6 -  Call SalEndDialog( hWndForm, cbShowNext )
.head 3 +  Pushbutton: pbDetails
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbDetail
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.757"
.head 5 -  Top:    1.729"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: F1
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Message Actions
.head 3 +  Multiline Field: mlError
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
.head 6 -  Left:   0.183"
.head 6 -  Top:    0.155"
.head 6 -  Width:  6.2"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 1.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Red
.head 5 -  Background Color: 3D Face Color
.head 4 -  Message Actions
.head 3 +  Check Box: cbShowNext
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Показывать сообщение об этой ошибке в следующий раз
.head 4 -  Window Location and Size
.head 5 -  Left:   0.283"
.head 5 -  Top:    1.405"
.head 5 -  Width:  6.1"
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
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.071"
.head 5 -  Top:    1.729"
.head 5 -  Width:  1.5"
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
.head 6 -  Call SalSendMsg( hpbCancel, SAM_Click, 0, 0 )
.head 6 -  Call SalEndDialog( hWndForm, cbShowNext )
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  String: strErrorText
.head 3 -  String: strModuleInfo
.head 3 -  Window Handle: hpbCancel
.head 2 +  Window Variables
.head 3 -  Boolean: bWasWaitCursor
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Set mlError = strErrorText
.head 4 -  Call SalSetWindowText( hWndForm, "Ошибка "|| strModuleInfo )
.head 4 -  Call SalCenterWindow( hWndForm )
.head 4 -  Set cbShowNext = TRUE
.head 4 +  If hpbCancel = hWndNULL
.head 5 -  Call SalDisableWindow( pbCancel )
.head 4 -  Set bWasWaitCursor = SalWaitCursor( FALSE)
.head 3 +  On SAM_Destroy
.head 4 -  Call SalWaitCursor( bWasWaitCursor )
