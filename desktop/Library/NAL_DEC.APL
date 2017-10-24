.head 0 +  Application Description: ! GL, NAL_DEC.APL - библиотека функций
! работы по налоговому учету
! ООО "Унити-Барс" (C) 1996-2001
! Разработчик: Сухова Т.А.
.head 1 -  Outline Version - 4.0.26
.head 1 +  Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000BC0000 002C000000020000 0003000000000000 0077020000F8FFFF
0040: FFE2FFFFFFFFFFFF FF000000007C0200 004D010000010000 0000000000010000
0060: 000F4170706C6963 6174696F6E497465 6D02000000075769 6E646F7773064F42
0080: 32324E55
.enddata
.data DT_MAKERUNDLG
0000: 02000000001D513A 5C4241525339385C 4C4942524152595C 4E414C5F4445432E
0020: 6578651D513A5C42 41525339385C4C49 42524152595C4E41 4C5F4445432E646C
0040: 6C1D513A5C424152 5339385C4C494252 4152595C4E414C5F 4445432E61706300
0060: 000101011D513A5C 4241525339385C4C 4942524152595C4E 414C5F4445432E72
0080: 756E1D513A5C4241 525339385C4C4942 524152595C4E414C 5F4445432E646C6C
00A0: 1D513A5C42415253 39385C4C49425241 52595C4E414C5F44 45432E6170630000
00C0: 010101175C424152 5339385C42494E5C 4E414C5F4445432E 617064175C424152
00E0: 5339385C42494E5C 4E414C5F4445432E 646C6C175C424152 5339385C42494E5C
0100: 4E414C5F4445432E 6170630001010101 1D513A5C42415253 39385C4C49425241
0120: 52595C4E414C5F44 45432E61706C1D51 3A5C424152533938 5C4C494252415259
0140: 5C4E414C5F444543 2E646C6C1D513A5C 4241525339385C4C 4942524152595C4E
0160: 414C5F4445432E61 70630000010101
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
.head 2 -  Dynalib: Docview.apd
.head 2 -  Dynalib: CustAcnt.apd
.head 2 -  Dynalib: Nsiapi.apd
.head 2 -  Dynalib: repbank.apd
.head 2 -  Dynalib: referenc.apd
.head 2 -  File Include: Gentbl.apl
.head 2 -  File Include: Genlabel.apl
.head 2 -  File Include: Genlist.apl
.head 2 -  File Include: Genemnu.apl
.head 2 -  File Include: DOCWIS6.APL
.head 2 -  File Include: Winbars2.apl
.head 2 -  File Include: Xsalcpt.apl
.head 2 -  File Include: XSALIMG.APL
.head 2 -  File Include: Vtmsgbox.apl
.head 2 -  File Include: Vtarray.apl
.head 2 -  File Include: VTCAL.APL
.head 2 -  File Include: vtdos.apl
.head 2 -  File Include: Vtfile.apl
.head 2 -  File Include: VTLBX.APL
.head 2 -  File Include: Vtmeter.apl
.head 2 -  File Include: vttblwin.apl
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
.head 3 -  Date/Time: dd-MM-yyyy
.head 2 +  External Functions
.head 3 +  ! Library name: seclogin.dll
.head 4 +  Function: SetParams
.head 5 -  Description: int SetParams(const char* szGatewayPath,
	const char* szGatewayConfig,
	const char* szCertPath,
	const char* szSecKeyPath,
	const char* szDate,
	const char* szDBAlias,
        int         nCORBADir);
.head 5 -  Export Ordinal: 0
.head 5 +  Returns 
.head 6 -  Number: LONG
.head 5 +  Parameters 
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  Number: INT
.head 4 +  Function: GetLogin
.head 5 -  Description: int GetLogin(	const char* szSecID,
	const char* szSecPassword,
	char* szOraLogin,
	char* szOraPassword);
.head 5 -  Export Ordinal: 0
.head 5 +  Returns 
.head 6 -  Number: LONG
.head 5 +  Parameters 
.head 6 -  Number: INT
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  Receive String: LPSTR
.head 6 -  Receive String: LPSTR
.head 4 +  Function: GetErrorMsg
.head 5 -  Description: const char* GetErrorMsg(int nResult);
.head 5 -  Export Ordinal: 0
.head 5 +  Returns 
.head 6 -  String: LPCSTR
.head 5 +  Parameters 
.head 6 -  Number: LONG
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
.head 3 -  Number: nFetchRes
.head 3 -  Window Handle: hTB0
.head 3 -  Window Handle: hTB_NO
.head 3 -  Window Handle: hTB_ND
.head 3 -  Window Handle: hTB_N
.head 3 -  Window Handle: hTB_I
.head 3 -  Window Handle: hFrm_4
.head 3 -  Window Handle: hTB6
.head 3 -  Window Handle: hTB31
.head 3 -  Window Handle: hTB3
.head 3 -  Window Handle: hFU
.head 3 -  Window Handle: hMOPER
.head 3 -  Window Handle: hOB22NU
.head 3 -  Window Handle: h21
.head 3 -  Sql Handle: hSqlABS
.head 3 -  Boolean: bFlagABS
.head 3 -  String: sABSDataBase
.head 3 -  String: sRnk
.head 3 -  ! ------------------------------------
.head 2 +  Internal Functions
.head 3 -  !
.head 3 +  Function: NAL_DEC	! __exported
.head 4 -  Description: Построение налогового учета
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Number: nParam
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Date/Time: DAT1p
.head 5 -  Date/Time: DAT2p
.head 4 +  Actions
.head 5 +  If nParam = 1 or nParam = 101		! Построение налогового учета КБ 
.head 6 +  If not IsWindow(hTB0)
.head 7 -  Set hTB0 = SalCreateWindow(TB0, hWndMDI, nParam)
.head 6 +  Else
.head 7 -  Call SalBringWindowToTop(hTB0)
.head 5 +  Else If nParam = 2  OR nParam = 102	! Состояние нал.декл ЦЕНТРА 
.head 6 +  If not IsWindow(hTB_N)
.head 7 -  Set hTB_N = SalCreateWindow(TB_N, hWndMDI, nParam)
.head 6 +  Else
.head 7 -  Call SalBringWindowToTop(hTB_N)
.head 5 +  Else If nParam = 3  or nParam = 33
     or nParam = 103 or nParam = 133	! Построение налогового учета обл НБУ SBU.dbf 
.head 6 +  If not IsWindow(hTB3)
.head 7 -  Set hTB3 = SalCreateWindow(TB3, hWndMDI, nParam)
.head 6 +  Else
.head 7 -  Call SalBringWindowToTop(hTB3)
.head 5 +  Else If nParam = 4  OR nParam = 104	! НОВЫЕ/104  СТАРЫЕ/4 - Открыть сводные счета НУ в гл НБУ 
.head 6 +  If not IsWindow(hFrm_4)
.head 7 -  Set hFrm_4 = SalCreateWindow(Frm_4, hWndMDI, nParam)
.head 6 +  Else
.head 7 -  Call SalBringWindowToTop(hFrm_4)
.head 5 +  Else If nParam = 5  OR nParam = 105	! Состояние нал.декл ОБЛАСТИ НБУ 
.head 6 +  If not IsWindow(hTB_N)
.head 7 -  Set hTB_N = SalCreateWindow(TB_N, hWndMDI, nParam)
.head 6 +  Else
.head 7 -  Call SalBringWindowToTop(hTB_N)
.head 5 +  Else If nParam = 6  OR nParam = 106	! Просмотр в гл НБУ связных таблиц 
.head 6 +  If not IsWindow(hTB6)
.head 7 -  Set hTB6 = SalCreateWindow(TB6, hWndMDI, nParam)
.head 6 +  Else
.head 7 -  Call SalBringWindowToTop(hTB6)
.head 5 +  Else If nParam = 7  or nParam = 107	! Построение налогового учета КБ без у.о.
.head 6 +  If not IsWindow(hTB0)
.head 7 -  Set hTB0 = SalCreateWindow(TB0, hWndMDI, nParam)
.head 6 +  Else
.head 7 -  Call SalBringWindowToTop(hTB0)
.head 5 +  Else If nParam = 12 OR nParam = 112	! Состояние нал.декл по исп (3-уровня) за любую дату
	                                ! 112 -   с выгрузкой в MOPER 
.head 6 +  If not IsWindow(hTB_I)
.head 7 -  Set hTB_I = SalCreateWindow(TB_I, hWndMDI, nParam)
.head 6 +  Else
.head 7 -  Call SalBringWindowToTop(hTB_I)
.head 5 +  Else If nParam = 19 or nParam = 119	! ТЕСТ 
.head 6 +  If not IsWindow(hTB_NO)
.head 7 -  Set hTB_NO = SalCreateWindow(TB_NO, hWndMDI, nParam)
.head 6 +  Else
.head 7 -  Call SalBringWindowToTop(hTB_NO)
.head 5 +  Else If nParam = 155			! НОВАЯ ДЕКЛ. - Открыть сводные ВЫБРАННЫЕ счета НУ 
.head 6 +  If not IsWindow(hTB_ND)
.head 7 -  Set hTB_ND = SalCreateWindow(TB_ND, hWndMDI, nParam)
.head 6 +  Else
.head 7 -  Call SalBringWindowToTop(hTB_ND)
.head 5 +  Else If nParam = 31 OR nParam = 131	! Открытие счетов подразделения 
.head 6 +  If not IsWindow(hTB31)
.head 7 -  Set hTB31 = SalCreateWindow(TB31, hWndMDI, nParam)
.head 6 +  Else
.head 7 -  Call SalBringWindowToTop(hTB31)
.head 5 +  Else If nParam = 32 OR nParam = 132	! Сверка с балансом ФУ (сальдо документов за интервал по датам валютирования)
.head 6 +  If not IsWindow(hFU)
.head 7 -  Set DAT2p = GetBankDate()
.head 7 -  Set DAT1p = SalDateQuarterBegin(DAT2p)
.head 7 -  Set hFU = SalCreateWindow(FU, hWndMDI, 32, '', DAT1p, DAT2p)
.head 6 +  Else
.head 7 -  Call SalBringWindowToTop(hFU)
.head 5 +  Else If nParam = 33			! Сверка с балансом ФУ (сальдо документов за интервал по датам документа)
.head 6 +  If not IsWindow(hFU)
.head 7 -  Set DAT2p = GetBankDate()
.head 7 -  Set DAT1p = SalDateQuarterBegin(DAT2p)
.head 7 -  Set hFU = SalCreateWindow(FU, hWndMDI, nParam, '', DAT1p, DAT2p)
.head 6 +  Else
.head 7 -  Call SalBringWindowToTop(hFU)
.head 5 +  Else If nParam = 21			! Прием NU<mfo>.<md> (MOPER по НУ филиалов)
.head 6 +  If not IsWindow(h21)
.head 7 -  Set h21 = SalCreateWindow(MOPER_NU, hWndMDI)
.head 6 +  Else
.head 7 -  Call SalBringWindowToTop(h21)
.head 5 +  Else If nParam = 100			! Просмотр протокола формирование-приема NU<mfo>.<md> (MOPER по НУ филиалов)
.head 6 +  If not IsWindow(hMOPER)
.head 7 -  Set hMOPER = SalCreateWindow(TB_MOPER, hWndMDI, nParam)
.head 6 +  Else
.head 7 -  Call SalBringWindowToTop(hMOPER)
.head 5 +  Else If nParam = 197			! КАТАЛОГИЗИРОВАННЫЕ ЗАПРОСЫ
.head 6 -  Call ShowQueryEditor(hWndMDI, 0)
.head 5 +  Else If nParam = 199			! ПРОГРАММА ПЕЧАТИ
.head 6 -  Call ShowOutForms(hWndMDI, 0)
.head 5 +  Else If nParam = 22			! НУ СберБанка (по системе)
.head 6 +  If not IsWindow(hOB22NU)
.head 7 -  Set hOB22NU = SalCreateWindow(OB22NU, hWndMDI)
.head 6 +  Else
.head 7 -  Call SalBringWindowToTop(hOB22NU)
.head 3 -  ! Закомментировано 03.03.2014
.head 3 +  ! Function: GateParams	! __exported
.head 4 -  Description: Установка параметров для GATE-а
.head 4 +  Returns 
.head 5 -  Boolean: 
.head 4 +  Parameters 
.head 5 -  String: dDataBase
.head 4 -  Static Variables 
.head 4 +  Local variables 
.head 5 -  String: szGatewayPath
.head 5 -  String: szGatewayConfigPath
.head 5 -  String: szGatewayOpenKey
.head 5 -  String: szGatewaySecretKeyDrv
.head 5 -  String: szCORBADir  ! служебная директория для CORBA
.head 5 -  Number: nCORBAPort ! номер порта сервера CORBA
.head 5 -  ! String: szSecUser
.head 5 -  ! String: szSecPassword
.head 5 -  ! String: szOraUser
.head 5 -  ! String: szOraPassword 
.head 5 -  String: szMsgBuf
.head 5 -  Number: nTaskID   	! ID задачи
.head 5 -  Number: nUserClass 	! тип пользователя
.head 4 +  Actions 
.head 5 -  ! Call Debug('логиниться через шлюз')
.head 5 -  Set nTaskID = SalGetProfileInt(INI_CommonParameters, 'TaskID', 1, GetIniFileName())
.head 5 -  ! Call SalMessageBox(  'TaskID - '||SalNumberToStrX(nTaskID,0), 'Параметры ... ', 4 )
.head 5 -  Call SalGetProfileString(INI_CommonParameters, 'GatewayPath', '!!!no!!!', szGatewayPath, GetIniFileName())
.head 5 -  ! Call Debug('GatewayPath='|| szGatewayPath)
.head 5 -  Call SalGetProfileString(INI_CommonParameters, 'GatewayConfigPath', '', szGatewayConfigPath, GetIniFileName())
.head 5 -  ! Call Debug('GatewayConfigPath='|| szGatewayConfigPath)
.head 5 -  Call SalGetProfileString(INI_CommonParameters, 'GatewayOpenKey', '', szGatewayOpenKey, GetIniFileName())
.head 5 -  ! Call Debug('GatewayOpenKey='|| szGatewayOpenKey)
.head 5 -  Call SalGetProfileString(INI_CommonParameters, 'GatewaySecretKeyDrv', '', szGatewaySecretKeyDrv, GetIniFileName())
.head 5 -  Call SalGetProfileString(INI_CommonParameters,'CORBADir', 'C:\\BARS', szCORBADir, GetIniFileName())
.head 5 -  Set nCORBAPort = SalGetProfileInt(INI_CommonParameters, 'CORBAPort', 8888, GetIniFileName())
.head 5 -  ! Call Debug('GetDbs()='|| GetDbs())
.head 5 -  Call SetParams( szGatewayPath,  szGatewayConfigPath,
	szGatewayOpenKey, szGatewaySecretKeyDrv,
	SalFmtFormatDateTime( SalDateCurrent(), 'yyyy/MM/dd hhhh:mm:ss' ) ,
	dDataBase, szCORBADir, nCORBAPort )
.head 5 -  Return TRUE
.head 3 +  ! Function: GateLogin	! __exported
.head 4 -  Description: Установка параметров для GATE-а
.head 4 +  Returns 
.head 5 -  Boolean: 
.head 4 +  Parameters 
.head 5 -  String: dUserName
.head 5 -  String: dPassword
.head 5 -  Receive String: szOraUser
.head 5 -  Receive String: szOraPassword
.head 4 -  Static Variables 
.head 4 +  Local variables 
.head 5 -  String: szSecUser
.head 5 -  String: szSecPassword
.head 5 -  ! String: szOraUser
.head 5 -  ! String: szOraPassword 
.head 5 -  Number: nTaskID 
.head 5 -  Number: nRes
.head 4 +  Actions 
.head 5 -  Set szOraUser = SalStrRepeatX( ' ', 64 )
.head 5 -  Set szOraPassword = SalStrRepeatX( ' ', 64 )
.head 5 -  Set szSecUser = dUserName
.head 5 -  Set szSecPassword = dPassword
.head 5 -  Set nTaskID = SalGetProfileInt(INI_CommonParameters, 'TaskID', 1, GetIniFileName())
.head 5 -  ! Call SalMessageBox( 'GateLogin   логин   - ' ||szSecUser||'  pass - '||szSecPassword, 'Параметры ... ', 4 )
.head 5 -  Set nRes = GetLogin( nTaskID,
	szSecUser, szSecPassword,
	szOraUser, szOraPassword )
.head 5 -  ! Call SalMessageBox( 'GateLogin   логин   - ' ||szOraUser||'  pass - '||szOraPassword, 'Параметры ... ', 4 )
.head 5 +  If nRes
.head 6 -  Call WaitCursorOff()
.head 6 -  Call SalMessageBox( 'Ошибка соединения через шлюз № '
|| SalNumberToStrX( nRes, 0 ) , 'Параметры ... ', 0 )
.head 6 -  Return FALSE
.head 5 -  Return TRUE
.head 3 -  !
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
.head 2 +  Default Classes
.head 3 -  MDI Window: cBaseMDI
.head 3 -  Form Window:
.head 3 -  Dialog Box:
.head 3 -  Table Window:
.head 3 -  Quest Window:
.head 3 -  Data Field:
.head 3 -  Spin Field:
.head 3 -  Multiline Field:
.head 3 -  Pushbutton: ctb_pbGetValue
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
.head 1 +  Table Window: TB_D
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Первичные документы
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
.head 4 -  Left:   0.24"
.head 4 -  Top:    1.125"
.head 4 -  Width:  14.014"
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
.head 4 -  Size: 0.688"
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
.head 6 -  Left:   0.386"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Tudasuda.bmp
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
.head 6 -  Left:   0.986"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Childs.bmp
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
.head 6 -  Left:   2.686"
.head 6 -  Top:    0.198"
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
.head 4 -  Line
.head 5 -  Resource Id: 50001
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? No
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
.head 6 -  Left:   3.114"
.head 6 -  Top:    0.198"
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
.head 6 -  Left:   3.543"
.head 6 -  Top:    0.198"
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
.head 6 -  Left:   3.971"
.head 6 -  Top:    0.198"
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
.head 7 -  Set strTip = 'Оригинал документа ...'
.head 6 +  On SAM_Click
.head 7 +  If TB_D.REC>0 !! Просмотр реквизитов документа СЭП
.head 8 -  Call DocViewContents(hWndMDI, TB_D.REC)
.head 7 +  Else !! Просмотр реквизитов внутреннего документа
.head 8 -  Call DocViewContentsEx(hWndMDI, TB_D.REF)
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 40
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.557"
.head 6 -  Top:    0.198"
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
.head 5 -  Resource Id: 50002
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? No
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
.head 6 -  Left:   5.129"
.head 6 -  Top:    0.198"
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
.head 5 -  Resource Id: 50003
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? No
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 +  Data Field: DAT11
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Editable? Yes
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   0.186"
.head 7 -  Top:    0.323"
.head 7 -  Width:  1.114"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.25"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? Yes
.head 6 -  Justify: Left
.head 6 -  Format: Date
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 +  Data Field: DAT22
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Editable? Yes
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   1.357"
.head 7 -  Top:    0.323"
.head 7 -  Width:  1.114"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.25"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? Yes
.head 6 -  Justify: Left
.head 6 -  Format: Date
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 +  Data Field: Text3
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Editable? Yes
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   5.686"
.head 7 -  Top:    0.229"
.head 7 -  Width:  7.8"
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
.head 4 -  Background Text: Дата документа
.head 5 -  Resource Id: 14493
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.271"
.head 6 -  Top:    0.115"
.head 6 -  Width:  2.2"
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
.head 4 -  Frame
.head 5 -  Resource Id: 14494
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.086"
.head 6 -  Top:    0.073"
.head 6 -  Width:  2.5"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.583"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Corners: Square
.head 5 -  Border Style: Raised-Shadow
.head 5 -  Border Thickness: 1
.head 5 -  Border Color: Default
.head 5 -  Background Color: Default
.head 2 +  Contents
.head 3 +  Column: SOS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: S
o
s
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 1
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.243"
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
.head 3 +  Column: REF
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Реф
НУ
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.729"
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
.head 3 +  Column: UID
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
исп.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.533"
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
док-та
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Left
.head 4 -  Width:  1.071"
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
.head 3 +  Column: DK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ДК
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.367"
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
.head 4 -  Title: МФО-А
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
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
.head 4 -  Message Actions
.head 3 +  Column: NLSA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Счет-А
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.257"
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
.head 3 +  Column: MFOB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: МФО-Б
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
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
.head 3 +  Column: NLSB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Счет-Б
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.286"
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
.head 4 -  Title: Сумма
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.557"
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
.head 3 +  Column: NAZN
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Назначение
платежа
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  5.457"
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
.head 4 -  Title: Назначение
платежа
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  6.8"
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
.head 3 -  Number: nAM
.head 3 -  String: s8
.head 3 -  Number: nPar
.head 3 -  Date/Time: DAT1p
.head 3 -  Date/Time: DAT2p
.head 2 +  Window Variables
.head 3 -  String: ss1
.head 3 -  String: ss2
.head 3 -  String: sTmp
.head 3 -  Boolean: bFL
.head 3 -  Number: nIsp
.head 3 -  Number: nCol
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  Call SetWindowFullSize( hWndForm )
.head 4 -  Set TB_D.strPrintFileName ='D' || Str(nPar)
.head 4 -  Set TB_D.Text3 = TB_D.s8 || ". Первичные документы."
.head 4 -  Set TB_D.DAT11 = TB_D.DAT1p
.head 4 -  Set TB_D.DAT22 = TB_D.DAT2p
.head 4 -  Set TB_D.strFilterTblName = 'OPER'
.head 4 +  Select Case TB_D.nPar
.head 5 +  Case 2  !! Документы по налоговому счету ЦЕНТРА
.head 6 +  If GetBankMfo()='300001'
.head 7 -  Set TB_D.strSqlPopulate = 
"SELECT ref,userid,vdat,dk,mfoa,nlsa,mfob,nlsb,s/100,substr(nazn,1,160),0,sos
 INTO :TB_D.REF, :TB_D.UID, :TB_D.DATD,:TB_D.DK,:TB_D.MFOA,:TB_D.NLSA,
      :TB_D.MFOB,:TB_D.NLSB,:TB_D.S, :TB_D.NAZN,:TB_D.REC,:TB_D.SOS
 FROM oper 
 WHERE datd>=:TB_D.DAT11 AND 
       datd<=:TB_D.DAT22 AND 
      ref in (SELECT ref FROM opldok WHERE 
(acc=:TB_D.nAM or acc in (select acc from accounts where accc=:TB_D.nAM)))"
.head 6 +  Else
.head 7 -  Set TB_D.strSqlPopulate = 
"SELECT ref,userid,vdat,dk,mfoa,nlsa,mfob,nlsb,s/100,substr(nazn,1,160),0,sos
 INTO :TB_D.REF, :TB_D.UID, :TB_D.DATD,:TB_D.DK,:TB_D.MFOA,:TB_D.NLSA,
      :TB_D.MFOB,:TB_D.NLSB,:TB_D.S, :TB_D.NAZN,:TB_D.REC,:TB_D.SOS
 FROM oper 
 WHERE ref in (SELECT ref FROM opldok WHERE fdat>=:TB_D.DAT11 AND fdat<=:TB_D.DAT22 AND 
(acc=:TB_D.nAM or acc in (select acc from accounts where accc=:TB_D.nAM)))"
.head 6 -  Break
.head 5 +  Case 22 !! Документы по налоговому счету СБЕРБАНКА (3 уровня)
.head 6 -  Set TB_D.strSqlPopulate = 
"SELECT ref,userid,vdat,dk,mfoa,nlsa,mfob,nlsb,s/100,substr(nazn,1,160),0,sos
 INTO :TB_D.REF, :TB_D.UID, :TB_D.DATD,:TB_D.DK,:TB_D.MFOA,:TB_D.NLSA,
      :TB_D.MFOB,:TB_D.NLSB,:TB_D.S, :TB_D.NAZN,:TB_D.REC,:TB_D.SOS
 FROM oper 
 WHERE ref in 
  (SELECT ref 
   FROM opldok 
   WHERE fdat>=:TB_D.DAT11 AND fdat<=:TB_D.DAT22 AND 
         (acc=:TB_D.nAM or 
          acc in (select acc 
                  from accounts 
                  where accc=:TB_D.nAM ) or 
          acc in (select a.acc 
                  from accounts a, accounts b
                  where a.accc=b.acc AND b.accc=:TB_D.nAM ) 
          )
   )"
.head 6 -  Break
.head 5 +  Case 5  !! Документы по налоговому счету Подразделения
.head 6 -  Set TB_D.strFilterTblName = 'NAL_2'
.head 6 -  Set TB_D.strSqlPopulate = "
    SELECT ref, datd, dk, mfoa, nlsa, mfob, nlsb, s/100, 
           substr(nazn,1,160), rec, sos
    INTO :TB_D.REF, :TB_D.DATD,:TB_D.DK,:TB_D.MFOA,:TB_D.NLSA,
         :TB_D.MFOB,:TB_D.NLSB,:TB_D.S, :TB_D.NAZN,:TB_D.REC,:TB_D.SOS
    FROM NAL_2
    WHERE ACC=" || Str(TB_D.nAM) || " and
          datd >= :TB_D.DAT11 and datd <= :TB_D.DAT22
    ORDER BY datd,s"
.head 6 -  Break
.head 5 +  Case 32 !! Сверка с финансовым учетом Подразделения(в центре нет)
.head 6 -  Set TB_D.nIsp = GetUserId()
.head 6 +  If SalStrLength( TB_D.s8 ) > 4     !! по ЛС
.head 7 -  Set TB_D.strSqlPopulate = "
 SELECT ref, datd, dk, mfoa, nlsa, mfob, nlsb,
        s/100, substr(nazn,1,160),0, sos 
 INTO :TB_D.REF, :TB_D.DATD,:TB_D.DK,:TB_D.MFOA,:TB_D.NLSA,
      :TB_D.MFOB,:TB_D.NLSB,:TB_D.S, :TB_D.NAZN,:TB_D.REC,:TB_D.SOS
 FROM  oper 
 WHERE userid=:TB_D.nIsp and  datd>=:TB_D.DAT11 and datd<=:TB_D.DAT22 and
      (mfoa=:TB_D.nAM and nlsa=:TB_D.s8 or 
       mfob=:TB_D.nAM and nlsb=:TB_D.s8 )      
 ORDER BY datd,s"
.head 6 +  Else If SalStrLength( TB_D.s8 ) =4 !! по БС 
.head 7 -  Set TB_D.strSqlPopulate = "
 SELECT ref, datd, dk, mfoa, nlsa, mfob, nlsb,
        s/100, substr(nazn,1,160),0, sos 
 INTO :TB_D.REF, :TB_D.DATD,:TB_D.DK,:TB_D.MFOA,:TB_D.NLSA,
      :TB_D.MFOB,:TB_D.NLSB,:TB_D.S, :TB_D.NAZN,:TB_D.REC,:TB_D.SOS
 FROM  oper 
 WHERE userid=:TB_D.nIsp and  datd>=:TB_D.DAT11 and datd<=:TB_D.DAT22 and
      (mfoa=:TB_D.nAM and substr(nlsa,1,4)=:TB_D.s8 or 
       mfob=:TB_D.nAM and substr(nlsb,1,4)=:TB_D.s8 )      
ORDER BY datd,s"
.head 6 +  Else If SalStrLength( TB_D.s8 ) =0 !! Все
.head 7 -  Set TB_D.strSqlPopulate = "
 SELECT ref, datd, dk, mfoa, nlsa, mfob, nlsb,
        s/100, substr(nazn,1,160),0, sos 
 INTO :TB_D.REF, :TB_D.DATD,:TB_D.DK,:TB_D.MFOA,:TB_D.NLSA,
      :TB_D.MFOB,:TB_D.NLSB,:TB_D.S, :TB_D.NAZN,:TB_D.REC,:TB_D.SOS
 FROM  oper 
 WHERE userid=:TB_D.nIsp and  datd>=:TB_D.DAT11 and datd<=:TB_D.DAT22 and
      (mfoa=:TB_D.nAM  or mfob=:TB_D.nAM )      
 ORDER BY datd,s"
.head 6 -  Break
.head 5 +  Default
.head 6 -  Break
.head 4 -  !
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 4 -  !
.head 3 +  On SAM_FetchRowDone
.head 4 -  Set TB_D.nCol=COLOR_Black
.head 4 +  If TB_D.SOS=1
.head 5 -  Set TB_D.nCol=COLOR_DarkGreen
.head 4 +  Else If TB_D.SOS<0
.head 5 -  Set TB_D.nCol=COLOR_Red
.head 4 -  Call SalTblSetCellTextColor(TB_D.REF, TB_D.nCol, FALSE)
.head 4 -  Call SalTblSetCellTextColor(TB_D.DATD,TB_D.nCol, FALSE)
.head 4 -  Call SalTblSetCellTextColor(TB_D.DK,  TB_D.nCol, FALSE)
.head 4 -  Call SalTblSetCellTextColor(TB_D.MFOA,TB_D.nCol, FALSE)
.head 4 -  Call SalTblSetCellTextColor(TB_D.NLSA,TB_D.nCol, FALSE)
.head 4 -  Call SalTblSetCellTextColor(TB_D.MFOB,TB_D.nCol, FALSE)
.head 4 -  Call SalTblSetCellTextColor(TB_D.NLSB,TB_D.nCol, FALSE)
.head 4 -  Call SalTblSetCellTextColor(TB_D.S,   TB_D.nCol, FALSE)
.head 4 -  Call SalTblSetCellTextColor(TB_D.NAZN,TB_D.nCol, FALSE)
.head 3 +  On UM_Populate
.head 4 +  If TB_D.nPar=2 or TB_D.nPar=22
.head 5 -  Call SalShowWindow( hWndForm.TB_D.UID )
.head 4 +  Else
.head 5 -  Call SalHideWindow( hWndForm.TB_D.UID )
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Call SalTblDefineSplitWindow(hWndForm, 0, FALSE)
.head 4 +  If NOT SetQueryFilter( TB_D.cF )
.head 5 -  Call SalDestroyWindow( hWndForm )
.head 4 -  ! Call Debug( TB_D.strSqlPopulate )
.head 4 -  Set TB_D.strDSql = cQ.GetFullSQLString(TB_D.cF)
.head 4 -  ! Call Debug( TB_D.strDSql  )
.head 4 -  !
.head 4 -  Call SalTblPopulate(hWndForm, hSql(), TB_D.strDSql , TBL_FillAll)
.head 4 -  Call SalTblSetContext(hWndForm, 0)
.head 4 -  Call SalPostMsg(hWndForm, SAM_TblDoDetails, 0, 0)
.head 4 -  Call SalWaitCursor(FALSE)
.head 1 +  Table Window: TB_N
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Состояние НАЛОГОВОЙ декларации
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
.head 4 -  Left:   0.22"
.head 4 -  Top:    1.108"
.head 4 -  Width:  13.533"
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
.head 6 -  Left:   0.086"
.head 6 -  Top:    0.063"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Tudasuda.bmp
.head 5 -  Picture Transparent Color: White
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Полная/Рабочая...'
.head 6 +  On SAM_Click
.head 7 -  Set bFL= not bFL
.head 7 -  Call SalSendMsg( pbRefresh, SAM_Click, 0, 0)
.head 4 +  Pushbutton: pbDel
.head 5 -  Class Child Ref Key: 34
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.514"
.head 6 -  Top:    0.063"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Childs.bmp
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Составляющие дочерние аналитические счета...'
.head 6 +  On SAM_Click
.head 7 +  If TB_N.ACC != NUMBER_Null
.head 8 -  Call ShowLNKAccounts(TB_N.ACC)
.head 4 +  Pushbutton: pbRefresh
.head 5 -  Class Child Ref Key: 35
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.943"
.head 6 -  Top:    0.063"
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
.head 6 -  Left:   2.814"
.head 6 -  Top:    0.063"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Accounts.bmp
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Первичные документы 3-го уровня...'
.head 6 +  On SAM_Click
.head 7 +  If TB_N.ACC != NUMBER_Null
.head 8 -  Call SalCreateWindow(TB_D, hWndMDI, TB_N.ACC, TB_N.N1||' '||TB_N.N3||' '||TB_N.NAM, 22, DAT1p,DAT2p)
.head 4 -  Line
.head 5 -  Resource Id: 23189
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  4.0"
.head 6 -  Begin Y:  0.021"
.head 6 -  End X:  4.0"
.head 6 -  End Y:  0.479"
.head 5 -  Visible? No
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
.head 6 -  Left:   1.529"
.head 6 -  Top:    0.063"
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
.head 6 -  Left:   1.957"
.head 6 -  Top:    0.063"
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
.head 6 -  Left:   2.386"
.head 6 -  Top:    0.063"
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
.head 7 -  Set strTip = 'Первичные документы 2-го уровня...'
.head 6 +  On SAM_Click
.head 7 +  If TB_N.ACC != NUMBER_Null
.head 8 -  Call SalCreateWindow(TB_D, hWndMDI, TB_N.ACC, TB_N.N1||' '||TB_N.N3||' '||TB_N.NAM, nParam0,
DAT1p,DAT2p)
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 40
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.243"
.head 6 -  Top:    0.063"
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
.head 5 -  Resource Id: 23190
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  1.443"
.head 6 -  Begin Y:  -0.031"
.head 6 -  End X:  1.443"
.head 6 -  End Y:  0.427"
.head 5 -  Visible? Yes
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
.head 6 -  Left:   8.833"
.head 6 -  Top:    0.095"
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
.head 5 -  Resource Id: 23191
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  3.329"
.head 6 -  Begin Y:  -0.021"
.head 6 -  End X:  3.329"
.head 6 -  End Y:  0.438"
.head 5 -  Visible? No
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 +  Data Field: DAZ
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Editable? Yes
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   3.8"
.head 7 -  Top:    0.107"
.head 7 -  Width:  2.2"
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
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 +  ! ctb_pbGetValue: pb_MOPER
.winattr class Pushbutton:
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbGetValue
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   6.067"
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
.head 5 -  Picture File Name: C:\bars98\RESOURCE\BMP\Doc_in.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 +              Message Actions 
.head 6 +              On SAM_Create
.head 7 -              Set strTip = 'Выгрузить в Moper.dbf от '|| sMfo ||' для ' || sMfoP
.head 6 +              On SAM_Click
.head 7 -  ! блок выгрузки
.head 7 -              Call F_MOPER()
.head 2 +  Contents
.head 3 +  Column: N1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
прил.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.586"
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
.head 3 +  Column: N2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: №
п/п
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Right
.head 4 -  Width:  0.557"
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
.head 3 +  Column: N3
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: №
стр.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.571"
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
.head 3 +  Column: NAM
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
.head 4 -  Width:  6.543"
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
.head 3 +  Column: ACC
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  6.8"
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
.head 4 -  Title: Текущий
остаток
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.457"
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
.head 3 +  Column: SPL
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Плановый
остаток
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.414"
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
.head 3 +  Column: NLS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Налоговый
счет (8 кл)
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.629"
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
.head 3 -  Number: nParam
.head 2 +  Window Variables
.head 3 -  String: ss1
.head 3 -  String: ss2
.head 3 -  String: ss3
.head 3 -  String: sRNK
.head 3 -  Number: nTmp
.head 3 -  Boolean: bFL
.head 3 -  Date/Time: DAT1p
.head 3 -  Date/Time: DAT2p
.head 3 -  : cQ2
.head 4 -  Class: cGenQuery
.head 3 -  String: NAL_DEC
.head 3 -  String: TITL
.head 3 -  Number: nParam100
.head 3 -  Number: nParam0
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 +  If nParam >100
.head 5 -  Set nParam100 = 100
.head 5 -  Set nParam0 = nParam - 100
.head 5 -  Set NAL_DEC = 'NAL_DEC3' 
.head 5 -  Set TITL= 'НОВОЙ'
.head 4 +  Else
.head 5 -  Set nParam100 = 0
.head 5 -  Set nParam0 = nParam
.head 5 -  Set NAL_DEC = 'NAL_DEC' 
.head 5 -  Set TITL= 'СТАРОЙ'
.head 4 -  Call SalSetWindowText( hWndForm, "Состояние "||TITL||" Налоговой декларации" )
.head 4 -  Set TB_N.strPrintFileName = NAL_DEC
.head 4 -  Set TB_N.strFilterTblName = NAL_DEC
.head 4 -  Set TB_N.DAZ=GetBankDate()
.head 4 -  Set DAT2p = GetBankDate()
.head 4 -  Set DAT1p = SalDateQuarterBegin(DAT2p)
.head 4 -  Call SalTblSetLockedColumns(hWndForm, 4)
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 +  If nParam0 = 2 ! для центра
.head 5 -  Set ss1 = "
    SELECT " || NAL_DEC || ".dd, " || NAL_DEC || ".pp, 
           " || NAL_DEC || ".rr, " || NAL_DEC || ".nms,
           a.nls,a.acc,a.ost/100
    INTO :TB_N.N1,:TB_N.N2,:TB_N.N3,:TB_N.NAM,:TB_N.NLS,
         :TB_N.ACC,:TB_N.S
    FROM  " || NAL_DEC || ", sal a
    WHERE " || NAL_DEC || ".nls = a.nls and a.fdat= :TB_N.DAZ 
    ORDER BY dd,ORD"
