.head 0 +  Application Description: ! TECHBANK.APL - Функции технолога банка
! TECHBANK.APD - Dynalib
! ООО Унити-Барс (C) 1996-2004
! Разработчики: Сыропоршнев Д.Л., Сухова Т.А.
! -----------------------------------------------------
.head 1 -  Outline Version - 4.0.26
.head 1 +  Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000E00000 002C000000020000 0003000000000000 0077020000F8FFFF
0040: FFE2FFFFFFFFFFFF FF000000007C0200 004D010000010000 0001000000010000
0060: 000F4170706C6963 6174696F6E497465 6D01000000075769 6E646F7773
.enddata
.data DT_MAKERUNDLG
0000: 0200000000001951 3A5C424152533938 5C42494E5C736572 766963652E646C6C
0020: 19513A5C42415253 39385C42494E5C73 6572766963652E61 706300000101011D
0040: 513A5C4241525339 385C4C4942524152 595C736572766963 652E72756E1D513A
0060: 5C4241525339385C 4C4942524152595C 736572766963652E 646C6C1D513A5C42
0080: 41525339385C4C49 42524152595C7365 72766963652E6170 630000010101185C
00A0: 4241525339385C42 494E5C7465636862 616E6B2E61706418 5C4241525339385C
00C0: 42494E5C74656368 62616E6B2E646C6C 185C424152533938 5C42494E5C746563
00E0: 6862616E6B2E6170 630000010101001D 513A5C4241525339 385C4C4942524152
0100: 595C736572766963 652E646C6C1D513A 5C4241525339385C 4C4942524152595C
0120: 736572766963652E 6170630000010101
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
0000: 0118B80BB80B2500
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
.head 2 -  Dynalib: Bankapi.apd
.head 2 -  Dynalib: Docview.apd
.head 2 -  Dynalib: Techsrv.apd
.head 2 -  Dynalib: Service.apd
.head 2 -  Dynalib: CustAcnt.apd
.head 2 -  Dynalib: Referenc.apd
.head 2 -  Dynalib: Repbank.apd
.head 2 -  Dynalib: Barsnet.apd
.head 2 -  Dynalib: Security.apd
.head 2 -  !
.head 2 -  File Include: Constant.apl
.head 2 -  File Include: Gentbl.apl
.head 2 -  File Include: GENTBLF.APL
.head 2 -  File Include: Genlist.apl
.head 2 -  File Include: Genfcls.apl
.head 2 -  File Include: Genadlg.apl
.head 2 -  File Include: barsnet.apc
.head 2 -  File Include: Vtcal.apl
.head 2 -  File Include: vttblwin.apl
.head 2 -  File Include: VTSPLIT.APL
.head 2 -  File Include: XSALCPT.APL
.head 2 -  File Include: XSALIMG.APL
.head 2 -  File Include: XSALSPL.APL
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
.head 4 -  Border Color: 3D Shadow Color
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
.head 3 -  Date/Time: dd/MM/yyyy
.head 3 -  Date/Time: dd/MM/yyyy hh:mm
.head 3 -  Date/Time: dd/MM/yyyy hhhh:mm
.head 3 -  Date/Time: dd/MM/yyyy hhhh:mm:ss
.head 3 -  Date/Time: dd/MdM/yyyy hhhh:mm:ss
.head 3 -  Date/Time: dd/MM/yyyy hh:mm:ss
.head 2 +  External Functions
.head 2 +  Constants
.data CCDATA
0000: 3000000000000000 0000000000000000 00000000
.enddata
.data CCSIZE
0000: 1400
.enddata
.head 3 +  System
.head 4 -  !
.head 4 -  ! Number: AM_MtrMove = SAM_User + 150
.head 4 -  !
.head 4 -  Number: UM_Filter	= SAM_User+301
.head 3 +  User
.head 4 -  String: MSG_Q_Confirm = 'Подтверждаете?'
.head 4 -  String: MSG_Q_R_U_Sure = 'Вы уверены во внесенных изменениях?'
.head 4 -  String: MSG_Q_R_U_Sure_Again = 'Вы действительно хотите сохранить изменения? '
.head 4 -  String: MSG_Q_DateMismatch = 'Введеная дата отлична от текущей! Вы настаиваете на введеной дате?'
.head 4 -  !
.head 4 -  String: MSG_QUIT_Verb = 'Квитуется файл'
.head 4 -  String: MSG_QUIT_FailureFor = 'Ошибка при квитовании файла '
.head 4 -  String: MSG_QUIT_Q_R_U_Sure = 'Вы действительно хотите сквитовать выбраный файл СЭП? '
.head 4 -  String: MSG_DEL_Q_R_U_Sure = 'Вы действительно хотите удалить выбраные записи?'
.head 4 -  String: MSG_DEL_Q_R_U_SureEx = 'Вы действительно хотите удалить выбраный файл СЭП? '
.head 4 -  String: MSG_DEL_Impossible =  'Информация об этом файле СЭП не может быть удалена из системы!'
.head 4 -  !
.head 4 -  String: MSG_NoMarkedLines = 'Не выбрано ни одной записи!'
.head 4 -  String: MSG_PSDangerWarn = 'Необоснованное или некорректное изменение может привести к остановке платежной системы!'
.head 4 -  !
.head 4 -  String: MSG_InputDate = 'Введите дату ( ДД/ММ/ГГГГ )'
.head 4 -  String: MSG_InvalidDateWarn = 'Неверное значение для даты!'
.head 4 -  String: MSG_TextConfirmDate = 'Подтвердите введенную дату'
.head 4 -  String: MSG_AccAmountChange4DateWarn = 'Значения остатков на счетах будут пересчитаны для новой Банковской даты!'
.head 4 -  String: MSG_DateUnChangeWarn = 'Дата Банковского дня остается прежней!'
.head 4 -  !
.head 4 -  String: MSG_AuditKSequenceP1 = 'Изменен порядковый номер очередного К-файла для '
.head 4 -  String: MSG_AuditKSequenceP2 = ' на номер '
.head 4 -  !
.head 4 -  Number: UM_DelRow=SAM_User+10002
.head 4 -  !
.head 4 -  ! String: AppCode = ' '
.head 4 -  ! 03 - 22.04.2014
.head 4 -  String: AppVersion = '03. '
.head 2 +  Resources
.head 2 +  Variables
.head 3 -  ! //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
.head 3 -  String: gOB22
.head 3 -  Number: nHaveTOBO
.head 3 -  !
.head 3 -  Window Handle: hWin22
.head 3 -  !
.head 3 -  String: strSqlTxt
.head 3 -  !
.head 3 -  Number: nFetchRes
.head 3 -  !
.head 3 -  Boolean: bApdInited
.head 3 -  !
.head 2 +  Internal Functions
.head 3 +  Function: IniTECHBANK
.head 4 -  Description: инициализация библиотеки
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strPathToLangResources
.head 5 -  String: strLangId
.head 5 -  String: strFileName
.head 4 +  Actions
.head 5 +  If not bApdInited
.head 6 -  Set nHaveTOBO = GetGlobalOptionEx('HAVETOBO')
.head 6 -  Set bStaticsAsWindows = TRUE
.head 6 -  Set strPathToLangResources = GetLangPath()
.head 6 -  Set strLangId = GetLang()
.head 6 -  Set strFileName = strPathToLangResources || "\\" || strLangId || "\\techbank.lng"
.head 6 +  If (NOT strLangId) OR (NOT CurrentLangTable.InitFromFile( strFileName, strLangId ))
.head 7 -  Call CurrentLangTable.Init()
.head 7 -  ! constants
.head 7 -  Call CurrentLangTable.AddAtom('cTAt', 'Внимание!')
.head 7 -  Call CurrentLangTable.AddAtom('cTErr','Ошибка!')
.head 7 -  Call CurrentLangTable.AddAtom('cTItogo','И Т О Г О')
.head 7 -  ! ====================================================
.head 7 -  ! frm_Ctrl_D
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.pbExit','Выход')
.head 7 -  ! BG
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.bgArch','Архив документов')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.bgDocAll','Все~документы')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.bgDocMB', 'Межбанковские~(полученные)')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.bgDocVB', 'Внутрибанковские~(полученные)')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.bgDocAll','Все документы~введенные пользователем')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.bgDocMB', 'Межбанковские (полученные)~счета пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.bgDocVB', 'Внутрибанковские (полученные)~счета пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.bgDocDay','* Введенные~за')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.bgDocAllDay','** Все дни')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.bgPrimTek','* В выборках используется реальная дата ввода документов')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.bgPrimAll','** Можно менять даты')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.bgDatFrom','с')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.bgDatTo','по')
.head 7 -  ! constants
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.cTAllUsersDocs','ДОКУМЕНТЫ ВСЕХ ПОЛЬЗОВАТЕЛЕЙ')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.cTUserDocs', 'ДОКУМЕНТЫ ПОЛЬЗОВАТЕЛЯ')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.cTNavigation','Навигация')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.cTNDOKAll',  'Введенные документы')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.cTNDOKUser', 'Введенные документы пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.cTNDOKArch', 'Архив введенных документов')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.cTMODOKAll', 'Межбанковские поступления')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.cTMODOKUser','Межбанковские поступления на счета пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.cTVODOKAll', 'Внутренние поступления на счета')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.cTVODOKUser','Внутренние поступления на счета пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Ctrl_D.cTData','за')
.head 7 -  ! ====================================================
.head 7 -  ! TB30
.head 7 -  Call CurrentLangTable.AddAtom('TB30.cTWndTitle','Кол-во и Сумма НЕЗАВИЗИРОВАННЫХ')
.head 7 -  ! Columns
.head 7 -  Call CurrentLangTable.AddAtom('TB30.gr','Код~гр.~кон-~троля')
.head 7 -  Call CurrentLangTable.AddAtom('TB30.name_gr','Наименование~группы~контроля')
.head 7 -  Call CurrentLangTable.AddAtom('TB30.pr','Прио~ритет')
.head 7 -  Call CurrentLangTable.AddAtom('TB30.tt','Код~ОПЕР')
.head 7 -  Call CurrentLangTable.AddAtom('TB30.name_tt','Наименование~операции')
.head 7 -  Call CurrentLangTable.AddAtom('TB30.user_id','ИД~пользо~ваетля')
.head 7 -  Call CurrentLangTable.AddAtom('TB30.user_name','Ф.И.О.~исполнителя')
.head 7 -  Call CurrentLangTable.AddAtom('TB30.kol','Кол-во~докумен~тов')
.head 7 -  Call CurrentLangTable.AddAtom('TB30.su','Сумма~документов')
.head 7 -  Call CurrentLangTable.AddAtom('TB30.vdat','Дата~валютирования')
.head 7 -  ! ====================================================
.head 7 -  ! TB31
.head 7 -  Call CurrentLangTable.AddAtom('TB31.cTWndTitle','НЕЗАВИЗИРОВАННЫЕ документы')
.head 7 -  ! Columns
.head 7 -  Call CurrentLangTable.AddAtom('TB31.gr','Код~гр.~кон-~троля')
.head 7 -  Call CurrentLangTable.AddAtom('TB31.name_gr','Наименование~группы~контроля')
.head 7 -  Call CurrentLangTable.AddAtom('TB31.pr','Прио~ритет~группы')
.head 7 -  Call CurrentLangTable.AddAtom('TB31.tt','Код~ОПЕР')
.head 7 -  Call CurrentLangTable.AddAtom('TB31.name_tt','Наименование~операции')
.head 7 -  Call CurrentLangTable.AddAtom('TB31.user_name','ФИО~исполнителя')
.head 7 -  Call CurrentLangTable.AddAtom('TB31.kol','Референс')
.head 7 -  Call CurrentLangTable.AddAtom('TB31.su','Сумма~документа')
.head 7 -  ! ====================================================
.head 7 -  ! tbl_USERS
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.cTWndTitle','Активные пользователи')
.head 7 -  ! strTip
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.cBTipRefresh','Перечитать данные')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.cBTipFilter', 'Установить фильтр')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.cBTipSearch', 'Поиск строки по значению поля')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.cBTipPrint',  'Печать содержания таблицы')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.cBTipMessage','Послать сообщение')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.cBTipDelete', 'Закрыть сессии...')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.cBTipExit',   'Закончить работу')
.head 7 -  ! Columns
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.PROG','Программа~пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.ID','Пользователь~ АБС')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.SERTID','Ид Пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.FIO','ФИО пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.TERMI','Имя~раб.станции')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.LTIME','Дата/Время~подключения')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.colBANKDATE','Банковская~дата')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.SID','Номер~сессии')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.SERIA','Серийный~номер')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.STATU','Статус')
.head 7 -  ! constants
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.cTClose','Закрыть выбранные сессии?')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.cTCloseSession','Закрыть сессию пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.cTMachine', 'на машине')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.cTCloseApp','Закрыть приложение пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.cTAppBars','Толко для приложения BARS')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.cTAppQuit','Принудительное отключение!')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.cTErrDel', 'Невозможно удаление сессии')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_USERS.cTMess','Не отмечено ни одной записи!')
.head 7 -  ! ====================================================
.head 7 -  ! AccessControl
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTWndTitle','Просмотр доступа к счетам')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTWndTitleAcc', 'Просмотр и установка доступа к счетам')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTWndTitleUser','Счета пользователей')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTWndTitleIsp', 'Счета исполнителей')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTWndTitleGr',  'Состав групп доступа')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTWndTitleAccUser','Счета пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTWndTitleAccIsp', 'Счета исполнителя')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTWndTitleAccGr',  'Счета группы')
.head 7 -  !
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTColTitleFio','Ф.И.О.')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTColTitleGr', 'Группа')
.head 7 -  ! ButtonTip
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cBTipSwitchUser','Пользователи')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cBTipSwitchIsp', 'Исполнители')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cBTipSwitchGr',  'Группы')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cBTipSwitchAcc', 'Доступ к счетам')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cBTipFind','Поиск')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cBTipCancel','Выйти')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cBTipSave','Сохранить')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cBTipAdd','Добавить пользователя в группу')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cBTipDelete','Удалить пользователя из группы')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cBTipMainFilter','Фильтр по основной таблице')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cBTipAuxFilter','Фильтр по детальной таблице')
.head 7 -  ! Columns
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.tblAcc.colKv', 'Вал.')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.tblAcc.colNls','Лицевой Счет')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.tblAcc.colNms','Название счета')
.head 7 -  !
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.tblGroupAcc.colGId','Код')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.tblGroupAcc.colGName','Группа')
.head 7 -  !
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.tblGroupStaff.colGId','Код')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.tblGroupStaff.colGName','Группа')
.head 7 -  !
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.tblGroupMem.colGId','Код')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.tblGroupMem.colGFio','Ф.И.О.')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.tblGroupMem.colGView','Пр')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.tblGroupMem.colGDebit','Дб')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.tblGroupMem.colGCredit','Кр')
.head 7 -  !
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.tbl1.id','Код')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.tbl1.name','Ф.И.О.')
.head 7 -  !
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.tbl2.kv','Валюта')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.tbl2.nls','Лицевой Счет')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.tbl2.name','Наименование')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.tbl2.colS','Пр')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.tbl2.colD','Дб')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.tbl2.colK','Кр')
.head 7 -  ! Msg
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTMsgGMsg1','Группа не назначена')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTMsgGMsg2','Группа обслуживающая счет')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTMsgGMsg3','Группа пользователей, обслуживающая группу счетов')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTMsgGName','Состав группы')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTMsgGUser','Пользователю')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTMsgGGr',  'данная группа делегирована')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTMsgGDel', 'удаление невозможно')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTMsgOthers','Остальные пользователи')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTMsgOMsg1','Доступ к счету остальных пользователей')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTMsgOMsg2','Остальные пользователи не имеют доступа')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTMsgUUser','Доступ к счету пользователей')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTMsgUAcc', 'данные права делегированы')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTMsgSave', 'Настройки не сохранены!')
.head 7 -  ! Constant
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTToolTip1','Не подтвержден на добавление')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTToolTip2','Не подтвержден на удаление')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTToolTip3','Делегирован')
.head 7 -  Call CurrentLangTable.AddAtom('AccessControl.cTWithFilter','с фильтром')
.head 7 -  ! ====================================================
.head 7 -  ! acNewGroup
.head 7 -  Call CurrentLangTable.AddAtom('acNewGroup.cTWndTitle','Новая группа')
.head 7 -  ! Columns
.head 7 -  Call CurrentLangTable.AddAtom('acNewGroup.tblGroups.colId','Код')
.head 7 -  Call CurrentLangTable.AddAtom('acNewGroup.tblGroups.colGName','Название группы')
.head 7 -  ! ====================================================
.head 7 -  ! acNewUser
.head 7 -  Call CurrentLangTable.AddAtom('acNewUser.cTWndTitle','Новый пользователь')
.head 7 -  ! Columns
.head 7 -  Call CurrentLangTable.AddAtom('acNewUser.tblStaff.colId', 'Код')
.head 7 -  Call CurrentLangTable.AddAtom('acNewUser.tblStaff.colFio','Ф.И.О.')
.head 7 -  ! ====================================================
.head 7 -  ! frmSetAccAccess
.head 7 -  Call CurrentLangTable.AddAtom('frmSetAccAccess.cTWndTitle','Установка доступа к группам счетов')
.head 7 -  Call CurrentLangTable.AddAtom('frmSetAccAccess.cTUserGrpName','Наименование группы пользователей')
.head 7 -  Call CurrentLangTable.AddAtom('frmSetAccAccess.cTAccGrpName', 'Наименование группы счетов')
.head 7 -  Call CurrentLangTable.AddAtom('frmSetAccAccess.tblMain.colId','№ группы')
.head 7 -  ! ====================================================
.head 7 -  ! frmSetAccess
.head 7 -  Call CurrentLangTable.AddAtom('frmSetAccess.tblGrp.colId',  '№ группы')
.head 7 -  Call CurrentLangTable.AddAtom('frmSetAccess.tblGrp.colName','Наименование')
.head 7 -  Call CurrentLangTable.AddAtom('frmSetAccess.tblGrp.colNls', 'Номер счета')
.head 7 -  Call CurrentLangTable.AddAtom('frmSetAccess.tblGrp.colKv',  'Вал.')
.head 7 -  Call CurrentLangTable.AddAtom('frmSetAccess.tblGrpAll.colId',  '№ группы')
.head 7 -  Call CurrentLangTable.AddAtom('frmSetAccess.tblGrpAll.colName','Наименование')
.head 7 -  Call CurrentLangTable.AddAtom('frmSetAccess.tblGrpAll.colNls', 'Номер счета')
.head 7 -  Call CurrentLangTable.AddAtom('frmSetAccess.tblGrpAll.colKv',  'Вал.')
.head 7 -  Call CurrentLangTable.AddAtom('frmSetAccess.cTUserGrp','Выбранные группы пользователей')
.head 7 -  Call CurrentLangTable.AddAtom('frmSetAccess.cTAccGrp', 'Выбранные группы счетов')
.head 7 -  Call CurrentLangTable.AddAtom('frmSetAccess.cTAcc',    'Счета группы')
.head 7 -  Call CurrentLangTable.AddAtom('frmSetAccess.cTUserGrpAll','Доступные группы пользователей')
.head 7 -  Call CurrentLangTable.AddAtom('frmSetAccess.cTAccGrpAll', 'Доступные группы счетов')
.head 7 -  Call CurrentLangTable.AddAtom('frmSetAccess.cTAccAll',    'Счета, не входящие в группу')
.head 7 -  ! ====================================================
.head 7 -  ! frmCheckPoint
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckPoint.cTWndTitle','Присутствующие и отсутствующие пользователи')
.head 7 -  ! ButtonTip
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckPoint.cBTipCheckIn','Отметить приход пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckPoint.cBTipCheckOut','Отметить уход пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckPoint.cBTipHistory','Просмотреть журнал посещения пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckPoint.cBTipFilter','Фильтр...')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckPoint.cBTipRefresh','Перечитать')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckPoint.cBTipExit','Закончить работу функции')
.head 7 -  ! Columns
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckPoint.tbl1.branch','Отделение')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckPoint.tbl1.id','Код')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckPoint.tbl1.login','Рабочее~имя')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckPoint.tbl1.name','ПРИСУТСТВУЮТ')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckPoint.tbl1.tim','Время ПРИХОДА')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckPoint.tbl2.branch','Отделение')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckPoint.tbl2.id','Код')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckPoint.tbl2.login','Рабочее~имя')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckPoint.tbl2.name','ОТСУТСТВУЮТ')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckPoint.tbl2.tim','Время УХОДА')
.head 7 -  ! constant
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckPoint.cTIn','Приход')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckPoint.cTOut','Уход')
.head 7 -  ! ====================================================
.head 7 -  ! frm_UDBD
.head 7 -  Call CurrentLangTable.AddAtom('frm_UDBD.cTWndTitle','Управление доступом к банковским дням')
.head 7 -  !
.head 7 -  Call CurrentLangTable.AddAtom('frm_UDBD.pbEx','Применить')
.head 7 -  Call CurrentLangTable.AddAtom('frm_UDBD.pbClose','Выход')
.head 7 -  ! constant
.head 7 -  Call CurrentLangTable.AddAtom('frm_UDBD.cTSt_1','недоступен')
.head 7 -  Call CurrentLangTable.AddAtom('frm_UDBD.cTSt0','доступен')
.head 7 -  Call CurrentLangTable.AddAtom('frm_UDBD.cTSt9','закрыт')
.head 7 -  Call CurrentLangTable.AddAtom('frm_UDBD.cTSt10','изъять')
.head 7 -  Call CurrentLangTable.AddAtom('frm_UDBD.cTToLog0','доступен')
.head 7 -  Call CurrentLangTable.AddAtom('frm_UDBD.cTToLog9','закрыт')
.head 7 -  Call CurrentLangTable.AddAtom('frm_UDBD.cTToLog10','изъят')
.head 7 -  ! Mess
.head 7 -  Call CurrentLangTable.AddAtom('frm_UDBD.cTMess1','Невозможно изменить статус текущего банковского дня.')
.head 7 -  Call CurrentLangTable.AddAtom('frm_UDBD.cTMess2','Невозможно изменить статус недоступного банковского дня.')
.head 7 -  Call CurrentLangTable.AddAtom('frm_UDBD.cTMess3','Невозможно изъять день')
.head 7 -  ! ====================================================
.head 6 -  ! Call CurrentLangTable.SaveToFile('C:\\TEMP\\tech.lng','RUS')
.head 6 -  Set bApdInited = TRUE
.head 5 -  Return bApdInited
.head 3 +  Function: ShowAllDocs		! __exported
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Window Handle: hWin
.head 5 -  ! nPar1 - флаг: 0-документы пользователя, 1-документы ВСЕХ пользователей
.head 5 -  Number: nPar1
.head 5 -  Number: nPar2
.head 5 -  ! sPar1 - фильтр на документы
.head 5 -  String: sPar1
.head 5 -  ! sPar2 - название фильтра (заголовок окна)
.head 5 -  String: sPar2
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call IniTECHBANK()
.head 5 -  ! Call SalCreateWindow(frm_Ctrl_D, hWin, nPar1, sPar1, sPar2)
.head 5 -  Call ShowChoiceDocsForm(hWin, nPar1, NUMBER_Null, sPar1, sPar2)
.head 3 +  Function: Show_USERS		! __exported
.head 4 -  Description: Просмотр/манипулирование пользователями
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Window Handle: hW
.head 5 -  Boolean: FLAG
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call IniTECHBANK()
.head 5 -  Call SalCreateWindow( tbl_USERS, hW, FLAG)
.head 3 +  Function: F_Ek_Day		! __exported
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call IniTECHBANK()
.head 5 -  Call SalCreateWindow( frm_Ek_Day, hWndMDI)
.head 3 +  Function: F_Ctrl_D		! __exported
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Boolean: FLAG
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  ! Call IniTECHBANK()
.head 5 -  ! Call SalCreateWindow(frm_Ctrl_D, hWndMDI, FLAG, '', '')
.head 5 -  Call ShowChoiceDocsForm(hWndMDI, FLAG, NUMBER_Null, '', '')
.head 3 -  ! Obsolete ! 
.head 3 +  Function: ShowSepFiles		! __exported
.head 4 -  Description: Просмотр/манипулирование файлам СЭП
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  ! Call SalCreateWindow( frm_AllFilesSep, hWndMDI, TRUE )
.head 5 -  Call SalMessageBox( 'Moved to BARS014.apd', 'Warning', MB_IconInformation )
.head 3 +  Function: ShowSepFilesReadOnly	! __exported
.head 4 -  Description: Просмотр файлов СЭП
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  ! Call SalCreateWindow( frm_AllFilesSep, hWndMDI, FALSE )
.head 5 -  Call SalMessageBox( 'Moved to BARS014.apd', 'Warning', MB_IconInformation )
.head 3 -  !
.head 3 +  Function: ShowNotPayDok		! __exported
.head 4 -  Description: Просмотр старистики о непроплате
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Number: para
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call IniTECHBANK()
.head 5 +  If para=0   or para=10 
or para=100 or para=110
.head 6 -  Call SalCreateWindow(TB30, hWndMDI, para)
.head 5 +  Else If para=1 or para=11
.head 6 -  Call SalCreateWindow(TB31, hWndMDI, para)
.head 5 +  Else If para=22 or para=20
.head 6 +  If not IsWindow(hWin22)
.head 7 -  Set hWin22 = SalCreateWindow(BLK, hWndMDI, para)
.head 6 +  Else
.head 7 -  Call SalBringWindowToTop(BLK)
.head 3 +  Function: ShowGroups		! __exported
.head 4 -  Description: Показ формы просмотра и установки доступа к счетам
nP - Опция
0 - только проспотр доступа, пользователей, ответ, исполнителей, групп
1 - просмотр и редактирование  доступа, просмотр пользователей, ответ, исполнителей, групп
2 - только проспотр доступа
3 - просмотр и редактирование  доступа
Модифицированно Иваном
4, 5 - установка доступа групп пользователей к группам счетов
6 - установка доступа счетов к группам счетов
    (установка группового доступа)
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Window Handle: hW
.head 5 -  Number: nP
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: Ver
.head 4 +  Actions
.head 5 -  Call IniTECHBANK()
.head 5 +  Select Case nP
.head 6 -  Case 0
.head 6 -  Case 1
.head 6 -  Case 2
.head 6 +  Case 3
.head 7 -  Call SalCreateWindow(AccessControl, hW, nP)
.head 7 -  Break
.head 6 -  Case 4
.head 6 -  Case 5
.head 6 -  Case 6
.head 6 +  Case 7
.head 7 -  Call SalCreateWindow(frmSetAccAccess, hW, nP, 0, '', '')
.head 7 -  Break
.head 6 +  Default
.head 7 -  Break
.head 3 +  Function: ShowBAXTA		! __exported
.head 4 -  Description: КТО есть
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Window Handle: hW
.head 5 -  Boolean: FLAG
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call IniTECHBANK()
.head 5 -  ! Call SalModalDialog( BAXTA, hW, FLAG )
.head 5 -  Call SalCreateWindow( frmCheckPoint, hW, FLAG )
.head 3 +  Function: SetLimMod1		! __exported
.head 4 -  Description: Установка лимитов филиалам по МоД1
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  ! Call SalCreateWindow( tblSetLimMod1, hWndForm )
.head 5 -  Call SalMessageBox( 'Moved to BARS014.apd', 'Warning', MB_IconInformation )
.head 3 -  !
.head 3 +  Function: SelFirstRow
.head 4 -  Description: Select first row in the table, unselects all others
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Window Handle: hTbl
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SalTblClearSelection( hTbl )
.head 5 -  Call SalTblSetContext( hTbl, 0 )
.head 5 -  Call SalTblSetRowFlags( hTbl, 0, ROW_Selected, TRUE )
.head 3 -  !
.head 3 +  Function: StatBankDay        ! __exported
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call IniTECHBANK()
.head 5 -  Call SalCreateWindow( frm_UDBD, hWndMDI )
.head 3 -  !
.head 2 +  Named Menus
.head 3 +  Windows Menu: menuWindows
.head 4 -  Resource Id: 31998
.head 4 -  Description: Работа с окнами работающих задач
.head 4 -  Title: &Окна
.head 4 -  Enabled when:
.head 4 -  Status Text: Работа с окнами работающих задач
.head 4 -  Menu Item Name:
.head 4 +  Menu Item: Разместить &каскадом
.head 5 -  Resource Id: 31999
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text: Показать окна задач, разместив их каскадом
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalMDICascade( hWndMDI )
.head 5 -  Menu Item Name:
.head 4 +  Menu Item: Разместить &горизонтально
.head 5 -  Resource Id: 32000
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text: Показать окна задач, разместив их вплотную, горизонтально
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalMDITile( hWndMDI, FALSE )
.head 5 -  Menu Item Name:
.head 4 +  Menu Item: Разместить &вертикально
.head 5 -  Resource Id: 32001
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text: Показать окна задач, разместив их вплотную, вертикально
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalMDITile( hWndMDI, TRUE )
.head 5 -  Menu Item Name:
.head 4 +  Menu Item: &Упорядочить значки
.head 5 -  Resource Id: 32002
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text: Упорядочить значки миниизированых окон задач
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalMDIArrangeIcons( hWndMDI )
.head 5 -  Menu Item Name:
.head 4 -  Menu Separator
.head 4 +  Menu Item: Закр&ыть все
.head 5 -  Resource Id: 32003
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text: Закрыть окна задач
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsgToChildren( hWndMDI, SAM_Close, 0, 0 )
.head 5 -  Menu Item Name:
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
.head 3 -  Pushbutton: ctb_pbFilter
.head 3 -  Radio Button:
.head 3 -  Option Button:
.head 3 -  Check Box:
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
.head 3 -  Custom Control: cCalendarDropDown
.head 2 -  Application Actions
.head 1 -  !
.head 1 +  ! Form Window: frm_Ctrl_D
.winattr
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Информация  о  ДОКУМЕНТАХ [Навигация]
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? No
.head 3 -  Initial State: Normal
.head 3 -  Maximizable? Yes
.head 3 -  Minimizable? Yes
.head 3 -  System Menu? Yes
.head 3 -  Resizable? Yes
.head 3 -  Window Location and Size
.head 4 -  Left:   0.79"
.head 4 -  Top:    0.308"
.head 4 -  Width:  9.8"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 4.583"
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
.end
.head 2 -   Description: Информация о документах
.head 2 -   Named Menus 
.head 2 -   Menu 
.head 2 +   Tool Bar 
.head 3 -   Contents 
.head 2 +   Contents 
.head 3 +   Picture: pic1
.head 4 -   Message Actions 
.head 3 -   Background Text: Архив документов
.head 3 +   Data Field: bgArch
.head 4 -   Message Actions 
.head 3 +   Pushbutton: NDOK1
.head 4 +   Message Actions 
.head 5 +   On SAM_Click
.head 6 +   If FLAG      !! ВСЕ пользователи за ТЕК день
.head 7 -  ! Введенные документы за ss5
.head 7 -   Call DocViewListIntCurr(hWndMDI, ssN, sFilter,
     CurrentLangTable.GetAtomTitle('frm_Ctrl_D.cTNDOKAll') || ' ' ||
     CurrentLangTable.GetAtomTitle('frm_Ctrl_D.cTData') || ' ' || ss5 || ' ' || sWinTitle)
