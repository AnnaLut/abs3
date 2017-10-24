.head 0 +  Application Description: Библиотека классов Combo и ListBox-ов
(с) Abyss, Unity-Bars, 1999
-------------------------------------
КАК ЭТО РАБОТАЕТ:
1) Создаете во время проектирования формы
   экземпляр одного из перечисленных объектов:
   cGenComboBox    - выпадающий список;
   cGenListBox     - постоянный список;
   cGenColComboBox - колонка-выпадающий список.
При этом суффикс после подчеркивания в
названии класса указывает на тип ключевого
поля.

2) В обработке сообщения SAM_Create (или в
   другом удобном месте) вызываете функцию
   инициализации Init (Window Handle).
   Параметр - хендл экземпляра объекта.
Вызов этой функции обязателен и должен быть
произведен до любого другого вызова функций
класса.

3) Население списка производится функцией 
   Populate (Sql Handle, String, String,
             String, String)
   Параметр 1 - хендл коннекта к базе данных;
   Параметр 2 - имя поля ключа;
   Параметр 3 - имя поля семантики (что будет
                в списке);
   Параметр 4 - имя таблицы БД;
   Параметр 5 - Условие выборки (обязательно с
                тэгом WHERE).

Можно добавить пункты списка вручную функцией
   Add (<Number/String/DateTime>, String)
   Параметр 1 - значение ключа;
   Параметр 2 - значение семантики.

4) В нужном месте (например, по событию
   SAM_Click) вы можете получить значение
   ключа или семантики выбранного пункта
   списка. Используйте функции

   GetStrKey (Number) - для значения
                        строкового ключа
   GetNumKey (Number) - для значения числового
                        ключа
   GetName (Number) - для значения семантики.

Во всех функциях параметр - это индекс пункта
списка, который можно получить функцией
SalListQuerySelection.
!ВАЖНО ПОМНИТЬ!, что если объект не
проинициализирован, как объект с числовым
ключом, то функция числового значения ключа
вернет 0 !
!ВАЖНО ПОМНИТЬ!, что во всех классах кроме
колонок таблицы существует обработка сообщения
SAM_Click, в которой иет присвоение значения
текущего ключа. Его можно получить функцией
GetCurrentKey().

5) Функция SetSelectById() выбирает запись из
   списка по значению ключа.
.head 1 -  Outline Version - 4.0.26
.head 1 +  Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000620000 002C000000020000 0003000000FFFFFF FFFFFFFFFFFCFFFF
0040: FFD4FFFFFFFFFFFF FF000000007C0200 004D010000010000 0001000000010000
0060: 000F4170706C6963 6174696F6E497465 6D00000000
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
0000: 0019B80BB80B2500
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
.head 1 -  Libraries
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
.head 2 -  External Functions
.head 2 +  Constants
.data CCDATA
0000: 3000000000000000 0000000000000000 00000000
.enddata
.data CCSIZE
0000: 1400
.enddata
.head 3 -  System
.head 3 -  User
.head 2 -  Resources
.head 2 -  Variables
.head 2 -  Internal Functions
.head 2 -  Named Menus
.head 2 +  Class Definitions
.head 3 +  Functional Class: cList
.head 4 -  Description: Функциональный класс списка
.head 4 -  Derived From
.head 4 -  Class Variables
.head 4 +  Instance Variables
.head 5 -  Window Handle: hWinListObject
.head 5 -  !
.head 5 -  String: strList[*,2]	! Массив значений списка
.head 5 -  Number: nItemNum	! Количество элементов
.head 4 +  Functions
.head 5 +  Function: Init
.head 6 -  Description: Конструктор
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Window Handle: hWin
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set hWinListObject = hWin
.head 7 -  Set nItemNum = 0
.head 7 -  Return TRUE
.head 3 +  Functional Class: cListNumberId
.head 4 -  Description: Функциональный класс списка (числовой ключ)
.head 4 +  Derived From
.head 5 -  Class: cList
.head 4 -  Class Variables
.head 4 +  Instance Variables
.head 5 -  Number: nCurrentId
.head 4 +  Functions
.head 5 +  Function: Populate
.head 6 -  Description: Инициализация
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Sql Handle: hSqlConnect	! Хендл коннекта
.head 7 -  String: strKeyName	! Наименование колонки-ключа
.head 7 -  String: strSemName	! Наименование колонки-семантики
.head 7 -  String: strTableName	! Наименование таблицы
.head 7 -  String: strAddCondition	! Дополнительные условия
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nI
.head 7 -  Number: nKey
.head 7 -  String: sName
.head 7 -  !
.head 7 -  String: sSelect
.head 7 -  Number: nFetchRes
.head 6 +  Actions
.head 7 -  Set nI = 0
.head 7 -  Set sSelect = '
    SELECT ' || strKeyName || ', ' || strSemName || '
    INTO :nKey, :sName
    FROM ' || strTableName
