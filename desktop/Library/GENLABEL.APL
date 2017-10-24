.head 0 +  Application Description: Библиотека класса умных "этикеток" к полям ввода
 и прочих контролов
(с) Abyss, Unity-Bars, 1999-2003
------------------------------------------------------------
КАК ЭТО РАБОТАЕТ:
1) Во время проектирования формы создаете необходимое
количество label-ов.
2) Заполнить языковую таблицу CurrentLangTable или проассоциировать
ее с другой заполненой таблицей функцией AssignLangTable
3) В материнском окне на обработке сообщения SAM_Create 
необходимо добавить команду:
SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
Если речь идет об объектах в Child Table - сообщение продублировать
в SAM_Create таблицы.
.head 1 -  Outline Version - 4.0.26
.head 1 +  Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000730000 002C000000020000 0003000000FFFFFF FFFFFFFFFFFCFFFF
0040: FFE9FFFFFFFFFFFF FF000000007C0200 004D010000010000 0000000000010000
0060: 000F4170706C6963 6174696F6E497465 6D01000000075769 6E646F7773
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
.head 2 -  File Include: Constant.apl
.head 2 -  File Include: Winbars2.apl
.head 2 -  File Include: VtStr.apl
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
.head 4 -  Number: UM_QueryLabelText = SAM_User + 700	! Запрос на выдачу текста
.head 3 +  User
.head 2 -  Resources
.head 2 +  Variables
.head 3 -  : CurrentLangTable
.head 4 -  Class: cAtomList
.head 2 +  Internal Functions
.head 3 +  Function: AssignLangTable
.head 4 -  Description: Назначает текущую языковую таблицу
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  : cNewTable
.head 6 -  Class: cAtomList
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Return CurrentLangTable.InitFromExtern( cNewTable )
.head 3 +  Function: ApplyParametersToTemplate
.head 4 -  Description: Заменить в шаблоне текстовой строки макросы на значения
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  String: strSource
.head 5 -  String: strParams[*]
.head 5 -  Number: nParamsNum
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nIterator
.head 5 -  Number: nBound
.head 5 -  String: strRes
.head 4 +  Actions
.head 5 +  If NOT strSource
.head 6 -  Return ''
.head 5 -  Set nIterator = 0
.head 5 -  Set strRes = strSource
.head 5 -  Call SalArrayGetUpperBound( strParams, 1, nBound )
.head 5 +  While nIterator < nParamsNum
.head 6 +  If nIterator <= nBound
.head 7 -  Set strRes = VisStrSubstitute( strRes, '%'||SalNumberToStrX(nIterator+1, 0), strParams[nIterator] )
.head 7 -  Set nIterator = nIterator + 1
.head 6 +  Else
.head 7 -  Break
.head 5 -  Return strRes
.head 2 -  Named Menus
.head 2 +  Class Definitions
.head 3 +  General Window Class: cAutoLabeledWindow
.head 4 -  Description: класс окон с возможностью автоназначения
заголовков. На разных языках и пр.
.head 4 -  Derived From
.head 4 -  Class Variables
.head 4 -  Instance Variables
.head 4 -  Functions
.head 4 +  Message Actions
.head 5 +  On UM_QueryLabelText
.head 6 +  If CurrentLangTable.nAtomNum > 0
.head 7 -  Call CurrentLangTable.SetTitleToControl( hWndItem )
.head 3 +  Data Field Class: cFieldLabel
.head 4 -  Data
.head 5 -  Maximum Data Length: Class Default
.head 5 -  Data Type: Class Default
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:  
.head 6 -  Top:   
.head 6 -  Width:  1.286"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.177"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Border? No
.head 5 -  Justify: Class Default
.head 5 -  Format: Class Default
.head 5 -  Country: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Class Default
.head 4 -  List in Tool Palette? Yes
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Description: Общий класс лэйблов к полям ввода
.head 4 +  Derived From
.head 5 -  Class: cAutoLabeledWindow
.head 4 -  Class Variables
.head 4 -  Instance Variables
.head 4 -  Functions
.head 4 +  Message Actions
.head 5 +  On UM_IsFieldLabel	! Предупреждение "Я - метка поля!"
.head 6 -  Return TRUE
.head 3 +  Data Field Class: cLabelControl
.head 4 -  Data
.head 5 -  Maximum Data Length: Class Default
.head 5 -  Data Type: Class Default
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:  
.head 6 -  Top:   
.head 6 -  Width:  0.0"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.0"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
.head 5 -  Border? No
.head 5 -  Justify: Class Default
.head 5 -  Format: Class Default
.head 5 -  Country: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Class Default
.head 4 -  List in Tool Palette? Yes
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Description: Общий класс лэйблов к полям ввода
.head 4 +  Derived From
.head 5 -  Class: cAutoLabeledWindow
.head 4 -  Class Variables
.head 4 -  Instance Variables
.head 4 -  Functions
.head 4 +  Message Actions
.head 5 +  On UM_NoFontChange	! Отказ от смены фонта
.head 6 -  Return TRUE
.head 5 +  On UM_IsFieldLabel	! Предупреждение "Я - метка поля!"
.head 6 -  Return TRUE
.head 5 +  On UM_QueryLabelText
.head 6 +  If CurrentLangTable.nAtomNum > 0
.head 7 -  Call CurrentLangTable.SetTitleToControlLabel( hWndItem )
.head 3 +  Column Class: cColumnLabeled
.head 4 -  Title:
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
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
.head 4 -  Description: Колонка, запрашивающая свре название
.head 4 +  Derived From
.head 5 -  Class: cAutoLabeledWindow
.head 4 -  Class Variables
.head 4 -  Instance Variables
.head 4 -  Functions
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Pushbutton Class: cPushButtonLabeled
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:  
.head 5 -  Top:   
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
.head 4 -  List in Tool Palette? Yes
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Description: Кнопка, запрашивающая свое название
.head 4 +  Derived From
.head 5 -  Class: cAutoLabeledWindow
.head 4 -  Class Variables
.head 4 -  Instance Variables
.head 4 -  Functions
.head 4 -  Message Actions
.head 3 +  Check Box Class: cCheckBoxLabeled
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:  
.head 5 -  Top:   
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  List in Tool Palette? Yes
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Description: Автозаголовочный чек бокс
.head 4 +  Derived From
.head 5 -  Class: cAutoLabeledWindow
.head 4 -  Class Variables
.head 4 -  Instance Variables
.head 4 -  Functions
.head 4 -  Message Actions
.head 3 +  Radio Button Class: cRadioButtonLabeled
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:  
.head 5 -  Top:   
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  List in Tool Palette? Yes
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Description: Автозаголовочная Radio Button
.head 4 +  Derived From
.head 5 -  Class: cAutoLabeledWindow
.head 4 -  Class Variables
.head 4 -  Instance Variables
.head 4 -  Functions
.head 4 -  Message Actions
.head 3 -  !
.head 3 +  Functional Class: cAtom
.head 4 -  Description: структура "атома" в таблице ресурсов
.head 4 -  Derived From
.head 4 -  Class Variables
.head 4 +  Instance Variables
.head 5 -  String: strName
.head 5 -  String: strTitle
.head 5 -  String: strDefault
.head 4 +  Functions
.head 5 +  Function: Init
.head 6 -  Description: "Конструктор"
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set strName = ""
.head 7 -  Set strDefault = ""
.head 7 -  Set strTitle = ""
.head 7 -  Return TRUE
.head 3 +  Functional Class: cAtomList
.head 4 -  Description: Таблица ресурсов для контролов с 
многоязычной поддержкой
.head 4 -  Derived From
.head 4 -  Class Variables
.head 4 +  Instance Variables
.head 5 -  Number: nAtomNum
.head 5 -  : Atom[*]
.head 6 -  Class: cAtom
.head 5 -  Boolean: fConstructMode
.head 4 +  Functions
.head 5 +  Function: Init
.head 6 -  Description: Конструктор класса
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set nAtomNum = 0
.head 7 -  Return TRUE
.head 5 +  Function: InitFromFile
.head 6 -  Description: Конструктор, инициализиующийся значениями
из файла языковой поддержки с проверкой идентификатора
языка в заголовке
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: strFileName
.head 7 -  String: strLangId
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: strParId
.head 6 +  Actions
.head 7 -  Set strParId = strLangId
.head 7 -  Return InitFromFileEx( strFileName, strParId, TRUE )
.head 5 +  Function: InitFromFileEx
.head 6 -  Description: Конструктор, инициализиующийся значениями
из файла языковой поддержки без проверки идентификатора
языка в заголовке
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: strFileName
.head 7 -  Receive String: strLangId
.head 7 -  Boolean: fCheckId
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  File Handle: hFile
.head 7 -  String: sVer
.head 6 +  Actions
.head 7 -  ! Какой файл - старой структуры или новой?
.head 7 +  If NOT SalFileOpen(hFile, strFileName, OF_Read)
.head 8 -  Return FALSE
.head 7 -  Call SalFileSeek(hFile, 12, FILE_SeekBegin)
.head 7 -  Call SalFileRead(hFile, sVer, 2)
.head 7 -  Call SalFileClose(hFile)
.head 7 -  ! Новая структура
.head 7 +  If SalStrUpperX(sVer) = 'V2'
.head 8 +  If NOT InitFromFileV2(strFileName, strLangId, fCheckId)
.head 9 -  Return FALSE
.head 7 -  ! Старая структура
.head 7 +  Else
.head 8 +  If NOT InitFromFileV1(strFileName, strLangId, fCheckId)
.head 9 -  Return FALSE
.head 7 -  Return TRUE
.head 5 +  Function: InitFromFileV1
.head 6 -  Description: Конструктор, инициализиующийся значениями
из файла языковой поддержки без проверки идентификатора
языка в заголовке
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: strFileName
.head 7 -  Receive String: strLangId
.head 7 -  Boolean: fCheckId
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: hFile
.head 7 -  Number: nIterator
.head 7 -  Number: nRecordNum
.head 7 -  !
.head 7 -  String: strCtl
.head 7 -  String: strDTitle
.head 7 -  String: strSTitle
.head 6 +  Actions
.head 7 +  If strLangId = ""
.head 8 -  Set strLangId = "   "
.head 7 -  Set nRecordNum = 0
.head 7 -  !
.head 7 -  Set hFile = OpenLangFileRead( strFileName, strLangId, nRecordNum, fCheckId )
.head 7 +  If hFile <= 0
.head 8 -  Return FALSE
.head 7 +  If nRecordNum = 0
.head 8 -  Call CloseLangFile( hFile )
.head 8 -  Return FALSE
.head 7 -  Call Init()
.head 7 -  Set nIterator = 1
.head 7 +  While nIterator <= nRecordNum
.head 8 -  Set strCtl = SalStrRepeatX( " ", 255 )
.head 8 -  Set strDTitle = SalStrRepeatX( " ", 255 )
.head 8 -  Set strSTitle = SalStrRepeatX( " ", 255 )
.head 8 +  If GetLangRecord( hFile, nIterator, strCtl, strDTitle, strSTitle )
.head 9 +  If strSTitle
.head 10 -  Call AddAtomEx( strCtl, strDTitle, strSTitle )
.head 9 +  Else
.head 10 -  Call AddAtomEx( strCtl, strDTitle, strDTitle )
.head 8 -  Set nIterator = nIterator + 1
.head 7 +  If hFile > 0
.head 8 -  Call CloseLangFile( hFile )
.head 7 -  Return TRUE
.head 5 +  Function: InitFromFileV2
.head 6 -  Description: Конструктор, инициализиующийся значениями
из файла языковой поддержки без проверки идентификатора
языка в заголовке
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: strFileName
.head 7 -  Receive String: strLangId
.head 7 -  Boolean: fCheckId
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  File Handle: hFile
.head 7 -  Long String: sStr
.head 7 -  String: sStrPar[5]
.head 7 -  !
.head 7 -  String: strCtl
.head 7 -  String: strDTitle
.head 7 -  String: strSTitle
.head 6 +  Actions
.head 7 +  If NOT SalFileOpen(hFile, strFileName, OF_Read)
.head 8 -  Return FALSE
.head 7 -  Call Init()
.head 7 -  Call SalFileSeek(hFile, 14, FILE_SeekBegin)
.head 7 -  Call SalFileRead(hFile, strLangId, 3)
.head 7 -  Call SalFileSeek(hFile, 17+2, FILE_SeekBegin)
.head 7 +  While SalFileGetStr(hFile, sStr, 254*3+8) > 0
.head 8 -  Call SalStrTokenize(sStr, '', '}', sStrPar)
.head 8 -  Set strCtl    = SalStrRightX(sStrPar[0], SalStrLength(sStrPar[0]) - SalStrScan(sStrPar[0], '{') - 1)
.head 8 -  Set strDTitle = SalStrRightX(sStrPar[1], SalStrLength(sStrPar[1]) - SalStrScan(sStrPar[1], '{') - 1)
.head 8 -  Set strSTitle = SalStrRightX(sStrPar[2], SalStrLength(sStrPar[2]) - SalStrScan(sStrPar[2], '{') - 1)
.head 8 +  If strSTitle
.head 9 -  Call AddAtomEx(strCtl, strDTitle, strSTitle)
.head 8 +  Else
.head 9 -  Call AddAtomEx(strCtl, strDTitle, strDTitle)
.head 7 -  Call SalFileClose(hFile)
.head 7 -  Return TRUE
.head 5 +  Function: InitFromFileSpecial
.head 6 -  Description: Конструктор, инициализиующийся значениями
из файла языковой поддержки
без разрушения текущей языковой таблицы
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: strFileName
.head 7 -  String: strLangId
.head 7 -  String: strInstanceName
.head 7 -  Boolean: fDoNotDestroy
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  File Handle: hFile
.head 7 -  Number: nIterator
.head 7 -  Number: nRecordNum
.head 7 -  String: sVer
.head 7 -  !
.head 7 -  String: strCtl
.head 7 -  String: strDTitle
.head 7 -  String: strSTitle
.head 6 +  Actions
.head 7 -  ! Какой файл - старой структуры или новой?
.head 7 +  If NOT SalFileOpen(hFile, strFileName, OF_Read)
.head 8 -  Return FALSE
.head 7 -  Call SalFileSeek(hFile, 12, FILE_SeekBegin)
.head 7 -  Call SalFileRead(hFile, sVer, 2)
.head 7 -  Call SalFileClose(hFile)
.head 7 -  ! Новая структура
.head 7 +  If SalStrUpperX(sVer) = 'V2'
.head 8 +  If NOT InitFromFileSpecialV2(strFileName, strLangId, strInstanceName, fDoNotDestroy)
.head 9 -  Return FALSE
.head 7 -  ! Старая структура
.head 7 +  Else
.head 8 +  If NOT InitFromFileSpecialV1(strFileName, strLangId, strInstanceName, fDoNotDestroy)
.head 9 -  Return FALSE
.head 7 -  Return TRUE
.head 5 +  Function: InitFromFileSpecialV1
.head 6 -  Description: Конструктор, инициализиующийся значениями
из файла языковой поддержки
без разрушения текущей языковой таблицы
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: strFileName
.head 7 -  String: strLangId
.head 7 -  String: strInstanceName
.head 7 -  Boolean: fDoNotDestroy
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: hFile
.head 7 -  Number: nIterator
.head 7 -  Number: nRecordNum
.head 7 -  !
.head 7 -  String: strCtl
.head 7 -  String: strDTitle
.head 7 -  String: strSTitle
.head 6 +  Actions
.head 7 -  Set nRecordNum = 0
.head 7 -  !
.head 7 -  Set hFile = OpenLangFileRead( strFileName, strLangId, nRecordNum, TRUE )
.head 7 +  If hFile <= 0
.head 8 -  Return FALSE
.head 7 +  If nRecordNum = 0
.head 8 -  Call CloseLangFile( hFile )
.head 8 -  Return FALSE
.head 7 +  If NOT fDoNotDestroy
.head 8 -  Call Init()
.head 7 -  Set nIterator = 1
.head 7 +  While nIterator <= nRecordNum
.head 8 -  Set strCtl = SalStrRepeatX( " ", 255 )
.head 8 -  Set strDTitle = SalStrRepeatX( " ", 255 )
.head 8 -  Set strSTitle = SalStrRepeatX( " ", 255 )
.head 8 +  If GetLangRecord( hFile, nIterator, strCtl, strDTitle, strSTitle )
.head 9 +  If strInstanceName
.head 10 -  Set strCtl = VisStrSubstitute( strCtl, '*', strInstanceName )
.head 9 +  If strSTitle
.head 10 -  Call AddAtom( strCtl, VisStrSubstitute( strSTitle, '~', SalNumberToChar( 13 )||SalNumberToChar( 10 ) ) )
.head 9 +  Else
.head 10 -  Call AddAtom( strCtl, VisStrSubstitute( strDTitle, '~', SalNumberToChar( 13 )||SalNumberToChar( 10 ) ) )
.head 8 -  Set nIterator = nIterator + 1
.head 7 +  If hFile > 0
.head 8 -  Call CloseLangFile( hFile )
.head 7 -  Return TRUE
.head 5 +  Function: InitFromFileSpecialV2
.head 6 -  Description: Конструктор, инициализиующийся значениями
из файла языковой поддержки
без разрушения текущей языковой таблицы
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: strFileName
.head 7 -  String: strLangId
.head 7 -  String: strInstanceName
.head 7 -  Boolean: fDoNotDestroy
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  File Handle: hFile
.head 7 -  Long String: sStr
.head 7 -  String: sStrPar[3]
.head 7 -  !
.head 7 -  String: strCtl
.head 7 -  String: strDTitle
.head 7 -  String: strSTitle
.head 6 +  Actions
.head 7 +  If NOT SalFileOpen(hFile, strFileName, OF_Read)
.head 8 -  Return FALSE
.head 7 +  If NOT fDoNotDestroy
.head 8 -  Call Init()
.head 7 -  Call SalFileSeek(hFile, 17+2, FILE_SeekBegin)
.head 7 +  While SalFileGetStr(hFile, sStr, 254*3+8) > 0
.head 8 -  Call SalStrTokenize(sStr, '', '}', sStrPar)
.head 8 -  Set strCtl    = SalStrRightX(sStrPar[0], SalStrLength(sStrPar[0]) - SalStrScan(sStrPar[0], '{') - 1)
.head 8 -  Set strDTitle = SalStrRightX(sStrPar[1], SalStrLength(sStrPar[1]) - SalStrScan(sStrPar[1], '{') - 1)
.head 8 -  Set strSTitle = SalStrRightX(sStrPar[2], SalStrLength(sStrPar[2]) - SalStrScan(sStrPar[2], '{') - 1)
.head 8 +  If strSTitle
.head 9 -  Call AddAtomEx(strCtl, strDTitle, strSTitle)
.head 8 +  Else
.head 9 -  Call AddAtomEx(strCtl, strDTitle, strDTitle)
.head 7 -  Call SalFileClose(hFile)
.head 7 -  Return TRUE
.head 5 +  Function: InitFromTable
.head 6 -  Description: Заполнить список локализации из таблицы
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Window Handle: hTable
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nIterator
.head 7 -  Number: nRow
.head 7 -  !
.head 7 -  String: strCtrl
.head 7 -  String: strDTtl
.head 7 -  String: strSTtl
.head 6 +  Actions
.head 7 -  Call Init()
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow( hTable, nRow, 0, 0 )
.head 8 -  Call SalTblSetContext( hTable, nRow )
.head 8 -  Call SalTblGetColumnText( hTable, 1, strCtrl )
.head 8 -  Call SalTblGetColumnText( hTable, 2, strDTtl )
.head 8 -  Call SalTblGetColumnText( hTable, 3, strSTtl )
.head 8 -  Call AddAtomEx( strCtrl, strDTtl, strSTtl )
.head 7 -  Return TRUE
.head 5 +  Function: InitFromExtern
.head 6 -  Description: Сериализовать внешнюю таблицу
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  : cExtern
.head 8 -  Class: cAtomList
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nIterator
.head 6 +  Actions
.head 7 +  If cExtern.nAtomNum <= 0
.head 8 -  Return FALSE
.head 7 -  Call Init()
.head 7 -  Set nIterator = 0
.head 7 +  While nIterator < cExtern.nAtomNum
.head 8 -  Call AddAtomEx( cExtern.Atom[nIterator].strName,
		cExtern.Atom[nIterator].strDefault,
		cExtern.Atom[nIterator].strTitle )