.head 5 -  Set ss2 = "
    SELECT " || NAL_DEC || ".dd, " || NAL_DEC || ".pp, 
           " || NAL_DEC || ".rr, " || NAL_DEC || ".nms,
           a.nls,a.acc,a.ost/100
    INTO :TB_N.N1,:TB_N.N2,:TB_N.N3,:TB_N.NAM,:TB_N.NLS,
         :TB_N.ACC,:TB_N.S
 FROM " || NAL_DEC || ", sal a
 WHERE " || NAL_DEC || ".nls=a.nls (+) and a.fdat= :TB_N.DAZ 
 ORDER BY dd,ORD"
.head 4 +  Else If nParam0 = 5  ! для области
.head 5 -  Set sRNK = SalStrRightX(Str(GetIdRnk()+100), 2)
.head 5 -  Call SalDisableWindow(pbDel)
.head 5 -  Set ss1 = "
    SELECT " || NAL_DEC || ".dd, " || NAL_DEC || ".pp, 
           " || NAL_DEC || ".rr, " || NAL_DEC || ".nms,
           a.nls,a.acc,a.ostc/100,a.ostb/100
    INTO :TB_N.N1,:TB_N.N2,:TB_N.N3,:TB_N.NAM,:TB_N.NLS,
         :TB_N.ACC,:TB_N.S,:TB_N.SPL
    FROM  " || NAL_DEC || ", accounts a, accounts a8, cust_acc c
    WHERE " || NAL_DEC || ".nls=a8.nls and a8.acc=a.accc and
          c.acc=a.acc and c.rnk=" || sRNK || "
    ORDER BY " || NAL_DEC || ".dd, " || NAL_DEC || ".ORD"
.head 5 -  Set ss2 = "
    SELECT " || NAL_DEC || ".ORD, " || NAL_DEC || ".dd, " || NAL_DEC || ".pp,
           " || NAL_DEC || ".rr, "  || NAL_DEC || ".nms,
           a.nls,a.acc,a.ostc/100,a.ostb/100
    INTO :TB_N.nTmp,:TB_N.N1,:TB_N.N2,:TB_N.N3,
         :TB_N.NAM,:TB_N.NLS,:TB_N.ACC,:TB_N.S,:TB_N.SPL
    FROM " || NAL_DEC || ", accounts a, accounts a8, cust_acc c
    WHERE " || NAL_DEC || ".nls=a8.nls and a8.acc=a.accc and
          c.acc=a.acc and c.rnk=" || sRNK 
.head 5 -  Set ss3 = " 
    SELECT ORD,dd,pp,rr,nms,to_char(NULL),
           To_number(NULL),To_number(NULL),
           To_number(NULL)
    FROM " || NAL_DEC || " WHERE nls is null    
    ORDER BY 2,1"
.head 4 -  Set bFL = FALSE
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalWaitCursor( FALSE )
.head 4 -  Call SetQueryFilter( TB_N.cF )
.head 4 -  Call SalSendClassMessage(SAM_CreateComplete, 0, 0)
.head 3 +  On SAM_FetchRowDone
.head 4 -  Call SalTblSetCellTextColor( TB_N.S,IifN(TB_N.S<0,COLOR_DarkRed,COLOR_DarkBlue), FALSE )
.head 4 -  Call SalTblSetCellTextColor( TB_N.SPL,IifN(TB_N.SPL<0,COLOR_DarkRed,COLOR_DarkBlue), FALSE )
.head 4 +  If N3='0'
.head 5 -  Set N3=STRING_Null
.head 3 +  On UM_Populate
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Call SalTblDefineSplitWindow(hWndForm, 0, FALSE)
.head 4 +  If nParam0 = 5  AND NOT bFL  !! особый режим обработки запроса с UNION
.head 5 -  Call cQ.Init(TB_N.ss2)
.head 5 -  Call cQ2.Init(TB_N.ss3)
.head 5 -  Set TB_N.strDSql = TB_N.cQ.GetFullSQLString(TB_N.cF) || " UNION ALL " ||
TB_N.cQ2.GetFullSQLString(TB_N.cF)
.head 4 +  Else
.head 5 -  Set TB_N.strSqlPopulate=IifS(bFL, ss1, ss2)
.head 5 +  If TB_N.strSqlPopulate != ''
.head 6 -  Call cQ.Init(TB_N.strSqlPopulate)
.head 5 -  Set TB_N.strDSql = TB_N.cQ.GetFullSQLString(TB_N.cF)
.head 4 -  Call SalTblPopulate(hWndForm, TB_N.cMain.hSql(), T(TB_N.strDSql), TBL_FillAll)
.head 4 -  Call SalTblSetContext(hWndForm, 0)
.head 4 -  Call SalPostMsg(hWndForm, SAM_TblDoDetails, 0, 0)
.head 4 -  Call SalWaitCursor(FALSE)
.head 1 +  Form Window: Frm_4
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
.head 4 -  Width:  5.543"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 1.802"
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
.head 2 -  Contents
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Number: nParam
.head 2 +  Window Variables
.head 3 -  String: NAL_DEC
.head 3 -  String: sSql
.head 3 -  String: AMF
.head 3 -  String: NLS
.head 3 -  String: NMS
.head 3 -  Number: n980
.head 3 -  Number: ISP
.head 3 -  Number: GRP
.head 3 -  Number: RNK
.head 3 -  Number: nTmp
.head 3 -  Number: ACC
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalHideWindow(hWndForm)
.head 4 -  Set NAL_DEC = "nal_dec" || IifS( nParam=104, "3" ,"")
.head 4 -  Call FunNSIEditControlled( NAL_DEC, hWndForm, SAM_User)
.head 3 +  On SAM_User
.head 4 -  ! Kонстанты
.head 4 -  ! Set AMF=Subs(GetBankMfo(),1,5)
.head 4 -  If SqlPrepareAndExecute( hSqlAux2(), "SELECT substr(val,1,5) INTO :AMF FROM params WHERE par='MFO' " ) 
and SqlFetchNext(hSqlAux2(), nFetchRes)
.head 4 -  ! Set RNK=Val(GetOurRnk())
.head 4 -  If SqlPrepareAndExecute( hSqlAux2(), "SELECT to_number(val) INTO :RNK FROM params WHERE par='OUR_RNK' " ) 
and SqlFetchNext(hSqlAux2(), nFetchRes)
.head 4 -  Set n980 = GetBaseVal()
.head 4 -  Set ISP  = GetUserId()
.head 4 -  Set GRP  = GetUserId()
.head 4 -  !
.head 4 -  Set sSql = 
"UPDATE " || NAL_DEC ||" SET nls=VKRZN(:AMF,substr(nls||'0000000000',1,12) ) WHERE length(nls)<=12 AND nls+0 > 0" 
.head 4 +  If SqlPrepareAndExecute( hSqlAux2(), sSql ) 
.head 5 -  Call SqlCommit(hSqlAux2() )
.head 4 -  !
.head 4 -  Set sSql = 
"SELECT  nls, DD||' '||RR||' '||substr(nms,1,38) INTO :NLS,:NMS FROM " || NAL_DEC || " WHERE nls+0 > 0" 
.head 4 +  If SqlPrepareAndExecute( hSqlAux2(), sSql )
.head 5 +  While SqlFetchNext(hSqlAux2(), nFetchRes)
.head 6 +  If not Op_Reg(99, 0, 0, GRP, nTmp, RNK, NLS, n980, NMS, 'ODB', ISP, ACC)
.head 7 -  Call SalMessageBeep(MB_IconAsterisk)
.head 7 -  Call SalMessageBox('Ошибка при открытии счета ' ||
     NLS, 'Внимание', MB_Ok | MB_IconAsterisk)
.head 5 -  Call SqlCommit(hSqlAux2())
.head 5 -  Call SalMessageBox(
 "Выполнено открытие счетов НУ согласно Вашему шаблону" ,
"В Н И М А Н И Е ! ", MB_Ok )
.head 1 +  Table Window: TB_I
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Состояние счетов налогового учета исполнителя
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
.head 4 -  Left:   1.925"
.head 4 -  Top:    1.604"
.head 4 -  Width:  13.883"
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
.head 3 -  Discardable? Class Default
.head 2 -  Description:
.head 2 -  Named Menus
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Class Default
.head 4 -  Location? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Size: 0.488"
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
.head 6 -  Left:   0.35"
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
.head 4 -  Line
.head 5 -  Resource Id: 15327
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? No
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
.head 6 -  Left:   0.817"
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
.head 6 -  Left:   1.283"
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
.head 4 +  Pushbutton: pbDetails
.head 5 -  Class Child Ref Key: 39
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.75"
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
.head 7 -  Set strTip = 'Составляющие дочерние аналитические счета...'
.head 6 +  On SAM_Click
.head 7 -  Call SalCreateWindow(TB_IF, hWndMDI, TB_I.ACC, DAZ, DAZ2,
 TB_I.N1||' '||TB_I.N2||' '||TB_I.N3||' '||TB_I.NLS||' '||TB_I.NAM )
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 40
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.217"
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
.head 5 -  Resource Id: 15328
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? No
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
.head 6 -  Left:   9.333"
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
.head 5 -  Resource Id: 15329
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? No
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 -  ! C
.head 4 +  Data Field: DAZ
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Editable? Yes
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   5.233"
.head 7 -  Top:    0.071"
.head 7 -  Width:  1.533"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.321"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? Yes
.head 6 -  Justify: Center
.head 6 -  Format: Date
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 -  Background Text: по
.head 5 -  Resource Id: 12421
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Window Location and Size
.head 6 -  Left:   6.767"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.4"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Justify: Center
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 4 -  Background Text: С
.head 5 -  Resource Id: 53770
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.85"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.333"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Justify: Right
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 4 -  ! по
.head 4 +  Data Field: DAZ2
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Editable? Yes
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   7.233"
.head 7 -  Top:    0.071"
.head 7 -  Width:  1.533"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.321"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? Yes
.head 6 -  Justify: Center
.head 6 -  Format: Date
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 +  Data Field: DAT_END_OLD
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
.head 7 -  Left:   3.233"
.head 7 -  Top:    0.071"
.head 7 -  Width:  1.533"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.321"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? Yes
.head 6 -  Justify: Center
.head 6 -  Format: Date
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbAccHistory
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cTBarButton
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.683"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.429"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Books.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'История счета...'
.head 6 +  On SAM_Click
.head 7 +  If SalTblAnyRows( hWndForm, ROW_Selected, 0 ) and TB_I.ACC !=NUMBER_Null
.head 8 -  Call Show_Sal_Day_P( TB_I.ACC, TB_I.NLS, TB_I.n980, TB_I.DAZ, TB_I.DAZ2 )
.head 4 -  !
.head 4 +  Pushbutton: pb_MOPER
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbGetValue
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   8.833"
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
.head 5 -  Picture File Name: \bars98\RESOURCE\BMP\Doc_in.bmp
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Выгрузить в Moper.dbf от '|| sMfo ||' для ' || sMfoP
.head 6 +  On SAM_Click
.head 7 -  ! блок выгрузки
.head 7 -  Set TB_I.DAZ2 = SalDateQuarterBegin( TB_I.DAZ2+1 )-1
.head 7 -  Set TB_I.DAZ  = SalDateQuarterBegin( TB_I.DAZ2 )
.head 7 -  !
.head 7 -  Call SalSendMsg( pbRefresh, SAM_Click, 0, 0 )
.head 7 -  Call F_MOPER()
.head 2 +  Contents
.head 3 +  Column: ISP
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
исп
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.586"
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
.head 3 +  Column: N1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
прил.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.586"
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
.head 3 +  Column: N2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: №
п/п
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Right
.head 4 -  Width:  0.557"
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
.head 3 +  Column: N3
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: №
стр.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Right
.head 4 -  Width:  0.571"
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
.head 3 +  Column: NAM
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
.head 4 -  Width:  2.95"
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
.head 3 +  Column: ACC
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  6.8"
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
.head 4 -  Title: Налоговый
счет (8 кл)
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.629"
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
.head 4 -  Title: Остаток
входящий
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.457"
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
.head 3 +  Column: DOS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Обороты
Дебет
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.457"
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
.head 3 +  Column: KOS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Обороты
Кредит
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.457"
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
.head 3 +  Column: S2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Остаток
исходящий
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.457"
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
.head 2 +  Functions
.head 3 +  Function: F_MOPER
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sOdir !!-- запомнить старый тек каталог
.head 5 -  String: sPath !! -- установить текущий новый
.head 5 -  Sql Handle: hSqlA
.head 5 -  String: sMoper
.head 5 -  String: sBank
.head 5 -  String: sNama
.head 5 -  String: sOkpo
.head 5 -  String: Moper
.head 5 -  String: Y
.head 5 -  Number: nRow
.head 5 -  Boolean: bFL
.head 5 -  Number: nDk
.head 5 -  String: sNd
.head 5 -  String: sNls
.head 5 -  String: sNlsK
.head 5 -  String: sNazn
.head 5 -  String: sPeriod
.head 5 -  Number: nS
.head 5 -  Date/Time: DAT_FORM
.head 5 -  Date/Time: DAT_BEG
.head 5 -  Date/Time: DAT_END
.head 5 -  ! Date/Time: DAT_END_OLD
.head 5 -  String: FN
.head 5 -  String: FN_NEW
.head 4 +  Actions
.head 5 -  Set sBank = StrWinToDosX (Subs(GetBankName(),1,38))
.head 5 -  Set sOkpo = GetGlobalOption('OKPO')
.head 5 -  Set sPeriod='Консолидированные обороты за период с '  || 
            Subs(SalFmtFormatDateTime( DAZ,  'DD/mm/YYYY'),1,10) ||' по '||
            Subs(SalFmtFormatDateTime( DAZ2, 'DD/mm/YYYY'),1,10)
.head 5 -  ! Проверка на повторное формирование
.head 5 -  Set DAT_END_OLD = DAZ - 1
.head 5 -  If SqlPrepareAndExecute( hSql(),
  "SELECT NVL(max(DAT_END),:DAT_END_OLD)  INTO :DAT_END_OLD FROM moper_nu WHERE mfo=:sMfo " ) 
and SqlFetchNext(  hSql(), nFetchRes )
.head 5 +  If DAT_END_OLD >= DAZ 
.head 6 +  If not 
SalMessageBox("Внимание ! Формирование уже выполнялось "||
' по '|| Subs(SalFmtFormatDateTime( DAT_END_OLD,  'DD/mm/YYYY'),1,10) , 
 "Выполнять формирование  П О В Т О Р Н О  ? ",
MB_IconQuestion | MB_YesNo) = IDYES
.head 7 -  Return FALSE
.head 5 -  ! Проверка на пропуск периода
.head 5 +  If SqlPrepareAndExecute( hSql(),
  "SELECT count(*) INTO :Kol_Period FROM fdat WHERE fdat> :DAT_END_OLD and fdat<:DAZ " ) 
and SqlFetchNext(  hSql(), nFetchRes )
.head 6 +  If Kol_Period >0
.head 7 -  Call SalMessageBox("Обнаружен пропуск в "||Str(Kol_Period)||" банк.дней", 
"В Н И М А Н И Е ! Формирование невозможно ", MB_IconStop)
.head 7 -  Return FALSE
.head 5 -  !
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 -  Call SalUseRegistry(FALSE, '')
.head 5 -  Call SalGetProfileString('Import','NU_PATH',GetPrnDir(),sPath,GetIniFileName())
.head 5 +  If Right(sPath,1) != '\\'
.head 6 -  Set sPath = sPath || '\\'
.head 5 -  Set sMoper = sPath||'MOPER.dbf' !! промежуточный файл
.head 5 -  Set FN_NEW = 'NU'|| sMfo ||'.'|| Sep98md(DAZ2) 
.head 5 -  Set Moper = sPath || FN_NEW  !! полное имя
.head 5 -  Set SqlDatabase = 'dBase_Files'
.head 5 -  Call SalFileGetCurrentDirectory(sOdir)
.head 5 -  Call SalFileSetCurrentDirectory(sPath)
.head 5 +  If SqlConnect(hSqlA)
.head 6 -  Call VisFileDelete( sMoper )
.head 6 -  Set bFL = TRUE
.head 6 -  Set DAT_FORM = GetBankDate()
.head 6 -  Set nMfo=Val(sMfo)
.head 6 +  If SqlPrepareAndExecute(hSqlA,
"CREATE TABLE MOPER (
 NM NUMBER(2),  DK NUMBER(1), MFO  NUMBER(6), ND  CHAR(10), VOB NUMBER(2), NLS CHAR(14),
 NLSK CHAR(14), SK  NUMBER(2), S NUMBER(16) , 
 DATD DATE, DA DATE, VDATE DATE,    
 PLAT CHAR(38), POLU CHAR(38),NAZ1 CHAR(160), VSPO CHAR(1), KOD  CHAR(14), KODB  CHAR(14), 
 KISP CHAR(1),  SIGN CHAR(1), NS NUMBER(1),   NP NUMBER(1), SOS NUMBER(1) )") 
and SqlPrepareAndExecute(hSqlA,
 "INSERT INTO MOPER( DATD, DA, VDATE, MFO) VALUES (:DAZ, :DAZ2, :DAT_FORM, :nMfo  )" )
