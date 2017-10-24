.head 0 +  Application Description: ! Библиотека функций формирования динамического условия
! фильтра при просмотре массива записей таблицы
! + Поисковые функции
! + Функции визуализации таблицы по колонкам.
! -----------------------------------------------------
! Разработчик: Сыропоршнев Д.Л. (С) 1998-2004
! -----------------------------------------------------
.head 1 -  Outline Version - 4.0.26
.head 1 +  Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000CC0000 002C000000020000 0003000000FFFFFF FFFFFFFFFFF8FFFF
0040: FFE2FFFFFF000000 00000000002C0300 00B8010000010000 0001000000010000
0060: 000F4170706C6963 6174696F6E497465 6D01000000075769 6E646F7773
.enddata
.data DT_MAKERUNDLG
0000: 0200000000001E51 3A5C424152533938 5C4C494252415259 5C44464C54524150
0020: 492E646C6C1E513A 5C4241525339385C 4C4942524152595C 44464C5452415049
0040: 2E61706300000101 011E513A5C424152 5339385C4C494252 4152595C44464C54
0060: 524150492E72756E 1E513A5C42415253 39385C4C49425241 52595C44464C5452
0080: 4150492E646C6C1E 513A5C4241525339 385C4C4942524152 595C44464C545241
00A0: 50492E6170630000 010101185C424152 5339385C42494E5C 64666C7472617069
00C0: 2E617064185C4241 525339385C42494E 5C64666C74726170 692E646C6C185C42
00E0: 41525339385C4249 4E5C64666C747261 70692E6170630000 010101001E513A5C
0100: 4241525339385C4C 4942524152595C44 464C54524150492E 646C6C1E513A5C42
0120: 41525339385C4C49 42524152595C4446 4C54524150492E61 70630000010101
.enddata
.head 2 -  Outline Window State: Normal
.head 2 +  Outline Window Location and Size
.data VIEWINFO
0000: 6600040003001B00 0000000000000000 0000E91EB20C0500 1D00FFFF4D61696E
0020: 0029000100000000 0000000000E91E80 0A00008600FFFF49 6E7465726E616C20
0040: 46756E6374696F6E 7300200001000000 000000000000E91E 800A0000DF00FFFF
0060: 5661726961626C65 73001E0001000000 000000000000F51E 100D0000F400FFFF
0080: 436C617373657300
.enddata
.data VIEWSIZE
0000: 8800
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
.head 3 -  Visible? Yes
.head 3 -  Left:   6.4"
.head 3 -  Top:    0.729"
.head 2 -  Fully Qualified External References? No
.head 2 -  Reject Multiple Window Instances? Yes
.head 2 -  Enable Runtime Checks Of External References? Yes
.head 2 -  Use Release 4.0 Scope Rules? No
.head 1 +  Libraries
.head 2 -  Dynalib: Global.apd
.head 2 -  Dynalib: Message.apd
.head 2 -  Dynalib: Absapi.apd
.head 2 -  !
.head 2 -  File Include: qcktabs.apl
.head 2 -  File Include: Vttblwin.apl
.head 2 -  File Include: Constant.apl
.head 2 -  File Include: Genfcls.apl
.head 2 -  File Include: Genbutn.apl
.head 2 -  File Include: Genfiltr.apl
.head 2 -  File Include: GENLABEL.APL
.head 2 -  File Include: WinAPI.apl
.head 1 +  Global Declarations
.head 2 +  Window Defaults
.head 3 +  Tool Bar
.head 4 -  Display Style? Etched
.head 4 -  Font Name: System Default
.head 4 -  Font Size: System Default
.head 4 -  Font Enhancement: System Default
.head 4 -  Text Color: System Default
.head 4 -  Background Color: System Default
.head 3 +  Form Window
.head 4 -  Display Style? Etched
.head 4 -  Font Name: System Default
.head 4 -  Font Size: System Default
.head 4 -  Font Enhancement: System Default
.head 4 -  Text Color: System Default
.head 4 -  Background Color: System Default
.head 3 +  Dialog Box
.head 4 -  Display Style? Etched
.head 4 -  Font Name: System Default
.head 4 -  Font Size: System Default
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
.head 4 -  Background Color: Use Parent
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
.head 4 -  Number: FLTR_START    = 0
.head 4 -  Number: FLTR_LPARANT  = 1 
.head 4 -  Number: FLTR_RPARANT  = 2
.head 4 -  Number: FLTR_ATOM     = 3
.head 4 -  Number: FLTR_OPERATOR = 4
.head 4 -  Number: FLTR_ISNULLOP = 7
.head 4 -  Number: FLTR_SIGN     = 5
.head 4 -  Number: FLTR_STOP     = 6
.head 2 +  Resources
.head 2 +  Variables
.data RESOURCE 0 0 1 1502803507
0000: 380000001D000000 0000000000000000 020000020000003C 000000E0010D0000
0020: 00FF3F4900800000 0204000000FFFF
.enddata
.head 3 -  Boolean: fInitLib
.head 3 -  ! cAtomList: LangTable
.head 3 -  !
.head 3 -  Number: nFetchRes
.head 3 -  !
.head 2 +  Internal Functions
.head 3 +  Function: DfltrApi_Ini
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strPathToLangResources
.head 5 -  String: strLangId
.head 5 -  ! !
.head 5 -  String: strFileName
.head 4 +  Actions
.head 5 +  If NOT fInitLib
.head 6 -  Set strPathToLangResources = GetLangPath()
.head 6 -  Set strLangId = GetLang()
.head 6 -  Set strFileName = strPathToLangResources || "\\" || strLangId || "\\dfltrapi.lng"
.head 6 -  !
.head 6 +  If (NOT strLangId) OR (NOT CurrentLangTable.InitFromFile( strFileName, strLangId ))
.head 7 -  Call CurrentLangTable.Init()
.head 7 -  !
.head 7 -  Call CurrentLangTable.AddAtom('cTAt', 'Внимание!')
.head 7 -  Call CurrentLangTable.AddAtom('cTErr','Ошибка!')
.head 7 -  Call CurrentLangTable.AddAtom('cTSyntaxErr','Синтаксическая ошибка')
.head 7 -  ! ====================================================
.head 7 -  ! dlg_GetFilterName
.head 7 -  Call CurrentLangTable.AddAtom('dlg_GetFilterName.cTWndTitle','Задайте имя фильтра...')
.head 7 -  ! button
.head 7 -  Call CurrentLangTable.AddAtom('dlg_GetFilterName.pbOk','Утвердить')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_GetFilterName.pbCancel','Отменить')
.head 7 -  ! Constants
.head 7 -  Call CurrentLangTable.AddAtom('dlg_GetFilterName.cTName','Новый фильтр')
.head 7 -  ! ====================================================
.head 7 -  ! dlg_GetValue
.head 7 -  ! Button strTip
.head 7 -  Call CurrentLangTable.AddAtom('dlg_GetValue.cBTipFind',  'Найти запись')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_GetValue.cBTipSelect','Выбрать запись')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_GetValue.cBTipExit',  'Выйти')
.head 7 -  ! ====================================================
.head 7 -  ! dlg_SetColumnStatus
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetColumnStatus.cTWndTitle','Колонки таблицы...')
.head 7 -  ! Button strTip
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetColumnStatus.cBTipShowColumn','Показывать колонку')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetColumnStatus.cBTipShowAll','Показывать все колонки')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetColumnStatus.cBTipHideColumn','Не показывать колонку')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetColumnStatus.cBTipHideAll','Не показывать все колонки')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetColumnStatus.cBTipDecPosition','Уменьшить позицию колонки')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetColumnStatus.cBTipIncPosition','Увеличить позицию колонки')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetColumnStatus.cBTipRefresh','Установить начальные значения колонок')
.head 7 -  ! button
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetColumnStatus.pbOk','Утвердить')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetColumnStatus.pbCancel','Отменить')
.head 7 -  ! Columns
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetColumnStatus.tblColumns.colName','Наименование колонки')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetColumnStatus.tblColumns.colVisible','Показывать')
.head 7 -  ! ====================================================
.head 7 -  ! dlg_SetFilter
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cTWndTitle','Фильтр')
.head 7 -  ! Tabs
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cTabs0','Системный ')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cTabs1','Пользовательский ')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cTabs2','Новый ')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cTabs3','Простой ')
.head 7 -  ! button
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.pbApply','Применить')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.pbCancel','Отменить')
.head 7 -  ! System
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cbFSystem','Использовать Системный фильтр')
.head 7 -  ! Columns
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.tblFSystem.colID','Код~фильтра')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.tblFSystem.colName','Наименование')
.head 7 -  ! Users
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cbFUser','Использовать Пользовательский фильтр')
.head 7 -  ! Button strTip
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cBTipUDelete','Удалить фильтр')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cBTipUSave','Сохранить измения в БД')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cBTipShowCondition','Просмотреть значение фильтра...')
.head 7 -  ! Columns
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.tblFUser.colID','Код~фильтра')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.tblFUser.colName','Наименование')
.head 7 -  ! New
.head 7 -  ! Button strTip
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cBTipInsertBefore','Вставить строку фильтра')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cBTipInsert','Добавить строку фильтра')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cBTipDelete','Удалить строку фильтра')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cBTipDeleteAll','Удалить все строки фильтра')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cBTipGetValue','Выбрать значение из возможных')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cBTipGetFormula','Выбрать формулу из возможных')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cBTipCheck','Проверить синтаксис сформированого фильтра')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cBTipSave','Сохранить сформированый фильтр в БД')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cBTipRefresh','Очистить')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cBTipApply','Сохранить')
.head 7 -  ! Columns
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.tblFString.colOp','И/ИЛИ')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.tblFString.colTag','Атрибут')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.tblFString.colSign','Оператор')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.tblFString.colValue','Значение')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.tblFString.colSemantic','Семантика значения')
.head 7 -  ! Error text
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cTErr1','Недопустимое выражение после оператора сравнения')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cTErr2','Недопустимое выражение после оператора IS NULL/IS NOT NULL')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cTErr3','Недопустимое выражение после логического оператора')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cTErr4','Недопустимое начало логического выражения фильтра')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cTErr5','Недопустимое выражение после открывающей скобки')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cTErr6','Недопустимое выражение после закрывающей скобки')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cTErr7','Недопустимое выражение после атрибута или значения')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cTErr8','Пропущена ЗАКРЫВАЮЩАЯ скобка')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cTErr9','Пропущена ОТКРЫВАЮЩАЯ скобка')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cTErrType','Недопустимый тип данных для этого атрибута!')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cTErrList','Неверный список значений для этого атрибута!')
.head 7 -  !
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cTSetFilter','Задействован фильтр')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilter.cTSetNotFilter','Задействована нефильтрованная (полная) выборка')
.head 7 -  ! ====================================================
.head 7 -  ! Simple
.head 7 -  ! Columns
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilterEx.tblFSimple.colTag','Атрибут')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetFilterEx.tblFSimple.colValue','Значение')
.head 7 -  ! ====================================================
.head 7 -  ! dlg_SetDFilter
.head 7 -  ! System Columns
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetDFilter.tblFSystem.colApply','Использовать~фильтр')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetDFilter.tblFSystem.colID','Код~фильтра')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetDFilter.tblFSystem.colName','Наименование')
.head 7 -  ! User Columns
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetDFilter.tblFUser.colApply','Использовать~фильтр')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetDFilter.tblFUser.colID','Код~фильтра')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetDFilter.tblFUser.colName','Наименование')
.head 7 -  ! New Columns
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetDFilter.tblFString.colOp','И/ИЛИ')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetDFilter.tblFString.colTag','Атрибут')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetDFilter.tblFString.colSign','Оператор')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetDFilter.tblFString.colValue','Значение')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetDFilter.tblFString.colSemantic','Семантика значения')
.head 7 -  ! ====================================================
.head 7 -  ! Simple
.head 7 -  ! Columns
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetDFilterEx.tblFSimple.colTag','Атрибут')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetDFilterEx.tblFSimple.colValue','Значение')
.head 7 -  ! ====================================================
.head 7 -  ! dlg_SetSearch
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetSearch.cTWndTitle','Поиск...')
.head 7 -  ! button
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetSearch.pbDone','Искать!')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetSearch.pbCancel','Отменить')
.head 7 -  ! BG
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetSearch.bgTblFields','Поле таблицы:')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetSearch.bgSearch','Искать:')
.head 7 -  !
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetSearch.cTSetSearch','Задействован поиск')
.head 7 -  ! ====================================================
.head 7 -  ! TblFindString
.head 7 -  Call CurrentLangTable.AddAtom('TblFindString.cTSearchOther','Просмотрена вся таблица, значения не найдено. Искать другое?')
.head 7 -  Call CurrentLangTable.AddAtom('TblFindString.cTSearchFarther','Искать дальше?')
.head 7 -  Call CurrentLangTable.AddAtom('TblFindString.cTNotName','Без имени')
.head 7 -  ! ====================================================
.head 7 -  ! dlg_ShowFilter
.head 7 -  Call CurrentLangTable.AddAtom('dlg_ShowFilter.cTWndTitle','Выражение фильтра')
.head 7 -  ! ====================================================
.head 7 -  ! Call CurrentLangTable.SaveToFile('C:\\TEMP\\dfltrapi.lng','RUS')
.head 6 -  !
.head 6 -  Set fInitLib = TRUE
.head 5 -  Return fInitLib
.head 3 -  !
.head 3 +  Function: SetQueryFilter	! __exported
.head 4 -  Description: Установить условие WHERE для запроса через
класс фильтра
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  : cF
.head 6 -  Class: cGenFilter
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call DfltrApi_Ini()
.head 5 -  Return SalModalDialog(dlg_SetFilter, hWndForm, cF, FALSE)
.head 3 +  Function: SetQueryFilterEx	! __exported
.head 4 -  Description: Установить условие WHERE для запроса через
класс фильтра
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  : cF
.head 6 -  Class: cGenFilterEx
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call DfltrApi_Ini()
.head 5 -  Return SalModalDialog(dlg_SetFilterEx, hWndForm, cF, FALSE)
.head 3 +  Function: SetQueryDFilter	! __exported
.head 4 -  Description: Установить условие WHERE для запроса через
класс фильтра
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  : cF
.head 6 -  Class: cGenDFilter
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call DfltrApi_Ini()
.head 5 -  Return SalModalDialog(dlg_SetDFilter, hWndForm, cF, FALSE)
.head 3 +  Function: SetQueryDFilterEx	! __exported
.head 4 -  Description: Установить условие WHERE для запроса через
класс фильтра
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  : cF
.head 6 -  Class: cGenDFilterEx
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call DfltrApi_Ini()
.head 5 -  Return SalModalDialog(dlg_SetDFilterEx, hWndForm, cF, FALSE)
.head 3 +  Function: SetPlainFilter	! __exported
.head 4 -  Description: Установить чистый фильтр, без применения
системного и пользовательского
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  : cF
.head 6 -  Class: cGenFilter
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call DfltrApi_Ini()
.head 5 -  Return SalModalDialog( dlg_SetFilter, hWndForm, cF, TRUE )
.head 3 -  !
.head 3 +  Function: TblFindString		! __exported
.head 4 -  Description: Поиск строки в таблице
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Window Handle: hWndTbl
.head 5 -  Number: nSearchMode
.head 4 +  Static Variables
.head 5 -  Number: nColId
.head 5 -  String: sColVal
.head 4 +  Local variables
.head 5 -  Number: nRow
.head 5 -  Number: nRowStart
.head 5 -  Window Handle: hCol
.head 4 +  Actions
.head 5 -  Call DfltrApi_Ini()
.head 5 +  Select Case nSearchMode
.head 6 +  Case DFIND_First
.head 7 -  Call SalTblQueryFocus( hWndForm, nRow, hCol )
.head 7 +  If NOT GetTblSearchVal( hWndTbl, nColId, sColVal )
.head 8 -  Return FALSE
.head 7 -  Break
.head 6 +  Case DFIND_Again
.head 7 -  Call SalTblQueryFocus( hWndForm, nRow, hCol )
.head 7 -  Set nRow = nRow + 1
.head 7 -  Break
.head 6 +  Default
.head 7 -  Call SalTblQueryFocus( hWndForm, nRow, hCol )
.head 7 -  Break
.head 5 -  Set nRowStart = nRow
.head 5 -  Call SalWaitCursor( TRUE )
.head 5 -  Call SalTblSetRowFlags( hWndTbl, nRow, ROW_Selected, FALSE )
.head 5 +  Loop
.head 6 -  Set nRow = VisTblFindString( hWndTbl, nRow,
    SalTblGetColumnWindow( hWndTbl, nColId, COL_GetID ), StrMatches2Like( sColVal) )
.head 6 +  If nRow = -1	! Not Found
.head 7 -  Call SalWaitCursor( FALSE )
.head 7 -  Call SalMessageBeep( MB_IconInformation )
.head 7 -  ! SalMessageBox( 'Просмотрена вся таблица, значения не найдено. Искать другое?', 'Внимание!', MB_IconQuestion | MB_YesNo ) = IDYES
.head 7 +  If SalMessageBox(CurrentLangTable.GetAtomTitle('TblFindString.cTSearchOther'), 
   CurrentLangTable.GetAtomTitle('cTAt'), MB_IconQuestion | MB_YesNo ) = IDYES
.head 8 +  If NOT GetTblSearchVal( hWndTbl, nColId, sColVal )
.head 9 -  Return FALSE
.head 8 -  Set nRow = 0
.head 8 -  Call SalTblSetFocusRow( hWndTbl, nRow )
.head 8 -  Call SalTblSetContext( hWndTbl, nRow )
.head 8 -  Call SalWaitCursor( TRUE )
.head 7 +  Else
.head 8 -  Return FALSE
.head 6 +  Else
.head 7 -  Call SalTblSetFocusRow( hWndTbl, nRow )
.head 7 -  Call SalTblSetContext( hWndTbl, nRow )
.head 7 -  Call SalTblSetRowFlags( hWndTbl, nRow, ROW_Selected, TRUE )
.head 7 -  Call SalWaitCursor( FALSE )
.head 7 -  Call SalMessageBeep( MB_IconInformation )
.head 7 -  ! SalMessageBox( 'Искать дальше?', 'Внимание!', MB_IconQuestion | MB_YesNo ) = IDYES
.head 7 +  If SalMessageBox(CurrentLangTable.GetAtomTitle('TblFindString.cTSearchFarther'), 
   CurrentLangTable.GetAtomTitle('cTAt'), MB_IconQuestion | MB_YesNo ) = IDYES
.head 8 -  Set nRow = nRow + 1
.head 8 -  Call SalWaitCursor( TRUE )
.head 7 +  Else
.head 8 -  Break
.head 5 -  Call SalWaitCursor( FALSE )
.head 5 -  Return TRUE
.head 3 +  Function: GetTblSearchVal	! __exported
.head 4 -  Description: Ввод значения поиска и выбор колонки-критерия
для таблицы (умолчательный)
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Window Handle: hWndTbl
.head 5 -  Receive Number: nCol
.head 5 -  Receive String: strSVal
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nC
.head 5 -  String: sV
.head 5 -  Boolean: fRet
.head 4 +  Actions
.head 5 -  Call DfltrApi_Ini()
.head 5 -  Set nC = nCol
.head 5 -  Set sV = strSVal
.head 5 -  !
.head 5 -  Set fRet =  GetTblSearchValEx(hWndTbl, nC, sV, SRCH_Normal)
.head 5 -  !
.head 5 -  Set nCol = nC
.head 5 -  Set strSVal = sV
.head 5 -  !
.head 5 -  Return fRet
.head 3 +  Function: GetTblSearchValEx	! __exported
.head 4 -  Description: Ввод значения поиска и выбор колонки-критерия
для таблицы (параметризированый)
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Window Handle: hWndTbl
.head 5 -  Receive Number: nCol
.head 5 -  Receive String: strSVal
.head 5 -  Number: nFlagsSearch
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strColArray[*,2]
.head 5 -  Number: nColNum
.head 5 -  Number: nColAll
.head 5 -  Window Handle: hChild
.head 5 -  !
.head 5 -  Number: ntmpCol
.head 5 -  String: strtmpStr
.head 5 -  Number: nRet
.head 4 +  Actions
.head 5 -  Call DfltrApi_Ini()
.head 5 -  Set nColNum = 1
.head 5 -  Set nColAll = 0
.head 5 -  Set hChild =  SalTblGetColumnWindow( hWndTbl, nColNum, COL_GetID )
.head 5 +  While hChild != hWndNULL
.head 6 +  If IsColumnSuitable( hChild, nFlagsSearch )
.head 7 -  Set nColAll = nColAll + 1
.head 7 +  If nCol = nColNum
.head 8 -  Set nCol = nColAll
.head 7 -  Call SalTblGetColumnTitle( hChild, strColArray[nColAll-1, 0], 255 )
.head 7 +  If strColArray[nColAll-1, 0] = '(untitled)'
.head 8 -  ! Set strColArray[nColAll-1, 0] = 'Без имени #' || SalNumberToStrX( nColNum, 0 )
.head 8 -  Set strColArray[nColAll-1, 0] = CurrentLangTable.GetAtomTitle('TblFindString.cTNotName') || ' #' || SalNumberToStrX( nColNum, 0 )
.head 7 -  Call SalNumberToStr( nColNum, 0, strColArray[nColAll-1, 1] )
.head 6 -  Set nColNum = nColNum + 1
.head 6 -  Set hChild =  SalTblGetColumnWindow( hWndTbl, nColNum, COL_GetID )
.head 5 +  If nColAll>0
.head 6 -  Set ntmpCol = nCol
.head 6 -  Set strtmpStr = strSVal
.head 6 -  Set nRet = SalModalDialog(dlg_SetSearch, hWndForm, strColArray, nColAll, ntmpCol, strtmpStr )
.head 6 +  If nRet
.head 7 -  Set nCol = ntmpCol
.head 7 -  Set strSVal = strtmpStr 
.head 6 -  Return nRet
.head 5 +  Else
.head 6 -  Return FALSE
.head 3 +  Function: IsColumnSuitable
.head 4 -  Description: подходит ли колонка для формировнаия критерия поиска
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Window Handle: hWndCol
.head 5 -  Number: nFlags
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sColTitle
.head 4 +  Actions
.head 5 -  Call SalTblGetColumnTitle( hWndCol, sColTitle, 255 )
.head 5 -  Return SalIsWindowVisible( hWndCol ) OR
(sColTitle != '(untitled)' AND ( nFlags & SRCH_UseHiddenNamed )) OR
(sColTitle = '(untitled)' AND ( nFlags & SRCH_UseHiddenUnNamed ))