.head 8 -  Set nIterator = nIterator + 1
.head 7 -  Return TRUE
.head 5 +  Function: AddAtom
.head 6 -  Description: Добавить атом в таблицу
.head 6 +  Returns
.head 7 -  Number:
.head 6 +  Parameters
.head 7 -  String: strName
.head 7 -  String: strTitle
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return AddAtomEx( strName, strTitle, strTitle )
.head 5 +  Function: AddAtomEx
.head 6 -  Description: Добавить атом в таблицу
.head 6 +  Returns
.head 7 -  Number:
.head 6 +  Parameters
.head 7 -  String: strName
.head 7 -  String: strDefault
.head 7 -  String: strTitle
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set Atom[nAtomNum].strName  = strName
.head 7 -  Set Atom[nAtomNum].strTitle = VisStrSubstitute( strTitle, '~', SalNumberToChar( 13 )||SalNumberToChar( 10 ) )
.head 7 -  Set Atom[nAtomNum].strDefault = VisStrSubstitute( strDefault, '~', SalNumberToChar( 13 )||SalNumberToChar( 10 ) )
.head 7 -  Set nAtomNum = nAtomNum + 1
.head 7 -  Return nAtomNum - 1
.head 5 +  Function: GetAtom
.head 6 -  Description: Получить элемент лингвистического списка
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: nIndex
.head 7 -  : TAtom
.head 8 -  Class: cAtom
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 +  If nIndex >= 0 AND nIndex <= nAtomNum
.head 8 -  Set TAtom.strName = Atom[nIndex].strName
.head 8 -  Set TAtom.strDefault = Atom[nIndex].strDefault
.head 8 -  Set TAtom.strTitle = Atom[nIndex].strTitle
.head 8 -  Return TRUE
.head 7 +  Else
.head 8 -  Return FALSE
.head 5 +  Function: GetAtomTitle
.head 6 -  Description: Получить заголовок ресурса
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  String: strName
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nI
.head 7 -  String: strDefTitle
.head 6 +  Actions
.head 7 -  Set nI = 0
.head 7 +  Loop
.head 8 +  If nI >= nAtomNum
.head 9 -  Break
.head 8 +  If Atom[nI].strName = strName
.head 9 -  Break
.head 8 -  Set nI = nI + 1
.head 7 +  If nI < nAtomNum
.head 8 -  Return Atom[nI].strTitle
.head 7 +  Else
.head 8 -  Return strName
.head 5 +  Function: GetAtomIndex
.head 6 -  Description: Получить индекс ресурса
.head 6 +  Returns
.head 7 -  Number:
.head 6 +  Parameters
.head 7 -  String: strName
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nI
.head 7 -  String: strDefTitle
.head 6 +  Actions
.head 7 -  Set nI = 0
.head 7 +  Loop
.head 8 +  If nI >= nAtomNum
.head 9 -  Break
.head 8 +  If Atom[nI].strName = strName
.head 9 -  Break
.head 8 -  Set nI = nI + 1
.head 7 +  If nI < nAtomNum
.head 8 -  Return nI
.head 7 +  Else
.head 8 -  Return -1
.head 5 +  Function: SetAtom
.head 6 -  Description: Назначить элемент лингвистического списка
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: nIndex
.head 7 -  : TAtom
.head 8 -  Class: cAtom
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 +  If nIndex >= 0 AND nIndex <= nAtomNum
.head 8 -  Set Atom[nIndex].strName    = TAtom.strName
.head 8 -  Set Atom[nIndex].strDefault = TAtom.strDefault
.head 8 -  Set Atom[nIndex].strTitle   = TAtom.strTitle
.head 8 -  Return TRUE
.head 7 +  Else
.head 8 -  Return FALSE
.head 5 +  Function: IsAtomExists
.head 6 -  Description: Проверяет, существует ли такой элемент
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: strName
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return GetAtomIndex( strName ) >= 0
.head 5 +  Function: GetFullReferencedControlName
.head 6 -  Description: ! Get full reference to item
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  Window Handle: hWndControl
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Window Handle: hWinUp
.head 7 -  String: strItemName
.head 7 -  Number: nUpType
.head 7 -  String: strUpName
.head 6 +  Actions
.head 7 +  If hWndControl
.head 8 -  Call SalGetItemName( hWndControl, strItemName )
.head 8 -  Set hWinUp = SalParentWindow( hWndControl )
.head 8 +  While hWinUp
.head 9 +  If SalGetItemName( hWinUp, strUpName )
.head 10 -  Set strItemName = strUpName || '.' || strItemName
.head 9 -  ! Get parent type
.head 9 -  ! If it's a window type - cut the loop
.head 9 -  ! That decreases number of referencial
.head 9 -  Set nUpType = SalGetType( hWinUp )
.head 9 +  If nUpType = TYPE_FormWindow  OR
   nUpType = TYPE_DialogBox   OR
   nUpType = TYPE_TableWindow OR
   nUpType = TYPE_MDIWindow