.head 7 -  Set nRow = TBL_MinRow
.head 7 -  ! !!! В этом отличие от предыдущей версии
.head 7 -  ! Set sNlsK = Vkrz2( sMfoP, '81990')  
.head 7 -  Set sNlsK = STRING_Null
.head 7 -  Set Kol_PAY = 0 
.head 7 -  ! !!!!
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 8 -  Call SalTblFetchRow(hWndForm, nRow)
.head 8 -  Set sNd  = StrWinToDosX ( N1||'-'||N3 )
.head 8 -  ! !!! В этом отличие от предыдущей версии
.head 8 -  ! Set sNls = Vkrz2( sMfoP, NLS||sMfo )
.head 8 -  Set sNls =  NLS
.head 8 -  Set sNama= Subs(StrWinToDosX(NAM),1,38)
.head 8 -  ! !!!!
.head 8 +  If bFL and DOS >0 
.head 9 -  Set nS = DOS * 100
.head 9 -  Set sNazn = StrWinToDosX('Дебет. '||sPeriod )
.head 9 -  Set bFL = SqlPrepareAndExecute(hSqlA,
 "INSERT INTO MOPER( NM, DK, ND, VOB, NLS, NLSK, S, DA, VDATE, DATD, PLAT, POLU, KOD, KODB, NAZ1 ) 
  VALUES (1, 1, :sNd,6,:sNls,:sNlsK,:nS,:DAZ2,:DAZ2,:DAZ2,:sNama,:sBank,:sOkpo,:sOkpo,:sNazn )" )
.head 9 -  Set Kol_PAY = Kol_PAY + 1
.head 8 +  If bFL and KOS >0 
.head 9 -  !
.head 9 -  Set nS = KOS * 100
.head 9 -  Set sNazn = StrWinToDosX('Кредит.'||sPeriod  )
.head 9 -  Set bFL = SqlPrepareAndExecute(hSqlA,
 "INSERT INTO MOPER( NM, DK, ND, VOB, NLS, NLSK, S, DA, VDATE, DATD, PLAT, POLU, KOD, KODB, NAZ1 ) 
  VALUES (1, 0, :sNd,6,:sNls,:sNlsK,:nS,:DAZ2,:DAZ2,:DAZ2,:sNama,:sBank,:sOkpo,:sOkpo,:sNazn )" )
.head 9 -  Set Kol_PAY = Kol_PAY + 1
.head 7 +  If bFL
.head 8 -  Call SqlCommit(hSqlA)
.head 8 -  ! 2-x фазный commit 
.head 8 -  If SqlPrepareAndExecute( hSql(), "DELETE from moper_nu WHERE DAT_END>=:DAZ")  
and SqlPrepareAndExecute(hSql(), "INSERT INTO moper_nu (MFO,DAT_FORM,DAT_BEG,DAT_END,FN,PAY) 
                                   values (:sMfo, :DAT_FORM, :DAZ, :DAZ2, :FN_NEW, :Kol_PAY )" ) 
and SqlCommit( hSql() )
.head 8 +  Else
.head 9 -  Call Debug('DELETE from moper_nu')
.head 7 +  Else
.head 8 -  Call SqlRollback(hSqlA)
.head 8 -  Call Debug('bFL')
.head 6 +  Else
.head 7 -  Call Debug('CREATE TABLE MOPER')
.head 6 -  Call SqlDisconnect(hSqlA)
.head 6 +  If bFL
.head 7 +  If VisFileCopy ( sMoper , Moper) = 1
.head 8 -  Call MessageNoWait('Наполнение ' || Moper ||' успешно завершено !', 'Сообщение', 1, 0)
.head 7 +  Else
.head 8 -  Call MessageNoWait('Неуспешная попытка создания ' || Moper , 'Внимание', 0, 2)
.head 6 -  Call SalFileSetCurrentDirectory(sOdir)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  Else
.head 6 -  Call Debug('SqlConnect(hSqlA)')
.head 6 -  Return FALSE
.head 2 +  Window Parameters
.head 3 -  Number: nParam
.head 2 +  Window Variables
.head 3 -  String: NAL_ISP
.head 3 -  String: TITL
.head 3 -  String: sMfoP
.head 3 -  String: sMfo
.head 3 -  Number: nMfo 
.head 3 -  Number: Kol_Period
.head 3 -  Number: Kol_PAY
.head 3 -  Number: n980
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 +  If nParam > 100
.head 5 -  Set NAL_ISP = 'NAL_ISP3' 
.head 5 -  Set TITL = "НОВОГО"
.head 4 +  Else
.head 5 -  Set NAL_ISP = 'NAL_ISP'
.head 5 -  Set TITL = "СТАРОГО"
.head 4 -  Call SalSetWindowText( hWndForm, "Состояние счетов "|| TITL|| " налогового учета исполнителя" )
.head 4 -  Set TB_I.strPrintFileName = NAL_ISP
.head 4 -  Set sMfoP= GetGlobalOption('MFOP')
.head 4 -  Set sMfo=  GetBankMfo()
.head 4 -  !
.head 4 -  Set TB_I.DAZ2= GetBankDate()
.head 4 -  Set TB_I.n980= GetBaseVal()
.head 4 -  Set TB_I.DAZ = SalDateQuarterBegin( TB_I.DAZ2 )
.head 4 -  !
.head 4 -  Set TB_I.strFilterTblName = NAL_ISP
.head 4 -  Call SalTblSetLockedColumns(hWndForm, 5)
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Set TB_I.strSqlPopulate =
 "SELECT " || NAL_ISP || ".DD,  " || NAL_ISP || ".PP,  " || NAL_ISP || ".RR, 
         " || NAL_ISP || ".NMS, " || NAL_ISP || ".NLS, " || NAL_ISP || ".ACC, 
         " || NAL_ISP || ".ISP,
         bars.FOST( " || NAL_ISP || ".ACC ,:TB_I.DAZ2)/100,
         bars.FDOS( " || NAL_ISP || ".ACC ,:TB_I.DAZ,:TB_I.DAZ2)/100,
         bars.FKOS( " || NAL_ISP || ".ACC ,:TB_I.DAZ,:TB_I.DAZ2)/100
  INTO :TB_I.N1, :TB_I.N2, :TB_I.N3,:TB_I.NAM,:TB_I.NLS,:TB_I.ACC,:TB_I.ISP,
       :TB_I.S2, :TB_I.DOS,:TB_I.KOS 
  FROM " || NAL_ISP || " ORDER BY  isp, DD, ORD "
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On SAM_FetchRowDone
.head 4 -  Set TB_I.S = TB_I.S2 + TB_I.DOS - TB_I.KOS
.head 4 -  Call SalTblSetCellTextColor( TB_I.S, IifN(TB_I.S <0,COLOR_DarkRed,COLOR_DarkBlue), FALSE )
.head 4 -  Call SalTblSetCellTextColor( TB_I.S2,IifN(TB_I.S2<0,COLOR_DarkRed,COLOR_DarkBlue), FALSE )
.head 4 +  If TB_I.N3='0'
.head 5 -  Set TB_I.N3=STRING_Null
.head 1 +  Table Window: TB6
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Построение связи финансового и управленческого учета
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
.head 4 -  Left:   0.59"
.head 4 -  Top:    0.908"
.head 4 -  Width:  13.533"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 6.073"
.head 4 -  Height Editable? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Black
.head 3 -  Background Color: Default
.head 3 -  View: Table
.head 3 -  Allow Row Sizing? No
.head 3 -  Lines Per Row: Default
.head 2 -  Memory Settings
.head 3 -  Maximum Rows in Memory: 20000
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
.head 6 -  Left:   0.086"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
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
.head 6 -  Left:   0.514"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
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
.head 6 -  Left:   0.043"
.head 6 -  Top:    0.063"
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
.head 6 -  Left:   1.371"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
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
.head 5 -  Resource Id: 20237
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  3.1"
.head 6 -  Begin Y:  -0.021"
.head 6 -  End X:  3.1"
.head 6 -  End Y:  0.438"
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
.head 6 -  Left:   0.471"
.head 6 -  Top:    0.063"
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
.head 6 -  Left:   0.9"
.head 6 -  Top:    0.063"
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
.head 6 -  Left:   1.514"
.head 6 -  Top:    0.063"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Open.bmp
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
.head 6 -  Left:   1.943"
.head 6 -  Top:    0.063"
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
.head 5 -  Resource Id: 20238
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  2.457"
.head 6 -  Begin Y:  -0.052"
.head 6 -  End X:  2.457"
.head 6 -  End Y:  0.406"
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
.head 6 -  Left:   2.571"
.head 6 -  Top:    0.063"
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
.head 5 -  Resource Id: 20239
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  1.414"
.head 6 -  Begin Y:  -0.031"
.head 6 -  End X:  1.414"
.head 6 -  End Y:  0.427"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 2 +  Contents
.head 3 +  Column: RNK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Рег
 №
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.657"
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
.head 3 +  Column: NMK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
подразделения
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  3.214"
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
.head 4 -  Title: ЛС
финансового 
учета
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.514"
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
.head 3 +  Column: FLAG
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ЧО
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.371"
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
.head 3 +  Column: NMS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
 ЛС финансового 
учета
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  4.729"
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
.head 3 +  Column: DD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Документ
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
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
.head 3 +  Column: RR
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Строка
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.086"
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
.head 3 -  Number: nParam
.head 2 +  Window Variables
.head 3 -  String: NAL_3
.head 3 -  String: TITL
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 +  If nParam >100
.head 5 -  Set NAL_3 = 'NAL_33' 
.head 5 -  Set TITL = 'НОВОГО'
.head 4 +  Else
.head 5 -  Set NAL_3 = 'NAL_3' 
.head 5 -  Set TITL = 'СТАРОГО'
.head 4 -  Call SalSetWindowText( hWndForm, "Просмотр связи финансового и "||TITL||" налогового учета" )
.head 4 -  Call WaitCursorOn()
.head 4 -  Call PrepareWindow( hWndForm )
.head 4 -  Call SetWindowFullSize( hWndForm )
.head 4 -  Set TB6.strPrintFileName = NAL_3
.head 4 -  Set TB6.strFilterTblName = NAL_3
.head 4 -  Set TB6.strSqlPopulate ="
    SELECT rnk, nmk, nls_FU, nms_FU, flag, DD, RR 
    INTO :TB6.RNK,:TB6.NMK,:TB6.NLS,:TB6.NMS,:TB6.FLAG,:TB6.DD,:TB6.RR
    FROM "|| NAL_3  || " ORDER BY rnk,DD,RR "
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 1 +  Table Window: TB31
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: С Ч Е Т А   НУ подразделения
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
.head 4 -  Left:   0.038"
.head 4 -  Top:    0.083"
.head 4 -  Width:  13.214"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 6.073"
.head 4 -  Height Editable? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Black
.head 3 -  Background Color: Default
.head 3 -  View: Table
.head 3 -  Allow Row Sizing? No
.head 3 -  Lines Per Row: Default
.head 2 -  Memory Settings
.head 3 -  Maximum Rows in Memory: 20000
.head 3 -  Discardable? No
.head 2 -  Description:
.head 2 -  Named Menus
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.521"
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
.head 6 -  Left:   2.086"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Insert.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Открыть счет'
.head 6 +  On SAM_Click
.head 7 +  If TB31.NLS1 = STRING_Null
.head 8 -  Set TB31.NLS1 = KeyAccount(AMF, TB31.NLS||sRNK)
.head 8 -  Set nTmp=0
.head 8 -  If Op_Reg
   (99,0,0,nGRP,nTmp,Val(sRNK),TB31.NLS1,n980,
    TB31.DD||' '||TB31.RR||' '||Subs(TB31.NMS,1,38),
   'ODB',nISP, TB31.ACC1) 
and SqlPrepareAndExecute(hSql(),
   "UPDATE accounts SET accc=:TB31.ACC WHERE acc=:TB31.ACC1") 
and SqlCommit(hSql())
.head 8 +  Else
.head 9 -  Set TB31.NLS1=STRING_Null
.head 9 -  Call SalMessageBeep(MB_IconAsterisk)
.head 9 -  Call SalMessageBox('Ошибка при открытии счета ' ||
     TB31.NLS1, 'Внимание', MB_Ok | MB_IconAsterisk)
.head 4 +  Pushbutton: pbDel
.head 5 -  Class Child Ref Key: 34
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.814"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
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
.head 6 -  Left:   2.843"
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
.head 6 -  Left:   2.671"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
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
.head 5 -  Resource Id: 8136
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  5.857"
.head 6 -  Begin Y:  -0.01"
.head 6 -  End X:  5.857"
.head 6 -  End Y:  0.448"
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
.head 6 -  Left:   3.35"
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
.head 6 -  Left:   3.767"
.head 6 -  Top:    0.073"
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
.head 6 -  Left:   4.2"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Open.bmp
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
.head 6 -  Left:   4.633"
.head 6 -  Top:    0.073"
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
.head 5 -  Resource Id: 8137
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  5.186"
.head 6 -  Begin Y:  -0.01"
.head 6 -  End X:  5.186"
.head 6 -  End Y:  0.448"
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
.head 6 -  Left:   5.317"
.head 6 -  Top:    0.073"
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
.head 5 -  Resource Id: 8138
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  2.6"
.head 6 -  Begin Y:  0.073"
.head 6 -  End X:  2.6"
.head 6 -  End Y:  0.531"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 2 +  Contents
.head 3 +  Column: DD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Доп.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.514"
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
.head 3 +  Column: PP
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: №
п/п
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.5"
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
.head 3 +  Column: RR
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Стр.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.471"
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
.head 4 -  Width:  4.714"
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
.head 4 -  Title: ЛС
консолидированный
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.086"
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
.head 3 +  Column: NLS1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ЛС 
подразделения
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.157"
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
.head 3 +  Column: ACC
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
.head 4 -  Width:  4.883"
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
.head 3 +  Column: ACC1
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
.head 4 -  Width:  4.883"
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
.head 3 -  Number: nParam
.head 2 +  Window Variables
.head 3 -  Number: n980
.head 3 -  String: sRNK
.head 3 -  String: AMF
.head 3 -  String: sTmp
.head 3 -  String: sTmp1
.head 3 -  String: NAL_DEC
.head 3 -  String: TITL
.head 3 -  Number: nI
.head 3 -  Number: nACC
.head 3 -  Number: nTmp
.head 3 -  Number: nISP
.head 3 -  Number: nGRP
.head 3 -  !
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 +  If nParam > 100
.head 5 -  Set NAL_DEC = 'NAL_DEC3' 
.head 5 -  Set TITL = "НОВОГО"
.head 4 +  Else
.head 5 -  Set NAL_DEC = 'NAL_DEC' 
.head 5 -  Set TITL = "СТАРОГО"
.head 4 -  Call SalSetWindowText( hWndForm, "С Ч Е Т А  "|| TITL|| " нал.учета подразделения" )
.head 4 -  Call WaitCursorOn()
.head 4 -  Call PrepareWindow( hWndForm )
.head 4 -  Call SetWindowFullSize( hWndForm )
.head 4 -  Call SalTblSetLockedColumns(hWndForm, 5)
.head 4 -  Set n980 = GetBaseVal()
.head 4 -  Set AMF  = GetBankMfo()
.head 4 -  Set sRNK = SalStrRightX(Str(GetIdRnk()+100), 2) || ' '
.head 4 -  Set nISP = GetUserId()
.head 4 -  Set nGRP = GetUserId()
.head 4 -  Set TB31.strPrintFileName = 'SBU'
.head 4 -  !
.head 4 -  Set TB31.strSqlPopulate = "
    SELECT n.dd, n.pp, n.rr, n.nms, n.nls, a.acc
    INTO :TB31.DD,:TB31.PP,:TB31.RR,:TB31.NMS,:TB31.NLS,:TB31.ACC
    FROM " || NAL_DEC || " n, accounts a  WHERE a.nls=n.nls  ORDER BY 1,2,3"
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On SAM_FetchRowDone
.head 4 +  If SqlPrepareAndExecute(hSql(), "
   SELECT a.nls,a.acc INTO :NLS1,:ACC1
   FROM accounts a, cust_acc u
   WHERE a.accc=:ACC and a.acc=u.acc AND u.rnk=" || sRNK )   
.head 5 -  Call SqlFetchNext(hSql(), nFetchRes) 
.head 1 +  Table Window: TB0
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Построение связи финансового и управленческого учета
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
.head 4 -  Left:   0.63"
.head 4 -  Top:    0.958"
.head 4 -  Width:  13.329"
.head 4 -  Width Editable? Class Default
.head 4 -  Height: 6.073"
.head 4 -  Height Editable? Class Default
.head 3 -  Font Name: Class Default
.head 3 -  Font Size: 8
.head 3 -  Font Enhancement: Class Default
.head 3 -  Text Color: Royal Blue
.head 3 -  Background Color: Class Default
.head 3 -  View: Class Default
.head 3 -  Allow Row Sizing? Class Default
.head 3 -  Lines Per Row: Class Default
.head 2 -  Memory Settings
.head 3 -  Maximum Rows in Memory: 20000
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
.head 5 -  Resource Id: 20728
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? No
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
.head 6 -  Left:   3.883"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Childs.bmp
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Установить сумму остатков по ВСЕМ счетам'
.head 6 +  On SAM_Click
.head 7 +  If nPar = 1
.head 8 +  If SalStrTrimX(SalStrUpperX(GetDBMS())) = 'ORACLE'
.head 9 -  Call SalShowWindow(DAT_)
.head 9 +  If SalMessageBox("Установить сумму остатков на счетах НУ ?",
  "Стартовая дата для взятия остатков " || Subs(SalFmtFormatDateTime(DAT_, 'DD/mm/YYYY'),1,10),  
  MB_IconQuestion | MB_YesNo) = IDYES
.head 10 -  Call SalWaitCursor(TRUE)
.head 10 +  If NOT SqlPLSQLCommand(hSql(), "NU_START(DAT_)")
.head 11 -  Call SqlRollbackEx(hSql(), 'NAL_DEC. Неуспешная попытка установки остатков')
.head 11 -  Call MessageNoWait('Неуспешная попытка установки остатков' , 'Внимание', 0, 2)
.head 10 +  Else
.head 11 -  Call SqlCommitEx(hSql(), 'NAL_DEC. Установлены остатки на счетах НУ с ' || 
Subs(SalFmtFormatDateTime(DAT_, 'DD/mm/YYYY'),1,10))
.head 11 -  Call MessageNoWait('Установлены остатки на счетах НУ с ' || 
Subs(SalFmtFormatDateTime(DAT_, 'DD/mm/YYYY'),1,10), 'Сообщение', 1, 0)
.head 10 -  Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 40
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.917"
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
.head 5 -  Resource Id: 20729
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? No
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
.head 6 -  Left:   6.85"
.head 6 -  Top:    0.063"
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
.head 4 +  Pushbutton: pbOpen
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbExecute
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   6.2"
.head 6 -  Top:    0.063"
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
.head 7 -  Set strTip = 'Установить сумму остатков по ВЫБРАННЫМ счетам'
.head 6 +  On SAM_Click
.head 7 +  If nPar = 1
.head 8 +  If SalStrTrimX(SalStrUpperX(GetDBMS())) = 'ORACLE'
.head 9 -  Call SalShowWindow(DAT_)
.head 9 +  If SalMessageBox("Установить сумму остатков на счетах НУ ?",
  "Стартовая дата для взятия остатков " || Subs(SalFmtFormatDateTime(DAT_, 'DD/mm/YYYY'), 1, 10), 
  MB_IconQuestion | MB_YesNo) = IDYES
.head 10 -  Set bFL  = TRUE
.head 10 -  Set nRow = TBL_MinRow
.head 10 +  While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
.head 11 -  Call SalTblSetContext(hWndForm, nRow)
.head 11 +  If NOT SqlPLSQLCommand(hSql(), "NU_START1(DAT_, sNLS8)")
.head 12 -  Call MessageNoWait('Неуспешная попытка установки остатков' , 'Внимание', 0, 2)
.head 12 -  Set bFL = FALSE
.head 12 -  Break
.head 10 +  If NOT bFL
.head 11 -  Call SqlRollback(hSql())
.head 10 +  Else
.head 11 -  Call MessageNoWait('Установлены остатки на отмеченных счетах НУ с ' || 
Subs(SalFmtFormatDateTime(DAT_, 'DD/mm/YYYY'),1,10), 'Сообщение', 1, 0)
.head 11 -  Call SqlCommitEx(hSql(), 
'NAL_DEC. Установлены остатки на отмеченных счетах НУ с ' || 
Subs(SalFmtFormatDateTime(DAT_, 'DD/mm/YYYY'),1,10))
.head 10 -  Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
.head 4 -  Line
.head 5 -  Resource Id: 20730
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
.head 4 +  Data Field: DAT_
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Editable? Yes
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   4.333"
.head 7 -  Top:    0.095"
.head 7 -  Width:  1.867"
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
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 2 +  Contents
.head 3 +  Column: sNLS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ЛС
финансового
учета
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.429"
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
.head 5 +  On SAM_Validate
.head 6 +  If SalTblQueryRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_New)
.head 7 -  Call SqlPrepareAndExecute(hSql(), 
"SELECT acc, nms INTO :ACC6, :sNMS
 FROM accounts WHERE kv=:n980_ AND nls=:sNLS")
.head 7 +  If NOT SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set ACC6 = NUMBER_Null
.head 8 -  Set sNMS = ''
.head 8 -  Call SalTblSetCellTextColor(sNLS, COLOR_DarkRed, FALSE)
.head 7 +  Else
.head 8 -  Call SalTblSetCellTextColor(sNLS, COLOR_DarkBlue, FALSE)
.head 6 -  Return VALIDATE_Ok
.head 5 +  On SAM_AnyEdit
.head 6 +  If NOT SalTblQueryRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_New)
.head 7 -  Set sNLS = sTmpNls
.head 7 -  Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
.head 5 +  On SAM_SetFocus
.head 6 -  Set sTmpNls = sNLS
.head 3 +  Column: sNMS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование ЛС
финансового учета
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  5.0"
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
.head 3 +  Column: sNLS8
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ЛС 
налогового
учета
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.643"
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
.head 5 +  On SAM_Validate
.head 6 -  Call SalSendMsg(sNLS8, SAM_User, 0, 0)
.head 6 -  Call sNMS8.SetSelectById(sNLS8)
.head 6 -  Return VALIDATE_Ok
.head 5 +  On SAM_User
.head 6 -  Call SqlPrepareAndExecute(hSql(),
"SELECT dd, pp, rr INTO :sDD, :sPP, :sRR  
 FROM " || NAL_DEC || " WHERE nls=:sNLS8")
.head 6 +  If NOT SqlFetchNext(hSql(), nFetchRes)
.head 7 -  Call SalMessageBox('Счет ' || sNLS8 || ' не является счетом Налогового Учета', 'Внимание!', MB_IconExclamation | MB_Ok)
.head 7 -  Set sNLS8 = ''
.head 7 -  Set ACC8  = NUMBER_Null
.head 7 -  Set sDD = ''
.head 7 -  Set sPP = ''
.head 7 -  Set sRR = ''
.head 6 +  Else
.head 7 -  Call SalTblSetCellTextColor(sNLS8, COLOR_DarkBlue, FALSE)
.head 7 -  Call SalTblSetCellTextColor(sNMS8, COLOR_DarkBlue, FALSE)
.head 7 -  Call SqlPrepareAndExecute(hSql(), 
"SELECT acc INTO :ACC8 FROM accounts 
 WHERE nls=:sNLS8 AND kv=:n980_")
.head 7 +  If NOT SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set ACC8 = NUMBER_Null
.head 8 -  Call SalTblSetCellTextColor(sNLS8, COLOR_Red, FALSE)
.head 8 -  Call SalTblSetCellTextColor(sNMS8, COLOR_Red, FALSE)
.head 7 +  Else
.head 8 -  Call SalTblSetCellTextColor(sNLS8, COLOR_DarkBlue, FALSE)
.head 8 -  Call SalTblSetCellTextColor(sNMS8, COLOR_DarkBlue, FALSE)
.head 3 +  Column: sNMS8
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenColComboBox_StrId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ЛС и Наименование ЛС
налогового  учета
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  5.0"
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
.head 6 -  Call sNMS8.Init(hWndItem)
.head 6 -  Call sNMS8.Populate(hSql(), "NLS", 
"SUBSTR(substr(nls||'         ',1,15)||DD||' '||RR||' '||NMS,1,100)", 
NAL_DEC, " WHERE NLS>0 ORDER BY DD,PP,RR")
.head 5 +  On SAM_AnyEdit
.head 6 -  Set sNLS8 = sNMS8.GetKey(SalListQuerySelection(hWndItem))
.head 6 -  Call SalSendMsg(sNLS8, SAM_User, 0, 0)
.head 3 +  Column: sDD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Доп.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.5"
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
.head 3 +  Column: sPP
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: №
п/п
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.629"
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
.head 3 +  Column: sRR
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Стр.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.486"
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
.head 3 +  Column: ACC6
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
.head 3 +  Column: ACC8
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
.head 3 +  Column: DAZS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? Yes
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
.head 4 -  List Values
.head 4 -  Message Actions
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Number: nParam
.head 2 +  Window Variables
.head 3 -  Number: nPar100
.head 3 -  Number: nPar
.head 3 -  !
.head 3 -  String: NAL_DEC
.head 3 -  Number: n980_
.head 3 -  String: AMF
.head 3 -  Number: RNK
.head 3 -  Number: ISP
.head 3 -  Number: nGrp
.head 3 -  !
.head 3 -  Boolean: bFL
.head 3 -  Number: nRow
.head 3 -  Number: nTmp
.head 3 -  String: sTmpNls
.head 3 -  String: NMS
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 +  If nParam > 100
.head 5 -  Set nPar100 = 100
.head 5 -  Set nPar = nParam -100
.head 5 -  Set NAL_DEC = 'NAL_DEC3'
.head 4 +  Else
.head 5 -  Set nPar100 = 0
.head 5 -  Set nPar = nParam 
.head 5 -  Set NAL_DEC = 'NAL_DEC'
.head 4 +  If nPar != 1
.head 5 -  Call SalDisableWindow(pbDetails)
.head 5 -  Call SalDisableWindow(pbOpen)
.head 4 +  If nPar = 7
.head 5 -  Call SalHideWindow(DAT_)
.head 5 -  Call SalHideWindow(pbOpen)
.head 4 -  Set DAT_  = GetBankDate()
.head 4 -  Set n980_ = GetBaseVal()
.head 4 -  Set AMF = SalStrLeftX(GetBankMfo(), 5)
.head 4 -  Set ISP = GetUserId()
.head 4 +  If SqlPrepareAndExecute(hSql(), 
"SELECT val+0 INTO :RNK FROM params WHERE par='OUR_RNK'")
AND NOT SqlFetchNext(hSql(), nFetchRes)
.head 5 -  Set RNK = 1
.head 4 +  If SqlPrepareAndExecute(hSql(), 
"SELECT nvl(to_number(rr),0) INTO :nGrp FROM nal_dec3 WHERE pp='GRP'") 
AND (NOT SqlFetchNext(hSql(), nFetchRes) OR nGrp = 0)
.head 5 -  Call SalMessageBox('Не указана группа доступа для открытия счетов!', 'Внимание!', MB_IconExclamation | MB_Ok)
.head 4 +  If SqlPrepareAndExecute(hSql(), 
"UPDATE nal_dec8 SET nls8=VKRZN(:AMF, nls8) WHERE nls8 is not null") 
AND SqlPrepareAndExecute(hSql(),
"UPDATE " || NAL_DEC || " SET nls=VKRZN(:AMF, nls) WHERE nls is not null")
.head 5 -  Call SqlCommit(hSql())
.head 4 -  Call SalTblSetLockedColumns(hWndForm, 2)
.head 4 -  !
.head 4 -  Set hWndForm.TB0.strPrintFileName = 'NAL_DEC8'
.head 4 -  Set hWndForm.TB0.strFilterTblName = 'NAL_DEC8'
.head 4 -  Set hWndForm.TB0.strSqlPopulate = 
"SELECT a.acc, NAL_DEC8.nls, a.nms, n.nls,
        substr( substr(n.nls||'         ',1,15) || n.NMS,1,100),  
        n.DD, n.PP, n.RR, b.acc, a.dazs 
 INTO :hWndForm.TB0.ACC6, :hWndForm.TB0.sNLS, :hWndForm.TB0.sNMS, :hWndForm.TB0.sNLS8, :hWndForm.TB0.sNMS8, 
      :hWndForm.TB0.sDD, :hWndForm.TB0.sPP, :hWndForm.TB0.sRR, :hWndForm.TB0.ACC8, :hWndForm.TB0.DAZS 
 FROM NAL_DEC8, ACCOUNTS a, " || NAL_DEC || " n, accounts b 
 WHERE NAL_DEC8.nls=a.nls(+) AND a.kv(+)=" || Str(TB0.n980_) || "
   AND n.nls=NAL_DEC8.nls8 AND n.nls=b.nls(+) AND b.kv(+)=" || Str(TB0.n980_) || "
 ORDER BY NAL_DEC8.nls, n.DD, n.ord "
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On UM_Populate
.head 4 -  Call SalSendClassMessage(UM_Populate, 0, 0)
.head 4 -  Call VisTblAutoSizeColumn(hWndForm, sNLS)
.head 4 -  Call VisTblAutoSizeColumn(hWndForm, sNLS8)
.head 3 +  On SAM_FetchRowDone
.head 4 +  If ACC6 = NUMBER_Null
.head 5 -  Call SalTblSetCellTextColor(sNLS, COLOR_DarkRed, FALSE)
.head 4 +  If NOT SalIsNull(DAZS)
.head 5 -  Call SetTblRowColor(hWndForm, COLOR_Periwinkle)
.head 3 +  On UM_Update
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set bFL  = TRUE
.head 4 -  Set nRow = TBL_MinRow
.head 4 +  While SalTblFindNextRow(hWndForm, nRow, ROW_New | ROW_MarkDeleted | ROW_Edited, 0)
.head 5 -  Call SalTblSetContext(hWndForm, nRow)
.head 5 +  If SalTblQueryRowFlags(hWndForm, nRow, ROW_New)
.head 6 +  If ACC6
.head 7 +  If NOT SqlPrepareAndExecute(hSql(), 
"INSERT INTO nal_dec8(nls, nls8) VALUES(:hWndForm.TB0.sNLS, :hWndForm.TB0.sNLS8)")
.head 8 -  Set bFL = FALSE
.head 8 -  Break
.head 7 -  ! Открытие счета, если не открыт
.head 7 +  If NOT ACC8
.head 8 -  Call SqlPrepareAndExecute(hSqlAux2(),
"SELECT m.DD||' '||m.RR||' '||substr(m.nms,1,30)
 INTO :NMS
 FROM " || NAL_DEC || " m
 WHERE m.nls=:hWndForm.TB0.sNLS8
 ORDER BY m.nls")
.head 8 +  If NOT SqlFetchNext(hSqlAux2(), nFetchRes)
.head 9 -  Set bFL = FALSE
.head 9 -  Break
.head 8 +  If NOT Op_Reg(99,0,0,nGrp,nTmp,RNK,sNLS8,n980_,NMS,'ODB',ISP,ACC8)
.head 9 -  Set bFL = FALSE
.head 9 -  Break
.head 7 -  ! Пролинковать
.head 7 +  If NOT SqlPrepareAndExecute(hSql(), "UPDATE accounts SET accc=:hWndForm.TB0.ACC8 WHERE acc=:hWndForm.TB0.ACC6") 
.head 8 -  Set bFL = FALSE
.head 8 -  Break
.head 5 +  Else If SalTblQueryRowFlags(hWndForm, nRow, ROW_MarkDeleted)
.head 6 +  If NOT SqlPrepareAndExecute(hSql(), "UPDATE accounts SET accc=null WHERE acc=:hWndForm.TB0.ACC6" )
.head 7 -  Set bFL = FALSE
.head 7 -  Break
.head 6 +  If NOT SqlPrepareAndExecute(hSql(), "DELETE FROM nal_dec8 WHERE nls=:hWndForm.TB0.sNLS")
.head 7 -  Set bFL = FALSE
.head 7 -  Break
.head 5 +  Else If SalTblQueryRowFlags(hWndForm, nRow, ROW_Edited)
.head 6 +  If NOT SqlPrepareAndExecute(hSql(), "UPDATE nal_dec8 SET nls8=:hWndForm.TB0.sNLS8 WHERE nls=:hWndForm.TB0.sNLS")
.head 7 -  Set bFL = FALSE
.head 7 -  Break
.head 6 -  ! Открытие счета, если не открыт
.head 6 +  If NOT ACC8
.head 7 -  Call SqlPrepareAndExecute(hSqlAux2(),
"SELECT m.DD||' '||m.RR||' '||substr(m.nms,1,30)
 INTO :NMS
 FROM " || NAL_DEC || " m
 WHERE m.nls=:hWndForm.TB0.sNLS8
 ORDER BY m.nls")
.head 7 +  If NOT SqlFetchNext(hSqlAux2(), nFetchRes)
.head 8 -  Set bFL = FALSE
.head 8 -  Break
.head 7 +  If not Op_Reg(99,0,0,nGrp,nTmp,RNK,sNLS8,n980_,NMS,'ODB',ISP,ACC8)
.head 8 -  Set bFL = FALSE
.head 8 -  Break
.head 6 -  ! Пролинковать
.head 6 +  If NOT SqlPrepareAndExecute(hSql(), "UPDATE accounts SET accc=:hWndForm.TB0.ACC8 WHERE acc=:hWndForm.TB0.ACC6") 
.head 7 -  Set bFL = FALSE
.head 7 -  Break
.head 4 +  If NOT bFL
.head 5 -  Call SqlRollbackEx(hSql(), 'NAL_DEC. Неуспешная попытка при установке связи Фин-Упр учета')
.head 4 +  Else
.head 5 -  Call SqlCommitEx(hSql(), 'NAL_DEC. Сохранены настройки связи Фин-Упр учета')
.head 4 -  Call SalPostMsg(hWndForm, UM_Populate, 0, 0)
.head 4 -  Call SalWaitCursor(FALSE)
.head 1 +  Table Window: FU
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Сверка с  БАЛАНСОМ  финансового учета
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
.head 4 -  Left:   1.19"
.head 4 -  Top:    0.842"
.head 4 -  Width:  10.543"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.781"
.head 4 -  Height Editable? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Bold
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
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
.head 4 -  Size: 0.833"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Contents
.head 4 -  ! невидимые
.head 4 +  Pushbutton: pbIns
.head 5 -  Class Child Ref Key: 33
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.486"
.head 6 -  Top:    0.24"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
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
.head 6 -  Left:   0.514"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
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
.head 4 +  Pushbutton: pbUpdate
.head 5 -  Class Child Ref Key: 36
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.371"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
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
.head 4 +  Pushbutton: pbFilter
.head 5 -  Class Child Ref Key: 44
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.471"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? No
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
.head 4 -  !
.head 4 +  Pushbutton: pbRefresh
.head 5 -  Class Child Ref Key: 35
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   5.514"
.head 6 -  Top:    0.24"
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
.head 4 -  Line
.head 5 -  Resource Id: 60994
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  5.357"
.head 6 -  Begin Y:  0.073"
.head 6 -  End X:  5.357"
.head 6 -  End Y:  0.531"
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
.head 6 -  Left:   7.386"
.head 6 -  Top:    0.24"
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
.head 4 +  Pushbutton: pbDetails !! Документы
.head 5 -  Class Child Ref Key: 39
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   6.8"
.head 6 -  Top:    0.24"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Open.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = ' Документы  ФУ...'
.head 6 +  On SAM_Click
.head 7 -  Call SalCreateWindow(TB_D, hWndMDI, 
Val(sMFO),
 IifS(SalTblAnyRows( hWndForm, ROW_Selected, 0 ),FU.NLS,''), 
 32,
 FU.DAT1,
 FU.DAT2)
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 40
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   7.814"
.head 6 -  Top:    0.24"
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
.head 5 -  Resource Id: 60995
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  4.686"
.head 6 -  Begin Y:  -0.01"
.head 6 -  End X:  4.686"
.head 6 -  End Y:  0.448"
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
.head 6 -  Left:   8.4"
.head 6 -  Top:    0.24"
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
.head 5 -  Resource Id: 60996
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  1.9"
.head 6 -  Begin Y:  -0.01"
.head 6 -  End X:  1.9"
.head 6 -  End Y:  0.448"
.head 5 -  Visible? No
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 -  !
.head 4 -  Frame
.head 5 -  Resource Id: 60997
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.086"
.head 6 -  Top:    0.073"
.head 6 -  Width:  5.3"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.667"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Corners: Square
.head 5 -  Border Style: Raised-Shadow
.head 5 -  Border Thickness: 1
.head 5 -  Border Color: Default
.head 5 -  Background Color: Default
.head 4 +  Radio Button: rb1
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title: Дата отч.периода НУ
.head 5 -  Window Location and Size
.head 6 -  Left:   0.286"
.head 6 -  Top:    0.156"
.head 6 -  Width:  2.5"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Message Actions
.head 4 +  Radio Button: rb2
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title: Дата документа
.head 5 -  Window Location and Size
.head 6 -  Left:   0.286"
.head 6 -  Top:    0.406"
.head 6 -  Width:  2.5"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Message Actions
.head 4 +  Data Field: DAT1
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Editable? Yes
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   3.0"
.head 7 -  Top:    0.281"
.head 7 -  Width:  1.171"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.25"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? Yes
.head 6 -  Justify: Left
.head 6 -  Format: Date
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 +  Data Field: DAT2
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Editable? Yes
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   4.171"
.head 7 -  Top:    0.281"
.head 7 -  Width:  1.171"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.25"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? Yes
.head 6 -  Justify: Left
.head 6 -  Format: Date
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 -  !
.head 4 +  Pushbutton: pbSAL_All !! Все ЛС
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbRelation
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   5.943"
.head 6 -  Top:    0.24"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Look.bmp
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'ВСЕ Лицевые Счета ФУ...'
.head 6 +  On SAM_Click
.head 7 +  If nPar =32
.head 8 -  Call SalCreateWindow(FU, hWndMDI, 1,'',DAT1,DAT2)
.head 4 +  Pushbutton: pbSal_1   !! Лс одного БС
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbRelation
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   6.371"
.head 6 -  Top:    0.24"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Childs.bmp
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Один выбранный БС: Лицевые Счета ФУ...'
.head 6 +  On SAM_Click
.head 7 -  Call SalCreateWindow(FU, hWndMDI, 2,FU.NLS,DAT1,DAT2)
.head 2 +  Contents
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
.head 4 -  Width:  1.529"
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
.head 3 +  Column: OST5
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сальдо ( +Кр  -Дб  ) 
завизированных
(sos = 5)
Гр.1
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
.head 3 +  Column: OST1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сальдо ( +Кр  -Дб  ) 
HEзавизированных
(sos = 1)
Гр.2
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  2.029"
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
.head 3 +  Column: OST2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сальдо ( +Кр  -Дб  ) 
отказанных
(sos < 0 )
Гр.3
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  2.014"
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
.head 3 +  Column: OST
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сальдо ( +Кр  -Дб  ) 
в БД

Гр.1 + Гр.2 + Гр.3
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  2.057"
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
.head 3 -  String: sNBS
.head 3 -  Date/Time: DAT1p
.head 3 -  Date/Time: DAT2p
.head 2 +  Window Variables
.head 3 -  Number: nISP
.head 3 -  Number: nRnk
.head 3 -  Number: nTmp
.head 3 -  String: sMFO
.head 3 -  String: lifff
.head 3 -  String: strMySql
.head 3 -  String: sTmp
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindow( hWndForm )
.head 4 -  Set rb1=TRUE
.head 4 +  If nPar != 32 !! сальдовки
.head 5 -  Call SalHideWindow( pbSAL_All )
.head 5 -  Call SalHideWindow( pbSal_1 )
.head 4 -  Call SetWindowFullSize( hWndForm )
.head 4 -  Call SalTblSetLockedColumns(hWndForm, 1)
.head 4 -  Set nISP = GetUserId()
.head 4 -  Set nRnk=GetIdRnk()
.head 4 +  If SqlPrepareAndExecute( hSql(), "SELECT mfo INTO :sMFO FROM custbank where rnk=:nRnk" )
.head 5 -  Call SqlFetchNext( hSql(), nTmp )
.head 4 -  Set FU.DAT2 = DAT2p
.head 4 -  Set FU.DAT1 = DAT1p
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On UM_Populate
.head 4 -  Call SalWaitCursor( TRUE )
.head 4 -  Set sTmp="Сверка с БАЛАНСОМ "||sNBS||". "|| IifS(rb1,"Дата отч.периода НУ","Дата документа") || ": "||
SalFmtFormatDateTime( DAT1, 'dd/MM/yyyy')||" - " || SalFmtFormatDateTime( DAT2, 'dd/MM/yyyy')
.head 4 -  Call SalSetWindowText( hWndForm, sTmp)
.head 4 +  If nPar =32  !! баланс
.head 5 -  Set FU.strPrintFileName = 'FUB'
.head 5 +  If rb1
.head 6 -  Set strMySql = "
SELECT substr(nls,1,4),sum(ost5)/100,sum(ost1)/100,sum(ost2)/100 
INTO :FU.NLS,:FU.OST5,:FU.OST1,:FU.OST2
FROM 
(select nlsa nls,
        decode(sos,5,decode(dk,1,-s,s),0) ost5,
        decode(sos,1,decode(dk,1,-s,s),0) ost1,
        decode(sos,-1,decode(dk,1,-s,s),0) ost2
 from oper where userid=:nISP and mfoa=:sMFO and vdat>=:DAT1 and vdat<=:DAT2
 union all
 select nlsb,
        decode(sos,5,decode(dk,0,-s,s),0),
        decode(sos,1,decode(dk,0,-s,s),0),
        decode(sos,-1,decode(dk,0,-s,s),0)
 from oper where userid=:nISP and  mfob=:sMFO and vdat>=:DAT1 and vdat<=:DAT2
)
WHERE  nls in (select nls from sbu where rnk=:nRnk)
GROUP BY substr(nls,1,4) ORDER BY 1 "    
.head 5 +  Else
.head 6 -  Set strMySql = "
SELECT substr(nls,1,4),sum(ost5)/100,sum(ost1)/100,sum(ost2)/100 
INTO :FU.NLS,:FU.OST5,:FU.OST1,:FU.OST2
FROM 
(select nlsa nls,
        decode(sos,5,decode(dk,1,-s,s),0) ost5,
        decode(sos,1,decode(dk,1,-s,s),0) ost1,
        decode(sos,-1,decode(dk,1,-s,s),0) ost2
 from oper where userid=:nISP and mfoa=:sMFO and datd>=:DAT1 and datd<=:DAT2
 union all
 select nlsb,
        decode(sos,5,decode(dk,0,-s,s),0),
        decode(sos,1,decode(dk,0,-s,s),0),
        decode(sos,-1,decode(dk,0,-s,s),0)
 from oper where userid=:nISP and  mfob=:sMFO and datd>=:DAT1 and datd<=:DAT2
)
WHERE  nls in (select nls from sbu where rnk=:nRnk)
GROUP BY substr(nls,1,4) ORDER BY 1 "    
.head 4 +  Else If nPar =1 !! сальдовка по всем  БС
.head 5 -  Set FU.strPrintFileName = 'FUS'
.head 5 +  If rb1
.head 6 -  Set strMySql = "
SELECT nls,sum(ost5)/100,sum(ost1)/100,sum(ost2)/100 
INTO :FU.NLS,:FU.OST5,:FU.OST1,:FU.OST2
FROM 
(select nlsa nls,
        decode(sos,5,decode(dk,1,-s,s),0) ost5,
        decode(sos,1,decode(dk,1,-s,s),0) ost1,
        decode(sos,-1,decode(dk,1,-s,s),0) ost2
 from oper where userid=:nISP and mfoa=:sMFO and vdat>=:DAT1 and vdat<=:DAT2
 union all
 select nlsb,
        decode(sos,5,decode(dk,0,-s,s),0),
        decode(sos,1,decode(dk,0,-s,s),0),
        decode(sos,-1,decode(dk,0,-s,s),0)
 from oper where userid=:nISP and  mfob=:sMFO and vdat>=:DAT1 and vdat<=:DAT2
)
WHERE  nls in (select nls from sbu where rnk=:nRnk) 
GROUP BY nls ORDER BY nls "    
.head 5 +  Else
.head 6 -  Set strMySql = "
SELECT nls,sum(ost5)/100,sum(ost1)/100,sum(ost2)/100 
INTO :FU.NLS,:FU.OST5,:FU.OST1,:FU.OST2
FROM 
(select nlsa nls,
        decode(sos,5,decode(dk,1,-s,s),0) ost5,
        decode(sos,1,decode(dk,1,-s,s),0) ost1,
        decode(sos,-1,decode(dk,1,-s,s),0) ost2
 from oper where userid=:nISP and mfoa=:sMFO and vdat>=:DAT1 and vdat<=:DAT2
 union all
 select nlsb,
        decode(sos,5,decode(dk,0,-s,s),0),
        decode(sos,1,decode(dk,0,-s,s),0),
        decode(sos,-1,decode(dk,0,-s,s),0)
 from oper where userid=:nISP and  mfob=:sMFO and vdat>=:DAT1 and vdat<=:DAT2
)
WHERE  nls in (select nls from sbu where rnk=:nRnk) 
GROUP BY nls ORDER BY nls "    
.head 4 +  Else If nPar =2 !! сальдовка по 1-му БС
.head 5 -  Set FU.strPrintFileName = 'FU'||sNBS
.head 5 +  If rb1
.head 6 -  Set strMySql = "
SELECT nls,sum(ost5)/100,sum(ost1)/100,sum(ost2)/100 
INTO :FU.NLS,:FU.OST5,:FU.OST1,:FU.OST2
FROM 
(select nlsa nls,
        decode(sos,5,decode(dk,1,-s,s),0) ost5,
        decode(sos,1,decode(dk,1,-s,s),0) ost1,
        decode(sos,-1,decode(dk,1,-s,s),0) ost2
 from oper where userid=:nISP and mfoa=:sMFO and vdat>=:DAT1 and vdat<=:DAT2
 union all
 select nlsb,
        decode(sos,5,decode(dk,0,-s,s),0),
        decode(sos,1,decode(dk,0,-s,s),0),
        decode(sos,-1,decode(dk,0,-s,s),0)
 from oper where userid=:nISP and  mfob=:sMFO and vdat>=:DAT1 and vdat<=:DAT2
)
WHERE  nls in (select nls from sbu where rnk=:nRnk) and
       substr(nls,1,4)=:sNBS 
GROUP BY nls ORDER BY nls "    
.head 5 +  Else
.head 6 -  Set strMySql = "
SELECT nls,sum(ost5)/100,sum(ost1)/100,sum(ost2)/100 
INTO :FU.NLS,:FU.OST5,:FU.OST1,:FU.OST2
FROM 
(select nlsa nls,
        decode(sos,5,decode(dk,1,-s,s),0) ost5,
        decode(sos,1,decode(dk,1,-s,s),0) ost1,
        decode(sos,-1,decode(dk,1,-s,s),0) ost2
 from oper where userid=:nISP and mfoa=:sMFO and datd>=:DAT1 and datd<=:DAT2
 union all
 select nlsb,
        decode(sos,5,decode(dk,0,-s,s),0),
        decode(sos,1,decode(dk,0,-s,s),0),
        decode(sos,-1,decode(dk,0,-s,s),0)
 from oper where userid=:nISP and  mfob=:sMFO and datd>=:DAT1 and datd<=:DAT2
)
WHERE  nls in (select nls from sbu where rnk=:nRnk) and
       substr(nls,1,4)=:sNBS 
GROUP BY nls ORDER BY nls "    
.head 4 -  Call SalTblPopulate( hWndForm, FU.cMain.hSql(), strMySql, TBL_FillNormal )
.head 4 -  Call SalWaitCursor( FALSE )
.head 3 +  On SAM_FetchRowDone
.head 4 -  Set OST=OST5+OST1+OST2
.head 4 -  Call SalTblSetCellTextColor(OST5,COLOR_Black, FALSE)
.head 4 -  Call SalTblSetCellTextColor(OST1,COLOR_DarkGreen, FALSE)
.head 4 -  Call SalTblSetCellTextColor(OST2,COLOR_Red, FALSE)
.head 4 -  Call SalTblSetCellTextColor(OST,COLOR_DarkBlue, FALSE)
.head 4 -  !
.head 1 +  Table Window: TB_IF
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Состояние подчиненых счетов финансового учета 
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
.head 4 -  Top:    0.688"
.head 4 -  Width:  12.7"
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
.head 4 -  Size: 0.464"
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
.head 6 -  Left:   9.917"
.head 6 -  Top:    0.095"
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
.head 4 -  Line
.head 5 -  Resource Id: 47846
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? No
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
.head 6 -  Left:   7.383"
.head 6 -  Top:    0.012"
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
.head 4 +  Pushbutton: pbFilter
.head 5 -  Class Child Ref Key: 44
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.267"
.head 6 -  Top:    0.048"
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
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 40
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   10.983"
.head 6 -  Top:    0.095"
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
.head 5 -  Resource Id: 47847
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? No
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
.head 6 -  Left:   11.517"
.head 6 -  Top:    0.095"
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
.head 5 -  Resource Id: 47848
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? No
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 +  Data Field: DAZ
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Editable? Yes
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   6.467"
.head 7 -  Top:    0.167"
.head 7 -  Width:  1.533"
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
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 +  Data Field: DAZ2
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Editable? Yes
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   8.15"
.head 7 -  Top:    0.167"
.head 7 -  Width:  1.533"
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
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 +  Data Field: dTitle
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
.head 7 -  Left:   0.25"
.head 7 -  Top:    0.167"
.head 7 -  Width:  6.2"
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
.head 4 +  Pushbutton: pbAccHistory
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cTBarButton
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   10.45"
.head 6 -  Top:    0.095"
.head 6 -  Width:  0.429"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Books.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'История счета...'
.head 6 +  On SAM_Click
.head 7 +  If SalTblAnyRows( hWndForm, ROW_Selected, 0 ) and TB_IF.ACC !=NUMBER_Null
.head 8 -  Call Show_Sal_Day_P( TB_IF.ACC, TB_IF.NLS, TB_IF.n980, TB_IF.DAZ, TB_IF.DAZ2 )
.head 2 +  Contents
.head 3 +  Column: ISP
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
исп
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.586"
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
фин.учета
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.629"
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
.head 3 +  Column: NAM
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
.head 4 -  Width:  2.95"
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
.head 3 +  Column: ACC
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  6.8"
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
.head 4 -  Title: Остаток
входящий
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.457"
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
.head 3 +  Column: DOS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Обороты
Дебет
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.457"
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
.head 3 +  Column: KOS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Обороты
Кредит
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.457"
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
.head 3 +  Column: S2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Остаток
исходящий
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.457"
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
.head 3 -  Number: nACCC
.head 3 -  Date/Time: dDAZ
.head 3 -  Date/Time: dDAZ2
.head 3 -  String: sTitle
.head 2 +  Window Variables
.head 3 -  String: ss1
.head 3 -  Number: nIsx
.head 3 -  Number: nDos
.head 3 -  Number: nKos
.head 3 -  Number: nVx
.head 3 -  Number: nTmp
.head 3 -  Number: n980
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Set TB_IF.strPrintFileName = 'NAL_DECIF'
.head 4 -  Set TB_IF.DAZ=GetBankDate()
.head 4 -  Set TB_IF.DAZ2=GetBankDate()
.head 4 -  Set TB_IF.n980=GetBaseVal()
.head 4 -  ! Set TB_IF.nIsp=GetUserId()
.head 4 -  Set dTitle=sTitle
.head 4 -  Call SalTblSetLockedColumns(hWndForm, 4)
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Set TB_IF.DAZ = TB_IF.dDAZ
.head 4 -  Set TB_IF.DAZ2= TB_IF.dDAZ2
.head 4 -  Set TB_IF.ss1 = "
    SELECT b.nms, b.nls, b.acc, b.isp,
         bars.FOST(b.acc,:TB_IF.DAZ2)/100,
         bars.FDOS(b.acc,:TB_IF.DAZ,:TB_IF.DAZ2)/100,
         bars.FKOS(b.acc,:TB_IF.DAZ,:TB_IF.DAZ2)/100
    INTO :TB_IF.NAM,:TB_IF.NLS,:TB_IF.ACC,:TB_IF.ISP,
         :TB_IF.S2, :TB_IF.DOS,:TB_IF.KOS 
    FROM  accounts b
    WHERE b.accc=:nACCC
    ORDER BY b.nls "
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On SAM_FetchRowDone
.head 4 -  Set TB_IF.S = TB_IF.S2 + TB_IF.DOS - TB_IF.KOS
.head 4 -  Call SalTblSetCellTextColor( TB_IF.S, IifN(TB_IF.S <0,COLOR_DarkRed,COLOR_DarkBlue), FALSE )
.head 4 -  Call SalTblSetCellTextColor( TB_IF.S2,IifN(TB_IF.S2<0,COLOR_DarkRed,COLOR_DarkBlue), FALSE )
.head 4 -  Set nIsx = nIsx + S
.head 4 -  Set nDos = nDos + DOS
.head 4 -  Set nKos = nKos + KOS
.head 4 -  Set nVx  = nVx  + S2
.head 3 +  On UM_Populate
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set nIsx=0
.head 4 -  Set nDos=0
.head 4 -  Set nKos=0
.head 4 -  Set nVx=0
.head 4 -  Call SalTblPopulate(hWndForm, hSql(), TB_IF.ss1, TBL_FillAll )
.head 4 -  Call SalTblDefineSplitWindow ( hWndForm, 5, TRUE )
.head 4 -  Set nTmp=SalTblInsertRow ( hWndForm, TBL_MinRow )
.head 4 -  Call SalTblSetContext ( hWndForm, nTmp)
.head 4 -  Call SalTblSetRowFlags( hWndForm, nTmp, ROW_New, FALSE )
.head 4 -  !
.head 4 -  Set TB_IF.S=nIsx
.head 4 -  Set TB_IF.DOS=nDos
.head 4 -  Set TB_IF.KOS=nKos
.head 4 -  Set TB_IF.S2=nVx
.head 4 -  Set TB_IF.NAM='Итог'
.head 4 -  Call SalTblSetCellTextColor( TB_IF.S, IifN(TB_IF.S <0,COLOR_DarkRed,COLOR_DarkBlue), FALSE )
.head 4 -  Call SalTblSetCellTextColor( TB_IF.S2,IifN(TB_IF.S2<0,COLOR_DarkRed,COLOR_DarkBlue), FALSE )
.head 4 -  !
.head 4 -  Set nTmp=SalTblInsertRow ( hWndForm, TBL_MinRow )
.head 4 -  Call SalTblSetContext ( hWndForm, nTmp)
.head 4 -  Call SalTblSetRowFlags( hWndForm, nTmp, ROW_New, FALSE )
.head 4 +  If SqlPrepareAndExecute( hSql(),
  "SELECT b.nms, b.nls, b.acc, b.isp,
         bars.FOST(b.acc,:TB_IF.DAZ2)/100,
         bars.FDOS(b.acc,:TB_IF.DAZ,:TB_IF.DAZ2)/100,
         bars.FKOS(b.acc,:TB_IF.DAZ,:TB_IF.DAZ2)/100
    INTO :TB_IF.NAM,:TB_IF.NLS,:TB_IF.ACC,:TB_IF.ISP,
         :TB_IF.S2, :TB_IF.DOS,:TB_IF.KOS 
    FROM  accounts b WHERE b.acc=:nACCC" )
 and SqlFetchNext( hSql(), nFetchRes )
.head 5 -  Set TB_IF.S = TB_IF.S2 + TB_IF.DOS - TB_IF.KOS
.head 5 -  Call XSalTblSetRowBackColor( hWndForm, nTmp, COLOR_Gray )
.head 5 -  Call SalTblSetCellTextColor( TB_IF.S, IifN(TB_IF.S <0,COLOR_DarkRed,COLOR_DarkBlue), FALSE )
.head 5 -  Call SalTblSetCellTextColor( TB_IF.S2,IifN(TB_IF.S2<0,COLOR_DarkRed,COLOR_DarkBlue), FALSE )
.head 4 -  !
.head 4 -  ! Call SalTblSetContext(hWndForm, 0)
.head 4 -  Call SalPostMsg(hWndForm, SAM_TblDoDetails, 0, 0)
.head 4 -  Call SalWaitCursor(FALSE)
.head 1 +  Table Window: TB_MOPER
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Протокол отправки и приема файлов NU<MFO>.<md>   - MOPER.dbf  по нал.учету
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
.head 4 -  Top:    0.688"
.head 4 -  Width:  11.717"
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
.head 6 -  Left:   1.517"
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
.head 4 -  Line
.head 5 -  Resource Id: 23192
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? No
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
.head 6 -  Left:   2.067"
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
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbFilter
.head 5 -  Class Child Ref Key: 44
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.617"
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
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbDetails
.head 5 -  Class Child Ref Key: 39
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
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
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 40
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.717"
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
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 23193
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? No
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
.head 6 -  Left:   4.267"
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
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 23194
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? No
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 2 +  Contents
.head 3 +  Column: MFO
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: МФО 
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.883"
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
.head 3 +  Column: NAME 
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование  филиала
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.533"
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
.head 3 +  Column: DAT_FORM
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
формирования
в филиале
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.417"
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
.head 3 +  Column: DAT_BEG
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
начала 
периода
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
.head 3 +  Column: DAT_END
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
конца 
периода
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
.head 3 +  Column: FN
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Имя
файла
.head 4 -  Visible? Yes
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
.head 3 +  Column: DAT_PAY
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
приема 
в гл.банке
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
.head 3 +  Column: PAY
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кол-во 
пл.док
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
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Number: nParam
.head 2 -  Window Variables
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Set TB_MOPER.strFilterTblName = 'MOPER_NU'
.head 4 -  Set TB_MOPER.strPrintFileName =  'MOPER_NU'
.head 4 -  Set TB_MOPER.strSqlPopulate=
"SELECT m.MFO, m.DAT_FORM, m.DAT_BEG, m.DAT_END, m.FN, m.DAT_PAY, b.nb, m.PAY        
 INTO  :TB_MOPER.MFO,     :TB_MOPER.DAT_FORM, :TB_MOPER.DAT_BEG, 
       :TB_MOPER.DAT_END, :TB_MOPER.FN,       :TB_MOPER.DAT_PAY, :TB_MOPER.NAME,
       :TB_MOPER.PAY
 FROM moper_nu m, banks b
 WHERE m.mfo=b.mfo
 ORDER BY m.DAT_END desc,  m.mfo"
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 1 +  Dialog Box: dlg_ImpMoperi
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Прием ИТОГОВЫХ сумм НУ  из файлов NU<MFO>.<md> от филиалов
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   0.675"
.head 4 -  Top:    0.552"
.head 4 -  Width:  12.983"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 6.679"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Прием документов и оплата документов из MOPER по НУ
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
.head 3 -  Background Text: Имя файла импорта
.head 4 -  Resource Id: 23199
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   9.517"
.head 5 -  Top:    0.214"
.head 5 -  Width:  3.1"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.202"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Combo Box: dfFile
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   9.7"
.head 5 -  Top:    0.56"
.head 5 -  Width:  2.983"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 4.107"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  String Type: String
.head 4 -  Maximum Data Length: 12
.head 4 -  Sorted? Yes
.head 4 -  Always Show List? No
.head 4 -  Vertical Scroll? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  List Initialization
.head 4 -  Message Actions
.head 3 +  Check Box: cbAll
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cCheckBoxLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Принять ВСЕ файлы
.head 4 -  Window Location and Size
.head 5 -  Left:   8.517"
.head 5 -  Top:    5.369"
.head 5 -  Width:  3.4"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Teal
.head 4 -  Background Color: Class Default
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbExecute
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выполнить
.head 4 -  Window Location and Size
.head 5 -  Left:   9.85"
.head 5 -  Top:    5.667"
.head 5 -  Width:  1.333"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.595"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \bars98\RESOURCE\BMP\Execute.bmp
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click   ! Nata
.head 6 +  If dfFile ! есть ли входные файлы
.head 7 +  If MessageQuestion('Прием/Оплата ' || IifS(cbAll, 'NU??????.'||sMD, dfFile) || ' ?') = IDNO
.head 8 -  Return FALSE
.head 7 +  If IsBankDayOpen()
.head 8 -  ! Для проверки на недопустимые символы
.head 8 -  Set i = 0
.head 8 +  While i <= 31
.head 9 -  Set msSimv[i] = SalNumberToChar( i )
.head 9 -  Set i = i + 1
.head 8 -  Set msSimv[i] = SalNumberToChar( 255 )
.head 8 -  !
.head 8 -  Set nJur = TBL_MinRow
.head 8 -  ! организация цикла по COMBOboxУ
.head 8 -  Call F_KATALOG ()
.head 8 -  !
.head 7 +  Else
.head 8 -  Call Debug("День закрыт !")
.head 3 +  Pushbutton: pbRef
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Перечитать
.head 4 -  Window Location and Size
.head 5 -  Left:   8.5"
.head 5 -  Top:    5.667"
.head 5 -  Width:  1.333"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.595"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \bars98\RESOURCE\BMP\Refresh.bmp
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click   
.head 6 -  Call FileZNListBox()
.head 3 +  Pushbutton: pbProt
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Протокол
.head 4 -  Window Location and Size
.head 5 -  Left:   7.15"
.head 5 -  Top:    5.667"
.head 5 -  Width:  1.333"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.595"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \bars98\RESOURCE\BMP\Open.bmp
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click  
.head 6 -  Call NAL_DEC(100)
.head 3 -  !
.head 3 +  Data Field: dfReccount
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 6
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.45"
.head 6 -  Top:    0.19"
.head 6 -  Width:  1.883"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.226"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfAll
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 6
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.1"
.head 6 -  Top:    0.19"
.head 6 -  Width:  1.883"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.226"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Blue
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbExit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выход
.head 4 -  Window Location and Size
.head 5 -  Left:   11.2"
.head 5 -  Top:    5.667"
.head 5 -  Width:  1.333"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.595"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \bars98\RESOURCE\BMP\Discard.bmp
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(hWndForm, FALSE)
.head 3 +  Data Field: dfCurrent
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 6
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   6.067"
.head 6 -  Top:    0.19"
.head 6 -  Width:  1.883"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.226"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Dark Green
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Frame
.head 4 -  Resource Id: 23198
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.083"
.head 5 -  Top:    5.238"
.head 5 -  Width:  12.667"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.083"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Drop-Shadow
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 +  Data Field: dfStart
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
.head 6 -  Left:   0.433"
.head 6 -  Top:    5.345"
.head 6 -  Width:  6.9"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Fixedsys
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Periwinkle
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfEnd
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
.head 6 -  Left:   0.433"
.head 6 -  Top:    5.333"
.head 6 -  Width:  6.883"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Fixedsys
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Periwinkle
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfDone
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
.head 6 -  Left:   0.383"
.head 6 -  Top:    5.345"
.head 6 -  Width:  6.917"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.298"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Center
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Purple
.head 5 -  Background Color: Gray
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Child Table: tbl1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.05"
.head 6 -  Top:    0.56"
.head 6 -  Width:  9.267"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 4.179"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  View: Table
.head 5 -  Allow Row Sizing? No
.head 5 -  Lines Per Row: Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: 333333
.head 5 -  Discardable? Yes
.head 4 +  Contents
.head 5 +  Column: colFA
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Файл
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.214"
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
.head 5 +  Column: colNPP
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Nпп
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  0.471"
.head 6 -  Width Editable? Yes
.head 6 -  Format: #0
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
.head 5 +  Column: colND
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Номер док.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.114"
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
.head 5 +  Column: colVOB
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Вид оп.
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
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
.head 5 +  Column: colNLSA
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Счет-А
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.4"
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
.head 5 +  Column: colNAMA
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наим.А
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.714"
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
.head 5 +  Column: colNAMB
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наим.Б
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.714"
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
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Сумма
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.643"
.head 6 -  Width Editable? Yes
.head 6 -  Format: ###000
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
.head 5 +  Column: colVDATE
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Дата вал.
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Justify: Left
.head 6 -  Width:  1.543"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Date
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
.head 5 +  Column: colNAZN
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Назначение пл.
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 160
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.357"
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
.head 5 +  Column: colREF98
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Референс
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  1.329"
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
.head 5 +  Column: colTT
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Транзакция
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.943"
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
.head 5 -  Number: nFocusRow
.head 5 -  Window Handle: hWndCol
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
.head 6 -  Call VisTblAutoSizeColumn(tbl1, hWndNULL)
.head 5 +  On SAM_CornerClick
.head 6 -  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
.head 5 +  On SAM_CornerDoubleClick
.head 6 -  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
.head 5 +  On SAM_DoubleClick
.head 6 -  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
.head 5 +  On SAM_RowHeaderClick
.head 6 -  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
.head 5 +  On SAM_RowHeaderDoubleClick
.head 6 -  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
.head 5 +  On SAM_EndCellTab
.head 6 -  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
.head 5 +  On WM_LbuttonUp
.head 6 -  ! Узнать текущую строку
.head 6 -  ! Call SalTblQueryFocus(tbl1, nFocusRow, hWndCol)
.head 6 -  ! Set nFocusRow = SalTblQueryContext(tbl1)
.head 6 -  ! Почистить все
.head 6 -  Call SalTblSetFlagsAnyRows(tbl1, ROW_Selected, FALSE, 0, 0)
.head 6 -  ! Call SalTblSetFocusRow (tbl1, nFocusRow)
.head 6 -  ! Стать на нее (что выше)
.head 6 -  ! Call SalTblSetRowFlags(tbl1, nFocusRow, ROW_Selected, FALSE)
.head 6 -  ! Call SalSendMsg(tbl1, SAM_RowHeaderClick, 0, Max(TBL_MaxRow, nFocusRow+1))
.head 5 +  On VTM_KeyUp
.head 6 -  Call SalTblSetFlagsAnyRows(tbl1, ROW_Selected, FALSE, 0, 0)
.head 6 -  Call VisTblAutoSizeColumn(tbl1, hWndNULL)
.head 5 +  On WM_NCMouseMove ! 160
.head 6 -  Call VisTblAutoSizeColumn(tbl1, hWndNULL)
.head 3 +  Custom Control: ccProgressBar
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
.head 6 -  Left:   0.117"
.head 6 -  Top:    4.786"
.head 6 -  Width:  10.867"
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
.head 5 -  Text Color: Royal Blue
.head 5 -  Background Color: Gray
.head 5 -  DLL Settings
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
.head 6 -  Left:   11.117"
.head 6 -  Top:    4.786"
.head 6 -  Width:  1.733"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.333"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Date
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 12
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Group Box: Всего
.head 4 -  Resource Id: 54104
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.217"
.head 5 -  Top:    0.06"
.head 5 -  Width:  2.233"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.429"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Group Box: Выбрано
.head 4 -  Resource Id: 54103
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.083"
.head 5 -  Top:    0.06"
.head 5 -  Width:  2.233"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.429"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Blue
.head 4 -  Background Color: Default
.head 3 -  Group Box: Выбрано
.head 4 -  Resource Id: 54102
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.95"
.head 5 -  Top:    0.06"
.head 5 -  Width:  2.233"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.429"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Dark Green
.head 4 -  Background Color: Default
.head 2 +  Functions
.head 3 +  Function: FileZNListBox
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: smFiles[*]
.head 5 -  Number: nI
.head 5 -  Number: nFiles
.head 4 +  Actions
.head 5 -  Set sMD=Sep98md( dfBD ) 
.head 5 -  Set nFiles = VisDosEnumFiles(sODBCDir || '\\NU??????.'||sMD, FA_Standard, smFiles)
.head 5 -  Set nI = 0
.head 5 -  Call SalListClear(dfFile)
.head 5 +  While nI < nFiles
.head 6 -  Call SalListAdd(dfFile, smFiles[nI])
.head 6 -  Set nI = nI + 1
.head 5 +  If nI > 0
.head 6 -  Call SalListSetSelect(dfFile, 0)
.head 6 -  Call SalEnableWindow(pbExecute)
.head 6 -  Call SalSendMsg(dfFile, SAM_Click, 0, 0)
.head 5 +  Else
.head 6 -  Call SalDisableWindow(pbExecute)
.head 5 -  Call SalEnableWindow(pbExit)
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  Call SalSetFocus(pbExit)
.head 3 +  Function: Perenos
.head 4 -  Description: Разбиение назначения платежа
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  String: sTxt	! текст
.head 5 -  Number: nLen	! длина
.head 5 -  Number: nSpaces ! количество пробелов слева
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sNana[*]
.head 5 -  Number: nL
.head 5 -  String: sI
.head 5 -  Number: nJ
.head 5 -  Number: nC
.head 5 -  String: sRes
.head 4 +  Actions
.head 5 -  Set nL = 0
.head 5 -  Set sI = SalStrTrimX(sTxt)
.head 5 +  Loop
.head 6 +  If Len(sI) = 0
.head 7 -  Break
.head 6 +  If Len(sI) < nLen+1
.head 7 -  Set sNana[nL] = sI
.head 7 -  Break
.head 6 -  Set nJ = nLen + 1
.head 6 -  Set sNana[nL] = Left(sI, nJ)
.head 6 +  While nJ > 0
.head 7 +  If Subs(sNana[nL], nJ, 1) = ' ' or Subs(sNana[nL], nJ, 1) = ',' or
   Subs(sNana[nL], nJ, 1) = '.' or Subs(sNana[nL], nJ, 1) = ';' or
   Subs(sNana[nL], nJ, 1) = ':' or Subs(sNana[nL], nJ, 1) = '-'
.head 8 -  Set sNana[nL] = SalStrTrimX(Left(sNana[nL], nJ))
.head 8 -  Set sI = SalStrTrimX(Subs(sI, nJ+1, Len(sI)-nJ))
.head 8 -  Break
.head 7 -  Set nJ = nJ - 1
.head 7 +  If nJ = 0
.head 8 -  Set sI = SalStrTrimX(Subs(sI, nLen+1, Len(sI)-nLen))
.head 6 -  Set nL = nL + 1
.head 5 -  Set nC = 0
.head 5 -  Set sRes = ''
.head 5 +  While nC <= nL
.head 6 -  Set sRes = sRes || Spac(nSpaces) || sNana[nC] || PutCrLf()
.head 6 -  Set nC = nC + 1
.head 5 -  Return sRes
.head 3 +  Function: FScan
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  String: sPar
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sStr
.head 5 -  Number: nNum
.head 5 -  Boolean: bRet
.head 4 +  Actions
.head 5 -  Set sStr = sPar
.head 5 -  Set bRet = TRUE
.head 5 +  Loop
.head 6 +  If sStr
.head 7 -  Call SalStrFirstC( sStr, nNum )
.head 7 -  Set i = 0
.head 7 +  While i <= 32
.head 8 +  If SalNumberToChar(nNum) = msSimv[i]
.head 9 -  Set bRet = FALSE
.head 9 -  Break
.head 8 -  Set i = i + 1
.head 6 +  Else
.head 7 -  Break
.head 6 +  If not bRet
.head 7 -  Break
.head 5 -  Return bRet
.head 3 +  Function: F_KATALOG
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Date/Time: dTmp
.head 4 +  Actions
.head 5 -  Set dTmp = dfBD
.head 5 +  While Len(dfFile) > 0
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call SalDisableWindow(pbExecute)
.head 6 -  Call SalDisableWindow(pbExit)
.head 6 -  Set dfDone = ""
.head 6 -  Call SalUseRegistry(FALSE, '')
.head 6 -  Call SaveInfoToLog('Прием документов из ' || IifS(cbAll, 'NU??????.'||sMD, dfFile))
.head 6 -  Call SalFileCreateDirectory(sODBCDir || '\\TempODBC.Dir')
.head 6 +  If SalFileSetCurrentDirectory(sODBCDir)
.head 7 -  Call SalFileCreateDirectory(sODBCDir || '\\TempODBC.Dir')
.head 7 -  Call SalFileSetCurrentDirectory(sODBCDir || '\\TempODBC.Dir')
.head 7 -  Set sTempDbf = 'Db' || Left(SalFmtFormatDateTime(   SalDateCurrent(), 'mmmmmm'), 2) || SalFmtFormatDateTime(
    SalDateCurrent(), 'ssmm') || '.Dbf'
.head 7 -  ! !!!!
.head 7 -  Call VisFileCopy(sODBCDir || '\\' || dfFile, sODBCDir || '\\TempODBC.Dir\\' ||     sTempDbf )
.head 7 -  Set SqlDatabase = 'dBase_Files'
.head 7 +  If SalFileGetDateTime(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf, dTmp )
.head 8 -  ! проверить, есть ли поле ref99bm в operxx, если нет, то добавить его
.head 8 -  Set n99 = -1
.head 8 -  Set dfDone = "Подождите ..."
.head 8 -  Call SalLoadAppAndWait("FindVar2 " || sODBCDir || '\\TempODBC.Dir\\' ||  sTempDbf || " ref99bm", Window_NotVisible, n99)
.head 8 +  If n99 = 1
.head 9 -  Call SalWaitCursor(FALSE)
.head 9 -  ! удалить в NOT, но запросить сначала
.head 9 +  If VisMessageBox('Файл ' || dfFile || ' возможно занят другим пользователем. Удалить в NOT ?', 'ЗАПРОС', MBF_IconQuestion, hBtns, 2) = 1 ! ID_Yes
.head 10 -  Call SalWaitCursor(TRUE)
.head 10 -  Call SalFileCreateDirectory(sODBCDir || '\\ArchivNO')
.head 10 -  Call VisFileCopy(sODBCDir || '\\' || dfFile, sODBCDir || '\\ArchivNO\\' || dfFile)
.head 10 +  If File(sODBCDir || '\\ArchivNO\\' || dfFile)
.head 11 -  Call VisFileDelete(sODBCDir || '\\' || dfFile)
.head 11 -  Call VisFileDelete(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf)
.head 9 -  Return FALSE
.head 8 +  If n99 = 2
.head 9 -  Call SalWaitCursor(FALSE)
.head 9 -  ! удалить без запроса в NOT, но написать об этом
.head 9 -  Call MessageNoWait('Файл ' || dfFile ||     ' не DBF-структуры, удаляется в NOT !', 'ВНИМАНИЕ !', 37, 1)
.head 9 -  Call SalFileCreateDirectory(sODBCDir || '\\ArchivNO')
.head 9 -  Call VisFileCopy(sODBCDir || '\\' || dfFile, sODBCDir || '\\ArchivNO\\' ||     dfFile)
.head 9 +  If File(sODBCDir || '\\ArchivNO\\' || dfFile)
.head 10 -  Call VisFileDelete(sODBCDir || '\\' || dfFile)
.head 10 -  Call VisFileDelete(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf)
.head 9 -  Return FALSE
.head 8 +  If n99 = 3
.head 9 -  Call SalWaitCursor(FALSE)
.head 9 -  ! удалить без запроса в NOT, но написать об этом
.head 9 -  Call MessageNoWait('Файл ' || dfFile ||     ' имеет структуру не MOPER, удаляется в NOT !', 'ВНИМАНИЕ !', 37, 1)
.head 9 -  Call SalFileCreateDirectory(sODBCDir || '\\ArchivNO')
.head 9 -  Call VisFileCopy(sODBCDir || '\\' || dfFile, sODBCDir || '\\ArchivNO\\' ||     dfFile)
.head 9 +  If File(sODBCDir || '\\ArchivNO\\' || dfFile)
.head 10 -  Call VisFileDelete(sODBCDir || '\\' || dfFile)
.head 10 -  Call VisFileDelete(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf)
.head 9 -  Return FALSE
.head 8 +  If n99 = 4
.head 9 -  Call SalWaitCursor(FALSE)
.head 9 -  ! удалить без запроса в NOT, но написать об этом
.head 9 -  Call MessageNoWait('Файл ' || dfFile ||' имеет расширение не .DBF, удаляется в NOT !', 'ВНИМАНИЕ !', 37, 1)
.head 9 -  Call SalFileCreateDirectory(sODBCDir || '\\ArchivNO')
.head 9 -  Call VisFileCopy(sODBCDir || '\\' || dfFile, sODBCDir || '\\ArchivNO\\' ||     dfFile)
.head 9 +  If File(sODBCDir || '\\ArchivNO\\' || dfFile)
.head 10 -  Call VisFileDelete(sODBCDir || '\\' || dfFile)
.head 10 -  Call VisFileDelete(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf)
.head 9 -  Return FALSE
.head 8 -  Set dfDone = ""
.head 8 -  Set sErr = STRING_Null
.head 8 -  Set FN_tmp = Left(sTempDbf, Len(sTempDbf)-4)
.head 8 +  If SqlConnect(hSqlA) and SqlConnect(hSqlB) 
.head 9 +  If not F_FILE1()
.head 10 -  Return FALSE
.head 8 +  Else
.head 9 -  Call MessageAttention('Ошибка подсоединения к Базе данных: ' || SqlDatabase)
.head 9 -  Return FALSE
.head 7 +  Else
.head 8 +  If VisMessageBox('Файл ' || dfFile ||   ' возможно занят другим пользователем. Удалить в NOT ?', 'ЗАПРОС',
   MBF_IconQuestion, hBtns, 2) = 1 ! ID_Yes
.head 9 -  Call SalWaitCursor(TRUE)
.head 9 -  Call SalFileCreateDirectory(sODBCDir || '\\ArchivNO')
.head 9 -  Call VisFileCopy(sODBCDir || '\\' || dfFile, sODBCDir || '\\ArchivNO\\' ||     dfFile)
.head 9 +  If File(sODBCDir || '\\ArchivNO\\' || dfFile)
.head 10 -  Call VisFileDelete(sODBCDir || '\\' || dfFile)
.head 10 -  Call VisFileDelete(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf)
.head 8 -  Return FALSE
.head 6 +  Else
.head 7 -  Call MessageAttention('Нет каталога: ' || sODBCDir)
.head 7 -  Return FALSE
.head 6 -  !
.head 6 -  Call FileZNListBox()
.head 6 -  !
.head 6 +  If not cbAll
.head 7 -  Return TRUE
.head 6 -  ! Call SalSendMsg( pbExecute, SAM_Click, 0, 0 )
.head 5 -  Return TRUE
.head 3 +  Function: F_FILE1
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  ! повтор периода
.head 5 -  Set sErr = STRING_Null
.head 5 +  If SqlPrepareAndExecute(hSqlA,
  "SELECT DATD,DA,VDATE,MFO    INTO :DAT_BEG,:DAT_END,:DAT_FORM,:fMFO FROM " || FN_tmp ) 
and SqlFetchNext(hSqlA, nFetchRes)
.head 6 -  Set dTempDate = DAT_END
.head 6 -  ! Проверка на повторное формирование
.head 6 -  Set DAT_END_OLD = DAT_BEG -1
.head 6 +  If SqlPrepareAndExecute( hSql(),
  "SELECT NVL( max(DAT_END), :DAT_END_OLD )    INTO :DAT_END_OLD 
   FROM moper_nu WHERE mfo=:fMFO " ) 
and SqlFetchNext( hSql(), nFetchRes )
.head 7 +  If DAT_END_OLD >= DAT_BEG
.head 8 -  Set sErr = ' содержит повторный период' 
.head 6 -  ! Проверка на пропущенный период
.head 6 +  If SqlPrepareAndExecute( hSql(),
  "SELECT count(*) INTO :Kol_dney FROM fdat WHERE fdat>:DAT_END_OLD and fdat<:DAT_BEG" ) 
and SqlFetchNext( hSql(), nFetchRes )
.head 7 +  If Kol_dney >0
.head 8 -  Set sErr = ' пропущено '||Str(Kol_dney)||' дней' 
.head 5 -  ! Синхронное отображение по банковской дате в банк.дате гл банка и филиала
.head 5 +  If sErr != STRING_Null
.head 6 -  Call SqlDisconnect(hSqlA)
.head 6 -  Call SqlDisconnect(hSqlB)
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Call MessageNoWait('Файл ' || dfFile || sErr || '. Удаляется в NOT !', 'ВНИМАНИЕ !', 37, 1)
.head 6 -  Call SalFileCreateDirectory(sODBCDir || '\\ArchivNO')
.head 6 -  Call VisFileCopy(sODBCDir || '\\' || dfFile, sODBCDir || '\\ArchivNO\\'  || dfFile)
.head 6 +  If File(sODBCDir || '\\ArchivNO\\' || dfFile)
.head 7 -  Call VisFileDelete(sODBCDir || '\\' || dfFile)
.head 7 -  Call VisFileDelete(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf)
.head 6 -  ! удалить без запроса в NOT, но написать об этом
.head 6 -  Return FALSE
.head 5 -  !
.head 5 -  If SqlPrepareAndExecute(hSqlA,
  "SELECT count(*) FROM " || Left(sTempDbf, Len(sTempDbf)-4) || " INTO :nRecCount")
and SqlFetchNext(hSqlA, nFetchRes)
.head 5 -  Call SalShowWindow(dfStart)
.head 5 -  Call SalShowWindow(dfEnd)
.head 5 -  Set nTimeStart = SalDateHour(SalDateCurrent())*3600 + SalDateMinute( SalDateCurrent())*60 + SalDateSecond(SalDateCurrent())
.head 5 -  Set dfStart = 'Старт: ' || SalFmtFormatDateTime( SalDateCurrent(), 'hhh:mm:ss')
.head 5 -  Set dfReccount = nRecCount
.head 5 -  Set dfCurrent = 0
.head 5 -  Set dfAll = 0
.head 5 -  Set nPos = 0
.head 5 -  Set nTek = 0
.head 5 -  Set nRecn = 1
.head 5 -  Set nDelta = 100 / nRecCount
.head 5 -  Call SqlSetResultSet(hSqlA, FALSE)
.head 5 -  Set sSelectOper = "
    SELECT rowid, nm,  dk,  nd,  nls, s,   plat,  polu,  naz1,  sos,  ref99bm
    INTO :nRow, :nNm,:nDk,:sNd,:sNls,:nS,:sPlat,:sPolu,:sNaz1,:nSos,:nRef99bm
    FROM " || Left(sTempDbf, Len(sTempDbf)-4) || " FOR UPDATE OF sos"
.head 5 +  If not SqlPrepare(hSqlA, sSelectOper)
.head 6 -  Call SqlDisconnect(hSqlA)
.head 6 -  Call SqlDisconnect(hSqlB)
.head 6 -  Return FALSE
.head 5 -  Call SqlOpen(hSqlA, Left(sTempDbf, Len(sTempDbf)-4))
.head 5 -  Set Kol_PAY = 0
.head 5 +  While SqlFetchNext(hSqlA, nFetchRes)
.head 6 -  Call Oplata1()
.head 5 -  Call ccProgressBar.SetProgress(100)
.head 5 +  If SqlPrepareAndExecute( hSql(), 
  "INSERT INTO moper_nu( MFO, DAT_FORM, DAT_BEG, DAT_END, FN, DAT_PAY, PAY) 
 values (:fMFO,:DAT_FORM,:DAT_BEG, :DAT_END, :dfFile, :dfBD, :Kol_PAY )" )
.head 6 -  Call SqlCommitEx(hSql(), 'OK')
.head 5 -  Call SqlCommit(hSqlB)
.head 5 -  Call SqlDisconnect(hSqlA)
.head 5 -  Call SqlDisconnect(hSqlB)
.head 5 -  Call SaveInfoToLog('Прием документов из ' || dfFile || ' ОКОНЧЕН')
.head 5 -  Set dfDone = "Готово"
.head 5 -  Set dfEnd = Left(dfEnd, 15)
.head 5 -  !
.head 5 +  If dfCurrent > 0
.head 6 -  ! сформировать файл оплаченных документов
.head 6 -  Set nCurrentRow = nJur
.head 6 -  Set nP = 1
.head 6 -  Set nItog = 0
.head 6 -  Set sFr = GetPrnDir() || '\\M' || Right(Str(SalDateMonth(dfBD)+100), 2)
    || Right(Str(SalDateDay(dfBD)+100), 2) || Right(Str(SalDateHour(
    SalDateCurrent())+100), 2) || Subs(Str(SalDateMinute(
    SalDateCurrent())+100), 2, 1) || '.' || Right(Str(SalDateMinute(
    SalDateCurrent())), 1) || Right(Str(SalDateSecond(
    SalDateCurrent())+100), 2)
.head 6 -  Call SalFileOpen(hF, sFr, OF_Create | OF_Write)
.head 6 -  Set sBuff = StrWinToDosX(SalStrTrimX(GetBankName())||' '||aMFO|| PutCrLf() ||
    'Дата и время формирования ' || SalFmtFormatDateTime(
    SalDateCurrent(), 'dd/MM/yyyy ') || Right('0' ||
    SalFmtFormatDateTime(SalDateCurrent(), 'hhhh:mm:ss'), 8) ||
    PutCrLf() || PutCrLf() || Spac(15) ||
    'Реестр оплаченных платежных документов' || PutCrLf() || Spac(15) ||
    '(' || dfFile || ') сеанс (с ' || Right(dfStart, 8) || ' по ') ||
    Right(dfEnd, 8) || ')' || PutCrLf() || Repl('-', 69) || PutCrLf()
.head 6 -  Call SalFileWrite(hF, sBuff, Len(sBuff))
.head 6 +  While SalTblFindNextRow(tbl1, nCurrentRow, 0, 0)
.head 7 -  Call SalTblSetFocusRow(tbl1, nCurrentRow)
.head 7 -  Set nColor = SalColorGet(tbl1.colNLSA,    COLOR_IndexCellText)
.head 7 +  If nColor = COLOR_DarkGreen
.head 8 -  Set sLev = tbl1.colTT || ' реф.' || Str(tbl1.colREF98) || ', док.'
    || SalStrTrimX(tbl1.colND) || ', оп.' || Str(tbl1.colVOB)
.head 8 -  Set sBuff = PadR(Str(nP) || '.', 4) || 
    PadR(tbl1.colNLSA || '(980)', 20) || StrWinToDosX(SalStrTrimX(tbl1.colNAMA) || PutCrLf()
    || PadL('сумма ' || SalNumberToStrX(tbl1.colS, 2), 69-Len(sLev)) ||
    PutCrLf() || Perenos(tbl1.colNAZN, 65, 4)) || PutCrLf()
.head 8 -  Call SalFileWrite(hF, sBuff, Len(sBuff))
.head 8 -  Set nP = nP + 1
.head 8 -  Set nItog = nItog + tbl1.colS
.head 6 -  Set sBuff = Repl('-', 69) || PutCrLf() || StrWinToDosX('    Итого: ' ||
    PadR(Str(nP-1), 20) || 'На сумму:') || PadL(
    SalNumberToStrX(nItog, 2), 29) || PutCrLf() || Repl('-', 69) ||
    Repl(PutCrLf(), 3)
.head 6 -  Call SalFileWrite(hF, sBuff, Len(sBuff))
.head 6 -  Call SalFileClose(hF)
.head 5 -  Call SalMessageBeep(-1)
.head 5 +  If dfAll > dfCurrent
.head 6 -  ! удалить файл в NOT (по запросу)
.head 6 +  If VisMessageBox('ВНИМАНИЕ ! Файл ' || dfFile || '. Обработаны не ВСЕ '
   || 'выбранные документы. Примите меры для исправления ошибок. ' ||
   'Переместить в NOT ?', 'ЗАПРОС', MBF_IconQuestion, hBtns, 2) = 1
 ! ID_Yes
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call SalFileCreateDirectory(sODBCDir || '\\ArchivNO')
.head 7 -  Call VisFileCopy(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf, sODBCDir
     || '\\ArchivNO\\' || dfFile)
.head 7 +  If File(sODBCDir || '\\ArchivNO\\' || dfFile)
.head 8 -  Call VisFileDelete(sODBCDir || '\\' || dfFile)
.head 8 -  Call VisFileDelete(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf)
.head 8 -  Call FileZNListBox()
.head 6 +  Else
.head 7 -  Call VisFileCopy(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf, sODBCDir     || '\\' || dfFile)
.head 7 +  If File(sODBCDir || '\\' || dfFile)
.head 8 -  Call VisFileDelete(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf)
.head 6 -  Return FALSE
.head 5 +  Else
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  ! записать в архив OK и удалить
.head 6 +  If VisMessageBox('ВНИМАНИЕ ! Файл ' || dfFile ||
   ' обработан. Записать в АРХИВ(Ok) ?', 'ЗАПРОС', MBF_IconQuestion,   hBtns, 2) = 1 ! ID_Yes
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  Call SalFileCreateDirectory(sODBCDir || '\\ArchivOK')
.head 7 -  Call VisFileCopy(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf, sODBCDir
     || '\\ArchivOK\\' || dfFile)
.head 7 +  If File(sODBCDir || '\\ArchivOK\\' || dfFile)
.head 8 -  Call VisFileDelete(sODBCDir || '\\' || dfFile)
.head 8 -  Call VisFileDelete(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf)
.head 8 -  Call FileZNListBox()
.head 6 +  Else
.head 7 -  Call VisFileCopy(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf, sODBCDir     || '\\' || dfFile)
.head 7 +  If File(sODBCDir || '\\' || dfFile)
.head 8 -  Call VisFileDelete(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf)
.head 7 -  Return FALSE
.head 6 -  Call SalWaitCursor(TRUE)
.head 5 -  Call SalSetFocus(tbl1)
.head 5 -  Call VisTblAutoSizeColumn(tbl1, hWndNULL)
.head 5 -  Set nJur = nNewRow
.head 5 -  Return TRUE
.head 3 +  Function: Oplata1
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sNlsA
.head 5 -  String: sTmpS
.head 5 -  Date/Time: bfBD
.head 4 +  Actions
.head 5 -  Set sNls = SalStrTrimX(sNls)
.head 5 -  Set bfBD = dfBD
.head 5 +  If SalStrLength( sNls ) < 5 
.head 6 -  Return FALSE
.head 5 -  ! Преобразовать счет !
.head 5 -  Set sTmpS =
" SELECT Substr(vkrzn( '" || MFO5 ||"', nlsg||'" || fMFO ||"' ),1,14)
  INTO :sNlsA FROM nal_dec3 
  WHERE '"||sNls||"' like substr(nls,1,4)||'_'||substr(nls,6,9) and nls is not null "
.head 5 +  If SqlPrepareAndExecute( hSql(),sTmpS ) and not SqlFetchNext( hSql(), nFetchRes )
.head 6 -  Return FALSE
.head 5 -  ! Перекодировка
.head 5 -  Set sNd   = SalStrTrimX(StrDosToWinX(sNd))
.head 5 -  Set sPlat = SalStrTrimX(StrDosToWinX(sPlat))
.head 5 -  Set sPolu = SalStrTrimX(StrDosToWinX(sPolu))
.head 5 -  Set sNaz1 = SalStrTrimX(StrDosToWinX(sNaz1))
.head 5 -  !
.head 5 -  Set nNewRow = SalTblInsertRow(tbl1, TBL_MaxRow)
.head 5 -  Call SalTblSetFocusRow(tbl1, nNewRow)
.head 5 -  Set tbl1.colNPP = nRecn
.head 5 -  Set tbl1.colND  = sNd
.head 5 -  Set tbl1.colNLSA = sNlsA
.head 5 -  Set tbl1.colNAMA = sPlat
.head 5 -  Set tbl1.colNAMB = sPolu
.head 5 -  Set tbl1.colFA = dfFile
.head 5 -  Set tbl1.colS = nS/100
.head 5 -  Set tbl1.colNAZN = sNaz1
.head 5 -  Set tbl1.colREF98 = nRef99bm
.head 5 -  Call SalTblSetRowFlags(tbl1, nNewRow, ROW_Edited | ROW_New, FALSE)
.head 5 +  If nNm=1 and nSos=0 and nS>0 
.head 6 -  ! --------------------------------------------
.head 6 -  Set nRef = NUMBER_Null
.head 6 -  Call VisTblSetRowColor(tbl1, nNewRow, COLOR_Blue)
.head 6 -  ! Оплата
.head 6 -  Call ccDoc.SetDoc(0, 'PO3', nDk, 6, sNd, bfBD, bfBD, bfBD, bfBD,
     sNlsA, sPlat, aMFO, '', 980, nS, STRING_Null,
     sNlsk, sPolu, aMFO, '', 980, nS, STRING_Null, sNaz1, STRING_Null, 
     GetIdOper(), '', NUMBER_Null,  0)
.head 6 -  Set dfAll = dfAll + 1
.head 6 +  If ccDoc.oDoc()
.head 7 +  If SqlPrepareAndExecute(hSqlB, "
   UPDATE " || Left(sTempDbf, Len(sTempDbf)-4) || " SET sos=9
   WHERE CURRENT OF " || Left(sTempDbf, Len(sTempDbf)-4))
.head 8 -  Call SqlCommit(hSql())
.head 8 -  Set Kol_PAY = Kol_PAY + 1
.head 8 -  Set tbl1.colREF98 = ccDoc.m_nRef
.head 8 -  Call VisTblSetRowColor(tbl1, nNewRow, COLOR_DarkGreen)
.head 8 -  Set dfCurrent = dfCurrent + 1
.head 8 +  If Mod(n99, 10) = 0
.head 9 -  Call SqlPrepareAndExecute(hSqlB, "
     UPDATE " || Left(sTempDbf, Len(sTempDbf)-4) || "
     SET sos=9,ref99bm=:ccDoc.m_nRef
     WHERE CURRENT OF " ||
           Left(sTempDbf, Len(sTempDbf)-4))
.head 7 +  Else
.head 8 -  Call SaveInfoToLog('ошибка UPDATE '||Left(sTempDbf,Len(sTempDbf)-4) ||' SET sos=9 '||sNls )
.head 8 -  Call SqlRollback(hSql())
.head 6 +  Else
.head 7 -  Call SaveInfoToLog('ошибка при оплате ' || sNlsA )
.head 7 -  Call SqlRollback(hSql())
.head 5 -  Call SalTblSetCellTextColor(tbl1.colNPP, COLOR_Charcoal, TRUE)
.head 5 -  Set nPos = nPos + nDelta
.head 5 -  Set nRecn = nRecn + 1
.head 5 +  If Int(nPos) != nTek
.head 6 -  Set nTek = Int(nPos)
.head 6 -  Set nTimeCurrent = SalDateHour(SalDateCurrent())*3600 + SalDateMinute(
    SalDateCurrent())*60 + SalDateSecond(SalDateCurrent())
.head 6 -  Set nTimeEnd = Int(100 * (nTimeCurrent-nTimeStart) / nPos +
    nTimeStart)
.head 6 -  Set nHour = Int(nTimeEnd/3600)
.head 6 -  Set nTemp = nTimeEnd - nHour*3600
.head 6 -  Set nMinu = Int(nTemp/60)
.head 6 -  Set dfStart = dfStart
.head 6 -  Set dfEnd = 'Финиш: ' || Right(Str(100+nHour), 2) || ':' || Right(
    Str(100+nMinu), 2) || ':' || Right(Str(100+nTemp-nMinu*60), 2) ||
    ' (прогноз)'
.head 6 -  Set dfReccount = dfReccount
.head 6 -  Set dfCurrent = dfCurrent
.head 6 -  Set dfAll = dfAll
.head 5 -  Call ccProgressBar.SetProgress(nPos)
.head 5 -  Call SalUpdateWindow(hWndForm)
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  Date/Time: DAT_FORM
.head 3 -  Date/Time: DAT_BEG
.head 3 -  Date/Time: DAT_END 
.head 3 -  Date/Time: DAT_END_OLD
.head 3 -  String: aMFO
.head 3 -  String: MFO5
.head 3 -  String: fMFO
.head 3 -  String: sMD
.head 3 -  String: sErr
.head 3 -  String: FN
.head 3 -  String: FN_tmp
.head 3 -  Number: Kol_dney
.head 3 -  Number: Kol_PAY
.head 3 -  : ccDoc
.head 4 -  Class: cDoc
.head 3 -  Number: nNm
.head 3 -  Number: nDk
.head 3 -  String: sNd
.head 3 -  String: sNls
.head 3 -  String: sNlsk
.head 3 -  Number: nS
.head 3 -  String: sPlat
.head 3 -  String: sPolu
.head 3 -  String: sNaz1
.head 3 -  Number: nRow
.head 3 -  Number: nRef
.head 3 -  Number: nRef99bm
.head 3 -  Number: nSos
.head 3 -  String: sTmp
.head 3 -  Number: nCount 
.head 3 -  Number: nNewRow
.head 3 -  Sql Handle: hSqlA
.head 3 -  Sql Handle: hSqlB
.head 3 -  Number: nPos
.head 3 -  Number: nDelta
.head 3 -  Number: nRecCount
.head 3 -  String: strMessage
.head 3 -  String: sODBCDir
.head 3 -  Number: n99
.head 3 -  Number: nTimeStart
.head 3 -  Number: nTimeCurrent
.head 3 -  Number: nTimeEnd
.head 3 -  Number: nHour
.head 3 -  Number: nMinu
.head 3 -  Number: nTemp
.head 3 -  Number: nTek
.head 3 -  Number: nRecn
.head 3 -  Number: nCurrentRow
.head 3 -  Number: nP
.head 3 -  Number: nItog
.head 3 -  File Handle: hF
.head 3 -  Number: nColor
.head 3 -  String: sBuff
.head 3 -  String: sFr
.head 3 -  String: sLev
.head 3 -  Date/Time: dTempDate
.head 3 -  Number: hBtnYes
.head 3 -  Number: hBtnNo
.head 3 -  Number: hBtns[*]
.head 3 -  Number: nJur
.head 3 -  String: sTempDbf
.head 3 -  !
.head 3 -  String: sSelectOper
.head 3 -  !
.head 3 -  Number: i
.head 3 -  String: msSimv[33]
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set aMFO = GetBankMfo()
.head 4 -  Set MFO5 = Subs(aMFO,1,5)
.head 4 -  Set sNlsk = Vkrz2( aMFO, '81990')  
.head 4 -  Set dfBD =  GetBankDate()
.head 4 -  Call ConPara('PUSH')
.head 4 -  Set hBtnYes = VisMessageLoadButton('&Да', 1)
.head 4 -  Set hBtnNo = VisMessageLoadButton('&Нет', 2)
.head 4 -  Call VisMessageSetBkgdColor(COLOR_Salmon)
.head 4 -  Set hBtns[0] = hBtnYes | MBF_DefButton
.head 4 -  Set hBtns[1] = hBtnNo
.head 4 -  Call SalUseRegistry(FALSE, '')
.head 4 -  Call SalGetProfileString('Import', 'MoperPath', SalStrLeftX(SalFileGetDrive(), 1) ||
     ':\\BARS98\\ODBC.DSN\\Moper', sODBCDir, GetIniFileName())
.head 4 -  !
.head 4 -  Call FileZNListBox()
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Call SalHideWindow(dfStart)
.head 4 -  Call SalHideWindow(dfEnd)
.head 4 -  Call SalSetFocus(pbExit)
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_Destroy
.head 4 -  Call ConPara('POP')
.head 4 -  Call SalWaitCursor(FALSE)
.head 1 -  ! Закомментировано 03.03.2014
.head 1 +  ! Dialog Box: dlg_Connect
.winattr
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Подключение к Базе Данных ОДБ
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  5.7"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 2.024"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.end
.head 2 -  Description: 
.head 2 +  Tool Bar 
.winattr
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
.end
.head 3 -  Contents 
.head 2 +  Contents 
.head 3 +  Pushbutton: pbCancel
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отмена
.head 4 -  Window Location and Size
.head 5 -  Left:   4.067"
.head 5 -  Top:    0.881"
.head 5 -  Width:  1.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Magenta
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 4 +  Message Actions 
.head 5 +  On SAM_Click
.head 6 -  Call SalDestroyWindow( dlg_Connect )
.head 6 -  Set bFlagABS=0
.head 3 +  Pushbutton: pbOk
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Да
.head 4 -  Window Location and Size
.head 5 -  Left:   2.617"
.head 5 -  Top:    0.881"
.head 5 -  Width:  1.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.44"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Magenta
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 4 +  Message Actions 
.head 5 +  On SAM_Click
.head 6 -  Set SqlDatabase = dDataBase
.head 6 -  Call WaitCursorOn()
.head 6 +  When SqlError
.head 7 -  Call WaitCursorOff()
.head 7 -  Set bFlagABS=0
.head 7 -  ! Call SalMessageBox( 'Возникла ошибка при подключеннии ...', 'Ошибка ...',  MB_Ok )
.head 7 -  Return FALSE
.head 6 +  If nUseGateway  ! логиниться через шлюз
.head 7 -  ! Call SalMessageBox( ' nUseGateway ',MSG_Attention(), MB_Ok)
.head 7 +  If GateLogin(dUserName, dPassword, szOraUser, szOraPassword) = FALSE
.head 8 -  ! Call SalMessageBox( 'Not GateLogin' , 'Параметры ... ', 0 )
.head 8 -  Set bFlagABS=0
.head 8 -  Call WaitCursorOff()
.head 8 -  Set nConnectError = SqlError( hSqlABS )
.head 8 +  ! If nConnectError = 21017
.head 9 -           Call SalMessageBox( MSG_NoConnectDbs() ||' Неверное рабочее имя или пароль. [Error #21017]',MSG_Attention(), MB_Ok)
.head 8 +  ! Else
.head 9 -           Call SalMessageBox(MSG_NoConnectDbs() ,MSG_Attention(), MB_Ok)
.head 8 -  Return 0
.head 7 +  Else 
.head 8 -  ! Call SalMessageBox( 'GateLogin' , 'Параметры ... ', 0 )
.head 8 -  Set SqlUser = szOraUser
.head 8 -  Set SqlPassword = szOraPassword
.head 6 +  Else 
.head 7 -  ! Call SalMessageBox( ' !!! no nUseGateway ',MSG_Attention(), MB_Ok)
.head 7 -  Set SqlUser = dUserName
.head 7 -  Set SqlPassword = dPassword
.head 6 +  If SqlConnect( hSqlABS )
.head 7 -  Set sSqlOut =''
.head 7 -  Set sSqlAll =''
.head 7 -  Set sSqlAllN =''
.head 7 +  If rbBii and SalStrTrimX( dfBi ) != ''
.head 8 -  Call ABSSqlLike(SalStrTrimX( dfBi ),' LIKE ', ' OR ',sSqlOut)
.head 8 +  If SalStrLength( sSqlOut )>0
.head 9 -  Set sSqlAll   = sSqlAll   || sSqlOut
.head 7 +  If rbBoo and SalStrTrimX( dfBo ) != ''
.head 8 -  Call ABSSqlLike(SalStrTrimX( dfBo ),' NOT  LIKE ',' AND ',sSqlOut)
.head 8 +  If SalStrLength( sSqlOut )>0
.head 9 -  Set sSqlAllN   = sSqlAllN   || sSqlOut
.head 7 +  If sSqlAll   !='' or sSqlAllN   !=''
.head 8 -  Set sSqlAll   = IifS(sSqlAll    !='' ," ( "||SalStrMidX( sSqlAll   , 4, SalStrLength( sSqlAll    ))||" ) " ,'')||
                       IifS( ( sSqlAll !='' and rbBii ) and ( sSqlAllN    !='' and rbBoo ),' and ','')||
                       IifS(sSqlAllN !='' ," ( "||SalStrMidX( sSqlAllN, 5, SalStrLength( sSqlAllN  ))||" ) " ,'')
.head 7 +  If sSqlAll   !=''
.head 8 -  Set sSqlOut = ' AND ' || IifS( sSqlAll   !=''," ( "|| sSqlAll ||" ) ",'')
.head 7 +  If cbAll
.head 8 -  Set sAllNLS=''
.head 7 +  Else 
.head 8 +  If rbDates
.head 9 -  Set dDateStart = dfDbeg
.head 9 -  Set dDateEnd = dfDend
.head 8 +  Else 
.head 9 -  Set dDateStart = SalDateQuarterBegin(SalDateConstruct(dfGod, dfKw*3, 1, 0, 0, 0))
.head 9 -  Set dDateEnd = SalDateQuarterBegin(SalDateConstruct(dfGod, dfKw*3, 1, 0, 0, 0) + 92) - 1
.head 8 -  Set sAllNLS = 'daos between :dDateStart and :dDateEnd and '
.head 7 +  If SqlPrepareAndExecute( hSqlABS, "
    select distinct nls,nms
    INTO :sNLS,:sNMS
     from accounts
     where "||sAllNLS||" kv=980
                   "||sSqlOut )
.head 8 -  Set nABSNext = 1
.head 8 +  While SqlFetchNext( hSqlABS,  nFetchRes )
.head 9 -  Set sNLSA[ nABSNext ] = sNLS
.head 9 -  Set sNMSA[ nABSNext ] = SalStrLeftX(sNMS,38)
.head 9 -  Set nABSNext = nABSNext + 1
.head 8 +  While nABSNext>1
.head 9 -  Set nABSNext = nABSNext - 1
.head 9 -  Call SqlPrepareAndExecute( hSql(),"
select nls
into :sNLS
from sbu
where nls=:sNLSA[ nABSNext ] and rnk= :sRnk")
.head 9 +  If not SqlFetchNext( hSql(),  nFetchRes )
.head 10 +  If SqlPrepareAndExecute( hSql(),"
insert into sbu (nls,nms,rnk)
values  ( :sNLSA[ nABSNext ] ,:sNMSA[ nABSNext ], :sRnk )")
.head 11 -  Call SqlCommit( hSql() )
.head 10 +  Else 
.head 11 -  Call SqlRollback( hSql() )
.head 7 -  ! ----------------------------------------------------------------  sRnk
.head 7 -  Set bFlagABS=1
.head 7 -  Call SqlDisconnect( hSqlABS )
.head 7 -  Call WaitCursorOff()
.head 7 -  Call SalDestroyWindow( dlg_Connect )
.head 6 +  Else 
.head 7 -  Set bFlagABS=0
.head 7 -  Call WaitCursorOff()
.head 7 -  Set nConnectError = SqlError( hSqlABS )
.head 7 +  If nConnectError = 21017
.head 8 -  Call SalMessageBox( MSG_NoConnectDbs() ||' Неверное рабочее имя или пароль. [Error #21017]',MSG_Attention(), MB_Ok)
.head 7 +  Else 
.head 8 -  Call SalMessageBox(MSG_NoConnectDbs() ,MSG_Attention(), MB_Ok)
.head 3 -  Background Text: База Данных
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.267"
.head 5 -  Top:    0.083"
.head 5 -  Width:  1.167"
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
.end
.head 3 -  Background Text: Пользователь
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.217"
.head 5 -  Top:    0.357"
.head 5 -  Width:  1.217"
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
.end
.head 3 -  Background Text: Пароль
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.75"
.head 5 -  Top:    0.595"
.head 5 -  Width:  0.683"
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
.end
.head 3 +  Data Field: dDataBase
.winattr
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
.head 6 -  Left:   3.467"
.head 6 -  Top:    0.048"
.head 6 -  Width:  2.017"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Uppercase
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.end
.head 4 +  Message Actions 
.head 5 +  On SAM_AnyEdit
.head 6 +  If Len(SalStrTrimX(dDataBase))*Len(SalStrTrimX(dUserName))*
   Len(SalStrTrimX(dPassword)) = 0
.head 7 -  Call SalDisableWindow(pbOk)
.head 6 +  Else 
.head 7 -  Call SalEnableWindow(pbOk)
.head 3 +  Data Field: dUserName
.winattr
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
.head 6 -  Left:   3.467"
.head 6 -  Top:    0.321"
.head 6 -  Width:  2.017"
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
.end
.head 4 +  Message Actions 
.head 5 +  On SAM_AnyEdit
.head 6 +  If Len(SalStrTrimX(dDataBase))*Len(SalStrTrimX(dUserName))*
   Len(SalStrTrimX(dPassword)) = 0
.head 7 -  Call SalDisableWindow(pbOk)
.head 6 +  Else 
.head 7 -  Call SalEnableWindow(pbOk)
.head 3 +  Data Field: dPassword
.winattr
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
.head 6 -  Left:   3.467"
.head 6 -  Top:    0.56"
.head 6 -  Width:  2.017"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Invisible
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.end
.head 4 +  Message Actions 
.head 5 +  On SAM_AnyEdit
.head 6 +  If Len(SalStrTrimX(dDataBase))*Len(SalStrTrimX(dUserName))*
   Len(SalStrTrimX(dPassword)) = 0
.head 7 -  Call SalDisableWindow(pbOk)
.head 6 +  Else 
.head 7 -  Call SalEnableWindow(pbOk)
.head 3 +  Pushbutton: pbF11
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.3"
.head 5 -  Top:    0.667"
.head 5 -  Width:  0.517"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.298"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: F11
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 4 +  Message Actions 
.head 5 +  On SAM_Click
.head 6 -  Call SalEnableWindow( dDataBase )
.head 6 -  Call SalSetFocus( dDataBase )
.head 3 +  Pushbutton: pbF12
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.467"
.head 5 -  Top:    0.381"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.298"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: F12
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 4 +  Message Actions 
.head 5 +  On SAM_Click
.head 6 -  Set dUserName='BARS'
.head 6 -  Set dPassword='BARS'
.head 6 -  Call SalSendMsg( pbOk, SAM_Click , 0, 0 )
.head 3 +  Picture: pic1
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.033"
.head 5 -  Top:    0.012"
.head 5 -  Width:  2.1"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.333"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  File Name: IP_Z.BMP
.head 4 -  Storage: External
.head 4 -  Picture Transparent Color: None
.head 4 -  Fit: Scale
.head 4 -  Scaling
.head 5 -  Width:  100
.head 5 -  Height:  100
.head 4 -  Corners: Square
.head 4 -  Border Style: Solid
.head 4 -  Border Thickness: 1
.head 4 -  Tile To Parent? No
.head 4 -  Border Color: Default
.head 4 -  Background Color: Default
.end
.head 4 -  Message Actions 
.head 3 -  Frame 
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.183"
.head 5 -  Top:    0.012"
.head 5 -  Width:  3.367"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.845"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 3
.head 4 -  Border Color: Default
.head 4 -  Background Color: Default
.end
.head 3 +  Pushbutton: pbExport
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Параметры отбора бал. счетов  >>
.head 4 -  Window Location and Size
.head 5 -  Left:   0.083"
.head 5 -  Top:    1.405"
.head 5 -  Width:  5.4"
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
.end
.head 4 +  Message Actions 
.head 5 +  On SAM_Click
.head 6 +  If bFlagSize
.head 7 -  Call SalSetWindowSize( dlg_Connect ,5.7 ,4.381 )
.head 7 -  Call SalSetWindowText( pbExport, 'Параметры отбора бал. счетов   <<' )
.head 7 -  Set bFlagSize = FALSE
.head 6 +  Else 
.head 7 -  Call SalSetWindowSize( dlg_Connect ,5.7 ,2.012  )
.head 7 -  Call SalSetWindowText( pbExport, 'Параметры отбора бал. счетов  >>' )
.head 7 -  Set bFlagSize = TRUE
.head 3 +  Data Field: dfBi
.winattr
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
.head 6 -  Left:   2.083"
.head 6 -  Top:    3.119"
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
.end
.head 4 +  Message Actions 
.head 5 +  On SAM_AnyEdit
.head 6 -  Call SalEnableWindow( pbSave )
.head 3 +  Data Field: dfBo
.winattr
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
.head 6 -  Left:   2.083"
.head 6 -  Top:    3.405"
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
.end
.head 4 +  Message Actions 
.head 5 +  On SAM_AnyEdit
.head 6 -  Call SalEnableWindow( pbSave )
.head 3 -  Frame 
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.083"
.head 5 -  Top:    1.738"
.head 5 -  Width:  5.5"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 2.333"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: Default
.head 4 -  Background Color: Default
.end
.head 3 +  Check Box: rbBii
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Включать бал.сч
.head 4 -  Window Location and Size
.head 5 -  Left:   0.183"
.head 5 -  Top:    3.155"
.head 5 -  Width:  1.9"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 4 +  Message Actions 
.head 5 +  On SAM_Click
.head 6 -  Call SalEnableWindow( pbSave )
.head 3 +  Check Box: rbBoo
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Исключать бал.сч
.head 4 -  Window Location and Size
.head 5 -  Left:   0.183"
.head 5 -  Top:    3.405"
.head 5 -  Width:  1.9"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 4 +  Message Actions 
.head 5 +  On SAM_Click
.head 6 -  Call SalEnableWindow( pbSave )
.head 3 +  Pushbutton: pbSave
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сохранить
.head 4 -  Window Location and Size
.head 5 -  Left:   3.283"
.head 5 -  Top:    3.679"
.head 5 -  Width:  2.2"
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
.end
.head 4 +  Message Actions 
.head 5 +  On SAM_Click
.head 6 -  Call SalUseRegistry(TRUE, GetCompanyName())
.head 6 -  Call SalSetProfileString('NalUch', 'BalAccVkl', dfBi, GetIniFileName())
.head 6 -  Call SalSetProfileString('NalUch', 'BalAccIsk', dfBo, GetIniFileName())
.head 6 -  Call SalUseRegistry(FALSE, '')
.head 6 -  Call SalSetProfileString('NalUch', 'BalAccBii', IifS(rbBii=0, '0', '1'), GetIniFileName())
.head 6 -  Call SalSetProfileString('NalUch', 'BalAccBoo', IifS(rbBoo=0, '0', '1'), GetIniFileName())
.head 6 -  Call SalDisableWindow(pbSave)
.head 3 -  Background Text: Дата отчетного периода
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.283"
.head 5 -  Top:    1.929"
.head 5 -  Width:  3.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.226"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Charcoal
.head 4 -  Background Color: Default
.end
.head 3 +  Data Field: dfBD
.winattr
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
.head 6 -  Left:   3.483"
.head 6 -  Top:    1.857"
.head 6 -  Width:  1.9"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.333"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Date
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 12
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Burgundy
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.end
.head 4 +  Message Actions 
.head 5 +  On SAM_Validate
.head 6 +  If dfBD > dBankDate
.head 7 -  Call MessageNoWait('Локальная дата не может быть больше текущей даты !', 'ОШИБКА',
     30, 1)
.head 7 -  Return VALIDATE_Cancel
.head 6 -  Call SalSendMsg(dfGod, SAM_Create, 0, 0)
.head 6 -  Call SalSendMsg(dfKw, SAM_Create, 0, 0)
.head 6 -  Call SalSendMsg(dfDbeg, SAM_Create, 0, 0)
.head 6 -  Call SalSendMsg(dfDend, SAM_Create, 0, 0)
.head 3 +  Radio Button: rbGodKw
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Год, квартал
.head 4 -  Window Location and Size
.head 5 -  Left:   0.383"
.head 5 -  Top:    2.488"
.head 5 -  Width:  1.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 4 +  Message Actions 
.head 5 +  On SAM_Click
.head 6 -  Call SalDisableWindow(dfDbeg)
.head 6 -  Call SalDisableWindow(dfDend)
.head 6 -  Call SalEnableWindow(dfGod)
.head 6 -  Call SalEnableWindow(dfKw)
.head 3 +  Radio Button: rbDates
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Интервал дат
.head 4 -  Window Location and Size
.head 5 -  Left:   0.383"
.head 5 -  Top:    2.738"
.head 5 -  Width:  1.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 4 +  Message Actions 
.head 5 +  On SAM_Click
.head 6 -  Call SalEnableWindow(dfDbeg)
.head 6 -  Call SalEnableWindow(dfDend)
.head 6 -  Call SalDisableWindow(dfGod)
.head 6 -  Call SalDisableWindow(dfKw)
.head 3 +  Data Field: dfGod
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 4
.head 5 -  Data Type: Number
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.483"
.head 6 -  Top:    2.488"
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
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Dark Blue
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.end
.head 4 +  Message Actions 
.head 5 +  On SAM_Create
.head 6 -  Set dfGod = SalDateYear(dfBD-1)
.head 5 +  On SAM_Validate
.head 6 +  If dfGod < SalDateYear(dfBD-1)-3 or dfGod > SalDateYear(dfBD) or
   (dfGod = SalDateYear(dfBD-1) and dfKw > SalDateQuarter(dfBD-1))
.head 7 -  Call MessageNoWait('Недопустимое сочетание года и номера квартала.', 'ОШИБКА', 30,
     1)
.head 7 -  Return VALIDATE_Cancel
.head 6 +  Else 
.head 7 -  Call SetDbegDend(dfGod, dfKw)
.head 3 +  Data Field: dfKw
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 1
.head 5 -  Data Type: Number
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.983"
.head 6 -  Top:    2.488"
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
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Midnight Blue
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.end
.head 4 +  Message Actions 
.head 5 +  On SAM_Create
.head 6 -  Set dfKw = SalDateQuarter(dfBD-1)
.head 5 +  On SAM_Validate
.head 6 +  If dfKw < 1 or dfKw > 4 or (dfGod = SalDateYear(dfBD-1) and
   dfKw > SalDateQuarter(dfBD-1))
.head 7 -  Call MessageNoWait('Недопустимый номер квартала.', 'ОШИБКА', 30, 1)
.head 7 -  Return VALIDATE_Cancel
.head 6 +  Else 
.head 7 -  Call SetDbegDend(dfGod, dfKw)
.head 3 +  Data Field: dfDbeg
.winattr
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
.head 6 -  Left:   2.483"
.head 6 -  Top:    2.738"
.head 6 -  Width:  1.4"
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
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.end
.head 4 +  Message Actions 
.head 5 +  On SAM_Create
.head 6 -  Set dTemp = SalDateQuarterBegin(dfBD-1)
.head 6 -  Set dfDbeg = IifD(dTemp > dfBD, dfBD, dTemp)
.head 5 +  On SAM_Validate
.head 6 +  If dfDbeg > dfBD
.head 7 -  Call MessageNoWait('Даты ("Интервал дат") не должны превышать текущей даты.',
     'ОШИБКА', 30, 1)
.head 7 -  Return VALIDATE_Cancel
.head 6 +  Else 
.head 7 -  Set dfGod = SalDateYear(dfDbeg)
.head 7 -  Set dfKw = SalDateQuarter(dfDbeg)
.head 5 +  On SAM_KillFocus
.head 6 -  Call SalSetFocus(dfDend)
.head 6 -  Call SalSetFieldEdit(dfDend, TRUE)
.head 3 +  Data Field: dfDend
.winattr
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
.head 6 -  Left:   3.983"
.head 6 -  Top:    2.738"
.head 6 -  Width:  1.4"
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
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.end
.head 4 +  Message Actions 
.head 5 +  On SAM_Create
.head 6 -  Set dTemp = SalDateQuarterBegin(dfBD+91) - 1
.head 6 -  Set dfDend = IifD(dTemp > dfBD, dfBD, dTemp)
.head 5 +  On SAM_Validate
.head 6 +  If dfDend > dfBD or dfDbeg > dfDend or
   SalDateQuarter(dfDbeg) != SalDateQuarter(dfDend) or dfDbeg > dfBD
.head 7 -  Call MessageNoWait(IifS(dfDbeg>dfDend, 'Вторая дата не может быть меньше первой.',
     'Даты ("Интервал дат") ' || IifS(dfDend>dfBD,
     'не должны превышать текущей даты.',
     'должны находиться в пределах одного квартала.')), 'ОШИБКА', 30, 1)
.head 7 -  Return VALIDATE_Cancel
.head 6 +  Else 
.head 7 -  Set dfGod = SalDateYear(dfDend)
.head 7 -  Set dfKw = SalDateQuarter(dfDend)
.head 3 -  Frame 
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.183"
.head 5 -  Top:    1.821"
.head 5 -  Width:  5.3"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Solid
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: Default
.head 4 -  Background Color: Default
.end
.head 3 +  Check Box: cbAll
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Весь период работы банка
.head 4 -  Window Location and Size
.head 5 -  Left:   0.383"
.head 5 -  Top:    2.238"
.head 5 -  Width:  4.9"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 4 +  Message Actions 
.head 5 +  On SAM_Click
.head 6 +  If cbAll
.head 7 -  Call SalDisableWindow(rbGodKw)
.head 7 -  Call SalDisableWindow( rbDates)
.head 7 -  Call SalDisableWindow(dfDbeg)
.head 7 -  Call SalDisableWindow(dfDend)
.head 7 -  Call SalDisableWindow(dfGod)
.head 7 -  Call SalDisableWindow(dfKw)
.head 6 +  Else 
.head 7 -  Call SalEnableWindow(rbGodKw)
.head 7 -  Call SalEnableWindow( rbDates)
.head 7 +  If rbGodKw
.head 8 -  Call SalSendMsg( dlg_Connect.rbGodKw,SAM_Click, 0, 0 )
.head 7 +  Else 
.head 8 -  Call SalSendMsg( dlg_Connect.rbDates,SAM_Click, 0, 0 )
.head 2 +  Functions 
.head 3 +  Function: SetDbegDend
.head 4 -  Description: 
.head 4 -  Returns 
.head 4 +  Parameters 
.head 5 -  Number: nGod
.head 5 -  Number: nKw
.head 4 -  Static Variables 
.head 4 -  Local variables 
.head 4 +  Actions 
.head 5 -  Set dfDbeg = SalDateQuarterBegin(SalDateConstruct(nGod, nKw*3, 1, 0, 0, 0))
.head 5 -  Set dfDend = SalDateQuarterBegin(SalDateConstruct(nGod, nKw*3, 1, 0, 0, 0) + 92) - 1
.head 3 +  Function: ABSSqlLike
.head 4 -  Description: 
.head 4 -  Returns 
.head 4 +  Parameters 
.head 5 -  String: sSqlInABS
.head 5 -  String: sSqlInNotABS
.head 5 -  String: sOrAnd
.head 5 -  Receive String: sOut
.head 4 -  Static Variables 
.head 4 +  Local variables 
.head 5 -  String: sSqlOutABS
.head 4 +  Actions 
.head 5 +  While not SalStrLength( sSqlInABS )=0
.head 6 +  If SalStrScan( sSqlInABS , ',' ) = -1
.head 7 -  Set sSqlOutABS  =   sSqlOutABS  || sOrAnd ||" NLS"||sSqlInNotABS||"'"||SalStrTrimX(sSqlInABS)||"%' "
.head 7 -  Set sSqlInABS = ''
.head 6 +  Else 
.head 7 +  If SalStrTrimX(SalStrMidX( sSqlInABS, 0, SalStrScan( sSqlInABS , ',' ))) !=''
.head 8 -  Set sSqlOutABS   =  sSqlOutABS  || sOrAnd ||" NLS"||sSqlInNotABS||"'"||SalStrTrimX( SalStrMidX( sSqlInABS, 0, SalStrScan( sSqlInABS , ',' )))||"%' "
.head 8 -  Set sSqlInABS = SalStrMidX( sSqlInABS, SalStrScan( sSqlInABS , ',' )+1,SalStrLength( sSqlInABS ))
.head 7 +  Else 
.head 8 -  Set sSqlInABS = SalStrMidX( sSqlInABS, SalStrScan( sSqlInABS , ',' )+1,SalStrLength( sSqlInABS ))
.head 5 -  Set sOut   = sSqlOutABS
.head 2 -  Window Parameters 
.head 2 +  Window Variables 
.head 3 -  String: strErrorText
.head 3 -  Number: nConnectError
.head 3 -  String: sBii
.head 3 -  String: sBoo
.head 3 -  Boolean: bFlagSize
.head 3 -  String: sBalAcc
.head 3 -  String: sFlagSize
.head 3 -  Date/Time: dTemp
.head 3 -  Date/Time: dBankDate
.head 3 -  String: sSqlOut
.head 3 -  String: sSqlOut1
.head 3 -  String: sSqlAll
.head 3 -  String: sSqlAll1
.head 3 -  String: sSqlAllN
.head 3 -  String: sSqlAllN1
.head 3 -  Date/Time: dDateStart
.head 3 -  Date/Time: dDateEnd
.head 3 -  String: sNLS
.head 3 -  String: sNLSA[*]
.head 3 -  String: sNMS
.head 3 -  String: sNMSA[*]
.head 3 -  Number: nABSNext
.head 3 -  String: sAllNLS
.head 3 -  Number: nInitCounter
.head 3 -  Number: nRes
.head 3 -  Number: nUseGateway
.head 3 -  String: szOraUser
.head 3 -  String: szOraPassword
.head 2 +  Message Actions 
.head 3 +  On SAM_Create
.head 4 -  Set dBankDate = GetBankDate()
.head 4 -  Set dfBD = dBankDate
.head 4 -  Call SalUseRegistry(FALSE, '')
.head 4 -  Call SalGetProfileString('NalUch', 'BalAccBii',    '0', sBii, GetIniFileName())
.head 4 -  Call SalGetProfileString('NalUch', 'BalAccBoo',   '0', sBoo, GetIniFileName())
.head 4 -  Call SalGetProfileString('Import', 'BalAcc', '99999999999999', sBalAcc, GetIniFileName())
.head 4 -  Call SalUseRegistry(TRUE, GetCompanyName())
.head 4 -  Call SalGetProfileString('NalUch', 'BalAccVkl', sBalAcc, dfBi, GetIniFileName())
.head 4 -  Call SalGetProfileString('NalUch', 'BalAccIsk', '99999999999999', dfBo, GetIniFileName())
.head 4 -  Set rbBii = SalStrToNumber( sBii )
.head 4 -  Set rbBoo = SalStrToNumber( sBoo )
.head 4 -  Call SalUseRegistry(TRUE, GetDBMS())
.head 4 -  Call SalGetProfileString(GetHost(), "USERABS", GetUserLoginName(), dUserName, "netrc")
.head 4 -  Call SalGetProfileString(GetHost(), 'FlagSize', '0', sFlagSize, "netrc")
.head 4 -  Call SalUseRegistry(FALSE, GetCompanyName())
.head 4 -  Call SalCenterWindow(dlg_Connect)
.head 4 -  Set dDataBase=sABSDataBase
.head 4 -  Call SalDisableWindow(pbOk)
.head 4 -  Set bFlagABS=0
.head 4 -  ! Set bFlagSize = TRUE
.head 4 -  Set bFlagSize = SalStrToNumber( sFlagSize )
.head 4 -  Call SalSendMsg( pbExport, SAM_Click, 0, 0 )
.head 4 -  Call SalDisableWindow( pbSave )
.head 4 -  Call SalDisableWindow( dfDbeg )
.head 4 -  Call SalDisableWindow( dfDend )
.head 4 +  If dUserName = ''
.head 5 -  Call SalSetFocus( dUserName )
.head 4 +  Else 
.head 5 -  Call SalSetFocus( dPassword )
.head 4 -  Set nUseGateway = SalGetProfileInt(INI_CommonParameters, 'UseGateway', 0, GetIniFileName())
.head 4 -  ! Call SalMessageBox( SalNumberToStrX( nUseGateway ,0), 'Параметры ... ', 4 )
.head 4 +  If nUseGateway            ! логиниться через шлюз
.head 5 +  ! If GateParams(dDataBase)
.head 6 -  ! Call SalMessageBox( 'Применение парамметров прошло успешно', 'Параметры ... ', 4 )
.head 5 +  ! Else
.head 6 -  Call SalDestroyWindow( dlg_Connect )
.head 6 -  Set bFlagABS=0
.head 3 +  On SAM_Destroy
.head 4 +  If dUserName != ''
.head 5 -  Call SalSetProfileString(GetHost(), "USERABS", dUserName, "netrc")
.head 4 -  Call SalSetProfileString(GetHost(), 'FlagSize', IifS( bFlagSize,'0','1' ), "netrc")
.head 4 -  Call SalWaitCursor( FALSE )
.head 1 +  Table Window: TB3
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Построение связи финансового и управленческого учета
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
.head 4 -  Left:   0.45"
.head 4 -  Top:    0.625"
.head 4 -  Width:  13.471"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 6.375"
.head 4 -  Height Editable? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: 8
.head 3 -  Font Enhancement: Class Default
.head 3 -  Text Color: Black
.head 3 -  Background Color: Default
.head 3 -  View: Table
.head 3 -  Allow Row Sizing? No
.head 3 -  Lines Per Row: Default
.head 2 -  Memory Settings
.head 3 -  Maximum Rows in Memory: 20000
.head 3 -  Discardable? No
.head 2 -  Description:
.head 2 -  Named Menus
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.406"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Class Default
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
.head 6 -  Left:   0.086"
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
.head 6 -  Left:   0.514"
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
.head 6 -  Left:   5.9"
.head 6 -  Top:    0.063"
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
.head 6 -  Left:   0.943"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Save.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 43063
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  5.857"
.head 6 -  Begin Y:  -0.01"
.head 6 -  End X:  5.857"
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
.head 6 -  Left:   1.529"
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
.head 6 -  Left:   1.957"
.head 6 -  Top:    0.073"
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
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Установить фильтр'
.head 4 +  Pushbutton: pbDetails
.head 5 -  Class Child Ref Key: 39
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.386"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Open.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Карточка счета НУ'
.head 6 +  On SAM_Click
.head 7 -  Call OperWithAccount(USER_ACCOUNTS, ACC, 0,
     ACCESS_READONLY)
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 40
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.814"
.head 6 -  Top:    0.073"
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
.head 5 -  Resource Id: 43064
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  5.186"
.head 6 -  Begin Y:  -0.01"
.head 6 -  End X:  5.186"
.head 6 -  End Y:  0.448"
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
.head 6 -  Left:   7.057"
.head 6 -  Top:    0.063"
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
.head 5 -  Resource Id: 43065
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  3.2"
.head 6 -  Begin Y:  -0.01"
.head 6 -  End X:  3.2"
.head 6 -  End Y:  0.448"
.head 5 -  Visible? No
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 +  Pushbutton: pbCENTR
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbRelation
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   6.486"
.head 6 -  Top:    0.063"
.head 6 -  Width:  0.4"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: MS Sans Serif
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Relation.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = ' Передать для просмотра в ЦЕНТР '
.head 6 +  On SAM_Click
.head 7 +  If sABSFlag= 'DBF'
.head 8 -  Call SalWaitCursor(TRUE)
.head 8 +  If SqlPrepareAndExecute(hSql(),"DELETE FROM sbu WHERE rnk=:sRNK")
.head 9 -  Call SalTblSetFlagsAnyRows(hWndForm, ROW_New, TRUE,0, 0)
.head 9 -  Call SqlPrepare(hSql(),"INSERT INTO sbu (nls,nms,nls8,flag,rnk)
       VALUES (:sNLS,:sNMS,:sNLS8,:FLAG,:sRNK)")
.head 9 -  Call SalTblDoInserts(hWndForm, hSql(), TRUE)
.head 9 -  Call SqlCommit(hSql())
.head 8 -  Call SalWaitCursor(FALSE)
.head 4 +  Data Field: dfN
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: 40
.head 6 -  Data Type: String
.head 6 -  Editable? No
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   8.014"
.head 7 -  Top:    0.104"
.head 7 -  Width:  2.371"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.226"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? No
.head 6 -  Justify: Right
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: 8
.head 6 -  Font Enhancement: Bold
.head 6 -  Text Color: Default
.head 6 -  Background Color: 3D Face Color
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 +  Radio Button: rb_All
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title: Все
.head 5 -  Window Location and Size
.head 6 -  Left:   3.8"
.head 6 -  Top:    0.094"
.head 6 -  Width:  0.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 +  If sABSFlag= 'DBF'
.head 8 -  Call SalEnableWindow(pbCENTR)
.head 7 -  Call SalSendMsg( TB3, UM_Populate, 0, 0 )
.head 4 +  Radio Button: rb_New
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title: Новые
.head 5 -  Window Location and Size
.head 6 -  Left:   4.7"
.head 6 -  Top:    0.094"
.head 6 -  Width:  1.1"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Dark Red
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 -  Call SalDisableWindow(pbCENTR)
.head 7 -  Call SalSendMsg( TB3, UM_Populate, 0, 0 )
.head 2 +  Contents
.head 3 +  Column: sNLS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ЛС
финансового
учета
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.471"
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
.head 3 +  Column: sNMS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
 ЛС финансового
учета
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.543"
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
.head 3 +  Column: FLAG
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ЧО
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.571"
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
.head 3 +  Column: sNLS8
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ЛС
налогового
 учета
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
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
.head 3 +  Column: sNMS8
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenColComboBox_StrId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ЛС  и
Наименование ЛС
налогового учета
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  5.929"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Drop Down List
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? No
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? No
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call sNMS8.Init(hWndItem)
.head 6 -  Set sTmp = "NLS || '" || sRNK || "' || DD||' '||RR||' '||NMS"
.head 6 -  Call sNMS8.Populate(hSql(), "NLS", sTmp, NAL_DEC, 
" WHERE NLS>0 ORDER BY DD,PP,RR")
.head 5 +  On SAM_AnyEdit
.head 6 -  Set sNLS8 = KeyAccount(AMF, Left(sNMS8, 14))
.head 6 +  If SqlPrepareAndExecute(hSql(), "
   SELECT n.dd,n.pp,n.rr,a.acc INTO :sDD,:sPP,:sRR,:ACCC
   FROM " || NAL_DEC || " n, accounts a  
   WHERE a.nls=n.nls and a.kv=:n980 and n.nls=" || Left(sNMS8, 12))
.head 7 +  If SqlFetchNext(hSql(), nFetchRes)
.head 8 +  If Op_Reg(99, 0, 0, nGRP, nTmp, Val(sRNK), sNLS8,
   n980, Subs(sNMS8,16,38), 'ODB', nISP, ACC)
.head 9 +  If SqlPrepareAndExecute(hSql(), " UPDATE accounts SET accc=:ACCC WHERE acc=:ACC")
.head 10 +  If SqlCommit(hSql())
.head 11 -  Return VALIDATE_Ok
.head 10 +  Else
.head 11 -  Set sTmp='SqlCommit... '
.head 9 +  Else
.head 10 -  Set sTmp='Привязка нового: UPDATE accounts SET accc=:ACCC... '
.head 8 +  Else
.head 9 -  Set sTmp='Выполнение OP_REG'
.head 7 +  Else
.head 8 -  Set sTmp='Нет показателя: not SqlFetchNext'
.head 6 +  Else
.head 7 -  Set sTmp='Вычитывание показателя:SELECT n.dd,n.pp,n.rr,a.acc ...'
.head 6 -  Call SalMessageBeep(MB_IconAsterisk)
.head 6 -  Call SalMessageBox('Ошибка при открытии счета ' ||
     sNLS8, 'Внимание.'||sTmp, MB_Ok | MB_IconAsterisk)
.head 3 +  Column: sDD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Деклар.
Дополн.
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
.head 3 +  Column: sPP
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: №
п/п
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.388"
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
.head 3 +  Column: sRR
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Стр
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.7"
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
.head 3 +  Column: ACC
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
.head 4 -  Width:  4.883"
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
.head 3 +  Column: ACCC
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
.head 4 -  Width:  4.883"
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
.head 3 +  Column: RI
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: №
записи
в SBU.dbf
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.95"
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
.head 3 +  Column: sNMS_DOS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
 ЛС финансового
учета
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.288"
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
.head 3 -  Number: nPar
.head 2 +  Window Variables
.head 3 -  String: sODBCDir
.head 3 -  Sql Handle: hSqlA
.head 3 -  Sql Handle: hSqlB
.head 3 -  Number: n980
.head 3 -  String: sRNK
.head 3 -  String: AMF
.head 3 -  String: sTmp
.head 3 -  String: sTmp1
.head 3 -  String: sNewWhere
.head 3 -  Number: nI
.head 3 -  Number: nACC
.head 3 -  Boolean: bFL
.head 3 -  ! Boolean: bSALDO
.head 3 -  Number: nTmp
.head 3 -  Number: nISP
.head 3 -  Number: nGRP
.head 3 -  !
.head 3 -  Number: nOrderBy
.head 3 -  Window Handle: hColumn
.head 3 -  !
.head 3 -  String: sNLSs
.head 3 -  String: sNMSs
.head 3 -  String: smNLSs[*]
.head 3 -  String: smNMSs[*]
.head 3 -  Number: nIs
.head 3 -  Number: nIn
.head 3 -  Number: nIndex
.head 3 -  !
.head 3 -  String: oldPATH
.head 3 -  String: sABSFlag
.head 3 -  String: NAL_DEC
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call WaitCursorOn()
.head 4 -  Set NAL_DEC = 'NAL_DEC3'
.head 4 -  ! запомнить путь, в котором мы находимся
.head 4 -  Call ConPara('PUSH')
.head 4 -  Call SalFileGetCurrentDirectory(oldPATH)
.head 4 -  Set rb_New=TRUE
.head 4 -  ! Set rb_All=TRUE
.head 4 -  Call SalDisableWindow(pbCENTR)
.head 4 +  If nPar = 3
.head 5 -  Call SalHideWindow(sNLS8)
.head 4 -  Set n980 = GetBaseVal()
.head 4 -  Set AMF  = GetBankMfo()
.head 4 -  Set sRNK = SalStrRightX(Str(GetIdRnk()+100), 2) || ' '
.head 4 -  Set nISP = GetUserId()
.head 4 -  Set nGRP = GetUserId()
.head 4 -  Set TB3.strPrintFileName = 'SBU'
.head 4 -  Set TB3.strFilterTblName = 'SBU'
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  Call SetWindowFullSize( hWndForm )
.head 4 -  Call SalUseRegistry(FALSE, '')
.head 4 -  ! Вычитать путь, где наш SBU.dbf
.head 4 -  Call SalGetProfileString('Import', 'NalDecPath', SalStrLeftX(SalFileGetDrive(), 1) ||  ':\\BARS98\\ODBC.DSN\\MOPER', sODBCDir,  GetIniFileName())
.head 4 -  Call SalGetProfileString('NalUch', 'Input', 'DBF', sABSFlag,GetIniFileName())
.head 4 -  Call SalGetProfileString('NalUch', 'DataBase', '', sABSDataBase,GetIniFileName())
.head 4 -  ! Поиск и Установка текущего каталога c  SBU.dbf
.head 4 +  If sABSFlag= 'DBF'
.head 5 +  If SalFileSetCurrentDirectory(sODBCDir)
.head 6 -  Set SqlDatabase = 'dBase_Files'
.head 6 +  If File(sODBCDir || '\\SBU.dbf')
.head 7 +  If SqlConnect(hSqlA)
.head 8 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 7 +  Else
.head 8 -  Call MessageAttention(
     'Ошибка подсоединения к Базе данных: ' || SqlDatabase)
.head 6 +  Else
.head 7 -  Call MessageAttention('Нет файла: ' || sODBCDir ||
     '\\SBU.dbf')
.head 5 +  Else
.head 6 -  Call MessageAttention('Нет каталога: ' || sODBCDir)
.head 5 -  Call SalDisableWindow( pbFilter )
.head 4 -  Set nIs = 0
.head 4 -  Set sRnk = Str(GetIdRnk())
.head 4 -  Set nIn = 0
.head 4 +  If sABSFlag= 'ABS'
.head 5 -  Call WaitCursorOff()
.head 5 -  ! Закомментировано 03.03.2014
.head 5 +  ! If SalMessageBox( 'Импортировать новые счета с базы данных АБС БАРС ?', 'Параметры ... ', 4 ) = IDYES
.head 6 -  Call SalModalDialog( dlg_Connect , hWndForm )
.head 6 +  If bFlagABS=0
.head 7 -  Call SalDestroyWindow( TB3 )
.head 7 -  Call WaitCursorOff()
.head 6 +  ! Else
.head 7 -           Call SalSendClassMessage(SAM_Create, 0, 0)
.head 7 -           Call WaitCursorOff()
.head 5 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On UM_Populate
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set sNewWhere = cF.GetFilterWhereClause( FALSE)
.head 4 -  Set nIn = 0
.head 4 -  Set dfN = Str(nIn)
.head 4 +  If sABSFlag= 'DBF'
.head 5 +  If rb_All
.head 6 -  Set sTmp1 = "
    SELECT flag,nls,nams,nls8,rowid
    INTO :FLAG,:sNLS,:sNMS,:sNLS8,:RI
    FROM sbu
    ORDER BY nls"
.head 5 +  Else
.head 6 -  Set sTmp1 = "
    SELECT flag,nls,nams,nls8,rowid
    INTO :FLAG,:sNLS,:sNMS,:sNLS8,:RI
    FROM sbu WHERE length(trim(nls8))=0
    ORDER BY nls"
.head 6 -  ! Call SalEnableWindow(pbCENTR)
.head 5 -  Call SalTblPopulate(hWndForm, hSqlA, sTmp1, TBL_FillAll)
.head 5 -  ! Call SalTblSetLockedColumns(hWndForm, 2)
.head 4 +  Else
.head 5 +  If rb_All
.head 6 -  Set sTmp1 =
"SELECT sbu.flag, sbu.nls, sbu.nms, sbu.nls8,rownum,a.nls || ' ' || a.nms nms8,acs.dd,acs.pp,acs.rr
 INTO      :FLAG,:sNLS,:sNMS,:sNLS8,:RI,:sNMS8,:sDD,:sPP,:sRR
 FROM sbu, accounts a,
  (select ac.acc,n.dd,n.pp,n.rr from accounts ac, " || NAL_DEC || " n where n.nls = ac.nls) acs
 WHERE sbu.rnk=:sRnk and sbu.nls8 = a.nls (+) and a.accc=acs.acc  (+) "|| IifS(sNewWhere!=""," AND "||sNewWhere,"")||"
 ORDER BY nls"
.head 5 +  Else
.head 6 -  Set sTmp1 =
"SELECT sbu.flag,sbu.nls,sbu.nms,sbu.nls8,rownum,a.nls || ' ' || a.nms nms8,acs.dd,acs.pp,acs.rr
 INTO :FLAG,:sNLS,:sNMS,:sNLS8,:RI,:sNMS8,:sDD,:sPP,:sRR
 FROM sbu, accounts a, 
 (select ac.acc,n.dd,n.pp,n.rr from accounts ac," || NAL_DEC ||" n where n.nls = ac.nls) acs
 WHERE (length(Ltrim(RTrim(nls8)))=0 or nls8 is null) and sbu.rnk=:sRnk and sbu.nls8 = a.nls (+) and a.accc=acs.acc  (+) "|| IifS(sNewWhere!=""," AND "||sNewWhere,"")||"
 ORDER BY nls"
.head 6 -  ! Call SalEnableWindow(pbCENTR)
.head 5 -  Call SalTblPopulate(hWndForm, hSql(), sTmp1, TBL_FillAll)
.head 4 -  Call SalTblSetLockedColumns(hWndForm, 2)
.head 4 -  Call SalWaitCursor(FALSE)
.head 4 -  Call SalTblSetFocusRow(hWndForm, 0)
.head 3 +  On SAM_FetchRowDone
.head 4 +  If sABSFlag= 'DBF'
.head 5 -  Set nIn = nIn + 1
.head 5 -  Set dfN = Str(nIn)
.head 5 -  Set sNLS  = SalStrTrimX(sNLS)
.head 5 -  Set sNLS8 = SalStrTrimX(sNLS8)
.head 5 -  Set nIndex = VisArrayFindString(smNLSs, sNLS)
.head 5 -  Set sNMS_DOS=SalStrTrimX(sNMS)
.head 5 -  Set sNMS = StrDosToWinX(sNMS_DOS)
.head 5 +  If nIndex >= 0
.head 6 -  Set sNMS = smNMSs[nIndex]
.head 5 -  If SqlPrepareAndExecute(hSql(),
  "SELECT acc,accc,nls || ' ' || nms INTO :ACC,:ACCC,:sNMS8 FROM accounts WHERE nls=:sNLS8 and kv=:n980") 
and SqlFetchNext(hSql(), nFetchRes) and
    SqlPrepareAndExecute(hSql(), 
  "SELECT n.dd,n.pp,n.rr INTO :sDD,:sPP,:sRR FROM " || NAL_DEC || " n, accounts a
   WHERE a.acc=:ACCC and a.nls=n.nls") 
and SqlFetchNext(hSql(), nFetchRes)
.head 5 +  Else
.head 6 -  Call SalTblSetCellTextColor(sNLS, COLOR_DarkGreen, FALSE)
.head 4 +  Else
.head 5 -  Set nIn = nIn + 1
.head 5 -  Set dfN = Str(nIn)
.head 5 -  Set sNLS   = SalStrTrimX(sNLS)
.head 5 -  Set sNLS8 = SalStrTrimX(sNLS8)
.head 5 -  Set sNMS  = SalStrTrimX(sNMS)
.head 5 +  If sNLS8 = ''
.head 6 -  Call SalTblSetCellTextColor(sNLS, COLOR_DarkGreen, FALSE)
.head 3 +  On SAM_ColumnSelectClick
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set hColumn = SalNumberToWindowHandle(wParam)
.head 4 -  Set nOrderBy = not nOrderBy
.head 4 -  Call SalTblSortRows(hWndForm,
     SalTblQueryColumnID(hColumn), nOrderBy)
.head 4 -  Call SalTblSetColumnFlags(hColumn, COL_Selected, FALSE)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On UM_Update ! НЕТ
.head 4 +  If sABSFlag= 'DBF'
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 -  Call SaveInfoToLog(MSG_SaveDataRef() || ' ' || strTitleAux)
.head 5 -  Set nI = TBL_MinRow
.head 5 -  Set bFL = TRUE
.head 5 +  While SalTblFindNextRow(hWndForm, nI, ROW_MarkDeleted | ROW_Edited | ROW_New, 0)
.head 6 -  Call SalTblSetFocusRow(hWndForm, nI)
.head 6 +  If not SqlPrepareAndExecute(hSqlA,
       "DELETE FROM sbu WHERE ltrim(rtrim(nls))=:sNLS") or
   not SqlPrepareAndExecute(hSql(),
       "DELETE FROM sbu WHERE nls=:sNLS and rnk=:sRNK")
.head 7 -  Set bFL = FALSE
.head 7 -  Break
.head 6 +  If not SalTblQueryRowFlags(hWndForm, nI, ROW_MarkDeleted)
   and
 ( not SqlPrepareAndExecute(hSqlA,
      "INSERT INTO sbu (nls,nls8,flag,nams) VALUES (:sNLS,:sNLS8,:FLAG,:sNMS_DOS)")
   or
   not SqlPrepareAndExecute(hSql(),
      "INSERT INTO sbu (nls,nls8,flag,rnk,nms) VALUES (:sNLS,:sNLS8,:FLAG,:sRNK,:sNMS)")
  )
.head 7 -  Set bFL = FALSE
.head 7 -  Break
.head 6 -  Call SalTblSetRowFlags(hWndForm, nI, ROW_MarkDeleted,FALSE)
.head 6 -  Call SalTblSetRowFlags(hWndForm, nI, ROW_Edited, FALSE)
.head 6 -  Call SalTblSetRowFlags(hWndForm, nI, ROW_New, FALSE)
.head 5 -  !
.head 5 +  If bFL and SqlPrepareAndExecute(hSqlA, "PACK sbu")
.head 6 -  Call SqlCommit(hSqlA)
.head 6 -  Call SqlCommit(hSql())
.head 5 +  Else
.head 6 -  Call SqlRollback(hSqlA)
.head 6 -  Call SqlRollback(hSql())
.head 5 -  ! Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 5 -  Call SalWaitCursor(FALSE)
.head 4 +  Else
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 -  Call SaveInfoToLog(MSG_SaveDataRef() || ' ' || strTitleAux)
.head 5 -  Set nI = TBL_MinRow
.head 5 -  Set bFL = TRUE
.head 5 +  While SalTblFindNextRow(hWndForm, nI, ROW_MarkDeleted | ROW_Edited | ROW_New, 0)
.head 6 -  Call SalTblSetFocusRow(hWndForm, nI)
.head 6 +  If not SqlPrepareAndExecute(hSql(),
       "DELETE FROM sbu WHERE nls=:sNLS and rnk=:sRNK")
.head 7 -  Set bFL = FALSE
.head 7 -  Break
.head 6 +  If not SalTblQueryRowFlags(hWndForm, nI, ROW_MarkDeleted)
   and
 ( not SqlPrepareAndExecute(hSql(),
      "INSERT INTO sbu (nls,nls8,flag,rnk,nms) VALUES (:sNLS,:sNLS8,:FLAG,:sRNK,:sNMS)")
  )
.head 7 -  Set bFL = FALSE
.head 7 -  Break
.head 6 -  Call SalTblSetRowFlags(hWndForm, nI, ROW_MarkDeleted,FALSE)
.head 6 -  Call SalTblSetRowFlags(hWndForm, nI, ROW_Edited, FALSE)
.head 6 -  Call SalTblSetRowFlags(hWndForm, nI, ROW_New, FALSE)
.head 5 +  If bFL
.head 6 -  Call SqlCommit(hSql())
.head 5 +  Else
.head 6 -  Call SqlRollback(hSql())
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  Call SalSendMsg( TB3, UM_Populate, 0, 0 )
.head 3 +  On SAM_Destroy
.head 4 +  If sABSFlag= 'DBF'
.head 5 -  Call SqlDisconnect(hSqlA)
.head 4 -  ! восстановить путь: который был вначале
.head 4 -  Call ConPara('POP')
.head 4 -  Call SalFileSetCurrentDirectory(oldPATH)
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalSendClassMessage(SAM_CreateComplete, 0, 0)
.head 4 +  If sABSFlag= 'DBF'
.head 5 -  Set dfN = ''
.head 4 -  Set nIn = 0
.head 1 +  Form Window: MOPER_NU
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Прием ИТОГОВЫХ сумм НУ  из файлов NU<MFO>.<md> от филиалов
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
.head 4 -  Left:   0.55"
.head 4 -  Top:    0.458"
.head 4 -  Width:  13.583"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 6.655"
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
.head 3 -  Background Text: Имя файла импорта
.head 4 -  Resource Id: 54105
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   9.517"
.head 5 -  Top:    0.214"
.head 5 -  Width:  3.1"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.202"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Combo Box: dfFile
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   9.7"
.head 5 -  Top:    0.56"
.head 5 -  Width:  2.983"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 4.107"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  String Type: String
.head 4 -  Maximum Data Length: 12
.head 4 -  Sorted? Yes
.head 4 -  Always Show List? No
.head 4 -  Vertical Scroll? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  List Initialization
.head 4 -  Message Actions
.head 3 +  Check Box: cbAll
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cCheckBoxLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Принять ВСЕ файлы
.head 4 -  Window Location and Size
.head 5 -  Left:   8.517"
.head 5 -  Top:    5.369"
.head 5 -  Width:  3.4"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Teal
.head 4 -  Background Color: Class Default
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbExecute
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выполнить
.head 4 -  Window Location and Size
.head 5 -  Left:   9.85"
.head 5 -  Top:    5.667"
.head 5 -  Width:  1.333"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.595"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \bars98\RESOURCE\BMP\Execute.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click   ! Nata
.head 6 +  If dfFile ! есть ли входные файлы
.head 7 +  If MessageQuestion('Прием/Оплата ' || IifS(cbAll, 'NU??????.'||sMD, dfFile) || ' ?') = IDNO
.head 8 -  Return FALSE
.head 7 +  If IsBankDayOpen()
.head 8 -  ! Для проверки на недопустимые символы
.head 8 -  Set i = 0
.head 8 +  While i <= 31
.head 9 -  Set msSimv[i] = SalNumberToChar( i )
.head 9 -  Set i = i + 1
.head 8 -  Set msSimv[i] = SalNumberToChar( 255 )
.head 8 -  !
.head 8 -  Set nJur = TBL_MinRow
.head 8 -  ! организация цикла по COMBOboxУ
.head 8 -  Call F_KATALOG ()
.head 8 -  !
.head 7 +  Else
.head 8 -  Call Debug("День закрыт !")
.head 3 +  Pushbutton: pbRef
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Перечитать
.head 4 -  Window Location and Size
.head 5 -  Left:   8.5"
.head 5 -  Top:    5.667"
.head 5 -  Width:  1.333"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.595"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \bars98\RESOURCE\BMP\Refresh.bmp
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click   
.head 6 -  Call FileZNListBox()
.head 3 +  Pushbutton: pbProt
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Протокол
.head 4 -  Window Location and Size
.head 5 -  Left:   7.15"
.head 5 -  Top:    5.667"
.head 5 -  Width:  1.333"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.595"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \bars98\RESOURCE\BMP\Open.bmp
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click  
.head 6 -  Call NAL_DEC(100)
.head 3 -  !
.head 3 +  Data Field: dfReccount
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 6
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.45"
.head 6 -  Top:    0.19"
.head 6 -  Width:  1.883"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.226"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfAll
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 6
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.1"
.head 6 -  Top:    0.19"
.head 6 -  Width:  1.883"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.226"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Blue
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbExit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выход
.head 4 -  Window Location and Size
.head 5 -  Left:   11.2"
.head 5 -  Top:    5.667"
.head 5 -  Width:  1.333"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.595"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \bars98\RESOURCE\BMP\Discard.bmp
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  ! Call SalEndDialog(hWndForm, FALSE)
.head 6 -  Call SalDestroyWindow(hWndForm)
.head 3 +  Data Field: dfCurrent
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 6
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   6.067"
.head 6 -  Top:    0.19"
.head 6 -  Width:  1.883"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.226"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Dark Green
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Frame
.head 4 -  Resource Id: 54106
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.083"
.head 5 -  Top:    5.238"
.head 5 -  Width:  12.667"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.083"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Drop-Shadow
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 +  Data Field: dfStart
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
.head 6 -  Left:   0.433"
.head 6 -  Top:    5.345"
.head 6 -  Width:  6.9"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Fixedsys
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Periwinkle
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfEnd
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
.head 6 -  Left:   0.433"
.head 6 -  Top:    5.333"
.head 6 -  Width:  6.883"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Fixedsys
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Periwinkle
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfDone
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
.head 6 -  Left:   0.383"
.head 6 -  Top:    5.345"
.head 6 -  Width:  6.917"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.298"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Center
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Purple
.head 5 -  Background Color: Gray
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Child Table: tbl1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.05"
.head 6 -  Top:    0.56"
.head 6 -  Width:  9.267"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 4.179"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  View: Table
.head 5 -  Allow Row Sizing? No
.head 5 -  Lines Per Row: Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: 333333
.head 5 -  Discardable? Yes
.head 4 +  Contents
.head 5 +  Column: colFA
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Файл
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.214"
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
.head 5 +  Column: colNPP
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Nпп
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  0.471"
.head 6 -  Width Editable? Yes
.head 6 -  Format: #0
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
.head 5 +  Column: colND
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Номер док.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.114"
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
.head 5 +  Column: colVOB
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Вид оп.
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
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
.head 5 +  Column: colNLSA
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Счет-А
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.4"
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
.head 5 +  Column: colNAMA
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наим.А
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.714"
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
.head 5 +  Column: colNAMB
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наим.Б
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.714"
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
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Сумма
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.643"
.head 6 -  Width Editable? Yes
.head 6 -  Format: ###000
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
.head 5 +  Column: colVDATE
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Дата вал.
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Justify: Left
.head 6 -  Width:  1.543"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Date
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
.head 5 +  Column: colNAZN
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Назначение пл.
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 160
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.357"
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
.head 5 +  Column: colREF98
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Референс
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  1.329"
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
.head 5 +  Column: colTT
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Транзакция
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.943"
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
.head 5 -  Number: nFocusRow
.head 5 -  Window Handle: hWndCol
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
.head 6 -  Call VisTblAutoSizeColumn(tbl1, hWndNULL)
.head 5 +  On SAM_CornerClick
.head 6 -  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
.head 5 +  On SAM_CornerDoubleClick
.head 6 -  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
.head 5 +  On SAM_DoubleClick
.head 6 -  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
.head 5 +  On SAM_RowHeaderClick
.head 6 -  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
.head 5 +  On SAM_RowHeaderDoubleClick
.head 6 -  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
.head 5 +  On SAM_EndCellTab
.head 6 -  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
.head 5 +  On WM_LbuttonUp
.head 6 -  ! Узнать текущую строку
.head 6 -  ! Call SalTblQueryFocus(tbl1, nFocusRow, hWndCol)
.head 6 -  ! Set nFocusRow = SalTblQueryContext(tbl1)
.head 6 -  ! Почистить все
.head 6 -  Call SalTblSetFlagsAnyRows(tbl1, ROW_Selected, FALSE, 0, 0)
.head 6 -  ! Call SalTblSetFocusRow (tbl1, nFocusRow)
.head 6 -  ! Стать на нее (что выше)
.head 6 -  ! Call SalTblSetRowFlags(tbl1, nFocusRow, ROW_Selected, FALSE)
.head 6 -  ! Call SalSendMsg(tbl1, SAM_RowHeaderClick, 0, Max(TBL_MaxRow, nFocusRow+1))
.head 5 +  On VTM_KeyUp
.head 6 -  Call SalTblSetFlagsAnyRows(tbl1, ROW_Selected, FALSE, 0, 0)
.head 6 -  Call VisTblAutoSizeColumn(tbl1, hWndNULL)
.head 5 +  On WM_NCMouseMove ! 160
.head 6 -  Call VisTblAutoSizeColumn(tbl1, hWndNULL)
.head 3 +  Custom Control: ccProgressBar
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
.head 6 -  Left:   0.117"
.head 6 -  Top:    4.786"
.head 6 -  Width:  10.867"
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
.head 5 -  Text Color: Royal Blue
.head 5 -  Background Color: Gray
.head 5 -  DLL Settings
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
.head 6 -  Left:   11.117"
.head 6 -  Top:    4.786"
.head 6 -  Width:  1.733"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.333"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Date
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 12
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Group Box: Всего
.head 4 -  Resource Id: 54107
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.217"
.head 5 -  Top:    0.06"
.head 5 -  Width:  2.233"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.429"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Group Box: Выбрано
.head 4 -  Resource Id: 54108
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.083"
.head 5 -  Top:    0.06"
.head 5 -  Width:  2.233"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.429"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Blue
.head 4 -  Background Color: Default
.head 3 -  Group Box: Выбрано
.head 4 -  Resource Id: 54109
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.95"
.head 5 -  Top:    0.06"
.head 5 -  Width:  2.233"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.429"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Dark Green
.head 4 -  Background Color: Default
.head 2 +  Functions
.head 3 +  Function: FileZNListBox
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: smFiles[*]
.head 5 -  Number: nI
.head 5 -  Number: nFiles
.head 4 +  Actions
.head 5 -  Set sMD=Sep98md( dfBD ) 
.head 5 -  Set nFiles = VisDosEnumFiles(sODBCDir || '\\NU??????.'||sMD, FA_Standard, smFiles)
.head 5 -  Set nI = 0
.head 5 -  Call SalListClear(dfFile)
.head 5 +  While nI < nFiles
.head 6 -  Call SalListAdd(dfFile, smFiles[nI])
.head 6 -  Set nI = nI + 1
.head 5 +  If nI > 0
.head 6 -  Call SalListSetSelect(dfFile, 0)
.head 6 -  Call SalEnableWindow(pbExecute)
.head 6 -  Call SalSendMsg(dfFile, SAM_Click, 0, 0)
.head 5 +  Else
.head 6 -  Call SalDisableWindow(pbExecute)
.head 5 -  Call SalEnableWindow(pbExit)
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  Call SalSetFocus(pbExit)
.head 3 +  Function: Perenos
.head 4 -  Description: Разбиение назначения платежа
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  String: sTxt	! текст
.head 5 -  Number: nLen	! длина
.head 5 -  Number: nSpaces ! количество пробелов слева
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sNana[*]
.head 5 -  Number: nL
.head 5 -  String: sI
.head 5 -  Number: nJ
.head 5 -  Number: nC
.head 5 -  String: sRes
.head 4 +  Actions
.head 5 -  Set nL = 0
.head 5 -  Set sI = SalStrTrimX(sTxt)
.head 5 +  Loop
.head 6 +  If Len(sI) = 0
.head 7 -  Break
.head 6 +  If Len(sI) < nLen+1
.head 7 -  Set sNana[nL] = sI
.head 7 -  Break
.head 6 -  Set nJ = nLen + 1
.head 6 -  Set sNana[nL] = Left(sI, nJ)
.head 6 +  While nJ > 0
.head 7 +  If Subs(sNana[nL], nJ, 1) = ' ' or Subs(sNana[nL], nJ, 1) = ',' or
   Subs(sNana[nL], nJ, 1) = '.' or Subs(sNana[nL], nJ, 1) = ';' or
   Subs(sNana[nL], nJ, 1) = ':' or Subs(sNana[nL], nJ, 1) = '-'
.head 8 -  Set sNana[nL] = SalStrTrimX(Left(sNana[nL], nJ))
.head 8 -  Set sI = SalStrTrimX(Subs(sI, nJ+1, Len(sI)-nJ))
.head 8 -  Break
.head 7 -  Set nJ = nJ - 1
.head 7 +  If nJ = 0
.head 8 -  Set sI = SalStrTrimX(Subs(sI, nLen+1, Len(sI)-nLen))
.head 6 -  Set nL = nL + 1
.head 5 -  Set nC = 0
.head 5 -  Set sRes = ''
.head 5 +  While nC <= nL
.head 6 -  Set sRes = sRes || Spac(nSpaces) || sNana[nC] || PutCrLf()
.head 6 -  Set nC = nC + 1
.head 5 -  Return sRes
.head 3 +  Function: FScan
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  String: sPar
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sStr
.head 5 -  Number: nNum
.head 5 -  Boolean: bRet
.head 4 +  Actions
.head 5 -  Set sStr = sPar
.head 5 -  Set bRet = TRUE
.head 5 +  Loop
.head 6 +  If sStr
.head 7 -  Call SalStrFirstC( sStr, nNum )
.head 7 -  Set i = 0
.head 7 +  While i <= 32
.head 8 +  If SalNumberToChar(nNum) = msSimv[i]
.head 9 -  Set bRet = FALSE
.head 9 -  Break
.head 8 -  Set i = i + 1
.head 6 +  Else
.head 7 -  Break
.head 6 +  If not bRet
.head 7 -  Break
.head 5 -  Return bRet
.head 3 +  Function: F_KATALOG
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Date/Time: dTmp
.head 4 +  Actions
.head 5 -  Set dTmp = dfBD
.head 5 +  While Len(dfFile) > 0
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call SalDisableWindow(pbExecute)
.head 6 -  ! Call SalDisableWindow(pbExit)
.head 6 -  Set dfDone = ""
.head 6 -  Call SalUseRegistry(FALSE, '')
.head 6 -  Call SaveInfoToLog('Прием документов из ' || IifS(cbAll, 'NU??????.'||sMD, dfFile))
.head 6 -  Call SalFileCreateDirectory(sODBCDir || '\\TempODBC.Dir')
.head 6 +  If SalFileSetCurrentDirectory(sODBCDir)
.head 7 -  Call SalFileCreateDirectory(sODBCDir || '\\TempODBC.Dir')
.head 7 -  Call SalFileSetCurrentDirectory(sODBCDir || '\\TempODBC.Dir')
.head 7 -  Set sTempDbf = 'Db' || Left(SalFmtFormatDateTime(   SalDateCurrent(), 'mmmmmm'), 2) || SalFmtFormatDateTime(
    SalDateCurrent(), 'ssmm') || '.Dbf'
.head 7 -  ! !!!!
.head 7 -  Call VisFileCopy(sODBCDir || '\\' || dfFile, sODBCDir || '\\TempODBC.Dir\\' ||     sTempDbf )
.head 7 -  Set SqlDatabase = 'dBase_Files'
.head 7 +  If SalFileGetDateTime(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf, dTmp )
.head 8 -  ! проверить, есть ли поле ref99bm в operxx, если нет, то добавить его
.head 8 -  Set n99 = -1
.head 8 -  Set dfDone = "Подождите ..."
.head 8 -  Call SalLoadAppAndWait("FindVar2 " || sODBCDir || '\\TempODBC.Dir\\' ||  sTempDbf || " ref99bm", Window_NotVisible, n99)
.head 8 +  If n99 = 1
.head 9 -  Call SalWaitCursor(FALSE)
.head 9 -  ! удалить в NOT, но запросить сначала
.head 9 +  If VisMessageBox('Файл ' || dfFile || ' возможно занят другим пользователем. Удалить в NOT ?', 'ЗАПРОС', MBF_IconQuestion, hBtns, 2) = 1 ! ID_Yes
.head 10 -  Call SalWaitCursor(TRUE)
.head 10 -  Call SalFileCreateDirectory(sODBCDir || '\\ArchivNO')
.head 10 -  Call VisFileCopy(sODBCDir || '\\' || dfFile, sODBCDir || '\\ArchivNO\\' || dfFile)
.head 10 +  If File(sODBCDir || '\\ArchivNO\\' || dfFile)
.head 11 -  Call VisFileDelete(sODBCDir || '\\' || dfFile)
.head 11 -  Call VisFileDelete(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf)
.head 9 -  Return FALSE
.head 8 +  If n99 = 2
.head 9 -  Call SalWaitCursor(FALSE)
.head 9 -  ! удалить без запроса в NOT, но написать об этом
.head 9 -  Call MessageNoWait('Файл ' || dfFile ||     ' не DBF-структуры, удаляется в NOT !', 'ВНИМАНИЕ !', 37, 1)
.head 9 -  Call SalFileCreateDirectory(sODBCDir || '\\ArchivNO')
.head 9 -  Call VisFileCopy(sODBCDir || '\\' || dfFile, sODBCDir || '\\ArchivNO\\' ||     dfFile)
.head 9 +  If File(sODBCDir || '\\ArchivNO\\' || dfFile)
.head 10 -  Call VisFileDelete(sODBCDir || '\\' || dfFile)
.head 10 -  Call VisFileDelete(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf)
.head 9 -  Return FALSE
.head 8 +  If n99 = 3
.head 9 -  Call SalWaitCursor(FALSE)
.head 9 -  ! удалить без запроса в NOT, но написать об этом
.head 9 -  Call MessageNoWait('Файл ' || dfFile ||     ' имеет структуру не MOPER, удаляется в NOT !', 'ВНИМАНИЕ !', 37, 1)
.head 9 -  Call SalFileCreateDirectory(sODBCDir || '\\ArchivNO')
.head 9 -  Call VisFileCopy(sODBCDir || '\\' || dfFile, sODBCDir || '\\ArchivNO\\' ||     dfFile)
.head 9 +  If File(sODBCDir || '\\ArchivNO\\' || dfFile)
.head 10 -  Call VisFileDelete(sODBCDir || '\\' || dfFile)
.head 10 -  Call VisFileDelete(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf)
.head 9 -  Return FALSE
.head 8 +  If n99 = 4
.head 9 -  Call SalWaitCursor(FALSE)
.head 9 -  ! удалить без запроса в NOT, но написать об этом
.head 9 -  Call MessageNoWait('Файл ' || dfFile ||' имеет расширение не .DBF, удаляется в NOT !', 'ВНИМАНИЕ !', 37, 1)
.head 9 -  Call SalFileCreateDirectory(sODBCDir || '\\ArchivNO')
.head 9 -  Call VisFileCopy(sODBCDir || '\\' || dfFile, sODBCDir || '\\ArchivNO\\' ||     dfFile)
.head 9 +  If File(sODBCDir || '\\ArchivNO\\' || dfFile)
.head 10 -  Call VisFileDelete(sODBCDir || '\\' || dfFile)
.head 10 -  Call VisFileDelete(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf)
.head 9 -  Return FALSE
.head 8 -  Set dfDone = ""
.head 8 -  Set sErr = STRING_Null
.head 8 -  Set FN_tmp = Left(sTempDbf, Len(sTempDbf)-4)
.head 8 +  If SqlConnect(hSqlA) and SqlConnect(hSqlB) 
.head 9 +  If not F_FILE1()
.head 10 -  Return FALSE
.head 8 +  Else
.head 9 -  Call MessageAttention('Ошибка подсоединения к Базе данных: ' || SqlDatabase)
.head 9 -  Return FALSE
.head 7 +  Else
.head 8 +  If VisMessageBox('Файл ' || dfFile ||   ' возможно занят другим пользователем. Удалить в NOT ?', 'ЗАПРОС',
   MBF_IconQuestion, hBtns, 2) = 1 ! ID_Yes
.head 9 -  Call SalWaitCursor(TRUE)
.head 9 -  Call SalFileCreateDirectory(sODBCDir || '\\ArchivNO')
.head 9 -  Call VisFileCopy(sODBCDir || '\\' || dfFile, sODBCDir || '\\ArchivNO\\' ||     dfFile)
.head 9 +  If File(sODBCDir || '\\ArchivNO\\' || dfFile)
.head 10 -  Call VisFileDelete(sODBCDir || '\\' || dfFile)
.head 10 -  Call VisFileDelete(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf)
.head 8 -  Return FALSE
.head 6 +  Else
.head 7 -  Call MessageAttention('Нет каталога: ' || sODBCDir)
.head 7 -  Return FALSE
.head 6 -  !
.head 6 -  Call FileZNListBox()
.head 6 -  !
.head 6 +  If not cbAll
.head 7 -  Return TRUE
.head 6 -  ! Call SalSendMsg( pbExecute, SAM_Click, 0, 0 )
.head 5 -  Call SalEnableWindow(pbExit)
.head 5 -  Return TRUE
.head 3 +  Function: F_FILE1
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  ! повтор периода
.head 5 -  Set sErr = STRING_Null
.head 5 +  If SqlPrepareAndExecute(hSqlA,
  "SELECT DATD,DA,VDATE,MFO    INTO :DAT_BEG,:DAT_END,:DAT_FORM,:fMFO FROM " || FN_tmp ) 
and SqlFetchNext(hSqlA, nFetchRes)
.head 6 -  Set dTempDate = DAT_END
.head 6 -  ! Проверка на повторное формирование
.head 6 -  Set DAT_END_OLD = DAT_BEG -1
.head 6 +  If SqlPrepareAndExecute( hSql(),
  "SELECT NVL( max(DAT_END), :DAT_END_OLD )    INTO :DAT_END_OLD 
   FROM moper_nu WHERE mfo=:fMFO " ) 
and SqlFetchNext( hSql(), nFetchRes )
.head 7 +  If DAT_END_OLD >= DAT_BEG
.head 8 -  Set sErr = ' содержит повторный период' 
.head 6 -  ! Проверка на пропущенный период
.head 6 +  If SqlPrepareAndExecute( hSql(),
  "SELECT count(*) INTO :Kol_dney FROM fdat WHERE fdat>:DAT_END_OLD and fdat<:DAT_BEG" ) 
and SqlFetchNext( hSql(), nFetchRes )
.head 7 +  If Kol_dney >0
.head 8 -  Set sErr = ' пропущено '||Str(Kol_dney)||' дней' 
.head 5 -  ! Синхронное отображение по банковской дате в банк.дате гл банка и филиала
.head 5 +  If sErr != STRING_Null
.head 6 -  Call SqlDisconnect(hSqlA)
.head 6 -  Call SqlDisconnect(hSqlB)
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Call MessageNoWait('Файл ' || dfFile || sErr || '. Удаляется в NOT !', 'ВНИМАНИЕ !', 37, 1)
.head 6 -  Call SalFileCreateDirectory(sODBCDir || '\\ArchivNO')
.head 6 -  Call VisFileCopy(sODBCDir || '\\' || dfFile, sODBCDir || '\\ArchivNO\\'  || dfFile)
.head 6 +  If File(sODBCDir || '\\ArchivNO\\' || dfFile)
.head 7 -  Call VisFileDelete(sODBCDir || '\\' || dfFile)
.head 7 -  Call VisFileDelete(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf)
.head 6 -  ! удалить без запроса в NOT, но написать об этом
.head 6 -  Return FALSE
.head 5 -  !
.head 5 -  If SqlPrepareAndExecute(hSqlA,
  "SELECT count(*) FROM " || Left(sTempDbf, Len(sTempDbf)-4) || " INTO :nRecCount")
and SqlFetchNext(hSqlA, nFetchRes)
.head 5 -  Call SalShowWindow(dfStart)
.head 5 -  Call SalShowWindow(dfEnd)
.head 5 -  Set nTimeStart = SalDateHour(SalDateCurrent())*3600 + SalDateMinute( SalDateCurrent())*60 + SalDateSecond(SalDateCurrent())
.head 5 -  Set dfStart = 'Старт: ' || SalFmtFormatDateTime( SalDateCurrent(), 'hhh:mm:ss')
.head 5 -  Set dfReccount = nRecCount
.head 5 -  Set dfCurrent = 0
.head 5 -  Set dfAll = 0
.head 5 -  Set nPos = 0
.head 5 -  Set nTek = 0
.head 5 -  Set nRecn = 1
.head 5 -  Set nDelta = 100 / nRecCount
.head 5 -  Call SqlSetResultSet(hSqlA, FALSE)
.head 5 -  Set sSelectOper = "
    SELECT rowid, nm,  dk,  nd,  nls, s,   plat,  polu,  naz1,  sos,  ref99bm
    INTO :nRow, :nNm,:nDk,:sNd,:sNls,:nS,:sPlat,:sPolu,:sNaz1,:nSos,:nRef99bm
    FROM " || Left(sTempDbf, Len(sTempDbf)-4) || " FOR UPDATE OF sos"
.head 5 +  If not SqlPrepare(hSqlA, sSelectOper)
.head 6 -  Call SqlDisconnect(hSqlA)
.head 6 -  Call SqlDisconnect(hSqlB)
.head 6 -  Return FALSE
.head 5 -  Call SqlOpen(hSqlA, Left(sTempDbf, Len(sTempDbf)-4))
.head 5 -  Set Kol_PAY = 0
.head 5 +  While SqlFetchNext(hSqlA, nFetchRes)
.head 6 -  Call Oplata1()
.head 5 -  Call ccProgressBar.SetProgress(100)
.head 5 +  If SqlPrepareAndExecute( hSql(), 
  "INSERT INTO moper_nu( MFO, DAT_FORM, DAT_BEG, DAT_END, FN, DAT_PAY, PAY) 
 values (:fMFO,:DAT_FORM,:DAT_BEG, :DAT_END, :dfFile, :dfBD, :Kol_PAY )" )
.head 6 -  Call SqlCommitEx(hSql(), 'OK')
.head 5 -  Call SqlCommit(hSqlB)
.head 5 -  Call SqlDisconnect(hSqlA)
.head 5 -  Call SqlDisconnect(hSqlB)
.head 5 -  Call SaveInfoToLog('Прием документов из ' || dfFile || ' ОКОНЧЕН')
.head 5 -  Set dfDone = "Готово"
.head 5 -  Set dfEnd = Left(dfEnd, 15)
.head 5 -  !
.head 5 +  If dfCurrent > 0
.head 6 -  ! сформировать файл оплаченных документов
.head 6 -  Set nCurrentRow = nJur
.head 6 -  Set nP = 1
.head 6 -  Set nItog = 0
.head 6 -  Set sFr = GetPrnDir() || '\\M' || Right(Str(SalDateMonth(dfBD)+100), 2)
    || Right(Str(SalDateDay(dfBD)+100), 2) || Right(Str(SalDateHour(
    SalDateCurrent())+100), 2) || Subs(Str(SalDateMinute(
    SalDateCurrent())+100), 2, 1) || '.' || Right(Str(SalDateMinute(
    SalDateCurrent())), 1) || Right(Str(SalDateSecond(
    SalDateCurrent())+100), 2)
.head 6 -  Call SalFileOpen(hF, sFr, OF_Create | OF_Write)
.head 6 -  Set sBuff = StrWinToDosX(SalStrTrimX(GetBankName())||' '||aMFO|| PutCrLf() ||
    'Дата и время формирования ' || SalFmtFormatDateTime(
    SalDateCurrent(), 'dd/MM/yyyy ') || Right('0' ||
    SalFmtFormatDateTime(SalDateCurrent(), 'hhhh:mm:ss'), 8) ||
    PutCrLf() || PutCrLf() || Spac(15) ||
    'Реестр оплаченных платежных документов' || PutCrLf() || Spac(15) ||
    '(' || dfFile || ') сеанс (с ' || Right(dfStart, 8) || ' по ') ||
    Right(dfEnd, 8) || ')' || PutCrLf() || Repl('-', 69) || PutCrLf()
.head 6 -  Call SalFileWrite(hF, sBuff, Len(sBuff))
.head 6 +  While SalTblFindNextRow(tbl1, nCurrentRow, 0, 0)
.head 7 -  Call SalTblSetFocusRow(tbl1, nCurrentRow)
.head 7 -  Set nColor = SalColorGet(tbl1.colNLSA,    COLOR_IndexCellText)
.head 7 +  If nColor = COLOR_DarkGreen
.head 8 -  Set sLev = tbl1.colTT || ' реф.' || Str(tbl1.colREF98) || ', док.'
    || SalStrTrimX(tbl1.colND) || ', оп.' || Str(tbl1.colVOB)
.head 8 -  Set sBuff = PadR(Str(nP) || '.', 4) || 
    PadR(tbl1.colNLSA || '(980)', 20) || StrWinToDosX(SalStrTrimX(tbl1.colNAMA) || PutCrLf()
    || PadL('сумма ' || SalNumberToStrX(tbl1.colS, 2), 69-Len(sLev)) ||
    PutCrLf() || Perenos(tbl1.colNAZN, 65, 4)) || PutCrLf()
.head 8 -  Call SalFileWrite(hF, sBuff, Len(sBuff))
.head 8 -  Set nP = nP + 1
.head 8 -  Set nItog = nItog + tbl1.colS
.head 6 -  Set sBuff = Repl('-', 69) || PutCrLf() || StrWinToDosX('    Итого: ' ||
    PadR(Str(nP-1), 20) || 'На сумму:') || PadL(
    SalNumberToStrX(nItog, 2), 29) || PutCrLf() || Repl('-', 69) ||
    Repl(PutCrLf(), 3)
.head 6 -  Call SalFileWrite(hF, sBuff, Len(sBuff))
.head 6 -  Call SalFileClose(hF)
.head 5 -  Call SalMessageBeep(-1)
.head 5 +  If dfAll > dfCurrent
.head 6 -  ! удалить файл в NOT (по запросу)
.head 6 +  If VisMessageBox('ВНИМАНИЕ ! Файл ' || dfFile || '. Обработаны не ВСЕ '
   || 'выбранные документы. Примите меры для исправления ошибок. ' ||
   'Переместить в NOT ?', 'ЗАПРОС', MBF_IconQuestion, hBtns, 2) = 1
 ! ID_Yes
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call SalFileCreateDirectory(sODBCDir || '\\ArchivNO')
.head 7 -  Call VisFileCopy(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf, sODBCDir
     || '\\ArchivNO\\' || dfFile)
.head 7 +  If File(sODBCDir || '\\ArchivNO\\' || dfFile)
.head 8 -  Call VisFileDelete(sODBCDir || '\\' || dfFile)
.head 8 -  Call VisFileDelete(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf)
.head 8 -  Call FileZNListBox()
.head 6 +  Else
.head 7 -  Call VisFileCopy(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf, sODBCDir     || '\\' || dfFile)
.head 7 +  If File(sODBCDir || '\\' || dfFile)
.head 8 -  Call VisFileDelete(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf)
.head 6 -  Return FALSE
.head 5 +  Else
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  ! записать в архив OK и удалить
.head 6 +  If VisMessageBox('ВНИМАНИЕ ! Файл ' || dfFile ||
   ' обработан. Записать в АРХИВ(Ok) ?', 'ЗАПРОС', MBF_IconQuestion,   hBtns, 2) = 1 ! ID_Yes
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  Call SalFileCreateDirectory(sODBCDir || '\\ArchivOK')
.head 7 -  Call VisFileCopy(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf, sODBCDir
     || '\\ArchivOK\\' || dfFile)
.head 7 +  If File(sODBCDir || '\\ArchivOK\\' || dfFile)
.head 8 -  Call VisFileDelete(sODBCDir || '\\' || dfFile)
.head 8 -  Call VisFileDelete(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf)
.head 8 -  Call FileZNListBox()
.head 6 +  Else
.head 7 -  Call VisFileCopy(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf, sODBCDir     || '\\' || dfFile)
.head 7 +  If File(sODBCDir || '\\' || dfFile)
.head 8 -  Call VisFileDelete(sODBCDir || '\\TempODBC.Dir\\' || sTempDbf)
.head 7 -  Return FALSE
.head 6 -  Call SalWaitCursor(TRUE)
.head 5 -  Call SalSetFocus(tbl1)
.head 5 -  Call VisTblAutoSizeColumn(tbl1, hWndNULL)
.head 5 -  Set nJur = nNewRow
.head 5 -  Return TRUE
.head 3 +  Function: Oplata1
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sNlsA
.head 5 -  String: sTmpS
.head 5 -  Date/Time: bfBD
.head 4 +  Actions
.head 5 -  Set sNls = SalStrTrimX(sNls)
.head 5 -  Set bfBD = dfBD
.head 5 +  If SalStrLength( sNls ) < 5 
.head 6 -  Return FALSE
.head 5 -  ! Преобразовать счет !
.head 5 -  Set sTmpS =
" SELECT Substr(vkrzn( '" || MFO5 ||"', nlsg||'" || fMFO ||"' ),1,14)
  INTO :sNlsA FROM nal_dec3 
  WHERE '"||sNls||"' like substr(nls,1,4)||'_'||substr(nls,6,9) and nls is not null "
.head 5 +  If SqlPrepareAndExecute( hSql(),sTmpS ) and not SqlFetchNext( hSql(), nFetchRes )
.head 6 -  Return FALSE
.head 5 -  ! Перекодировка
.head 5 -  Set sNd   = SalStrTrimX(StrDosToWinX(sNd))
.head 5 -  Set sPlat = SalStrTrimX(StrDosToWinX(sPlat))
.head 5 -  Set sPolu = SalStrTrimX(StrDosToWinX(sPolu))
.head 5 -  Set sNaz1 = SalStrTrimX(StrDosToWinX(sNaz1))
.head 5 -  !
.head 5 -  Set nNewRow = SalTblInsertRow(tbl1, TBL_MaxRow)
.head 5 -  Call SalTblSetFocusRow(tbl1, nNewRow)
.head 5 -  Set tbl1.colNPP = nRecn
.head 5 -  Set tbl1.colND  = sNd
.head 5 -  Set tbl1.colNLSA = sNlsA
.head 5 -  Set tbl1.colNAMA = sPlat
.head 5 -  Set tbl1.colNAMB = sPolu
.head 5 -  Set tbl1.colFA = dfFile
.head 5 -  Set tbl1.colS = nS/100
.head 5 -  Set tbl1.colNAZN = sNaz1
.head 5 -  Set tbl1.colREF98 = nRef99bm
.head 5 -  Call SalTblSetRowFlags(tbl1, nNewRow, ROW_Edited | ROW_New, FALSE)
.head 5 +  If nNm=1 and nSos=0 and nS>0 
.head 6 -  ! --------------------------------------------
.head 6 -  Set nRef = NUMBER_Null
.head 6 -  Call VisTblSetRowColor(tbl1, nNewRow, COLOR_Blue)
.head 6 -  ! Оплата
.head 6 -  Call ccDoc.SetDoc(0, 'PO3', nDk, 6, sNd, bfBD, bfBD, bfBD, bfBD,
     sNlsA, sPlat, aMFO, '', 980, nS, STRING_Null,
     sNlsk, sPolu, aMFO, '', 980, nS, STRING_Null, sNaz1, STRING_Null, 
     GetIdOper(), '', NUMBER_Null,  0)
.head 6 -  Set dfAll = dfAll + 1
.head 6 +  If ccDoc.oDoc()
.head 7 +  If SqlPrepareAndExecute(hSqlB, "
   UPDATE " || Left(sTempDbf, Len(sTempDbf)-4) || " SET sos=9
   WHERE CURRENT OF " || Left(sTempDbf, Len(sTempDbf)-4))
.head 8 -  Call SqlCommit(hSql())
.head 8 -  Set Kol_PAY = Kol_PAY + 1
.head 8 -  Set tbl1.colREF98 = ccDoc.m_nRef
.head 8 -  Call VisTblSetRowColor(tbl1, nNewRow, COLOR_DarkGreen)
.head 8 -  Set dfCurrent = dfCurrent + 1
.head 8 +  If Mod(n99, 10) = 0
.head 9 -  Call SqlPrepareAndExecute(hSqlB, "
     UPDATE " || Left(sTempDbf, Len(sTempDbf)-4) || "
     SET sos=9,ref99bm=:ccDoc.m_nRef
     WHERE CURRENT OF " ||
           Left(sTempDbf, Len(sTempDbf)-4))
.head 7 +  Else
.head 8 -  Call SaveInfoToLog('ошибка UPDATE '||Left(sTempDbf,Len(sTempDbf)-4) ||' SET sos=9 '||sNls )
.head 8 -  Call SqlRollback(hSql())
.head 6 +  Else
.head 7 -  Call SaveInfoToLog('ошибка при оплате ' || sNlsA )
.head 7 -  Call SqlRollback(hSql())
.head 5 -  Call SalTblSetCellTextColor(tbl1.colNPP, COLOR_Charcoal, TRUE)
.head 5 -  Set nPos = nPos + nDelta
.head 5 -  Set nRecn = nRecn + 1
.head 5 +  If Int(nPos) != nTek
.head 6 -  Set nTek = Int(nPos)
.head 6 -  Set nTimeCurrent = SalDateHour(SalDateCurrent())*3600 + SalDateMinute(
    SalDateCurrent())*60 + SalDateSecond(SalDateCurrent())
.head 6 -  Set nTimeEnd = Int(100 * (nTimeCurrent-nTimeStart) / nPos +
    nTimeStart)
.head 6 -  Set nHour = Int(nTimeEnd/3600)
.head 6 -  Set nTemp = nTimeEnd - nHour*3600
.head 6 -  Set nMinu = Int(nTemp/60)
.head 6 -  Set dfStart = dfStart
.head 6 -  Set dfEnd = 'Финиш: ' || Right(Str(100+nHour), 2) || ':' || Right(
    Str(100+nMinu), 2) || ':' || Right(Str(100+nTemp-nMinu*60), 2) ||
    ' (прогноз)'
.head 6 -  Set dfReccount = dfReccount
.head 6 -  Set dfCurrent = dfCurrent
.head 6 -  Set dfAll = dfAll
.head 5 -  Call ccProgressBar.SetProgress(nPos)
.head 5 -  Call SalUpdateWindow(hWndForm)
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  Date/Time: DAT_FORM
.head 3 -  Date/Time: DAT_BEG
.head 3 -  Date/Time: DAT_END 
.head 3 -  Date/Time: DAT_END_OLD
.head 3 -  !
.head 3 -  String: aMFO
.head 3 -  String: MFO5
.head 3 -  String: fMFO
.head 3 -  !
.head 3 -  String: sMD
.head 3 -  String: sErr
.head 3 -  String: FN
.head 3 -  String: FN_tmp
.head 3 -  Number: Kol_dney
.head 3 -  Number: Kol_PAY
.head 3 -  : ccDoc
.head 4 -  Class: cDoc
.head 3 -  Number: nNm
.head 3 -  Number: nDk
.head 3 -  String: sNd
.head 3 -  String: sNls
.head 3 -  String: sNlsk
.head 3 -  Number: nS
.head 3 -  String: sPlat
.head 3 -  String: sPolu
.head 3 -  String: sNaz1
.head 3 -  Number: nRow
.head 3 -  Number: nRef
.head 3 -  Number: nRef99bm
.head 3 -  Number: nSos
.head 3 -  String: sTmp
.head 3 -  Number: nCount 
.head 3 -  Number: nNewRow
.head 3 -  Sql Handle: hSqlA
.head 3 -  Sql Handle: hSqlB
.head 3 -  Number: nPos
.head 3 -  Number: nDelta
.head 3 -  Number: nRecCount
.head 3 -  String: strMessage
.head 3 -  String: sODBCDir
.head 3 -  Number: n99
.head 3 -  Number: nTimeStart
.head 3 -  Number: nTimeCurrent
.head 3 -  Number: nTimeEnd
.head 3 -  Number: nHour
.head 3 -  Number: nMinu
.head 3 -  Number: nTemp
.head 3 -  Number: nTek
.head 3 -  Number: nRecn
.head 3 -  Number: nCurrentRow
.head 3 -  Number: nP
.head 3 -  Number: nItog
.head 3 -  File Handle: hF
.head 3 -  Number: nColor
.head 3 -  String: sBuff
.head 3 -  String: sFr
.head 3 -  String: sLev
.head 3 -  Date/Time: dTempDate
.head 3 -  Number: hBtnYes
.head 3 -  Number: hBtnNo
.head 3 -  Number: hBtns[*]
.head 3 -  Number: nJur
.head 3 -  String: sTempDbf
.head 3 -  !
.head 3 -  String: sSelectOper
.head 3 -  ! переменные для проверки реквизитов
.head 3 -  Number: i
.head 3 -  String: msSimv[33]
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set aMFO = GetBankMfo()
.head 4 -  Set MFO5 = Subs(aMFO,1,5)
.head 4 -  Set sNlsk = Vkrz2( aMFO, '81990')  
.head 4 -  Set dfBD =  GetBankDate()
.head 4 -  Call ConPara('PUSH')
.head 4 -  Set hBtnYes = VisMessageLoadButton('&Да', 1)
.head 4 -  Set hBtnNo = VisMessageLoadButton('&Нет', 2)
.head 4 -  Call VisMessageSetBkgdColor(COLOR_Salmon)
.head 4 -  Set hBtns[0] = hBtnYes | MBF_DefButton
.head 4 -  Set hBtns[1] = hBtnNo
.head 4 -  Call SalUseRegistry(FALSE, '')
.head 4 -  Call SalGetProfileString('Import', 'MoperPath', SalStrLeftX(SalFileGetDrive(), 1) ||
     ':\\BARS98\\ODBC.DSN\\Moper', sODBCDir, GetIniFileName())
.head 4 -  !
.head 4 -  Call FileZNListBox()
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Call SalHideWindow(dfStart)
.head 4 -  Call SalHideWindow(dfEnd)
.head 4 -  Call SalSetFocus(pbExit)
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_Destroy
.head 4 -  Call ConPara('POP')
.head 4 -  Call SalWaitCursor(FALSE)
.head 1 +  Table Window: TB_NO
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Построение возможных связей ФУ и НУ 
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
.head 4 -  Left:   0.63"
.head 4 -  Top:    0.958"
.head 4 -  Width:  13.329"
.head 4 -  Width Editable? Class Default
.head 4 -  Height: 6.073"
.head 4 -  Height Editable? Class Default
.head 3 -  Font Name: Class Default
.head 3 -  Font Size: 8
.head 3 -  Font Enhancement: Class Default
.head 3 -  Text Color: Royal Blue
.head 3 -  Background Color: Class Default
.head 3 -  View: Class Default
.head 3 -  Allow Row Sizing? Class Default
.head 3 -  Lines Per Row: Class Default
.head 2 -  Memory Settings
.head 3 -  Maximum Rows in Memory: 20000
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
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 +  If NLSN=STRING_Null
.head 8 +  If SqlPrepareAndExecute( hSqlAux2(), "INSERT INTO SBULINK (nls) VALUES (:TB_NO.sNLS)")
.head 9 -  Call SqlCommit( hSqlAux2() )
.head 8 +  Else
.head 9 -  Call SqlRollback( hSqlAux2() )
.head 7 -  Call SalSendClassMessage( SAM_Click, 0, 0 )
.head 4 -  Line
.head 5 -  Resource Id: 27315
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? No
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
.head 5 +  Message Actions
.head 6 +  ! On SAM_Create
.head 7 -              Set strTip = 'Установить фильтр'
.head 4 +  Pushbutton: pbDetails
.head 5 -  Class Child Ref Key: 39
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.883"
.head 6 -  Top:    0.071"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Childs.bmp
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  ! On SAM_Click
.head 7 +           If SqlPrepareAndExecute(hSqlAux(),
  "UPDATE "|| NAL_DEC || " SET nls=VKRZN(:AMF,nls) WHERE nls is not null") 
and  SqlPrepareAndExecute(hSqlAux(), 
  "UPDATE nal_dec8 SET nls8=VKRZN(:AMF,nls8) WHERE nls8 is not null") 
and SqlPrepareAndExecute(hSqlAux(), "Commit")
and SqlPrepareAndExecute( hSqlAux2(),
  "SELECT m.nls,a.acc, m.DD||' '||m.RR||' '||substr(m.nms,1,30)
   INTO :NLS8,:ACC,:NMS
   FROM nal_dec8 n, accounts a, " || NAL_DEC || " m
   WHERE m.nls=n.nls8 and substr(m.nls,1,1)='8' and n.nls=a.nls and a.kv=:n980_
   ORDER BY m.nls")
.head 8 -  ! Цикл по таблице для линкования и открытия NLS8
.head 8 -           Set bFL = TRUE
.head 8 +           While SqlFetchNext(hSqlAux2(), nFetchRes)
.head 9 +           If NLS8_OLD != NLS8
.head 10 -  ! Попытка Открыть счет NLS8 ! Получить асс NLS8
.head 10 +           If not Op_Reg(99,0,0,0,nTmp,RNK,NLS8,n980_,NMS,'ODB',ISP,ACC8)
.head 11 -           Set bFL=FALSE
.head 11 -           Break 
.head 10 -           Set NLS8_OLD = NLS8
.head 9 -  ! Пролинковать
.head 9 +           If not SqlPrepareAndExecute( hSql(),
"UPDATE accounts SET accc=:ACC8 WHERE acc=:ACC") 
.head 10 -           Set bFL=FALSE
.head 10 -           Break 
.head 8 +           If bFL
.head 9 -           Call SqlCommitEx(hSql(), 'Установлена связь Фин-Упр учет')
.head 9 -           Call SalWaitCursor(FALSE)
.head 9 -           Call MessageNoWait('Установлена связь Фин-Упр учет',
     'Сообщение', 3, 0)
.head 9 -  ! If SqlPrepareAndExecute( hSql(),
"SELECT NVL(min(fdat), BANKDATE) INTO :DAT_ FROM saldoa " )
and SqlFetchNext(hSql(), nFetchRes)
.head 9 +           If nPar = 1
.head 10 -           Call SalShowWindow( DAT_ )
.head 10 -           Call SalSetFocus( DAT_ )
.head 10 +           If SalMessageBox("Установить сумму остатков на счетах НУ ?",
   "Стартовая дата для взятия остатков "|| Subs(SalFmtFormatDateTime( DAT_, 'DD/mm/YYYY'),1,10),  
MB_IconQuestion | MB_YesNo) = IDYES
.head 11 -           Call SalWaitCursor(TRUE)
.head 11 +           If SalStrTrimX(SalStrUpperX( GetDBMS() ))='ORACLE'
.head 12 -  ! Call SqlPrepareAndExecute( hSql(), "set transaction use rollback segment R04" )
.head 12 +           If SqlPLSQLCommand( hSql(), " NU_START(DAT_) ")
.head 13 -           Call SqlCommit( hSql() )
.head 13 -           Call MessageNoWait('Установлены остатки на счетах НУ с '|| 
Subs(SalFmtFormatDateTime( DAT_, 'DD/mm/YYYY'),1,10), 'Сообщение', 1, 0)
.head 12 +           Else 
.head 13 -           Call SqlRollback( hSql() )
.head 13 -           Call MessageNoWait('Неуспешная попытка установки остатков' , 'Внимание', 0, 2)
.head 8 -           Call SqlPrepareAndExecute(hSql(), "Rollback")
.head 7 -           Call SalWaitCursor(FALSE)
.head 6 +  ! On SAM_Create
.head 7 -           Set strTip = 'Установить связь'
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 40
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.917"
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
.head 5 -  Resource Id: 27316
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? No
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
.head 6 -  Left:   6.85"
.head 6 -  Top:    0.048"
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
.head 5 -  Resource Id: 27317
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
.head 3 +  Column: sNLS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ЛС
финансового
учета
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.429"
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
.head 5 +  On SAM_Validate
.head 6 -  Call SqlPrepareAndExecute(hSql(), "
     SELECT nms
     INTO :sNMS
     FROM accounts
     WHERE kv=:n980_ AND nls=:sNLS")
.head 6 -  Call SalTblSetCellTextColor(sNLS,
     IifN(SqlFetchNext(hSql(), nFetchRes),
     COLOR_DarkBlue, COLOR_DarkRed), FALSE)
.head 3 +  Column: sNMS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование ЛС
финансового учета
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
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
.head 3 +  Column: sNLS8
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ЛС 
налогового
учета
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.643"
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
.head 5 +  On SAM_Validate
.head 6 -  If SqlPrepareAndExecute(hSql(),
  "SELECT dd,pp,rr INTO :sDD,:sPP,:sRR  FROM " || NAL_DEC || " WHERE nls=:sNLS8")
and SqlFetchNext(hSql(), nFetchRes)
.head 3 +  Column: sNMS8
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenColComboBox_StrId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ЛС и Наименование ЛС
налогового  учета
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  4.486"
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
.head 6 -  Call sNMS8.Init( hWndItem )
.head 6 -  Call sNMS8.Populate( hSql(), "NLS", "substr(nls||'         ',1,15)||DD||' '||RR||' '||NMS", 
NAL_DEC, " WHERE NLS>0 ORDER BY DD,PP,RR" )
.head 5 +  On SAM_Validate
.head 6 -  Set sNLS8 = sNMS8.GetKey( SalListQuerySelection(hWndItem))
.head 6 -  If SqlPrepareAndExecute(hSql(),
  "SELECT dd,pp,rr INTO :sDD,:sPP,:sRR  FROM " || NAL_DEC || " WHERE nls=:sNLS8")
and SqlFetchNext(hSql(), nFetchRes)
.head 3 +  Column: sDD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Доп.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.5"
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
.head 3 +  Column: sPP
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: №
п/п
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.629"
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
.head 3 +  Column: sRR
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Стр.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.486"
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
.head 3 +  Column: RI
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  4.883"
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
.head 3 +  Column: AC
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
.head 4 -  Width:  4.883"
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
.head 3 +  Column: NLSN
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  4.883"
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
.head 3 +  Column: Summa
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Остаток на счете ФУ
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.117"
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
.head 3 -  Number: nParam
.head 2 +  Window Variables
.head 3 -  Number: nPar100
.head 3 -  Number: nPar
.head 3 -  !
.head 3 -  Number: nI
.head 3 -  Number: n980_
.head 3 -  Number: ACC8
.head 3 -  Number: ACC
.head 3 -  Number: RNK
.head 3 -  String: NLS8
.head 3 -  String: NLS8_OLD
.head 3 -  String: NLS
.head 3 -  String: NMS
.head 3 -  String: AMF
.head 3 -  String: sTmp
.head 3 -  Number: ISP
.head 3 -  Boolean: bFL
.head 3 -  Number: nS
.head 3 -  Number: S
.head 3 -  Number: nS8
.head 3 -  Number: nTmp
.head 3 -  Number: nFetchRes
.head 3 -  String: NAL_DEC
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 +  If nParam > 100
.head 5 -  Set nPar100 = 100
.head 5 -  Set nPar = nParam -100
.head 5 -  Set NAL_DEC = 'NAL_DEC3'
.head 4 +  Else
.head 5 -  Set nPar100 = 0
.head 5 -  Set nPar = nParam 
.head 5 -  Set NAL_DEC = 'NAL_DEC'
.head 4 -  ! Set DAT_ = GetBankDate()
.head 4 +  If nPar = 7
.head 5 -  ! Call SalHideWindow( DAT_ )
.head 4 -  Set TB_NO.strPrintFileName = 'SBULINK'
.head 4 -  Set TB_NO.strFilterTblName = 'ACCOUNTS'
.head 4 -  Set TB_NO.nTabInstance = 1
.head 4 -  Call SalTblSetLockedColumns( hWndForm,2 )
.head 4 -  ! Открыть счета 8 класа
.head 4 -  ! Kонстанты
.head 4 -  Set TB_NO.n980_ = GetBaseVal()
.head 4 -  Set NLS8_OLD = '*'
.head 4 -  Set AMF = SalStrLeftX(GetBankMfo(), 5)
.head 4 -  Set ISP = GetUserId()
.head 4 +  If SqlPrepareAndExecute(hSqlAux(), 
   "SELECT val+0 INTO :RNK   FROM params  WHERE par='OUR_RNK'")
and not SqlFetchNext(hSqlAux(), nFetchRes)
.head 5 -  Set RNK=1
.head 4 -  !
.head 4 -  !
.head 4 -  ! Set TB_NO.strSqlPopulate=
"SELECT NAL_DEC8.nls, a.nms, n.nls, substr(n.nls||'         ',1,15) || n.NMS,   
        n.DD, n.PP, n.RR, a.ACC, NAL_DEC8.rowid
 INTO   :TB0.sNLS,:TB0.sNMS,:TB0.sNLS8,:TB0.sNMS8,
        :TB0.sDD, :TB0.sPP, :TB0.sRR,:TB0.AC,:TB0.RI
 FROM NAL_DEC8, ACCOUNTS a, " || NAL_DEC || " n 
 WHERE NAL_DEC8.nls = a.nls (+) AND a.kv (+) =:n980_ AND n.nls=NAL_DEC8.nls8
 ORDER BY decode(a.acc,null,0,1), n.DD, n.ord "
.head 4 -  Set TB_NO.strSqlPopulate=
"SELECT ACCOUNTS.nls, ACCOUNTS.nms, n.nls, substr(n.nls||'         ',1,15) || n.NMS,   
        n.DD, n.PP, n.RR, ACCOUNTS.ACC, SBULINK.rowid, SBULINK.nls, ACCOUNTS.ostc/100
 INTO   :TB_NO.sNLS,:TB_NO.sNMS,:TB_NO.sNLS8,:TB_NO.sNMS8,
        :TB_NO.sDD, :TB_NO.sPP, :TB_NO.sRR,:TB_NO.AC,:TB_NO.RI, :TB_NO.NLSN, :TB_NO.Summa
 FROM SBULINK, ACCOUNTS, " || NAL_DEC || " n 
 WHERE ACCOUNTS.nls = SBULINK.nls (+) AND ACCOUNTS.kv (+) = " || Str(TB_NO.n980_)||" AND n.nls (+) = SBULINK.nls8 AND ACCOUNTS.ACCC IS NULL AND (ACCOUNTS.NLS LIKE '6%' OR ACCOUNTS.NLS LIKE '7%' )
 ORDER BY decode(ACCOUNTS.acc,null,0,1), n.DD, n.ord "
.head 4 -  Set TB_NO.strSqlUpdate="UPDATE SBULINK SET nls8=:TB_NO.sNLS8 WHERE nls=:TB_NO.sNLS"
.head 4 -  ! Set TB_NO.strSqlUpdate="UPDATE SBULINK SET nls=:TB_NO.sNLS, nls8=:TB_NO.sNLS8 WHERE rowid=:TB_NO.RI"
.head 4 -  Set TB_NO.strSqlDelete="DELETE FROM SBULINK WHERE rowid=:TB_NO.RI"
.head 4 -  ! Set TB_NO.strSqlInsert="INSERT INTO SBULINK (nls,nls8) VALUES (:TB_NO.sNLS,:TB_NO.sNLS8)"
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On SAM_FetchRowDone
.head 4 +  If AC = NUMBER_Null
.head 5 -  Call SalTblSetCellTextColor( sNLS, COLOR_Red, FALSE )
.head 1 +  Table Window: TB_ND
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Заготовка декларації ПО для автовідкриття рахунків
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
.head 4 -  Left:   0.59"
.head 4 -  Top:    0.908"
.head 4 -  Width:  13.533"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 6.073"
.head 4 -  Height Editable? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Black
.head 3 -  Background Color: Default
.head 3 -  View: Table
.head 3 -  Allow Row Sizing? No
.head 3 -  Lines Per Row: Default
.head 2 -  Memory Settings
.head 3 -  Maximum Rows in Memory: 20000
.head 3 -  Discardable? No
.head 2 -  Description: Заготовка декларации для автооткрытия счетов
.head 2 -  Named Menus
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.476"
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
.head 6 -  Left:   0.086"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
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
.head 6 -  Left:   0.514"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
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
.head 6 -  Left:   0.043"
.head 6 -  Top:    0.063"
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
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Перечитати'
.head 4 +  Pushbutton: pbUpdate
.head 5 -  Class Child Ref Key: 36
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.371"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
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
.head 5 -  Resource Id: 37433
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  3.1"
.head 6 -  Begin Y:  -0.021"
.head 6 -  End X:  3.1"
.head 6 -  End Y:  0.438"
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
.head 6 -  Left:   0.471"
.head 6 -  Top:    0.063"
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
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Пошук значення'
.head 4 +  Pushbutton: pbFilter
.head 5 -  Class Child Ref Key: 44
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.9"
.head 6 -  Top:    0.063"
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
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Відібрати (фільтр)'
.head 4 +  Pushbutton: pbDetails
.head 5 -  Class Child Ref Key: 39
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.514"
.head 6 -  Top:    0.063"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Open.bmp
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
.head 6 -  Left:   1.943"
.head 6 -  Top:    0.063"
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
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Друк'
.head 4 -  Line
.head 5 -  Resource Id: 37434
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  2.457"
.head 6 -  Begin Y:  -0.052"
.head 6 -  End X:  2.457"
.head 6 -  End Y:  0.406"
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
.head 6 -  Left:   2.571"
.head 6 -  Top:    0.063"
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
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Вихід'
.head 4 -  Line
.head 5 -  Resource Id: 37435
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  1.414"
.head 6 -  Begin Y:  -0.031"
.head 6 -  End X:  1.414"
.head 6 -  End Y:  0.427"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 +  Pushbutton: pbOpen
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbExecute
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.6"
.head 6 -  Top:    0.063"
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
.head 7 -  Set strTip = 'Відкрити виділені рахунки'
.head 6 +  On SAM_Click
.head 7 +  If SalTblAnyRows( hWndForm, ROW_Selected, 0 )
.head 8 -  Set nRow = TBL_MinRow
.head 8 +  While SalTblFindNextRow( hWndForm, nRow, ROW_Selected, 0 )
.head 9 -  Call SalTblSetContext( hWndForm, nRow )
.head 9 +  If not Op_Reg(99, 0, 0, GRP, nTmp, RNK, NLS, n980,
              NMS, 'ODB', ISP, ACC)
.head 10 -  Call SalMessageBox('Ошибка при открытии счета ' ||
     NLS, 'Внимание', MB_Ok | MB_IconAsterisk)
.head 10 -  Call SqlRollback( hSql() )
.head 9 +  Else
.head 10 -  Call SalMessageBox(
 "Виконано відкриття/поновлення параметрів рахунку ПО "||NLS ,
 "У В А Г А ! ", MB_Ok )
.head 10 -  Call SqlCommit(hSql())
.head 7 +  Else
.head 8 -  Call SalMessageBox(
 "Оберіть рахунки для відкриття!" ,
 "У В А Г А ! ", MB_Ok )
.head 4 -  Line
.head 5 -  Resource Id: 37436
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  4.1"
.head 6 -  Begin Y:  -0.021"
.head 6 -  End X:  4.1"
.head 6 -  End Y:  0.438"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 2 +  Contents
.head 3 +  Column: DD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Додаток
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Right
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
.head 3 +  Column: RR
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Рядок
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.9"
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
.head 4 -  Title: ОР
податкового 
обліку
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.467"
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
.head 4 -  Title: Найменування
показника ПО
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Long String
.head 4 -  Justify: Left
.head 4 -  Width:  8.617"
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
.head 3 -  Number: nParam
.head 2 +  Window Variables
.head 3 -  String: NAL_DEC
.head 3 -  Number: RNK
.head 3 -  Number: n980
.head 3 -  Number: ACC
.head 3 -  String: AMF
.head 3 -  Number: ISP
.head 3 -  Number: GRP
.head 3 -  Number: nTmp
.head 3 -  Number: nFetchRes
.head 3 -  Number: nRow
.head 2 +  Message Actions
.head 3 +  ! On SAM_Create
.head 4 +  ! If nParam >100
.head 5 -          Set NAL_3 = 'NAL_33' 
.head 5 -          Set TITL = 'НОВОГО'
.head 4 +  ! Else
.head 5 -          Set NAL_3 = 'NAL_3' 
.head 5 -          Set TITL = 'СТАРОГО'
.head 4 -  ! Call SalSetWindowText( hWndForm, "Просмотр связи финансового и "||TITL||" налогового учета" )
.head 4 -  ! Call WaitCursorOn()
.head 4 -  ! Call PrepareWindow( hWndForm )
.head 4 -  ! Call SetWindowFullSize( hWndForm )
.head 4 -  ! Set TB6.strPrintFileName = 'NAL_3'
.head 4 -  ! Set TB6.strFilterTblName = 'NAL_3'
.head 4 -  ! Set TB6.strSqlPopulate ="
    SELECT rnk, nmk, nls_FU, nms_FU, flag, DD, RR 
    INTO :TB6.RNK,:TB6.NMK,:TB6.NLS,:TB6.NMS,:TB6.FLAG,:TB6.DD,:TB6.RR
    FROM "|| NAL_3  || " ORDER BY rnk,DD,RR "
.head 4 -  ! Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On SAM_Create
.head 4 +  If nParam = 155
.head 5 -  Set NAL_DEC = 'NAL_DEC3'
.head 4 +  Else
.head 5 -  Set NAL_DEC = 'NAL_DEC'
.head 4 -  Call PrepareWindow( hWndForm )
.head 4 -  Call SetWindowFullSize( hWndForm )
.head 4 -  Set TB_ND.strPrintFileName = NAL_DEC
.head 4 -  Set TB_ND.strFilterTblName = NAL_DEC
.head 4 -  Set AMF = SalStrLeftX(GetBankMfo(), 5)
.head 4 -  Set TB_ND.n980 = GetBaseVal()
.head 4 -  Set TB_ND.ISP  = GetUserId()
.head 4 -  Set TB_ND.GRP  = GetUserId()
.head 4 +  If SqlPrepareAndExecute(hSqlAux(), "SELECT val+0 INTO :RNK FROM params  WHERE par='OUR_RNK'")
and not SqlFetchNext(hSqlAux(), nFetchRes)
.head 5 -  Set RNK=1
.head 4 -  Set TB_ND.strSqlPopulate ="
    SELECT dd, rr, nls, nms||' '||nms1  
    INTO :TB_ND.DD,:TB_ND.RR,:TB_ND.NLS,:TB_ND.NMS 
    FROM "|| NAL_DEC  || " ORDER BY DD,RR "
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 1 +  Table Window: OB22NU
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Проводки налогового учёта по ОБ22
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Class Default
.head 2 -  Visible? Class Default
.head 2 -  Display Settings
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? Class Default
.head 3 -  Initial State: Maximized
.head 3 -  Maximizable? Class Default
.head 3 -  Minimizable? Class Default
.head 3 -  System Menu? Class Default
.head 3 -  Resizable? Class Default
.head 3 -  Window Location and Size
.head 4 -  Left:   2.438"
.head 4 -  Top:    0.938"
.head 4 -  Width:  15.517"
.head 4 -  Width Editable? Class Default
.head 4 -  Height: 7.012"
.head 4 -  Height Editable? Class Default
.head 3 -  Font Name: Default
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
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Снять без проводок'
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
.head 5 -  Resource Id: 23243
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
.head 5 -  Resource Id: 23244
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
.head 6 -  Left:   4.033"
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
.head 5 -  Resource Id: 23245
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
.head 4 +  Pushbutton: pb_Nal
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbExecute
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   6.483"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Execute.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 -  On SAM_Create
.head 6 +  On SAM_Click
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, ROW_MarkDeleted)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 -  ! nRow >= 0 - чтоб не бралась итоговая строка
.head 8 +  If nRow >= 0
.head 9 -  ! Дополнительная проверка, чтобы 2 пользователя не оплатили документ
.head 9 -  ! Проверка: проводка не оплачена (флаг 1) и не снята с обработки (флаг 2)
.head 9 +  If SqlPrepareAndExecute(hSql(), 
"select count(*) into :nCount 
   from opldok 
  where ref = :REF and stmt = :STMT
    and bitand(nvl(otm,0),1) = 0
    and bitand(nvl(otm,0),2) = 0")
and SqlFetchNext(hSql(), nFetchRes) and nCount > 0
.head 10 -  Set bOk = TRUE
.head 10 -  Call Pl_dat(IifD(VOB=96 or VOB=99, O_VDAT, VDAT))
.head 10 -  !
.head 10 -  ! 1-й документ (если нужно) - если 2 счета НУ
.head 10 +  If bOk and colKontrAcc_D
.head 11 -  ! NLSD нас интересует? он должен быть в sb_p0853.r020_fa
.head 11 +  If SqlPrepareAndExecute(hSql(), "select count(*) into :nCount from sb_p0853 where r020_fa=substr(:NLSD,1,4)")
and SqlFetchNext(hSql(), nFetchRes) and nCount > 0
.head 12 -  Set sNLSA = colKontrAcc_D
.head 12 -  Set sNLSB = NLS8_D
.head 12 -  Set nS = IifN(SN!=NUMBER_Null, SN, S) * 100
.head 12 +  If not cDoc.PayV(1, REF, IifD(VOB=96 or VOB=99, O_VDAT, VDAT), 'PO3', 1, n980, sNLSA, nS, n980, sNLSB, nS)
.head 13 -  Set bOk = FALSE
.head 10 -  ! 2-й документ (если нужно) - если 2 счета НУ
.head 10 +  If bOk and colKontrAcc_K
.head 11 -  ! NLSK нас интересует? он должен быть в sb_p0853.r020_fa
.head 11 +  If SqlPrepareAndExecute(hSql(), "select count(*) into :nCount from sb_p0853 where r020_fa=substr(:NLSK,1,4)")
and SqlFetchNext(hSql(), nFetchRes) and nCount > 0
.head 12 -  Set sNLSA = NLS8_K
.head 12 -  Set sNLSB = colKontrAcc_K
.head 12 -  Set nS = IifN(SN!=NUMBER_Null, SN, S) * 100
.head 12 +  If not cDoc.PayV(1, REF, IifD(VOB=96 or VOB=99, O_VDAT, VDAT), 'PO3', 1, n980, sNLSA, nS, n980, sNLSB, nS)
.head 13 -  Set bOk = FALSE
.head 10 -  !
.head 10 +  If bOk
.head 11 -  ! установить флаг 1 = 'Проводка обработана': set otm = bitand(nvl(otm,0),254)+1
.head 11 +  If SqlPrepareAndExecute(hSqlAux2(),
"update opldok
    set otm = bitand(nvl(otm,0),254)+1
  where ref  = :hWndForm.OB22NU.REF
    and stmt = :hWndForm.OB22NU.STMT")
.head 12 -  Call SqlCommitEx(hSqlAux2(), "NU. Выполнена проводка по док." || Str(REF) || ", установлен флаг 'Проводка бработана'")
.head 12 -  ! Остались необработанные проводки?
.head 12 -  Call SqlPrepareAndExecute(hSqlAux2(), 
"select count(*) into :nCount
   from opldok 
  where ref = :REF
    and bitand(nvl(otm,0),1) = 0
    and bitand(nvl(otm,0),2) = 0
    and tt <> 'PO3'")
.head 12 -  ! не остались - ставим визу об окончательной обработке
.head 12 +  If SqlFetchNext(hSqlAux2(), nFetchRes) and nCount = 0
.head 13 +  If SqlPrepareAndExecute(hSqlAux2(),
"insert into oper_visa (ref, dat, userid, groupid, status, passive)
 values (:REF, SYSDATE, :nUserId, :nGrp, 2, null)")
.head 14 -  Call SqlCommitEx(hSqlAux2(), "NU. Обработан док." || Str(REF))
.head 13 +  Else
.head 14 -  Call SqlRollbackEx(hSqlAux2(), "NU. Ошибка insert into oper_visa док." || Str(REF) || " (OPER_VISA)")
.head 11 +  Else
.head 12 -  Call SqlRollbackEx(hSqlAux2(), "NU. Ошибка установки флага 'Проводка бработана' по док." || Str(REF))
.head 10 +  Else
.head 11 -  Call SqlRollbackEx(hSqlAux2(), "NU. Ошибка выполнения проводки по док." || Str(REF))
.head 7 -  Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
.head 7 -  Call SalWaitCursor(FALSE)
.head 6 +  On SAM_TooltipSetText
.head 7 -  Return XSalTooltipSetText(lParam, IifS(GetLang()='RUS', 'Выполнить проводки налогового учёта',
       IifS(GetLang()='UKR', 'Виконати проводки податкового обліку', 'To execute wirings of the fiscal accounting')))
.head 4 +  Data Field: Dat_End
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Editable? Yes
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   9.2"
.head 7 -  Top:    0.107"
.head 7 -  Width:  1.75"
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
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 +  Message Actions
.head 6 +  On SAM_Validate
.head 7 +  If Dat_End < Dat_Beg
.head 8 -  Return VALIDATE_Cancel
.head 7 -  Return VALIDATE_Ok
.head 4 +  Data Field: Dat_Beg
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Editable? Yes
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   7.0"
.head 7 -  Top:    0.107"
.head 7 -  Width:  1.75"
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
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 +  Message Actions
.head 6 +  On SAM_Validate
.head 7 +  If Dat_End < Dat_Beg
.head 8 -  Return VALIDATE_Cancel
.head 7 -  Return VALIDATE_Ok
.head 2 +  Contents
.head 3 +  Column: PRIZN
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ознака
обов`язк.
(1-100%,
3 -може,
0-ні)
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
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
.head 3 +  Column: REF
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Реф
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.233"
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
.head 5 +  On SAM_SetFocus
.head 6 -  Set nTmp = MyValue
.head 5 +  On SAM_AnyEdit
.head 6 -  Set MyValue = nTmp
.head 3 +  Column: VDAT
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
вал.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.2"
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
.head 3 +  Column: NLSD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Счет
дебет
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
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
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Set sTmp = MyValue
.head 5 +  On SAM_AnyEdit
.head 6 -  Set MyValue = sTmp
.head 3 +  Column: NLSK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Счет
кредит
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
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
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Set sTmp = MyValue
.head 5 +  On SAM_AnyEdit
.head 6 -  Set MyValue = sTmp
.head 3 +  Column: NLS8_D
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Счет
нал.учёта-Д
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
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
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Set sTmp = MyValue
.head 5 +  On SAM_AnyEdit
.head 6 -  Set MyValue = sTmp
.head 3 +  Column: colKontrAcc_D
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Контрсчет-Д
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
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
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Set sTmp = MyValue
.head 5 +  On SAM_AnyEdit
.head 6 -  Set MyValue = sTmp
.head 3 +  Column: OB22_D
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ОБ22-Д
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.7"
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
.head 3 +  Column: NLS8_K
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Счет
нал.учёта-К
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
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
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Set sTmp = MyValue
.head 5 +  On SAM_AnyEdit
.head 6 -  Set MyValue = sTmp
.head 3 +  Column: colKontrAcc_K
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Контрсчет-К
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
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
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Set sTmp = MyValue
.head 5 +  On SAM_AnyEdit
.head 6 -  Set MyValue = sTmp
.head 3 +  Column: OB22_K
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ОБ22-К
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.7"
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
.head 4 -  Title: Сумма
фин.учёта
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.883"
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
.head 3 +  Column: SN
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сумма
нал.учёта
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.883"
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
.head 4 +  Message Actions
.head 5 +  On SAM_Validate
.head 6 +  If SN < 0
.head 7 -  Return VALIDATE_Cancel
.head 3 +  Column: NAZN
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Назначение
платежа
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.883"
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
.head 5 +  On SAM_SetFocus
.head 6 -  Set sTmp = MyValue
.head 5 +  On SAM_AnyEdit
.head 6 -  Set MyValue = sTmp
.head 3 +  Column: NMS8
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
счёта нал.учёта
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.517"
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
.head 5 +  On SAM_SetFocus
.head 6 -  Set sTmp = MyValue
.head 5 +  On SAM_AnyEdit
.head 6 -  Set MyValue = sTmp
.head 3 +  Column: DK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ДК
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  2.517"
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
.head 4 -  Title: Vob
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
.head 3 +  Column: O_VDAT
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
вал. oper
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.2"
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
.head 3 +  Column: STMT
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
.head 3 +  Column: OTM
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
.head 3 +  Column: PAPD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
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
.head 3 +  Column: PAPK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
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
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  ! Number: nKonrt
.head 2 +  Window Variables
.head 3 -  : cDoc
.head 4 -  Class: cDoc
.head 3 -  !
.head 3 -  String: sDat
.head 3 -  Date/Time: bDat
.head 3 -  Number: n980
.head 3 -  Number: nUserId
.head 3 -  Number: nGrp
.head 3 -  Number: nGrpN
.head 3 -  String: sNU_KS6 
.head 3 -  String: sNU_KS7
.head 3 -  !
.head 3 -  Number: nRow
.head 3 -  !
.head 3 -  String: sKontr
.head 3 -  String: sNLSA
.head 3 -  String: sNLSB
.head 3 -  Number: nS
.head 3 -  String: sFilter
.head 3 -  ! Итоги
.head 3 -  Number: nCount
.head 3 -  Number: nSum
.head 3 -  String: sNlsd_n
.head 3 -  String: sNlsk_n
.head 3 -  Boolean: bOk
.head 3 -  !
.head 3 -  Number: nTmp
.head 3 -  String: sTmp
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Set hWndForm.OB22NU.nFlags = GT_NoIns
.head 4 -  Set hWndForm.OB22NU.strFilterTblName = 'v_ob22nu_f'
.head 4 -  Set OB22NU.strPrintFileName = 'OB22NU'
.head 4 -  Set hWndForm.OB22NU.nTabInstance = 1
.head 4 -  ! установить флаг 1 = 'Проводка обработана':         set otm = bitand(nvl(otm,0),254)+1
.head 4 -  ! установить флаг 2 = 'Проводка снята из обработки': set otm = bitand(nvl(otm,0),253)+2
.head 4 -  Set hWndForm.OB22NU.strSqlDelete = 
"update opldok
    set otm = bitand(nvl(otm,0),253)+2
  where ref  = :hWndForm.OB22NU.REF
    and stmt = :hWndForm.OB22NU.STMT"
.head 4 -  Set bDat    = GetBankDate()
.head 4 -  Set Dat_Beg = GetBankDate()
.head 4 -  Set Dat_End = GetBankDate()
.head 4 -  Set n980    = GetBaseVal()
.head 4 -  Set nUserId = GetUserId()
.head 4 -  Set nGrp    = GetGlobalOptionEx('NU_CHCK')
.head 4 -  Set nGrpN   = GetGlobalOptionEx('NU_CHCKN')
.head 4 -  Set sNU_KS6 = GetGlobalOption('NU_KS6')
.head 4 -  Set sNU_KS7 = GetGlobalOption('NU_KS7')
.head 4 -  !
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 -  On SAM_CreateComplete
.head 3 +  ! On UM_Populate
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set sFilter = cF.GetFilterWhereClause(FALSE)
.head 4 -  Set nCount = 0
.head 4 -  Set nSum   = 0
.head 4 -  ! Set OB22NU.strSqlPopulate = 
"SELECT prizn, nlsn, ob22, fdat, ref, nlsd, nlsk, s, nazn, nmsn, vob, vdat, stmt, otm
   INTO :OB22NU.PRIZN, :OB22NU.NLS8, :OB22NU.OB22, :OB22NU.VDAT, :OB22NU.REF,
        :OB22NU.NLSD, :OB22NU.NLSK, :OB22NU.S, :OB22NU.NAZN, :OB22NU.NMS8, :OB22NU.VOB, :OB22NU.O_VDAT, 
        :OB22NU.STMT, :OB22NU.OTM
   FROM ( SELECT n.prizn, n.nlsn, n.ob22, p.fdat, p.ref, p.nlsd, p.nlsk, 
                 p.s/100 s, p.nazn, n.nmsn, p.vob, p.vdat, p.stmt, p.otm
            FROM provodkin p, v_ob22nu n 
           WHERE (p.accd=n.acc or p.acck=n.acc) 
             and p.fdat >= :OB22NU.Dat_Beg and p.fdat <= :OB22NU.Dat_End 
             and bitand(nvl(p.otm,0),1) = 0
             and bitand(nvl(p.otm,0),2) = 0) v_ob22nu_f 
  WHERE not exists (select 1 from oper_visa where ref=v_ob22nu_f.ref and groupid=:nGrp)" || 
        IifS(sFilter!="", " and ", "") || sFilter || "
  ORDER BY ob22, ref"
.head 4 -  Set OB22NU.strSqlPopulate = 
"SELECT prizn, nlsn_d, ob22_d, nlsn_k, ob22_k, fdat, ref, nlsd, nlsk, 
        s, nazn, nmsn, vob, vdat, stmt, otm, d.pap, k.pap
   INTO :OB22NU.PRIZN, :OB22NU.NLS8_D, :OB22NU.OB22_D, :OB22NU.NLS8_K, :OB22NU.OB22_K, 
        :OB22NU.VDAT, :OB22NU.REF, :OB22NU.NLSD, :OB22NU.NLSK, 
        :OB22NU.S, :OB22NU.NAZN, :OB22NU.NMS8, :OB22NU.VOB, :OB22NU.O_VDAT,
        :OB22NU.STMT, :OB22NU.OTM, :OB22NU.PAPD, :OB22NU.PAPK
   FROM ( SELECT case 
                   when nvl(n.prizn,0)=1 or nvl(n2.prizn,0)=1 then 1 
                   when nvl(n.prizn,0)=3 or nvl(n2.prizn,0)=3 then 3
                   else 0
                 end prizn, n.nlsn nlsn_d, n.ob22 ob22_d, n2.nlsn nlsn_k, n2.ob22 ob22_k, p.fdat, p.ref, p.nlsd, p.nlsk, 
                 p.s/100 s, p.nazn, n.nmsn, p.vob, p.vdat, p.stmt, p.otm, p.accd, p.acck
            FROM provodkin p, v_ob22nu n, v_ob22nu n2 
           WHERE p.accd=n.acc(+) and p.acck=n2.acc(+)
             and p.fdat >= :OB22NU.Dat_Beg and p.fdat <= :OB22NU.Dat_End 
             and bitand(nvl(p.otm,0),1) = 0
             and bitand(nvl(p.otm,0),2) = 0) v_ob22nu_f, accounts d, accounts k  
  WHERE (ob22_d is not null or ob22_k is not null)
    and not exists (select 1 from oper_visa where ref=v_ob22nu_f.ref and groupid=:nGrp)
    and accd = d.acc and acck = k.acc " || 
        IifS(sFilter!="", " and ", "") || sFilter || "
  ORDER BY ob22_d, ref"
.head 4 -  Call SalTblPopulate(hWndForm, hSql(), OB22NU.strSqlPopulate, TBL_FillAll)
.head 4 -  Call SalTblSetContext(hWndForm, 0)
.head 4 -  Call SalPostMsg(hWndForm, SAM_TblDoDetails, 0, 0)
.head 4 -  ! Итоги
.head 4 -  Call SalTblDefineSplitWindow(hWndForm, 1, TBL_Split_Adjustable)
.head 4 -  Call SalTblFetchRow(hWndForm, SalTblInsertRow(hWndForm, TBL_MinSplitRow))
.head 4 -  Call SalTblSetFlagsAnyRows(hWndForm, ROW_New, FALSE, 0, 0)
.head 4 -  Set NLS8_D = 'Всего'
.head 4 -  Set OB22_D = Str(nCount)
.head 4 -  Set S    = nSum
.head 4 -  Call VisTblAutoSizeColumn(hWndForm, hWndNULL)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On UM_Populate
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set sFilter = cF.GetFilterWhereClause(FALSE)
.head 4 -  Set nCount = 0
.head 4 -  Set nSum   = 0
.head 4 +  If not SqlPLSQLCommand(hSql(), "p_ob22nu(Dat_Beg, Dat_End)")
.head 5 -  Call SqlRollback(hSql())
.head 5 -  Return FALSE
.head 4 -  Call SqlCommit(hSql())
.head 4 -  Set OB22NU.strSqlPopulate = 
"SELECT prizn, nlsn_d, ob22_d, nlsn_k, ob22_k, fdat, ref, nlsd, nlsk, 
        s, nazn, nmsn, vob, vdat, stmt, otm, d.ap, k.ap
   INTO :OB22NU.PRIZN, :OB22NU.NLS8_D, :OB22NU.OB22_D, :OB22NU.NLS8_K, :OB22NU.OB22_K, 
        :OB22NU.VDAT, :OB22NU.REF, :OB22NU.NLSD, :OB22NU.NLSK, 
        :OB22NU.S, :OB22NU.NAZN, :OB22NU.NMS8, :OB22NU.VOB, :OB22NU.O_VDAT,
        :OB22NU.STMT, :OB22NU.OTM, :OB22NU.PAPD, :OB22NU.PAPK
   FROM ( select prizn, nlsn_d, ob22_d, nlsn_k, ob22_k, fdat, ref, nlsd, nlsk, 
                 s/100 s, nazn, nmsn, vob, vdat, stmt, otm, accd, acck, p080_d, p080_k
            from tmp_ob22_funu ) v_ob22nu_f, sb_p0853 d, sb_p0853 k  
  WHERE (ob22_d is not null or ob22_k is not null)
    and not exists (select 1 from oper_visa where ref=v_ob22nu_f.ref and groupid=:nGrp)
    and d.r020(+) = substr(nlsn_d,1,4) and d.r020_fa(+) = substr(nlsd,1,4) and d.ob22(+) = ob22_d and d.p080(+) = p080_d and (d.d_close is null or d.d_close > bankdate)
    and k.r020(+) = substr(nlsn_k,1,4) and k.r020_fa(+) = substr(nlsk,1,4) and k.ob22(+) = ob22_k and k.p080(+) = p080_k and (k.d_close is null or k.d_close > bankdate)" || 
        IifS(sFilter!="", " and ", "") || sFilter || "
  ORDER BY ob22_d, ref"
.head 4 -  Call SalTblPopulate(hWndForm, hSql(), OB22NU.strSqlPopulate, TBL_FillAll)
.head 4 -  Call SalTblSetContext(hWndForm, 0)
.head 4 -  Call SalPostMsg(hWndForm, SAM_TblDoDetails, 0, 0)
.head 4 -  ! Итоги
.head 4 -  Call SalTblDefineSplitWindow(hWndForm, 1, TBL_Split_Adjustable)
.head 4 -  Call SalTblFetchRow(hWndForm, SalTblInsertRow(hWndForm, TBL_MinSplitRow))
.head 4 -  Call SalTblSetFlagsAnyRows(hWndForm, ROW_New, FALSE, 0, 0)
.head 4 -  Set NLS8_D = 'Всего'
.head 4 -  Set OB22_D = Str(nCount)
.head 4 -  Set S      = nSum
.head 4 -  Call VisTblAutoSizeColumn(hWndForm, hWndNULL)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_FetchRowDone
.head 4 -  Set nCount = nCount + 1
.head 4 -  Set nSum   = nSum + S
.head 4 +  If VOB = 96 or VOB = 99
.head 5 -  Call XSalTblSetRowBackColor(hWndForm, lParam, COLOR_Maize)
.head 4 -  Set colKontrAcc_D = IifS(NLS8_D!='', IifS(PAPD='1', sNU_KS6, sNU_KS7), '')
.head 4 -  Set colKontrAcc_K = IifS(NLS8_K!='', IifS(PAPK='1', sNU_KS6, sNU_KS7), '')
.head 3 +  On SAM_DoubleClick
.head 4 -  Call DocView(hWndMDI, REF, 2, 0, '')
.head 3 +  On SAM_Destroy
.head 4 -  Call Pl_dat(bDat)