.head 3 +  Function: SubFunParseTableName
.head 4 -  Description: Разбор имени таблицы, отсечение имени базы и сервера
.head 4 +  Returns
.head 5 -  String: strPlainName
.head 4 +  Parameters
.head 5 -  String: strFullName
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nColonPos
.head 5 -  String: strPlainName
.head 4 +  Actions
.head 5 -  Set nColonPos = SalStrScan( strFullName, ':' )
.head 5 +  If nColonPos = -1
.head 6 -  Set strPlainName = strFullName
.head 5 +  Else
.head 6 -  Set strPlainName = SalStrMidX( strFullName, nColonPos+1, SalStrLength( strFullName ) - (nColonPos+1))
.head 5 -  Return SalStrUpperX( strPlainName )
.head 3 -  !
.head 3 +  Function: SetTblColumnStatus	! __exported
.head 4 -  Description: Манипулирует видимостью и позицией колонок таблицы
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Window Handle: hWndParent
.head 5 -  : TSupTable
.head 6 -  Class: cABSTab
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call DfltrApi_Ini()
.head 5 -  Return SalModalDialog( dlg_SetColumnStatus, hWndParent, TSupTable )
.head 3 -  !
.head 2 -  Named Menus
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
.head 3 -  Multiline Field: cQuickMLField
.head 3 -  Pushbutton: ctb_pbRefresh
.head 3 -  Radio Button:
.head 3 -  Option Button:
.head 3 -  Check Box: cCheckBoxLabeled
.head 3 -  Child Table:
.head 3 -  Quest Child Window: cQuickDatabase
.head 3 -  List Box:
.head 3 -  Combo Box:
.head 3 -  Picture: cQuickPicture
.head 3 -  Vertical Scroll Bar:
.head 3 -  Horizontal Scroll Bar:
.head 3 -  Column:
.head 3 -  Background Text:
.head 3 -  Group Box:
.head 3 -  Line:
.head 3 -  Frame:
.head 3 -  Custom Control: cQuickGraph
.head 2 -  Application Actions
.head 1 -  !
.head 1 +  Dialog Box: dlg_SetFilter
.head 2 -  Class: cQuickTabsDialog
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Фильтр
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   0.5"
.head 4 -  Top:    0.5"
.head 4 -  Width:  11.057"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 4.354"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: MS Sans Serif
.head 3 -  Font Size: 8
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Показывает/создает/редактирует фильтр на таблицу
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
.head 3 -  ! ***** Системный фильтр *****
.head 3 +  Child Table: tblFSystem
.data CLASSPROPSSIZE
0000: 1A00
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 5379735461670000 0000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.186"
.head 6 -  Top:    0.344"
.head 6 -  Width:  10.657"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 2.698"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? No
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  View: Table
.head 5 -  Allow Row Sizing? No
.head 5 -  Lines Per Row: Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: 1000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colID
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
фильтра
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 5
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.2"
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
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 70
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  8.7"
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
.head 5 +  Column: colFromClause
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
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
.head 5 +  Column: colWhereClause
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 2000
.head 6 -  Data Type: Long String
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
.head 4 -  Functions
.head 4 +  Window Variables
.head 5 -  Boolean: bSortOrd
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 6 -  Call SalTblSetTableFlags(hWndForm, TBL_Flag_SelectableCols, TRUE)
.head 6 +  If NOT fPlainMode
.head 7 -  Set nSysFilterNum = 0
.head 7 -  Call SqlSetLongBindDatatype(4, 22)
.head 7 -  Call SalTblPopulate(hWndForm, FSys.hSql(), 
"SELECT filter_id, semantic, from_clause, where_clause
 INTO :colID, :colName, :colFromClause, :colWhereClause 
 FROM dyn_filter
 WHERE tabid = :F.nFTabId AND userid IS NULL 
 ORDER BY semantic", TBL_FillAll)
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  If F.nSysRow > 0 and cbFSystem
.head 8 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 9 -  Call SalTblSetContext(hWndForm, nRow)
.head 9 +  If F.nSysRow = colID
.head 10 -  Break
.head 7 +  Else
.head 8 -  Set nRow = 0
.head 7 -  Call SalTblSetContext(hWndForm, nRow)
.head 7 -  Call SalTblSetFocusRow(hWndForm, nRow)
.head 7 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_Selected, TRUE)
.head 5 +  On SAM_FetchRowDone
.head 6 -  Set nSysFilterNum = nSysFilterNum + 1
.head 5 +  On UM_NoFontChange
.head 6 -  Return TRUE
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndForm)
.head 5 +  On SAM_ColumnSelectClick
.head 6 -  Call SalTblSetColumnFlags(SalNumberToWindowHandle(wParam), COL_Selected, FALSE)
.head 6 -  Set bSortOrd = not bSortOrd
.head 6 -  Call SalTblSortRows(hWndForm, SalTblQueryColumnID(SalNumberToWindowHandle(wParam)), bSortOrd)
.head 3 +  Check Box: cbFSystem
.data INHERITPROPS
0000: 0100
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 5379735461670000 0000
.enddata
.data CLASSPROPSSIZE
0000: 1A00
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cCheckBoxLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Использовать Системный фильтр
.head 4 -  Window Location and Size
.head 5 -  Left:   0.186"
.head 5 -  Top:    3.073"
.head 5 -  Width:  5.471"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set F.fSystemFilterInUse = NOT F.fSystemFilterInUse
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow( hWndItem )
.head 3 -  ! ***** Пользовательский фильтр *****
.head 3 -  Frame
.data CLASSPROPSSIZE
0000: 1B00
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000800 5573657254616700 000000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Resource Id: 24833
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.186"
.head 5 -  Top:    0.344"
.head 5 -  Width:  1.057"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.396"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 3 +  Pushbutton: pbUDelete
.data CLASSPROPSSIZE
0000: 1B00
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000800 5573657254616700 000000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbDelete
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.286"
.head 5 -  Top:    0.385"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Удалить фильтр
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipUDelete')
.head 5 +  On SAM_Click
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call SqlPrepare(FUsr.hSql(), 'DELETE FROM dyn_filter WHERE filter_id = :tblFUser.colID')
.head 6 +  If SalTblDoDeletes(tblFUser, FUsr.hSql(), ROW_Selected)
.head 7 -  Call SqlCommit(FUsr.hSql())
.head 7 -  Set F.nUserRow = 0
.head 6 -  Call SalSendMsg(tblFUser, SAM_Create, 0, 0)
.head 6 +  If NOT nUserFilterNum
.head 7 -  Call Tags.Enable(1, FALSE)
.head 7 -  Call Tags.Next()
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Pushbutton: pbUSave
.data CLASSPROPSSIZE
0000: 1B00
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000800 5573657254616700 000000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbUpdate
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.714"
.head 5 -  Top:    0.385"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Сохранить измения в БД
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipUSave')
.head 5 +  On SAM_Click
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call SqlPrepare(FUsr.hSql(), 'UPDATE dyn_filter SET semantic = :tblFUser.colName WHERE filter_id = :tblFUser.colID')
.head 6 +  If SalTblDoUpdates(tblFUser, FUsr.hSql(), TRUE)
.head 7 -  Call SqlCommit(FUsr.hSql())
.head 6 +  Else
.head 7 -  Call SqlRollback(FUsr.hSql()) 
.head 6 -  Call SalSendMsg(tblFUser, SAM_Create, 0, 0)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Pushbutton: pbShowCondition
.data CLASSPROPSSIZE
0000: 1900
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000800 5573657254616700 00
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbEdit
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.314"
.head 5 -  Top:    0.385"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Просмотреть значение фильтра...
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipShowCondition')
.head 5 +  On SAM_Click
.head 6 -  Set sTmp = tblFUser.colWhereClause
.head 6 +  If SalModalDialog(dlg_ShowFilter, hWndForm, FUsr.hSql(), tblFUser.colID, sTmp)
.head 7 +  If sTmp != tblFUser.colWhereClause
.head 8 -  Set tblFUser.colWhereClause = sTmp
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Child Table: tblFUser
.data CLASSPROPSSIZE
0000: 1900
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000800 5573657254616700 00
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.186"
.head 6 -  Top:    0.75"
.head 6 -  Width:  10.657"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 2.292"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? No
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  View: Table
.head 5 -  Allow Row Sizing? No
.head 5 -  Lines Per Row: Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: 2000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colID
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
фильтра
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 5
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.2"
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
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: 70
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  8.7"
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
.head 5 +  Column: colFromClause
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
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
.head 5 +  Column: colWhereClause
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 2000
.head 6 -  Data Type: Long String
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
.head 4 -  Functions
.head 4 +  Window Variables
.head 5 -  Boolean: bSortOrd
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 6 -  Call SalTblSetTableFlags(hWndForm, TBL_Flag_SelectableCols, TRUE)
.head 6 +  If NOT fPlainMode
.head 7 -  Set nUserFilterNum = 0
.head 7 -  Call SqlSetLongBindDatatype(4, 22)
.head 7 -  Call SalTblPopulate(hWndForm, FUsr.hSql(), 
"SELECT filter_id, semantic, from_clause, where_clause
   INTO :colID, :colName, :colFromClause, :colWhereClause 
   FROM dyn_filter
  WHERE tabid = :F.nFTabId AND userid = :nUserId 
  ORDER BY semantic", TBL_FillAll)
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  If F.nUserRow > 0 and cbFUser
.head 8 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 9 -  Call SalTblSetContext(hWndForm, nRow)
.head 9 +  If F.nUserRow = colID
.head 10 -  Break
.head 7 +  Else
.head 8 -  Set nRow = 0
.head 7 -  Call SalTblSetContext(hWndForm, nRow)
.head 7 -  Call SalTblSetFocusRow(hWndForm, nRow)
.head 7 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_Selected, TRUE)
.head 5 +  On SAM_FetchRowDone
.head 6 -  Set nUserFilterNum = nUserFilterNum + 1
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndForm)
.head 5 +  On UM_NoFontChange
.head 6 -  Return TRUE
.head 5 +  On SAM_ColumnSelectClick
.head 6 -  Call SalTblSetColumnFlags(SalNumberToWindowHandle(wParam), COL_Selected, FALSE)
.head 6 -  Set bSortOrd = not bSortOrd
.head 6 -  Call SalTblSortRows(hWndForm, SalTblQueryColumnID(SalNumberToWindowHandle(wParam)), bSortOrd)
.head 3 +  Check Box: cbFUser
.data INHERITPROPS
0000: 0100
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000800 5573657254616700 00
.enddata
.data CLASSPROPSSIZE
0000: 1900
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cCheckBoxLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Использовать Пользовательский фильтр
.head 4 -  Window Location and Size
.head 5 -  Left:   0.186"
.head 5 -  Top:    3.073"
.head 5 -  Width:  4.929"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set F.fUserFilterInUse = NOT F.fUserFilterInUse
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 -  ! ***** Новый фильтр *****
.head 3 -  Frame
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Resource Id: 26942
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.186"
.head 5 -  Top:    0.344"
.head 5 -  Width:  1.057"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.396"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 3 +  Pushbutton: pbInsertBefore
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbInsert
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.183"
.head 5 -  Top:    0.381"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\C2.BMP
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Вставить строку фильтра
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipInsertBefore')
.head 5 +  On SAM_Click
.head 6 -  Set nRow = SalTblQueryContext(tblFString)
.head 6 -  Call SalTblSetRowFlags(tblFString, nRow, ROW_Selected, FALSE)
.head 6 -  Set nRow = SalTblInsertRow(tblFString, nRow)
.head 6 +  If nRow != TBL_Error
.head 7 -  Call SalSetFocus(tblFString)
.head 7 -  Call SalTblSetFocusRow(tblFString, nRow)
.head 7 -  Call SalTblSetRowFlags(tblFString, nRow, ROW_Selected, TRUE)
.head 7 -  Call SalTblSetRowFlags(tblFString, nRow, ROW_New, FALSE)
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Pushbutton: pbInsert
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbInsert
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.617"
.head 5 -  Top:    0.381"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Insert.bmp
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Добавить строку фильтра
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipInsert')
.head 5 +  On SAM_Click
.head 6 -  Call SalTblSetRowFlags(tblFString, SalTblQueryContext(tblFString), ROW_Selected, FALSE)
.head 6 -  Set nRow = SalTblInsertRow(tblFString, TBL_MaxRow)
.head 6 +  If nRow != TBL_Error
.head 7 -  Call SalSetFocus(tblFString)
.head 7 -  Call SalTblSetFocusRow(tblFString, nRow)
.head 7 -  Call SalTblSetRowFlags(tblFString, nRow, ROW_New, FALSE)
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Pushbutton: pbDelete
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cTBarButton
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.05"
.head 5 -  Top:    0.381"
.head 5 -  Width:  0.43"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.317"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Delete.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Удалить строку фильтра
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipDelete')
.head 5 +  On SAM_Click
.head 6 -  Set nRow = TBL_MinRow
.head 6 +  While SalTblFindNextRow( tblFString, nRow, ROW_Selected, 0 )
.head 7 -  Call SalTblDeleteRow( tblFString, nRow, TBL_Adjust )
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow( hWndItem )
.head 3 +  Pushbutton: pbDeleteAll
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbDelete
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.483"
.head 5 -  Top:    0.381"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Удалить все строки фильтра
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipDeleteAll')
.head 5 +  On SAM_Click
.head 6 -  Call SalTblReset(tblFString)
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 -  Frame
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Resource Id: 26943
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.7"
.head 5 -  Top:    0.344"
.head 5 -  Width:  0.686"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.396"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 3 +  Pushbutton: pbGetValue
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbDetail
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.15"
.head 5 -  Top:    0.381"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalDisableWindow(hWndItem)
.head 6 -  ! Выбрать значение из возможных
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipGetValue')
.head 5 +  On SAM_Click
.head 6 +  If tblFString.colTagId != -1
.head 7 +  If F.Tag[tblFString.colTagId].isForeignKey() 
.head 8 +  If GetExtraValue( F.Tag[tblFString.colTagId].S.sSTabName,
                  F.Tag[tblFString.colTagId].S.sSSemantic,
                  sKeyValue, sSemValue ) != -1
.head 9 -  Set tblFString.colValue    = sKeyValue
.head 9 -  Set tblFString.colSemantic = sSemValue
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow( hWndItem )
.head 3 +  Pushbutton: pbGetFormula
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cTBarButton
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.583"
.head 5 -  Top:    0.381"
.head 5 -  Width:  0.43"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.317"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Formula.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalDisableWindow(hWndItem)
.head 6 -  ! Выбрать формулу из возможных
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipGetFormula')
.head 5 -  On SAM_Click
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 -  Frame
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Resource Id: 26944
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.743"
.head 5 -  Top:    0.344"
.head 5 -  Width:  1.114"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.396"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 3 +  Pushbutton: pbCheck
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cTBarButton
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.2"
.head 5 -  Top:    0.381"
.head 5 -  Width:  0.43"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.317"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Chekin.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Проверить синтаксис сформированого фильтра
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipCheck')
.head 5 +  On SAM_Click
.head 6 -  Call CheckFilter()
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Pushbutton: pbSave
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbUpdate
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.633"
.head 5 -  Top:    0.381"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 +  If fPlainMode
.head 7 -  Call SalDisableWindow(hWndItem)
.head 6 -  ! Сохранить сформированый фильтр в БД
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipSave')
.head 5 +  On SAM_Click
.head 6 +  If CheckFilter()
.head 7 +  If SalModalDialog(dlg_GetFilterName, hWndForm, strNewFilterName)
.head 8 -  Call SalWaitCursor(TRUE)
.head 8 +  If SalTblAnyRows(tblFString, 0, 0)
.head 9 -  Call SetFilter()
.head 9 +  If NOT F.isFilterEmpty()
.head 10 -  Call F.SaveFilterDB(nUserId, strNewFilterName)
.head 10 -  Call SalSendMsg(tblFUser, SAM_Create, 0, 0)
.head 10 +  If nUserFilterNum AND NOT Tags.IsEnabled(1)
.head 11 -  Call Tags.Enable(1, TRUE)
.head 9 -  Set F.nStrNum = 0
.head 9 -  Call SalTblReset(tblFString)
.head 8 -  Call SalWaitCursor(FALSE)
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 -  !
.head 3 +  Child Table: tblFString
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.186"
.head 6 -  Top:    0.75"
.head 6 -  Width:  10.657"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 2.583"
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
.head 5 +  Column: colOp
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: И/ИЛИ
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.757"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? No
.head 8 -  Vertical Scroll? No
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? No
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 +  List Values
.head 7 -  Text: И
.head 7 -  Text: ИЛИ
.head 7 -  Text: (
.head 7 -  Text: )
.head 7 -  Text:
.head 6 +  Message Actions
.head 7 +  On SAM_Validate
.head 8 +  If colOp = ')'
.head 9 -  Set colTagId = -1
.head 9 -  Set colTag = ''
.head 9 -  Set colSign = ''
.head 9 -  Set colValue = ''
.head 9 -  Set colSemantic = ''
.head 9 -  Set fIsBrackets = TRUE
.head 8 +  Else
.head 9 -  Set fIsBrackets = FALSE
.head 5 +  Column: colTagId
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
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
.head 5 +  Column: colTag
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Атрибут
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  2.886"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? No
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? No
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 +  Message Actions
.head 7 +  On SAM_Create
.head 8 +  If NOT F.isTagListEmpty()
.head 9 -  Set ni = 0
.head 9 +  While ni < F.nTagNum
.head 10 -  Call SalListAdd(hWndItem, F.Tag[ni].sTagName)
.head 10 -  Set ni = ni + 1
.head 9 -  Call SalListAdd(hWndItem, '')
.head 7 +  On SAM_Validate
.head 8 +  If colTag != ''
.head 9 +  If NOT F.isTagListEmpty()
.head 10 +  If colTagId != F.GetTagByName(colTag)
.head 11 -  Set colTagId = F.GetTagByName(colTag)
.head 11 +  If colTagId >= 0  and colTagId < F.nTagNum
.head 12 -  Set colTag = F.Tag[colTagId].sTagName
.head 12 -  Set colTagType = F.Tag[colTagId].sTagType
.head 12 -  !
.head 12 -  Call SalSendMsg(colSign, SAM_Validate, 0, 0)
.head 12 -  ! Set fIsNULLValue = TRUE
.head 12 -  ! Set colValue = ''
.head 12 -  ! Set colSemantic = ''
.head 12 -  !
.head 12 +  If F.Tag[colTagId].isForeignKey()
.head 13 -  Call SalEnableWindow(pbGetValue)
.head 12 +  Else
.head 13 -  Call SalDisableWindow(pbGetValue)
.head 8 +  Else
.head 9 -  Set colTagId = -1
.head 9 -  Set colSign = ''
.head 9 -  Set colValue = ''
.head 9 -  Set colSemantic = ''
.head 9 -  Call SalDisableWindow(pbGetValue)
.head 8 -  Return VALIDATE_Ok
.head 5 +  Column: colTagType
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: TagType
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
.head 5 +  Column: colSign
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Оператор
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.471"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? No
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? No
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 +  List Values
.head 7 -  Text: =
.head 7 -  Text: <
.head 7 -  Text: <=
.head 7 -  Text: >
.head 7 -  Text: >=
.head 7 -  Text: <>
.head 7 -  Text: ПОХОЖ
.head 7 -  Text: НЕ ПОХОЖ
.head 7 -  Text: ПУСТОЙ
.head 7 -  Text: НЕ ПУСТОЙ
.head 7 -  Text: ОДИН ИЗ
.head 7 -  Text: НЕ ОДИН ИЗ
.head 7 -  Text:
.head 6 +  Message Actions
.head 7 +  On SAM_Validate
.head 8 +  If colSign = 'ПУСТОЙ' OR colSign = 'НЕ ПУСТОЙ' OR colSign = ''
.head 9 -  Set fIsNULLValue = TRUE
.head 9 -  Set colValue = ''
.head 9 -  Set colSemantic = ''
.head 8 +  Else
.head 9 -  Set fIsNULLValue = FALSE
.head 8 +  If SalSendMsg(colValue, SAM_Validate, 0, 0)
.head 9 -  Return VALIDATE_Ok
.head 8 +  Else
.head 9 -  Return VALIDATE_Cancel
.head 5 +  Column: colValue
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Значение
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: 200
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.743"
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
.head 6 +  Message Actions
.head 7 +  On SAM_AnyEdit
.head 8 -  Call SalClearField(colSemantic)
.head 8 +  If fIsNULLValue or fIsBrackets
.head 9 -  Call SalClearField(hWndItem)
.head 7 +  On SAM_Validate
.head 8 +  If MyValue = STRING_Null
.head 9 -  Return VALIDATE_Ok
.head 8 +  If SalStrLeftX( MyValue, 1) = '@'
.head 9 -  Return VALIDATE_Ok
.head 8 +  If colTagType = 'N' AND NOT SalStrIsValidNumber(MyValue)
.head 9 +  If colSign = 'ОДИН ИЗ' OR colSign = 'НЕ ОДИН ИЗ'
.head 10 +  If NOT CheckListOfNumber(colValue)
.head 11 -  Call SalMessageBeep(MB_IconStop)
.head 11 -  ! Неверный список значений для этого атрибута!
.head 11 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErrList'),
     CurrentLangTable.GetAtomTitle('cTErr'), MB_IconStop | MB_Ok)
.head 11 -  Return VALIDATE_Cancel
.head 9 +  Else
.head 10 +  If SalStrUpperX(F.Tag[colTagId].sQueryCol) = 'KV' AND
SalStrScan( colValue, ',' ) = -1
.head 11 -  Set strKv = ''
.head 11 +  If SqlPrepareAndExecute( hSql(), 'SELECT kv INTO :strKv FROM tabval WHERE lcv = :colValue' )
.head 12 -  Call SqlFetchNext( hSql(), nFetchRes )
.head 12 -  Set MyValue = strKv
.head 12 -  Return VALIDATE_Ok
.head 10 +  Else
.head 11 -  Call SalMessageBeep(MB_IconStop)
.head 11 -  ! Недопустимый тип данных для этого атрибута!
.head 11 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErrType'),
     CurrentLangTable.GetAtomTitle('cTErr'), MB_IconStop | MB_Ok)