.head 10 -  Break
.head 9 -  Set hWinUp = SalParentWindow( hWinUp )
.head 7 -  Return strItemName
.head 5 +  Function: SetTitleToControl
.head 6 -  Description: Устанавливает заголовки полей данных, кнопок, колонок и пр.
NB! Подразумевается, что заголовки организованы в виде DataField-ов.
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  Window Handle: hWndControl
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: strItemName
.head 7 -  String: strTitle
.head 6 +  Actions
.head 7 +  If NOT hWndControl
.head 8 -  Return ''
.head 7 -  Set strTitle = ''
.head 7 -  ! Get full reference to item
.head 7 -  Set strItemName = GetFullReferencedControlName( hWndControl )
.head 7 +  If strItemName
.head 8 -  ! Now Get the title text
.head 8 -  Set strTitle = GetAtomTitle( strItemName )
.head 8 -  !
.head 8 +  If strTitle != strItemName
.head 9 +  If SalGetType( hWndControl ) = TYPE_TableColumn
.head 10 -  Call SalTblSetColumnTitle( hWndControl, strTitle )
.head 9 +  Else
.head 10 -  Call SalSetWindowText( hWndControl, strTitle )
.head 8 +  Else
.head 9 +  If fConstructMode
.head 10 +  If SalGetType( hWndControl ) = TYPE_TableColumn
.head 11 -  Call SalTblGetColumnTitle( hWndControl, strTitle, 255 )
.head 10 +  Else
.head 11 -  Call SalGetWindowText( hWndControl, strTitle, 255 )
.head 10 -  Call AddAtomEx( strItemName, strTitle, strTitle )
.head 7 -  Return strTitle
.head 5 +  Function: SetTitleToControlLabel
.head 6 -  Description: Устанавливает заголовки меток полей данных, кнопок, колонок и пр.
NB! Подразумевается, что заголовки организованы в виде BackgroundText-ов.
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  Window Handle: hWndControl
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: strItemName
.head 7 -  String: strTitle
.head 6 +  Actions
.head 7 +  If NOT hWndControl
.head 8 -  Return ''
.head 7 -  Set strTitle = ''
.head 7 -  ! Get full reference to item
.head 7 -  Set strItemName = GetFullReferencedControlName( hWndControl )
.head 7 +  If strItemName
.head 8 -  ! Now Get the title text
.head 8 -  Set strTitle = GetAtomTitle( strItemName )
.head 8 -  !
.head 8 +  If strTitle != strItemName
.head 9 -  Call SalSetWindowLabelText( hWndControl, strTitle )
.head 8 +  Else
.head 9 +  If fConstructMode
.head 10 -  Call SalGetWindowLabelText( hWndControl, strTitle, 255 )
.head 10 -  Call AddAtomEx( strItemName, strTitle, strTitle )
.head 7 -  Return strTitle
.head 5 +  Function: SaveToFile
.head 6 -  Description: Сохранить значения таблицы локализации
в файле
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: strFileName
.head 7 -  String: strLangId
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  File Handle: hFile
.head 7 -  Number: nIterator
.head 7 -  Boolean: isError
.head 6 +  Actions
.head 7 +  If NOT SalFileOpen(hFile, strFileName, OF_Text | OF_Write)
.head 8 -  Call SalMessageBox("Unable to open file " || strFileName || "!", "Save to File", MB_Ok | MB_IconStop)
.head 8 -  Return FALSE
.head 7 -  Set nIterator = 0
.head 7 +  If NOT SalFilePutStr(hFile, 'LangResourceV2' || strLangId)
.head 8 -  Return FALSE
.head 7 -  Set isError = FALSE
.head 7 +  While nIterator < nAtomNum
.head 8 +  If NOT SalFilePutStr(hFile, 
'{' || SalStrTrimX(Atom[nIterator].strName) || '} ' ||
'{' || VisStrSubstitute(SalStrTrimX(Atom[nIterator].strDefault), SalNumberToChar(13) || SalNumberToChar(10), '~') || '} ' ||
'{' || VisStrSubstitute(SalStrTrimX(Atom[nIterator].strTitle),   SalNumberToChar(13) || SalNumberToChar(10), '~') || '}')
.head 9 -  Call SalMessageBox("Error writing record to file " || strFileName || "!", "Save to File", MB_Ok | MB_IconStop)
.head 9 -  Set isError = TRUE
.head 9 -  Break
.head 8 -  Set nIterator = nIterator + 1
.head 7 -  Call SalFileClose(hFile)
.head 7 -  Return NOT isError
.head 5 -  !
.head 5 +  Function: PopulateTable
.head 6 -  Description: Населить таблицу для редактирования
(Таблица должна содержать, как минимум, 3 колонки)
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Window Handle: hTable
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nIterator
.head 7 -  Number: nNewRow
.head 6 +  Actions
.head 7 -  Call SalTblReset( hTable )
.head 7 -  Set nIterator = 0
.head 7 +  While nIterator < nAtomNum
.head 8 -  Set nNewRow = SalTblInsertRow( hTable, TBL_MaxRow )
.head 8 +  If nNewRow != TBL_Error
.head 9 -  Call SalTblSetContext( hTable, nNewRow )
.head 9 -  Call SalTblSetRowFlags( hTable, nNewRow, ROW_New, FALSE )
.head 9 -  Call SalTblSetColumnText( hTable, 1, Atom[nIterator].strName )
.head 9 -  Call SalTblSetColumnText( hTable, 2, VisStrSubstitute( Atom[nIterator].strDefault,SalNumberToChar( 13 )||SalNumberToChar( 10 ),'~' ) )
.head 9 -  Call SalTblSetColumnText( hTable, 3, VisStrSubstitute( Atom[nIterator].strTitle,SalNumberToChar( 13 )||SalNumberToChar( 10 ),'~' ) )
.head 8 -  Set nIterator = nIterator + 1
.head 7 -  Return TRUE
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