.head 7 +  If strAddCondition != ''
.head 8 -  Set sSelect = sSelect || ' ' || strAddCondition
.head 7 -  ! Call SalMessageBox( sSelect, 'Debug', MB_Ok )
.head 7 -  Call SalListClear(hWinListObject)
.head 7 +  If not SqlPrepareAndExecute(hSqlConnect, sSelect)
.head 8 -  Return FALSE
.head 7 +  While SqlFetchNext(hSqlConnect, nFetchRes)
.head 8 -  Set strList[nI, 0] = SalNumberToStrX(nKey, 0)
.head 8 -  Set strList[nI, 1] = sName
.head 8 -  Call SalListAdd(hWinListObject, sName)
.head 8 -  Set nI = nI + 1
.head 7 -  Set nItemNum = nI
.head 7 -  Set nCurrentId = NUMBER_Null
.head 7 -  Return TRUE
.head 5 +  Function: Add
.head 6 -  Description: Добавить вхождение в список
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: nKey
.head 7 -  String: sName
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set strList[nItemNum, 0] = SalNumberToStrX(nKey, 0)
.head 7 -  Set strList[nItemNum, 1] = sName
.head 7 -  Call SalListAdd(hWinListObject, sName)
.head 7 -  Set nItemNum = nItemNum + 1
.head 7 -  Return TRUE
.head 5 +  Function: GetKey
.head 6 -  Description: Вернуть ключ 
.head 6 +  Returns
.head 7 -  Number:
.head 6 +  Parameters
.head 7 -  Number: nIndex
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 +  If nIndex >=0 AND nIndex < nItemNum 
.head 8 -  Return SalStrToNumber(strList[nIndex, 0])
.head 7 +  Else
.head 8 -  Return NUMBER_Null
.head 5 +  Function: GetName
.head 6 -  Description: Вернуть семантику
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  Number: nIndex
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 +  If nIndex >=0 AND nIndex < nItemNum
.head 8 -  Return strList[nIndex, 1]
.head 7 +  Else
.head 8 -  Return ''
.head 5 +  Function: GetNameById
.head 6 -  Description: Вернуть семантику по ID
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  Number: nKey
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nI
.head 6 +  Actions
.head 7 -  Set nI = 0
.head 7 +  Loop
.head 8 +  If nI >= nItemNum
.head 9 -  Break
.head 8 +  If strList[nI, 0] = SalNumberToStrX(nKey, 0)
.head 9 -  Return strList[nI, 1]
.head 8 -  Set nI = nI + 1
.head 7 -  Return ""
.head 5 +  Function: SetSelectById
.head 6 -  Description: Выбрать запись в списке по ID
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: nId
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nI
.head 6 +  Actions
.head 7 -  Set nCurrentId = NUMBER_Null
.head 7 -  Set nI = 0
.head 7 +  While nI < nItemNum 
.head 8 +  If strList[nI, 0] = SalNumberToStrX(nId, 0)
.head 9 -  Set nCurrentId=nId
.head 9 -  Call SalListSetSelect ( hWinListObject, nI )
.head 9 -  Return TRUE
.head 8 -  Set nI = nI + 1
.head 7 -  Call SalListSetSelect( hWinListObject, -1 )
.head 5 +  Function: SetCurrentKey
.head 6 -  Description: Установить текущий ключ
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: nKey
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set nCurrentId = nKey
.head 5 +  Function: GetCurrentKey
.head 6 -  Description: Получить текущий ключ
.head 6 +  Returns
.head 7 -  Number:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return nCurrentId
.head 3 +  Functional Class: cListStringId
.head 4 -  Description: Функциональный класс списка (строковый ключ)
.head 4 +  Derived From
.head 5 -  Class: cList
.head 4 -  Class Variables
.head 4 +  Instance Variables
.head 5 -  String: strCurrentId
.head 4 +  Functions
.head 5 +  Function: Populate
.head 6 -  Description: Инициализация
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Sql Handle: hSqlConnect	! Хендл коннекта
.head 7 -  String: strKeyName	! Наименование колонки-ключа
.head 7 -  String: strSemName	! Наименование колонки-семантики
.head 7 -  String: strTableName	! Наименование таблицы
.head 7 -  String: strAddCondition	! Дополнительные условия
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nI
.head 7 -  String: sKey
.head 7 -  String: sName
.head 7 -  !
.head 7 -  String: sSelect
.head 7 -  Number: nFetchRes
.head 6 +  Actions
.head 7 -  Set nI = 0
.head 7 -  Set sSelect = '
    SELECT ' || strKeyName || ', ' || strSemName || '
    INTO :sKey, :sName
    FROM ' || strTableName