.head 11 -  Return VALIDATE_Cancel
.head 8 -  Return VALIDATE_Ok
.head 5 +  Column: colSemantic
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Семантика значения
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  4.414"
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
.head 4 +  Window Variables
.head 5 -  Number: ni
.head 5 -  String: strKv
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 6 +  If NOT F.isFilterEmpty()
.head 7 -  Set ni = 0
.head 7 +  While ni < F.nStrNum
.head 8 -  Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
.head 8 +  If nRow != TBL_Error
.head 9 -  Call SalTblSetContext(hWndForm, nRow)
.head 9 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 9 -  Set colOp = F.TranslateLOper(F.FStr[ni].sLOper, TRUE)
.head 9 -  Set colTagId = F.GetTagByKey(F.FStr[ni].sColName,F.FStr[ni].sRTabName)
.head 9 +  If colTagId >= 0  and colTagId < F.nTagNum
.head 10 -  Set colTag = F.Tag[colTagId].sTagName
.head 10 -  Set colTagType = F.Tag[colTagId].sTagType
.head 9 -  Set colSign = F.TranslateLSign(F.FStr[ni].sLSign, TRUE)
.head 9 -  Set colValue = F.FStr[ni].sValue
.head 9 -  Set colSemantic = F.FStr[ni].sSemantic
.head 9 -  Set ni = ni + 1
.head 7 -  Call SalTblSetContext(hWndForm, 0)
.head 7 -  Call SalSendMsg( hWndForm, SAM_TblDoDetails, 0, 0)
.head 6 +  Else
.head 7 -  Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
.head 7 +  If nRow != TBL_Error
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 -  Call SalTblSetFocusRow(hWndForm, nRow)
.head 8 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 6 -  Call SalTblSetLockedColumns(hWndForm, 5)
.head 5 +  On SAM_TblDoDetails
.head 6 +  If colOp = ')'
.head 7 -  Set fIsBrackets = TRUE
.head 6 +  Else
.head 7 -  Set fIsBrackets = FALSE
.head 6 +  If colTagId >= 0 AND colTagId < F.nTagNum
.head 7 +  If F.Tag[colTagId].isForeignKey()
.head 8 -  Call SalEnableWindow(pbGetValue)
.head 7 +  Else
.head 8 -  Call SalDisableWindow(pbGetValue)
.head 6 +  Else
.head 7 -  Call SalDisableWindow(pbGetValue)
.head 6 -  !
.head 6 +  If colSign = 'ПУСТОЙ' OR colSign = 'НЕ ПУСТОЙ' OR colSign=''
.head 7 -  Set fIsNULLValue = TRUE
.head 6 +  Else
.head 7 -  Set fIsNULLValue = FALSE
.head 5 +  On SAM_EndCellTab
.head 6 -  Call SalSendMsg(pbInsert, SAM_Click, 0, 0)
.head 6 -  Call SalTblSetFocusCell(hWndForm, nRow, colOp, 0, 0)
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndForm)
.head 5 +  On UM_NoFontChange
.head 6 -  Return TRUE
.head 3 -  ! ***** = *****
.head 3 +  Picture: picTabs
.data CLASSPROPS
0000: 546162546F704D61 7267696E00020030 0000546162466F72 6D50616765730003
0020: 0009090000546162 447261775374796C 65000B0057696E39 355374796C650000
0040: 546162426F74746F 6D4D617267696E00 0500302E34350000 5461625061676543
0060: 6F756E7400020031 00005461624C6162 656C73002400D1E8 F1F2E5ECEDFBE920
0080: 09CFEEEBFCE7EEE2 E0F2E5EBFCF1EAE8 E92009CDEEE2FBE9 2000005461624E61
00A0: 6D65730016005379 7354616709557365 72546167094E6577 5461670000546162
00C0: 52696768744D6172 67696E0002003000 0054616243757272 656E740007004E65
00E0: 7754616700005461 624C6566744D6172 67696E0002003000 005461624F726965
0100: 6E746174696F6E00 0100000000000000 0000000000000000 0000000000000000
0120: 0000
.enddata
.data CLASSPROPSSIZE
0000: 2201
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 1
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cQuickTabsDialog
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    0.031"
.head 5 -  Width:  10.829"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 3.375"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  File Name:
.head 4 -  Storage: Class Default
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Fit: Class Default
.head 4 -  Scaling
.head 5 -  Width:  Class Default
.head 5 -  Height:  Class Default
.head 4 -  Corners: Class Default
.head 4 -  Border Style: Class Default
.head 4 -  Border Thickness: Class Default
.head 4 -  Tile To Parent? No
.head 4 -  Border Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendClassMessage(SAM_Create, wParam, lParam)
.head 6 -  Call Tags.AttachWindow(picTabs)
.head 6 -  !
.head 6 -  Call picTabs.SetLabel(0, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTabs0'), TRUE)
.head 6 -  Call picTabs.SetLabel(1, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTabs1'), TRUE)
.head 6 -  Call picTabs.SetLabel(2, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTabs2'), TRUE)
.head 6 +  If NOT fPlainMode
.head 7 +  If NOT nSysFilterNum
.head 8 -  Call Tags.Enable(0, FALSE)
.head 8 -  Call Tags.SendMsgToAssociated(0, UM_ObjDeactivate, 0, 0)
.head 7 +  If NOT nUserFilterNum
.head 8 -  Call Tags.Enable(1, FALSE)
.head 8 -  Call Tags.SendMsgToAssociated(1, UM_ObjDeactivate, 0, 0)
.head 7 -  !
.head 7 +  If nSysFilterNum
.head 8 -  Call Tags.BringToTop(0, TRUE)
.head 8 -  Call Tags.SendMsgToAssociated(2, UM_ObjDeactivate, 0, 0)
.head 7 +  Else If nUserFilterNum
.head 8 -  Call Tags.BringToTop(1, TRUE)
.head 8 -  Call Tags.SendMsgToAssociated(2, UM_ObjDeactivate, 0, 0)
.head 7 +  Else
.head 8 -  Call Tags.BringToTop(2, TRUE)
.head 6 +  Else
.head 7 -  Call Tags.Delete(0, FALSE)
.head 7 -  Call Tags.Delete(0, TRUE)
.head 3 -  !
.head 3 +  Pushbutton: pbApply
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Применить
.head 4 -  Window Location and Size
.head 5 -  Left:   7.671"
.head 5 -  Top:    3.5"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\APPLY.BMP
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 +  If fPlainMode
.head 7 -  ! Сохранить
.head 7 -  Call SalSetWindowText(hWndItem, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipApply'))
.head 5 +  On SAM_Click
.head 6 -  ! F.nSysRow - не номер строки (сейчас это не актуально, т.к. работает сортировка), а номер фильтра (colID)
.head 6 -  Set F.nSysRow = tblFSystem.colID
.head 6 -  Set F.strSysFromClause  = tblFSystem.colFromClause
.head 6 -  Set F.strSysWhereClause = tblFSystem.colWhereClause
.head 6 -  ! F.nUserRow - не номер строки (сейчас это не актуально, т.к. работает сортировка), а номер фильтра (colID)
.head 6 -  Set F.nUserRow = tblFUser.colID
.head 6 -  Set F.strUserFromClause  = tblFUser.colFromClause
.head 6 -  Set F.strUserWhereClause = tblFUser.colWhereClause
.head 6 -  !
.head 6 +  If CheckFilter( )
.head 7 +  If SalTblAnyRows( tblFString, 0, 0 )
.head 8 -  Call SetFilter( )
.head 8 -  ! Задействован фильтр: F.GetFilterWhereClause(FALSE)
.head 8 -  Call SaveInfoToLog(CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTSetFilter') ||  ': ' || F.GetFilterWhereClause( FALSE ) )
.head 7 +  Else
.head 8 -  ! Фильтр пуст...
.head 8 -  Set F.nStrNum = 0
.head 8 -  ! Задействована нефильтрованная (полная) выборка
.head 8 -  Call SaveInfoToLog(CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTSetNotFilter'))
.head 7 -  Call SalEndDialog(hWndForm, 1)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отменить
.head 4 -  Window Location and Size
.head 5 -  Left:   9.4"
.head 5 -  Top:    3.5"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\DISCARD.BMP
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(hWndForm, 0)
.head 2 +  Functions
.head 3 +  Function: CheckFilter
.head 4 -  Description: Проверить синтаксис фильтра
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nParanteses
.head 5 -  Number: nLastState
.head 5 -  Number: nCurrState
.head 5 -  Boolean: fIsError
.head 5 -  String: sError
.head 4 +  Actions
.head 5 -  ! let's remove blank strings
.head 5 -  Set nRow = TBL_MinRow
.head 5 +  While SalTblFindNextRow( tblFString, nRow, 0, 0)
.head 6 -  Call SalTblSetContext( tblFString, nRow )
.head 6 +  If tblFString.colTagId = NUMBER_Null AND tblFString.colOp = ''
.head 7 -  Call SalTblDeleteRow( tblFString, nRow, TBL_Adjust )
.head 5 -  !
.head 5 -  Set nRow = TBL_MinRow
.head 5 -  Set nParanteses = 0
.head 5 -  Set nLastState = FLTR_START
.head 5 -  Set nCurrState = FLTR_START
.head 5 -  Set fIsError = FALSE
.head 5 +  While NOT fIsError AND SalTblFindNextRow( tblFString, nRow, 0, 0) 
.head 6 -  Call SalTblSetContext( tblFString, nRow )
.head 6 +  If tblFString.colOp = '('
.head 7 -  Set nParanteses = nParanteses + 1
.head 6 +  If tblFString.colOp = ')'
.head 7 -  Set nParanteses = nParanteses - 1
.head 6 -  !
.head 6 +  If tblFString.colOp != ''
.head 7 +  If tblFString.colOp = '('
.head 8 -  Set nCurrState = FLTR_LPARANT
.head 7 +  Else If tblFString.colOp = ')'
.head 8 -  Set nCurrState = FLTR_RPARANT
.head 7 +  Else
.head 8 -  Set nCurrState = FLTR_OPERATOR
.head 7 -  !
.head 7 -  Set fIsError = CheckAllowence( nLastState, nCurrState, sError )
.head 7 -  Set nLastState = nCurrState
.head 6 +  If NOT fIsError
.head 7 +  If tblFString.colTag != ''
.head 8 -  Set nCurrState = FLTR_ATOM
.head 8 -  !
.head 8 -  Set fIsError = CheckAllowence( nLastState, nCurrState, sError )
.head 8 -  Set nLastState = nCurrState
.head 7 +  If NOT fIsError
.head 8 +  If tblFString.colSign != ''
.head 9 +  If SalStrTrimX( tblFString.colSign ) = 'ПУСТОЙ' OR
   SalStrTrimX( tblFString.colSign ) = 'НЕ ПУСТОЙ'
.head 10 -  Set nCurrState = FLTR_ISNULLOP
.head 9 +  Else
.head 10 -  Set nCurrState = FLTR_SIGN
.head 9 -  !
.head 9 -  Set fIsError = CheckAllowence( nLastState, nCurrState, sError )
.head 9 -  Set nLastState = nCurrState
.head 8 +  If NOT fIsError
.head 9 +  If tblFString.colValue != ''
.head 10 -  Set nCurrState = FLTR_ATOM
.head 10 -  !
.head 10 -  Set fIsError = CheckAllowence( nLastState, nCurrState, sError )
.head 10 -  Set nLastState = nCurrState
.head 5 +  If NOT fIsError
.head 6 -  Set fIsError = CheckAllowence( nLastState, FLTR_STOP, sError )
.head 5 +  If NOT fIsError AND nParanteses != 0
.head 6 +  If nParanteses > 0
.head 7 -  ! Set sError = 'Пропущена ЗАКРЫВАЮЩАЯ скобка'
.head 7 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr8')
.head 6 +  Else
.head 7 -  ! Set sError = 'Пропущена ОТКРЫВАЮЩАЯ скобка'
.head 7 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr9')
.head 6 -  Set fIsError = TRUE
.head 5 +  If fIsError
.head 6 -  Call SalMessageBeep( MB_IconStop )
.head 6 -  ! Call SalMessageBox( sError, 'Синтаксическая ошибка', MB_Ok )
.head 6 -  Call SalMessageBox( sError, CurrentLangTable.GetAtomTitle('cTSyntaxErr'), MB_Ok )
.head 6 -  Call SalTblSetFocusRow( tblFString, nRow )
.head 5 -  Return NOT fIsError
.head 3 +  Function: CheckAllowence
.head 4 -  Description: Проверяет допустимость последовательности атомов
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nPrev
.head 5 -  Number: nNext
.head 5 -  Receive String: sError
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Boolean: fRet
.head 4 +  Actions
.head 5 -  Set sError = ''
.head 5 -  Set fRet = FALSE
.head 5 +  If nPrev = FLTR_SIGN     AND nNext != FLTR_ATOM
.head 6 -  Set fRet = TRUE
.head 6 -  ! Недопустимое выражение после оператора сравнения
.head 6 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr1')
.head 5 +  If nPrev = FLTR_ISNULLOP AND nNext != FLTR_OPERATOR AND nNext != FLTR_SIGN AND nNext != FLTR_RPARANT AND nNext != FLTR_STOP
.head 6 -  Set fRet = TRUE
.head 6 -  ! Недопустимое выражение после оператора IS NULL/IS NOT NULL
.head 6 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr2')
.head 5 +  If nPrev = FLTR_OPERATOR AND nNext != FLTR_ATOM AND nNext != FLTR_LPARANT
.head 6 -  Set fRet = TRUE
.head 6 -  ! Недопустимое выражение после логического оператора
.head 6 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr3')
.head 5 +  If nPrev = FLTR_START    AND nNext != FLTR_ATOM AND nNext != FLTR_LPARANT AND nNext != FLTR_STOP
.head 6 -  Set fRet = TRUE
.head 6 -  ! Недопустимое начало логического выражения фильтра
.head 6 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr4')
.head 5 +  If nPrev = FLTR_LPARANT  AND nNext != FLTR_ATOM AND nNext != FLTR_LPARANT
.head 6 -  Set fRet = TRUE
.head 6 -  ! Недопустимое выражение после открывающей скобки
.head 6 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr5')
.head 5 +  If nPrev = FLTR_RPARANT  AND nNext != FLTR_OPERATOR AND nNext != FLTR_ISNULLOP AND nNext != FLTR_RPARANT AND nNext != FLTR_STOP
.head 6 -  Set fRet = TRUE
.head 6 -  ! Недопустимое выражение после закрывающей скобки
.head 6 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr6')
.head 5 +  If nPrev = FLTR_ATOM     AND nNext != FLTR_OPERATOR AND nNext != FLTR_ISNULLOP AND nNext != FLTR_SIGN    AND nNext != FLTR_RPARANT AND nNext != FLTR_STOP
.head 6 -  Set fRet = TRUE
.head 6 -  ! Недопустимое выражение после атрибута или значения
.head 6 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr7')
.head 5 -  !
.head 5 -  Return fRet
.head 3 +  Function: CheckListOfNumber
.head 4 -  Description: Проверить строчных список числовых значений
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: strValList
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strVal[*]
.head 5 -  Number: nVals
.head 5 -  Number: nIterator
.head 5 -  Boolean: fError
.head 4 +  Actions
.head 5 +  If NOT strValList
.head 6 -  Return FALSE
.head 5 +  If SalStrScan( SalStrUpperX( strValList ), 'SELECT' ) >= 0
.head 6 -  Return TRUE
.head 5 -  Set nVals = SalStrTokenize( strValList, '', ',', strVal )
.head 5 +  If NOT nVals
.head 6 -  Return FALSE
.head 5 -  Set nIterator = 0
.head 5 -  Set fError = FALSE
.head 5 +  While ( nIterator < nVals AND NOT fError )
.head 6 +  If NOT SalStrIsValidNumber( strVal[nIterator] )
.head 7 -  Set fError = TRUE
.head 6 -  Set nIterator = nIterator + 1
.head 5 -  Return NOT fError
.head 3 +  Function: SetFilter
.head 4 -  Description: Запомнить фильтр в структуру
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nRow
.head 4 +  Actions
.head 5 -  Set nRow = TBL_MinRow
.head 5 -  Set F.nStrNum = 0
.head 5 +  While SalTblFindNextRow( tblFString, nRow, 0, 0 )
.head 6 -  Call SalTblSetContext( tblFString, nRow )
.head 6 +  If tblFString.colTagId >= 0 AND tblFString.colTagId < F.nTagNum
.head 7 -  Call F.NewString (F.TranslateLOper(tblFString.colOp, FALSE), -1, 
     F.Tag[tblFString.colTagId].sQueryCol, -1, F.Tag[tblFString.colTagId].sQueryTab,
     F.TranslateLSign(tblFString.colSign, FALSE), tblFString.colValue, tblFString.colSemantic)
.head 6 +  Else
.head 7 -  Call F.NewString (F.TranslateLOper(tblFString.colOp, FALSE), -1, '', -1, '',
     F.TranslateLSign(tblFString.colSign, FALSE), tblFString.colValue, tblFString.colSemantic)
.head 3 +  Function: GetExtraValue
.head 4 -  Description: Получить значение из справочника
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: strTab
.head 5 -  String: strCol
.head 5 -  Receive String: strId
.head 5 -  Receive String: strSm
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: s1
.head 5 -  String: s2
.head 5 -  Boolean: fRet
.head 4 +  Actions
.head 5 -  Set fRet = SalModalDialog(dlg_GetValue, hWndForm, strTab, strCol, s1, s2)
.head 5 +  If fRet
.head 6 -  Set strId = s1
.head 6 -  Set strSm = s2
.head 5 -  Return fRet
.head 2 +  Window Parameters
.head 3 -  : F
.head 4 -  Class: cGenFilter
.head 3 -  Boolean: fPlainMode
.head 2 +  Window Variables
.head 3 -  : FSys
.head 4 -  Class: cABSConnect
.head 3 -  : FUsr
.head 4 -  Class: cABSConnect
.head 3 -  !
.head 3 -  Number: nRow
.head 3 -  Boolean: fIsNULLValue ! флаг наличия оператора IS NULL
.head 3 -  Boolean: fIsBrackets  ! флаг наличия закрывающей скобки
.head 3 -  String: sKeyValue     ! хранилище для значения ключа
.head 3 -  String: sSemValue     ! хранилище для семантики
.head 3 -  String: sTabSemantic  ! семантическое название фильтруемой таблицы
.head 3 -  !
.head 3 -  : Tags
.head 4 -  Class: cSWTabs
.head 3 -  !
.head 3 -  Number: nUserId
.head 3 -  String: strNewFilterName
.head 3 -  Number: nSysFilterNum
.head 3 -  Number: nUserFilterNum
.head 3 -  !
.head 3 -  Window Handle: hWndFocusCol
.head 3 -  String: sTmp
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTWndTitle'))
.head 4 -  !
.head 4 -  Call XConnectGetParams(FSys)
.head 4 -  Call FSys.Connect()
.head 4 -  Call FUsr.Clone(FSys, TRUE)
.head 4 -  !
.head 4 +  If SqlPrepareAndExecute(FUsr.hSql(), 'SELECT semantic INTO :sTabSemantic FROM meta_tables WHERE tabid=:F.nFTabId')
.head 5 +  If SqlFetchNext(FUsr.hSql(), nFetchRes)
.head 6 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTWndTitle') || ' [' || sTabSemantic || ']')
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  !
.head 4 -  Call XSalTooltipSetUserDefault()
.head 4 -  Set nUserId = GetUserId()
.head 4 -  !
.head 4 -  Set cbFSystem = F.fSystemFilterInUse
.head 4 -  Set cbFUser   = F.fUserFilterInUse
.head 3 +  On SAM_Destroy
.head 4 -  Call FSys.Disconnect()
.head 4 -  Call FUsr.Disconnect()
.head 1 +  Dialog Box: dlg_SetFilterEx
.head 2 -  Class: cQuickTabsDialog
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Фильтр
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   0.5"
.head 4 -  Top:    0.5"
.head 4 -  Width:  11.057"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 4.354"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: MS Sans Serif
.head 3 -  Font Size: 8
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Показывает/создает/редактирует фильтр на таблицу
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
.head 3 -  ! ***** Системный фильтр *****
.head 3 +  Child Table: tblFSystem
.data CLASSPROPSSIZE
0000: 1A00
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 5379735461670000 0000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.186"
.head 6 -  Top:    0.344"
.head 6 -  Width:  10.657"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 2.698"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? No
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  View: Table
.head 5 -  Allow Row Sizing? No
.head 5 -  Lines Per Row: Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: 1000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colID
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
фильтра
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 5
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.2"
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
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 70
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  8.7"
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
.head 5 +  Column: colFromClause
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
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
.head 5 +  Column: colWhereClause
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 2000
.head 6 -  Data Type: Long String
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
.head 4 -  Functions
.head 4 +  Window Variables
.head 5 -  Boolean: bSortOrd
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 6 -  Call SalTblSetTableFlags(hWndForm, TBL_Flag_SelectableCols, TRUE)
.head 6 +  If NOT fPlainMode
.head 7 -  Set nSysFilterNum = 0
.head 7 -  Call SqlSetLongBindDatatype(4, 22)
.head 7 -  Call SalTblPopulate(hWndForm, FSys.hSql(), 
"SELECT filter_id, semantic, from_clause, where_clause
 INTO :colID, :colName, :colFromClause, :colWhereClause 
 FROM dyn_filter
 WHERE tabid = :F.nFTabId AND userid IS NULL 
 ORDER BY semantic", TBL_FillAll)
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  If F.nSysRow > 0 and cbFSystem
.head 8 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 9 -  Call SalTblSetContext(hWndForm, nRow)
.head 9 +  If F.nSysRow = colID
.head 10 -  Break
.head 7 +  Else
.head 8 -  Set nRow = 0
.head 7 -  Call SalTblSetContext(hWndForm, nRow)
.head 7 -  Call SalTblSetFocusRow(hWndForm, nRow)
.head 7 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_Selected, TRUE)
.head 5 +  On SAM_FetchRowDone
.head 6 -  Set nSysFilterNum = nSysFilterNum + 1
.head 5 +  On UM_NoFontChange
.head 6 -  Return TRUE
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndForm)
.head 5 +  On SAM_ColumnSelectClick
.head 6 -  Call SalTblSetColumnFlags(SalNumberToWindowHandle(wParam), COL_Selected, FALSE)
.head 6 -  Set bSortOrd = not bSortOrd
.head 6 -  Call SalTblSortRows(hWndForm, SalTblQueryColumnID(SalNumberToWindowHandle(wParam)), bSortOrd)
.head 3 +  Check Box: cbFSystem
.data INHERITPROPS
0000: 0100
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 5379735461670000 0000
.enddata
.data CLASSPROPSSIZE
0000: 1A00
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cCheckBoxLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Использовать Системный фильтр
.head 4 -  Window Location and Size
.head 5 -  Left:   0.186"
.head 5 -  Top:    3.073"
.head 5 -  Width:  5.471"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set F.fSystemFilterInUse = NOT F.fSystemFilterInUse
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow( hWndItem )
.head 3 -  ! ***** Пользовательский фильтр *****
.head 3 -  Frame
.data CLASSPROPSSIZE
0000: 1B00
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000800 5573657254616700 000000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Resource Id: 27772
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.186"
.head 5 -  Top:    0.344"
.head 5 -  Width:  1.057"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.396"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 3 +  Pushbutton: pbUDelete
.data CLASSPROPSSIZE
0000: 1B00
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000800 5573657254616700 000000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbDelete
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.286"
.head 5 -  Top:    0.385"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Удалить фильтр
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipUDelete')
.head 5 +  On SAM_Click
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call SqlPrepare(FUsr.hSql(), 'DELETE FROM dyn_filter WHERE filter_id = :tblFUser.colID')
.head 6 +  If SalTblDoDeletes(tblFUser, FUsr.hSql(), ROW_Selected)
.head 7 -  Call SqlCommit(FUsr.hSql())
.head 7 -  Set F.nUserRow = 0
.head 6 -  Call SalSendMsg(tblFUser, SAM_Create, 0, 0)
.head 6 +  If NOT nUserFilterNum
.head 7 -  Call Tags.Enable(1, FALSE)
.head 7 -  Call Tags.Next()
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Pushbutton: pbUSave
.data CLASSPROPSSIZE
0000: 1B00
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000800 5573657254616700 000000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbUpdate
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.714"
.head 5 -  Top:    0.385"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Сохранить измения в БД
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipUSave')
.head 5 +  On SAM_Click
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call SqlPrepare(FUsr.hSql(), 'UPDATE dyn_filter SET semantic = :tblFUser.colName WHERE filter_id = :tblFUser.colID')
.head 6 +  If SalTblDoUpdates(tblFUser, FUsr.hSql(), TRUE)
.head 7 -  Call SqlCommit(FUsr.hSql())
.head 6 +  Else
.head 7 -  Call SqlRollback(FUsr.hSql()) 
.head 6 -  Call SalSendMsg(tblFUser, SAM_Create, 0, 0)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Pushbutton: pbShowCondition
.data CLASSPROPSSIZE
0000: 1900
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000800 5573657254616700 00
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbEdit
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.314"
.head 5 -  Top:    0.385"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Просмотреть значение фильтра...
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipShowCondition')
.head 5 +  On SAM_Click
.head 6 -  Set sTmp = tblFUser.colWhereClause
.head 6 +  If SalModalDialog(dlg_ShowFilter, hWndForm, FUsr.hSql(), tblFUser.colID, sTmp)
.head 7 +  If sTmp != tblFUser.colWhereClause
.head 8 -  Set tblFUser.colWhereClause = sTmp
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Child Table: tblFUser
.data CLASSPROPSSIZE
0000: 1900
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000800 5573657254616700 00
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.186"
.head 6 -  Top:    0.75"
.head 6 -  Width:  10.657"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 2.292"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? No
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  View: Table
.head 5 -  Allow Row Sizing? No
.head 5 -  Lines Per Row: Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: 2000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colID
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
фильтра
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 5
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.2"
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
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: 70
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  8.7"
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
.head 5 +  Column: colFromClause
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
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
.head 5 +  Column: colWhereClause
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 2000
.head 6 -  Data Type: Long String
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
.head 4 -  Functions
.head 4 +  Window Variables
.head 5 -  Boolean: bSortOrd
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 6 -  Call SalTblSetTableFlags(hWndForm, TBL_Flag_SelectableCols, TRUE)
.head 6 +  If NOT fPlainMode
.head 7 -  Set nUserFilterNum = 0
.head 7 -  Call SqlSetLongBindDatatype(4, 22)
.head 7 -  Call SalTblPopulate(hWndForm, FUsr.hSql(), 
"SELECT filter_id, semantic, from_clause, where_clause
   INTO :colID, :colName, :colFromClause, :colWhereClause 
   FROM dyn_filter
  WHERE tabid = :F.nFTabId AND userid = :nUserId 
  ORDER BY semantic", TBL_FillAll)
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  If F.nUserRow > 0 and cbFUser
.head 8 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 9 -  Call SalTblSetContext(hWndForm, nRow)
.head 9 +  If F.nUserRow = colID
.head 10 -  Break
.head 7 +  Else
.head 8 -  Set nRow = 0
.head 7 -  Call SalTblSetContext(hWndForm, nRow)
.head 7 -  Call SalTblSetFocusRow(hWndForm, nRow)
.head 7 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_Selected, TRUE)
.head 5 +  On SAM_FetchRowDone
.head 6 -  Set nUserFilterNum = nUserFilterNum + 1
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndForm)
.head 5 +  On UM_NoFontChange
.head 6 -  Return TRUE
.head 5 +  On SAM_ColumnSelectClick
.head 6 -  Call SalTblSetColumnFlags(SalNumberToWindowHandle(wParam), COL_Selected, FALSE)
.head 6 -  Set bSortOrd = not bSortOrd
.head 6 -  Call SalTblSortRows(hWndForm, SalTblQueryColumnID(SalNumberToWindowHandle(wParam)), bSortOrd)
.head 3 +  Check Box: cbFUser
.data INHERITPROPS
0000: 0100
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000800 5573657254616700 00
.enddata
.data CLASSPROPSSIZE
0000: 1900
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cCheckBoxLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Использовать Пользовательский фильтр
.head 4 -  Window Location and Size
.head 5 -  Left:   0.186"
.head 5 -  Top:    3.073"
.head 5 -  Width:  4.929"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set F.fUserFilterInUse = NOT F.fUserFilterInUse
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 -  ! ***** Новый фильтр *****
.head 3 -  Frame
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Resource Id: 27773
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.186"
.head 5 -  Top:    0.344"
.head 5 -  Width:  1.057"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.396"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 3 +  Pushbutton: pbInsertBefore
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbInsert
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.183"
.head 5 -  Top:    0.381"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\C2.BMP
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Вставить строку фильтра
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipInsertBefore')
.head 5 +  On SAM_Click
.head 6 -  Set nRow = SalTblQueryContext(tblFString)
.head 6 -  Call SalTblSetRowFlags(tblFString, nRow, ROW_Selected, FALSE)
.head 6 -  Set nRow = SalTblInsertRow(tblFString, nRow)
.head 6 +  If nRow != TBL_Error
.head 7 -  Call SalSetFocus(tblFString)
.head 7 -  Call SalTblSetFocusRow(tblFString, nRow)
.head 7 -  Call SalTblSetRowFlags(tblFString, nRow, ROW_Selected, TRUE)
.head 7 -  Call SalTblSetRowFlags(tblFString, nRow, ROW_New, FALSE)
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Pushbutton: pbInsert
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbInsert
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.617"
.head 5 -  Top:    0.381"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Insert.bmp
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Добавить строку фильтра
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipInsert')
.head 5 +  On SAM_Click
.head 6 -  Call SalTblSetRowFlags(tblFString, SalTblQueryContext(tblFString), ROW_Selected, FALSE)
.head 6 -  Set nRow = SalTblInsertRow(tblFString, TBL_MaxRow)
.head 6 +  If nRow != TBL_Error
.head 7 -  Call SalSetFocus(tblFString)
.head 7 -  Call SalTblSetFocusRow(tblFString, nRow)
.head 7 -  Call SalTblSetRowFlags(tblFString, nRow, ROW_New, FALSE)
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Pushbutton: pbDelete
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cTBarButton
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.05"
.head 5 -  Top:    0.381"
.head 5 -  Width:  0.43"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.317"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Delete.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Удалить строку фильтра
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipDelete')
.head 5 +  On SAM_Click
.head 6 -  Set nRow = TBL_MinRow
.head 6 +  While SalTblFindNextRow( tblFString, nRow, ROW_Selected, 0 )
.head 7 -  Call SalTblDeleteRow( tblFString, nRow, TBL_Adjust )
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow( hWndItem )
.head 3 +  Pushbutton: pbDeleteAll
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbDelete
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.483"
.head 5 -  Top:    0.381"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Удалить все строки фильтра
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipDeleteAll')
.head 5 +  On SAM_Click
.head 6 -  Call SalTblReset(tblFString)
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 -  Frame
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Resource Id: 27774
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.7"
.head 5 -  Top:    0.344"
.head 5 -  Width:  0.686"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.396"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 3 +  Pushbutton: pbGetValue
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbDetail
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.15"
.head 5 -  Top:    0.381"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalDisableWindow(hWndItem)
.head 6 -  ! Выбрать значение из возможных
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipGetValue')
.head 5 +  On SAM_Click
.head 6 +  If tblFString.colTagId != -1
.head 7 +  If F.Tag[tblFString.colTagId].isForeignKey() 
.head 8 +  If GetExtraValue( F.Tag[tblFString.colTagId].S.sSTabName,
                  F.Tag[tblFString.colTagId].S.sSSemantic,
                  sKeyValue, sSemValue ) != -1
.head 9 -  Set tblFString.colValue    = sKeyValue
.head 9 -  Set tblFString.colSemantic = sSemValue
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow( hWndItem )
.head 3 +  Pushbutton: pbGetFormula
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cTBarButton
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.583"
.head 5 -  Top:    0.381"
.head 5 -  Width:  0.43"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.317"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Formula.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalDisableWindow(hWndItem)
.head 6 -  ! Выбрать формулу из возможных
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipGetFormula')
.head 5 -  On SAM_Click
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 -  Frame
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Resource Id: 27775
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.743"
.head 5 -  Top:    0.344"
.head 5 -  Width:  1.114"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.396"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 3 +  Pushbutton: pbCheck
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cTBarButton
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.2"
.head 5 -  Top:    0.381"
.head 5 -  Width:  0.43"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.317"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Chekin.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Проверить синтаксис сформированого фильтра
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipCheck')
.head 5 +  On SAM_Click
.head 6 -  Call CheckFilter()
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Pushbutton: pbSave
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbUpdate
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.633"
.head 5 -  Top:    0.381"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 +  If fPlainMode
.head 7 -  Call SalDisableWindow(hWndItem)
.head 6 -  ! Сохранить сформированый фильтр в БД
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipSave')
.head 5 +  On SAM_Click
.head 6 +  If CheckFilter()
.head 7 +  If SalModalDialog(dlg_GetFilterName, hWndForm, strNewFilterName)
.head 8 -  Call SalWaitCursor(TRUE)
.head 8 +  If SalTblAnyRows(tblFString, 0, 0)
.head 9 -  Call SetFilter()
.head 9 +  If NOT F.isFilterEmpty()
.head 10 -  Call F.SaveFilterDB(nUserId, strNewFilterName)
.head 10 -  Call SalSendMsg(tblFUser, SAM_Create, 0, 0)
.head 10 +  If nUserFilterNum AND NOT Tags.IsEnabled(1)
.head 11 -  Call Tags.Enable(1, TRUE)
.head 9 -  Set F.nStrNum = 0
.head 9 -  Call SalTblReset(tblFString)
.head 8 -  Call SalWaitCursor(FALSE)
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 -  !
.head 3 +  Child Table: tblFString
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.186"
.head 6 -  Top:    0.75"
.head 6 -  Width:  10.657"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 2.583"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? No
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
.head 5 +  Column: colOp
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: И/ИЛИ
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.757"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? No
.head 8 -  Vertical Scroll? No
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? No
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 +  List Values
.head 7 -  Text: И
.head 7 -  Text: ИЛИ
.head 7 -  Text: (
.head 7 -  Text: )
.head 7 -  Text:
.head 6 +  Message Actions
.head 7 +  On SAM_Validate
.head 8 +  If colOp = ')'
.head 9 -  Set colTagId = -1
.head 9 -  Set colTag = ''
.head 9 -  Set colSign = ''
.head 9 -  Set colValue = ''
.head 9 -  Set colSemantic = ''
.head 9 -  Set fIsBrackets = TRUE
.head 8 +  Else
.head 9 -  Set fIsBrackets = FALSE
.head 5 +  Column: colTagId
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
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
.head 5 +  Column: colTag
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Атрибут
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  2.886"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? No
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? No
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 +  Message Actions
.head 7 +  On SAM_Create
.head 8 +  If NOT F.isTagListEmpty()
.head 9 -  Set ni = 0
.head 9 +  While ni < F.nTagNum
.head 10 -  Call SalListAdd(hWndItem, F.Tag[ni].sTagName)
.head 10 -  Set ni = ni + 1
.head 9 -  Call SalListAdd(hWndItem, '')
.head 7 +  On SAM_Validate
.head 8 +  If colTag != ''
.head 9 +  If NOT F.isTagListEmpty()
.head 10 +  If colTagId != F.GetTagByName(colTag)
.head 11 -  Set colTagId = F.GetTagByName(colTag)
.head 11 +  If colTagId >= 0  and colTagId < F.nTagNum
.head 12 -  Set colTag = F.Tag[colTagId].sTagName
.head 12 -  Set colTagType = F.Tag[colTagId].sTagType
.head 12 -  !
.head 12 -  Call SalSendMsg(colSign, SAM_Validate, 0, 0)
.head 12 -  ! Set fIsNULLValue = TRUE
.head 12 -  ! Set colValue = ''
.head 12 -  ! Set colSemantic = ''
.head 12 -  !
.head 12 +  If F.Tag[colTagId].isForeignKey()
.head 13 -  Call SalEnableWindow(pbGetValue)
.head 12 +  Else
.head 13 -  Call SalDisableWindow(pbGetValue)
.head 8 +  Else
.head 9 -  Set colTagId = -1
.head 9 -  Set colSign = ''
.head 9 -  Set colValue = ''
.head 9 -  Set colSemantic = ''
.head 9 -  Call SalDisableWindow(pbGetValue)
.head 8 -  Return VALIDATE_Ok
.head 5 +  Column: colTagType
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: TagType
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
.head 5 +  Column: colSign
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Оператор
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.471"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? No
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? No
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 +  List Values
.head 7 -  Text: =
.head 7 -  Text: <
.head 7 -  Text: <=
.head 7 -  Text: >
.head 7 -  Text: >=
.head 7 -  Text: <>
.head 7 -  Text: ПОХОЖ
.head 7 -  Text: НЕ ПОХОЖ
.head 7 -  Text: ПУСТОЙ
.head 7 -  Text: НЕ ПУСТОЙ
.head 7 -  Text: ОДИН ИЗ
.head 7 -  Text: НЕ ОДИН ИЗ
.head 7 -  Text:
.head 6 +  Message Actions
.head 7 +  On SAM_Validate
.head 8 +  If colSign = 'ПУСТОЙ' OR colSign = 'НЕ ПУСТОЙ' OR colSign = ''
.head 9 -  Set fIsNULLValue = TRUE
.head 9 -  Set colValue = ''
.head 9 -  Set colSemantic = ''
.head 8 +  Else
.head 9 -  Set fIsNULLValue = FALSE
.head 8 +  If SalSendMsg(colValue, SAM_Validate, 0, 0)
.head 9 -  Return VALIDATE_Ok
.head 8 +  Else
.head 9 -  Return VALIDATE_Cancel
.head 5 +  Column: colValue
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Значение
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: 200
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.743"
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
.head 6 +  Message Actions
.head 7 +  On SAM_AnyEdit
.head 8 -  Call SalClearField(colSemantic)
.head 8 +  If fIsNULLValue or fIsBrackets
.head 9 -  Call SalClearField(hWndItem)
.head 7 +  On SAM_Validate
.head 8 +  If MyValue = STRING_Null
.head 9 -  Return VALIDATE_Ok
.head 8 +  If SalStrLeftX( MyValue, 1) = '@'
.head 9 -  Return VALIDATE_Ok
.head 8 +  If colTagType = 'N' AND NOT SalStrIsValidNumber(MyValue)
.head 9 +  If colSign = 'ОДИН ИЗ' OR colSign = 'НЕ ОДИН ИЗ'
.head 10 +  If NOT CheckListOfNumber(colValue)
.head 11 -  Call SalMessageBeep(MB_IconStop)
.head 11 -  ! Неверный список значений для этого атрибута!
.head 11 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErrList'),
     CurrentLangTable.GetAtomTitle('cTErr'), MB_IconStop | MB_Ok)
.head 11 -  Return VALIDATE_Cancel
.head 9 +  Else
.head 10 +  If SalStrUpperX(F.Tag[colTagId].sQueryCol) = 'KV' AND
SalStrScan( colValue, ',' ) = -1
.head 11 -  Set strKv = ''
.head 11 +  If SqlPrepareAndExecute( hSql(), 'SELECT kv INTO :strKv FROM tabval WHERE lcv = :colValue' )
.head 12 -  Call SqlFetchNext( hSql(), nFetchRes )
.head 12 -  Set MyValue = strKv
.head 12 -  Return VALIDATE_Ok
.head 10 +  Else
.head 11 -  Call SalMessageBeep(MB_IconStop)
.head 11 -  ! Недопустимый тип данных для этого атрибута!
.head 11 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErrType'),
     CurrentLangTable.GetAtomTitle('cTErr'), MB_IconStop | MB_Ok)
.head 11 -  Return VALIDATE_Cancel
.head 8 -  Return VALIDATE_Ok
.head 5 +  Column: colSemantic
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Семантика значения
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  4.414"
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
.head 4 +  Window Variables
.head 5 -  Number: ni
.head 5 -  String: strKv
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 6 +  If NOT F.isFilterEmpty()
.head 7 -  Set ni = 0
.head 7 +  While ni < F.nStrNum
.head 8 -  Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
.head 8 +  If nRow != TBL_Error
.head 9 -  Call SalTblSetContext(hWndForm, nRow)
.head 9 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 9 -  Set colOp = F.TranslateLOper(F.FStr[ni].sLOper, TRUE)
.head 9 -  Set colTagId = F.GetTagByKey(F.FStr[ni].sColName,F.FStr[ni].sRTabName)
.head 9 +  If colTagId >= 0  and colTagId < F.nTagNum
.head 10 -  Set colTag = F.Tag[colTagId].sTagName
.head 10 -  Set colTagType = F.Tag[colTagId].sTagType
.head 9 -  Set colSign = F.TranslateLSign(F.FStr[ni].sLSign, TRUE)
.head 9 -  Set colValue = F.FStr[ni].sValue
.head 9 -  Set colSemantic = F.FStr[ni].sSemantic
.head 9 -  Set ni = ni + 1
.head 7 -  Call SalTblSetContext(hWndForm, 0)
.head 7 -  Call SalSendMsg( hWndForm, SAM_TblDoDetails, 0, 0)
.head 6 +  Else
.head 7 -  Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
.head 7 +  If nRow != TBL_Error
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 -  Call SalTblSetFocusRow(hWndForm, nRow)
.head 8 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 6 -  Call SalTblSetLockedColumns(hWndForm, 5)
.head 5 +  On SAM_TblDoDetails
.head 6 +  If colOp = ')'
.head 7 -  Set fIsBrackets = TRUE
.head 6 +  Else
.head 7 -  Set fIsBrackets = FALSE
.head 6 +  If colTagId >= 0 AND colTagId < F.nTagNum
.head 7 +  If F.Tag[colTagId].isForeignKey()
.head 8 -  Call SalEnableWindow(pbGetValue)
.head 7 +  Else
.head 8 -  Call SalDisableWindow(pbGetValue)
.head 6 +  Else
.head 7 -  Call SalDisableWindow(pbGetValue)
.head 6 -  !
.head 6 +  If colSign = 'ПУСТОЙ' OR colSign = 'НЕ ПУСТОЙ' OR colSign=''
.head 7 -  Set fIsNULLValue = TRUE
.head 6 +  Else
.head 7 -  Set fIsNULLValue = FALSE
.head 5 +  On SAM_EndCellTab
.head 6 -  Call SalSendMsg(pbInsert, SAM_Click, 0, 0)
.head 6 -  Call SalTblSetFocusCell(hWndForm, nRow, colOp, 0, 0)
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndForm)
.head 5 +  On UM_NoFontChange
.head 6 -  Return TRUE
.head 3 -  ! ***** Простой фильтр *****
.head 3 +  Pushbutton: pbRefresh
.data CLASSPROPSSIZE
0000: 1B00
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000A00 53696D706C655461 670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbRefresh
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.183"
.head 5 -  Top:    0.371"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Yes
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
.head 5 +  On SAM_Create
.head 6 -  ! Очистить
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipRefresh')
.head 5 +  On SAM_Click
.head 6 -  Call tblFSimple.ClearFilter()
.head 3 +  Child Table: tblFSimple
.data CLASSPROPSSIZE
0000: 1B00
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000A00 53696D706C655461 670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.15"
.head 6 -  Top:    0.75"
.head 6 -  Width:  10.65"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 2.6"
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
.head 5 +  Column: colTagId
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
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
.head 5 +  Column: colTag
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Атрибут
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  2.886"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? No
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? No
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 +  Message Actions
.head 7 +  ! On SAM_Create
.head 8 +  If NOT F.cSimpleFilter.isTagListEmpty()
.head 9 -  Set ni = 0
.head 9 +  While ni < F.cSimpleFilter.nTagNum
.head 10 -  Call SalListAdd(hWndItem, F.cSimpleFilter.Tag[ni].sTagName)
.head 10 -  Set ni = ni + 1
.head 9 -  Call SalListAdd(hWndItem, '')
.head 7 +  ! On SAM_Validate
.head 8 +  If colTag != ''
.head 9 +  If NOT F.cSimpleFilter.isTagListEmpty()
.head 10 +  If colTagId != F.cSimpleFilter.GetTagByName(colTag)
.head 11 -  Set colTagId = F.cSimpleFilter.GetTagByName(colTag)
.head 11 +  If colTagId >= 0  and colTagId < F.cSimpleFilter.nTagNum
.head 12 -  Set colTag = F.cSimpleFilter.Tag[colTagId].sTagName
.head 12 -  Set colTagType = F.cSimpleFilter.Tag[colTagId].sTagType
.head 8 +  Else 
.head 9 -  Set colTagId = -1
.head 9 -  Set colValue = ''
.head 8 -  Return VALIDATE_Ok
.head 5 +  Column: colTagType
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: TagType
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
.head 5 +  Column: colValue
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Значение
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: 200
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.743"
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
.head 6 +  Message Actions
.head 7 +  On SAM_Validate
.head 8 +  If MyValue = STRING_Null
.head 9 -  Return VALIDATE_Ok
.head 8 +  If SalStrLeftX(MyValue, 1) = '@'
.head 9 -  Return VALIDATE_Ok
.head 8 +  If colTagType = 'N'
.head 9 +  If SalStrScan(MyValue, ',') = -1
.head 10 +  If NOT SalStrIsValidNumber(MyValue)
.head 11 -  Call SalMessageBeep(MB_IconStop)
.head 11 -  ! Недопустимый тип данных для этого атрибута!
.head 11 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErrType'),
     CurrentLangTable.GetAtomTitle('cTErr'), MB_IconStop | MB_Ok)
