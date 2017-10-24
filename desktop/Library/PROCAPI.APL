.head 0 +  Application Description: ! ///////////////////////////////////////////////////////////
! PROCAPI.APD - Dynalib ( префикс - PRC )
! PROCAPI.APL - Библиотека ф-ций работы с процентами
! ООО Унити-Барс  ( C )  1996-1997
! Разработчик: Марценюк М.П.
! ///////////////////////////////////////////////////////////
! Оплата К2: Для операций  K2C и К2G  динамически подбирается
!            связанная типа DKZ (MIK сделал 28-09-2001)
! 23/04/2002 - SERG
! Функции работы с Реестром Должников перенесены в DEBREG.APD
.head 1 -  Outline Version - 4.0.26
.head 1 +  Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000ED0000 002C000000030000 0003000000000000 0061020000F8FFFF
0040: FFE2FFFFFF000000 00000000002C0300 0064020000010000 0001000000010000
0060: 000F4170706C6963 6174696F6E497465 6D01000000075769 6E646F7773
.enddata
.data DT_MAKERUNDLG
0000: 0200000000001E71 3A5C626172733938 5C6C696272617279 5C524547434C4E45
0020: 582E646C6C1E713A 5C6261727339385C 6C6962726172795C 524547434C4E4558
0040: 2E61706300000101 011E713A5C626172 7339385C6C696272 6172795C52454743
0060: 4C4E45582E72756E 1E713A5C62617273 39385C6C69627261 72795C524547434C
0080: 4E45582E646C6C1E 713A5C6261727339 385C6C6962726172 795C524547434C4E
00A0: 45582E6170630000 010101175C424152 5339385C42494E5C 70726F636170692E
00C0: 617064175C424152 5339385C42494E5C 70726F636170692E 646C6C175C424152
00E0: 5339385C42494E5C 70726F636170692E 6170630000010101 001E713A5C626172
0100: 7339385C6C696272 6172795C52454743 4C4E45582E646C6C 1E713A5C62617273
0120: 39385C6C69627261 72795C524547434C 4E45582E61706300 00010101
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
0000: 1018B80BB80B2500
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
.head 2 -  Dynalib: NSIAPI.APD
.head 2 -  Dynalib: Message.apd
.head 2 -  Dynalib: Absapi.apd
.head 2 -  Dynalib: Docview.apd
.head 2 -  Dynalib: Custacnt.apd
.head 2 -  Dynalib: CHCKINNR.APD
.head 2 -  Dynalib: impexp.apd
.head 2 -  !
.head 2 -  File Include: Winbars2.apl
.head 2 -  File Include: Winapi.apl
.head 2 -  File Include: Gentbl.apl
.head 2 -  File Include: Xsalcpt.apl
.head 2 -  File Include: Vtlbx.apl
.head 2 -  !
.head 2 -  File Include: Docfun6.apl
.head 2 -  File Include: vtmeter.apl
.head 2 -  File Include: Vtfile.apl
.head 2 -  File Include: xsalimg.APL
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
.head 3 -  Date/Time: dd-MM-yy
.head 3 -  Date/Time: dd/MM/yyyy
.head 3 -  Number: ###00000
.head 3 -  Number: ###00000
.head 3 -  Number: 00000
.head 3 -  Number: ###000;'($'###000')'
.head 3 -  Number: #000
.head 3 -  Date/Time: dd.MM.yyyy
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
.head 2 +  Variables
.head 3 -  Boolean: fInitLib
.head 3 -  Boolean: bTB4
.head 3 -  Boolean: bTB1
.head 3 -  Boolean: bTB2
.head 3 -  Number: nFetchRes
.head 3 -  Number: nBackKvit	! Флаг формирования квитанции D при сторнировании документа
.head 3 -  String: strPathD
.head 3 -  Window Handle: WH
.head 3 -  Window Handle: hW_F
.head 3 -  Window Handle: hW_C
.head 3 -  Window Handle: hW_D
.head 3 -  Window Handle: hW_Q
.head 3 -  Number: nFetchRes1
.head 3 -  Window Handle: hW_FILE_INFO
.head 3 -  Window Handle: hW_BLK
.head 3 -  Number: nNewRow
.head 3 -  Number: nRow
.head 3 -  !
.head 2 +  Internal Functions
.head 3 -  ! // PROCAPI.APL - Функции /////////////////////////////////////////////////////////////////////////////////////
.head 3 +  Function: Procapi_ini
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
.head 6 -  ! Формировать квитанцию D?
.head 6 -  Call SalUseRegistry(FALSE, '')
.head 6 -  Set nBackKvit = SalGetProfileInt(INI_ElektroKlients, 'NOKK_BackKvit', 0, GetIniFileName())
.head 6 -  Call SalGetProfileString(INI_ElektroKlients, 'NOKK_DPath', GetPrnDir(), strPathD, GetIniFileName())
.head 6 -  !
.head 6 -  Set strPathToLangResources = GetLangPath()
.head 6 -  Set strLangId = GetLang()
.head 6 -  Set strFileName = strPathToLangResources || "\\" || strLangId || "\\procapi.lng"
.head 6 -  !
.head 6 +  If (NOT strLangId) OR (NOT CurrentLangTable.InitFromFile( strFileName, strLangId ))
.head 7 -  Call CurrentLangTable.Init()
.head 7 -  !
.head 7 -  Call CurrentLangTable.AddAtom('cTAt', 'Внимание!')
.head 7 -  Call CurrentLangTable.AddAtom('cTErr','Ошибка!')
.head 7 -  ! ====================================================
.head 7 -  ! frm_Pay_Bck
.head 7 -  Call CurrentLangTable.AddAtom('frm_Pay_Bck.cTWndTitle','Выполнение возврата операций')
.head 7 -  !
.head 7 -  Call CurrentLangTable.AddAtom('frm_Pay_Bck.pbSearch','Искать')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Pay_Bck.pbOk','"ВАCК"')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Pay_Bck.Exit','Выход')
.head 7 -  ! BG
.head 7 -  Call CurrentLangTable.AddAtom('frm_Pay_Bck.bgNotProcessing','НЕПРОЦЕССИНГОВЫЕ !')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Pay_Bck.bgRef', 'Референс')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Pay_Bck.bgFDat','Дата выполнения')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Pay_Bck.bgIn', 'ВНУТРЕННИЕ (sos=5)')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Pay_Bck.bgAll','ЛЮБЫЕ (sos<5)')
.head 7 -  ! Msg
.head 7 -  Call CurrentLangTable.AddAtom('frm_Pay_Bck.cTMsgDocNotFound','Документ не найден !')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Pay_Bck.cTMsgBackDoc','ВЕРНУТЬ  документ')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Pay_Bck.cTMsgSumm','на сумму')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Pay_Bck.cTMsgTitle','Снятие оборотов, восстановление остатков')
.head 7 -  ! Err
.head 7 -  Call CurrentLangTable.AddAtom('frm_Pay_Bck.cTErrSign','Ошибка при попытке подписать сторно операцию')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Pay_Bck.cTErrProc','Ошибка выполнения процедуры')
.head 7 -  Call CurrentLangTable.AddAtom('frm_Pay_Bck.cTErrBack','Ошибка ИЗЪЯТИЯ док.')
.head 7 -  ! ====================================================
.head 6 -  !
.head 6 -  Set fInitLib = TRUE
.head 5 -  ! Call CurrentLangTable.SaveToFile('C:\\TEMP\\procapi.lng','RUS')
.head 5 -  Return fInitLib
.head 3 -  ! Заглушки
.head 3 +  Function: AcrProc		! __exported
.head 4 -  Description: Процедура импорта шаблонов документов в БД из каталога TEMPLATE.RPT
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Window Handle: hW
.head 5 -  String: sPar
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sRepPrefix
.head 5 -  String: sRepSuffix
.head 5 -  String: sFileName
.head 4 +  Actions
.head 5 -  ! Ммпорт шаблонов документов в БД из каталога TEMPLATE.RPT
.head 5 +  If sPar = STRING_Null
.head 6 -  Call DocsPrint(0, '', 100)
.head 5 -  ! Экспорт шаблонов документов в Sql-сценарий
.head 5 +  Else If sPar = '1'
.head 6 +  If SalMessageBox('Вибрати певний шаблон?', 'Питання', MB_IconQuestion | MB_YesNo) = IDYES
.head 7 +  If FunNSIGetAltPK("rpt_template", "rep_prefix", "rep_suffix", sRepPrefix, sRepSuffix) 
.head 8 +  If not GeneralImpExp(hWndMDI, 3, 2, "tic.get_template_file('" || sRepPrefix || "', '" || sRepSuffix || "', sFileName)", '')
.head 9 -  Call SalMessageBox('Помилка формування файлу', 'Помилка', MB_IconStop | MB_Ok)
.head 9 -  Return FALSE 
.head 6 +  Else
.head 7 +  If not GeneralImpExp(hWndMDI, 3, 2, 'tic.get_template_file(STRING_Null, STRING_Null, sFileName)', '')
.head 8 -  Call SalMessageBox('Помилка формування файлу', 'Помилка', MB_IconStop | MB_Ok)
.head 8 -  Return FALSE 
.head 5 -  Return TRUE
.head 3 +  Function: SetProcPar    	! __exported
.head 4 -  Description: Установить параметры начисления %%
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nAcc     ! номер счета (внутренний) начисления
.head 5 -  Number: nKvSN    ! код валюты
.head 5 -  String: sNlsSN   ! номер счета начисленных %
.head 5 -  String: sNlsSD   ! номер счета дох/расх
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SalMessageBox( 'Функция удалена.', 'Внимание', MB_IconHand )
.head 3 +  Function: AccProc		! __exported
.head 4 -  Description: Ведення рахунків з % ставками
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SalMessageBox('Функция больше не работает. См."Начисление %%"','Внимание',MB_IconHand)
.head 3 +  Function: PEREKRYT		! __exported
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Window Handle: hW
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SalMessageBox( 'Функция удалена.', 'Внимание', MB_IconHand )
.head 3 +  Function: F902			! __exported
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Window Handle: hW
.head 5 -  Number: nPar
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If nPar=0 or nPar=10  !! Картотека 902
.head 6 +  If not bTB4
.head 7 -  Call Procapi_ini()
.head 7 -  Set bTB4=TRUE
.head 7 -  Call SalCreateWindow(T902, hW,nPar )
.head 5 +  If nPar=1 !! Картотека деб.запросов по доступу к счету
.head 6 -  Call SalMessageBox( 'Функция перенесена в BARS014.apd', 'ВНИМАНИЕ', MB_IconStop )
.head 5 +  If nPar=2 !! Комиссии в 8-класе
.head 6 +  If not bTB2
.head 7 -  Call Procapi_ini()
.head 7 -  Set bTB2=TRUE
.head 7 -  Call SalCreateWindow(TKOM, hW, 0 )
.head 3 +  Function: Pay_K2		! __exported
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Window Handle: hW
.head 5 -  Number: nPar
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SalMessageBox( 'Функция перенесена в BARS023.apd.
Заменить вызов с Pay_K2(hWndMDI,nn) на
Sel023(hWndMDI,3,nn,"","")', 'ВНИМАНИЕ', MB_IconStop )
.head 3 +  Function: F_Pay_Bck		! __exported
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Window Handle: hW
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call Procapi_ini()
.head 5 -  Call SalCreateWindow( frm_Pay_Bck, hW )
.head 3 +  Function: SetBrat		! __exported
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SalMessageBox( 'Функция удалена.', 'Внимание', MB_IconHand )
.head 2 +  Named Menus
.head 2 +  Class Definitions
.data RESOURCE 0 0 1 3063301029
0000: D9010000F1000000 0000000000000000 0200000300FFFF01 00160000436C6173
0020: 73566172004F7574 6C696E6552006567 496E666F41003C00 000D630052616469
0040: 6F4C69730074426F 7886000000F00500 0000E0010D000000 FF3F0D00B9000100
0060: FFFFE01A00000001 FE00FF8327000000 01FB00FF0F340000 00EE0100FF3F0180
0080: 0022000000010000 00000A6347656E46 696C007465727400 0000047800000002
00A0: 640400000100FFE0 8001000000DF04D8 00010D00FF7F1170 0000000200FFFFC1
00C0: 1500000001FD00FF C701802200000200 00000B6347E34446 69CF00049E000204
00E0: D1000100003F8001 F9000037040001F6 0D00FFDF11DC0002 00FF7F1573000100
0100: FFFF01
.enddata
.head 3 +  ! Functional Class: cCustomerSign
.winattr
.end
.head 4 -                       Description: класс подписи строки информ. о клиенте файла PF
.head 4 +                       Derived From
.head 5 -                       Class: cDoc
.head 4 -                       Class Variables
.head 4 -                       Instance Variables
.head 4 +                       Functions
.head 5 +                       Function: InitSign ! Инициализация ЭЦП
.head 6 -                       Description: ! Инициализация ЭЦП
.head 6 +                       Returns
.head 7 -                       Boolean:
.head 6 -                       Parameters
.head 6 -                       Static Variables
.head 6 -                       Local variables
.head 6 +                       Actions
.head 7 +                       If GetSignType() = 'NBU'
.head 8 -                       Return sIni()
.head 7 +                       Else
.head 8 -                       Return MessageErrorEx('Неверный тип ЭЦП: '|| GetSignType()
||' Требуемый тип ЭЦП: '||'NBU')
.head 3 +  Functional Class: cK2Doc
.head 4 -  Description:
.head 4 +  Derived From
.head 5 -  Class: cDoc
.head 4 -  Class Variables
.head 4 +  Instance Variables
.head 5 -  Number: nK2Mode
.head 5 -  Number: nK2Ref
.head 5 -  String: sK2Nls9
.head 5 -  String: sK2NlsK
.head 4 +  Functions
.head 5 +  Function: iDoc
.head 6 -  Description:
.head 6 -  Returns
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set cDoc.m_nPyD=0   ! Запретить оплату по факт остатку
.head 7 -  Return cDoc.iDoc()
.head 5 +  Function: oDoc
.head 6 -  Description: Оплатить документ с
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sErrTxt
.head 6 +  Actions
.head 7 +  While TRUE
.head 8 +  If cDoc.oDoc()
.head 9 +  If nK2Mode = 3
.head 10 +  If not SqlPLSQLCommand(hSql(), "p_asse(cDoc.m_nRef)")
.head 11 -  Set sErrTxt = 'Невозможно выполнить ASSE ' || cDoc.m_sTT
.head 11 -  Break
.head 9 +  If cDoc.B.Bank = GetBankMfo() and
  (cDoc.m_sTT = 'K2I' or cDoc.m_sTT = 'K2E' or cDoc.m_sTT = 'K2C' or cDoc.m_sTT = 'K2G')
.head 10 +  If not SqlPLSQLCommand(hSql(),
  "DynTT(0,cDoc.m_nRef,cDoc.m_dDatV1,cDoc.m_nDk,cDoc.A.Kv,cDoc.A.Nls,cDoc.A.S,cDoc.B.Kv,cDoc.B.Nls,cDoc.B.S)")
.head 11 -  Set sErrTxt = 'Невозможно выполнить связанную операцию для ' || cDoc.m_sTT
.head 11 -  Break
.head 9 +  If not cDoc.P_Fac(cDoc.m_nRef, SalFmtFormatDateTime(cDoc.m_dDatV1, 'MM-dd-yyyy'))
.head 10 -  Set sErrTxt = 'Невозможно оплатить док. РЕФ #' || Str(cDoc.m_nRef)
.head 10 -  Break
.head 9 +  If not cDoc.PayV(1,nK2Ref,cDoc.m_dDatV1,'K2O',1,cDoc.A.Kv,sK2NlsK,cDoc.A.S,cDoc.B.Kv,sK2Nls9,cDoc.B.S)
.head 10 -  Set sErrTxt = 'Невозможно оплатить док. K2-РЕФ #' || Str(nK2Ref)
.head 10 -  Break
.head 9 -  Return TRUE
.head 8 +  Else
.head 9 -  Return FALSE
.head 7 -  Call SqlRollback(hSql())
.head 7 -  Call MessageErrorEx('Ошибка : ' || sErrTxt || '.')
.head 7 -  Return FALSE
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
.head 2 +  Application Actions
.head 3 -  On SAM_AppStartup
.head 1 +  Table Window: T902	 !! картотека дикарей -- старая
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Разбор сумм СЭП "до выяснения"
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? No
.head 3 -  Initial State: Maximized
.head 3 -  Maximizable? Yes
.head 3 -  Minimizable? Yes
.head 3 -  System Menu? Yes
.head 3 -  Resizable? Yes
.head 3 -  Window Location and Size
.head 4 -  Left:   0.53"
.head 4 -  Top:    0.7"
.head 4 -  Width:  13.533"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.781"
.head 4 -  Height Editable? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: System Window Color
.head 3 -  View: Table
.head 3 -  Allow Row Sizing? No
.head 3 -  Lines Per Row: Default
.head 2 -  Memory Settings
.head 3 -  Maximum Rows in Memory: 2000
.head 3 -  Discardable? No
.head 2 -  Description:
.head 2 -  Named Menus
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.69"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Contents
.head 4 +  Pushbutton: pbTudaSuda
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cTBarButton
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.15"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.433"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Doc_out.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Вернуть назад '
.head 6 +  On SAM_Click
.head 7 -  Call T902.FU3(3)
.head 4 +  Pushbutton: pbAlt
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cTBarButton
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   5.083"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.433"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\App1.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Зачислить по Альтернативному счету '
.head 6 +  On SAM_Click
.head 7 +  ! If not ShowInputPassword()
.head 8 -                          Return FALSE
.head 7 -  Set nRow=TBL_MinRow
.head 7 -  Call SalTblClearSelection( hWndForm )
.head 7 -  Call WaitCursorOn()
.head 7 -  !
.head 7 +  While SalTblFindNextRow( hWndForm, nRow, 0, 0 )
.head 8 -  Call SalTblFetchRow( hWndForm, nRow )
.head 8 -  Call SalTblSetRowFlags( hWndForm, nRow, ROW_Selected, TRUE )
.head 8 -  Set T902.sNLSB2 = IifN(T902.OTM=1,
    SalStrToNumber(T902.NLSB), NUMBER_Null)
.head 8 +  If SqlPrepareAndExecute( hSql(),
  "SELECT nls INTO :T902.sNLSB2
   FROM accounts WHERE nlsalt=:T902.NLSB and kv=:T902.nBaseVal " )
and SqlFetchNext( hSql(), nFetchRes )
.head 9 -  Call T902.FU3(1)
.head 8 +  Else
.head 9 -  Call SalMessageBox( "Счет "||T902.NLSB ||" (как альтернативный) НЕ НАЙДЕН !", "Ошибка !", 1 )
.head 7 -  Call WaitCursorOff()
.head 4 +  Pushbutton: pbIns
.head 5 -  Class Child Ref Key: 33
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.586"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Tomail.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Другому получателю'
.head 6 +  On SAM_Click
.head 7 -  Set T902.F902 = TRUE
.head 7 -  Call SalEnableWindow(T902.sMFOB2)
.head 7 -  Call SalEnableWindow(T902.sNLSB2)
.head 7 -  Set T902.sMFOB2 = NUMBER_Null
.head 7 -  Set T902.sNLSB2 = NUMBER_Null
.head 7 -  Call SalSetFocus(T902.sMFOB2)
.head 7 -  Call SalShowWindow(T902.pbIns1)
.head 4 +  Pushbutton: pbIns1
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbSynchro
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.686"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.433"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Execute.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Red
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Подтвердить '
.head 6 +  On SAM_Click
.head 7 -  Call SalHideWindow(T902.pbIns1)
.head 7 +  If T902.F901 !! Внутренний платеж
.head 8 -  Call T902.FU3(1)
.head 7 +  If T902.F902 !! Внешний  платеж
.head 8 -  Call T902.FU3(2)
.head 7 -  Call SalSendMsg( hWndForm, SAM_RowSetContext, 0, 0)
.head 4 +  Pushbutton: pbDel
.head 5 -  Class Child Ref Key: 34
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   5.55"
.head 6 -  Top:    0.071"
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
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = ' Изъять'
.head 6 +  On SAM_Click
.head 7 -  Call T902.FU3(4)
.head 4 +  Pushbutton: pbRefresh
.head 5 -  Class Child Ref Key: 35
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   7.05"
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
.head 6 -  Left:   4.617"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Apply.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Зачислить '
.head 6 +  On SAM_Click
.head 7 -  Set T902.sNLSB2 = IifN(T902.OTM=1,
    SalStrToNumber(T902.NLSB), NUMBER_Null)
.head 7 +  If T902.OTM = 1
.head 8 -  Call T902.FU3(1)
.head 7 +  Else
.head 8 -  Set T902.F901 = TRUE
.head 8 -  Call SalEnableWindow(T902.sNLSB2)
.head 8 -  Call SalSetFocus(T902.sNLSB2)
.head 4 -  Line
.head 5 -  Resource Id: 33708
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  5.457"
.head 6 -  Begin Y:  -0.01"
.head 6 -  End X:  5.457"
.head 6 -  End Y:  0.448"
.head 5 -  Visible? No
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
.head 6 -  Left:   7.483"
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
.head 6 -  Left:   7.917"
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
.head 6 -  Left:   8.35"
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
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Документ '
.head 6 +  On SAM_Click
.head 7 -  Call DocViewContents(hWndMDI, T902.REC)
.head 4 +  Pushbutton: pbPr1
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbSynchro
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   8.8"
.head 6 -  Top:    0.06"
.head 6 -  Width:  0.433"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\A_link.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Red
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Порожденный документ '
.head 6 +  On SAM_Click
.head 7 -  Call DocViewContentsEx(hWndMDI, T902.REFN)
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 40
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   9.25"
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
.head 5 -  Resource Id: 33709
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  4.786"
.head 6 -  Begin Y:  0.073"
.head 6 -  End X:  4.786"
.head 6 -  End Y:  0.531"
.head 5 -  Visible? No
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
.head 6 -  Left:   9.883"
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
.head 5 -  Resource Id: 33710
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  2.1"
.head 6 -  Begin Y:  -0.01"
.head 6 -  End X:  2.1"
.head 6 -  End Y:  0.448"
.head 5 -  Visible? No
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 +  Data Field: sNAMB2
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
.head 7 -  Left:   0.017"
.head 7 -  Top:    0.406"
.head 7 -  Width:  5.65"
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
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 +  Data Field: sNAMB1
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
.head 7 -  Left:   5.6"
.head 7 -  Top:    0.679"
.head 7 -  Width:  6.3"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.25"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? No
.head 6 -  Border? Yes
.head 6 -  Justify: Left
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 +  Data Field: sBANK
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
.head 7 -  Left:   0.183"
.head 7 -  Top:    0.656"
.head 7 -  Width:  5.4"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.25"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? No
.head 6 -  Border? Yes
.head 6 -  Justify: Left
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 -  !
.head 4 +  Data Field: sMFOB2
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: 9
.head 6 -  Data Type: Number
.head 6 -  Editable? No
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   1.086"
.head 7 -  Top:    0.073"
.head 7 -  Width:  0.9"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.313"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? Yes
.head 6 -  Justify: Left
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 +  Message Actions
.head 6 +  On SAM_Validate
.head 7 +  If T902.F902 !! Внешний платеж
.head 8 -  Call SqlPrepareAndExecute(hSql(), "
     SELECT nb
     INTO :T902.sBANK
     FROM banks
     WHERE mfo=:T902.sMFOB2")
.head 8 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 9 +  If SalMessageBox("ВВЕСТИ повторно ?", 'Банк с МФО '
   || Str(T902.sMFOB2) || ' Не открыт !',
   MB_YesNo | MB_IconHand) = IDYES
.head 10 -  Call SalSetFocus(T902.sMFOB2)
.head 10 -  Return FALSE
.head 9 +  Else
.head 10 -  Call T902.FU1()
.head 10 -  Return TRUE
.head 8 +  Else
.head 9 -  Call SalSetFocus(T902.sNLSB2)
.head 7 -  Return TRUE
.head 4 +  Data Field: sNLSB2
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: 14
.head 6 -  Data Type: Number
.head 6 -  Editable? Yes
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   1.986"
.head 7 -  Top:    0.073"
.head 7 -  Width:  1.6"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.313"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? Yes
.head 6 -  Justify: Left
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 +  Message Actions
.head 6 +  On SAM_Validate
.head 7 +  If T902.F901 !! Внутренний платеж
.head 8 -  Call SqlPrepareAndExecute(hSql(), "
     SELECT nms
     INTO :T902.sNAMB2
     FROM accounts
     WHERE nls=:T902.sNLSB2")
.head 8 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 9 +  If SalMessageBox("ВВЕСТИ повторно ?", 'Счет ' ||
   Str(T902.sNLSB2) || ' Не открыт !',
   MB_YesNo | MB_IconHand) = IDYES
.head 10 -  Call SalSetFocus(T902.sNLSB2)
.head 10 -  Return VALIDATE_Cancel
.head 9 +  Else
.head 10 -  Call T902.FU1()
.head 10 -  Return VALIDATE_Ok
.head 8 -  Call T902.FU3(1)
.head 7 +  If T902.F902 !! Внешний  платеж
.head 8 +  If T902.sMFOB2 = NUMBER_Null
.head 9 -  Set sNLSB2 = NUMBER_Null
.head 9 -  Call SalSetFocus(sMFOB2)
.head 9 -  Return TRUE
.head 8 +  If Vkrz2(Str(T902.sMFOB2), Str(T902.sNLSB2)) !=
   Str(T902.sNLSB2)
.head 9 +  If SalMessageBox("ВВЕСТИ повторно ?", 'Ош.Счет ' ||
   Str(T902.sNLSB2), MB_YesNo | MB_IconHand) = IDYES
.head 10 -  Call SalSetFocus(sNLSB2)
.head 10 -  Return FALSE
.head 9 +  Else
.head 10 -  Set T902.F902 = FALSE
.head 10 -  Call T902.FU1()
.head 10 -  Call SalSetFocus(T902)
.head 8 +  ! Else
.head 9 -                          Call T902.FU3(2)
.head 7 -  Call SalSetFocus(T902.pbIns1)
.head 7 -  Return TRUE
.head 4 +  Data Field: sNAZN1
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: 160
.head 6 -  Data Type: String
.head 6 -  Editable? No
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   5.657"
.head 7 -  Top:    0.406"
.head 7 -  Width:  7.557"
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
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 -  !
.head 4 +  Data Field: dfSumSelect
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
.head 7 -  Left:   10.843"
.head 7 -  Top:    0.071"
.head 7 -  Width:  1.9"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.31"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? Yes
.head 6 -  Justify: Right
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbBack_All
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbGetValue
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   6.017"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\A_bkld.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Повернути платникам пакетом (Рахунки закрито)'
.head 6 +  On SAM_Click
.head 7 -  Set nRow=TBL_MinRow
.head 7 -  Call SalTblClearSelection( hWndForm )
.head 7 -  Call WaitCursorOn()
.head 7 -  !
.head 7 +  While SalTblFindNextRow( hWndForm, nRow, 0, 0 )
.head 8 -  Call SalTblFetchRow( hWndForm, nRow )
.head 8 -  Call SalTblSetRowFlags( hWndForm, nRow, ROW_Selected, TRUE )
.head 8 +  If SqlPrepareAndExecute( hSql(),
  "SELECT nls FROM accounts WHERE nls=:T902.NLSB and kv=:T902.nBaseVal and dazs is not null" )
and SqlFetchNext( hSql(), nFetchRes )
.head 9 -  Call T902.FU3(-3)
.head 7 -  Call WaitCursorOff()
.head 2 +  Contents
.head 3 +  Column: REF
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Референс
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.85"
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
.head 3 +  Column: MFOA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: МФО-A
из док
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.814"
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
.head 3 +  Column: NLSA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Счет-A
из док
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.229"
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
.head 3 +  Column: OKPOA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ОКПО-A
из док
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.083"
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
.head 3 +  Column: NLSB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Счет-Б
из документа
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.386"
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
.head 3 +  Column: NAMB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Получатель
из документа
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.667"
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
.head 3 +  Column: S
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сумма док
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.357"
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
.head 3 +  Column: OTM
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отк
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.417"
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
.head 3 +  Column: NAZN
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Подробности платежа
.head 4 -  Visible? No
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  5.067"
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
.head 3 +  Column: DK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: DK
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  1.083"
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
.head 3 +  Column: REC
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: REC
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  1.083"
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
.head 3 +  Column: NAMB2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
счета
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.343"
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
.head 3 +  Column: FDAT
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
зачисления
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Left
.head 4 -  Width:  1.014"
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
.head 3 +  Column: ND
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: N док

.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 10
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.057"
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
.head 3 +  Column: NAMA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Плательщик
из документа
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.486"
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
.head 3 +  Column: VOB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вид оп.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.483"
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
.head 3 +  Column: DATD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
док
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Left
.head 4 -  Width:  1.15"
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
.head 3 +  Column: OPL
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ОПЛ
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.4"
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
.head 3 +  Column: REFN
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: NEW ref
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.771"
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
.head 2 +  Functions
.head 3 +  Function: FU3 !! ОПЛАТА
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Number: para
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: ss1
.head 5 -  String: ss2
.head 5 -  String: tt
.head 5 -  String: s1
.head 5 -  String: s2
.head 5 -  String: s3
.head 5 -  String: s4
.head 5 -  String: s5
.head 5 -  String: s6
.head 4 +  Actions
.head 5 +  If T902.OPL=0
.head 6 -  Set s6='99999'
.head 6 +  If para=1
.head 7 -  Set ss1 = IifS(T902.DK=0, "ПЕРЕДЕБЕ", "ПЕРЕКРЕДИ") ||
    "ТОВАТЬ документ на счет " || Str(T902.sNLSB2) ||
    ' ' || T902.sNAMB2
.head 7 -  Set ss2 = "Будет сформирован внутренний мем.ордер !"
.head 7 -  Set s1 = T902.sNAMB1
.head 7 -  Set s2 = Str(T902.sNLSB2)
.head 7 -  Set s3 = T902.sBankMfo
.head 7 -  Set s4 = 'Перекр./' || T902.MFOA || '/' || T902.NLSA ||
    '/' || T902.NAMA || '/'
.head 6 +  If para=2
.head 7 -  Set ss1 = "ПЕРЕКРЕДИТОВАТЬ "||IifS(SalNumberToStrX(sMFOB2,0)=GetBankMfo(),
          " другому получателю","в другой банк")
.head 7 -  Set ss2 = "Будет сформирован новый документ !"
.head 7 -  Set s1 = T902.NAMB
.head 7 -  Set s2 = Str(T902.sNLSB2)
.head 7 -  Set s3 = Str(T902.sMFOB2)
.head 7 -  Set s4 = 'Перекр./' || T902.MFOA || '/' || T902.NLSA ||
    '/' || T902.NAMA || '/'
.head 6 +  If para=3
.head 7 -  Set ss1 = "ВЕРНУТЬ документ отправителю"
.head 7 -  Set ss2 = "Будет сформирован обратный межбанковский документ !"
.head 7 -  Set s1 = T902.NAMA
.head 7 -  Set s2 = T902.NLSA
.head 7 -  Set s3 = T902.MFOA
.head 7 -  Set s6 = T902.OKPOA
.head 7 -  Set s4 = 'Повернено.Уточніть реквіз./' || T902.NAMB
.head 6 +  If para= -3
.head 7 -  Set ss1 = "ВЕРНУТЬ документ отправителю"
.head 7 -  Set ss2 = "Будет сформирован обратный межбанковский документ !"
.head 7 -  Set s1 = T902.NAMA
.head 7 -  Set s2 = T902.NLSA
.head 7 -  Set s3 = T902.MFOA
.head 7 -  Set s6 = T902.OKPOA
.head 7 -  Set s4 = 'Рахунок '||T902.NLSB||' закрито.'
.head 6 +  If para=4
.head 7 -  Set ss1 = "УДАЛИТЬ из картотеки невыясненных сумм"
.head 7 -  Set ss2 = "Документ по перекредитовке необходимо " ||
    "ввести вручную !"
.head 6 +  If nPar=10 or
   SalMessageBox(ss1 || " ?", ss2, MB_YesNo | MB_IconHand) = IDYES
.head 7 +  If para < 4
.head 8 -  Call cDoc.SetDoc(0, IifS(s3=GetBankMfo(), '901', '902'),
     T902.DK, 6, T902.ND, GetBankDate(), GetBankDate(), GetBankDate(),
     GetBankDate(),
     IifS(T902.DK=1, T902.S902, T902.S90D),
     IifS(T902.DK=1, T902.NMS902, T902.NMS90D), T902.sBankMfo, '',
     T902.nBaseVal, T902.S*100, GetBankOkpoS(), s2, s1, s3, '',
     T902.nBaseVal, T902.S*100, s6,
     SalStrTrimX(SalStrLeftX(s4 || '/' || T902.NAZN,
     160)), '', GetIdOper(), '', NUMBER_Null, 0)
.head 8 +  If not cDoc.oDoc()
.head 9 -  Call SqlRollback(hSql())
.head 9 -  Return FALSE
.head 8 -  Set T902.REFN = cDoc.m_nRef
.head 8 -  Call SqlPrepareAndExecute(hSql(), "
     DELETE
     FROM t902
     WHERE ref=:T902.REF")
.head 8 -  Call SqlCommitEx(hSql(), ss1 || ' Обработка REF=' ||
     SalNumberToStrX(T902.REF, 0))
.head 8 +  If nPar !=10
.head 9 -  ! печать исходного
.head 9 -  Call DocsPrint(T902.REC, 'ARC_RRP', PRINT_DOC)
.head 9 -  ! печать возвратного
.head 9 -  Call DocsPrint(T902.REFN, 'OPER', PRINT_DOC)
.head 7 +  Else
.head 8 -  Call SqlPrepareAndExecute(hSql(), "
     DELETE
     FROM t902
     WHERE ref=:T902.REF")
.head 8 -  Call SqlCommitEx(hSql(), ss1 || ' Удаление REF=' ||
     SalNumberToStrX(T902.REF, 0))
.head 7 -  Set T902.OPL = 1
.head 7 -  Call SalTblSetCellTextColor(T902.REF, COLOR_Red, FALSE)
.head 7 -  Call SalTblSetCellTextColor(T902.MFOA, COLOR_Red, FALSE)
.head 7 -  Call SalTblSetCellTextColor(T902.NLSA, COLOR_Red, FALSE)
.head 7 -  Call SalTblSetCellTextColor(T902.NLSB, COLOR_Red, FALSE)
.head 7 -  Call SalTblSetCellTextColor(T902.NAMB, COLOR_Red, FALSE)
.head 7 -  Call SalTblSetCellTextColor(T902.S, COLOR_Red, FALSE)
.head 7 -  Call SalTblSetCellTextColor(T902.NAZN, COLOR_Red, FALSE)
.head 7 -  Call SalTblSetCellTextColor(T902.OTM, COLOR_Red, FALSE)
.head 7 -  Call SalTblSetCellTextColor(T902.DATD, COLOR_Red, FALSE)
.head 7 -  Call SalTblSetCellTextColor(T902.VOB, COLOR_Red, FALSE)
.head 7 -  Call SalTblSetCellTextColor(T902.NAMA, COLOR_Red, FALSE)
.head 7 -  Call SalTblSetCellTextColor(T902.ND, COLOR_Red, FALSE)
.head 7 -  Call SalTblSetCellTextColor(T902.DK, COLOR_Red, FALSE)
.head 7 -  Call SalTblSetCellTextColor(T902.REC, COLOR_Red, FALSE)
.head 7 -  Call SalTblSetCellTextColor(T902.OTM, COLOR_Red, FALSE)
.head 7 -  Call SalTblSetCellTextColor(T902.NAMB2, COLOR_Red,
     FALSE)
.head 7 -  Call SalTblSetCellTextColor(T902.FDAT, COLOR_Red, FALSE)
.head 7 -  Call SalEnableWindow(pbPr1)
.head 7 -  Call T902.FU2()
.head 6 +  Else
.head 7 -  Call T902.FU1()
.head 5 -  Return TRUE
.head 3 +  Function: FU1 !! Заполнение нижних данных
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SalDisableWindow(T902.sMFOB2)
.head 5 -  Call SalDisableWindow(T902.sBANK )
.head 5 -  Call SalDisableWindow(T902.sNAZN1)
.head 5 -  Call SalDisableWindow(T902.sNAMB2)
.head 5 -  Call SalDisableWindow(T902.sNLSB2)
.head 5 -  Call SalDisableWindow(T902.sNAMB1)
.head 5 -  Set T902.F901 = FALSE
.head 5 -  Set T902.F902 = FALSE
.head 5 -  Set T902.sMFOB2 = SalStrToNumber(GetBankMfo())
.head 5 -  Set T902.sBANK = GetBankName()
.head 5 -  Set T902.sNAZN1 = T902.NAZN
.head 5 -  Set T902.sNAMB2 = T902.NAMB2
.head 5 -  Set T902.sNAMB1 = T902.NAMB
.head 5 -  Set T902.sNLSB2 = NUMBER_Null
.head 3 +  Function: FU2 !! Очистка нижних данных
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Set T902.F901 = FALSE
.head 5 -  Set T902.F902 = FALSE
.head 5 -  Set T902.sMFOB2 = NUMBER_Null
.head 5 -  Set T902.sBANK =''
.head 5 -  Set T902.sNAZN1 = ''
.head 5 -  Set T902.sNAMB2 = ''
.head 5 -  Set T902.sNLSB2 = NUMBER_Null
.head 5 -  Set T902.sNAMB1 = ''
.head 2 +  Window Parameters
.head 3 -  Number: nPar
.head 2 +  Window Variables
.head 3 -  String: ss
.head 3 -  Number: ACC902
.head 3 -  Number: ACC90D
.head 3 -  String: NMS902
.head 3 -  String: NMS90D
.head 3 -  Number: IS902
.head 3 -  Number: IS90D
.head 3 -  String: S902
.head 3 -  String: S90D
.head 3 -  Boolean: F901
.head 3 -  Boolean: F902
.head 3 -  Number: nRow
.head 3 -  Number: nInd
.head 3 -  Number: nOsts
.head 3 -  Number: nAcrD
.head 3 -  Number: nCuRw
.head 3 -  Long String: lsSign
.head 3 -  String: sOkpoA
.head 3 -  String: sOkpoB
.head 3 -  String: sOperID
.head 3 -  Number: nErrorSign
.head 3 -  Boolean: bSingOk
.head 3 -  String: strErrorSign
.head 3 -  Number: nFetchRes
.head 3 -  Number: nChoice
.head 3 -  String: sTT
.head 3 -  String: sBankDay
.head 3 -  Date/Time: dBankDay
.head 3 -  String: sBankMfo
.head 3 -  : cDoc
.head 4 -  Class: cDoc
.head 3 -  Number: nBaseVal
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalHideWindow(T902.pbIns1)
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Call SalMapEnterToTab(TRUE)
.head 4 +  If nPar=0
.head 5 -  Call SalTblSetTableFlags(hWndForm, TBL_Flag_SingleSelection, TRUE)
.head 4 -  Set T902.sBankDay = GetBankDateEx()
.head 4 -  Set T902.dBankDay = GetBankDate()
.head 4 -  Set T902.F901 = FALSE
.head 4 -  Set T902.sBankMfo = GetBankMfo()
.head 4 -  Set T902.sOperID = GetIdOper()
.head 4 -  Set T902.nBaseVal = GetBaseVal()
.head 4 -  Set T902.sOkpoA = GetBankOkpoS()
.head 4 -  Set T902.strFilterTblName = 'ARC_RRP'
.head 4 -  Set T902.strPrintFileName = 'T902.txt'
.head 4 +  If SqlPrepareAndExecute(hSql(), "
   SELECT nls,acc,nms,ostc
   INTO :T902.S902,:T902.ACC902,:T902.NMS902,:T902.IS902
   FROM accounts
   WHERE kv=" || Str(T902.nBaseVal) || " and tip='902'") and
   SqlFetchNext(hSql(), nFetchRes) and
   SqlPrepareAndExecute(hSql(), "
   SELECT nls,acc,nms,ostc
   INTO :T902.S90D,:T902.ACC90D,:T902.NMS90D,:T902.IS90D
   FROM accounts
   WHERE kv=" || Str(T902.nBaseVal) || " and tip='90D'") and
   SqlFetchNext(hSql(), nFetchRes)
.head 5 -  Set T902.strSqlPopulate =
"SELECT o.dk, o.ref,  ARC_RRP.mfoa, ARC_RRP.nlsa,  ARC_RRP.s/100,
        ARC_RRP.nlsb, ARC_RRP.nam_b, ARC_RRP.nazn, ARC_RRP.rec,
        o.fdat, ARC_RRP.nd, ARC_RRP.nam_a,ARC_RRP.vob, ARC_RRP.datd,
        ARC_RRP.id_a
 INTO :T902.DK,:T902.REF,:T902.MFOA,:T902.NLSA,:T902.S,
      :T902.NLSB,:T902.NAMB,:T902.NAZN,:T902.REC,
      :T902.FDAT,:T902.ND,:T902.NAMA,:T902.VOB,:T902.DATD,
      :T902.OKPOA
 FROM ARC_RRP , opldok o, t902 t
 WHERE o.acc IN (" || Str(T902.ACC902) || "," ||
       Str(T902.ACC90D) ||") and o.ref=t.ref and
       o.tt in ('R01','D01') and o.ref=ARC_RRP.ref
 ORDER BY o.ref desc"
.head 5 -  ! Call Debug(T902.strSqlPopulate)
.head 5 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On SAM_FetchRowDone
.head 4 -  ! Set T902.NAMA = StrDosToWinX(T902.NAMA)
.head 4 -  ! Set T902.NAMB = StrDosToWinX(T902.NAMB)
.head 4 -  ! Set T902.NAZN = StrDosToWinX(T902.NAZN)
.head 4 -  ! Set T902.ND = StrDosToWinX(T902.ND)
.head 4 +  If SqlPrepareAndExecute(hSqlAux(),
  "SELECT decode(dazs, null, 1,0),
          decode(dazs, null, nms, 'Закр.'||to_char(dazs,'dd-mm-yyyy') )
   INTO :T902.OTM, :T902.NAMB2  FROM accounts
   WHERE kv=" || Str(T902.nBaseVal) || " and nls=:T902.NLSB ")
and SqlFetchNext(hSqlAux(), nFetchRes)
.head 5 -  ! Set T902.OTM =
    IifN(SqlFetchNext(hSqlAux(), nFetchRes), 1, 0)
.head 4 -  Call SalTblSetCellTextColor(T902.S, IifN(T902.DK=0,
     COLOR_DarkRed, COLOR_DarkBlue), FALSE)
.head 4 -  Call SalTblSetCellTextColor(T902.REF, IifN(T902.DK=0,
     COLOR_DarkRed, COLOR_DarkBlue), FALSE)
.head 4 -  Set T902.OPL = 0
.head 3 +  On WM_Char
.head 4 +  If wParam = 32
.head 5 -  Call DocViewContents(hWndMDI, T902.REC)
.head 3 +  On SAM_DoubleClick
.head 4 +  If T902.REC
.head 5 -  Call SalSendMsg( pbDetails, SAM_Click, 0, 0 )
.head 3 +  On SAM_RowSetContext
.head 4 -  Call T902.FU1()
.head 4 +  If T902.OPL = 1
.head 5 -  Call SalDisableWindow(T902.pbTudaSuda)
.head 5 -  Call SalDisableWindow(T902.pbIns)
.head 5 -  Call SalDisableWindow(T902.pbUpdate)
.head 5 -  Call SalDisableWindow(T902.pbDel)
.head 4 +  Else
.head 5 +  If T902.DK = 1
.head 6 -  Call SalEnableWindow(T902.pbIns)
.head 6 -  Call SalEnableWindow(T902.pbTudaSuda)
.head 5 +  Else
.head 6 -  Call SalDisableWindow(T902.pbIns)
.head 6 -  Call SalDisableWindow(T902.pbTudaSuda)
.head 5 -  Call SalEnableWindow(T902.pbUpdate)
.head 5 -  Call SalEnableWindow(T902.pbDel)
.head 4 +  If T902.REFN = NUMBER_Null
.head 5 -  Call SalDisableWindow(pbPr1)
.head 4 +  Else
.head 5 -  Call SalEnableWindow(pbPr1)
.head 3 +  On SAM_Destroy
.head 4 -  Call SalSendClassMessage(SAM_Destroy, wParam, lParam)
.head 4 -  Set bTB4 = FALSE
.head 3 +  On WM_LbuttonUp
.head 4 -  ! Обращайте внимание на номер суммируемой колонки!
.head 4 -  Set dfSumSelect=SalTblColumnSum( hWndForm, 6, ROW_Selected, 0 )
.head 1 +  Table Window: TKOM	 !! начислено комиссий по счетам
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
.head 4 -  Width:  11.029"
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
.head 5 -  Resource Id: 22838
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
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 +  ! If not b2
.head 8 -                          Set b2=TRUE
.head 7 -  Call SalCreateWindow(TK, hWndMDI,TKOM.NMS, TKOM.NLS, TKOM.KV, TKOM.nAcc)
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
.head 5 -  Resource Id: 22839
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
.head 5 -  Resource Id: 22840
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
.head 3 +  Column: ISP
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Исп
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.614"
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
.head 3 +  Column: NLS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Счет
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.714"
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
.head 3 +  Column: KV
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вал
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.6"
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
.head 3 +  Column: NMS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
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
.head 3 +  Column: NLS8
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Счет
8 класса
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  1.829"
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
.head 3 +  Column: DATP
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата пред
 списания
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.471"
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
.head 3 +  Column: SKOM
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сумма нач
комиссии
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.543"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.head 3 -  Number: nPar
.head 2 +  Window Variables
.head 3 -  Number: nBaseVal
.head 3 -  Number: nAcc
.head 3 -  String: s9
.head 3 -  Boolean: b2
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalWaitCursor( TRUE )
.head 4 -  Set TKOM.nBaseVal=GetBaseVal()
.head 4 -  Set TKOM.strSqlPopulate="
 SELECT isp, nls, kv, nms INTO :TKOM.ISP,:TKOM.NLS,:TKOM.KV,:TKOM.NMS
 FROM accounts
 WHERE kv=:TKOM.nBaseVal and
      nbs in (2600,2620)  and
       substr(nls,6,9) in
   (select substr(nls,6,9) from accounts
    where kv=:TKOM.nBaseVal and nbs=8600 and ostc<0)
 ORDER BY 1,2 "
.head 4 -  Call SalMapEnterToTab( TRUE )
.head 4 -  ! Set TZ.sBankDay=GetBankDateEx( )
.head 4 -  ! Set TZ.dBankDay=GetBankDate( )
.head 4 -  ! Set TZ.F901=FALSE
.head 4 -  ! Set TZ.sBankMfo=GetBankMfo()
.head 4 -  ! Set TZ.sOperID=GetIdOper()
.head 4 -  ! Set TZ.nBaseVal=GetBaseVal()
.head 4 -  Set TKOM.strFilterTblName = 'ACCOUNTS'
.head 4 -  Set TKOM.strPrintFileName = 'Acc-26.txt'
.head 4 -  Call SalSendClassMessage( SAM_Create, 0, 0 )
.head 3 +  On SAM_FetchRowDone
.head 4 -  Set s9=Subs(TKOM.NLS,6,9)
.head 4 -  If SqlPrepareAndExecute( hSqlAux(),
  "SELECT acc, nls, ostc/100
   INTO :nAcc,:TKOM.NLS8,:TKOM.SKOM
   FROM accounts
   WHERE kv=:TKOM.nBaseVal AND nbs=8600 AND substr(nls,6.9)=:s9" )
and SqlFetchNext( hSqlAux(), nFetchRes )
and SqlPrepareAndExecute( hSqlAux(),
  "SELECT max(fdat)
   FROM saldoa
   WHERE acc=:nAcc AND ostf-dos+kos=0" )
and SqlFetchNext( hSqlAux(), nFetchRes )
.head 3 +  On SAM_Destroy
.head 4 -  Call SalSendClassMessage( SAM_Destroy, wParam, lParam )
.head 4 -  Set bTB2 = FALSE
.head 1 +  Table Window: TK
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
.head 4 -  Left:   1.08"
.head 4 -  Top:    0.9"
.head 4 -  Width:  10.186"
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
.head 5 -  Resource Id: 23303
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
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 -  Call DocViewContentsEx(hWndMDI, TK.REF)
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
.head 5 -  Resource Id: 23304
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
.head 5 -  Resource Id: 23305
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
.head 3 +  Column: PDAT
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Поступил
в банк
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.786"
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
.head 3 +  Column: FDAT
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Оплачено
в банке
.head 4 -  Visible? Yes
.head 4 -  Editable? No
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
.head 3 +  Column: REF
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Реф
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.2"
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
.head 3 +  Column: TT
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Оп
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
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
.head 3 +  Column: ND
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: №
документа
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Right
.head 4 -  Width:  1.3"
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
.head 3 +  Column: SD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сумма
документа
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.9"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.head 3 +  Column: SK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сумма
комиссии
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.286"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.head 3 -  String: NMS
.head 3 -  String: NLS
.head 3 -  Number: KV
.head 3 -  Number: nAcc
.head 2 -  Window Variables
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalWaitCursor( TRUE )
.head 4 -  Call SalSetWindowText( hWndForm,
 'Док. и нач.комиссии в 8 кл по '||NLS||' '||Str(KV)||' '||NMS)
.head 4 -  ! Set TK.nBaseVal=GetBaseVal()
.head 4 -  Set TK.strSqlPopulate="
 SELECT oper.pdat, opldok.fdat, oper.ref, oper.tt, oper.nd, oper.s/100,   opldok.s/100
 INTO :TK.PDAT,  :TK.FDAT,      :TK.REF,  :TK.TT,  :TK.ND,:TK.SD,:TK.SK
 FROM oper, opldok
 WHERE oper.nlsa=:TK.NLS AND oper.kv=:TK.KV  AND
       oper.ref=opldok.ref AND
       opldok.acc=:TK.nAcc AND opldok.dk=0
 ORDER BY 1,2,3 "
.head 4 -  Call SalMapEnterToTab( TRUE )
.head 4 -  ! Set TZ.sBankDay=GetBankDateEx( )
.head 4 -  ! Set TZ.dBankDay=GetBankDate( )
.head 4 -  ! Set TZ.F901=FALSE
.head 4 -  ! Set TZ.sBankMfo=GetBankMfo()
.head 4 -  ! Set TZ.sOperID=GetIdOper()
.head 4 -  ! Set TZ.nBaseVal=GetBaseVal()
.head 4 -  Set TK.strFilterTblName = 'OPER'
.head 4 -  Set TK.strPrintFileName = 'Op-26.txt'
.head 4 -  Call SalSendClassMessage( SAM_Create, 0, 0 )
.head 1 +  Form Window: frm_Pay_Bck !! возврат операций
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Выполнение возврата операций
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? No
.head 3 -  Automatically Created at Runtime? Yes
.head 3 -  Initial State: Normal
.head 3 -  Maximizable? Yes
.head 3 -  Minimizable? Yes
.head 3 -  System Menu? Yes
.head 3 -  Resizable? No
.head 3 -  Window Location and Size
.head 4 -  Left:   1.525"
.head 4 -  Top:    0.552"
.head 4 -  Width:  6.5"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 3.4"
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
.head 2 -  Description: возврат операций
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
.head 3 +  Pushbutton: pbSearch
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Искать
.head 4 -  Window Location and Size
.head 5 -  Left:   0.457"
.head 5 -  Top:    1.76"
.head 5 -  Width:  1.3"
.head 5 -  Width Editable? No
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? No
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\search.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click   !nata
.head 6 +  If SqlPrepareAndExecute( hSql(), "
  SELECT o.s*power(10,-v.dig), o.dk, o.sos, v.lcv
  INTO :nSum, :nDK, :nSOS, :sLCV
  FROM oper o, tts t, tabval v
  WHERE o.ref=:nRef AND o.tt=t.tt AND o.kv=v.kv AND
        o.tt not in (select tt from templates) AND
        ((o.sos<5 OR t.fli=0 OR t.fli is null) OR
         (o.mfoa=o.mfob)) AND o.sos>0" )
and SqlFetchNext( hSql(), nFetchRes )
and ( ( SqlPrepareAndExecute( hSql(), "
  SELECT count(*) FROM opldok INTO :nTmp WHERE ref=:nRef ")
    and SqlFetchNext( hSql(), nFetchRes )
    and nTmp>0 ) or nDK=2 )
.head 7 -  Call DocViewContentsEx(hWndMDI, nRef)
.head 7 -  Call SalEnableWindow( pbOk )
.head 6 +  Else
.head 7 -  Call SalDisableWindow( pbOk )
.head 7 -  ! Call Debug("Документ не найден !")
.head 7 -  Call Debug("Документ не найден !")
.head 3 +  Pushbutton: pbOk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: "ВАCК"
.head 4 -  Window Location and Size
.head 5 -  Left:   2.5"
.head 5 -  Top:    1.76"
.head 5 -  Width:  1.3"
.head 5 -  Width Editable? No
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? No
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Apply.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  ! If SalMessageBox("ВЕРНУТЬ  документ " || Str(nRef) || " на сумму " || Str(nSum) || " " || sLCV || "?" , 
  "Снятие оборотов, восстановление остатков", MB_YesNo | MB_IconHand )=6
.head 6 +  If SalMessageBox(CurrentLangTable.GetAtomTitle('frm_Pay_Bck.cTMsgBackDoc') || " " || Str(nRef)|| " " || 
  CurrentLangTable.GetAtomTitle('frm_Pay_Bck.cTMsgSumm') || " " || Str(nSum) || " " || sLCV || "?" , 
  CurrentLangTable.GetAtomTitle('frm_Pay_Bck.cTMsgTitle'), MB_YesNo | MB_IconHand) = 6
.head 7 -  Set sStornoReasonId = ''
.head 7 -  Set sStornoReason = ''
.head 7 +  If FunNSIGet('BP_REASON', '', sStornoReasonId,  sStornoReason)
.head 8 +  If sStornoReasonId
.head 9 -  Set nChkId = GetGlobalOptionEx('BACKVISA')
.head 9 +  If DocumentBack(nRef, 5, Val(sStornoReasonId), nChkId)
.head 10 -  Call SaveFInfoToLog('Выполнено изъятие операции, реф=' || Str(nRef) ||
     ' за дату ' || SalFmtFormatDateTime(FDAT1, 'dd/MM/yyyy'))
.head 10 -  Call DocViewContentsEx(hWndMDI, nRef)
.head 10 -  Set nRef = 0
.head 6 -  Call OBNOV()
.head 3 +  Pushbutton: pbExit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выход
.head 4 -  Window Location and Size
.head 5 -  Left:   4.443"
.head 5 -  Top:    1.76"
.head 5 -  Width:  1.3"
.head 5 -  Width Editable? No
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? No
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Esc
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
.head 3 -  Frame
.head 4 -  Resource Id: 6613
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.243"
.head 5 -  Top:    0.146"
.head 5 -  Width:  5.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.313"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Drop-Shadow
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 -  Frame
.head 4 -  Resource Id: 6614
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.243"
.head 5 -  Top:    1.563"
.head 5 -  Width:  5.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.906"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Drop-Shadow
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 -  Background Text: НЕПРОЦЕССИНГОВЫЕ !
.head 4 -  Resource Id: 6615
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.1"
.head 5 -  Top:    0.25"
.head 5 -  Width:  4.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Center
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Midnight Blue
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgNotProcessing
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
.head 3 +  Data Field: nRef
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Number
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.457"
.head 6 -  Top:    0.615"
.head 6 -  Width:  1.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.3"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: #0
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Midnight Blue
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Референс
.head 4 -  Resource Id: 6616
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.9"
.head 5 -  Top:    0.719"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.198"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Midnight Blue
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgRef
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
.head 3 -  Background Text: Дата выполнения
.head 4 -  Resource Id: 6617
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.9"
.head 5 -  Top:    1.052"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.2"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Midnight Blue
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgFDat
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
.head 3 +  Data Field: FDAT
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
.head 6 -  Left:   3.457"
.head 6 -  Top:    0.948"
.head 6 -  Width:  1.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.302"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Date
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Midnight Blue
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: ВНУТРЕННИЕ (sos=5)
.head 4 -  Resource Id: 6618
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.243"
.head 5 -  Top:    2.604"
.head 5 -  Width:  2.8"
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
.head 3 +  Data Field: bgIn
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
.head 3 -  Background Text: ЛЮБЫЕ (sos<5)
.head 4 -  Resource Id: 6619
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.043"
.head 5 -  Top:    2.583"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgAll
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
.head 2 +  Functions
.head 3 +  Function: OBNOV
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  ! Set nRef=0
.head 5 -  Call SalDisableWindow( pbOk )
.head 5 -  Call SalSetFocus( nRef )
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  Date/Time: dBankDay
.head 3 -  Date/Time: FDAT1
.head 3 -  String: sBankMfo
.head 3 -  Number: nSum
.head 3 -  Number: nSOS
.head 3 -  String: sLCV
.head 3 -  Number: nTmp
.head 3 -  Number: nResult
.head 3 -  Number: nDK
.head 3 -  String: sStornoReasonId
.head 3 -  String: sStornoReason
.head 3 -  : m_Doc
.head 4 -  Class: cDoc
.head 3 -  String: strKeyId
.head 3 -  Number: nStatus
.head 3 -  Number: nUserId
.head 3 -  String: strHexMark2Ret
.head 3 -  Long String: lsHexBuf
.head 3 -  Number: nErr
.head 3 -  String: sErrTxt
.head 3 -  Number: nStornoReasonId
.head 3 -  Long String: lSi
.head 3 -  !
.head 3 -  String: sNls
.head 3 -  String: sMfo
.head 3 -  String: sNlsp
.head 3 -  Number: nS
.head 3 -  String: sNd
.head 3 -  String: sText1
.head 3 -  String: sPond
.head 3 -  String: sNaex
.head 3 -  String: sNaimp
.head 3 -  Number: nEom
.head 3 -  String: sSab0
.head 3 -  String: sOper
.head 3 -  String: AMFO
.head 3 -  Number: nChkId
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 +  If not IsBankDayOpen()
.head 5 -  Call Debug("Банковский день не открыт")
.head 5 -  Call SalDestroyWindow( frm_Pay_Bck )
.head 4 -  Call SetWindowFont( hWndForm )
.head 4 -  Call SalSendMsgToChildren( hWndForm, UM_QueryLabelText, 0, 0 )
.head 4 -  Call SalSetWindowText( hWndForm, CurrentLangTable.GetAtomTitle('frm_Pay_Bck.cTWndTitle') )
.head 4 -  Set dBankDay=GetBankDate( )
.head 4 -  Set sBankMfo=GetBankMfo()
.head 4 -  Set nRef=0
.head 4 -  Call OBNOV()
.head 4 -  Call SalCenterWindow( frm_Pay_Bck )
.head 3 +  On SAM_Destroy
.head 4 +  If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
.head 5 -  Call XRoleUnset(hSql(),' F_Pay_Bck(hWndMDI) ')