.head 7 +  If strAddCondition != ''
.head 8 -  Set sSelect = sSelect || ' ' || strAddCondition
.head 7 -  Call SalListClear(hWinListObject)
.head 7 +  If NOT SqlPrepareAndExecute(hSqlConnect, sSelect)
.head 8 -  Return FALSE
.head 7 +  While SqlFetchNext(hSqlConnect, nFetchRes)
.head 8 -  Set strList[nI, 0] = sKey
.head 8 -  Set strList[nI, 1] = sName
.head 8 -  Call SalListAdd(hWinListObject, sName)
.head 8 -  Set nI = nI + 1
.head 7 -  Set nItemNum = nI
.head 7 -  Set strCurrentId = STRING_Null
.head 7 -  Return TRUE
.head 5 +  Function: Add
.head 6 -  Description: Добавить вхождение в список
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: sKey
.head 7 -  String: sName
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set strList[nItemNum, 0] = sKey
.head 7 -  Set strList[nItemNum, 1] = sName
.head 7 -  Call SalListAdd(hWinListObject, sName)
.head 7 -  Set nItemNum = nItemNum + 1
.head 7 -  Return TRUE
.head 5 +  Function: GetKey
.head 6 -  Description: Вернуть ключ 
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  Number: nIndex
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 +  If nIndex >=0 and nIndex < nItemNum
.head 8 -  Return strList[nIndex, 0]
.head 7 +  Else
.head 8 -  Return STRING_Null
.head 5 +  Function: GetName
.head 6 -  Description: Вернуть семантику
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  Number: nIndex
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 +  If nIndex >=0 and nIndex < nItemNum
.head 8 -  Return strList[nIndex, 1]
.head 7 +  Else
.head 8 -  Return ''
.head 5 +  Function: GetNameById
.head 6 -  Description: Вернуть семантику по ID
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  String: strKey
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nI
.head 6 +  Actions
.head 7 -  Set nI = 0
.head 7 +  Loop
.head 8 +  If nI >= nItemNum
.head 9 -  Break
.head 8 +  If strList[nI, 0] = strKey
.head 9 -  Return strList[nI, 1]
.head 8 -  Set nI = nI + 1
.head 7 -  Return ""
.head 5 +  Function: SetSelectById
.head 6 -  Description: Выбрать запись в списке по ID
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: strId
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nI
.head 6 +  Actions
.head 7 -  Set strCurrentId = STRING_Null
.head 7 -  Set nI = 0
.head 7 +  While nI < nItemNum 
.head 8 +  If strList[nI, 0] = strId
.head 9 -  Set strCurrentId=strList[nI, 0]
.head 9 -  Call SalListSetSelect ( hWinListObject, nI )
.head 9 -  Return TRUE
.head 8 -  Set nI = nI + 1
.head 7 -  Call SalListSetSelect( hWinListObject, -1 )
.head 5 +  Function: SetCurrentKey
.head 6 -  Description: Установить текущий ключ
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: strKey
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set strCurrentId = strKey
.head 5 +  Function: GetCurrentKey
.head 6 -  Description: Получить текущий ключ
.head 6 +  Returns
.head 7 -  String:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return strCurrentId
.head 3 +  Functional Class: cListDateId
.head 4 -  Description: Функциональный класс списка (ключ - дата)
.head 4 +  Derived From
.head 5 -  Class: cList
.head 4 -  Class Variables
.head 4 +  Instance Variables
.head 5 -  Date/Time: dtCurrentId
.head 4 +  Functions
.head 5 +  Function: Populate
.head 6 -  Description: Инициализация
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Sql Handle: hSqlConnect	! Хендл коннекта
.head 7 -  String: strKeyName	! Наименование колонки-ключа
.head 7 -  String: strSemName	! Наименование колонки-семантики
.head 7 -  String: strTableName	! Наименование таблицы
.head 7 -  String: strAddCondition	! Дополнительные условия
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nI
.head 7 -  Date/Time: dtKey
.head 7 -  String: sName
.head 7 -  !
.head 7 -  String: sSelect
.head 7 -  Number: nFetchRes
.head 6 +  Actions
.head 7 -  Set nI = 0
.head 7 -  Set sSelect = '
    SELECT ' || strKeyName || ', ' || strSemName || '
    INTO :dtKey,:sName
    FROM ' || strTableName