.head 11 -  Return VALIDATE_Cancel
.head 8 -  Return VALIDATE_Ok
.head 4 +  Functions
.head 5 +  Function: SetFilter
.head 6 -  Description: Запомнить фильтр в структуру
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 6 +  Actions
.head 7 -  Set F.cSimpleFilter.nStrNum = 0
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 -  Call F.cSimpleFilter.NewString(F.cSimpleFilter.Tag[colTagId].sQueryCol, colValue)
.head 7 -  !
.head 7 -  Return TRUE
.head 5 +  Function: ClearFilter
.head 6 -  Description: Очистить фильтр
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 6 +  Actions
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 -  Set colValue = ''
.head 7 -  !
.head 7 -  Return TRUE
.head 4 +  Window Variables
.head 5 -  Number: ni
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 6 +  If NOT F.cSimpleFilter.isTagListEmpty()
.head 7 -  Set ni = 0
.head 7 +  While ni < F.cSimpleFilter.nTagNum
.head 8 -  Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
.head 8 +  If nRow != TBL_Error
.head 9 -  Call SalTblSetContext(hWndForm, nRow)
.head 9 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 9 -  Set colTagId   = ni
.head 9 -  Set colTag     = F.cSimpleFilter.Tag[ni].sTagName
.head 9 -  Set colTagType = F.cSimpleFilter.Tag[ni].sTagType
.head 9 -  Set colValue   = F.cSimpleFilter.GetValueByColName(F.cSimpleFilter.Tag[ni].sQueryCol)
.head 9 -  Set ni = ni + 1
.head 6 -  Call SalTblSetContext(hWndForm, 0)
.head 6 -  Call SalTblSetFocusCell(hWndForm, 0, colValue, 0, 0)
.head 3 -  ! ***** = *****
.head 3 +  Picture: picTabs
.data CLASSPROPS
0000: 5461624F7269656E 746174696F6E0001 0000005461624C65 66744D617267696E
0020: 0002003000005461 6243757272656E74 000A0053696D706C 6554616700005461
0040: 6252696768744D61 7267696E00020030 00005461624E616D 6573002000537973
0060: 5461670955736572 546167094E657754 61670953696D706C 6554616700005461
0080: 624C6162656C7300 2C00D1E8F1F2E5EC EDFBE92009CFEEEB FCE7EEE2E0F2E5EB
00A0: FCF1EAE8E92009CD EEE2FBE92009CFF0 EEF1F2EEE9000054 616250616765436F
00C0: 756E740002003100 00546162426F7474 6F6D4D617267696E 000500302E343500
00E0: 0054616244726177 5374796C65000B00 57696E3935537479 6C65000054616246
0100: 6F726D5061676573 0004000909090000 546162546F704D61 7267696E00020030
0120: 0000000000000000 0000000000000000 0000000000000000
.enddata
.data CLASSPROPSSIZE
0000: 3801
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 1
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cQuickTabsDialog
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    0.031"
.head 5 -  Width:  10.829"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 3.375"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  File Name:
.head 4 -  Storage: Class Default
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Fit: Class Default
.head 4 -  Scaling
.head 5 -  Width:  Class Default
.head 5 -  Height:  Class Default
.head 4 -  Corners: Class Default
.head 4 -  Border Style: Class Default
.head 4 -  Border Thickness: Class Default
.head 4 -  Tile To Parent? No
.head 4 -  Border Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendClassMessage(SAM_Create, wParam, lParam)
.head 6 -  Call Tags.AttachWindow(picTabs)
.head 6 -  !
.head 6 -  Call picTabs.SetLabel(0, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTabs0'), TRUE)
.head 6 -  Call picTabs.SetLabel(1, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTabs1'), TRUE)
.head 6 -  Call picTabs.SetLabel(2, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTabs2'), TRUE)
.head 6 -  Call picTabs.SetLabel(3, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTabs3'), TRUE)
.head 6 +  If NOT fPlainMode
.head 7 +  If NOT nSysFilterNum
.head 8 -  Call Tags.Enable(0, FALSE)
.head 8 -  Call Tags.SendMsgToAssociated(0, UM_ObjDeactivate, 0, 0)
.head 7 +  If NOT nUserFilterNum
.head 8 -  Call Tags.Enable(1, FALSE)
.head 8 -  Call Tags.SendMsgToAssociated(1, UM_ObjDeactivate, 0, 0)
.head 7 -  !
.head 7 +  If F.cSimpleFilter.nTagNum
.head 8 -  Call Tags.BringToTop(3, TRUE)
.head 8 -  Call SalSetFocus(tblFSimple)
.head 8 -  Call SalTblSetFocusRow(tblFSimple, 0)
.head 8 -  Call SalTblSetFocusCell(tblFSimple, 0, tblFSimple.colValue, 0, 0)
.head 7 +  Else
.head 8 -  Call Tags.Delete(3, FALSE)
.head 8 -  Call SalHideWindow(pbRefresh)
.head 8 -  Call SalHideWindow(tblFSimple)
.head 8 +  If nSysFilterNum
.head 9 -  Call Tags.BringToTop(0, TRUE)
.head 9 -  Call Tags.SendMsgToAssociated(2, UM_ObjDeactivate, 0, 0)
.head 8 +  Else If nUserFilterNum
.head 9 -  Call Tags.BringToTop(1, TRUE)
.head 9 -  Call Tags.SendMsgToAssociated(2, UM_ObjDeactivate, 0, 0)
.head 8 +  Else
.head 9 -  Call Tags.BringToTop(2, TRUE)
.head 6 +  Else
.head 7 -  Call Tags.Delete(0, FALSE)
.head 7 -  Call Tags.Delete(0, TRUE)
.head 7 -  Call Tags.Delete(3, FALSE)
.head 3 -  !
.head 3 +  Pushbutton: pbApply
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Применить
.head 4 -  Window Location and Size
.head 5 -  Left:   7.671"
.head 5 -  Top:    3.5"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\APPLY.BMP
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 +  If fPlainMode
.head 7 -  ! Сохранить
.head 7 -  Call SalSetWindowText(hWndItem, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipApply'))
.head 5 +  On SAM_Click
.head 6 -  ! F.nSysRow - не номер строки (сейчас это не актуально, т.к. работает сортировка), а номер фильтра (colID)
.head 6 -  Set F.nSysRow = tblFSystem.colID
.head 6 -  Set F.strSysFromClause  = tblFSystem.colFromClause
.head 6 -  Set F.strSysWhereClause = tblFSystem.colWhereClause
.head 6 -  ! F.nUserRow - не номер строки (сейчас это не актуально, т.к. работает сортировка), а номер фильтра (colID)
.head 6 -  Set F.nUserRow = tblFUser.colID
.head 6 -  Set F.strUserFromClause  = tblFUser.colFromClause
.head 6 -  Set F.strUserWhereClause = tblFUser.colWhereClause
.head 6 -  !
.head 6 +  If CheckFilter( )
.head 7 +  If SalTblAnyRows(tblFString, 0, 0)
.head 8 -  Call SetFilter()
.head 7 +  Else
.head 8 -  ! Фильтр пуст...
.head 8 -  Set F.nStrNum = 0
.head 7 -  Call SetSimpleFilter()
.head 7 -  !
.head 7 -  Set sTmp = F.GetFilterWhereClause(FALSE)
.head 7 +  If sTmp
.head 8 -  ! Задействован фильтр: F.GetFilterWhereClause(FALSE)
.head 8 -  Call SaveInfoToLog(CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTSetFilter') ||  ': ' || sTmp)
.head 7 +  Else
.head 8 -  ! Задействована нефильтрованная (полная) выборка
.head 8 -  Call SaveInfoToLog(CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTSetNotFilter'))
.head 7 -  Call SalEndDialog(hWndForm, 1)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отменить
.head 4 -  Window Location and Size
.head 5 -  Left:   9.4"
.head 5 -  Top:    3.5"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\DISCARD.BMP
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(hWndForm, 0)
.head 2 +  Functions
.head 3 +  Function: CheckFilter
.head 4 -  Description: Проверить синтаксис фильтра
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nParanteses
.head 5 -  Number: nLastState
.head 5 -  Number: nCurrState
.head 5 -  Boolean: fIsError
.head 5 -  String: sError
.head 4 +  Actions
.head 5 -  ! let's remove blank strings
.head 5 -  Set nRow = TBL_MinRow
.head 5 +  While SalTblFindNextRow( tblFString, nRow, 0, 0)
.head 6 -  Call SalTblSetContext( tblFString, nRow )
.head 6 +  If tblFString.colTagId = NUMBER_Null AND tblFString.colOp = ''
.head 7 -  Call SalTblDeleteRow( tblFString, nRow, TBL_Adjust )
.head 5 -  !
.head 5 -  Set nRow = TBL_MinRow
.head 5 -  Set nParanteses = 0
.head 5 -  Set nLastState = FLTR_START
.head 5 -  Set nCurrState = FLTR_START
.head 5 -  Set fIsError = FALSE
.head 5 +  While NOT fIsError AND SalTblFindNextRow( tblFString, nRow, 0, 0) 
.head 6 -  Call SalTblSetContext( tblFString, nRow )
.head 6 +  If tblFString.colOp = '('
.head 7 -  Set nParanteses = nParanteses + 1
.head 6 +  If tblFString.colOp = ')'
.head 7 -  Set nParanteses = nParanteses - 1
.head 6 -  !
.head 6 +  If tblFString.colOp != ''
.head 7 +  If tblFString.colOp = '('
.head 8 -  Set nCurrState = FLTR_LPARANT
.head 7 +  Else If tblFString.colOp = ')'
.head 8 -  Set nCurrState = FLTR_RPARANT
.head 7 +  Else
.head 8 -  Set nCurrState = FLTR_OPERATOR
.head 7 -  !
.head 7 -  Set fIsError = CheckAllowence( nLastState, nCurrState, sError )
.head 7 -  Set nLastState = nCurrState
.head 6 +  If NOT fIsError
.head 7 +  If tblFString.colTag != ''
.head 8 -  Set nCurrState = FLTR_ATOM
.head 8 -  !
.head 8 -  Set fIsError = CheckAllowence( nLastState, nCurrState, sError )
.head 8 -  Set nLastState = nCurrState
.head 7 +  If NOT fIsError
.head 8 +  If tblFString.colSign != ''
.head 9 +  If SalStrTrimX( tblFString.colSign ) = 'ПУСТОЙ' OR
   SalStrTrimX( tblFString.colSign ) = 'НЕ ПУСТОЙ'
.head 10 -  Set nCurrState = FLTR_ISNULLOP
.head 9 +  Else
.head 10 -  Set nCurrState = FLTR_SIGN
.head 9 -  !
.head 9 -  Set fIsError = CheckAllowence( nLastState, nCurrState, sError )
.head 9 -  Set nLastState = nCurrState
.head 8 +  If NOT fIsError
.head 9 +  If tblFString.colValue != ''
.head 10 -  Set nCurrState = FLTR_ATOM
.head 10 -  !
.head 10 -  Set fIsError = CheckAllowence( nLastState, nCurrState, sError )
.head 10 -  Set nLastState = nCurrState
.head 5 +  If NOT fIsError
.head 6 -  Set fIsError = CheckAllowence( nLastState, FLTR_STOP, sError )
.head 5 +  If NOT fIsError AND nParanteses != 0
.head 6 +  If nParanteses > 0
.head 7 -  ! Set sError = 'Пропущена ЗАКРЫВАЮЩАЯ скобка'
.head 7 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr8')
.head 6 +  Else
.head 7 -  ! Set sError = 'Пропущена ОТКРЫВАЮЩАЯ скобка'
.head 7 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr9')
.head 6 -  Set fIsError = TRUE
.head 5 +  If fIsError
.head 6 -  Call SalMessageBeep( MB_IconStop )
.head 6 -  ! Call SalMessageBox( sError, 'Синтаксическая ошибка', MB_Ok )
.head 6 -  Call SalMessageBox( sError, CurrentLangTable.GetAtomTitle('cTSyntaxErr'), MB_Ok )
.head 6 -  Call SalTblSetFocusRow( tblFString, nRow )
.head 5 -  Return NOT fIsError
.head 3 +  Function: CheckAllowence
.head 4 -  Description: Проверяет допустимость последовательности атомов
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nPrev
.head 5 -  Number: nNext
.head 5 -  Receive String: sError
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Boolean: fRet
.head 4 +  Actions
.head 5 -  Set sError = ''
.head 5 -  Set fRet = FALSE
.head 5 +  If nPrev = FLTR_SIGN     AND nNext != FLTR_ATOM
.head 6 -  Set fRet = TRUE
.head 6 -  ! Недопустимое выражение после оператора сравнения
.head 6 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr1')
.head 5 +  If nPrev = FLTR_ISNULLOP AND nNext != FLTR_OPERATOR AND nNext != FLTR_SIGN AND nNext != FLTR_RPARANT AND nNext != FLTR_STOP
.head 6 -  Set fRet = TRUE
.head 6 -  ! Недопустимое выражение после оператора IS NULL/IS NOT NULL
.head 6 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr2')
.head 5 +  If nPrev = FLTR_OPERATOR AND nNext != FLTR_ATOM AND nNext != FLTR_LPARANT
.head 6 -  Set fRet = TRUE
.head 6 -  ! Недопустимое выражение после логического оператора
.head 6 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr3')
.head 5 +  If nPrev = FLTR_START    AND nNext != FLTR_ATOM AND nNext != FLTR_LPARANT AND nNext != FLTR_STOP
.head 6 -  Set fRet = TRUE
.head 6 -  ! Недопустимое начало логического выражения фильтра
.head 6 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr4')
.head 5 +  If nPrev = FLTR_LPARANT  AND nNext != FLTR_ATOM AND nNext != FLTR_LPARANT
.head 6 -  Set fRet = TRUE
.head 6 -  ! Недопустимое выражение после открывающей скобки
.head 6 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr5')
.head 5 +  If nPrev = FLTR_RPARANT  AND nNext != FLTR_OPERATOR AND nNext != FLTR_ISNULLOP AND nNext != FLTR_RPARANT AND nNext != FLTR_STOP
.head 6 -  Set fRet = TRUE
.head 6 -  ! Недопустимое выражение после закрывающей скобки
.head 6 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr6')
.head 5 +  If nPrev = FLTR_ATOM     AND nNext != FLTR_OPERATOR AND nNext != FLTR_ISNULLOP AND nNext != FLTR_SIGN    AND nNext != FLTR_RPARANT AND nNext != FLTR_STOP
.head 6 -  Set fRet = TRUE
.head 6 -  ! Недопустимое выражение после атрибута или значения
.head 6 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr7')
.head 5 -  !
.head 5 -  Return fRet
.head 3 +  Function: CheckListOfNumber
.head 4 -  Description: Проверить строчных список числовых значений
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: strValList
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strVal[*]
.head 5 -  Number: nVals
.head 5 -  Number: nIterator
.head 5 -  Boolean: fError
.head 4 +  Actions
.head 5 +  If NOT strValList
.head 6 -  Return FALSE
.head 5 +  If SalStrScan( SalStrUpperX( strValList ), 'SELECT' ) >= 0
.head 6 -  Return TRUE
.head 5 -  Set nVals = SalStrTokenize( strValList, '', ',', strVal )
.head 5 +  If NOT nVals
.head 6 -  Return FALSE
.head 5 -  Set nIterator = 0
.head 5 -  Set fError = FALSE
.head 5 +  While ( nIterator < nVals AND NOT fError )
.head 6 +  If NOT SalStrIsValidNumber( strVal[nIterator] )
.head 7 -  Set fError = TRUE
.head 6 -  Set nIterator = nIterator + 1
.head 5 -  Return NOT fError
.head 3 +  Function: SetFilter
.head 4 -  Description: Запомнить фильтр в структуру
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nRow
.head 4 +  Actions
.head 5 -  Set nRow = TBL_MinRow
.head 5 -  Set F.nStrNum = 0
.head 5 +  While SalTblFindNextRow( tblFString, nRow, 0, 0 )
.head 6 -  Call SalTblSetContext( tblFString, nRow )
.head 6 +  If tblFString.colTagId >= 0 AND tblFString.colTagId < F.nTagNum
.head 7 -  Call F.NewString (F.TranslateLOper(tblFString.colOp, FALSE), -1, 
     F.Tag[tblFString.colTagId].sQueryCol, -1, F.Tag[tblFString.colTagId].sQueryTab,
     F.TranslateLSign(tblFString.colSign, FALSE), tblFString.colValue, tblFString.colSemantic)
.head 6 +  Else
.head 7 -  Call F.NewString (F.TranslateLOper(tblFString.colOp, FALSE), -1, '', -1, '',
     F.TranslateLSign(tblFString.colSign, FALSE), tblFString.colValue, tblFString.colSemantic)
.head 3 +  Function: GetExtraValue
.head 4 -  Description: Получить значение из справочника
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: strTab
.head 5 -  String: strCol
.head 5 -  Receive String: strId
.head 5 -  Receive String: strSm
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: s1
.head 5 -  String: s2
.head 5 -  Boolean: fRet
.head 4 +  Actions
.head 5 -  Set fRet = SalModalDialog(dlg_GetValue, hWndForm, strTab, strCol, s1, s2)
.head 5 +  If fRet
.head 6 -  Set strId = s1
.head 6 -  Set strSm = s2
.head 5 -  Return fRet
.head 3 +  Function: SetSimpleFilter
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Return tblFSimple.SetFilter()
.head 2 +  Window Parameters
.head 3 -  : F
.head 4 -  Class: cGenFilterEx
.head 3 -  Boolean: fPlainMode
.head 2 +  Window Variables
.head 3 -  : FSys
.head 4 -  Class: cABSConnect
.head 3 -  : FUsr
.head 4 -  Class: cABSConnect
.head 3 -  !
.head 3 -  Number: nRow
.head 3 -  Boolean: fIsNULLValue ! флаг наличия оператора IS NULL
.head 3 -  Boolean: fIsBrackets  ! флаг наличия закрывающей скобки
.head 3 -  String: sKeyValue     ! хранилище для значения ключа
.head 3 -  String: sSemValue     ! хранилище для семантики
.head 3 -  String: sTabSemantic  ! семантическое название фильтруемой таблицы
.head 3 -  !
.head 3 -  : Tags
.head 4 -  Class: cSWTabs
.head 3 -  !
.head 3 -  Number: nUserId
.head 3 -  String: strNewFilterName
.head 3 -  Number: nSysFilterNum
.head 3 -  Number: nUserFilterNum
.head 3 -  !
.head 3 -  Window Handle: hWndFocusCol
.head 3 -  String: sTmp
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTWndTitle'))
.head 4 -  !
.head 4 -  Call XConnectGetParams(FSys)
.head 4 -  Call FSys.Connect()
.head 4 -  Call FUsr.Clone(FSys, TRUE)
.head 4 -  !
.head 4 +  If SqlPrepareAndExecute(FUsr.hSql(), 'SELECT semantic INTO :sTabSemantic FROM meta_tables WHERE tabid=:F.nFTabId')
.head 5 +  If SqlFetchNext(FUsr.hSql(), nFetchRes)
.head 6 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTWndTitle') || ' [' || sTabSemantic || ']')
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  !
.head 4 -  Call XSalTooltipSetUserDefault()
.head 4 -  Set nUserId = GetUserId()
.head 4 -  !
.head 4 -  Set cbFSystem = F.fSystemFilterInUse
.head 4 -  Set cbFUser   = F.fUserFilterInUse
.head 3 +  On SAM_Destroy
.head 4 -  Call FSys.Disconnect()
.head 4 -  Call FUsr.Disconnect()
.head 1 +  Dialog Box: dlg_SetDFilter
.head 2 -  Class: cQuickTabsDialog
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Фильтр
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   0.5"
.head 4 -  Top:    0.5"
.head 4 -  Width:  11.0"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 4.4"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: MS Sans Serif
.head 3 -  Font Size: 8
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Показывает/создает/редактирует фильтр на таблицу
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
.head 3 -  ! ***** Системный фильтр *****
.head 3 +  Child Table: tblFSystem
.data CLASSPROPSSIZE
0000: 1A00
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 5379735461670000 0000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.15"
.head 6 -  Top:    0.35"
.head 6 -  Width:  10.65"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 3.0"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? No
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  View: Table
.head 5 -  Allow Row Sizing? No
.head 5 -  Lines Per Row: Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: 1000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colApply
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Использовать
фильтр
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Class Default
.head 6 -  Width:  1.4"
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Check Box
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value: 1
.head 8 -  Uncheck Value: 0
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colID
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
фильтра
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 5
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.2"
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
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 70
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  7.3"
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
.head 5 +  Column: colFromClause
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
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
.head 5 +  Column: colWhereClause
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 2000
.head 6 -  Data Type: Long String
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
.head 4 +  Functions
.head 5 +  Function: SetFilter
.head 6 -  Description:
.head 6 -  Returns
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 6 +  Actions
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 -  Call F.cSysFilter.setFilterInUse(colID, colApply)
.head 4 +  Window Variables
.head 5 -  Number: i
.head 5 -  Boolean: bSortOrd
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 6 -  Call SalTblSetTableFlags(hWndForm, TBL_Flag_SelectableCols, TRUE)
.head 6 +  If NOT fPlainMode
.head 7 -  Call SalTblReset(hWndForm)
.head 7 -  Set nSysFilterNum = F.cSysFilter.nFilterNum
.head 7 -  Set i = 0
.head 7 +  While i < nSysFilterNum
.head 8 -  Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
.head 8 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 -  Call F.cSysFilter.getFilterByIndex(i, colID, colName, colFromClause, colWhereClause, colApply)
.head 8 -  Set i = i + 1
.head 7 -  Call SalTblSetContext(hWndForm, 0)
.head 7 -  Call SalTblSetFocusRow(hWndForm, 0)
.head 5 +  On UM_NoFontChange
.head 6 -  Return TRUE
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndForm)
.head 5 +  On SAM_ColumnSelectClick
.head 6 -  Call SalTblSetColumnFlags(SalNumberToWindowHandle(wParam), COL_Selected, FALSE)
.head 6 -  Set bSortOrd = not bSortOrd
.head 6 -  Call SalTblSortRows(hWndForm, SalTblQueryColumnID(SalNumberToWindowHandle(wParam)), bSortOrd)
.head 3 -  ! ***** Пользовательский фильтр *****
.head 3 -  Frame
.data CLASSPROPSSIZE
0000: 1B00
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000800 5573657254616700 000000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Resource Id: 45574
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.186"
.head 5 -  Top:    0.344"
.head 5 -  Width:  1.057"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.396"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 3 +  Pushbutton: pbUDelete
.data CLASSPROPSSIZE
0000: 1B00
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000800 5573657254616700 000000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbDelete
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.286"
.head 5 -  Top:    0.385"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Удалить фильтр
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipUDelete')
.head 5 +  On SAM_Click
.head 6 -  Call tblFUser.DeleteFilter()
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Pushbutton: pbUSave
.data CLASSPROPSSIZE
0000: 1B00
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000800 5573657254616700 000000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbUpdate
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.714"
.head 5 -  Top:    0.385"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Сохранить измения в БД
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipUSave')
.head 5 +  On SAM_Click
.head 6 -  Call tblFUser.UpdateFilter()
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Pushbutton: pbShowCondition
.data CLASSPROPSSIZE
0000: 1900
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000800 5573657254616700 00
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbEdit
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.314"
.head 5 -  Top:    0.385"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Просмотреть значение фильтра...
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipShowCondition')
.head 5 +  On SAM_Click
.head 6 -  Set sTmp = tblFUser.colWhereClause
.head 6 +  If SalModalDialog(dlg_ShowFilter, hWndForm, FUsr.hSql(), tblFUser.colID, sTmp)
.head 7 +  If sTmp != tblFUser.colWhereClause
.head 8 -  Set tblFUser.colWhereClause = sTmp
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Child Table: tblFUser
.data CLASSPROPSSIZE
0000: 1900
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000800 5573657254616700 00
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.15"
.head 6 -  Top:    0.75"
.head 6 -  Width:  10.65"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 2.6"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? No
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  View: Table
.head 5 -  Allow Row Sizing? No
.head 5 -  Lines Per Row: Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: 2000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colApply
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Использовать
фильтр
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Class Default
.head 6 -  Width:  1.4"
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Check Box
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value: 1
.head 8 -  Uncheck Value: 0
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colID
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
фильтра
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 5
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.2"
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
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: 70
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  7.3"
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
.head 5 +  Column: colFromClause
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
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
.head 5 +  Column: colWhereClause
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 2000
.head 6 -  Data Type: Long String
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
.head 4 +  Functions
.head 5 +  Function: SetFilter
.head 6 -  Description:
.head 6 -  Returns
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 6 +  Actions
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 -  Call F.cUserFilter.setFilterInUse(colID, colApply)
.head 5 +  Function: DeleteFilter
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 6 +  Actions
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 +  If SqlPrepareAndExecute(FUsr.hSql(), "DELETE FROM dyn_filter WHERE filter_id = :colID")
.head 9 -  Call SqlCommit(FUsr.hSql())
.head 9 -  Call F.cUserFilter.delFilter(colID)
.head 8 +  Else
.head 9 -  Call SqlRollback(FUsr.hSql())
.head 9 -  Break
.head 7 -  Call F.cUserFilter.ReInit(F.nFTabId, nUserId)
.head 7 -  Call SalSendMsg(hWndForm, SAM_Create, 0, 0)
.head 7 +  If NOT nUserFilterNum
.head 8 -  Call Tags.Enable(1, FALSE)
.head 8 -  Call Tags.Next()
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Return TRUE
.head 5 +  Function: UpdateFilter
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 6 +  Actions
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, ROW_Edited, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 +  If SqlPrepareAndExecute(FUsr.hSql(), "UPDATE dyn_filter SET semantic = :tblFUser.colName WHERE filter_id = :colID")
.head 9 -  Call SqlCommit(FUsr.hSql())
.head 9 -  Call F.cUserFilter.setFilterName(colID, colName)
.head 8 +  Else
.head 9 -  Call SqlRollback(FUsr.hSql())
.head 7 -  Call F.cUserFilter.ReInit(F.nFTabId, nUserId)
.head 7 -  Call SalSendMsg(hWndForm, SAM_Create, 0, 0)
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Return TRUE
.head 4 +  Window Variables
.head 5 -  Number: i
.head 5 -  Boolean: bSortOrd
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 6 -  Call SalTblSetTableFlags(hWndForm, TBL_Flag_SelectableCols, TRUE)
.head 6 +  If NOT fPlainMode
.head 7 -  Call SalTblReset(hWndForm)
.head 7 -  Set nUserFilterNum = F.cUserFilter.nFilterNum
.head 7 -  Set i = 0
.head 7 +  While i < nUserFilterNum
.head 8 +  If not F.cUserFilter.cFilter[i].bDeleted
.head 9 -  Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
.head 9 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New | ROW_Edited, FALSE)
.head 9 -  Call SalTblSetContext(hWndForm, nRow)
.head 9 -  Call F.cUserFilter.getFilterByIndex(i, colID, colName, colFromClause, colWhereClause, colApply)
.head 8 -  Set i = i + 1
.head 7 -  Call SalTblSetContext(hWndForm, 0)
.head 7 -  Call SalTblSetFocusRow(hWndForm, 0)
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndForm)
.head 5 +  On UM_NoFontChange
.head 6 -  Return TRUE
.head 5 +  On SAM_ColumnSelectClick
.head 6 -  Call SalTblSetColumnFlags(SalNumberToWindowHandle(wParam), COL_Selected, FALSE)
.head 6 -  Set bSortOrd = not bSortOrd
.head 6 -  Call SalTblSortRows(hWndForm, SalTblQueryColumnID(SalNumberToWindowHandle(wParam)), bSortOrd)
.head 3 -  ! ***** Новый фильтр *****
.head 3 -  Frame
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Resource Id: 45575
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.186"
.head 5 -  Top:    0.344"
.head 5 -  Width:  1.057"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.396"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 3 +  Pushbutton: pbInsertBefore
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbInsert
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.183"
.head 5 -  Top:    0.381"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\C2.BMP
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Вставить строку фильтра
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipInsertBefore')
.head 5 +  On SAM_Click
.head 6 -  Call tblFString.InsertRowBefore()
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Pushbutton: pbInsert
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbInsert
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.617"
.head 5 -  Top:    0.381"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Insert.bmp
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Добавить строку фильтра
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipInsert')
.head 5 +  On SAM_Click
.head 6 -  Call tblFString.InsertRow()
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Pushbutton: pbDelete
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cTBarButton
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.05"
.head 5 -  Top:    0.381"
.head 5 -  Width:  0.43"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.317"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Delete.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Удалить строку фильтра
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipDelete')
.head 5 +  On SAM_Click
.head 6 -  Call tblFString.DeleteRow()
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow( hWndItem )
.head 3 +  Pushbutton: pbDeleteAll
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbDelete
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.483"
.head 5 -  Top:    0.381"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Удалить все строки фильтра
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipDeleteAll')
.head 5 +  On SAM_Click
.head 6 -  Call SalTblReset(tblFString)
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 -  Frame
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Resource Id: 45576
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.7"
.head 5 -  Top:    0.344"
.head 5 -  Width:  0.686"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.396"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 3 +  Pushbutton: pbGetValue
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbDetail
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.15"
.head 5 -  Top:    0.381"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalDisableWindow(hWndItem)
.head 6 -  ! Выбрать значение из возможных
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipGetValue')
.head 5 +  On SAM_Click
.head 6 +  If tblFString.colTagId != -1
.head 7 +  If F.cNewFilter.Tag[tblFString.colTagId].isForeignKey() 
.head 8 +  If GetExtraValue( F.cNewFilter.Tag[tblFString.colTagId].S.sSTabName,
                  F.cNewFilter.Tag[tblFString.colTagId].S.sSSemantic,
                  sKeyValue, sSemValue ) != -1
.head 9 -  Set tblFString.colValue    = sKeyValue
.head 9 -  Set tblFString.colSemantic = sSemValue
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow( hWndItem )
.head 3 +  Pushbutton: pbGetFormula
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cTBarButton
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.583"
.head 5 -  Top:    0.381"
.head 5 -  Width:  0.43"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.317"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Formula.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalDisableWindow(hWndItem)
.head 6 -  ! Выбрать формулу из возможных
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipGetFormula')
.head 5 -  On SAM_Click
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 -  Frame
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Resource Id: 45577
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.743"
.head 5 -  Top:    0.344"
.head 5 -  Width:  1.114"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.396"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 3 +  Pushbutton: pbCheck
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cTBarButton
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.2"
.head 5 -  Top:    0.381"
.head 5 -  Width:  0.43"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.317"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Chekin.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Проверить синтаксис сформированого фильтра
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipCheck')
.head 5 +  On SAM_Click
.head 6 -  Call tblFString.CheckFilter()
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Pushbutton: pbSave
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbUpdate
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.633"
.head 5 -  Top:    0.381"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 +  If fPlainMode
.head 7 -  Call SalDisableWindow(hWndItem)
.head 6 -  ! Сохранить сформированый фильтр в БД
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipSave')
.head 5 +  On SAM_Click
.head 6 +  If tblFString.CheckFilter()
.head 7 +  If SalModalDialog(dlg_GetFilterName, hWndForm, strNewFilterName)
.head 8 -  Call SalWaitCursor(TRUE)
.head 8 +  If SalTblAnyRows(tblFString, 0, 0)
.head 9 -  Call tblFString.SetFilter()
.head 9 +  If NOT F.cNewFilter.isFilterEmpty()
.head 10 -  Call F.SaveFilterDB(nUserId, strNewFilterName)
.head 10 -  Call SalSendMsg(tblFUser, SAM_Create, 0, 0)
.head 10 +  If nUserFilterNum AND NOT Tags.IsEnabled(1)
.head 11 -  Call Tags.Enable(1, TRUE)
.head 9 -  Set F.cNewFilter.nStrNum = 0
.head 9 -  Call SalTblReset(tblFString)
.head 8 -  Call SalWaitCursor(FALSE)
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Child Table: tblFString
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.15"
.head 6 -  Top:    0.75"
.head 6 -  Width:  10.65"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 2.6"
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
.head 5 +  Column: colOp
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: И/ИЛИ
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.757"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? No
.head 8 -  Vertical Scroll? No
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? No
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 +  List Values
.head 7 -  Text: И
.head 7 -  Text: ИЛИ
.head 7 -  Text: (
.head 7 -  Text: )
.head 7 -  Text:
.head 6 +  Message Actions
.head 7 +  On SAM_Validate
.head 8 +  If colOp = ')'
.head 9 -  Set colTagId = -1
.head 9 -  Set colTag = ''
.head 9 -  Set colSign = ''
.head 9 -  Set colValue = ''
.head 9 -  Set colSemantic = ''
.head 9 -  Set fIsBrackets = TRUE
.head 8 +  Else
.head 9 -  Set fIsBrackets = FALSE
.head 5 +  Column: colTagId
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
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
.head 5 +  Column: colTag
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Атрибут
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  2.886"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? No
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? No
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 +  Message Actions
.head 7 +  On SAM_Create
.head 8 +  If NOT F.cNewFilter.isTagListEmpty()
.head 9 -  Set ni = 0
.head 9 +  While ni < F.cNewFilter.nTagNum
.head 10 -  Call SalListAdd(hWndItem, F.cNewFilter.Tag[ni].sTagName)
.head 10 -  Set ni = ni + 1
.head 9 -  Call SalListAdd(hWndItem, '')
.head 7 +  On SAM_Validate
.head 8 +  If colTag != ''
.head 9 +  If NOT F.cNewFilter.isTagListEmpty()
.head 10 +  If colTagId != F.cNewFilter.GetTagByName(colTag)
.head 11 -  Set colTagId = F.cNewFilter.GetTagByName(colTag)
.head 11 +  If colTagId >= 0  and colTagId < F.cNewFilter.nTagNum
.head 12 -  Set colTag = F.cNewFilter.Tag[colTagId].sTagName
.head 12 -  Set colTagType = F.cNewFilter.Tag[colTagId].sTagType
.head 12 -  !
.head 12 -  Call SalSendMsg(colSign, SAM_Validate, 0, 0)
.head 12 -  ! Set fIsNULLValue = TRUE
.head 12 -  ! Set colValue = ''
.head 12 -  ! Set colSemantic = ''
.head 12 -  !
.head 12 +  If F.cNewFilter.Tag[colTagId].isForeignKey()
.head 13 -  Call SalEnableWindow(pbGetValue)
.head 12 +  Else
.head 13 -  Call SalDisableWindow(pbGetValue)
.head 8 +  Else
.head 9 -  Set colTagId = -1
.head 9 -  Set colSign = ''
.head 9 -  Set colValue = ''
.head 9 -  Set colSemantic = ''
.head 9 -  Call SalDisableWindow(pbGetValue)
.head 8 -  Return VALIDATE_Ok
.head 5 +  Column: colTagType
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: TagType
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
.head 5 +  Column: colSign
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Оператор
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.471"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? No
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? No
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 +  List Values
.head 7 -  Text: =
.head 7 -  Text: <
.head 7 -  Text: <=
.head 7 -  Text: >
.head 7 -  Text: >=
.head 7 -  Text: <>
.head 7 -  Text: ПОХОЖ
.head 7 -  Text: НЕ ПОХОЖ
.head 7 -  Text: ПУСТОЙ
.head 7 -  Text: НЕ ПУСТОЙ
.head 7 -  Text: ОДИН ИЗ
.head 7 -  Text: НЕ ОДИН ИЗ
.head 7 -  Text:
.head 6 +  Message Actions
.head 7 +  On SAM_Validate
.head 8 +  If colSign = 'ПУСТОЙ' OR colSign = 'НЕ ПУСТОЙ' OR colSign = ''
.head 9 -  Set fIsNULLValue = TRUE
.head 9 -  Set colValue = ''
.head 9 -  Set colSemantic = ''
.head 8 +  Else
.head 9 -  Set fIsNULLValue = FALSE
.head 8 +  If SalSendMsg(colValue, SAM_Validate, 0, 0)
.head 9 -  Return VALIDATE_Ok
.head 8 +  Else
.head 9 -  Return VALIDATE_Cancel
.head 5 +  Column: colValue
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Значение
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: 200
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.743"
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
.head 6 +  Message Actions
.head 7 +  On SAM_AnyEdit
.head 8 -  Call SalClearField(colSemantic)
.head 8 +  If fIsNULLValue or fIsBrackets
.head 9 -  Call SalClearField(hWndItem)
.head 7 +  On SAM_Validate
.head 8 +  If MyValue = STRING_Null
.head 9 -  Return VALIDATE_Ok
.head 8 +  If SalStrLeftX( MyValue, 1) = '@'
.head 9 -  Return VALIDATE_Ok
.head 8 +  If colTagType = 'N' AND NOT SalStrIsValidNumber(MyValue)
.head 9 +  If colSign = 'ОДИН ИЗ' OR colSign = 'НЕ ОДИН ИЗ'
.head 10 +  If NOT CheckListOfNumber(colValue)
.head 11 -  Call SalMessageBeep(MB_IconStop)
.head 11 -  ! Неверный список значений для этого атрибута!
.head 11 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErrList'),
     CurrentLangTable.GetAtomTitle('cTErr'), MB_IconStop | MB_Ok)
.head 11 -  Return VALIDATE_Cancel
.head 9 +  Else
.head 10 +  If SalStrUpperX(F.cNewFilter.Tag[colTagId].sQueryCol) = 'KV' AND
SalStrScan(colValue, ',') = -1
.head 11 -  Set strKv = ''
.head 11 +  If SqlPrepareAndExecute(hSql(), 'SELECT kv INTO :strKv FROM tabval WHERE lcv = :colValue')
.head 12 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 12 -  Set MyValue = strKv
.head 12 -  Return VALIDATE_Ok
.head 10 +  Else
.head 11 -  Call SalMessageBeep(MB_IconStop)
.head 11 -  ! Недопустимый тип данных для этого атрибута!
.head 11 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErrType'),
     CurrentLangTable.GetAtomTitle('cTErr'), MB_IconStop | MB_Ok)
.head 11 -  Return VALIDATE_Cancel
.head 8 -  Return VALIDATE_Ok
.head 5 +  Column: colSemantic
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Семантика значения
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  4.414"
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
.head 5 +  Function: CheckFilter
.head 6 -  Description: Проверить синтаксис фильтра
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nParanteses
.head 7 -  Number: nLastState
.head 7 -  Number: nCurrState
.head 7 -  Boolean: fIsError
.head 7 -  String: sError
.head 6 +  Actions
.head 7 -  ! let's remove blank strings
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 +  If colTagId = NUMBER_Null AND colOp = ''
.head 9 -  Call SalTblDeleteRow(hWndForm, nRow, TBL_Adjust)
.head 7 -  !
.head 7 -  Set nRow = TBL_MinRow
.head 7 -  Set nParanteses = 0
.head 7 -  Set nLastState = FLTR_START
.head 7 -  Set nCurrState = FLTR_START
.head 7 -  Set fIsError = FALSE
.head 7 +  While NOT fIsError AND SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 +  If colOp = '('
.head 9 -  Set nParanteses = nParanteses + 1
.head 8 +  If colOp = ')'
.head 9 -  Set nParanteses = nParanteses - 1
.head 8 -  !
.head 8 +  If colOp != ''
.head 9 +  If colOp = '('
.head 10 -  Set nCurrState = FLTR_LPARANT
.head 9 +  Else If colOp = ')'
.head 10 -  Set nCurrState = FLTR_RPARANT
.head 9 +  Else
.head 10 -  Set nCurrState = FLTR_OPERATOR
.head 9 -  !
.head 9 -  Set fIsError = CheckAllowence(nLastState, nCurrState, sError)
.head 9 -  Set nLastState = nCurrState
.head 8 +  If NOT fIsError
.head 9 +  If colTag != ''
.head 10 -  Set nCurrState = FLTR_ATOM
.head 10 -  !
.head 10 -  Set fIsError = CheckAllowence(nLastState, nCurrState, sError)
.head 10 -  Set nLastState = nCurrState
.head 9 +  If NOT fIsError
.head 10 +  If colSign != ''
.head 11 +  If SalStrTrimX(colSign) = 'ПУСТОЙ' OR
   SalStrTrimX(colSign) = 'НЕ ПУСТОЙ'
.head 12 -  Set nCurrState = FLTR_ISNULLOP
.head 11 +  Else
.head 12 -  Set nCurrState = FLTR_SIGN
.head 11 -  !
.head 11 -  Set fIsError = CheckAllowence(nLastState, nCurrState, sError)
.head 11 -  Set nLastState = nCurrState
.head 10 +  If NOT fIsError
.head 11 +  If colValue != ''
.head 12 -  Set nCurrState = FLTR_ATOM
.head 12 -  !
.head 12 -  Set fIsError = CheckAllowence(nLastState, nCurrState, sError)
.head 12 -  Set nLastState = nCurrState
.head 7 +  If NOT fIsError
.head 8 -  Set fIsError = CheckAllowence(nLastState, FLTR_STOP, sError)
.head 7 +  If NOT fIsError AND nParanteses != 0
.head 8 +  If nParanteses > 0
.head 9 -  ! Пропущена ЗАКРЫВАЮЩАЯ скобка
.head 9 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr8')
.head 8 +  Else
.head 9 -  ! Пропущена ОТКРЫВАЮЩАЯ скобка
.head 9 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr9')
.head 8 -  Set fIsError = TRUE
.head 7 +  If fIsError
.head 8 -  Call SalMessageBeep(MB_IconStop)
.head 8 -  ! sError, Синтаксическая ошибка
.head 8 -  Call SalMessageBox(sError, CurrentLangTable.GetAtomTitle('cTSyntaxErr'), MB_Ok)
.head 8 -  Call SalTblSetFocusRow(hWndForm, nRow)
.head 7 -  Return NOT fIsError
.head 5 +  Function: CheckAllowence
.head 6 -  Description: Проверяет допустимость последовательности атомов
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: nPrev
.head 7 -  Number: nNext
.head 7 -  Receive String: sError
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Boolean: fRet
.head 6 +  Actions
.head 7 -  Set sError = ''
.head 7 -  Set fRet = FALSE
.head 7 +  If nPrev = FLTR_SIGN     AND nNext != FLTR_ATOM
.head 8 -  Set fRet = TRUE
.head 8 -  ! Недопустимое выражение после оператора сравнения
.head 8 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr1')
.head 7 +  If nPrev = FLTR_ISNULLOP AND nNext != FLTR_OPERATOR AND nNext != FLTR_SIGN AND nNext != FLTR_RPARANT AND nNext != FLTR_STOP
.head 8 -  Set fRet = TRUE
.head 8 -  ! Недопустимое выражение после оператора IS NULL/IS NOT NULL
.head 8 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr2')
.head 7 +  If nPrev = FLTR_OPERATOR AND nNext != FLTR_ATOM AND nNext != FLTR_LPARANT
.head 8 -  Set fRet = TRUE
.head 8 -  ! Недопустимое выражение после логического оператора
.head 8 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr3')
.head 7 +  If nPrev = FLTR_START    AND nNext != FLTR_ATOM AND nNext != FLTR_LPARANT AND nNext != FLTR_STOP
.head 8 -  Set fRet = TRUE
.head 8 -  ! Недопустимое начало логического выражения фильтра
.head 8 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr4')
.head 7 +  If nPrev = FLTR_LPARANT  AND nNext != FLTR_ATOM AND nNext != FLTR_LPARANT
.head 8 -  Set fRet = TRUE
.head 8 -  ! Недопустимое выражение после открывающей скобки
.head 8 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr5')
.head 7 +  If nPrev = FLTR_RPARANT  AND nNext != FLTR_OPERATOR AND nNext != FLTR_ISNULLOP AND nNext != FLTR_RPARANT AND nNext != FLTR_STOP
.head 8 -  Set fRet = TRUE
.head 8 -  ! Недопустимое выражение после закрывающей скобки
.head 8 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr6')
.head 7 +  If nPrev = FLTR_ATOM     AND nNext != FLTR_OPERATOR AND nNext != FLTR_ISNULLOP AND nNext != FLTR_SIGN    AND nNext != FLTR_RPARANT AND nNext != FLTR_STOP
.head 8 -  Set fRet = TRUE
.head 8 -  ! Недопустимое выражение после атрибута или значения
.head 8 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr7')
.head 7 -  !
.head 7 -  Return fRet
.head 5 +  Function: CheckListOfNumber
.head 6 -  Description: Проверить строчных список числовых значений
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: strValList
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: strVal[*]
.head 7 -  Number: nVals
.head 7 -  Number: nIterator
.head 7 -  Boolean: fError
.head 6 +  Actions
.head 7 +  If NOT strValList
.head 8 -  Return FALSE
.head 7 +  If SalStrScan(SalStrUpperX(strValList), 'SELECT') >= 0
.head 8 -  Return TRUE
.head 7 -  Set nVals = SalStrTokenize(strValList, '', ',', strVal)
.head 7 +  If NOT nVals
.head 8 -  Return FALSE
.head 7 -  Set nIterator = 0
.head 7 -  Set fError = FALSE
.head 7 +  While (nIterator < nVals AND NOT fError)
.head 8 +  If NOT SalStrIsValidNumber(strVal[nIterator])
.head 9 -  Set fError = TRUE
.head 8 -  Set nIterator = nIterator + 1
.head 7 -  Return NOT fError
.head 5 +  Function: SetFilter
.head 6 -  Description: Запомнить фильтр в структуру
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 6 +  Actions
.head 7 +  If not CheckFilter()
.head 8 -  Return FALSE
.head 7 -  !
.head 7 -  Set F.cNewFilter.nStrNum = 0
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 +  If colTagId >= 0 AND colTagId < F.cNewFilter.nTagNum
.head 9 -  Call F.cNewFilter.NewString(F.TranslateLOper(colOp, FALSE), -1,
     F.cNewFilter.Tag[colTagId].sQueryCol, -1, F.cNewFilter.Tag[colTagId].sQueryTab,
     F.TranslateLSign(colSign, FALSE), colValue, colSemantic)
.head 8 +  Else
.head 9 -  Call F.cNewFilter.NewString(F.TranslateLOper(colOp, FALSE), -1, '', -1, '',
     F.TranslateLSign(colSign, FALSE), colValue, colSemantic)
.head 7 -  !
.head 7 -  Return TRUE
.head 5 +  Function: InsertRowBefore
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set nRow = SalTblQueryContext(hWndForm)
.head 7 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_Selected, FALSE)
.head 7 -  Set nRow = SalTblInsertRow(hWndForm, nRow)
.head 7 +  If nRow != TBL_Error
.head 8 -  Call SalSetFocus(hWndForm)
.head 8 -  Call SalTblSetFocusRow(hWndForm, nRow)
.head 8 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_Selected, TRUE)
.head 8 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 7 -  Return TRUE
.head 5 +  Function: InsertRow
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Selected, FALSE)
.head 7 -  Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
.head 7 +  If nRow != TBL_Error
.head 8 -  Call SalSetFocus(hWndForm)
.head 8 -  Call SalTblSetFocusRow(hWndForm, nRow)
.head 8 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 7 -  Return TRUE
.head 5 +  Function: DeleteRow
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblDeleteRow(hWndForm, nRow, TBL_Adjust)
.head 7 -  Return TRUE
.head 4 +  Window Variables
.head 5 -  Number: ni
.head 5 -  String: strKv
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 6 +  If NOT F.cNewFilter.isFilterEmpty()
.head 7 -  Set ni = 0
.head 7 +  While ni < F.cNewFilter.nStrNum
.head 8 -  Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
.head 8 +  If nRow != TBL_Error
.head 9 -  Call SalTblSetContext(hWndForm, nRow)
.head 9 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 9 -  Set colOp = F.TranslateLOper(F.cNewFilter.FStr[ni].sLOper, TRUE)
.head 9 -  Set colTagId = F.cNewFilter.GetTagByKey(F.cNewFilter.FStr[ni].sColName,F.cNewFilter.FStr[ni].sRTabName)
.head 9 +  If colTagId >= 0  and colTagId < F.cNewFilter.nTagNum
.head 10 -  Set colTag = F.cNewFilter.Tag[colTagId].sTagName
.head 10 -  Set colTagType = F.cNewFilter.Tag[colTagId].sTagType
.head 9 -  Set colSign = F.TranslateLSign(F.cNewFilter.FStr[ni].sLSign, TRUE)
.head 9 -  Set colValue = F.cNewFilter.FStr[ni].sValue
.head 9 -  Set colSemantic = F.cNewFilter.FStr[ni].sSemantic
.head 9 -  Set ni = ni + 1
.head 7 -  Call SalTblSetContext(hWndForm, 0)
.head 7 -  Call SalSendMsg( hWndForm, SAM_TblDoDetails, 0, 0)
.head 6 +  Else
.head 7 -  Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
.head 7 +  If nRow != TBL_Error
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 -  Call SalTblSetFocusRow(hWndForm, nRow)
.head 8 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 6 -  Call SalTblSetLockedColumns(hWndForm, 5)
.head 5 +  On SAM_TblDoDetails
.head 6 +  If colOp = ')'
.head 7 -  Set fIsBrackets = TRUE
.head 6 +  Else
.head 7 -  Set fIsBrackets = FALSE
.head 6 +  If colTagId >= 0 AND colTagId < F.cNewFilter.nTagNum
.head 7 +  If F.cNewFilter.Tag[colTagId].isForeignKey()
.head 8 -  Call SalEnableWindow(pbGetValue)
.head 7 +  Else
.head 8 -  Call SalDisableWindow(pbGetValue)
.head 6 +  Else
.head 7 -  Call SalDisableWindow(pbGetValue)
.head 6 -  !
.head 6 +  If colSign = 'ПУСТОЙ' OR colSign = 'НЕ ПУСТОЙ' OR colSign=''
.head 7 -  Set fIsNULLValue = TRUE
.head 6 +  Else
.head 7 -  Set fIsNULLValue = FALSE
.head 5 +  On SAM_EndCellTab
.head 6 -  Call SalSendMsg(pbInsert, SAM_Click, 0, 0)
.head 6 -  Call SalTblSetFocusCell(hWndForm, nRow, colOp, 0, 0)
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndForm)
.head 5 +  On UM_NoFontChange
.head 6 -  Return TRUE
.head 3 -  ! ***** = *****
.head 3 -  !
.head 3 +  Picture: picTabs
.data CLASSPROPS
0000: 546162546F704D61 7267696E00020030 0000546162466F72 6D50616765730003
0020: 0009090000546162 447261775374796C 65000B0057696E39 355374796C650000
0040: 546162426F74746F 6D4D617267696E00 0500302E34350000 5461625061676543
0060: 6F756E7400020031 00005461624C6162 656C73002400D1E8 F1F2E5ECEDFBE920
0080: 09CFEEEBFCE7EEE2 E0F2E5EBFCF1EAE8 E92009CDEEE2FBE9 2000005461624E61
00A0: 6D65730016005379 7354616709557365 72546167094E6577 5461670000546162
00C0: 52696768744D6172 67696E0002003000 0054616243757272 656E740007004E65
00E0: 7754616700005461 624C6566744D6172 67696E0002003000 005461624F726965
0100: 6E746174696F6E00 0100000000000000 0000000000000000 0000000000000000
0120: 0000
.enddata
.data CLASSPROPSSIZE
0000: 2201
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 1
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cQuickTabsDialog
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    0.031"
.head 5 -  Width:  10.8"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 3.4"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  File Name:
.head 4 -  Storage: Class Default
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Fit: Class Default
.head 4 -  Scaling
.head 5 -  Width:  Class Default
.head 5 -  Height:  Class Default
.head 4 -  Corners: Class Default
.head 4 -  Border Style: Class Default
.head 4 -  Border Thickness: Class Default
.head 4 -  Tile To Parent? No
.head 4 -  Border Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendClassMessage(SAM_Create, wParam, lParam)
.head 6 -  Call Tags.AttachWindow(picTabs)
.head 6 -  !
.head 6 -  Call picTabs.SetLabel(0, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTabs0'), TRUE)
.head 6 -  Call picTabs.SetLabel(1, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTabs1'), TRUE)
.head 6 -  Call picTabs.SetLabel(2, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTabs2'), TRUE)
.head 6 +  If NOT fPlainMode
.head 7 +  If NOT nSysFilterNum
.head 8 -  Call Tags.Enable(0, FALSE)
.head 8 -  Call Tags.SendMsgToAssociated(0, UM_ObjDeactivate, 0, 0)
.head 7 +  If NOT nUserFilterNum
.head 8 -  Call Tags.Enable(1, FALSE)
.head 8 -  Call Tags.SendMsgToAssociated(1, UM_ObjDeactivate, 0, 0)
.head 7 -  !
.head 7 +  If nSysFilterNum
.head 8 -  Call Tags.BringToTop(0, TRUE)
.head 8 -  Call Tags.SendMsgToAssociated(2, UM_ObjDeactivate, 0, 0)
.head 7 +  Else If nUserFilterNum
.head 8 -  Call Tags.BringToTop(1, TRUE)
.head 8 -  Call Tags.SendMsgToAssociated(2, UM_ObjDeactivate, 0, 0)
.head 7 +  Else
.head 8 -  Call Tags.BringToTop(2, TRUE)
.head 6 +  Else
.head 7 -  Call Tags.Delete(0, FALSE)
.head 7 -  Call Tags.Delete(0, TRUE)
.head 3 -  !
.head 3 +  Pushbutton: pbApply
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Применить
.head 4 -  Window Location and Size
.head 5 -  Left:   7.7"
.head 5 -  Top:    3.55"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\APPLY.BMP
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 +  If fPlainMode
.head 7 -  ! Сохранить
.head 7 -  Call SalSetWindowText(hWndItem, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipApply'))
.head 5 +  On SAM_Click
.head 6 -  Call SetSysFilter()
.head 6 -  Call SetUserFilter()
.head 6 -  !
.head 6 +  If not SetNewFilter()
.head 7 -  Return FALSE
.head 6 -  Set sTmp = F.GetFilterWhereClause(FALSE)
.head 6 +  If sTmp
.head 7 -  ! Задействован фильтр: F.GetFilterWhereClause(FALSE)
.head 7 -  Call SaveInfoToLog(CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTSetFilter') ||  ': ' || sTmp)
.head 6 +  Else
.head 7 -  ! Задействована нефильтрованная (полная) выборка
.head 7 -  Call SaveInfoToLog(CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTSetNotFilter'))
.head 6 -  Call SalEndDialog(hWndForm, 1)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отменить
.head 4 -  Window Location and Size
.head 5 -  Left:   9.3"
.head 5 -  Top:    3.55"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\DISCARD.BMP
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(hWndForm, 0)
.head 2 +  Functions
.head 3 +  Function: GetExtraValue
.head 4 -  Description: Получить значение из справочника
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: strTab
.head 5 -  String: strCol
.head 5 -  Receive String: strId
.head 5 -  Receive String: strSm
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: s1
.head 5 -  String: s2
.head 5 -  Boolean: fRet
.head 4 +  Actions
.head 5 -  Set fRet = SalModalDialog(dlg_GetValue, hWndForm, strTab, strCol, s1, s2)
.head 5 +  If fRet
.head 6 -  Set strId = s1
.head 6 -  Set strSm = s2
.head 5 -  Return fRet
.head 3 +  Function: SetSysFilter
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call tblFSystem.SetFilter()
.head 3 +  Function: SetUserFilter
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call tblFUser.SetFilter()
.head 3 +  Function: SetNewFilter
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Return tblFString.SetFilter()
.head 2 +  Window Parameters
.head 3 -  : F
.head 4 -  Class: cGenDFilter
.head 3 -  Boolean: fPlainMode
.head 2 +  Window Variables
.head 3 -  : FSys
.head 4 -  Class: cABSConnect
.head 3 -  : FUsr
.head 4 -  Class: cABSConnect
.head 3 -  !
.head 3 -  Number: nRow
.head 3 -  Boolean: fIsNULLValue ! флаг наличия оператора IS NULL
.head 3 -  Boolean: fIsBrackets  ! флаг наличия закрывающей скобки
.head 3 -  String: sKeyValue     ! хранилище для значения ключа
.head 3 -  String: sSemValue     ! хранилище для семантики
.head 3 -  String: sTabSemantic  ! семантическое название фильтруемой таблицы
.head 3 -  !
.head 3 -  : Tags
.head 4 -  Class: cSWTabs
.head 3 -  !
.head 3 -  Number: nUserId
.head 3 -  String: strNewFilterName
.head 3 -  Number: nSysFilterNum
.head 3 -  Number: nUserFilterNum
.head 3 -  !
.head 3 -  Window Handle: hWndFocusCol
.head 3 -  !
.head 3 -  String: sTmp
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTWndTitle'))
.head 4 -  !
.head 4 -  Call XConnectGetParams(FSys)
.head 4 -  Call FSys.Connect()
.head 4 -  Call FUsr.Clone(FSys, TRUE)
.head 4 -  !
.head 4 +  If SqlPrepareAndExecute(FUsr.hSql(), 'SELECT semantic INTO :sTabSemantic FROM meta_tables WHERE tabid=:F.nFTabId')
.head 5 +  If SqlFetchNext(FUsr.hSql(), nFetchRes)
.head 6 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTWndTitle') || ' [' || sTabSemantic || ']')
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  !
.head 4 -  Call XSalTooltipSetUserDefault()
.head 4 -  Set nUserId = GetUserId()
.head 3 +  On SAM_Destroy
.head 4 -  Call FSys.Disconnect()
.head 4 -  Call FUsr.Disconnect()
.head 1 +  Dialog Box: dlg_SetDFilterEx
.head 2 -  Class: cQuickTabsDialog
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Фильтр
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   0.5"
.head 4 -  Top:    0.5"
.head 4 -  Width:  11.0"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 4.4"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: MS Sans Serif
.head 3 -  Font Size: 8
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Показывает/создает/редактирует фильтр на таблицу
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
.head 3 -  ! ***** Системный фильтр *****
.head 3 +  Child Table: tblFSystem
.data CLASSPROPSSIZE
0000: 1A00
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 5379735461670000 0000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.15"
.head 6 -  Top:    0.35"
.head 6 -  Width:  10.65"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 3.0"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? No
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  View: Table
.head 5 -  Allow Row Sizing? No
.head 5 -  Lines Per Row: Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: 1000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colApply
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Использовать
фильтр
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Class Default
.head 6 -  Width:  1.4"
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Check Box
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value: 1
.head 8 -  Uncheck Value: 0
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colID
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
фильтра
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 5
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.2"
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
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 70
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  7.3"
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
.head 5 +  Column: colFromClause
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
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
.head 5 +  Column: colWhereClause
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 2000
.head 6 -  Data Type: Long String
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
.head 4 +  Functions
.head 5 +  Function: SetFilter
.head 6 -  Description:
.head 6 -  Returns
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 6 +  Actions
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 -  Call F.cSysFilter.setFilterInUse(colID, colApply)
.head 4 +  Window Variables
.head 5 -  Number: i
.head 5 -  Boolean: bSortOrd
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 6 -  Call SalTblSetTableFlags(hWndForm, TBL_Flag_SelectableCols, TRUE)
.head 6 +  If NOT fPlainMode
.head 7 -  Call SalTblReset(hWndForm)
.head 7 -  Set nSysFilterNum = F.cSysFilter.nFilterNum
.head 7 -  Set i = 0
.head 7 +  While i < nSysFilterNum
.head 8 -  Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
.head 8 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 -  Call F.cSysFilter.getFilterByIndex(i, colID, colName, colFromClause, colWhereClause, colApply)
.head 8 -  Set i = i + 1
.head 7 -  Call SalTblSetContext(hWndForm, 0)
.head 7 -  Call SalTblSetFocusRow(hWndForm, 0)
.head 5 +  On UM_NoFontChange
.head 6 -  Return TRUE
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndForm)
.head 5 +  On SAM_ColumnSelectClick
.head 6 -  Call SalTblSetColumnFlags(SalNumberToWindowHandle(wParam), COL_Selected, FALSE)
.head 6 -  Set bSortOrd = not bSortOrd
.head 6 -  Call SalTblSortRows(hWndForm, SalTblQueryColumnID(SalNumberToWindowHandle(wParam)), bSortOrd)
.head 3 -  ! ***** Пользовательский фильтр *****
.head 3 -  Frame
.data CLASSPROPSSIZE
0000: 1B00
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000800 5573657254616700 000000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Resource Id: 64694
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.186"
.head 5 -  Top:    0.344"
.head 5 -  Width:  1.057"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.396"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 3 +  Pushbutton: pbUDelete
.data CLASSPROPSSIZE
0000: 1B00
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000800 5573657254616700 000000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbDelete
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.286"
.head 5 -  Top:    0.385"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Удалить фильтр
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipUDelete')
.head 5 +  On SAM_Click
.head 6 -  Call tblFUser.DeleteFilter()
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Pushbutton: pbUSave
.data CLASSPROPSSIZE
0000: 1B00
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000800 5573657254616700 000000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbUpdate
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.714"
.head 5 -  Top:    0.385"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Сохранить измения в БД
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipUSave')
.head 5 +  On SAM_Click
.head 6 -  Call tblFUser.UpdateFilter()
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Pushbutton: pbShowCondition
.data CLASSPROPSSIZE
0000: 1900
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000800 5573657254616700 00
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbEdit
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.314"
.head 5 -  Top:    0.385"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Просмотреть значение фильтра...
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipShowCondition')
.head 5 +  On SAM_Click
.head 6 -  Set sTmp = tblFUser.colWhereClause
.head 6 +  If SalModalDialog(dlg_ShowFilter, hWndForm, FUsr.hSql(), tblFUser.colID, sTmp)
.head 7 +  If sTmp != tblFUser.colWhereClause
.head 8 -  Set tblFUser.colWhereClause = sTmp
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Child Table: tblFUser
.data CLASSPROPSSIZE
0000: 1900
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000800 5573657254616700 00
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.15"
.head 6 -  Top:    0.75"
.head 6 -  Width:  10.65"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 2.6"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? No
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  View: Table
.head 5 -  Allow Row Sizing? No
.head 5 -  Lines Per Row: Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: 2000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colApply
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Использовать
фильтр
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Class Default
.head 6 -  Width:  1.4"
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Check Box
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value: 1
.head 8 -  Uncheck Value: 0
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colID
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
фильтра
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 5
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.2"
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
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: 70
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  7.3"
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
.head 5 +  Column: colFromClause
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
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
.head 5 +  Column: colWhereClause
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 2000
.head 6 -  Data Type: Long String
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
.head 4 +  Functions
.head 5 +  Function: SetFilter
.head 6 -  Description:
.head 6 -  Returns
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 6 +  Actions
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 -  Call F.cUserFilter.setFilterInUse(colID, colApply)
.head 5 +  Function: DeleteFilter
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 6 +  Actions
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 +  If SqlPrepareAndExecute(FUsr.hSql(), "DELETE FROM dyn_filter WHERE filter_id = :colID")
.head 9 -  Call SqlCommit(FUsr.hSql())
.head 9 -  Call F.cUserFilter.delFilter(colID)
.head 8 +  Else
.head 9 -  Call SqlRollback(FUsr.hSql())
.head 9 -  Break
.head 7 -  Call F.cUserFilter.ReInit(F.nFTabId, nUserId)
.head 7 -  Call SalSendMsg(hWndForm, SAM_Create, 0, 0)
.head 7 +  If NOT nUserFilterNum
.head 8 -  Call Tags.Enable(1, FALSE)
.head 8 -  Call Tags.Next()
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Return TRUE
.head 5 +  Function: UpdateFilter
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 6 +  Actions
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, ROW_Edited, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 +  If SqlPrepareAndExecute(FUsr.hSql(), "UPDATE dyn_filter SET semantic = :tblFUser.colName WHERE filter_id = :colID")
.head 9 -  Call SqlCommit(FUsr.hSql())
.head 9 -  Call F.cUserFilter.setFilterName(colID, colName)
.head 8 +  Else
.head 9 -  Call SqlRollback(FUsr.hSql())
.head 7 -  Call F.cUserFilter.ReInit(F.nFTabId, nUserId)
.head 7 -  Call SalSendMsg(hWndForm, SAM_Create, 0, 0)
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Return TRUE
.head 4 +  Window Variables
.head 5 -  Number: i
.head 5 -  Boolean: bSortOrd
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 6 -  Call SalTblSetTableFlags(hWndForm, TBL_Flag_SelectableCols, TRUE)
.head 6 +  If NOT fPlainMode
.head 7 -  Call SalTblReset(hWndForm)
.head 7 -  Set nUserFilterNum = F.cUserFilter.nFilterNum
.head 7 -  Set i = 0
.head 7 +  While i < nUserFilterNum
.head 8 +  If not F.cUserFilter.cFilter[i].bDeleted
.head 9 -  Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
.head 9 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New | ROW_Edited, FALSE)
.head 9 -  Call SalTblSetContext(hWndForm, nRow)
.head 9 -  Call F.cUserFilter.getFilterByIndex(i, colID, colName, colFromClause, colWhereClause, colApply)
.head 8 -  Set i = i + 1
.head 7 -  Call SalTblSetContext(hWndForm, 0)
.head 7 -  Call SalTblSetFocusRow(hWndForm, 0)
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndForm)
.head 5 +  On UM_NoFontChange
.head 6 -  Return TRUE
.head 5 +  On SAM_ColumnSelectClick
.head 6 -  Call SalTblSetColumnFlags(SalNumberToWindowHandle(wParam), COL_Selected, FALSE)
.head 6 -  Set bSortOrd = not bSortOrd
.head 6 -  Call SalTblSortRows(hWndForm, SalTblQueryColumnID(SalNumberToWindowHandle(wParam)), bSortOrd)
.head 3 -  ! ***** Новый фильтр *****
.head 3 -  Frame
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Resource Id: 64695
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.186"
.head 5 -  Top:    0.344"
.head 5 -  Width:  1.057"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.396"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 3 +  Pushbutton: pbInsertBefore
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbInsert
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.183"
.head 5 -  Top:    0.381"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\C2.BMP
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Вставить строку фильтра
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipInsertBefore')
.head 5 +  On SAM_Click
.head 6 -  Call tblFString.InsertRowBefore()
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Pushbutton: pbInsert
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbInsert
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.617"
.head 5 -  Top:    0.381"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Insert.bmp
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Добавить строку фильтра
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipInsert')
.head 5 +  On SAM_Click
.head 6 -  Call tblFString.InsertRow()
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Pushbutton: pbDelete
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cTBarButton
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.05"
.head 5 -  Top:    0.381"
.head 5 -  Width:  0.43"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.317"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Delete.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Удалить строку фильтра
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipDelete')
.head 5 +  On SAM_Click
.head 6 -  Call tblFString.DeleteRow()
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow( hWndItem )
.head 3 +  Pushbutton: pbDeleteAll
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbDelete
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.483"
.head 5 -  Top:    0.381"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Удалить все строки фильтра
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipDeleteAll')
.head 5 +  On SAM_Click
.head 6 -  Call SalTblReset(tblFString)
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 -  Frame
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Resource Id: 64696
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.7"
.head 5 -  Top:    0.344"
.head 5 -  Width:  0.686"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.396"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 3 +  Pushbutton: pbGetValue
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbDetail
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.15"
.head 5 -  Top:    0.381"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalDisableWindow(hWndItem)
.head 6 -  ! Выбрать значение из возможных
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipGetValue')
.head 5 +  On SAM_Click
.head 6 +  If tblFString.colTagId != -1
.head 7 +  If F.cNewFilter.Tag[tblFString.colTagId].isForeignKey() 
.head 8 +  If GetExtraValue( F.cNewFilter.Tag[tblFString.colTagId].S.sSTabName,
                  F.cNewFilter.Tag[tblFString.colTagId].S.sSSemantic,
                  sKeyValue, sSemValue ) != -1
.head 9 -  Set tblFString.colValue    = sKeyValue
.head 9 -  Set tblFString.colSemantic = sSemValue
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow( hWndItem )
.head 3 +  Pushbutton: pbGetFormula
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cTBarButton
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.583"
.head 5 -  Top:    0.381"
.head 5 -  Width:  0.43"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.317"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Formula.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalDisableWindow(hWndItem)
.head 6 -  ! Выбрать формулу из возможных
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipGetFormula')
.head 5 -  On SAM_Click
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 -  Frame
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Resource Id: 64697
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.743"
.head 5 -  Top:    0.344"
.head 5 -  Width:  1.114"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.396"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 3 +  Pushbutton: pbCheck
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cTBarButton
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.2"
.head 5 -  Top:    0.381"
.head 5 -  Width:  0.43"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.317"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Chekin.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Проверить синтаксис сформированого фильтра
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipCheck')
.head 5 +  On SAM_Click
.head 6 -  Call tblFString.CheckFilter()
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Pushbutton: pbSave
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbUpdate
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.633"
.head 5 -  Top:    0.381"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 +  If fPlainMode
.head 7 -  Call SalDisableWindow(hWndItem)
.head 6 -  ! Сохранить сформированый фильтр в БД
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipSave')
.head 5 +  On SAM_Click
.head 6 +  If tblFString.CheckFilter()
.head 7 +  If SalModalDialog(dlg_GetFilterName, hWndForm, strNewFilterName)
.head 8 -  Call SalWaitCursor(TRUE)
.head 8 +  If SalTblAnyRows(tblFString, 0, 0)
.head 9 -  Call tblFString.SetFilter()
.head 9 +  If NOT F.cNewFilter.isFilterEmpty()
.head 10 -  Call F.SaveFilterDB(nUserId, strNewFilterName)
.head 10 -  Call SalSendMsg(tblFUser, SAM_Create, 0, 0)
.head 10 +  If nUserFilterNum AND NOT Tags.IsEnabled(1)
.head 11 -  Call Tags.Enable(1, TRUE)
.head 9 -  Set F.cNewFilter.nStrNum = 0
.head 9 -  Call SalTblReset(tblFString)
.head 8 -  Call SalWaitCursor(FALSE)
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndItem)
.head 3 +  Child Table: tblFString
.data CLASSPROPSSIZE
0000: 1800
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000700 4E65775461670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.15"
.head 6 -  Top:    0.75"
.head 6 -  Width:  10.65"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 2.6"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? No
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
.head 5 +  Column: colOp
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: И/ИЛИ
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.757"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? No
.head 8 -  Vertical Scroll? No
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? No
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 +  List Values
.head 7 -  Text: И
.head 7 -  Text: ИЛИ
.head 7 -  Text: (
.head 7 -  Text: )
.head 7 -  Text:
.head 6 +  Message Actions
.head 7 +  On SAM_Validate
.head 8 +  If colOp = ')'
.head 9 -  Set colTagId = -1
.head 9 -  Set colTag = ''
.head 9 -  Set colSign = ''
.head 9 -  Set colValue = ''
.head 9 -  Set colSemantic = ''
.head 9 -  Set fIsBrackets = TRUE
.head 8 +  Else
.head 9 -  Set fIsBrackets = FALSE
.head 5 +  Column: colTagId
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
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
.head 5 +  Column: colTag
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Атрибут
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  2.886"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? No
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? No
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 +  Message Actions
.head 7 +  On SAM_Create
.head 8 +  If NOT F.cNewFilter.isTagListEmpty()
.head 9 -  Set ni = 0
.head 9 +  While ni < F.cNewFilter.nTagNum
.head 10 -  Call SalListAdd(hWndItem, F.cNewFilter.Tag[ni].sTagName)
.head 10 -  Set ni = ni + 1
.head 9 -  Call SalListAdd(hWndItem, '')
.head 7 +  On SAM_Validate
.head 8 +  If colTag != ''
.head 9 +  If NOT F.cNewFilter.isTagListEmpty()
.head 10 +  If colTagId != F.cNewFilter.GetTagByName(colTag)
.head 11 -  Set colTagId = F.cNewFilter.GetTagByName(colTag)
.head 11 +  If colTagId >= 0  and colTagId < F.cNewFilter.nTagNum
.head 12 -  Set colTag = F.cNewFilter.Tag[colTagId].sTagName
.head 12 -  Set colTagType = F.cNewFilter.Tag[colTagId].sTagType
.head 12 -  !
.head 12 -  Call SalSendMsg(colSign, SAM_Validate, 0, 0)
.head 12 -  ! Set fIsNULLValue = TRUE
.head 12 -  ! Set colValue = ''
.head 12 -  ! Set colSemantic = ''
.head 12 -  !
.head 12 +  If F.cNewFilter.Tag[colTagId].isForeignKey()
.head 13 -  Call SalEnableWindow(pbGetValue)
.head 12 +  Else
.head 13 -  Call SalDisableWindow(pbGetValue)
.head 8 +  Else
.head 9 -  Set colTagId = -1
.head 9 -  Set colSign = ''
.head 9 -  Set colValue = ''
.head 9 -  Set colSemantic = ''
.head 9 -  Call SalDisableWindow(pbGetValue)
.head 8 -  Return VALIDATE_Ok
.head 5 +  Column: colTagType
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: TagType
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
.head 5 +  Column: colSign
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Оператор
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.471"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? No
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? No
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 +  List Values
.head 7 -  Text: =
.head 7 -  Text: <
.head 7 -  Text: <=
.head 7 -  Text: >
.head 7 -  Text: >=
.head 7 -  Text: <>
.head 7 -  Text: ПОХОЖ
.head 7 -  Text: НЕ ПОХОЖ
.head 7 -  Text: ПУСТОЙ
.head 7 -  Text: НЕ ПУСТОЙ
.head 7 -  Text: ОДИН ИЗ
.head 7 -  Text: НЕ ОДИН ИЗ
.head 7 -  Text:
.head 6 +  Message Actions
.head 7 +  On SAM_Validate
.head 8 +  If colSign = 'ПУСТОЙ' OR colSign = 'НЕ ПУСТОЙ' OR colSign = ''
.head 9 -  Set fIsNULLValue = TRUE
.head 9 -  Set colValue = ''
.head 9 -  Set colSemantic = ''
.head 8 +  Else
.head 9 -  Set fIsNULLValue = FALSE
.head 8 +  If SalSendMsg(colValue, SAM_Validate, 0, 0)
.head 9 -  Return VALIDATE_Ok
.head 8 +  Else
.head 9 -  Return VALIDATE_Cancel
.head 5 +  Column: colValue
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Значение
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: 200
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.743"
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
.head 6 +  Message Actions
.head 7 +  On SAM_AnyEdit
.head 8 -  Call SalClearField(colSemantic)
.head 8 +  If fIsNULLValue or fIsBrackets
.head 9 -  Call SalClearField(hWndItem)
.head 7 +  On SAM_Validate
.head 8 +  If MyValue = STRING_Null
.head 9 -  Return VALIDATE_Ok
.head 8 +  If SalStrLeftX( MyValue, 1) = '@'
.head 9 -  Return VALIDATE_Ok
.head 8 +  If colTagType = 'N' AND NOT SalStrIsValidNumber(MyValue)
.head 9 +  If colSign = 'ОДИН ИЗ' OR colSign = 'НЕ ОДИН ИЗ'
.head 10 +  If NOT CheckListOfNumber(colValue)
.head 11 -  Call SalMessageBeep(MB_IconStop)
.head 11 -  ! Неверный список значений для этого атрибута!
.head 11 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErrList'),
     CurrentLangTable.GetAtomTitle('cTErr'), MB_IconStop | MB_Ok)
.head 11 -  Return VALIDATE_Cancel
.head 9 +  Else
.head 10 +  If SalStrUpperX(F.cNewFilter.Tag[colTagId].sQueryCol) = 'KV' AND
SalStrScan(colValue, ',') = -1
.head 11 -  Set strKv = ''
.head 11 +  If SqlPrepareAndExecute(hSql(), 'SELECT kv INTO :strKv FROM tabval WHERE lcv = :colValue')
.head 12 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 12 -  Set MyValue = strKv
.head 12 -  Return VALIDATE_Ok
.head 10 +  Else
.head 11 -  Call SalMessageBeep(MB_IconStop)
.head 11 -  ! Недопустимый тип данных для этого атрибута!
.head 11 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErrType'),
     CurrentLangTable.GetAtomTitle('cTErr'), MB_IconStop | MB_Ok)
