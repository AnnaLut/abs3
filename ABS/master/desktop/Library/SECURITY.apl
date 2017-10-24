.head 0 +  Application Description: ! SECURITY.APL - Аудиторские просмотры комплекса 
! //////////////////////////////////////////////
! ООО Унити-Барс  ( C ) 1997-2003
! Разработчик: Сыропоршнев Д.Л., Чупахина Н.А., Лут А.В.
! Щетенюк С.П.
! //////////////////////////////////////////////
.head 1 -  Outline Version - 4.0.26
.head 1 +  Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000DA0000 002C000000020000 0003000000FFFFFF FFFFFFFFFFF8FFFF
0040: FFE2FFFFFF000000 00000000002C0300 0040010000010000 0001000000010000
0060: 000F4170706C6963 6174696F6E497465 6D01000000075769 6E646F7773
.enddata
.data DT_MAKERUNDLG
0000: 02000000001D443A 5C576F726B5C4479 6E4D656E75735C64 796E5F6D656E752E
0020: 6578651D443A5C57 6F726B5C44796E4D 656E75735C64796E 5F6D656E752E646C
0040: 6C1D443A5C576F72 6B5C44796E4D656E 75735C64796E5F6D 656E752E61706300
0060: 000101011D443A5C 576F726B5C44796E 4D656E75735C6479 6E5F6D656E752E72
0080: 756E1D443A5C576F 726B5C44796E4D65 6E75735C64796E5F 6D656E752E646C6C
00A0: 1D443A5C576F726B 5C44796E4D656E75 735C64796E5F6D65 6E752E6170630000
00C0: 010101185C426172 7339385C42696E5C 5345435552495459 2E617064185C4261
00E0: 727339385C42696E 5C64796E5F6D656E 752E646C6C185C42 61727339385C4269
0100: 6E5C64796E5F6D65 6E752E6170630000 0101011D443A5C57 6F726B5C44796E4D
0120: 656E75735C64796E 5F6D656E752E6170 6C1D443A5C576F72 6B5C44796E4D656E
0140: 75735C64796E5F6D 656E752E646C6C1D 443A5C576F726B5C 44796E4D656E7573
0160: 5C64796E5F6D656E 752E617063000001 0101
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
0000: 0418B80BB80B2500
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
.head 2 -  Dynalib: Dfltrapi.apd
.head 2 -  Dynalib: Nsiapi.apd
.head 2 -  !
.head 2 -  File Include: Constant.apl
.head 2 -  File Include: XSALIMG.APL
.head 2 -  File Include: Genbutn.apl
.head 2 -  File Include: Genemnu.apl
.head 2 -  File Include: Gentimer.apl
.head 2 -  File Include: Gentbl.apl
.head 2 -  File Include: Genlist.apl
.head 2 -  File Include: Vtcomm.apl
.head 2 -  File Include: Winbars2.apl
.head 2 -  File Include: Watchdog.apc
.head 2 -  File Include: Vttblwin.apl
.head 2 -  File Include: Vtwin.apl
.head 2 -  File Include: Vtmeter.apl
.head 2 -  File Include: XSALCPT.APL
.head 2 -  File Include: dsdll.apl
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
.head 4 -  Font Name: Arial Cyr
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Bold
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
.head 3 -  Date/Time: hhh:mm:ss
.head 3 -  Date/Time: dd/MM/yyyy
.head 3 -  Input: 99:99
.head 3 -  Date/Time: dd/MM/yyyy hh:mm
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
.head 4 -  String: AppCode = 'SECURITY '
.head 4 -  !
.head 4 -  Number: APPROVE_Arms		= 1
.head 4 -  Number: APPROVE_Tts		= 2
.head 4 -  Number: APPROVE_Check		= 3
.head 4 -  Number: APPROVE_Groups		= 4
.head 4 -  Number: APPROVE_RepNBU		= 5
.head 4 -  Number: APPROVE_Func		= 7
.head 4 -  Number: APPROVE_Ref		= 8
.head 4 -  Number: APPROVE_Rep		= 9
.head 4 -  Number: APPROVE_Acc		= 10
.head 4 -  Number: APPROVE_User		= 20
.head 4 -  !
.head 4 -  Number: SECEXP_TextDelimiters   = 0
.head 4 -  Number: SECEXP_TextSQL          = 1
.head 2 +  Resources
.head 2 +  Variables
.head 3 -  Boolean: fInitLib
.head 3 -  !
.head 3 -  Number: nFetchRes
.head 3 -  !
.head 3 -  Boolean: bIsOpen
.head 3 -  Boolean: bRefr
.head 3 -  !
.head 3 -  Number: nGateWay
.head 3 -  String: sGateWay
.head 3 -  !
.head 3 -  Window Handle: hWin0
.head 3 -  Window Handle: hWin1
.head 3 -  Window Handle: hWin2
.head 3 -  Window Handle: hWin3
.head 3 -  Window Handle: hWin4
.head 3 -  Window Handle: hWin5
.head 3 -  Window Handle: hWin6
.head 3 -  Window Handle: hWinErr
.head 3 -  Window Handle: hWinKeeper
.head 3 -  Window Handle: hWinJournal
.head 3 -  Window Handle: hWinSecJournal
.head 2 +  Internal Functions
.head 3 +  Function: SecurityIni
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
.head 6 -  Set strFileName = strPathToLangResources || "\\" || strLangId || "\\security.lng"
.head 6 -  !
.head 6 +  If (NOT strLangId) OR (NOT CurrentLangTable.InitFromFile( strFileName, strLangId ))
.head 7 -  Call CurrentLangTable.Init()
.head 7 -  !
.head 7 -  Call CurrentLangTable.AddAtom('cTAt', 'Внимание!')
.head 7 -  Call CurrentLangTable.AddAtom('cTErr','Ошибка!')
.head 7 -  Call CurrentLangTable.AddAtom('cTEnhancedSecurity','Не включена опция усиленного режима безопасности!')
.head 7 -  Call CurrentLangTable.AddAtom('cTFunction','Функция уже активирована')
.head 7 -  ! ====================================================
.head 7 -  ! tbl_Approving
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTWndTitle','Подтверждение/Аннулирование прав пользователей')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTWndTitleShow','Просмотр неподтвержденных прав пользователей')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTMenu','Подтверждение прав')
.head 7 -  ! Columns
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.colID','Код')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.colLOGIN','Рабочее~Имя')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.colUserName','Ф.И.О.')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.colRTable','Тип~ресурса')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.colResourceKod','Код~ресурса')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.colResourceName','Наименование~ресурса')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.colApprove','Разре~шить')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.colADate1','Разрешен~с')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.colADate2','Разрешен~до')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.colRDate1','Запрещен~с')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.colRDate2','Запрещен~до')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.colGrantor','Кто выд./анн.~ресурс')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.colGrantorLOGIN','Кто выд./анн.~ресурс')
.head 7 -  ! Botton strTip
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cBTipGranted','Показать выдаваемые права на ресурсы')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cBTipRevoked','Показать аннулируемые права на ресурс')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cBTipUser','Показать ресурсы пользователей')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cBTipArms','Показать ресурсы АРМ-ов')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cBTipABS','Показать ресурсы АБС')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cBTipSecJournal','Показать журнал безопасности')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cBTipChangePeriod','Показать ресурсы с периодом действия')
.head 7 -  ! Msg
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTMsg1','Невозможно удалить запись из SEC_LOGINS')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTMsg2','Невозможно удалить пользователя для таб.№')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTMsg3','Невозможно создать запись в табл. SEC_LOGINS для пользователя с таб.№')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTMsg4','Невозможно сделать запись в журнале безопасности')
.head 7 -  ! Err
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTErr1','Нету записи в staff_storage для пользователя с №')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTErr2','Невозможно вычитать параметры для создания пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTErr3','Невозможно создать пользователя ORACLE для таб.№')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTErr4','Невозможно создать запись в табл. SEC_LOGINS для пользователя с таб.№')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTErr5','Невозможно обновить таблицу staff')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTErr6','Невозможно дать привелегию')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTErr7','Невозможно дать роль поумолчанию')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTErr8','Невозможно дать привелегию на создание сессии')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTErrConnect','Невозможно установить соединение')
.head 7 -  ! Constant
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTObjects0','Все')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTObjects1','Арм-ы')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTObjects2','Банковские Операции')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTObjects3','Группы Контроля')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTObjects4','Группы Доступа')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTObjects5','Файлы отчетности НБУ')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTObjects10','Счета')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTObjects7','Функции')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTObjects8','Справочники')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTObjects9','Печатные отчеты')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTObjects20','Пользователи')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTColLOGIN','Код АРМа')
.head 7 -  ! Call CurrentLangTable.AddAtom('tbl_Approving.cTColUserName','АРМ')
.head 7 -  ! Call CurrentLangTable.AddAtom('tbl_Approving.cTColResourceKod','Код~ресурса')
.head 7 -  ! Call CurrentLangTable.AddAtom('tbl_Approving.cTColResourceName','Наименование~ресурса')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTColRDate1','Дата действия')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTColUserName1','Реципиент')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTColResourceKod1','Таб.№')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTColResourceId','Код польз.')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTColRTable1','АРМ')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTColRTable2','Банковские Операции')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTColRTable3','Группа контроля')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTColRTable4','Группа доступа')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTColRTable5','Отчет НБУ')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTColRTable6','Счет')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTColRTable7','Функция')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTColRTable8','Отчет')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTColRTable9','Справочник')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTToLog1','Отказ от подтверждения прав для')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTToLog2','Неуспешный отказ от подтверждения прав для')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTToLog3','на ресурс')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTToLogSec0','Безопасность')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTToLogSec1','подтверждение прав')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTToLogSec2','аннулирование прав')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Approving.cTToLogSec3','неуспешное выполнение')
.head 7 -  ! ====================================================
.head 7 -  ! tbl_ApprovingAttr
.head 7 -  Call CurrentLangTable.AddAtom('tbl_ApprovingAttr.cTWndTitle','Подтверждение/Аннулирование изменений атрибутов пользователей')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_ApprovingAttr.cTWndTitleShow','Просмотр неподтвержденных изменений атрибутов пользователей')
.head 7 -  ! Columns
.head 7 -  Call CurrentLangTable.AddAtom('tbl_ApprovingAttr.colUserId','Код')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_ApprovingAttr.colUserLogin','Рабочее~Имя')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_ApprovingAttr.colUserName','Ф.И.О.')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_ApprovingAttr.colAttrName','Наименование~атрибута')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_ApprovingAttr.colAttrValue','Значение~атрибута')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_ApprovingAttr.colApprove','Разре~шить')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_ApprovingAttr.colGrantorName','Кто изменил~атрибут')
.head 7 -  !
.head 7 -  Call CurrentLangTable.AddAtom('tbl_ApprovingAttr.cTToLog1','Отказ от подтверждения изменений атрибута')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_ApprovingAttr.cTToLog2','Неуспешный отказ от подтверждения изменений атрибута')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_ApprovingAttr.cTToLog3','Подтверждение изменений атрибута')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_ApprovingAttr.cTToLog4','Неуспешное подтверждение изменений атрибута')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_ApprovingAttr.cTToLogFor','для')
.head 7 -  ! ====================================================
.head 7 -  ! tbl_Journal
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cTWndTitle','Журнал событий банковского комплекса')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cTMenu','Журнал')
.head 7 -  ! Columns
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.colId',   'Ид.')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.colType', 'Тип~события')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.colBDate','Банковская~Дата')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.colDate', 'Реальная~Дата')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.colTime', 'Время')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.colMessage','Сообщение')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.colUName','Пользователь')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.colMachine','Рабочая~станция')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.colUname', 'Имя~пользователя БД')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.colUproxy','Имя~proxy-пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.colModule','Модуль~комплекса')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.colObject','Создал~сообщение')
.head 7 -  ! Botton strTip
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cBTipRefresh','Перечитать')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cBTipMoveToArchive','Сохранить журнал в архив')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cBTipPrint','Печать в файл')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cBTipFilter','Фильтр')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cBTipSearch','Искать')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cBTipExit','Завершить работу')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cBTipDet','Просмотреть сообщения')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cBTipFilterDat','Фильтр по дате сообщения')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cBTipCheckLog','Проверить целостность файла протокола')
.head 7 -  ! Msg
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cTMsgOpenFile','Неудача при открытии файла')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cTMsgFileSave','Текст успешно сохранен в файле')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cTMsgProtokol1','Цілісність протоколу')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cTMsgProtokol2','не порушено.')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cTMsgProtokol','Перевірка протоколу')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cTMsgSize1','Размер журнала превысил значение в')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cTMsgSize2','и составляет')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cTMsgSize3','Необходима его архивация.')
.head 7 -  ! Err
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cTErrCall','Ошибка вызова')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cTErrProtokol1','Порушено цілісність протоколу.')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cTErrProtokol2','Файл')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cTErrProtokol3','Функція')
.head 7 -  ! Constant
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cTFTime','Сист. Время')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cTDelete','Удаление всех записей из оперативного журнала контроля выполнения банковских операций')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cTTitleOpenFile1','Проверка целостности журнала...')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cTTitleOpenFile2','Печать в файл...')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cTTitleOpenFile3','Сохранение записей журнала...')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cTTitleDlg','Архивирование журнала событий...')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Journal.cTToLog','Перемещение записей журнала аудита в файл')
.head 7 -  ! ====================================================
.head 7 -  ! dlg_clear_journal
.head 7 -  Call CurrentLangTable.AddAtom('dlg_clear_journal.cTWndTitle','Сохранение журнала в архив...')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_clear_journal.rbTxtDelim','Экспорт в файл с разделителями (TAB)')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_clear_journal.rbSQL','Экспорт в виде SQL ')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_clear_journal.rbJournalDel','С удалением записей из журнала')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_clear_journal.rbJournalNoDel','Без удаления записей из журнала')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_clear_journal.pbOk','Архивировать')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_clear_journal.pbCancel','Отменить')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_clear_journal.bgClear','Сохранить журнал аудита в архив (файл) по указанную дату?')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_clear_journal.bgArchDate','Дата архивации:')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_clear_journal.bgDateFrom','С даты:')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_clear_journal.bgDateTo','По дату:')
.head 7 -  ! ====================================================
.head 7 -  ! dlg_edit_mess
.head 7 -  Call CurrentLangTable.AddAtom('dlg_edit_mess.cTWndTitle','Просмотр сообщений')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_edit_mess.bgBD','Банковская дата:')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_edit_mess.bgRD','Реальная дата:')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_edit_mess.bgType','Тип сообщения:')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_edit_mess.bgUser','Пользователь:')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_edit_mess.bgMach','Рабочая станция:')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_edit_mess.cBTipBack','Предыдущая запись')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_edit_mess.cBTipForw','Следующая запись')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_edit_mess.cBTipBegin','В начало журнала')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_edit_mess.cBTipEnd','В конец журнала')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_edit_mess.cBTipClose','Закрыть окно')
.head 7 -  ! ====================================================
.head 7 -  ! dlg_input_value
.head 7 -  Call CurrentLangTable.AddAtom('dlg_input_value.cTWndTitle','Укажите параметры фильтра...')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_input_value.cbUseFTime','Временной интервал:')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_input_value.pbExecute','Утвердить')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_input_value.pbCancel','Отменить')
.head 7 -  ! ====================================================
.head 7 -  ! frm_Keeper
.head 7 -  Call CurrentLangTable.AddAtom('frm_Keeper.cTWndTitle','Сторож')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Keeper.pbKeep','Спрятать')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Keeper.pbOk','Применить')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Keeper.pbExit','Отменить')
.head 7 -  ! Columns
.head 7 -  Call CurrentLangTable.AddAtom('frm_Keeper.tblT.colType','Тип сообщения')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Keeper.tblT.colComm','Тип сообщения')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Keeper.tblT.colAlarm','Обработать')
.head 7 -  ! Msg
.head 7 -  Call CurrentLangTable.AddAtom('frm_Keeper.cTMsg1','Были изменены настройки.')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Keeper.cTMsg2','Сохранить изменения?')
.head 7 -  ! Err
.head 7 -  Call CurrentLangTable.AddAtom('frm_Keeper.cTErrExecute','Ошибка выполнения')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Keeper.cTErrCreate','Ошибка создания')
.head 7 -  ! ====================================================
.head 7 -  ! frm_Err
.head 7 -  Call CurrentLangTable.AddAtom('frm_Err.cTWndTitle','Сообщения об ошибках')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Err.pbJournal','Просмотреть журнал событий')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Err.pbRefresh','Обновить')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Err.pbClose','Закрыть')
.head 7 -  ! bg
.head 7 -  Call CurrentLangTable.AddAtom('frm_Err.bgBD','Банковская дата:')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Err.bgC','Сообщений всего:')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Err.bgUser','Пользователь:')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Err.bgMach','Рабочая станция:')
.head 7 -  ! Columns
.head 7 -  Call CurrentLangTable.AddAtom('frm_Err.tblMess.colDat','Время')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Err.tblMess.colMess','Сообщение')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Err.tblMess.colUser','Пользователь')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Err.tblMess.colMach','Рабочая станция')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Err.tblMess.colBdat','Банк. дата')
.head 7 -  ! ====================================================
.head 7 -  ! tbl_Attend
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Attend.cTWndTitle','Журнал регистрации пользователей на "проходной"')
.head 7 -  ! Columns
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Attend.colID','Код')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Attend.colLog','Рабочее имя')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Attend.colFio','ФИО')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Attend.colMode','Посещение')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Attend.colAtt','Присутствие')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Attend.colDate','Дата и время регистрации')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Attend.colDat','Дата регистрации')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Attend.colTime','Время регистрации')
.head 7 -  ! Constant
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Attend.cTIn', 'Приход')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Attend.cTOut','Уход')
.head 7 -  ! ====================================================
.head 7 -  ! tbl_Logins
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Logins.cTWndTitle','Управление пользовательскими Login-ами')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Logins.cTMenu','Управление Login-ами')
.head 7 -  ! Columns
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Logins.colID','Код')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Logins.colLOGIN','Рабочее~Имя')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Logins.colName','Ф.И.О.')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Logins.colDisable','Закрыт')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Logins.colADate1','Разрешен~с')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Logins.colADate2','Разрешен~до')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Logins.colRDate1','Запрещен~с')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Logins.colRDate2','Запрещен~до')
.head 7 -  ! Constant
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Logins.cTToLog1','Изменение статуса учетной записи пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Logins.cTToLog2','Выкл')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Logins.cTToLog3','Разрешен')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Logins.cTToLog4','Запрещен')
.head 7 -  ! ====================================================
.head 7 -  ! tbl_SecJournal
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecJournal.cTWndTitle','Журнал событий безопасности')
.head 7 -  !
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecJournal.cBTipUser','Показать ресурсы пользователей')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecJournal.cBTipArms','Показать ресурсы АРМ-ов')
.head 7 -  ! Columns 
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecJournal.colGrantorName','Инициатор~действий')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecJournal.colGrantorLogin','Инициатор~действий')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecJournal.colGrDate','Дата~ действий')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecJournal.colAction','Дей-~ствие')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecJournal.colResType','Тип ресурса')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecJournal.colResId','Код~ресурса')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecJournal.colResourceName','Имя ресурса')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecJournal.colSourceType','Тип~получателя')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecJournal.colSourceId','Код~получателя')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecJournal.colSourceName','Наименование~получателя')
.head 7 -  ! ====================================================
.head 7 -  ! tbl_Substitutes
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTWndTitle','Делигирование прав другим пользователям')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTMenu','Делигирование прав')
.head 7 -  !
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cBTipDetails','Получить значение из справочника')
.head 7 -  ! Columns
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.colID_WHO','Кому~(Код)')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.colLOGIN_WHO','Рабочее~Имя')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.colFIO_WHO','Ф.И.О.')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.colID_WHOM','От кого~(Код)')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.colLOGIN_WHOM','Рабочее~Имя')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.colFIO_WHOM','Ф.И.О.')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.colSTART','На период~с')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.colFINISH','На период~по')
.head 7 -  ! Msg
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTMsgProc','Процедура делегирования или снятия полномочий сопровождается процедурой манипулирования правами пользователей на системном уровне, которая может занять продолжительное время.')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTMsgValue','Недопустимо отсутствие значений в атрибутах "Кому" или "От Кого"!')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTMsgBlock','Блокировать Login пользователя')
.head 7 -  ! Err
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTErrExecute','Ошибка при выполнении')
.head 7 -  ! Constant
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTToLogArms','Передача системных прав на АРМы пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTToLogArmsOk','Передача системных прав на АРМы завершена')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTToLogRef','Передача системных прав на справочники пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTToLogRefOk','Передача системных прав на справочники завершена')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTToLogArmsNull','Аннулирование системных прав на АРМы пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTToLogArmsNullOk','Аннулирование системных прав на АРМы завершено')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTToLogRefNull','Аннулирование системных прав на справочники пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTToLogRefNullOk','Аннулирование системных прав на справочники завершено')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTToLogForUser','пользователю')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTLoginClosed','Закрыт пользовательский логин')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTPeriod','на период')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTFrom','c')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTTo','по')
.head 7 -  ! Option Button
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTShowAllDelegation','Показать все делегации')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTShowActiveDelegation','Показать активные делегации')
.head 7 -  ! Msg2
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTNonValuesDatesPeriod','Несоответствие значений дат периода!')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_Substitutes.cTMsgValue2','Недопустимо отсутствие значений в датах периода!')
.head 7 -  ! ====================================================
.head 7 -  ! tbl_SecAuditArch
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecAuditArch.cTWndTitle','Архив журнала событий')
.head 7 -  ! Columns
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecAuditArch.colId',   'Ид.')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecAuditArch.colType', 'Тип~события')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecAuditArch.colBDate','Банковская~Дата')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecAuditArch.colDate', 'Реальная~Дата')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecAuditArch.colMessage','Сообщение')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecAuditArch.colMachine','Рабочая~станция')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecAuditArch.colUname', 'Имя~пользователя БД')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecAuditArch.colUproxy','Имя~proxy-пользователя')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecAuditArch.colModule','Модуль~комплекса')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecAuditArch.colObject','Создал~сообщение')
.head 7 -  Call CurrentLangTable.AddAtom('tbl_SecAuditArch.colBranch','Отделение')
.head 7 -  ! ====================================================
.head 7 -  ! dlg_SetDate 
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetDate.cTWndTitle','Задайте период дат')
.head 7 -  ! Button
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetDate.pbOk','Применить')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetDate.pbCancel','Отменить')
.head 7 -  ! bg
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetDate.bgDat1','Дата начала')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SetDate.bgDat2','Дата окончания')
.head 7 -  ! ====================================================
.head 6 -  !
.head 6 -  Set fInitLib = TRUE
.head 5 -  ! Call CurrentLangTable.SaveToFile('C:\\TEMP\\security.lng','RUS')
.head 5 -  Return fInitLib
.head 3 +  Function: ShowSecurity		!__exported
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SecurityIni()
.head 5 +  If NOT IsWindow(hWinJournal)
.head 6 -  Set hWinJournal = SalCreateWindow(tbl_Journal, hWndMDI, TRUE)
.head 6 -  Return TRUE
.head 5 +  Else
.head 6 -  Call SalMessageBox('Функция просмотра журнала событий уже активирована', 'Внимание!', MB_Ok)
.head 3 +  Function: ManageUserLogins	!__exported
.head 4 -  Description: Управление пользовательскими логинами
и сроками их действия.
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SecurityIni()
.head 5 +  If NOT EnhancedSecurity()
.head 6 -  Call SalMessageBeep(MB_IconStop)
.head 6 -  ! Не включена опция усиленного режима безопасности!
.head 6 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('cTEnhancedSecurity'),
     CurrentLangTable.GetAtomTitle('cTAt'), MB_IconStop | MB_Ok)
.head 6 -  Return FALSE
.head 5 +  If NOT SalCreateWindow(tbl_Logins, hWndMDI)
.head 6 -  Return FALSE
.head 5 -  Return TRUE
.head 3 +  Function: ApproveUserAccess	!__exported
.head 4 -  Description: Подтверждение прав пользователя
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SecurityIni()
.head 5 -  Call F_Security(hWndMDI, 1, 0, 0, '', '')
.head 5 -  Return TRUE
.head 3 +  Function: MakeSubstitutes	!__exported
.head 4 -  Description: Сделать замены в команде
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SecurityIni()
.head 5 +  If NOT SalCreateWindow(tbl_Substitutes, hWndMDI)
.head 6 -  Return FALSE
.head 5 -  Return TRUE
.head 3 +  Function: ShowErrMess           !__exported
.head 4 -  Description: Функция контроля появления ошибок в журнале событий
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SecurityIni()
.head 5 +  If NOT IsWindow(hWin0)
.head 6 -  Set hWin0 = SalCreateWindow(frm_Keeper, hWndMDI)
.head 6 -  Return TRUE
.head 5 +  Else
.head 6 -  ! Функция уже активирована
.head 6 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('cTFunction'),
     CurrentLangTable.GetAtomTitle('cTAt'), MB_Ok)
.head 3 +  Function: ShowAttendance        !__exported
.head 4 -  Description: Просмотр журнала посещений
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Number: nUserId
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SecurityIni()
.head 5 +  If nUserId < 0
.head 6 -  Call F_Security(hWndMDI, 2, 0, 0, '', '')
.head 5 +  Else
.head 6 -  Call SalCreateWindow(tbl_Attend, hWndMDI, nUserId)
.head 3 +  Function: F_Security		!__exported
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Window Handle: hWndParent
.head 5 -  Number: nMode
.head 5 -  Number: nPar1
.head 5 -  Number: nPar2
.head 5 -  String: strPar1
.head 5 -  String: strPar2
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SecurityIni()
.head 5 +  Select Case nMode
.head 6 -  ! Подтверждение прав пользователей
.head 6 +  Case 1
.head 7 +  If NOT EnhancedSecurity()
.head 8 -  Call SalMessageBeep(MB_IconStop)
.head 8 -  ! Не включена опция усиленного режима безопасности!
.head 8 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('cTEnhancedSecurity'),
     CurrentLangTable.GetAtomTitle('cTAt'), MB_IconStop | MB_Ok)
.head 8 -  Break
.head 7 +  If not IsWindow(hWin1)
.head 8 -  Set hWin1 = SalCreateWindow(tbl_Approving, hWndParent, TRUE)
.head 7 +  Else
.head 8 -  Call SalBringWindowToTop(hWin1)
.head 7 -  Break
.head 6 -  ! Просотр неподтвержденных прав пользователей
.head 6 +  Case 2
.head 7 +  If NOT EnhancedSecurity()
.head 8 -  Call SalMessageBeep(MB_IconStop)
.head 8 -  ! Не включена опция усиленного режима безопасности!
.head 8 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('cTEnhancedSecurity'),
     CurrentLangTable.GetAtomTitle('cTAt'), MB_IconStop | MB_Ok)
.head 8 -  Break
.head 7 +  If not IsWindow(hWin2)
.head 8 -  Set hWin2 = SalCreateWindow(tbl_Approving, hWndParent, FALSE)
.head 7 +  Else
.head 8 -  Call SalBringWindowToTop(hWin2)
.head 7 -  Break
.head 6 -  ! Подтверждение изменений атрибутов пользователей
.head 6 +  Case 3
.head 7 +  If NOT EnhancedSecurity()
.head 8 -  Call SalMessageBeep(MB_IconStop)
.head 8 -  ! Не включена опция усиленного режима безопасности!
.head 8 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('cTEnhancedSecurity'),
     CurrentLangTable.GetAtomTitle('cTAt'), MB_IconStop | MB_Ok)
.head 8 -  Break
.head 7 +  If not IsWindow(hWin3)
.head 8 -  Set hWin3 = SalCreateWindow(tbl_ApprovingAttr, hWndParent, TRUE)
.head 7 +  Else
.head 8 -  Call SalBringWindowToTop(hWin3)
.head 7 -  Break
.head 6 -  ! Просотр неподтвержденных изменений атрибутов пользователей
.head 6 +  Case 4
.head 7 +  If NOT EnhancedSecurity()
.head 8 -  Call SalMessageBeep(MB_IconStop)
.head 8 -  ! Не включена опция усиленного режима безопасности!
.head 8 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('cTEnhancedSecurity'),
     CurrentLangTable.GetAtomTitle('cTAt'), MB_IconStop | MB_Ok)