.head 7 +  If strAddCondition != ''
.head 8 -  Set sSelect = sSelect || ' ' || strAddCondition
.head 7 -  Call SalListClear(hWinListObject)
.head 7 +  If NOT SqlPrepareAndExecute(hSqlConnect, sSelect)
.head 8 -  Return FALSE
.head 7 +  While SqlFetchNext(hSqlConnect, nFetchRes)
.head 8 -  Set strList[nI, 0] = SalFmtFormatDateTime(dtKey,'yyyyMMdd')
.head 8 -  Set strList[nI, 1] = sName
.head 8 -  Call SalListAdd(hWinListObject, sName)
.head 8 -  Set nI = nI + 1
.head 7 -  Set nItemNum = nI
.head 7 -  Set dtCurrentId = SalDateConstruct(1900, 1, 1, 0, 0, 0)
.head 7 -  Return TRUE
.head 5 +  Function: Add
.head 6 -  Description: Добавить вхождение в список
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Date/Time: dtKey
.head 7 -  String: sName
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set strList[nItemNum, 0] = SalFmtFormatDateTime(dtKey, 'yyyyMMdd')
.head 7 -  Set strList[nItemNum, 1] = sName
.head 7 -  Call SalListAdd(hWinListObject, sName)
.head 7 -  Set nItemNum = nItemNum + 1
.head 7 -  Return TRUE
.head 5 +  Function: GetKey
.head 6 -  Description: Вернуть ключ 
.head 6 +  Returns
.head 7 -  Date/Time:
.head 6 +  Parameters
.head 7 -  Number: nIndex
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nY
.head 7 -  Number: nM
.head 7 -  Number: nD
.head 6 +  Actions
.head 7 +  If nIndex >=0 and nIndex < nItemNum 
.head 8 -  Return SalDateConstruct(
 SalStrToNumber(SalStrMidX(strList[nIndex, 0],0,4)),
 SalStrToNumber(SalStrMidX(strList[nIndex, 0],4,2)),
 SalStrToNumber(SalStrMidX(strList[nIndex, 0],6,2)), 0, 0, 0)