.head 11 -  Return VALIDATE_Cancel
.head 8 -  Return VALIDATE_Ok
.head 5 +  Column: colSemantic
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Семантика значения
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  4.414"
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
.head 5 +  Function: CheckFilter
.head 6 -  Description: Проверить синтаксис фильтра
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nParanteses
.head 7 -  Number: nLastState
.head 7 -  Number: nCurrState
.head 7 -  Boolean: fIsError
.head 7 -  String: sError
.head 6 +  Actions
.head 7 -  ! let's remove blank strings
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 +  If colTagId = NUMBER_Null AND colOp = ''
.head 9 -  Call SalTblDeleteRow(hWndForm, nRow, TBL_Adjust)
.head 7 -  !
.head 7 -  Set nRow = TBL_MinRow
.head 7 -  Set nParanteses = 0
.head 7 -  Set nLastState = FLTR_START
.head 7 -  Set nCurrState = FLTR_START
.head 7 -  Set fIsError = FALSE
.head 7 +  While NOT fIsError AND SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 +  If colOp = '('
.head 9 -  Set nParanteses = nParanteses + 1
.head 8 +  If colOp = ')'
.head 9 -  Set nParanteses = nParanteses - 1
.head 8 -  !
.head 8 +  If colOp != ''
.head 9 +  If colOp = '('
.head 10 -  Set nCurrState = FLTR_LPARANT
.head 9 +  Else If colOp = ')'
.head 10 -  Set nCurrState = FLTR_RPARANT
.head 9 +  Else
.head 10 -  Set nCurrState = FLTR_OPERATOR
.head 9 -  !
.head 9 -  Set fIsError = CheckAllowence(nLastState, nCurrState, sError)
.head 9 -  Set nLastState = nCurrState
.head 8 +  If NOT fIsError
.head 9 +  If colTag != ''
.head 10 -  Set nCurrState = FLTR_ATOM
.head 10 -  !
.head 10 -  Set fIsError = CheckAllowence(nLastState, nCurrState, sError)
.head 10 -  Set nLastState = nCurrState
.head 9 +  If NOT fIsError
.head 10 +  If colSign != ''
.head 11 +  If SalStrTrimX(colSign) = 'ПУСТОЙ' OR
   SalStrTrimX(colSign) = 'НЕ ПУСТОЙ'