.head 8 -  Break
.head 7 +  If not IsWindow(hWin4)
.head 8 -  Set hWin4 = SalCreateWindow(tbl_ApprovingAttr, hWndParent, FALSE)
.head 7 +  Else
.head 8 -  Call SalBringWindowToTop(hWin4)
.head 7 -  Break
.head 6 -  ! Журнал событий
.head 6 +  Case 5
.head 7 +  If not IsWindow(hWin5)
.head 8 -  Set hWin5 = SalCreateWindow(tbl_Journal, hWndParent, nPar1)
.head 7 +  Else
.head 8 -  Call SalBringWindowToTop(hWin5)
.head 7 -  Break
.head 6 -  ! Архив Журнала событий
.head 6 +  Case 6
.head 7 +  If not IsWindow(hWin6)
.head 8 -  Set hWin6 = SalCreateWindow(tbl_SecAuditArch, hWndParent)
.head 7 +  Else
.head 8 -  Call SalBringWindowToTop(hWin6)
.head 7 -  Break
.head 6 +  Default
.head 7 -  Break
.head 5 -  Return TRUE
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
.head 3 +  Functional Class: cSecResources
.head 4 -  Description:
.head 4 -  Derived From
.head 4 -  Class Variables
.head 4 +  Instance Variables
.head 5 -  Number: nResId
.head 5 -  String: sResName
.head 5 -  String: sResCode
.head 5 -  String: sResList
.head 5 -  Number: nResParentId
.head 5 -  String: sResTabName
.head 5 -  String: sResColName
.head 5 -  String: sResAfterProc
.head 5 -  String: sResColPK
.head 5 -  String: sListPKVals
.head 5 -  String: sListPKNames
.head 5 -  String: sAddTabCondition
.head 4 -  Functions
.head 3 +  Functional Class: cSecResourcesList
.head 4 -  Description:
.head 4 -  Derived From
.head 4 -  Class Variables
.head 4 +  Instance Variables
.head 5 -  : cResourceList[*]
.head 6 -  Class: cSecResources
.head 5 -  Number: nResourceNum
.head 4 +  Functions
.head 5 +  Function: Init
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: i
.head 7 -  String: sColName
.head 7 -  String: sPK
.head 7 -  Number: nResId
.head 7 -  String: sResName
.head 7 -  String: sResCode
.head 7 -  String: sResList
.head 7 -  Number: nResParentId
.head 7 -  String: sResTabName
.head 7 -  String: sResColName
.head 7 -  String: sResAfterProc
.head 7 -  String: sResColPK
.head 7 -  String: sAddTabCondition
.head 6 +  Actions
.head 7 -  Set i = 0
.head 7 -  ! должны быть заполнены поля - по ним потом строятся select'ы
.head 7 +  If SqlPrepareAndExecute(hSql(),
"select res_id, res_name, res_code, res_list, res_parentid, res_tabname, res_usercol, res_afterproc, res_addtabcondition
   into :nResId, :sResName, :sResCode, :sResList, :nResParentId, :sResTabName, :sResColName, :sResAfterProc, :sAddTabCondition
   from sec_resources
  where res_approve = 'Y'
    and res_grntviewname is not null
    and res_accsviewname is not null
    and res_tabname is not null
    and res_usercol is not null
  order by res_id")
.head 8 +  While SqlFetchNext(hSql(), nFetchRes)
.head 9 -  Set cResourceList[i].nResId        = nResId
.head 9 -  Set cResourceList[i].sResName      = sResName
.head 9 -  Set cResourceList[i].sResCode      = sResCode
.head 9 -  Set cResourceList[i].sResList      = sResList
.head 9 -  Set cResourceList[i].nResParentId  = nResParentId
.head 9 -  Set cResourceList[i].sResTabName   = sResTabName
.head 9 -  Set cResourceList[i].sResColName   = sResTabName || "." || sResColName
.head 9 -  Set cResourceList[i].sResAfterProc = sResAfterProc
.head 9 -  Set cResourceList[i].sAddTabCondition = sAddTabCondition
.head 9 -  ! PK (Не userid и codeapp) в табл.-связке (напр., OPERAPP.CODEOPER)
.head 9 -  Set sPK = ""
.head 9 +  If SqlPrepareAndExecute(hSqlAux(),
"select c.colname
   into :sColName
   from sec_resources s, meta_tables t, meta_columns c
  where s.res_id = :nResId
    and s.res_tabname = t.tabname
    and t.tabid = c.tabid
    and c.showretval = 1
    and c.colname <> :sResColName")
.head 10 +  While SqlFetchNext(hSqlAux(), nFetchRes)
.head 11 -  Set sPK = IifS(sPK="", sColName, sPK || "||' '||" || sResTabName || "." || sColName)
.head 11 -  ! список значений PK p_pkcolvals (t_varchar2list) - (для АРМов - ('MAIN'), для отчетов НБУ - ('AA','1'), и т.д.)
.head 11 -  Set cResourceList[i].sListPKVals = IifS(cResourceList[i].sListPKVals="", "", cResourceList[i].sListPKVals || "||','||") || 
    "''''||"||sResTabName || "." || sColName||"||''''"
.head 11 -  ! список колонок PK p_pkcolnames (t_varchar2list) - (для АРМов - ('CODEOPER'), для отчетов НБУ - ('KODF','A017'), и т.д.)
.head 11 -  Set cResourceList[i].sListPKNames = IifS(cResourceList[i].sListPKNames="", "", cResourceList[i].sListPKNames || ",") || "'" || sColName || "'"
.head 9 -  Set cResourceList[i].sResColPK = sResTabName || "." || sPK
.head 9 -  Set i = i + 1
.head 7 -  Set nResourceNum = i
.head 7 -  Return TRUE
.head 3 +  Functional Class: cSecAttributes
.head 4 -  Description:
.head 4 -  Derived From
.head 4 -  Class Variables
.head 4 +  Instance Variables
.head 5 -  Number: nAttrId
.head 5 -  String: sAttrName
.head 5 -  String: sAttrCode
.head 5 -  String: sAttrTabName
.head 5 -  String: sAttrColName
.head 5 -  String: sAttrStorage
.head 5 -  String: sAttrType
.head 4 -  Functions
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
.head 3 -  Custom Control: cMeter
.head 2 -  Application Actions
.head 1 +  Table Window: tbl_Journal
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Журнал событий банковского комплекса
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Visible at Design time? No
.head 3 -  Automatically Created at Runtime? No
.head 3 -  Initial State: Normal
.head 3 -  Maximizable? Yes
.head 3 -  Minimizable? Yes
.head 3 -  System Menu? Yes
.head 3 -  Resizable? Yes
.head 3 -  Window Location and Size
.head 4 -  Left:   0.78"
.head 4 -  Top:    0.192"
.head 4 -  Width:  13.1"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 6.81"
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
.head 3 -  Maximum Rows in Memory: 32000
.head 3 -  Discardable? No
.head 2 -  Description: Форма просмотра журнала сообщений
.head 2 +  Named Menus
.head 3 +  Menu: menuSecurity
.head 4 -  Resource Id: 59186
.head 4 -  Title:
.head 4 -  Description:
.head 4 -  Enabled when:
.head 4 -  Status Text:
.head 4 -  Menu Item Name:
.head 4 +  Menu Item: &Пересканировать журнал
.head 5 -  Resource Id: 59187
.head 5 -  Keyboard Accelerator: Ctrl+R
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg( hWndForm, WM_Populate, 0, 0 )
.head 5 -  Menu Item Name:
.head 4 +  Menu Item: Пе&чать...
.head 5 -  Resource Id: 59188
.head 5 -  Keyboard Accelerator: Ctrl+P
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call PrintAuditJournal()
.head 5 -  Menu Item Name:
.head 4 -  Menu Separator
.head 4 +  Menu Item: &Искать...
.head 5 -  Resource Id: 59189
.head 5 -  Keyboard Accelerator: Ctrl+F
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call TblFindString( hWndForm, DFIND_First )
.head 5 -  Menu Item Name:
.head 4 +  Menu Item: Искать &следующий...
.head 5 -  Resource Id: 59190
.head 5 -  Keyboard Accelerator: Ctrl+G
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call TblFindString( hWndForm, DFIND_Again )
.head 5 -  Menu Item Name:
.head 4 +  Menu Item: &Фильтр...
.head 5 -  Resource Id: 59191
.head 5 -  Keyboard Accelerator: Ctrl+T
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 +  If SalModalDialog( dlg_input_value, hWndForm, sTimeLowBound, sTimeHiBound, strWhereAdd, bCB )
.head 7 -  Call SalPostMsg( hWndForm, WM_Populate, 0, 0 )
.head 5 -  Menu Item Name:
.head 4 -  Menu Separator
.head 4 +  Menu Item: &Очистить журнал (в архив)...
.head 5 -  Resource Id: 59192
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg( pbMoveToArchive, SAM_Click, 0, 0 )
.head 5 -  Menu Item Name:
.head 4 -  Menu Separator
.head 4 +  Menu Item: В&ыход
.head 5 -  Resource Id: 59193
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalDestroyWindow( hWndForm )
.head 5 -  Menu Item Name:
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.448"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Contents
.head 4 +  Data Field: dfFTime
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: 254
.head 6 -  Data Type: String
.head 6 -  Editable? No
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   5.75"
.head 7 -  Top:    0.135"
.head 7 -  Width:  5.0"
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
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: 3D Face Color
.head 6 -  Input Mask: Unformatted
.head 5 +  Message Actions
.head 6 +  On WM_Populate
.head 7 -  Set dfFTime = ''
.head 7 +  If bCB
.head 8 +  If sTimeLowBound != '' or sTimeHiBound != ''
.head 9 -  ! Set dfFTime = 'Сист. Время: ' || sTimeLowBound || '...' || sTimeHiBound
.head 9 -  Set dfFTime = CurrentLangTable.GetAtomTitle('tbl_Journal.cTFTime') || ': ' || sTimeLowBound || '...' || sTimeHiBound
.head 4 +  Pushbutton: pbRefresh
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbRefresh
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.086"
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
.head 7 -  ! Set pbRefresh.strTip = 'Перечитать'
.head 7 -  Set pbRefresh.strTip = CurrentLangTable.GetAtomTitle('tbl_Journal.cBTipRefresh')
.head 6 +  On SAM_Click
.head 7 -  Call SalPostMsg( hWndForm, WM_Populate, 0, 0)
.head 4 +  Pushbutton: pbMoveToArchive
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbUpdate
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.517"
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
.head 7 -  ! Передвинуть записи в архив
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('tbl_Journal.cBTipMoveToArchive')
.head 6 +  On SAM_Click
.head 7 +  If SalModalDialog(dlg_clear_journal, hWndForm, dtFrom, dtArch, nExpMode, bDelJournal)
.head 8 -  Call ClearAuditJournal(dtFrom, dtArch, nExpMode, bDelJournal)
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbPrint
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.95"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\print.bmp
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  ! Печать в файл
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('tbl_Journal.cBTipPrint')
.head 6 +  On SAM_Click
.head 7 -  Call PrintAuditJournal()
.head 4 -  Line
.head 5 -  Resource Id: 59194
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  1.486"
.head 6 -  Begin Y:  0.01"
.head 6 -  End X:  1.486"
.head 6 -  End Y:  0.438"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 +  Pushbutton: pbFilter
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbFilter
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.043"
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
.head 7 -  ! Set strTip = 'Фильтр'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('tbl_Journal.cBTipFilter')
.head 6 +  On SAM_Click
.head 7 +  If SetQueryFilter( cF )
.head 8 -  Call SalPostMsg( hWndForm, WM_Populate, 0, 0 )
.head 4 +  Pushbutton: pbSearch
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbSearch
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.483"
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
.head 7 -  ! Set strTip = 'Искать'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('tbl_Journal.cBTipSearch')
.head 6 +  On SAM_Click
.head 7 -  Call TblFindString( hWndForm, DFIND_First )
.head 4 -  Line
.head 5 -  Resource Id: 59195
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  3.457"
.head 6 -  Begin Y:  0.0"
.head 6 -  End X:  3.457"
.head 6 -  End Y:  0.458"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 +  Pushbutton: pbExit
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbCancel
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.571"
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
.head 7 -  ! Set strTip = 'Завершить работу'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('tbl_Journal.cBTipExit')
.head 6 +  On SAM_Click
.head 7 -  Call SalDestroyWindow( hWndForm )
.head 4 -  Line
.head 5 -  Resource Id: 59196
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  4.114"
.head 6 -  Begin Y:  0.0"
.head 6 -  End X:  4.114"
.head 6 -  End Y:  0.448"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 +  Pushbutton: pbDet
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbDetail
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.914"
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
.head 7 -  ! Set strTip = 'Просмотреть сообщения'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('tbl_Journal.cBTipDet')
.head 6 +  On SAM_Click
.head 7 +  If nKolRow
.head 8 -  Set nRow = SalTblQueryContext(tbl_Journal)
.head 8 -  Call SalModalDialog(dlg_edit_mess, hWndForm, 1, nRow, nKolRow)
.head 4 +  Pushbutton: pbFilterDat
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbRelation
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.614"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Clock.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  ! Set strTip = 'Фильтр по дате сообщения'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('tbl_Journal.cBTipFilterDat')
.head 6 +  On SAM_Click
.head 7 +  If SalModalDialog( dlg_input_value, hWndForm, sTimeLowBound, sTimeHiBound, strWhereAdd, bCB )
.head 8 -  Call SalPostMsg( hWndForm, WM_Populate, 0, 0 )
.head 4 +  Pushbutton: pbCheckLog
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbUpdate
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.283"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\summ.bmp
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  ! Set strTip = 'Проверить целостность файла протокола'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('tbl_Journal.cBTipCheckLog')
.head 6 +  On SAM_Click
.head 7 -  Set strFilesExt[0] = 'Журнал событий АБС'
.head 7 -  Set strFilesExt[1] = '*.log'
.head 7 -  Set nIndex = 1
.head 7 -  Set strFileName = ''
.head 7 -  Set strFileWPath = GetLogDir()
.head 7 -  ! If NOT SalDlgOpenFile( hWndForm, 'Проверка целостности журнала...', strFilesExt, 2, nIndex, strFileName, strFileWPath )
.head 7 +  If NOT SalDlgOpenFile( hWndForm, CurrentLangTable.GetAtomTitle('tbl_Journal.cTTitleOpenFile1'), strFilesExt, 2, nIndex, strFileName, strFileWPath )
.head 8 -  Return FALSE
.head 7 +  Else
.head 8 -  Set major_status = NG_CHECK_PROT( minor_status, 
strFileWPath )
.head 8 +  If major_status!=0
.head 9 -  ! Call MessageError( 'Порушено цілісність протоколу.'||PutCrLf()
||'Файл: '||strFileWPath||PutCrLf()
||'Функція NG_CHECK_PROT:'
.head 9 -  Call MessageError( CurrentLangTable.GetAtomTitle('tbl_Journal.cTErrProtokol1') || PutCrLf()
|| CurrentLangTable.GetAtomTitle('tbl_Journal.cTErrProtokol2') || ': ' || strFileWPath || PutCrLf()
|| CurrentLangTable.GetAtomTitle('tbl_Journal.cTErrProtokol3') || ' NG_CHECK_PROT:' || PutCrLf()
|| 'major_status=' || SalNumberToStrX( major_status, 0 ) || PutCrLf()
|| 'minor_status=' || SalNumberToStrX( minor_status, 0 ) || PutCrLf()
|| UNIMajorMessage(major_status) || PutCrLf()
|| UNIMinorMessage(minor_status)
)
.head 8 +  Else
.head 9 -  ! Call SalMessageBox( 'Цілісність протоколу'||PutCrLf()
||strFileWPath||PutCrLf()||'не порушено.',
 'Перевірка протоколу', MB_IconAsterisk|MB_Ok )
.head 9 -  Call SalMessageBox( CurrentLangTable.GetAtomTitle('tbl_Journal.cTMsgProtokol1') || PutCrLf()
|| strFileWPath || PutCrLf() || CurrentLangTable.GetAtomTitle('tbl_Journal.cTMsgProtokol2'),
  CurrentLangTable.GetAtomTitle('tbl_Journal.cTMsgProtokol'), MB_IconAsterisk|MB_Ok )
.head 2 +  Contents
.head 3 +  Column: colId
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ид.
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
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
.head 3 +  Column: colType
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Тип
события
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Right
.head 4 -  Width:  1.143"
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
.head 3 +  Column: colBDate
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Банковская
Дата
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Right
.head 4 -  Width:  1.257"
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
.head 3 +  Column: colDate
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Реальная
Дата
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Right
.head 4 -  Width:  1.243"
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
.head 3 +  Column: colTime
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Время
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Right
.head 4 -  Width:  0.914"
.head 4 -  Width Editable? Yes
.head 4 -  Format: hhh:mm:ss
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
.head 3 +  Column: colMessage
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сообщение
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 4000
.head 4 -  Data Type: Long String
.head 4 -  Justify: Class Default
.head 4 -  Width:  7.0"
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
.head 3 +  Column: colUid
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: UID
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
.head 3 +  Column: colULog
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenColComboBox_NumId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
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
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call colULog.Init( hWndItem )
.head 6 -  Call colULog.Populate( hSql(), 'ID', 'LOGNAME', 'STAFF', '')
.head 3 +  Column: colUName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenColComboBox_NumId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Пользователь
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
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call colUName.Init( hWndItem )
.head 6 -  Call colUName.Populate( hSql(), 'ID', 'FIO', 'STAFF', '')
.head 3 +  Column: colMachine
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Рабочая
станция
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Long String
.head 4 -  Justify: Left
.head 4 -  Width:  1.8"
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
.head 3 +  Column: colUserid
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ид.
пользователя БД
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
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
.head 3 +  Column: colUname
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Имя
пользователя БД
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
.head 3 +  Column: colUproxy
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Имя
proxy-пользователя
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
.head 3 +  Column: colModule
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Модуль
комплекса
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
.head 3 +  Column: colObject
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Создал
сообщение
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
.head 3 +  Function: PrintAuditJournal
.head 4 -  Description: Печатает журнал событий с текущей выборкой
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  ! cAuditFilterVarPool: Vp
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  File Handle: hArcFile
.head 5 -  String: strFilesExt[*]
.head 5 -  Number: nIndex
.head 5 -  String: strFileName
.head 5 -  String: strFileWPath
.head 5 -  !
.head 5 -  Date/Time: dBD
.head 5 -  Date/Time: dRD
.head 5 -  String: sMT
.head 5 -  String: sMU
.head 5 -  Long String: sMB
.head 5 -  String: sQ
.head 5 -  String: sMCH
.head 5 -  !
.head 5 -  String: sS
.head 4 +  Actions
.head 5 -  Set strFilesExt[0] = 'Журнал событий АБС'
.head 5 -  Set strFilesExt[1] = '*.cur'
.head 5 -  Set nIndex = 1
.head 5 -  Set strFileName = 'Cl' || SalFmtFormatDateTime(SalDateCurrent(), 'ddMMyy')
.head 5 -  Set strFileWPath = GetLogDir()
.head 5 -  ! Печать в файл...
.head 5 +  If NOT SalDlgSaveFile( hWndForm, CurrentLangTable.GetAtomTitle('tbl_Journal.cTTitleOpenFile2'), strFilesExt, 2, nIndex, strFileName, strFileWPath )
.head 6 -  Return FALSE
.head 5 -  !
.head 5 -  Call SalWaitCursor( TRUE )
.head 5 +  If SalFileOpen( hArcFile, strFileWPath, OF_Text | OF_Write | OF_Create )
.head 6 -  Call SalFilePutStr( hArcFile, StrWinToDosX( 'Выборка записей из журнала событий АБС'))
.head 6 -  Call SalFilePutStr( hArcFile, StrWinToDosX( 'Печать: ' ) || SalFmtFormatDateTime(SalDateCurrent(), 'dd/MM/yyyy hhh:mm:ss') )
.head 6 -  Call SalFilePutStr( hArcFile, StrWinToDosX( 'Детализация: ' || dfFTime ))
.head 6 -  Call SalFilePutStr( hArcFile, '' )
.head 6 -  Call SqlSetLongBindDatatype( 5, 22 )
.head 6 -  Set nRowT = TBL_MinRow
.head 6 +  Loop
.head 7 +  If SalTblFindNextRow( tbl_Journal, nRowT, 0, 0 )
.head 8 -  Call SalTblSetContext( tbl_Journal, nRowT )
.head 8 -  Set sS = 
SalFmtFormatDateTime(colBDate, 'dd-MMM-yy') || SalNumberToChar( 9 ) || 
SalFmtFormatDateTime(colDate, 'dd/MM/yy')   || SalNumberToChar( 9 ) || 
SalFmtFormatDateTime(colTime, 'hhh:mm:ss')  || SalNumberToChar( 9 ) || 
SalStrLeftX(SalStrTrimX(colType), 10)       || SalNumberToChar( 9 ) || 
SalStrTrimX( colUName )                     || SalNumberToChar( 9 ) || 
SalStrTrimX( colMachine )                   || SalNumberToChar( 9 ) || 
SalStrTrimX( colMessage )
.head 8 -  Call SalFilePutStr( hArcFile, StrWinToDosX( sS ) )
.head 7 +  Else
.head 8 -  Break
.head 6 -  Call SalFileClose( hArcFile )
.head 5 +  Else
.head 6 -  Call SalWaitCursor( FALSE )
.head 6 -  ! Неудача при открытии файла strFileWPath
.head 6 -  Call MessageError( CurrentLangTable.GetAtomTitle('tbl_Journal.cTMsgOpenFile') || ' ' || strFileWPath )
.head 6 -  Return FALSE
.head 5 -  Call SalWaitCursor( FALSE )
.head 5 -  ! Текст успешно сохранен в файле strFileWPath
.head 5 -  Call MessageInfo( CurrentLangTable.GetAtomTitle('tbl_Journal.cTMsgFileSave') || ' ' || strFileWPath )
.head 5 -  Return TRUE
.head 3 +  Function: ClearAuditJournal
.head 4 -  Description: Сворачивает журнал событий по текущую дату
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Date/Time: FromDate
.head 5 -  Date/Time: UpToDate
.head 5 -  Number: nExportMode
.head 5 -  Boolean: bDel
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  File Handle: hArcFile
.head 5 -  String: strFilesExt[*]
.head 5 -  Number: nIndex
.head 5 -  String: strFileName
.head 5 -  String: strFileWPath
.head 5 -  !
.head 5 -  Date/Time: dBD
.head 5 -  Date/Time: dRD
.head 5 -  String: sMT
.head 5 -  String: sMU
.head 5 -  Number: nMUID
.head 5 -  Long String: sMB
.head 5 -  String: sQ
.head 5 -  Long String: sMCH
.head 5 -  Number: nRecId
.head 5 -  Number: nRecUserId
.head 5 -  String: sRecUName
.head 5 -  String: sRecUProxy
.head 5 -  String: sRecModule
.head 5 -  String: sRecObject
.head 5 -  Long String: sRecStack
.head 5 -  !
.head 5 -  String: sS
.head 5 -  String: strRBSName
.head 5 -  !
.head 5 -  Number: nRecords
.head 5 -  Number: nRecNum
.head 5 -  Window Handle: hWndProgress
.head 5 -  Number: major_status
.head 5 -  Number: minor_status
.head 5 -  Boolean: isOk
.head 5 -  Number: nFileHash
.head 5 -  Number: nLength
.head 5 -  ! Контрольная сумма
.head 5 -  Number: nFileHashLength
.head 5 -  Number: pFileHash
.head 5 -  String: sFileHash
.head 4 +  Actions
.head 5 -  Set strFilesExt[0] = 'Журнал событий АБС'
.head 5 +  Select Case nExportMode
.head 6 +  Case SECEXP_TextSQL
.head 7 -  Set strFilesExt[1] = '*.sql'
.head 7 -  Break
.head 6 -  ! Case SECEXP_TextDelimiters
.head 6 +  Default
.head 7 -  Set strFilesExt[1] = '*.log'
.head 7 -  Break
.head 5 -  Set nIndex = 1
.head 5 -  Set strFileName = 'Au' || SalFmtFormatDateTime(UpToDate, 'ddMMyy')
.head 5 -  Set strFileWPath = GetLogDir()
.head 5 -  ! Сохранение записей журнала...
.head 5 +  If NOT SalDlgSaveFile(hWndForm, CurrentLangTable.GetAtomTitle('tbl_Journal.cTTitleOpenFile3'), strFilesExt, 2, nIndex, strFileName, strFileWPath)
.head 6 -  Return FALSE
.head 5 -  !
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 +  If UseGateway() and SECEXP_TextDelimiters=nExportMode
.head 6 -  Set major_status = NG_OPEN_PROT( minor_status, strFileWPath, nFileHash )
.head 6 +  If major_status!=0
.head 7 -  Set isOk = FALSE
.head 7 -  ! Ошибка вызова NG_OPEN_PROT:
.head 7 -  Call MessageError( CurrentLangTable.GetAtomTitle('tbl_Journal.cTErrCall') || ' NG_OPEN_PROT:' || PutCrLf()
|| 'major_status=' || SalNumberToStrX( major_status, 0 ) || PutCrLf()
|| 'minor_status=' || SalNumberToStrX( minor_status, 0 )
)
.head 6 +  Else
.head 7 -  Set isOk = TRUE
.head 5 +  Else
.head 6 -  Set isOk = SalFileOpen(hArcFile, strFileWPath, OF_Text | OF_Write | OF_Create)
.head 5 +  If isOk
.head 6 +  If NOT SqlPrepareAndExecute(cMisc.hSql(), T('SELECT count(*) INTO :nRecords FROM sec_audit WHERE rec_date <= :UpToDate'))
.head 7 -  Call SalWaitCursor( FALSE )
.head 7 -  Return FALSE
.head 6 -  Call SqlFetchNext( cMisc.hSql(), nFetchRes )
.head 6 -  Set nRecords = nRecords + 1
.head 6 -  !
.head 6 -  Set sQ = T(
"SELECT rec_bdate, rec_date, s.fio, rec_type, rec_message, machine, rec_uid, 
        rec_id, rec_userid, rec_uname, rec_uproxy, rec_module, rec_object, rec_stack 
   FROM Sec_Audit a, OUTER Staff s
   INTO :dBD, :dRD, :sMU, :sMT, :sMB, :sMCH, :nMUID, 
        :nRecId, :nRecUserId, :sRecUName, :sRecUProxy, :sRecModule, :sRecObject, :sRecStack
  WHERE s.id(+)=rec_uid AND rec_date<:UpToDate " ||
        IifS(bDel=FALSE, " and rec_date>=:FromDate", "") || "
  ORDER BY rec_id, rec_date, rec_bdate")
.head 6 +  If NOT SqlPrepare(cMisc.hSql(), sQ)
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Return FALSE
.head 6 -  Call SqlSetLongBindDatatype(5, 22)
.head 6 -  Call SqlSetLongBindDatatype(6, 22)
.head 6 -  Call SqlSetLongBindDatatype(14, 22)
.head 6 +  If NOT SqlExecute(cMisc.hSql())
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Return FALSE
.head 6 -  Set nRecNum = 0
.head 6 +  While SqlFetchNext(cMisc.hSql(), nFetchRes)
.head 7 +  If NOT hWndProgress
.head 8 -  ! Архивирование журнала событий...
.head 8 -  Set hWndProgress = SalCreateWindow( dlg_clear_progress, hWndForm, CurrentLangTable.GetAtomTitle('tbl_Journal.cTTitleDlg'), nRecords )
.head 7 +  Select Case nExportMode
.head 8 +  Case SECEXP_TextSQL
.head 9 -  Set sMU = SalNumberToStrX(nMUID, 0)
.head 9 +  If sMU = ''
.head 10 -  Set sMU = 'NULL'
.head 9 -  Set sS = 
"INSERT INTO SEC_AUDIT (rec_id, rec_bdate, rec_date, rec_uid, rec_type, machine, rec_message, " || 
  "rec_userid, rec_uname, rec_uproxy, rec_module, rec_object, rec_stack" || " ) " || PutCrLf() ||
"VALUES ("  || Str(nRecId) || ", " ||  
  "TO_DATE('" || SalFmtFormatDateTime(dBD, 'dd-MMM-yyyy')           || "', 'DD-MON-YYYY'), " || 
  "TO_DATE('" || SalFmtFormatDateTime(dRD, 'dd-MMM-yyyy hhh:mm:ss') || "', 'DD-MON-YYYY HH24:MI:SS'), " || PutCrLf() ||
  sMU || ", '" || SalStrTrimX(sMT) || "', '" || SalStrTrimX(sMCH) || "', " || PutCrLf() || 
  "'" || VisStrSubstitute(VisStrSubstitute(SalStrTrimX(sMB), "'", "''"), PutCrLf(), ' ') || "', " || PutCrLf() || 
  IifS(nRecUserId=NUMBER_Null, "NULL", Str(nRecUserId)) || ", " || 
  "'" || SalStrTrimX(sRecUName)  || "', " || 
  "'" || SalStrTrimX(sRecUProxy) || "', " || 
  "'" || SalStrTrimX(sRecModule) || "', " || 
  "'" || SalStrTrimX(sRecObject) || "', " || 
  "'" || VisStrSubstitute(VisStrSubstitute(SalStrTrimX(sRecStack), "'", "''"), PutCrLf(), ' ') || "');"
.head 9 -  Break
.head 8 -  ! Case SECEXP_TextDelimiters
.head 8 +  Default
.head 9 -  Set sS = 
Str(nRecId) || SalNumberToChar(9) ||
SalFmtFormatDateTime(dBD, 'dd-MMM-yy')          || SalNumberToChar(9) || 
SalFmtFormatDateTime(dRD, 'dd/MM/yy hhh:mm:ss') || SalNumberToChar(9) || 
SalStrLeftX(SalStrTrimX(sMT), 10)               || SalNumberToChar(9) || 
SalStrTrimX(sMU)                                || SalNumberToChar(9) || 
SalStrTrimX(sMCH)                               || SalNumberToChar(9) || 
VisStrSubstitute(SalStrTrimX(sMB), PutCrLf(), '') || SalNumberToChar(9) || 
Str(nRecUserId)         || SalNumberToChar(9) || 
SalStrTrimX(sRecUName)  || SalNumberToChar(9) || 
SalStrTrimX(sRecUProxy) || SalNumberToChar(9) || 
SalStrTrimX(sRecModule) || SalNumberToChar(9) || 
VisStrSubstitute(SalStrTrimX(sRecStack), PutCrLf(), '')
.head 9 -  Break
.head 7 +  If UseGateway() and SECEXP_TextDelimiters=nExportMode
.head 8 -  Set sS = sS || Chr(9)
.head 8 -  Set nLength = Len( sS )
.head 8 -  Set major_status = NG_KC_PROT( minor_status, nFileHash, nLength, sS )
.head 8 +  If major_status!=0
.head 9 -  ! Ошибка вызова NG_KC_PROT:
.head 9 -  Call MessageError( CurrentLangTable.GetAtomTitle('tbl_Journal.cTErrCall') || ' NG_KC_PROT:' || PutCrLf()
|| 'major_status=' || SalNumberToStrX( major_status, 0 ) || PutCrLf()
|| 'minor_status=' || SalNumberToStrX( minor_status, 0 )
)
.head 7 +  Else
.head 8 -  Call SalFilePutStr(hArcFile, sS)
.head 7 -  Set nRecNum = nRecNum + 1
.head 7 -  Call SalSendMsg( hWndProgress, UM_Update, 0, nRecNum )
.head 6 +  If nExportMode = SECEXP_TextSQL
.head 7 -  Call SalFilePutStr( hArcFile, "COMMIT;" )
.head 6 +  If UseGateway() and SECEXP_TextDelimiters=nExportMode
.head 7 -  Set major_status = NG_CLOSE_PROT( minor_status, nFileHash )
.head 7 +  If major_status!=0
.head 8 -  ! Ошибка вызова NG_CLOSE_PROT:
.head 8 -  Call MessageError( CurrentLangTable.GetAtomTitle('tbl_Journal.cTErrCall') || ' NG_CLOSE_PROT:' || PutCrLf()
|| 'major_status=' || SalNumberToStrX( major_status, 0 ) || PutCrLf()
|| 'minor_status=' || SalNumberToStrX( minor_status, 0 )
)
.head 6 +  Else
.head 7 -  Call SalFileClose( hArcFile )
.head 6 -  Set strRBSName = GetGlobalOption('RNBURBCK')
.head 6 +  If strRBSName
.head 7 -  ! Make end of transaction and start new
.head 7 -  Call SqlCommit( cMisc.hSql() )
.head 7 -  ! to avoid error with set transaction...
.head 7 -  Call SqlPrepareAndExecute(cMisc.hSql(), 'SET TRANSACTION USE ROLLBACK SEGMENT ' || SalStrUpperX( strRBSName ))
.head 6 +  If bDel
.head 7 +  If SqlPrepareAndExecute( cMisc.hSql(), T('DELETE FROM SEC_AUDIT WHERE rec_date < :UpToDate '))
.head 8 -  Call SqlCommit(cMisc.hSql())
.head 8 -  ! Удаление всех записей из оперативного журнала контроля выполнения банковских операций
.head 8 -  Call SaveInfoToLog("SECURITY. " || CurrentLangTable.GetAtomTitle('tbl_Journal.cTDelete') )
.head 7 +  Else
.head 8 -  Call SqlPrepareAndExecute( cMisc.hSql(), 'Rollback')
.head 8 -  Call SalWaitCursor( FALSE )
.head 8 -  Return FALSE
.head 6 -  ! Перемещение записей журнала аудита в файл strFileWPath
.head 6 -  Call SaveInfoToLog("SECURITY. " || CurrentLangTable.GetAtomTitle('tbl_Journal.cTToLog') || ' ' || strFileWPath )
.head 6 -  Set nRecNum = nRecNum + 1
.head 5 +  Else
.head 6 -  Call SalWaitCursor( FALSE )
.head 6 -  ! Неудача при открытии файла strFileWPath
.head 6 -  Call MessageError( CurrentLangTable.GetAtomTitle('tbl_Journal.cTMsgOpenFile') || ' ' || strFileWPath )
.head 6 -  Return FALSE
.head 5 +  If hWndProgress
.head 6 -  Call SalDestroyWindow( hWndProgress )
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  ! Текст успешно сохранен в файле strFileWPath
.head 5 -  Call MessageInfo(CurrentLangTable.GetAtomTitle('tbl_Journal.cTMsgFileSave') || ' ' || strFileWPath )
.head 5 -  !
.head 5 -  Return TRUE
.head 3 +  Function: UNIMajorMessage
.head 4 -  Description: возвращает описание ошибки ЭЦП UNI
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  Number: nErrorCode
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strMessage
.head 5 -  Number: nMsgSize
.head 5 -  Number: nBufAddress
.head 5 -  Number: message_context
.head 5 -  Number: min_status
.head 5 -  Number: maj_status
.head 4 +  Actions
.head 5 -  Call SalStrSetBufferLength( strMessage, 4096 )
.head 5 -  Set message_context = 0
.head 5 -  Set maj_status = gss_display_status(
	min_status,
	nErrorCode,
	1, 0,
	message_context,
	nMsgSize, nBufAddress
)
.head 5 -  Call memmove( strMessage, NumPtr2Str( nBufAddress ), nMsgSize )
.head 5 -  Set strMessage = Left(strMessage,nMsgSize) || Chr(0)
.head 5 -  Call gss_release_buffer( min_status, nMsgSize, nBufAddress )
.head 5 -  Return strMessage
.head 3 +  Function: UNIMinorMessage
.head 4 -  Description: возвращает описание ошибки ЭЦП UNI
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  Number: nErrorCode
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strMessage
.head 5 -  Number: nMsgSize
.head 5 -  Number: nBufAddress
.head 5 -  Number: message_context
.head 5 -  Number: min_status
.head 5 -  Number: maj_status
.head 4 +  Actions
.head 5 -  Call SalStrSetBufferLength( strMessage, 4096 )
.head 5 -  Set message_context = 0
.head 5 -  Set maj_status = gss_display_status(
	min_status,
	nErrorCode,
	2, 0,
	message_context,
	nMsgSize, nBufAddress
)
.head 5 -  Call memmove( strMessage, NumPtr2Str( nBufAddress ), nMsgSize )
.head 5 -  Set strMessage = Left(strMessage,nMsgSize) || Chr(0)
.head 5 -  Call gss_release_buffer( min_status, nMsgSize, nBufAddress )
.head 5 -  Return strMessage
.head 2 +  Window Parameters
.head 3 -  Boolean: bEdited
.head 2 +  Window Variables
.head 3 -  String: strSql
.head 3 -  String: strWhereAdd
.head 3 -  Number: nCtlState
.head 3 -  Number: nAltState
.head 3 -  : cTSec
.head 4 -  Class: cABSConnect
.head 3 -  : cMisc
.head 4 -  Class: cABSConnect
.head 3 -  !
.head 3 -  Number: nSColId
.head 3 -  String: sSColVal
.head 3 -  Long String: strTmpMessage
.head 3 -  !
.head 3 -  : cSecMenu
.head 4 -  Class: cChildMenuEngine
.head 3 -  Date/Time: dtFrom
.head 3 -  Date/Time: dtArch
.head 3 -  Number: nExpMode
.head 3 -  Boolean: bDelJournal
.head 3 -  Boolean: bSortOrd
.head 3 -  !
.head 3 -  Number: nRow
.head 3 -  Number: nKolRow
.head 3 -  Number: nJrnSize
.head 3 -  !
.head 3 -  : cF
.head 4 -  Class: cGenFilter
.head 3 -  : cQ
.head 4 -  Class: cGenQuery
.head 3 -  String: strFilterT
.head 3 -  Number: nRowT
.head 3 -  !
.head 3 -  String: sTimeLowBound		! Нижняя граница временного интервала
.head 3 -  String: sTimeHiBound		! Верхняя граница временного интервала
.head 3 -  Boolean: bCB
.head 3 -  String: strFilesExt[*]
.head 3 -  Number: nIndex
.head 3 -  String: strFileName
.head 3 -  String: strFileWPath
.head 3 -  Number: major_status
.head 3 -  Number: minor_status
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call XConnectGetParams(cTSec)
.head 4 +  If NOT cTSec.Connect()
.head 5 -  Return FALSE
.head 4 -  Call cMisc.Clone(cTSec, TRUE)
.head 4 -  !
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('tbl_Journal.cTWndTitle'))
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  Call cSecMenu.Init(hWndForm, 'menuSecurity', CurrentLangTable.GetAtomTitle('tbl_Journal.cTWndTitle'))
.head 4 -  Call XSalTooltipSetUserDefault()
.head 4 -  !
.head 4 -  Call SalTblSetColumnTitle(tbl_Journal.colUName, CurrentLangTable.GetAtomTitle('tbl_Journal.colUName'))
.head 4 -  Call SalTblSetTableFlags(hWndForm, TBL_Flag_SelectableCols, TRUE)
.head 4 -  Call SalTblSetLockedColumns(hWndForm, 2)
.head 4 -  !
.head 4 +  If not bEdited
.head 5 -  Call SalDisableWindow(pbMoveToArchive)
.head 4 -  !
.head 4 -  Set nSColId = 1
.head 4 -  Set sSColVal = ''
.head 4 -  !
.head 4 -  Set strFilterT = 'SEC_AUDIT'
.head 4 -  Call cF.Init(strFilterT, strFilterT)
.head 4 -  Call cF.NewString('', -1, 'REC_DATE', -1, 'SEC_AUDIT', '=', '@TRUNC(SYSDATE)', 'Сегодняшние записи...')
.head 4 -  !
.head 4 -  Set sTimeLowBound = ''
.head 4 -  Set sTimeHiBound = ''
.head 4 -  Set bCB = FALSE
.head 4 -  Set nExpMode = SECEXP_TextDelimiters
.head 4 +  If not UseGateway()
.head 5 -  Call SalHideWindow(pbCheckLog)
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalWaitCursor(FALSE)
.head 4 -  Call SalSendMsg(pbFilter, SAM_Click, 0, 0)
.head 3 +  On SAM_Activate
.head 4 -  Call cSecMenu.Enable(wParam)
.head 3 +  On WM_Populate
.head 4 -  Call WaitCursorOn()
.head 4 -  Set nKolRow = 0
.head 4 -  Call SalSendMsg(dfFTime, WM_Populate, 0, 0)
.head 4 -  Set strSql = T(
"SELECT rec_id, rec_uid, rec_uname, rec_uproxy, rec_date, rec_date, rec_bdate, 
        rec_type, rec_module, rec_message, machine, rec_object, rec_userid 
   INTO :colId, :colUid, :colUname, :colUproxy, :colDate, :colTime, :colBDate, 
        :colType, :colModule, :strTmpMessage, :colMachine, :colObject, :colUserid 
   FROM Sec_Audit " || IifS( strWhereAdd != '', " WHERE " || strWhereAdd, "" ) || " 
  ORDER BY rec_id desc ")
.head 4 -  Call cQ.Init(strSql)
.head 4 -  Set strSql = cQ.GetFullSQLString(cF)
.head 4 -  Set strTmpMessage = SalStrRepeatX(' ', 4096)
.head 4 -  Call SqlSetLongBindDatatype(10, 22)
.head 4 -  Call SalTblPopulate(hWndForm, cTSec.hSql(), T(strSql), TBL_FillAll)
.head 4 -  Call WaitCursorOff()
.head 3 +  On SAM_FetchRowDone
.head 4 +  If colType = DBSpy_Error OR colType = DBSpy_FinError OR colType = DBSpy_SecError
.head 5 -  Call SalTblSetCellTextColor(colType, COLOR_Red, TRUE)
.head 4 +  Else If colType = DBSpy_FinInfo
.head 5 -  Call SalTblSetCellTextColor(colType, COLOR_Magenta, TRUE)
.head 4 +  Else If colType = DBSpy_Security
.head 5 -  Call SalTblSetCellTextColor(colType, COLOR_Periwinkle, TRUE)
.head 4 -  Set colMessage = strTmpMessage
.head 4 -  !
.head 4 -  Call colUName.SetCurrentKey(colUid)
.head 4 -  Set colUName = colUName.GetNameById(colUName.GetCurrentKey())
.head 4 -  !
.head 4 -  Call colULog.SetCurrentKey(colUid)
.head 4 -  Set colULog = colULog.GetNameById(colULog.GetCurrentKey())
.head 4 -  Set nKolRow = nKolRow + 1
.head 3 +  On VTM_KeyDown
.head 4 -  Set nCtlState = VisGetKeyState(VK_Control) 
.head 4 -  Set nAltState = VisGetKeyState(VK_Alt) 
.head 4 +  Select Case wParam
.head 5 +  Case VK_F	! Search Init
.head 6 +  If nCtlState & KS_Down
.head 7 -  Call TblFindString(hWndForm, DFIND_First)
.head 6 -  Break
.head 5 +  Case VK_G	! Search Again
.head 6 +  If nCtlState & KS_Down
.head 7 -  Call TblFindString(hWndForm, DFIND_Again)
.head 6 -  Break
.head 5 +  Case VK_P	! Print
.head 6 +  If nCtlState & KS_Down
.head 7 -  Call PrintAuditJournal()
.head 6 -  Break
.head 5 +  Case VK_R	! Rescan
.head 6 +  If nCtlState & KS_Down
.head 7 -  Call SalPostMsg(hWndForm, WM_Populate, 0, 0)
.head 6 -  Break
.head 5 +  Case VK_T	! Get Filter Mask
.head 6 +  If nCtlState & KS_Down
.head 7 +  If SalModalDialog(dlg_input_value, hWndForm, sTimeLowBound, sTimeHiBound, strWhereAdd,bCB)
.head 8 -  Call SalPostMsg(hWndForm, WM_Populate, 0, 0)
.head 6 -  Break
.head 5 +  Default
.head 6 -  Break
.head 3 +  On UM_MenuComponentShow
.head 4 -  Call cSecMenu.ShowMenu(wParam, lParam)
.head 3 +  On SAM_Destroy
.head 4 -  Set hWinJournal = hWndNULL
.head 4 -  Call cSecMenu.Kill()
.head 4 +  If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
.head 5 -  Call XRoleUnset(cMisc.hSql(), 'ShowSecurity()')
.head 4 -  Call SalSetFocus(SalParentWindow(hWndForm))
.head 3 +  On SAM_DoubleClick
.head 4 -  Call SalSendMsg(pbDet, SAM_Click, 0, 0)
.head 3 +  On SAM_ColumnSelectClick
.head 4 -  Call SalTblSetColumnFlags(SalNumberToWindowHandle(wParam), COL_Selected, FALSE)
.head 4 -  Set bSortOrd = not bSortOrd
.head 4 -  Call SalTblSortRows(hWndForm, SalTblQueryColumnID(SalNumberToWindowHandle(wParam)), bSortOrd)
.head 1 +  Dialog Box: dlg_edit_mess
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Просмотр сообщений
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  8.657"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 4.531"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Форма просмотра сообщений
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
.head 3 -  Background Text: Банковская дата:
.head 4 -  Resource Id: 18675
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.171"
.head 5 -  Top:    0.125"
.head 5 -  Width:  2.214"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgBD
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
.head 3 +  Data Field: dfBD
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
.head 6 -  Left:   2.5"
.head 6 -  Top:    0.107"
.head 6 -  Width:  1.614"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.292"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Date
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Highlight Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Реальная дата:
.head 4 -  Resource Id: 18676
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.171"
.head 5 -  Top:    0.427"
.head 5 -  Width:  2.214"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgRD
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
.head 3 +  Data Field: dfRD
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
.head 6 -  Left:   2.5"
.head 6 -  Top:    0.405"
.head 6 -  Width:  1.614"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.292"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Date
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Highlight Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfTime
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
.head 6 -  Left:   4.129"
.head 6 -  Top:    0.405"
.head 6 -  Width:  1.429"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.292"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: hhh:mm:ss
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Highlight Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Тип сообщения:
.head 4 -  Resource Id: 18677
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.167"
.head 5 -  Top:    0.729"
.head 5 -  Width:  2.214"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgType
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
.head 3 +  Data Field: dfType
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
.head 6 -  Left:   2.5"
.head 6 -  Top:    0.702"
.head 6 -  Width:  3.057"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.292"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Highlight Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Пользователь:
.head 4 -  Resource Id: 18678
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.167"
.head 5 -  Top:    1.031"
.head 5 -  Width:  2.214"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgUser
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
.head 3 +  Data Field: dfUser
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
.head 6 -  Left:   2.5"
.head 6 -  Top:    1.012"
.head 6 -  Width:  0.857"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.292"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Highlight Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfLog
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
.head 6 -  Left:   3.371"
.head 6 -  Top:    1.012"
.head 6 -  Width:  1.471"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.292"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Highlight Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfFio
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
.head 6 -  Left:   4.857"
.head 6 -  Top:    1.012"
.head 6 -  Width:  3.557"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.292"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Highlight Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Рабочая станция:
.head 4 -  Resource Id: 18679
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.167"
.head 5 -  Top:    1.333"
.head 5 -  Width:  2.214"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgMach
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
.head 3 +  Data Field: dfMach
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
.head 6 -  Left:   2.5"
.head 6 -  Top:    1.31"
.head 6 -  Width:  3.057"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.292"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Highlight Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Multiline Field: mlText
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
.head 5 -  Border? Yes
.head 5 -  Word Wrap? Yes
.head 5 -  Vertical Scroll? Yes
.head 5 -  Window Location and Size
.head 6 -  Left:   0.171"
.head 6 -  Top:    1.708"
.head 6 -  Width:  8.243"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 1.729"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Highlight Color
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbBack
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.171"
.head 5 -  Top:    3.615"
.head 5 -  Width:  1.3"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.396"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Prevrec.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call ChangeFocusRow( nR, nR - 1 )
.head 5 +  On SAM_TooltipSetText
.head 6 -  ! Return XSalTooltipSetText( lParam, 'Предыдущая запись' )
.head 6 -  Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('dlg_edit_mess.cBTipBack') )
.head 3 +  Pushbutton: pbForw
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.471"
.head 5 -  Top:    3.615"
.head 5 -  Width:  1.3"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.396"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Nextrec.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call ChangeFocusRow( nR, nR + 1 )
.head 5 +  On SAM_TooltipSetText
.head 6 -  ! Return XSalTooltipSetText( lParam, 'Следующая запись' )
.head 6 -  Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('dlg_edit_mess.cBTipForw') )
.head 3 +  Pushbutton: pbBegin
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.771"
.head 5 -  Top:    3.615"
.head 5 -  Width:  1.3"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.396"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Rwnd.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call ChangeFocusRow( nR, 0 )
.head 5 +  On SAM_TooltipSetText
.head 6 -  ! Return XSalTooltipSetText( lParam, 'В начало журнала' )
.head 6 -  Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('dlg_edit_mess.cBTipBegin') )
.head 3 +  Pushbutton: pbEnd
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.071"
.head 5 -  Top:    3.615"
.head 5 -  Width:  1.3"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.396"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Ffwd.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call ChangeFocusRow( nR, nKolRow - 1 )
.head 5 +  On SAM_TooltipSetText
.head 6 -  ! Return XSalTooltipSetText( lParam, 'В конец журнала' )
.head 6 -  Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('dlg_edit_mess.cBTipEnd') )
.head 3 +  Pushbutton: pbClose
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   7.114"
.head 5 -  Top:    3.615"
.head 5 -  Width:  1.3"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.4"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Discard.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog( hWndForm, 0 )
.head 5 +  On SAM_TooltipSetText
.head 6 -  ! Return XSalTooltipSetText( lParam, 'Закрыть окно' )
.head 6 -  Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('dlg_edit_mess.cBTipClose') )
.head 2 +  Functions
.head 3 +  Function: ChangeFocusRow
.head 4 -  Description: Меняем текущую строку журнала.
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nCurrRowNum
.head 5 -  Number: nNextRowNum
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SalTblSetRowFlags(hWndParent, nCurrRowNum, ROW_Selected, FALSE)
.head 5 +  If nNextRowNum < 0
.head 6 -  Set nNextRowNum = 0
.head 5 +  If nNextRowNum >= nKolRow
.head 6 -  Set nNextRowNum = nKolRow - 1
.head 5 -  Call SalTblSetContext (hWndParent, nNextRowNum)
.head 5 -  Call SalTblSetFocusRow(hWndParent, nNextRowNum)
.head 5 -  Call SalTblSetRowFlags(hWndParent, nNextRowNum, ROW_Selected, TRUE)
.head 5 -  Call SalSendMsg(hWndForm, WM_Populate, 0, 0)
.head 5 +  If nNextRowNum = 0
.head 6 -  Call SalDisableWindow( pbBack )
.head 6 -  Call SalDisableWindow( pbBegin )
.head 6 -  Call SalEnableWindow ( pbForw )
.head 6 -  Call SalEnableWindow ( pbEnd )
.head 5 +  Else If nNextRowNum = nKolRow - 1
.head 6 -  Call SalEnableWindow ( pbBack )
.head 6 -  Call SalEnableWindow ( pbBegin )
.head 6 -  Call SalDisableWindow( pbForw )
.head 6 -  Call SalDisableWindow( pbEnd )
.head 5 +  Else
.head 6 -  Call SalEnableWindow( pbBack )
.head 6 -  Call SalEnableWindow( pbBegin )
.head 6 -  Call SalEnableWindow( pbForw )
.head 6 -  Call SalEnableWindow( pbEnd )
.head 5 -  Set nR = nNextRowNum
.head 5 -  Return TRUE
.head 2 +  Window Parameters
.head 3 -  Number: nMode
.head 3 -  Number: nRow
.head 3 -  Number: nKolRow
.head 2 +  Window Variables
.head 3 -  Number: nR
.head 3 -  Boolean: bIsBegin
.head 3 -  Boolean: bIsEnd
.head 3 -  String: sLog
.head 3 -  Window Handle: hWndParent
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 -  Call SetWindowFont(hWndForm)
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('dlg_edit_mess.cTWndTitle'))
.head 4 -  Set hWndParent = SalParentWindow(hWndForm)
.head 3 +  On SAM_CreateComplete
.head 4 -  Set nR = nRow
.head 4 +  If nR  = 0
.head 5 -  Call SalDisableWindow(pbBack)
.head 5 -  Call SalDisableWindow(pbBegin)
.head 5 -  Set bIsBegin=TRUE
.head 4 +  If nR  = nKolRow - 1
.head 5 -  Call SalDisableWindow(pbForw)
.head 5 -  Call SalDisableWindow(pbEnd)
.head 5 -  Set bIsEnd=TRUE
.head 4 -  Call SalSendMsg(hWndForm, WM_Populate, 0, 0)
.head 3 +  ! On WM_Populate
.head 4 -     Set dfBD   = tbl_Journal.colBDate
.head 4 -     Set dfRD   = tbl_Journal.colDate
.head 4 -     Set dfTime = tbl_Journal.colTime
.head 4 -     Set dfType = tbl_Journal.colType
.head 4 -     Set dfUser = tbl_Journal.colUid
.head 4 -     Set dfLog  = tbl_Journal.colULog
.head 4 -     Set dfFio  = tbl_Journal.colUName
.head 4 -     Set dfMach = tbl_Journal.colMachine
.head 4 -     Set mlText = tbl_Journal.colMessage
.head 3 +  On WM_Populate
.head 4 +  If nMode = 1
.head 5 -  Set dfBD   = hWndParent.tbl_Journal.colBDate
.head 5 -  Set dfRD   = hWndParent.tbl_Journal.colDate
.head 5 -  Set dfTime = hWndParent.tbl_Journal.colTime
.head 5 -  Set dfType = hWndParent.tbl_Journal.colType
.head 5 -  Set dfUser = hWndParent.tbl_Journal.colUid
.head 5 -  Set dfLog  = hWndParent.tbl_Journal.colULog
.head 5 -  Set dfFio  = hWndParent.tbl_Journal.colUName
.head 5 -  Set dfMach = hWndParent.tbl_Journal.colMachine
.head 5 -  Set mlText = hWndParent.tbl_Journal.colMessage
.head 4 +  Else
.head 5 -  Set dfBD   = hWndParent.tbl_SecAuditArch.colBDate
.head 5 -  Set dfRD   = hWndParent.tbl_SecAuditArch.colDate
.head 5 -  Set dfTime = hWndParent.tbl_SecAuditArch.colDate
.head 5 -  Set dfType = hWndParent.tbl_SecAuditArch.colType
.head 5 -  Set dfUser = hWndParent.tbl_SecAuditArch.colUid
.head 5 -  Set dfLog  = hWndParent.tbl_SecAuditArch.colUName
.head 5 -  ! Set dfFio  = hWndParent.tbl_SecAuditArch.colUName
.head 5 -  Set dfMach = hWndParent.tbl_SecAuditArch.colMachine
.head 5 -  Set mlText = hWndParent.tbl_SecAuditArch.colMessage
.head 1 +  Dialog Box: dlg_input_value
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Укажите параметры фильтра...
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? No
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   1.538"
.head 4 -  Top:    0.938"
.head 4 -  Width:  6.0"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 2.2"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: MS Sans Serif
.head 3 -  Font Size: 8
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Назначить параметры фильтра
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
.head 3 +  Check Box: cbUseFTime
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cCheckBoxLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Временной интервал:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.371"
.head 5 -  Top:    0.208"
.head 5 -  Width:  2.529"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call EnableWindow( dfStartTime, cbUseFTime )
.head 6 -  Call EnableWindow( dfFinishTime, cbUseFTime )
.head 3 +  Data Field: dfStartTime
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
.head 6 -  Left:   3.229"
.head 6 -  Top:    0.208"
.head 6 -  Width:  0.829"
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
.head 5 -  Input Mask: 99:99
.head 4 -  Message Actions
.head 3 -  Background Text: --
.head 4 -  Resource Id: 59197
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.143"
.head 5 -  Top:    0.25"
.head 5 -  Width:  0.357"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Center
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfFinishTime
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
.head 6 -  Left:   4.6"
.head 6 -  Top:    0.208"
.head 6 -  Width:  0.829"
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
.head 5 -  Input Mask: 99:99
.head 4 -  Message Actions
.head 3 -  !
.head 3 +  Pushbutton: pbExecute
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Утвердить
.head 4 -  Window Location and Size
.head 5 -  Left:   0.729"
.head 5 -  Top:    1.208"
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
.head 6 -  Set sWhere = ''
.head 6 -  Set sTimeLowBound = dfStartTime
.head 6 -  Set sTimeHiBound = dfFinishTime
.head 6 +  If cbUseFTime
.head 7 +  If SalStrUpperX( SalStrTrimX( GetDBMS(  ))) = 'ORACLE'
.head 8 +  If sTimeLowBound != ''
.head 9 -  Set sWhere = sWhere || " TO_CHAR(rec_date, 'HH24:MI') >= '" || sTimeLowBound || "'"
.head 8 +  If sTimeHiBound != ''
.head 9 +  If sTimeLowBound != ''
.head 10 -  Set sWhere = sWhere || ' AND '
.head 9 -  Set sWhere = sWhere || " TO_CHAR(rec_date, 'HH24:MI') <= '" || sTimeHiBound || "'"
.head 7 +  Else
.head 8 +  If sTimeLowBound != ''
.head 9 -  Set sWhere = sWhere || ' EXTEND(rec_date, hour to minute) >= \'' || sTimeLowBound || '\''
.head 8 +  If sTimeHiBound != ''
.head 9 +  If sTimeLowBound != ''
.head 10 -  Set sWhere = sWhere || ' AND '
.head 9 -  Set sWhere = sWhere || ' EXTEND(rec_date, hour to minute) <= \'' || sTimeHiBound || '\''
.head 6 -  Set strWhereAdd = sWhere
.head 6 -  Call SalEndDialog( hWndForm, 1)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отменить
.head 4 -  Window Location and Size
.head 5 -  Left:   3.743"
.head 5 -  Top:    1.208"
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
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog( hWndForm, 0 )
.head 3 -  Frame
.head 4 -  Resource Id: 59198
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.057"
.head 5 -  Top:    0.042"
.head 5 -  Width:  5.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.0"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: Default
.head 3 -  Frame
.head 4 -  Resource Id: 59199
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.057"
.head 5 -  Top:    1.094"
.head 5 -  Width:  5.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.7"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: Default
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Receive String: sTimeLowBound		! Нижняя граница временного интервала
.head 3 -  Receive String: sTimeHiBound		! Верхняя граница временного интервала
.head 3 -  Receive String: strWhereAdd
.head 3 -  Receive Boolean: bCB
.head 2 +  Window Variables
.head 3 -  String: sWhere
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow( hWndForm )
.head 4 -  Call SetWindowFont( hWndForm )
.head 4 -  Call SalSendMsgToChildren( hWndForm, UM_QueryLabelText, 0, 0 )
.head 4 -  Call SalSetWindowText( hWndForm, CurrentLangTable.GetAtomTitle('dlg_input_value.cTWndTitle') )
.head 4 -  Call SalFmtKeepMask( TRUE )
.head 3 +  On SAM_CreateComplete
.head 4 -  Set dfStartTime = sTimeLowBound
.head 4 -  Set dfFinishTime = sTimeHiBound
.head 4 +  If bCB
.head 5 -  Set cbUseFTime = TRUE 
.head 5 -  Call EnableWindow( dfStartTime, TRUE )
.head 5 -  Call EnableWindow( dfFinishTime, TRUE )
.head 4 +  Else
.head 5 -  Set cbUseFTime = FALSE 
.head 5 -  Call EnableWindow( dfStartTime, FALSE )
.head 5 -  Call EnableWindow( dfFinishTime, FALSE )
.head 3 +  On SAM_Destroy
.head 4 -  Call SalFmtKeepMask( FALSE )
.head 4 -  Set bCB = cbUseFTime
.head 1 +  Dialog Box: dlg_clear_journal
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Сохранение журнала в архив...
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  6.5"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 3.25"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Запрос на очистку журнала 
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
.head 3 -  Background Text: Сохранить журнал аудита в архив (файл) по указанную дату?
.head 4 -  Resource Id: 4603
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.15"
.head 5 -  Width:  6.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Center
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgClear
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
.head 3 -  Background Text: Дата архивации:
.head 4 -  Resource Id: 4604
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.3"
.head 5 -  Top:    0.45"
.head 5 -  Width:  1.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Royal Blue
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgArchDate
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
.head 3 +  Data Field: dfArchDate
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
.head 6 -  Left:   3.2"
.head 6 -  Top:    0.4"
.head 6 -  Width:  1.517"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Date
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set MyValue = SalDateCurrent()
.head 3 -  Background Text: С даты:
.head 4 -  Resource Id: 12263
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.45"
.head 5 -  Width:  1.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Royal Blue
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgDateFrom
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
.head 3 +  Data Field: dfDateFrom
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
.head 6 -  Top:    0.4"
.head 6 -  Width:  1.517"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? No
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Date
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set MyValue = SalDateCurrent()
.head 3 -  Background Text: По дату:
.head 4 -  Resource Id: 12264
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.85"
.head 5 -  Top:    0.45"
.head 5 -  Width:  1.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Royal Blue
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgDateTo
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
.head 3 +  Data Field: dfDateTo
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
.head 6 -  Left:   4.75"
.head 6 -  Top:    0.4"
.head 6 -  Width:  1.517"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? No
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Date
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set MyValue = SalDateCurrent()
.head 3 -  Frame
.head 4 -  Resource Id: 40370
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.75"
.head 5 -  Width:  6.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.7"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: Default
.head 3 +  Radio Button: rbTxtDelim
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cRadioButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Экспорт в файл с разделителями (TAB)
.head 4 -  Window Location and Size
.head 5 -  Left:   0.4"
.head 5 -  Top:    0.8"
.head 5 -  Width:  5.0"
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
.head 3 +  Radio Button: rbSQL
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cRadioButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Экспорт в виде SQL 
.head 4 -  Window Location and Size
.head 5 -  Left:   0.4"
.head 5 -  Top:    1.1"
.head 5 -  Width:  5.0"
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
.head 3 -  Frame
.head 4 -  Resource Id: 12261
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    1.5"
.head 5 -  Width:  6.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.7"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: Default
.head 3 +  Radio Button: rbJournalDel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cRadioButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: С удалением записей из журнала
.head 4 -  Window Location and Size
.head 5 -  Left:   0.4"
.head 5 -  Top:    1.55"
.head 5 -  Width:  5.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalHideWindowAndLabel(bgDateFrom)
.head 6 -  Call SalHideWindow(dfDateFrom)
.head 6 -  Call SalHideWindowAndLabel(bgDateTo)
.head 6 -  Call SalHideWindow(dfDateTo)
.head 6 -  Call SalShowWindowAndLabel(bgArchDate)
.head 6 -  Call SalShowWindow(dfArchDate)
.head 3 +  Radio Button: rbJournalNoDel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cRadioButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Без удаления записей из журнала
.head 4 -  Window Location and Size
.head 5 -  Left:   0.4"
.head 5 -  Top:    1.85"
.head 5 -  Width:  5.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalShowWindowAndLabel(bgDateFrom)
.head 6 -  Call SalShowWindow(dfDateFrom)
.head 6 -  Call SalShowWindowAndLabel(bgDateTo)
.head 6 -  Call SalShowWindow(dfDateTo)
.head 6 -  Call SalHideWindowAndLabel(bgArchDate)
.head 6 -  Call SalHideWindow(dfArchDate)
.head 3 -  !
.head 3 +  Pushbutton: pbOk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Архивировать
.head 4 -  Window Location and Size
.head 5 -  Left:   1.0"
.head 5 -  Top:    2.35"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
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
.head 6 -  Set dtFromDate = dfDateFrom
.head 6 -  Set dtDate     = IifD(rbJournalDel=TRUE, dfArchDate, dfDateTo)
.head 6 +  If rbSQL
.head 7 -  Set nExpMode = SECEXP_TextSQL
.head 6 +  Else
.head 7 -  Set nExpMode = SECEXP_TextDelimiters
.head 6 -  Set bDeleteJournal = rbJournalDel
.head 6 -  Call SalEndDialog(hWndForm, 1)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отменить
.head 4 -  Window Location and Size
.head 5 -  Left:   3.9"
.head 5 -  Top:    2.35"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
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
.head 6 -  Call SalEndDialog( hWndForm, 0 )
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Receive Date/Time: dtFromDate
.head 3 -  Receive Date/Time: dtDate
.head 3 -  Receive Number: nExpMode
.head 3 -  Receive Boolean: bDeleteJournal
.head 2 -  Window Variables
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow( hWndForm )
.head 4 -  Call SetWindowFont( hWndForm )
.head 4 -  Call SalSendMsgToChildren( hWndForm, UM_QueryLabelText, 0, 0 )
.head 4 -  Call SalSetWindowText( hWndForm, CurrentLangTable.GetAtomTitle('dlg_clear_journal.cTWndTitle') )
.head 4 +  Select Case nExpMode
.head 5 +  Case SECEXP_TextDelimiters
.head 6 -  Set rbTxtDelim = TRUE
.head 6 -  Break
.head 5 +  Case SECEXP_TextSQL
.head 6 -  Set rbSQL = TRUE
.head 6 -  Break
.head 5 +  Default
.head 6 -  Set rbTxtDelim = TRUE
.head 6 -  Break
.head 1 +  Form Window: dlg_clear_progress
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
.head 3 -  Automatically Created at Runtime? No
.head 3 -  Initial State: Normal
.head 3 -  Maximizable? Yes
.head 3 -  Minimizable? Yes
.head 3 -  System Menu? Yes
.head 3 -  Resizable? Yes
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  6.967"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 1.167"
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
.head 2 -  Description: Визуализирует процесс очистки журнала ацдита
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
.head 3 +  Custom Control: cc1
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
.head 6 -  Left:   0.317"
.head 6 -  Top:    0.202"
.head 6 -  Width:  6.1"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.321"
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
.head 5 -  Background Color: Class Default
.head 5 -  DLL Settings
.head 4 -  Message Actions
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  String: strTitle
.head 3 -  Number: nUpperBound
.head 2 -  Window Variables
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow( hWndForm )
.head 4 -  Call SalSetWindowText( hWndForm, strTitle )
.head 4 -  Call cc1.SetProgress( 0 )
.head 3 +  On UM_Update
.head 4 -  Call cc1.SetProgress( SalNumberRound( lParam / nUpperBound * 100 ))
.head 1 -  !
.head 1 +  Table Window: tbl_Logins
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Управление пользовательскими Login-ами
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
.head 3 -  Maximum Rows in Memory: 3000
.head 3 -  Discardable? No
.head 2 -  Description: Управление пользовательскими login-ами.
.head 2 +  Named Menus
.head 3 +  Menu: menuLoginMan
.head 4 -  Resource Id: 32193
.head 4 -  Title: (untitled)
.head 4 -  Description:
.head 4 -  Enabled when:
.head 4 -  Status Text:
.head 4 -  Menu Item Name:
.head 4 +  Menu Item: &Перечитать
.head 5 -  Resource Id: 32194
.head 5 -  Keyboard Accelerator: Ctrl+R
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg( pbRefresh, SAM_Click, 0, 0 )
.head 5 -  Menu Item Name:
.head 4 +  Menu Item: Пе&чать...
.head 5 -  Resource Id: 32195
.head 5 -  Keyboard Accelerator: Ctrl+P
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg( pbPrint, SAM_Click, 0, 0 )
.head 5 -  Menu Item Name:
.head 4 -  Menu Separator
.head 4 +  Menu Item: &Искать...
.head 5 -  Resource Id: 32196
.head 5 -  Keyboard Accelerator: Ctrl+F
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call TblFindString( hWndForm, DFIND_First )
.head 5 -  Menu Item Name:
.head 4 +  Menu Item: Искать &следующий...
.head 5 -  Resource Id: 32197
.head 5 -  Keyboard Accelerator: Ctrl+G
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call TblFindString( hWndForm, DFIND_Again )
.head 5 -  Menu Item Name:
.head 4 +  Menu Item: &Фильтр...
.head 5 -  Resource Id: 32198
.head 5 -  Keyboard Accelerator: Ctrl+T
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg( pbFilter, SAM_Click, 0, 0 )
.head 5 -  Menu Item Name:
.head 4 -  Menu Separator
.head 4 +  Menu Item: &Сохранить
.head 5 -  Resource Id: 32199
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg( pbUpdate, SAM_Click, 0, 0 )
.head 5 -  Menu Item Name:
.head 4 -  Menu Separator
.head 4 +  Menu Item: В&ыход
.head 5 -  Resource Id: 32200
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalDestroyWindow( hWndForm )
.head 5 -  Menu Item Name:
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
.head 6 -  Left:   1.383"
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
.head 5 -  Resource Id: 43070
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
.head 6 -  Left:   2.483"
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
.head 6 -  Left:   2.917"
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
.head 6 -  Left:   3.35"
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
.head 5 -  Resource Id: 43071
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
.head 5 -  Resource Id: 43072
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
.head 3 +  Column: colID
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
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
.head 3 +  Column: colLOGIN
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Рабочее
Имя
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.283"
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
.head 3 +  Column: colName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ф.И.О.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.514"
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
.head 3 +  Column: colDisable
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Закрыт
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Center
.head 4 -  Width:  0.986"
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
.head 6 -  Uncheck Value: 0
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colADate1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Разрешен
с
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  Default
.head 4 -  Width Editable? Yes
.head 4 -  Format: Date
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
.head 3 +  Column: colADate2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Разрешен
до
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  Default
.head 4 -  Width Editable? Yes
.head 4 -  Format: Date
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
.head 3 +  Column: colRDate1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Запрещен
с
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  Default
.head 4 -  Width Editable? Yes
.head 4 -  Format: Date
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
.head 3 +  Column: colRDate2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Запрещен
до
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  Default
.head 4 -  Width Editable? Yes
.head 4 -  Format: Date
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
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  : cMenu
.head 4 -  Class: cChildMenuEngine
.head 3 -  Number: nRow
.head 3 -  String: sStrLock
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Call SetWindowFont(hWndForm)
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('tbl_Logins.cTWndTitle'))
.head 4 -  Set hWndForm.tbl_Logins.nFlags = GT_NoDel | GT_NoIns | GT_NoRet
.head 4 -  Set hWndForm.tbl_Logins.strSqlPopulate = 
'SELECT id, logname, fio, disable, adate1, adate2, rdate1, rdate2 
   INTO :hWndForm.tbl_Logins.colID, :hWndForm.tbl_Logins.colLOGIN,
        :hWndForm.tbl_Logins.colName, :hWndForm.tbl_Logins.colDisable,
        :hWndForm.tbl_Logins.colADate1, :hWndForm.tbl_Logins.colADate2,
        :hWndForm.tbl_Logins.colRDate1, :hWndForm.tbl_Logins.colRDate2 
   FROM v_user_login ORDER BY id'