.head 6 +   Else !! ТЕК пользователь за ТЕК день
.head 7 -  ! Введенные документы пользователя за ss5
.head 7 -   Call DocViewListIntCurr(hWndMDI, ssN, 'a.userid=' || ss1 || IifS(sFilter='', '', ' and (' || sFilter || ')'),
     CurrentLangTable.GetAtomTitle('frm_Ctrl_D.cTNDOKUser') || ' ' ||
     CurrentLangTable.GetAtomTitle('frm_Ctrl_D.cTData') || ' ' || ss5 || ' ' || sWinTitle)
.head 3 +   Pushbutton: NDOK2
.head 4 +   Message Actions 
.head 5 +   On SAM_Click
.head 6 -   Set sFilterDat = GetDat()
.head 6 +   If FLAG     !! ВСЕ пользователи за ВСЕ дни
.head 7 -  ! Архив введенных документов
.head 7 -   Call DocViewListInt(hWndMDI, 
     IifS(sFilterDat="", "" || IifS(sFilter="", "", sFilter), " a.pdat " || sFilterDat || IifS(sFilter="", "", " and (" || sFilter || ")")), 
     CurrentLangTable.GetAtomTitle('frm_Ctrl_D.cTNDOKArch') || 
     IifS(dfDatFrom!=DATETIME_Null, " " || CurrentLangTable.GetAtomTitle('frm_Ctrl_D.bgDatFrom') || " " || SalFmtFormatDateTime(dfDatFrom, 'dd/MM/yyyy'), "") || 
     IifS(dfDatTo  !=DATETIME_Null, " " || CurrentLangTable.GetAtomTitle('frm_Ctrl_D.bgDatTo')   || " " || SalFmtFormatDateTime(dfDatTo,   'dd/MM/yyyy'), "") || " " || sWinTitle  )
.head 6 +   Else !! ТЕК пользователь за ВСЕ дни
.head 7 -  ! Введенные документы пользователя
.head 7 -   Call DocViewListInt(hWndMDI, IifS(sFilterDat="", "", " a.pdat " || sFilterDat || " and ") || " a.userid=" || ss1 || IifS(sFilter="", "", " and (" || sFilter || ")"), 
     CurrentLangTable.GetAtomTitle('frm_Ctrl_D.cTNDOKUser') || 
     IifS(dfDatFrom!=DATETIME_Null, " " || CurrentLangTable.GetAtomTitle('frm_Ctrl_D.bgDatFrom') || " " || SalFmtFormatDateTime(dfDatFrom, 'dd/MM/yyyy'), "") || 
     IifS(dfDatTo  !=DATETIME_Null, " " || CurrentLangTable.GetAtomTitle('frm_Ctrl_D.bgDatTo')   || " " || SalFmtFormatDateTime(dfDatTo,   'dd/MM/yyyy'), "") || " " || sWinTitle)
.head 3 +   Pushbutton: MODOK1
.head 4 +   Message Actions 
.head 5 +   On SAM_Click
.head 6 +   If FLAG         !! ВСЕ пользователи за ТЕК день
.head 7 -  ! Межбанковские поступления за ss2
.head 7 -   Call DocViewList(hWndMDI, ' a.dat_a BETWEEN '|| ss || ' AND ' || ss || '+0.9999 AND a.mfob=' || ss4 || ' AND a.sos>3' || IifS(sFilter='', '', ' and (' || sFilter || ')'),
     CurrentLangTable.GetAtomTitle('frm_Ctrl_D.cTMODOKAll') || ' ' ||
     CurrentLangTable.GetAtomTitle('frm_Ctrl_D.cTData') || ' ' || ss2 || ' ' || sWinTitle)
.head 6 +   Else !! ТЕК пользователь за ТЕК день
.head 7 -  ! Межбанковские поступления на счета пользователя за ss2
.head 7 -   Call DocViewList(hWndMDI, ' a.dat_a BETWEEN '|| ss || ' AND ' || ss || '+0.9999 AND a.mfob=' || ss4 || ' AND a.sos>3' || ' and a.nlsb in ' || ss3 || IifS(sFilter='', '', ' and (' || sFilter || ')'),
     CurrentLangTable.GetAtomTitle('frm_Ctrl_D.cTMODOKUser') || ' ' ||
     CurrentLangTable.GetAtomTitle('frm_Ctrl_D.cTData') || ' ' || ss2 || ' ' || sWinTitle)
.head 3 +   Pushbutton: MODOK2
.head 4 +   Message Actions 
.head 5 +   On SAM_Click
.head 6 -   Set sFilterDat = GetDat()
.head 6 +   If FLAG      !! ВСЕ пользователи за ВСЕ дни
.head 7 -  ! Межбанковские поступления
.head 7 -   Call DocViewList(hWndMDI, IifS(sFilterDat="", "", " a.datp " || sFilterDat || " and ") || " a.mfob=" || ss4 || " AND a.sos>3" || IifS(sFilter="", "", " and (" || sFilter || ")"), 
     CurrentLangTable.GetAtomTitle('frm_Ctrl_D.cTMODOKAll') || 
     IifS(dfDatFrom!=DATETIME_Null, " " || CurrentLangTable.GetAtomTitle('frm_Ctrl_D.bgDatFrom') || " " || SalFmtFormatDateTime(dfDatFrom, 'dd/MM/yyyy'), "") || 
     IifS(dfDatTo  !=DATETIME_Null, " " || CurrentLangTable.GetAtomTitle('frm_Ctrl_D.bgDatTo')   || " " || SalFmtFormatDateTime(dfDatTo,   'dd/MM/yyyy'), "") || " " || sWinTitle)
.head 6 +   Else !! ТЕК пользователь за ВСЕ дни
.head 7 -  ! Межбанковские поступления на счета пользователя
.head 7 -   Call DocViewList(hWndMDI, IifS(sFilterDat="", "", " a.datp " || sFilterDat || " and ") || " a.mfob=" || ss4 || " AND a.sos>3" || " and a.nlsb in " || ss3 || IifS(sFilter="", "", " and (" || sFilter || ")"),
     CurrentLangTable.GetAtomTitle('frm_Ctrl_D.cTMODOKUser') || 
     IifS(dfDatFrom!=DATETIME_Null, " " || CurrentLangTable.GetAtomTitle('frm_Ctrl_D.bgDatFrom') || " " || SalFmtFormatDateTime(dfDatFrom, 'dd/MM/yyyy'), "") || 
     IifS(dfDatTo  !=DATETIME_Null, " " || CurrentLangTable.GetAtomTitle('frm_Ctrl_D.bgDatTo')   || " " || SalFmtFormatDateTime(dfDatTo,   'dd/MM/yyyy'), "") || " " || sWinTitle)
.head 3 +   Pushbutton: VODOK1
.head 4 +   Message Actions 
.head 5 +   On SAM_Click
.head 6 +   If FLAG       !! ВСЕ пользователи за ТЕК день
.head 7 -  ! Внутренние поступления на счета за ss2
.head 7 -   Call DocViewListInt(hWndMDI, ' a.datp=' || ss || ') ' || IifS(sFilter="", "", " and (" || sFilter || ")"),
     CurrentLangTable.GetAtomTitle('frm_Ctrl_D.cTVODOKAll') || ' ' ||
     CurrentLangTable.GetAtomTitle('frm_Ctrl_D.cTData') || ' ' || ss2 || ' ' || sWinTitle)
.head 6 +   Else !! ТЕК пользователь за ТЕК день
.head 7 -  ! Внутренние поступления на счета пользователя за ss2
.head 7 -   Call DocViewListInt(hWndMDI, ' a.datp=' || ss || ' AND (a.dk=1 and a.nlsb in ' || ss3 || ' OR a.dk=0 and a.nlsa in '||ss3||') ' || IifS(sFilter="", "", " and (" || sFilter || ")"),
     CurrentLangTable.GetAtomTitle('frm_Ctrl_D.cTVODOKUser') || ' ' ||
     CurrentLangTable.GetAtomTitle('frm_Ctrl_D.cTData') || ' ' || ss2 || ' ' || sWinTitle)
.head 3 +   Pushbutton: VODOK2
.head 4 +   Message Actions 
.head 5 +   On SAM_Click
.head 6 -   Set sFilterDat = GetDat()
.head 6 +   If FLAG      !! ВСЕ пользователи за ВСЕ дни
.head 7 -  ! Внутренние поступления на счета
.head 7 -   Call DocViewListInt(hWndMDI, IifS(sFilterDat="", "", " a.pdat " || sFilterDat || " and ") || " (a.sos is not NULL) " || IifS(sFilter="", "", " and (" || sFilter || ")"),
     CurrentLangTable.GetAtomTitle('frm_Ctrl_D.cTVODOKAll') || 
     IifS(dfDatFrom!=DATETIME_Null, " " || CurrentLangTable.GetAtomTitle('frm_Ctrl_D.bgDatFrom') || " " || SalFmtFormatDateTime(dfDatFrom, 'dd/MM/yyyy'), "") || 
     IifS(dfDatTo  !=DATETIME_Null, " " || CurrentLangTable.GetAtomTitle('frm_Ctrl_D.bgDatTo')   || " " || SalFmtFormatDateTime(dfDatTo,   'dd/MM/yyyy'), "") || " " || sWinTitle)
.head 6 +   Else !! ТЕК пользователь за ВСЕ дни
.head 7 -  ! Внутренние поступления на счета пользователя
.head 7 -   Call DocViewListInt(hWndMDI, IifS(sFilterDat="", "", " a.pdat " || sFilterDat || " and ") || " (a.dk=1 and a.nlsb in " || ss3 || " OR a.dk=0 and a.nlsa in " || ss3 || ") " || IifS(sFilter="", "", " and (" || sFilter || ")"),
     CurrentLangTable.GetAtomTitle('frm_Ctrl_D.cTVODOKUser') || 
     IifS(dfDatFrom!=DATETIME_Null, " " || CurrentLangTable.GetAtomTitle('frm_Ctrl_D.bgDatFrom') || " " || SalFmtFormatDateTime(dfDatFrom, 'dd/MM/yyyy'), "") || 
     IifS(dfDatTo  !=DATETIME_Null, " " || CurrentLangTable.GetAtomTitle('frm_Ctrl_D.bgDatTo')   || " " || SalFmtFormatDateTime(dfDatTo,   'dd/MM/yyyy'), "") || " " || sWinTitle)
.head 3 +   Pushbutton: pbExit
.head 4 +   Message Actions 
.head 5 +   On SAM_Click
.head 6 -   Call SalDestroyWindow(hWndForm)
.head 3 -   Background Text: Все
документы
.head 3 +   Data Field: bgDocAll
.head 4 -   Message Actions 
.head 3 -   Background Text: Межбанковские
(полученные)
.head 3 +   Data Field: bgDocMB
.head 4 -   Message Actions 
.head 3 -   Background Text: Внутрибанковские
(полученные)
.head 3 +   Data Field: bgDocVB
.head 4 -   Message Actions 
.head 3 -   Background Text: * Введенные
за
.head 3 +   Data Field: bgDocDay
.head 4 -   Message Actions 
.head 3 +   Data Field: dfCurrentDay
.head 4 -   Message Actions 
.head 3 -   Background Text: ** Все дни
.head 3 +   Data Field: bgDocAllDay
.head 4 -   Message Actions 
.head 3 -   Background Text: с
.head 3 +   Data Field: bgDatFrom
.head 4 -   Message Actions 
.head 3 +   Data Field: dfDatFrom
.head 4 -   Message Actions 
.head 3 -   Background Text: по
.head 3 +   Data Field: bgDatTo
.head 4 -   Message Actions 
.head 3 +   Data Field: dfDatTo
.head 4 -   Message Actions 
.head 3 -   Line 
.head 3 -   Line 
.head 3 -   Line 
.head 3 -   Line 
.head 3 -   Line 
.head 3 -   Line 
.head 3 -   Background Text: * В выборках используется реальная дата ввода документов
.head 3 +   Data Field: bgPrimTek
.head 4 -   Message Actions 
.head 3 -   Background Text: ** Можно менять даты
.head 3 +   Data Field: bgPrimAll
.head 4 -   Message Actions 
.head 2 +   Functions 
.head 3 +   Function: GetDat
.head 4 -   Description: 
.head 4 +   Returns 
.head 5 -   String: 
.head 4 -   Parameters 
.head 4 -   Static Variables 
.head 4 -   Local variables 
.head 4 +   Actions 
.head 5 +   If dfDatFrom
.head 6 +   If dfDatTo
.head 7 -   Return " between to_date('" || SalFmtFormatDateTime(dfDatFrom, 'dd/MM/yyyy') || "','dd/MM/yyyy') and to_date('" || 
SalFmtFormatDateTime(dfDatTo, 'dd/MM/yyyy') || "','dd/MM/yyyy')+0.9999"
.head 6 +   Else 
.head 7 -   Return " >= to_date('" || SalFmtFormatDateTime(dfDatFrom, 'dd/MM/yyyy') || "','dd/MM/yyyy')"
.head 5 +   Else If dfDatTo
.head 6 -   Return " <= to_date('" || SalFmtFormatDateTime(dfDatTo, 'dd/MM/yyyy') || "','dd/MM/yyyy')+0.9999"
.head 5 -   Return ""
.head 2 +   Window Parameters 
.head 3 -   Boolean: FLAG
.head 3 -   String: sFilter
.head 3 -   String: sWinTitle
.head 2 +   Window Variables 
.head 3 -   String: ss
.head 3 -   String: ssN
.head 3 -   String: ss1
.head 3 -   String: ss2
.head 3 -   String: ss3
.head 3 -   String: ss4
.head 3 -   String: ss5
.head 3 -   Date/Time: dtCurrent 
.head 3 -   String: sFilterDat
.head 2 +   Message Actions 
.head 3 +   On SAM_Create
.head 4 -  ! Присваиваем значения многоязыковым объектам
.head 4 -   Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 +   If FLAG
.head 5 -  ! ДОКУМЕНТЫ ВСЕХ ПОЛЬЗОВАТЕЛЕЙ [Навигация]
.head 5 -   Call SalSetWindowText(hWndForm,
     CurrentLangTable.GetAtomTitle('frm_Ctrl_D.cTAllUsersDocs') || ' [' || 
     CurrentLangTable.GetAtomTitle('frm_Ctrl_D.cTNavigation') || '] ' || sWinTitle)
.head 5 -   Call SalDisableWindow(VODOK1)
.head 5 -   Call SalDisableWindow(VODOK2)
.head 5 -   Call SalSetWindowLabelText(bgDocAll, CurrentLangTable.GetAtomTitle('frm_Ctrl_D.bgDocAll'))
.head 5 -   Call SalSetWindowLabelText(bgDocMB, CurrentLangTable.GetAtomTitle('frm_Ctrl_D.bgDocMB'))
.head 5 -   Call SalSetWindowLabelText(bgDocVB, CurrentLangTable.GetAtomTitle('frm_Ctrl_D.bgDocVB'))
.head 4 +   Else 
.head 5 -  ! ДОКУМЕНТЫ ПОЛЬЗОВАТЕЛЯ GetUserRealName() [Навигация]
.head 5 -   Call SalSetWindowText(hWndForm,
     CurrentLangTable.GetAtomTitle('frm_Ctrl_D.cTUserDocs') || ' ' || GetUserRealName() || ' [' || 
     CurrentLangTable.GetAtomTitle('frm_Ctrl_D.cTNavigation') || '] ' || sWinTitle )