.head 12 -  Set nCurrState = FLTR_ISNULLOP
.head 11 +  Else
.head 12 -  Set nCurrState = FLTR_SIGN
.head 11 -  !
.head 11 -  Set fIsError = CheckAllowence(nLastState, nCurrState, sError)
.head 11 -  Set nLastState = nCurrState
.head 10 +  If NOT fIsError
.head 11 +  If colValue != ''
.head 12 -  Set nCurrState = FLTR_ATOM
.head 12 -  !
.head 12 -  Set fIsError = CheckAllowence(nLastState, nCurrState, sError)
.head 12 -  Set nLastState = nCurrState
.head 7 +  If NOT fIsError
.head 8 -  Set fIsError = CheckAllowence(nLastState, FLTR_STOP, sError)
.head 7 +  If NOT fIsError AND nParanteses != 0
.head 8 +  If nParanteses > 0
.head 9 -  ! Пропущена ЗАКРЫВАЮЩАЯ скобка
.head 9 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr8')
.head 8 +  Else
.head 9 -  ! Пропущена ОТКРЫВАЮЩАЯ скобка
.head 9 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr9')
.head 8 -  Set fIsError = TRUE
.head 7 +  If fIsError
.head 8 -  Call SalMessageBeep(MB_IconStop)
.head 8 -  ! sError, Синтаксическая ошибка
.head 8 -  Call SalMessageBox(sError, CurrentLangTable.GetAtomTitle('cTSyntaxErr'), MB_Ok)
.head 8 -  Call SalTblSetFocusRow(hWndForm, nRow)
.head 7 -  Return NOT fIsError
.head 5 +  Function: CheckAllowence
.head 6 -  Description: Проверяет допустимость последовательности атомов
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: nPrev
.head 7 -  Number: nNext
.head 7 -  Receive String: sError
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Boolean: fRet
.head 6 +  Actions
.head 7 -  Set sError = ''
.head 7 -  Set fRet = FALSE
.head 7 +  If nPrev = FLTR_SIGN     AND nNext != FLTR_ATOM
.head 8 -  Set fRet = TRUE
.head 8 -  ! Недопустимое выражение после оператора сравнения
.head 8 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr1')
.head 7 +  If nPrev = FLTR_ISNULLOP AND nNext != FLTR_OPERATOR AND nNext != FLTR_SIGN AND nNext != FLTR_RPARANT AND nNext != FLTR_STOP
.head 8 -  Set fRet = TRUE
.head 8 -  ! Недопустимое выражение после оператора IS NULL/IS NOT NULL
.head 8 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr2')
.head 7 +  If nPrev = FLTR_OPERATOR AND nNext != FLTR_ATOM AND nNext != FLTR_LPARANT
.head 8 -  Set fRet = TRUE
.head 8 -  ! Недопустимое выражение после логического оператора
.head 8 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr3')
.head 7 +  If nPrev = FLTR_START    AND nNext != FLTR_ATOM AND nNext != FLTR_LPARANT AND nNext != FLTR_STOP
.head 8 -  Set fRet = TRUE
.head 8 -  ! Недопустимое начало логического выражения фильтра
.head 8 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr4')
.head 7 +  If nPrev = FLTR_LPARANT  AND nNext != FLTR_ATOM AND nNext != FLTR_LPARANT
.head 8 -  Set fRet = TRUE
.head 8 -  ! Недопустимое выражение после открывающей скобки
.head 8 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr5')
.head 7 +  If nPrev = FLTR_RPARANT  AND nNext != FLTR_OPERATOR AND nNext != FLTR_ISNULLOP AND nNext != FLTR_RPARANT AND nNext != FLTR_STOP
.head 8 -  Set fRet = TRUE
.head 8 -  ! Недопустимое выражение после закрывающей скобки
.head 8 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr6')
.head 7 +  If nPrev = FLTR_ATOM     AND nNext != FLTR_OPERATOR AND nNext != FLTR_ISNULLOP AND nNext != FLTR_SIGN    AND nNext != FLTR_RPARANT AND nNext != FLTR_STOP
.head 8 -  Set fRet = TRUE
.head 8 -  ! Недопустимое выражение после атрибута или значения
.head 8 -  Set sError = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErr7')
.head 7 -  !
.head 7 -  Return fRet
.head 5 +  Function: CheckListOfNumber
.head 6 -  Description: Проверить строчных список числовых значений
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: strValList
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: strVal[*]
.head 7 -  Number: nVals
.head 7 -  Number: nIterator
.head 7 -  Boolean: fError
.head 6 +  Actions
.head 7 +  If NOT strValList
.head 8 -  Return FALSE
.head 7 +  If SalStrScan(SalStrUpperX(strValList), 'SELECT') >= 0
.head 8 -  Return TRUE
.head 7 -  Set nVals = SalStrTokenize(strValList, '', ',', strVal)
.head 7 +  If NOT nVals
.head 8 -  Return FALSE
.head 7 -  Set nIterator = 0
.head 7 -  Set fError = FALSE
.head 7 +  While (nIterator < nVals AND NOT fError)
.head 8 +  If NOT SalStrIsValidNumber(strVal[nIterator])
.head 9 -  Set fError = TRUE
.head 8 -  Set nIterator = nIterator + 1
.head 7 -  Return NOT fError
.head 5 +  Function: SetFilter
.head 6 -  Description: Запомнить фильтр в структуру
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 6 +  Actions
.head 7 +  If not CheckFilter()
.head 8 -  Return FALSE
.head 7 -  !
.head 7 -  Set F.cNewFilter.nStrNum = 0
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 +  If colTagId >= 0 AND colTagId < F.cNewFilter.nTagNum
.head 9 -  Call F.cNewFilter.NewString(F.TranslateLOper(colOp, FALSE), -1,
     F.cNewFilter.Tag[colTagId].sQueryCol, -1, F.cNewFilter.Tag[colTagId].sQueryTab,
     F.TranslateLSign(colSign, FALSE), colValue, colSemantic)