.head 7 +  Else
.head 8 -  Return SalDateConstruct(1900, 1, 1, 0, 0, 0)
.head 5 +  Function: GetName
.head 6 -  Description: Вернуть семантику
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  Number: nIndex
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 +  If nIndex >=0 and nIndex < nItemNum
.head 8 -  Return strList[nIndex, 1]
.head 7 +  Else
.head 8 -  Return ''
.head 5 +  Function: GetNameById
.head 6 -  Description: Вернуть семантику по ID
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  Date/Time: dtKey
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nI
.head 6 +  Actions
.head 7 -  Set nI = 0
.head 7 +  Loop
.head 8 +  If nI >= nItemNum
.head 9 -  Break
.head 8 +  If strList[nI, 0] = SalFmtFormatDateTime(dtKey,'yyyyMMdd')
.head 9 -  Return strList[nI, 1]
.head 8 -  Set nI = nI + 1
.head 7 -  Return ""
.head 5 +  Function: SetSelectById
.head 6 -  Description: Выбрать запись в списке по ID
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Date/Time: dtId
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nI
.head 6 +  Actions
.head 7 -  Set dtCurrentId = DATETIME_Null
.head 7 -  Set nI = 0
.head 7 +  While nI < nItemNum 
.head 8 +  If strList[nI, 0] = SalFmtFormatDateTime(dtId,'yyyyMMdd')
.head 9 -  Set dtCurrentId=SalDateConstruct(
 SalStrToNumber(SalStrMidX(strList[nI, 0],0,4)),
 SalStrToNumber(SalStrMidX(strList[nI, 0],4,2)),
 SalStrToNumber(SalStrMidX(strList[nI, 0],6,2)), 0, 0, 0)