.head 5 -   Call SalSetWindowLabelText(bgDocAll, CurrentLangTable.GetAtomTitle('frm_Ctrl_D.bgDocAll_User'))
.head 5 -   Call SalSetWindowLabelText(bgDocMB, CurrentLangTable.GetAtomTitle('frm_Ctrl_D.bgDocMB_User'))
.head 5 -   Call SalSetWindowLabelText(bgDocVB, CurrentLangTable.GetAtomTitle('frm_Ctrl_D.bgDocVB_User'))
.head 4 -   Call PrepareWindowEx(hWndForm)
.head 4 -  !
.head 4 +   If SqlPrepareAndExecute(hSqlAux(), 'SELECT sysdate INTO :dfCurrentDay FROM dual')
.head 5 -   Call SqlFetchNext(hSqlAux(), nFetchRes)
.head 4 -   Set dfDatFrom = dfCurrentDay - 10
.head 4 -   Set dfDatTo = dfCurrentDay
.head 4 -   Set ss  = DateInQuery(GetBankDateEx())
.head 4 -   Set ss1 = SalNumberToStrX(GetUserId(),0)
.head 4 -   Set ss2 = SalFmtFormatDateTime(GetBankDate(),ddMMyyyy())
.head 4 -   Set ss3 = '(SELECT nls FROM accounts ac WHERE a.kv=ac.kv and isp in ('||GetSubstListId( GetUserId(), TRUE )||'))'
.head 4 -   Set ss4 = GetBankMfo( )
.head 4 -   Set ss5 = SalFmtFormatDateTime(dfCurrentDay, ddMMyyyy())
.head 4 -   Set ssN = SalFmtFormatDateTime(dfCurrentDay, 'MM/dd/yyyy')
.head 4 -   Set ssN = DateInQuery(ssN)
.head 4 -   Call SalSetFocus(pbExit)
.head 3 +   On SAM_Destroy
.head 4 -  ! Disactivation call function' role
.head 4 +   If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
.head 5 -   Call XRoleUnset(hSql(), ' F_Ctrl_D('||SalNumberToStrX(FLAG,0) || ') ' )
.head 4 -   Call SalSetFocus( SalParentWindow( hWndForm ))
.head 1 +  Form Window: frm_Ek_Day
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Экономические показатели
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? No
.head 3 -  Automatically Created at Runtime? No
.head 3 -  Initial State: Normal
.head 3 -  Maximizable? Yes
.head 3 -  Minimizable? Yes
.head 3 -  System Menu? Yes
.head 3 -  Resizable? Yes
.head 3 -  Window Location and Size
.head 4 -  Left:   1.363"
.head 4 -  Top:    0.344"
.head 4 -  Width:  4.743"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 2.333"
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
.head 2 -  Description: Накопление ЭК ПОК за день
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
.head 3 -  Background Text: Дата:
.head 4 -  Resource Id: 26719
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.157"
.head 5 -  Top:    0.094"
.head 5 -  Width:  1.486"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.226"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Arial
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  List Box: lbVedo
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.129"
.head 5 -  Top:    0.344"
.head 5 -  Width:  2.071"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.521"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Multiple selection? No
.head 4 -  Sorted? No
.head 4 -  Vertical Scroll? Yes
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Black
.head 4 -  Background Color: White
.head 4 -  Horizontal Scroll? No
.head 4 -  List Initialization
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set sDat=GetBankDateEx()
.head 6 -  Call SqlPrepareAndExecute(hSql(),
T('SELECT fdat FROM fdat INTO :dtFdat WHERE fdat<= :sDat ORDER BY fdat DESC'))
.head 6 +  While SqlFetchNext(hSql(), nFetchRes)
.head 7 -  Call SalListAdd(lbVedo,SalFmtFormatDateTime(dtFdat, ddMMyyyy()))
.head 6 -  Call SalListSetSelect(lbVedo, 0)
.head 6 -  Call SalSendMsg(lbVedo, SAM_Click, 0, 0)
.head 5 +  On SAM_Click
.head 6 -  Set strRepDate =SalListQueryTextX(hWndItem,SalListQuerySelection(hWndItem))
.head 6 -  Set sFdat=SalStrMidX(strRepDate,3,2)||'-'||SalStrLeftX(strRepDate, 2) || '-' || SalStrRightX(strRepDate, 4)
.head 6 -  Call SalSetFocus( pbExecute )
.head 3 +  Pushbutton: pbExecute
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbExecute
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Рассчитать
.head 4 -  Window Location and Size
.head 5 -  Left:   2.543"
.head 5 -  Top:    0.344"
.head 5 -  Width:  1.457"
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
.head 6 -  Call Ek_Pok_Day(sFdat)
.head 3 +  Pushbutton: pbExit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.543"
.head 5 -  Top:    0.906"
.head 5 -  Width:  1.457"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.448"
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
.head 6 -  Call SalDestroyWindow( hWndForm)
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  String: sDat ! для трансляции даты
.head 3 -  String: sFdat
.head 3 -  String: strRepDate
.head 3 -  Date/Time: dtFdat
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindow( hWndForm )
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalWaitCursor( FALSE )
.head 3 +  On SAM_Destroy
.head 4 -  ! Disactivation call function' role
.head 4 +  If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
.head 5 -  Call XRoleUnset(hSql(), ' F_Ek_Day() ' )
.head 4 -  Call SalSetFocus( SalParentWindow( hWndForm ))
.head 3 +  On SAM_Help
.head 4 -  Call SalLoadApp ( "WinHlp32.exe", "-wWin1 -i Fi_094 " || GetHelpFile () )
.head 1 -  ! Управление пользователеями
.head 1 +  Form Window: frmCheckPoint
.data CLASSPROPSSIZE
0000: 3C00
.enddata
.data CLASSPROPS
0000: 56543A53706C6974 746572002B000100 0000000000009DB9 C800CEDCE3005580
0020: 9700020000000000 0000010000000100 0000010000000001 00000000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 2 -  Class: cSplitterWindow
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Присутствующие и отсутствующие пользователи
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? No
.head 2 -  Display Settings
.head 3 -  Display Style? Class Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? No
.head 3 -  Initial State: Class Default
.head 3 -  Maximizable? Class Default
.head 3 -  Minimizable? Class Default
.head 3 -  System Menu? Class Default
.head 3 -  Resizable? Class Default
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  12.2"
.head 4 -  Width Editable? Class Default
.head 4 -  Height: 7.024"
.head 4 -  Height Editable? Class Default
.head 3 -  Form Size
.head 4 -  Width:  Class Default
.head 4 -  Height: Class Default
.head 4 -  Number of Pages: Class Default
.head 3 -  Font Name: Class Default
.head 3 -  Font Size: Class Default
.head 3 -  Font Enhancement: Class Default
.head 3 -  Text Color: Class Default
.head 3 -  Background Color: Class Default
.head 2 -  Description: Учет прихода-ухода пользователей АБС
.head 2 -  Named Menus
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Class Default
.head 4 -  Location? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Size: 0.429"
.head 4 -  Size Editable? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 3 +  Contents
.head 4 +  Pushbutton: pbCheckIn
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cTBarButton
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.05"
.head 6 -  Top:    0.06"
.head 6 -  Width:  0.433"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Arr1tol.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 +  If NOT fAccessWrite
.head 8 -  Call SalDisableWindow( hWndItem )
.head 7 -  ! Отметить приход пользователя
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('frmCheckPoint.cBTipCheckIn')
.head 6 +  On SAM_Click
.head 7 +  If fAccessWrite AND SalTblAnyRows( tbl2, ROW_Selected, 0 )
.head 8 +  If SalStrTrimX(SalStrUpperX(GetDBMS ())) = 'ORACLE'
.head 9 -  Set strQuery = "UPDATE staff SET bax = 1, tbax = sysdate WHERE id=:tbl2.id "
.head 8 +  Else
.head 9 -  Set strQuery = "UPDATE staff SET bax = 1, tbax = current WHERE id=:tbl2.id "
.head 8 -  Call SqlPrepareAndExecute (ListOut.hSql (), strQuery)
.head 8 -  ! Приход tbl2.name
.head 8 -  Call SqlCommitEx(ListOut.hSql(), CurrentLangTable.GetAtomTitle('frmCheckPoint.cTIn') || ' ' || tbl2.name)
.head 8 -  Call SalSendMsg(tbl1, UM_Populate, 0, 0)
.head 8 -  Call SalSendMsg(tbl2, UM_Populate, 0, 0)
.head 4 +  Pushbutton: pbCheckOut
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cTBarButton
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.483"
.head 6 -  Top:    0.06"
.head 6 -  Width:  0.433"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Arr1tor.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 +  If NOT fAccessWrite
.head 8 -  Call SalDisableWindow( hWndItem )
.head 7 -  ! Отметить уход пользователя
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('frmCheckPoint.cBTipCheckOut')
.head 6 +  On SAM_Click
.head 7 +  If fAccessWrite AND SalTblAnyRows( tbl1, ROW_Selected, 0 )
.head 8 +  If SalStrTrimX(SalStrUpperX(GetDBMS ())) = 'ORACLE'
.head 9 -  Set strQuery = "UPDATE staff SET bax = 0, tbax = sysdate WHERE id=:tbl1.id "
.head 8 +  Else
.head 9 -  Set strQuery = "UPDATE staff SET bax = 0, tbax = current WHERE id=:tbl1.id "
.head 8 -  Call SqlPrepareAndExecute (ListIn.hSql (), strQuery)
.head 8 -  ! Уход  tbl1.name
.head 8 -  Call SqlCommitEx(ListIn.hSql(), CurrentLangTable.GetAtomTitle('frmCheckPoint.cTOut') || ' ' || tbl1.name)
.head 8 -  Call SalSendMsg(tbl1, UM_Populate, 0, 0)
.head 8 -  Call SalSendMsg(tbl2, UM_Populate, 0, 0)
.head 4 +  Pushbutton: pbHistory
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbDetail
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.917"
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
.head 7 -  ! Просмотреть журнал посещения пользователя
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('frmCheckPoint.cBTipHistory')
.head 6 +  On SAM_Click
.head 7 -  Call SalGetItemName( SalGetFocus(), strCurWin )
.head 7 +  If strCurWin = 'tbl2'
.head 8 -  Set nUId = tbl2.id
.head 7 +  Else
.head 8 -  Set nUId = tbl1.id
.head 7 -  Call ShowAttendance( nUId )
.head 4 +  Pushbutton: pbFilter
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbRefresh
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.5"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Filter.bmp
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  ! Фильтр
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('frmCheckPoint.cBTipFilter')
.head 6 +  On SAM_Click
.head 7 +  If SetQueryFilter( cF )
.head 8 -  Set sf = cF.GetFilterWhereClause( FALSE )
.head 8 -  Call SalSendMsg( tbl1, UM_Populate, 0, 0 )
.head 8 -  Call SalSendMsg( tbl2, UM_Populate, 0, 0 )
.head 4 +  Pushbutton: pbRefresh
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbRefresh
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.933"
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
.head 7 -  ! Перечитать
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('frmCheckPoint.cBTipRefresh')
.head 6 +  On SAM_Click
.head 7 -  Call SalSendMsg(tbl1, UM_Populate, 0, 0)
.head 7 -  Call SalSendMsg(tbl2, UM_Populate, 0, 0)
.head 4 +  Pushbutton: pbExit
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbCancel
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.533"
.head 6 -  Top:    0.06"
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
.head 7 -  ! Закончить работу функции
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('frmCheckPoint.cBTipExit')
.head 6 +  On SAM_Click
.head 7 -  Call SalDestroyWindow(hWndForm)
.head 2 +  Contents
.head 3 +  Child Table: tbl1  !! они ЕСТЬ
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.0"
.head 6 -  Top:    0.0"
.head 6 -  Width:  6.383"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 6.036"
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
.head 5 -  Maximum Rows in Memory: 2000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: id
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  0.8"
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
.head 5 +  Column: login
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Рабочее
имя
.head 6 -  Visible? Yes
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
.head 5 +  Column: name
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: ПРИСУТСТВУЮТ
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  4.0"
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
.head 5 +  Column: tim
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Время ПРИХОДА
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Justify: Left
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Format: DateTime
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
.head 5 +  Column: branch
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Отделение
.head 6 -  Visible? Class Default
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  2.2"
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
.head 5 -  Number: nOrderBy1
.head 5 -  Window Handle: hColumn1
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 6 -  Call SalTblSetTableFlags(hWndForm, TBL_Flag_SelectableCols, TRUE)
.head 6 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 5 +  On UM_Populate
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call SalTblPopulate(hWndForm, ListIn.hSql(),
"SELECT a.id, " || IifS(nUseGateway, "trim(a.tabn)", "a.logname") || ", a.fio, a.tbax" || IifS(nHaveTOBO=2, ", a.branch", "") || " 
   INTO :tbl1.id, :tbl1.login, :tbl1.name, :tbl1.tim" || IifS(nHaveTOBO=2, ", :tbl1.branch", "") || "
   FROM staff a 
  WHERE (a.logname <> user OR a.logname is NULL ) 
    AND nvl(a.bax,0) = 1 
    AND a.active = 1" || IifS(sf!="", " and " || sf, "") ||
" ORDER BY a.tbax DESC " , TBL_FillAll)
.head 6 -  Call SalTblSetLockedColumns(hWndForm, 2)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On SAM_DoubleClick
.head 6 -  Call SalSendMsg(pbCheckOut, SAM_Click, 0, 0)
.head 5 +  On SAM_ColumnSelectClick
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Set hColumn1 = SalNumberToWindowHandle(wParam)
.head 6 -  Set nOrderBy1 = not nOrderBy1
.head 6 -  Call SalTblSortRows(hWndForm, SalTblQueryColumnID(hColumn1), nOrderBy1)
.head 6 -  Call SalTblSetColumnFlags(hColumn1, COL_Selected, FALSE)
.head 6 -  Call SalWaitCursor(FALSE)
.head 3 +  Custom Control: ccSplitter
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 1
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cSplitterWindow
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  DLL Name:
.head 5 -  MS Windows Class Name:
.head 5 -  Style:  Class Default
.head 5 -  ExStyle:  Class Default
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   5.867"
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
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
.head 3 +  Child Table: tbl2  !! их НЕТ
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   6.171"
.head 6 -  Top:    0.042"
.head 6 -  Width:  6.414"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 5.012"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Dark Red
.head 5 -  Background Color: Default
.head 5 -  View: Table
.head 5 -  Allow Row Sizing? No
.head 5 -  Lines Per Row: Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: 2000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: id
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  0.8"
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
.head 5 +  Column: login
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Рабочее
имя
.head 6 -  Visible? Yes
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
.head 5 +  Column: name
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: ОТСУТСТВУЮТ
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  4.0"
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
.head 5 +  Column: tim
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Время УХОДА
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Justify: Left
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Format: DateTime
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
.head 5 +  Column: branch
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Отделение
.head 6 -  Visible? Class Default
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  2.2"
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
.head 5 -  Number: nOrderBy2
.head 5 -  Window Handle: hColumn2
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 6 -  Call SalTblSetTableFlags(hWndForm, TBL_Flag_SelectableCols, TRUE)
.head 6 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 5 +  On UM_Populate
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call SalTblPopulate(hWndForm, ListOut.hSql(), 
"SELECT a.id, " || IifS(nUseGateway, "trim(a.tabn)", "a.logname") || ", a.fio, a.tbax" || IifS(nHaveTOBO=2, ", a.branch", "") || "
   INTO :tbl2.id, :tbl2.login, :tbl2.name, :tbl2.tim" || IifS(nHaveTOBO=2, ", :tbl2.branch", "") || "
   FROM staff a 
  WHERE (a.logname <> user) 
    AND nvl(a.bax,0) = 0 
    AND a.active = 1 " || IifS(sf!="", " and " || sf, "") ||
" ORDER BY a.tbax DESC " , TBL_FillAll)
.head 6 -  Call SalTblSetLockedColumns(hWndForm, 2)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On SAM_DoubleClick
.head 6 -  Call SalSendMsg(pbCheckIn, SAM_Click, 0, 0)
.head 5 +  On SAM_ColumnSelectClick
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Set hColumn2 = SalNumberToWindowHandle(wParam)
.head 6 -  Set nOrderBy2 = not nOrderBy2
.head 6 -  Call SalTblSortRows(hWndForm, SalTblQueryColumnID(hColumn2), nOrderBy2)
.head 6 -  Call SalTblSetColumnFlags(hColumn2, COL_Selected, FALSE)
.head 6 -  Call SalWaitCursor(FALSE)
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Boolean: fAccessWrite
.head 2 +  Window Variables
.head 3 -  : ListIn
.head 4 -  Class: cABSConnect
.head 3 -  : ListOut
.head 4 -  Class: cABSConnect
.head 3 -  : cF
.head 4 -  Class: cGenFilter
.head 3 -  !
.head 3 -  String: strQuery
.head 3 -  String: sf
.head 3 -  String: strWinTitle
.head 3 -  String: strCurUser
.head 3 -  String: strCurWin
.head 3 -  Number: nUId
.head 3 -  !
.head 3 -  Number: nX
.head 3 -  Number: nY
.head 3 -  Number: nUseGateway
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call SalSetWindowText(hWndForm, AppVersion || CurrentLangTable.GetAtomTitle('frmCheckPoint.cTWndTitle'))
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Call XConnectGetParams(ListIn)
.head 4 -  !
.head 4 -  Set nUseGateway = 0
.head 4 -  Call SalUseRegistry(FALSE, '')
.head 4 -  Set nUseGateway = SalGetProfileInt(INI_CommonParameters, 'UseGateway', 0, GetIniFileName())
.head 4 +  If nHaveTOBO != 2
.head 5 -  Call SalHideWindow(tbl1.branch)
.head 5 -  Call SalHideWindow(tbl2.branch)
.head 4 -  !
.head 4 +  If NOT ListIn.Connect()
.head 5 -  Call SalDestroyWindow(hWndItem)
.head 4 -  Call ListOut.Clone(ListIn, TRUE)
.head 4 +  If SqlPrepareAndExecute(ListIn.hSql(), T('SELECT fio FROM staff INTO :strCurUser WHERE logname = user'))
.head 5 -  Call SqlFetchNext(ListIn.hSql(), nFetchRes)
.head 4 -  Call SalGetWindowText(hWndForm, strWinTitle, 254)
.head 4 -  Call SalSetWindowText(hWndForm, strWinTitle || ': ' || strCurUser)
.head 4 -  Call cF.Init('Staff', 'a')
.head 4 -  Call XSalTooltipSetUserDefault()
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalSendClassMessage(SAM_CreateComplete, wParam, lParam)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On VTM_Size
.head 4 -  Call SalGetWindowSize(hWndForm, nX, nY)
.head 4 -  Call SalSetWindowLoc(ccSplitter, nX/2, 0)
.head 4 -  Call SalSendClassMessage(VTM_Size, wParam, lParam)
.head 3 +  On SAM_Destroy
.head 4 -  Call ListIn.Disconnect()
.head 4 -  Call ListOut.Disconnect()
.head 1 +  Table Window: tbl_USERS
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Активные пользователи
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? No
.head 2 -  Display Settings
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
.head 4 -  Width:  10.971"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.792"
.head 4 -  Height Editable? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 3 -  View: Table
.head 3 -  Allow Row Sizing? No
.head 3 -  Lines Per Row: Default
.head 2 -  Memory Settings
.head 3 -  Maximum Rows in Memory: 2000
.head 3 -  Discardable? No
.head 2 -  Description: Информация о пользователях
.head 2 -  Named Menus
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.417"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Contents
.head 4 +  Pushbutton: pbRefresh
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbRefresh
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.043"
.head 6 -  Top:    0.063"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: F5
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
.head 7 -  ! Set strTip = 'Перечитать данные'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('tbl_USERS.cBTipRefresh')
.head 6 +  On SAM_Click
.head 7 -  Call SalPostMsg( hWndForm, SAM_User, 0, 0 )
.head 4 +  Pushbutton: pbFilter
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbFilter
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.483"
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
.head 7 -  ! Set strTip = 'Установить фильтр'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('tbl_USERS.cBTipFilter')
.head 6 +  On SAM_Click
.head 7 +  If SetQueryFilter( cF )
.head 8 -  Call SalPostMsg( hWndForm, SAM_User, 0, 0 )
.head 4 +  Pushbutton: pbSearch
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbSearch
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.917"
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
.head 7 -  ! Set strTip = 'Поиск строки по значению поля'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('tbl_USERS.cBTipSearch')
.head 6 +  On SAM_Click
.head 7 -  Call SalSendMsg( hWndForm, UM_Search, 0, 0 )
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbPrint
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.35"
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
.head 7 -  ! Set strTip = 'Печать содержания таблицы'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('tbl_USERS.cBTipPrint')
.head 6 +  On SAM_Click
.head 7 -  Call SalSendMsg(hWndForm, UM_Print, 0, 0)
.head 7 -  ! Call SaveInfoToLog('Печать формы ' || strTitle)
.head 4 +  Pushbutton: pbMessage
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cTBarButton
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.967"
.head 6 -  Top:    0.063"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: F10
.head 5 -  Font Name: MS Sans Serif
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Tomail.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  ! Set strTip = 'Послать сообщение'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('tbl_USERS.cBTipMessage')
.head 6 +  On SAM_Click
.head 7 -  Call XNetEditMessageTo( hWndForm, ID, TERMI)
.head 4 +  Pushbutton: pbDelete
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbDelete
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.4"
.head 6 -  Top:    0.063"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: F8
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
.head 7 +  If NOT fAdmin
.head 8 -  Call SalDisableWindow( hWndItem )
.head 7 -  ! Set strTip = 'Закрыть сессии...'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('tbl_USERS.cBTipDelete')
.head 6 +  On SAM_Click
.head 7 +  If SalTblAnyRows( hWndForm, ROW_Selected, 0 )
.head 8 -  ! If SalMessageBox("Закрыть выбранные сессии?", "Внимание!", MB_IconQuestion | MB_YesNo) = IDYES
.head 8 +  If SalMessageBox(CurrentLangTable.GetAtomTitle('tbl_USERS.cTClose'), 
  CurrentLangTable.GetAtomTitle('cTAt'), MB_IconQuestion | MB_YesNo) = IDYES
.head 9 -  Set nRow = TBL_MinRow
.head 9 -  Set fCancelLoop = FALSE
.head 9 -  Set fSkipConfirmKillSes = FALSE
.head 9 -  Set fSkipConfirmKillApp = FALSE
.head 9 -  Set nRetQKillSes = IDNO
.head 9 -  Set nRetQKillApp = IDNO
.head 9 +  While ( NOT fCancelLoop ) AND SalTblFindNextRow( hWndForm, nRow, ROW_Selected, 0 )
.head 10 -  Call SalTblSetContext( hWndForm, nRow )
.head 10 +  If NOT fSkipConfirmKillSes
.head 11 -  ! Set nRetQKillSes = XSalAdvMessageBox("Закрыть сессию пользователя " || FIO || " на машине " ||TERMI || "?",
"Внимание!", MB_YesToAll | MB_NoToAll | MB_Cancel, 1 )
.head 11 -  Set nRetQKillSes = XSalAdvMessageBox(
  CurrentLangTable.GetAtomTitle('tbl_USERS.cTCloseSession') || " " || FIO || " " || 
  CurrentLangTable.GetAtomTitle('tbl_USERS.cTMachine') || " " ||TERMI || "?",
  CurrentLangTable.GetAtomTitle('cTAt'), MB_YesToAll | MB_NoToAll | MB_Cancel, 1 )
.head 11 +  If nRetQKillSes = IDYES2ALL OR nRetQKillSes = IDNO2ALL
.head 12 -  Set fSkipConfirmKillSes = TRUE
.head 10 +  If nRetQKillSes = IDYES OR nRetQKillSes = IDYES2ALL
.head 11 +  If SqlPrepareAndExecute( hSqlAux(), "ALTER SYSTEM KILL SESSION '" || SID || "," || SERIA || "'" )
.head 12 +  If NOT fSkipConfirmKillApp
.head 13 -  ! Set nRetQKillApp = XSalAdvMessageBox("Закрыть приложение пользователя " || FIO || " на машине " || TERMI || "?" ||
PutCrLf() || "(Толко для приложения BARS)", "Внимание!", MB_YesToAll | MB_NoToAll, 1 )
.head 13 -  Set nRetQKillApp = XSalAdvMessageBox(
  CurrentLangTable.GetAtomTitle('tbl_USERS.cTCloseApp') || " " || FIO || " " || 
  CurrentLangTable.GetAtomTitle('tbl_USERS.cTMachine')  || " " || TERMI || "?" || PutCrLf() || "(" || 
  CurrentLangTable.GetAtomTitle('tbl_USERS.cTAppBars')  || ")", 
  CurrentLangTable.GetAtomTitle('cTAt'), MB_YesToAll | MB_NoToAll, 1 )
.head 13 +  If nRetQKillSes = IDYES2ALL OR nRetQKillSes = IDNO2ALL
.head 14 -  Set fSkipConfirmKillApp = TRUE
.head 12 +  If nRetQKillSes = IDYES OR nRetQKillSes = IDYES2ALL
.head 13 -  ! Call XNetSendMsg( "Принудительное отключение!", BNTC_APPQUIT, ID, TERMI )
.head 13 -  Call XNetSendMsg( CurrentLangTable.GetAtomTitle('tbl_USERS.cTAppQuit'), BNTC_APPQUIT, ID, TERMI )
.head 11 +  Else
.head 12 -  ! Call SalMessageBox("Невозможно удаление сессии", "Ошибка!", MB_Ok | MB_IconAsterisk )
.head 12 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('tbl_USERS.cTErrDel'), 
  CurrentLangTable.GetAtomTitle('cTErr'), MB_Ok | MB_IconAsterisk )
.head 10 +  If nRetQKillSes = IDCANCEL
.head 11 -  Set fCancelLoop = TRUE
.head 9 -  Call SalPostMsg( hWndForm, SAM_User, 0, 0 )
.head 7 +  Else
.head 8 -  ! Call MessageInfo( 'Не отмечено ни одной записи!' )
.head 8 -  Call MessageInfo( CurrentLangTable.GetAtomTitle('tbl_USERS.cTMess') )
.head 4 +  Pushbutton: pbExit
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbCancel
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.983"
.head 6 -  Top:    0.063"
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
.head 7 -  ! Set strTip = 'Закончить работу'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('tbl_USERS.cBTipExit')
.head 6 +  On SAM_Click
.head 7 -  Call SalDestroyWindow(hWndForm)
.head 2 +  Contents
.head 3 +  Column: PROG
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Программа
пользователя
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 14
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.767"
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
.head 3 +  Column: ID
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Пользователь
 АБС
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 14
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.383"
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
.head 3 +  Column: SERTID
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ид Пользователя
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 14
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.383"
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
.head 3 +  Column: FIO
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ФИО пользователя
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 14
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.8"
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
.head 3 +  Column: TERMI
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Имя
раб.станции
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 5
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.433"
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
.head 3 +  Column: LTIME
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата/Время
подключения
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Left
.head 4 -  Width:  1.883"
.head 4 -  Width Editable? Yes
.head 4 -  Format: dd/MM/yyyy hhhh:mm:ss
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
.head 3 +  Column: colBANKDATE
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Банковская
дата
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.217"
.head 4 -  Width Editable? Yes
.head 4 -  Format: dd/MM/yyyy
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
.head 3 +  Column: SID
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Номер
сессии
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 12
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.767"
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
.head 3 +  Column: SERIA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Серийный
номер
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 3
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.067"
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
.head 3 +  Column: STATU
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Статус
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.383"
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
.head 3 -  Boolean: fAdmin
.head 2 +  Window Variables
.head 3 -  : TTbl
.head 4 -  Class: cABSConnect
.head 3 -  Number: nLastSortColId
.head 3 -  Number: nClickedColId
.head 3 -  Number: nSortDirection
.head 3 -  Number: nRow
.head 3 -  Window Handle: hColClicked
.head 3 -  Number: nWParam
.head 3 -  String: strTitle
.head 3 -  String: strFilterT
.head 3 -  : cF
.head 4 -  Class: cGenFilter
.head 3 -  : cQ
.head 4 -  Class: cGenQuery
.head 3 -  String: strDSql
.head 3 -  String: strSqlPopulate
.head 3 -  Boolean: fCancelLoop
.head 3 -  Boolean: fSkipConfirmKillSes
.head 3 -  Boolean: fSkipConfirmKillApp
.head 3 -  Number: nRetQKillSes
.head 3 -  Number: nRetQKillApp
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call XConnectGetParams(TTbl)
.head 4 +  If NOT TTbl.Connect()
.head 5 -  Return FALSE
.head 4 -  Call XNetInit(hWndMDI, UM_NetMessage, GetUserLoginName(), not BroadcastAllowed(), hSql(), GetDBMS())
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Call XSalTooltipSetUserDefault()
.head 4 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('tbl_USERS.cTWndTitle'))
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  !
.head 4 +  If GetGlobalOptionEx('NBUBANK')
.head 5 -  Call SalHideWindow(hWndForm.tbl_USERS.ID)
.head 4 +  Else
.head 5 -  Call SalHideWindow(hWndForm.tbl_USERS.SERTID)
.head 4 -  !
.head 4 -  Call SalTblSetTableFlags(hWndForm, TBL_Flag_SelectableCols, TRUE)
.head 4 -  Set nLastSortColId = -1
.head 4 -  Set nSortDirection = 1
.head 4 -  Set nWParam = -1
.head 4 -  Set strFilterT = 'V_ACTIVE_USERS'
.head 4 -  Set strSqlPopulate = "
  SELECT program,username,tabn,fio,terminal,
         logon_time, bankdate,
         sid, serial#, status
  FROM v_active_users
   ORDER BY fio,terminal,logon_time "
.head 4 -  !
.head 4 -  Call cQ.Init(strSqlPopulate)
.head 4 -  Call cF.Init(strFilterT, strFilterT)
.head 3 +  On SAM_CreateComplete
.head 4 +  If NOT SetQueryFilter( cF )
.head 5 -  Call SalDestroyWindow( hWndForm )
.head 4 -  Call SalSendMsg(hWndForm, SAM_User, 0,0)
.head 3 +  On SAM_User
.head 4 -  Call SalWaitCursor( TRUE )
.head 4 -  Set strDSql = cQ.GetFullSQLString( cF )
.head 4 -  Call SalTblPopulate(hWndForm, TTbl.hSql(), T(strDSql), TBL_FillAll)
.head 4 +  If nWParam != -1
.head 5 -  Call SalSendMsg( hWndForm, SAM_ColumnSelectClick, nWParam, 0 )
.head 5 -  Call SalSendMsg( hWndForm, SAM_ColumnSelectClick, nWParam, 0 )
.head 4 -  Call VisTblAutoSizeColumn( hWndForm, hWndNULL )
.head 4 -  Call SalWaitCursor( FALSE )
.head 3 +  On SAM_Destroy
.head 4 -  ! Disactivation call function' role
.head 4 -  Call XNetDown()
.head 4 +  If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
.head 5 -  Call XRoleUnset(TTbl.hSql(), ' Show_USERS(hWndMDI,' || SalNumberToStrX(fAdmin,0) || ') ' )
.head 4 -  Call SalSetFocus( SalParentWindow( hWndForm ))
.head 3 +  On SAM_ColumnSelectClick
.head 4 -  Call SalWaitCursor( TRUE )
.head 4 -  Set nWParam = wParam
.head 4 -  Set hColClicked = SalNumberToWindowHandle( wParam )
.head 4 -  Call SalTblSetColumnFlags( hColClicked, COL_Selected, FALSE )
.head 4 -  Set nClickedColId = SalTblQueryColumnID( hColClicked )
.head 4 +  If nClickedColId != nLastSortColId
.head 5 -  Set nLastSortColId = nClickedColId
.head 5 -  Set nSortDirection = 1
.head 4 +  Else
.head 5 -  Set nSortDirection = 1 - nSortDirection
.head 4 -  Call SalTblSortRows( hWndForm, nClickedColId, nSortDirection )
.head 4 -  Call SalWaitCursor( FALSE )
.head 3 +  On UM_Search
.head 4 -  Call TblFindString( hWndForm,  DFIND_First )
.head 3 +  On UM_Print
.head 4 -  Call SalGetWindowText( hWndForm, strTitle, 100 )
.head 4 -  Call TablePrint( hWndForm, strTitle, GetPrnDir() || '\\'
     || 'a_users.txt', '')