.head 8 +  Else
.head 9 -  Call F.cNewFilter.NewString(F.TranslateLOper(colOp, FALSE), -1, '', -1, '',
     F.TranslateLSign(colSign, FALSE), colValue, colSemantic)
.head 7 -  !
.head 7 -  Return TRUE
.head 5 +  Function: InsertRowBefore
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set nRow = SalTblQueryContext(hWndForm)
.head 7 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_Selected, FALSE)
.head 7 -  Set nRow = SalTblInsertRow(hWndForm, nRow)
.head 7 +  If nRow != TBL_Error
.head 8 -  Call SalSetFocus(hWndForm)
.head 8 -  Call SalTblSetFocusRow(hWndForm, nRow)
.head 8 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_Selected, TRUE)
.head 8 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 7 -  Return TRUE
.head 5 +  Function: InsertRow
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Selected, FALSE)
.head 7 -  Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
.head 7 +  If nRow != TBL_Error
.head 8 -  Call SalSetFocus(hWndForm)
.head 8 -  Call SalTblSetFocusRow(hWndForm, nRow)
.head 8 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 7 -  Return TRUE
.head 5 +  Function: DeleteRow
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblDeleteRow(hWndForm, nRow, TBL_Adjust)
.head 7 -  Return TRUE
.head 4 +  Window Variables
.head 5 -  Number: ni
.head 5 -  String: strKv
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 6 +  If NOT F.cNewFilter.isFilterEmpty()
.head 7 -  Set ni = 0
.head 7 +  While ni < F.cNewFilter.nStrNum
.head 8 -  Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
.head 8 +  If nRow != TBL_Error
.head 9 -  Call SalTblSetContext(hWndForm, nRow)
.head 9 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 9 -  Set colOp = F.TranslateLOper(F.cNewFilter.FStr[ni].sLOper, TRUE)
.head 9 -  Set colTagId = F.cNewFilter.GetTagByKey(F.cNewFilter.FStr[ni].sColName,F.cNewFilter.FStr[ni].sRTabName)
.head 9 +  If colTagId >= 0  and colTagId < F.cNewFilter.nTagNum
.head 10 -  Set colTag = F.cNewFilter.Tag[colTagId].sTagName
.head 10 -  Set colTagType = F.cNewFilter.Tag[colTagId].sTagType
.head 9 -  Set colSign = F.TranslateLSign(F.cNewFilter.FStr[ni].sLSign, TRUE)
.head 9 -  Set colValue = F.cNewFilter.FStr[ni].sValue
.head 9 -  Set colSemantic = F.cNewFilter.FStr[ni].sSemantic
.head 9 -  Set ni = ni + 1
.head 7 -  Call SalTblSetContext(hWndForm, 0)
.head 7 -  Call SalSendMsg( hWndForm, SAM_TblDoDetails, 0, 0)
.head 6 +  Else
.head 7 -  Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
.head 7 +  If nRow != TBL_Error
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 -  Call SalTblSetFocusRow(hWndForm, nRow)
.head 8 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 6 -  Call SalTblSetLockedColumns(hWndForm, 5)
.head 5 +  On SAM_TblDoDetails
.head 6 +  If colOp = ')'
.head 7 -  Set fIsBrackets = TRUE
.head 6 +  Else
.head 7 -  Set fIsBrackets = FALSE
.head 6 +  If colTagId >= 0 AND colTagId < F.cNewFilter.nTagNum
.head 7 +  If F.cNewFilter.Tag[colTagId].isForeignKey()
.head 8 -  Call SalEnableWindow(pbGetValue)
.head 7 +  Else
.head 8 -  Call SalDisableWindow(pbGetValue)
.head 6 +  Else
.head 7 -  Call SalDisableWindow(pbGetValue)
.head 6 -  !
.head 6 +  If colSign = 'ПУСТОЙ' OR colSign = 'НЕ ПУСТОЙ' OR colSign=''
.head 7 -  Set fIsNULLValue = TRUE
.head 6 +  Else
.head 7 -  Set fIsNULLValue = FALSE
.head 5 +  On SAM_EndCellTab
.head 6 -  Call SalSendMsg(pbInsert, SAM_Click, 0, 0)
.head 6 -  Call SalTblSetFocusCell(hWndForm, nRow, colOp, 0, 0)
.head 5 +  On UM_ObjDeactivate
.head 6 -  Call SalHideWindow(hWndForm)
.head 5 +  On UM_NoFontChange
.head 6 -  Return TRUE
.head 3 -  ! ***** Простой фильтр *****
.head 3 +  Pushbutton: pbRefresh
.data CLASSPROPSSIZE
0000: 1B00
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000A00 53696D706C655461 670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbRefresh
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.183"
.head 5 -  Top:    0.381"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Yes
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
.head 5 +  On SAM_Create
.head 6 -  ! Очистить
.head 6 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipRefresh')
.head 5 +  On SAM_Click
.head 6 -  Call tblFSimple.ClearFilter()
.head 3 +  Child Table: tblFSimple
.data CLASSPROPSSIZE
0000: 1B00
.enddata
.data CLASSPROPS
0000: 5461624368696C64 4E616D6573000A00 53696D706C655461 670000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.15"
.head 6 -  Top:    0.75"
.head 6 -  Width:  10.65"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 2.6"
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
.head 5 +  Column: colTagId
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
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
.head 5 +  Column: colTag
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Атрибут
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  2.886"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? No
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? No
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 +  Message Actions
.head 7 +  ! On SAM_Create
.head 8 +  If NOT F.cSimpleFilter.isTagListEmpty()
.head 9 -  Set ni = 0
.head 9 +  While ni < F.cSimpleFilter.nTagNum
.head 10 -  Call SalListAdd(hWndItem, F.cSimpleFilter.Tag[ni].sTagName)
.head 10 -  Set ni = ni + 1
.head 9 -  Call SalListAdd(hWndItem, '')
.head 7 +  ! On SAM_Validate
.head 8 +  If colTag != ''
.head 9 +  If NOT F.cSimpleFilter.isTagListEmpty()
.head 10 +  If colTagId != F.cSimpleFilter.GetTagByName(colTag)
.head 11 -  Set colTagId = F.cSimpleFilter.GetTagByName(colTag)
.head 11 +  If colTagId >= 0  and colTagId < F.cSimpleFilter.nTagNum
.head 12 -  Set colTag = F.cSimpleFilter.Tag[colTagId].sTagName
.head 12 -  Set colTagType = F.cSimpleFilter.Tag[colTagId].sTagType
.head 8 +  Else 
.head 9 -  Set colTagId = -1
.head 9 -  Set colValue = ''
.head 8 -  Return VALIDATE_Ok
.head 5 +  Column: colTagType
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: TagType
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
.head 5 +  Column: colValue
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Значение
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: 200
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.743"
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
.head 6 +  Message Actions
.head 7 +  On SAM_Validate
.head 8 +  If MyValue = STRING_Null
.head 9 -  Return VALIDATE_Ok
.head 8 +  If SalStrLeftX(MyValue, 1) = '@'
.head 9 -  Return VALIDATE_Ok
.head 8 +  If colTagType = 'N'
.head 9 +  If SalStrScan(MyValue, ',') = -1
.head 10 +  If NOT SalStrIsValidNumber(MyValue)
.head 11 -  Call SalMessageBeep(MB_IconStop)
.head 11 -  ! Недопустимый тип данных для этого атрибута!
.head 11 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTErrType'),
     CurrentLangTable.GetAtomTitle('cTErr'), MB_IconStop | MB_Ok)