.head 4 -  Set hWndForm.tbl_Logins.strSqlUpdate = 
'UPDATE Staff
    SET adate1 = :hWndForm.tbl_Logins.colADate1,
        adate2 = :hWndForm.tbl_Logins.colADate2, 
        rdate1 = :hWndForm.tbl_Logins.colRDate1,
        rdate2 = :hWndForm.tbl_Logins.colRDate2 
  WHERE id = :hWndForm.tbl_Logins.colID'
.head 4 -  Set hWndForm.tbl_Logins.strFilterTblName = 'STAFF'
.head 4 -  Set hWndForm.tbl_Logins.strPrintFileName = 'LoginTrm.txt'
.head 4 -  ! Управление Login-ами
.head 4 -  Call cMenu.Init(hWndForm, 'menuLoginMan', CurrentLangTable.GetAtomTitle('tbl_Logins.cTMenu'))
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On UM_Update
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set nRow = TBL_MinRow
.head 4 +  While SalTblFindNextRow(hWndForm, nRow, ROW_Edited, 0)
.head 5 -  Call SalTblSetContext(hWndForm, nRow)
.head 5 +  If not SqlPrepareAndExecute(hSql(), hWndForm.tbl_Logins.strSqlUpdate)
.head 6 -  Call SqlRollbackEx(hSql(), AppCode || "Неуспешное выполнение процедуры блокирования пользователя")
.head 6 -  Break
.head 5 +  If hWndForm.tbl_Logins.colDisable
.head 6 -  Set sStrLock = "bars_useradm.lock_user(hWndForm.tbl_Logins.colID, DATETIME_Null, DATETIME_Null)"
.head 5 +  Else
.head 6 -  Set sStrLock = "bars_useradm.unlock_user(hWndForm.tbl_Logins.colID, DATETIME_Null, DATETIME_Null)"
.head 5 +  If not SqlPLSQLCommand(hSql(), sStrLock)
.head 6 -  Call SqlRollbackEx(hSql(), AppCode || "Неуспешное выполнение процедуры разблокирования пользователя")
.head 6 -  Break
.head 5 -  ! Изменение статуса учетной записи пользователя colName (colID,colLOGIN).
  Выкл=colDisable, Разрешен: colADate1-colADate2, Запрещен: colRDate1-colRDate2