.head 1 -  ! Регулирование доступа к счетам
.head 1 +  Form Window: AccessControl
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Просмотр и установка доступа к счетам
.head 2 -  Icon File: \BARS98\RESOURCE\ICO\Lock.ico
.data RESOURCE 2 0 1 3896917988
0000: FE020000E5010000 0000000000000000 0200A20001000120 3010000000E80200
0020: 0000160000002800 0000002000000040 0008000001040000 00A380020000FFFF
0040: 8F80000003008080 0080006800008080 800D008000C0C080 C0000000FF000003
0060: 00FFFF00FF006800 00FFFFFF4D00FF00 007F90F80000007F 99F80000003F0999
0080: F49000003F9999F4 9900005F0999EC99 90005F9999EB0000 6F0999DB9000AF99
00A0: 99D70000D79999A1 9099900000B70999 A890099900003709 99004F9000005799
00C0: 990057990000CB09 0099D40099999052 0099900990B19999 9900120099000099
00E0: 995E990000939900 00092C9999900000 5B990099AC999900 004399B0B0B0B9B0
0100: 9999999000D1B099 B0B0D09999990000 A0B0B0B990000058 99999000B001000B
0120: 99BBBBBBB91A99B0 0000B00800BBBB9B BBBB99209BB900B0 B000008ABBBB9999
0140: 99C2BBBB00B0004D BBB9999B0ABBBB00 000BBBFCBBBB8FB0 000BFDBBEFB0FDBB
0160: 2FB000BBFDBBAF00 00FABBBBD70000F5 BBBBEB0000DB0BBB F6B000FFBFFF00DF
0180: FFFFFFCFFFFFFF00 87FFFFFF03FFFFFE 4001FFFFFC00FFF8 04007FF0003FFFC0
01A0: 00001FFFE0000FFF E01107FFC003FF8C 400001FF1E00003F 0400033F8007FF00
01C0: 010FFC00001FF000 00003FC000000F80 0000000700000003 0000CC00030003CC
01E0: 0003000318000380 07C000110FF0003F FC0021FFFF8007
.enddata
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? No
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? No
.head 3 -  Initial State: Normal
.head 3 -  Maximizable? Yes
.head 3 -  Minimizable? Yes
.head 3 -  System Menu? Yes
.head 3 -  Resizable? Yes
.head 3 -  Window Location and Size
.head 4 -  Left:   0.44"
.head 4 -  Top:    0.525"
.head 4 -  Width:  12.443"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 6.405"
.head 4 -  Height Editable? Yes
.head 3 -  Form Size
.head 4 -  Width:  Default
.head 4 -  Height: Default
.head 4 -  Number of Pages: Dynamic
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: 3D Face Color
.head 2 -  Description: Просмотр и установка доступа к счетам
.head 2 +  Named Menus
.head 3 +  Menu: pmGrpMem
.head 4 -  Resource Id: 41726
.head 4 -  Title:
.head 4 -  Description:
.head 4 -  Enabled when:
.head 4 -  Status Text:
.head 4 -  Menu Item Name:
.head 4 +  Menu Item: Добавить
.head 5 -  Resource Id: 41727
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text: Добавить пользователя в группу
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg(hWndMain.AccessControl.tblGroupMem, SAM_DoubleClick, 0, 0)
.head 5 -  Menu Item Name:
.head 4 +  Menu Item: Удалить
.head 5 -  Resource Id: 41728
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text: Удалить пользователя из группы
.head 5 +  Menu Settings
.head 6 -  Enabled when: fDelGrpMem
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg(hWndMain.AccessControl.tblGroupMem, UM_DelRow, 0, 0)
.head 5 -  Menu Item Name:
.head 3 +  Menu: pmGroupAcc
.head 4 -  Resource Id: 41729
.head 4 -  Title:
.head 4 -  Description:
.head 4 -  Enabled when:
.head 4 -  Status Text:
.head 4 -  Menu Item Name:
.head 4 +  Menu Item: Добавить
.head 5 -  Resource Id: 41730
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg(hWndMain.AccessControl.tblGroupAcc, SAM_DoubleClick, 0, 0)
.head 5 -  Menu Item Name:
.head 4 +  Menu Item: Удалить
.head 5 -  Resource Id: 41731
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when: fDelGrpAcc
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg(hWndMain.AccessControl.tblGroupAcc, UM_DelRow, 0, 0)
.head 5 -  Menu Item Name:
.head 3 +  Menu: pmGroupStaff
.head 4 -  Resource Id: 41732
.head 4 -  Title:
.head 4 -  Description:
.head 4 -  Enabled when:
.head 4 -  Status Text:
.head 4 -  Menu Item Name:
.head 4 +  Menu Item: Добавить
.head 5 -  Resource Id: 41733
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg(hWndMain.AccessControl.tblGroupStaff, SAM_DoubleClick, 0, 0)
.head 5 -  Menu Item Name:
.head 4 +  Menu Item: Удалить
.head 5 -  Resource Id: 41734
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when: fDelGrpStaff
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg(hWndMain.AccessControl.tblGroupStaff, UM_DelRow, 0, 0)
.head 5 -  Menu Item Name:
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Etched
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.464"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Contents
.head 4 +  Pushbutton: pbSwitch
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbSwitch
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.1"
.head 6 -  Top:    0.083"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Switch.bmp
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  ! Пользователи
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('AccessControl.cBTipSwitchUser')
.head 6 +  On SAM_Click
.head 7 -  Set hWndMain.AccessControl.nViewMode = hWndMain.AccessControl.nViewMode + 1
.head 7 +  If hWndMain.AccessControl.nViewMode = 3
.head 8 -  Set hWndMain.AccessControl.nViewMode = 0
.head 7 -  ! Показываем доступ к счетам
.head 7 +  If hWndMain.AccessControl.nViewMode = 0
.head 8 -  ! Пользователи
.head 8 -  Set strTip = CurrentLangTable.GetAtomTitle('AccessControl.cBTipSwitchUser')
.head 8 -  ! Просмотр и установка доступа к счетам
.head 8 -  Set sTitle = AppVersion || CurrentLangTable.GetAtomTitle('AccessControl.cTWndTitleAcc')
.head 8 -  Call SalSetWindowText(hWndForm, sTitle)
.head 8 -  ! Hide
.head 8 -  Call SalHideWindow(hWndForm.AccessControl.tbl1)
.head 8 -  Call SalHideWindow(hWndForm.AccessControl.tbl2)
.head 8 -  Call SalTblReset(hWndForm.AccessControl.tbl2)
.head 8 -  ! Show
.head 8 -  Call SalEnableWindow(pbRefresh)
.head 8 -  Call SalEnableWindow(pbSave)
.head 8 -  Call SalShowWindow(hWndForm.AccessControl.tblAcc)
.head 8 -  Call SalShowWindow(dfGroupAcc)
.head 8 -  Call SalShowWindow(dfGroupStaff)
.head 8 -  Call SalShowWindow(dfGroupMem)
.head 8 -  ! Populate
.head 8 -  Call SalSendMsg(hWndForm.AccessControl.tblAcc, UM_Populate, 0, 0)
.head 8 -  Call SaveInfoToLog(sFuncName || '. Переход в режим установки доступа')
.head 7 -  ! Показываем пользователей и обслуживаемые ими счета
.head 7 +  Else If hWndMain.AccessControl.nViewMode = 1
.head 8 +  If NOT fSave
.head 9 -  ! Настройки не сохранены!
.head 9 +  If IDYES = SalMessageBox(CurrentLangTable.GetAtomTitle('AccessControl.cTMsgSave') || ' ' || PutCrLf() || 
   CurrentLangTable.GetAtomTitle('AccessControl.cBTipSave') || '?', 
   CurrentLangTable.GetAtomTitle('cTAt'), MB_YesNo | MB_IconExclamation)
.head 10 -  Call SalSendMsg(pbSave, SAM_Click, 0, 0)
.head 9 +  Else
.head 10 -  Call SqlRollbackEx(hpSelUpd.hSql(), sFuncName ||' : Отказ от сохранений установок доступа')
.head 8 -  ! Группы
.head 8 -  Set strTip = CurrentLangTable.GetAtomTitle('AccessControl.cBTipSwitchGr')
.head 8 -  ! Счета пользователей
.head 8 -  Set sTitle = AppVersion || CurrentLangTable.GetAtomTitle('AccessControl.cTWndTitleUser')
.head 8 -  Call SalSetWindowText(hWndForm, sTitle)
.head 8 -  ! ФИО
.head 8 -  Call SalTblSetColumnTitle(hWndForm.AccessControl.tbl1.name, CurrentLangTable.GetAtomTitle('AccessControl.cTColTitleFio'))
.head 8 -  Call SaveInfoToLog(sFuncName || '. Переход в режим просмотра прав пользователей на счета')
.head 8 -  Call InitStrSqlPopulate()
.head 8 -  ! Hide and reset
.head 8 -  Call SalDisableWindow(pbRefresh)
.head 8 -  Call SalDisableWindow(pbSave)
.head 8 -  Call SalHideWindow(hWndForm.AccessControl.tblAcc)
.head 8 -  Call SalHideWindow(pbGroupAcc)
.head 8 -  Call SalHideWindow(dfGroupAcc)
.head 8 -  Call SalHideWindow(hWndForm.AccessControl.tblGroupAcc)
.head 8 -  Call SalHideWindow(pbGroupStaff)
.head 8 -  Call SalHideWindow(dfGroupStaff)
.head 8 -  Call SalHideWindow(hWndForm.AccessControl.tblGroupStaff)
.head 8 -  Call SalHideWindow(dfGroupMem)
.head 8 -  Call SalHideWindow(hWndForm.AccessControl.tblGroupMem)
.head 8 -  ! Show and populate
.head 8 -  Call SalShowWindow(hWndForm.AccessControl.tbl1)
.head 8 -  Call SalShowWindow(hWndForm.AccessControl.tbl2)
.head 8 -  Call SalSendMsg(hWndForm.AccessControl.tbl1, UM_Populate, 0, 0)
.head 7 -  ! Показываем группы и обслуживаемые ими счета
.head 7 +  Else If hWndMain.AccessControl.nViewMode = 2
.head 8 -  ! Доступ к счетам
.head 8 -  Set strTip = CurrentLangTable.GetAtomTitle('AccessControl.cBTipSwitchAcc')
.head 8 -  ! Состав групп доступа
.head 8 -  Set sTitle = AppVersion || CurrentLangTable.GetAtomTitle('AccessControl.cTWndTitleGr')
.head 8 -  Call SalSetWindowText(hWndForm, sTitle)
.head 8 -  ! Группа
.head 8 -  Call SalTblSetColumnTitle(hWndForm.AccessControl.tbl1.name, CurrentLangTable.GetAtomTitle('AccessControl.cTColTitleGr')  )
.head 8 -  Call SaveInfoToLog(sFuncName || '. Переход в режим просмотра состава групп счетов')
.head 8 -  Call InitStrSqlPopulate()
.head 8 -  Call SalDisableWindow(pbSave)
.head 8 -  Call SalSendMsg(hWndForm.AccessControl.tbl1, UM_Populate, 0, 0)
.head 4 +  Pushbutton: pbRefresh
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbRefresh
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.533"
.head 6 -  Top:    0.083"
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
.head 7 +  If hWndMain.AccessControl.nViewMode = 0
.head 8 -  Call SqlRollback(hpSelUpd.hSql())
.head 8 -  Call SaveInfoToLog(sFuncName || '. Сброс параметров(перечитать) функции: ' || IifS(nP>0,
     CurrentLangTable.GetAtomTitle('AccessControl.cTWndTitleAcc'),
     CurrentLangTable.GetAtomTitle('AccessControl.cTWndTitle')))
.head 8 -  Call SalSendMsg(hWndForm.AccessControl.tblAcc, UM_Populate, 0, 0)
.head 4 +  Pushbutton: pbFind
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbSearch
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.967"
.head 6 -  Top:    0.083"
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
.head 7 -  ! Поиск
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('AccessControl.cBTipFind')
.head 6 +  On SAM_Click
.head 7 +  If hWndMain.AccessControl.nViewMode=0
.head 8 -  Call TblFindString(hWndForm.AccessControl.tblAcc, 1)
.head 7 +  Else
.head 8 -  Call TblFindString(hWndForm.AccessControl.tbl1, 1)
.head 4 +  Pushbutton: pbMainFilter
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbFilter
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.4"
.head 6 -  Top:    0.085"
.head 6 -  Width:  0.433"
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
.head 7 -  ! Фильтр по основной таблице
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('AccessControl.cBTipMainFilter')
.head 6 +  On SAM_Click
.head 7 +  If hWndMain.AccessControl.nViewMode = 0		!! счета
.head 8 -  Call SalSendMsg(hWndForm.AccessControl.tblAcc, UM_Filter, 0, 0)
.head 7 +  Else !! пользователи, исполнители, группы доступа
.head 8 -  Call SalSendMsg(hWndForm.AccessControl.tbl1, UM_Filter, 0, 0)
.head 4 -  Line
.head 5 -  Resource Id: 41735
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  1.933"
.head 6 -  Begin Y:  0.071"
.head 6 -  End X:  1.933"
.head 6 -  End Y:  0.405"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: Default
.head 4 +  Pushbutton: pbAdd
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbCancel
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.033"
.head 6 -  Top:    0.083"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Insert.bmp
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  ! Добавить пользователя в группу
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('AccessControl.cBTipAdd')
.head 6 +  On SAM_Click
.head 7 -  Call SalSendMsg(hWndForm.AccessControl.tblGroupMem, SAM_DoubleClick, 0, 0)
.head 4 +  Pushbutton: pbDelete
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbCancel
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.467"
.head 6 -  Top:    0.083"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Delrec.bmp
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  ! Удалить пользователя из группы
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('AccessControl.cBTipDelete')
.head 6 +  On SAM_Click
.head 7 -  Call SalSetFocus(hWndForm.AccessControl.tblGroupMem)
.head 7 -  Call SalSendMsg(hWndForm.AccessControl.tblGroupMem, UM_DelRow, 0, 0)
.head 4 +  Pushbutton: pbAuxFilter
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbFilter
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.083"
.head 6 -  Top:    0.085"
.head 6 -  Width:  0.45"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Yes
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
.head 7 -  ! Фильтр по детальной таблице
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('AccessControl.cBTipAuxFilter')
.head 6 +  On SAM_Click
.head 7 -  Call SalSendMsg(hWndForm.AccessControl.tbl2, UM_Filter, 0, 0)
.head 4 -  Line
.head 5 -  Resource Id: 41736
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  3.0"
.head 6 -  Begin Y:  0.095"
.head 6 -  End X:  3.0"
.head 6 -  End Y:  0.429"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: Default
.head 4 +  Pushbutton: pbSave
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbCancel
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.583"
.head 6 -  Top:    0.083"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Save.bmp
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  ! Сохранить
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('AccessControl.cBTipSave')
.head 6 +  On SAM_Click
.head 7 +  If SqlCommitEx(hpSelUpd.hSql(), sFuncName ||' : Сохранены установки доступа')
.head 8 -  Set fSave = TRUE
.head 7 -  Call SalSendMsg(hWndMain.AccessControl.tblAcc, UM_Populate, 0, 0)
.head 4 +  Pushbutton: pbCancel
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbCancel
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   5.033"
.head 6 -  Top:    0.083"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Discard.bmp
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  ! Выйти
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('AccessControl.cBTipCancel')
.head 6 +  On SAM_Click
.head 7 -  If IfClose()
.head 7 +  Else
.head 8 -  Call SqlRollback(hpSelUpd.hSql())
.head 8 -  Call SalDestroyWindow(hWndForm)
.head 2 +  Contents
.head 3 +  Child Table: tblAcc
.data CLASSPROPSSIZE
0000: D101
.enddata
.data CLASSPROPS
0000: 5550444154454142 4C45000500545255 45000053484F574C 4F47494E00060046
0020: 414C534500005345 4C4F524445520015 00224E4C53222041 5343202C224B5622
0040: 2041534320000046 494C4C414C4C0006 0046414C53450000 54494E53001B0054
0060: 4F5F444154452827 2573272C27686832 342E6D692E737327 2900005553455200
0080: 0500626172730000 54424E414D450009 004143434F554E54 5300004441544153
00A0: 4F55524345000400 5945530000574952 4544000400010000 000053594D424F4C
00C0: 4E414D45000D0074 626C4143434F554E 5453310000544142 4C45530009004143
00E0: 434F554E54530000 4441544142415345 0005006167696F00 0050415353574F52
0100: 4400050062617273 00004454494E5300 2700544F5F444154 4528272573272C27
0120: 4D4F4E2044442059 5959592068683234 2E6D692E73732729 000044494E53001C
0140: 00544F5F44415445 28272573272C274D 4F4E204444205959 5959272900005345
0160: 4C57484552450001 0000005553455359 5356415253000600 46414C534500004B
0180: 4559494E464F0006 00524F5749440000 504F50554C415445 204F4E2043524541
01A0: 5445000500545255 4500000000000000 0000000000000000 0000000000000000
01C0: 0000000000000000 0000000000000000 00
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
.head 6 -  Left:   0.029"
.head 6 -  Top:    0.021"
.head 6 -  Width:  5.943"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 5.06"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  View: Table
.head 5 -  Allow Row Sizing? No
.head 5 -  Lines Per Row: Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: 64000
.head 5 -  Discardable? Yes
.head 4 +  Contents
.head 5 +  Column: colKv
.data INHERITPROPS
0000: 0100
.enddata
.data CLASSPROPS
0000: 57495245444E414D 450003004B560000 5749524544495445 4D0003004B560000
0020: 4954454D0003004B 560000434F4C554D 4E20545950450002 00430000434F4C55
0040: 4D4E2053514C0005 00224B5622000043 4F4C554D4E204E41 4D450003004B5600
0060: 0047545459504500 0200370000534F55 524345000D007462 6C4143434F554E54
0080: 5331000057495245 44534F5552434500 0D0074626C414343 4F554E5453310000
00A0: 0000000000000000 0000000000000000 0000
.enddata
.data CLASSPROPSSIZE
0000: B200
.enddata
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Вал.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Center
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
.head 5 +  Column: colNls
.data INHERITPROPS
0000: 0100
.enddata
.data CLASSPROPS
0000: 57495245444E414D 450004004E4C5300 0057495245444954 454D0004004E4C53
0020: 00004954454D0004 004E4C530000434F 4C554D4E20545950 4500020043000043
0040: 4F4C554D4E205351 4C000600224E4C53 220000434F4C554D 4E204E414D450004
0060: 004E4C5300004754 5459504500020035 0000534F55524345 000D0074626C4143
0080: 434F554E54533100 005749524544534F 55524345000D0074 626C4143434F554E
00A0: 5453310000000000 0000000000000000 00000000000000
.enddata
.data CLASSPROPSSIZE
0000: B700
.enddata
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Лицевой Счет
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 15
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.583"
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
.head 5 +  Column: colNms
.data INHERITPROPS
0000: 0100
.enddata
.data CLASSPROPS
0000: 57495245444E414D 450004004E4D5300 0057495245444954 454D0004004E4D53
0020: 00004954454D0004 004E4D530000434F 4C554D4E20545950 4500020043000043
0040: 4F4C554D4E205351 4C000600224E4D53 220000434F4C554D 4E204E414D450004
0060: 004E4D5300004754 5459504500020035 0000534F55524345 000D0074626C4143
0080: 434F554E54533100 005749524544534F 55524345000D0074 626C4143434F554E
00A0: 5453310000000000 0000000000000000 00000000000000
.enddata
.data CLASSPROPSSIZE
0000: B700
.enddata
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Название счета
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 70
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  3.0"
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
.head 5 +  Column: colAcc
.data INHERITPROPS
0000: 0100
.enddata
.data CLASSPROPS
0000: 57495245444E414D 4500040041434300 0057495245444954 454D000400414343
0020: 00004954454D0004 004143430000434F 4C554D4E20545950 4500020043000043
0040: 4F4C554D4E205351 4C00060022414343 220000434F4C554D 4E204E414D450004
0060: 0041434300004754 5459504500020037 0000534F55524345 000D0074626C4143
0080: 434F554E54533100 005749524544534F 55524345000D0074 626C4143434F554E
00A0: 5453310000000000 0000000000000000 00000000000000
.enddata
.data CLASSPROPSSIZE
0000: B700
.enddata
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Acc
.head 6 -  Visible? No
.head 6 -  Editable? Yes
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
.head 4 -  Functions
.head 4 +  Window Variables
.head 5 -  : cQry
.head 6 -  Class: cGenQuery
.head 5 -  String: sMainSqlText
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 6 -  Call SalTblSetTableFlags(hWndForm, TBL_Flag_SingleSelection, TRUE)
.head 6 -  Call cFltAcc.Init('ACCOUNTS', 'a')
.head 6 -  Set sMainSqlText =
"SELECT v.lcv, a.nls, a.nms, a.acc
   INTO :colKv, :colNls, :colNms, :colAcc
   FROM accounts a, tabval v
  WHERE a.kv=v.kv AND a.dazs IS NULL
  ORDER BY a.nls,a.kv"