.head 11 -  Return VALIDATE_Cancel
.head 8 -  Return VALIDATE_Ok
.head 4 +  Functions
.head 5 +  Function: SetFilter
.head 6 -  Description: Запомнить фильтр в структуру
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 6 +  Actions
.head 7 -  Set F.cSimpleFilter.nStrNum = 0
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 -  Call F.cSimpleFilter.NewString(F.cSimpleFilter.Tag[colTagId].sQueryCol, colValue)
.head 7 -  !
.head 7 -  Return TRUE
.head 5 +  Function: ClearFilter
.head 6 -  Description: Очистить фильтр
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 6 +  Actions
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 -  Set colValue = ''
.head 7 -  !
.head 7 -  Return TRUE
.head 4 +  Window Variables
.head 5 -  Number: ni
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 6 +  If NOT F.cSimpleFilter.isTagListEmpty()
.head 7 -  Set ni = 0
.head 7 +  While ni < F.cSimpleFilter.nTagNum
.head 8 -  Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
.head 8 +  If nRow != TBL_Error
.head 9 -  Call SalTblSetContext(hWndForm, nRow)
.head 9 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 9 -  Set colTagId   = ni
.head 9 -  Set colTag     = F.cSimpleFilter.Tag[ni].sTagName
.head 9 -  Set colTagType = F.cSimpleFilter.Tag[ni].sTagType
.head 9 -  Set colValue   = F.cSimpleFilter.GetValueByColName(F.cSimpleFilter.Tag[ni].sQueryCol)
.head 9 -  Set ni = ni + 1
.head 6 -  Call SalTblSetContext(hWndForm, 0)
.head 6 -  Call SalTblSetFocusCell(hWndForm, 0, colValue, 0, 0)
.head 3 -  ! ***** = *****
.head 3 -  !
.head 3 +  Picture: picTabs
.data CLASSPROPS
0000: 5461624F7269656E 746174696F6E0001 0000005461624C65 66744D617267696E
0020: 0002003000005461 6243757272656E74 000A0053696D706C 6554616700005461
0040: 6252696768744D61 7267696E00020030 00005461624E616D 6573002000537973
0060: 5461670955736572 546167094E657754 61670953696D706C 6554616700005461
0080: 624C6162656C7300 2C00D1E8F1F2E5EC EDFBE92009CFEEEB FCE7EEE2E0F2E5EB
00A0: FCF1EAE8E92009CD EEE2FBE92009CFF0 EEF1F2EEE9000054 616250616765436F
00C0: 756E740002003100 00546162426F7474 6F6D4D617267696E 000500302E343500
00E0: 0054616244726177 5374796C65000B00 57696E3935537479 6C65000054616246
0100: 6F726D5061676573 0004000909090000 546162546F704D61 7267696E00020030
0120: 0000000000000000 0000000000000000 0000000000000000
.enddata
.data CLASSPROPSSIZE
0000: 3801
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 1
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cQuickTabsDialog
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    0.031"
.head 5 -  Width:  10.8"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 3.4"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  File Name:
.head 4 -  Storage: Class Default
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Fit: Class Default
.head 4 -  Scaling
.head 5 -  Width:  Class Default
.head 5 -  Height:  Class Default
.head 4 -  Corners: Class Default
.head 4 -  Border Style: Class Default
.head 4 -  Border Thickness: Class Default
.head 4 -  Tile To Parent? No
.head 4 -  Border Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendClassMessage(SAM_Create, wParam, lParam)
.head 6 -  Call Tags.AttachWindow(picTabs)
.head 6 -  !
.head 6 -  Call picTabs.SetLabel(0, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTabs0'), TRUE)
.head 6 -  Call picTabs.SetLabel(1, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTabs1'), TRUE)
.head 6 -  Call picTabs.SetLabel(2, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTabs2'), TRUE)
.head 6 -  Call picTabs.SetLabel(3, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTabs3'), TRUE)
.head 6 +  If NOT fPlainMode
.head 7 +  If NOT nSysFilterNum
.head 8 -  Call Tags.Enable(0, FALSE)
.head 8 -  Call Tags.SendMsgToAssociated(0, UM_ObjDeactivate, 0, 0)
.head 7 +  If NOT nUserFilterNum
.head 8 -  Call Tags.Enable(1, FALSE)
.head 8 -  Call Tags.SendMsgToAssociated(1, UM_ObjDeactivate, 0, 0)
.head 7 -  !
.head 7 +  If F.cSimpleFilter.nTagNum
.head 8 -  Call Tags.BringToTop(3, TRUE)
.head 8 -  Call SalSetFocus(tblFSimple)
.head 8 -  Call SalTblSetFocusRow(tblFSimple, 0)
.head 8 -  Call SalTblSetFocusCell(tblFSimple, 0, tblFSimple.colValue, 0, 0)
.head 7 +  Else
.head 8 -  Call Tags.Delete(3, FALSE)
.head 8 -  Call SalHideWindow(pbRefresh)
.head 8 -  Call SalHideWindow(tblFSimple)
.head 8 +  If nSysFilterNum
.head 9 -  Call Tags.BringToTop(0, TRUE)
.head 9 -  Call Tags.SendMsgToAssociated(2, UM_ObjDeactivate, 0, 0)
.head 8 +  Else If nUserFilterNum
.head 9 -  Call Tags.BringToTop(1, TRUE)
.head 9 -  Call Tags.SendMsgToAssociated(2, UM_ObjDeactivate, 0, 0)
.head 8 +  Else
.head 9 -  Call Tags.BringToTop(2, TRUE)
.head 6 +  Else
.head 7 -  Call Tags.Delete(0, FALSE)
.head 7 -  Call Tags.Delete(0, TRUE)
.head 7 -  Call Tags.Delete(1, FALSE)
.head 3 -  !
.head 3 +  Pushbutton: pbApply
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Применить
.head 4 -  Window Location and Size
.head 5 -  Left:   7.7"
.head 5 -  Top:    3.55"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\APPLY.BMP
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 +  If fPlainMode
.head 7 -  ! Сохранить
.head 7 -  Call SalSetWindowText(hWndItem, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cBTipApply'))
.head 5 +  On SAM_Click
.head 6 -  Call SetSysFilter()
.head 6 -  Call SetUserFilter()
.head 6 -  !
.head 6 +  If not SetNewFilter()
.head 7 -  Return FALSE
.head 6 -  Call SetSimpleFilter()
.head 6 -  Set sTmp = F.GetFilterWhereClause(FALSE)
.head 6 +  If sTmp
.head 7 -  ! Задействован фильтр: F.GetFilterWhereClause(FALSE)
.head 7 -  Call SaveInfoToLog(CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTSetFilter') ||  ': ' || sTmp)
.head 6 +  Else
.head 7 -  ! Задействована нефильтрованная (полная) выборка
.head 7 -  Call SaveInfoToLog(CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTSetNotFilter'))
.head 6 -  Call SalEndDialog(hWndForm, 1)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отменить
.head 4 -  Window Location and Size
.head 5 -  Left:   9.3"
.head 5 -  Top:    3.55"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\DISCARD.BMP
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(hWndForm, 0)
.head 2 +  Functions
.head 3 +  Function: GetExtraValue
.head 4 -  Description: Получить значение из справочника
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: strTab
.head 5 -  String: strCol
.head 5 -  Receive String: strId
.head 5 -  Receive String: strSm
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: s1
.head 5 -  String: s2
.head 5 -  Boolean: fRet
.head 4 +  Actions
.head 5 -  Set fRet = SalModalDialog(dlg_GetValue, hWndForm, strTab, strCol, s1, s2)
.head 5 +  If fRet
.head 6 -  Set strId = s1
.head 6 -  Set strSm = s2
.head 5 -  Return fRet
.head 3 +  Function: SetSysFilter
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call tblFSystem.SetFilter()
.head 3 +  Function: SetUserFilter
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call tblFUser.SetFilter()
.head 3 +  Function: SetNewFilter
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Return tblFString.SetFilter()
.head 3 +  Function: SetSimpleFilter
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Return tblFSimple.SetFilter()
.head 2 +  Window Parameters
.head 3 -  : F
.head 4 -  Class: cGenDFilterEx
.head 3 -  Boolean: fPlainMode
.head 2 +  Window Variables
.head 3 -  : FSys
.head 4 -  Class: cABSConnect
.head 3 -  : FUsr
.head 4 -  Class: cABSConnect
.head 3 -  !
.head 3 -  Number: nRow
.head 3 -  Boolean: fIsNULLValue ! флаг наличия оператора IS NULL
.head 3 -  Boolean: fIsBrackets  ! флаг наличия закрывающей скобки
.head 3 -  String: sKeyValue     ! хранилище для значения ключа
.head 3 -  String: sSemValue     ! хранилище для семантики
.head 3 -  String: sTabSemantic  ! семантическое название фильтруемой таблицы
.head 3 -  !
.head 3 -  : Tags
.head 4 -  Class: cSWTabs
.head 3 -  !
.head 3 -  Number: nUserId
.head 3 -  String: strNewFilterName
.head 3 -  Number: nSysFilterNum
.head 3 -  Number: nUserFilterNum
.head 3 -  !
.head 3 -  Window Handle: hWndFocusCol
.head 3 -  !
.head 3 -  String: sTmp
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTWndTitle'))
.head 4 -  !
.head 4 -  Call XConnectGetParams(FSys)
.head 4 -  Call FSys.Connect()
.head 4 -  Call FUsr.Clone(FSys, TRUE)
.head 4 -  !
.head 4 +  If SqlPrepareAndExecute(FUsr.hSql(), 'SELECT semantic INTO :sTabSemantic FROM meta_tables WHERE tabid=:F.nFTabId')
.head 5 +  If SqlFetchNext(FUsr.hSql(), nFetchRes)
.head 6 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('dlg_SetFilter.cTWndTitle') || ' [' || sTabSemantic || ']')
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  !
.head 4 -  Call XSalTooltipSetUserDefault()
.head 4 -  Set nUserId = GetUserId()
.head 3 +  On SAM_Destroy
.head 4 -  Call FSys.Disconnect()
.head 4 -  Call FUsr.Disconnect()
.head 1 +  Dialog Box: dlg_GetValue
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title:
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? No
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  7.5"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.2"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: MS Sans Serif
.head 3 -  Font Size: 8
.head 3 -  Font Enhancement: None
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Получить значение из таблицы
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.4"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Contents
.head 4 +  Pushbutton: pbFind
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbSearch
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.08"
.head 6 -  Top:    0.05"
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
.head 7 -  ! Найти запись
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_GetValue.cBTipFind')
.head 6 +  On SAM_Click
.head 7 -  Call TblFindString(tblData, DFIND_First)
.head 4 +  Pushbutton: pbSelect
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbOk
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.0"
.head 6 -  Top:    0.052"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Enter
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
.head 7 -  ! Выбрать запись
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_GetValue.cBTipSelect')
.head 6 +  On SAM_Click
.head 7 -  Call SalPostMsg(tblData, SAM_DoubleClick, 0, 0)
.head 4 +  Pushbutton: pbExit
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbCancel
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.425"
.head 6 -  Top:    0.052"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Esc
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
.head 7 -  ! Выйти
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_GetValue.cBTipExit')
.head 6 +  On SAM_Click
.head 7 -  Call SalEndDialog(hWndForm, 0)
.head 2 +  Contents
.head 3 +  Child Table: tblData
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.0"
.head 6 -  Top:    0.0"
.head 6 -  Width:  7.4"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 4.45"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: 9
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  View: Table
.head 5 -  Allow Row Sizing? No
.head 5 -  Lines Per Row: Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: 2000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colId
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.2"
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
.head 5 +  Column: colSemantic
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  4.5"
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
.head 4 +  Window Variables
.head 5 -  Number: nOrderBy
.head 5 -  Window Handle: hColumn
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalTblSetTableFlags(hWndItem, TBL_Flag_SelectableCols, TRUE)
.head 6 -  Set nOrderBy = 1
.head 5 +  On SAM_DoubleClick
.head 6 -  Set strKeyValue = colId
.head 6 -  Set strSemValue = colSemantic
.head 6 -  Call SalEndDialog(dlg_GetValue, 1)
.head 5 +  On SAM_ColumnSelectClick
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Set hColumn = SalNumberToWindowHandle(wParam)
.head 6 -  Set nOrderBy = Not nOrderBy
.head 6 -  Call SalTblSortRows(hWndForm, SalTblQueryColumnID(hColumn), nOrderBy)
.head 6 -  Call SalTblSetColumnFlags(hColumn, COL_Selected, FALSE)
.head 6 -  Call SalWaitCursor(FALSE)
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  String: strTabName
.head 3 -  String: strColName
.head 3 -  Receive String: strKeyValue
.head 3 -  Receive String: strSemValue
.head 2 +  Window Variables
.head 3 -  Number: nTabId
.head 3 -  String: strTabSem
.head 3 -  String: strColmName
.head 3 -  String: strColSmName
.head 3 -  String: strColType
.head 3 -  String: strSqlPopulate
.head 3 -  Number: fKey
.head 3 -  Number: nWidth
.head 3 -  !
.head 3 -  String: strCols
.head 3 -  String: strInto
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call XSalTooltipSetUserDefault()
.head 4 -  Call SalStrTrim(SalStrUpperX(strTabName), strTabName)
.head 4 -  Call SalStrTrim(SalStrUpperX(strColName), strColName)
.head 4 -  Call SqlPrepareAndExecute(hSqlAux(),
"SELECT tabid, semantic INTO :nTabId, :strTabSem FROM meta_tables WHERE tabname=:strTabName") 
.head 4 -  Call SqlFetchNext(hSqlAux(), nFetchRes)
.head 4 -  Call SalSetWindowText(hWndForm, strTabSem)
.head 4 -  Set strSqlPopulate = ''
.head 4 -  Set strCols = ''
.head 4 -  Set strInto = ''
.head 4 -  Call SqlPrepareAndExecute (hSqlAux(),
"SELECT colname, semantic, showretval, coltype, showwidth
   INTO :strColmName, :strColSmName, :fKey, :strColType, :nWidth 
   FROM meta_columns 
  WHERE tabid=:nTabId AND (colname=:strColName OR showretval=1)")
.head 4 +  While SqlFetchNext(hSqlAux(), nFetchRes)
.head 5 -  Set strSqlPopulate = "SELECT "
.head 5 +  If strCols
.head 6 -  Set strCols = strCols || ","
.head 5 +  If strColType = 'N'
.head 6 -  Set strColmName = "to_char(" || strColmName || ")"
.head 5 +  Else If strColType = 'D'
.head 6 -  Set strColmName = "to_char(" || strColmName || ", 'dd.mm.yyyy')"
.head 5 -  Set strCols = strCols || "substr(" || strColmName || ", 1, 100)"
.head 5 +  If strInto
.head 6 -  Set strInto = strInto || ","
.head 5 +  If fKey
.head 6 -  Call SalTblSetColumnTitle(tblData.colId, VisStrSubstitute(strColSmName, '~', PutCrLf() ))
.head 6 +  If nWidth
.head 7 -  Call SalTblSetColumnWidth(tblData.colId, nWidth)
.head 6 -  Set strInto = strInto || ":tblData.colId"
.head 5 +  Else
.head 6 -  Call SalTblSetColumnTitle( tblData.colSemantic, VisStrSubstitute(strColSmName, '~', PutCrLf() ))
.head 6 +  If nWidth
.head 7 -  Call SalTblSetColumnWidth(tblData.colSemantic, nWidth)
.head 6 -  Set strInto = strInto || ":tblData.colSemantic"
.head 4 -  Set strSqlPopulate = strSqlPopulate || strCols || " INTO " || strInto || " FROM " || strTabName || " order by 1"
.head 4 -  ! Call Debug( strSqlPopulate )
.head 4 -  Call SalTblPopulate(tblData, hSqlAux(), strSqlPopulate, TBL_FillNormal)
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalWaitCursor(FALSE)
.head 1 +  Dialog Box: dlg_GetFilterName
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Задайте имя фильтра...
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  6.343"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 1.488"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: MS Sans Serif
.head 3 -  Font Size: 8
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Ввести имя нового фильтра
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
.head 3 +  Data Field: dfName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 70
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.071"
.head 6 -  Top:    0.219"
.head 6 -  Width:  6.143"
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
.head 6 -  ! Set MyValue ='<Новый фильтр>'
.head 6 -  Set MyValue ='<' || CurrentLangTable.GetAtomTitle('dlg_GetFilterName.cTName') || '>'
.head 3 +  Pushbutton: pbOk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Утвердить
.head 4 -  Window Location and Size
.head 5 -  Left:   1.033"
.head 5 -  Top:    0.594"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\APPLY.BMP
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set strName = dfName
.head 6 -  Call SalEndDialog( hWndForm, 1 )
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отменить
.head 4 -  Window Location and Size
.head 5 -  Left:   3.367"
.head 5 -  Top:    0.594"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\DISCARD.BMP
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog( hWndForm, 0 )
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Receive String: strName
.head 2 -  Window Variables
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('dlg_GetFilterName.cTWndTitle'))
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 1 -  !
.head 1 +  Dialog Box: dlg_SetSearch
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Поиск...
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  6.443"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 1.813"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: MS Sans Serif
.head 3 -  Font Size: 8
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Установка поля таблицы и значения для поиска
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
.head 3 -  Frame
.head 4 -  Resource Id: 38974
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.06"
.head 5 -  Top:    0.063"
.head 5 -  Width:  3.757"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.725"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 3 -  Background Text: Поле таблицы:
.head 4 -  Resource Id: 38975
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.146"
.head 5 -  Width:  2.043"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgTblFields
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
.head 3 +  Combo Box: cmbtblFields
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.365"
.head 5 -  Width:  3.471"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.094"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  String Type: String
.head 4 -  Maximum Data Length: Default
.head 4 -  Sorted? No
.head 4 -  Always Show List? No
.head 4 -  Vertical Scroll? Yes
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  List Initialization
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set nCnt = 0
.head 6 +  Loop
.head 7 +  If nCnt >= nBound
.head 8 -  Break
.head 7 -  Set strTitle = FunStrSupressCrLfX( strFields[nCnt,0] )
.head 7 -  Call SalListAdd( hWndItem, strTitle)
.head 7 -  Set nCnt = nCnt + 1
.head 6 -  Call SalListSetSelect( hWndItem, nSearchCol-1 )
.head 3 -  Frame
.head 4 -  Resource Id: 38976
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.786"
.head 5 -  Top:    0.063"
.head 5 -  Width:  2.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.725"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 3 -  Background Text: Искать:
.head 4 -  Resource Id: 38977
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.929"
.head 5 -  Top:    0.146"
.head 5 -  Width:  1.314"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgSearch
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
.head 3 +  Data Field: dfSearch4
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.929"
.head 6 -  Top:    0.357"
.head 6 -  Width:  2.114"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.274"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: MS Sans Serif
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set dfSearch4 = strSearchVal
.head 3 +  Pushbutton: pbDone
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Искать!
.head 4 -  Window Location and Size
.head 5 -  Left:   0.943"
.head 5 -  Top:    0.906"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\APPLY.BMP
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set nSearchCol = SalStrToNumber(strFields[SalListQuerySelection( cmbtblFields ), 1])
.head 6 -  Set strSearchVal = dfSearch4
.head 6 -  ! Call SaveInfoToLog( 'Задействован поиск: ' || cmbtblFields || ' = ' || dfSearch4 )
.head 6 -  Call SaveInfoToLog(CurrentLangTable.GetAtomTitle('dlg_SetSearch.cTSetSearch') || ': ' || cmbtblFields || ' = ' || dfSearch4)
.head 6 -  Call SalEndDialog(hWndForm, 1)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отменить
.head 4 -  Window Location and Size
.head 5 -  Left:   3.886"
.head 5 -  Top:    0.906"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\DISCARD.BMP
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog( hWndForm, 0 )
.head 2 +  Functions
.head 3 +  Function: FunStrSupressCrLfX
.head 4 -  Description: подавляет ЦрЛф-ы  в строке
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  String: strSrc
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nOffset
.head 4 +  Actions
.head 5 -  Set strSrc = SalStrTrimX( strSrc )
.head 5 -  Set nOffset = SalStrScan( strSrc, '
' )
.head 5 +  While nOffset >= 0
.head 6 -  Set strSrc =  SalStrReplaceX( strSrc, nOffset, 2, ' ' )
.head 6 -  Set nOffset = SalStrScan( strSrc, '
' )
.head 5 -  Return strSrc
.head 2 +  Window Parameters
.head 3 -  String: strFields[*,2]
.head 3 -  Number: nBound
.head 3 -  Receive Number: nSearchCol
.head 3 -  Receive String: strSearchVal
.head 2 +  Window Variables
.head 3 -  Number: nCnt
.head 3 -  String: strTitle
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('dlg_SetSearch.cTWndTitle'))
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 1 -  !
.head 1 +  Dialog Box: dlg_SetColumnStatus
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Колонки таблицы...
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? No
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  9.883"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.476"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: MS Sans Serif
.head 3 -  Font Size: 8
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Назначить видимость/невидимость колонок.
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.417"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Contents
.head 4 +  Pushbutton: pbShowColumn
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cTBarButton
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.067"
.head 6 -  Top:    0.06"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: MS Sans Serif
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Showitem.bmp
.head 5 -  Picture Transparent Color: None
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  ! Set strTip = 'Показывать колонку'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetColumnStatus.cBTipShowColumn')
.head 6 +  On SAM_Click
.head 7 -  Call MarkVisibleColumn( 1, ROW_Selected )
.head 4 +  Pushbutton: pbShowAll
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cTBarButton
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.5"
.head 6 -  Top:    0.06"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: MS Sans Serif
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Showall.bmp
.head 5 -  Picture Transparent Color: None
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  ! Set strTip = 'Показывать все колонки'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetColumnStatus.cBTipShowAll')
.head 6 +  On SAM_Click
.head 7 -  Call MarkVisibleColumn( 1, 0 )
.head 4 +  Pushbutton: pbHideColumn
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cTBarButton
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.067"
.head 6 -  Top:    0.06"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: MS Sans Serif
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Hideitem.bmp
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  ! Set strTip = 'Не показывать колонку'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetColumnStatus.cBTipHideColumn')
.head 6 +  On SAM_Click
.head 7 -  Call MarkVisibleColumn( 0, ROW_Selected )
.head 4 +  Pushbutton: pbHideAll
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cTBarButton
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.5"
.head 6 -  Top:    0.06"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: MS Sans Serif
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Hideall.bmp
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  ! Set strTip = 'Не показывать все колонки'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetColumnStatus.cBTipHideAll')
.head 6 +  On SAM_Click
.head 7 -  Call MarkVisibleColumn( 0, 0 )
.head 4 +  Pushbutton: pbDecPosition
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cTBarButton
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.117"
.head 6 -  Top:    0.06"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: MS Sans Serif
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \Bars98\resource\bmp\ascend_.bmp
.head 5 -  Picture Transparent Color: Dark Gray
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  ! Set strTip = 'Уменьшить позицию колонки'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetColumnStatus.cBTipDecPosition')
.head 6 +  On SAM_Click
.head 7 -  Call SwapTableRows( SalTblQueryContext( tblColumns ), SalTblQueryContext( tblColumns )-1 )
.head 4 +  Pushbutton: pbIncPosition
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cTBarButton
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.55"
.head 6 -  Top:    0.06"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: MS Sans Serif
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \bars98\resource\bmp\descend_.bmp
.head 5 -  Picture Transparent Color: Dark Gray
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  ! Set strTip = 'Увеличить позицию колонки'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetColumnStatus.cBTipIncPosition')
.head 6 +  On SAM_Click
.head 7 -  Call SwapTableRows( SalTblQueryContext( tblColumns ), SalTblQueryContext( tblColumns )+1 )
.head 4 +  Pushbutton: pbRefresh
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbRefresh
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.167"
.head 6 -  Top:    0.06"
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
.head 7 -  ! Set strTip = 'Установить начальные значения колонок'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('dlg_SetColumnStatus.cBTipRefresh')
.head 6 +  On SAM_Click
.head 7 -  Call RefreshTable(TTable)
.head 2 +  Contents
.head 3 +  Child Table: tblColumns
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.0"
.head 6 -  Top:    0.0"
.head 6 -  Width:  9.483"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 4.0"
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
.head 5 -  Maximum Rows in Memory: 300
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colClassId
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
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
.head 5 +  Column: colPos
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
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
.head 5 +  Column: colName
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование колонки
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.333"
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
.head 5 +  Column: colVisible
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Показывать
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  1.183"
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
.head 6 +  Message Actions
.head 7 -  On SAM_Validate
.head 4 -  Functions
.head 4 -  Window Variables
.head 4 +  Message Actions
.head 5 +  On SAM_TblDoDetails
.head 6 -  ! разберемся с применимостью кнопок
.head 6 -  Call CustomizeButtons( )
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren( hWndForm, UM_QueryLabelText, 0, 0 )
.head 3 +  Pushbutton: pbOk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Утвердить
.head 4 -  Window Location and Size
.head 5 -  Left:   3.033"
.head 5 -  Top:    4.107"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\APPLY.BMP
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call CommitChangesToClass ( TTable )
.head 6 +  If TTable.ApplyColumnsSettings()
.head 7 -  Call TTable.SaveColumnsSettings()
.head 6 -  Call SalEndDialog( hWndForm, 1 )
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отменить
.head 4 -  Window Location and Size
.head 5 -  Left:   5.25"
.head 5 -  Top:    4.107"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\DISCARD.BMP
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog( hWndForm, 0 )
.head 2 +  Functions
.head 3 +  Function: PopulateTable
.head 4 -  Description: Населить таблицу для редактирования статуса колонок.
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  : TTab_
.head 6 -  Class: cABSTab
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nI
.head 5 -  Number: nRow
.head 4 +  Actions
.head 5 -  Set nI = 0
.head 5 +  While nI < TTab_.nColNum
.head 6 +  If NOT TTab_.TabColumn[nI].fSystemHidden
.head 7 -  Set nRow = SalTblInsertRow( tblColumns, TBL_MaxRow )
.head 7 +  If nRow != TBL_Error
.head 8 -  Call SalTblSetContext( tblColumns, nRow )
.head 8 -  Call SalTblSetRowFlags( tblColumns, nRow, ROW_New, FALSE )
.head 8 -  Set tblColumns.colClassId = nI
.head 8 -  Set tblColumns.colPos = TTab_.TabColumn[nI].nPosition
.head 8 -  Set tblColumns.colName = TTab_.TabColumn[nI].strColTitle 
.head 8 -  Set colVisible = TTab_.TabColumn[nI].fShow
.head 6 -  Set nI = nI + 1
.head 5 -  Call SalTblSortRows( tblColumns, 2, TBL_SortIncreasing )
.head 5 -  Call SalTblSetContext( tblColumns, 0 )
.head 5 -  Call SalSendMsg( tblColumns, SAM_TblDoDetails, 0, 0 )
.head 3 +  Function: CustomizeButtons
.head 4 -  Description: Вычислить применимость кнопок и задать их видимость
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nRowNum
.head 4 +  Actions
.head 5 +  If TTable.fColPosChangeAllowed
.head 6 -  Set nRowNum = SalTblQueryContext( tblColumns )
.head 6 +  If nRowNum = 0
.head 7 -  Call SalDisableWindow( pbDecPosition )
.head 6 +  Else
.head 7 -  Call SalEnableWindow( pbDecPosition )
.head 6 -  !
.head 6 +  If NOT SalTblFindNextRow( tblColumns, nRowNum, 0, 0)
.head 7 -  Call SalDisableWindow( pbIncPosition )
.head 6 +  Else
.head 7 -  Call SalEnableWindow( pbIncPosition )
.head 5 -  !
.head 5 +  If tblColumns.colVisible
.head 6 -  Call SalDisableWindow( pbShowColumn )
.head 6 -  Call SalEnableWindow( pbHideColumn )
.head 5 +  Else
.head 6 -  Call SalDisableWindow( pbHideColumn )
.head 6 -  Call SalEnableWindow( pbShowColumn )
.head 5 -  !
.head 5 -  Return TRUE
.head 3 +  Function: MarkVisibleColumn
.head 4 -  Description: Пометить колонку видимости.
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nVisible
.head 5 -  Number: nRowFlag
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SalWaitCursor( TRUE )
.head 5 -  Set nRowCurr = SalTblQueryContext( tblColumns )
.head 5 -  Set nRow = TBL_MinRow
.head 5 +  While SalTblFindNextRow( tblColumns, nRow, nRowFlag, 0 )
.head 6 -  Call SalTblSetContext( tblColumns, nRow )
.head 6 -  Set tblColumns.colVisible = nVisible
.head 5 -  Call SalTblSetContext( tblColumns, nRowCurr )
.head 5 -  Call CustomizeButtons(  )
.head 5 -  Call SalWaitCursor( FALSE )
.head 3 +  Function: SwapTableRows
.head 4 -  Description: Поменять значения строки колонки друг на друга с переносом контекста
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nSrcRow
.head 5 -  Number: nDstRow
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nSrcClassId
.head 5 -  Number: nDstClassId
.head 5 -  Number: nSrcPos
.head 5 -  Number: nDstPos
.head 5 -  String: strSrcName
.head 5 -  String: strDstName
.head 5 -  Number: nSrcVisible
.head 5 -  Number: nDstVisible
.head 4 +  Actions
.head 5 -  Call SalTblSetContext( tblColumns, nDstRow )
.head 5 -  Set nDstClassId = tblColumns.colClassId
.head 5 -  Set nDstPos     = tblColumns.colPos
.head 5 -  Set strDstName  = tblColumns.colName
.head 5 -  Set nDstVisible = tblColumns.colVisible
.head 5 -  !
.head 5 -  Call SalTblSetContext( tblColumns, nSrcRow )
.head 5 -  Set nSrcClassId = tblColumns.colClassId
.head 5 -  Set nSrcPos     = tblColumns.colPos
.head 5 -  Set strSrcName  = tblColumns.colName
.head 5 -  Set nSrcVisible = tblColumns.colVisible
.head 5 -  Set tblColumns.colClassId = nDstClassId
.head 5 -  Set tblColumns.colPos     = nDstPos
.head 5 -  Set tblColumns.colName    = strDstName
.head 5 -  Set tblColumns.colVisible = nDstVisible
.head 5 -  !
.head 5 -  Call SalTblSetContext( tblColumns, nDstRow )
.head 5 -  Set tblColumns.colClassId = nSrcClassId
.head 5 -  Set tblColumns.colPos     = nSrcPos
.head 5 -  Set tblColumns.colName    = strSrcName
.head 5 -  Set tblColumns.colVisible = nSrcVisible
.head 5 -  !
.head 5 -  Call SalTblSetFocusRow( tblColumns, nDstRow )
.head 5 -  Call SalTblSetRowFlags( tblColumns, nSrcRow, ROW_Selected, FALSE )
.head 5 -  Call SalTblSetRowFlags( tblColumns, nDstRow, ROW_Selected, TRUE )
.head 3 +  Function: CommitChangesToClass
.head 4 -  Description: Сохранить изменения в классе таблицы.
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  : TTab_
.head 6 -  Class: cABSTab
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nRow
.head 5 -  Number: nVisRow
.head 5 -  Number: nI
.head 4 +  Actions
.head 5 -  Set nRow = TBL_MinRow
.head 5 +  While SalTblFindNextRow( tblColumns, nRow, 0, 0 )
.head 6 -  Call SalTblSetContext( tblColumns, nRow )
.head 6 -  Set TTab_.TabColumn[tblColumns.colClassId].nPosition = nRow + 1
.head 6 -  Set TTab_.TabColumn[tblColumns.colClassId].fShow = tblColumns.colVisible
.head 6 -  Set nVisRow = nRow + 1
.head 5 -  !
.head 5 -  Set nI = 0
.head 5 +  While nI < TTable.nColNum
.head 6 +  If TTable.TabColumn[nI].fSystemHidden
.head 7 -  Set nVisRow = nVisRow + 1
.head 7 -  Set TTable.TabColumn[nI].nPosition = nVisRow
.head 6 -  Set nI = nI + 1
.head 5 -  Return TRUE
.head 3 +  Function: RefreshTable
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  : TTab_
.head 6 -  Class: cABSTab
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call TTab_.RefreshColumnSetting()
.head 5 -  Call SalTblReset( tblColumns )
.head 5 -  Call PopulateTable(TTab_)
.head 5 -  Return TRUE
.head 2 +  Window Parameters
.head 3 -  : TTable
.head 4 -  Class: cABSTab
.head 2 +  Window Variables
.head 3 -  Number: nRow
.head 3 -  Number: nRowCurr
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('dlg_SetColumnStatus.cTWndTitle'))
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  Call XSalTooltipSetUserDefault()
.head 4 -  Call TTable.FetchColumnsPosition()
.head 4 -  Call PopulateTable(TTable)
.head 4 -  Call VisTblAutoSizeColumn(tblColumns, hWndNULL)
.head 4 +  If NOT TTable.fColPosChangeAllowed
.head 5 -  Call SalDisableWindow(pbIncPosition)
.head 5 -  Call SalDisableWindow(pbDecPosition)
.head 4 -  Call SalWaitCursor(FALSE)

.head 1 +  Dialog Box: dlg_ShowFilter
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Выражение фильтра
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  8.0"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 2.0"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: MS Sans Serif
.head 3 -  Font Size: 8
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
.head 3 +  Multiline Field: mlFilter
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 2000
.head 5 -  String Type: Long String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Border? Yes
.head 5 -  Word Wrap? Yes
.head 5 -  Vertical Scroll? Yes
.head 5 -  Window Location and Size
.head 6 -  Left:   0.1"
.head 6 -  Top:    0.08"
.head 6 -  Width:  7.7"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.8"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: None
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Set sTmpFilter = mlFilter
.head 5 +  On SAM_AnyEdit
.head 6 +  If not bEdit
.head 7 -  Set mlFilter = sTmpFilter
.head 3 +  Pushbutton: pbOk	! F10
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: OK
.head 4 -  Window Location and Size
.head 5 -  Left:   3.1"
.head 5 -  Top:    1.1"
.head 5 -  Width:  1.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.35"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F10
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(hWndForm, TRUE)
.head 3 +  Pushbutton: pbEdit		! F6
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbEdit
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    1.0"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: F6
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
.head 6 -  Call SalColorSet(mlFilter, COLOR_IndexWindow, COLOR_White)
.head 6 -  Set bEdit = TRUE
.head 6 -  Call SalSetFocus(mlFilter)
.head 3 +  Pushbutton: bpSave	! F2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbUpdate
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.0"
.head 5 -  Top:    1.0"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: F2
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
.head 6 -  Set sTmpFilter = mlFilter
.head 6 -  Set sFilter = VisStrSubstitute(mlFilter, 'a.', '$~~ALIAS~~$.')
.head 6 -  Call SqlSetLongBindDatatype(1, 22)
.head 6 +  If SqlPrepareAndExecute(hFilterSql, "update dyn_filter set where_clause = :sFilter where filter_id = :nFilterId")
.head 7 -  Call SqlCommit(hFilterSql)
.head 6 +  Else
.head 7 -  Call SqlRollback(hFilterSql)
.head 6 -  Call SalColorSet(mlFilter, COLOR_IndexWindow, SalColorGet(hWndForm, COLOR_IndexWindow))
.head 6 -  Set bEdit = FALSE
.head 3 +  Pushbutton: pbCancel	! Esc
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.8"
.head 5 -  Top:    1.0"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
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
.head 6 -  Call SalEndDialog(hWndForm, TRUE)
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Sql Handle: hFilterSql
.head 3 -  Number: nFilterId
.head 3 -  Receive Long String: sFilter
.head 2 +  Window Variables
.head 3 -  Boolean: bEdit
.head 3 -  String: sTmpFilter
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('dlg_ShowFilter.cTWndTitle'))
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Call SalColorSet(mlFilter, COLOR_IndexWindow, SalColorGet(hWndForm, COLOR_IndexWindow))
.head 4 -  Set bEdit = FALSE
.head 4 -  Set mlFilter = VisStrSubstitute(sFilter, '$~~ALIAS~~$', 'a')
.head 4 -  Call SalSetFocus(pbOk)
