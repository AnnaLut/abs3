.head 0 +  Application Description: ! BANKAPI.APD - Dynalib
! BANKAPI.APL - библиотека функций управления
!               режимами работы банка в СЭП
! ООО Унити-Барс  (C)  1996-2003
! Разработчик: Сыропоршнев Д.Л., Костров С.В.
.head 1 -  Outline Version - 4.0.26
.head 1 +  Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000BA0000 002C000000020000 0003000000000000 00B1010000FCFFFF
0040: FFE2FFFFFFFFFFFF FF000000007C0200 004D010000010000 0001000000010000
0060: 000F4170706C6963 6174696F6E497465 6D00000000
.enddata
.data DT_MAKERUNDLG
0000: 0200000000001A51 3A5C424152533938 5C42494E5C41505F 5052494E542E646C
0020: 6C1A513A5C424152 5339385C42494E5C 41505F5052494E54 2E61706300000101
0040: 011E513A5C424152 5339385C4C494252 4152595C41505F50 52494E542E72756E
0060: 1E513A5C42415253 39385C4C49425241 52595C41505F5052 494E542E646C6C1E
0080: 513A5C4241525339 385C4C4942524152 595C41505F505249 4E542E6170630000
00A0: 010101175C424152 5339385C42494E5C 62616E6B6170692E 617064175C424152
00C0: 5339385C42494E5C 62616E6B6170692E 646C6C175C424152 5339385C42494E5C
00E0: 62616E6B6170692E 6170630000010101 000C41505F505249 4E542E646C6C0C41
0100: 505F5052494E542E 6170630000010101
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
.head 2 -  Dynalib: Global.apd
.head 2 -  Dynalib: Message.apd
.head 2 -  Dynalib: Absapi.apd
.head 2 -  Dynalib: Service.apd
.head 2 -  Dynalib: Flistapi.apd
.head 2 -  Dynalib: BarsNet.apd
.head 2 -  !
.head 2 -  File Include: Vtmeter.apl
.head 2 -  File Include: Genbutn.apl
.head 2 -  File Include: GENLABEL.APL
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
.head 4 -  Number: AM_MtrMove = SAM_User + 150
.head 3 +  User
.head 4 -  ! String: MSG_CustomerLockWarnP1  = 'В списке прямых участников СЭП расчетов есть '
.head 4 -  ! String: MSG_NonQuitDocsCheck    = 'Проверка "незаквитованых" документов СЭП...'
.head 4 -  ! String: MSG_CheckMfo            = 'Проверяем банк - МФО: '
.head 4 -  ! String: MSG_BanksInitFail       = 'Ошибка при инициализации таблицы "Участники СЭП" (Banks)'
.head 4 -  ! String: MSG_CustomerWillBeLockWarnP1 = 'Участник СЭП - МФО банка: '
.head 4 -  ! String: MSG_CustomerWillBeLockWarnP2 = ' будет блокирован'
.head 4 -  ! String: MSG_DirCustomerSelect   = ' [ Выбор прямых участников СЭП ]'
.head 4 -  ! String: MSG_VFilesInProgress    = 'Формируются выписки (V файлы)...'
.head 4 -  !
.head 4 -  ! String: MSG_TableClean_Z        = 'Очистка таблицы: Z'
.head 4 -  ! String: MSG_TableClean_SALDOH   = 'Очистка таблицы SALDOH'
.head 4 -  ! String: MSG_TableClean_LIMHIST  = 'Очистка таблицы LIM_HIST'
.head 4 -  ! String: MSG_TableClean_SEC_AUDIT = 'Очистка таблицы SEC_AUDIT'
.head 4 -  ! String: MSG_TableClean_REF_LST  = 'Очистка таблицы REF_LST'
.head 4 -  !
.head 4 -  ! String: MSG_TmpTableInitFail    = 'Ошибка при инициализации таблицы БД: '
.head 4 -  !
.head 4 -  ! String: MSG_FlagsSetting        = 'Установка флагов в таблице PARAMS'
.head 4 -  !
.head 4 -  ! String: MSG_AuditBankDateChange = 'Изменение Банковской даты на '
.head 4 -  ! String: MSG_FlagName_BankDate   = 'Текущая Банковская дата'
.head 4 -  ! String: MSG_FlagName_DayOpen    = 'Признак открытия дня'
.head 4 -  ! String: MSG_BankDayIsOpen       = 'Операционный день банка открыт.'
.head 4 -  ! String: MSG_DayCloseSuccess     = 'Закрытие дня банка прошло успешно!'
.head 4 -  !
.head 4 -  ! String: MSG_VerbLock            = 'Блокировать '
.head 4 -  ! String: MSG_VerbUnLock          = 'Разблокировать '
.head 4 -  !
.head 4 -  ! String: MSG_Q_K0FilesProcess    = 'Формировать файлы "K0" на участников СЭП?'
.head 4 -  ! String: MSG_Q_KFilesProcess     = 'Формировать файлы "K" на участников СЭП?'
.head 4 -  ! String: MSG_Q_VFilesProcess     = 'Формировать файлы-выписки "V" на участников СЭП?'
.head 4 -  ! String: MSG_Q_StartDirLock      = '"начальные" для подчиненных РП?'
.head 4 -  ! String: MSG_Q_BackDirLock       = '"ответные" для подчиненных РП?'
.head 4 -  ! String: MSG_Q_AllDirLock        = 'все направления для подчиненных РП?'
.head 4 -  !
.head 4 -  ! String: MSG_InputDate           = 'Введите дату (ДД/ММ/ГГГГ)'
.head 4 -  ! String: MSG_InvalidDateWarn     = 'Неверное значение даты!'
.head 4 -  ! String: MSG_OpenBankDate        = 'Открыть новый день'
.head 4 -  ! String: MSG_AccAmountChange4DateWarn = 'Значения остатков на счетах будут пересчитаны для новой Банковской даты!'
.head 4 -  ! String: MSG_DateUnChangeWarn    = 'Дата Банковского дня не изменяется!'
.head 2 -  Resources
.head 2 +  Variables
.head 3 -  Boolean: fInitLib
.head 3 -  !
.head 3 -  String: MSG_CustomerLockWarnP1
.head 3 -  String: MSG_NonQuitDocsCheck
.head 3 -  String: MSG_CheckMfo
.head 3 -  String: MSG_BanksInitFail
.head 3 -  String: MSG_CustomerWillBeLockWarnP1
.head 3 -  String: MSG_CustomerWillBeLockWarnP2
.head 3 -  String: MSG_DirCustomerSelect
.head 3 -  String: MSG_VFilesInProgress
.head 3 -  !
.head 3 -  String: MSG_TableClean_Z
.head 3 -  String: MSG_TableClean_SALDOH
.head 3 -  String: MSG_TableClean_LIMHIST
.head 3 -  String: MSG_TableClean_SEC_AUDIT
.head 3 -  String: MSG_TableClean_REF_LST
.head 3 -  !
.head 3 -  String: MSG_TmpTableInitFail
.head 3 -  !
.head 3 -  String: MSG_FlagsSetting
.head 3 -  !
.head 3 -  String: MSG_AuditBankDateChange
.head 3 -  String: MSG_FlagName_BankDate
.head 3 -  String: MSG_FlagName_DayOpen
.head 3 -  String: MSG_BankDayIsOpen
.head 3 -  String: MSG_DayCloseSuccess
.head 3 -  !
.head 3 -  String: MSG_VerbLock
.head 3 -  String: MSG_VerbUnLock
.head 3 -  !
.head 3 -  String: MSG_Q_K0FilesProcess
.head 3 -  String: MSG_Q_KFilesProcess
.head 3 -  String: MSG_Q_VFilesProcess
.head 3 -  String: MSG_Q_StartDirLock
.head 3 -  String: MSG_Q_BackDirLock
.head 3 -  String: MSG_Q_AllDirLock
.head 3 -  !
.head 3 -  String: MSG_InputDate
.head 3 -  String: MSG_InvalidDateWarn
.head 3 -  String: MSG_OpenBankDate
.head 3 -  String: MSG_AccAmountChange4DateWarn
.head 3 -  String: MSG_DateUnChangeWarn
.head 3 -  ! BANKAPI.APL - Переменные
.head 3 -  String: strDirMfo
.head 3 -  Boolean: bWinWait
.head 2 +  Internal Functions
.head 3 +  Function: BnkapiIni
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strPathToLangResources
.head 5 -  String: strLangId
.head 5 -  !
.head 5 -  String: strFileName
.head 4 +  Actions
.head 5 +  If NOT fInitLib
.head 6 -  Set strPathToLangResources = GetLangPath()
.head 6 -  Set strLangId = GetLang()
.head 6 -  Set strFileName = strPathToLangResources || "\\" || strLangId || "\\bankapi.lng"
.head 6 -  !
.head 6 +  If (NOT strLangId) OR (NOT CurrentLangTable.InitFromFile( strFileName, strLangId ))
.head 7 -  Call CurrentLangTable.Init()
.head 7 -  !
.head 7 -  Call CurrentLangTable.AddAtom('cTAt', 'Внимание!')
.head 7 -  Call CurrentLangTable.AddAtom('cTErr','Ошибка!')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_CustomerLockWarnP1','В списке прямых участников СЭП расчетов есть ')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_NonQuitDocsCheck',  'Проверка "незаквитованых" документов СЭП...')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_CheckMfo',          'Проверяем банк - МФО')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_BanksInitFail',     'Ошибка при инициализации таблицы "Участники СЭП" (Banks)')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_CustomerWillBeLockWarnP1','Участник СЭП - МФО банка')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_CustomerWillBeLockWarnP2',' будет блокирован')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_DirCustomerSelect', 'Выбор прямых участников СЭП')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_VFilesInProgress',  'Формируются выписки (V файлы)...')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_TableClean',        'Очистка таблицы:')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_TmpTableInitFail',  'Ошибка при инициализации таблицы БД: ')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_FlagsSetting',      'Установка флагов в таблице PARAMS')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_AuditBankDateChange','Изменение Банковской даты на ')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_FlagName_BankDate', 'Текущая Банковская дата')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_FlagName_DayOpen',  'Признак открытия дня')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_BankDayIsOpen',     'Операционный день банка открыт.')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_DayCloseSuccess',   'Закрытие дня банка прошло успешно!')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_VerbLock',          'Блокировать ')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_VerbUnLock',        'Разблокировать ')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_Q_K0FilesProcess',  'Формировать файлы "K0" на участников СЭП?')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_Q_KFilesProcess',   'Формировать файлы "K" на участников СЭП?')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_Q_VFilesProcess',   'Формировать файлы-выписки "V" на участников СЭП?')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_Q_StartDirLock',    '"начальные" для подчиненных РП?')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_Q_BackDirLock',     '"ответные" для подчиненных РП?')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_Q_AllDirLock',      'все направления для подчиненных РП?')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_InputDate',         'Введите дату (ДД/ММ/ГГГГ)')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_InvalidDateWarn',   'Неверное значение даты!')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_OpenBankDate',      'Открыть новый день')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_AccAmountChange4DateWarn','Значения остатков на счетах будут пересчитаны для новой Банковской даты!')
.head 7 -  Call CurrentLangTable.AddAtom('cTMSG_DateUnChangeWarn',  'Дата Банковского дня не изменяется!')
.head 7 -  ! ====================================================
.head 7 -  ! dlg_OpenBankDay
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.cTWndTitle','Открытие банковского дня')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.pbOpenDay','Выполнить ')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.pbExit','Отменить')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.bgToday','Сегодня:')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.bgOpened','Открыть банковский день')
.head 7 -  ! Msg
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.cTMsgBankDayNotAcceess','Банковский день НЕДОСТУПЕН для работы!')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.cTMsgBankDayNotOpen','Невозможно открыть банковский день!')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.cTMsgBankDayHoliday','выходной')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.cTMsgProc1','При выполнении процедур открытия дня были ошибки!')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.cTMsgProc2','При выполнении процедур открытия дня были пропущены некоторые функции!')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.cTMsgProc4','Выполнение процедур открытия дня было прервано!')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.cTMsgProc0','Выполнение процедур открытия дня успешно завершено')
.head 7 -  ! Constant
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.cTOpened1','Банковский день открыт')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.cTOpened2','Открыть банковский день')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.cTDay0','суббота')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.cTDay1','воскресенье')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.cTDay2','понедельник')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.cTDay3','вторник')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.cTDay4','среда')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.cTDay5','четверг')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.cTDay6','пятница')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.cTProcList','список процедур, сопутсвующих открытию')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.cTOpenBDay','открытие банковского дня и')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_OpenBankDay.cTStatusExit','Завершить работу с диалогом')
.head 7 -  ! ====================================================
.head 7 -  ! dlg_CloseBankDay
.head 7 -  Call CurrentLangTable.AddAtom('dlg_CloseBankDay.cTWndTitle','Закрытие банковского дня')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_CloseBankDay.pbCloseDay','Выполнить ')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_CloseBankDay.pbExit','Отменить')
.head 7 -  ! Msg
.head 7 -  Call CurrentLangTable.AddAtom('dlg_CloseBankDay.cTMsgProc1','При выполнении процедур закрытия дня были ошибки!')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_CloseBankDay.cTMsgProc2','При выполнении процедур закрытия дня были пропущены некоторые функции!')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_CloseBankDay.cTMsgProc4','Выполнение процедур закрытия дня было прервано!')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_CloseBankDay.cTMsgProc0','Выполнение процедур закрытия дня успешно завершено')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_CloseBankDay.cTMsgClose','Закрывать день?')
.head 7 -  ! Constant
.head 7 -  Call CurrentLangTable.AddAtom('dlg_CloseBankDay.cTOpened1','Банковский день')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_CloseBankDay.cTOpened2','Банковский день закрыт')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_CloseBankDay.cTStatusCloseDay','Закрыть банковский день')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_CloseBankDay.cTQuestion','Выполнить закрытие банковского дня и список процедур, сопутсвующих закрытию?')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_CloseBankDay.cTStatusOk','Готово')
.head 7 -  ! ====================================================
.head 7 -  ! ShowOpenBankDay
.head 7 -  Call CurrentLangTable.AddAtom('ShowOpenBankDay.cTMsgOpenChange','Операция открытия банковского дня не может быть произведена в данном рабочем дне! Смените рабочую дату на')
.head 7 -  ! ====================================================
.head 7 -  ! ShowCloseBankDay
.head 7 -  Call CurrentLangTable.AddAtom('ShowCloseBankDay.cTMsgCloseChange','Операция закрытия банковского дня не может быть произведена в данном рабочем дне! Смените рабочую дату на')
.head 7 -  ! ====================================================
.head 7 -  ! BnkCloseDay
.head 7 -  Call CurrentLangTable.AddAtom('BnkCloseDay.cTErrFileV','Ошибка создания файла-флага V в директории')
.head 7 -  ! ====================================================
.head 7 -  ! BnkOpenDay
.head 7 -  Call CurrentLangTable.AddAtom('BnkOpenDay.cTMsgBankDay','Обновление рабочей банковской даты для пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('BnkOpenDay.cTErrFileK0','Ошибка создания файла-флага K0 в директории')
.head 7 -  ! ====================================================
.head 7 -  Call CurrentLangTable.AddAtom('cTErrFileK','Ошибка создания файла-флага K в директории')
.head 7 -  ! BnkLockPtsOutDir
.head 7 -  Call CurrentLangTable.AddAtom('BnkLockPtsOutDir.cTBlock','Блокировка начальных платежей')
.head 7 -  ! ====================================================
.head 7 -  ! BnkUnLockPtsOutDir
.head 7 -  Call CurrentLangTable.AddAtom('BnkUnLockPtsOutDir.cTUnBlock','Разблокировка начальных платежей')
.head 7 -  ! ====================================================
.head 7 -  ! BnkLockPtsInDir
.head 7 -  Call CurrentLangTable.AddAtom('BnkLockPtsInDir.cTBlock','Блокировка ответных платежей')
.head 7 -  ! ====================================================
.head 7 -  ! BnkUnLockPtsInDir
.head 7 -  Call CurrentLangTable.AddAtom('BnkUnLockPtsInDir.cTUnBlock','Разблокировка ответных платежей')
.head 7 -  ! ====================================================
.head 7 -  ! BnkLockPtsAllDir
.head 7 -  Call CurrentLangTable.AddAtom('BnkLockPtsAllDir.cTBlock','Блокировка всех направлений')
.head 7 -  ! ====================================================
.head 7 -  ! BnkUnLockPtsAllDir
.head 7 -  Call CurrentLangTable.AddAtom('BnkUnLockPtsAllDir.cTUnBlock','Разблокировка всех направлений')
.head 7 -  ! ====================================================
.head 6 -  Set MSG_CustomerLockWarnP1  = CurrentLangTable.GetAtomTitle('cTMSG_CustomerLockWarnP1')
.head 6 -  Set MSG_NonQuitDocsCheck    = CurrentLangTable.GetAtomTitle('cTMSG_NonQuitDocsCheck')
.head 6 -  Set MSG_CheckMfo            = CurrentLangTable.GetAtomTitle('cTMSG_CheckMfo') || ': '
.head 6 -  Set MSG_BanksInitFail       = CurrentLangTable.GetAtomTitle('cTMSG_BanksInitFail')
.head 6 -  Set MSG_CustomerWillBeLockWarnP1 = CurrentLangTable.GetAtomTitle('cTMSG_CustomerWillBeLockWarnP1') || ': '
.head 6 -  Set MSG_CustomerWillBeLockWarnP2 = ' ' || CurrentLangTable.GetAtomTitle('cTMSG_CustomerWillBeLockWarnP2')
.head 6 -  Set MSG_DirCustomerSelect   = ' [ ' || CurrentLangTable.GetAtomTitle('cTMSG_DirCustomerSelect') || ' ]'
.head 6 -  Set MSG_VFilesInProgress    = CurrentLangTable.GetAtomTitle('cTMSG_VFilesInProgress')
.head 6 -  !
.head 6 -  Set MSG_TableClean_Z        = CurrentLangTable.GetAtomTitle('cTMSG_TableClean') || ' Z'
.head 6 -  Set MSG_TableClean_SALDOH   = CurrentLangTable.GetAtomTitle('cTMSG_TableClean') || ' SALDOH'
.head 6 -  Set MSG_TableClean_LIMHIST  = CurrentLangTable.GetAtomTitle('cTMSG_TableClean') || ' LIM_HIST'
.head 6 -  Set MSG_TableClean_SEC_AUDIT= CurrentLangTable.GetAtomTitle('cTMSG_TableClean') || ' SEC_AUDIT'
.head 6 -  Set MSG_TableClean_REF_LST  = CurrentLangTable.GetAtomTitle('cTMSG_TableClean') || ' REF_LST'
.head 6 -  !
.head 6 -  Set MSG_TmpTableInitFail    = CurrentLangTable.GetAtomTitle('cTMSG_TmpTableInitFail') || ': '
.head 6 -  !
.head 6 -  Set MSG_FlagsSetting        = CurrentLangTable.GetAtomTitle('cTMSG_FlagsSetting')
.head 6 -  !
.head 6 -  Set MSG_AuditBankDateChange = CurrentLangTable.GetAtomTitle('cTMSG_AuditBankDateChange') || ' '
.head 6 -  Set MSG_FlagName_BankDate   = CurrentLangTable.GetAtomTitle('cTMSG_FlagName_BankDate')
.head 6 -  Set MSG_FlagName_DayOpen    = CurrentLangTable.GetAtomTitle('cTMSG_FlagName_DayOpen')
.head 6 -  Set MSG_BankDayIsOpen       = CurrentLangTable.GetAtomTitle('cTMSG_BankDayIsOpen')
.head 6 -  Set MSG_DayCloseSuccess     = CurrentLangTable.GetAtomTitle('cTMSG_DayCloseSuccess')
.head 6 -  !
.head 6 -  Set MSG_VerbLock            = CurrentLangTable.GetAtomTitle('cTMSG_VerbLock') || ' '
.head 6 -  Set MSG_VerbUnLock          = CurrentLangTable.GetAtomTitle('cTMSG_VerbUnLock') || ' '
.head 6 -  !
.head 6 -  Set MSG_Q_K0FilesProcess    = CurrentLangTable.GetAtomTitle('cTMSG_Q_K0FilesProcess')
.head 6 -  Set MSG_Q_KFilesProcess     = CurrentLangTable.GetAtomTitle('cTMSG_Q_KFilesProcess')
.head 6 -  Set MSG_Q_VFilesProcess     = CurrentLangTable.GetAtomTitle('cTMSG_Q_VFilesProcess')
.head 6 -  Set MSG_Q_StartDirLock      = CurrentLangTable.GetAtomTitle('cTMSG_Q_StartDirLock')
.head 6 -  Set MSG_Q_BackDirLock       = CurrentLangTable.GetAtomTitle('cTMSG_Q_BackDirLock')
.head 6 -  Set MSG_Q_AllDirLock        = CurrentLangTable.GetAtomTitle('cTMSG_Q_AllDirLock')
.head 6 -  !
.head 6 -  Set MSG_InputDate           = CurrentLangTable.GetAtomTitle('cTMSG_InputDate')
.head 6 -  Set MSG_InvalidDateWarn     = CurrentLangTable.GetAtomTitle('cTMSG_InvalidDateWarn')
.head 6 -  Set MSG_OpenBankDate        = CurrentLangTable.GetAtomTitle('cTMSG_OpenBankDate')
.head 6 -  Set MSG_AccAmountChange4DateWarn = CurrentLangTable.GetAtomTitle('cTMSG_AccAmountChange4DateWarn')
.head 6 -  Set MSG_DateUnChangeWarn    = CurrentLangTable.GetAtomTitle('cTMSG_DateUnChangeWarn')
.head 6 -  !
.head 6 -  Set fInitLib = TRUE
.head 5 -  ! Call CurrentLangTable.SaveToFile('C:\\TEMP\\bankapi_.lng','RUS')
.head 5 -  Return fInitLib
.head 3 -  ! BANKAPI.APL - Функции
.head 3 +  Function: ShowOpenBankDay	! __exported
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call BnkapiIni()
.head 5 +  If GetBankDate() = GetParamBankDate()
.head 6 -  Call SalModalDialog(dlg_OpenBankDay, hWndForm)
.head 5 +  Else
.head 6 -  Call SalMessageBeep( MB_IconStop )
.head 6 -  ! Call MessageError( 'Операция открытия банковского дня не может быть произведена в данном ' || 
'рабочем дне! Смените рабочую дату на ' || SalFmtFormatDateTime(GetParamBankDate(), 'dd/MM/yyyy') )
.head 6 -  Call MessageError( CurrentLangTable.GetAtomTitle('ShowOpenBankDay.cTMsgOpenChange') || ' ' || SalFmtFormatDateTime(GetParamBankDate(), 'dd/MM/yyyy') )
.head 3 +  Function: ShowCloseBankDay	! __exported
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call BnkapiIni()
.head 5 +  If GetBankDate() = GetParamBankDate()
.head 6 -  Call SalModalDialog(dlg_CloseBankDay, hWndForm)
.head 5 +  Else
.head 6 -  Call SalMessageBeep( MB_IconStop )
.head 6 -  ! Call MessageError( 'Операция открытия банковского дня не может быть произведена в данном ' ||
'рабочем дне! Смените рабочую дату на ' || SalFmtFormatDateTime(GetParamBankDate(), 'dd/MM/yyyy') )
.head 6 -  Call MessageError( CurrentLangTable.GetAtomTitle('ShowOpenBankDay.cTMsgCloseChange') || ' ' || SalFmtFormatDateTime(GetParamBankDate(), 'dd/MM/yyyy') )
.head 3 -  !
.head 3 +  Function: BnkCloseDay		! __exported
.head 4 -  Description: Закрыть банковский день
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  File Handle: hFile
.head 5 -  Number: nCountDelay
.head 4 +  Actions
.head 5 -  Call BnkapiIni()
.head 5 +  If GetBankDate() != GetParamBankDate()
.head 6 -  Return FALSE
.head 5 +  If GetBankModel() = 3
.head 6 +  If MessageQuestion(MSG_Q_VFilesProcess) = IDYES
.head 7 +  If SalFileOpen(hFile, GetIntDir() || FILE_V(),
   OF_Binary | OF_Create)
.head 8 -  Call SalFileClose(hFile)
.head 7 +  Else
.head 8 -  ! Return MessageError('Ошибка создания файла-флага V в директории: ' || GetIntDir())
.head 8 -  Return MessageError(CurrentLangTable.GetAtomTitle('BnkCloseDay.cTErrFileV') || ': ' || GetIntDir())
.head 7 -  Call SalCreateWindow(win_wait, hWndForm,
       MSG_VFilesInProgress)
.head 7 +  Loop
.head 8 +  If not SalFileOpen(hFile, GetIntDir() || FILE_V(),
   OF_Exist | OF_Share_Compat)
.head 9 -  Break
.head 8 -  Set nCountDelay = 1000
.head 8 +  Loop
.head 9 +  If nCountDelay <= 0
.head 10 -  Break
.head 9 -  Set nCountDelay = nCountDelay - 1
.head 7 -  Call SalDestroyWindow(win_wait)
.head 5 +  If not PutGlobalOption(CFG_BANKDAY(), '0')
.head 6 -  Return FALSE
.head 5 -  Call MessageInfo(MSG_DayCloseSuccess)
.head 5 -  Return TRUE
.head 3 +  Function: BnkOpenDay		! __exported
.head 4 -  Description: Открыть банковский день
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Date/Time: dtBankDay
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  File Handle: hFile
.head 4 +  Actions
.head 5 -  Call BnkapiIni()
.head 5 +  If GetBankDate() != GetParamBankDate()
.head 6 -  Return FALSE
.head 5 -  Call WaitCursorOn()
.head 5 +  If not SetBankDate(dtBankDay)
.head 6 -  Call WaitCursorOff()
.head 6 -  Return FALSE
.head 5 +  If not SetWorkBankDate(dtBankDay)
.head 6 -  Call WaitCursorOff()
.head 6 -  Return FALSE
.head 5 +  If not ExecuteParams()
.head 6 -  Call WaitCursorOff()
.head 6 -  Return FALSE
.head 5 +  If not Pl_dat(dtBankDay)
.head 6 -  Call WaitCursorOff()
.head 6 -  Return FALSE
.head 5 -  Call SaveInfoToLog(MSG_AuditBankDateChange || GetBankDateEx())
.head 5 -  Call SalSendMsg(hWndMDI, UM_Update, 0, 0)
.head 5 +  If CheckGlobalOption(CFG_BANKDAY())
.head 6 -  Call PutGlobalOption(CFG_BANKDAY(), '1')
.head 5 +  Else
.head 6 -  Call AddNewGlobalOption(CFG_BANKDAY(), '1', MSG_FlagName_DayOpen)
.head 5 +  If GetBankModel() = 3
.head 6 +  If MessageQuestion(MSG_Q_K0FilesProcess) = IDYES
.head 7 +  If SalFileOpen(hFile, GetIntDir() || FILE_K0(), OF_Create | OF_Binary | OF_Write)
.head 8 -  Call SalFileClose(hFile)
.head 7 +  Else
.head 8 -  ! Return MessageError('Ошибка создания файла-флага K0 в директории: ' || GetIntDir())
.head 8 -  Return MessageError(CurrentLangTable.GetAtomTitle('BnkOpenDay.cTErrFileK0') || ': ' || GetIntDir())
.head 5 -  Call SalStatusSetText(hWndForm, '')
.head 5 -  Call GetParamsSettings(hSql())
.head 5 +  If SqlPLSQLCommand(hSql(), "set_bankdate(dtBankDay) ")
.head 6 -  ! Call SqlCommitEx(hSql(), 'Обновление рабочей банковской даты для пользователя' )
.head 6 -  Call SqlCommitEx(hSql(), CurrentLangTable.GetAtomTitle('BnkOpenDay.cTMsgBankDay'))
.head 5 +  Else
.head 6 -  Call SqlRollbackEx(hSql(), 'Неуспешное обновление рабочей банковской даты для пользователя')
.head 5 -  Call WaitCursorOff()
.head 5 -  Call MessageAttention(MSG_BankDayIsOpen)
.head 5 -  Return TRUE
.head 3 -  !
.head 3 +  Function: BnkLockPtsOutDir	! __exported
.head 4 -  Description: Блокировать начальные платежи
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  File Handle: hFile
.head 5 -  String: strBankMfo
.head 4 +  Actions
.head 5 -  Call BnkapiIni()
.head 5 +  If MessageQuestion(MSG_VerbLock || MSG_Q_StartDirLock) =
   IDYES
.head 6 -  Set strBankMfo = GetBankMfo()
.head 6 +  If SqlPrepareAndExecute(hSql(), T('
   update lkl_rrp set blk=1 where blk=0 and mfo in 
   (select mfo from banks 
    where mfop=trim(:strBankMfo) and kodn in(0,4,6))'))
.head 7 -  ! Call SqlCommitEx(hSql(), 'Блокировка начальных платежей')
.head 7 -  Call SqlCommitEx(hSql(), CurrentLangTable.GetAtomTitle('BnkLockPtsOutDir.cTBlock'))
.head 7 +  If SalFileOpen(hFile, GetIntDir() || FILE_K(),
   OF_Create | OF_Binary | OF_Write) = TRUE
.head 8 -  Call SalFileClose(hFile)
.head 7 +  Else
.head 8 -  ! Return MessageError('Ошибка создания файла-флага K в директории: ' || GetIntDir())
.head 8 -  Return MessageError(CurrentLangTable.GetAtomTitle('cTErrFileK') || ': ' || GetIntDir())
.head 3 +  Function: BnkUnLockPtsOutDir	! __exported
.head 4 -  Description: Разблокировать начальные платежи
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  File Handle: hFile
.head 5 -  String: strBankMfo
.head 4 +  Actions
.head 5 -  Call BnkapiIni()
.head 5 +  If MessageQuestion(MSG_VerbUnLock || MSG_Q_StartDirLock) =
   IDYES
.head 6 -  Set strBankMfo = GetBankMfo()
.head 6 +  If SqlPrepareAndExecute(hSql(), T('
   update lkl_rrp set blk=0 where blk=1 and mfo in 
   (SELECT mfo FROM banks WHERE mfop=trim(:strBankMfo) and kodn IN(0,4,6))'))
.head 7 -  ! Call SqlCommitEx(hSql(), 'Разблокировка начальных платежей')
.head 7 -  Call SqlCommitEx(hSql(),CurrentLangTable.GetAtomTitle('BnkUnLockPtsOutDir.cTUnBlock'))
.head 7 +  If MessageQuestion(MSG_Q_KFilesProcess) = IDYES
.head 8 +  If SalFileOpen(hFile, GetIntDir() || FILE_K(),
   OF_Create | OF_Binary | OF_Write) = TRUE
.head 9 -  Call SalFileClose(hFile)
.head 8 +  Else
.head 9 -  ! Return MessageError('Ошибка создания файла-флага ' ||'K в директории: ' || GetIntDir())
.head 9 -  Return MessageError(CurrentLangTable.GetAtomTitle('cTErrFileK') || ': ' || GetIntDir())
.head 3 +  Function: BnkLockPtsInDir	! __exported
.head 4 -  Description: Блокировать ответные платежи
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  File Handle: hFile
.head 5 -  String: strBankMfo
.head 4 +  Actions
.head 5 -  Call BnkapiIni()
.head 5 +  If MessageQuestion(MSG_VerbLock || MSG_Q_BackDirLock) =
   IDYES
.head 6 -  Set strBankMfo = GetBankMfo()
.head 6 +  If SqlPrepareAndExecute(hSql(), T('
   update lkl_rrp set blk=2 where blk=0 and mfo in 
   (SELECT mfo FROM banks WHERE mfop=trim(:strBankMfo) and kodn IN(0,4,6))'))
.head 7 -  ! Call SqlCommitEx(hSql(), 'Блокировка ответных платежей')
.head 7 -  Call SqlCommitEx(hSql(),CurrentLangTable.GetAtomTitle('BnkLockPtsInDir.cTBlock'))
.head 7 +  If SalFileOpen(hFile, GetIntDir() || FILE_K(),
   OF_Create | OF_Binary | OF_Write) = TRUE
.head 8 -  Call SalFileClose(hFile)
.head 7 +  Else
.head 8 -  ! Return MessageError(
           'Ошибка создания файла-флага K в директории: ' ||
            GetIntDir())
.head 8 -  Return MessageError(CurrentLangTable.GetAtomTitle('cTErrFileK') || ': ' || GetIntDir())
.head 3 +  Function: BnkUnLockPtsInDir	! __exported
.head 4 -  Description: Разблокировать ответные платежи
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  File Handle: hFile
.head 5 -  String: strBankMfo
.head 4 +  Actions
.head 5 -  Call BnkapiIni()
.head 5 +  If MessageQuestion(
   MSG_VerbUnLock || MSG_Q_BackDirLock) = IDYES
.head 6 -  Set strBankMfo = GetBankMfo()
.head 6 +  If SqlPrepareAndExecute(hSql(), T('
   update lkl_rrp set blk=0 where blk=2 and mfo in 
   (SELECT mfo FROM banks WHERE mfop=trim(:strBankMfo) and kodn IN(0,4,6))'))
.head 7 -  ! Call SqlCommitEx(hSql(),
       'Разблокировка ответных платежей')
.head 7 -  Call SqlCommitEx(hSql(),CurrentLangTable.GetAtomTitle('BnkUnLockPtsInDir.cTUnBlock'))
.head 7 +  If MessageQuestion(MSG_Q_KFilesProcess) = IDYES
.head 8 +  If SalFileOpen(hFile, GetIntDir() || FILE_K(),
   OF_Create | OF_Binary | OF_Write) = TRUE
.head 9 -  Call SalFileClose(hFile)
.head 8 +  Else
.head 9 -  ! Return MessageError('Ошибка создания файла-флага ' ||
           'K в директории: ' || GetIntDir())
.head 9 -  Return MessageError(CurrentLangTable.GetAtomTitle('cTErrFileK') || ': ' || GetIntDir())
.head 3 +  Function: BnkLockPtsAllDir	! __exported
.head 4 -  Description: Блокировать все направления
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  File Handle: hFile
.head 5 -  String: strBankMfo
.head 4 +  Actions
.head 5 -  Call BnkapiIni()
.head 5 +  If MessageQuestion(MSG_VerbLock || MSG_Q_AllDirLock) =
   IDYES
.head 6 -  Set strBankMfo = GetBankMfo()
.head 6 +  If SqlPrepareAndExecute(hSql(), T('
   update lkl_rrp set blk=3 where blk=0 and mfo in 
   (SELECT mfo FROM banks WHERE mfop=trim(:strBankMfo) and kodn IN(0,4,6))'))
.head 7 -  ! Call SqlCommitEx(hSql(), 'Блокировка всех направлений')
.head 7 -  Call SqlCommitEx(hSql(), CurrentLangTable.GetAtomTitle('BnkLockPtsAllDir.cTBlock'))
.head 7 +  If SalFileOpen(hFile, GetIntDir() || FILE_K(),
   OF_Create | OF_Binary | OF_Write) = TRUE
.head 8 -  Call SalFileClose(hFile)
.head 7 +  Else
.head 8 -  ! Return MessageError('Ошибка создания файла-флага K в директории: ' || GetIntDir())
.head 8 -  Return MessageError(CurrentLangTable.GetAtomTitle('cTErrFileK') || ': ' || GetIntDir())
.head 3 +  Function: BnkUnLockPtsAllDir	! __exported
.head 4 -  Description: Разблокировать все направления
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  File Handle: hFile
.head 5 -  String: strBankMfo
.head 4 +  Actions
.head 5 -  Call BnkapiIni()
.head 5 +  If MessageQuestion(MSG_VerbUnLock || MSG_Q_AllDirLock) =
   IDYES
.head 6 -  Set strBankMfo = GetBankMfo()
.head 6 +  If SqlPrepareAndExecute(hSql(), T('
   update lkl_rrp set blk=0 where blk=3 and mfo in 
   (SELECT mfo FROM banks WHERE mfop=trim(:strBankMfo) and kodn IN(0,4,6))'))
.head 7 -  ! Call SqlCommitEx(hSql(), 'Разблокировка всех направлений')
.head 7 -  Call SqlCommitEx(hSql(),CurrentLangTable.GetAtomTitle('BnkUnLockPtsAllDir.cTUnBlock'))
.head 7 +  If MessageQuestion(MSG_Q_KFilesProcess) = IDYES
.head 8 +  If SalFileOpen(hFile, GetIntDir() || FILE_K(),
   OF_Create | OF_Binary | OF_Write) = TRUE
.head 9 -  Call SalFileClose(hFile)
.head 8 +  Else
.head 9 -  ! Return MessageError('Ошибка создания файла-флага ' ||
           'K в директории: ' || GetIntDir())
.head 9 -  Return MessageError(CurrentLangTable.GetAtomTitle('cTErrFileK') || ': ' || GetIntDir())
.head 3 +  ! Function: BnkIsValidMfo		! __exported
.head 4 -          Description: Проверка кода МФО банка
.head 4 +          Returns
.head 5 -          Boolean: fValidMFO
.head 4 +          Parameters
.head 5 -          String: sMFO
.head 4 -          Static Variables
.head 4 +          Local variables
.head 5 -          Number: i
.head 5 -          Number: nSumDigits
.head 5 -          Number: nWeight[5]
.head 5 -          Number: nMFO
.head 4 +          Actions
.head 5 -  ! /////////////////////////////////////////////////////////////////////////////////////////////////////////////
.head 5 -  !
.head 5 -          Set nMFO = SalStrToNumber(sMFO)
.head 5 -          Set nWeight[ 0 ] = 1
.head 5 -          Set nWeight[ 1 ] = 3
.head 5 -          Set nWeight[ 2 ] = 7
.head 5 -          Set nWeight[ 3 ] = 1
.head 5 -          Set nWeight[ 4 ] = 3
.head 5 -          Set i = 0
.head 5 -          Set nSumDigits = 0
.head 5 +          While i < 5
.head 6 -          Set nSumDigits = nSumDigits +
    GetLastDigit(nWeight[ i ] * GetDigit(nMFO, i))
.head 6 -          Set i = i + 1
.head 5 -          Set nSumDigits = GetLastDigit(nSumDigits * 7)
.head 5 -  ! Call MessageInfo('Последняя цифра = ' ||
         SalNumberToStrX(nSumDigits, 0))
.head 5 -          Return GetLastDigit(nMFO) = nSumDigits
.head 3 +  Function: InitRefLstTable
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nRecCount
.head 5 -  Number: nFetchRes
.head 4 +  Actions
.head 5 +  While TRUE
.head 6 -  Call SaveInfoToLog(
      'Контроль числа записей в таблице REF_LST')
.head 6 -  !
.head 6 +  If SqlPrepareAndExecute(hSql(), T('
   SELECT count(*)
   FROM Ref_lst
   INTO :nRecCount')) = FALSE
.head 7 -  Call SaveInfoToLog(
      'Ошибка получения числа записей в таблице REF_LST')
.head 7 -  Break
.head 6 +  If SqlFetchNext(hSql(), nFetchRes) = FALSE
.head 7 -  Break
.head 6 -  ! Call Debug(NumberToStr(nRecCount))
.head 6 +  If nRecCount > 1000000
.head 7 +  If MessageQuestion('Выполнить очистку таблицы ' ||
   'Контроля уникальности платежей СЭП - REF_LST?')
   = IDNO
.head 8 -  Return FALSE
.head 6 +  Else
.head 7 -  Return FALSE
.head 6 +  If SqlPrepareAndExecute(hSql(), T('
   DROP TABLE Ref_lst')) = FALSE
.head 7 -  Call SaveInfoToLog('Ошибка удаления таблицы REF_LST')
.head 7 -  Break
.head 6 -  Call SaveInfoToLog('Таблица REF_LST удалена')
.head 6 +  If SqlPrepareAndExecute(hSql(), T('
   CREATE TABLE Ref_lst (mfoa varchar(12),
                                              data date,
                                              datp date,
                                              ref_a varchar(9),
                                              rec integer,
                                              unique (mfoa, datp, ref_a)
   CONSTRAINT uniq_doc)
   IN ' || GetDefDbs() || '
   EXTENT size 10000
   NEXT size 10000
   lock mode row')) = FALSE
.head 7 -  Call SaveInfoToLog('Ошибка создания таблицы REF_LST')
.head 7 -  Break
.head 6 +  If SqlCommitEx(hSql(), MSG_TableClean_REF_LST) = FALSE
.head 7 -  Break
.head 6 -  Call SaveInfoToLog('Таблица REF_LST создана')
.head 6 +  If SqlPrepareAndExecute(hSql(), T('
   UPDATE STATISTICS for table Ref_lst')) = FALSE
.head 7 -  Call SaveInfoToLog('Ошибка выполнения SQL-оператора ' ||
      'UPDATE STATISTICS для таблицы REF_LST')
.head 7 -  Break
.head 6 -  Call SaveInfoToLog('Выполнен SQL-оператор UPDATE ' ||
      'STATISTICS для таблицы REF_LST')
.head 6 -  Return TRUE
.head 5 -  Call SqlRollback(hSql())
.head 5 -  Return MessageError(MSG_TmpTableInitFail || 'REF_LST')
.head 2 -  Named Menus
.head 2 +  Class Definitions
.head 2 +  Default Classes
.head 3 -  MDI Window: cBaseMDI
.head 3 -  Form Window:
.head 3 -  Dialog Box:
.head 3 -  Table Window:
.head 3 -  Quest Window:
.head 3 -  Data Field:
.head 3 -  Spin Field:
.head 3 -  Multiline Field:
.head 3 -  Pushbutton: cPushButtonLabeled
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
.head 1 +  Dialog Box: dlg_CloseBankDay
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Закрытие банковского дня
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? No
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   3.75"
.head 4 -  Top:    1.542"
.head 4 -  Width:  5.217"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 2.49"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: MS Sans Serif
.head 3 -  Font Size: 8
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Закрыть банковский день
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? No
.head 4 -  Size: Default
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  Data Field: dfOpened
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
.head 6 -  Left:   0.2"
.head 6 -  Top:    0.286"
.head 6 -  Width:  4.733"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Center
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Arial
.head 5 -  Font Size: 12
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Black
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfBankDay
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
.head 6 -  Left:   1.614"
.head 6 -  Top:    0.604"
.head 6 -  Width:  1.883"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.333"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Date
.head 5 -  Country: Default
.head 5 -  Font Name: Arial
.head 5 -  Font Size: 12
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsg(hWndItem, UM_ObjActivate, 0, 0)
.head 5 +  On UM_ObjActivate
.head 6 -  Set dfBankDay = GetBankDate()
.head 6 +  If IsBankDayOpen()
.head 7 -  ! Set dfOpened='Банковский день'
.head 7 -  Set dfOpened = CurrentLangTable.GetAtomTitle('dlg_CloseBankDay.cTOpened1')
.head 6 +  Else
.head 7 -  ! Set dfOpened='Банковский день закрыт'
.head 7 -  Set dfOpened = CurrentLangTable.GetAtomTitle('dlg_CloseBankDay.cTOpened2')
.head 7 -  Call SalDisableWindow(pbCloseDay)
.head 3 +  Pushbutton: pbCloseDay
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выполнить
.head 4 -  Window Location and Size
.head 5 -  Left:   0.514"
.head 5 -  Top:    1.333"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\APPLY.BMP
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  ! Call SalStatusSetText(hWndForm, 'Закрыть банковский день')
.head 6 -  Call SalStatusSetText(hWndForm, CurrentLangTable.GetAtomTitle('dlg_CloseBankDay.cTStatusCloseDay'))
.head 5 +  On SAM_KillFocus
.head 6 -  Call SalStatusSetText(hWndForm, '')
.head 5 +  On SAM_Click
.head 6 +  If IsBankDayOpen()
.head 7 -  ! Set sTmp='Выполнить закрытие банковского дня и список процедур, сопутсвующих закрытию?'
.head 7 -  Set sTmp = CurrentLangTable.GetAtomTitle('dlg_CloseBankDay.cTQuestion')
.head 7 -  ! Запускаем процедуры списка закрытия дня в режиме подтверждения
.head 7 -  Set nRet = FListRun(1, FALSE)
.head 7 +  Select Case nRet
.head 8 +  Case 1
.head 9 -  ! Set sTmp = 'При выполнении процедур закрытия дня были ошибки!'
.head 9 -  Set sTmp = CurrentLangTable.GetAtomTitle('dlg_CloseBankDay.cTMsgProc1')
.head 9 -  Break
.head 8 +  Case 2
.head 9 -  ! Set sTmp = 'При выполнении процедур закрытия дня были пропущены некоторые функции!'
.head 9 -  Set sTmp = CurrentLangTable.GetAtomTitle('dlg_CloseBankDay.cTMsgProc2')
.head 9 -  Break
.head 8 +  Case 4
.head 9 -  ! Set sTmp = 'Выполнение процедур закрытия дня было прервано!'
.head 9 -  Set sTmp = CurrentLangTable.GetAtomTitle('dlg_CloseBankDay.cTMsgProc4')
.head 9 -  Break
.head 8 +  Default
.head 9 -  ! Set sTmp = 'Выполнение процедур закрытия дня успешно завершено'
.head 9 -  Set sTmp = CurrentLangTable.GetAtomTitle('dlg_CloseBankDay.cTMsgProc0')
.head 9 -  Break
.head 7 +  If nRet
.head 8 -  ! If SalMessageBox(sTmp || ' Закрывать день?', 'Внимание!', MB_YesNo | MB_IconAsterisk) = IDNO
.head 8 +  If SalMessageBox(sTmp || ' ' || 
  CurrentLangTable.GetAtomTitle('dlg_CloseBankDay.cTMsgClose'), 
  CurrentLangTable.GetAtomTitle('cTAt'), MB_YesNo | MB_IconAsterisk) = IDNO
.head 9 -  Return FALSE
.head 7 -  !
.head 7 +  If BnkCloseDay()
.head 8 -  Call SalDisableWindow(hWndItem)
.head 8 -  Call SalSendMsg(dfBankDay, UM_ObjActivate, 0, 0)
.head 8 -  Call SalSendMsg(hWndMDI, UM_Update, 0, 0)
.head 8 -  Call BDateNotify(dfBankDay, 0)
.head 8 -  ! Call XNetSendDayCloseMsg('Банковский день закрыт!')
.head 8 -  ! Call SalStatusSetText(hWndForm, 'Готово')
.head 8 -  Call SalStatusSetText(hWndForm, CurrentLangTable.GetAtomTitle('dlg_CloseBankDay.cTStatusOk'))
.head 3 +  Pushbutton: pbExit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отменить
.head 4 -  Window Location and Size
.head 5 -  Left:   3.114"
.head 5 -  Top:    1.344"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.448"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\DISCARD.BMP
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(hWndForm, 1)
.head 3 -  Frame
.head 4 -  Resource Id: 14734
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.057"
.head 5 -  Top:    0.042"
.head 5 -  Width:  5.017"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.208"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  String: sTmp
.head 3 -  Number: nRet
.head 3 -  Window Handle: hWndObject
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  ! Call PrepareWindowEx(hWndForm)
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 -  Call SetWindowFont(hWndForm)
.head 4 -  Call SalSendMsgToChildren( hWndForm, UM_QueryLabelText, 0, 0 )
.head 4 -  Call SalSetWindowText( hWndForm, CurrentLangTable.GetAtomTitle('dlg_CloseBankDay.cTWndTitle') )
.head 4 +  If not ShowInputPassword()
.head 5 -  Return SalEndDialog(hWndForm, FALSE)
.head 4 -  Call WaitCursorOn()
.head 4 -  Call SalSetFocus(pbExit)
.head 3 +  On SAM_CreateComplete
.head 4 -  Call WaitCursorOff()
.head 3 +  On SAM_Destroy
.head 4 -  Call WaitCursorOff()
.head 4 -  ! Disactivation of  function's role, which activated for calling window
.head 4 +  If SalStrTrimX(SalStrUpperX(GetDBMS())) = 'ORACLE'
.head 5 -  Call XRoleUnset(hSql(),'ShowCloseBankDay()')
.head 1 +  Dialog Box: dlg_OpenBankDay
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Открытие банковского дня
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   1.375"
.head 4 -  Top:    1.094"
.head 4 -  Width:  5.217"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 2.49"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? No
.head 3 -  Font Name: Arial
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description:
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? No
.head 4 -  Size: 0.286"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 -  Background Text: Сегодня:
.head 4 -  Resource Id: 14971
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.129"
.head 5 -  Top:    0.021"
.head 5 -  Width:  1.029"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.238"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 +  Data Field: bgToday
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
.head 3 +  Data Field: dfToday
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
.head 6 -  Left:   1.443"
.head 6 -  Top:    0.021"
.head 6 -  Width:  1.4"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.238"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Center
.head 5 -  Format: Date
.head 5 -  Country: Default
.head 5 -  Font Name: MS Sans Serif
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: 99/99/9999
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set dfToday = SalDateCurrent()
.head 3 -  Background Text: Открыть банковский день
.head 4 -  Resource Id: 47546
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.186"
.head 5 -  Top:    0.313"
.head 5 -  Width:  4.733"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Center
.head 4 -  Font Name: Arial
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgOpened
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
.head 3 +  Data Field: dfOpened
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
.head 6 -  Left:   0.2"
.head 6 -  Top:    0.286"
.head 6 -  Width:  4.733"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.271"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Center
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Arial
.head 5 -  Font Size: 12
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Black
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfBankDay
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
.head 6 -  Left:   1.614"
.head 6 -  Top:    0.604"
.head 6 -  Width:  1.883"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Date
.head 5 -  Country: Default
.head 5 -  Font Name: Arial
.head 5 -  Font Size: 12
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsg(hWndItem, UM_ObjActivate, 0, 0)
.head 5 +  On UM_ObjActivate
.head 6 +  If IsBankDayOpen()
.head 7 -  Call SalDisableWindow(hWndItem)
.head 7 -  Set dfBankDay = GetBankDate()
.head 7 -  ! Set dfOpened='Банковский день открыт'
.head 7 -  Set dfOpened = CurrentLangTable.GetAtomTitle('dlg_OpenBankDay.cTOpened1')
.head 6 +  Else
.head 7 -  Call SalEnableWindow(hWndItem)
.head 7 -  Set dfBankDay = GetBankDate() + 1
.head 7 +  Loop
.head 8 -  Call SqlPrepareAndExecute( hSql(), "
  SELECT holiday FROM  holiday
  WHERE kv=:nKv and holiday=:dfBankDay" )
.head 8 +  If SqlFetchNext( hSql(), nFetchRes )
.head 9 -  Set dfBankDay = dfBankDay + 1
.head 8 +  Else
.head 9 -  Break
.head 7 -  ! Set dfOpened='Открыть банковский день'
.head 7 -  Set dfOpened = CurrentLangTable.GetAtomTitle('dlg_OpenBankDay.cTOpened2')
.head 6 -  Call SalSendMsg(dfDay, UM_ObjActivate, 0, 0)
.head 5 +  On SAM_SetFocus
.head 6 -  Call SalStatusSetText(hWndForm, MSG_InputDate)
.head 5 +  On SAM_AnyEdit
.head 6 -  Call SalSendMsg(dfDay, UM_ObjActivate, 0, 0)
.head 5 +  On SAM_Validate
.head 6 +  If SalIsNull ( dfBankDay )
.head 7 -  Return VALIDATE_Ok
.head 6 +  If SalIsValidDateTime(dfBankDay)
.head 7 -  ! Call SqlPrepareAndExecute( hSql(), "
  SELECT holiday FROM  holiday
  WHERE kv=:nKv and holiday=:dfBankDay" )
.head 7 +  ! If SqlFetchNext( hSql(), nFetchRes )
.head 8 -  Call SalMessageBox( 'Невозможно открыть банковский день!
'|| SalFmtFormatDateTime( dfBankDay, 'dd/MM/yyyy' ) ||' - выходной!', 'Внимание!', MB_Ok | MB_IconStop )
.head 8 -  Call SalSendMsg(hWndItem, UM_ObjActivate, 0, 0)
.head 8 -  Return VALIDATE_Ok
.head 7 -  ! Else
.head 7 -  Call SqlPrepareAndExecute(hSql(), 'SELECT nvl(stat,0) INTO :nDayStat FROM fdat WHERE fdat = :dfBankDay')
.head 7 +  If SqlFetchNext( hSql(), nFetchRes ) AND nDayStat != 0
.head 8 -  Call SalMessageBeep( MB_IconStop )
.head 8 -  ! Call SalMessageBox( 'Банковский день НЕДОСТУПЕН для работы!', 'Внимание!', MB_Ok | MB_IconStop )
.head 8 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('dlg_OpenBankDay.cTMsgBankDayNotAcceess'), 
  CurrentLangTable.GetAtomTitle('cTAt'), MB_Ok | MB_IconStop )
.head 8 -  Return VALIDATE_Cancel
.head 7 -  Return VALIDATE_Ok
.head 6 +  Else
.head 7 -  Set dfDay = ''
.head 7 -  Return MessageErrorInput(MSG_InvalidDateWarn)
.head 3 +  Data Field: dfDay
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 11
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.2"
.head 6 -  Top:    0.969"
.head 6 -  Width:  4.733"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Center
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Arial
.head 5 -  Font Size: 12
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Blue
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On UM_ObjActivate
.head 6 -  Set nDay = SalDateWeekday(dfBankDay)
.head 6 +  Select Case (nDay)
.head 7 +  Case 0
.head 8 -  ! Set dfDay = 'суббота'
.head 8 -  Set dfDay = CurrentLangTable.GetAtomTitle('dlg_OpenBankDay.cTDay0')
.head 8 -  Break
.head 7 +  Case 1
.head 8 -  ! Set dfDay = 'воскресенье'
.head 8 -  Set dfDay = CurrentLangTable.GetAtomTitle('dlg_OpenBankDay.cTDay1')
.head 8 -  Break
.head 7 +  Case 2
.head 8 -  ! Set dfDay = 'понедельник'
.head 8 -  Set dfDay = CurrentLangTable.GetAtomTitle('dlg_OpenBankDay.cTDay2')
.head 8 -  Break
.head 7 +  Case 3
.head 8 -  ! Set dfDay = 'вторник'
.head 8 -  Set dfDay = CurrentLangTable.GetAtomTitle('dlg_OpenBankDay.cTDay3')
.head 8 -  Break
.head 7 +  Case 4
.head 8 -  ! Set dfDay = 'среда'
.head 8 -  Set dfDay = CurrentLangTable.GetAtomTitle('dlg_OpenBankDay.cTDay4')
.head 8 -  Break
.head 7 +  Case 5
.head 8 -  ! Set dfDay = 'четверг'
.head 8 -  Set dfDay = CurrentLangTable.GetAtomTitle('dlg_OpenBankDay.cTDay5')
.head 8 -  Break
.head 7 +  Case 6
.head 8 -  ! Set dfDay = 'пятница'
.head 8 -  Set dfDay = CurrentLangTable.GetAtomTitle('dlg_OpenBankDay.cTDay6')
.head 8 -  Break
.head 7 +  Default
.head 8 -  Set dfDay = ''
.head 6 -  ! Set nKv = GetBaseVal()
.head 6 -  Call SqlPrepareAndExecute(hSql(), T("
       SELECT holiday FROM holiday
       WHERE kv=:nKv and holiday=:dfBankDay"))
.head 6 -  Call SalColorSet(dfDay, COLOR_IndexWindowText,
       IifN(nDay<2 or SqlFetchNext(hSql(), nFetchRes),
       COLOR_Red, COLOR_Blue))
.head 3 +  Pushbutton: pbOpenDay
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выполнить
.head 4 -  Window Location and Size
.head 5 -  Left:   0.514"
.head 5 -  Top:    1.344"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\APPLY.BMP
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If NOT SalIsNull(dfBankDay)
.head 7 -  ! Set sTmp='список процедур, сопутсвующих открытию'
.head 7 -  Set sTmp = CurrentLangTable.GetAtomTitle('dlg_OpenBankDay.cTProcList')
.head 7 +  If not IsBankDayOpen()
.head 8 -  ! Set sTmp='открытие банковского дня и '||sTmp
.head 8 -  Set sTmp = CurrentLangTable.GetAtomTitle('dlg_OpenBankDay.cTOpenBDay') || ' '||sTmp
.head 7 +  If not IsBankDayOpen()
.head 8 -  Call SqlPrepareAndExecute(hSql(), 
"SELECT holiday FROM holiday
 WHERE kv=:nKv and holiday=:dfBankDay")
.head 8 +  If SqlFetchNext(hSql(), nFetchRes)
.head 9 -  ! Call SalMessageBox( 'Невозможно открыть банковский день!
'|| SalFmtFormatDateTime( dfBankDay, 'dd/MM/yyyy' ) ||' - выходной!', 'Внимание!', MB_Ok | MB_IconStop )
.head 9 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('dlg_OpenBankDay.cTMsgBankDayNotOpen') || PutCrLf() || 
  SalFmtFormatDateTime( dfBankDay, 'dd/MM/yyyy' ) || ' - ' || 
  CurrentLangTable.GetAtomTitle('dlg_OpenBankDay.cTMsgBankDayHoliday') || '!', 
  CurrentLangTable.GetAtomTitle('cTAt'), MB_Ok | MB_IconStop)
.head 9 -  Call SalSendMsg(dfBankDay, UM_ObjActivate, 0, 0)
.head 8 +  Else
.head 9 -  Set dtOldDate = GetBankDate()
.head 9 +  If BnkOpenDay(dfBankDay)
.head 10 -  Call SalDisableWindow(hWndItem)
.head 10 -  ! Вызываем прокрутку списка функций открития дня в режиме подтверждения
.head 10 -  Set nRet = FListRun(0, FALSE)
.head 10 +  Select Case nRet
.head 11 +  Case 1
.head 12 -  ! Set sTmp = 'При выполнении процедур открытия дня были ошибки!'
.head 12 -  Set sTmp = CurrentLangTable.GetAtomTitle('dlg_OpenBankDay.cTMsgProc1')
.head 12 -  Break
.head 11 +  Case 2
.head 12 -  ! Set sTmp = 'При выполнении процедур открытия дня были пропущены некоторые функции!'
.head 12 -  Set sTmp = CurrentLangTable.GetAtomTitle('dlg_OpenBankDay.cTMsgProc2')
.head 12 -  Break
.head 11 +  Case 4
.head 12 -  ! Set sTmp = 'Выполнение процедур открытия дня было прервано!'
.head 12 -  Set sTmp = CurrentLangTable.GetAtomTitle('dlg_OpenBankDay.cTMsgProc4')
.head 12 -  Break
.head 11 +  Default
.head 12 -  ! Set sTmp = 'Выполнение процедур открытия дня успешно завершено'
.head 12 -  Set sTmp = CurrentLangTable.GetAtomTitle('dlg_OpenBankDay.cTMsgProc0')
.head 12 -  Break
.head 10 +  If nRet
.head 11 -  Call SalMessageBox(sTmp, 
  CurrentLangTable.GetAtomTitle('cTAt'), MB_Ok | MB_IconAsterisk)
.head 10 -  !
.head 10 -  Call SalSendMsg(dfBankDay, UM_ObjActivate, 0, 0)
.head 10 -  Call SalSendMsg(hWndMDI, UM_Update, 0, 0)
.head 10 -  Call BDateNotify(dfBankDay, 1)
.head 10 -  Call BDateNotify(dtOldDate, 10)
.head 10 -  ! Call XNetSendDayOpenMsg('Банковский день открыт!')
.head 7 +  Else
.head 8 -  Call MessageAttention(MSG_DateUnChangeWarn)
.head 6 +  Else
.head 7 -  Call SalMessageBeep( MB_IconAsterisk )
.head 5 +  On SAM_SetFocus
.head 6 -  Call SalStatusSetText(hWndForm, MSG_OpenBankDate)
.head 3 +  Pushbutton: pbExit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отменить
.head 4 -  Window Location and Size
.head 5 -  Left:   3.114"
.head 5 -  Top:    1.344"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\DISCARD.BMP
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  ! Call SalStatusSetText(hWndForm, 'Завершить работу с диалогом')
.head 6 -  Call SalStatusSetText(hWndForm,
  CurrentLangTable.GetAtomTitle('dlg_OpenBankDay.cTStatusExit'))
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(hWndForm, 1)
.head 3 -  Frame
.head 4 -  Resource Id: 14973
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.071"
.head 5 -  Top:    0.26"
.head 5 -  Width:  4.986"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.01"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  Number: nDay
.head 3 -  Number: nKv
.head 3 -  Number: nFetchRes
.head 3 -  Number: nRet
.head 3 -  Window Handle: hWndObject
.head 3 -  !
.head 3 -  String: sTmp
.head 3 -  String: strDirMfoEx[*]
.head 3 -  Number: nCount
.head 3 -  Number: nDayStat
.head 3 -  String: strMfoTmp
.head 3 -  String: ss
.head 3 -  String: ss1
.head 3 -  String: strBankMfo
.head 3 -  Number: nMfo
.head 3 -  !
.head 3 -  Date/Time: dtChoose
.head 3 -  Date/Time: dtOldDate
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 -  Call SetWindowFont(hWndForm)
.head 4 -  Call SalSendMsgToChildren( hWndForm, UM_QueryLabelText, 0, 0 )
.head 4 -  Call SalSetWindowText( hWndForm, CurrentLangTable.GetAtomTitle('dlg_OpenBankDay.cTWndTitle') )
.head 4 +  If not ShowInputPassword()
.head 5 -  Return SalEndDialog(hWndForm, FALSE)
.head 4 -  Set nKv = GetBaseVal()
.head 3 +  On SAM_Destroy
.head 4 -  ! Disactivation of  function's role, which activated for calling window
.head 4 +  If SalStrTrimX(SalStrUpperX(GetDBMS())) = 'ORACLE'
.head 5 -  Call XRoleUnset(hSql(),'ShowOpenBankDay()')
.head 1 +  Form Window: win_meter
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title:
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Etched
.head 3 -  Visible at Design time? No
.head 3 -  Automatically Created at Runtime? No
.head 3 -  Initial State: Normal
.head 3 -  Maximizable? No
.head 3 -  Minimizable? No
.head 3 -  System Menu? Yes
.head 3 -  Resizable? No
.head 3 -  Window Location and Size
.head 4 -  Left:   2.763"
.head 4 -  Top:    2.073"
.head 4 -  Width:  5.2"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 1.262"
.head 4 -  Height Editable? Yes
.head 3 -  Form Size
.head 4 -  Width:  Default
.head 4 -  Height: Default
.head 4 -  Number of Pages: 0
.head 3 -  Font Name: MS Sans Serif
.head 3 -  Font Size: 8
.head 3 -  Font Enhancement: Bold
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Process indicator dialog
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
.head 3 +  Custom Control: ProcIndicator
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
.head 6 -  Left:   0.329"
.head 6 -  Top:    0.325"
.head 6 -  Width:  4.429"
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
.head 5 -  Text Color: Dark Blue
.head 5 -  Background Color: System Window Color
.head 5 -  DLL Settings
.head 4 -  Message Actions
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  String: PIndTitle
.head 3 -  Number: Bound
.head 2 +  Window Variables
.head 3 -  Number: nPerCent
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSetWindowText(hWndForm, PIndTitle)
.head 4 -  Call SalCenterWindow(hWndForm)
.head 3 +  On SAM_Close
.head 4 -  Return FALSE
.head 3 +  On AM_MtrMove
.head 4 -  Set nPerCent = SalNumberRound((lParam / Bound) * 100)
.head 4 -  Call ProcIndicator.SetProgress(nPerCent)
.head 4 -  Return TRUE
.head 1 +  Form Window: win_wait
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Ожидание
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? No
.head 3 -  Automatically Created at Runtime? No
.head 3 -  Initial State: Normal
.head 3 -  Maximizable? No
.head 3 -  Minimizable? No
.head 3 -  System Menu? Yes
.head 3 -  Resizable? Yes
.head 3 -  Window Location and Size
.head 4 -  Left:   2.713"
.head 4 -  Top:    1.708"
.head 4 -  Width:  4.557"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 1.24"
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
.head 3 +  Multiline Field: mlWarning
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
.head 6 -  Left:   0.0"
.head 6 -  Top:    0.01"
.head 6 -  Width:  4.388"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.885"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Highlight Color
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set mlWarning = szWarnText
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  String: szWarnText
.head 2 -  Window Variables
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set bWinWait = TRUE
.head 3 +  On SAM_Close
.head 4 -  Return FALSE
.head 3 +  On SAM_Destroy
.head 4 -  Call SalWaitCursor(FALSE)
.head 4 -  Set bWinWait = FALSE