.head 6 -  Call cQry.Init(sMainSqlText)
.head 5 +  On UM_Populate		!Население таблицы
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Set sMainSqlText = cQry.GetFullSQLString(cFltAcc)
.head 6 +  If cFltAcc.GetFilterWhereClause(FALSE)
.head 7 -  ! с Фильтром
.head 7 -  Call SalSetWindowText(hWndMain, sTitle || ' (' || CurrentLangTable.GetAtomTitle('AccessControl.cTWithFilter') || ')')
.head 6 +  Else
.head 7 -  Call SalSetWindowText(hWndMain, sTitle)
.head 6 -  Call SalTblPopulate(hWndForm, hpMaster.hSql(), T(sMainSqlText), TBL_FillAll)
.head 6 -  Call SelFirstRow(hWndForm)
.head 6 -  Call SalSendMsg(hWndForm, SAM_RowSetContext, 0, 0)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On SAM_RowSetContext	!Население таблиц деталей
.head 6 -  Set nCurrAcc = colAcc
.head 6 -  Set sCurrNls = colNls
.head 6 -  Set sCurrKv  = colKv
.head 6 -  Call SalSendMsg(tblGroupAcc, UM_Populate, 0 , 0)
.head 5 +  On UM_Filter		!Фильтрование таблицы
.head 6 +  If SetQueryFilter(cFltAcc)
.head 7 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 3 +  Pushbutton: pbGroupAcc
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: -
.head 4 -  Window Location and Size
.head 5 -  Left:   6.071"
.head 5 -  Top:    0.1"
.head 5 -  Width:  0.314"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
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
.head 6 +  If SalGetWindowState(tblGroupAcc) = Window_NotVisible
.head 7 -  Call SalSendMsg(tblGroupAcc, SAM_DoubleClick, 0, 0)
.head 3 +  Data Field: dfGroupAcc
.data INHERITPROPS
0000: 0100
.enddata
.data CLASSPROPS
0000: 534F55524345000D 0074626C4143434F 554E5453310000
.enddata
.data CLASSPROPSSIZE
0000: 1700
.enddata
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
.head 6 -  Left:   6.517"
.head 6 -  Top:    0.1"
.head 6 -  Width:  4.5"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Child Table: tblGroupAcc
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   6.067"
.head 6 -  Top:    0.31"
.head 6 -  Width:  5.317"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 1.4"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: 8
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
.head 5 +  Column: colGId
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 6
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  0.7"
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
.head 5 +  Column: colGName
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Группа
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  3.543"
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
.head 5 +  Function: InGroupAcc
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: nGrp
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 6 +  Actions
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(tblGroupAcc, nRow, 0, 0)
.head 8 -  Call SalTblSetContext(tblGroupAcc, nRow)
.head 8 +  If tblGroupAcc.colGId = nGrp
.head 9 -  Return TRUE
.head 7 -  Return FALSE
.head 4 +  Window Variables
.head 5 -  Number: nNewGroupId
.head 5 -  Number: nRowNew
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 6 -  Call SalTblSetTableFlags(hWndForm, TBL_Flag_SingleSelection, TRUE)
.head 5 +  On UM_Populate
.head 6 -  Call SalTblPopulate(hWndForm, hSql(),
"SELECT g.id, g.name 
   INTO :colGId, :colGName 
   FROM groups_acc g, table(sec.getAgrp(:nCurrAcc)) b 
  WHERE g.id=b.column_value 
  ORDER BY g.id", TBL_FillAll)
.head 6 -  Call SelFirstRow(hWndForm)
.head 6 -  Call SalSendMsg(hWndForm, SAM_RowSetContext, 0, 0)
.head 5 +  On SAM_RowSetContext
.head 6 -  Set nCurrAccGrp = colGId
.head 6 -  Set sCurrAccGrpName = colGName
.head 6 +  If colGId
.head 7 -  Call SqlClose(hpSelUpd.hSql())
.head 7 -  Call SalHideWindow(pbGroupAcc)
.head 7 -  Call SalShowWindow(tblGroupAcc)
.head 7 -  Call SalStrTrim(hWndForm.tblGroupAcc.colGName, strTmp)
.head 7 -  ! Группа обслуживающая  счет
.head 7 -  Set dfGroupAcc = CurrentLangTable.GetAtomTitle('AccessControl.cTMsgGMsg2')
.head 7 -  Call SalSendMsg(tblGroupStaff, UM_Populate, 0, 0)
.head 6 +  Else
.head 7 -  Set colGId = 0
.head 7 -  Set colGName = ''
.head 7 -  Call SalShowWindow(pbGroupAcc)
.head 7 -  Call SalSetWindowText(pbGroupAcc , '+')
.head 7 -  ! Группа не назначена
.head 7 -  Set dfGroupAcc = CurrentLangTable.GetAtomTitle('AccessControl.cTMsgGMsg1')
.head 7 -  Set dfGroupStaff = ''
.head 7 -  Set dfGroupMem = ''
.head 7 -  Call SalHideWindow(pbGroupStaff)
.head 7 -  Call SalHideWindow(tblGroupAcc)
.head 7 -  Call SalHideWindow(tblGroupStaff)
.head 7 -  Call SalHideWindow(tblGroupMem)
.head 7 -  Call SqlClose(hpSelUpd.hSql())
.head 5 +  On SAM_ContextMenu
.head 6 -  Set fDelGrpAcc = SalTblAnyRows(hWndForm, ROW_Selected, 0)
.head 6 -  Call SalTrackPopupMenu(hWndMain, "pmGroupAcc", TPM_CursorX | TPM_CursorY , 0, 0)
.head 5 +  On SAM_DoubleClick
.head 6 +  If nP = 1
.head 7 -  Set nNewGroupId = 0
.head 7 -  Set nNewGroupId = SalModalDialog(acNewGroup, hWndNULL, 1)
.head 7 +  If nNewGroupId != 0
.head 8 +  If NOT InGroupAcc(nNewGroupId)
.head 9 -  Set nRowNew = SalTblInsertRow(hWndForm, TBL_MaxRow)
.head 9 -  Call SalTblSetContext(hWndForm, nRowNew)
.head 9 -  Call SqlPLSQLCommand(hpSelUpd.hSql(), "sec.addAgrp(nCurrAcc, nNewGroupId)")
.head 9 -  Call SqlClose(hpSelUpd.hSql())
.head 9 -  Set fSave = FALSE
.head 9 -  Call SaveInfoToLog(sFuncName || '. Счет #'|| sCurrNls || '(' || sCurrKv || ')' ||' добавлен в группу #'|| Str(nNewGroupId))
.head 8 -  Call SalSendMsg(tblAcc, SAM_RowSetContext, 0, 0)
.head 5 +  On UM_DelRow
.head 6 +  If nP = 1
.head 7 -  Call SqlPLSQLCommand(hpSelUpd.hSql(),
"sec.delAgrp(nCurrAcc, nCurrAccGrp)")
.head 7 -  Call SqlClose(hpSelUpd.hSql())
.head 7 -  Set fSave = FALSE
.head 7 -  Call SaveInfoToLog(sFuncName || '. Счет #'|| sCurrNls || '(' || sCurrKv || ')' ||' удален из группы #'|| SalNumberToStrX(nCurrAccGrp, 0))
.head 7 -  Call SalSendMsg(tblAcc, SAM_RowSetContext, 0, 0)
.head 3 +  Pushbutton: pbGroupStaff
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: -
.head 4 -  Window Location and Size
.head 5 -  Left:   6.067"
.head 5 -  Top:    1.798"
.head 5 -  Width:  0.317"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
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
.head 6 +  If SalGetWindowState(tblGroupStaff) = Window_NotVisible
.head 7 -  Call SalSendMsg(tblGroupStaff, SAM_DoubleClick, 0, 0)
.head 3 +  Data Field: dfGroupStaff
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
.head 6 -  Left:   6.55"
.head 6 -  Top:    1.8"
.head 6 -  Width:  4.5"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
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
.head 3 +  Child Table: tblGroupStaff
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   6.067"
.head 6 -  Top:    2.0"
.head 6 -  Width:  5.167"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 1.4"
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
.head 5 +  Column: colGId
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
.head 6 -  Visible? Class Default
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Class Default
.head 6 -  Width:  0.7"
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
.head 5 +  Column: colGName
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Группа
.head 6 -  Visible? Class Default
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  3.5"
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
.head 5 -  Number: nNewGroupId
.head 5 -  Number: nRowNew
.head 5 -  Number: nCount
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 6 -  Call SalTblSetTableFlags(hWndForm, TBL_Flag_SingleSelection, TRUE)
.head 5 +  On UM_Populate
.head 6 -  Call SalTblPopulate(hWndForm, hSql(),
"SELECT g.id, g.name
   INTO :colGId, :colGName
   FROM groups_staff_acc c, groups g
  WHERE c.idg=g.id AND c.ida=:nCurrAccGrp
  ORDER BY g.id", TBL_FillAll)
.head 6 -  Call SelFirstRow(hWndForm)
.head 6 -  Call SalSendMsg(hWndForm, SAM_RowSetContext, 0, 0)
.head 5 +  On SAM_RowSetContext
.head 6 -  Set nCurrStaffGrp = colGId
.head 6 -  Set sCurrStaffGrpName = colGName
.head 6 +  If nCurrStaffGrp
.head 7 -  Call SqlClose(hpSelUpd.hSql())
.head 7 -  Call SalHideWindow(pbGroupStaff)
.head 7 -  Call SalShowWindow(dfGroupStaff)
.head 7 -  Call SalShowWindow(tblGroupStaff)
.head 7 -  ! Set dfGroupStaff = 'Группа пользователей, обслуживающая группу счетов << '||strTmp||' >>'
.head 7 -  Set dfGroupStaff = CurrentLangTable.GetAtomTitle('AccessControl.cTMsgGMsg3') || ' << ' || sCurrAccGrpName || ' >>'
.head 7 -  Call SalShowWindow(dfGroupMem)
.head 7 -  Call SalShowWindow(tblGroupMem)
.head 7 -  ! Set dfGroupMem='Состав группы << '||strTmp||' >>'
.head 7 -  Set dfGroupMem = CurrentLangTable.GetAtomTitle('AccessControl.cTMsgGName') || ' << ' || sCurrStaffGrpName || ' >>'
.head 7 -  Call SalSendMsg(tblGroupMem, UM_Populate, 0, 0)
.head 6 +  Else
.head 7 -  Set tblGroupStaff.colGId = 0
.head 7 -  Set tblGroupStaff.colGName = ''
.head 7 -  Call SalShowWindow(pbGroupStaff)
.head 7 -  Call SalSetWindowText(pbGroupStaff , '+')
.head 7 -  ! Set dfGroupMessage='Группа не назначена'
.head 7 -  Set dfGroupStaff = CurrentLangTable.GetAtomTitle('AccessControl.cTMsgGMsg1')
.head 7 -  Set dfGroupMem = ''
.head 7 -  Call SalHideWindow(tblGroupStaff)
.head 7 -  Call SalHideWindow(tblGroupMem)
.head 7 -  Call SqlClose(hpSelUpd.hSql())
.head 5 +  On SAM_ContextMenu
.head 6 -  Set fDelGrpStaff = SalTblAnyRows(hWndForm, ROW_Selected, 0)
.head 6 -  Call SalTrackPopupMenu(hWndMain, "pmGroupStaff", TPM_CursorX | TPM_CursorY , 0, 0)
.head 5 +  On SAM_DoubleClick
.head 6 +  If nP = 1
.head 7 -  Set nNewGroupId = 0
.head 7 -  Set nNewGroupId = SalModalDialog(acNewGroup, hWndNULL, 2)
.head 7 +  If nNewGroupId != 0
.head 8 -  Set strSql =
"SELECT COUNT(*) INTO :nCount FROM groups_staff_acc
 WHERE idg=:nNewGroupId AND ida=:nCurrAccGrp"
.head 8 -  Call SqlPrepareAndExecute(hpSelUpd.hSql(), T(strSql))
.head 8 -  Call SqlFetchNext(hpSelUpd.hSql(), nFetchRes)
.head 8 -  Call SqlClose(hpSelUpd.hSql())
.head 8 +  If nCount = 0
.head 9 -  Set nRowNew = SalTblInsertRow(hWndForm, TBL_MaxRow)
.head 9 -  Call SalTblSetContext(hWndForm, nRowNew)
.head 9 -  Set strSql =
"INSERT INTO groups_staff_acc(ida, idg)
 VALUES(:nCurrAccGrp, :nNewGroupId)"
.head 9 -  Call SqlPrepareAndExecute(hpSelUpd.hSql(), strSql)
.head 9 -  Call SqlClose(hpSelUpd.hSql())
.head 9 -  Set fSave = FALSE
.head 9 -  Call SaveInfoToLog(sFuncName || '. Группа счетов #'|| Str(nCurrAccGrp) || ' добавлена в группу #'|| SalNumberToStrX(nCurrStaffGrp, 0))
.head 8 -  Call SalSendMsg(tblGroupAcc, SAM_RowSetContext, 0, 0)
.head 5 +  On UM_DelRow
.head 6 +  If nP = 1
.head 7 -  Set strSql =
"DELETE FROM groups_staff_acc " ||
"WHERE idg=:nCurrStaffGrp AND ida=:nCurrAccGrp"
.head 7 -  Call SqlPrepareAndExecute(hpSelUpd.hSql(), strSql)
.head 7 -  Call SqlClose(hpSelUpd.hSql())
.head 7 -  Set fSave = FALSE
.head 7 -  Call SaveInfoToLog(sFuncName || '. Группа счетов #'|| Str(nCurrAccGrp) || ' удалена из группы #'|| SalNumberToStrX(nCurrStaffGrp, 0))
.head 7 -  Call SalSendMsg(tblGroupAcc, SAM_RowSetContext, 0, 0)
.head 3 +  Data Field: dfGroupMem
.data INHERITPROPS
0000: 0100
.enddata
.data CLASSPROPS
0000: 534F55524345000D 0074626C4143434F 554E5453310000
.enddata
.data CLASSPROPSSIZE
0000: 1700
.enddata
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
.head 6 -  Left:   6.567"
.head 6 -  Top:    3.5"
.head 6 -  Width:  4.5"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Child Table: tblGroupMem
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   6.067"
.head 6 -  Top:    3.7"
.head 6 -  Width:  5.317"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 1.4"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  View: Table
.head 5 -  Allow Row Sizing? No
.head 5 -  Lines Per Row: Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: 5000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colGId
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 6
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  0.7"
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
.head 5 +  Column: colGFio
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Ф.И.О.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  2.517"
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
.head 5 +  Column: colGSec
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: sec
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
.head 5 +  Column: colGView
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Пр
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  0.357"
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
.head 7 +  On SAM_AnyEdit
.head 8 -  Call EncodeAccess(colGSec, colGView, colGDebit, colGCredit)
.head 8 -  Set strSql =
"UPDATE groups_staff 
    SET secg=:colGSec
  WHERE idu=:colGId AND idg=:nCurrStaffGrp"
.head 8 -  Call SqlPrepareAndExecute(hpSelUpd.hSql(), strSql)
.head 8 -  Call SqlClose(hpSelUpd.hSql())
.head 8 -  Set fSave = FALSE
.head 5 +  Column: colGDebit
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Дб
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  0.357"
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
.head 7 +  On SAM_AnyEdit
.head 8 -  Call EncodeAccess(colGSec, colGView, colGDebit, colGCredit)
.head 8 -  Set strSql =
"UPDATE groups_staff 
    SET secg=:colGSec
  WHERE idu=:colGId AND idg=:nCurrStaffGrp"
.head 8 -  Call SqlPrepareAndExecute(hpSelUpd.hSql(), strSql)
.head 8 -  Call SqlClose(hpSelUpd.hSql())
.head 8 -  Set fSave = FALSE
.head 5 +  Column: colGCredit
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Кр
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  0.343"
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
.head 7 +  On SAM_AnyEdit
.head 8 -  Call EncodeAccess(colGSec, colGView, colGDebit, colGCredit)
.head 8 -  Set strSql =
"UPDATE groups_staff 
    SET secg=:colGSec
  WHERE idu=:colGId AND idg=:nCurrStaffGrp"
.head 8 -  Call SqlPrepareAndExecute(hpSelUpd.hSql(), strSql)
.head 8 -  Call SqlClose(hpSelUpd.hSql())
.head 8 -  Set fSave = FALSE
.head 5 +  Column: colApprove
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
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
.head 4 +  Functions
.head 5 +  Function: EnableButton
.head 6 -  Description:
.head 6 -  Returns
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 +  If fDelGrpMem
.head 8 -  Call SalEnableWindow(pbDelete)
.head 7 +  Else
.head 8 -  Call SalDisableWindow(pbDelete)
.head 7 +  If nP = 1
.head 8 -  Call SalEnableWindow(pbAdd)
.head 8 -  Call SalEnableWindow(pbDelete)
.head 7 +  Else
.head 8 -  Call SalDisableWindow(pbAdd)
.head 8 -  Call SalDisableWindow(pbDelete)
.head 4 +  Window Variables
.head 5 -  Number: nCount
.head 5 -  Number: nNewUserId
.head 5 -  Number: nDelUserId
.head 5 -  Number: nRowNew
.head 5 -  String: sTmp
.head 5 -  Number: nBColor
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 5 +  On UM_Populate
.head 6 -  Call SalTblPopulate(hWndForm, hpSelUpd.hSql(),
"SELECT a.id, a.fio fio, b.secg, 
        decode(b.revoked, 1, '-', decode(b.approve,1,'','+')) 
   INTO :colGId, :colGFio, :colGSec, :colApprove 
   FROM groups_staff b, staff a 
  WHERE b.idg=:nCurrStaffGrp AND a.id=b.idu 
  ORDER BY a.id", TBL_FillAll)
.head 6 -  Call SalTblSetContext(hWndForm, 0)
.head 6 -  Call SalSendMsg(hWndForm, SAM_RowSetContext, 0, 0)
.head 5 +  On SAM_FetchRowDone
.head 6 -  Call DecodeAccess(colGSec, colGView, colGDebit, colGCredit)
.head 6 +  If EnhancedSecurity()
.head 7 -  ! Неподтвержденные на добавление
.head 7 +  If colApprove ='+'
.head 8 -  Call XSalTblSetRowBackColor(hWndForm, lParam, COLOR_LightPeriwinkle)
.head 7 -  ! Неподтвержденные на удаление
.head 7 +  If colApprove ='-'
.head 8 -  Call XSalTblSetRowBackColor(hWndForm, lParam, COLOR_Sky)
.head 6 -  ! Деллегированные
.head 6 +  If colApprove ='/'
.head 7 -  Call XSalTblSetRowBackColor(hWndForm, lParam, COLOR_LightGreen)
.head 5 +  On SAM_RowSetContext
.head 6 -  Set nCurrStaffId = colGId
.head 6 -  Set fDelGrpMem = SalTblAnyRows(hWndForm, ROW_Selected, 0)
.head 6 -  Call EnableButton()
.head 5 +  On SAM_SetFocus
.head 6 -  Call SalShowWindow(pbAdd)
.head 6 -  Call SalShowWindow(pbDelete)
.head 6 -  Set fDelGrpMem = SalTblAnyRows(hWndForm, ROW_Selected, 0)
.head 6 -  Call EnableButton()
.head 5 +  On SAM_KillFocus
.head 6 -  Call SalHideWindow(pbAdd)
.head 6 -  Call SalHideWindow(pbDelete)
.head 5 +  On SAM_DoubleClick
.head 6 +  If nP = 1
.head 7 -  Set nNewUserId = 0
.head 7 -  Set nNewUserId = SalModalDialog(acNewGroup, hWndForm, 3)
.head 7 +  If nNewUserId
.head 8 -  Set strSql =
"SELECT COUNT(*) INTO :nCount
   FROM groups_staff 
  WHERE idu=:nNewUserId AND idg=:nCurrStaffGrp"
.head 8 -  Call SqlPrepareAndExecute(hpSelUpd.hSql(), T(strSql))
.head 8 -  Call SqlFetchNext(hpSelUpd.hSql(), nFetchRes)
.head 8 -  Call SqlClose(hpSelUpd.hSql())
.head 8 +  If nCount = 0
.head 9 -  Set nRowNew = SalTblInsertRow(hWndForm, TBL_MaxRow)
.head 9 -  Call SalTblSetContext(hWndForm, nRowNew)
.head 9 -  Set strSql =
"INSERT INTO groups_staff(idu, idg, secg, approve, grantor)
 VALUES(:nNewUserId, :nCurrStaffGrp, 0, "
.head 9 +  If EnhancedSecurity()
.head 10 -  Set strSql = strSql || " 0, " || Str(GetUserIdX()) || ")"
.head 9 +  Else
.head 10 -  Set strSql = strSql || " 1, 1)"
.head 9 -  Call SqlPrepareAndExecute(hpSelUpd.hSql(), strSql)
.head 9 -  Call SqlClose(hpSelUpd.hSql())
.head 9 -  Set fSave = FALSE
.head 9 -  Call SaveInfoToLog(sFuncName || '. Пользователь #' || SalNumberToStrX( nNewUserId, 0 ) || ' добавлен в группу #' || SalNumberToStrX(nCurrStaffGrp, 0))
.head 9 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 5 +  On UM_DelRow
.head 6 -  ! Если пользователь не деллегированный
.head 6 +  If tblGroupMem.colApprove != '/'
.head 7 +  If nP = 1
.head 8 -  Set nDelUserId = nCurrStaffId
.head 8 +  If EnhancedSecurity()
.head 9 +  If tblGroupMem.colApprove = '+'
.head 10 -  If SqlPrepareAndExecute (hSql(),
"DELETE FROM groups_staff
  WHERE idu=:nCurrStaffId and idg=:nCurrStaffGrp")
.head 10 +  Else
.head 11 -  Call SaveInfoToLog(sFuncName || '. Неуспешная попытка удалить пользователя #'|| SalNumberToStrX( nCurrStaffId, 0 ) || ' из группы #' || SalNumberToStrX(nCurrStaffGrp, 0))
.head 11 -  Return -1
.head 9 +  Else
.head 10 -  If SqlPrepareAndExecute (hSql(),
"UPDATE groups_staff SET revoked=1, grantor=" || Str(GetUserIdX()) || "
  WHERE idu=:nCurrStaffId AND idg=:nCurrStaffGrp")
.head 10 +  Else
.head 11 -  Call SaveInfoToLog(sFuncName || '. Невозможно пометить на удаление пользователя #' || SalNumberToStrX(nCurrStaffId, 0) || ' из группы #' || SalNumberToStrX(nCurrStaffGrp, 0))
.head 11 -  Return -1
.head 9 -  Call SalTblDeleteSelected(hWndForm, hpSelUpd.hSql())
.head 9 -  Call SqlClose(hpSelUpd.hSql())
.head 9 -  Call SaveInfoToLog(sFuncName || '. Пользователь #' || SalNumberToStrX(nDelUserId, 0) || ' помечен на удаление из группы #' || SalNumberToStrX(nCurrStaffGrp, 0))
.head 8 +  Else
.head 9 +  If SqlPrepareAndExecute(hpSelUpd.hSql(), 
"DELETE FROM groups_staff 
  WHERE idu=:nCurrStaffId AND idg=:nCurrStaffGrp")
.head 10 -  Call SaveInfoToLog(sFuncName || '. Пользователь #' || SalNumberToStrX(nDelUserId, 0) || ' удален из группы #' || SalNumberToStrX(nCurrStaffGrp, 0))
.head 9 +  Else
.head 10 -  Call SaveInfoToLog(sFuncName || '. Неуспешная попытка удалить пользователя #' || SalNumberToStrX(nDelUserId, 0) || ' из группы #' || SalNumberToStrX(nCurrStaffGrp, 0))
.head 10 -  Return -1
.head 8 -  !
.head 8 -  Set fSave = FALSE
.head 8 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 6 +  Else
.head 7 -  ! Пользователю tblGroupMem.colGFio данная группа делегирована - удаление невозможно
.head 7 -  Call SalMessageBox( CurrentLangTable.GetAtomTitle('AccessControl.cTMsgGUser') || ' ' || tblGroupMem.colGFio ||' ' ||
     CurrentLangTable.GetAtomTitle('AccessControl.cTMsgGGr') || ' - ' ||
     CurrentLangTable.GetAtomTitle('AccessControl.cTMsgGDel') ,
     CurrentLangTable.GetAtomTitle('cTAt'),0)
.head 5 +  On SAM_ContextMenu
.head 6 -  Set fDelGrpMem = SalTblAnyRows(hWndForm, ROW_Selected, 0)
.head 6 -  Call SalTrackPopupMenu(hWndMain, "pmGrpMem", TPM_CursorX | TPM_CursorY , 0, 0)
.head 5 +  On WM_RbuttonDblClick
.head 6 -  Call SalSendMsg(hWndForm, UM_DelRow, 0, 0)
.head 5 +  On WM_LbuttonUp
.head 6 -  Set fDelGrpMem = SalTblAnyRows(hWndForm, ROW_Selected, 0)
.head 6 -  Call EnableButton()
.head 5 +  On SAM_RowHeaderClick
.head 6 -  ! Неподтвержденные на добавление
.head 6 +  If colApprove = '+'
.head 7 -  ! Set sTmp='Не подтвержден на добавление'
.head 7 -  Set sTmp = CurrentLangTable.GetAtomTitle('AccessControl.cTToolTip1')
.head 7 -  Set nBColor = COLOR_LightPeriwinkle
.head 6 -  ! Неподтвержденные на удаление
.head 6 +  Else If colApprove = '-'
.head 7 -  ! Set sTmp='Не подтвержден на удаление'
.head 7 -  Set sTmp = CurrentLangTable.GetAtomTitle('AccessControl.cTToolTip2')
.head 7 -  Set nBColor = COLOR_Sky
.head 6 -  ! Делегированные
.head 6 +  Else If colApprove = '/'
.head 7 -  ! Set sTmp='Делегирован'
.head 7 -  Set sTmp = CurrentLangTable.GetAtomTitle('AccessControl.cTToolTip3')
.head 7 -  Set nBColor = COLOR_LightGreen
.head 6 +  Else
.head 7 -  Set sTmp = ''
.head 7 -  Set nBColor = COLOR_White
.head 6 -  Call XSalTooltipSetColors(COLOR_Black, nBColor)
.head 6 -  Call XSalTooltipShow(tblGroupMem, sTmp)
.head 6 -  Call XSalTooltipSetColors(COLOR_Black, COLOR_LightGray)
.head 3 +  Child Table: tbl1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.067"
.head 6 -  Top:    0.031"
.head 6 -  Width:  4.5"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 4.219"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? No
.head 5 -  Font Name: Default
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  View: Table
.head 5 -  Allow Row Sizing? No
.head 5 -  Lines Per Row: Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: 5000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: id
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
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
.head 5 +  Column: name
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Ф.И.О.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  2.6"
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
.head 5 +  Column: branch
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
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
.head 5 -  : cQry
.head 6 -  Class: cGenQuery
.head 5 -  : cFlt
.head 6 -  Class: cGenFilter
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 5 +  On UM_Populate
.head 6 -  Set strSqlPopulateTbl1 = cQry.GetFullSQLString(cFlt)
.head 6 -  Call SalTblPopulate(hWndForm, TableMaster.hSql(), T(strSqlPopulateTbl1), TBL_FillAll)
.head 6 -  Call SelFirstRow(hWndForm)
.head 6 -  Call SalSendMsg(hWndForm, SAM_RowSetContext, 0, 0)
.head 5 +  On SAM_RowSetContext
.head 6 -  Set nCurrId = id
.head 6 +  If nHaveTOBO = 2
.head 7 +  If hWndMain.AccessControl.nViewMode = 1 	!! пользователи
.head 8 -  Set sCurrTobo = branch
.head 8 -  Set strSqlPopulateTbl2 = strEtalonTbl2 || " AND a.branch like '"||sCurrTobo||"%' "
.head 8 -  Call hWndMain.AccessControl.tbl2.cQry.Init(strSqlPopulateTbl2)
.head 6 -  ! Set text
.head 6 +  If hWndMain.AccessControl.nViewMode = 1		!! пользователи
.head 7 -  ! Счета пользователя
.head 7 -  Set sTitle = AppVersion || CurrentLangTable.GetAtomTitle('AccessControl.cTWndTitleAccUser') || ' ' || name
.head 6 +  Else If hWndMain.AccessControl.nViewMode = 2 	!! группы доступа
.head 7 -  ! Счета группы
.head 7 -  Set sTitle = AppVersion || CurrentLangTable.GetAtomTitle('AccessControl.cTWndTitleAccGr') || ' ' || name
.head 6 -  Call SalSetWindowText(hWndMain, sTitle)
.head 6 -  Call SalSendMsg(hWndMain.AccessControl.tbl2, UM_Populate, 0, 0)
.head 5 +  On UM_Filter		! Фильтрование таблицы
.head 6 +  If SetQueryFilter(cFlt)
.head 7 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 3 +  Child Table: tbl2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   4.6"
.head 6 -  Top:    0.036"
.head 6 -  Width:  6.7"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 4.219"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? No
.head 5 -  Font Name: Default
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Dark Red
.head 5 -  Background Color: Default
.head 5 -  View: Table
.head 5 -  Allow Row Sizing? No
.head 5 -  Lines Per Row: 1
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: 30000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: kv
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Валюта
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 3
.head 6 -  Data Type: String
.head 6 -  Justify: Center
.head 6 -  Width:  0.8"
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
.head 5 +  Column: nls
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Лицевой Счет
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 14
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.6"
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
.head 7 +  On SAM_Create
.head 8 +  If GetAccountStructure(nTmp,nTmp,nTmp,nTmp) ! Прижимать влево или вправо
.head 9 -  Call SalTblSetColumnFlags(hWndForm, COL_RightJustify, TRUE)
.head 5 +  Column: name
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  4.0"
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
.head 5 +  Column: colS
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Пр
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  0.356"
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
.head 5 +  Column: colD
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Дб
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  0.356"
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
.head 5 +  Column: colK
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Кр
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  0.356"
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
.head 5 +  Column: colSecg
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
.head 4 -  Functions
.head 4 +  Window Variables
.head 5 -  : cQry
.head 6 -  Class: cGenQuery
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren( hWndForm, UM_QueryLabelText, 0, 0)
.head 5 +  On UM_Populate
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Set strSqlPopulateTbl2 = cQry.GetFullSQLString(cFltAcc)
.head 6 +  If cFltAcc.GetFilterWhereClause(FALSE)
.head 7 -  ! с Фильтром
.head 7 -  Call SalSetWindowText(hWndMain, sTitle || ' (' || CurrentLangTable.GetAtomTitle('AccessControl.cTWithFilter') || ')')
.head 6 +  Else
.head 7 -  Call SalSetWindowText(hWndMain, sTitle)
.head 6 -  Call SalTblPopulate(hWndForm, TableDetail.hSql(), T(strSqlPopulateTbl2) || " ORDER BY a.nls, t.lcv", TBL_FillAll)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On SAM_FetchRowDone
.head 6 +  If hWndMain.AccessControl.nViewMode = 1
.head 7 -  Set colS = 0 OR colSecg & 4
.head 7 -  Set colD = 0 OR colSecg & 2
.head 7 -  Set colK = 0 OR colSecg & 1
.head 5 +  On SAM_CountRows
.head 6 -  Call SaveInfoToLog('SAM_CountRows')
.head 5 +  On SAM_SetFocus		! Showing filter button
.head 6 -  Call SalShowWindow(pbAuxFilter)
.head 5 +  On SAM_KillFocus	! Hiding  filter button
.head 6 -  Call SalHideWindow(pbAuxFilter)
.head 5 +  On UM_Filter		! Фильтрование таблицы
.head 6 +  If SetQueryFilter(cFltAcc)
.head 7 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 2 +  Functions
.head 3 +  Function: DecodeAccess
.head 4 -  Description: Decode Access Rights from nRights to nView,nDebit,nCredit
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Number: nAccessRights
.head 5 -  Receive Number: canView
.head 5 -  Receive Number: canDebit
.head 5 -  Receive Number: canCredit
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If (4 & nAccessRights) = 0
.head 6 -  Set canView = 0
.head 5 +  Else
.head 6 -  Set canView = 1
.head 5 +  If (2 & nAccessRights) = 0
.head 6 -  Set canDebit = 0
.head 5 +  Else
.head 6 -  Set canDebit = 1
.head 5 +  If (1 & nAccessRights) = 0
.head 6 -  Set canCredit = 0
.head 5 +  Else
.head 6 -  Set canCredit = 1
.head 3 +  Function: EncodeAccess
.head 4 -  Description: Encode Access Rights from  nView,nDebit,nCredit to nRights
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Receive Number: nAccessRights
.head 5 -  Number: canView
.head 5 -  Number: canDebit
.head 5 -  Number: canCredit
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Set nAccessRights = 0
.head 5 +  If canCredit = 1
.head 6 -  Set nAccessRights = nAccessRights + 1
.head 5 +  If canDebit = 1
.head 6 -  Set nAccessRights = nAccessRights + 2
.head 5 +  If canView = 1
.head 6 -  Set nAccessRights = nAccessRights + 4
.head 3 +  Function: IfClose
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 -  Actions
.head 3 +  Function: GetUserIdX
.head 4 -  Description: Расширеная функа GetUserId, но также корректно выдает № пользователя GateWay-я
.head 4 +  Returns
.head 5 -  Number:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sGateWay
.head 5 -  Number: nUserId
.head 5 -  Number: nRow
.head 5 -  Boolean: bGateWay
.head 4 +  Actions
.head 5 -  Call SalUseRegistry(FALSE, '')
.head 5 -  Call SalGetProfileString('Common Parameters', 'UseGateway', '', sGateWay, GetIniFileName())
.head 5 +  If SalStrToNumber(SalStrTrimX(sGateWay)) = 1
.head 6 -  Set bGateWay = TRUE
.head 5 +  Else
.head 6 -  Set bGateWay=FALSE
.head 5 -  !
.head 5 +  If bGateWay
.head 6 +  If SqlPrepareAndExecute(hSqlAux(),
   ' SELECT s.id INTO :nUserId
     FROM sec_logins l, staff s
     WHERE l.oralogin = USER AND trim(l.secid)=trim(s.tabn) ')
.head 7 -  If SqlFetchNext(hSqlAux(), nRow)
.head 5 +  Else
.head 6 -  Set nUserId=GetUserId()
.head 5 -  Return nUserId
.head 3 +  Function: InitStrSqlPopulate
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If hWndMain.AccessControl.nViewMode = 1 	!! пользователи
.head 6 -  Call hWndMain.AccessControl.tbl1.cFlt.Init('STAFF', 'staff')
.head 6 -  Set strEtalonTbl1 = 
"SELECT id, fio " || IifS(nHaveTOBO=2, ", branch",  "") || " 
 INTO :id, :name" || IifS(nHaveTOBO=2, ", :branch", "") || "
 FROM staff ORDER BY 1"
.head 6 -  Set strEtalonTbl2 =
"SELECT t.lcv, a.nls, a.nms, " || IifS(GetGlobalOptionEx('NBUBANK')=1, "sec_fitumask(a.sec,:nCurrId)", "sec.fit_umask(a.sec,:nCurrId)") || "
 INTO :kv, :nls, :name, :colSecg
 FROM accounts a, tabval t 
 WHERE a.kv=t.kv AND " || IifS(GetGlobalOptionEx('NBUBANK')=1, "sec_fitumask(a.sec,:nCurrId)", "sec.fit_umask(a.sec,:nCurrId)") || ">0"
.head 6 -  Call SalShowWindow(hWndMain.AccessControl.tbl2.colS)
.head 6 -  Call SalShowWindow(hWndMain.AccessControl.tbl2.colD)
.head 6 -  Call SalShowWindow(hWndMain.AccessControl.tbl2.colK)
.head 5 +  Else If hWndMain.AccessControl.nViewMode = 2  	!! группы доступа
.head 6 -  Call hWndMain.AccessControl.tbl1.cFlt.Init('GROUPS_ACC', 'groups_acc')
.head 6 -  Set strEtalonTbl1 = 
"SELECT id, name INTO :id, :name FROM groups_acc ORDER BY 1"
.head 6 -  Set strEtalonTbl2 = 
"SELECT t.lcv, a.nls, a.nms 
 INTO :kv, :nls, :name
 FROM accounts a, tabval t 
 WHERE a.kv=t.kv AND sec.fit_gmask(a.sec,:nCurrId)>0 "
.head 6 -  Call SalHideWindow(hWndMain.AccessControl.tbl2.colS)
.head 6 -  Call SalHideWindow(hWndMain.AccessControl.tbl2.colD)
.head 6 -  Call SalHideWindow(hWndMain.AccessControl.tbl2.colK)
.head 5 -  Set strSqlPopulateTbl1 = strEtalonTbl1
.head 5 -  Set strSqlPopulateTbl2 = strEtalonTbl2
.head 5 -  Call hWndMain.AccessControl.tbl1.cQry.Init(strEtalonTbl1)
.head 5 -  Call hWndMain.AccessControl.tbl2.cQry.Init(strEtalonTbl2)
.head 2 +  Window Parameters
.head 3 -  Number: nP	! Флаг редактируемости
0 - только просмотр доступа, пользователей, ответ. исполнителей, групп
1 - просмотр и редактирование доступа, просмотр пользователей, ответ. исполнителей, групп
2 - только просмотр доступа
3 - просмотр и редактирование доступа
.head 2 +  Window Variables
.head 3 -  : hpMaster	! Хэндл для населения основной таблицы
.head 4 -  Class: cABSConnect
.head 3 -  : hpSelUpd	! Хэндл для выборок и обновлений в таблицах деталей
.head 4 -  Class: cABSConnect
.head 3 -  ! Begin << Heterogenios block
.head 3 -  : TableMaster
.head 4 -  Class: cABSConnect
.head 3 -  : TableDetail
.head 4 -  Class: cABSConnect
.head 3 -  String: strSqlPopulateTbl1	! Мастер SQL выражение
.head 3 -  String: strSqlPopulateTbl2	! Детальное SQL выражение
.head 3 -  String: strEtalonTbl1		! Их эталоны
.head 3 -  String: strEtalonTbl2
.head 3 -  ! End <<
.head 3 -  ! Временные переменные
.head 3 -  Number: nTmp
.head 3 -  String: strTmp
.head 3 -  ! hWndMain.AccessControl.nViewMode =  0- по счету 1 - по пользователю 2 - по группе
.head 3 -  Number: nViewMode
.head 3 -  ! Формирование SQL выражений
.head 3 -  String: strSql
.head 3 -  ! Параметры поиска
.head 3 -  Number: nFindId
.head 3 -  String: strFindName
.head 3 -  ! Флаги доступности меню
.head 3 -  Boolean: fDelGrpAcc
.head 3 -  Boolean: fDelGrpStaff
.head 3 -  Boolean: fDelGrpMem
.head 3 -  ! Флаг доступности режимов просмотра пользователей, исполнителей, групп.
.head 3 -  Boolean: fEnableEx
.head 3 -  String: sFuncName
.head 3 -  ! Флаг редактирования
.head 3 -  Boolean: fEdited
.head 3 -  !
.head 3 -  Window Handle: hWndMain
.head 3 -  String: sTitle
.head 3 -  : cFltAcc
.head 4 -  Class: cGenFilter
.head 3 -  Boolean: fSave
.head 3 -  Number: nCurrAcc
.head 3 -  String: sCurrNls
.head 3 -  String: sCurrKv
.head 3 -  Number: nCurrAccGrp
.head 3 -  String: sCurrAccGrpName
.head 3 -  Number: nCurrStaffGrp
.head 3 -  String: sCurrStaffGrpName
.head 3 -  Number: nCurrStaffId
.head 3 -  Number: nCurrId
.head 3 -  String: sCurrTobo
.head 3 -  !
.head 3 -  Number: nWinFW
.head 3 -  Number: nWinFH
.head 3 -  Number: nWinX0
.head 3 -  Number: nWinY0
.head 3 -  Number: nWinWidth
.head 3 -  Number: nWinHeigh
.head 3 -  Number: nTblX0
.head 3 -  Number: nTblY0
.head 3 -  Number: nTblWidth
.head 3 -  Number: nTblHeigh
.head 3 -  Number: nXd
.head 3 -  Number: nYd
.head 3 -  Number: nXe
.head 3 -  Number: nYe
.head 3 -  Number: nXg
.head 3 -  Number: nYg
.head 3 -  Number: nXm
.head 3 -  Number: nYm
.head 3 -  Number: nXo
.head 3 -  Number: nYo
.head 3 -  Number: nXu
.head 3 -  Number: nYu
.head 3 -  Number: nXuw
.head 3 -  Number: nYuh
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  ! Просмотр и установка доступа к счетам
.head 4 -  Set sTitle = AppVersion || CurrentLangTable.GetAtomTitle('AccessControl.cTWndTitleAcc')
.head 4 -  Call SalSetWindowText(hWndForm, sTitle)
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  !
.head 4 -  Set hWndMain = hWndForm
.head 4 -  Set fEnableEx = (nP<2)
.head 4 -  ! Просмотр/редактирование всего
.head 4 +  If fEnableEx
.head 5 -  Call SalEnableWindow(pbSwitch)
.head 4 -  ! Просмотр/редактирование только доступа к счетам
(без переключения на пользователей и группы )
.head 4 +  Else
.head 5 -  Call SalDisableWindow(pbSwitch)
.head 4 +  If nP > 1
.head 5 -  Set nP = nP - 2
.head 4 +  If NOT nP
.head 5 -  ! Просмотр доступа к счетам
.head 5 -  Set sTitle = AppVersion || CurrentLangTable.GetAtomTitle('AccessControl.cTWndTitle')
.head 5 -  Call SalSetWindowText(hWndForm, sTitle)
.head 5 -  Call SalDisableWindow(pbSave)
.head 4 -  Call XSalTooltipSetUserDefault()
.head 4 -  Call XConnectGetParams(hpMaster)
.head 4 +  If hpMaster.Connect()
.head 5 -  Call hpSelUpd.Clone(hpMaster, TRUE)
.head 5 -  Call TableMaster.Clone(hpMaster, TRUE)
.head 5 -  Call TableDetail.Clone(hpMaster, TRUE)
.head 4 +  Else
.head 5 -  Call SalDestroyWindow(hWndForm)
.head 4 -  !
.head 4 -  Set fSave = TRUE
.head 4 -  Set sFuncName = 'DOSTUP'
.head 4 -  Call SalHideWindow(pbAdd)
.head 4 -  Call SalHideWindow(pbDelete)
.head 4 -  Call SalHideWindow(pbAuxFilter)
.head 4 -  Set hWndMain.AccessControl.nViewMode = 0
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalTblSetColumnFlags(hWndForm.AccessControl.tblGroupMem.colGView,   COL_Editable, nP=1)
.head 4 -  Call SalTblSetColumnFlags(hWndForm.AccessControl.tblGroupMem.colGDebit,  COL_Editable, nP=1)
.head 4 -  Call SalTblSetColumnFlags(hWndForm.AccessControl.tblGroupMem.colGCredit, COL_Editable, nP=1)
.head 4 -  Call SaveInfoToLog('Запуск функции: ' || IifS(nP>0,
  CurrentLangTable.GetAtomTitle('AccessControl.cTWndTitleAcc'),
  CurrentLangTable.GetAtomTitle('AccessControl.cTWndTitle')))
.head 4 +  If SetQueryFilter(hWndMain.AccessControl.cFltAcc)
.head 5 -  Set hWndForm.AccessControl.tblAcc.sMainSqlText = hWndForm.AccessControl.tblAcc.cQry.GetFullSQLString(hWndMain.AccessControl.cFltAcc)
.head 5 -  Call SalSendMsg(hWndForm.AccessControl.tblAcc, UM_Populate, 0, 0)
.head 4 +  Else
.head 5 -  Call SalDestroyWindow(hWndForm)
.head 3 +  On SAM_Destroy
.head 4 -  Call SqlRollback(hpSelUpd.hSql())
.head 4 -  Call SalSetFocus(SalParentWindow(hWndForm))
.head 4 -  ! Disactivation call function' role
.head 4 +  If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
.head 5 -  Call XRoleUnset(hpMaster.hSql(), ' ShowGroups(hWndMDI,' || SalNumberToStrX(nP,0) || ') ' )
.head 4 -  Call hpMaster.Disconnect()
.head 4 -  Call hpSelUpd.Disconnect()
.head 4 -  Call TableMaster.Disconnect()
.head 4 -  Call TableDetail.Disconnect()
.head 4 -  Call SaveInfoToLog('Выход из функции: ' || IifS(nP>0,
  CurrentLangTable.GetAtomTitle('AccessControl.cTWndTitleAcc'),
  CurrentLangTable.GetAtomTitle('AccessControl.cTWndTitle')))
.head 3 +  On SAM_Close
.head 4 -  Return IfClose()
.head 3 +  On WM_Size
.head 4 -  Call SalGetWindowSize( hWndForm, nWinFW, nWinFH )
.head 4 +  If nWinFW >= 12
.head 5 +  If nWinFH<6
.head 6 -  Call SalSetWindowSize( hWndForm, nWinFW, 6)
.head 4 +  Else
.head 5 +  If nWinFH<6
.head 6 -  Call SalSetWindowSize(hWndForm, 12, 6 )
.head 5 +  Else
.head 6 -  Call SalSetWindowSize(hWndForm, 12, nWinFH )
.head 4 -  Call GetClientRect( hWndForm, nWinX0, nWinY0, nWinWidth, nWinHeigh )
.head 4 -  !
.head 4 -  Call SalGetWindowLoc( hWndForm.AccessControl.pbGroupAcc, nXd, nYd )
.head 4 -  Call SalSetWindowLoc( hWndForm.AccessControl.pbGroupAcc,
         SalPixelsToFormUnits( hWndForm, nWinWidth, FALSE )-5.47, nYd)
.head 4 -  Call SalGetWindowLoc( hWndForm.AccessControl.dfGroupAcc, nXd, nYd )
.head 4 -  Call SalSetWindowLoc( hWndForm.AccessControl.dfGroupAcc,
         SalPixelsToFormUnits( hWndForm, nWinWidth, FALSE )-5.1, nYd)
.head 4 -  !
.head 4 -  Call SalGetWindowLoc( hWndForm.AccessControl.tblGroupAcc, nXg, nYg )
.head 4 -  Call SalSetWindowLoc( hWndForm.AccessControl.tblGroupAcc,
         SalPixelsToFormUnits( hWndForm, nWinWidth, FALSE )-5.5, nYg)
.head 4 -  Call SalGetWindowLoc( hWndForm.AccessControl.pbGroupStaff, nXd, nYd )
.head 4 -  Call SalSetWindowLoc( hWndForm.AccessControl.pbGroupStaff,
         SalPixelsToFormUnits( hWndForm, nWinWidth, FALSE )-5.47, nYd)
.head 4 -  Call SalGetWindowLoc( hWndForm.AccessControl.dfGroupStaff, nXd, nYd )
.head 4 -  Call SalSetWindowLoc( hWndForm.AccessControl.dfGroupStaff,
         SalPixelsToFormUnits( hWndForm, nWinWidth, FALSE )-5.1, nYd)
.head 4 -  Call SalGetWindowLoc( hWndForm.AccessControl.tblGroupStaff, nXg, nYg )
.head 4 -  Call SalSetWindowLoc( hWndForm.AccessControl.tblGroupStaff,
         SalPixelsToFormUnits( hWndForm, nWinWidth, FALSE )-5.5, nYg)
.head 4 -  !
.head 4 -  Call SalGetWindowLoc( hWndForm.AccessControl.dfGroupMem, nXd, nYd )
.head 4 -  Call SalSetWindowLoc( hWndForm.AccessControl.dfGroupMem,
         SalPixelsToFormUnits( hWndForm, nWinWidth, FALSE )-5.1, nYd)
.head 4 -  Call SalGetWindowLoc( hWndForm.AccessControl.tblGroupMem, nXg, nYg )
.head 4 -  Call SalSetWindowLoc( hWndForm.AccessControl.tblGroupMem,
         SalPixelsToFormUnits( hWndForm, nWinWidth, FALSE )-5.5, nYg)
.head 4 -  Call SalGetWindowSize( hWndForm.AccessControl.tblGroupMem, nXg, nYg )
.head 4 -  Call SalSetWindowSize( hWndForm.AccessControl.tblGroupMem, nXg,
         SalPixelsToFormUnits( hWndForm, nWinHeigh, TRUE )-3.8)
.head 4 -  !
.head 4 -  Call SalSetWindowSize( hWndForm.AccessControl.tblAcc,
         SalPixelsToFormUnits( hWndForm.AccessControl.tblAcc, nWinWidth, FALSE )-5.7,
         SalPixelsToFormUnits( hWndForm.AccessControl.tblAcc, nWinHeigh, TRUE  )-0.1)
.head 4 -  Call GetClientRect( hWndForm.AccessControl.tblAcc, nTblX0, nTblY0, nTblWidth, nTblHeigh )
.head 4 +  If SalPixelsToFormUnits( hWndForm.AccessControl.tblAcc, nTblWidth, FALSE )>7
.head 5 -  Call SalTblSetColumnWidth( hWndForm.AccessControl.tblAcc.colNms,
	SalPixelsToFormUnits( hWndForm.AccessControl.tblAcc, nTblWidth, FALSE )-2.8 )
.head 4 -  !
.head 4 -  Call SalSetWindowSize( hWndForm.AccessControl.tbl1, 4.5,
         SalPixelsToFormUnits( hWndForm.AccessControl.tbl1, nWinHeigh, TRUE  )-0.1)
.head 4 -  Call SalSetWindowSize( hWndForm.AccessControl.tbl2,
         SalPixelsToFormUnits( hWndForm.AccessControl.tbl2, nWinWidth, FALSE )-4.7,
         SalPixelsToFormUnits( hWndForm.AccessControl.tbl2, nWinHeigh, TRUE  )-0.1)
.head 4 -  Call SalInvalidateWindow(hWndForm)
.head 1 +  Dialog Box: acNewGroup
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Новая группа
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   2.2"
.head 4 -  Top:    1.542"
.head 4 -  Width:  6.933"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 3.143"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Диалоговое окно для установки новй группы
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
.head 3 +  Child Table: tblGroups
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.0"
.head 6 -  Top:    0.0"
.head 6 -  Width:  6.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 2.833"
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
.head 5 -  Maximum Rows in Memory: 2000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colId
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
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
.head 5 +  Column: colGName
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Название группы
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  5.0"
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
.head 6 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 6 -  Call SalTblSetTableFlags(hWndForm, TBL_Flag_SelectableCols, TRUE)
.head 6 -  Set nOrderBy = 1
.head 5 +  On SAM_DoubleClick
.head 6 -  Call SalEndDialog(acNewGroup, colId)
.head 5 +  On SAM_ColumnSelectClick
.head 6 -  Set hColumn = SalNumberToWindowHandle(wParam)
.head 6 -  Set nOrderBy = NOT nOrderBy
.head 6 -  Call SalTblSortRows(hWndForm, SalTblQueryColumnID(hColumn), nOrderBy)
.head 6 -  Call SalTblSetColumnFlags(hColumn, COL_Selected, FALSE)
.head 6 -  Call SalWaitCursor(FALSE)
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Number: nPar	! 1-гр.счетов(groups_acc)
		! 2-гр.польз.(groups)
		! 3-пользователи(staff)
		! 4-исполнители(staff)
.head 2 +  Window Variables
.head 3 -  : hpMaster
.head 4 -  Class: cABSConnect
.head 3 -  String: strSql
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 -  Call SetWindowFont(hWndForm)
.head 4 -  Call XConnectGetParams(hpMaster)
.head 4 +  If NOT hpMaster.Connect()
.head 5 -  Call SalDestroyWindow(hWndForm)
.head 4 +  If nPar = 1
.head 5 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('acNewGroup.cTWndTitle'))
.head 5 -  Set strSql =
"SELECT id, name 
   INTO :hWndForm.acNewGroup.tblGroups.colId, 
        :hWndForm.acNewGroup.tblGroups.colGName
   FROM v_groups_acc ORDER BY name"
.head 4 +  Else If nPar = 2
.head 5 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('acNewGroup.cTWndTitle'))
.head 5 -  Set strSql =
"SELECT id, name 
   INTO :hWndForm.acNewGroup.tblGroups.colId, 
        :hWndForm.acNewGroup.tblGroups.colGName
   FROM groups ORDER BY name"
.head 4 +  Else If nPar = 3
.head 5 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('acNewUser.cTWndTitle'))
.head 5 -  Call SalTblSetColumnTitle(tblGroups, CurrentLangTable.GetAtomTitle('acNewUser.tblStaff.colFio'))
.head 5 -  Set strSql = 
"SELECT id, fio 
   INTO :hWndForm.acNewGroup.tblGroups.colId, 
        :hWndForm.acNewGroup.tblGroups.colGName 
   FROM staff ORDER BY fio"
.head 4 +  Else If nPar = 4
.head 5 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('acNewUser.cTWndTitle'))
.head 5 -  Call SalTblSetColumnTitle(tblGroups, CurrentLangTable.GetAtomTitle('acNewUser.tblStaff.colFio'))
.head 5 -  Set strSql = 
"SELECT id, fio 
   INTO :hWndForm.acNewGroup.tblGroups.colId, 
        :hWndForm.acNewGroup.tblGroups.colGName 
   FROM staff WHERE type=1 ORDER BY fio"
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call SalTblPopulate(hWndForm.acNewGroup.tblGroups, hpMaster.hSql(), T(strSql), TBL_FillAll)
.head 3 +  On SAM_Destroy
.head 4 -  Call hpMaster.Disconnect()
.head 1 +  Form Window: frmSetAccAccess
.head 2 -  Class: cGenericTableFrm
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title:
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Class Default
.head 2 -  Visible? Class Default
.head 2 -  Display Settings
.head 3 -  Display Style? Class Default
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
.head 4 -  Width:  10.883"
.head 4 -  Width Editable? Class Default
.head 4 -  Height: 5.345"
.head 4 -  Height Editable? Class Default
.head 3 -  Form Size
.head 4 -  Width:  Class Default
.head 4 -  Height: Class Default
.head 4 -  Number of Pages: Class Default
.head 3 -  Font Name: Class Default
.head 3 -  Font Size: Class Default
.head 3 -  Font Enhancement: Class Default
.head 3 -  Text Color: Class Default
.head 3 -  Background Color: Class Default
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
.head 5 -  Class Child Ref Key: 14
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableFrm
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
.head 5 -  Class Child Ref Key: 15
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableFrm
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
.head 5 -  Class Child Ref Key: 16
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableFrm
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
.head 5 -  Class Child Ref Key: 17
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableFrm
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
.head 5 -  Resource Id: 41737
.head 5 -  Class Child Ref Key: 18
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableFrm
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
.head 5 -  Class Child Ref Key: 19
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableFrm
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
.head 5 -  Class Child Ref Key: 20
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableFrm
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
.head 5 -  Class Child Ref Key: 21
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableFrm
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
.head 5 -  Class Child Ref Key: 22
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableFrm
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
.head 5 -  Resource Id: 41738
.head 5 -  Class Child Ref Key: 23
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableFrm
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
.head 5 -  Class Child Ref Key: 24
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableFrm
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
.head 5 -  Resource Id: 41739
.head 5 -  Class Child Ref Key: 25
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableFrm
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
.head 3 +  Custom Control: splMain
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cXSalHSplitter
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  DLL Name:
.head 5 -  MS Windows Class Name:
.head 5 -  Style:  Class Default
.head 5 -  ExStyle:  Class Default
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Default
.head 6 -  Top:    Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Border? Class Default
.head 5 -  Etched Border? Class Default
.head 5 -  Hollow? Class Default
.head 5 -  Vertical Scroll? Class Default
.head 5 -  Horizontal Scroll? Class Default
.head 5 -  Tab Stop? Class Default
.head 5 -  Tile To Parent? Yes
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  DLL Settings
.head 4 -  Message Actions
.head 3 +  Child Table: tblMain
.head 4 -  Class Child Ref Key: 1
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenericTableFrm
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  9.933"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 2.0"
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
.head 5 -  Maximum Rows in Memory: 10000
.head 5 -  Discardable? Class Default
.head 4 +  Contents
.head 5 +  Column: colId
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: № группы
.head 6 -  Visible? Class Default
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  2.0"
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
.head 5 +  Column: colName
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
.head 6 -  Visible? Class Default
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Class Default
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
.head 4 -  Window Variables
.head 4 +  Message Actions
.head 5 +  On UM_Populate
.head 6 -  Call SalSendClassMessage(UM_Populate, 0, 0)
.head 6 -  Call SalTblSetContext(hWndForm, 0)
.head 6 -  Call SalTblSetFocusRow(hWndForm, 0)
.head 5 +  On SAM_RowSetContext
.head 6 -  Call SalSendMsg(hCurr, SAM_User, 0, 0)
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Number: nMode	! 4 - установка доступа гр.счетов к гр. польз.
		  5 - установка доступа гр.польз. к гр. счетов
		  6 - установка доступа счетов к гр. счетов
.head 3 -  Number: nPar
.head 3 -  String: sPar1
.head 3 -  String: sPar2
.head 2 +  Window Variables
.head 3 -  Window Handle: hCurr
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  ! Установка доступа
.head 4 -  Call SalSetWindowText(hWndForm,  CurrentLangTable.GetAtomTitle('frmSetAccAccess.cTWndTitle'))
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  ! Наименование группы пользователей/счетов
.head 4 +  If nMode = 4
.head 5 -  ! Пользователи - голубые
.head 5 -  Call SalColorSet(tblMain, COLOR_IndexWindow, SalColorFromRGB(230,255,255))
.head 5 -  Call SalTblSetColumnTitle(hWndForm.frmSetAccAccess.tblMain.colName,
     CurrentLangTable.GetAtomTitle('frmSetAccAccess.cTUserGrpName'))
.head 4 +  Else
.head 5 -  ! Счета - зелененькие
.head 5 -  Call SalColorSet(tblMain, COLOR_IndexWindow, SalColorFromRGB(230,255,230))
.head 5 -  Call SalTblSetColumnTitle(hWndForm.frmSetAccAccess.tblMain.colName,
     CurrentLangTable.GetAtomTitle('frmSetAccAccess.cTAccGrpName'))
.head 4 -  Call splMain.setBarPosition(400)
.head 4 -  Call splMain.setTopFrame(tblMain)
.head 4 -  Call splMain.setBottomFrame(SalCreateWindowEx(frmSetAccess, hWndForm, 0,0,0,0, CREATE_AsChild, hWndForm, nMode))
.head 4 -  Call SalTblSetTableFlags(tblMain, TBL_Flag_SingleSelection, TRUE)
.head 4 -  Set hWndForm.frmSetAccAccess.strFilterTblName = IifS(nMode=4, "groups", "groups_acc")
.head 4 -  Set hWndForm.frmSetAccAccess.nFlags = GT_ReadOnly
.head 4 -  Set hWndForm.frmSetAccAccess.strSqlPopulate =
"SELECT id, name
   INTO :hWndForm.tblMain.colId,
        :hWndForm.tblMain.colName
   FROM " || IifS(nMode=4, "groups", "groups_acc") || "
  ORDER BY id"
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 1 +  Form Window: frmSetAccess
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title:
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
.head 4 -  Width:  12.5"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 4.774"
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
.head 3 -  Background Text: Выбранные группы
.head 4 -  Resource Id: 41740
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.1"
.head 5 -  Width:  4.0"
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
.head 3 +  Data Field: bgGrp
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
.head 3 +  Child Table: tblGrp
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.1"
.head 6 -  Top:    0.4"
.head 6 -  Width:  5.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 2.964"
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
.head 5 -  Maximum Rows in Memory: 30000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colId
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: № группы
.head 6 -  Visible? Class Default
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.0"
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
.head 5 +  Column: colNls
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Номер счета
.head 6 -  Visible? Class Default
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  1.6"
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
.head 5 +  Column: colKv
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Вал.
.head 6 -  Visible? Class Default
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  0.6"
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
.head 5 +  Column: colName
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
.head 6 -  Visible? Class Default
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
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
.head 5 +  Column: colDazs
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Date/Time
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
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
.head 5 -  Number: nOrderBy
.head 5 -  Window Handle: hColumn
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Присваиваем значения многоязыковым объектам
.head 6 -  Call SalSendMsgToChildren( hWndForm, UM_QueryLabelText, 0, 0 )
.head 6 -  Call SalTblSetTableFlags( hWndItem, TBL_Flag_SelectableCols, TRUE )
.head 6 -  Set nOrderBy = 1
.head 5 +  On UM_Populate
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  ! If nMode = 6
.head 6 -  Call cQGrp.Init(strSqlPopulateGrp)
.head 6 -  Set strSqlPopulate = cQGrp.GetFullSQLString(cFGrp)
.head 6 -  Call SalTblPopulate(hWndForm, hSql(), strSqlPopulate, TBL_FillAll)
.head 6 -  Call VisTblAutoSizeColumn(hWndForm, hWndNULL)
.head 6 -  Call SalTblSetContext(hWndForm, 0)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On SAM_FetchRowDone
.head 6 +  If NOT SalIsNull(colDazs)
.head 7 -  Call SetTblRowColor(hWndForm, COLOR_Periwinkle)
.head 5 +  On SAM_ColumnSelectClick
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Set hColumn = SalNumberToWindowHandle(wParam)
.head 6 -  Set nOrderBy = Not nOrderBy
.head 6 -  Call SalTblSortRows(hWndForm, SalTblQueryColumnID(hColumn), nOrderBy)
.head 6 -  Call SalTblSetColumnFlags(hColumn, COL_Selected, FALSE)
.head 6 -  Call SalWaitCursor(FALSE)
.head 3 -  Background Text: Доступные группы
.head 4 -  Resource Id: 41741
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   6.733"
.head 5 -  Top:    0.1"
.head 5 -  Width:  4.0"
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
.head 3 +  Data Field: bgGrpAll
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
.head 3 +  Data Field: dfGrpAll
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
.head 6 -  Left:   6.733"
.head 6 -  Top:    0.1"
.head 6 -  Width:  4.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? No
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Set dfGrpAll = 'Доступные группы'
.head 6 +  If nMode = 4
.head 7 -  Set dfGrpAll = CurrentLangTable.GetAtomTitle('frmSetAccess.cTAccGrpAll')
.head 6 +  Else If nMode = 5
.head 7 -  Set dfGrpAll = CurrentLangTable.GetAtomTitle('frmSetAccess.cTUserGrpAll')
.head 6 +  Else If nMode = 6
.head 7 -  Set dfGrpAll = CurrentLangTable.GetAtomTitle('frmSetAccess.cTAccAll')
.head 6 -  Call SalShowWindow(dfGrpAll)
.head 6 -  Call SalHideWindowAndLabel(bgGrpAll)
.head 3 +  Child Table: tblGrpAll
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   6.667"
.head 6 -  Top:    0.4"
.head 6 -  Width:  5.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 2.821"
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
.head 5 -  Maximum Rows in Memory: 30000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colId
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: № группы
.head 6 -  Visible? Class Default
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.0"
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
.head 5 +  Column: colNls
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Номер счета
.head 6 -  Visible? Class Default
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  1.6"
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
.head 5 +  Column: colKv
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Вал.
.head 6 -  Visible? Class Default
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  0.6"
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
.head 5 +  Column: colName
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
.head 6 -  Visible? Class Default
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
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
.head 5 -  Number: nOrderBy
.head 5 -  Window Handle: hColumn
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  ! Присваиваем значения многоязыковым объектам
.head 6 -  Call SalSendMsgToChildren( hWndForm, UM_QueryLabelText, 0, 0 )
.head 6 -  Call SalTblSetTableFlags( hWndItem, TBL_Flag_SelectableCols, TRUE )
.head 6 -  Set nOrderBy = 1
.head 5 +  On UM_Populate
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call cQGrpAll.Init(strSqlPopulateGrpAll)
.head 6 -  Set strSqlPopulate = cQGrpAll.GetFullSQLString(cFGrpAll)
.head 6 -  Call SalTblPopulate(hWndForm, hSql(), strSqlPopulate, TBL_FillAll)
.head 6 -  Call VisTblAutoSizeColumn(hWndForm, hWndNULL)
.head 6 -  Call SalTblSetContext(hWndForm, 0)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On SAM_ColumnSelectClick
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Set hColumn = SalNumberToWindowHandle(wParam)
.head 6 -  Set nOrderBy = Not nOrderBy
.head 6 -  Call SalTblSortRows(hWndForm, SalTblQueryColumnID(hColumn), nOrderBy)
.head 6 -  Call SalTblSetColumnFlags(hColumn, COL_Selected, FALSE)
.head 6 -  Call SalWaitCursor(FALSE)
.head 3 +  Pushbutton: pbAdd
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.75"
.head 5 -  Top:    1.226"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\UNDO.BMP
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If nMode = 4 Or nMode = 5
.head 7 +  If setGrp()
.head 8 -  Set bPopulate = TRUE
.head 6 +  Else If nMode = 6
.head 7 +  If setAcc()
.head 8 -  Set bPopulate = TRUE
.head 6 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 3 +  Pushbutton: pbDrop
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.75"
.head 5 -  Top:    1.679"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\UNDO1.BMP
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If nMode = 4 Or nMode = 5
.head 7 +  If revGrp()
.head 8 -  Set bPopulate = TRUE
.head 6 +  Else If nMode = 6
.head 7 +  If revAcc()
.head 8 -  Set bPopulate = TRUE
.head 6 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 3 +  Pushbutton: pbFilterGrp
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbFilter
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.583"
.head 5 -  Top:    0.048"
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
.head 6 +  If SetQueryFilter(cFGrp)
.head 7 -  Set sTmp = cFGrp.GetFilterWhereClause(FALSE)
.head 7 +  If sTmp
.head 8 -  Call SalSetWindowLabelText(bgGrp, sStrGrp || ' (фильтр)')
.head 7 +  Else
.head 8 -  Call SalSetWindowLabelText(bgGrp, sStrGrp)
.head 7 -  Call SalPostMsg(tblGrp, UM_Populate, 0, 0)
.head 3 +  Pushbutton: pbFilterGrpAll
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbFilter
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   11.133"
.head 5 -  Top:    0.048"
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
.head 6 +  If SetQueryFilter(cFGrpAll)
.head 7 -  Set sTmp = cFGrpAll.GetFilterWhereClause(FALSE)
.head 7 +  If sTmp
.head 8 -  Call SalSetWindowLabelText(bgGrpAll, sStrGrpAll || ' (фильтр)')
.head 8 -  Set dfGrpAll = sStrGrpAll || ' (фильтр)'
.head 7 +  Else
.head 8 -  Call SalSetWindowLabelText(bgGrpAll, sStrGrpAll)
.head 8 -  Set dfGrpAll = sStrGrpAll
.head 7 +  If nMode = 6 and not sTmp
.head 8 -  Call SalMessageBox('Задайте фильтр для просмотра!', 'Внимание!', MB_Ok)
.head 8 -  Return FALSE
.head 7 -  Call SalPostMsg(tblGrpAll, UM_Populate, 0, 0)
.head 2 +  Functions
.head 3 +  Function: setGrp
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Set nRow = TBL_MinRow
.head 5 +  While SalTblFindNextRow(tblGrpAll, nRow, ROW_Selected, 0)
.head 6 -  Call SalTblSetContext(tblGrpAll, nRow)
.head 6 -  Set nUserGrp  = IifN(nMode=4, nId,   tblGrpAll.colId)
.head 6 -  Set sUserName = IifS(nMode=4, sName, tblGrpAll.colName)
.head 6 -  Set nAccGrp   = IifN(nMode=4, tblGrpAll.colId,   nId)
.head 6 -  Set sAccName  = IifS(nMode=4, tblGrpAll.colName, sName)
.head 6 +  If SqlPLSQLCommand(hSql(), "sec.givUAgrp(nUserGrp, nAccGrp)")
.head 7 -  Call SqlCommitEx(hSql(), "DOSTUP. Разрешен доступ группы пользователей " || Str(nUserGrp) || " <" || sUserName ||
"> к группе счетов " || Str(nAccGrp) || " <" || sAccName || ">")
.head 6 +  Else
.head 7 -  Call SqlRollback(hSql())
.head 7 -  Call SaveInfoToLog("DOSTUP. Ошибка выполнения процедуры выдачи прав доступа группы пользователей " || Str(nUserGrp) || " <" || sUserName ||
"> к группе счетов " || Str(nAccGrp) || " <" || sAccName || ">")
.head 3 +  Function: setAcc
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Boolean: bOk
.head 5 -  Number: nAcc
.head 5 -  String: sNls
.head 4 +  Actions
.head 5 -  Set bOk = TRUE
.head 5 -  Set nRow = TBL_MinRow
.head 5 +  While SalTblFindNextRow(tblGrpAll, nRow, ROW_Selected, 0)
.head 6 -  Call SalTblSetContext(tblGrpAll, nRow)
.head 6 -  Set nAccGrp  = nId
.head 6 -  Set sAccName = sName
.head 6 -  Set nAcc = tblGrpAll.colId
.head 6 -  Set sNls = tblGrpAll.colNls || '(' || Str(tblGrpAll.colKv) || ')'
.head 6 +  If NOT SqlPLSQLCommand(hSql(), "sec.addAgrp(nAcc, nAccGrp)")
.head 7 -  Set bOk = FALSE
.head 7 -  Call SqlRollbackEx(hSql(), "DOSTUP. Ошибка выполнения процедуры добавления счета " || sNls || " в группу счетов " || 
  Str(nAccGrp) || " <" || sAccName || ">")
.head 7 -  Break
.head 6 -  Call SqlCommitEx(hSql(), "DOSTUP. Счет " || sNls || " добавлен в группу счетов " || 
  Str(nAccGrp) || " <" || sAccName || ">")
.head 5 +  If NOT bOk
.head 6 -  Return FALSE
.head 5 -  Return TRUE
.head 3 +  Function: revGrp
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Set nRow = TBL_MinRow
.head 5 +  While SalTblFindNextRow(tblGrp, nRow, ROW_Selected, 0)
.head 6 -  Call SalTblSetContext(tblGrp, nRow)
.head 6 -  Set nUserGrp  = IifN(nMode=4, nId,   tblGrp.colId)
.head 6 -  Set sUserName = IifS(nMode=4, sName, tblGrp.colName)
.head 6 -  Set nAccGrp   = IifN(nMode=4, tblGrp.colId,   nId)
.head 6 -  Set sAccName  = IifS(nMode=4, tblGrp.colName, sName)
.head 6 +  If SqlPLSQLCommand(hSql(), "sec.revUAgrp(nUserGrp, nAccGrp)")
.head 7 -  Call SqlCommitEx(hSql(), "DOSTUP. Запрещен доступ группы пользователей " || Str(nUserGrp) || " <" || sUserName ||
"> к группе счетов " || Str(nAccGrp) || " <" || sAccName || ">")
.head 6 +  Else
.head 7 -  Call SqlRollback(hSql())
.head 7 -  Call SaveInfoToLog("DOSTUP. Ошибка выполнения процедуры выдачи прав доступа группы пользователей " || Str(nUserGrp) || " <" || sUserName ||
"> к группе счетов " || Str(nAccGrp) || " <" || sAccName || ">")
.head 3 +  Function: revAcc
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Boolean: bOk
.head 5 -  Number: nAcc
.head 5 -  String: sNls
.head 4 +  Actions
.head 5 -  Set bOk = TRUE
.head 5 -  Set nRow = TBL_MinRow
.head 5 +  While SalTblFindNextRow(tblGrp, nRow, ROW_Selected, 0)
.head 6 -  Call SalTblSetContext(tblGrp, nRow)
.head 6 -  Set nAccGrp  = nId
.head 6 -  Set sAccName = sName
.head 6 -  Set nAcc = tblGrp.colId
.head 6 -  Set sNls = tblGrp.colNls || '(' || Str(tblGrp.colKv) || ')'
.head 6 +  If NOT SqlPLSQLCommand(hSql(), "sec.delAgrp(nAcc, nAccGrp)")
.head 7 -  Set bOk = FALSE
.head 7 -  Call SqlRollbackEx(hSql(), "DOSTUP. Ошибка выполнения процедуры исключения счета " || sNls || " из группы счетов " || 
  Str(nAccGrp) || " <" || sAccName || ">")
.head 7 -  Break
.head 6 -  Call SqlCommitEx(hSql(), "DOSTUP. Счет " || sNls || " исключен из группы счетов " || 
  Str(nAccGrp) || " <" || sAccName || ">")
.head 5 +  If NOT bOk
.head 6 -  Return FALSE
.head 5 -  Return TRUE
.head 2 +  Window Parameters
.head 3 -  Window Handle: hWndParent
.head 3 -  Number: nMode
.head 2 +  Window Variables
.head 3 -  Number: nId
.head 3 -  String: sName
.head 3 -  String: strSqlPopulate
.head 3 -  String: strSqlPopulateGrp
.head 3 -  String: strSqlPopulateGrpAll
.head 3 -  ! String: strSqlPopulateAcc
.head 3 -  ! String: strSqlPopulateAccAll
.head 3 -  Number: nRow
.head 3 -  Number: nUserGrp
.head 3 -  String: sUserName
.head 3 -  Number: nAccGrp
.head 3 -  String: sAccName
.head 3 -  : cQGrp
.head 4 -  Class: cGenQuery
.head 3 -  : cFGrp
.head 4 -  Class: cGenFilter
.head 3 -  : cQGrpAll
.head 4 -  Class: cGenQuery
.head 3 -  : cFGrpAll
.head 4 -  Class: cGenFilter
.head 3 -  Boolean: bPopulate
.head 3 -  String: sStrGrp
.head 3 -  String: sStrGrpAll
.head 3 -  String: sTmp
.head 3 -  !
.head 3 -  Number: nWW
.head 3 -  Number: nWH
.head 3 -  Number: nWinX0
.head 3 -  Number: nWinY0
.head 3 -  Number: nWinWidth
.head 3 -  Number: nWinHeight
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Set hWndParent.frmSetAccAccess.hCurr = hWndForm
.head 4 -  ! Set bPopulate = TRUE
.head 4 -  Set bPopulate = TRUE
.head 4 +  If nMode = 4
.head 5 -  ! Счета - зелененькие
.head 5 -  Call SalColorSet(tblGrp,    COLOR_IndexWindow, SalColorFromRGB(230,255,230))
.head 5 -  Call SalColorSet(tblGrpAll, COLOR_IndexWindow, SalColorFromRGB(230,255,230))
.head 5 -  Call cFGrp.Init('groups_acc', 'g')
.head 5 -  Call cFGrpAll.Init('groups_acc', 'g')
.head 5 -  ! Выбранные группы счетов
.head 5 -  Set sStrGrp = CurrentLangTable.GetAtomTitle('frmSetAccess.cTAccGrp')
.head 5 -  ! Доступные группы счетов
.head 5 -  Set sStrGrpAll = CurrentLangTable.GetAtomTitle('frmSetAccess.cTAccGrpAll')
.head 5 -  Call SalShowWindow(tblGrp.colId)
.head 5 -  Call SalHideWindow(tblGrp.colNls)
.head 5 -  Call SalHideWindow(tblGrp.colKv)
.head 5 -  Call SalShowWindow(tblGrpAll.colId)
.head 5 -  Call SalHideWindow(tblGrpAll.colNls)
.head 5 -  Call SalHideWindow(tblGrpAll.colKv)
.head 5 -  Set strSqlPopulateGrp =
"SELECT g.id, g.name
   INTO :hWndForm.tblGrp.colId,
        :hWndForm.tblGrp.colName
   FROM groups_acc g, groups_staff_acc s
  WHERE g.id=s.ida AND s.idg=:nId
  ORDER BY id"
.head 5 -  Set strSqlPopulateGrpAll =
"SELECT g.id, g.name
   INTO :hWndForm.tblGrpAll.colId,
        :hWndForm.tblGrpAll.colName
   FROM v_groups_acc g
  WHERE g.id not in (SELECT s.ida
                       FROM groups_staff_acc s
                      WHERE s.idg=:nId)
  ORDER BY id"
.head 4 +  Else If nMode = 5
.head 5 -  ! Пользователи - голубые
.head 5 -  Call SalColorSet(tblGrp,    COLOR_IndexWindow, SalColorFromRGB(230,255,255))
.head 5 -  Call SalColorSet(tblGrpAll, COLOR_IndexWindow, SalColorFromRGB(230,255,255))
.head 5 -  Call cFGrp.Init('groups', 'g')
.head 5 -  Call cFGrpAll.Init('groups', 'g')
.head 5 -  ! Выбранные группы пользователей
.head 5 -  Set sStrGrp = CurrentLangTable.GetAtomTitle('frmSetAccess.cTUserGrp')
.head 5 -  ! Доступные группы пользователей
.head 5 -  Set sStrGrpAll = CurrentLangTable.GetAtomTitle('frmSetAccess.cTUserGrpAll')
.head 5 -  Call SalShowWindow(tblGrp.colId)
.head 5 -  Call SalHideWindow(tblGrp.colNls)
.head 5 -  Call SalHideWindow(tblGrp.colKv)
.head 5 -  Call SalShowWindow(tblGrpAll.colId)
.head 5 -  Call SalHideWindow(tblGrpAll.colNls)
.head 5 -  Call SalHideWindow(tblGrpAll.colKv)
.head 5 -  Set strSqlPopulateGrp =
"SELECT g.id, g.name
   INTO :hWndForm.tblGrp.colId,
        :hWndForm.tblGrp.colName
   FROM groups g, groups_staff_acc s
  WHERE g.id=s.idg AND s.ida=:nId
  ORDER BY id"
.head 5 -  Set strSqlPopulateGrpAll =
"SELECT g.id, g.name
   INTO :hWndForm.tblGrpAll.colId,
        :hWndForm.tblGrpAll.colName
   FROM groups g
  WHERE g.id not in (SELECT s.idg
                       FROM groups_staff_acc s
                      WHERE s.ida=:nId)
  ORDER BY id"
.head 4 +  Else If nMode = 6
.head 5 -  ! Счета - белые
.head 5 -  Set bPopulate = FALSE
.head 5 -  Call cFGrp.Init('accounts', 'a')
.head 5 -  Call cFGrpAll.Init('accounts', 'a')
.head 5 -  ! Счета группы
.head 5 -  Set sStrGrp = CurrentLangTable.GetAtomTitle('frmSetAccess.cTAcc')
.head 5 -  ! Счета, не входящие в группу
.head 5 -  Set sStrGrpAll = CurrentLangTable.GetAtomTitle('frmSetAccess.cTAccAll')
.head 5 -  Call SalHideWindow(tblGrp.colId)
.head 5 -  Call SalShowWindow(tblGrp.colNls)
.head 5 -  Call SalShowWindow(tblGrp.colKv)
.head 5 -  Call SalHideWindow(tblGrpAll.colId)
.head 5 -  Call SalShowWindow(tblGrpAll.colNls)
.head 5 -  Call SalShowWindow(tblGrpAll.colKv)
.head 5 -  Set strSqlPopulateGrp =
"SELECT a.acc, a.nls, a.kv, a.nms, a.dazs
   INTO :hWndForm.tblGrp.colId, :hWndForm.tblGrp.colNls,
        :hWndForm.tblGrp.colKv, :hWndForm.tblGrp.colName, :hWndForm.tblGrp.colDazs
   FROM accounts a
  WHERE sec.fit_gmask(a.sec,:nId)>0
  ORDER BY a.nls, a.kv"
.head 5 -  Set strSqlPopulateGrpAll =
"SELECT a.acc, a.nls, a.kv, a.nms
   INTO :hWndForm.tblGrpAll.colId, :hWndForm.tblGrpAll.colNls,
        :hWndForm.tblGrpAll.colKv, :hWndForm.tblGrpAll.colName
   FROM accounts a
  WHERE sec.fit_gmask(a.sec,:nId)=0
  ORDER BY a.nls, a.kv"
.head 4 -  Call SalSetWindowLabelText(bgGrp, sStrGrp)
.head 4 -  Call SalSetWindowLabelText(bgGrpAll, sStrGrpAll)
.head 3 +  On SAM_User
.head 4 -  Set nId   = hWndParent.frmSetAccAccess.tblMain.colId
.head 4 -  Set sName = hWndParent.frmSetAccAccess.tblMain.colName
.head 4 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 3 +  On UM_Populate
.head 4 +  If nMode = 6
.head 5 -  Call SalTblReset(tblGrp)
.head 5 -  Call SalTblReset(tblGrpAll)
.head 4 +  If bPopulate
.head 5 -  Call SalSendMsg(tblGrp, UM_Populate, 0, 0)
.head 5 -  Call SalSendMsg(tblGrpAll, UM_Populate, 0, 0)
.head 3 +  On WM_Size
.head 4 -  Call GetClientRect( hWndForm, nWinX0, nWinY0, nWinWidth, nWinHeight )
.head 4 -  Call SalSetWindowSize(hWndForm.frmSetAccess.tblGrp,
  SalPixelsToFormUnits(hWndForm.frmSetAccess.tblGrp, nWinWidth, FALSE)/2 - 0.7,
  SalPixelsToFormUnits(hWndForm.frmSetAccess.tblGrp, nWinHeight, TRUE ) - 0.55)
.head 4 -  Call SalGetWindowLoc(hWndForm.frmSetAccess.pbFilterGrp, nWW, nWH)
.head 4 -  Call SalSetWindowLoc(hWndForm.frmSetAccess.pbFilterGrp,
  SalPixelsToFormUnits(hWndForm.frmSetAccess.pbFilterGrp, nWinWidth, FALSE)/2 - 1.05, nWH)
.head 4 -  Call SalGetWindowLoc(hWndForm.frmSetAccess.pbFilterGrpAll, nWW, nWH)
.head 4 -  Call SalSetWindowLoc(hWndForm.frmSetAccess.pbFilterGrpAll,
  SalPixelsToFormUnits(hWndForm.frmSetAccess.pbFilterGrpAll, nWinWidth, FALSE) - 0.7, nWH)
.head 4 -  !
.head 4 -  Call SalGetWindowLoc(hWndForm.frmSetAccess.dfGrpAll, nWW, nWH)
.head 4 -  Call SalSetWindowLoc(hWndForm.frmSetAccess.dfGrpAll,
  SalPixelsToFormUnits(hWndForm.frmSetAccess.dfGrpAll, nWinWidth, FALSE)/2 + 0.5, nWH)
.head 4 -  Call SalGetWindowLoc(hWndForm.frmSetAccess.tblGrpAll, nWW, nWH)
.head 4 -  Call SalSetWindowLoc(hWndForm.frmSetAccess.tblGrpAll,
  SalPixelsToFormUnits(hWndForm.frmSetAccess.tblGrpAll, nWinWidth, FALSE)/2 + 0.5, nWH)
.head 4 -  Call SalSetWindowSize(hWndForm.frmSetAccess.tblGrpAll,
  SalPixelsToFormUnits(hWndForm.frmSetAccess.tblGrpAll, nWinWidth, FALSE)/2 - 0.7,
  SalPixelsToFormUnits(hWndForm.frmSetAccess.tblGrpAll, nWinHeight, TRUE ) - 0.55)
.head 4 -  !
.head 4 -  Call SalSetWindowLoc(hWndForm.frmSetAccess.pbAdd,
  SalPixelsToFormUnits(hWndForm.frmSetAccess.pbAdd, nWinWidth, FALSE)/2 - 0.25,
  SalPixelsToFormUnits(hWndForm.frmSetAccess.pbAdd, nWinHeight, TRUE )/2 - 0.3)
.head 4 -  Call SalSetWindowLoc(hWndForm.frmSetAccess.pbDrop,
  SalPixelsToFormUnits(hWndForm.frmSetAccess.pbDrop, nWinWidth, FALSE)/2 - 0.25,
  SalPixelsToFormUnits(hWndForm.frmSetAccess.pbDrop, nWinHeight, TRUE )/2 + 0.1)
.head 4 -  Call SalInvalidateWindow( hWndForm )
.head 1 -  !
.head 1 +  Form Window: frm_UDBD
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Управление доступом к банковским дням
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? No
.head 3 -  Initial State: Normal
.head 3 -  Maximizable? Yes
.head 3 -  Minimizable? Yes
.head 3 -  System Menu? Yes
.head 3 -  Resizable? No
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  5.233"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.131"
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
.head 3 +  Custom Control: cCal
.data CLASSPROPSSIZE
0000: 2C00
.enddata
.data CLASSPROPS
0000: 56543A43616C656E 646172001B000100 0000000100010000 0200000001000101
0020: 0101000000000001 00000000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cCalendar
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
.head 6 -  Top:    0.048"
.head 6 -  Width:  4.683"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 3.274"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Border? Class Default
.head 5 -  Etched Border? No
.head 5 -  Hollow? Class Default
.head 5 -  Vertical Scroll? Class Default
.head 5 -  Horizontal Scroll? Class Default
.head 5 -  Tab Stop? Class Default
.head 5 -  Tile To Parent? Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: 12
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  DLL Settings
.head 4 +  Message Actions
.head 5 +  On SAM_CustControlCmd
.head 6 -  Call cCal.GetFocusDate( dFD )
.head 6 +  If SqlPrepareAndExecute(hSql(), T("SELECT stat INTO :nDayStat FROM fdat WHERE fdat = :dFD "))
.head 7 +  If SqlFetchNext( hSql(), nFetchRes )
.head 8 +  If nDayStat = NUMBER_Null 
.head 9 -  Set nDayStat = 0
.head 9 -  Call SalEnableWindow (cmbSt)
.head 8 +  If nDayStat = 9
.head 9 -  Call SalEnableWindow (cmbSt)
.head 7 +  Else
.head 8 -  Set nDayStat = -1
.head 8 -  Call SalDisableWindow (cmbSt )
.head 7 -  Call cmbSt.SetSelectById( nDayStat )
.head 5 +  On SAM_Create
.head 6 -  Call cCal.WeekStartSet(2)
.head 3 +  Pushbutton: pbEx
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Применить
.head 4 -  Window Location and Size
.head 5 -  Left:   0.867"
.head 5 -  Top:    3.893"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Apply.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call cCal.GetFocusDate( dFD )
.head 6 +  If SalFmtFormatDateTime( dFD, 'dd/MM/yyyy' ) = SalFmtFormatDateTime( dBDOpen, 'dd/MM/yyyy' )
.head 7 -  ! Call SalMessageBox( 'Невозможно изменить статус текущего банковского дня.', 'Внимание!', MB_Ok )
.head 7 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('frm_UDBD.cTMess1'), 
     CurrentLangTable.GetAtomTitle('cTAt'), MB_Ok )
.head 7 -  Return FALSE
.head 6 +  If nDayStat < 0
.head 7 -  ! Call SalMessageBox( 'Невозможно изменить статус недоступного банковского дня.', 'Внимание!', MB_Ok )
.head 7 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('frm_UDBD.cTMess2'), 
     CurrentLangTable.GetAtomTitle('cTAt'), MB_Ok )
.head 7 -  Return FALSE
.head 6 -  !
.head 6 -  Set nStat=cmbSt.GetCurrentKey()
.head 6 +  If nStat >= 0
.head 7 +  If nStat != 10
.head 8 +  If SqlPrepareAndExecute( hSql(), 'UPDATE fdat SET stat=:nStat WHERE fdat=:dFD' )
.head 9 -  Call SqlCommit( hSql() )
.head 9 -  ! Call SaveInfoToLog( 'Управление доступом к банковским дням: '||SalFmtFormatDateTime( dFD, 'dd/MM/yyyy' )|| ' - '||IifS(nStat=0,'доступен','закрыт')||'.' )
.head 9 -  Call SaveInfoToLog(CurrentLangTable.GetAtomTitle('frm_UDBD.cTWndTitle') ||  ': '||SalFmtFormatDateTime( dFD, 'dd/MM/yyyy' )|| ' - '||IifS(nStat=0,
     CurrentLangTable.GetAtomTitle('frm_UDBD.cTToLog0'),
     CurrentLangTable.GetAtomTitle('frm_UDBD.cTToLog9'))||'.' )
.head 7 +  Else
.head 8 -  Call SqlPrepareAndExecute( hSql(), "
  SELECT count(fdat) 
  INTO :nCount 
  FROM opldok
  WHERE fdat=:dFD and sos=5" )
.head 8 +  If SqlFetchNext( hSql(), nFetchRes ) and nCount > 0
.head 9 -  ! Call SalMessageBox( 'Невозможно изъять день '|| SalFmtFormatDateTime( dFD,'dd/MM/yyyy' ), 'Внимание!', MB_IconAsterisk )
.head 9 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('frm_UDBD.cTMess3') ||  ' '|| SalFmtFormatDateTime( dFD,'dd/MM/yyyy' ), 
     CurrentLangTable.GetAtomTitle('cTAt'), MB_IconAsterisk )
.head 9 -  Return FALSE
.head 8 +  Else
.head 9 -  Call SqlPrepareAndExecute( hSql(), "DELETE FROM fdat WHERE fdat=:dFD" )
.head 9 -  Call SqlCommit( hSql() )
.head 9 -  ! Call SaveInfoToLog( 'Управление доступом к банковским дням: '||SalFmtFormatDateTime( dFD, 'dd/MM/yyyy' )|| ' - изъят.' )
.head 9 -  Call SaveInfoToLog(CurrentLangTable.GetAtomTitle('frm_UDBD.cTWndTitle') || ': '||SalFmtFormatDateTime( dFD, 'dd/MM/yyyy' )|| ' - ' || 
     CurrentLangTable.GetAtomTitle('frm_UDBD.cTToLog10') )
.head 9 -  Call cCal.SpecialDate(SPECIAL_OneTime, dFD,
     DAY_Unset, SEQ_Unset, COLOR_Black,
     COLOR_Salmon, TRUE)
.head 7 +  If nStat = 9
.head 8 -  ! Заслать мессагу по пайпу о дне !
.head 8 -  ! Prohibited !
.head 8 -  Call BDateNotify( dFD, 9 )
.head 7 -  Call SalSendMsg( hWndForm, SAM_User, 0, 0 )
.head 3 +  Pushbutton: pbClose
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выход
.head 4 -  Window Location and Size
.head 5 -  Left:   2.567"
.head 5 -  Top:    3.893"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Discard.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalDestroyWindow( hWndForm )
.head 3 +  Combo Box: cmbSt
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenComboBox_NumId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.85"
.head 5 -  Top:    3.548"
.head 5 -  Width:  3.2"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.881"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  String Type: Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Sorted? Class Default
.head 4 -  Always Show List? Class Default
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  List Initialization
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 +  If cmbSt.Init( hWndItem )
.head 7 -  ! Call cmbSt.Add( -1, 'недоступен' )
.head 7 -  Call cmbSt.Add(-1, CurrentLangTable.GetAtomTitle('frm_UDBD.cTSt_1'))
.head 7 -  ! Call cmbSt.Add(  0, 'доступен' )
.head 7 -  Call cmbSt.Add( 0, CurrentLangTable.GetAtomTitle('frm_UDBD.cTSt0'))
.head 7 -  ! Call cmbSt.Add(  9, 'закрыт' )
.head 7 -  Call cmbSt.Add( 9, CurrentLangTable.GetAtomTitle('frm_UDBD.cTSt9'))
.head 7 -  ! Call cmbSt.Add( 10, 'изъять' )
.head 7 -  Call cmbSt.Add(10, CurrentLangTable.GetAtomTitle('frm_UDBD.cTSt10'))
.head 5 +  On SAM_Click
.head 6 -  Call SalSendClassMessage( SAM_Click, 0, 0 )
.head 6 +  If cmbSt.GetCurrentKey() < 0
.head 7 -  Call cmbSt.SetSelectById( 0 )
.head 3 -  Line
.head 4 -  Resource Id: 2489
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  0.183"
.head 5 -  Begin Y:  3.405"
.head 5 -  End X:  4.883"
.head 5 -  End Y:  3.405"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Etched
.head 4 -  Line Thickness: 1
.head 4 -  Line Color: Default
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  String: smWeek[7]
.head 3 -  String: smMonth[12]
.head 3 -  Date/Time: dBD
.head 3 -  Date/Time: dBDOpen
.head 3 -  Date/Time: dFD
.head 3 -  String: sBDOpen
.head 3 -  Number: nFetchRes
.head 3 -  Number: nDayStat
.head 3 -  Number: nStat
.head 3 -  Number: nCount
.head 3 -  Boolean: fFirstInit
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('frm_UDBD.cTWndTitle'))
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Set dBD = GetBankDate()
.head 4 -  Set sBDOpen = GetGlobalOption('BANKDATE')
.head 4 -  Set dBDOpen = SalStrToDate(SalStrMidX(sBDOpen, 3, 2) || '-' || SalStrMidX(sBDOpen, 0, 2) || '-' || SalStrMidX(sBDOpen, 6, 4))
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Call cCal.ClearSpecials()
.head 4 -  Call SalSetFocus(cCal)
.head 4 +  If GetLang() = 'RUS'
.head 5 -  Call GetMonthArrayRus(smMonth)
.head 4 +  Else
.head 5 -  Call GetMonthArray(smMonth)
.head 4 -  Call GetWeekDayArray(smWeek)
.head 4 -  Call cCal.SetMonthText(smMonth)
.head 4 -  Call cCal.SetWeekDayText(smWeek)
.head 4 -  Call cCal.SpecialDate(SPECIAL_Weekly,
     DATETIME_Null, DAY_Sunday, SEQ_Unset,
     COLOR_Black, COLOR_Salmon, TRUE)
.head 4 -  Call cCal.SpecialDate(SPECIAL_Weekly,
     DATETIME_Null, DAY_Monday, SEQ_Unset,
     COLOR_Black, COLOR_Salmon, TRUE)
.head 4 -  Call cCal.SpecialDate(SPECIAL_Weekly,
     DATETIME_Null, DAY_Tuesday, SEQ_Unset,
     COLOR_Black, COLOR_Salmon, TRUE)
.head 4 -  Call cCal.SpecialDate(SPECIAL_Weekly,
     DATETIME_Null, DAY_Wednesday, SEQ_Unset,
     COLOR_Black, COLOR_Salmon, TRUE)
.head 4 -  Call cCal.SpecialDate(SPECIAL_Weekly,
     DATETIME_Null, DAY_Thursday, SEQ_Unset,
     COLOR_Black, COLOR_Salmon, TRUE)
.head 4 -  Call cCal.SpecialDate(SPECIAL_Weekly,
     DATETIME_Null, DAY_Friday, SEQ_Unset,
     COLOR_Black, COLOR_Salmon, TRUE)
.head 4 -  Call cCal.SpecialDate(SPECIAL_Weekly,
     DATETIME_Null, DAY_Saturday, SEQ_Unset,
     COLOR_Black, COLOR_Salmon, TRUE)
.head 4 -  Set fFirstInit = TRUE
.head 4 -  Call SalSendMsg(hWndForm, SAM_User, 0, 0)
.head 3 +  On SAM_User
.head 4 +  If SqlPrepareAndExecute(hSql(), T("
     SELECT fdat, stat
     INTO :dFD, :nStat
     FROM fdat"))
.head 5 +  While SqlFetchNext(hSql(), nFetchRes )
.head 6 +  Select Case nStat
.head 7 -  ! ! Синим цветом выделенны закрытые дни, 
.head 7 +  Case 9
.head 8 -  Call cCal.SpecialDate(SPECIAL_OneTime, dFD,
     DAY_Unset, SEQ_Unset, COLOR_Black,
     COLOR_Periwinkle, TRUE)
.head 8 -  Break
.head 7 +  Default
.head 8 -  ! ! Белым цветом - открыые дни, 
.head 8 -  Call cCal.SpecialDate(SPECIAL_OneTime, dFD,
     DAY_Unset, SEQ_Unset, COLOR_Black,
     COLOR_White, TRUE)
.head 4 +  If fFirstInit
.head 5 -  Call cCal.SetFocusDate(dBD)
.head 5 -  Set fFirstInit = FALSE
.head 4 -  Call SalWaitCursor(FALSE)
.head 1 +  Table Window: BLK
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Управління самоблоками
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
.head 4 -  Width:  8.117"
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
.head 5 -  Visible? No
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
.head 5 -  Visible? No
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
.head 5 -  Resource Id: 19452
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
.head 5 -  Visible? Yes
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
.head 5 -  Resource Id: 19453
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
.head 5 -  Resource Id: 19454
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
.head 3 +  Column: ID
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
користувача
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.817"
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
.head 3 +  Column: FIO
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
.head 4 -  Width:  3.233"
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
.head 3 +  Column: KBLK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Само-
блок
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.783"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Check Box
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value: 1
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: TBLK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Час зміни
сабоблоку
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Center
.head 4 -  Width:  2.4"
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
.head 3 -  Number: para
.head 2 -  Window Variables
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Call SalDisableWindow(pbDetails)
.head 4 -  Call SalDisableWindow(pbPrint)
.head 4 +  If para = 22
.head 5 -  Call SalSetWindowLabelText(hWndForm, 'Самоблокування виконавця')
.head 5 -  Call SalSetWindowText(hWndForm, 'Самоблокування виконавця')
.head 5 -  Call SalDisableWindow(pbSearch)
.head 4 -  Set hWndForm.BLK.strSqlPopulate =
"SELECT ID, FIO, to_number(BLK),to_char(TBLK ,'dd/mm/yyyy hh24:mm:ss ') 
   INTO :BLK.ID, :BLK.FIO, :BLK.KBLK, :BLK.TBLK 
   FROM staff " || IifS(para=22, " WHERE id=" || Str(GetUserId()), "") || 
" ORDER BY 1 "
.head 4 -  Set hWndForm.BLK.strSqlUpdate = 
"UPDATE staff 
    SET BLK  = to_char(" || IifS(para=22, '1', '0') || ") , 
        TBLK = sysdate 
  WHERE id=:BLK.ID and BLK=to_char(" || IifS(para=22, '0', '1') || ")"
.head 4 -  Call SalTblSetLockedColumns(hWndForm, 2)
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 1 +  Table Window: TB30
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Кол-во и Сумма НЕЗАВИЗИРОВАННЫХ
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
.head 4 -  Left:   0.825"
.head 4 -  Top:    1.031"
.head 4 -  Width:  Class Default
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
.head 3 -  Maximum Rows in Memory: 20000
.head 3 -  Discardable? Class Default
.head 2 -  Description: Просмотр количества и суммы зависших на контроле
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
.head 5 -  Resource Id: 26974
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
.head 5 -  Resource Id: 26975
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
.head 5 -  Resource Id: 26976
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
.head 4 +  Data Field: dCount
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
.head 7 -  Left:   7.35"
.head 7 -  Top:    0.095"
.head 7 -  Width:  1.6"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.25"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? Yes
.head 6 -  Justify: Right
.head 6 -  Format: #0
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 -  Background Text: Общее Кол-во
.head 5 -  Resource Id: 30901
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Window Location and Size
.head 6 -  Left:   5.45"
.head 6 -  Top:    0.119"
.head 6 -  Width:  1.7"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Justify: Right
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 2 +  Contents
.head 3 +  Column: gr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
гр.
кон-
троля
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 4
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.757"
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
.head 3 +  Column: name_gr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
группы
контроля
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.5"
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
.head 3 +  Column: pr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Прио
ритет
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 2
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.643"
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
.head 3 +  Column: tt
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
ОПЕР
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Center
.head 4 -  Width:  0.686"
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
.head 3 +  Column: name_tt
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
операции
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  3.157"
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
.head 3 +  Column: user_id
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ИД
пользо
ваетля
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
.head 3 +  Column: user_name
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ф.И.О.
исполнителя
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.414"
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
.head 3 +  Column: BRANCH
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Бранч
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.133"
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
.head 3 +  Column: kol
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кол-во
докумен
тов
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.943"
.head 4 -  Width Editable? Yes
.head 4 -  Format: ###0
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
.head 3 +  Column: su
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сумма
документов
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.757"
.head 4 -  Width Editable? Yes
.head 4 -  Format: ###000
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
.head 3 +  Column: vdat
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
валютирования
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
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
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Number: para
.head 2 +  Window Variables
.head 3 -  Number: nFetchRec
.head 3 -  Number: skol
.head 3 -  Number: ssu
.head 3 -  Number: nTmp
.head 3 -  Number: nId
.head 3 -  String: sSql
.head 3 -  String: sWhere
.head 3 -  Number: nPos
.head 3 -  Number: nFli
.head 3 -  String: sBRA
.head 3 -  String: sCount
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('TB30.cTWndTitle'))
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Call SalDisableWindow(pbDetails)
.head 4 -  Set nTabInstance = 1
.head 4 -  !
.head 4 -  Set gOB22     = GetGlobalOption  ('OB22')
.head 4 +  If nHaveTOBO = 2
.head 5 -  Set sBRA = 'oper.BRANCH,'
.head 4 +  Else
.head 5 -  Set sBRA = 'oper.TOBO,'
.head 4 -  ! население таблицы
.head 4 +  If para = 0 or para = 100 ! по банку
.head 5 -  Set sWhere = " "
.head 4 +  Else If para = 10 or para = 110 ! по текущему подразделению
.head 5 -  Set TB30.nId = GetUserId()
.head 5 -  Set sWhere = " and oper.userid in
 (SELECT u1.USERID 
  FROM otd_user u1, otd_user u2 
  WHERE u1.otd=u2.otd and u2.USERID=:hWndForm.TB30.nId) "
.head 4 +  If para = 0 or para = 10
.head 5 -  Call SalHideWindow(vdat)
.head 4 -  !
.head 4 -  Set hWndForm.TB30.strSqlPopulate = 
"SELECT " || sBRA || 
       " oper.userid, s.fio, t.tt, t.name, n.idchk, nvl(length(trim(oper.chk)),0)/6+1, 
        n.name, COUNT(*), SUM(oper.s)/100, t.fli " || 
        IifS(para=100 or para=110, ", oper.vdat", "") || "
 INTO :hWndForm.TB30.BRANCH, 
      :hWndForm.TB30.user_id, :hWndForm.TB30.user_name, :hWndForm.TB30.tt, :hWndForm.TB30.name_tt, 
      :hWndForm.TB30.gr, :hWndForm.TB30.pr,
      :hWndForm.TB30.name_gr, :hWndForm.TB30.kol, :hWndForm.TB30.su, :hWndForm.TB30.nFli" || 
      IifS(para=100 or para=110, ",  :hWndForm.TB30.vdat", "") || "
 FROM ref_que q, oper, tts t, chklist n, staff s
 WHERE oper.tt=t.tt AND s.id=oper.userid AND n.idchk=hex_to_num(oper.nextvisagrp) 
   AND oper.sos<>5 AND oper.sos>=0 AND oper.ref=q.ref " || sWhere || "
 GROUP BY " || sBRA || " oper.userid, s.fio, t.tt, t.fli, t.name, n.idchk, length(trim(oper.chk)), n.name" || 
       IifS(para=100 or para=110, ", oper.vdat", "") || "
 ORDER BY 1, n.idchk, t.tt, oper.userid" || 
       IifS(para=100 or para=110, ", oper.vdat", "")
.head 4 -  !
.head 4 -  Set sCount = 
"SELECT count(*) into :dCount FROM ref_que q, oper, tts t, chklist n, staff s
 WHERE oper.tt=t.tt AND s.id=oper.userid AND n.idchk=hex_to_num(oper.nextvisagrp) 
   AND oper.sos<>5 AND oper.sos>=0 AND oper.ref=q.ref " || sWhere 
.head 4 -  Set hWndForm.TB30.strFilterTblName = 'oper'
.head 4 -  Set hWndForm.TB30.nFlags = GT_NoUpd | GT_NoDel | GT_NoIns
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On UM_Populate
.head 4 -  Set ssu  = 0
.head 4 -  Set skol = 0
.head 4 -  If SqlPrepareAndExecute( hSql(), sCount )
and SqlFetchNext( hSql(), nFetchRes)
.head 4 -  Set nPos = SalTblQueryContext(hWndForm)
.head 4 -  Call SalSendClassMessage(UM_Populate, 0, 0)
.head 4 -  Call VisTblAutoSizeColumn(hWndForm, hWndNULL)
.head 4 -  Call SalTblDefineSplitWindow(hWndForm, 1, TBL_Split_Adjustable)
.head 4 -  Set nTmp = SalTblInsertRow(hWndForm, TBL_MinRow)
.head 4 -  Call SalTblSetContext(hWndForm, nTmp)
.head 4 -  Call SalTblSetRowFlags(hWndForm, nTmp, ROW_New, FALSE)
.head 4 -  Set kol = skol
.head 4 -  Set su  = ssu
.head 4 -  ! Set name_gr = 'И Т О Г О'
.head 4 -  Set name_gr = CurrentLangTable.GetAtomTitle('cTItogo')
.head 4 -  Call SalTblSetContext (hWndForm, nPos)
.head 4 -  Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Selected, TRUE)
.head 4 -  Call SalTblSetFocusRow(hWndForm, nPos)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_FetchRowDone
.head 4 -  Set ssu  = ssu+su
.head 4 -  Set skol = skol+kol
.head 4 +  If nFli = 1
.head 5 -  Call XSalTblSetRowBackColor(hWndForm, lParam, COLOR_Gray)
.head 4 +  If vdat != GetBankDate()
.head 5 -  Call XSalTblSetCellBackColor(vdat, SalColorFromRGB(230,255,230)) ! светло-зеленый
.head 3 +  On SAM_Destroy
.head 4 -  ! Disactivation call function' role
.head 4 +  If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
.head 5 -  Call XRoleUnset(hSql(), ' ShowNotPayDoc(0) ' )
.head 4 -  Call SalSetFocus( SalParentWindow( hWndForm ))
.head 1 +  Table Window: TB31
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: НЕЗАВИЗИРОВАННЫЕ документы
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
.head 4 -  Top:    1.719"
.head 4 -  Width:  18.167"
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
.head 3 -  Maximum Rows in Memory: 50000
.head 3 -  Discardable? Class Default
.head 2 -  Description: Просмотр незавизированных документов
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
.head 5 -  Resource Id: 26977
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
.head 5 -  Resource Id: 26978
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
.head 5 -  Resource Id: 26979
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
.head 4 +  Data Field: dCount
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
.head 7 -  Left:   10.783"
.head 7 -  Top:    0.071"
.head 7 -  Width:  1.6"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.25"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? Yes
.head 6 -  Justify: Right
.head 6 -  Format: #0
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 -  Background Text: Общее Кол-во
.head 5 -  Resource Id: 30902
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Window Location and Size
.head 6 -  Left:   8.883"
.head 6 -  Top:    0.095"
.head 6 -  Width:  1.7"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Justify: Right
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 2 +  Contents
.head 3 +  Column: gr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
гр.
кон-
троля
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 4
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.757"
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
.head 3 +  Column: name_gr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
группы
контроля
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.5"
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
.head 3 +  Column: pr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Прио
ритет
группы
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 2
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.757"
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
.head 3 +  Column: tt
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
ОПЕР
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Center
.head 4 -  Width:  0.686"
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
.head 3 +  Column: name_tt
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
операции
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  3.157"
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
.head 3 +  Column: user_id
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
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
.head 3 +  Column: user_name
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ФИО
исполнителя
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.443"
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
.head 3 +  Column: BRANCH
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Бранч
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.133"
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
.head 3 +  Column: kol
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Референс
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.1"
.head 4 -  Width Editable? Yes
.head 4 -  Format: ###0
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
.head 3 +  Column: su
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сумма
документа
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.757"
.head 4 -  Width Editable? Yes
.head 4 -  Format: ###000
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
.head 3 +  Column: k1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Штука
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.914"
.head 4 -  Width Editable? Yes
.head 4 -  Format: ###0
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
.head 3 -  Number: para
.head 2 +  Window Variables
.head 3 -  Number: nFetchRec
.head 3 -  Number: skol
.head 3 -  Number: ssu
.head 3 -  Number: nTmp
.head 3 -  Number: nId
.head 3 -  String: sSql
.head 3 -  String: sWhere
.head 3 -  Number: nPos
.head 3 -  Number: nFli
.head 3 -  String: sBRA
.head 3 -  String: sCount
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('TB31.cTWndTitle'))
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  !
.head 4 -  Set gOB22     = GetGlobalOption  ('OB22')
.head 4 +  If nHaveTOBO = 2
.head 5 -  Set sBRA = 'oper.BRANCH,'
.head 4 +  Else
.head 5 -  Set sBRA = 'oper.TOBO,'
.head 4 -  ! население таблицы
.head 4 -  Set nTabInstance = 1
.head 4 +  If para = 1 ! по банку
.head 5 -  Set sWhere = " "
.head 4 +  Else If para = 11 ! по текущему подразделению
.head 5 -  Set TB31.nId = GetUserId()
.head 5 -  Set sWhere = " and oper.userid in
 (SELECT u1.USERID 
  FROM otd_user u1, otd_user u2 
  WHERE u1.otd=u2.otd and u2.USERID=:hWndForm.TB31.nId) "