.head 9 -  Call SalListSetSelect ( hWinListObject, nI )
.head 9 -  Return TRUE
.head 8 -  Set nI = nI + 1
.head 7 -  Call SalListSetSelect( hWinListObject, -1 )
.head 5 +  Function: SetCurrentKey
.head 6 -  Description: Установить текущий ключ
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Date/Time: dtKey
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set dtCurrentId = dtKey
.head 5 +  Function: GetCurrentKey
.head 6 -  Description: Получить текущий ключ
.head 6 +  Returns
.head 7 -  Date/Time:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return dtCurrentId
.head 3 -  !
.head 3 +  General Window Class: cGenList_NumId
.head 4 -  Description: Визуальность...
.head 4 +  Derived From
.head 5 -  Class: cListNumberId
.head 4 -  Class Variables
.head 4 -  Instance Variables
.head 4 -  Functions
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SetCurrentKey(GetKey(SalListQuerySelection(hWndItem)))
.head 3 +  General Window Class: cGenList_StrId
.head 4 -  Description: Визуальность...
.head 4 +  Derived From
.head 5 -  Class: cListStringId
.head 4 -  Class Variables
.head 4 -  Instance Variables
.head 4 -  Functions
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SetCurrentKey(GetKey(SalListQuerySelection(hWndItem)))
.head 3 +  General Window Class: cGenList_DatId
.head 4 -  Description: Визуальность...
.head 4 +  Derived From
.head 5 -  Class: cListDateId
.head 4 -  Class Variables
.head 4 -  Instance Variables
.head 4 -  Functions
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SetCurrentKey(GetKey(SalListQuerySelection(hWndItem)))
.head 3 -  !
.head 3 +  Combo Box Class: cGenComboBox_NumId
.head 4 -  Window Location and Size
.head 5 -  Left:  
.head 5 -  Top:   
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  String Type: Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Sorted? No
.head 4 -  Always Show List? Class Default
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  List in Tool Palette? Yes
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Description: Улучшеный КомбоБокс
.head 4 +  Derived From
.head 5 -  Class: cGenList_NumId
.head 4 -  Class Variables
.head 4 -  Instance Variables
.head 4 -  Functions
.head 4 -  List Initialization
.head 4 -  Message Actions
.head 3 +  List Box Class: cGenListBox_NumId
.head 4 -  Window Location and Size
.head 5 -  Left:  
.head 5 -  Top:   
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Multiple selection? Class Default
.head 4 -  Sorted? No
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  List in Tool Palette? Yes
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Description: Улучшеный ЛистБокс
.head 4 +  Derived From
.head 5 -  Class: cGenList_NumId
.head 4 -  Class Variables
.head 4 -  Instance Variables
.head 4 -  Functions
.head 4 -  List Initialization
.head 4 -  Message Actions
.head 3 +  Column Class: cGenColComboBox_NumId
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
.head 5 -  Cell Type? Drop Down List
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? No
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? No
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  Description: Улучшенная колонка Комбо-бокс
.head 4 +  Derived From
.head 5 -  Class: cListNumberId
.head 4 -  Class Variables
.head 4 -  Instance Variables
.head 4 -  Functions
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 -  !
.head 3 +  Combo Box Class: cGenComboBox_StrId
.head 4 -  Window Location and Size
.head 5 -  Left:  
.head 5 -  Top:   
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  String Type: Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Sorted? No
.head 4 -  Always Show List? Class Default
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  List in Tool Palette? Yes
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Description: Улучшеный КомбоБокс
.head 4 +  Derived From
.head 5 -  Class: cGenList_StrId
.head 4 -  Class Variables
.head 4 -  Instance Variables
.head 4 -  Functions
.head 4 -  List Initialization
.head 4 -  Message Actions
.head 3 +  List Box Class: cGenListBox_StrId
.head 4 -  Window Location and Size
.head 5 -  Left:  
.head 5 -  Top:   
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Multiple selection? Class Default
.head 4 -  Sorted? No
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  List in Tool Palette? Yes
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Description: Улучшеный ЛистБокс
.head 4 +  Derived From
.head 5 -  Class: cGenList_StrId
.head 4 -  Class Variables
.head 4 -  Instance Variables
.head 4 -  Functions
.head 4 -  List Initialization
.head 4 -  Message Actions
.head 3 +  Column Class: cGenColComboBox_StrId
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
.head 5 -  Cell Type? Drop Down List
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? No
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? No
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  Description: Улучшенная колонка Комбо-бокс
.head 4 +  Derived From
.head 5 -  Class: cListStringId
.head 4 -  Class Variables
.head 4 -  Instance Variables
.head 4 -  Functions
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 -  !
.head 3 +  Combo Box Class: cGenComboBox_DatId
.head 4 -  Window Location and Size
.head 5 -  Left:  
.head 5 -  Top:   
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  String Type: Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Sorted? No
.head 4 -  Always Show List? Class Default
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  List in Tool Palette? Yes
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Description: Улучшеный КомбоБокс
.head 4 +  Derived From
.head 5 -  Class: cGenList_DatId
.head 4 -  Class Variables
.head 4 -  Instance Variables
.head 4 -  Functions
.head 4 -  List Initialization
.head 4 -  Message Actions
.head 3 +  List Box Class: cGenListBox_DatId
.head 4 -  Window Location and Size
.head 5 -  Left:  
.head 5 -  Top:   
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Multiple selection? Class Default
.head 4 -  Sorted? No
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  List in Tool Palette? Yes
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Description: Улучшеный ЛистБокс
.head 4 +  Derived From
.head 5 -  Class: cGenList_DatId
.head 4 -  Class Variables
.head 4 -  Instance Variables
.head 4 -  Functions
.head 4 -  List Initialization
.head 4 -  Message Actions
.head 3 +  Column Class: cGenColComboBox_DatId
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
.head 5 -  Cell Type? Drop Down List
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? No
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? No
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Class Default
.head 4 -  Description: Улучшенная колонка Комбо-бокс
.head 4 +  Derived From
.head 5 -  Class: cListDateId
.head 4 -  Class Variables
.head 4 -  Instance Variables
.head 4 -  Functions
.head 4 -  List Values
.head 4 -  Message Actions
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