.head 5 -  Call SqlCommitEx(hSql(), AppCode || CurrentLangTable.GetAtomTitle('tbl_Logins.cTToLog1') || ' ' || colName || '(' || Str(colID) || ',' || colLOGIN || '). ' || 
     CurrentLangTable.GetAtomTitle('tbl_Logins.cTToLog2') || '=' || Str(colDisable) || ', ' || 
     CurrentLangTable.GetAtomTitle('tbl_Logins.cTToLog3') || ': ' || SalFmtFormatDateTime(colADate1, 'dd/MM/yyyy') || '-' || SalFmtFormatDateTime(colADate2, 'dd/MM/yyyy') || ', ' || 
     CurrentLangTable.GetAtomTitle('tbl_Logins.cTToLog4') || ': ' || SalFmtFormatDateTime(colRDate1, 'dd/MM/yyyy') || '-' || SalFmtFormatDateTime(colRDate2, 'dd/MM/yyyy'))
.head 4 -  Call SalWaitCursor(FALSE)
.head 4 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 3 +  On SAM_Activate
.head 4 -  Call cMenu.Enable(wParam)
.head 3 +  On UM_MenuComponentShow
.head 4 -  Call cMenu.ShowMenu(wParam, lParam)
.head 3 +  On SAM_Destroy
.head 4 -  Call cMenu.Kill()
.head 4 -  Call SalSendClassMessage(SAM_Destroy, 0, 0)
.head 1 +  Table Window: tbl_Approving
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Подтверждение/Аннулирование прав пользователей
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
.head 4 -  Width:  14.8"
.head 4 -  Width Editable? Class Default
.head 4 -  Height: 6.25"
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
.head 3 -  Discardable? No
.head 2 -  Description: Подтверждение прав пользователя на ресурсы.
.head 2 +  Named Menus
.head 3 +  Menu: menuAcessApproving
.head 4 -  Resource Id: 16115
.head 4 -  Title: (untitled)
.head 4 -  Description:
.head 4 -  Enabled when:
.head 4 -  Status Text:
.head 4 -  Menu Item Name:
.head 4 +  Menu Item: &Перечитать
.head 5 -  Resource Id: 16116
.head 5 -  Keyboard Accelerator: Ctrl+R
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg( pbRefresh, SAM_Click, 0, 0 )
.head 5 -  Menu Item Name:
.head 4 +  Menu Item: Пе&чать...
.head 5 -  Resource Id: 16117
.head 5 -  Keyboard Accelerator: Ctrl+P
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg( pbPrint, SAM_Click, 0, 0 )
.head 5 -  Menu Item Name:
.head 4 -  Menu Separator
.head 4 +  Menu Item: &Искать...
.head 5 -  Resource Id: 16118
.head 5 -  Keyboard Accelerator: Ctrl+F
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call TblFindString( hWndForm, DFIND_First )
.head 5 -  Menu Item Name:
.head 4 +  Menu Item: Искать &следующий...
.head 5 -  Resource Id: 16119
.head 5 -  Keyboard Accelerator: Ctrl+G
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call TblFindString( hWndForm, DFIND_Again )
.head 5 -  Menu Item Name:
.head 4 +  Menu Item: &Фильтр...
.head 5 -  Resource Id: 16120
.head 5 -  Keyboard Accelerator: Ctrl+T
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg( pbFilter, SAM_Click, 0, 0 )
.head 5 -  Menu Item Name:
.head 4 -  Menu Separator
.head 4 +  Menu Item: &Сохранить
.head 5 -  Resource Id: 16121
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg( pbUpdate, SAM_Click, 0, 0 )
.head 5 -  Menu Item Name:
.head 4 -  Menu Separator
.head 4 +  Menu Item: В&ыход
.head 5 -  Resource Id: 16122
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalDestroyWindow( hWndForm )
.head 5 -  Menu Item Name:
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Class Default
.head 4 -  Location? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Size: 0.452"
.head 4 -  Size Editable? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 3 +  Contents
.head 4 +  Option Button: obGranted
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.067"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.433"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\A_lims.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Button Style: Check
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_TooltipSetText
.head 7 -  ! Показать выдаваемые права на ресурсы
.head 7 -  Return XSalTooltipSetText(lParam, CurrentLangTable.GetAtomTitle('tbl_Approving.cBTipGranted'))
.head 6 +  On SAM_Click
.head 7 -  Call SalSendMsg(cmbObjects, SAM_User, 0, 0)
.head 7 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 4 +  Option Button: obRevoked
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.5"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.433"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\A_bkld.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Button Style: Check
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_TooltipSetText
.head 7 -  ! Показать аннулируемые права на ресурсы
.head 7 -  Return XSalTooltipSetText(lParam, CurrentLangTable.GetAtomTitle('tbl_Approving.cBTipRevoked'))
.head 6 +  On SAM_Click
.head 7 -  Call SalSendMsg(cmbObjects, SAM_User, 0, 0)
.head 7 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 4 +  Option Button: obUser
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.583"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.433"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Custpers.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Button Style: Radio
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_TooltipSetText
.head 7 -  ! Показать ресурсы пользователей
.head 7 -  Return XSalTooltipSetText(lParam, CurrentLangTable.GetAtomTitle('tbl_Approving.cBTipUser'))
.head 6 +  On SAM_Click
.head 7 -  ! Call SalEnableWindow(pbFilter)
.head 7 -  Call SalSendMsg(cmbObjects, SAM_User, 0, 0)
.head 7 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 4 +  Option Button: obArms
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.02"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.433"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Docs.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Button Style: Radio
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_TooltipSetText
.head 7 -  ! Показать ресурсы АРМ-ов
.head 7 -  Return XSalTooltipSetText(lParam, CurrentLangTable.GetAtomTitle('tbl_Approving.cBTipArms'))
.head 6 +  On SAM_Click
.head 7 -  ! Call SalDisableWindow(pbFilter)
.head 7 -  Call SalSendMsg(cmbObjects, SAM_User, 0, 0)
.head 7 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 4 +  Option Button: obABS
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.45"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.433"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\DOC_TURN.BMP
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Button Style: Radio
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_TooltipSetText
.head 7 -  ! Показать ресурсы АБС
.head 7 -  Return XSalTooltipSetText(lParam, CurrentLangTable.GetAtomTitle('tbl_Approving.cBTipABS'))
.head 6 +  On SAM_Click
.head 7 -  Call SalDisableWindow(pbFilter)
.head 7 -  Set hWndForm.tbl_Approving.strFilterTblName = ''
.head 7 -  Call SalSendMsg(cmbObjects, SAM_User, 0, 0)
.head 7 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 4 +  Combo Box: cmbObjects
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenComboBox_NumId
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.9"
.head 6 -  Top:    0.107"
.head 6 -  Width:  2.8"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 1.81"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Editable? No
.head 5 -  String Type: Class Default
.head 5 -  Maximum Data Length: Class Default
.head 5 -  Sorted? Class Default
.head 5 -  Always Show List? Class Default
.head 5 -  Vertical Scroll? Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Input Mask: Class Default
.head 5 -  List Initialization
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 6 +  On SAM_User
.head 7 -  Call SalListClear(hWndItem)
.head 7 -  Call cmbObjects.Init(hWndItem)
.head 7 -  Call cmbObjects.Populate(hSql, "res_id", "res_name", "sec_resources",
" WHERE res_approve='Y' and res_id<>0
    AND " || IifS(obUser, "res_parentid=20", IifS(obArms, "res_parentid=1", "res_parentid=0")) || 
" ORDER BY res_name")
.head 7 -  ! Все
.head 7 -  Call cmbObjects.Add(0, CurrentLangTable.GetAtomTitle('tbl_Approving.cTObjects0'))
.head 7 -  Call cmbObjects.SetSelectById(0)
.head 7 +  If obUser
.head 8 -  Call SetColumnTitles(2)
.head 7 +  Else If obArms
.head 8 -  Call SetColumnTitles(1)
.head 7 +  Else If obABS
.head 8 -  Call SetColumnTitles(4)
.head 6 +  On SAM_Click
.head 7 -  Call SalSendClassMessage(SAM_Click, 0, 0)
.head 7 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 4 -  Line
.head 5 -  Resource Id: 60914
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  3.033"
.head 6 -  Begin Y:  -0.012"
.head 6 -  End X:  3.033"
.head 6 -  End Y:  0.488"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 -  Line
.head 5 -  Resource Id: 65092
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  6.9"
.head 6 -  Begin Y:  0.036"
.head 6 -  End X:  6.9"
.head 6 -  End Y:  0.5"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 -  Line
.head 5 -  Resource Id: 36040
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  3.767"
.head 6 -  Begin Y:  0.048"
.head 6 -  End X:  3.767"
.head 6 -  End Y:  0.512"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 +  Pushbutton: pbIns
.head 5 -  Class Child Ref Key: 33
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.417"
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
.head 6 -  Left:   7.1"
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
.head 4 +  Pushbutton: pbSecJournal
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.183"
.head 6 -  Top:    0.095"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Books.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_TooltipSetText
.head 7 -  ! Показать журнал безопасности
.head 7 -  Return XSalTooltipSetText(lParam, CurrentLangTable.GetAtomTitle('tbl_Approving.cBTipSecJournal'))
.head 6 +  On SAM_Click
.head 7 +  If hWinSecJournal
.head 8 -  Call SalBringWindowToTop(tbl_SecJournal)
.head 7 +  Else
.head 8 -  Set hWinSecJournal = SalCreateWindow(tbl_SecJournal, hWndMDI)
.head 4 +  Pushbutton: pbRefresh
.head 5 -  Class Child Ref Key: 35
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   7.533"
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
.head 4 +  Pushbutton: pbUpdate
.head 5 -  Class Child Ref Key: 36
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   7.967"
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
.head 5 -  Resource Id: 16123
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  11.15"
.head 6 -  Begin Y:  0.024"
.head 6 -  End X:  11.15"
.head 6 -  End Y:  0.488"
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
.head 6 -  Left:   8.633"
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
.head 4 +  Pushbutton: pbFilter
.head 5 -  Class Child Ref Key: 44
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   9.083"
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
.head 6 -  Left:   9.517"
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
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 40
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   9.95"
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
.head 5 -  Resource Id: 16124
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  10.483"
.head 6 -  Begin Y:  -0.012"
.head 6 -  End X:  10.483"
.head 6 -  End Y:  0.452"
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
.head 6 -  Left:   10.617"
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
.head 5 -  Resource Id: 16125
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  8.483"
.head 6 -  Begin Y:  -0.012"
.head 6 -  End X:  8.483"
.head 6 -  End Y:  0.452"
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 +  Option Button: obChangePeriod
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.933"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.433"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\clock-2.BMP
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Button Style: Check
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_TooltipSetText
.head 7 -  ! Показать ресурсы с периодом действия
.head 7 -  Return XSalTooltipSetText(lParam, CurrentLangTable.GetAtomTitle('tbl_Approving.cBTipChangePeriod'))
.head 6 +  On SAM_Click
.head 7 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 4 -  Line
.head 5 -  Resource Id: 65091
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  1.45"
.head 6 -  Begin Y:  -0.012"
.head 6 -  End X:  1.45"
.head 6 -  End Y:  0.452"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 +  Check Box: cbAll
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cCheckBoxLabeled
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title: Дозволити всі
.head 5 -  Window Location and Size
.head 6 -  Left:   11.283"
.head 6 -  Top:    0.15"
.head 6 -  Width:  2.0"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 -  Set i = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, i, 0, 0)
.head 8 -  Call SalTblSetContext(hWndForm, i)
.head 8 +  If colResourceName
.head 9 -  Set colApprove = cbAll
.head 9 -  Call SalTblSetRowFlags(hWndForm, i, ROW_Edited, TRUE)
.head 2 +  Contents
.head 3 +  Column: colBranch
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отделение
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  2.2"
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
.head 3 +  Column: colID			! S
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 8
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.8"
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
.head 3 +  Column: colGateLogin
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.317"
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
.head 3 +  Column: colLOGIN
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Рабочее
Имя
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.283"
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
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ф.И.О.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.1"
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
.head 3 +  Column: colResourceId		! S
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Resource id
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
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
.head 3 +  Column: colResourceType		! N sec_resources.res_id
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
.head 3 +  Column: colRTable
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Тип 
ресурса
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.071"
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
.head 3 +  Column: colResourceKod
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
ресурса
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.033"
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
.head 3 +  Column: colResourceName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
ресурса
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.629"
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
.head 3 +  Column: colApprove
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Разре
шить
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: 1
.head 4 -  Data Type: Number
.head 4 -  Justify: Center
.head 4 -  Width:  0.757"
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
.head 6 -  Uncheck Value: 0
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colADate1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Разрешен
с
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.171"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Date
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
.head 3 +  Column: colADate2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Разрешен
до
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.171"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Date
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
.head 3 +  Column: colRDate1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Запрещен
с
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.171"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Date
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
.head 3 +  Column: colRDate2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Запрещен
до
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.171"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Date
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
.head 3 +  Column: colResourceRole
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ```
.head 4 -  Visible? No
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
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
.head 3 +  Column: colAction
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: +/-
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Center
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
.head 3 +  Column: colGrantorId
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кто выд./анн.
ресурс
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  1.367"
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
.head 3 +  Column: colGrantor
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кто выд./анн.
ресурс
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.367"
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
.head 3 +  Column: colListPKVals
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
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
.head 2 +  Functions
.head 3 +  Function: SetColumnTitles
.head 4 -  Description: устанавливает колонки для разных режимов
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Number: nType !-- (1- АРМ-ы, 2- пользователи, 3- журналы)
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  ! АРМы
.head 5 +  If nType = 1
.head 6 -  Call SalHideWindow(colID)
.head 6 -  Call SalShowWindow(colLOGIN)
.head 6 -  Call SalShowWindow(colRTable)
.head 6 -  Call SalHideWindow(colGateLogin)
.head 6 -  ! Код АРМа
.head 6 -  Call SalTblSetColumnTitle(colLOGIN, CurrentLangTable.GetAtomTitle('tbl_Approving.cTColLOGIN'))
.head 6 -  ! АРМ
.head 6 -  Call SalTblSetColumnTitle(colUserName, CurrentLangTable.GetAtomTitle('tbl_Approving.cTColRTable1'))
.head 6 -  ! Код ресурса
.head 6 -  Call SalTblSetColumnTitle(colResourceKod, CurrentLangTable.GetAtomTitle('tbl_Approving.colResourceKod'))
.head 6 -  ! Наименование ресурса
.head 6 -  Call SalTblSetColumnTitle(colResourceName, CurrentLangTable.GetAtomTitle('tbl_Approving.colResourceName'))
.head 5 -  ! Пользователи
.head 5 +  Else If nType = 2
.head 6 -  Call SalShowWindow(colID)
.head 6 -  Call SalShowWindow(colRTable)
.head 6 -  ! Код ресурса
.head 6 -  Call SalTblSetColumnTitle(colResourceKod, CurrentLangTable.GetAtomTitle('tbl_Approving.colResourceKod'))
.head 6 -  !
.head 6 +  If not nGateWay
.head 7 -  ! Рабочее Имя
.head 7 -  Call SalTblSetColumnTitle(colLOGIN, CurrentLangTable.GetAtomTitle('tbl_Approving.colLOGIN'))
.head 7 -  Call SalShowWindow(colLOGIN)
.head 7 -  Call SalHideWindow(colGateLogin)
.head 6 +  Else
.head 7 -  ! Рабочее Имя
.head 7 -  Call SalTblSetColumnTitle(colGateLogin, CurrentLangTable.GetAtomTitle('tbl_Approving.colLOGIN'))
.head 7 -  Call SalHideWindow(colLOGIN)
.head 7 -  Call SalShowWindow(colGateLogin)
.head 6 -  !
.head 6 -  ! Ф.И.О.
.head 6 -  Call SalTblSetColumnTitle(colUserName, CurrentLangTable.GetAtomTitle('tbl_Approving.colUserName'))
.head 6 -  ! Наименование ресурса
.head 6 -  Call SalTblSetColumnTitle(colResourceName, CurrentLangTable.GetAtomTitle('tbl_Approving.colResourceName'))
.head 5 -  ! ???
.head 5 +  Else If nType = 3
.head 6 -  ! Дата действия)
.head 6 -  Call SalTblSetColumnTitle(colRDate1, CurrentLangTable.GetAtomTitle('tbl_Approving.cTColRDate1'))
.head 6 -  Call SalHideWindow(colADate2)
.head 6 -  Call SalHideWindow(colRDate1)
.head 6 -  Call SalHideWindow(colRDate2)
.head 6 -  Call SalHideWindow(colGateLogin)
.head 6 -  ! Ф.И.О.
.head 6 -  Call SalTblSetColumnTitle(colUserName, CurrentLangTable.GetAtomTitle('tbl_Approving.colUserName'))
.head 5 -  ! АБС
.head 5 +  Else If nType = 4
.head 6 -  ! Реципиент
.head 6 -  Call SalTblSetColumnTitle(colUserName, CurrentLangTable.GetAtomTitle('tbl_Approving.cTColUserName1'))
.head 6 -  ! Ф.И.О.
.head 6 -  Call SalTblSetColumnTitle(colResourceName, CurrentLangTable.GetAtomTitle('tbl_Approving.colUserName'))
.head 6 -  ! Таб.№
.head 6 -  Call SalTblSetColumnTitle(colResourceKod, CurrentLangTable.GetAtomTitle('tbl_Approving.cTColResourceKod1'))
.head 6 -  ! Код польз.
.head 6 -  Call SalTblSetColumnTitle(colResourceId, CurrentLangTable.GetAtomTitle('tbl_Approving.cTColResourceId'))
.head 6 -  Call SalHideWindow(colGateLogin)
.head 6 -  Call SalHideWindow(colResourceType)
.head 6 -  Call SalHideWindow(colID)
.head 6 -  Call SalHideWindow(colLOGIN)
.head 6 -  Call SalHideWindow(colRTable)
.head 6 -  Call SalHideWindow(colADate2)
.head 6 -  Call SalHideWindow(colADate1)
.head 6 -  Call SalHideWindow(colRDate1)
.head 6 -  Call SalHideWindow(colRDate2)
.head 3 +  Function: initResources
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call cResList.Init()
.head 5 -  Set nNumResource = cResList.nResourceNum
.head 5 -  Return TRUE
.head 3 +  Function: GetSQLPopulateStr_
.head 4 -  Description: Получить SQL строку населения таблицы...
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  Number: nMode		! Режимы показывания объектов
.head 5 -  String: strAddWhere	! Условие фильтра
.head 5 -  Number: nActMode	! =3 - Revoke+Approve,  =2 - Revoked,  =1 - Approve
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strSQL
.head 5 -  String: strINTO
.head 5 -  String: strAction
.head 5 -  !
.head 5 -  Number: i
.head 5 -  Number: k
.head 5 -  String: sSql
.head 4 +  Actions
.head 5 -  Set sSql    = ""
.head 5 -  Set strSQL  = ""
.head 5 -  Set strINTO =
" INTO :colBranch, :colID, :colLOGIN, :colUserName,
       :colResourceType, :colRTable, :colResourceId, :colResourceName,
       :colApprove, :colADate1, :colADate2, :colRDate1, :colRDate2,
       :colResourceRole, :colGrantorId, :colGrantor, :colResourceKod,
       :colGateLogin, :colAction, :colListPKVals"
.head 5 +  If obUser
.head 6 -  Set i = 0
.head 6 +  While i <= nNumResource
.head 7 +  If cResList.cResourceList[i].nResParentId = 20
.head 8 -  Set strAction = getAction(nActMode, i)
.head 8 -  !
.head 8 -  Set sSql =
" SELECT s.branch, " || 
         cResList.cResourceList[i].sResColName || ",
         s.dblogin,
         s.fio,
         " || Str(cResList.cResourceList[i].nResId) || ",
         '" || cResList.cResourceList[i].sResName || "',
         ''||" || cResList.cResourceList[i].sResColPK || ",
         v.name,
 	 0,
         " || cResList.cResourceList[i].sResTabName || ".adate1,
         " || cResList.cResourceList[i].sResTabName || ".adate2,
         " || cResList.cResourceList[i].sResTabName || ".rdate1,
         " || cResList.cResourceList[i].sResTabName || ".rdate2,
         NULL,
         gr.id,
         gr.fio,
         ''||" || cResList.cResourceList[i].sResColPK || ",
         s.logname,
         decode(" || cResList.cResourceList[i].sResTabName || ".revoked, 1, '-', decode(" || cResList.cResourceList[i].sResTabName || ".approve,1,'?','+')) " || ", 
         ''||" || cResList.cResourceList[i].sListPKVals ||
 strINTO || 
"   FROM " || cResList.cResourceList[i].sResTabName || ", v_staff s, 
         " || cResList.cResourceList[i].sResList || " v, staff gr
   WHERE s.id =" || cResList.cResourceList[i].sResColName || "
     and v.id =" || cResList.cResourceList[i].sResColPK   || "
     and gr.id=" || cResList.cResourceList[i].sResTabName || ".grantor
     and " || strAction || strAddWhere ||
         IifS(cResList.cResourceList[i].sAddTabCondition='', "",
   " and " || cResList.cResourceList[i].sAddTabCondition)
.head 8 -  Set sSql = VisStrSubstitute(sSql, "V_STAFF.", "s.")
.head 8 +  If nMode
.head 9 +  If cResList.cResourceList[i].nResId = nMode
.head 10 -  Set strSQL = sSql
.head 10 -  Break
.head 8 +  Else
.head 9 +  If strSQL
.head 10 -  Set strSQL = strSQL || PutCrLf() || ' UNION ' || PutCrLf()
.head 9 -  Set strINTO = ""
.head 9 -  Set strSQL = strSQL || sSql
.head 7 -  Set i = i + 1
.head 5 +  Else If obArms
.head 6 -  Set i = 0
.head 6 +  While i <= nNumResource
.head 7 +  If cResList.cResourceList[i].nResParentId = 1
.head 8 -  Set strAction = getAction(nActMode, i)
.head 8 -  Set sSql =
" SELECT null, 
         " || cResList.cResourceList[i].sResColName || ",
         " || cResList.cResourceList[i].sResColName || ",
         b.name,
         " || Str(cResList.cResourceList[i].nResId) || ",
         '" || cResList.cResourceList[i].sResName || "',
         ''||" || cResList.cResourceList[i].sResColPK || ",
         v.name,
	 0,
         " || cResList.cResourceList[i].sResTabName || ".adate1,
         " || cResList.cResourceList[i].sResTabName || ".adate2,
         " || cResList.cResourceList[i].sResTabName || ".rdate1,
         " || cResList.cResourceList[i].sResTabName || ".rdate2,
         v.rolename,
         gr.id,
         gr.fio,
         ''||" || cResList.cResourceList[i].sResColPK || ",
         0,
         decode(" || cResList.cResourceList[i].sResTabName || ".revoked, 1, '-', decode(" || cResList.cResourceList[i].sResTabName || ".approve,1,'?','+')) " ||", 
         ''||" || cResList.cResourceList[i].sListPKVals ||
 strINTO ||
"   FROM " || cResList.cResourceList[i].sResTabName || ", applist b,
         " || cResList.cResourceList[i].sResList || " v, staff gr
   WHERE b.codeapp=" || cResList.cResourceList[i].sResColName || "
     and v.id     =" || cResList.cResourceList[i].sResColPK || "
     and gr.id    =" || cResList.cResourceList[i].sResTabName || ".grantor
     and " || strAction || strAddWhere ||
         IifS(cResList.cResourceList[i].sAddTabCondition='', "",
   " and " || cResList.cResourceList[i].sAddTabCondition)
.head 8 +  If nMode
.head 9 +  If cResList.cResourceList[i].nResId = nMode
.head 10 -  Set strSQL = sSql
.head 10 -  Break
.head 8 +  Else
.head 9 +  If strSQL
.head 10 -  Set strSQL = strSQL || PutCrLf() || ' UNION ' || PutCrLf()
.head 9 -  Set strINTO = ""
.head 9 -  Set strSQL = strSQL || sSql
.head 7 -  Set i = i + 1
.head 5 +  Else If obABS
.head 6 -  Set strSQL =
" SELECT null, '0', '', 'Комплекс АБС', 20, '', a.id, a.fio, 0, to_date(NULL), to_date(NULL), to_date(NULL), to_date(NULL),
         '', gr.id,  gr.fio, rtrim(ltrim(a.tabn)), 0, '+', ''" || 
 strINTO ||
"   FROM staff a, staff_storage b, staff gr
   WHERE a.id=b.id
     AND gr.id=b.grantor " || strAddWhere
.head 5 +  If strSQL
.head 6 -  Set strSQL = strSQL || " order by 4, 1"
.head 5 -  ! Call SaveInfoToLog(strSQL)
.head 5 -  Return strSQL
.head 3 +  Function: GetSQLPopulateStr
.head 4 -  Description: Получить SQL строку населения таблицы...
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  Number: nMode		! Режимы показывания объектов
.head 5 -  ! String: strAddWhere	! Условие фильтра
.head 5 -  Number: nActMode	! =3 - Revoke+Approve,  =2 - Revoked,  =1 - Approve
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strSQL
.head 5 -  String: strINTO
.head 5 -  String: strAction
.head 5 -  !
.head 5 -  Number: i
.head 5 -  Number: k
.head 5 -  String: sSql
.head 4 +  Actions
.head 5 -  Set sSql    = ""
.head 5 -  Set strSQL  = ""
.head 5 -  Set strINTO =
" INTO :colBranch, :colID, :colLOGIN, :colUserName,
       :colResourceType, :colRTable, :colResourceId, :colResourceName,
       :colApprove, :colADate1, :colADate2, :colRDate1, :colRDate2,
       :colResourceRole, :colGrantorId, :colGrantor, :colResourceKod,
       :colGateLogin, :colAction, :colListPKVals"
.head 5 +  If obUser
.head 6 -  Set i = 0
.head 6 +  While i <= nNumResource
.head 7 +  If cResList.cResourceList[i].nResParentId = 20
.head 8 -  Set strAction = getAction(nActMode, i)
.head 8 -  !
.head 8 -  Set sSql =
" SELECT s.branch branch, " || 
         cResList.cResourceList[i].sResColName || " id,
         s.dblogin id_name,
         s.fio name,
         " || Str(cResList.cResourceList[i].nResId) || " res_id,
         '" || cResList.cResourceList[i].sResName || "' res_name,
         ''||" || cResList.cResourceList[i].sResColPK || " res_pk,
         v.name res_sem,
 	 0 approve,
         " || cResList.cResourceList[i].sResTabName || ".adate1 adate1,
         " || cResList.cResourceList[i].sResTabName || ".adate2 adate2,
         " || cResList.cResourceList[i].sResTabName || ".rdate1 rdate1,
         " || cResList.cResourceList[i].sResTabName || ".rdate2 rdate2,
         NULL res_role,
         gr.id gr_id,
         gr.fio gr_fio,
         ''||" || cResList.cResourceList[i].sResColPK || " res_code,
         s.logname gate_login,
         decode(" || cResList.cResourceList[i].sResTabName || ".revoked, 1, '-', decode(" || cResList.cResourceList[i].sResTabName || ".approve,1,'?','+')) " || " action, 
         ''||" || cResList.cResourceList[i].sListPKVals || " vals " ||
"   FROM " || cResList.cResourceList[i].sResTabName || ", v_staff s, 
         " || cResList.cResourceList[i].sResList || " v, staff gr
   WHERE s.id =" || cResList.cResourceList[i].sResColName || "
     and v.id =" || cResList.cResourceList[i].sResColPK   || "
     and gr.id=" || cResList.cResourceList[i].sResTabName || ".grantor
     and " || strAction || 
         IifS(cResList.cResourceList[i].sAddTabCondition='', "",
   " and " || cResList.cResourceList[i].sAddTabCondition)
.head 8 -  Set sSql = VisStrSubstitute(sSql, "V_STAFF.", "s.")
.head 8 +  If nMode
.head 9 +  If cResList.cResourceList[i].nResId = nMode
.head 10 -  Set strSQL = sSql
.head 10 -  Break
.head 8 +  Else
.head 9 +  If strSQL
.head 10 -  Set strSQL = strSQL || PutCrLf() || ' UNION ' || PutCrLf()
.head 9 -  Set strSQL = strSQL || sSql
.head 7 -  Set i = i + 1
.head 5 +  Else If obArms
.head 6 -  Set i = 0
.head 6 +  While i <= nNumResource
.head 7 +  If cResList.cResourceList[i].nResParentId = 1
.head 8 -  Set strAction = getAction(nActMode, i)
.head 8 -  Set sSql =
" SELECT null branch, 
         " || cResList.cResourceList[i].sResColName || " id,
         " || cResList.cResourceList[i].sResColName || " id_name,
         b.name name,
         " || Str(cResList.cResourceList[i].nResId) || " res_id,
         '" || cResList.cResourceList[i].sResName || "' res_name,
         ''||" || cResList.cResourceList[i].sResColPK || " res_pk,
         v.name res_sem,
	 0 approve,
         " || cResList.cResourceList[i].sResTabName || ".adate1 adate1,
         " || cResList.cResourceList[i].sResTabName || ".adate2 adate2,
         " || cResList.cResourceList[i].sResTabName || ".rdate1 rdate1,
         " || cResList.cResourceList[i].sResTabName || ".rdate2 rdate2,
         v.rolename res_role,
         gr.id gr_id,
         gr.fio gr_fio,
         ''||" || cResList.cResourceList[i].sResColPK || " res_code,
         0 gate_login,
         decode(" || cResList.cResourceList[i].sResTabName || ".revoked, 1, '-', decode(" || cResList.cResourceList[i].sResTabName || ".approve,1,'?','+')) " ||" action, 
         ''||" || cResList.cResourceList[i].sListPKVals || " vals " ||
"   FROM " || cResList.cResourceList[i].sResTabName || ", applist b,
         " || cResList.cResourceList[i].sResList || " v, staff gr
   WHERE b.codeapp=" || cResList.cResourceList[i].sResColName || "
     and v.id     =" || cResList.cResourceList[i].sResColPK || "
     and gr.id    =" || cResList.cResourceList[i].sResTabName || ".grantor
     and " || strAction || 
         IifS(cResList.cResourceList[i].sAddTabCondition='', "",
   " and " || cResList.cResourceList[i].sAddTabCondition)
.head 8 +  If nMode
.head 9 +  If cResList.cResourceList[i].nResId = nMode
.head 10 -  Set strSQL = sSql
.head 10 -  Break
.head 8 +  Else
.head 9 +  If strSQL
.head 10 -  Set strSQL = strSQL || PutCrLf() || ' UNION ' || PutCrLf()
.head 9 -  Set strSQL = strSQL || sSql
.head 7 -  Set i = i + 1
.head 5 +  Else If obABS
.head 6 -  ! Set strSQL =
" SELECT null, '0', '', 'Комплекс АБС', 20, '', a.id, a.fio, 0, to_date(NULL), to_date(NULL), to_date(NULL), to_date(NULL),
         '', gr.id,  gr.fio, rtrim(ltrim(a.tabn)), 0, '+', ''" || 
 strINTO ||
"   FROM staff a, staff_storage b, staff gr
   WHERE a.id=b.id
     AND gr.id=b.grantor " || strAddWhere
.head 5 +  If strSQL
.head 6 -  Set strSQL = 
"select v_approve_resources.branch, v_approve_resources.id, v_approve_resources.id_name, v_approve_resources.name,
        v_approve_resources.res_id, v_approve_resources.res_name, v_approve_resources.res_pk, v_approve_resources.res_sem,
        v_approve_resources.approve, v_approve_resources.adate1, v_approve_resources.adate2, v_approve_resources.rdate1, v_approve_resources.rdate2, v_approve_resources.res_role,
        v_approve_resources.gr_id, v_approve_resources.gr_fio, v_approve_resources.res_code, v_approve_resources.gate_login, v_approve_resources.action, v_approve_resources.vals " ||
        strINTO || "
   from ( " || strSQL || " ) v_approve_resources"
.head 5 -  ! Call SaveInfoToLog(strSQL)
.head 5 -  Return strSQL
.head 3 +  Function: getAction
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  Number: nActMode
.head 5 -  Number: nIndex
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strAction
.head 5 -  String: strActRevoke
.head 5 -  String: strActApprove
.head 5 -  String: strActDate
.head 4 +  Actions
.head 5 -  Set strAction = ""
.head 5 -  !
.head 5 -  Set strActRevoke   = " ( nvl(" || cResList.cResourceList[nIndex].sResTabName || ".revoked,0)=1 ) "
.head 5 -  Set strActApprove  = " ( nvl(" || cResList.cResourceList[nIndex].sResTabName || ".approve,0)=0 ) "
.head 5 -  Set strActDate     = " ( " || cResList.cResourceList[nIndex].sResTabName || ".adate1 is not NULL or " || cResList.cResourceList[nIndex].sResTabName || ".adate2 is not NULL or
                         " || cResList.cResourceList[nIndex].sResTabName || ".rdate1 is not NULL or " || cResList.cResourceList[nIndex].sResTabName || ".rdate2 is not NULL ) "
.head 5 +  Select Case nActMode
.head 6 +  Case 1 !-- подтверждение
.head 7 -  Set strAction = strActApprove
.head 7 -  Break
.head 6 +  Case 3 !-- аннулирование
.head 7 -  Set strAction = strActRevoke
.head 7 -  Break
.head 6 +  Case 5 !-- изменение сроков
.head 7 -  Set strAction = strActDate
.head 7 -  Break
.head 6 +  Case 4
.head 7 -  Set strAction = " ( " || strActApprove || " OR " || strActRevoke || " ) "
.head 7 -  Break
.head 6 +  Case 6
.head 7 -  Set strAction = " ( " || strActApprove || " OR " || strActDate || " ) "
.head 7 -  Break
.head 6 +  Case 8
.head 7 -  Set strAction = " ( " || strActRevoke || " OR " || strActDate || " ) "
.head 7 -  Break
.head 6 +  Case 9
.head 7 -  Set strAction = " ( " || strActRevoke || " OR " || strActDate || " OR " || strActApprove || " ) "
.head 7 -  Break
.head 6 +  Default
.head 7 -  Break
.head 5 -  ! Set strAction = strAction || IifS(strAction="", "", " and ") || " nvl(grantor,0) <> user_id "
.head 5 -  Return strAction
.head 3 +  Function: ApproveResources
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sListPKNames
.head 5 -  String: sResUserCol
.head 5 -  String: sAlterProc
.head 5 -  String: sDropProc
.head 5 -  String: sArrColVals
.head 5 -  String: sRoles 
.head 5 -  String: sStr
.head 5 -  !
.head 5 -  Number: nRow
.head 5 -  Boolean: bIsDeleted
.head 5 -  String: strAction
.head 5 -  String: sTmp
.head 5 -  ! -- для журнализации
.head 5 -  Number: nJrnAction
.head 5 -  Number: nJrnRecieveType !-- тип приемника ресурса
.head 5 -  String: sResCode
.head 5 -  Number: nGrantorId
.head 5 -  Boolean: bSaveInSecJournal
.head 4 +  Actions
.head 5 -  Set nRow = TBL_MinRow
.head 5 +  While SalTblFindNextRow(hWndForm, nRow, ROW_Edited | ROW_MarkDeleted, 0)
.head 6 -  Call SalTblSetContext(hWndForm, nRow)
.head 6 -  Set bIsDeleted = SalTblQueryRowFlags(hWndForm, nRow, ROW_MarkDeleted)
.head 6 -  ! Запрещаем подтверждать собственноручно выданные ресурсы
.head 6 +  If colApprove or bIsDeleted
.head 7 -  Set i = 0
.head 7 +  While i <= nNumResource
.head 8 +  If colResourceType = cResList.cResourceList[i].nResId
.head 9 -  Set sListPKNames    = cResList.cResourceList[i].sListPKNames
.head 9 -  Set nJrnRecieveType = cResList.cResourceList[i].nResParentId
.head 9 -  Set sRoles          = cResList.cResourceList[i].sResAfterProc
.head 8 -  Set i = i + 1
.head 7 -  !
.head 7 +  If obUser
.head 8 -  Set sResUserCol = colID
.head 8 -  Set sAlterProc  = "bars_useradm.alter_user_resource"
.head 8 -  Set sDropProc   = "bars_useradm.drop_user_resource"
.head 7 +  Else If obArms
.head 8 -  Set sResUserCol = "'" || colID || "'"
.head 8 -  Set sAlterProc  = "bars_useradm.alter_app_resource"
.head 8 -  Set sDropProc   = "bars_useradm.drop_app_resource"
.head 7 +  Else If obABS
.head 8 -  Set sDropProc = "bars_useradm.drop_user(" || colResourceId || ")"
.head 7 -  !
.head 7 -  Set sStr = ""
.head 7 -  Set bSaveInSecJournal = FALSE
.head 7 -  ! ==================================
.head 7 -  ! -- помеченные на удаление
.head 7 -  ! ==================================
.head 7 +  If bIsDeleted
.head 8 -  ! -- отказ от подтверждения
.head 8 +  If colAction = '+'
.head 9 +  If obABS
.head 10 -  Set sStr = sDropProc
.head 9 +  Else
.head 10 -  Set sStr = sDropProc || "(" || 
    sResUserCol || ", " || 
    Str(colResourceType) || ", " ||
    "bars_useradm.t_varchar2list(" || sListPKNames  || "), " || 
    "bars_useradm.t_varchar2list(" || colListPKVals || "))"
.head 9 -  Set nJrnAction = 6
.head 8 -  ! -- отказ от аннулир.
.head 8 +  Else
.head 9 -  Set sStr = sAlterProc || "(" || 
    sResUserCol || ", " || 
    Str(colResourceType) || ", " ||
    "bars_useradm.t_varchar2list(" || sListPKNames  || "), " || 
    "bars_useradm.t_varchar2list(" || colListPKVals || "), " ||
    "bars_useradm.t_varchar2list('REVOKED'), " || 
    "bars_useradm.t_varchar2list('0'))"
.head 9 -  Set nJrnAction = 7
.head 8 -  ! -- выполнение процедуры
.head 8 +  If sStr
.head 9 +  If SqlPrepareAndExecute(hSql, "begin " || sStr || "; end;")
.head 10 -  ! Отказ от подтверждения прав для colUserName на ресурс colResourceName
.head 10 -  Call SqlCommitEx(hSql, AppCode || CurrentLangTable.GetAtomTitle('tbl_Approving.cTToLog1') || ' ' || colUserName || ' ' ||
     CurrentLangTable.GetAtomTitle('tbl_Approving.cTToLog3') || ' ' || colResourceName)
.head 10 -  Set bSaveInSecJournal = TRUE
.head 9 +  Else
.head 10 -  ! Неуспешный отказ от подтверждения прав для colUserName на ресурс colResourceName
.head 10 -  Call SqlRollbackEx(hSql, AppCode || CurrentLangTable.GetAtomTitle('tbl_Approving.cTToLog2') || ' ' || colUserName || ' ' ||
     CurrentLangTable.GetAtomTitle('tbl_Approving.cTToLog3') || ' ' || colResourceName)
.head 10 -  Call SalMessageBox(AppCode || CurrentLangTable.GetAtomTitle('tbl_Approving.cTToLog2') || ' ' || colUserName || ' ' ||
     CurrentLangTable.GetAtomTitle('tbl_Approving.cTToLog3') || ' ' || colResourceName ,
     CurrentLangTable.GetAtomTitle('cTAt'), 0)
.head 10 -  Return FALSE
.head 7 -  ! ==================================
.head 7 -  ! -- помеченные на подтверждение
.head 7 -  ! ==================================
.head 7 +  Else
.head 8 -  ! If colGrantorId != nMyUserId or GetUserLoginName() = 'BARS'
.head 8 -  ! -- Подтверждение ресурса или изменение срока действия
.head 8 +  If colAction = '+' or colAction = '?'
.head 9 -  ! -- Если у ресурса нету приемника (например пользователь)
.head 9 +  If colResourceType = 20
.head 10 +  If not CreateUserGtw()
.head 11 -  Return FALSE
.head 9 +  Else
.head 10 -  Set sArrColVals = Str(colApprove)
.head 10 -  Call SalTblGetColumnText(hWndForm, SalTblQueryColumnID(colADate1), sTmp)
.head 10 -  Set sArrColVals = sArrColVals || IifS(sArrColVals="", "", ",") || "'" || sTmp || "'"
.head 10 -  Call SalTblGetColumnText(hWndForm, SalTblQueryColumnID(colADate2), sTmp)
.head 10 -  Set sArrColVals = sArrColVals || IifS(sArrColVals="", "", ",") || "'" || sTmp || "'"
.head 10 -  Call SalTblGetColumnText(hWndForm, SalTblQueryColumnID(colRDate1), sTmp)
.head 10 -  Set sArrColVals = sArrColVals || IifS(sArrColVals="", "", ",") || "'" || sTmp || "'"
.head 10 -  Call SalTblGetColumnText(hWndForm, SalTblQueryColumnID(colRDate2), sTmp)
.head 10 -  Set sArrColVals = sArrColVals || IifS(sArrColVals="", "", ",") || "'" || sTmp || "'"
.head 10 -  Set sStr = sAlterProc || "(" || 
    sResUserCol || ", " || 
    Str(colResourceType) || ", " ||
    "bars_useradm.t_varchar2list(" || sListPKNames  || "), " || 
    "bars_useradm.t_varchar2list(" || colListPKVals || "), " ||
    "bars_useradm.t_varchar2list('APPROVE','ADATE1','ADATE2','RDATE1','RDATE2'), " || 
    "bars_useradm.t_varchar2list(" || sArrColVals || "))"
.head 9 -  ! подтверждение прав
.head 9 -  Set strAction = CurrentLangTable.GetAtomTitle('tbl_Approving.cTToLogSec1')
.head 9 +  If colAction = '+'
.head 10 -  Set nJrnAction = 3
.head 9 +  Else
.head 10 -  Set nJrnAction = 5
.head 8 -  ! -- Подтверждение на аннулирование
.head 8 +  Else
.head 9 -  Set sStr = sDropProc || "(" || 
    sResUserCol || ", " || 
    Str(colResourceType) || ", " ||
    "bars_useradm.t_varchar2list(" || sListPKNames  || "), " || 
    "bars_useradm.t_varchar2list(" || colListPKVals || "))"
.head 9 -  ! аннулирование прав
.head 9 -  Set strAction = CurrentLangTable.GetAtomTitle('tbl_Approving.cTToLogSec2')
.head 9 -  Set nJrnAction = 4
.head 8 -  ! -- выполнение процедуры
.head 8 +  If sStr
.head 9 +  If SqlPrepareAndExecute(hSql, "begin " || sStr || "; end;")
.head 10 +  If sRoles and colAction != '?'
.head 11 -  ! -- если нужно дать/забрать роли-гранты
.head 11 -  Set sRoles = IifS(obUser=TRUE, 
    sRoles || "("  || colID || ")",
    sRoles || "('" || colID || "')")
.head 11 +  If not SqlPLSQLCommand(hSql, sRoles)
.head 12 -  ! Безопасность: неуспешное strAction прав colUserName <- colRTable.colResourceName
.head 12 -  Call SqlRollbackEx(hSql, AppCode || CurrentLangTable.GetAtomTitle('tbl_Approving.cTToLogSec0') || ': ' ||
     CurrentLangTable.GetAtomTitle('tbl_Approving.cTToLogSec3') || ': ' || strAction || ' ' || colUserName || ' <- ' || colRTable || '.' || colResourceName)
.head 12 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('tbl_Approving.cTToLogSec0') || ': ' ||
     CurrentLangTable.GetAtomTitle('tbl_Approving.cTToLogSec3') || ': ' || strAction || ' ' || colUserName || ' <- ' || colRTable || '.' || colResourceName,
     CurrentLangTable.GetAtomTitle('cTAt'),0)
.head 12 -  Return FALSE
.head 10 -  ! Безопасность: strAction прав colUserName <- colRTable.colResourceName
.head 10 -  Call SqlCommitEx(hSql, CurrentLangTable.GetAtomTitle('tbl_Approving.cTToLogSec0') || ': ' || strAction||' ' || colUserName || ' <- ' || colRTable || '.' || colResourceName)
.head 10 -  Set bSaveInSecJournal = TRUE
.head 9 +  Else
.head 10 -  ! Безопасность: неуспешное strAction прав colUserName <- colRTable . colResourceName
.head 10 -  Call SqlRollbackEx(hSql, AppCode || CurrentLangTable.GetAtomTitle('tbl_Approving.cTToLogSec0') || ': ' ||
     CurrentLangTable.GetAtomTitle('tbl_Approving.cTToLogSec3') || ': ' || strAction || colUserName || ' <- ' || colRTable || '.' || colResourceName)
.head 10 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('tbl_Approving.cTToLogSec0') || ': ' ||
     CurrentLangTable.GetAtomTitle('tbl_Approving.cTToLogSec3') || ': ' || strAction || colUserName || ' <- ' || colRTable || '.' || colResourceName,
     CurrentLangTable.GetAtomTitle('cTAt'), 0)
.head 10 -  Return FALSE
.head 7 -  ! ==================================
.head 7 -  ! -- Вставка в журнал безопасности
.head 7 -  ! ==================================
.head 7 +  If bSaveInSecJournal
.head 8 -  Set nGrantorId = GetUserIdX()
.head 8 +  If obUser
.head 9 -  Set sResCode = ':colLOGIN'
.head 8 +  Else
.head 9 -  Set sResCode = ':colID'
.head 8 +  If not SqlPrepareAndExecute(hSql,
"INSERT INTO sec_journal(
        who_grant, resource_type, gr_date, action,
        resource_id, source_id, SOURCE_TYPE,
        resource_name, source_name,  source_kod)
 VALUES (:nGrantorId, :colResourceType, SYSDATE, :nJrnAction,
         :colResourceId, " || sResCode || ", :nJrnRecieveType,
         :colResourceName, :colUserName, :colLOGIN) ")
.head 9 -  ! Невозможно сделать запись в журнале безопасности
.head 9 -  Call SqlRollbackEx(hSql, AppCode || CurrentLangTable.GetAtomTitle('tbl_Approving.cTMsg4'))
.head 9 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('tbl_Approving.cTMsg4'),
     CurrentLangTable.GetAtomTitle('cTAt'), 0)
.head 9 -  Return FALSE
.head 8 +  Else
.head 9 -  Call SqlCommit(hSql)
.head 7 -  ! ==================================
.head 5 -  Return TRUE
.head 3 +  Function: CreateUserGtw
.head 4 -  Description: ! При подтверждении пользователя 
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  ! для ресурса - пользователь
.head 5 -  Number: nUserId		! staff.id
.head 5 -  ! String: sUserTabn	! staff.tabn
.head 5 -  String: sUsrName	! staff.logname
.head 4 +  Actions
.head 5 -  Set nUserId  = Val(colResourceId)
.head 5 -  Set sUsrName = colResourceName
.head 5 -  ! -- Создание пользователя GateWay
.head 5 +  If not SqlPLSQLCommand(hSql, "bars_useradm.create_user_gtw(nUserId)")
.head 6 -  Call SqlRollbackEx(hSql, AppCode || "Неуспешное выполнение процедуры создания пользователя GateWay [" || sUsrName || "]")
.head 6 -  Return FALSE
.head 5 -  Call SqlCommitEx(hSql, AppCode || "Создание пользователя GateWay [" || sUsrName || "]")
.head 5 -  Return TRUE
.head 3 +  Function: GetUserIdX
.head 4 -  Description: Расширеная функа GetUserId, но также корректно выдает № пользователя GateWay-я
.head 4 +  Returns
.head 5 -  Number:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nUserId
.head 4 +  Actions
.head 5 +  If bGateWay
.head 6 +  If SqlPrepareAndExecute(hSqlAux(),
"SELECT s.id INTO :nUserId
   FROM sec_logins l, staff s
  WHERE l.oralogin = USER AND trim(l.secid)=trim(s.tabn)")
.head 7 -  Call SqlFetchNext(hSqlAux(), nFetchRes)
.head 5 +  Else
.head 6 -  Set nUserId = GetUserId()
.head 5 -  Return nUserId
.head 2 +  Window Parameters
.head 3 -  Boolean: bEdit	! TRUE-Edit, FALSE-Show
.head 2 +  Window Variables
.head 3 -  : cMenu
.head 4 -  Class: cChildMenuEngine
.head 3 -  !
.head 3 -  : cCnc
.head 4 -  Class: cABSConnect
.head 3 -  Sql Handle: hSql
.head 3 -  : cResList
.head 4 -  Class: cSecResourcesList
.head 3 -  !
.head 3 -  Number: nHaveTobo
.head 3 -  !
.head 3 -  String: strAddWhere
.head 3 -  String: strAddFrom
.head 3 -  Number: nActionMode
.head 3 -  ! -- для GateWay
.head 3 -  String: sGateWay
.head 3 -  Boolean: bGateWay
.head 3 -  Number: nTaskId
.head 3 -  Number: nMyUserId
.head 3 -  !
.head 3 -  Number: i
.head 3 -  !
.head 3 -  Number: nNumResource
.head 3 -  Number: nCount
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  ! Подтверждение/Аннулирование прав пользователей | Просмотр неподтвержденных прав пользователей
.head 4 -  Call SalSetWindowText(hWndForm, IifS(bEdit=TRUE, 
     CurrentLangTable.GetAtomTitle('tbl_Approving.cTWndTitle'),
     CurrentLangTable.GetAtomTitle('tbl_Approving.cTWndTitleShow')))
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  !
.head 4 -  Call XConnectGetParams(cCnc)
.head 4 +  If NOT cCnc.Connect()
.head 5 -  ! Невозможно установить соединение
.head 5 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('tbl_Approving.cTErrConnect'), 
     CurrentLangTable.GetAtomTitle('cTAt'), 0)
.head 5 -  Return -1
.head 4 -  Set hSql = cCnc.hSql()
.head 4 -  Set nHaveTobo = GetGlobalOptionEx("HAVETOBO")
.head 4 -  !
.head 4 -  Set hWndForm.tbl_Approving.nFlags = GT_NoIns | GT_NoRet
.head 4 -  ! Set hWndForm.tbl_Approving.strFilterTblName = 'V_STAFF'
.head 4 -  Set hWndForm.tbl_Approving.strFilterTblName = 'v_approve_resources'
.head 4 -  Set hWndForm.tbl_Approving.strPrintFileName = 'Access.txt'
.head 4 -  !
.head 4 -  ! Подтверждение прав
.head 4 -  Call cMenu.Init(hWndForm, 'menuAcessApproving', CurrentLangTable.GetAtomTitle('tbl_Approving.cTMenu'))
.head 4 -  Set obGranted = TRUE
.head 4 -  Set obUser    = TRUE
.head 4 -  Set nMyUserId = GetUserId()
.head 4 -  !
.head 4 -  Call SalUseRegistry(FALSE, '')
.head 4 -  Call SalGetProfileString('Common Parameters', 'UseGateway', '', sGateWay, GetIniFileName())
.head 4 -  Set bGateWay = SalStrToNumber(SalStrTrimX(sGateWay)) = 1
.head 4 +  If not bGateWay
.head 5 -  Call SalDisableWindow(obABS)
.head 4 -  Set nTaskId = SalGetProfileInt('Common Parameters', 'TaskID', 1, GetIniFileName())
.head 4 -  !
.head 4 -  Call initResources()
.head 4 -  !
.head 4 +  If not bEdit
.head 5 -  Call SalDisableWindow(pbDel)
.head 5 -  Call SalDisableWindow(pbUpdate)
.head 5 -  Call SalHideWindow(colApprove)
.head 5 -  Call SalDisableWindow(colADate1)
.head 5 -  Call SalDisableWindow(colADate2)
.head 5 -  Call SalDisableWindow(colRDate1)
.head 5 -  Call SalDisableWindow(colRDate2)
.head 4 -  !
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On UM_Populate
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set cbAll = FALSE
.head 4 -  Set nCount = 0
.head 4 +  If obUser and nHaveTobo = 2
.head 5 -  Call SalShowWindow(colBranch)
.head 4 +  Else
.head 5 -  Call SalHideWindow(colBranch)
.head 4 -  Call SalTblDefineSplitWindow(hWndForm, 0, FALSE)
.head 4 -  Set nActionMode = 0
.head 4 +  If obGranted 
.head 5 -  Set nActionMode = 1
.head 4 +  If obRevoked
.head 5 -  Set nActionMode = nActionMode + 3
.head 4 +  If obChangePeriod
.head 5 -  Set nActionMode = nActionMode + 5
.head 4 +  ! If obUser
.head 5 -  Set strAddWhere = cF.GetFilterWhereClause(TRUE)
.head 5 -  Set strAddFrom = cF.GetFilterFromClause(TRUE)
.head 4 +  ! Else
.head 5 -  Set strAddWhere = ""
.head 5 -  Set strAddFrom = ""
.head 4 +  ! If strAddWhere
.head 5 -  Set strAddWhere = " AND " || strAddWhere
.head 4 -  Set strAddWhere = cF.GetFilterWhereClause(TRUE)
.head 4 -  Set strAddFrom = cF.GetFilterFromClause(TRUE)
.head 4 +  If nActionMode != 0
.head 5 -  Set strDSql = GetSQLPopulateStr(cmbObjects.GetCurrentKey(), nActionMode)
.head 5 -  Set strDSql = strDSql ||
    IifS(strAddFrom='', "", ", " || strAddFrom) || 
    IifS(strAddWhere='', "", " where " || strAddWhere) ||
    " order by 4, 1"
.head 5 -  Call SaveInfoToLog(strDSql)
.head 5 -  Call SalTblPopulate(hWndForm, cMain.hSql(), T(strDSql), TBL_FillAll)
.head 5 -  Call VisTblAutoSizeColumn(hWndForm, colResourceKod)
.head 5 -  Call SalTblSetContext(hWndForm, 0)
.head 5 -  Call SalPostMsg(hWndForm, SAM_TblDoDetails, 0, 0)
.head 4 -  Call SalTblDefineSplitWindow(hWndForm, 1, TBL_Split_Adjustable)
.head 4 -  Call SalTblFetchRow(hWndForm, SalTblInsertRow(hWndForm, TBL_MinSplitRow))
.head 4 -  Call SalTblSetFlagsAnyRows(hWndForm, ROW_New, FALSE, 0, 0)
.head 4 -  Set colRTable = 'Всього:'
.head 4 -  Set colResourceKod = Str(nCount)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_FetchRowDone
.head 4 -  Set nCount = nCount + 1
.head 4 +  Select Case colResourceType
.head 5 +  Case APPROVE_Arms
.head 6 -  Call SetTblRowColor(hWndForm, COLOR_Jade)
.head 6 -  Break
.head 5 +  Case APPROVE_Tts
.head 6 -  Call SetTblRowColor(hWndForm, COLOR_Purple)
.head 6 -  Break
.head 5 +  Case APPROVE_Check
.head 6 -  Call SetTblRowColor(hWndForm, COLOR_DarkBlue)
.head 6 -  Break
.head 5 +  Case APPROVE_Groups
.head 6 -  Call SetTblRowColor(hWndForm, COLOR_DarkGreen)
.head 6 -  Break
.head 5 +  Case APPROVE_RepNBU
.head 6 -  Call SetTblRowColor(hWndForm, COLOR_MidnightBlue)
.head 6 -  Break
.head 5 +  Case APPROVE_Acc
.head 6 -  Call SetTblRowColor(hWndForm, COLOR_Burgundy)
.head 6 -  Break
.head 5 +  Case APPROVE_Func
.head 6 -  Call SetTblRowColor(hWndForm, COLOR_MidnightBlue)
.head 6 -  Break
.head 5 +  Case APPROVE_Rep
.head 6 -  Call SetTblRowColor(hWndForm, COLOR_Jade)
.head 6 -  Break
.head 5 +  Case APPROVE_Ref
.head 6 -  Call SetTblRowColor(hWndForm, COLOR_DarkGreen)
.head 6 -  Break
.head 5 +  Default
.head 6 -  Break
.head 4 +  If colGrantorId = nMyUserId and GetUserLoginName() != 'BARS'
.head 5 -  Call XSalTblSetRowBackColor(hWndForm, lParam, SalColorFromRGB(255, 200, 200))
.head 3 +  On UM_Update
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  !
.head 4 +  If ApproveResources()
.head 5 -  Call SqlCommitEx(hSql, "")
.head 4 +  Else
.head 5 -  Call SqlRollbackEx(hSql, "")
.head 4 -  !
.head 4 -  Call SalPostMsg(hWndForm, UM_Populate, 0, 0)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_Activate
.head 4 -  Call cMenu.Enable(wParam)
.head 3 +  On UM_MenuComponentShow
.head 4 -  Call cMenu.ShowMenu(wParam, lParam)
.head 3 +  On SAM_Destroy
.head 4 -  Call cMenu.Kill()
.head 4 -  Call SalSendClassMessage(SAM_Destroy, 0, 0)
.head 1 +  Table Window: tbl_Substitutes
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Делигирование прав другим пользователям
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
.head 3 -  Maximum Rows in Memory: 5000
.head 3 -  Discardable? No
.head 2 -  Description: Замены в команде игроков
.head 2 +  Named Menus
.head 3 +  Menu: menuTeamSubst
.head 4 -  Resource Id: 18388
.head 4 -  Title: (untitled)
.head 4 -  Description:
.head 4 -  Enabled when:
.head 4 -  Status Text:
.head 4 -  Menu Item Name:
.head 4 +  Menu Item: &Перечитать
.head 5 -  Resource Id: 18389
.head 5 -  Keyboard Accelerator: Ctrl+R
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg( pbRefresh, SAM_Click, 0, 0 )
.head 5 -  Menu Item Name:
.head 4 +  Menu Item: Пе&чать...
.head 5 -  Resource Id: 18390
.head 5 -  Keyboard Accelerator: Ctrl+P
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg( pbPrint, SAM_Click, 0, 0 )
.head 5 -  Menu Item Name:
.head 4 -  Menu Separator
.head 4 +  Menu Item: &Искать...
.head 5 -  Resource Id: 18391
.head 5 -  Keyboard Accelerator: Ctrl+F
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call TblFindString( hWndForm, DFIND_First )
.head 5 -  Menu Item Name:
.head 4 +  Menu Item: Искать &следующий...
.head 5 -  Resource Id: 18392
.head 5 -  Keyboard Accelerator: Ctrl+G
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call TblFindString( hWndForm, DFIND_Again )
.head 5 -  Menu Item Name:
.head 4 +  Menu Item: &Фильтр...
.head 5 -  Resource Id: 18393
.head 5 -  Keyboard Accelerator: Ctrl+T
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg( pbFilter, SAM_Click, 0, 0 )
.head 5 -  Menu Item Name:
.head 4 -  Menu Separator
.head 4 +  Menu Item: &Значение из справочника...
.head 5 -  Resource Id: 18394
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg( pbDetails, SAM_Click, 0, 0 )
.head 5 -  Menu Item Name:
.head 4 +  Menu Item: &Добавить
.head 5 -  Resource Id: 18395
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg( pbIns, SAM_Click, 0, 0 )
.head 5 -  Menu Item Name:
.head 4 +  Menu Item: &Удалить
.head 5 -  Resource Id: 18396
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg( pbDel, SAM_Click, 0, 0 )
.head 5 -  Menu Item Name:
.head 4 +  Menu Item: &Сохранить
.head 5 -  Resource Id: 18397
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg( pbUpdate, SAM_Click, 0, 0 )
.head 5 -  Menu Item Name:
.head 4 -  Menu Separator
.head 4 +  Menu Item: В&ыход
.head 5 -  Resource Id: 18398
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalDestroyWindow( hWndForm )
.head 5 -  Menu Item Name:
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
.head 6 -  Left:   0.517"
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
.head 6 -  Left:   0.95"
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
.head 6 -  Left:   1.383"
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
.head 5 -  Resource Id: 37623
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
.head 6 -  Left:   2.483"
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
.head 6 -  Left:   2.917"
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
.head 6 +  On SAM_Create
.head 7 -  ! Set pbDetails.strTip = 'Получить значение из справочника'
.head 7 -  Set pbDetails.strTip = CurrentLangTable.GetAtomTitle('tbl_Substitutes.cBTipDetails')
.head 6 +  On SAM_Click
.head 7 +  If SalTblQueryFocus( hWndForm, nRow, hCol ) 
.head 8 -  Call SalSendMsg( hCol, SAM_DoubleClick, 0, nRow )
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 40
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.35"
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
.head 5 -  Resource Id: 37624
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
.head 5 -  Resource Id: 37625
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  1.95"
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  1.95"
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 +  Option Button: obAllActive
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.633"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.433"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \Bars98\RESOURCE\BMP\SHOWITEM.BMP
.head 5 -  Picture Transparent Color: None
.head 5 -  Button Style: Check
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 +  If obAllActive
.head 8 -  Set tbl_Substitutes.strSqlPopulate = 
"SELECT id_who,id_who,s1.logname,s1.fio,id_whom,id_whom,s2.logname,s2.fio,date_start,date_finish,
        staff_substitute.rowid
 INTO :hWndForm.tbl_Substitutes.colID_WHO,:hWndForm.tbl_Substitutes.colIDW,
      :hWndForm.tbl_Substitutes.colLOGIN_WHO,:hWndForm.tbl_Substitutes.colFIO_WHO,
      :hWndForm.tbl_Substitutes.colID_WHOM,:hWndForm.tbl_Substitutes.colIDWM,
      :hWndForm.tbl_Substitutes.colLOGIN_WHOM,:hWndForm.tbl_Substitutes.colFIO_WHOM,
      :hWndForm.tbl_Substitutes.colSTART,:hWndForm.tbl_Substitutes.colFINISH,:hWndForm.tbl_Substitutes.colRowId
 FROM staff_substitute, staff s1, staff s2
 WHERE s1.id=id_who and s2.id=id_whom 
   and (date_finish is null or date_finish>=:dSysDate) 
   and (date_start  is null or date_start <=:dSysDate)
 ORDER BY 1"
.head 7 +  Else
.head 8 -  Set tbl_Substitutes.strSqlPopulate = 
"SELECT id_who,id_who,s1.logname,s1.fio,id_whom,id_whom,s2.logname,s2.fio,date_start,date_finish,
        staff_substitute.rowid
 INTO :hWndForm.tbl_Substitutes.colID_WHO,:hWndForm.tbl_Substitutes.colIDW,
      :hWndForm.tbl_Substitutes.colLOGIN_WHO,:hWndForm.tbl_Substitutes.colFIO_WHO,
      :hWndForm.tbl_Substitutes.colID_WHOM,:hWndForm.tbl_Substitutes.colIDWM,
      :hWndForm.tbl_Substitutes.colLOGIN_WHOM,:hWndForm.tbl_Substitutes.colFIO_WHOM,
      :hWndForm.tbl_Substitutes.colSTART,:hWndForm.tbl_Substitutes.colFINISH,:hWndForm.tbl_Substitutes.colRowId
 FROM staff_substitute, staff s1, staff s2
 WHERE s1.id=id_who and s2.id=id_whom
 ORDER BY 1"
.head 7 -  ! Call Debug(tbl_Substitutes.strSqlPopulate)
.head 7 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 7 -  Call SalWaitCursor(FALSE)
.head 6 +  On SAM_TooltipSetText
.head 7 -  ! Return XSalTooltipSetText(lParam, 'Показать ' || IifS(obAllActive, 'вс', 'активны') || 'е делегации')
.head 7 -  Return XSalTooltipSetText(lParam, IifS(obAllActive,
       CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTShowAllDelegation'),
       CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTShowActiveDelegation')))
.head 2 +  Contents
.head 3 +  Column: colRowId
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
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
.head 3 +  Column: colID_WHO
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кому
(Код)
.head 4 -  Visible? Yes
.head 4 -  Editable? Class Default
.head 4 -  Maximum Data Length: 4
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.717"
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
.head 4 +  Message Actions
.head 5 +  On SAM_DoubleClick
.head 6 +  If dFINISH and colFINISH < dSysDate and not SalTblQueryRowFlags ( hWndForm, lParam, ROW_New )
.head 7 -  Return FALSE
.head 6 +  If FunNSIGetFiltered( 'STAFF', 'FIO', 'nvl(active,0)=1', strUId, strUName )
.head 7 -  Set MyValue = SalStrToNumber( strUId )
.head 7 -  Set colFIO_WHO = strUName
.head 7 -  Call SalTblSetRowFlags( hWndForm, lParam, ROW_Edited, TRUE )
.head 5 +  On SAM_SetFocus
.head 6 +  If colFINISH
.head 7 -  Set dFINISH = colFINISH
.head 7 -  Set nID_WHO = colID_WHO
.head 5 +  On SAM_AnyEdit
.head 6 +  If dFINISH < dSysDate
.head 7 -  Set colID_WHO = nID_WHO
.head 7 -  Call SalTblSetRowFlags( hWndForm, lParam, ROW_Edited, FALSE )
.head 3 +  Column: colLOGIN_WHO
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Рабочее
Имя
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.283"
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
.head 3 +  Column: colIDW
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
.head 3 +  Column: colFIO_WHO
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ф.И.О.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  3.0"
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
.head 3 +  Column: colID_WHOM
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: От кого
(Код)
.head 4 -  Visible? Yes
.head 4 -  Editable? Class Default
.head 4 -  Maximum Data Length: 4
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.786"
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
.head 4 +  Message Actions
.head 5 +  On SAM_DoubleClick
.head 6 +  If dFINISH and colFINISH < dSysDate and not SalTblQueryRowFlags ( hWndForm, lParam, ROW_New )
.head 7 -  Return FALSE
.head 6 +  If FunNSIGetFiltered( 'STAFF', 'FIO', 'nvl(active,0)=1', strUId, strUName )
.head 7 -  Set MyValue = SalStrToNumber( strUId )
.head 7 -  Set colFIO_WHOM = strUName
.head 7 -  Call SalTblSetRowFlags( hWndForm, lParam, ROW_Edited, TRUE )
.head 5 +  On SAM_SetFocus
.head 6 +  If colFINISH
.head 7 -  Set dFINISH = colFINISH
.head 7 -  Set nID_WHOM = colID_WHOM
.head 5 +  On SAM_AnyEdit
.head 6 +  If dFINISH < dSysDate
.head 7 -  Set colID_WHOM = nID_WHOM
.head 7 -  Call SalTblSetRowFlags( hWndForm, lParam, ROW_Edited, FALSE )
.head 3 +  Column: colLOGIN_WHOM
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Рабочее
Имя
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.25"
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
.head 3 +  Column: colIDWM
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
.head 3 +  Column: colFIO_WHOM
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ф.И.О.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  3.0"
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
.head 3 +  Column: colSTART
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: На период
с
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.243"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Date
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
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Set dSTART = DATETIME_Null
.head 6 +  If colSTART
.head 7 -  Set dSTART = colSTART
.head 5 +  ! On SAM_AnyEdit
.head 6 +     If dFINISH and dFINISH < dSysDate and not SalTblQueryRowFlags ( hWndForm, lParam, ROW_New )
.head 7 -                        Set colSTART = dSTART
.head 7 -                        Call SalTblSetRowFlags( hWndForm, lParam, ROW_Edited, FALSE )
.head 5 +  On SAM_Validate
.head 6 +  If colSTART and colFINISH and colFINISH < colSTART
.head 7 -  ! Call SalMessageBox('Несоответствие значений дат периода!', 'Ошибка!', MB_IconStop | MB_Ok)
.head 7 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTNonValuesDatesPeriod'),
     CurrentLangTable.GetAtomTitle('cTErr'), MB_IconStop | MB_Ok)
.head 7 -  ! Set colSTART = dSTART
.head 7 -  Return VALIDATE_Cancel
.head 6 +  Else
.head 7 -  Return VALIDATE_Ok
.head 3 +  Column: colFINISH
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: На период
по
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  Default
.head 4 -  Width Editable? Yes
.head 4 -  Format: Date
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
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Set dFINISH = DATETIME_Null
.head 6 +  If colFINISH
.head 7 -  Set dFINISH = colFINISH
.head 5 +  ! On SAM_AnyEdit
.head 6 +     If dFINISH and dFINISH < dSysDate and not SalTblQueryRowFlags ( hWndForm, lParam, ROW_New )
.head 7 -                       Set colFINISH = dFINISH
.head 7 -                       Call SalTblSetRowFlags( hWndForm, lParam, ROW_Edited, FALSE )
.head 5 +  On SAM_Validate
.head 6 +  If (colFINISH and colFINISH < dSysDate) or
   (colSTART and colFINISH and (colFINISH < colSTART or colFINISH < dSysDate))
.head 7 -  ! Call SalMessageBox( 'Несоответствие значений дат периода!', 'Ошибка!', MB_IconStop | MB_Ok)
.head 7 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTNonValuesDatesPeriod'),
     CurrentLangTable.GetAtomTitle('cTErr'), MB_IconStop | MB_Ok)
.head 7 -  ! Set colFINISH = dFINISH
.head 7 -  Return VALIDATE_Cancel
.head 6 +  Else
.head 7 -  Return VALIDATE_Ok
.head 3 +  ! Column: colRDate1
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
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
.end
.head 4 -                 List Values 
.head 4 -                 Message Actions 
.head 3 +  ! Column: colRDate2
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
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
.end
.head 4 -                 List Values 
.head 4 -                 Message Actions 
.head 2 +  Functions
.head 3 +  Function: GrantAddRoles
.head 4 -  Description: Награнтить дополнительные роли (для функций АРМов)
! NB - Для функции обязательна роль DBA !
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nIdFrom		! Чьи роли
.head 5 -  Number: nIdTo		! Кому
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Boolean: fRet
.head 5 -  String: dbaSqlSentence
.head 5 -  String: strLogNameTo
.head 5 -  String: strLogName
.head 5 -  String: strNameTo
.head 5 -  String: strName
.head 4 +  Actions
.head 5 +  If SqlPrepareAndExecute(hSql(),
"SELECT UPPER(logname), fio INTO :strLogName, :strName FROM staff WHERE id = :nIdFrom")
.head 6 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 5 -  Set fRet = SqlPrepareAndExecute(hSql(),
"SELECT UPPER(logname), fio INTO :strLogNameTo, :strNameTo FROM staff WHERE id = :nIdTo")
.head 5 +  If fRet
.head 6 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 5 +  Else
.head 6 -  Return FALSE
.head 5 -  !
.head 5 -  Set fRet = SqlPrepareAndExecute(hSql(),
"SELECT DISTINCT 'GRANT '|| UPPER(b.rolename) ||' TO " || strLogNameTo || "'
   INTO :dbaSqlSentence
   FROM operlist b, operapp c, applist_staff d
  WHERE b.rolename IS NOT NULL 
    AND d.codeapp  = c.codeapp 
    AND c.codeoper = b.codeoper 
    AND d.id = :nIdFrom")
.head 5 +  If fRet
.head 6 -  ! Передача системных прав на АРМы пользователя strName (nIdFrom, strLogName) 
  пользователю strNameTo (nIdTo, strLogNameTo)
.head 6 -  Call SaveInfoToLog(CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTToLogArms') || ' ' || 
     strName || '(' || Str(nIdFrom) || ',' || strLogName || ') ' || 
     CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTToLogForUser') || ' ' || 
     strNameTo || '(' || Str(nIdTo) || ',' || strLogNameTo || ')')
.head 6 +  While SqlFetchNext( hSql(), nFetchRes) 
.head 7 +  When SqlError
.head 8 -  Return FALSE
.head 7 +  If NOT SqlPrepareAndExecute(hSqlAux(), dbaSqlSentence)
.head 8 -  ! Ошибка при выполнении: dbaSqlSentence
.head 8 -  Call SaveErrorToLog(CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTErrExecute') || ': ' || dbaSqlSentence)
.head 6 -  ! Передача системных прав на АРМы завершена
.head 6 -  Call SaveInfoToLog(CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTToLogArmsOk'))
.head 6 -  Set fRet = SqlPrepareAndExecute(hSql(), "
    SELECT DISTINCT 'GRANT '|| UPPER(b.role2edit) ||' TO " || strLogNameTo || "'
    INTO :dbaSqlSentence
    FROM references b, refapp c, applist_staff d
    WHERE role2edit is not null and
          d.codeapp=c.codeapp   and
          c.tabid=b.tabid       and
          d.id=:nIdFrom")
.head 6 +  If fRet
.head 7 -  ! Передача системных прав на справочники пользователя strName (nIdFrom,nstrLogName) 
  пользователю strNameTo (nIdTo, strLogNameTo)
.head 7 -  Call SaveInfoToLog(CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTToLogRef') || ' ' || 
     strName || '(' || Str(nIdFrom) || ',' || strLogName || ') ' || 
     CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTToLogForUser') || ' ' || 
     strNameTo || '(' || Str(nIdTo) || ',' || strLogNameTo || ')')
.head 7 +  While SqlFetchNext(hSql(), nFetchRes)
.head 8 +  When SqlError
.head 9 -  Return FALSE
.head 8 +  If NOT SqlPrepareAndExecute(hSqlAux(), dbaSqlSentence)
.head 9 -  ! Ошибка при выполнении: dbaSqlSentence
.head 9 -  Call SaveErrorToLog(CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTErrExecute') || ': ' || dbaSqlSentence)
.head 7 -  ! Передача системных прав на справочники завершена
.head 7 -  Call SaveInfoToLog(CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTToLogRefOk'))
.head 5 -  Return fRet
.head 3 +  Function: RevokeAddRoles
.head 4 -  Description: Забрать роли от пользователя
! NB - Для функции обязательна роль DBA !
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nIdFrom		! От кого
.head 5 -  Number: nId		! Чьи роли
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Boolean: fRet
.head 5 -  String: dbaSqlSentence
.head 5 -  String: strLogNameFrom
.head 5 -  String: strLogName
.head 5 -  String: strNameFrom
.head 5 -  String: strName
.head 4 +  Actions
.head 5 +  If SqlPrepareAndExecute(hSql(), 
"SELECT UPPER(logname),fio INTO :strLogName,:strName FROM staff WHERE id=:nId")
.head 6 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 5 -  Set fRet = SqlPrepareAndExecute(hSql(), 
"SELECT UPPER(logname),fio INTO :strLogNameFrom,:strNameFrom FROM staff WHERE id=:nIdFrom")
.head 5 +  If fRet
.head 6 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 5 +  Else
.head 6 -  Return FALSE
.head 5 -  !
.head 5 -  Set fRet = SqlPrepareAndExecute(hSql(), 
"SELECT DISTINCT 'REVOKE '|| UPPER(b.rolename) ||' FROM " || strLogNameFrom || "'
   INTO :dbaSqlSentence
   FROM operlist b, operapp c, applist_staff d, dba_role_privs r
  WHERE b.rolename is not null 
    and r.granted_role = upper(b.rolename) 
    and r.grantee = :strLogNameFrom 
    and d.codeapp = c.codeapp 
    and c.codeoper = b.codeoper 
    and d.id = :nId 
    and b.rolename not in (SELECT e.rolename
                             FROM applist_staff i, operlist e, operapp f
                            WHERE i.codeapp = f.codeapp 
                              and f.codeoper = e.codeoper 
                              and i.id = :nIdFrom 
                              and e.rolename is not null)
    and upper(b.rolename) not in ( select rolename from barsroles where upper(roletype) = upper('u') )")
.head 5 +  If fRet
.head 6 -  ! Аннулирование системных прав на АРМы пользователя strName (nId, strLogName) 
  пользователю strNameFrom (nIdFrom, strLogNameFrom)
.head 6 -  Call SaveInfoToLog(CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTToLogArmsNull') || ' ' || 
     strName || '(' || Str(nId) || ',' || strLogName || ') ' || 
     CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTToLogForUser') || ' ' || 
     strNameFrom || '(' || Str(nIdFrom) || ',' || strLogNameFrom || ')')
.head 6 +  While SqlFetchNext(hSql(), nFetchRes)
.head 7 +  When SqlError
.head 8 -  Return FALSE
.head 7 +  If not SqlPrepareAndExecute(hSqlAux(), dbaSqlSentence)
.head 8 -  ! Ошибка при выполнении: dbaSqlSentence
.head 8 -  Call SaveErrorToLog(CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTErrExecute') || ': ' || dbaSqlSentence)
.head 7 -  Call SaveInfoToLog('SEC. ' || dbaSqlSentence)
.head 6 -  ! Аннулирование системных прав на АРМы завершено
.head 6 -  Call SaveInfoToLog(CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTToLogArmsNullOk'))
.head 6 -  Set fRet = SqlPrepareAndExecute(hSql(), 
"SELECT DISTINCT 'REVOKE '|| UPPER(b.role2edit) ||' FROM " || strLogNameFrom || "'
   INTO :dbaSqlSentence
   FROM references b, refapp c, applist_staff d, dba_role_privs r
  WHERE b.role2edit IS NOT NULL 
    and r.granted_role = upper(b.role2edit) 
    and r.grantee = :strLogNameFrom 
    and d.codeapp = c.codeapp 
    and c.tabid = b.tabid 
    and d.id = :nId 
    and b.role2edit not in ( SELECT e.role2edit
                               FROM applist_staff i, references e, refapp f
                              WHERE i.codeapp = f.codeapp 
                                and f.tabid = e.tabid 
                                and i.id = :nIdFrom 
                                and e.role2edit is not null)
    and upper(b.role2edit) not in ( select rolename from barsroles where upper(roletype) = upper('u') )")
.head 6 +  If fRet
.head 7 -  ! Аннулирование системных прав на справочники пользователя strName (nId, strLogName) 
  пользователю strNameFrom (nIdFrom, strLogNameFrom)
.head 7 -  Call SaveInfoToLog(CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTToLogRefNull') || ' ' || 
     strName || '(' || Str(nId) || ',' || strLogName || ') ' || 
     CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTToLogForUser') || ' ' || 
     strNameFrom || '(' || Str(nIdFrom) || ',' || strLogNameFrom || ')')
.head 7 +  While SqlFetchNext(hSql(), nFetchRes)
.head 8 +  When SqlError
.head 9 -  Return FALSE
.head 8 +  If not SqlPrepareAndExecute(hSqlAux(), dbaSqlSentence)
.head 9 -  ! Ошибка при выполнении: dbaSqlSentence
.head 9 -  Call SaveErrorToLog(CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTErrExecute') || ': ' || dbaSqlSentence)
.head 7 -  ! Аннулирование системных прав на справочники завершено
.head 7 -  Call SaveInfoToLog(CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTToLogRefNullOk'))
.head 5 -  Return fRet
.head 3 +  Function: DisableUserAccount
.head 4 -  Description: Закрыть пользовательский логин
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nId
.head 5 -  Date/Time: dtFrom
.head 5 -  Date/Time: dtUpto
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strStaffUpdate
.head 5 -  String: strLog
.head 4 +  Actions
.head 5 -  ! Закрыт пользовательский логин id=nId
.head 5 -  Set strLog = CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTLoginClosed') || ' id=' || SalNumberToStrX(nId, 0)
.head 5 +  If dtFrom != DATETIME_Null OR dtUpto != DATETIME_Null
.head 6 -  ! на период
.head 6 -  Set strLog = strLog || ' ' || CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTPeriod') || ' '
.head 6 +  If dtFrom != DATETIME_Null
.head 7 -  ! c dtFrom
.head 7 -  Set strLog = strLog || ' ' || CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTFrom') || ' ' ||
    SalFmtFormatDateTime(dtFrom,  'dd/MM/yyyy')
.head 6 +  If dtUpto != DATETIME_Null
.head 7 -  ! по dtUpto
.head 7 -  Set strLog = strLog || ' ' || CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTTo') || ' ' ||
    SalFmtFormatDateTime(dtUpto, 'dd/MM/yyyy')
.head 5 -  !
.head 5 -  Set strStaffUpdate = "bars_useradm.lock_user(nId, dtFrom, dtUpto)"
.head 5 +  If SqlPLSQLCommand(hSql(), strStaffUpdate)
.head 6 -  Call SqlCommitEx(hSql(), strLog)
.head 6 -  Return TRUE
.head 5 +  Else
.head 6 -  Call SqlRollback(hSql())
.head 6 -  Return FALSE
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  : cMenu
.head 4 -  Class: cChildMenuEngine
.head 3 -  !
.head 3 -  String: strUId
.head 3 -  String: strUName
.head 3 -  String: strLockMsg
.head 3 -  !
.head 3 -  Number: nRow
.head 3 -  Window Handle: hCol
.head 3 -  !
.head 3 -  Date/Time: dFINISH
.head 3 -  Date/Time: dSTART
.head 3 -  Number: nID_WHOM
.head 3 -  Number: nID_WHO
.head 3 -  Date/Time: dSysDate
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTWndTitle'))
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  !
.head 4 -  Set dSysDate = SalFmtFormatStrDateTime(SalFmtFormatDateTime(SalDateCurrent(), 'dd.MM.yyyy'), 'dd.MM.yyyy')
.head 4 -  !
.head 4 -  Set hWndForm.tbl_Substitutes.nFlags = GT_NoRet
.head 4 -  Set hWndForm.tbl_Substitutes.strFilterTblName = "STAFF_SUBSTITUTE"
.head 4 -  Set hWndForm.tbl_Substitutes.strPrintFileName = "Subst.txt"
.head 4 -  Set hWndForm.tbl_Substitutes.strSqlPopulate = 
"SELECT id_who, id_who, s1.logname, s1.fio, id_whom, id_whom, s2.logname, s2.fio, 
        date_start, date_finish, staff_substitute.rowid
   INTO :hWndForm.tbl_Substitutes.colID_WHO, :hWndForm.tbl_Substitutes.colIDW, :hWndForm.tbl_Substitutes.colLOGIN_WHO,
        :hWndForm.tbl_Substitutes.colFIO_WHO, :hWndForm.tbl_Substitutes.colID_WHOM, :hWndForm.tbl_Substitutes.colIDWM,
        :hWndForm.tbl_Substitutes.colLOGIN_WHOM, :hWndForm.tbl_Substitutes.colFIO_WHOM, :hWndForm.tbl_Substitutes.colSTART,
        :hWndForm.tbl_Substitutes.colFINISH, :hWndForm.tbl_Substitutes.colRowId
   FROM staff_substitute, staff s1, staff s2
  WHERE s1.id=id_who and s2.id=id_whom
  ORDER BY 1"
.head 4 -  Set hWndForm.tbl_Substitutes.strSqlInsert = 
"INSERT INTO staff_substitute(id_who, id_whom, date_start, date_finish) 
 VALUES (:hWndForm.tbl_Substitutes.colID_WHO, :hWndForm.tbl_Substitutes.colID_WHOM, 
         :hWndForm.tbl_Substitutes.colSTART, :hWndForm.tbl_Substitutes.colFINISH)"
.head 4 -  Set hWndForm.tbl_Substitutes.strSqlDelete = 
"DELETE FROM staff_substitute 
  WHERE id_who  = :hWndForm.tbl_Substitutes.colID_WHO 
    AND id_whom = :hWndForm.tbl_Substitutes.colID_WHOM"
.head 4 -  Set hWndForm.tbl_Substitutes.strSqlUpdate = 
"UPDATE staff_substitute 
    SET id_who = :hWndForm.tbl_Substitutes.colID_WHO,
        id_whom = :hWndForm.tbl_Substitutes.colID_WHOM, 
        date_start = :hWndForm.tbl_Substitutes.colSTART, 
        date_finish = :hWndForm.tbl_Substitutes.colFINISH
  WHERE rowid = :hWndForm.tbl_Substitutes.colRowId"
.head 4 -  Set obAllActive = FALSE
.head 4 -  ! Делигирование прав
.head 4 -  Call cMenu.Init(hWndForm, 'menuTeamSubst', CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTMenu'))
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On UM_Update
.head 4 -  Call SalMessageBeep(MB_IconAsterisk)
.head 4 -  ! Процедура делегирования или снятия полномочий сопровождается процедурой манипулирования 
  правами пользователей на системном уровне, которая может занять продолжительное время
.head 4 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTMsgProc'), 
     CurrentLangTable.GetAtomTitle('cTAt'), MB_IconAsterisk | MB_Ok)
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set nRow = TBL_MinRow
.head 4 +  While SalTblFindNextRow(hWndForm, nRow, ROW_New | ROW_MarkDeleted | ROW_Edited, 0)
.head 5 -  Call SalTblSetContext(hWndForm, nRow)
.head 5 -  ! If SalIsNull(colFINISH) or SalIsNull(colSTART)
.head 5 +  ! If SalIsNull(colSTART) and not SalIsNull(colFINISH)
.head 6 -                        Call SalMessageBeep(MB_IconStop)
.head 6 -  ! Call SalMessageBox('Недопустимо отсутствие значений в датах периода!', 'Ошибка!', MB_IconStop | MB_Ok)
.head 6 -                        Call SalMessageBox(CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTMsgValue2'),
     CurrentLangTable.GetAtomTitle('cTErr'), MB_IconStop | MB_Ok)
.head 6 -                        Call SalTblSetRowFlags(hWndForm, nRow, ROW_New | ROW_Edited, FALSE)
.head 5 +  If SalIsNull(colID_WHO) OR SalIsNull(colID_WHOM)
.head 6 -  Call SalMessageBeep(MB_IconStop)
.head 6 -  ! Недопустимо отсутствие значений в атрибутах "Кому" или "От Кого"!
.head 6 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTMsgValue'),
     CurrentLangTable.GetAtomTitle('cTErr'), MB_IconStop | MB_Ok)
.head 6 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New | ROW_Edited, FALSE)
.head 5 +  If SalTblQueryRowFlags(hWndForm, nRow, ROW_New)
.head 6 -  Call GrantAddRoles(colID_WHOM, colID_WHO)
.head 6 -  !
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Call SalMessageBeep(MB_IconAsterisk)
.head 6 -  ! Блокировать Login пользователя colFIO_WHOM
.head 6 -  Set strLockMsg = CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTMsgBlock') || ' ' || colFIO_WHOM
.head 6 +  If colSTART != DATETIME_Null OR colFINISH != DATETIME_Null
.head 7 -  ! на период
.head 7 -  Set strLockMsg = strLockMsg || ' ' || CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTPeriod') ||' '
.head 7 +  If colSTART  != DATETIME_Null
.head 8 -  ! c colSTART
.head 8 -  Set strLockMsg = strLockMsg || ' ' || CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTFrom') || ' '  ||
    SalFmtFormatDateTime( colSTART,  'dd/MM/yyyy' )
.head 7 +  If colFINISH != DATETIME_Null
.head 8 -  ! по colFINISH
.head 8 -  Set strLockMsg = strLockMsg || ' ' || CurrentLangTable.GetAtomTitle('tbl_Substitutes.cTTo') || ' ' ||
    SalFmtFormatDateTime( colFINISH, 'dd/MM/yyyy' )
.head 6 -  Set strLockMsg = strLockMsg || '?'
.head 6 +  If SalMessageBox(strLockMsg, CurrentLangTable.GetAtomTitle('cTAt'), MB_IconAsterisk | MB_YesNo | MB_DefButton2 ) = IDYES
.head 7 -  Call DisableUserAccount(colID_WHOM, colSTART, colFINISH)
.head 6 -  Call SalWaitCursor(TRUE)
.head 5 +  Else If SalTblQueryRowFlags(hWndForm, nRow, ROW_MarkDeleted)
.head 6 +  If RevokeAddRoles(colID_WHO, colID_WHOM)
.head 7 +  If SqlPrepareAndExecute(hSql(), "UPDATE staff SET rdate1 = null, rdate2 = null WHERE id = :colID_WHOM")
.head 8 -  Call SqlCommit(hSql())
.head 7 +  Else
.head 8 -  Call SqlRollback(hSql())
.head 5 +  Else If SalTblQueryRowFlags(hWndForm, nRow, ROW_Edited)
.head 6 -  Call RevokeAddRoles(colIDW, colIDWM)
.head 6 -  Call GrantAddRoles(colID_WHOM, colID_WHO)
.head 4 -  Call SalSendClassMessage(UM_Update, 0, 0)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On UM_Populate
.head 4 -  Call tbl_Substitutes.ReInitQueryString()
.head 4 -  Call SalSendClassMessage(UM_Populate, 0, 0)
.head 3 +  On SAM_Activate
.head 4 -  Call cMenu.Enable(wParam)
.head 3 +  On UM_MenuComponentShow
.head 4 -  Call cMenu.ShowMenu(wParam, lParam)
.head 3 +  On SAM_Destroy
.head 4 -  Call cMenu.Kill()
.head 4 -  Call SalSendClassMessage(SAM_Destroy, 0, 0)
.head 3 +  On SAM_FetchRowDone
.head 4 +  If hWndForm.tbl_Substitutes.colFINISH != DATETIME_Null and 
   hWndForm.tbl_Substitutes.colFINISH < dSysDate
or hWndForm.tbl_Substitutes.colSTART != DATETIME_Null and 
   hWndForm.tbl_Substitutes.colSTART > dSysDate
.head 5 -  Call XSalTblSetRowBackColor(hWndForm, lParam, COLOR_Gray)
.head 1 -  !
.head 1 +  Form Window: frm_Keeper		! new
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Сторож
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? No
.head 3 -  Initial State: Minimized
.head 3 -  Maximizable? Yes
.head 3 -  Minimizable? Yes
.head 3 -  System Menu? Yes
.head 3 -  Resizable? Yes
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  7.557"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 3.844"
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
.head 2 -  Description: Сторож
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
.head 3 +  Pushbutton: cpb_Timer
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cTimer
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: timer
.head 4 -  Window Location and Size
.head 5 -  Left:   0.214"
.head 5 -  Top:    0.531"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.292"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
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
.head 5 +  On UM_TimerFired
.head 6 -  Set bTblReset = FALSE
.head 6 -  Set nCount = 0
.head 6 -  Set mMess[0] = ''	! mess
.head 6 -  Set mMess[1] = ''	! type
.head 6 -  Set mMess[2] = ''	! date
.head 6 -  Set mMess[3] = ''	! bankdate
.head 6 -  Set mMess[4] = ''	! u_id
.head 6 -  Set mMess[5] = ''	! machine
.head 6 -  Set mMess[6] = ''	! u_logname
.head 6 -  Set mMess[7] = ''	! u_fio
.head 6 -  Set i = 0
.head 6 +  Loop
.head 7 +  If SqlPLSQLCommand( cSql.hSql(), "bars.bars_alerter_pop_msg(nRet,'SEC_WATCHER',nMsgn,sMsg,sParam1,sParam2,sParam3)" )
.head 8 +  ! error
.head 9 -  ! ORA-20000: Error: 1 sending on pipe
ORA-06512: at "BARS.BARS_ALERTER_PUSH_MSG", line 33
ORA-06512: at "BARS.TI_SEC_AUDIT", line 15
ORA-04088: error during execution of trigger 'BARS.TI_SEC_AUDIT'
.head 8 +  If nRet=0
.head 9 -  Break
.head 8 -  ! фильтруем - какие нужны данному юзеру
.head 8 -  !
.head 8 -  ! если нужны
.head 8 +  If SalStrScan( SalStrUpperX(sTypeErr), SalStrUpperX(sParam1) ) != -1 AND
   SalStrToDate( sKD ) < SalStrToDate( SalStrMidX( sParam2, 0, SalStrScan( sParam2, '@' ) ) )
.head 9 -  Set mMess[0] = sMsg
.head 9 -  Set mMess[1] = sParam1
.head 9 -  Set mMess[2] = SalStrMidX( sParam2, 0, SalStrScan( sParam2, '@' ) )
.head 9 -  Set mMess[3] = SalStrMidX( sParam2, SalStrScan( sParam2, '@' )+1, SalStrLength( sParam2 )-SalStrScan( sParam2, '@' )+1 )
.head 9 -  Set mMess[4] = SalStrMidX( sParam3, 0, SalStrScan( sParam3, '@' ) )
.head 9 -  Set mMess[5] = SalStrMidX( sParam3, SalStrScan( sParam3, '@' )+1, SalStrLength( sParam3 )-SalStrScan( sParam3, '@' )+1 )
.head 9 +  If SqlPrepareAndExecute( cSql.hSql(), "
  SELECT logname, fio INTO :sLog, :sFio
  FROM staff WHERE id=to_char(:mMess[4])") and SqlFetchNext( cSql.hSql(), nFetchRes )
.head 10 -  Set mMess[6] = sLog
.head 10 -  Set mMess[7] = sFio
.head 9 -  Set i = i + 1
.head 9 -  Set nCount = i
.head 9 +  If not IsWindow( hWinErr )
.head 10 -  Set hWinErr = SalCreateWindow( frm_Err, hWndParent )
.head 9 +  Else
.head 10 -  Call SalSendMsg( hWndForm, UM_Populate, 0, 0 )
.head 10 -  Call SalBringWindowToTop( hWinErr )
.head 7 +  Else
.head 8 -  ! Call Debug('Ошибка выполнения pop_msg')
.head 8 -  Call Debug(CurrentLangTable.GetAtomTitle('frm_Keeper.cTErrExecute') || ' pop_msg')
.head 8 -  Break
.head 3 +  Data Field: dfClock
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cClock
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 8
.head 5 -  Data Type: Date/Time
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.014"
.head 6 -  Top:    0.229"
.head 6 -  Width:  3.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.476"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Center
.head 5 -  Format: hhh:mm:ss
.head 5 -  Country: Default
.head 5 -  Font Name: Arial
.head 5 -  Font Size: 20
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Child Table: tblT
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.029"
.head 6 -  Top:    0.792"
.head 6 -  Width:  7.329"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 1.781"
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
.head 5 +  Column: colType
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Тип сообщения
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
.head 5 +  Column: colComm
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Тип сообщения
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
.head 5 +  Column: colAlarm
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Обработать
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  1.5"
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
.head 4 -  Functions
.head 4 -  Window Variables
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren( hWndForm, UM_QueryLabelText, 0, 0 )
.head 6 -  Call SalSendMsg( tblT, UM_Populate, 0, 0 )
.head 5 +  On UM_Populate
.head 6 -  Call SalTblPopulate( tblT, cSql.hSql(), "
  SELECT sec_rectype, sec_typecomm
  INTO :colType, :colComm
  FROM sec_rectype
  WHERE sec_alarm='Y'", TBL_FillAll )
.head 5 +  On SAM_FetchRowDone
.head 6 +  If SalStrScan( SalStrUpperX(sTypeErr), SalStrUpperX(colType) ) != -1
.head 7 -  Set colAlarm = 1
.head 6 +  Else
.head 7 -  Set colAlarm = 0
.head 3 +  Pushbutton: pbKeep
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Спрятать
.head 4 -  Window Location and Size
.head 5 -  Left:   0.514"
.head 5 -  Top:    2.771"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.45"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Relation.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set nRowT = TBL_MinRow
.head 6 +  Loop
.head 7 +  If SalTblFindNextRow( tblT, nRowT, 0, 0 )
.head 8 -  Call SalTblSetContext( tblT, nRowT )
.head 8 +  If SalTblQueryRowFlags( tblT, nRowT, ROW_Edited )
.head 9 -  ! сохранять?
.head 9 -  ! If SalMessageBox( 'Были изменены настройки.
  Сохранить изменения?', 'Внимание!', MB_IconQuestion|MB_YesNo ) = IDYES
.head 9 +  If SalMessageBox( CurrentLangTable.GetAtomTitle('frm_Keeper.cTMsg1') || PutCrLf() || 
  CurrentLangTable.GetAtomTitle('frm_Keeper.cTMsg2'), 
  CurrentLangTable.GetAtomTitle('cTAt'), MB_IconQuestion|MB_YesNo ) = IDYES
.head 10 -  ! сохраняем настройки
.head 10 -  Call SalSendMsg( pbOk, SAM_Click, 0, 0 )
.head 9 +  Else
.head 10 -  Call SalSendMsg( tblT, UM_Populate, 0, 0 )
.head 9 -  Break
.head 7 +  Else
.head 8 -  Break
.head 6 -  Call VisWinShow( hWndForm, SHOW_Minimized )
.head 3 +  Pushbutton: pbOk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Применить
.head 4 -  Window Location and Size
.head 5 -  Left:   1.857"
.head 5 -  Top:    2.771"
.head 5 -  Width:  1.214"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.45"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Apply.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set nRowT = TBL_MinRow
.head 6 +  Loop
.head 7 +  If SalTblFindNextRow( tblT, nRowT, 0, 0 )
.head 8 -  Call SalTblSetContext( tblT, nRowT )
.head 8 +  If SalTblQueryRowFlags( tblT, nRowT, ROW_Edited )
.head 9 -  ! сохраняем настройки
.head 9 +  If tblT.colAlarm = 1
.head 10 -  Set sTypeErr = sTypeErr || ' ' || tblT.colType
.head 9 +  Else
.head 10 -  Set sTypeErr = SalStrTrimX( SalStrReplaceX( sTypeErr, SalStrScan( SalStrUpperX(sTypeErr), SalStrUpperX(tblT.colType) ), SalStrLength(tblT.colType), '' ) )
.head 9 -  Call SalUseRegistry(TRUE,GetCompanyName())
.head 9 -  Call SalSetProfileString( 'DBSO','TypeErr', sTypeErr, GetProductName() )
.head 9 -  Call SalUseRegistry(FALSE,GetCompanyName())
.head 9 -  Call SalTblSetRowFlags( tblT, nRowT, ROW_Edited, FALSE )
.head 7 +  Else
.head 8 -  Break
.head 3 +  Pushbutton: pbExit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отменить
.head 4 -  Window Location and Size
.head 5 -  Left:   5.7"
.head 5 -  Top:    2.771"
.head 5 -  Width:  1.186"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.45"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Discard.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalDestroyWindow( hWndForm )
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  String: sInterval
.head 3 -  ! String: sNumErr
.head 3 -  String: sTypeErr
.head 3 -  Number: nInterval
.head 3 -  ! Number: nNumErr
.head 3 -  ! Number: nNumErr1
.head 3 -  String: sPipeName
.head 3 -  Number: nRes
.head 3 -  !
.head 3 -  : cSql
.head 4 -  Class: cABSConnect
.head 3 -  ! Date/Time: dKD
.head 3 -  String: sKD
.head 3 -  ! Long String: mMess[*,8]
.head 3 -  Long String: mMess[8]
.head 3 -  Number: nCount
.head 3 -  !
.head 3 -  Number: nRet
.head 3 -  Number: nMsgn
.head 3 -  String: sMsg
.head 3 -  String: sParam1
.head 3 -  String: sParam2
.head 3 -  String: sParam3
.head 3 -  String: sLog
.head 3 -  String: sFio
.head 3 -  ! Boolean: bShowErr
.head 3 -  Boolean: bTblReset
.head 3 -  Number: nRowT
.head 3 -  Window Handle: hWndParent
.head 3 -  !
.head 3 -  Number: i
.head 3 -  Number: nWinX0
.head 3 -  Number: nWinY0
.head 3 -  Number: nWinWidth
.head 3 -  Number: nWinHeigh
.head 3 -  Number: ndfX
.head 3 -  Number: ndfY
.head 3 -  Number: ndfW
.head 3 -  Number: ndfH
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalWaitCursor( TRUE )
.head 4 -  Call SetWindowFont( hWndForm )
.head 4 -  Call SalSendMsgToChildren( hWndForm, UM_QueryLabelText, 0, 0 )
.head 4 -  Call SalSetWindowText( hWndForm, CurrentLangTable.GetAtomTitle('frm_Keeper.cTWndTitle') )
.head 4 -  Call XConnectGetParams( cSql )
.head 4 +  If NOT cSql.Connect()
.head 5 -  Return FALSE
.head 4 +  If SqlPLSQLCommand( cSql.hSql(), "BARS.BARS_ALERTER_CREATE_CHNL(nRes,'SEC_WATCHER',20480)" )
.head 5 +  If nRes != 0
.head 6 -  ! Call SalMessageBox( 'Ошибка создания pipe ('||Str(nRes)||')', 'Внимание!', MB_IconAsterisk )
.head 6 -  Call SalMessageBox( CurrentLangTable.GetAtomTitle('frm_Keeper.cTErrCreate') || ' pipe ('||Str(nRes)||')', 
  CurrentLangTable.GetAtomTitle('cTAt'), MB_IconAsterisk )
.head 6 -  Call SalSendMsg( hWndForm, SAM_Destroy, 0, 0 )
.head 4 -  !
.head 4 +  If NOT SqlPrepareAndExecute( cSql.hSql(), "
  SELECT  to_char(sysdate,'dd/MM/yyyy hh:mi:ss') INTO :sKD FROM dual" )
or NOT SqlFetchNext( cSql.hSql(), nFetchRes )
.head 5 -  Return FALSE
.head 4 -  Call SalUseRegistry(TRUE,GetCompanyName())
.head 4 -  Call SalGetProfileString('DBSO','ErrorCheckInterval','5',
      sInterval,GetProductName())
.head 4 -  Call SalGetProfileString('DBSO','TypeErr','',
      sTypeErr,GetProductName())
.head 4 -  Call SalUseRegistry(FALSE,GetCompanyName())
.head 4 -  Set nInterval = SalStrToNumber(sInterval)
.head 4 -  Call SalWaitCursor( FALSE )
.head 4 +  If sInterval != ''
.head 5 -  Call cpb_Timer.Init(nInterval, 0, TRUE)
.head 4 -  Call SalSetWindowSize( hWndForm, 7.6, 3.8 )
.head 3 +  On UM_Populate
.head 4 -  Set frm_Err.dfC = nCount
.head 4 +  If NOT bTblReset
.head 5 -  Call SalTblReset( frm_Err.tblMess )
.head 5 -  Set bTblReset = TRUE
.head 4 -  Set nCount = SalTblInsertRow( frm_Err.tblMess, TBL_MaxRow )
.head 4 -  Call SalTblSetRowFlags( frm_Err.tblMess, nCount, ROW_New, FALSE)
.head 4 -  Call SetTblRowColor( frm_Err.tblMess, COLOR_Red )
.head 4 -  Set frm_Err.tblMess.colMess = mMess[0]
.head 4 -  Set frm_Err.tblMess.colDat  = SalStrToDate(mMess[2])
.head 4 -  Set frm_Err.tblMess.colBdat = SalStrToDate(mMess[3])
.head 4 -  Set frm_Err.tblMess.colUser = mMess[4]
.head 4 -  Set frm_Err.tblMess.colMach = mMess[5]
.head 4 -  Set frm_Err.tblMess.colLog  = mMess[6]
.head 4 -  Set frm_Err.tblMess.colFio  = mMess[7]
.head 4 -  Call SalTblSetFocusRow( frm_Err.tblMess, 0)
.head 4 -  Call SalSendMsg( frm_Err.tblMess, SAM_TblDoDetails, 0, 0)
.head 4 -  Call SalMessageBeep( MB_IconAsterisk )
.head 3 +  On WM_Size
.head 4 -  Call SalGetWindowSize( hWndForm, nWinWidth, nWinHeigh )
.head 4 +  If nWinWidth >= 7.6
.head 5 +  If nWinHeigh < 3.8
.head 6 -  Call SalSetWindowSize( hWndForm, nWinWidth, 3.8 )
.head 4 +  Else
.head 5 +  If nWinHeigh < 3.8
.head 6 -  Call SalSetWindowSize(hWndForm, 7.6, 3.8 )
.head 5 +  Else
.head 6 -  Call SalSetWindowSize(hWndForm, 7.6, nWinHeigh )
.head 4 -  Call GetClientRect( hWndForm, nWinX0, nWinY0, nWinWidth, nWinHeigh )
.head 4 -  Call GetClientRect( dfClock, ndfX, ndfY, ndfW, ndfH )
.head 4 -  Call SalGetWindowLoc( hWndForm.frm_Keeper.dfClock, ndfX, ndfY )
.head 4 -  Call SalSetWindowLoc(dfClock,
       SalPixelsToFormUnits( hWndForm,nWinWidth/2-ndfW/2, FALSE  ),
       ndfY)
.head 4 -  !
.head 4 -  Call SalSetWindowSize( tblT,
       SalPixelsToFormUnits( hWndForm.frm_Keeper.tblT, nWinWidth, FALSE )-0.07,
       SalPixelsToFormUnits( hWndForm.frm_Keeper.tblT, nWinHeigh, TRUE )-1.65 )
.head 4 -  Call SalTblSetColumnWidth( tblT.colComm,
       SalPixelsToFormUnits( hWndForm.frm_Keeper.tblT.colComm, nWinWidth, FALSE )-2.4 )
.head 4 -  !
.head 4 -  Call SalGetWindowLoc( hWndForm.frm_Keeper.pbKeep, ndfX, ndfY )
.head 4 -  Call SalSetWindowLoc( pbKeep, ndfX,
       SalPixelsToFormUnits( hWndForm.frm_Keeper.pbKeep, nWinHeigh, TRUE )-0.65 )
.head 4 -  !
.head 4 -  Call SalGetWindowLoc( hWndForm.frm_Keeper.pbOk, ndfX, ndfY )
.head 4 -  Call SalSetWindowLoc( pbOk, ndfX,
       SalPixelsToFormUnits( hWndForm.frm_Keeper.pbOk, nWinHeigh, TRUE )-0.65 )
.head 4 -  !
.head 4 -  Call SalSetWindowLoc( pbExit,
       SalPixelsToFormUnits( hWndForm.frm_Keeper.pbExit, nWinWidth, FALSE )-1.6,
       SalPixelsToFormUnits( hWndForm.frm_Keeper.pbExit, nWinHeigh, TRUE )-0.65 )
.head 4 -  Call SalInvalidateWindow( hWndForm )
.head 3 +  On SAM_Destroy
.head 4 +  If nRes = 0
.head 5 +  If SqlPLSQLCommand( cSql.hSql(), "BARS.BARS_ALERTER_REMOVE_CHNL(nRes,'SEC_WATCHER')" )
.head 6 +  If nRes != 0
.head 7 -  ! Call SalMessageBox( 'Ошибка remove pipe ('||Str(nRes)||')', 'Внимание!', MB_IconAsterisk )
.head 7 -  Call SalMessageBox( CurrentLangTable.GetAtomTitle('cTErr') || ' remove pipe ('||Str(nRes)||')', 
  CurrentLangTable.GetAtomTitle('cTAt'), MB_IconAsterisk )
.head 4 +  If IsWindow( hWinErr )
.head 5 -  Call SalSendMsg( frm_Err.pbClose, SAM_Click, 0, 0 )
.head 4 -  Set hWinKeeper = hWndNULL
.head 1 +  Form Window: frm_Err		! new
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Сообщения об ошибках
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
.head 4 -  Left:   1.28"
.head 4 -  Top:    1.067"
.head 4 -  Width:  8.643"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.094"
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
.head 2 -  Description: Сообщения об ошибках
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
.head 3 +  Child Table: tblMess
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.029"
.head 6 -  Top:    0.917"
.head 6 -  Width:  8.429"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 1.75"
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
.head 5 +  Column: colDat
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Время
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Justify: Center
.head 6 -  Width:  0.857"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Time
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
.head 5 +  Column: colMess
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Сообщение
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  6.8"
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
.head 5 +  Column: colUser
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Пользователь
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.514"
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
.head 5 +  Column: colLog
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
.head 5 +  Column: colFio
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
.head 5 +  Column: colMach
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Рабочая станция
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  2.186"
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
.head 5 +  Column: colBdat
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Банк. дата
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Justify: Left
.head 6 -  Width:  0.857"
.head 6 -  Width Editable? Yes
.head 6 -  Format: dd/MM/yyyy
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
.head 6 -  Call SalSendMsgToChildren( hWndForm, UM_QueryLabelText, 0, 0 )
.head 5 +  On SAM_TblDoDetails
.head 6 -  Set dfBD = colBdat
.head 6 -  Set dfUser = colUser
.head 6 -  Set dfLog  = colLog
.head 6 -  Set dfFio  = colFio
.head 6 -  Set dfMach = colMach
.head 6 -  Set mlMess = colMess
.head 3 +  Multiline Field: mlMess
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  String Type: Long String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Border? Yes
.head 5 -  Word Wrap? Yes
.head 5 -  Vertical Scroll? Yes
.head 5 -  Window Location and Size
.head 6 -  Left:   0.129"
.head 6 -  Top:    2.802"
.head 6 -  Width:  8.229"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.948"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbJournal
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Просмотреть журнал событий
.head 4 -  Window Location and Size
.head 5 -  Left:   0.129"
.head 5 -  Top:    3.938"
.head 5 -  Width:  3.329"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.45"
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
.head 6 -  Call SalDestroyWindow( hWndForm )
.head 6 +  If SalGetWindowState( hWndMDI ) = Window_Minimized
.head 7 -  Call ShowWindow( hWndMDI, SW_RESTORE )
.head 6 -  Call ShowSecurity()
.head 3 +  Pushbutton: pbRefresh
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Обновить
.head 4 -  Window Location and Size
.head 5 -  Left:   3.614"
.head 5 -  Top:    3.938"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.45"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Refresh.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set dfBD = DATETIME_Null
.head 6 -  Set dfC = NUMBER_Null
.head 6 -  Set dfUser = ''
.head 6 -  Set dfLog = ''
.head 6 -  Set dfFio = ''
.head 6 -  Set dfMach = ''
.head 6 -  Set mlMess = ''
.head 6 -  Call SalTblReset( tblMess )
.head 6 -  Call SalSendMsg( frm_Keeper.cpb_Timer, UM_TimerFired, 0, 0 )
.head 3 +  Pushbutton: pbClose
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Закрыть
.head 4 -  Window Location and Size
.head 5 -  Left:   6.829"
.head 5 -  Top:    3.948"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.45"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Discard.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalDestroyWindow( hWndForm )
.head 3 -  Background Text: Банковская дата:
.head 4 -  Resource Id: 37329
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.115"
.head 5 -  Width:  1.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgBD
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
.head 3 +  Data Field: dfBD
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
.head 6 -  Left:   1.957"
.head 6 -  Top:    0.073"
.head 6 -  Width:  1.1"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: dd/MM/yyyy
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Сообщений всего:
.head 4 -  Resource Id: 37330
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.771"
.head 5 -  Top:    0.104"
.head 5 -  Width:  1.871"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgC
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
.head 3 +  Data Field: dfC
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
.head 6 -  Left:   7.686"
.head 6 -  Top:    0.063"
.head 6 -  Width:  0.7"
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
.head 3 -  Background Text: Пользователь:
.head 4 -  Resource Id: 37331
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.406"
.head 5 -  Width:  1.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgUser
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
.head 3 +  Data Field: dfUser
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
.head 6 -  Left:   1.957"
.head 6 -  Top:    0.365"
.head 6 -  Width:  0.643"
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
.head 3 +  Data Field: dfLog
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
.head 6 -  Left:   2.614"
.head 6 -  Top:    0.365"
.head 6 -  Width:  1.9"
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
.head 3 +  Data Field: dfFio
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
.head 6 -  Left:   4.543"
.head 6 -  Top:    0.365"
.head 6 -  Width:  3.843"
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
.head 3 -  Background Text: Рабочая станция:
.head 4 -  Resource Id: 37332
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.677"
.head 5 -  Width:  1.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgMach
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
.head 3 +  Data Field: dfMach
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
.head 6 -  Left:   1.957"
.head 6 -  Top:    0.635"
.head 6 -  Width:  2.557"
.head 6 -  Width Editable? Yes
.head 6 -  Height: Default
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
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  ! Number: nCount
.head 3 -  ! String: mMess[*,8]
.head 3 -  ! Number: nNumErr
.head 2 +  Window Variables
.head 3 -  Number: i
.head 3 -  Number: nWinX0
.head 3 -  Number: nWinY0
.head 3 -  Number: nWinWidth
.head 3 -  Number: nWinHeigh
.head 3 -  Number: nWinFW
.head 3 -  Number: nWinFH
.head 3 -  Number: nTblX0
.head 3 -  Number: nTblY0
.head 3 -  Number: nTblWidth
.head 3 -  Number: nTblHeigh
.head 3 -  Number: nXml
.head 3 -  Number: nYml
.head 3 -  Number: nWml
.head 3 -  Number: nHml
.head 3 -  Number: nXj
.head 3 -  Number: nYj
.head 3 -  Number: nXr
.head 3 -  Number: nYr
.head 3 -  Number: nXc
.head 3 -  Number: nYc
.head 3 -  Number: nWC
.head 3 -  Number: nHC
.head 3 -  Number: nWf
.head 3 -  Number: nHf
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow( hWndForm)
.head 4 -  Call SetWindowFont( hWndForm )
.head 4 -  Call SalSendMsgToChildren( hWndForm, UM_QueryLabelText, 0, 0 )
.head 4 -  Call SalSetWindowText( hWndForm, CurrentLangTable.GetAtomTitle('frm_Err.cTWndTitle') )
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalSendMsg( frm_Keeper, UM_Populate, 0, 0 )
.head 3 +  On WM_Size
.head 4 -  Call SalGetWindowSize( hWndForm, nWinFW, nWinFH )
.head 4 +  If nWinFW >= 8.8
.head 5 +  If nWinFH<5.3
.head 6 -  Call SalSetWindowSize( hWndForm, nWinFW, 5.3)
.head 4 +  Else
.head 5 +  If nWinFH<5.3
.head 6 -  Call SalSetWindowSize(hWndForm,8.8,5.3)
.head 5 +  Else
.head 6 -  Call SalSetWindowSize(hWndForm,8.8, nWinFH )
.head 4 -  Call GetClientRect( hWndForm, nWinX0, nWinY0, nWinWidth, nWinHeigh )
.head 4 -  Call SalGetWindowLoc( hWndForm.frm_Err.mlMess, nXml,nYml )
.head 4 -  Call SalGetWindowSize(hWndForm.frm_Err. mlMess, nWml,nHml )
.head 4 -  Call SalGetWindowSize( hWndForm.frm_Err.dfC, nWC,nHC )
.head 4 -  Call SalGetWindowSize( hWndForm.frm_Err.dfFio, nWf,nHf )
.head 4 -  Call SalGetWindowLoc( hWndForm.frm_Err.pbJournal, nXj,nYj )
.head 4 -  Call SalGetWindowLoc( hWndForm.frm_Err.pbRefresh, nXr,nYr )
.head 4 -  Call SalGetWindowLoc( hWndForm.frm_Err.pbClose, nXc,nYc )
.head 4 -  Call SalSetWindowSize( hWndForm.frm_Err.tblMess,
	SalPixelsToFormUnits( hWndForm.frm_Err.tblMess, nWinWidth, FALSE )-0.05,
	SalPixelsToFormUnits( hWndForm.frm_Err.tblMess, nWinHeigh, TRUE  )-2.9)
.head 4 -  !
.head 4 -  Call GetClientRect( hWndForm.frm_Err.tblMess, nTblX0, nTblY0, nTblWidth, nTblHeigh )
.head 4 -  Call SalTblSetColumnWidth( hWndForm.frm_Err.tblMess.colMess,
	SalPixelsToFormUnits( hWndForm.frm_Err.tblMess, nTblWidth, FALSE )-1.6 )
.head 4 -  !
.head 4 -  Call SalSetWindowLoc( hWndForm.frm_Err.mlMess,nXml,
	SalPixelsToFormUnits( hWndForm, nWinHeigh, TRUE  )-1.8)
.head 4 -  Call SalSetWindowSize( hWndForm.frm_Err.mlMess,
	SalPixelsToFormUnits( hWndForm.frm_Err.mlMess, nWinWidth, FALSE )-0.25,
	nHml)
.head 4 -  !
.head 4 -  Call SalSetWindowLoc( hWndForm.frm_Err.pbJournal,nXj,
	SalPixelsToFormUnits( hWndForm, nWinHeigh, TRUE  )-0.68)
.head 4 -  Call SalSetWindowLoc( hWndForm.frm_Err.pbRefresh,nXr,
	SalPixelsToFormUnits( hWndForm, nWinHeigh, TRUE  )-0.68)
.head 4 -  Call SalSetWindowLoc( hWndForm.frm_Err.pbClose,
        SalPixelsToFormUnits( hWndForm, nWinWidth, FALSE )-1.8,
	SalPixelsToFormUnits( hWndForm, nWinHeigh, TRUE  )-0.68)
.head 4 -  !
.head 4 -  Call SalSetWindowSize( hWndForm.frm_Err.dfC,
          SalPixelsToFormUnits( hWndForm, nWinWidth, FALSE )-7.78,
	  nHC)
.head 4 -  Call SalSetWindowSize( hWndForm.frm_Err.dfFio,
          SalPixelsToFormUnits( hWndForm, nWinWidth, FALSE )-4.65,
	  nHf)
.head 4 -  Call SalInvalidateWindow( hWndForm )
.head 3 +  On SAM_Destroy
.head 4 -  Set hWinErr = hWndNULL
.head 1 -  !
.head 1 +  Table Window: tbl_Attend
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Журнал регистрации пользователей  на "проходной"
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
.head 4 -  Left:   0.96"
.head 4 -  Top:    0.8"
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
.head 6 -  Left:   1.383"
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
.head 5 -  Resource Id: 2801
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
.head 6 -  Left:   2.483"
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
.head 6 -  Left:   2.917"
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
.head 6 -  Left:   3.35"
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
.head 5 -  Resource Id: 2802
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
.head 5 -  Resource Id: 2803
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
.head 3 +  Column: colID
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код 
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.0"
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
.head 3 +  Column: colLog
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Рабочее имя
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
.head 3 +  Column: colFio
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ФИО
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
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
.head 3 +  Column: colMode
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Посещение
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
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
.head 3 +  Column: colAtt
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Присутствие
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
.head 3 +  Column: colDate
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата и время регистрации
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Left
.head 4 -  Width:  3.0"
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
.head 3 +  Column: colDat
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата регистрации
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  2.0"
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
.head 3 +  Column: colTime
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Время регистрации
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  2.0"
.head 4 -  Width Editable? Yes
.head 4 -  Format: hhh:mm:ss
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
.head 3 -  Number: nUserId
.head 2 +  Window Variables
.head 3 -  String: sLogname
.head 3 -  String: sFio
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('tbl_Attend.cTWndTitle'))
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  !
.head 4 -  Set tbl_Attend.nFlags = GT_ReadOnly
.head 4 -  Set tbl_Attend.strFilterTblName = 'SEC_USER_IO'
.head 4 -  Set tbl_Attend.strPrintFileName = 'Attend.txt'
.head 4 +  If nUserId = 0
.head 5 -  Set fFilterAtStart = TRUE
.head 5 -  Call SalShowWindow(hWndForm.tbl_Attend.colID)
.head 5 -  Call SalShowWindow(hWndForm.tbl_Attend.colLog)
.head 5 -  Call SalShowWindow(hWndForm.tbl_Attend.colFio)
.head 5 -  Set strTitleAux = ''
.head 4 +  Else
.head 5 -  Set fFilterAtStart = FALSE
.head 5 -  Call SalHideWindow(hWndForm.tbl_Attend.colID)
.head 5 -  Call SalHideWindow(hWndForm.tbl_Attend.colLog)
.head 5 -  Call SalHideWindow(hWndForm.tbl_Attend.colFio)
.head 5 -  Call SqlPrepareAndExecute(hSql(),
"SELECT logname, fio 
   INTO :sLogname, :sFio
   FROM staff 
  WHERE id = :hWndForm.tbl_Attend.nUserId")
.head 5 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 5 -  Set strTitleAux = SalNumberToStrX(nUserId,0) || ', ' || sLogname || ', ' || sFio
.head 4 -  Set tbl_Attend.strSqlPopulate = 
"SELECT sec_user_io.id, sec_user_io.io_mode, 
        sec_user_io.io_date, u.logname, u.fio
   INTO :hWndForm.tbl_Attend.colID,   :hWndForm.tbl_Attend.colMode,
        :hWndForm.tbl_Attend.colDate, :hWndForm.tbl_Attend.colLog,
        :hWndForm.tbl_Attend.colFio
   FROM sec_user_io, staff u 
  WHERE sec_user_io.id = u.id " || IifS(nUserId>0, " AND sec_user_io.id = :hWndForm.tbl_Attend.nUserId", "") ||
" ORDER BY sec_user_io.io_date"
.head 4 -  Call SalDisableWindow(tbl_Attend.pbDetails)
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_FetchRowDone
.head 4 +  If colMode = 0
.head 5 -  ! Уход
.head 5 -  Set tbl_Attend.colAtt = CurrentLangTable.GetAtomTitle('tbl_Attend.cTOut')
.head 5 -  Call SalTblSetCellTextColor(colAtt, COLOR_Red, TRUE)
.head 4 +  Else If colMode = 1
.head 5 -  ! Приход
.head 5 -  Set tbl_Attend.colAtt = CurrentLangTable.GetAtomTitle('tbl_Attend.cTIn')
.head 5 -  Call SalTblSetCellTextColor(colAtt, COLOR_DarkGreen, TRUE)
.head 4 -  Set tbl_Attend.colDat  = tbl_Attend.colDate
.head 4 -  Set tbl_Attend.colTime = tbl_Attend.colDate
.head 1 +  Table Window: tbl_SecJournal
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Журнал событий безопасности
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? No
.head 3 -  Initial State: Normal
.head 3 -  Maximizable? Yes
.head 3 -  Minimizable? Yes
.head 3 -  System Menu? Yes
.head 3 -  Resizable? Yes
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  14.8"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 6.19"
.head 4 -  Height Editable? Yes
.head 3 -  Font Name: Class Default
.head 3 -  Font Size: 8
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 3 -  View: Table
.head 3 -  Allow Row Sizing? No
.head 3 -  Lines Per Row: Default
.head 2 -  Memory Settings
.head 3 -  Maximum Rows in Memory: 30000
.head 3 -  Discardable? No
.head 2 -  Description:
.head 2 -  Named Menus
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.417"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Contents
.head 4 +  Pushbutton: pbIns
.head 5 -  Class Child Ref Key: 33
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   5.333"
.head 6 -  Top:    0.06"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Insert.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbDel
.head 5 -  Class Child Ref Key: 34
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   5.783"
.head 6 -  Top:    0.06"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Delrec.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbRefresh
.head 5 -  Class Child Ref Key: 35
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   6.233"
.head 6 -  Top:    0.06"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Refresh.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbUpdate
.head 5 -  Class Child Ref Key: 36
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   6.683"
.head 6 -  Top:    0.06"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Save.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 64356
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  5.15"
.head 6 -  Begin Y:  -0.012"
.head 6 -  End X:  5.15"
.head 6 -  End Y:  0.452"
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
.head 6 -  Left:   7.383"
.head 6 -  Top:    0.06"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\search.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbFilter
.head 5 -  Class Child Ref Key: 44
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   7.833"
.head 6 -  Top:    0.06"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: MS Sans Serif
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Filter.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbDetails
.head 5 -  Class Child Ref Key: 39
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   8.283"
.head 6 -  Top:    0.06"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\open.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 40
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   8.733"
.head 6 -  Top:    0.06"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: F5
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\print.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 64357
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  9.233"
.head 6 -  Begin Y:  -0.012"
.head 6 -  End X:  9.233"
.head 6 -  End Y:  0.452"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 +  Pushbutton: pbExit
.head 5 -  Class Child Ref Key: 42
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   9.383"
.head 6 -  Top:    0.06"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: Esc
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Discard.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 64358
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  7.233"
.head 6 -  Begin Y:  0.024"
.head 6 -  End X:  7.233"
.head 6 -  End Y:  0.488"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 +  Option Button: obUser
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.05"
.head 6 -  Top:    0.048"
.head 6 -  Width:  0.433"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Custpers.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Button Style: Check
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_TooltipSetText
.head 7 -  ! Return XSalTooltipSetText( lParam, 'Показать ресурсы пользователей' )
.head 7 -  Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('tbl_SecJournal.cBTipUser') )
.head 6 +  On SAM_Click
.head 7 -  Call SalSendMsg( hWndForm, UM_Populate, 0, 0 )
.head 4 +  Option Button: obArms
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.483"
.head 6 -  Top:    0.048"
.head 6 -  Width:  0.433"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Docs.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Button Style: Check
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_TooltipSetText
.head 7 -  ! Return XSalTooltipSetText( lParam, 'Показать ресурсы АРМ-ов' )
.head 7 -  Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('tbl_SecJournal.cBTipArms') )
.head 6 +  On SAM_Click
.head 7 -  Call SalSendMsg( hWndForm, UM_Populate, 0, 0 )
.head 4 +  Combo Box: cmbSecAct
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenComboBox_NumId
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.05"
.head 6 -  Top:    0.071"
.head 6 -  Width:  4.033"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 1.5"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Editable? No
.head 5 -  String Type: Class Default
.head 5 -  Maximum Data Length: Class Default
.head 5 -  Sorted? Class Default
.head 5 -  Always Show List? Class Default
.head 5 -  Vertical Scroll? Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Input Mask: Class Default
.head 5 -  List Initialization
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Call cmbSecAct.Init(hWndItem)		
.head 7 -  Call cmbSecAct.Populate(hSql(),
    "ID","'<'||SEMANTIC||'> '||NAME","SEC_ACTION",
    " ORDER BY ID " )
.head 7 -  Call cmbSecAct.SetSelectById( 0 )
.head 6 +  On SAM_Click
.head 7 -  Call SalSendMsg( hWndForm, UM_Populate, 0, 0 )
.head 2 +  Contents
.head 3 +  Column: colGrantorName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Инициатор
действий
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.6"
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
.head 3 +  Column: colGrantorLogin
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Инициатор
действий
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.317"
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
.head 3 +  Column: colGrDate
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
 действий
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Center
.head 4 -  Width:  1.467"
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
.head 3 +  Column: colAction
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дей-
ствие
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Center
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
.head 3 +  Column: colResType
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Тип ресурса
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.483"
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
.head 3 +  Column: colResId
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код 
ресурса
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.983"
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
.head 3 +  Column: colResourceName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Имя ресурса
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Long String
.head 4 -  Justify: Left
.head 4 -  Width:  1.533"
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
.head 3 +  Column: colSourceType
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Тип 
получателя
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.417"
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
.head 3 +  Column: colSourceId
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код 
получателя
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.35"
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
.head 3 +  Column: colSourceName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
получателя
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Long String
.head 4 -  Justify: Left
.head 4 -  Width:  2.45"
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
.head 3 +  Column: colResTypeId
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
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
.head 3 +  Column: colSourceTypeId
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
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
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  String: strSql
.head 3 -  String: strOrder
.head 3 -  String: sWhereCaluse
.head 3 -  Number: nRow
.head 3 -  Number: nActionType
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('tbl_SecJournal.cTWndTitle'))
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  Set obUser = TRUE
.head 4 -  Set obArms = TRUE
.head 4 -  ! ----------------------------
.head 4 -  Set hWndForm.tbl_SecJournal.nFlags = GT_NoDel | GT_NoIns | GT_NoRet
.head 4 -  ! Call cF.Init("SEC_JOURNAL", "SEC_JOURNAL")
.head 4 -  Set strSql = 
"SELECT s.logname, s.fio, to_char(sec_journal.gr_date,'YYYY/MM/DD HH24:MI'),
        ac.semantic, sr1.res_name, sec_journal.resource_id, sec_journal.source_id, sr1.res_id,  
        sr2.res_name, sr2.res_id, sec_journal.RESOURCE_NAME, sec_journal.SOURCE_NAME 
  INTO :hWndForm.tbl_SecJournal.colGrantorLogin,  
       :hWndForm.tbl_SecJournal.colGrantorName,    
       :hWndForm.tbl_SecJournal.colGrDate,   
       :hWndForm.tbl_SecJournal.colAction,  
       :hWndForm.tbl_SecJournal.colResType,   
       :hWndForm.tbl_SecJournal.colResId,    
       :hWndForm.tbl_SecJournal.colSourceId, 
       :hWndForm.tbl_SecJournal.colResTypeId,    
       :hWndForm.tbl_SecJournal.colSourceType,
       :hWndForm.tbl_SecJournal.colSourceTypeId,
       :hWndForm.tbl_SecJournal.colResourceName,
       :hWndForm.tbl_SecJournal.colSourceName            
  FROM sec_journal, staff s, sec_resources sr1, sec_resources sr2, sec_action ac  
 WHERE sec_journal.who_grant     = s.id 
   AND sec_journal.resource_type = sr1.res_id   
   AND sec_journal.source_type   = sr2.res_id
   AND sec_journal.action        = ac.id "
.head 4 -  Set strOrder = " ORDER BY sec_journal.resource_type  "
.head 4 -  Set hWndForm.tbl_SecJournal.strSqlPopulate   = strSql || strOrder
.head 4 -  Set hWndForm.tbl_SecJournal.strFilterTblName = 'sec_journal'
.head 4 -  Set hWndForm.tbl_SecJournal.strPrintFileName = 'LoginTrm.txt'
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalSendMsg(pbFilter, SAM_Click, 0, 0)
.head 3 +  On UM_Populate
.head 4 -  Set sWhereCaluse = STRING_Null
.head 4 +  If obUser or obArms
.head 5 +  If obUser and obArms
.head 6 -  Set sWhereCaluse = " "
.head 5 +  Else
.head 6 +  If obUser
.head 7 -  Set sWhereCaluse = " AND  sec_journal.source_type=20 "
.head 6 +  Else
.head 7 -  Set sWhereCaluse = " AND  sec_journal.source_type=1 "
.head 4 -  !
.head 4 -  Set nActionType = cmbSecAct.GetKey(SalListQuerySelection( cmbSecAct))
.head 4 -  !
.head 4 +  If sWhereCaluse 
.head 5 +  If nActionType != 0
.head 6 -  Set sWhereCaluse = sWhereCaluse || " AND action=:nActionType "
.head 5 +  If cF.GetFilterWhereClause(FALSE)
.head 6 -  Set sWhereCaluse = sWhereCaluse || " AND " || cF.GetFilterWhereClause(FALSE)
.head 5 -  Call SalTblPopulate(hWndForm, hSql(), T(strSql || sWhereCaluse || strOrder), TBL_FillAll)
.head 4 +  Else
.head 5 -  Call SalTblReset(hWndForm)
.head 3 +  On SAM_Destroy
.head 4 -  Set hWinSecJournal = hWndNULL
.head 1 +  Table Window: tbl_ApprovingAttr
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title:
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
.head 4 -  Width:  11.833"
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
.head 4 +  Pushbutton: pbSecAttrJournal
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.1"
.head 6 -  Top:    0.07"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Books.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_TooltipSetText
.head 7 -  ! Показать журнал безопасности
.head 7 -  Return XSalTooltipSetText(lParam, CurrentLangTable.GetAtomTitle('tbl_Approving.cBTipSecJournal'))
.head 6 +  On SAM_Click
.head 7 -  Call FunNSIEditF('v_sec_attr_journal', 1 | 0x0010)
.head 4 -  Line
.head 5 -  Resource Id: 4638
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  0.65"
.head 6 -  Begin Y:  0.0"
.head 6 -  End X:  0.65"
.head 6 -  End Y:  0.5"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 +  Combo Box: cmbObjects
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenComboBox_NumId
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.8"
.head 6 -  Top:    0.08"
.head 6 -  Width:  2.8"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 1.655"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Editable? No
.head 5 -  String Type: Class Default
.head 5 -  Maximum Data Length: Class Default
.head 5 -  Sorted? Class Default
.head 5 -  Always Show List? Class Default
.head 5 -  Vertical Scroll? Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Input Mask: Class Default
.head 5 -  List Initialization
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 6 +  On SAM_User
.head 7 -  Call SalListClear(hWndItem)
.head 7 -  Call cmbObjects.Init(hWndItem)
.head 7 -  Call cmbObjects.Populate(hSql(), "attr_id", "attr_name", "sec_attributes",
" where nvl(inuse,0) = 1 order by attr_name")
.head 7 -  ! Все
.head 7 -  Call cmbObjects.Add(0, CurrentLangTable.GetAtomTitle('tbl_Approving.cTObjects0'))
.head 7 -  Call cmbObjects.SetSelectById(0)
.head 6 +  On SAM_Click
.head 7 -  Call SalSendClassMessage(SAM_Click, 0, 0)
.head 7 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 4 -  Line
.head 5 -  Resource Id: 4637
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  3.7"
.head 6 -  Begin Y:  0.0"
.head 6 -  End X:  3.7"
.head 6 -  End Y:  0.5"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
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
.head 6 -  Left:   3.833"
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
.head 4 +  Pushbutton: pbRefresh
.head 5 -  Class Child Ref Key: 35
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.267"
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
.head 4 +  Pushbutton: pbUpdate
.head 5 -  Class Child Ref Key: 36
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.7"
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
.head 5 -  Resource Id: 4634
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  7.433"
.head 6 -  Begin Y:  -0.048"
.head 6 -  End X:  7.433"
.head 6 -  End Y:  0.417"
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
.head 6 -  Left:   5.367"
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
.head 4 +  Pushbutton: pbDetails
.head 5 -  Class Child Ref Key: 39
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   5.8"
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
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 40
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   6.233"
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
.head 5 -  Resource Id: 4635
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  6.767"
.head 6 -  Begin Y:  -0.048"
.head 6 -  End X:  6.767"
.head 6 -  End Y:  0.417"
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
.head 6 -  Left:   6.9"
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
.head 5 -  Resource Id: 4636
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  5.217"
.head 6 -  Begin Y:  -0.048"
.head 6 -  End X:  5.217"
.head 6 -  End Y:  0.417"
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 2 +  Contents
.head 3 +  Column: colUserId	! Код
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Class Default
.head 4 -  Width:  0.8"
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
.head 3 +  Column: colUserLogin	! Рабочее имя
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Рабочее
имя
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
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
.head 3 +  Column: colUserName	! ФИО
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ФИО
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
.head 3 +  Column: colAttrId	! Ид. атрибута
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
.head 3 +  Column: colAttrName	! Наименование атрибута
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
атрибута
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
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
.head 3 +  Column: colAttrValue	! Значение атрибута
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Значение
атрибута
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
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
.head 3 +  Column: colApprove	! Разрешить
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Разре
шить
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Class Default
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Check Box
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value: 1
.head 6 -  Uncheck Value: 0
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colGrantorId	! Кто изменил атрибут
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
.head 3 +  Column: colGrantorName	! Кто изменил атрибут
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кто изменил
атрибут
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
.head 3 +  Function: initAttributes
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: j
.head 5 -  Number: nAttrId
.head 5 -  String: sAttrName
.head 5 -  String: sAttrCode
.head 5 -  String: sAttrTabName
.head 5 -  String: sAttrColName
.head 5 -  String: sAttrStorage
.head 5 -  String: sAttrType
.head 4 +  Actions
.head 5 -  Set nNumAttr = 0
.head 5 -  Set j = 0
.head 5 -  ! должны быть заполнены поля - по ним потом строятся select'ы
.head 5 +  If SqlPrepareAndExecute(hSql(),
"select attr_id, attr_name, attr_code, attr_tabname, attr_usercol, attr_storage, nvl(attr_type,'S')
   into :nAttrId, :sAttrName, :sAttrCode, :sAttrTabName, :sAttrColName, :sAttrStorage, :sAttrType
   from sec_attributes
  where nvl(inuse,0) = 1
    and attr_tabname is not null
    and attr_usercol is not null
    and attr_storage is not null
  order by attr_id")
.head 6 +  While SqlFetchNext(hSql(), nFetchRes)
.head 7 -  Set cAttr[j].nAttrId      = nAttrId
.head 7 -  Set cAttr[j].sAttrName    = sAttrName
.head 7 -  Set cAttr[j].sAttrCode    = sAttrCode
.head 7 -  Set cAttr[j].sAttrTabName = sAttrTabName
.head 7 -  Set cAttr[j].sAttrColName = sAttrColName
.head 7 -  Set cAttr[j].sAttrStorage = sAttrStorage
.head 7 -  Set cAttr[j].sAttrType    = sAttrType
.head 7 -  Set j = j + 1
.head 5 -  Set nNumAttr = j
.head 5 -  Return TRUE
.head 3 +  Function: GetSQLPopulateStr
.head 4 -  Description: Получить SQL строку населения таблицы...
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  Number: nMode		! Режимы показывания объектов
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sSql
.head 5 -  String: strSql
.head 5 -  String: strInto
.head 5 -  !
.head 5 -  Number: i
.head 4 +  Actions
.head 5 -  Set sSql    = ""
.head 5 -  Set strSql  = ""
.head 5 -  Set strInto =
"  into :colUserId, :colUserLogin, :colUserName,
        :colAttrId, :colAttrName, :colAttrValue, :colGrantorId, :colGrantorName"
.head 5 -  Set i = 0
.head 5 +  While i < nNumAttr
.head 6 -  Set sSql = 
"select a." || cAttr[i].sAttrColName || ", s.logname, s.fio, " ||
        Str(cAttr[i].nAttrId) || ",
        '" || cAttr[i].sAttrName || "',
        substr(a." || cAttr[i].sAttrCode || ", 1, 254),
        g.id, g.fio " || strInto || "
   from " || cAttr[i].sAttrTabName || " a, staff s, staff g
  where a." || cAttr[i].sAttrColName || " = s.id
    and a.grantor = g.id"
.head 6 +  If nMode
.head 7 +  If cAttr[i].nAttrId = nMode
.head 8 -  Set strSql = sSql
.head 8 -  Break
.head 6 +  Else
.head 7 +  If strSql
.head 8 -  Set strSql = strSql || PutCrLf() || ' union all ' || PutCrLf()
.head 7 -  Set strSql  = strSql || sSql
.head 7 -  Set strInto = ""
.head 6 -  Set i = i + 1
.head 5 -  Return strSql
.head 3 +  Function: ApproveAttributes
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nRow
.head 5 -  Boolean: bIsDeleted
.head 5 -  Number: nGrantorId
.head 5 -  Boolean: bSaveInSecJournal
.head 5 -  Number: nAction
.head 4 +  Actions
.head 5 -  Set nRow = TBL_MinRow
.head 5 +  While SalTblFindNextRow(hWndForm, nRow, ROW_Edited | ROW_MarkDeleted, 0)
.head 6 -  Call SalTblSetContext(hWndForm, nRow)
.head 6 -  Set bIsDeleted = SalTblQueryRowFlags(hWndForm, nRow, ROW_MarkDeleted)
.head 6 -  ! Запрещаем подтверждать собственноручно выданные ресурсы
.head 6 +  If colApprove or bIsDeleted
.head 7 -  Set bSaveInSecJournal = FALSE
.head 7 -  ! ==================================
.head 7 -  ! -- помеченные на удаление
.head 7 -  ! ==================================
.head 7 +  If bIsDeleted
.head 8 -  Set nAction = 2
.head 8 -  ! -- выполнение процедуры
.head 8 +  If SqlPLSQLCommand(hSql(), "bars_useradm.drop_user_attribute(colUserId, colAttrId)")
.head 9 -  ! Отказ от подтверждения изменений атрибута <colAttrName> для colUserName 
.head 9 -  Call SqlCommitEx(hSql(), AppCode || 
     CurrentLangTable.GetAtomTitle('tbl_ApprovingAttr.cTToLog1') || ' <' || colAttrName || '> ' ||
     CurrentLangTable.GetAtomTitle('tbl_ApprovingAttr.cTToLogFor') || ' ' || colAttrName)
.head 9 -  Set bSaveInSecJournal = TRUE
.head 8 +  Else
.head 9 -  ! Неуспешный отказ от подтверждения изменений атрибута <colAttrName> для colUserName 
.head 9 -  Call SqlRollbackEx(hSql(), AppCode || 
     CurrentLangTable.GetAtomTitle('tbl_ApprovingAttr.cTToLog2') || ' <' || colAttrName || '> ' ||
     CurrentLangTable.GetAtomTitle('tbl_ApprovingAttr.cTToLogFor') || ' ' || colAttrName)
.head 9 -  Call SalMessageBox(AppCode || 
     CurrentLangTable.GetAtomTitle('tbl_ApprovingAttr.cTToLog2') || ' <' || colAttrName || '> ' ||
     CurrentLangTable.GetAtomTitle('tbl_ApprovingAttr.cTToLogFor') || ' ' || colAttrName,
     CurrentLangTable.GetAtomTitle('cTAt'), 0)
.head 9 -  Return FALSE
.head 7 -  ! ==================================
.head 7 -  ! -- помеченные на подтверждение
.head 7 -  ! ==================================
.head 7 +  Else
.head 8 -  Set nAction = 1
.head 8 +  If colGrantorId != nMyUserId or GetUserLoginName() = 'BARS'
.head 9 +  If SqlPLSQLCommand(hSql(), "bars_useradm.alter_user_attribute(colUserId, colAttrId)")
.head 10 -  ! Безопасность: подтверждение изменений атрибута <colAttrName> для colUserName
.head 10 -  Call SqlCommitEx(hSql(), 
     CurrentLangTable.GetAtomTitle('tbl_Approving.cTToLogSec0')  || ': ' || 
     CurrentLangTable.GetAtomTitle('tbl_ApprovingAttr.cTToLog3') || ' <' || colAttrName || '> ' ||
     CurrentLangTable.GetAtomTitle('tbl_ApprovingAttr.cTToLogFor') || ' ' || colUserName)
.head 10 -  Set bSaveInSecJournal = TRUE
.head 9 +  Else
.head 10 -  ! Безопасность: неуспешное подтверждение изменений атрибута <colAttrName> для colUserName
.head 10 -  Call SqlRollbackEx(hSql(), AppCode || 
     CurrentLangTable.GetAtomTitle('tbl_Approving.cTToLogSec0')  || ': ' ||
     CurrentLangTable.GetAtomTitle('tbl_ApprovingAttr.cTToLog4') || ' <' || colAttrName || '> ' ||
     CurrentLangTable.GetAtomTitle('tbl_ApprovingAttr.cTToLogFor') || ' ' || colUserName)
.head 10 -  Call SalMessageBox(
     CurrentLangTable.GetAtomTitle('tbl_Approving.cTToLogSec0')  || ': ' ||
     CurrentLangTable.GetAtomTitle('tbl_ApprovingAttr.cTToLog4') || ' <' || colAttrName || '> ' ||
     CurrentLangTable.GetAtomTitle('tbl_ApprovingAttr.cTToLogFor') || ' ' || colUserName,
     CurrentLangTable.GetAtomTitle('cTAt'), 0)
.head 10 -  Return FALSE
.head 7 -  ! ==================================
.head 7 -  ! -- Вставка в журнал безопасности
.head 7 -  ! ==================================
.head 7 +  If bSaveInSecJournal
.head 8 +  If not SqlPrepareAndExecute(hSql(),
"insert into sec_attr_journal(who_grant, action, attr_id, attr_value, user_id)
 values (:colGrantorId, :nAction, :colAttrId, :colAttrValue, :colUserId)")
.head 9 -  ! Невозможно сделать запись в журнале безопасности
.head 9 -  Call SqlRollbackEx(hSql(), AppCode || CurrentLangTable.GetAtomTitle('tbl_Approving.cTMsg4'))
.head 9 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('tbl_Approving.cTMsg4'),
     CurrentLangTable.GetAtomTitle('cTAt'), 0)
.head 9 -  Return FALSE
.head 8 +  Else
.head 9 -  Call SqlCommit(hSql())
.head 7 -  ! ==================================
.head 5 -  Return TRUE
.head 2 +  Window Parameters
.head 3 -  Boolean: bEdit	! TRUE-Edit, FALSE-Show
.head 2 +  Window Variables
.head 3 -  : cAttr[*]
.head 4 -  Class: cSecAttributes
.head 3 -  Number: nNumAttr
.head 3 -  Number: nMyUserId
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  ! Подтверждение/Аннулирование изменений атрибутов пользователей | Просмотр неподтвержденных изменений атрибутов пользователей
.head 4 -  Call SalSetWindowText(hWndForm, IifS(bEdit=TRUE, 
     CurrentLangTable.GetAtomTitle('tbl_ApprovingAttr.cTWndTitle'),
     CurrentLangTable.GetAtomTitle('tbl_ApprovingAttr.cTWndTitleShow')))
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Set nMyUserId = GetUserId()
.head 4 -  !
.head 4 -  Call initAttributes()
.head 4 -  !
.head 4 +  If not bEdit
.head 5 -  Call SalDisableWindow(pbDel)
.head 5 -  Call SalDisableWindow(pbUpdate)
.head 5 -  Call SalHideWindow(colApprove)
.head 4 -  !
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On UM_Populate
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Call SalTblDefineSplitWindow(hWndForm, 0, FALSE)
.head 4 -  Set strDSql = GetSQLPopulateStr(cmbObjects.GetCurrentKey())
.head 4 -  Call SalTblPopulate(hWndForm, cMain.hSql(), T(strDSql), TBL_FillAll)
.head 4 -  ! Call VisTblAutoSizeColumn(hWndForm, colResourceKod)
.head 4 -  Call SalTblSetContext(hWndForm, 0)
.head 4 -  Call SalPostMsg(hWndForm, SAM_TblDoDetails, 0, 0)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_FetchRowDone
.head 4 +  If colGrantorId = nMyUserId and GetUserLoginName() != 'BARS'
.head 5 -  Call XSalTblSetRowBackColor(hWndForm, lParam, SalColorFromRGB(255, 200, 200))
.head 3 +  On UM_Update
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  !
.head 4 +  If ApproveAttributes()
.head 5 -  Call SqlCommitEx(hSql(), "")
.head 4 +  Else
.head 5 -  Call SqlRollbackEx(hSql(), "")
.head 4 -  !
.head 4 -  Call SalPostMsg(hWndForm, UM_Populate, 0, 0)
.head 4 -  Call SalWaitCursor(FALSE)
.head 1 +  Table Window: tbl_SecAuditArch
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Архив журнала событий
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
.head 3 -  Maximum Rows in Memory: 64000
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
.head 5 -  Resource Id: 64733
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
.head 5 -  Resource Id: 64734
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
.head 5 -  Resource Id: 64735
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
.head 3 +  Column: colId
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ид.
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
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
.head 3 +  Column: colType
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Тип
события
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Right
.head 4 -  Width:  1.143"
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
.head 3 +  Column: colBDate
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Банковская
Дата
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Right
.head 4 -  Width:  1.257"
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
.head 3 +  Column: colDate
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Реальная
Дата
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  2.0"
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
.head 3 +  Column: colMessage
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сообщение
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 4000
.head 4 -  Data Type: Long String
.head 4 -  Justify: Class Default
.head 4 -  Width:  7.0"
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
.head 3 +  Column: colUid
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: UID
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
.head 3 +  Column: colMachine
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Рабочая
станция
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Long String
.head 4 -  Justify: Left
.head 4 -  Width:  1.8"
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
.head 3 +  Column: colUserid
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ид.
пользователя БД
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
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
.head 3 +  Column: colUName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Имя
пользователя БД
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
.head 3 +  Column: colUproxy
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Имя
proxy-пользователя
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
.head 3 +  Column: colModule
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Модуль
комплекса
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
.head 3 +  Column: colObject
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Создал
сообщение
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
.head 3 +  Column: colBranch
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отделение
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
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  Date/Time: dDat1
.head 3 -  Date/Time: dDat2
.head 3 -  String: sPopulate
.head 3 -  String: sTabName
.head 3 -  String: sFilter
.head 3 -  Number: nRow
.head 3 -  Number: nKolRow
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Set hWndForm.tbl_SecAuditArch.nFlags = GT_ReadOnly
.head 4 -  Set hWndForm.tbl_SecAuditArch.strFilterTblName = 'V_SEC_AUDIT_ARCH'
.head 4 -  Set hWndForm.tbl_SecAuditArch.strPrintFileName = 'SEC_AUDIT_ARCH'
.head 4 -  Set hWndForm.tbl_SecAuditArch.fFilterAtStart = TRUE
.head 4 -  Set sPopulate = ''
.head 4 +  If SalModalDialog(dlg_SetDate, hWndForm, dDat1, dDat2)
.head 5 +  If SqlPLSQLCommand(hSql(), "bars_aud_arch.link_files(dDat1, dDat2)")
.head 6 -  Call SqlPrepareAndExecute(hSql(), 
"select file_tabname into :sTabName
   from bars_aud_arch_hist
  where connected = 1
    and trunc(file_date) between :dDat1 and :dDat2")
.head 6 +  While SqlFetchNext(hSql(), nFetchRes)
.head 7 -  Set sPopulate = sPopulate || IifS(sPopulate='', "", " union all ") || "select * from " || sTabName
.head 5 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('tbl_SecAuditArch.cTWndTitle') || ' ' ||
     IifS(dDat1!=DATETIME_Null, SalFmtFormatDateTime(dDat1, 'dd/MM/yyyy') || ' - ' || SalFmtFormatDateTime(dDat2, 'dd/MM/yyyy'),''))
.head 5 -  Call PrepareWindowEx(hWndForm)
.head 5 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 4 +  Else
.head 5 -  Call SalDestroyWindow(hWndForm)
.head 3 +  On UM_Populate
.head 4 +  If sPopulate
.head 5 -  Set nKolRow = 0
.head 5 +  If fFilterAtStart
.head 6 +  If SetQueryFilter(cF)
.head 7 -  Set fFilterAtStart = NOT fFilterAtStart
.head 5 +  If NOT fFilterAtStart
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Set sFilter = cF.GetFilterWhereClause(FALSE)
.head 6 -  Set strDSql =
"select /*+parallel(20)*/ rec_id, rec_uid, rec_uname, rec_uproxy, rec_date, rec_bdate, 
        rec_type, rec_module, rec_message, machine, rec_object, rec_userid, branch
   into :hWndForm.tbl_SecAuditArch.colId, :hWndForm.tbl_SecAuditArch.colUid,
        :hWndForm.tbl_SecAuditArch.colUName, :hWndForm.tbl_SecAuditArch.colUproxy,
        :hWndForm.tbl_SecAuditArch.colDate, :hWndForm.tbl_SecAuditArch.colBDate, 
        :hWndForm.tbl_SecAuditArch.colType, :hWndForm.tbl_SecAuditArch.colModule,
        :hWndForm.tbl_SecAuditArch.colMessage, :hWndForm.tbl_SecAuditArch.colMachine,
        :hWndForm.tbl_SecAuditArch.colObject, :hWndForm.tbl_SecAuditArch.colUserid, :hWndForm.tbl_SecAuditArch.colBranch
   from (" || sPopulate || ") V_SEC_AUDIT_ARCH 
  where trunc(rec_date) between :hWndForm.tbl_SecAuditArch.dDat1 and :hWndForm.tbl_SecAuditArch.dDat2
    and branch like sys_context('bars_context','user_branch_mask') " ||
        IifS(sFilter='', "", "and " || sFilter) || "
  order by rec_id desc"
.head 6 -  Call SqlSetLongBindDatatype(9, 22)
.head 6 -  Call SalTblPopulate(hWndForm, hSql(), T(strDSql), nTabPopulateMethod)
.head 6 -  Call SalTblSetContext(hWndForm, 0)
.head 6 -  Call SalPostMsg(hWndForm, SAM_TblDoDetails, 0, 0)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  Else
.head 6 -  Call SalDestroyWindow(hWndForm)
.head 3 +  On SAM_FetchRowDone
.head 4 -  Set nKolRow = nKolRow + 1
.head 3 +  On SAM_DoubleClick
.head 4 +  If nKolRow
.head 5 -  Set nRow = SalTblQueryContext(hWndForm)
.head 5 -  Call SalModalDialog(dlg_edit_mess, hWndForm, 2, nRow, nKolRow)
.head 1 +  Dialog Box: dlg_SetDate
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Задайте период дат
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? No
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   1.538"
.head 4 -  Top:    0.938"
.head 4 -  Width:  6.0"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 2.2"
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
.head 3 -  Frame
.head 4 -  Resource Id: 64736
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.057"
.head 5 -  Top:    0.042"
.head 5 -  Width:  5.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.0"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: Default
.head 3 -  Background Text: Дата начала
.head 4 -  Resource Id: 64738
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.25"
.head 5 -  Width:  2.0"
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
.head 3 +  Data Field: bgDat1
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
.head 3 +  Data Field: dfDat1
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
.head 6 -  Left:   2.3"
.head 6 -  Top:    0.2"
.head 6 -  Width:  2.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Date
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Дата окончания
.head 4 -  Resource Id: 64739
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.55"
.head 5 -  Width:  2.0"
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
.head 3 +  Data Field: bgDat2
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
.head 3 +  Data Field: dfDat2
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
.head 6 -  Left:   2.3"
.head 6 -  Top:    0.5"
.head 6 -  Width:  2.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Date
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 +  If SalIsNull(dfDat2) and not SalIsNull(dfDat1)
.head 7 -  Set dfDat2 = dfDat1
.head 3 -  Frame
.head 4 -  Resource Id: 64737
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.057"
.head 5 -  Top:    1.094"
.head 5 -  Width:  5.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.7"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: Default
.head 3 +  Pushbutton: pbOk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Применить
.head 4 -  Window Location and Size
.head 5 -  Left:   0.729"
.head 5 -  Top:    1.208"
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
.head 6 +  If not SalIsNull(dfDat1) and not SalIsNull(dfDat2)
.head 7 -  Set dDat1 = dfDat1
.head 7 -  Set dDat2 = dfDat2
.head 7 -  Call SalEndDialog(hWndForm, TRUE)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отменить
.head 4 -  Window Location and Size
.head 5 -  Left:   3.743"
.head 5 -  Top:    1.208"
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
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(hWndForm, FALSE)
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Receive Date/Time: dDat1
.head 3 -  Receive Date/Time: dDat2
.head 2 +  Window Variables
.head 3 -  String: sWhere
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('dlg_SetDate.cTWndTitle'))
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 -  Call SalSetFocus(dfDat1)