.head 4 -  Set TB31.strSqlPopulate=
"SELECT " || sBRA || " oper.userid, s.fio, t.tt, t.name, n.idchk, 
    nvl(length(trim(oper.chk)),0)/6+1, n.name, oper.ref, oper.s/100, 1, t.fli
 INTO :hWndForm.TB30.BRANCH, :hWndForm.TB31.user_id, :hWndForm.TB31.user_name, :hWndForm.TB31.tt,
      :hWndForm.TB31.name_tt,  :hWndForm.TB31.gr, :hWndForm.TB31.pr,
      :hWndForm.TB31.name_gr, :hWndForm.TB31.kol, :hWndForm.TB31.su, :hWndForm.TB31.k1, :hWndForm.TB31.nFli
 FROM ref_que q, oper, tts t, chklist n, staff s
 WHERE oper.tt=t.tt AND s.id=oper.userid AND n.idchk=hex_to_num(oper.nextvisagrp) AND
       oper.sos<>5 AND oper.sos>=0 AND oper.ref=q.ref " || sWhere || "
 ORDER BY 1, 6, 4, 2"
.head 4 -  Set sCount = 
"SELECT count(*) INTO :dCount FROM ref_que q, oper, tts t, chklist n, staff s
 WHERE oper.tt=t.tt AND s.id=oper.userid AND n.idchk=hex_to_num(oper.nextvisagrp) AND
       oper.sos<>5 AND oper.sos>=0 AND oper.ref=q.ref  " || sWhere 
.head 4 -  !
.head 4 -  Set TB31.strFilterTblName='oper'
.head 4 -  ! Call VisTblAutoSizeColumn( hWndForm, hWndNULL )
.head 4 -  Set nFlags = GT_NoUpd | GT_NoDel | GT_NoIns
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On SAM_DoubleClick
.head 4 -  Call DocViewContentsEx ( hWndMDI, TB31.kol )
.head 3 +  On UM_Populate
.head 4 -  Set ssu=0
.head 4 -  Set skol=0
.head 4 -  If SqlPrepareAndExecute( hSql(), sCount )
and SqlFetchNext( hSql(), nFetchRes)
.head 4 -  Set nPos=SalTblQueryContext ( hWndForm )
.head 4 -  Call SalSendClassMessage(UM_Populate, 0, 0)
.head 4 -  Call SalTblDefineSplitWindow (hWndForm, 1, TBL_Split_Adjustable)
.head 4 -  Set nTmp=SalTblInsertRow(hWndForm, TBL_MinRow)
.head 4 -  Call SalTblSetContext(hWndForm, nTmp)
.head 4 -  Call SalTblSetRowFlags(hWndForm, nTmp, ROW_New, FALSE)
.head 4 -  Set kol = skol
.head 4 -  Set su  = ssu
.head 4 -  ! Set name_gr = 'И Т О Г О'
.head 4 -  Set name_gr = CurrentLangTable.GetAtomTitle('cTItogo')
.head 4 -  Call SalTblSetContext ( hWndForm, nPos )
.head 4 -  Call SalTblSetRowFlags( hWndForm, SalTblQueryContext ( hWndForm ), ROW_Selected, TRUE )
.head 4 -  Call SalTblSetFocusRow( hWndForm, nPos )
.head 4 -  Call SalWaitCursor( FALSE )
.head 3 +  On SAM_Destroy
.head 4 -  ! Disactivation call function' role
.head 4 +  If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
.head 5 -  Call XRoleUnset(hSql(), ' ShowNotPayDoc(1) ' )
.head 4 -  Call SalSetFocus( SalParentWindow( hWndForm ))
.head 3 +  On SAM_FetchRowDone
.head 4 -  Set ssu  = ssu+su
.head 4 -  Set skol = skol+k1
.head 4 +  If nFli=1
.head 5 -  Call XSalTblSetRowBackColor( hWndForm, lParam, COLOR_Gray )
