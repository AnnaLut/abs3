.head 0 +  Application Description: ! OBANKPC.APL -  Интерфейс с процессинговым 
! центром для ОЩАДБАНКА
! ООО Унити-Барс  (C)  2001-2003
! Разработчик: Малышев И.В., Чупахина Н.А.
! ///////////////////////////////////////////
.head 1 -  Outline Version - 4.0.26
.head 1 +  Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000C80000 002C000000030000 00030000000E0300 000B000000F8FFFF
0040: FFE2FFFFFF200000 0015000000EA0200 00D7010000010000 0001000000010000
0060: 000F4170706C6963 6174696F6E497465 6D01000000075769 6E646F7773
.enddata
.data DT_MAKERUNDLG
0000: 0200000000001C51 3A5C424152533938 5C4C494252415259 5C4162736170692E
0020: 646C6C1C513A5C42 41525339385C4C49 42524152595C4162 736170692E617063
0040: 00000101011C513A 5C4241525339385C 4C4942524152595C 4162736170692E72
0060: 756E1C513A5C4241 525339385C4C4942 524152595C416273 6170692E646C6C1C
0080: 513A5C4241525339 385C4C4942524152 595C416273617069 2E61706300000101
00A0: 01175C4241525339 385C42494E5C4F42 414E4B50432E6170 64165C4241525339
00C0: 385C42494E5C4162 736170692E646C6C 165C424152533938 5C42494E5C416273
00E0: 6170692E61706300 00010101001C513A 5C4241525339385C 4C4942524152595C
0100: 4162736170692E64 6C6C1C513A5C4241 525339385C4C4942 524152595C416273
0120: 6170692E61706300 00010101
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
.head 2 -  Dynalib: Message.apd
.head 2 -  Dynalib: Absapi.apd
.head 2 -  Dynalib: Nsiapi.apd
.head 2 -  Dynalib: DOCVIEW.APD
.head 2 -  Dynalib: custacnt.apd
.head 2 -  Dynalib: CC_DOC.APD
.head 2 -  Dynalib: techbank.apd
.head 2 -  Dynalib: openway.apd
.head 2 -  !
.head 2 -  File Include: GenTbl.apl
.head 2 -  File Include: GenTblS.apl
.head 2 -  File Include: Constant.apl
.head 2 -  File Include: Genbutn.apl
.head 2 -  File Include: Genemnu.apl
.head 2 -  File Include: Genlist.apl
.head 2 -  File Include: Winapi.apl
.head 2 -  File Include: Winbars2.apl
.head 2 -  File Include: Sqlnsi.apl
.head 2 -  !
.head 2 -  File Include: DOCFUN6.APL
.head 2 -  !
.head 2 -  File Include: Vtcal.apl
.head 2 -  File Include: Vtmeter.apl
.head 2 -  File Include: Vttblwin.apl
.head 2 -  File Include: vtsplit.apl
.head 2 -  File Include: vtlbx.apl
.head 2 -  File Include: vtdos.apl
.head 2 -  File Include: Vtmsgbox.apl
.head 2 -  File Include: VTFILE.APL
.head 2 -  File Include: XSalImg.apl
.head 2 -  File Include: xsalcpt.apl
.head 2 -  File Include: QCKTABS.APL
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
.head 3 -  Input: 99/99/99
.head 3 -  Number: ###00000
.head 3 -  Date/Time: dd/MM/yyyy
.head 3 -  Date/Time: dd/MM/yy
.head 3 -  Date/Time: dd
.head 3 -  Date/Time: dd-MM-yyyy
.head 3 -  Date/Time: ddMMyy
.head 3 -  Input: 9999
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
.head 3 +  Icon: icon_Folder1
.head 4 -  File Name: \Bars98\Resource\Ico\Folder.ico
.head 2 +  Variables
.data RESOURCE 0 0 1 3777691153
0000: 8E020000EB000000 0000000000000000 02000019000000B6 000000E002040000
0020: 00FF3FBA00B80000 0200FFFFE0BE0000 0002FE00FF03C200 0000010DF8000000
0040: FF0FCF000000EE01 00FF3FDC00B80000 0200FFFFE0E00000 0002FE00FF83E400
0060: 000002FB00FF0FE8 000000EE0100FF3F F500A00000030400 00FFFFE0F9000000
0080: 02FE00FF83FD0000 0002FB00FF0F0101 0000EE0200FF3F05 01B200010D00FFFF
00A0: E812010003FE00FF A316010003FB00FF 8F1A0100EE0200FF 3F1E01BA000200FF
00C0: FFE822010001FE00 FF232F0100040DFA 0000FF8F3C0100EE 0200FF3F4001BA00
00E0: 0200FFFFE8440100 02FE00FFA3480100 02FB00FF8F4C0100 EE0200FF3F
.enddata
.head 3 -  Number: nFetchRes
.head 3 -  Window Handle: hWnd6
.head 3 -  Window Handle: hWnd7
.head 3 -  Window Handle: hWnd8
.head 3 -  Window Handle: hWnd10
.head 3 -  Window Handle: hWnd11
.head 3 -  Window Handle: hWnd12
.head 3 -  Window Handle: hWnd13
.head 3 -  Window Handle: hWnd14
.head 3 -  Window Handle: hWnd15
.head 3 -  Window Handle: hWnd16
.head 3 -  Window Handle: hWnd19
.head 3 -  Window Handle: hWnd20
.head 3 -  Window Handle: hWnd21
.head 3 -  Window Handle: hWnd22
.head 3 -  Window Handle: hWnd23
.head 3 -  Window Handle: hWnd24
.head 3 -  Window Handle: hWnd25
.head 3 -  String: sFileName
.head 3 -  File Handle: hFile
.head 3 -  String: sStatusText
.head 2 +  Internal Functions
.head 3 +  Function: FOBPC_Select			! __exported
.head 4 -  Description: Интерфейс для вызова всех функций в 
OBANKPC.APD
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nFuncCode
.head 5 -  String: sFuncParams
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If nFuncCode > 100 
.head 6 -  Call OpenWay(hWndMDI, nFuncCode-100, 0, 0, sFuncParams, '')
.head 5 +  Else
.head 6 +  Select Case nFuncCode
.head 7 +  Case 1		! Формирование файлов P~
.head 8 -  Call FormPCFiles(sFuncParams)
.head 8 -  Break
.head 7 -  ! Просмотр карточных документов
.head 7 +  Case 2		! Просмотр внутр. не отправленных документов по карточным счетам
.head 8 -  Call DocList(hWndMDI, 2, 0, '', '', '',
" a.ref IN (SELECT ref FROM PKK_QUE WHERE sos=0) and a.sos >= 0",
"Внутрішні не відправлені карткові документи")
.head 8 -  Break
.head 7 +  Case 3		! Просмотр внутр. не сквитованных документов по карточным счетам
.head 8 -  Call DocList(hWndMDI, 2, 0, '', '', '',
" a.ref IN (SELECT ref FROM PKK_QUE WHERE sos=1) ",
"Внутрішні не заквитовані карткові документи")
.head 8 -  Break
.head 7 +  Case 4		! Просмотр внеш. не отправленных документов по карточным счетам
.head 8 -  ! Call DocList( 
	hWndMDI,1,0,'','','',
	' a.ref IN (SELECT ref FROM PKK_QUE WHERE sos=0) ',
	'Внешние не отправленные карточные документы')
.head 8 -  Call DocList(hWndMDI, 1, 0, '', '', '',
" a.rec in ( select rec from arc_rrp where ref in (select ref from pkk_que where sos = 0)
             union all
             select rec from pkk_inf ) ",
"Зовнішні не відправлені карткові документи")
.head 8 -  Break
.head 7 +  Case 5		! Просмотр внеш. не сквитованных документов по карточным счетам
.head 8 -  Call DocList(hWndMDI, 1, 0, '', '', '',
" a.ref IN (SELECT ref FROM PKK_QUE WHERE sos=1) ",
"Зовнішні не заквитовані карткові документи")
.head 8 -  Break
.head 7 +  Case 6		! Прием файлов процессингового центра
.head 8 +  If not IsWindow(hWnd6)
.head 9 -  Set hWnd6 = SalCreateWindow(frm_ImportPCFiles, hWndMDI)
.head 8 +  Else
.head 9 -  Call SalBringWindowToTop(hWnd6)
.head 8 -  Break
.head 7 +  Case 7		! Прием файлов из локальных задач
.head 8 +  If not IsWindow(hWnd7)
.head 9 -  Set hWnd7 = SalCreateWindow(frm_ImportInternalTasks, hWndMDI, sFuncParams)
.head 8 +  Else
.head 9 -  Call SalBringWindowToTop(hWnd7)
.head 8 -  Break
.head 7 +  Case 8		! Доввод доп. реквизитов
.head 8 +  If not IsWindow(hWnd8)
.head 9 -  Set hWnd8 = SalCreateWindow(frm_AuxReenter, hWndMDI)
.head 8 +  Else
.head 9 -  Call SalBringWindowToTop(hWnd8)
.head 8 -  Break
.head 7 +  Case 9		! Сброс таблицы импортированных файлов ПЦ
.head 8 -  Call ResetImportedFiles()
.head 8 -  Break
.head 7 +  Case 10		! Ручная квитовка док-тов
.head 8 +  If not IsWindow(hWnd10)
.head 9 -  Set hWnd10 = SalCreateWindow(frm_HandReceipe, hWndMDI)
.head 8 +  Else
.head 9 -  Call SalBringWindowToTop(hWnd10)
.head 8 -  Break
.head 7 +  Case 11		! Портфель
.head 8 +  If not IsWindow(hWnd11)
.head 9 -  Set hWnd11 = SalCreateWindow(tblPortfolio, hWndMDI, 1, sFuncParams)
.head 8 +  Else
.head 9 -  Call SalBringWindowToTop(hWnd11)
.head 8 -  Break
.head 7 +  Case 12		! Продукты БПК
.head 8 +  If not IsWindow(hWnd12)
.head 9 -  Set hWnd12 = SalCreateWindow(tblProduct, hWndMDI, nFuncCode)
.head 8 +  Else
.head 9 -  Call SalBringWindowToTop(hWnd12)
.head 8 -  Break
.head 7 +  Case 13		! Формирование odb*.dbf
.head 8 +  If not IsWindow(hWnd13)
.head 9 -  Set hWnd13 = SalCreateWindow(tblFormOdbDbf, hWndMDI)
.head 8 +  Else
.head 9 -  Call SalBringWindowToTop(hWnd13)
.head 8 -  Break
.head 7 +  Case 14		! Импорт зарплатного файла
.head 8 +  If not IsWindow(hWnd14)
.head 9 -  Set hWnd14 = SalCreateWindow(frm_ImportZP, hWndMDI, sFuncParams)
.head 8 +  Else
.head 9 -  Call SalBringWindowToTop(hWnd14)
.head 8 -  Break
.head 7 +  Case 15		! Пополнение карт. счетов с одного транзита (задаем техн. счет)
.head 8 +  If not IsWindow(hWnd15)
.head 9 -  Set hWnd15 = SalCreateWindow(frm_PayCard, hWndMDI, sFuncParams, 0)
.head 8 +  Else
.head 9 -  Call SalBringWindowToTop(hWnd15)
.head 8 -  Break
.head 7 +  Case 16		! Ручная корректировка документов для ПЦ
.head 8 +  If not IsWindow(hWnd16)
.head 9 -  Set hWnd16 = SalCreateWindow(tblObpcPkkque, hWndMDI, sFuncParams)
.head 8 +  Else
.head 9 -  Call SalBringWindowToTop(hWnd16)
.head 8 -  Break
.head 7 +  Case 17		! Пополнение карт. счетов с одного транзита (задаем карт. счет)
.head 8 +  If not IsWindow(hWnd15)
.head 9 -  Set hWnd15 = SalCreateWindow(frm_PayCard, hWndMDI, sFuncParams, 1)
.head 8 +  Else
.head 9 -  Call SalBringWindowToTop(hWnd15)
.head 8 -  Break
.head 7 +  Case 18		! Импорт справочников, синхронизация
.head 8 -  Call ImportReference(sFuncParams)
.head 8 -  Break
.head 7 +  Case 19		! Формирование файлов P*
.head 8 +  If not IsWindow(hWnd19)
.head 9 -  Set hWnd19 = SalCreateWindow(tblFormFileP, hWndMDI)
.head 8 +  Else
.head 9 -  Call SalBringWindowToTop(hWnd19)
.head 8 -  Break
.head 7 +  Case 20		! Удаление в архив необработанных транзакций ПЦ
.head 8 +  If not IsWindow(hWnd20)
.head 9 -  Set hWnd20 = SalCreateWindow(tblDeleteTran, hWndMDI)
.head 8 +  Else
.head 9 -  Call SalBringWindowToTop(hWnd20)
.head 8 -  Break
.head 7 +  Case 21		! Отчет
.head 8 +  If not IsWindow(hWnd21)
.head 9 -  Set hWnd20 = SalCreateWindow(tblReport, hWndMDI)
.head 8 +  Else
.head 9 -  Call SalBringWindowToTop(hWnd21)
.head 8 -  Break
.head 7 +  Case 22         ! ОБ РУ - XML - Зачисление з/п на каоточные счета
.head 8 +  If not IsWindow(hWnd22)
.head 9 -  Set hWnd22 = SalCreateWindow(XM3, hWndMDI, 0, 0, '', '')
.head 8 +  Else
.head 9 -  Call SalBringWindowToTop(hWnd22)
.head 8 -  Break
.head 7 +  Case 23         ! Импорт зарплатных проэктов - открытие карточек
.head 8 +  If not IsWindow(hWnd23)
.head 9 -  Set hWnd23 = SalCreateWindow(frmImpProect, hWndMDI)
.head 8 +  Else
.head 9 -  Call SalBringWindowToTop(hWnd23)
.head 8 -  Break
.head 7 +  Case 24         ! Импорт ACCT (всего файла)
.head 8 +  If not IsWindow(hWnd24)
.head 9 -  Set hWnd24 = SalCreateWindow(frmImportAcct, hWndMDI)
.head 8 +  Else
.head 9 -  Call SalBringWindowToTop(hWnd24)
.head 8 -  Break
.head 7 +  Case 25		! Портфель-просмотр
.head 8 +  If not IsWindow(hWnd25)
.head 9 -  Set hWnd25 = SalCreateWindow(tblPortfolio, hWndMDI, 0, sFuncParams)
.head 8 +  Else
.head 9 -  Call SalBringWindowToTop(hWnd25)
.head 8 -  Break
.head 7 +  Default
.head 8 -  Break
.head 5 -  Return TRUE
.head 3 +  Function: FormPCFiles
.head 4 -  Description: Формирование файлов для процессингового центра
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  String: sFileType
.head 4 +  Static Variables
.head 5 -  : cFileFormer
.head 6 -  Class: cPA_PC_Former
.head 4 +  Local variables
.head 5 -  Boolean: fNeedStatus
.head 5 -  String: sPath
.head 4 +  Actions
.head 5 +  If sFileType
.head 6 -  Call SaveInfoToLog('OBPC. Формування файлу P' || sFileType || '*')
.head 6 -  Set fNeedStatus = FALSE
.head 6 -  ! Чтение параметров
.head 6 -  Call SalUseRegistry(FALSE, GetIniFileName())
.head 6 -  Call SalGetProfileString('OBPC', 'OBPCOutPath', '', sPath, GetIniFileName())
.head 6 -  ! Вызов класса формирования файла
.head 6 +  If cFileFormer.FormFile(sPath, sFileType)
.head 7 +  If cFileFormer.sLog
.head 8 -  Set fNeedStatus = TRUE
.head 6 +  Else
.head 7 -  Set fNeedStatus = TRUE
.head 6 +  If fNeedStatus
.head 7 -  Call SalModalDialog(dlgStatus, hWndForm, cFileFormer.sLog, 'Статус формування файлу Р~')
.head 7 -  Call SaveInfoToLog('OBPC. ' || cFileFormer.sLog)
.head 6 +  Else
.head 7 -  Call SalMessageBox('Формування успішно завершено!', 'Формування файлів', 0)
.head 5 +  Else
.head 6 -  Call FOBPC_Select(19, '')
.head 3 +  Function: ResetImportedFiles
.head 4 -  Description: Сброс таблицы импортированных файлов ПЦ
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  : cOra
.head 6 -  Class: cABSConnect
.head 4 +  Actions
.head 5 +  If SalMessageBox("Ви дійсно бажаєте помістити в архів прийняті файли ПЦ ?", 
   "Увага!", MB_YesNo | MB_IconExclamation | MB_DefButton2) = IDYES
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call XConnectGetParams(cOra)
.head 6 +  If cOra.Connect()
.head 7 +  If SqlPLSQLCommand(cOra.hSql(), "obpc.arc_pc_files(NUMBER_Null)")
.head 8 -  Call SqlCommitEx(cOra.hSql(), 'OBPC. Файли ПЦ перенесены в архив!' )
.head 8 -  Call SalMessageBox('Архівацію завершено!', 'Інформація', 0)
.head 7 +  Else
.head 8 -  Call SqlRollbackEx(cOra.hSql(), 'OBPC. Неуспешное выполнение процедуры архивации файлов ПЦ!' )
.head 7 -  Call cOra.Disconnect()
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 -  Return TRUE
.head 3 -  !
.head 3 +  Function: ImportReference
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: sFileName
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Boolean: bRet
.head 5 -  String: sPath
.head 5 -  String: sFile
.head 5 -  File Handle: hFile
.head 5 -  String: sErrMsg
.head 5 -  String: sMsg
.head 4 +  Actions
.head 5 -  Set bRet = FALSE
.head 5 -  ! Чтение параметров
.head 5 -  Call SalUseRegistry(FALSE, '')
.head 5 -  Call SalGetProfileString('OBPC', 'OBPCInPath', '', sPath, GetIniFileName())
.head 5 +  Loop
.head 6 +  If sFileName = STRING_Null
.head 7 -  Call SalMessageBox("Не задано довідник для імпорту!", "Помилка", MB_Ok | MB_IconStop)
.head 7 -  Call SaveInfoToLog("OBPC. Не задано довідник для імпорту!")
.head 7 -  Break
.head 6 -  Set sFile = sPath || sFileName || '.DBF'
.head 6 +  If not SalFileOpen(hFile, sFile, OF_Exist)
.head 7 -  Call SalMessageBox("Файл не знайдено: " || sFile, "Помилка", MB_Ok | MB_IconStop)
.head 7 -  Call SaveInfoToLog("OBPC. Файл не знайдено: " || sFile)
.head 7 -  Break
.head 6 -  ! Импорт во временную таблицу
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 +  If not ImportUseMomory(sPath, sFileName || '.DBF', 'PCIMP_' || sFileName, 'UKG', 1, sErrMsg)
.head 7 -  Break
.head 6 +  If not SqlPLSQLCommand(hSql(), "obpc.sync_reference(sFileName, sMsg)")
.head 7 -  Call SqlRollbackEx(hSql(), "OBPC. Ошибка синхронизации " || sFileName)
.head 7 -  Break
.head 6 -  Call SqlCommitEx(hSql(), "OBPC. Синхронизирован справочник " || sFileName)
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Call SalMessageBox("Імпорт файлу " || sFileName || " завершено", "Інформація", MB_IconAsterisk)
.head 6 +  If sMsg
.head 7 -  Call SalMessageBox(sMsg, "Інформація", MB_IconAsterisk)
.head 6 -  Set bRet = TRUE
.head 6 -  Break
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  Return bRet
.head 3 -  !
.head 3 +  Function: ImportUseMomory
.head 4 -  Description: Импорт через память (переменная в bars_dbf)
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: sFilePath          ! путь к файлу dbf
.head 5 -  String: sFileName          ! имя файла dbf
.head 5 -  String: sTableName         ! имя таблицы для импорта
.head 5 -  String: sEncode            ! кодировка DBF файла
.head 5 -  Number: nForceMode         ! =0-пересоздать таблицу, =1-создать новую с хвостом времени, =2-не создавать
.head 5 -  Receive String: sErrMsg    ! текст ошибки обработки
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sFilePathName
.head 5 -  Number: nIsMemoExists
.head 4 +  Actions
.head 5 -  ! загрузка DBF файла в переменную пакета
.head 5 -  ! Set sFilePathName = sFilePath||'\\'||sFileName
.head 5 -  Set sFilePathName = sFilePath || IifS(Right(sFilePath,1)='\\', '', '\\') || sFileName
.head 5 -  Call SaveInfoToLog("OBPC. " || "Импорт файла " || sFilePathName)
.head 5 +  If not LoadDBFfile(hSql(), sFilePathName, 'DBF', sErrMsg)
.head 6 -  Return FALSE
.head 5 +  Else
.head 6 -  ! Существует ли мемо поле
.head 6 +  If not SqlPLSQLCommand(hSql(),"bars_dbf.is_memo_exists_cnt(nIsMemoExists)")
.head 7 -  Set sErrMsg = 'Ошибка проверки на наличия МЕМО поля'
.head 7 -  Return FALSE
.head 6 +  Else
.head 7 -  ! Существует мемо поле - подтянуть файл для него
.head 7 +  If nIsMemoExists = 1
.head 8 -  Set sFilePathName = sFilePath||'\\'||SalStrLeftX(sFileName, SalStrScan(sFileName,'.'))||'.dbt'
.head 8 +  If not LoadDBFfile( hSql(), sFilePathName, 'DBT', sErrMsg)
.head 9 -  Set sErrMsg = 'Неуспешная загрузка файла *.DBT для мемо поля в БД: ' ||sErrMsg
.head 9 -  Return FALSE
.head 7 -  ! импорт DBF файла из переменной пакета
.head 7 +  If not SqlPLSQLCommand(hSql(),"bars_dbf.import_dbf_cnt(sTableName, nForceMode, sEncode, 'WIN')")
.head 8 -  Set sErrMsg = 'Ошибка импорта DBF файла'
.head 8 -  Return FALSE
.head 7 +  Else
.head 8 -  Call SqlCommitEx(hSql(),'Выполнен импорт данных файла '|| sFilePathName ||' в таблицу '||sTableName)
.head 6 -  Return TRUE
.head 3 +  Function: LoadDBFfile
.head 4 -  Description: Загрузить файл в переменную пакета bars_dbf
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  ! SQL соединение
.head 5 -  Sql Handle: hSqlHandle
.head 5 -  ! Имя файла загружаемого в БД
.head 5 -  String: strFileName
.head 5 -  ! Тип файла (DBF или DBT)
.head 5 -  String: strFileType
.head 5 -  Receive String: sErrMsg
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  ! Файл
.head 5 -  File Handle: hFile
.head 5 -  ! Ошибка при открытии файла
.head 5 -  Number: nErrCode
.head 5 -  ! Буфер чтения файла
.head 5 -  Long String: sBuffer
.head 5 -  ! Максимальный размер буфера (3999)
.head 5 -  Number: nBufferSize
.head 5 -  ! Количество прочитанных байт
.head 5 -  Number: nBytesRead
.head 4 +  Actions
.head 5 -  ! Это максимальный теоритический предел для вставки в БД
.head 5 -  Set nBufferSize = 3999
.head 5 -  ! Здесь мы удаляем даные из временной таблицы
.head 5 -  ! Открываем файл для чтения
.head 5 -  Set nErrCode = VisFileOpen(hFile, strFileName, OF_Binary | OF_Read)
.head 5 +  If nErrCode
.head 6 -  Set sErrMsg =  'Не удалось открыть файл ' || strFileName
.head 6 -  Return FALSE
.head 5 -  ! В цикле по частям вычитываем файл и складываем его во временую таблицу БД
.head 5 +  Loop
.head 6 +  If SalStrSetBufferLength(sBuffer, nBufferSize+1)
.head 7 -  Set nBytesRead = VisFileRead(hFile, sBuffer, nBufferSize)
.head 7 -  Call SalStrSetBufferLength(sBuffer, nBufferSize+1)
.head 7 +  If nBytesRead
.head 8 +  If not SqlPLSQLCommand(hSql(),"bars_dbf.set_buffer(sBuffer,strFileType,nBytesRead)")
.head 9 -  Call SqlRollback(hSqlHandle)
.head 9 -  Set sErrMsg =  'Ошибка вычитки файла в буффер. Размер буффера - '||SalNumberToStrX(nBytesRead,0)
.head 9 -  Return FALSE
.head 8 +  If nBytesRead < nBufferSize
.head 9 -  Break
.head 7 +  Else
.head 8 -  Break
.head 6 +  Else
.head 7 -  Return FALSE
.head 5 -  ! Закрываем файл
.head 5 -  Call VisFileClose(hFile)
.head 5 -  ! Сохраняем изменения
.head 5 -  Call SqlCommit(hSqlHandle)
.head 5 -  Return TRUE
.head 3 -  !
.head 2 +  Named Menus
.head 3 +  Menu: pmStatusPrint
.head 4 -  Resource Id: 1717
.head 4 -  Title:
.head 4 -  Description:
.head 4 -  Enabled when:
.head 4 -  Status Text:
.head 4 -  Menu Item Name:
.head 4 +  Menu Item: Распечатать статус
.head 5 -  Resource Id: 1718
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Set sFileName = GetPrnDir() || "\\" || SalFmtFormatDateTime(SalDateCurrent(), 'ddMMhhss') || '.txt'
.head 6 -  Call VisFileOpen(hFile, sFileName, OF_Create)
.head 6 -  Call VisFileWriteString(hFile, sStatusText)
.head 6 -  Call VisFileClose(hFile)
.head 6 -  Call DosDirectPrint(sFileName)
.head 5 -  Menu Item Name:
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
.head 3 +  Functional Class: cPA_PC_Former
.head 4 -  Description: Класс формирования файлов
интерфейса с процессинговым центром
.head 4 -  Derived From
.head 4 -  Class Variables
.head 4 +  Instance Variables
.head 5 -  ! Коорд. файла
.head 5 -  String: sFilePath
.head 5 -  String: sFileName
.head 5 -  ! Имя файла - пусто, если файл не сформировался
.head 5 -  String: sFileFormed
.head 5 -  ! Кол-во строк в файле
.head 5 -  Number: nRowCount
.head 5 -  Number: nInfoRowCount
.head 5 -  ! Соединения
.head 5 -  ! Для выборок
.head 5 -  : cMain
.head 6 -  Class: cABSConnect
.head 5 -  ! Для оновлений
.head 5 -  : cAux
.head 6 -  Class: cABSConnect
.head 5 -  ! Файл
.head 5 -  File Handle: hFile
.head 5 -  ! Текстовое представление файла (текст. буфер)
.head 5 -  String: sFile
.head 5 -  ! Лог. сообщений
.head 5 -  String: sLog
.head 5 -  ! Сумма файла
.head 5 -  Number: nFileSum
.head 5 -  ! Дата/время формирования файла
.head 5 -  Date/Time: dtFormDate
.head 5 -  ! № файла
.head 5 -  String: sFileNo
.head 5 -  ! Тип файла A,C
.head 5 -  String: sFileType
.head 5 -  ! Код филиала
.head 5 -  String: sBranchCode
.head 5 -  ! End-Of-Line
.head 5 -  String: sEOL
.head 5 -  ! Заголовок
.head 5 -  String: rLineHeader
.head 4 +  Functions
.head 5 -  ! Ключевой метод
.head 5 +  Function: FormFile
.head 6 -  Description: Формирует файл путем вызова методов класса
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: pFilePath
.head 7 -  String: pFileName
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Boolean: bResult
.head 7 -  String: sTip
.head 7 -  String: sCurTip
.head 6 +  Actions
.head 7 -  Set bResult = FALSE
.head 7 -  ! Иниц. переменных класса
.head 7 -  Set sEOL  = SalNumberToChar(13) || SalNumberToChar(10)
.head 7 -  Set sLog  = ''
.head 7 -  Set sFile = ''
.head 7 -  ! Др. параметры
.head 7 -  Set sFilePath = pFilePath
.head 7 -  Set sFileName = pFileName
.head 7 -  Set nRowCount = 0
.head 7 -  Set nInfoRowCount = 0
.head 7 -  Set dtFormDate  = SalDateCurrent()
.head 7 -  Set sBranchCode = GetGlobalOption('PC_KF')
.head 7 -  Set sFileFormed = STRING_Null
.head 7 -  ! Формирование
.head 7 +  If SetDbConnect()
.head 8 +  Loop
.head 9 -  ! Вид карточек
.head 9 -  Set sFileType = pFileName
.head 9 -  Set sTip = ''
.head 9 +  If SqlPrepareAndExecute(cMain.hSql(), 'SELECT ACC_TYPE INTO :sCurTip FROM OBPC_OUT_FILES WHERE FILE_CHAR=:sFileType')
.head 10 +  While SqlFetchNext(cMain.hSql(), nFetchRes)
.head 11 +  If not sTip
.head 12 -  Set sTip = "'" || sCurTip || "'"
.head 11 +  Else
.head 12 -  Set sTip = sTip || ", '" || sCurTip || "'"
.head 9 +  Else
.head 10 -  Break
.head 9 +  If not sTip
.head 10 -  Call PutLog('Задано невідомий тип файлу ' || sFileType)
.head 10 -  Break
.head 9 -  ! Проверка наличия данных для формирования файла
.head 9 +  If not CheckForData(sTip)
.head 10 -  Call PutLog('Відсутні дані для формування файлу!')
.head 10 -  Break
.head 9 -  ! Вычисление имени файла
.head 9 +  If not EvalFilename()
.head 10 -  Call PutLog('Помилка визначення імені файлу (EvalFilename)!')
.head 10 -  Break
.head 9 -  ! Формирование файла
.head 9 +  If not DoBeforeFileForm()
.head 10 -  Call PutLog('Помилка відкриття файлу (DoBeforeFileForm)!')
.head 10 -  Break
.head 9 +  If not DoLinesHeader()
.head 10 -  Call PutLog('Помилка формування заголовку файлу (DoLinesHeader)!')
.head 10 -  Break
.head 9 +  If not DoLines(sTip)
.head 10 -  Call PutLog('Помилка формування інформаційних рядків файлу (DoLines)!')
.head 10 -  Break
.head 9 +  If not DoLinesFooter()
.head 10 -  Call PutLog('Помилка формування закінчення набору рядків (DoLinesFooter)!')
.head 10 -  Break
.head 9 +  If not DoAfterFileForm()
.head 10 -  Call PutLog('Помилка при закінченні формування файлу(DoAfterFileForm)!')
.head 10 -  Break
.head 9 -  Set bResult = TRUE
.head 9 -  Break
.head 8 -  Call CloseDbConnect()
.head 7 -  Return bResult
.head 5 -  ! Методы реализации функциональности
.head 5 +  Function: SetDbConnect
.head 6 -  Description: Установка соединения с БД и подготовительные действия
Возвр. TRUE если соед. установлено
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Call XConnectGetParams(cMain)
.head 7 -  Call cAux.Clone(cMain, FALSE)
.head 7 -  Return cMain.Connect() AND cAux.Connect()
.head 5 +  Function: CloseDbConnect
.head 6 -  Description: Закрытие соединения с БД
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Call cMain.Disconnect()
.head 7 -  Call cAux.Disconnect()
.head 5 -  !
.head 5 +  Function: CheckForData
.head 6 -  Description: Проверяет наличие данных для формирования файла
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: sTip
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nTotal
.head 6 +  Actions
.head 7 -  Set nTotal = 0
.head 7 -  ! Проверяем наличие данных
.head 7 +  If SqlPrepareAndExecute(cMain.hSql(), 
"select count(*) into :nTotal 
   from v_obpc_pfiles_form
  where tip in (" || sTip || ")")
.head 8 -  Call SqlFetchNext(cMain.hSql(), nFetchRes)
.head 7 -  Return nTotal > 0
.head 5 -  !
.head 5 +  Function: EvalFilename
.head 6 -  Description: Вычисление имени файла
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 +  If not SqlPLSQLCommand(cMain.hSql(), "obpc.get_p_file_name(sFileType, sFileName)")
.head 8 -  Call SqlRollback(cMain.hSql())
.head 8 -  Return FALSE
.head 7 -  Return TRUE
.head 5 -  !
.head 5 +  Function: DoBeforeFileForm
.head 6 -  Description: Действия перед формированием файла
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set nFileSum = 0
.head 7 -  Return TRUE
.head 5 +  Function: DoAfterFileForm
.head 6 -  Description: Действия после формирования файла
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Boolean: bOk
.head 6 +  Actions
.head 7 +  If nInfoRowCount = 0
.head 8 -  Call PutLog('Недостатньо даних для формування файлу!')
.head 8 -  Call PutLog('Черга на відправку документів по карткам даного типу в ПЦ')
.head 8 -  Call PutLog('містить тільки неправильні документи.')
.head 8 -  Call SqlRollback(cMain.hSql())
.head 7 +  Else If SalStrLength(sFile) > 0
.head 8 -  Set bOk = TRUE
.head 8 +  Loop
.head 9 -  ! Открытие файла
.head 9 +  If not SalFileOpen(hFile, sFilePath || sFileName, OF_Create | OF_ReadWrite | OF_Share_Exclusive)
.head 10 -  Set bOk = FALSE
.head 10 -  Break
.head 9 -  ! Пишем в файл
.head 9 -  Call SalFileWrite(hFile, sFile, SalStrLength(sFile))
.head 9 -  ! Закрываем файл
.head 9 +  If not SalFileClose(hFile)
.head 10 -  Set bOk = FALSE
.head 10 -  Break
.head 9 -  Break
.head 8 +  If not bOk
.head 9 -  Call SqlRollbackEx(cAux.hSql(), 'Помилка при записі файлу: ' || sFileName)
.head 9 -  Return FALSE
.head 8 -  Call SqlCommitEx(cAux.hSql(), 'OBPC. Файл сформовано: ' || sFileName)
.head 8 -  Call SqlCommit(cMain.hSql())
.head 8 -  Set sFileFormed = sFileName
.head 7 -  Return TRUE
.head 5 -  !
.head 5 +  Function: DoLinesHeader
.head 6 -  Description: Формирование заголовка файла
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: rCode
.head 7 -  String: rFile_date
.head 7 -  String: rFile_time
.head 7 -  String: sHour
.head 7 -  String: sMin
.head 7 -  String: sSec
.head 7 -  String: rSource
.head 7 -  String: rPaym_ord_no
.head 7 -  String: rPaym_ord_date
.head 7 -  String: rPaym_ord_sum
.head 6 +  Actions
.head 7 -  ! заголовок файла
.head 7 -  Set rCode = '00'
.head 7 -  Set rFile_date = SalFmtFormatDateTime(dtFormDate, 'yyyyMMdd')
.head 7 -  Set sHour = SalFmtFormatDateTime(dtFormDate, 'hhhh')
.head 7 -  Set sMin  = SalFmtFormatDateTime(dtFormDate, 'mm')
.head 7 -  Set sSec  = SalFmtFormatDateTime(dtFormDate, 'ss')
.head 7 -  Set rFile_time = SalStrRightX('00' || sHour, 2) || 
    SalStrRightX('00' || sMin, 2) || 
    SalStrRightX('00' || sSec, 2)
.head 7 -  Set rSource = ' '
.head 7 -  Set rPaym_ord_no = SalStrRightX('00000000' || sFileNo, 8)
.head 7 -  Set rPaym_ord_date = SalFmtFormatDateTime(GetBankDate(), 'yyyyMMdd')
.head 7 -  Set rLineHeader =
    rCode ||
    rFile_date ||
    rFile_time ||
    rSource ||
    sFileName ||
    rPaym_ord_no ||
    rPaym_ord_date
.head 7 -  Return TRUE
.head 5 +  Function: DoLinesFooter
.head 6 -  Description: Формирование окончания набора строк
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: rCode
.head 7 -  String: rRecord_cnt
.head 7 -  String: rPaym_ord_sum
.head 7 -  String: rChek_sum
.head 7 -  String: rLineFooter
.head 6 +  Actions
.head 7 -  Set rCode = '99'
.head 7 -  Set rRecord_cnt   = PadL(SalNumberToStrX(nInfoRowCount, 0), 10)
.head 7 -  Set rPaym_ord_sum = PadL(VisStrSubstitute(SalNumberToStrX(nFileSum/100, 2), ',', '.'), 12)
.head 7 -  Set rChek_sum = rPaym_ord_sum
.head 7 -  Set rLineFooter =
    rCode ||
    rRecord_cnt ||
    rPaym_ord_sum ||
    rChek_sum
.head 7 -  Set rLineHeader = rLineHeader || rPaym_ord_sum
.head 7 -  Call PutLine(rLineHeader, FALSE)
.head 7 -  Call PutLine(rLineFooter, TRUE)
.head 7 -  Return TRUE
.head 5 -  !
.head 5 +  Function: DoLines
.head 6 -  Description: Формирование информационной строки
Возвр. TRUE значит строка успешно сформированна
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: sTip
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Boolean: bCardAcctExists
.head 7 -  String: rCode
.head 7 -  String: rCard_no
.head 7 -  String: rTran_date
.head 7 -  String: rBill_ref_no
.head 7 -  String: rTran_type
.head 7 -  String: rAmount
.head 7 -  String: rCurrency
.head 7 -  String: rBank_code
.head 7 -  String: rBranch_code
.head 7 -  String: rWrpl_no
.head 7 -  String: rTab_no
.head 7 -  String: rInfoString
.head 7 -  Number: nFetchRes
.head 7 -  Number: nCorCount
.head 7 -  String: sCardAcct
.head 7 -  ! Свойства инф. строки
.head 7 -  Number: dbDocType
.head 7 -  Number: dbRef
.head 7 -  Number: dbDk
.head 7 -  String: dbCard_Acc
.head 7 -  String: dbCardNo
.head 7 -  Date/Time: dbDat
.head 7 -  String: dbTt
.head 7 -  Number: dbAmount
.head 7 -  String: dbLcv
.head 7 -  String: dbNls
.head 7 -  String: dbBrn
.head 6 +  Actions
.head 7 +  If not SqlPrepareAndExecute(cMain.hSql(), 
"select doc_type, ref, dk, card_acc, vdat, tran_type, s, lcv, nls, brn 
   into :dbDocType, :dbRef, :dbDk, :dbCard_Acc, :dbDat, :dbTt, :dbAmount, :dbLcv, :dbNls, :dbBrn
   from v_obpc_pfiles_form
  where tip in (" || sTip || ") 
  order by ref")
.head 8 -  Return FALSE
.head 7 +  While SqlFetchNext(cMain.hSql(), nFetchRes)
.head 8 -  Set bCardAcctExists = FALSE
.head 8 -  Set nCorCount = 0
.head 8 -  ! Проверка наличия доп. рек.
.head 8 +  If not dbCard_Acc
.head 9 +  If SqlPrepareAndExecute(cAux.hSql(), 
"select card_acct into :dbCard_Acc 
   from v_obpc_acct
  where lacct = :dbNls and currency = :dbLcv
    and doc_type = :dbDocType")
.head 10 +  While SqlFetchNext(cAux.hSql(), nFetchRes)
.head 11 -  Set nCorCount = nCorCount + 1
.head 10 -  ! в справочнике счетов obpc_acct не указан техн. счет для карточного (нет записи)
.head 10 +  If nCorCount = 0
.head 11 -  Call PutLog(IifS(dbDocType=1,"Реф.№","REC №") || SalNumberToStrX(dbRef, 0) || " - невідомий технічний рахунок.")
.head 11 -  Set bCardAcctExists = FALSE
.head 10 -  ! у одного карт. счета м.б. неск. технических
.head 10 +  Else If nCorCount > 1
.head 11 -  Call PutLog(IifS(dbDocType=1,"Реф.№","REC №") || SalNumberToStrX(dbRef, 0) || " - присутній неоднозначний зв'язок з технічним рахунком.")
.head 11 -  Set bCardAcctExists = FALSE 
.head 10 +  Else
.head 11 -  Set bCardAcctExists = TRUE
.head 8 -  ! Проверка правильности доп. рек."Техн. счет"
.head 8 +  Else
.head 9 +  If SqlPrepareAndExecute(cAux.hSql(), 
"select card_acct into :sCardAcct
   from v_obpc_acct
  where lacct = :dbNls and currency = :dbLcv
    and doc_type = :dbDocType")
.head 10 -  ! если карт. счет новый, известен его техн. счет, но техн. счета еще нет в obpc_acct - проверка не нужна, на совесть вводившего доп. рекв.
.head 10 +  While SqlFetchNext(cAux.hSql(), nFetchRes)
.head 11 -  Set nCorCount = nCorCount + 1
.head 11 +  If dbCard_Acc = sCardAcct
.head 12 -  Set bCardAcctExists = TRUE 
.head 12 -  Break
.head 11 +  Else
.head 12 -  Call PutLog(IifS(dbDocType=1,"Реф.№","REC №") || SalNumberToStrX(dbRef, 0) || " - невірно вказано технічний рахунок.")
.head 12 -  Set bCardAcctExists = FALSE 
.head 10 +  If nCorCount = 0
.head 11 -  Call PutLog(IifS(dbDocType=1,"Реф.№","REC №")|| SalNumberToStrX(dbRef, 0) || " - невірно вказано технічний рахунок.")
.head 11 -  Set bCardAcctExists = FALSE 
.head 8 -  ! Если определен технический счет, формируем строку
.head 8 +  If bCardAcctExists
.head 9 -  ! Формирую детальную строку
.head 9 +  If dbCard_Acc
.head 10 -  Set rCode = '11'
.head 9 +  Else
.head 10 -  Set rCode = '10'
.head 9 +  If rCode = '10'
.head 10 -  Set rCard_no = PadL(dbCardNo, 19)
.head 9 +  Else
.head 10 -  Set rCard_no = PadL(dbCard_Acc, 19)
.head 9 -  Set rTran_date   = SalFmtFormatDateTime(dbDat, 'yyyyMMdd')
.head 9 -  Set rBill_ref_no = PadL('', 7)
.head 9 -  Set rTran_type   = PadL(dbTt, 2)
.head 9 -  Set rAmount      = PadL(VisStrSubstitute(SalNumberToStrX(dbAmount/100,2), ',', '.'), 12)
.head 9 -  Set rCurrency    = PadL(dbLcv, 3)
.head 9 -  ! Главное ОПЕРУ
.head 9 -  ! Set rBank_code   = '04'
.head 9 -  ! Set rBranch_code = '000'
.head 9 -  ! Set rBranch_code = SalStrRightX('000' || sBranchCode, 3)
.head 9 +  If Len(dbBrn) != 5 or Subs(dbBrn,1,2) != '04'
.head 10 -  Set rBranch_code = '04' || SalStrRightX('000' || sBranchCode, 3)
.head 9 +  Else
.head 10 -  Set rBranch_code = dbBrn
.head 9 -  ! UserId
.head 9 -  Set rWrpl_no = SalStrRightX('   ', 3)
.head 9 -  Set rTab_no  = SalStrRightX('   ', 3)
.head 9 -  Set rInfoString =
    rCode ||
    rCard_no ||
    rTran_date ||
    rBill_ref_no ||
    rTran_type ||
    rAmount ||
    rCurrency ||
    rBranch_code ||
    rWrpl_no ||
    rTab_no
.head 9 -  ! Вычисляем сумму файла
.head 9 -  Set nFileSum      = nFileSum + dbAmount
.head 9 -  Set nInfoRowCount = nInfoRowCount + 1
.head 9 +  If not SqlPLSQLCommand(cAux.hSql(), "obpc.set_form_flag(dbDocType, dbRef, dbDk, sFileName, dtFormDate, dbCard_Acc, dbTt, dbAmount)")
.head 10 -  Call SqlRollbackEx(cAux.hSql(), 'Помилка на obpc.set_form_flag - ' || IifS(dbDocType=1,"Реф.№","REC №") ||Str(dbRef))
.head 10 -  Return FALSE
.head 9 -  Call PutLine(rInfoString, TRUE)
.head 7 -  Return TRUE
.head 5 -  !
.head 5 +  Function: PutLine
.head 6 -  Description: Вставка строки в файл
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: sString
.head 7 -  Boolean: fToTheEnd
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 +  If SalStrLength(sString) > 0
.head 8 +  If SalStrLength(sFile) > 0
.head 9 +  If fToTheEnd
.head 10 -  Set sFile = sFile || sEOL || sString
.head 9 +  Else
.head 10 -  Set sFile = sString || sEOL || sFile
.head 8 +  Else
.head 9 -  Set sFile = sString
.head 8 -  Set nRowCount = nRowCount + 1
.head 7 -  Return TRUE
.head 5 +  Function: PutLog
.head 6 -  Description: Вставка строки в ЛОГ
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: sString
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 +  If SalStrLength(sString) > 0
.head 8 +  If SalStrLength(sLog) > 0
.head 9 -  Set sLog = sLog || sEOL || sString
.head 8 +  Else
.head 9 -  Set sLog = sString
.head 7 -  Return TRUE
.head 3 +  Functional Class: cFilesImporter
.head 4 -  Description: Импорт файла с разделителями колонок
Ключ. свойства
 sSeparator	- Разделитель колонок
 nValueCount	- Количество колонок
 sValues	- Значения колонок
Ключ. методы
 Open		- Открыть файл
 Close		- Закрыть файл
 FetchNext	- Прочитать след. строку
.head 4 -  Derived From
.head 4 -  Class Variables
.head 4 +  Instance Variables
.head 5 -  ! Разделитель колонок
.head 5 -  String: sSeparator
.head 5 -  ! Количество колонок
.head 5 -  Number: nValueCount
.head 5 -  ! Значения колонок
.head 5 -  String: sValues[*]
.head 5 -  ! Внутр. свойства
.head 5 -  File Handle: hFile
.head 5 -  Boolean: fActive
.head 4 +  Functions
.head 5 -  ! Открыть файл
.head 5 +  Function: Open
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: sFileName
.head 7 -  String: aSeparator
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 +  If SalFileOpen( hFile, sFileName, OF_Read | OF_Text )
.head 8 -  Set sSeparator = aSeparator
.head 8 -  Set fActive    = TRUE
.head 8 -  Return TRUE
.head 7 -  Return FALSE
.head 5 -  ! Закрыть файл
.head 5 +  Function: Close
.head 6 -  Description:
.head 6 -  Returns
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Call SalFileClose( hFile )
.head 7 -  Set fActive=TRUE
.head 7 -  Set nValueCount=0
.head 7 -  Call SalArraySetUpperBound( sValues, 1, -1 )
.head 5 -  ! Прочитать след. строку
.head 5 +  Function: FetchNext
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sLine
.head 6 +  Actions
.head 7 +  If fActive
.head 8 +  If SalFileGetStr( hFile, sLine, 1024 )
.head 9 -  Call SalArraySetUpperBound( sValues, 1, -1 )
.head 9 -  Set nValueCount=SalStrTokenize( sLine, sSeparator, sSeparator, sValues )
.head 9 +  If nValueCount>0
.head 10 -  Return TRUE
.head 7 +  Else
.head 8 -  Return FALSE
.head 3 +  ! Functional Class: cBPKProduct
.winattr
.end
.head 4 -             Description: 
.head 4 -             Derived From 
.head 4 -             Class Variables 
.head 4 +             Instance Variables 
.head 5 -             Number: nId
.head 5 -             String: sName
.head 5 -             String: sType
.head 5 -             Number: nKv
.head 5 -             String: sLcv
.head 5 -             String: sKk
.head 5 -             String: sCondSet
.head 5 -             String: sCondSetName
.head 5 -             Number: nCValidity
.head 5 -             Number: nDebIntr
.head 5 -             Number: nOlimIntr
.head 5 -             Number: nCredIntr
.head 5 -             String: sNbs
.head 5 -             String: sOb22
.head 5 -             Number: nLimit
.head 5 -             String: sIdDoc
.head 5 -             String: sIdDocCred
.head 4 +             Functions 
.head 5 +             Function: setProduct
.head 6 -             Description: 
.head 6 -             Returns 
.head 6 +             Parameters 
.head 7 -             Number: nProductId
.head 6 -             Static Variables 
.head 6 -             Local variables 
.head 6 +             Actions 
.head 7 -             Set nId = 
.head 7 -             Set sName = 
.head 7 -             Set sType = 
.head 7 -             Set nKv   = 
.head 7 -             Set sLcv  =
.head 7 -             Set sKk   = 
.head 7 -             Set sCondSet = 
.head 7 -             Set sCondSetName = 
.head 7 -             Set nCValidity = 
.head 7 -             Set nDebIntr = 
.head 7 -             Set nOlimIntr =
.head 7 -             Set nCredIntr = 
.head 7 -             Set sNbs = 
.head 7 -             Set sOb22 = 
.head 7 -             Set nLimit = 
.head 7 -             Set sIdDoc = 
.head 7 -             Set sIdDocCred = 
.head 7 -             Call setProduct(colId, colName, colType, colTypeName, 
     colKv, colKk, colKkName, colCondSet, colCondSetName,
     colCValidity, colDebIntr, colOlimIntr, colCredIntr,
     colNbs, colNbsName, colOb22, colOb22Name, colLimit,
     colIdDoc, colIdDocCred)
.head 2 +  Default Classes
.head 3 -  MDI Window: cBaseMDI
.head 3 -  Form Window:
.head 3 -  Dialog Box:
.head 3 -  Table Window:
.head 3 -  Quest Window:
.head 3 -  Data Field:
.head 3 -  Spin Field:
.head 3 -  Multiline Field:
.head 3 -  Pushbutton: cpbRefresh
.head 3 -  Radio Button: cRadioButtonLabeled
.head 3 -  Option Button:
.head 3 -  Check Box: cCheckBoxLabeled
.head 3 -  Child Table:
.head 3 -  Quest Child Window: cQuickDatabase
.head 3 -  List Box:
.head 3 -  Combo Box: cGenComboBox_StrId
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
.head 1 -  ! Импорт/Экспорт
.head 1 +  Form Window: frm_ImportPCFiles
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Імпорт файлів ПЦ
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
.head 4 -  Width:  7.0"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 3.8"
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
.head 2 -  Description: Импорт файлов процессингового центра
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
.head 3 -  Background Text: XXXX_
.head 4 -  Resource Id: 13685
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.0"
.head 5 -  Top:    0.1"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.31"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Courier New CYR
.head 4 -  Font Size: 16
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: .DBF
.head 4 -  Resource Id: 13686
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.4"
.head 5 -  Top:    0.1"
.head 5 -  Width:  1.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.31"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Courier New CYR
.head 4 -  Font Size: 16
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfFileName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 3
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.3"
.head 6 -  Top:    0.08"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.35"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Courier New CYR
.head 5 -  Font Size: 16
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbExecute
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbExecute
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.5"
.head 5 -  Top:    0.1"
.head 5 -  Width:  Class Default
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
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call SaveInfoToLog("OBPC. Пользователь выбрал Обработку файлов")
.head 6 -  Call ImportPCFiles()
.head 6 -  Call SalWaitCursor(FALSE)
.head 3 +  Pushbutton: pbImpOnly
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Тільки імпорт
.head 4 -  Window Location and Size
.head 5 -  Left:   5.0"
.head 5 -  Top:    0.1"
.head 5 -  Width:  1.5"
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
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SaveInfoToLog("OBPC. Пользователь выбрал Только импорт")
.head 6 -  Call ImportDBFData()
.head 3 -  Line
.head 4 -  Resource Id: 13687
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  0.05"
.head 5 -  Begin Y:  1.25"
.head 5 -  End X:  6.65"
.head 5 -  End Y:  1.25"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Etched
.head 4 -  Line Thickness: 2
.head 4 -  Line Color: Default
.head 3 +  Check Box: cbImpAcc
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Імпорт файлу рахунків
.head 4 -  Window Location and Size
.head 5 -  Left:   0.3"
.head 5 -  Top:    0.6"
.head 5 -  Width:  6.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 -  Message Actions
.head 3 +  Check Box: cbImpOper
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Імпорт файлу операцій
.head 4 -  Window Location and Size
.head 5 -  Left:   0.3"
.head 5 -  Top:    0.9"
.head 5 -  Width:  6.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 -  Message Actions
.head 3 -  Line
.head 4 -  Resource Id: 13688
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  0.05"
.head 5 -  Begin Y:  2.3"
.head 5 -  End X:  6.65"
.head 5 -  End Y:  2.3"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Etched
.head 4 -  Line Thickness: 2
.head 4 -  Line Color: Default
.head 3 +  Check Box: cbParams
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Оновлення параметрів карткових рахунків
.head 4 -  Window Location and Size
.head 5 -  Left:   0.3"
.head 5 -  Top:    1.35"
.head 5 -  Width:  6.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 -  Message Actions
.head 3 +  Check Box: cbComplete
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Квитовка операцій банку
.head 4 -  Window Location and Size
.head 5 -  Left:   0.3"
.head 5 -  Top:    1.65"
.head 5 -  Width:  6.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 -  Message Actions
.head 3 +  Check Box: cbPay
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Оплата операцій ПЦ
.head 4 -  Window Location and Size
.head 5 -  Left:   0.3"
.head 5 -  Top:    1.95"
.head 5 -  Width:  6.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 -  Message Actions
.head 3 -  Line
.head 4 -  Resource Id: 41575
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  0.05"
.head 5 -  Begin Y:  2.75"
.head 5 -  End X:  6.65"
.head 5 -  End Y:  2.75"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Etched
.head 4 -  Line Thickness: 2
.head 4 -  Line Color: Default
.head 3 +  Check Box: cbCheck
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Перевірка цілістності даних
.head 4 -  Window Location and Size
.head 5 -  Left:   0.3"
.head 5 -  Top:    2.4"
.head 5 -  Width:  6.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 -  Message Actions
.head 3 -  Line
.head 4 -  Resource Id: 26202
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  0.05"
.head 5 -  Begin Y:  3.2"
.head 5 -  End X:  6.65"
.head 5 -  End Y:  3.2"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Etched
.head 4 -  Line Thickness: 2
.head 4 -  Line Color: Default
.head 3 +  Custom Control: ccMeter
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
.head 6 -  Left:   0.1"
.head 6 -  Top:    2.85"
.head 6 -  Width:  6.55"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.25"
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
.head 5 -  Text Color: Green
.head 5 -  Background Color: Dark Gray
.head 5 -  DLL Settings
.head 4 +  Message Actions
.head 5 +  On SAM_User
.head 6 -  ! Прогресс
.head 6 +  If wParam = 0
.head 7 +  If (nDone <= nTotal) AND (nTotal != 0)
.head 8 -  Call ccMeter.SetProgress( nDone/nTotal*100 )
.head 7 +  Else
.head 8 -  Call ccMeter.SetProgress( 100 )
.head 6 -  ! Сброс
.head 6 +  Else If wParam = 1
.head 7 -  Call ccMeter.SetProgress( 0 )
.head 6 -  ! 100%
.head 6 +  Else If wParam = 2
.head 7 -  Call ccMeter.SetProgress( 100 )
.head 3 -  Line
.head 4 -  Resource Id: 13689
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  0.05"
.head 5 -  Begin Y:  0.5"
.head 5 -  End X:  6.65"
.head 5 -  End Y:  0.5"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Etched
.head 4 -  Line Thickness: 2
.head 4 -  Line Color: Default
.head 2 +  Functions
.head 3 +  Function: InitInfoWindow
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SalHideWindow(cbImpAcc)
.head 5 -  Call SalHideWindow(cbImpOper)
.head 5 -  Call SalHideWindow(cbParams)
.head 5 -  Call SalHideWindow(cbComplete)
.head 5 -  Call SalHideWindow(cbPay)
.head 5 -  Call SalHideWindow(cbCheck)
.head 5 -  Call SalHideWindow(ccMeter)
.head 5 -  Set cbImpAcc   = FALSE
.head 5 -  Set cbImpOper  = FALSE
.head 5 -  Set cbParams   = FALSE
.head 5 -  Set cbComplete = FALSE
.head 5 -  Set cbPay      = FALSE
.head 5 -  Set cbCheck    = FALSE
.head 5 -  Call SalDisableWindow(cbImpAcc)
.head 5 -  Call SalDisableWindow(cbImpOper)
.head 5 -  Call SalDisableWindow(cbParams)
.head 5 -  Call SalDisableWindow(cbComplete)
.head 5 -  Call SalDisableWindow(cbPay)
.head 5 -  Call SalDisableWindow(cbCheck)
.head 5 -  Set sLog = ''
.head 5 -  Return TRUE
.head 3 +  Function: ImportPCFiles
.head 4 -  Description: Импорт файлов пришедших из ПЦ=
Квитовка собственных операций
+
Оплата новых
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nFileId
.head 4 +  Actions
.head 5 -  ! Инициализация интерфейса
.head 5 -  Call InitInfoWindow()
.head 5 +  If IsBankDayOpen()
.head 6 +  If dfFileName
.head 7 -  ! Инициализация индикатора
.head 7 -  Set nDone  = 0
.head 7 -  Set nTotal = 4
.head 7 -  Call SalShowWindow(ccMeter)
.head 7 -  Call SalSendMsg(ccMeter, SAM_User, 1, 0)
.head 7 -  Set nFileId = ImportData(SalStrUpperX(dfFileName), FALSE)
.head 7 -  ! Импорт выполнен
.head 7 +  If nFileId > 0
.head 8 -  ! Установка параметров
.head 8 -  Call SetAccParams(nFileId)
.head 8 -  ! Квитовка операций банка
.head 8 -  Call CompleteOpers(nFileId)
.head 8 -  ! Оплата операций ПЦ
.head 8 -  Call PayOpers(nFileId)
.head 8 -  ! Проверки
.head 8 -  Call CheckAcctTran(nFileId)
.head 8 -  ! Log
.head 8 +  If not sLog
.head 9 -  Set sLog = 'Файли успішно оброблено'
.head 8 -  Call SalModalDialog(dlgStatus, hWndForm, sLog, 'Статус імпорту файлів ПЦ')
.head 8 -  Call SaveInfoToLog('OBPC. ' || sLog)
.head 7 -  ! Ощибка при импорте
.head 7 +  Else If nFileId = 0
.head 8 -  Call SalMessageBox("Імпорт припинений", "Увага!", MB_IconExclamation | MB_Ok)
.head 7 -  ! Импорт не производился
.head 7 -  Else If nFileId < 0
.head 7 -  Call SalHideWindow(ccMeter)
.head 5 +  Else
.head 6 -  Call SalMessageBox("Банківський день закрито!", "Увага!", MB_Ok | MB_IconStop)
.head 3 +  Function: ImportDBFData
.head 4 -  Description: Импорт файлов пришедших из ПЦ
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nFileId
.head 4 +  Actions
.head 5 -  ! Инициализация интерфейса
.head 5 -  Call InitInfoWindow()
.head 5 +  If IsBankDayOpen()
.head 6 +  If dfFileName
.head 7 -  ! Инициализация индикатора
.head 7 -  Call SalShowWindow(ccMeter)
.head 7 -  Set nDone  = 0
.head 7 -  Set nTotal = 4
.head 7 -  Call SalShowWindow(ccMeter)
.head 7 -  Call SalSendMsg(ccMeter, SAM_User, 1, 0)
.head 7 -  Set nFileId = ImportData(SalStrUpperX(dfFileName), TRUE)
.head 7 +  If nFileId > 0
.head 8 -  Set sLog = 'Файли успішно проімпортовано'
.head 8 -  Call SalModalDialog(dlgStatus, hWndForm, sLog, 'Статус імпорту файлів ПЦ')
.head 7 -  Call SalHideWindow(ccMeter)
.head 5 +  Else
.head 6 -  Call SalMessageBox("Банківський день закрито!", "Увага!", MB_Ok | MB_IconStop)
.head 3 +  Function: ImportData
.head 4 -  Description: Импорт информации из DBF во временные таблицы
.head 4 +  Returns
.head 5 -  Number:
.head 4 +  Parameters
.head 5 -  String: sFileSufix
.head 5 -  Boolean: bImpOnly
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sErrMsg
.head 5 -  ! Путь
.head 5 -  String: sPath
.head 5 -  ! Файл (для проверки существования)
.head 5 -  File Handle: hFile
.head 5 -  ! Имя файла счетов
.head 5 -  String: sAcctFile
.head 5 -  ! Имя файла операций
.head 5 -  String: sTranFile
.head 5 -  ! Понты
.head 5 -  Number: nFetchRes
.head 5 -  ! Код файла
.head 5 -  Number: nFileId
.head 5 -  ! Результат этой функции
.head 5 -  Number: Result
.head 4 +  Actions
.head 5 -  Set Result  = 0
.head 5 -  Set nFileId = 0
.head 5 -  ! Чтение параметров
.head 5 -  Call SalUseRegistry(FALSE, '')
.head 5 -  Call SalGetProfileString('OBPC', 'OBPCInPath', '', sPath, GetIniFileName())
.head 5 -  !
.head 5 +  Loop
.head 6 -  ! Проверка повторного импортирования
.head 6 +  If SqlPrepareAndExecute(hSql(), "SELECT id INTO :nFileId FROM OBPC_FILES WHERE FILE_NAME = :sFileSufix and nvl(arc,0) = 0")
.head 7 +  If SqlFetchNext(hSql(), nFetchRes)
.head 8 -  ! Файл уже импортился
.head 8 +  If nFileId
.head 9 +  If bImpOnly
.head 10 -  Call SalMessageBox( 
     "Файл " || sFileSufix || " вже імпортувався!",
     "Увага!", MB_Ok | MB_IconStop)
.head 10 -  Set Result = -1
.head 10 -  Call SaveInfoToLog("OBPC. Файл " || sFileSufix || " вже імпортувався!")
.head 10 -  Break
.head 9 +  Else
.head 10 +  If SalMessageBox( 
   "Файл " || sFileSufix || " вже імпортувався!" || PutCrLf() ||
   "Провести повторну обробку даних в БД?",
   "Увага!", MB_YesNo | MB_IconQuestion) = IDYES
.head 11 -  Call SaveInfoToLog("OBPC. Повторная обработка файла " || sFileSufix)
.head 11 -  Set Result = nFileId
.head 11 -  Break
.head 10 +  Else
.head 11 -  Set Result = -1
.head 11 -  Call SaveInfoToLog("OBPC. Пользователь отказался от повторной обработки файла " || sFileSufix)
.head 11 -  Break
.head 6 -  ! Нахожу файлы
.head 6 -  Set sAcctFile = sPath || 'ACCT_' || sFileSufix || '.DBF'
.head 6 -  Set sTranFile = sPath || 'TRAN_' || sFileSufix || '.DBF'
.head 6 +  If SalFileOpen(hFile, sAcctFile, OF_Exist) AND
   SalFileOpen(hFile, sTranFile, OF_Exist)
.head 7 -  ! =============================================
.head 7 -  Set sAcctFile = 'ACCT_' || sFileSufix
.head 7 -  Set sTranFile = 'TRAN_' || sFileSufix
.head 7 -  Set nDone = nDone + 1
.head 7 -  Call SalSendMsg(ccMeter, SAM_User, 0, 0)
.head 7 -  ! =============================================
.head 7 -  ! Счета
.head 7 -  Call SaveInfoToLog("OBPC. Импорт файла счетов.")
.head 7 -  ! Показываем пункт
.head 7 -  Call SalShowWindow(cbImpAcc)
.head 7 -  Call SalUpdateWindow(hWndForm)
.head 7 -  ! Импорт во временную таблицу
.head 7 +  If not ImportUseMomory(sPath, sAcctFile || '.DBF', 'TEST_OBPC_ACCT_' || sBankMfo, 'UKG', 1, sErrMsg)
.head 8 -  Call SalMessageBox("Помилка імпорту файла " || sAcctFile || '.DBF ' || sErrMsg,
     "Помилка", MB_Ok | MB_IconStop )
.head 8 -  Call SaveInfoToLog("OBPC. " || "Помилка імпору файла " || sAcctFile || '.DBF: ' || sErrMsg)
.head 8 -  Break
.head 7 -  ! Отметка об импорте
.head 7 -  Set cbImpAcc = TRUE
.head 7 -  Call SalUpdateWindow(hWndForm)
.head 7 -  Set nDone = nDone + 1
.head 7 -  Call SalSendMsg(ccMeter, SAM_User, 0, 0)
.head 7 -  Call SaveInfoToLog("OBPC. Импорт файла счетов окончен")
.head 7 -  ! =============================================
.head 7 -  ! Операции
.head 7 -  Call SaveInfoToLog("OBPC. Импорт файла операций.")
.head 7 -  ! Показываем пункт
.head 7 -  Call SalShowWindow(cbImpOper)
.head 7 -  Call SalUpdateWindow(hWndForm)
.head 7 -  ! Импорт во временную таблицу
.head 7 +  If not ImportUseMomory(sPath, sTranFile || '.DBF', 'TEST_OBPC_TRAN_' || sBankMfo, 'UKG', 1, sErrMsg)
.head 8 -  Call SalMessageBox("Помилка імпорту файла " || sTranFile || '.DBF ' || sErrMsg,
     "Помилка", MB_Ok | MB_IconStop )
.head 8 -  Call SaveInfoToLog("OBPC. " || "Помилка імпору файла " || sAcctFile || '.DBF: ' || sErrMsg)
.head 8 -  Break
.head 7 -  ! Отметка об импорте
.head 7 -  Set cbImpOper = TRUE
.head 7 -  Call SalUpdateWindow(hWndForm)
.head 7 -  Set nDone = nDone + 1
.head 7 -  Call SalSendMsg(ccMeter, SAM_User, 0, 0)
.head 7 -  Call SaveInfoToLog("OBPC. Импорт файла операций окончен")
.head 7 -  ! =============================================
.head 7 -  ! Импорт в табл. obpc* 
.head 7 +  If SqlPLSQLCommand(hSql(), "obpc.import_data(sFileSufix, nFileId)")
.head 8 -  Set Result = nFileId
.head 7 -  Set nDone = nDone + 1
.head 7 -  Call SalSendMsg(ccMeter, SAM_User, 0, 0)
.head 7 -  ! =============================================
.head 7 -  ! Commit/Rollback
.head 7 +  If Result
.head 8 -  Call SqlCommitEx(hSql(), "OBPC. Успешный импорт файла " || sFileSufix)
.head 8 -  ! =============================================
.head 8 -  ! Переименование файлов
.head 8 -  Call VisFileRename(
     sPath || 'ACCT_' || sFileSufix || '.DBF', 
     sPath || 'ACCT_' || sFileSufix || '.OLD' )
.head 8 -  Call VisFileRename(
     sPath || 'TRAN_' || sFileSufix || '.DBF', 
     sPath || 'TRAN_' || sFileSufix || '.OLD' )
.head 8 -  ! =============================================
.head 7 +  Else
.head 8 -  Call SqlRollbackEx(hSql(), "OBPC. Неуспешный импорт файла " || sFileSufix)
.head 7 -  ! =============================================
.head 7 -  Call SalSendMsg(ccMeter, SAM_User, 2, 0)
.head 6 +  Else
.head 7 -  Call SalMessageBox("Один або обидва файли не існують: " || sAcctFile || ", " || sTranFile || "." ,
     "Помилка", MB_Ok | MB_IconStop )
.head 7 -  Call SaveInfoToLog("OBPC. Один или оба файла не существуют: " || sAcctFile || ", " || sTranFile)
.head 7 -  Set Result = -1
.head 7 -  Break
.head 6 -  Break
.head 5 -  !
.head 5 -  Return Result
.head 3 +  Function: SetAccParams
.head 4 -  Description: Фаза установки лимитов на счетах
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Number: nFileId
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SaveInfoToLog("OBPC. Обновление параметров счетов по файлу acct.")
.head 5 -  ! Показываем пункт
.head 5 -  Call SalShowWindow(cbParams)
.head 5 -  Call SalUpdateWindow(hWndForm)
.head 5 -  ! Установка лимитов
.head 5 +  If not SqlPLSQLCommand(hSql(), "obpc.set_acc_params(nFileId)")
.head 6 -  Call SqlRollbackEx(hSql(), "OBPC. Ощибка выполнения процедуры обновления параметров счетов по файлу acct.")
.head 5 +  Else
.head 6 -  Call SqlCommitEx(hSql(), "OBPC. Выполнено обновление параметров счетов по файлу acct.")
.head 6 -  ! Отметка об окончании
.head 6 -  Set cbParams = TRUE
.head 5 -  Call SalUpdateWindow(hWndForm)
.head 5 -  ! Перечитываем индикатор
.head 5 -  Set nDone = nDone + 1
.head 5 -  Call SalSendMsg(ccMeter, SAM_User, 0, 0)
.head 5 -  Return TRUE
.head 3 +  Function: CompleteOpers
.head 4 -  Description: Фаза квитовки операций
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Number: nFileId
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nCount
.head 4 +  Actions
.head 5 -  Call SaveInfoToLog("OBPC. Квитовка операций банка.")
.head 5 -  ! Показываем пункт
.head 5 -  Call SalShowWindow(cbComplete)
.head 5 -  Call SalUpdateWindow(hWndForm)
.head 5 -  ! Квитовка операций
.head 5 +  If not SqlPLSQLCommand(hSql(), "obpc.kvt_oper(nFileId)")
.head 6 -  Call SqlRollbackEx(hSql(), "OBPC. Неуспешное выполнение процедуры квитовки операций банка")
.head 5 +  Else
.head 6 -  Call SqlCommitEx(hSql(), "OBPC. Выполнена процедура квитовки операций банка")
.head 6 -  ! Отметка об окончании квитовки операций
.head 6 -  Set cbComplete = TRUE
.head 5 -  Call SalUpdateWindow(hWndForm)
.head 5 -  ! Перечитываем индикатор
.head 5 -  Set nDone = nDone + 1
.head 5 -  Call SalSendMsg(ccMeter, SAM_User, 0, 0)
.head 5 -  Return TRUE
.head 3 +  Function: PayOpers
.head 4 -  Description: Фаза оплаты операций ПЦ
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nFileId
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SaveInfoToLog("OBPC. Оплата операций ПЦ.")
.head 5 -  ! Показываем пункт
.head 5 -  Call SalShowWindow(cbPay)
.head 5 -  Call SalUpdateWindow(hWndForm)
.head 5 -  ! Оплата операций
.head 5 +  If not SqlPLSQLCommand(hSql(), "obpc.pay_oper(nFileId)")
.head 6 -  Call SqlRollbackEx(hSql(), "OBPC. Неуспешное выполнение процедуры оплаты операций ПЦ")
.head 5 +  Else
.head 6 -  Call SqlCommitEx(hSql(), "OBPC. Выполнена процедура оплаты операций ПЦ")
.head 6 -  ! Отметка об окончании оплаты
.head 6 -  Set cbPay = TRUE
.head 5 -  Call SalUpdateWindow(hWndForm)
.head 5 -  ! Перечитываем индикатор
.head 5 -  Set nDone = nDone + 1
.head 5 -  Call SalSendMsg(ccMeter, SAM_User, 0, 0)
.head 5 -  Return TRUE
.head 3 -  ! Проверка целостности
.head 3 +  Function: CheckAcctTran
.head 4 -  Description: проверки после обработки файлов
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nFileId
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  : cMain
.head 6 -  Class: cABSConnect
.head 5 -  : cAux
.head 6 -  Class: cABSConnect
.head 5 -  Number: nFetchRes
.head 5 -  Number: nCount
.head 5 -  ! Свойства документа для оплаты
.head 5 -  String: sTt
.head 5 -  String: sTtAll
.head 5 -  !
.head 5 -  String: sDataList
.head 5 -  Number: nDataCount
.head 5 -  !
.head 5 -  Boolean: fError
.head 5 -  !
.head 5 -  Date/Time: dBDate
.head 4 +  Actions
.head 5 -  Call XConnectGetParams(cMain)
.head 5 -  Call cAux.Clone(cMain, FALSE)
.head 5 +  If cMain.Connect() AND cAux.Connect()
.head 6 -  ! Инициализация индикатора
.head 6 -  Call SalShowWindow(ccMeter)
.head 6 -  Set nDone  = 0
.head 6 -  Set nTotal = 10
.head 6 -  Call SalSendMsg(ccMeter, SAM_User, 1, 0)
.head 6 -  Call SalShowWindow(cbCheck)
.head 6 -  Call SalUpdateWindow(hWndForm)
.head 6 -  ! 1: Проверка несквитованных документов банка
.head 6 +  If SqlPrepareAndExecute(cMain.hSql(), "SELECT COUNT(*) INTO :nCount FROM PKK_QUE WHERE sos=1")
.head 7 +  If SqlFetchNext(cMain.hSql(), nFetchRes) 
.head 8 +  If nCount
.head 9 -  Call PutLog(SalNumberToStrX(nCount, 0) || ' несквітованних документів БАНКА після квітовки!')
.head 6 -  Set nDone = nDone + 1
.head 6 -  Call SalSendMsg(ccMeter, SAM_User, 0, 0)
.head 6 -  ! 2: Проверка несквитованных документов ПЦ
.head 6 +  If SqlPrepareAndExecute(hSql(),
"SELECT COUNT(*) INTO :nCount
   FROM OBPC_TRAN A, OBPC_TRANS B
  WHERE a.id = :nFileId
    AND a.tran_type = b.tran_type AND b.bof = 1")
.head 7 +  If SqlFetchNext(hSql(), nFetchRes)
.head 8 +  If nCount
.head 9 -  Call PutLog(SalNumberToStrX(nCount, 0) || ' несквітованих документів ПЦ після квітовки!')
.head 6 -  Set nDone = nDone + 1
.head 6 -  Call SalSendMsg(ccMeter, SAM_User, 0, 0)
.head 6 -  ! 3: Проверка необработанных документов ПЦ
.head 6 +  If SqlPrepareAndExecute(cMain.hSql(), 
"SELECT COUNT(*) INTO :nCount
   FROM OBPC_TRAN A, OBPC_TRANS B
  WHERE a.id = :nFileId 
    AND a.tran_type = b.tran_type AND b.bof = 0 ")
.head 7 +  If SqlFetchNext(cMain.hSql(), nFetchRes) 
.head 8 +  If nCount
.head 9 -  Call PutLog(SalNumberToStrX(nCount, 0) || ' необроблених документів ПЦ після оплати.')
.head 6 -  Set nDone = nDone + 1
.head 6 -  Call SalSendMsg(ccMeter, SAM_User, 0, 0)
.head 6 -  ! 4: Проверка необработанных документов (всего)
.head 6 +  If SqlPrepareAndExecute(cMain.hSql(), 
"SELECT COUNT(*) INTO :nCount
   FROM OBPC_TRAN A
  WHERE a.id = :nFileId")
.head 7 +  If SqlFetchNext(cMain.hSql(), nFetchRes) 
.head 8 +  If nCount
.head 9 -  Call PutLog('ВСЬОГО ' || SalNumberToStrX(nCount, 0) || ' необроблених документів після імпорту.')
.head 6 -  Set nDone = nDone + 1
.head 6 -  Call SalSendMsg(ccMeter, SAM_User, 0, 0)
.head 6 -  ! 5: Проверка настройки импортных операций
.head 6 +  If SqlPrepareAndExecute(cMain.hSql(), 
"SELECT DISTINCT A.TRAN_TYPE INTO :sTt 
   FROM OBPC_TRAN A, OBPC_TRANS B 
  WHERE a.id = :nFileId
    AND a.tran_type = b.tran_type AND b.bof = 0 
    AND ( b.tran_type not in (select tran_type from obpc_trans_in)
       or b.tran_type in (select tran_type from obpc_trans_in where tt is null) )
 ORDER BY tran_type")
.head 7 -  Set sTtAll = ''
.head 7 +  While SqlFetchNext(cMain.hSql(), nFetchRes) 
.head 8 +  If sTtAll
.head 9 -  Set sTtAll = sTtAll || ',' || sTt
.head 8 +  Else
.head 9 -  Set sTtAll = sTt
.head 7 +  If sTtAll
.head 8 -  Call PutLog('Для слід. типів операцій ПЦ не задано види операцій:')
.head 8 -  Call PutLog(sTtAll || '.')
.head 6 -  Set nDone = nDone + 1
.head 6 -  Call SalSendMsg(ccMeter, SAM_User, 0, 0)
.head 6 -  ! 6: Проверка транзитных счетов
.head 6 +  If SqlPrepareAndExecute(cMain.hSql(), 
"select tran_type || ': валюта-' || kv || ', тип рахунку-' || tip" ||
        IifS(nHAVETOBO=2, "|| ', відділення-' || substr(branch,1,15)", "") || "
   into :sTt
   from ( select unique s.tobo branch, t.tran_type, s.kv, s.tip
            from obpc_tran t, obpc_acct a, accounts s
           where t.id = :nFileId
             and t.card_acct = a.card_acct and a.acc = s.acc
             and (t.tran_type, s.tip, substr(s.tobo,1,15), s.kv) not in 
                 (select tran_type, tip, branch, kv from obpc_trans_tran)
           order by s.tobo, t.tran_type, s.tip)")
.head 7 -  Set sTtAll = ''
.head 7 +  While SqlFetchNext(cMain.hSql(), nFetchRes) 
.head 8 +  If sTtAll
.head 9 -  Set sTtAll = sTtAll || PutCrLf() || sTt
.head 8 +  Else
.head 9 -  Set sTtAll = sTt
.head 7 +  If sTtAll
.head 8 -  Call PutLog('Для слід. типів операцій ПЦ не задано транзитний рахунок:')
.head 8 -  Call PutLog(sTtAll)
.head 6 -  Set nDone = nDone + 1
.head 6 -  Call SalSendMsg(ccMeter, SAM_User, 0, 0)
.head 6 -  ! Проверка целостности
.head 6 -  ! 7: Проверка закрытых счетов, по кот. шли операции
.head 6 +  If CheckIntegrity(cMain.hSql(),
"select unique a.tobo || '   ' || a.nls || ' ' || o.currency
   into :sData
   from accounts a, obpc_acct o, obpc_tran t
  where t.id = " || Str(nFileId) || "
    and t.card_acct = o.card_acct
    and o.acc = a.acc
    and a.dazs is not null
  order by 1", sDataList, nDataCount)
.head 7 +  If sDataList
.head 8 -  Call PutLog('Рахунки, закриті в АБС, по яким були операції в TRAN*.dbf:' || sEOL || sDataList)
.head 6 -  Set nDone = nDone + 1
.head 6 -  Call SalSendMsg(ccMeter, SAM_User, 0, 0)
.head 6 -  ! 8: Бал. счета из ACCT_*.DBF не открытые в АБС
.head 6 +  If CheckIntegrity(cMain.hSql(),
"select unique a.branch || '   ' || a.lacct || ' ' || a.currency INTO :sData 
   from obpc_acct a, obpc_tran t
  where t.id = " || Str(nFileId) || "
    and t.card_acct = a.card_acct
    and a.acc is null
    and nvl(a.status,'0') <> '4'
  order by 1", sDataList, nDataCount)
.head 7 +  If nDataCount > 500
.head 8 -  Call PutLog('Більше 500 карт. рахунків з ACCT_*.DBF не відкрито в АБС!')
.head 7 +  Else If sDataList
.head 8 -  Call PutLog('Карт. рахунки з ACCT_*.DBF не відкриті в АБС:' || sEOL || sDataList)
.head 6 -  Set nDone = nDone + 1
.head 6 -  Call SalSendMsg(ccMeter, SAM_User, 0, 0)
.head 6 -  ! 9: Тех. счета из TRAN_*.DBF отсутствующие в ACCT_*.DBF
.head 6 +  If CheckIntegrity(cMain.hSql(),
"SELECT DISTINCT card_acct INTO :sData 
   FROM OBPC_TRAN 
  WHERE id = " || Str(nFileId) || "
    AND card_acct NOT IN (SELECT card_acct FROM OBPC_ACCT)", sDataList, nDataCount)
.head 7 +  If nDataCount > 500
.head 8 -  Call PutLog('Більше 500 тех. рахунків з TRAN_*.DBF відсутні в ACCT_*.DBF!')
.head 7 +  Else If sDataList
.head 8 -  Call PutLog('Тех. рахунки з TRAN_*.DBF відсутні в ACCT_*.DBF:' || sEOL || sDataList)
.head 6 -  Set nDone = nDone + 1
.head 6 -  Call SalSendMsg(ccMeter, SAM_User, 0, 0)
.head 6 -  Set cbCheck = TRUE
.head 6 -  Call SalUpdateWindow(hWndForm)
.head 5 -  Return TRUE
.head 3 +  Function: CheckIntegrity
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Sql Handle: hSql
.head 5 -  String: sSqlText
.head 5 -  Receive String: sOverideList
.head 5 -  Receive Number: nOverideCount
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sData
.head 5 -  Number: nFetchRes
.head 4 +  Actions
.head 5 -  Set nOverideCount = 0
.head 5 -  Set sOverideList  = ''
.head 5 +  If SqlPrepareAndExecute(hSql, sSqlText)
.head 6 +  While SqlFetchNext(hSql, nFetchRes)
.head 7 +  If sOverideList
.head 8 -  Set sOverideList = sOverideList || ',' || sEOL || sData
.head 7 +  Else
.head 8 -  Set sOverideList = sData
.head 7 -  Set nOverideCount = nOverideCount + 1
.head 7 +  If nOverideCount > 500
.head 8 -  Break
.head 5 -  Return nOverideCount > 0
.head 3 +  Function: PutLog
.head 4 -  Description: Вставка строки в ЛОГ
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: sString
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If SalStrLength(sString) > 0
.head 6 +  If SalStrLength(sLog) > 0
.head 7 -  Set sLog = sLog || sEOL || sString
.head 6 +  Else
.head 7 -  Set sLog = sString
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  Number: nHAVETOBO
.head 3 -  ! Для прогресс-индикатора
.head 3 -  Number: nTotal
.head 3 -  Number: nDone
.head 3 -  ! Log
.head 3 -  String: sLog
.head 3 -  !
.head 3 -  Boolean: fLogCalled
.head 3 -  !
.head 3 -  String: sEOL
.head 3 -  String: sBankMfo
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Set nHAVETOBO = GetGlobalOptionEx('HAVETOBO')
.head 4 -  Set sEOL = SalNumberToChar(13) || SalNumberToChar(10)
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Call SalHideWindow(pbImpOnly)
.head 4 -  Set fLogCalled = FALSE
.head 4 -  ! Инициализация интерфейса
.head 4 -  Call InitInfoWindow()
.head 4 -  !
.head 3 +  On SAM_CreateComplete
.head 4 +  If nHAVETOBO = 2
.head 5 +  If not SqlPrepareAndExecute(hSql(), "select substr(bc.extract_mfo,1,6) into :sBankMfo from dual")
or not SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Call SalDestroyWindow(hWndForm)
.head 1 -  !
.head 1 +  Form Window: frm_ImportInternalTasks
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Импорт файлов локальных задач
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
.head 4 -  Width:  8.6"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 4.5"
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
.head 2 -  Description: Импорт файлов локальных задач
Зарплата и депозиты
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
.head 3 -  ! Background Text: Транзит З/П:
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.117"
.head 5 -  Top:    0.06"
.head 5 -  Width:  2.767"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.262"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Courier New CYR
.head 4 -  Font Size: 16
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 3 -  ! Group Box: Счет З/П
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.1"
.head 5 -  Width:  4.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.65"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 3 -  Background Text: Счет З/П
.head 4 -  Resource Id: 51468
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.1"
.head 5 -  Width:  2.0"
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
.head 3 +  Data Field: dfTransNls
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 14
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.2"
.head 6 -  Top:    0.35"
.head 6 -  Width:  3.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.286"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Courier New CYR
.head 5 -  Font Size: 12
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Validate
.head 6 +  If not SalIsNull(dfTransNls)
.head 7 -  Call SqlPrepareAndExecute(hSql(), "select acc, nms into :nTransAcc, :sTransNms from accounts where nls = :dfTransNls and kv = 980")
.head 7 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Call SalMessageBox("Счет " || dfTransNls || "/UAH не найден!", "Внимание!", MB_IconStop | MB_Ok)
.head 8 -  Return VALIDATE_Cancel
.head 7 -  Call SalSetWindowLabelText(bgTransNms, sTransNms)
.head 6 -  Return VALIDATE_Ok
.head 3 -  Background Text: Название счета
.head 4 -  Resource Id: 51467
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.3"
.head 5 -  Top:    0.4"
.head 5 -  Width:  5.0"
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
.head 3 +  Data Field: bgTransNms
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
.head 3 -  !
.head 3 -  Group Box: Справочник счетов-клиентов
.head 4 -  Resource Id: 38655
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.8"
.head 5 -  Width:  4.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.0"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfSpravFile
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 8
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.2"
.head 6 -  Top:    1.05"
.head 6 -  Width:  2.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.3"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Courier New CYR
.head 5 -  Font Size: 16
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: .TXT
.head 4 -  Resource Id: 38652
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.25"
.head 5 -  Top:    1.1"
.head 5 -  Width:  1.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.3"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Courier New CYR
.head 4 -  Font Size: 16
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Check Box: cbImportSprav
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Импорт
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    1.45"
.head 5 -  Width:  2.0"
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
.head 3 +  Pushbutton: pbAll
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbExecute
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.4"
.head 5 -  Top:    1.05"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: (none)
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
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call ImportInFiles(TRUE, TRUE)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On SAM_Create
.head 6 -  Set strTip = 'Выполнить импорт зарплаты и депозитов'
.head 3 +  Pushbutton: pbCheck
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbRelation
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.4"
.head 5 -  Top:    1.4"
.head 5 -  Width:  0.4"
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
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call PeformIntegrityCheck()
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On SAM_Create
.head 6 -  Set strTip = 'Проверка целостности данных'
.head 3 -  !
.head 3 -  Group Box: Начисление З/П
.head 4 -  Resource Id: 38656
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    1.9"
.head 5 -  Width:  4.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.0"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfElplatFile
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 8
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.2"
.head 6 -  Top:    2.15"
.head 6 -  Width:  2.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.3"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Courier New CYR
.head 5 -  Font Size: 16
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: .TXT
.head 4 -  Resource Id: 38654
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.25"
.head 5 -  Top:    3.3"
.head 5 -  Width:  1.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.3"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Courier New CYR
.head 4 -  Font Size: 16
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Check Box: cbImportElplat
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Импорт
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    2.55"
.head 5 -  Width:  2.0"
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
.head 3 +  Pushbutton: pbExecutePlat
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbExecute
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.4"
.head 5 -  Top:    2.15"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: (none)
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
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call ImportInFiles(TRUE, FALSE)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On SAM_Create
.head 6 -  Set strTip = 'Выполнить импорт зарплаты'
.head 3 -  !
.head 3 -  Group Box: Начисление ДЕПОЗИТОВ
.head 4 -  Resource Id: 38657
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    3.0"
.head 5 -  Width:  4.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.0"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: DP
.head 4 -  Resource Id: 38653
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    3.3"
.head 5 -  Width:  0.5"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.3"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Courier New CYR
.head 4 -  Font Size: 16
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfDpFile
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 6
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.7"
.head 6 -  Top:    3.25"
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.3"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Courier New CYR
.head 5 -  Font Size: 16
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: .TXT
.head 4 -  Resource Id: 38658
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.25"
.head 5 -  Top:    2.2"
.head 5 -  Width:  1.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.3"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Courier New CYR
.head 4 -  Font Size: 16
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Check Box: cbImportDp
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Импорт
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    3.65"
.head 5 -  Width:  2.0"
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
.head 3 +  Pushbutton: pbExecuteDep
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbExecute
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.383"
.head 5 -  Top:    3.25"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: (none)
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
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call ImportInFiles(FALSE, TRUE)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On SAM_Create
.head 6 -  Set strTip = 'Выполнить импорт депозитов'
.head 3 -  !
.head 3 +  Check Box: cb1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Импорт текстового файла
.head 4 -  Window Location and Size
.head 5 -  Left:   4.3"
.head 5 -  Top:    1.05"
.head 5 -  Width:  4.0"
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
.head 3 +  Custom Control: ccMeter1
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
.head 6 -  Left:   4.3"
.head 6 -  Top:    1.45"
.head 6 -  Width:  4.0"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.25"
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
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Green
.head 5 -  Background Color: Dark Gray
.head 5 -  DLL Settings
.head 4 +  Message Actions
.head 5 +  On SAM_User
.head 6 -  ! Прогресс
.head 6 +  If wParam=0
.head 7 +  If (nDone<=nTotal) AND (nTotal!=0)
.head 8 -  Call ccMeter1.SetProgress( nDone/nTotal*100 )
.head 7 +  Else
.head 8 -  Call ccMeter1.SetProgress( 100 )
.head 6 -  ! Сброс
.head 6 +  Else If wParam=1
.head 7 -  Call ccMeter1.SetProgress( 0 )
.head 6 -  ! 100%
.head 6 +  Else If wParam=2
.head 7 -  Call ccMeter1.SetProgress( 100 )
.head 3 +  Check Box: cb2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Импорт текстового файла
.head 4 -  Window Location and Size
.head 5 -  Left:   4.3"
.head 5 -  Top:    2.15"
.head 5 -  Width:  4.0"
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
.head 3 +  Custom Control: ccMeter2
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
.head 6 -  Left:   4.3"
.head 6 -  Top:    2.55"
.head 6 -  Width:  4.0"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.25"
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
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Green
.head 5 -  Background Color: Dark Gray
.head 5 -  DLL Settings
.head 4 +  Message Actions
.head 5 +  On SAM_User
.head 6 -  ! Прогресс
.head 6 +  If wParam=0
.head 7 +  If (nDone<=nTotal) AND (nTotal!=0)
.head 8 -  Call ccMeter2.SetProgress( nDone/nTotal*100 )
.head 7 +  Else
.head 8 -  Call ccMeter2.SetProgress( 100 )
.head 6 -  ! Сброс
.head 6 +  Else If wParam=1
.head 7 -  Call ccMeter2.SetProgress( 0 )
.head 6 -  ! 100%
.head 6 +  Else If wParam=2
.head 7 -  Call ccMeter2.SetProgress( 100 )
.head 3 +  Check Box: cb3
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Импорт текстового файла
.head 4 -  Window Location and Size
.head 5 -  Left:   4.3"
.head 5 -  Top:    3.25"
.head 5 -  Width:  4.0"
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
.head 3 +  Custom Control: ccMeter3
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
.head 6 -  Left:   4.3"
.head 6 -  Top:    3.65"
.head 6 -  Width:  4.0"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.25"
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
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Green
.head 5 -  Background Color: Dark Gray
.head 5 -  DLL Settings
.head 4 +  Message Actions
.head 5 +  On SAM_User
.head 6 -  ! Прогресс
.head 6 +  If wParam=0
.head 7 +  If (nDone<=nTotal) AND (nTotal!=0)
.head 8 -  Call ccMeter3.SetProgress( nDone/nTotal*100 )
.head 7 +  Else
.head 8 -  Call ccMeter3.SetProgress( 100 )
.head 6 -  ! Сброс
.head 6 +  Else If wParam=1
.head 7 -  Call ccMeter3.SetProgress( 0 )
.head 6 -  ! 100%
.head 6 +  Else If wParam=2
.head 7 -  Call ccMeter3.SetProgress( 100 )
.head 2 +  Functions
.head 3 +  Function: ImportInFiles
.head 4 -  Description: Импорт файлов локальных задач
Зарплата и депозиты
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Boolean: fElplat
.head 5 -  Boolean: fDp
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nFileId
.head 4 +  Actions
.head 5 -  ! Проверка ввода
.head 5 +  If fDp
.head 6 +  If cbImportSprav and not dfSpravFile
.head 7 -  Call SalMessageBox('Не задан файл импорта!', 'Ошибка', MB_Ok | MB_IconStop)
.head 7 -  Call SalSetFocus(dfSpravFile)
.head 7 -  Return FALSE
.head 6 +  If cbImportDp and not dfDpFile
.head 7 -  Call SalMessageBox('Не задан файл импорта!', 'Ошибка', MB_Ok | MB_IconStop)
.head 7 -  Call SalSetFocus(dfDpFile)
.head 7 -  Return FALSE
.head 5 +  If fElplat
.head 6 +  If cbImportSprav and not dfSpravFile
.head 7 -  Call SalMessageBox('Не задан файл импорта!', 'Ошибка', MB_Ok | MB_IconStop)
.head 7 -  Call SalSetFocus(dfSpravFile)
.head 7 -  Return FALSE
.head 6 +  If cbImportElplat and not dfElplatFile
.head 7 -  Call SalMessageBox('Не задан файл импорта!', 'Ошибка', MB_Ok | MB_IconStop)
.head 7 -  Call SalSetFocus(dfElplatFile)
.head 7 -  Return FALSE
.head 5 -  Call InitIntf()
.head 5 -  Set sLog = ''
.head 5 +  If ImportData((fDp OR fElplat) AND cbImportSprav, fElplat AND cbImportElplat, fDp AND cbImportDp, TRUE)
.head 6 +  If fElplat
.head 7 -  Call PayPlatFile()
.head 6 +  If fDp
.head 7 -  Call PayDepFile()
.head 5 +  If sLog
.head 6 -  Call SalModalDialog(dlgStatus, hWndForm, sLog, 'Статус импорта файлов ПЦ')
.head 5 -  Call FinalIntf()
.head 3 +  Function: ImportData
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Boolean: fSprav
.head 5 -  Boolean: fElplat
.head 5 -  Boolean: fDp
.head 5 -  Boolean: fRenameSources
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sFileName
.head 5 -  ! Соед. c БД
.head 5 -  : cOra
.head 6 -  Class: cABSConnect
.head 5 -  : cImporter
.head 6 -  Class: cFilesImporter
.head 5 -  String: sPath
.head 5 -  String: sCurFileName
.head 5 -  ! Поля SPRAV
.head 5 -  Number: nNum_Conv
.head 5 -  Number: nVid_z
.head 5 -  Number: nVid_s
.head 5 -  String: sFio
.head 5 -  String: sAcc_Sbon
.head 5 -  String: sAcc_Card
.head 5 -  String: sAcc_Bal
.head 5 -  ! Поля ELPLAT
.head 5 -  String: sNls
.head 5 -  Number: sSum
.head 5 -  ! Поля DP
.head 5 -  Number: nInt_d
.head 5 -  Number: nInt_ss
.head 5 -  Number: nInt_cr
.head 5 -  !
.head 5 -  Number: nId
.head 5 -  Number: nFetchRes
.head 4 +  Actions
.head 5 +  If not IsBankDayOpen()
.head 6 -  Call SalMessageBox('Банковский день закрыт!', 'Ошибка', MB_Ok | MB_IconStop)
.head 6 -  Return FALSE
.head 5 -  ! Чтение параметров
.head 5 -  Call SalUseRegistry(FALSE, '')
.head 5 -  Call SalGetProfileString('OBPC', 'OBPCInPath', '', sPath, GetIniFileName())
.head 5 -  Call XConnectGetParams(cOra)
.head 5 +  If cOra.Connect()
.head 6 -  ! Импорт SPRAV.TXT
.head 6 +  If fSprav
.head 7 -  Call SalShowWindow(cb1)
.head 7 -  Call SalUpdateWindow(hWndForm)
.head 7 -  Set sCurFileName = sPath || dfSpravFile || '.TXT'
.head 7 +  If cImporter.Open(sCurFileName, '|')
.head 8 -  ! Чистим справочник
.head 8 -  Call SqlPrepareAndExecute(cOra.hSql(), "DELETE FROM OBPC_SPRAV")
.head 8 +  Loop
.head 9 +  If cImporter.FetchNext()
.head 10 -  Set nNum_Conv = SalStrToNumber(cImporter.sValues[2])
.head 10 +  If nNum_Conv != 0
.head 11 +  When SqlError
.head 12 -  Call PutLog('Не уникальные записи для номера конверта: ' || cImporter.sValues[2])
.head 12 -  Return TRUE
.head 11 -  Set nVid_z    = SalStrToNumber( cImporter.sValues[3] )
.head 11 -  Set nVid_s    = SalStrToNumber( cImporter.sValues[4] )
.head 11 -  Set sFio      = StrDosToWinX( SalStrTrimX( cImporter.sValues[0] ) )
.head 11 -  Set sAcc_Sbon = SalStrTrimX( cImporter.sValues[5] )
.head 11 -  Set sAcc_Card = SalStrTrimX( cImporter.sValues[6] )
.head 11 -  Set sAcc_Bal  = SalStrTrimX( cImporter.sValues[7] )
.head 11 -  Call SqlPrepareAndExecute(cOra.hSql(), 
"INSERT INTO OBPC_SPRAV (NUM_CONV, VID_Z, VID_S, FIO, ACC_SBON, ACC_CARD, ACC_BAL) 
 VALUES (:nNum_Conv, :nVid_z, :nVid_s, :sFio, :sAcc_Sbon, :sAcc_Card, :sAcc_Bal)")
.head 9 +  Else
.head 10 -  Break
.head 8 -  Call cImporter.Close()
.head 8 -  ! Переименовываем
.head 8 +  If fRenameSources
.head 9 -  Call VisFileRename(sCurFileName, sPath || dfSpravFile || '.OLD')
.head 7 +  Else
.head 8 -  Call SalMessageBox('Не могу открыть файл: ' || sCurFileName, 'Ошибка', MB_Ok | MB_IconStop)
.head 8 -  Return FALSE
.head 7 -  Set cb1 = TRUE
.head 7 -  Call SalUpdateWindow(hWndForm)
.head 6 -  ! Импорт ELPLAT1.TXT
.head 6 +  If fElplat
.head 7 -  Call SalShowWindow(cb2)
.head 7 -  Call SalUpdateWindow(hWndForm)
.head 7 -  Set sCurFileName = sPath || dfElplatFile || '.TXT'
.head 7 +  If cImporter.Open(sCurFileName, ',')
.head 8 -  ! Чистим справочник
.head 8 -  Call SqlPrepareAndExecute(cOra.hSql(), "DELETE FROM OBPC_ELPLAT")
.head 8 +  Loop
.head 9 +  If cImporter.FetchNext()
.head 10 -  Set sNls = SalStrTrimX(cImporter.sValues[1])
.head 10 -  Set sSum = SalStrToNumber(cImporter.sValues[2])
.head 10 +  If SqlPrepareAndExecute(cOra.hSql(), "SELECT S_OBPC_ELPLAT.NEXTVAL INTO :nId FROM DUAL")
.head 11 +  If SqlFetchNext(cOra.hSql(), nFetchRes)
.head 12 -  Call SqlPrepareAndExecute(cOra.hSql(), 
"INSERT INTO OBPC_ELPLAT (ID, NLS,S ) 
 VALUES (:nId, :sNls, :sSum)")
.head 9 +  Else
.head 10 -  Break
.head 8 -  Call cImporter.Close()
.head 8 -  ! Переименовываем
.head 8 +  If fRenameSources
.head 9 -  Call VisFileRename(sCurFileName, sPath || dfElplatFile || '.OLD')
.head 7 +  Else
.head 8 -  Call SalMessageBox( 'Не могу открыть файл: ' || sCurFileName, 'Ошибка', MB_Ok | MB_IconStop )
.head 8 -  Return FALSE
.head 7 -  Set cb2 = TRUE
.head 7 -  Call SalUpdateWindow(hWndForm)
.head 6 -  ! Импорт DP*.TXT
.head 6 +  If fDp
.head 7 -  Call SalShowWindow(cb3)
.head 7 -  Call SalUpdateWindow(hWndForm)
.head 7 -  Set sCurFileName = sPath || 'DP' || dfDpFile || '.TXT'
.head 7 +  If cImporter.Open(sCurFileName, '|')
.head 8 -  ! Чистим справочник
.head 8 -  Call SqlPrepareAndExecute(cOra.hSql(), "DELETE FROM OBPC_DP")
.head 8 +  Loop
.head 9 +  If cImporter.FetchNext()
.head 10 -  Set nNum_Conv = SalStrToNumber(cImporter.sValues[1])
.head 10 -  Set nInt_d    = SalStrToNumber(cImporter.sValues[4])
.head 10 -  Set nInt_ss   = SalStrToNumber(cImporter.sValues[5])
.head 10 -  Set nInt_cr   = SalStrToNumber(cImporter.sValues[6])
.head 10 +  If SqlPrepareAndExecute(cOra.hSql(), "SELECT S_OBPC_DP.NEXTVAL INTO :nId FROM DUAL")
.head 11 +  If SqlFetchNext(cOra.hSql(), nFetchRes)
.head 12 -  Call SqlPrepareAndExecute(cOra.hSql(), 
"INSERT INTO OBPC_DP (ID, NUM_CONV, S_INT_D, S_INT_SS, S_INT_CR ) 
 VALUES (:nId, :nNum_Conv, :nInt_d, :nInt_ss, :nInt_cr)")
.head 9 +  Else
.head 10 -  Break
.head 8 -  Call cImporter.Close()
.head 8 -  ! Переименовываем
.head 8 +  If fRenameSources
.head 9 -  Call VisFileRename(sCurFileName, sPath || 'DP' || dfDpFile || '.OLD')
.head 7 +  Else
.head 8 -  Call SalMessageBox( 'Не могу открыть файл: ' || sCurFileName, 'Ошибка', MB_Ok | MB_IconStop )
.head 8 -  Return FALSE
.head 7 -  Set cb3 = TRUE
.head 7 -  Call SalUpdateWindow(hWndForm)
.head 6 -  Call SqlCommitEx(cOra.hSql(), 'OBPC. Импорт из файлов локальных задач в БД завершен!')
.head 6 -  Call cOra.Disconnect()
.head 6 -  Return TRUE
.head 5 -  Return FALSE
.head 3 +  Function: PayPlatFile
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nCount
.head 4 +  Actions
.head 5 -  Call SaveInfoToLog("OBPC. Начисление зарплаты.")
.head 5 -  ! Показываем пункт
.head 5 -  Call SalShowWindow(ccMeter2)
.head 5 -  Call SalSendMsg(ccMeter2, SAM_User, 1, 0)
.head 5 -  Set nDone = 0
.head 5 -  ! Квитовка операций
.head 5 +  If not SqlPLSQLCommand(hSql(), "obpc.pay_elplat(nTransAcc)")
.head 6 -  Call SqlRollbackEx(hSql(), "OBPC. Неуспешное выполнение процедуры начисления зарплаты")
.head 5 +  Else
.head 6 -  Call SqlCommitEx(hSql(), "OBPC. Выполнена процедура начисления зарплаты")
.head 5 -  ! Перечитываем индикатор
.head 5 -  Set nDone = nDone + 1
.head 5 -  Call SalSendMsg(ccMeter2, SAM_User, 2, 0)
.head 5 -  ! Количество не оплаченых документов
.head 5 +  If SqlPrepareAndExecute(hSql(), 
"select count(*) into :nCount
   from obpc_elplat d, obpc_sprav s
  where d.nls = s.acc_bal
    and s.vid_z = 1
    and d.sos = 0")
.head 6 +  If SqlFetchNext(hSql(), nFetchRes)
.head 7 +  If nCount > 0
.head 8 -  Call PutLog(SalNumberToStrX(nCount, 0) || ' неоплаченных документов по начислению зарплаты')
.head 5 -  Return TRUE
.head 3 +  Function: PayDepFile
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nCount
.head 4 +  Actions
.head 5 -  Call SaveInfoToLog("OBPC. Начисление депозитов.")
.head 5 -  ! Показываем пункт
.head 5 -  Call SalShowWindow(ccMeter3)
.head 5 -  Call SalSendMsg(ccMeter3, SAM_User, 1, 0)
.head 5 -  Set nDone = 0
.head 5 -  ! Квитовка операций
.head 5 +  If not SqlPLSQLCommand(hSql(), "obpc.pay_dp(nTransAcc)")
.head 6 -  Call SqlRollbackEx(hSql(), "OBPC. Неуспешное выполнение процедуры начисления депозитов")
.head 5 +  Else
.head 6 -  Call SqlCommitEx(hSql(), "OBPC. Выполнена процедура начисления депозитов")
.head 5 -  ! Перечитываем индикатор
.head 5 -  Set nDone = nDone + 1
.head 5 -  Call SalSendMsg(ccMeter3, SAM_User, 2, 0)
.head 5 -  ! Количество не оплаченых документов
.head 5 +  If SqlPrepareAndExecute(hSql(), 
"select count(*) into :nCount 
   from obpc_dp d, obpc_sprav s
  where d.num_conv = s.num_conv 
    and s.vid_z = 2 and s.vid_s = 2
    and d.sos = 0")
.head 6 +  If SqlFetchNext(hSql(), nFetchRes)
.head 7 +  If nCount > 0
.head 8 -  Call PutLog(SalNumberToStrX(nCount, 0) || ' неоплаченных документов по начислению депозитов')
.head 5 -  Return TRUE
.head 3 +  Function: PeformIntegrityCheck
.head 4 -  Description: Проверка целостности данных,
принимаемых из локальных задач
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  : cSel
.head 6 -  Class: cABSConnect
.head 5 -  !
.head 5 -  String: sDataList
.head 5 -  Number: nDataCount
.head 4 +  Actions
.head 5 -  Call InitIntf()
.head 5 +  If ImportData(TRUE, TRUE, TRUE, FALSE)
.head 6 -  Call XConnectGetParams(cSel)
.head 6 +  If cSel.Connect()
.head 7 -  !
.head 7 -  ! Проверка целостности
.head 7 -  Set nDone = 0
.head 7 -  Set nTotal = 4
.head 7 -  Call SalShowWindow(ccMeter1)
.head 7 -  Call SalSendMsg(ccMeter1, SAM_User, 1, 0)
.head 7 -  ! 1. Бал. счета из SPRAV.TXT не открытые в ОДБ
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  Call CheckIntegrity(cSel.hSql(),
"SELECT acc_bal INTO :sData 
 FROM OBPC_SPRAV 
 WHERE acc_bal NOT IN (SELECT nls FROM ACCOUNTS WHERE DAZS IS NULL)
 ORDER BY acc_bal", sDataList, nDataCount)
.head 7 +  If nDataCount > 500
.head 8 -  Call PutLog('Более 500 бал. счетов из SPRAV.TXT не открыты в ОДБ!')
.head 7 +  Else If sDataList
.head 8 -  Call PutLog('Бал. счета из SPRAV.TXT не открытые в ОДБ:' || PutCrLf() || sDataList)
.head 7 -  Set nDone = nDone + 1
.head 7 -  Call SalSendMsg(ccMeter1, SAM_User, 0, 0)
.head 7 -  ! 2. Бал. счета из ELPLAT.TXT не открытые в ОДБ
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  Call CheckIntegrity(cSel.hSql(),
"SELECT nls INTO :sData 
 FROM OBPC_ELPLAT 
 WHERE nls NOT IN (SELECT nls FROM ACCOUNTS WHERE DAZS IS NULL)
 ORDER BY nls", sDataList, nDataCount)
.head 7 +  If nDataCount > 500
.head 8 -  Call PutLog('Более 500 бал. счетов из ELPLAT.TXT не открыты в ОДБ!')
.head 7 +  Else If sDataList
.head 8 -  Call PutLog('Бал. счета из ELPLAT.TXT не открытые в ОДБ:' || PutCrLf() || sDataList)
.head 7 -  Set nDone = nDone + 1
.head 7 -  Call SalSendMsg(ccMeter1, SAM_User, 0, 0)
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  ! 3. Бал. счета из  ELPLAT.TXT отсутствующие в SPRAV.TXT
.head 7 -  Call CheckIntegrity(cSel.hSql(),
"SELECT nls INTO :sData 
 FROM OBPC_ELPLAT 
 WHERE nls NOT IN (SELECT acc_bal FROM OBPC_SPRAV WHERE vid_z=1)
ORDER BY nls", sDataList, nDataCount)
.head 7 +  If nDataCount > 500
.head 8 -  Call PutLog('Более 500 бал. счет из ELPLAT.TXT отсутствуют в SPRAV.TXT!')
.head 7 +  Else If sDataList
.head 8 -  Call PutLog('Бал. счета из  ELPLAT.TXT отсутствующие в SPRAV.TXT:' || PutCrLf() || sDataList)
.head 7 -  Set nDone = nDone + 1
.head 7 -  Call SalSendMsg(ccMeter1, SAM_User, 0, 0)
.head 7 -  ! 4. Номера конвертов из DP*.TXT отсутствующие в SPRAV.TXT
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  Call CheckIntegrity(cSel.hSql(),
"SELECT num_conv INTO :sData 
 FROM OBPC_DP 
 WHERE num_conv NOT IN (SELECT num_conv FROM OBPC_SPRAV WHERE vid_z=2)
ORDER BY num_conv ", sDataList, nDataCount)
.head 7 +  If nDataCount > 500
.head 8 -  Call PutLog('Более 500 номеров конвертов из DP*.TXT отсутствуют в SPRAV.TXT!')
.head 7 +  Else If sDataList
.head 8 -  Call PutLog('Номера конвертов из DP*.TXT отсутствующие в SPRAV.TXT:' || PutCrLf() || sDataList)
.head 7 -  Set nDone = nDone + 1
.head 7 -  Call SalSendMsg(ccMeter1, SAM_User, 0, 0)
.head 7 -  Call cSel.Disconnect()
.head 5 +  If sLog
.head 6 -  Call SalModalDialog(dlgStatus, hWndForm, sLog, 'Статус импорта файлов ПЦ')
.head 5 -  Call FinalIntf()
.head 3 -  !
.head 3 +  Function: PutLog
.head 4 -  Description: Вставка строки в ЛОГ
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: sString
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If SalStrLength(sString) > 0
.head 6 +  If SalStrLength(sLog) > 0
.head 7 -  Set sLog = sLog || PutCrLf() || sString
.head 6 +  Else
.head 7 -  Set sLog = sString
.head 3 +  Function: InitIntf
.head 4 -  Description: ! Инициализация интерфейса
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SalEnableWindow(cb1)
.head 5 -  Call SalEnableWindow(cb2)
.head 5 -  Call SalEnableWindow(cb3)
.head 5 -  Call SalHideWindow(cb1)
.head 5 -  Call SalHideWindow(cb2)
.head 5 -  Call SalHideWindow(cb3)
.head 5 -  Call SalHideWindow(ccMeter1)
.head 5 -  Call SalHideWindow(ccMeter2)
.head 5 -  Call SalHideWindow(ccMeter3)
.head 5 -  Set cb1 = FALSE
.head 5 -  Set cb2 = FALSE
.head 5 -  Set cb3 = FALSE
.head 3 +  Function: FinalIntf
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SalDisableWindow(cb1)
.head 5 -  Call SalDisableWindow(cb2)
.head 5 -  Call SalDisableWindow(cb3)
.head 3 -  !
.head 3 +  Function: CheckIntegrity
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Sql Handle: hSql
.head 5 -  String: sSqlText
.head 5 -  Receive String: sOverideList
.head 5 -  Receive Number: nOverideCount
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sData
.head 5 -  Number: nFetchRes
.head 4 +  Actions
.head 5 -  Set nOverideCount = 0
.head 5 -  Set sOverideList = ''
.head 5 +  If SqlPrepareAndExecute(hSql, sSqlText)
.head 6 +  Loop
.head 7 +  If SqlFetchNext(hSql, nFetchRes)
.head 8 +  If sOverideList
.head 9 -  Set sOverideList = sOverideList || ',' || PutCrLf() || sData
.head 8 +  Else
.head 9 -  Set sOverideList = sData
.head 8 -  Set nOverideCount = nOverideCount+1
.head 8 +  If nOverideCount > 500
.head 9 -  Break
.head 7 +  Else
.head 8 -  Break
.head 2 +  Window Parameters
.head 3 -  String: sTransNls
.head 2 +  Window Variables
.head 3 -  ! Для прогресс-индикатора
.head 3 -  Number: nTotal
.head 3 -  Number: nDone
.head 3 -  ! Log
.head 3 -  String: sLog
.head 3 -  Boolean: fLogCalled
.head 3 -  !
.head 3 -  Number: nTransAcc
.head 3 -  String: sTransNms
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Call SalSetWindowLabelText(bgTransNms, '')
.head 4 +  If sTransNls
.head 5 -  Set dfTransNls = sTransNls
.head 5 -  Call SalSendMsg(dfTransNls, SAM_Validate, 0, 0)
.head 4 -  Set dfSpravFile  = 'SPRAV'
.head 4 -  Set dfElplatFile = 'ELPLAT1'
.head 4 -  Set dfDpFile     = ''
.head 4 -  Set cbImportSprav  = TRUE
.head 4 -  Set cbImportElplat = TRUE
.head 4 -  Set cbImportDp     = TRUE
.head 4 -  Call SalHideWindow(cb1)
.head 4 -  Call SalHideWindow(ccMeter1)
.head 4 -  Call SalHideWindow(cb2)
.head 4 -  Call SalHideWindow(ccMeter2)
.head 4 -  Call SalHideWindow(cb3)
.head 4 -  Call SalHideWindow(ccMeter3)
.head 4 -  Set fLogCalled = FALSE
.head 4 -  !
.head 4 -  Call SalSetFocus(pbAll)
.head 1 -  !
.head 1 -  ! Ручная квитовка документов
.head 1 +  Table Window: frm_HandReceipe
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Ручна квитовка/видалення документів ПЦ з черги на відправку
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
.head 4 -  Width:  13.533"
.head 4 -  Width Editable? Class Default
.head 4 -  Height: 6.31"
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
.head 2 -  Description: Форма ручной квитовки/удаление документов
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
.head 5 -  Resource Id: 42630
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
.head 5 -  Keyboard Accelerator: Enter
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
.head 5 -  Resource Id: 42631
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
.head 5 -  Resource Id: 42632
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
.head 4 +  Pushbutton: pbReceipe
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbOk
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
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Зквитувати/видалити вибранні документи'
.head 6 +  On SAM_Click
.head 7 +  If SalMessageBox('Ви впевнені, що бажаїте зквитувати вибрані документи?', 
   'Квитовка', MB_YesNo | MB_IconQuestion) = IDYES
.head 8 -  Set nRow = TBL_MinRow
.head 8 +  Loop
.head 9 +  If SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
.head 10 -  Call SalTblSetContext(hWndForm, nRow)
.head 10 -  Call ReceipeDoc(colDocType, colRef, colDk)
.head 9 +  Else
.head 10 -  Break
.head 8 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 4 -  Line
.head 5 -  Resource Id: 21168
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  5.25"
.head 6 -  Begin Y:  0.024"
.head 6 -  End X:  5.25"
.head 6 -  End Y:  0.488"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 2 +  Contents
.head 3 +  Column: colStatus
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Стан
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
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
.head 3 +  Column: colFileName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ім'я
файлу
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.4"
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
.head 3 +  Column: colFileDate
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
файлу
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.8"
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
.head 3 +  Column: colRef
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Референс
документу
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
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
.head 3 +  Column: colTt
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
ОП
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
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
.head 3 +  Column: colVDate
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
валютування
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.2"
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
.head 3 +  Column: colDk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дб
Кр
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
.head 3 +  Column: colNls
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кортковий
рахунок
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
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
.head 3 +  Column: colS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сума
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.6"
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
.head 3 +  Column: colLcv
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вал
юта
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
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
.head 3 +  Column: colNms
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Назва
карткового рахунку
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
.head 3 +  Column: colNlsb
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Рахунок-Б
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
.head 4 -  Message Actions
.head 3 +  Column: colNmsb
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Назва
рахунку-Б
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
.head 3 +  Column: colNazn
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Призначення платежу
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
.head 3 +  Column: colUserId
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: User
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
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
.head 3 +  Column: colDDate
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
документу
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.2"
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
.head 3 +  Column: colSos
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сост
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.617"
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
.head 3 +  Column: colDocType
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: DocType
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.617"
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
.head 3 +  Function: ReceipeDoc
.head 4 -  Description: Сквитовать документ
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Number: nDocType
.head 5 -  Number: nRef
.head 5 -  Number: nDk
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If SqlPLSQLCommand(cAux.hSql(), 'obpc.del_pkkque(nDocType, nRef, nDk)')
.head 6 -  Call SqlCommitEx(cAux.hSql(), 'OBPC. Документ REF=' || SalNumberToStrX(nRef, 0) || ' вручную удален из очереди на отправку в ПЦ!' )
.head 5 +  Else
.head 6 -  Call SqlRollback(cAux.hSql())
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  : cAux
.head 4 -  Class: cABSConnect
.head 3 -  Number: nRow
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Set hWndForm.frm_HandReceipe.nFlags = GT_ReadOnly
.head 4 -  Set hWndForm.frm_HandReceipe.fFilterAtStart = TRUE
.head 4 -  Set hWndForm.frm_HandReceipe.strFilterTblName = "v_obpc_pkkque"
.head 4 -  ! Можем удалить/сквитовать любые наши документы (doc_type = 1)
.head 4 -  ! и удалить документы отделений-мфо ( doc_type = 2 and f_n is null )
.head 4 -  Set hWndForm.frm_HandReceipe.strSqlPopulate = 
"select doc_type, status, f_n, f_d, ref, tt, vdat, datd,
        s/100, lcv, dk, card_nls, card_nms, nlsb, namb, nazn, userid, sos
   into :hWndForm.frm_HandReceipe.colDocType, :hWndForm.frm_HandReceipe.colStatus,
        :hWndForm.frm_HandReceipe.colFileName, :hWndForm.frm_HandReceipe.colFileDate, 
        :hWndForm.frm_HandReceipe.colRef, :hWndForm.frm_HandReceipe.colTt, 
        :hWndForm.frm_HandReceipe.colVDate, :hWndForm.frm_HandReceipe.colDDate, 
        :hWndForm.frm_HandReceipe.colS, :hWndForm.frm_HandReceipe.colLcv, :hWndForm.frm_HandReceipe.colDk, 
        :hWndForm.frm_HandReceipe.colNls, :hWndForm.frm_HandReceipe.colNms,
        :hWndForm.frm_HandReceipe.colNlsb, :hWndForm.frm_HandReceipe.colNmsb, :hWndForm.frm_HandReceipe.colNazn,
        :hWndForm.frm_HandReceipe.colUserId, :hWndForm.frm_HandReceipe.colSos
   from v_obpc_pkkque
  where (doc_type = 1
     or ( doc_type = 2 and f_n is null ))
  order by status, ref"
.head 4 -  Call XConnectGetParams(cAux)
.head 4 +  If NOT cAux.Connect()
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  Call SalDestroyWindow(hWndForm)
.head 4 -  Call SalSendClassMessage(UM_Create, 0, 0)
.head 3 +  On UM_DoubleClick
.head 4 +  If colRef
.head 5 -  Call DocViewContentsEx(hWndForm, colRef)
.head 3 +  On SAM_FetchRowDone
.head 4 +  If colDocType = 2
.head 5 -  Call XSalTblSetRowBackColor(hWndForm, lParam, SalColorFromRGB(230,255,255)) ! голубой
.head 4 +  Else If colSos > 0 and colSos < 5
.head 5 -  Call VisTblSetRowColor(hWndForm, lParam, COLOR_DarkGreen)
.head 1 -  ! Доввод доп. реквизитов
.head 1 +  Table Window: frm_AuxReenter
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Доввод дополнительных реквизитов документов
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? No
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
.head 4 -  Width:  11.117"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 6.131"
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
.head 3 -  Maximum Rows in Memory: Default
.head 3 -  Discardable? No
.head 2 -  Description: Форма доввода доп. реквизитов
.head 2 -  Named Menus
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.427"
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
.head 5 -  Resource Id: 54911
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  4.557"
.head 6 -  Begin Y:  -0.01"
.head 6 -  End X:  4.557"
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
.head 6 -  Left:   2.043"
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
.head 6 -  Left:   2.471"
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
.head 6 -  Left:   2.9"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: Enter
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
.head 6 -  Left:   3.329"
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
.head 5 -  Resource Id: 54912
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  3.886"
.head 6 -  Begin Y:  -0.01"
.head 6 -  End X:  3.886"
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
.head 6 -  Left:   4.014"
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
.head 5 -  Resource Id: 54913
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  1.9"
.head 6 -  Begin Y:  -0.01"
.head 6 -  End X:  1.9"
.head 6 -  End Y:  0.448"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 +  Pushbutton: pbDoc
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbBrowse
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.7"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: MS Sans Serif
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Doc.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip='Просмотреть документ'
.head 6 +  On SAM_Click
.head 7 +  If colRef
.head 8 -  Call DocViewContentsEx(hWndForm,colRef)
.head 4 -  Line
.head 5 -  Resource Id: 54914
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  5.267"
.head 6 -  Begin Y:  0.0"
.head 6 -  End X:  5.267"
.head 6 -  End Y:  0.464"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 2 +  Contents
.head 3 +  Column: colRef
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Референс
документа
.head 4 -  Visible? Yes
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
.head 3 +  Column: colTt
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
ОП
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
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
.head 3 +  Column: colUserId
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: User
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
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
.head 4 -  Message Actions
.head 3 +  Column: colNlsA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Счет - А
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.717"
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
.head 3 +  Column: colS1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сума
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.25"
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
.head 3 +  Column: colLcvA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вал
юта
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.617"
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
.head 3 +  Column: colVDate
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
валютирования
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Left
.head 4 -  Width:  1.533"
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
.head 3 +  Column: colS2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сумма в
валюте - Б
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  Default
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
.head 3 +  Column: colLcvB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вал
Б
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.55"
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
.head 3 +  Column: colMfoB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: МФО - Б
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
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
.head 3 +  Column: colNlsB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Счет - Б
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
.head 3 +  Column: colDk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дб
Кр
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.517"
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
.head 3 +  Column: colSk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: СКП
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.467"
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
.head 3 +  Column: colDDate
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
документа
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Left
.head 4 -  Width:  1.117"
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
.head 3 +  Column: colDig1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
документа
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
.head 3 +  Column: colDig2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
документа
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
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  : cAux
.head 4 -  Class: cABSConnect
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Set nFlags = GT_ReadOnly
.head 4 -  Set strFilterTblName = 'OPER'
.head 4 -  Set fFilterAtStart = TRUE
.head 4 -  Set strSqlPopulate =
"SELECT 
  oper.ref, oper.tt, oper.userid, oper.nlsa, oper.s, v1.lcv, 
  oper.vdat, oper.s2, v2.lcv,oper.mfob, oper.nlsb, oper.dk,
  oper.sk, oper.datd, v1.dig, v2.dig 
INTO 
  :frm_AuxReenter.colRef,   :frm_AuxReenter.colTt, 
  :frm_AuxReenter.colUserId,:frm_AuxReenter.colNlsA, 
  :frm_AuxReenter.colS1,    :frm_AuxReenter.colLcvA, 
  :frm_AuxReenter.colVDate, :frm_AuxReenter.colS2, 
  :frm_AuxReenter.colLcvB,  :frm_AuxReenter.colMfoB, 
  :frm_AuxReenter.colNlsB,  :frm_AuxReenter.colDk, 
  :frm_AuxReenter.colSk,    :frm_AuxReenter.colDDate, 
  :frm_AuxReenter.colDig1,  :frm_AuxReenter.colDig2 
FROM oper, tabval v1, tabval v2 
WHERE 
  oper.kv=v1.kv AND oper.kv2=v2.kv "
.head 4 -  Call XConnectGetParams(cAux)
.head 4 +  If NOT cAux.Connect()
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  Call SalDestroyWindow(hWndForm)
.head 4 -  Call SalSendClassMessage(UM_Create, 0, 0)
.head 3 +  On UM_DoubleClick
.head 4 -  Call SalCreateWindow(frm_AuxEnter, hWndMDI, colRef, cAux.hSql())
.head 3 +  On SAM_FetchRowDone
.head 4 -  Set colS1 = colS1/SalNumberPower(10, colDig1)
.head 4 -  Set colS2 = colS2/SalNumberPower(10, colDig2)
.head 1 +  Table Window: frm_AuxEnter
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Ввод доп. реквизитов
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? No
.head 2 -  Display Settings
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? No
.head 3 -  Initial State: Normal
.head 3 -  Maximizable? No
.head 3 -  Minimizable? No
.head 3 -  System Menu? Yes
.head 3 -  Resizable? Yes
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  10.85"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.381"
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
.head 3 -  Maximum Rows in Memory: Default
.head 3 -  Discardable? Yes
.head 2 -  Description:
.head 2 -  Named Menus
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.56"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Contents
.head 4 +  Pushbutton: pbSave
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cpbOk
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title: Сохранить
.head 5 -  Window Location and Size
.head 6 -  Left:   0.083"
.head 6 -  Top:    0.071"
.head 6 -  Width:  1.2"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.45"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: Enter
.head 5 -  Font Name: MS Sans Serif
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Apply.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 -  ! Меняем флаги
.head 7 -  Set iContext = 0
.head 7 +  Loop
.head 8 +  If iContext < (iCount)
.head 9 +  If SalTblSetContext(hWndForm, iContext)
.head 10 -  ! Только редактированные
.head 10 +  If SalTblQueryRowFlags(hWndForm, iContext, ROW_Edited)
.head 11 -  Set nCount = 0
.head 11 -  Set fAuxExists = FALSE
.head 11 -  ! Call Debug( SalNumberToStrX( nRef, 0 ) || ' ' || colTAG )
.head 11 +  If SqlPrepareAndExecute(hSql, 
"SELECT COUNT(*) INTO :nCount 
 FROM operw WHERE ref=:nRef AND tag=:colTAG ")
.head 12 +  If SqlFetchNext(hSql, nFetchRes)
.head 13 -  Set fAuxExists = (nCount>0)
.head 11 -  ! Не существует и есть значение
.head 11 +  If NOT fAuxExists AND colVALUE
.head 12 -  ! Удаляем редактирование
.head 12 -  Call SalTblSetRowFlags(hWndForm, iContext, ROW_Edited, FALSE)
.head 12 -  ! Добавляем вставку
.head 12 -  Call SalTblSetRowFlags(hWndForm, iContext, ROW_New, TRUE)
.head 11 -  ! Не существует и нет значения
.head 11 +  Else If NOT fAuxExists AND NOT colVALUE
.head 12 -  ! Удаляем редактирование
.head 12 -  Call SalTblSetRowFlags(hWndForm, iContext, ROW_Edited, FALSE)
.head 8 +  Else
.head 9 -  Break
.head 8 -  Set iContext = iContext + 1
.head 7 -  ! Сохраняем доп. реквизиты
.head 7 -  Call SqlPrepare(hSql, 
"INSERT INTO OPERW (ref, tag, value) 
 VALUES(:nRef, :colTAG, :colVALUE)")
.head 7 -  Set fModResult = SalTblDoInserts(hWndForm, hSql, TRUE)
.head 7 -  Call SqlPrepare(hSql, 
"UPDATE OPERW SET value = :colVALUE
 WHERE ref=:nRef and tag=:colTAG ")
.head 7 -  Set fModResult = fModResult OR SalTblDoUpdates(hWndForm, hSql, TRUE)
.head 7 +  If fModResult
.head 8 -  Call SqlCommitEx(hSql, 'Доп.реквизиты для документа #' || SalNumberToStrX( nRef, 0 ) || ' вставлены/изменены!')
.head 7 -  Call SalDestroyWindow(hWndForm)
.head 4 +  Pushbutton: pbCancel
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cpbCancel
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title: Отменить
.head 5 -  Window Location and Size
.head 6 -  Left:   1.383"
.head 6 -  Top:    0.071"
.head 6 -  Width:  1.2"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.45"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: Esc
.head 5 -  Font Name: MS Sans Serif
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Discard.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 -  Call SalDestroyWindow(hWndForm)
.head 2 +  Contents
.head 3 +  Column: colTAG
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
.head 4 -  Width:  0.967"
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
.head 3 +  Column: colNAME
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование доп. реквизита
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  5.533"
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
.head 3 +  Column: colVALUE
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Значение
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: 200
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  4.4"
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
.head 6 -  ! Лезем в справочник
.head 6 +  If colSELECT
.head 7 -  Set nType = SalCompileAndEvaluate( colSELECT,
    nError, nPos, nTmp, sTmp, dTmp, hTmp, TRUE, SalContextCurrent())
.head 7 +  If nError = 0
.head 8 +  If nType = EVAL_Number
.head 9 -  Set sTmp = SalNumberToStrX(nTmp, 0)
.head 8 +  Else If nType = EVAL_String
.head 9 -  ! Set dfValue = sBrowserRet
.head 8 +  Else If nType = EVAL_Date
.head 9 -  Call SalDateToStr ( dTmp, sTmp )
.head 8 -  Set colVALUE=sTmp
.head 8 -  Call SalTblSetRowFlags( hWndForm, SalTblQueryContext( hWndForm ),ROW_Edited , TRUE )
.head 7 +  Else
.head 8 -  Call SalMessageBox( 'Невозможно вызвать '||colSELECT, 'Информация', MB_IconInformation )
.head 8 -  Return FALSE
.head 3 +  Column: colSELECT
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
.head 3 -  Number: aRef
.head 3 -  Sql Handle: aSql
.head 2 +  Window Variables
.head 3 -  Number: nRef
.head 3 -  Sql Handle: hSql
.head 3 -  Number: iContext
.head 3 -  Number: iCount
.head 3 -  Number: nCount
.head 3 -  Number: nFetchRes
.head 3 -  Boolean: fAuxExists
.head 3 -  String: sValue
.head 3 -  Number: nType
.head 3 -  Number: nError
.head 3 -  Number: nPos
.head 3 -  Number: nTmp
.head 3 -  String: sTmp
.head 3 -  Window Handle: hTmp
.head 3 -  Date/Time: dTmp
.head 3 -  Boolean: fModResult
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Set nRef = aRef
.head 4 -  Set hSql = aSql
.head 4 -  Set iCount = 0
.head 4 -  Call SalTblPopulate(hWndForm, hSql, 
"SELECT r.tag, f.name, NVL(ww.value,''),f.browser 
 INTO :hWndForm.colTAG,:hWndForm.colNAME, 
      :hWndForm.colVALUE,:hWndForm.colSELECT 
 FROM oper o, op_rules r, op_field f, 
      (SELECT ff.tag, NVL(w.value,'') value 
       FROM operw w, op_field ff 
       WHERE w.ref (+) = :nRef AND w.tag (+) = ff.tag ) ww 
 WHERE o.ref = :nRef AND o.tt = r.tt AND r.tag = f.tag AND r.tag=ww.tag ", TBL_FillAll)
.head 3 +  On SAM_FetchRowDone
.head 4 -  Set iCount = iCount + 1
.head 1 -  !
.head 1 +  Table Window: tblPortfolio
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Портфель БПК
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
.head 4 -  Width:  11.067"
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
.head 4 -  !
.head 4 +  Pushbutton: pbIns
.head 5 -  Class Child Ref Key: 33
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.033"
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
.head 7 -  Set strTip = 'Нова картка'
.head 4 +  Pushbutton: pbRefresh
.head 5 -  Class Child Ref Key: 35
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.083"
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
.head 6 -  Left:   0.517"
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
.head 6 +  On SAM_Click
.head 7 +  If SetQueryFilterEx(cF_BPK)
.head 8 -  Call SalPostMsg(hWndForm, UM_Populate, 0, 0)
.head 4 +  Pushbutton: pbSearch
.head 5 -  Class Child Ref Key: 38
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.967"
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
.head 6 -  Left:   1.4"
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
.head 5 -  Resource Id: 4225
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  6.75"
.head 6 -  Begin Y:  -0.048"
.head 6 -  End X:  6.75"
.head 6 -  End Y:  0.417"
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 -  Line
.head 5 -  Resource Id: 54132
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  2.567"
.head 6 -  Begin Y:  0.012"
.head 6 -  End X:  2.567"
.head 6 -  End Y:  0.476"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 +  Pushbutton: pbLink
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbOk
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.683"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\CHEKIN.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Відкрити Кредитну лінію для вибраної угоди'
.head 6 +  On SAM_Click
.head 7 +  If colNd
.head 8 -  Call OpenKL()
.head 4 +  Pushbutton: pbDel
.head 5 -  Class Child Ref Key: 34
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.133"
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
.head 7 -  Set strTip = 'Закрити угоду'
.head 4 -  Line
.head 5 -  Resource Id: 5447
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  3.65"
.head 6 -  Begin Y:  0.0"
.head 6 -  End X:  3.65"
.head 6 -  End Y:  0.464"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 +  Pushbutton: pbCustomer
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbBrowse
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.767"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\CUSTPERS.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Картка клієнта'
.head 6 +  On SAM_Click
.head 7 +  If colNd
.head 8 +  Select Case colCust_type
.head 9 +  Case 2
.head 10 -  Call EditCustCorpsEx(colCust_rnk, nCustFlags, hWndForm, 0, '', FALSE)
.head 10 -  Break
.head 9 +  Case 3
.head 10 -  Call EditCustPersonEx(colCust_rnk, nCustFlags, hWndForm, 0, '', FALSE)
.head 10 -  Break
.head 9 +  Default
.head 10 -  Break
.head 4 +  Pushbutton: pbDetails
.head 5 -  Class Child Ref Key: 39
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.217"
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
.head 7 -  Set strTip = 'Картковий рахунок'
.head 4 +  Pushbutton: pbAccounts
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbBrowse
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.683"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\BOOK.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Рахунки угоди'
.head 6 +  On SAM_Click
.head 7 +  If colNd
.head 8 -  Call ShowAccList(colCust_rnk, AVIEW_CUST, nAccsFlags, 
"a.acc in (select acc from v_bpk_nd_acc where nd = " || Str(colNd) || " and acc is not null)")
.head 4 +  Pushbutton: pbAccHistory
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbBrowse
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   5.117"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\BOOKS.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Історя рахунку'
.head 6 +  On SAM_Click
.head 7 +  If colNd
.head 8 -  Call Show_Sal_Day_P(colAcc_acc, STRING_Null, NUMBER_Null, DATETIME_Null, DATETIME_Null)
.head 4 +  Pushbutton: pbDocs
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbOk
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   5.567"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\DOCS.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Документи по рахунку'
.head 6 +  On SAM_Click
.head 7 +  If colNd
.head 8 -  Call ShowAllDocs(hWndMDI,1,0,
   "(a.nlsa='" || colAcc_nls || "' and a.kv=" || Str(colAcc_kv) || 
" or a.nlsb='" || colAcc_nls || "' and nvl(a.kv2,a.kv)=" || Str(colAcc_kv) || ")",
"Документи по рахунку " || colAcc_nls || "/" || colAcc_lcv)
.head 4 -  Line
.head 5 -  Resource Id: 4226
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  6.083"
.head 6 -  Begin Y:  -0.048"
.head 6 -  End X:  6.083"
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
.head 6 -  Left:   6.217"
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
.head 5 -  Resource Id: 4227
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  1.917"
.head 6 -  Begin Y:  0.0"
.head 6 -  End X:  1.917"
.head 6 -  End Y:  0.464"
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 2 +  Contents
.head 3 +  Column: colNd		! N Номер договора
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Номер
угоди
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Class Default
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
.head 3 +  Column: colBranch	! S Код отделения
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
відділення
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
.head 3 +  Column: colAcc_acc	! N
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Acc
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
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
.head 3 +  Column: colAcc_nls	! S Номер счета
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Картковий
рахунок
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  1.8"
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
.head 5 +  On SAM_SetFocus
.head 6 -  Set sTmp = colAcc_nls
.head 5 +  On SAM_AnyEdit
.head 6 -  Set colAcc_nls = sTmp
.head 6 -  Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
.head 3 +  Column: colAcc_kv	! N Код вал.
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
вал.
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 3
.head 4 -  Data Type: Number
.head 4 -  Justify: Center
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
.head 3 +  Column: colAcc_lcv	! S Код вал.
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
вал.
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 3
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Center
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
.head 3 +  Column: colCard_acct	! S Технический счет
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Технічний
рахунок
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  1.4"
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
.head 5 +  On SAM_SetFocus
.head 6 -  Set sTmp = colCard_acct
.head 5 +  On SAM_AnyEdit
.head 6 -  Set colCard_acct = sTmp
.head 6 -  Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
.head 3 +  Column: colAcc_ob22	! S
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ОБ22
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Center
.head 4 -  Width:  0.6"
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
.head 3 +  Column: colAcc_tip	! S
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Tip
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
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
.head 3 +  Column: colAcc_tipname	! S Тип счета
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Тип
рахунку
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Left
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
.head 3 +  Column: colAcc_ost	! N Остаток
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Залишок
на рахунку
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.2"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Decimal
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
.head 3 +  Column: colAcc_fost	! N Остаток
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Розрахун-
ковий
залишок
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.2"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Decimal
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
.head 3 +  Column: colAcc_daos	! D Дата открытия счета
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
відкриття
рахунку
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.2"
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
.head 3 +  Column: colCust_rnk	! N Рег.номер клиента
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Реєстр.
номер
клієнта
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.2"
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
.head 3 +  Column: colCust_name	! S ФИО (наименование) клиента
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ПІБ (назва)
клієнта
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  4.0"
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
.head 3 +  Column: colCust_okpo	! S ОКПО клиента
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ЗКПО
клієнта
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  1.4"
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
.head 3 +  Column: colCust_type	! N
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Custtype
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
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
.head 3 +  Column: colCard_servname	! S Категория клиента
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Категорія
клієнта
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
.head 3 +  Column: colAcc_dazs	! D Дата закрытия счета
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
закриття
рахунку
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.2"
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
.head 2 +  Functions
.head 3 +  Function: OpenKL
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nAccOvr
.head 5 -  String: sNlsOvr
.head 4 +  Actions
.head 5 -  Set sNlsOvr = STRING_Null
.head 5 -  ! -- Проверка: для картсчета уже открыта кредитная линия? 
.head 5 -  Call SqlPrepareAndExecute(hSql(),
"select b.nls into :sNlsOvr
   from bpk_acc o, accounts b
  where o.nd = :colNd
    and o.acc_ovr = b.acc")
.head 5 +  If SqlFetchNext(hSql(), nFetchRes)
.head 6 +  If sNlsOvr
.head 7 -  Call SalMessageBox("Для карткового рахунку " || colAcc_nls || " вже відкрито кредитну лінію - рахунок " || sNlsOvr, 
     "Інфорація", MB_IconAsterisk | MB_Ok)
.head 7 -  Return TRUE
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 +  If not SqlPLSQLCommand(hSql(), "obpc.open_acc(colNd, '2202', nAccOvr)")
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Call SqlRollbackEx(hSql(), "Помилка при відкритті кредитної лінії")
.head 6 -  Call SalMessageBox("Помилка при відкритті кредитної лінії",
     "Помилка", MB_IconAsterisk | MB_Ok)
.head 6 -  Return FALSE
.head 5 -  Call SqlPrepareAndExecute(hSql(), "select nls into :sNlsOvr from accounts where acc = :nAccOvr")
.head 5 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  Call SqlCommitEx(hSql(), "Відкрито кредитну лінію " || sNlsOvr || " для карткового рахунку " || colAcc_nls)
.head 5 -  Call SalMessageBox("Відкрито кредитну лінію " || sNlsOvr || " для карткового рахунку " || colAcc_nls,
     "Інфорація", MB_IconAsterisk | MB_Ok)
.head 5 -  Return TRUE
.head 3 +  Function: CloseCard
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nNd
.head 5 -  String: sNls
.head 5 -  String: sLcv
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sMsg
.head 4 +  Actions
.head 5 +  If SalMessageBox("Закрити угоду " || Str(nNd) || PutCrLf() ||
   "(картковий рахунок " || sNls|| "/" || sLcv || PutCrLf() || 
   "та всі пов'язані з ним рахунки)?", "Увага!", MB_IconQuestion | MB_YesNo) = IDNO
.head 6 -  Return TRUE
.head 5 +  If not SqlPLSQLCommand(hSql(), "bars_bpk.can_close_deal(nNd, sMsg)")
.head 6 -  Return FALSE
.head 5 +  If sMsg
.head 6 +  If SalMessageBox(sMsg, "Увага!", MB_IconQuestion | MB_YesNo) = IDNO
.head 7 -  Return TRUE
.head 5 +  If not SqlPLSQLCommand(hSql(), "bars_bpk.close_deal(nNd, sMsg)")
.head 6 -  Call SqlRollbackEx(hSql(), "OBPC. cannot execute bars_bpk.close_deal")
.head 6 -  Return FALSE
.head 5 -  Call SqlCommitEx(hSql(), "OBPC. Угода " || Str(nNd) || ": " || sMsg)
.head 5 -  Call SalMessageBox("Угода " || Str(nNd) || ":" || PutCrLf() || sMsg, "Повідомлення", MB_IconAsterisk | MB_Ok)
.head 5 -  Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
.head 5 -  Return TRUE
.head 2 +  Window Parameters
.head 3 -  Number: nPar
.head 3 -  String: sFilter
.head 2 +  Window Variables
.head 3 -  : cF_BPK
.head 4 -  Class: cGenFilterEx
.head 3 -  String: strDynSql
.head 3 -  Number: nCount
.head 3 -  Number: nRow
.head 3 -  String: sTmp
.head 3 -  Number: nCustFlags
.head 3 -  Number: nAccsFlags
.head 3 -  Number: nAccAccess
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  ! Портфель БПК
.head 4 +  If nPar = 1
.head 5 -  Call SalSetWindowText(hWndForm, "Портфель БПК")
.head 5 -  Set nCustFlags = CVIEW_Saldo
.head 5 -  Set nAccsFlags = AVIEW_Financial | AVIEW_Special | AVIEW_NoOpen
.head 5 -  Set nAccAccess = ACCESS_FULL
.head 4 -  ! Портфель БПК - перегляд
.head 4 +  Else
.head 5 -  Call SalSetWindowText(hWndForm, "Портфель БПК - перегляд")
.head 5 -  Set nCustFlags = CVIEW_Saldo | CVIEW_ReadOnly
.head 5 -  Set nAccsFlags = AVIEW_Financial | AVIEW_Special | AVIEW_NoOpen | AVIEW_ReadOnly
.head 5 -  Set nAccAccess = ACCESS_READONLY
.head 5 -  Call SalDisableWindow(pbIns)
.head 5 -  Call SalDisableWindow(pbLink)
.head 5 -  Call SalDisableWindow(pbDel)
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Set hWndForm.tblPortfolio.strFilterTblName = 'obpc_deal'
.head 4 -  Set hWndForm.tblPortfolio.strPrintFileName = 'pk_deal'
.head 4 -  Set hWndForm.tblPortfolio.fFilterAtStart = TRUE
.head 4 -  Set hWndForm.tblPortfolio.nTabInstance   = 1
.head 4 -  Set hWndForm.tblPortfolio.strSqlPopulate = 
"select obpc_deal.nd, obpc_deal.branch, obpc_deal.acc_acc, obpc_deal.acc_nls, obpc_deal.acc_kv, obpc_deal.acc_lcv, obpc_deal.card_acct, 
        obpc_deal.acc_ob22, obpc_deal.acc_tip, obpc_deal.acc_tipname, obpc_deal.acc_ost, obpc_deal.acc_fost, obpc_deal.acc_daos, obpc_deal.acc_dazs,
        obpc_deal.cust_rnk, obpc_deal.cust_name, obpc_deal.cust_okpo, obpc_deal.cust_type, obpc_deal.card_servname
   into :hWndForm.tblPortfolio.colNd, :hWndForm.tblPortfolio.colBranch, 
        :hWndForm.tblPortfolio.colAcc_acc, :hWndForm.tblPortfolio.colAcc_nls, 
        :hWndForm.tblPortfolio.colAcc_kv, :hWndForm.tblPortfolio.colAcc_lcv, :hWndForm.tblPortfolio.colCard_acct, 
        :hWndForm.tblPortfolio.colAcc_ob22, :hWndForm.tblPortfolio.colAcc_tip, :hWndForm.tblPortfolio.colAcc_tipname, 
        :hWndForm.tblPortfolio.colAcc_ost, :hWndForm.tblPortfolio.colAcc_fost,
        :hWndForm.tblPortfolio.colAcc_daos, :hWndForm.tblPortfolio.colAcc_dazs,
        :hWndForm.tblPortfolio.colCust_rnk,  :hWndForm.tblPortfolio.colCust_name,
        :hWndForm.tblPortfolio.colCust_okpo, :hWndForm.tblPortfolio.colCust_type, 
        :hWndForm.tblPortfolio.colCard_servname
   from obpc_deal " || IifS(sFilter='', "", " where (" || sFilter || ")") || "
  order by obpc_deal.nd desc"
.head 4 -  Call cF_BPK.Init('obpc_deal', '')
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalWaitCursor(FALSE)
.head 4 -  Call hWndForm.tblPortfolio.cF_BPK.cSimpleFilter.NewString('ACC_DAOS',SalFmtFormatDateTime(GetBankDate(), 'dd.MM.yyyy'))
.head 4 +  If SetQueryFilterEx(cF_BPK)
.head 5 +  If cF_BPK.GetFilterWhereClause(TRUE) != ''
.head 6 -  Call SalPostMsg(hWndForm, UM_Populate, 0, 0)
.head 4 +  Else
.head 5 -  Call SalPostMsg(pbExit, SAM_Click, 0, 0)
.head 3 +  On UM_Populate
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set nCount = 0
.head 4 -  !
.head 4 -  Call cQ.Init(hWndForm.tblPortfolio.strSqlPopulate)
.head 4 -  Set strDynSql = cQ.GetFullSQLStringEx(cF_BPK)
.head 4 -  Call SalTblPopulate(hWndForm, hSql(), T(strDynSql), TBL_FillAll)
.head 4 -  !
.head 4 -  Call SalTblDefineSplitWindow(hWndForm, 1, TRUE)
.head 4 -  Set nRow = SalTblInsertRow(hWndForm, TBL_MinRow)
.head 4 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 4 -  Call SalTblSetContext(hWndForm, nRow)
.head 4 -  Set colBranch  = 'Рахунків всього:'
.head 4 -  Set colAcc_nls = Str(nCount)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_FetchRowDone
.head 4 +  If colAcc_dazs
.head 5 -  Call VisTblSetRowColor(hWndForm, lParam, COLOR_DarkRed)
.head 4 +  If colAcc_ost < 0
.head 5 -  Call SalTblSetCellTextColor(colAcc_ost, COLOR_Red, FALSE)
.head 4 -  Set nCount = nCount + 1
.head 3 +  On UM_Insert
.head 4 -  Call SalCreateWindow(frmCard, hWndMDI, hWndForm)
.head 3 +  On UM_Delete
.head 4 +  If colNd
.head 5 -  Call CloseCard(colNd, colAcc_nls, colAcc_lcv)
.head 3 +  On SAM_DoubleClick
.head 4 +  If colNd
.head 5 -  Call OperWithAccountEx(AVIEW_ALL, colAcc_acc, colCust_rnk, 
     IifN(colAcc_dazs!=DATETIME_Null, ACCESS_READONLY, nAccAccess), hWndForm, '')
.head 1 +  Form Window: frm_ImportZP
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Прийом зарплатних файлів
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? No
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
.head 4 -  Width:  16.3"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 8.4"
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
.head 4 -  Size: 0.4"
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
.head 6 -  Left:   0.033"
.head 6 -  Top:    0.048"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: F3
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
.head 7 -  Set strTip = 'Перечитати стан директорії'
.head 6 +  On SAM_Click
.head 7 -  Call clearFields(FALSE)
.head 7 -  Call SalSendMsg(cFiles, SAM_Create, 0, 0)
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbPrint
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
.head 7 -  Set strTip = 'Друк таблиці'
.head 6 +  On SAM_Click
.head 7 -  Call tblCard.printFile(GetPrnDir() || '\\' || sCurrFile)
.head 4 -  Line
.head 5 -  Resource Id: 57138
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  1.0"
.head 6 -  Begin Y:  0.0"
.head 6 -  End X:  1.0"
.head 6 -  End Y:  0.476"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: Default
.head 4 +  Pushbutton: pbImport
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbExecute
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.117"
.head 6 -  Top:    0.048"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: F10
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
.head 7 -  Set strTip = 'Оплатити файл'
.head 6 +  On SAM_Click
.head 7 +  If sCurrFile
.head 8 +  If checkFile()
.head 9 -  Call tblCard.payFile()
.head 4 -  Line
.head 5 -  Resource Id: 57139
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  1.633"
.head 6 -  Begin Y:  -0.048"
.head 6 -  End X:  1.633"
.head 6 -  End Y:  0.429"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: Default
.head 4 +  Pushbutton: pbCancel
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbCancel
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.783"
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
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Вийти'
.head 6 +  On SAM_Click
.head 7 -  Call SalDestroyWindow(hWndForm)
.head 2 +  Contents
.head 3 +  List Box: cFiles
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cOutlineListBox
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   Default
.head 5 -  Top:    0.0"
.head 5 -  Width:  3.0"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 7.55"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Multiple selection? Class Default
.head 4 -  Sorted? Class Default
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Horizontal Scroll? Class Default
.head 4 -  List Initialization
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 +  If h1stChild
.head 7 -  Call cFiles.DeleteChild(0)
.head 6 -  Call cFiles.SetStyle(LBS_ShowHorzScrollBar | LBS_ShowSelectTextPicture | LBS_Explorer | LBS_VisExtensions | LBS_FmtUppercase)
.head 6 +  If NOT hRoot
.head 7 -  Set hRoot = cFiles.GetRoot()
.head 6 +  If hRoot
.head 7 -  Set h1stChild = cFiles.LoadChild(hRoot, hPicRoot1, hPicRoot1, sFilePath, 0, 0)
.head 7 +  If h1stChild
.head 8 -  Set nFiles = VisDosEnumFiles(sFilePath || '\\*.TXT', FA_Standard, smFile)
.head 8 -  Set nIterator = 0
.head 8 +  While nIterator < nFiles
.head 9 -  Call cFiles.LoadChild(h1stChild, hPicNull, hPicNull, smFile[nIterator], nIterator+1, 0)
.head 9 -  Set nIterator = nIterator + 1
.head 8 -  !
.head 8 -  Set nFiles = VisDosEnumFiles(sFilePath || '\\*.DBF', FA_Standard, smFile)
.head 8 -  Set nIterator = 0
.head 8 +  While nIterator < nFiles
.head 9 -  Call cFiles.LoadChild(h1stChild, hPicNull, hPicNull, smFile[nIterator], nIterator+1, 0)
.head 9 -  Set nIterator = nIterator + 1
.head 8 -  !
.head 8 -  Set nFiles = VisDosEnumFiles(sFilePath || '\\*.XML', FA_Standard, smFile)
.head 8 -  Set nIterator = 0
.head 8 +  While nIterator < nFiles
.head 9 -  Call cFiles.LoadChild(h1stChild, hPicNull, hPicNull, smFile[nIterator], nIterator+1, 0)
.head 9 -  Set nIterator = nIterator + 1
.head 7 -  Call cFiles.ShowOutline(1)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On VTM_OutlineCornerClick
.head 6 -  Set nCurrentFlag = GetItemFlags(GetItemHandle(wParam))
.head 6 +  If (nCurrentFlag & ITEM_IsParent)
.head 7 +  If (nCurrentFlag &  ITEM_IsExpanded)
.head 8 -  Call Collapse(wParam)
.head 7 +  Else
.head 8 -  Call Expand(wParam)
.head 5 +  On VTM_KeyDown
.head 6 -  Set nCurrentFlag = GetItemFlags( GetItemHandle( VisListGetFocusIndex( hWndItem )))
.head 6 +  Select Case wParam
.head 7 +  Case VK_Left
.head 8 +  If nCurrentFlag & ITEM_CanCollapse
.head 9 -  Call Collapse( VisListGetFocusIndex( hWndItem ) )
.head 8 -  Break
.head 7 +  Case VK_Right
.head 8 +  If nCurrentFlag & ITEM_CanExpand
.head 9 -  Call Expand( VisListGetFocusIndex( hWndItem ) )
.head 8 -  Break
.head 7 +  Default
.head 8 -  Call SalSendClassMessage( VTM_KeyDown, wParam, lParam )
.head 8 -  Break
.head 5 +  On SAM_Click
.head 6 -  Call SalSendClassMessage(SAM_Click, wParam, lParam)
.head 6 -  Call clearFields(TRUE)
.head 6 +  If SalListQuerySelection(cFiles) > 0
.head 7 -  Set sCurrFile = VisListGetText(cFiles, SalListQuerySelection(cFiles))
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  Call readFile(sCurrFile)
.head 7 -  Call SalWaitCursor(FALSE)
.head 6 +  Else
.head 7 -  Set sCurrFile = ''
.head 6 +  If sCurrFile
.head 7 -  Call SalSetWindowText(hWndForm, "Обробка файлу " || sCurrFile)
.head 6 +  Else
.head 7 -  Call SalSetWindowText(hWndForm, "Прийом зарплатних файлів")
.head 3 -  !
.head 3 -  Background Text: Операція
.head 4 -  Resource Id: 26079
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.2"
.head 5 -  Top:    0.1"
.head 5 -  Width:  2.4"
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
.head 3 +  Data Field: dfTranType
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 2
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   5.7"
.head 6 -  Top:    0.05"
.head 6 -  Width:  0.6"
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
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfTt
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 3
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   6.35"
.head 6 -  Top:    0.05"
.head 6 -  Width:  0.8"
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
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Combo Box: cmbTt
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenComboBox_StrId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   7.2"
.head 5 -  Top:    0.05"
.head 5 -  Width:  4.55"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 1.345"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  String Type: Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Sorted? Class Default
.head 4 -  Always Show List? Class Default
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  List Initialization
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 +  If cmbTt.Init(hWndItem)
.head 7 +  If sParTt
.head 8 -  Call cmbTt.Populate(hSql(), "tt", "name", "v_bpk_tt_for_listpay", "where tt='" || sParTt || "' order by tt")
.head 8 +  If cmbTt.nItemNum = 0
.head 9 -  Call SalDestroyWindow(hWndForm)
.head 8 +  Else
.head 9 -  Call cmbTt.SetSelectById(sParTt)
.head 9 -  Call SalDisableWindow(hWndItem)
.head 9 -  Call SalSendMsg(hWndItem, SAM_Click, 0, 0)
.head 7 +  Else
.head 8 -  Call cmbTt.Populate(hSql(), "tt", "name", "v_bpk_tt_for_listpay", "order by tt")
.head 5 +  On SAM_Click
.head 6 -  Call SalSendClassMessage(SAM_Click, 0, 0)
.head 6 -  Set dfTt = cmbTt.strCurrentId
.head 6 -  Call SqlPrepareAndExecute(hSql(), "select tran_type into :dfTranType from obpc_trans_out where tt = :dfTt")
.head 6 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Call SqlPrepareAndExecute(hSql(), "select nvl(nazn,name) into :dfNazn from tts where tt = :dfTt")
.head 6 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Call SqlPrepareAndExecute(hSql(), "select val into :dfZB from op_rules where tt = :dfTt and tag = 'SK_ZB'")
.head 6 +  If SqlFetchNext(hSql(), nFetchRes)
.head 7 -  Call cmbZB.SetSelectById(dfZB)
.head 6 +  Else
.head 7 -  Set dfZB = ''
.head 7 -  Call SalListSetSelect(cmbZB, -1)
.head 3 +  Data Field: dfTransitNls
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 14
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   5.7"
.head 6 -  Top:    0.35"
.head 6 -  Width:  3.9"
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
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Validate
.head 6 +  If not SalIsNull(dfTransitNls)
.head 7 +  If not getTransit("a.nls = :dfTransitNls and a.kv = :nKv")
.head 8 -  Return VALIDATE_Cancel
.head 6 -  Return VALIDATE_Ok
.head 3 +  Data Field: dfLcv
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 3
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   9.65"
.head 6 -  Top:    0.35"
.head 6 -  Width:  0.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Uppercase
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Validate
.head 6 +  If SalIsNull(hWndItem)
.head 7 -  Set dfLcv = Str(nBaseVal)
.head 6 +  If SalIsValidInteger(hWndItem)
.head 7 -  Set sTmp = 'kv'
.head 6 +  Else
.head 7 -  Set sTmp = 'lcv'
.head 6 -  Call SqlPrepareAndExecute(hSql(), "select lcv, dig into :dfLcv, :nDig from tabval where " || sTmp || " = :dfLcv")
.head 6 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 7 -  Call SalMessageBox("Невідома валюта "|| " " || dfLcv,
     "Увага!", MB_IconExclamation)
.head 7 -  Set dfLcv = 'UAH'
.head 7 -  Return VALIDATE_Cancel
.head 6 -  Return VALIDATE_Ok
.head 3 +  Data Field: dfTransitNms
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 38
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   5.7"
.head 6 -  Top:    0.65"
.head 6 -  Width:  6.0"
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
.head 3 +  Pushbutton: pbSelectTransit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вибрати...
.head 4 -  Window Location and Size
.head 5 -  Left:   10.5"
.head 5 -  Top:    0.35"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
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
.head 6 +  If sCurrFile
.head 7 +  If FunNSIGetFiltered("v_bpk_transit", "acc", "v_bpk_transit.lcv='" || dfLcv || "'", sPK, sSem)
.head 8 -  Call getTransit("a.acc=:sPK")
.head 3 -  Background Text: Залишок фактичний
.head 4 -  Resource Id: 72
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   11.9"
.head 5 -  Top:    0.4"
.head 5 -  Width:  2.2"
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
.head 3 +  Data Field: dfOstc
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
.head 6 -  Left:   14.2"
.head 6 -  Top:    0.35"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Decimal
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Залишок плановий
.head 4 -  Resource Id: 73
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   11.9"
.head 5 -  Top:    0.7"
.head 5 -  Width:  2.2"
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
.head 3 +  Data Field: dfOstb
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
.head 6 -  Left:   14.2"
.head 6 -  Top:    0.65"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Decimal
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfNazn
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 160
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   5.7"
.head 6 -  Top:    0.95"
.head 6 -  Width:  10.3"
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
.head 3 +  Data Field: dfZB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 2
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   5.7"
.head 6 -  Top:    1.25"
.head 6 -  Width:  0.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Validate
.head 6 +  If SalIsNull(dfZB)
.head 7 -  Call SalListSetSelect(cmbZB, -1)
.head 7 -  Return VALIDATE_OkClearFlag
.head 6 -  Call cmbZB.SetSelectById(dfZB)
.head 6 +  If cmbZB.strCurrentId
.head 7 -  Return VALIDATE_Ok
.head 6 +  Else
.head 7 -  Call SalMessageBox('Невідомий позабалансовий символ!', 'Увага', MB_Ok | MB_IconExclamation)
.head 7 -  Return VALIDATE_Cancel
.head 3 +  Combo Box: cmbZB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenComboBox_StrId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   6.35"
.head 5 -  Top:    1.25"
.head 5 -  Width:  9.65"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 3.357"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  String Type: Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Sorted? Class Default
.head 4 -  Always Show List? Class Default
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  List Initialization
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 +  If cmbZB.Init(hWndItem)
.head 7 -  Call cmbZB.Populate(hSql(), 'd010', "d010 || ' ' || txt", 'kl_d010', "where d010>='84' order by d010")
.head 7 -  Call SalListSetSelect(cmbZB, -1)
.head 5 +  On SAM_Click
.head 6 -  Call SalSendClassMessage(SAM_Click, 0, 0)
.head 6 -  Set dfZB = cmbZB.strCurrentId
.head 3 +  Child Table: tblCard
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.2"
.head 6 -  Top:    1.6"
.head 6 -  Width:  12.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 5.1"
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
.head 5 -  Maximum Rows in Memory: 20000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colCardAcc	! Счет из файла (техн./аналитич.)
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Технічний/
аналітичний
рахунок
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
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
.head 7 +  On SAM_SetFocus
.head 8 -  Set sTmp = colCardAcc
.head 7 +  On SAM_AnyEdit
.head 8 -  Set colCardAcc = sTmp
.head 8 -  Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
.head 5 +  Column: colS
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Сума
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 16
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.4"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Decimal
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
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Картковий
рахунок
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: 14
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.8"
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
.head 7 +  On SAM_SetFocus
.head 8 -  Set sTmp = colNls
.head 7 +  On SAM_AnyEdit
.head 8 -  Set colNls = sTmp
.head 8 -  Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
.head 5 +  Column: colNms
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Назва рахунку
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  3.6"
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
.head 5 +  Column: colTip
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Tip
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
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
.head 5 +  Column: colOkpo
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
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
.head 5 +  Column: colError
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Повідомлення
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  3.6"
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
.head 5 +  Column: colCardAcct	! Техн. счет
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
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
.head 4 +  Functions
.head 5 +  Function: newRow
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: sFileAcc
.head 7 -  Number: sFileSum
.head 7 -  String: sPkNls
.head 7 -  String: sPkNms
.head 7 -  String: sPkTip
.head 7 -  String: sPkOkpo
.head 7 -  String: sCardAcct
.head 7 -  String: sErr
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 6 +  Actions
.head 7 -  Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
.head 7 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 7 -  Set colCardAcc = sFileAcc
.head 7 -  Set colS     = sFileSum
.head 7 -  Set colNls   = sPkNls
.head 7 -  Set colNms   = sPkNms
.head 7 -  Set colTip   = sPkTip
.head 7 -  Set colOkpo  = sPkOkpo
.head 7 -  Set colCardAcct = sCardAcct
.head 7 -  Set colError = sErr
.head 7 +  If sErr
.head 8 -  Call XSalTblSetRowBackColor(hWndForm, nRow, SalColorFromRGB(250, 170, 170))
.head 7 -  Return TRUE
.head 5 +  Function: payFile
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Boolean: bError
.head 7 -  String: sError
.head 7 -  !
.head 7 -  : ccDoc
.head 8 -  Class: cDoc
.head 7 -  Number: nDk
.head 7 -  String: sNlsT	! Транзитный счет (obpc_trans.transit)
.head 7 -  String: sNlsK	! Карточный счет 2625
.head 7 -  String: sPlat	! Наим. плательщика (транзит)
.head 7 -  String: sPolu	! Наим. получателя (карт. счет)
.head 7 -  Number: nS	! Сумма
.head 7 -  String: sOkpo
.head 7 -  !
.head 7 -  Date/Time: dValDate
.head 7 -  String: sBankMfo
.head 7 -  Number: nVob
.head 7 -  Number: nRef
.head 7 -  !
.head 7 -  Number: nRow
.head 7 -  !
.head 7 -  File Handle: hF
.head 7 -  Boolean: bDirExist
.head 7 -  String: sBackUpDir
.head 7 -  !
.head 7 -  Number: nPayAcc
.head 7 -  Number: nPaySum
.head 7 -  Number: nFileId
.head 6 +  Actions
.head 7 +  If SalIsNull(dfTt)
.head 8 -  Call SalMessageBox('Не задано операцію для оплати!', 'Увага!', MB_IconExclamation | MB_Ok)
.head 8 -  Call SalSetFocus(cmbTt)
.head 8 -  Return FALSE
.head 7 +  If SalIsNull(dfTransitNls)
.head 8 -  Call SalMessageBox('Не задано транзитний рахунок!', 'Увага!', MB_IconExclamation | MB_Ok)
.head 8 -  Call SalSetFocus(dfTransitNls)
.head 8 -  Return FALSE
.head 7 +  If SalIsNull(dfNazn)
.head 8 -  Call SalMessageBox('Не задано призначення платежу!', "Увага!", MB_IconExclamation | MB_Ok)
.head 8 -  Call SalSetFocus(dfNazn)
.head 8 -  Return FALSE
.head 7 +  If SalIsNull(dfZB)
.head 8 -  Call SalMessageBox('Не задано позабалансовий символ!', 'Увага!', MB_IconExclamation | MB_Ok)
.head 8 -  Call SalSetFocus(dfZB)
.head 8 -  Return FALSE
.head 7 +  If dfPayAcc = 0 or dfPaySum = 0
.head 8 -  Call SalMessageBox('Немає документів для оплати!', 'Увага!', MB_IconExclamation | MB_Ok)
.head 8 -  Return FALSE
.head 7 +  If SalMessageBox(cmbTt || PutCrLf() || PutCrLf() ||
   "Оплатити " || Str(dfPayAcc) || " документів на " || SalNumberToStrX(dfPaySum, 2) || " " || dfLcv || "?", 
   "Увага!", MB_IconQuestion | MB_YesNo) = IDNO
.head 8 -  Return FALSE
.head 7 +  If dfOstc != NUMBER_Null and dfOstc < dfPaySum
.head 8 +  If SalMessageBox("На транзитному рахунку недостатньо коштів для проведення операції." || PutCrLf() || 
   "Оплатити документи?", "Увага!", MB_IconExclamation | MB_YesNo) = IDNO
.head 9 -  Return FALSE
.head 7 -  Set bError = FALSE
.head 7 -  Set sError = ''
.head 7 +  If not SqlPrepareAndExecute(hSql(), "select s_obpczpfiles.nextval into :nFileId from dual")
.head 8 -  Return FALSE
.head 7 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Return FALSE
.head 7 -  Set nPayAcc = 0
.head 7 -  Set nPaySum = 0
.head 7 -  !
.head 7 -  Set nDk   = 1
.head 7 -  Set sNlsT = dfTransitNls
.head 7 -  Set sPlat = Subs(dfTransitNms,1,38)
.head 7 -  Set sNazn = dfNazn
.head 7 -  ! -- Дата валютирования
.head 7 -  Set dValDate = GetBankDate()
.head 7 -  ! -- МФО
.head 7 -  Set sBankMfo = GetBankMfo()
.head 7 -  ! -- Мем. ордер
.head 7 -  Set nVob = 6
.head 7 -  !
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 +  If colNls and colS > 0
.head 9 -  ! -- Счет
.head 9 -  Set sNlsK = colNls
.head 9 -  Set sPolu = colNms
.head 9 -  Set sOkpo = colOkpo
.head 9 -  ! -- Сумма
.head 9 -  Set nS = colS * SalNumberPower(10, nDig)
.head 9 -  !
.head 9 -  Call ccDoc.SetDoc(0, dfTt, nDk, nVob, '',
     dValDate, dValDate, dValDate, dValDate,
     sNlsT, sPlat, sBankMfo, '', nKv, nS, sTransitOkpo,
     sNlsK, sPolu, sBankMfo, '', nKv, nS, sOkpo,
     sNazn, '', GetIdOper(), '', NUMBER_Null, 0)
.head 9 +  If not ccDoc.oDoc()
.head 10 -  Set bError = TRUE
.head 10 -  Set sError = 'Неуспешная оплата документа ' || dfTt || ' Д' || sNlsT || ' К' || sNlsK
.head 10 -  Break
.head 9 -  ! -- Вставка доп. реквизитов если есть
.head 9 -  Set nRef = ccDoc.m_nRef
.head 9 +  If SalStrLeftX(colTip, 2) = 'PK'
.head 10 +  If not SqlPrepareAndExecute(hSql(), 
"insert into operw (ref, tag, value) 
 values (:nRef, 'CDAC', :colCardAcct)")
.head 11 -  Set bError = TRUE
.head 11 -  Set sError = 'Неуспішне виконання процедури додовання дод. реквизиту CDAC'
.head 11 -  Break
.head 9 +  If not SqlPrepareAndExecute(hSql(), 
"insert into operw (ref, tag, value) 
 values (:nRef, 'ZP_FN', :sCurrFile)")
.head 10 -  Set bError = TRUE
.head 10 -  Set sError = 'Неуспішне виконання процедури додовання дод. реквизиту ZP_FN'
.head 10 -  Break
.head 9 +  If not SqlPrepareAndExecute(hSql(), 
"insert into operw (ref, tag, value) 
 values (:nRef, 'ZP_ID', :nFileId)")
.head 10 -  Set bError = TRUE
.head 10 -  Set sError = 'Неуспішне виконання процедури додовання дод. реквизиту ZP_ID'
.head 10 -  Break
.head 9 +  If not SqlPrepareAndExecute(hSql(), 
"insert into operw (ref, tag, value) 
 values (:nRef, 'SK_ZB', :dfZB)")
.head 10 -  Set bError = TRUE
.head 10 -  Set sError = 'Неуспішне виконання процедури додовання дод. реквизиту SK_ZB'
.head 10 -  Break
.head 9 -  Set nPayAcc = nPayAcc + 1
.head 9 -  Set nPaySum = nPaySum + nS
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  !
.head 7 +  If not bError
.head 8 -  Call SqlCommitEx(hSql(), "OBPC. Оплачено " || Str(nPayAcc) || " документів на " || Str(nPaySum/SalNumberPower(10, nDig)) || " " || dfLcv)
.head 8 -  Call SalMessageBox("Оплачено " || Str(nPayAcc) || " документів на " || SalNumberToStrX(nPaySum/SalNumberPower(10, nDig), 2) || " " || dfLcv, 
     "Інформація", MB_IconAsterisk)
.head 8 -  ! Переименовываем
.head 8 -  Set sBackUpDir = sFilePath || '\\backup\\' || SalFmtFormatDateTime(SalDateCurrent(), 'yyyyMMdd')
.head 8 -  ! 16ZP____.___ - зарплатный файл, 1-2 симв - код района, 3-4 симв. - признак ЗП файла
.head 8 +  If Subs(SalStrUpperX(sCurrFile), 3, 2) = 'ZP'
.head 9 -  Set sBackUpDir = sBackUpDir || '\\' || Subs(sCurrFile, 1, 2)
.head 8 -  Set bDirExist = TRUE
.head 8 +  If not VisDosExist(sBackUpDir)
.head 9 -  Set bDirExist = FALSE
.head 9 +  If VisDosMakeAllDir(sBackUpDir) = VTERR_Ok
.head 10 -  Set bDirExist = TRUE
.head 8 +  If VisFileCopy(sFilePath || '\\' || sCurrFile, 
   IifS(bDirExist=TRUE, sBackUpDir, sFilePath) || '\\' || SalStrReplaceX(sCurrFile, Len(sCurrFile)-3, 3, 'OLD'))
.head 9 -  Call SalFileOpen(hF, sFilePath || sCurrFile, OF_Delete)
.head 8 -  Call printFile(IifS(bDirExist=TRUE, sBackUpDir, sFilePath) || '\\' || SalStrReplaceX(sCurrFile, Len(sCurrFile)-3, 3, 'LOG'))
.head 7 +  Else
.head 8 -  Call SqlRollbackEx(hSql(), "OBPC. " || sError)
.head 7 -  ! сохраняем инф. о файле
.head 7 +  If not bError
.head 8 +  If not SqlPrepareAndExecute(hSql(), 
"insert into obpc_zp_files(id, file_name, transit_acc, file_acc, file_sum, pay_acc, pay_sum)
 values (:nFileId, :sCurrFile, :nTransitAcc, :dfFileAcc, :dfFileSum * power(10,:nDig), :nPayAcc, :nPaySum)")
.head 9 -  Call SqlRollbackEx(hSql(), "OBPC. Ошибка сохранения инф. о З/П файле " || sCurrFile)
.head 8 +  Else
.head 9 -  Call SqlCommitEx(hSql(), "OBPC. Сохранена инф. о З/П файле " || sCurrFile)
.head 7 -  Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
.head 7 -  Return TRUE
.head 5 +  Function: printFile
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: sFileName
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 7 -  File Handle: hF
.head 7 -  String: sBadCardAcc
.head 7 -  String: sBadTipAcc
.head 6 +  Actions
.head 7 +  If not SalFileOpen(hF, sFileName, OF_Write | OF_Text)
.head 8 -  Call SalMessageBox('Неможливо відкрити файл ' || GetPrnDir()  || '\\' || sCurrFile, 'Ошибка!', MB_IconStop | MB_Ok)
.head 8 -  Return FALSE
.head 7 -  Call SalFilePutStr(hF, sCurrFile || ' ' || SalFmtFormatDateTime(SalDateCurrent(), 'dd.MM.yyyy hhhh:mm:ss'))
.head 7 +  If dfTransitNls
.head 8 -  Call SalFilePutStr(hF, dfTransitNls || ' ' || dfLcv || ' ' || dfTransitNms)
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 -  Call SalFilePutStr(hF, 
     PadR(colCardAcc,14) || ' ' || 
     PadL(SalNumberToStrX(colS,2), 16) || ' ' || 
     IifS(colNls='', '', PadR(colNls, 14) || ' ') || 
     IifS(colNms='', '', PadR(colNms, 38) || ' ') || 
     IifS(colError='','',colError))
.head 7 -  Call SalFilePutStr(hF, '')
.head 7 -  Call SalFilePutStr(hF, 'Всьго рахунків: ' || Str(dfFileAcc))
.head 7 -  Call SalFilePutStr(hF, 'Сума файлу    : ' || SalNumberToStrX(dfFileSum,2))
.head 7 +  If nBadAccCard
.head 8 -  Call SalFilePutStr(hF, 'Технічних рахунків не знайдено: ' || Str(nBadAccCard))
.head 8 -  Call SalFilePutStr(hF, '   ' || sBadAccCard)
.head 7 +  If nBadAccTip
.head 8 -  Call SalFilePutStr(hF, 'Рахунки не є картковими: ' || Str(nBadAccTip))
.head 8 -  Call SalFilePutStr(hF, '   ' || sBadAccTip)
.head 7 +  If nBadAccSum
.head 8 -  Call SalFilePutStr(hF, 'Рахунки з нульовими сумами: ' || Str(nBadAccSum))
.head 8 -  Call SalFilePutStr(hF, '   ' || sBadAccSum)
.head 7 +  If nBadAccOkpo
.head 8 -  Call SalFilePutStr(hF, 'Невідповіднисть ЗКПО: ' || Str(nBadAccOkpo))
.head 8 -  Call SalFilePutStr(hF, '   ' || sBadAccOkpo)
.head 7 -  Call SalFilePutStr(hF, 'Рахунків до сплати: ' || Str(dfPayAcc))
.head 7 -  Call SalFilePutStr(hF, 'Сума до сплати    : ' || SalNumberToStrX(dfPaySum,2))
.head 7 -  Call SalFileClose(hF)
.head 7 -  Return TRUE
.head 4 +  Window Variables
.head 5 -  Number: nRow
.head 4 -  Message Actions
.head 3 -  !
.head 3 +  Picture: picItog
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.2"
.head 5 -  Top:    6.8"
.head 5 -  Width:  12.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.75"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  File Name:
.head 4 -  Storage: External
.head 4 -  Picture Transparent Color: None
.head 4 -  Fit: Scale
.head 4 -  Scaling
.head 5 -  Width:  100
.head 5 -  Height:  100
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Tile To Parent? No
.head 4 -  Border Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 -  Message Actions
.head 3 +  Data Field: bgFileAcc
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
.head 6 -  Left:   3.4"
.head 6 -  Top:    6.952"
.head 6 -  Width:  1.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
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
.head 3 +  Data Field: dfFileAcc
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
.head 6 -  Left:   5.05"
.head 6 -  Top:    6.9"
.head 6 -  Width:  1.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfFileSum
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
.head 6 -  Left:   5.05"
.head 6 -  Top:    7.2"
.head 6 -  Width:  1.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Decimal
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: bgFileSum
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
.head 6 -  Left:   3.4"
.head 6 -  Top:    7.25"
.head 6 -  Width:  1.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
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
.head 3 +  Data Field: bgError
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
.head 6 -  Left:   6.8"
.head 6 -  Top:    6.952"
.head 6 -  Width:  3.4"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Dark Red
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfError
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
.head 6 -  Left:   10.25"
.head 6 -  Top:    6.9"
.head 6 -  Width:  1.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Dark Red
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  ! Data Field: bgBadAccTip
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
.head 6 -  Left:   6.8"
.head 6 -  Top:    7.25"
.head 6 -  Width:  3.4"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Dark Red
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.end
.head 4 -  Message Actions 
.head 3 +  ! Data Field: dfBadAccTip
.winattr
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
.head 6 -  Left:   10.25"
.head 6 -  Top:    7.2"
.head 6 -  Width:  1.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Dark Red
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.end
.head 4 -  Message Actions 
.head 3 +  Data Field: bgPayAcc
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
.head 6 -  Left:   12.1"
.head 6 -  Top:    6.952"
.head 6 -  Width:  2.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
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
.head 3 +  Data Field: dfPayAcc
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
.head 6 -  Left:   14.15"
.head 6 -  Top:    6.9"
.head 6 -  Width:  1.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: bgPaySum
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
.head 6 -  Left:   12.1"
.head 6 -  Top:    7.25"
.head 6 -  Width:  2.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
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
.head 3 +  Data Field: dfPaySum
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
.head 6 -  Left:   14.15"
.head 6 -  Top:    7.2"
.head 6 -  Width:  1.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Decimal
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Транзитний рахунок
.head 4 -  Resource Id: 26082
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.2"
.head 5 -  Top:    0.4"
.head 5 -  Width:  2.4"
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
.head 3 -  Background Text: Призначення платежу
.head 4 -  Resource Id: 26080
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.2"
.head 5 -  Top:    1.0"
.head 5 -  Width:  2.4"
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
.head 3 -  Background Text: Позабаланс. символ
.head 4 -  Resource Id: 26081
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.2"
.head 5 -  Top:    1.3"
.head 5 -  Width:  2.4"
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
.head 2 +  Functions
.head 3 +  Function: readFile
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: sFName
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Boolean: bError
.head 5 -  String: sError
.head 4 +  Actions
.head 5 -  Set bError = FALSE
.head 5 -  Set sError = ''
.head 5 -  Call clearFields(TRUE)
.head 5 -  !
.head 5 +  If SalStrUpperX(SalStrMidX(sFName, Len(sFName)-3, 3)) = 'TXT'
.head 6 -  Set bError = not readFileTxt(sFName, sError)
.head 5 +  Else If SalStrUpperX(SalStrMidX(sFName, Len(sFName)-3, 3)) = 'DBF'
.head 6 -  Set bError = not readFileDbf(sFName, sError)
.head 5 +  Else If SalStrUpperX(SalStrMidX(sFName, Len(sFName)-3, 3)) = 'XML'
.head 6 -  Set bError = not readFileXml(sFName, sError)
.head 5 -  !
.head 5 +  If bError
.head 6 -  Call SalMessageBox(sError, "Увага!", MB_IconExclamation)
.head 5 +  Else
.head 6 -  Set dfFileAcc = nAllAcc
.head 6 -  Set dfFileSum = nAllSum
.head 6 -  Set dfError   = nBadAccCard + nBadAccTip + nBadAccSum + nBadAccOkpo
.head 6 -  Set dfPayAcc  = nPayAcc
.head 6 -  Set dfPaySum  = nPaySum
.head 6 +  If dfError > 0
.head 7 -  Call SalShowWindowAndLabel(bgError)
.head 7 -  Call SalShowWindow(dfError)
.head 6 +  Else
.head 7 -  Call SalHideWindowAndLabel(bgError)
.head 7 -  Call SalHideWindow(dfError)
.head 5 -  Return TRUE
.head 3 +  Function: readFileTxt
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: sFName
.head 5 -  Receive String: sRetError
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nCountLine
.head 5 -  Number: nError
.head 5 -  String: sError
.head 5 -  !
.head 5 -  String: sFileName
.head 5 -  File Handle: hFile
.head 5 -  String: sLine
.head 5 -  String: sFileAcc
.head 5 -  String: sFileFio
.head 5 -  Number: nFileSum
.head 5 -  !
.head 5 -  String: sPkNls
.head 5 -  String: sPkNms
.head 5 -  String: sPkTip
.head 5 -  String: sPkOkpo
.head 5 -  String: sCardAcct
.head 5 -  String: sOkpo
.head 5 -  ! Количество колонок
.head 5 -  Number: nValueCount
.head 5 -  ! Значения колонок
.head 5 -  String: sValues[*]
.head 4 +  Actions
.head 5 -  ! -- Открываем файл
.head 5 -  Set sFileName = sFilePath || sFName
.head 5 +  If not SalFileOpen(hFile, sFileName, OF_Read | OF_Text )
.head 6 -  Set sRetError = "Неможливо відкрити Файл " || sFileName
.head 6 -  Return FALSE
.head 5 -  ! -- Обработка файла
.head 5 -  Set nCountLine = 0
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 +  While SalFileGetStr(hFile, sLine, 1024)
.head 6 +  If SalStrTrim(sLine, sLine) > 0
.head 7 -  ! Проверка на транзитный счет в первой строке
.head 7 +  If nCountLine = 0 and Len(sLine) <= 14
.head 8 -  ! Транзитный счет
.head 8 -  Set dfTransitNls = sLine
.head 8 -  Call SalSendMsg(dfTransitNls, SAM_Validate, 0, 0)
.head 7 +  Else
.head 8 -  Call SalArraySetUpperBound(sValues, 1, -1)
.head 8 -  Set nValueCount = SalStrTokenize(sLine, ',', ',', sValues)
.head 8 +  If nValueCount != 4
.head 9 -  Set sRetError = "Порушено структуру файлу: рядок " || Str(nCountLine+1)
.head 9 -  Return FALSE
.head 8 -  ! -- Данные из файла
.head 8 -  ! Счет
.head 8 -  Set sFileAcc = SalStrTrimX(sValues[0])
.head 8 -  ! ФИО
.head 8 -  Set sFileFio = SalStrTrimX(StrDosToWinX(sValues[1]))
.head 8 -  ! Сумма
.head 8 -  Set nFileSum = SalStrToNumber(sValues[2])
.head 8 -  ! ОКПО
.head 8 -  Set sPkOkpo = SalStrTrimX(sValues[3])
.head 8 -  !
.head 8 +  If not checkLine(sFileAcc, nFileSum, nError, sError, sPkNls, sPkNms, sPkTip, sOkpo, sCardAcct)
.head 9 -  Call tblCard.newRow(sFileAcc, nFileSum, STRING_Null, sFileFio, sPkTip, STRING_Null, STRING_Null, sError)
.head 9 -  ! Рахунок не знайдено
.head 9 +  If nError = 1
.head 10 -  Set sBadAccCard = sBadAccCard || IifS(sBadAccCard='', '', ',') || sFileAcc
.head 10 -  Set nBadAccCard = nBadAccCard + 1
.head 9 -  ! Рахунок не є картковим
.head 9 +  If nError = 2
.head 10 -  Set sBadAccTip = sBadAccTip || IifS(sBadAccTip='', '', ',') || sPkNls
.head 10 -  Set nBadAccTip = nBadAccTip + 1
.head 9 -  ! Нульова сума
.head 9 +  If nError = 3
.head 10 -  Set sBadAccSum = sBadAccSum || IifS(sBadAccSum='', '', ',') || sPkNls
.head 10 -  Set nBadAccSum = nBadAccSum + 1
.head 8 +  Else
.head 9 +  If sOkpo != sPkOkpo
.head 10 -  Call tblCard.newRow(sFileAcc, nFileSum, STRING_Null, sFileFio, sPkTip, STRING_Null, STRING_Null, "Невідповідність ЗКПО")
.head 10 -  Set sBadAccOkpo = sBadAccOkpo || IifS(sBadAccOkpo='', '', ',') || sPkNls
.head 10 -  Set nBadAccOkpo = nBadAccOkpo + 1
.head 9 +  Else
.head 10 -  Call tblCard.newRow(sFileAcc, nFileSum, sPkNls, sPkNms, sPkTip, sPkOkpo, sCardAcct, "")
.head 10 -  Set nPayAcc = nPayAcc + 1
.head 10 -  Set nPaySum = nPaySum + nFileSum
.head 8 -  !
.head 8 -  Set nAllAcc = nAllAcc + 1
.head 8 -  Set nAllSum = nAllSum + nFileSum
.head 6 -  Set nCountLine = nCountLine + 1
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  ! -- Закрываем файл
.head 5 -  Call SalFileClose(hFile)
.head 5 -  !
.head 5 -  Return TRUE
.head 3 +  Function: readFileDbf
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: sFName
.head 5 -  Receive String: sRetError
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nCountLine
.head 5 -  Number: nError
.head 5 -  String: sError
.head 5 -  !
.head 5 -  String: sFileAcc
.head 5 -  String: sFileFio
.head 5 -  Number: nFileSum
.head 5 -  !
.head 5 -  String: sPkNls
.head 5 -  String: sPkNms
.head 5 -  String: sPkTip
.head 5 -  String: sPkOkpo
.head 5 -  String: sCardAcct
.head 5 -  String: sOkpo
.head 5 -  !
.head 5 -  Sql Handle: hODBC
.head 4 +  Actions
.head 5 -  ! -- Открываем файл
.head 5 -  Set sFileName = sFilePath || sFName
.head 5 -  Call SalFileSetCurrentDirectory(sFilePath)
.head 5 +  If not SalFileOpen(hFile, sFileName, OF_Exist)
.head 6 -  Call SalMessageBox("Неможливо відкрити Файл " || sFileName, 
     "Увага!", MB_IconExclamation | MB_Ok)
.head 6 -  Return FALSE
.head 5 -  ! -- Импорт
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 -  Set SqlDatabase = 'dBase_Files'
.head 5 +  If SqlConnect(hODBC)
.head 6 -  ! -- Обработка файла
.head 6 -  Set nCountLine = 0
.head 6 +  If SqlPrepareAndExecute(hODBC, 
"select count_no, fio, amount, id_kod
   into :sFileAcc, :sFileFio, :nFileSum, :sPkOkpo
   from " || Subs(sFName, 1, Len(sFName)-4))
.head 7 +  While SqlFetchNext(hODBC, nFetchRes)
.head 8 -  Set sFileAcc = SalStrTrimX(sFileAcc)
.head 8 -  Set sFileFio = StrDosToWinX(SalStrTrimX(sFileFio))
.head 8 -  !
.head 8 +  If not checkLine(sFileAcc, nFileSum, nError, sError, sPkNls, sPkNms, sPkTip, sOkpo, sCardAcct)
.head 9 -  Call tblCard.newRow(sFileAcc, nFileSum, STRING_Null, sFileFio, sPkTip, STRING_Null, STRING_Null, sError)
.head 9 -  ! Рахунок не знайдено
.head 9 +  If nError = 1
.head 10 -  Set sBadAccCard = sBadAccCard || IifS(sBadAccCard='', '', ',') || sFileAcc
.head 10 -  Set nBadAccCard = nBadAccCard + 1
.head 9 -  ! Рахунок не є картковим
.head 9 +  If nError = 2
.head 10 -  Set sBadAccTip = sBadAccTip || IifS(sBadAccTip='', '', ',') || sPkNls
.head 10 -  Set nBadAccTip = nBadAccTip + 1
.head 9 -  ! Нульова сума
.head 9 +  If nError = 3
.head 10 -  Set sBadAccSum = sBadAccSum || IifS(sBadAccSum='', '', ',') || sPkNls
.head 10 -  Set nBadAccSum = nBadAccSum + 1
.head 8 +  Else
.head 9 +  If sOkpo != sPkOkpo
.head 10 -  Call tblCard.newRow(sFileAcc, nFileSum, STRING_Null, sFileFio, sPkTip, STRING_Null, STRING_Null, "Невідповідність ЗКПО")
.head 10 -  Set sBadAccOkpo = sBadAccOkpo || IifS(sBadAccOkpo='', '', ',') || sPkNls
.head 10 -  Set nBadAccOkpo = nBadAccOkpo + 1
.head 9 +  Else
.head 10 -  Call tblCard.newRow(sFileAcc, nFileSum, sPkNls, sPkNms, sPkTip, sPkOkpo, sCardAcct, "")
.head 10 -  Set nPayAcc = nPayAcc + 1
.head 10 -  Set nPaySum = nPaySum + nFileSum
.head 8 -  !
.head 8 -  Set nAllAcc = nAllAcc + 1
.head 8 -  Set nAllSum = nAllSum + nFileSum
.head 8 -  Set nCountLine = nCountLine + 1
.head 5 -  Call SqlDisconnect(hODBC)
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  !
.head 5 -  Return TRUE
.head 3 +  Function: readFileXml
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: sFName
.head 5 -  Receive String: sRetError
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nCountLine
.head 5 -  Number: nError
.head 5 -  String: sError
.head 5 -  !
.head 5 -  String: sFileAcc
.head 5 -  String: sFileFio
.head 5 -  Number: nFileSum
.head 5 -  !
.head 5 -  String: sPkNls
.head 5 -  String: sPkNms
.head 5 -  String: sPkTip
.head 5 -  String: sPkOkpo
.head 5 -  String: sCardAcct
.head 5 -  String: sOkpo
.head 4 +  Actions
.head 5 -  ! -- Открываем файл
.head 5 -  Set sFileName = sFilePath || sFName
.head 5 +  If not PutFileToTmpLob(hSql(), sFileName, 'C')
.head 6 -  Set sRetError = "Не вдалося загрузити файл " || sFName
.head 6 -  Return FALSE
.head 5 +  If not SqlPLSQLCommand(hSql(), "obpc.load_xml_file(0)")
.head 6 -  Call SqlRollback(hSql())
.head 6 -  Set sRetError = "Не вдалося загрузити файл " || sFName
.head 6 -  Return FALSE
.head 5 -  Call SqlCommit(hSql())
.head 5 -  ! -- Данные из файла
.head 5 -  Set nCountLine = 0
.head 5 -  Call SqlPrepareAndExecute(hSqlAux(),
"select nls, nms, okpo, s/100
   into :sFileAcc, :sFileFio, :sPkOkpo, :nFileSum
   from tmp_bpk_salary")
.head 5 +  While SqlFetchNext(hSqlAux(), nFetchRes)
.head 6 +  If not checkLine(sFileAcc, nFileSum, nError, sError, sPkNls, sPkNms, sPkTip, sOkpo, sCardAcct)
.head 7 -  Call tblCard.newRow(sFileAcc, nFileSum, STRING_Null, sFileFio, sPkTip, STRING_Null, STRING_Null, sError)
.head 7 -  ! Рахунок не знайдено
.head 7 +  If nError = 1
.head 8 -  Set sBadAccCard = sBadAccCard || IifS(sBadAccCard='', '', ',') || sFileAcc
.head 8 -  Set nBadAccCard = nBadAccCard + 1
.head 7 -  ! Рахунок не є картковим
.head 7 +  If nError = 2
.head 8 -  Set sBadAccTip = sBadAccTip || IifS(sBadAccTip='', '', ',') || sPkNls
.head 8 -  Set nBadAccTip = nBadAccTip + 1
.head 7 -  ! Нульова сума
.head 7 +  If nError = 3
.head 8 -  Set sBadAccSum = sBadAccSum || IifS(sBadAccSum='', '', ',') || sPkNls
.head 8 -  Set nBadAccSum = nBadAccSum + 1
.head 6 +  Else
.head 7 +  If sOkpo != sPkOkpo
.head 8 -  Call tblCard.newRow(sFileAcc, nFileSum, STRING_Null, sFileFio, sPkTip, STRING_Null, STRING_Null, "Невідповідність ЗКПО")
.head 8 -  Set sBadAccOkpo = sBadAccOkpo || IifS(sBadAccOkpo='', '', ',') || sPkNls
.head 8 -  Set nBadAccOkpo = nBadAccOkpo + 1
.head 7 +  Else
.head 8 -  Call tblCard.newRow(sFileAcc, nFileSum, sPkNls, sPkNms, sPkTip, sPkOkpo, sCardAcct, "")
.head 8 -  Set nPayAcc = nPayAcc + 1
.head 8 -  Set nPaySum = nPaySum + nFileSum
.head 6 -  Set nAllAcc = nAllAcc + 1
.head 6 -  Set nAllSum = nAllSum + nFileSum
.head 6 -  Set nCountLine = nCountLine + 1
.head 5 -  !
.head 5 -  Return TRUE
.head 3 +  Function: clearFields
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Boolean: bFlag
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SalTblReset(tblCard)
.head 5 +  If not sParTt
.head 6 -  Set dfTranType = STRING_Null
.head 6 -  Set dfTt = STRING_Null
.head 6 -  Call SalListSetSelect(cmbTt, -1)
.head 6 -  Call EnableWindow(cmbTt, bFlag)
.head 6 -  Set dfNazn = ''
.head 5 -  Set dfTransitNls = ''
.head 5 -  Set dfTransitNms = ''
.head 5 -  Set dfOstc = NUMBER_Null
.head 5 -  Set dfOstb = NUMBER_Null
.head 5 -  Set dfZB = ''
.head 5 -  Call SalListSetSelect(cmbZB, -1)
.head 5 -  Set dfFileAcc = 0
.head 5 -  Set dfFileSum = 0
.head 5 -  Set dfError   = 0
.head 5 -  Set dfPayAcc  = 0
.head 5 -  Set dfPaySum  = 0
.head 5 -  Set nBadAccCard = 0
.head 5 -  Set sBadAccCard = ''
.head 5 -  Set nBadAccTip  = 0
.head 5 -  Set sBadAccTip  = ''
.head 5 -  Set nBadAccSum  = 0
.head 5 -  Set sBadAccSum  = ''
.head 5 -  Set nBadAccOkpo = 0
.head 5 -  Set sBadAccOkpo = ''
.head 5 -  Set nAllAcc = 0
.head 5 -  Set nPayAcc = 0
.head 5 -  Set nAllSum = 0
.head 5 -  Set nPaySum = 0
.head 5 -  Call EnableWindow(dfTransitNls, bFlag)
.head 5 +  If bFlag
.head 6 -  Call SalEnableWindow(pbSelectTransit)
.head 5 +  Else
.head 6 -  Call SalDisableWindow(pbSelectTransit)
.head 5 -  Call EnableWindow(dfNazn, bFlag)
.head 5 -  Call EnableWindow(dfZB, bFlag)
.head 5 -  Call EnableWindow(cmbZB, bFlag)
.head 5 +  If sParTt
.head 6 -  Call SqlPrepareAndExecute(hSql(), "select val into :dfZB from op_rules where tt = :dfTt and tag = 'SK_ZB'")
.head 6 +  If SqlFetchNext(hSql(), nFetchRes)
.head 7 -  Call cmbZB.SetSelectById(dfZB)
.head 5 -  Return TRUE
.head 3 +  Function: checkFile
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sFName
.head 5 -  Date/Time: dFDat
.head 5 -  Number: nFAcc
.head 5 -  Number: nFSum
.head 4 +  Actions
.head 5 +  If not SqlPrepareAndExecute(hSql(), 
"select z.file_name, z.file_date, z.file_acc, z.file_sum/power(10, :nDig)
   into :sFName, :dFDat, :nFAcc, :nFSum
   from obpc_zp_files z, accounts a
  where a.acc = z.transit_acc
    and z.transit_acc = :nTransitAcc
    and z.file_sum = :dfFileSum * power(10, :nDig)
    and trunc(z.file_date) = trunc(sysdate)")
.head 6 -  Return FALSE
.head 5 +  If SqlFetchNext(hSql(), nFetchRes)
.head 6 +  If SalMessageBox("Файл з транзитним рахунком " || dfTransitNls || " на суму " || SalNumberToStrX(dfFileSum,2) || " сьогодні вже приймався!" || PutCrLf() ||
"   ім'я файлу: " || sFName || PutCrLf() ||
"   дата файлу: " || SalFmtFormatDateTime(dFDat, 'dd.MM.yyyy hhhh:mm:ss') || PutCrLf() ||
"   кіл-ть рахунків: " || Str(nFAcc) || PutCrLf() ||
"   сума файлу: " || SalNumberToStrX(nFSum,2) || PutCrLf() ||
"Прийняти файл?", "Увага!", MB_IconExclamation | MB_YesNo) = IDNO
.head 7 -  Return FALSE
.head 5 -  Return TRUE
.head 3 +  Function: checkLine
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: sCheckNls
.head 5 -  Number: nCheckSum
.head 5 -  Receive Number: nErr
.head 5 -  Receive String: sErr
.head 5 -  Receive String: sRetNls
.head 5 -  Receive String: sRetNms
.head 5 -  Receive String: sRetTip
.head 5 -  Receive String: sRetOkpo
.head 5 -  Receive String: sRetCardAcct
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Date/Time: dDazs
.head 4 +  Actions
.head 5 -  Set nErr = 0
.head 5 -  Set sErr = ''
.head 5 -  Set sRetNls = ''
.head 5 -  Set sRetNms = ''
.head 5 -  Set sRetTip = ''
.head 5 -  Set sRetOkpo = ''
.head 5 -  Set sRetCardAcct = ''
.head 5 +  If Subs(sCheckNls,1,4) = '2625'
.head 6 -  Call SqlPrepareAndExecute(hSql(), 
"select a.nls, substr(a.nms,1,38), a.tip, c.okpo, a.dazs
   into :sRetNls, :sRetNms, :sRetTip, :sRetOkpo, :dDazs
   from accounts a, customer c
  where a.nls = :sCheckNls
    and a.kv  = :nBaseVal
    and a.rnk = c.rnk")
.head 6 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 7 -  Set nErr = 1
.head 7 -  Set sErr = "Рахунок не знайдено"
.head 7 -  Return FALSE
.head 6 +  If SalStrLeftX(sRetTip, 2) != 'PK' and SalStrLeftX(sRetTip, 2) != 'W4'
.head 7 -  Set nErr = 2
.head 7 -  Set sErr = "Рахунок не є картковим"
.head 7 -  Return FALSE
.head 6 +  If SalStrLeftX(sRetTip, 2) = 'PK'
.head 7 -  ! если счет PK закрыт
.head 7 +  If dDazs != DATETIME_Null
.head 8 -  ! ищем новый счет W4
.head 8 -  Call SqlPrepareAndExecute(hSql(), 
"select nls, substr(a.nms,1,38), a.tip, a.dazs
   into :sRetNls, :sRetNms, :sRetTip, :dDazs
   from accounts a
  where a.nlsalt = :sCheckNls
    and a.kv     = :nBaseVal
    and a.tip like 'W4%'")
.head 8 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 9 -  Set nErr = 1
.head 9 -  Set sErr = "Рахунок закрито"
.head 9 -  Return FALSE
.head 7 +  Else
.head 8 -  Call SqlPrepareAndExecute(hSql(), "select card_acct into :sRetCardAcct from obpc_acct where lacct = :sCheckNls and currency = 'UAH'")
.head 8 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 9 -  Set nErr = 1
.head 9 -  Set sErr = "Рахунок не знайдено в ACCT"
.head 9 -  Return FALSE
.head 6 +  If SalStrLeftX(sRetTip, 2) = 'W4' and dDazs != DATETIME_Null
.head 7 -  Set nErr = 1
.head 7 -  Set sErr = "Рахунок закрито"
.head 7 -  Return FALSE
.head 5 +  Else
.head 6 -  Call SqlPrepareAndExecute(hSql(), 
"select a.nls, substr(a.nms,1,38), a.tip, c.okpo, pc_a.card_acct
   into :sRetNls, :sRetNms, :sRetTip, :sRetOkpo, :sRetCardAcct
   from obpc_acct pc_a, accounts a, tabval$global v, customer c
  where pc_a." || IifS(Subs(sCheckNls,1,4)='2625', "lacct", "card_acct") || " = :sCheckNls
    and nvl(pc_a.status,'0') <> '4'
    and pc_a.lacct    = a.nls
    and pc_a.currency = v.lcv
    and v.kv = a.kv
    and a.kv = :nBaseVal
    and a.rnk = c.rnk")
.head 6 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 7 -  Set nErr = 1
.head 7 -  Set sErr = "Рахунок не знайдено"
.head 7 -  Return FALSE
.head 6 +  If SalStrLeftX(sRetTip, 2) != 'PK'
.head 7 -  Set nErr = 2
.head 7 -  Set sErr = "Рахунок не є картковим"
.head 7 -  Return FALSE
.head 5 +  If nCheckSum = 0
.head 6 -  Set nErr = 3
.head 6 -  Set sErr = "Нульова сума"
.head 6 -  Return FALSE
.head 5 -  Return TRUE
.head 3 +  Function: getTransit
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: sWhere
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If not SqlPrepareAndExecute(hSql(), 
"select a.acc, a.nls, a.nms, c.okpo, a.ostc/100, a.ostb/100
   into :nTransitAcc, :dfTransitNls, :dfTransitNms,
        :sTransitOkpo, :dfOstc, :dfOstb
   from accounts a, customer c
  where a.rnk = c.rnk and " || sWhere )
or not SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Set dfTransitNls = ''
.head 6 -  Set dfTransitNms = ''
.head 6 -  Set dfOstc = NUMBER_Null
.head 6 -  Set dfOstb = NUMBER_Null
.head 6 -  Call SalMessageBox("Рахунок не знайдено!", "Увага!", MB_IconExclamation | MB_Ok)
.head 6 -  Return FALSE
.head 5 -  Return TRUE
.head 2 +  Window Parameters
.head 3 -  String: sParTt
.head 2 +  Window Variables
.head 3 -  String: sFilePath
.head 3 -  Number: nBaseVal
.head 3 -  Number: nKv
.head 3 -  Number: nDig
.head 3 -  String: sTransitOkpo
.head 3 -  Number: nTransitAcc
.head 3 -  String: sNazn	! Назначение платежа
.head 3 -  String: sTtName	! Наименование операции
.head 3 -  !
.head 3 -  String: smFile[*]
.head 3 -  Number: nFiles
.head 3 -  Number: nIterator
.head 3 -  Number: hRoot
.head 3 -  Number: h1stChild
.head 3 -  Number: nCurrentFlag
.head 3 -  Number: nIndex
.head 3 -  Number: hPicRoot1
.head 3 -  String: sCurrFile
.head 3 -  !
.head 3 -  String: sTmp
.head 3 -  String: sPK
.head 3 -  String: sSem
.head 3 -  !
.head 3 -  Number: nAllAcc
.head 3 -  Number: nPayAcc
.head 3 -  Number: nAllSum
.head 3 -  Number: nPaySum
.head 3 -  !
.head 3 -  Number: nBadAccCard
.head 3 -  String: sBadAccCard
.head 3 -  Number: nBadAccTip
.head 3 -  String: sBadAccTip
.head 3 -  Number: nBadAccSum
.head 3 -  String: sBadAccSum
.head 3 -  Number: nBadAccOkpo
.head 3 -  String: sBadAccOkpo
.head 3 -  Number: nBadAcc
.head 3 -  !
.head 3 -  Number: nWW
.head 3 -  Number: nWH
.head 3 -  Number: nX
.head 3 -  Number: nY
.head 3 -  Number: nW
.head 3 -  Number: nH
.head 3 -  Number: nCX
.head 3 -  Number: nCY
.head 3 -  Number: nCW
.head 3 -  Number: nCH
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  ! Установка оптимального размера окна в зависимости от настроек рабочей станции
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Call SalGetWindowSize(hWndForm, nWW, nWH)
.head 4 +  If nWH < 5
.head 5 -  Set nWH = 5
.head 4 +  Else If nWH > 8.4
.head 5 -  Set nWH = 8.4
.head 4 -  Call SalSetWindowSize(hWndForm, 16.3, nWH)
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Call SalUseRegistry(FALSE, '')
.head 4 -  Call SalGetProfileString('OBPC', 'OBPCZpPath', '', sFilePath, GetIniFileName())
.head 4 +  If sFilePath = ''
.head 5 -  Call SalGetProfileString('OBPC', 'OBPCInPath', '', sFilePath, GetIniFileName())
.head 4 -  Set hPicRoot1 = VisPicLoad(PIC_LoadSWinRes | PIC_FormatIcon | PIC_LoadSmallIcon, 'icon_Folder1', '')
.head 4 -  Set nBaseVal = GetBaseVal()
.head 4 -  Set nKv      = nBaseVal
.head 4 -  Set dfLcv    = Str(nBaseVal)
.head 4 -  Call SalSendMsg(dfLcv, SAM_Validate, 0, 0)
.head 4 -  !
.head 4 -  Call SalHideWindowAndLabel(bgError)
.head 4 -  Call SalHideWindow(dfError)
.head 4 -  Set bgFileAcc = 'Всьго рахунків:'
.head 4 -  Set bgFileSum = 'Сума файлу:'
.head 4 -  Set bgError   = 'Помилки:'
.head 4 -  Set bgPayAcc  = 'Рахунків до сплати:'
.head 4 -  Set bgPaySum  = 'Сума до сплати:'
.head 4 -  Call clearFields(FALSE)
.head 3 +  On WM_Size
.head 4 -  Call SalGetWindowSize(hWndForm, nWW, nWH)
.head 4 +  If nWH < 5
.head 5 -  Set nWH = 5
.head 4 -  Call SalSetWindowSize(hWndForm, 16.3, nWH)
.head 4 -  !
.head 4 -  Call GetClientRect(hWndForm, nX, nY, nW, nH)
.head 4 -  !
.head 4 -  Call SalGetWindowSize(hWndForm.frm_ImportZP.cFiles, nWW, nWH)
.head 4 -  Call SalSetWindowSize(hWndForm.frm_ImportZP.cFiles,
     nWW, SalPixelsToFormUnits(hWndForm.frm_ImportZP.cFiles, nH, TRUE)-0.05)
.head 4 -  Call SalGetWindowSize(hWndForm.frm_ImportZP.tblCard, nCW, nCH)
.head 4 -  Call SalSetWindowSize(hWndForm.frm_ImportZP.tblCard,
     nCW, SalPixelsToFormUnits(hWndForm.frm_ImportZP.tblCard, nH, TRUE)-2.4)
.head 4 -  ! Итоги
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_ImportZP.picItog, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_ImportZP.picItog,
     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.8)
.head 4 -  !
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_ImportZP.bgFileAcc, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_ImportZP.bgFileAcc,
     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.6)
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_ImportZP.dfFileAcc, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_ImportZP.dfFileAcc,
     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.65)
.head 4 -  !
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_ImportZP.bgFileSum, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_ImportZP.bgFileSum,
     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.35)
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_ImportZP.dfFileSum, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_ImportZP.dfFileSum,
     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.4)
.head 4 -  !
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_ImportZP.bgError, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_ImportZP.bgError,
     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.6)
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_ImportZP.dfError, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_ImportZP.dfError,
     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.65)
.head 4 -  !
.head 4 -  ! Call SalGetWindowLoc(hWndForm.frm_ImportZP.bgBadAccTip, nCX, nCY)
.head 4 -  ! Call SalSetWindowLoc(hWndForm.frm_ImportZP.bgBadAccTip,
     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.35)
.head 4 -  ! Call SalGetWindowLoc(hWndForm.frm_ImportZP.dfBadAccTip, nCX, nCY)
.head 4 -  ! Call SalSetWindowLoc(hWndForm.frm_ImportZP.dfBadAccTip,
     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.4)
.head 4 -  !
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_ImportZP.bgPayAcc, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_ImportZP.bgPayAcc,
     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.6)
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_ImportZP.dfPayAcc, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_ImportZP.dfPayAcc,
     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.65)
.head 4 -  !
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_ImportZP.bgPaySum, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_ImportZP.bgPaySum,
     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.35)
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_ImportZP.dfPaySum, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_ImportZP.dfPaySum,
     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.4)
.head 4 -  !
.head 4 -  Call SalInvalidateWindow(hWndForm)
.head 1 +  Form Window: frm_PayCard
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Поповнення карткових рахунків
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
.head 4 -  Width:  9.55"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 7.4"
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
.head 3 -  Frame
.head 4 -  Resource Id: 16727
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.1"
.head 5 -  Width:  9.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 6.0"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: Default
.head 3 -  Background Text: Операція
.head 4 -  Resource Id: 19139
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.25"
.head 5 -  Width:  2.4"
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
.head 3 +  Data Field: dfTranType
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 2
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.7"
.head 6 -  Top:    0.2"
.head 6 -  Width:  0.6"
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
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfTt
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 3
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.35"
.head 6 -  Top:    0.2"
.head 6 -  Width:  0.8"
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
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Combo Box: cmbTt
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenComboBox_StrId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.2"
.head 5 -  Top:    0.2"
.head 5 -  Width:  4.95"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 1.036"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  String Type: Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Sorted? Class Default
.head 4 -  Always Show List? Class Default
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  List Initialization
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 +  If cmbTt.Init(hWndItem)
.head 7 +  If sParTt
.head 8 -  Call cmbTt.Populate(hSql(), "tt", "name", "v_bpk_tt_for_listpay", "where tt='" || sParTt || "' order by tt")
.head 8 +  If cmbTt.nItemNum = 0
.head 9 -  Call SalDestroyWindow(hWndForm)
.head 8 +  Else
.head 9 -  Call cmbTt.SetSelectById(sParTt)
.head 9 -  Call SalDisableWindow(hWndItem)
.head 9 -  Call SalSendMsg(hWndItem, SAM_Click, 0, 0)
.head 7 +  Else
.head 8 -  Call cmbTt.Populate(hSql(), "tt", "name", "v_bpk_tt_for_listpay", "order by tt")
.head 5 +  On SAM_Click
.head 6 -  Call SalSendClassMessage(SAM_Click, 0, 0)
.head 6 -  Set dfTt = cmbTt.strCurrentId
.head 6 -  Call SqlPrepareAndExecute(hSql(), "select tran_type into :dfTranType from obpc_trans_out where tt = :dfTt")
.head 6 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Call SqlPrepareAndExecute(hSql(), "select nvl(nazn,name) into :dfNazn from tts where tt = :dfTt")
.head 6 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Call SqlPrepareAndExecute(hSql(), "select val into :dfZB from op_rules where tt = :dfTt and tag = 'SK_ZB'")
.head 6 +  If SqlFetchNext(hSql(), nFetchRes)
.head 7 -  Call cmbZB.SetSelectById(dfZB)
.head 6 +  Else
.head 7 -  Set dfZB = ''
.head 7 -  Call SalListSetSelect(cmbZB, -1)
.head 3 -  !
.head 3 -  Background Text: Транзитний рахунок
.head 4 -  Resource Id: 16724
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.55"
.head 5 -  Width:  2.433"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfTransitNls
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 14
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.7"
.head 6 -  Top:    0.5"
.head 6 -  Width:  2.4"
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
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Validate
.head 6 +  If not SalIsNull(dfTransitNls)
.head 7 +  If not SqlPrepareAndExecute(hSql(), 
"select acc, nls, nms into :nTransitAcc, :dfTransitNls, :dfTransitNms
   from saldod
  where nls = :dfTransitNls and kv = :nKv")
or not SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set nTransitAcc  = NUMBER_Null
.head 8 -  Set dfTransitNls = ''
.head 8 -  Set dfTransitNms = ''
.head 8 -  Call SalMessageBox("Рахунок не знайдено або недоступно на дебет!", "Увага!", MB_IconExclamation | MB_Ok)
.head 8 -  Return VALIDATE_Cancel
.head 6 -  Return VALIDATE_Ok
.head 3 +  Data Field: dfLcv
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 3
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   5.15"
.head 6 -  Top:    0.5"
.head 6 -  Width:  0.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Uppercase
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Validate
.head 6 +  If SalIsNull(hWndItem)
.head 7 -  Set dfLcv = Str(nBaseVal)
.head 6 +  If SalIsValidInteger(hWndItem)
.head 7 -  Set sTmp = 'kv'
.head 6 +  Else
.head 7 -  Set sTmp = 'lcv'
.head 6 -  Call SqlPrepareAndExecute(hSql(), "select kv, lcv, dig into :nKv, :dfLcv, :nDig from tabval where " || sTmp || " = :dfLcv")
.head 6 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 7 -  Call SalMessageBox("Невідома валюта "|| " " || dfLcv,
     "Увага!", MB_IconExclamation )
.head 7 -  Set dfLcv = 'UAH'
.head 7 -  Return VALIDATE_Cancel
.head 6 -  Return VALIDATE_Ok
.head 3 +  Pushbutton: pbSelectTransit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вибрати...
.head 4 -  Window Location and Size
.head 5 -  Left:   6.0"
.head 5 -  Top:    0.48"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.3"
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
.head 6 +  If FunNSIGetFiltered("v_bpk_transit", "acc", "v_bpk_transit.lcv='" || dfLcv || "'", sPK, sSem)
.head 7 -  Call SqlPrepareAndExecute(hSql(), "select nls, nms into :dfTransitNls, :dfTransitNms from accounts where acc=:sPK")
.head 7 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 3 +  Data Field: dfTransitNms
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
.head 6 -  Left:   2.7"
.head 6 -  Top:    0.8"
.head 6 -  Width:  6.5"
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
.head 3 -  !
.head 3 -  Background Text: Призначення платежу
.head 4 -  Resource Id: 16723
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    1.15"
.head 5 -  Width:  2.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfNazn
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 160
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.7"
.head 6 -  Top:    1.1"
.head 6 -  Width:  6.5"
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
.head 3 -  !
.head 3 -  Background Text: Позабаланс. символ
.head 4 -  Resource Id: 24108
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    1.45"
.head 5 -  Width:  2.4"
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
.head 3 +  Data Field: dfZB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 2
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.7"
.head 6 -  Top:    1.4"
.head 6 -  Width:  0.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Validate
.head 6 +  If SalIsNull(dfZB)
.head 7 -  Call SalListSetSelect(cmbZB, -1)
.head 7 -  Return VALIDATE_OkClearFlag
.head 6 -  Call cmbZB.SetSelectById(dfZB)
.head 6 +  If cmbZB.strCurrentId
.head 7 -  Return VALIDATE_Ok
.head 6 +  Else
.head 7 -  Call SalMessageBox('Невідомий позабалансовий символ!', 'Увага', MB_Ok | MB_IconExclamation)
.head 7 -  Return VALIDATE_Cancel
.head 5 +  On SAM_KillFocus
.head 6 +  If wParam = SalWindowHandleToNumber(tblCard)
.head 7 -  Call SalSendMsg(tblCard, UM_Clear, 0, 0)
.head 3 +  Combo Box: cmbZB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenComboBox_StrId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.35"
.head 5 -  Top:    1.4"
.head 5 -  Width:  5.85"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 2.119"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  String Type: Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Sorted? Class Default
.head 4 -  Always Show List? Class Default
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  List Initialization
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 +  If cmbZB.Init(hWndItem)
.head 7 -  Call cmbZB.Populate(hSql(), 'd010', "d010 || ' ' || txt", 'kl_d010', "where d010>='84' order by d010")
.head 7 -  Call SalListSetSelect(cmbZB, -1)
.head 5 +  On SAM_Click
.head 6 -  Call SalSendClassMessage(SAM_Click, 0, 0)
.head 6 -  Set dfZB = cmbZB.strCurrentId
.head 5 +  On SAM_KillFocus
.head 6 +  If wParam = SalWindowHandleToNumber(tblCard)
.head 7 -  Call SalSendMsg(tblCard, UM_Clear, 0, 0)
.head 3 -  !
.head 3 +  Child Table: tblCard
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.2"
.head 6 -  Top:    1.75"
.head 6 -  Width:  9.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 3.6"
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
.head 5 +  Column: colCardAcc
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Технічний
рахунок
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: 10
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
.head 6 +  Message Actions
.head 7 +  On SAM_Validate
.head 8 +  If not SalIsNull(colCardAcc)
.head 9 -  Call SqlPrepareAndExecute(hSql(), 
"select s.acc, s.nls, s.nms, c.okpo
   into :colAcc, :colNls, :colNms, :colOkpo
   from obpc_acct a, accounts s, tabval v, customer c
  where a.card_acct = :colCardAcc and a.lacct = s.nls and s.kv = :nKv
    and s.kv = v.kv and v.lcv = a.currency
    and s.rnk = c.rnk")
.head 9 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 10 -  Call SalMessageBox("Не знайдено картковий рахунок для " || colCardAcc || " " || dfLcv,
     "Увага!", MB_IconExclamation )
.head 10 -  Return VALIDATE_Cancel
.head 8 +  Else
.head 9 -  Set colNls = ''
.head 9 -  Set colNms = ''
.head 8 -  Return VALIDATE_Ok
.head 5 +  Column: colS
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Сума
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: 16
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.4"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Decimal
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
.head 8 -  Call DecPoint(hWndItem)
.head 8 -  Call checkSum()
.head 8 -  Return VALIDATE_Ok
.head 5 +  Column: colNls
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Картковий
рахунок
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 14
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.8"
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
.head 8 +  If not SalIsNull(colNls)
.head 9 -  Call SqlPrepareAndExecute(hSql(),
"select a.acc, a.nms, a.tip, c.okpo
   into :colAcc, :colNms, :colTip, :colOkpo
   from accounts a, customer c
  where a.nls = :colNls and a.kv = :nKv
    and a.rnk = c.rnk")
.head 9 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 10 -  Call SalMessageBox("Не знайдено рахунок " || colNls || "/ " || dfLcv,
     "Увага!", MB_IconExclamation )
.head 10 -  Return VALIDATE_Cancel
.head 9 +  If SalStrLeftX(colTip, 2) = 'PK'
.head 10 -  Call SqlPrepareAndExecute(hSql(), "select card_acct into :colCardAcc from obpc_acct where lacct = :colNls and currency = :dfLcv")
.head 10 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 11 -  Call SalMessageBox("Не знайдено технічний рахунок для " || colNls || "/" || dfLcv,
     "Увага!", MB_IconExclamation )
.head 11 -  Return VALIDATE_Cancel
.head 9 +  Else If SalStrLeftX(colTip, 2) = 'W4'
.head 10 -  Set colCardAcc = 'WAY4'
.head 9 +  Else
.head 10 -  Call SalMessageBox("Вказано не картковий рахунок " || colNls || "/" || dfLcv,
     "Увага!", MB_IconExclamation )
.head 10 -  Return VALIDATE_Cancel
.head 8 +  Else
.head 9 -  Set colCardAcc = ''
.head 9 -  Set colNms = ''
.head 9 -  Set colTip = ''
.head 8 -  Return VALIDATE_Ok
.head 5 +  Column: colNms
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Назва рахунку
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  3.6"
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
.head 5 +  Column: colTip
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Tip
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
.head 5 +  Column: colAcc
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
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
.head 5 +  Column: colOkpo
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
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
.head 4 +  Functions
.head 5 +  Function: checkSum
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 7 -  Number: nCountAcc
.head 7 -  Number: nSum
.head 6 +  Actions
.head 7 -  Set nCountAcc = 0
.head 7 -  Set nSum = 0
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, ROW_Edited, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 -  If SalIsNull(colCardAcc) and SalIsNull(colS)
.head 8 +  Else If not SalIsNull(colCardAcc) and not SalIsNull(colS) and colS > 0
.head 9 -  Set nSum = nSum + colS
.head 9 -  Set nCountAcc = nCountAcc + 1
.head 9 -  Call XSalTblSetCellBackColor(colCardAcc, COLOR_White)
.head 9 -  Call XSalTblSetCellBackColor(colS, COLOR_White)
.head 8 +  Else
.head 9 -  Call XSalTblSetCellBackColor(colCardAcc, SalColorFromRGB(250, 170, 170))
.head 9 -  Call XSalTblSetCellBackColor(colS, SalColorFromRGB(250, 170, 170))
.head 7 -  Set dfSum = nSum
.head 7 -  Set dfCountAcc = nCountAcc
.head 7 -  Return TRUE
.head 5 +  Function: payOper
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Boolean: bError
.head 7 -  String: sError
.head 7 -  !
.head 7 -  : ccDoc
.head 8 -  Class: cDoc
.head 7 -  String: sTt
.head 7 -  Number: nDk
.head 7 -  String: sNlsT	! Транзитный счет
.head 7 -  String: sNlsK	! Карточный счет 2625
.head 7 -  String: sPlat	! Наим. плательщика (транзит)
.head 7 -  String: sPolu	! Наим. получателя (карт. счет)
.head 7 -  String: sOkpoA	! ОКПО плательщика (транзит)
.head 7 -  String: sOkpoB	! ОКПО получателя (карт. счет)
.head 7 -  String: sNazn	! Назначение платежа
.head 7 -  Number: nS	! Сумма
.head 7 -  !
.head 7 -  Date/Time: dValDate
.head 7 -  String: sBankMfo
.head 7 -  Number: nVob
.head 7 -  Number: nRef
.head 7 -  !
.head 7 -  Number: nRow
.head 6 +  Actions
.head 7 +  If SalIsNull(dfTt)
.head 8 -  Call SalMessageBox('Не задано операцію для оплати!', 'Увага!', MB_IconExclamation | MB_Ok)
.head 8 -  Call SalSetFocus(cmbTt)
.head 8 -  Return FALSE
.head 7 +  If SalIsNull(dfTransitNls)
.head 8 -  Call SalMessageBox('Не задано транзитний рахунок!', "Увага!", MB_IconExclamation | MB_Ok)
.head 8 -  Call SalSetFocus(dfTransitNls)
.head 8 -  Return FALSE
.head 7 +  If SalIsNull(dfNazn)
.head 8 -  Call SalMessageBox('Не задано призначення платежу!', "Увага!", MB_IconExclamation | MB_Ok)
.head 8 -  Call SalSetFocus(dfNazn)
.head 8 -  Return FALSE
.head 7 +  If SalIsNull(dfZB)
.head 8 -  Call SalMessageBox('Не задано Позабалансовий символ!', "Увага!", MB_IconExclamation | MB_Ok)
.head 8 -  Call SalSetFocus(dfZB)
.head 8 -  Return FALSE
.head 7 -  Call checkSum()
.head 7 +  If SalIsNull(dfCountAcc) or dfSum = 0
.head 8 -  Call SalMessageBox('Немає документів для оплати!', "Увага!", MB_IconExclamation | MB_Ok)
.head 8 -  Return FALSE
.head 7 +  If SalMessageBox("Оплатити " || Str(dfCountAcc) || " документів на " || Str(dfSum) || " " || dfLcv || "?", 
   "Увага!", MB_IconQuestion | MB_YesNo) = IDNO
.head 8 -  Return FALSE
.head 7 -  Set bError = FALSE
.head 7 -  Set sError = ''
.head 7 -  ! -- Инициализация переменных
.head 7 -  Set sTt   = dfTt
.head 7 -  Set nDk   = 1
.head 7 -  Set sNlsT = dfTransitNls
.head 7 -  Set sPlat = dfTransitNms
.head 7 -  Set sNazn = dfNazn
.head 7 -  ! -- Дата валютирования
.head 7 -  Set dValDate = GetBankDate()
.head 7 -  ! -- МФО
.head 7 -  Set sBankMfo = GetBankMfo()
.head 7 -  ! -- Мем. ордер
.head 7 -  Set nVob = 6
.head 7 -  ! -- ОКПО-А
.head 7 -  Call SqlPrepareAndExecute(hSql(), 
"select c.okpo into :sOkpoA
   from accounts a, customer c
  where a.rnk = c.rnk and a.acc = :nTransitAcc")
.head 7 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 7 -  !
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, ROW_Edited, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 +  If not SalIsNull(colNls) and colS > 0
.head 9 -  ! -- Счет
.head 9 -  Set sNlsK = colNls
.head 9 -  Set sPolu = colNms
.head 9 -  Set sOkpoB = colOkpo
.head 9 -  ! -- Сумма
.head 9 -  Set nS = colS * SalNumberPower(10, nDig)
.head 9 -  ! -- Оплата
.head 9 -  Call ccDoc.SetDoc(0, sTt, nDk, nVob, '',
     dValDate, dValDate, dValDate, dValDate,
     sNlsT, sPlat, sBankMfo, '', nKv, nS, sOkpoA,
     sNlsK, sPolu, sBankMfo, '', nKv, nS, sOkpoB,
     sNazn, '', GetIdOper(), '', NUMBER_Null, 0)
.head 9 +  If not ccDoc.oDoc()
.head 10 -  Set bError = TRUE
.head 10 -  Set sError = 'Неуспішна оплата документа.'
.head 10 -  Break
.head 9 -  ! -- Вставка доп. реквизитов если есть
.head 9 -  Set nRef = ccDoc.m_nRef
.head 9 +  If SalStrLeftX(colTip, 2) = 'PK'
.head 10 +  If not SqlPrepareAndExecute(hSqlAux(), 
"insert into operw (ref, tag, value) 
 values (:nRef, 'CDAC', :colCardAcc)")
.head 11 -  Set bError = TRUE
.head 11 -  Set sError = 'Неуспішне виконання процедури додання дод. реквизиту CDAC'
.head 11 -  Break
.head 9 +  If not SqlPrepareAndExecute(hSql(), 
"insert into operw (ref, tag, value) 
 values (:nRef, 'SK_ZB', :dfZB)")
.head 10 -  Set bError = TRUE
.head 10 -  Set sError = 'Неуспішне виконання процедури додовання дод. реквизиту SK_ZB'
.head 10 -  Break
.head 7 -  !
.head 7 +  If not bError
.head 8 -  Call SqlCommitEx(hSql(), "OBPC. Оплачено " || Str(dfCountAcc) || " документів на " || Str(dfSum) || " " || dfLcv)
.head 8 -  Call SalMessageBox("Оплачено " || Str(dfCountAcc) || " документів на " || Str(dfSum) || " " || dfLcv, 
     "Інформація", MB_IconAsterisk)
.head 7 +  Else
.head 8 -  Call SqlRollbackEx(hSql(), "OBPC. " || sError)
.head 7 -  !
.head 7 -  Return not bError
.head 5 +  Function: DecPoint      ! Корректировка символа "десятичной точки"
.head 6 -  Description:
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  Window Handle: hWnd
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sTmp
.head 6 +  Actions
.head 7 -  Set sTmp = SalStrRepeatX(' ', 20)
.head 7 -  Call SalGetWindowText(hWnd, sTmp, 20)
.head 7 +  While SalStrScan(sTmp, sDecimal2) > 0
.head 8 -  Set sTmp = SalStrReplaceX(sTmp, SalStrScan(sTmp,sDecimal2), 1, sDecimal)
.head 7 -  Call SalFmtStrToField(hWnd, sTmp, TRUE)
.head 7 -  Return TRUE
.head 5 +  Function: PrintData
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sFileName
.head 7 -  File Handle: hF
.head 7 -  Number: nRow
.head 6 +  Actions
.head 7 -  ! Set sFileName = GetPrnDir() || '\\' || 'PK_' || 
    SalStrRightX(SalStrRepeatX('0', 4) || Str(SalDateYear(SalDateCurrent())), 4)  || 
    SalStrRightX(SalStrRepeatX('0', 2) || Str(SalDateMonth(SalDateCurrent())), 2) || 
    SalStrRightX(SalStrRepeatX('0', 2) || Str(SalDateDay(SalDateCurrent())), 2) || 
    SalStrRightX(SalStrRepeatX('0', 2) || Str(SalDateHour(SalDateCurrent())), 2) || 
    SalStrRightX(SalStrRepeatX('0', 2) || Str(SalDateMinute(SalDateCurrent())), 2) || 
    SalStrRightX(SalStrRepeatX('0', 2) || Str(SalDateSecond(SalDateCurrent())), 2)
.head 7 -  Set sFileName = GetPrnDir() || '\\' || 'PK_' || 
    SalStrRightX(SalStrRepeatX('0', 2) || Str(SalDateMonth(SalDateCurrent())), 2) || 
    SalStrRightX(SalStrRepeatX('0', 2) || Str(SalDateDay(SalDateCurrent())), 2) || 
    SalStrRightX(SalStrRepeatX('0', 2) || Str(SalDateHour(SalDateCurrent())), 2) || 
    SalStrRightX(SalStrRepeatX('0', 2) || Str(SalDateMinute(SalDateCurrent())), 2)
.head 7 +  If not SalFileOpen(hF, sFileName, OF_Write | OF_Text)
.head 8 -  Call SalMessageBox('Неможливо відкрити файл ' || sFileName, 'Ошибка!', MB_IconStop | MB_Ok)
.head 8 -  Return FALSE
.head 7 -  Call SalFilePutStr(hF, SalFmtFormatDateTime(SalDateCurrent(), 'dd.MM.yyyy hhhh:mm:ss'))
.head 7 -  Call SalFilePutStr(hF, '')
.head 7 -  Call SalFilePutStr(hF, 'Операція: ' || cmbTt)
.head 7 -  Call SalFilePutStr(hF, 'Транзитний рахунок:  ' || dfTransitNls || ' ' || dfLcv || ' ' || dfTransitNms)
.head 7 -  Call SalFilePutStr(hF, 'Призначення платежу: ' || dfNazn)
.head 7 -  Call SalFilePutStr(hF, '')
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 -  Call SalFilePutStr(hF, 
     IifS(colNls='', '', PadR(colNls, 14) || ' ') || 
     PadL(SalNumberToStrX(colS,2), 16) || ' ' || 
     IifS(colNms='', '', PadR(colNms, 38) || ' '))
.head 7 -  Call SalFilePutStr(hF, '')
.head 7 -  Call SalFilePutStr(hF, 'Рахунків всього: ' || Str(dfCountAcc))
.head 7 -  Call SalFilePutStr(hF, 'Сума           : ' || SalNumberToStrX(dfSum,2))
.head 7 -  Call SalFileClose(hF)
.head 7 -  Call SalMessageBox('Інформацію збережео в файл ' || sFileName, 'Ошибка!', MB_IconAsterisk | MB_Ok)
.head 7 -  Return TRUE
.head 4 +  Window Variables
.head 5 -  Number: nRow
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 +  If nMode = 1
.head 7 -  Call SalTblSetColumnPos(colNls, 1)
.head 7 -  Call SalTblSetColumnPos(colCardAcc, 3)
.head 7 -  Call SalEnableWindow(colNls)
.head 7 -  Call SalDisableWindow(colCardAcc)
.head 6 -  Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
.head 6 -  Call SalTblSetContext(hWndForm, nRow)
.head 6 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 5 +  On UM_Clear
.head 6 +  If not SalTblAnyRows(hWndForm, 0, 0)
.head 7 -  Call SalSendMsg(hWndForm, UM_Insert, 0, 0)
.head 6 +  Else
.head 7 +  If nMode = 0
.head 8 -  Call SalTblSetFocusCell(hWndForm, nRow, colCardAcc, 0, 1)
.head 7 +  Else
.head 8 -  Call SalTblSetFocusCell(hWndForm, nRow, colNls, 0, 1)
.head 5 +  On SAM_EndCellTab
.head 6 -  Call SalSendMsg(hWndForm, UM_Insert, 0, 0)
.head 6 -  Return TRUE
.head 5 +  On UM_Insert
.head 6 -  Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
.head 6 -  Call SalTblSetContext(hWndForm, nRow)
.head 6 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 6 +  If nMode = 0
.head 7 -  Call SalTblSetFocusCell(hWndForm, nRow, colCardAcc, 0, 1)
.head 6 +  Else
.head 7 -  Call SalTblSetFocusCell(hWndForm, nRow, colNls, 0, 1)
.head 3 -  !
.head 3 -  Background Text: Рахунків всього:
.head 4 -  Resource Id: 16720
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    5.45"
.head 5 -  Width:  2.1"
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
.head 3 +  Data Field: dfCountAcc
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
.head 6 -  Left:   2.4"
.head 6 -  Top:    5.4"
.head 6 -  Width:  1.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Сума
.head 4 -  Resource Id: 16721
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    5.75"
.head 5 -  Width:  2.1"
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
.head 3 +  Data Field: dfSum
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
.head 6 -  Left:   2.4"
.head 6 -  Top:    5.7"
.head 6 -  Width:  1.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Decimal
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Frame
.head 4 -  Resource Id: 16722
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    6.15"
.head 5 -  Width:  9.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.75"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: Default
.head 3 +  Pushbutton: pbCheck
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbDetail
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Перерахувати
.head 4 -  Window Location and Size
.head 5 -  Left:   2.4"
.head 5 -  Top:    6.3"
.head 5 -  Width:  1.6"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\SUMM.BMP
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call tblCard.checkSum()
.head 3 +  Pushbutton: pbRefresh
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbRefresh
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Очистити
.head 4 -  Window Location and Size
.head 5 -  Left:   4.2"
.head 5 -  Top:    6.3"
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
.head 6 -  Set bPay = FALSE
.head 6 -  Call SalDisableWindow(pbPrint)
.head 6 -  Call SalTblReset(tblCard)
.head 6 -  Call SalEnableWindow(tblCard.colCardAcc)
.head 6 -  Call SalEnableWindow(tblCard.colNls)
.head 6 -  Call SalEnableWindow(tblCard.colS)
.head 6 -  Call SalSendMsg(tblCard, UM_Clear, 0, 0)
.head 6 -  Set dfCountAcc = 0
.head 6 -  Set dfSum = 0
.head 3 +  Pushbutton: pbPrint
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbPrint
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Друк
.head 4 -  Window Location and Size
.head 5 -  Left:   5.4"
.head 5 -  Top:    6.3"
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
.head 6 -  Call tblCard.PrintData()
.head 3 +  Pushbutton: pbPay
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbExecute
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Оплатити
.head 4 -  Window Location and Size
.head 5 -  Left:   6.6"
.head 5 -  Top:    6.3"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: F10
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
.head 6 +  If not bPay
.head 7 +  If tblCard.payOper()
.head 8 -  Set bPay = TRUE
.head 8 -  Call SalEnableWindow(pbPrint)
.head 8 -  Call SalDisableWindow(tblCard.colCardAcc)
.head 8 -  Call SalDisableWindow(tblCard.colNls)
.head 8 -  Call SalDisableWindow(tblCard.colS)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Відмінити
.head 4 -  Window Location and Size
.head 5 -  Left:   7.8"
.head 5 -  Top:    6.3"
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
.head 6 -  Call SalDestroyWindow(hWndForm)
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  String: sParTt	! PKR - зачисление на карт. счет
.head 3 -  Number: nMode	! Режим ввода: 0-по техн.счету, 1-по карт.счету
.head 2 +  Window Variables
.head 3 -  Number: nBaseVal
.head 3 -  Number: nKv
.head 3 -  Boolean: bPay
.head 3 -  Number: nDig
.head 3 -  String: sDecimal   ! симв десятичной точки
.head 3 -  String: sDecimal2  ! симв десятичной точки alt
.head 3 -  String: sPK
.head 3 -  String: sSem
.head 3 -  String: sTmp
.head 3 -  Number: nTransitAcc
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Call SalMapEnterToTab(TRUE)
.head 4 -  !
.head 4 -  Set nBaseVal = GetBaseVal()
.head 4 -  Set dfLcv    = Str(nBaseVal)
.head 4 -  Call SalSendMsg(dfLcv, SAM_Validate, 0, 0)
.head 4 -  Set bPay = FALSE
.head 4 -  !
.head 4 -  Set sDecimal = SalStrMidX(SalNumberToStrX(1.1,1),1,1)
.head 4 +  If sDecimal = '.'
.head 5 -  Set sDecimal2 = ','
.head 4 +  Else
.head 5 -  Set sDecimal2 = '.'
.head 4 -  !
.head 4 -  Set dfCountAcc = 0
.head 4 -  Set dfSum = 0
.head 4 -  Call SalDisableWindow(pbPrint)
.head 3 +  On SAM_CreateComplete
.head 4 +  If dfZB
.head 5 -  Call cmbZB.SetSelectById(dfZB)
.head 3 +  On SAM_Destroy
.head 4 -  Call SalMapEnterToTab(FALSE)
.head 1 +  Table Window: tblObpcPkkque
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Ручне коректування документів для ПЦ
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
.head 4 -  Width:  16.0"
.head 4 -  Width Editable? Class Default
.head 4 -  Height: 8.4"
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
.head 2 -  Description: Ручне коректування документів для ПЦ
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
.head 5 -  Resource Id: 22624
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  5.167"
.head 6 -  Begin Y:  -0.024"
.head 6 -  End X:  5.167"
.head 6 -  End Y:  0.44"
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
.head 5 -  Resource Id: 33367
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  3.433"
.head 6 -  Begin Y:  0.012"
.head 6 -  End X:  3.433"
.head 6 -  End Y:  0.476"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 +  Pushbutton: pbDoc
.head 5 -  Class Child Ref Key: 39
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.533"
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
.head 7 -  Set strTip = 'Перегляд документу'
.head 4 +  Pushbutton: pbAccCard
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbOk
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.967"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\BOOK.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Перегляд картки рахунку'
.head 6 +  On SAM_Click
.head 7 +  If colDocType = 1
.head 8 +  If SqlPrepareAndExecute(hSql(), 
"select acc, rnk into :nAcc, :nRnk
   from accounts
  where nls = :hWndForm.tblObpcPkkque.colNls 
    and kv  = :hWndForm.tblObpcPkkque.colKv")
and SqlFetchNext(hSql(), nFetchRes)
.head 9 -  Call OperWithAccountEx(AVIEW_ALL, nAcc, nRnk, ACCESS_FULL, hWndForm, '')
.head 4 -  Line
.head 5 -  Resource Id: 22625
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  4.5"
.head 6 -  Begin Y:  -0.024"
.head 6 -  End X:  4.5"
.head 6 -  End Y:  0.44"
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 +  Pushbutton: pbUnForm
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbSynchro
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.633"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\BACK.BMP
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = "Зняти відмітку про відправку"
.head 6 +  On SAM_Click
.head 7 -  Call UnForm()
.head 4 -  Line
.head 5 -  Resource Id: 22626
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
.head 4 +  Pushbutton: pbExit
.head 5 -  Class Child Ref Key: 42
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   5.317"
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
.head 2 +  Contents
.head 3 +  Column: colStatus
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Стан
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Center
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
.head 3 +  Column: colCardAcct
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Технічний
рахунок
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: 10
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.4"
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
.head 6 -  Set sTmp = colCardAcct
.head 5 +  On SAM_AnyEdit
.head 6 +  If colFileName or colDocType = 2
.head 7 -  Set colCardAcct = sTmp
.head 7 -  Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
.head 3 +  Column: colFileName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ім'я
файлу
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.4"
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
.head 3 +  Column: colFileDate
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
файлу
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.8"
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
.head 3 +  Column: colRef
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Реф.

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
.head 3 +  Column: colTt
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
оп.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Center
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
.head 3 +  Column: colVdat
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
валютування.
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
.head 3 +  Column: colDk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Д/К
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Center
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
.head 3 +  Column: colNls
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Картковий
рахунок
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
.head 6 -  Set sTmp = colNls
.head 5 +  On SAM_AnyEdit
.head 6 -  Set colNls = sTmp
.head 6 -  Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
.head 3 +  Column: colS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сума
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  Default
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
.head 3 +  Column: colKv
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
.head 3 +  Column: colLcv
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вал
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Center
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
.head 3 +  Column: colNms
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Назва
карткового рахунку
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
.head 3 +  Column: colNlsb
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Рахунок-Б
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
.head 6 -  Set sTmp = colNlsb
.head 5 +  On SAM_AnyEdit
.head 6 -  Set colNlsb = sTmp
.head 6 -  Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
.head 3 +  Column: colNmsb
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Назва
рахунку-Б
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
.head 3 +  Column: colNazn
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Призначення
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
.head 3 +  Column: colUserid
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
корист.
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
.head 3 +  Column: colDatd
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
документу
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
.head 3 +  Column: colSos
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: SOS
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
.head 3 +  Column: colDocType
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: DocType
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
.head 2 +  Functions
.head 3 +  Function: UnForm
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nRow
.head 5 -  Boolean: bError
.head 4 +  Actions
.head 5 +  If SalMessageBox("Зняти відмітку про відправку по вибраним документам?" || PutCrLf() ||
   "Документи відправляться в ПЦ повторно!", "Увага!", MB_IconQuestion | MB_YesNo) = IDYES
.head 6 -  Set bError = FALSE
.head 6 -  Set nRow = TBL_MinRow
.head 6 +  While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
.head 7 -  Call SalTblSetContext(hWndForm, nRow)
.head 7 +  If not SqlPLSQLCommand(hSql(), "obpc.set_unform_flag(hWndForm.tblObpcPkkque.colDocType, hWndForm.tblObpcPkkque.colRef, hWndForm.tblObpcPkkque.colDk)")
.head 8 -  Set bError = TRUE
.head 8 -  Break
.head 7 +  Else
.head 8 -  Call SaveInfoToLog("OBPC. Снята отметка об отправке док." || Str(colRef))
.head 6 +  If bError
.head 7 -  Call SqlRollbackEx(hSql(), "OBPC. Ошибка при попытке снять отметку об отправке док.")
.head 6 +  Else
.head 7 -  Call SqlCommitEx(hSql(), "OBPC. Успешно снята отметка об отправке док.")
.head 6 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 5 -  Return TRUE
.head 2 +  Window Parameters
.head 3 -  String: sPar
.head 2 +  Window Variables
.head 3 -  Number: nCount
.head 3 -  Number: nAcc
.head 3 -  Number: nRnk
.head 3 -  String: sTmp
.head 3 -  Number: nRow
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Set hWndForm.tblObpcPkkque.nFlags = GT_NoIns | GT_NoDel
.head 4 -  Set hWndForm.tblObpcPkkque.fFilterAtStart = TRUE
.head 4 -  Set hWndForm.tblObpcPkkque.strPrintFileName = "pkk_status"
.head 4 -  Set hWndForm.tblObpcPkkque.strFilterTblName = "v_obpc_pkkque"
.head 4 -  Set hWndForm.tblObpcPkkque.strSqlPopulate = 
"select doc_type, status, card_acct, f_n, f_d, ref, tt, vdat, datd,
        s/100, kv, lcv, dk, card_nls, card_nms, nlsb, namb, nazn, userid, sos
   into :hWndForm.tblObpcPkkque.colDocType, :hWndForm.tblObpcPkkque.colStatus, :hWndForm.tblObpcPkkque.colCardAcct,
        :hWndForm.tblObpcPkkque.colFileName, :hWndForm.tblObpcPkkque.colFileDate,
        :hWndForm.tblObpcPkkque.colRef,  :hWndForm.tblObpcPkkque.colTt,
        :hWndForm.tblObpcPkkque.colVdat, :hWndForm.tblObpcPkkque.colDatd, 
        :hWndForm.tblObpcPkkque.colS,    :hWndForm.tblObpcPkkque.colKv,
        :hWndForm.tblObpcPkkque.colLcv,  :hWndForm.tblObpcPkkque.colDk,
        :hWndForm.tblObpcPkkque.colNls,  :hWndForm.tblObpcPkkque.colNms,
        :hWndForm.tblObpcPkkque.colNlsb, :hWndForm.tblObpcPkkque.colNmsb,
        :hWndForm.tblObpcPkkque.colNazn, :hWndForm.tblObpcPkkque.colUserid, :hWndForm.tblObpcPkkque.colSos
   from v_obpc_pkkque
  order by status, ref, dk"
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On UM_Populate
.head 4 -  Set nCount = 0
.head 4 -  Call SalSendClassMessage(UM_Populate, 0, 0)
.head 4 -  Call SalTblDefineSplitWindow(hWndForm, 1, TRUE)
.head 4 -  Set nRow = SalTblInsertRow(hWndForm, TBL_MinRow)
.head 4 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 4 -  Call SalTblSetContext(hWndForm, nRow)
.head 4 -  Set colFileName  = 'Док. всього:'
.head 4 -  Set colRef  = nCount
.head 3 +  On SAM_FetchRowDone
.head 4 -  Set nCount = nCount + 1
.head 4 +  If colDocType = 2
.head 5 -  Call XSalTblSetRowBackColor(hWndForm, lParam, SalColorFromRGB(230,255,255)) ! голубой
.head 4 +  Else If colSos > 0 and colSos < 5
.head 5 -  Call VisTblSetRowColor(hWndForm, lParam, COLOR_DarkGreen)
.head 3 +  On UM_Update
.head 4 -  Set nRow = TBL_MinRow
.head 4 +  While SalTblFindNextRow(hWndForm, nRow, ROW_Edited, 0)
.head 5 -  Call SalTblSetContext(hWndForm, nRow)
.head 5 +  If colDocType = 1
.head 6 +  If SqlPLSQLCommand(hSql(), "obpc.set_doc_cardacct(colRef, colDk, colCardAcct)")
.head 7 -  Call SqlCommitEx(hSql(), "OBPC. Установлен тех.счет для Реф.№" || Str(colRef))
.head 6 +  Else
.head 7 -  Call SqlRollbackEx(hSql(), "OBPC. Ошибка установки тех.счета для Реф.№" || Str(colRef))
.head 4 -  Call SalSendClassMessage(UM_Populate, 0, 0)
.head 3 +  On SAM_DoubleClick
.head 4 +  If colDocType
.head 5 -  ! 1-DOC_EXTERNAL, 2-DOC_INTERNAL, 0-DB_SRC_ACTIVE
.head 5 +  If colDocType = 1
.head 6 -  Call DocView(hWndMDI, hWndForm.tblObpcPkkque.colRef, 2, 0, '')
.head 5 +  Else
.head 6 -  Call DocView(hWndMDI, hWndForm.tblObpcPkkque.colRef, 1, 0, '')
.head 3 +  On SAM_RowHeaderClick
.head 4 +  If colRef
.head 5 +  If colStatus = 'О'
.head 6 -  Set sTmp = 'Відправлений'
.head 5 +  Else If colStatus = 'Н'
.head 6 -  Set sTmp = 'Невідправлений'
.head 5 +  If colDocType = 2
.head 6 -  Set sTmp = sTmp || IifS(sTmp="", "", ", ") || "Інформаційний"
.head 5 +  Else If colSos > 0 and colSos < 5
.head 6 -  Set sTmp = sTmp || IifS(sTmp="", "", ", ") || "Незавізований"
.head 5 -  Call XSalTooltipSetColors(COLOR_Black, COLOR_LightGray)
.head 5 -  Call XSalTooltipShow(hWndForm, sTmp)
.head 5 -  Call XSalTooltipSetColors(COLOR_Black, COLOR_White)
.head 1 +  Dialog Box: dlgStatus
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
.head 4 -  Left:   4.638"
.head 4 -  Top:    3.771"
.head 4 -  Width:  7.0"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 3.3"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? No
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Форма показа статуса
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
.head 3 +  Multiline Field: mlMessage
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 100000
.head 5 -  String Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Border? Yes
.head 5 -  Word Wrap? Yes
.head 5 -  Vertical Scroll? Yes
.head 5 -  Window Location and Size
.head 6 -  Left:   0.0"
.head 6 -  Top:    0.0"
.head 6 -  Width:  6.95"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 3.0"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_ContextMenu
.head 6 -  Set sStatusText = mlMessage
.head 6 -  Call SalTrackPopupMenu(hWndForm, "pmStatusPrint", TPM_CursorX | TPM_CursorY , 0, 0)
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  String: sMessage
.head 3 -  String: sTitle
.head 2 -  Window Variables
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Call SalSetWindowText(hWndForm, sTitle)
.head 4 -  Set mlMessage = sMessage
.head 1 +  Form Window: frmCard
.head 2 -  Class: cQuickTabsForm
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Нова угода
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? No
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
.head 4 -  Width:  9.35"
.head 4 -  Width Editable? Class Default
.head 4 -  Height: 6.6"
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
.head 4 -  Size: 0.4"
.head 4 -  Size Editable? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 3 +  Contents
.head 4 +  Pushbutton: pbNew	! Нова картка
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbInsert
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.15"
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
.head 7 -  Set strTip = 'Нова картка'
.head 6 +  On SAM_Click
.head 7 -  Call SalSetWindowText(hWndForm, "Нова угода")
.head 7 -  Call SetButton(1)
.head 7 -  Call picTabs.BringToTop(0, TRUE)
.head 4 +  Pushbutton: pbCopy	! Копія картки
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbInsert
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.583"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\COPY.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Копія картки'
.head 6 +  On SAM_Click
.head 7 -  Call SalSetWindowText(hWndForm, "Нова угода (копія, " || IifS(nCType=1, "фізична особа", "юридична особа") || ")")
.head 7 -  Call SetButton(2)
.head 7 -  Call picTabs.BringToTop(0, TRUE)
.head 4 -  Line
.head 5 -  Resource Id: 60123
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  1.117"
.head 6 -  Begin Y:  0.0"
.head 6 -  End X:  1.117"
.head 6 -  End Y:  0.476"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: Default
.head 4 +  Pushbutton: pbShowAcc	! Рахунки угоди
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbChilds
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.25"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\BOOK.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Рахунки угоди'
.head 6 +  On SAM_Click
.head 7 -  Call ShowAccList(nRnk, AVIEW_CUST, AVIEW_Financial | AVIEW_ExistOnly, 
"    a.acc in (
 select acc_pk   from bpk_acc where nd = " || Str(nNd) || "
 union
 select acc_ovr  from bpk_acc where nd = " || Str(nNd) || "
 union
 select acc_tovr from bpk_acc where nd = " || Str(nNd) || "
 union
 select acc_3570 from bpk_acc where nd = " || Str(nNd) || "
 union
 select acc_2208 from bpk_acc where nd = " || Str(nNd) || "
 union
 select acc_9129 from bpk_acc where nd = " || Str(nNd) || ")")
.head 4 +  Pushbutton: pbPrint	! Друк договорів
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbPrint
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.7"
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
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Друк договорів'
.head 6 +  On SAM_Click
.head 7 -  Call PrintDoc()
.head 4 -  Line
.head 5 -  Resource Id: 60124
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  2.25"
.head 6 -  Begin Y:  0.036"
.head 6 -  End X:  2.25"
.head 6 -  End Y:  0.512"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: Default
.head 4 +  Pushbutton: pbOpen	! Зареєструвати картку
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbOk
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.367"
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
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Зареєструвати картку'
.head 6 +  On SAM_Click
.head 7 +  If OpenCard()
.head 8 -  Call SetButton(0)
.head 4 -  Line
.head 5 -  Resource Id: 60125
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  2.9"
.head 6 -  Begin Y:  -0.012"
.head 6 -  End X:  2.9"
.head 6 -  End Y:  0.464"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: Default
.head 4 +  Pushbutton: pbCancel	! Вийти
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbCancel
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.0"
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
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Вийти'
.head 6 +  On SAM_Click
.head 7 -  Call SalDestroyWindow(hWndForm)
.head 2 +  Contents
.head 3 +  Picture: picTabs
.data CLASSPROPS
0000: 546162546F704D61 7267696E00020030 0000546162466F72 6D50616765730028
0020: 00646C6743617264 436C69656E740964 6C67436172644361 726409646C674361
0040: 726444656D616E64 0000546162447261 775374796C65000B 0057696E39355374
0060: 796C650000546162 52696768744D6172 67696E0002003000 005461624E616D65
0080: 73001F0043617264 436C69656E740943 6172644361726409 4361726444656D61
00A0: 6E6400005461624C 6162656C73001500 CAEBB3BAEDF209CA E0F0F2EAE0094465
00C0: 6D616E6400005461 6250616765436F75 6E74000200310000 546162426F74746F
00E0: 6D4D617267696E00 0200300000546162 43757272656E7400 0B0043617264436C
0100: 69656E7400005461 624C6566744D6172 67696E0002003000 005461624F726965
0120: 6E746174696F6E00 0100000000000000 0000000000000000 0000000000000000
0140: 0000
.enddata
.data CLASSPROPSSIZE
0000: 4201
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 1
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cQuickTabsForm
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.05"
.head 5 -  Width:  9.0"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 5.7"
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
.head 4 -  Tile To Parent? Class Default
.head 4 -  Border Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalSendClassMessage(SAM_Create, wParam, lParam)
.head 6 -  ! Инициализация закладок
.head 6 -  Call picTabs.InitializeFormPages(
     SalNumberToStrX(0,0) || ';' ||
     Str(SalWindowHandleToNumber(hWndForm)))
.head 6 -  Call picTabs.BringToTop(2, TRUE)
.head 6 -  Call picTabs.BringToTop(1, TRUE)
.head 6 -  Call picTabs.BringToTop(0, TRUE)
.head 6 -  Set fActivate = TRUE
.head 5 +  On TABSM_TabActivateStart
.head 6 +  If fActivate
.head 7 -  Call GetName(wParam, sTabName)
.head 7 +  If sTabName = 'CardClient'
.head 8 +  If not bCardOpen
.head 9 -  Call SalSetFocus(hWndTabClient.dlgCardClient.dfOkpo)
.head 7 +  If sTabName = 'CardCard'
.head 8 +  If not nCType or bCardOpen
.head 9 -  Call SalSendMsg(hWndTabCard, SAM_DoInit, 0, 0)
.head 8 +  Else If (nCType and not bCardOpen) or bCardCopy
.head 9 -  Call SalSendMsg(hWndTabCard, SAM_DoInit, 2, 0)
.head 7 +  If sTabName = 'CardDemand'
.head 8 +  If not bCardOpen
.head 9 -  ! если сменился клиент, нужно перечитать имена
.head 9 +  If nClientRnk != nDemandRnk
.head 10 -  Set hWndTabDemand.dlgCardDemand.dfDmName  = sNmkV
.head 10 -  Set hWndTabDemand.dlgCardDemand.dfDmMName = sMName
.head 10 -  Set hWndTabDemand.dlgCardDemand.dfWork    = sWork
.head 10 -  Set hWndTabDemand.dlgCardDemand.dfOffice  = sOffice
.head 10 -  Set hWndTabDemand.dlgCardDemand.dfWCntry  = 'Україна' 
.head 10 -  Set nDemandRnk = nClientRnk
.head 9 +  Else
.head 10 +  If hWndTabDemand.dlgCardDemand.dfDmName  = ''
.head 11 -  Set hWndTabDemand.dlgCardDemand.dfDmName = sNmkV
.head 10 +  If hWndTabDemand.dlgCardDemand.dfDmMName = ''
.head 11 -  Set hWndTabDemand.dlgCardDemand.dfDmMName = sMName
.head 10 +  If hWndTabDemand.dlgCardDemand.dfWork = ''
.head 11 -  Set hWndTabDemand.dlgCardDemand.dfWork = sWork
.head 10 +  If hWndTabDemand.dlgCardDemand.dfOffice = ''
.head 11 -  Set hWndTabDemand.dlgCardDemand.dfOffice = sOffice
.head 10 +  If hWndTabDemand.dlgCardDemand.dfWCntry = ''
.head 11 -  Set hWndTabDemand.dlgCardDemand.dfWCntry = 'Україна'
.head 10 +  If hWndTabDemand.dlgCardDemand.dfFCode = ''
.head 11 -  Call hWndTabDemand.dlgCardDemand.GetFilial(sPCBranch)
.head 9 -  Call SalSetFocus(hWndTabDemand.dlgCardDemand.dfDmName)
.head 2 +  Functions
.head 3 +  Function: check
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If SalIsNull(hWndTabClient.dlgCardClient.dfRnk)
.head 6 -  Call SalMessageBox("Не вказано клієнта!", "Увага!", MB_IconExclamation | MB_Ok)
.head 6 -  Call SetFocus(0, hWndTabClient.dlgCardClient.dfRnk)
.head 6 -  Return FALSE
.head 5 +  If SalIsNull(hWndTabCard.dlgCardCard.dfPCode)
.head 6 -  Call SalMessageBox("Не вибрано продукт БПК!", "Увага!", MB_IconExclamation | MB_Ok)
.head 6 -  Call SetFocus(1, hWndTabCard.dlgCardCard.pbProduct)
.head 6 -  Return FALSE
.head 5 +  If hWndTabDemand.dlgCardDemand.dfDmName = ''
.head 6 -  Set hWndTabDemand.dlgCardDemand.dfDmName = sNmkV
.head 5 +  If SalIsNull(hWndTabDemand.dlgCardDemand.dfDmName)
.head 6 -  Call SalMessageBox("Не заповнено ім'я та прізвище на картці!", "Увага!", MB_IconExclamation | MB_Ok)
.head 6 -  Call SetFocus(2, hWndTabDemand.dlgCardDemand.dfDmName)
.head 6 -  Return FALSE
.head 5 +  If hWndTabDemand.dlgCardDemand.dfDmMName = ''
.head 6 -  Set hWndTabDemand.dlgCardDemand.dfDmMName = sMName
.head 5 +  If SalIsNull(hWndTabDemand.dlgCardDemand.dfDmMName)
.head 6 -  Call SalMessageBox("Не заповнено дівоче прізвище матері!", "Увага!", MB_IconExclamation | MB_Ok)
.head 6 -  Call SetFocus(2, hWndTabDemand.dlgCardDemand.dfDmMName)
.head 6 -  Return FALSE
.head 5 +  If SalIsNull(hWndTabDemand.dlgCardDemand.dfWork)
.head 6 -  Call SalMessageBox("Не заповнено місце роботи!", "Увага!", MB_IconExclamation | MB_Ok)
.head 6 -  Call SetFocus(2, hWndTabDemand.dlgCardDemand.dfWork)
.head 6 -  Return FALSE
.head 5 +  If SalIsNull(hWndTabDemand.dlgCardDemand.dfOffice)
.head 6 -  Call SalMessageBox("Не заповнено посаду!", "Увага!", MB_IconExclamation | MB_Ok)
.head 6 -  Call SetFocus(2, hWndTabDemand.dlgCardDemand.dfOffice)
.head 6 -  Return FALSE
.head 5 +  If SalIsNull(hWndTabDemand.dlgCardDemand.dfFCode)
.head 6 -  Call SalMessageBox("Не вибрано філію!", "Увага!", MB_IconExclamation | MB_Ok)
.head 6 -  Call SetFocus(2, hWndTabDemand.dlgCardDemand.dfFCode)
.head 6 -  Return FALSE
.head 5 -  Set nRnk = hWndTabClient.dlgCardClient.dfRnk
.head 5 -  Set sFio = hWndTabClient.dlgCardClient.dfFio
.head 5 -  Set sNbs = hWndTabCard.dlgCardCard.sNbs
.head 5 -  Set nProductId = hWndTabCard.dlgCardCard.dfPCode
.head 5 -  Set nLimit   = hWndTabCard.dlgCardCard.dfLimit
.head 5 -  Set nKL      = hWndTabCard.dlgCardCard.cbKL
.head 5 -  Set sDmName  = hWndTabDemand.dlgCardDemand.dfDmName
.head 5 -  Set sDmMName = hWndTabDemand.dlgCardDemand.dfDmMName
.head 5 -  Set sWork    = hWndTabDemand.dlgCardDemand.dfWork
.head 5 -  Set sOffice  = hWndTabDemand.dlgCardDemand.dfOffice
.head 5 -  Set sWPhone  = hWndTabDemand.dlgCardDemand.dfWPhone
.head 5 -  Set sWCntry  = hWndTabDemand.dlgCardDemand.dfWCntry
.head 5 -  Set sWPcode  = hWndTabDemand.dlgCardDemand.dfWPcode
.head 5 -  Set sWCity   = hWndTabDemand.dlgCardDemand.dfWCity
.head 5 -  Set sWStreet = hWndTabDemand.dlgCardDemand.dfWStreet
.head 5 -  Set sFilial  = hWndTabDemand.dlgCardDemand.dfFCode
.head 5 -  Set sBranch  = hWndTabDemand.dlgCardDemand.dfBranch
.head 5 -  Set sCardName = hWndTabCard.dlgCardCard.cmbAccType
.head 5 -  Set sCardLcv  = IifS(hWndTabCard.dlgCardCard.rbUAH=TRUE, 'UAH', 'USD')
.head 5 -  Return TRUE
.head 3 +  Function: OpenCard
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Boolean: bRet
.head 4 +  Actions
.head 5 +  If not check()
.head 6 -  Return FALSE
.head 5 +  If SalMessageBox("Відкрити картку " || sCardName || "-" || sCardLcv || " (" ||
   sNbs || ") для " || 
   IifS(nCType=1, "фіз.особи", "юр.особи") || PutCrLf() || sFio || " ?",
   "Увага!", MB_IconQuestion | MB_YesNo) = IDNO
.head 6 -  Return FALSE
.head 5 -  Set bRet = TRUE
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 +  If not SqlPLSQLCommand(hSql(), "bars_bpk.open_card(nRnk, nProductId, sFilial, nLimit*100, nKL, sBranch,
   sDmName, sDmMName, sWork, sOffice, sWPhone, sWCntry, sWPcode, sWCity, sWStreet, nNd)") 
.head 6 -  Call SqlRollbackEx(hSql(), "OBPC. Неуспешное заведение сделки.")
.head 6 -  Set bRet = FALSE
.head 5 +  Else
.head 6 -  Call SqlCommitEx(hSql(), "OBPC. Зарегистрирован новый договор №" || Str(nNd))
.head 6 -  Call SalMessageBox("Зареєстровано нову угоду №" || Str(nNd), "Інформація", MB_IconAsterisk | MB_Ok)
.head 6 -  Set bParentRefresh = TRUE
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  Return bRet
.head 3 +  Function: SetFocus
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nTab
.head 5 -  Window Handle: hWnd
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call picTabs.BringToTop(nTab, TRUE)
.head 5 -  Call SalSetFocus(hWnd)
.head 5 -  Return TRUE
.head 3 +  Function: SetButton
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  ! nPar: =0-после "Открыть", =1-после "Новая карточка", =2-после "Копировать карточку"
.head 5 -  Number: nPar
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Set bCardOpen = FALSE
.head 5 -  Set bCardCopy = FALSE
.head 5 +  If nPar = 0
.head 6 -  Set bCardOpen = TRUE
.head 6 -  Call SalEnableWindow(pbNew)
.head 6 -  Call SalEnableWindow(pbCopy)
.head 6 -  Call SalEnableWindow(pbShowAcc)
.head 6 -  Call SalEnableWindow(pbPrint)
.head 6 -  Call SalDisableWindow(pbOpen)
.head 5 +  Else
.head 6 +  If nPar = 2
.head 7 -  Set bCardCopy = TRUE
.head 6 -  Set nNd     = NUMBER_Null
.head 6 -  Set nCType  = NUMBER_Null
.head 6 -  Set sNmkV   = STRING_Null
.head 6 -  Set sMName  = STRING_Null
.head 6 -  Set sWork   = STRING_Null
.head 6 -  Set sOffice = STRING_Null
.head 6 -  Call SalDisableWindow(pbNew)
.head 6 -  Call SalDisableWindow(pbCopy)
.head 6 -  Call SalDisableWindow(pbShowAcc)
.head 6 -  Call SalDisableWindow(pbPrint)
.head 6 -  Call SalEnableWindow(pbOpen)
.head 5 -  Call SalSendMsg(hWndTabClient, SAM_DoInit, nPar, 0)
.head 5 -  Call SalSendMsg(hWndTabCard,   SAM_DoInit, nPar, 0)
.head 5 -  Call SalSendMsg(hWndTabDemand, SAM_DoInit, nPar, 0)
.head 5 -  Return TRUE
.head 3 +  Function: PrintDoc
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nAcc
.head 5 -  String: sIdDoc
.head 5 -  String: sIdDocCred
.head 5 -  String: sTemplateId
.head 5 -  Long String: sDoc
.head 5 -  : cCnc
.head 6 -  Class: cABSConnect
.head 5 -  : cCnc2
.head 6 -  Class: cABSConnect
.head 4 +  Actions
.head 5 -  ! Выбираем шаблоны по коду продукта
.head 5 +  If not SqlPrepareAndExecute(hSql(),
"select id_doc, id_doc_cred into :sIdDoc, :sIdDocCred
   from bpk_product
  where id = :nProductId")
.head 6 -  Return FALSE
.head 5 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Return FALSE
.head 5 +  If sIdDoc or sIdDocCred
.head 6 -  ! Acc
.head 6 +  If not SqlPrepareAndExecute(hSql(), "select acc_pk into :nAcc from bpk_acc where nd = :nNd")
.head 7 -  Return FALSE
.head 6 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 7 -  Return FALSE
.head 6 -  !
.head 6 +  If not cdoc_SelectDocTemplate("DOC_SCHEME", "ID", "NAME",
" ID in ('" || sIdDoc || "', '" || sIdDocCred || "') ", sTemplateId)
.head 7 -  Return FALSE
.head 6 +  If sTemplateId
.head 7 -  Call XConnectGetParams(cCnc)
.head 7 +  If cCnc.Connect() and cCnc2.Clone(cCnc, TRUE)
.head 8 -  Set sDoc = cdoc_CreateDocFromTemplate(cCnc.hSql(), cCnc2.hSql(), sTemplateId,  nAcc, 0)
.head 8 +  If sDoc
.head 9 -  Call cdoc_ShowDoc(sDoc, TRUE, FALSE)
.head 8 -  Call cCnc.Disconnect()
.head 8 -  Call cCnc2.Disconnect()
.head 5 -  Return TRUE
.head 2 +  Window Parameters
.head 3 -  Window Handle: hWndParent
.head 2 +  Window Variables
.head 3 -  Boolean: bParentRefresh
.head 3 -  Boolean: fActivate
.head 3 -  Boolean: bCardOpen
.head 3 -  Boolean: bCardCopy
.head 3 -  Window Handle: hWndTabClient
.head 3 -  Window Handle: hWndTabCard
.head 3 -  Window Handle: hWndTabDemand
.head 3 -  String: sOurBranch
.head 3 -  String: sBranch
.head 3 -  String: sPCBranch
.head 3 -  Number: nCType
.head 3 -  Number: nCount
.head 3 -  Number: hBtns[*]
.head 3 -  Number: hBtnCustType3
.head 3 -  Number: hBtnCustType2
.head 3 -  Number: hBtnCancel
.head 3 -  String: sTabName
.head 3 -  !
.head 3 -  Number: nNd
.head 3 -  Number: nRnk
.head 3 -  String: sFio
.head 3 -  String: sNbs
.head 3 -  Number: nProductId
.head 3 -  Number: nLimit
.head 3 -  Number: nKL
.head 3 -  String: sFilial
.head 3 -  ! String: sBranch
.head 3 -  String: sDmName
.head 3 -  String: sDmMName
.head 3 -  String: sDmTel
.head 3 -  String: sWork
.head 3 -  String: sOffice
.head 3 -  String: sWPhone
.head 3 -  String: sWCntry
.head 3 -  String: sWPcode
.head 3 -  String: sWCity
.head 3 -  String: sWStreet
.head 3 -  !
.head 3 -  String: sNmkV
.head 3 -  String: sMName
.head 3 -  String: sCardName
.head 3 -  String: sCardLcv
.head 3 -  Number: nClientRnk	!Rnk из закладки "Клиент", нужно для закладки "Demand", чтоб перечитывать имена
.head 3 -  Number: nDemandRnk	!Rnk из закладки "Demand"
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  Set bParentRefresh = FALSE
.head 4 -  Set fActivate = FALSE
.head 4 -  Set bCardOpen = FALSE
.head 4 -  Set bCardCopy = FALSE
.head 4 -  Set nCType    = NUMBER_Null
.head 4 -  !
.head 4 -  Set sOurBranch = GetValueStr("select substr(sys_context('bars_context','user_branch'), 1, 30) from dual")
.head 4 -  ! Для ГРЦ sBranch = 0
.head 4 -  Set sBranch = IifS(sOurBranch='', '0', sOurBranch)
.head 4 -  !
.head 4 -  Call SqlPrepareAndExecute(hSql(), 
"select code into :sPCBranch
   from v_bpk_branch_filiales
  where branch = :sBranch")
.head 4 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 4 -  !
.head 4 -  Call SalDisableWindow(pbNew)
.head 4 -  Call SalDisableWindow(pbCopy)
.head 4 -  Call SalDisableWindow(pbShowAcc)
.head 4 -  Call SalDisableWindow(pbPrint)
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_Destroy
.head 4 +  If bParentRefresh
.head 5 -  Call SalPostMsg(hWndParent, UM_Populate, 0, 0)
.head 1 +  Dialog Box: dlgCardClient
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
.head 4 -  Width:  8.9"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.6"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
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
.head 3 -  Group Box: Клієнт
.head 4 -  Resource Id: 38343
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.05"
.head 5 -  Width:  8.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 5.2"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Picture: pbSearch
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.55"
.head 5 -  Top:    0.202"
.head 5 -  Width:  0.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.3"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  File Name: \BARS98\RESOURCE\BMP\SEARCH.BMP
.head 4 -  Storage: Internal
.head 4 -  Picture Transparent Color: None
.head 4 -  Fit: Scale
.head 4 -  Scaling
.head 5 -  Width:  100
.head 5 -  Height:  100
.head 4 -  Corners: Square
.head 4 -  Border Style: Raised-Shadow
.head 4 -  Border Thickness: 1
.head 4 -  Tile To Parent? No
.head 4 -  Border Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Пошук клієнта')
.head 5 +  On SAM_Click
.head 6 -  ! wParam=1, если ввели ОКПО, а клиентов с таким ОКПО несколько
.head 6 +  If FunNSIGetFiltered('customer', 'rnk', "customer.custtype in (2,3)" || IifS(wParam=1, " and okpo='" || dfOkpo || "'", "") || sCustTypeToSearch, sPK, sSem)
.head 7 -  Set dfRnk = Val(sPK)
.head 7 -  Call SearchCustomer(dfRnk, '')
.head 3 +  Picture: pbNew
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.0"
.head 5 -  Top:    0.202"
.head 5 -  Width:  0.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.3"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  File Name: \BARS98\RESOURCE\BMP\INSERT.BMP
.head 4 -  Storage: Internal
.head 4 -  Picture Transparent Color: None
.head 4 -  Fit: Scale
.head 4 -  Scaling
.head 5 -  Width:  100
.head 5 -  Height:  100
.head 4 -  Corners: Square
.head 4 -  Border Style: Raised-Shadow
.head 4 -  Border Thickness: 1
.head 4 -  Tile To Parent? No
.head 4 -  Border Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Реєстрація нового клієнта')
.head 5 +  On SAM_Click
.head 6 -  Set hBtnCustType3 = VisMessageLoadButton('Фіз. особа', 3)
.head 6 -  Set hBtnCustType2 = VisMessageLoadButton('Юр. особа', 2)
.head 6 -  Set hBtnCancel    = VisMessageLoadButton('Відмінити', 0)
.head 6 -  Set hBtns[0] = hBtnCustType3
.head 6 -  Set hBtns[1] = hBtnCustType2
.head 6 -  Set hBtns[2] = hBtnCancel | MBF_DefButton
.head 6 -  Call VisMessageSetBkgdColor(COLOR_LightGray)
.head 6 -  Set nChoose = VisMessageBox('Виберіть тип клієнта', 'Запит', MBF_IconQuestion, hBtns, 3)
.head 6 +  If nChoose
.head 7 -  Set dfRnk  = NUMBER_Null
.head 7 -  Set dfOkpo = STRING_Null
.head 7 -  Call SetButton(FALSE)
.head 7 -  Call ClearField()
.head 7 +  If nChoose = 3
.head 8 -  Call EditCustPerson(0, ACCESS_FULL, hWndForm)
.head 7 +  If nChoose = 2
.head 8 -  Call EditCustCorps(0, ACCESS_FULL, hWndForm)
.head 3 +  Picture: pbClient
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.45"
.head 5 -  Top:    0.202"
.head 5 -  Width:  0.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.3"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  File Name: \BARS98\RESOURCE\BMP\CUSTPERS.BMP
.head 4 -  Storage: Internal
.head 4 -  Picture Transparent Color: None
.head 4 -  Fit: Scale
.head 4 -  Scaling
.head 5 -  Width:  100
.head 5 -  Height:  100
.head 4 -  Corners: Square
.head 4 -  Border Style: Raised-Shadow
.head 4 -  Border Thickness: 1
.head 4 -  Tile To Parent? No
.head 4 -  Border Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Картка клієнта')
.head 5 +  On SAM_Click
.head 6 +  If dfRnk
.head 7 +  Select Case nCType
.head 8 +  Case 1
.head 9 -  Call EditCustPersonEx(dfRnk, ACCESS_FULL, hWndForm, 0, '', FALSE)
.head 9 -  Break
.head 8 +  Case 2
.head 9 -  Call EditCustCorpsEx(dfRnk, ACCESS_FULL, hWndForm, 0, '', FALSE)
.head 9 -  Break
.head 8 +  Default
.head 9 -  Break
.head 3 +  Picture: pbRefresh
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.9"
.head 5 -  Top:    0.202"
.head 5 -  Width:  0.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.3"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  File Name: \BARS98\RESOURCE\BMP\REFRESH.BMP
.head 4 -  Storage: Internal
.head 4 -  Picture Transparent Color: None
.head 4 -  Fit: Scale
.head 4 -  Scaling
.head 5 -  Width:  100
.head 5 -  Height:  100
.head 4 -  Corners: Square
.head 4 -  Border Style: Raised-Shadow
.head 4 -  Border Thickness: 1
.head 4 -  Tile To Parent? No
.head 4 -  Border Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Перечитати дані клієнта')
.head 5 +  On SAM_Click
.head 6 +  If dfRnk
.head 7 -  Call SearchCustomer(dfRnk, '')
.head 3 -  Background Text: Реєстр. номер
.head 4 -  Resource Id: 38328
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.3"
.head 5 -  Width:  2.2"
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
.head 3 +  Data Field: dfRnk
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
.head 6 -  Left:   2.5"
.head 6 -  Top:    0.25"
.head 6 -  Width:  2.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_AnyEdit
.head 6 -  Set dfOkpo = ''
.head 6 -  Set dfFio  = ''
.head 5 +  On SAM_Validate
.head 6 +  If not SalIsNull(dfRnk) 
.head 7 +  If not SearchCustomer(dfRnk, '')
.head 8 -  Set dfRnk  = NUMBER_Null
.head 8 -  Set dfOkpo = ''
.head 8 +  If SalMessageBox('Клієнта не знайдено! Вибрати з довідника?', 'Увага!', MB_IconExclamation | MB_YesNo) = IDYES
.head 9 -  Call SalSendMsg(pbSearch, SAM_Click, 0, 0)
.head 6 +  If dfRnk
.head 7 -  Call SetButton(TRUE)
.head 6 +  Else
.head 7 -  Call SetButton(FALSE)
.head 7 -  Call ClearField()
.head 6 -  Return VALIDATE_Ok
.head 3 -  Background Text: ЗКПО
.head 4 -  Resource Id: 38329
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.6"
.head 5 -  Width:  2.2"
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
.head 3 +  Data Field: dfOkpo
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 14
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    0.55"
.head 6 -  Width:  2.0"
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
.head 5 +  On SAM_AnyEdit
.head 6 -  Set dfRnk = NUMBER_Null
.head 6 -  Set dfFio = ''
.head 5 +  On SAM_Validate
.head 6 +  If not SalIsNull(dfOkpo)
.head 7 -  Call SqlPrepareAndExecute(hSql(), "select count(*) into :nCount from customer where okpo=:dfOkpo and custtype in (2,3)" || sCustTypeToSearch)
.head 7 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 7 +  If nCount = 0
.head 8 -  Set dfRnk  = NUMBER_Null
.head 8 -  Set dfOkpo = ''
.head 8 -  Set dfFio  = ''
.head 8 +  If SalMessageBox('Клієнта не знайдено! Вибрати з довідника?', 'Увага!', MB_IconExclamation | MB_YesNo) = IDYES
.head 9 -  Call SalSendMsg(pbSearch, SAM_Click, 0, 0)
.head 7 +  Else If nCount = 1
.head 8 -  Call SearchCustomer(NUMBER_Null, dfOkpo)
.head 7 +  Else
.head 8 +  If SalMessageBox("Знайдено декілька клієнтів з ЗКПО " || dfOkpo || "! Вибрати з довідника по ЗКПО?", "Увага!", MB_IconExclamation | MB_YesNo) = IDYES
.head 9 -  Call SalSendMsg(pbSearch, SAM_Click, 1, 0)
.head 8 +  Else
.head 9 -  Set dfRnk  = NUMBER_Null
.head 9 -  Set dfOkpo = ''
.head 6 +  If dfRnk
.head 7 -  Call SetButton(TRUE)
.head 6 +  Else
.head 7 -  Call SetButton(FALSE)
.head 7 -  Call ClearField()
.head 6 -  Return VALIDATE_Ok
.head 3 -  Background Text: ПІБ
.head 4 -  Resource Id: 38330
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.9"
.head 5 -  Width:  2.2"
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
.head 6 -  Left:   2.5"
.head 6 -  Top:    0.85"
.head 6 -  Width:  6.0"
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
.head 3 -  Background Text: Тип клієнта
.head 4 -  Resource Id: 29900
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    1.2"
.head 5 -  Width:  2.2"
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
.head 3 +  Data Field: dfCusttype
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
.head 6 -  Top:    1.15"
.head 6 -  Width:  6.0"
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
.head 3 -  !
.head 3 -  Group Box: Адреса
.head 4 -  Resource Id: 27346
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    1.45"
.head 5 -  Width:  8.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 3.8"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: Індекс
.head 4 -  Resource Id: 38331
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    1.7"
.head 5 -  Width:  2.2"
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
.head 3 +  Data Field: dfIndex
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 20
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    1.65"
.head 6 -  Width:  2.0"
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
.head 3 -  Background Text: Область
.head 4 -  Resource Id: 38332
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    2.0"
.head 5 -  Width:  2.2"
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
.head 3 +  Data Field: dfObl
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 30
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    1.95"
.head 6 -  Width:  6.0"
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
.head 3 -  Background Text: Район
.head 4 -  Resource Id: 38333
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    2.3"
.head 5 -  Width:  2.2"
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
.head 3 +  Data Field: dfReg
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 30
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    2.25"
.head 6 -  Width:  6.0"
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
.head 3 -  Background Text: Місто
.head 4 -  Resource Id: 38334
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    2.6"
.head 5 -  Width:  2.2"
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
.head 3 +  Data Field: dfCity
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 60
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    2.55"
.head 6 -  Width:  6.0"
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
.head 3 -  Background Text: Вулиця, дім, кв.
.head 4 -  Resource Id: 38335
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    2.9"
.head 5 -  Width:  2.2"
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
.head 3 +  Data Field: dfStreet
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 100
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    2.85"
.head 6 -  Width:  6.0"
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
.head 3 -  !
.head 3 -  Group Box: Паспортні дані
.head 4 -  Resource Id: 27347
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    3.15"
.head 5 -  Width:  8.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 2.1"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: Вид документу
.head 4 -  Resource Id: 38336
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    3.4"
.head 5 -  Width:  2.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfPassp
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
.head 6 -  Top:    3.35"
.head 6 -  Width:  6.0"
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
.head 3 -  Background Text: Серія, номер
.head 4 -  Resource Id: 38337
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    3.7"
.head 5 -  Width:  2.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfSer
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 6
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    3.65"
.head 6 -  Width:  1.6"
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
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfNumDoc
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 15
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   4.15"
.head 6 -  Top:    3.65"
.head 6 -  Width:  4.35"
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
.head 3 -  Background Text: Коли, ким видано
.head 4 -  Resource Id: 38339
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    4.0"
.head 5 -  Width:  2.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfPdate
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
.head 6 -  Top:    3.95"
.head 6 -  Width:  1.6"
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
.head 5 -  Input Mask: 99/99/9999
.head 4 -  Message Actions
.head 3 +  Data Field: dfOrgan
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
.head 6 -  Left:   4.15"
.head 6 -  Top:    3.95"
.head 6 -  Width:  4.35"
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
.head 3 -  Background Text: Дата, місце народж.
.head 4 -  Resource Id: 38341
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    4.3"
.head 5 -  Width:  2.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfBday
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
.head 6 -  Top:    4.25"
.head 6 -  Width:  1.6"
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
.head 5 -  Input Mask: 99/99/9999
.head 4 -  Message Actions
.head 3 +  Data Field: dfBplace
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 70
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   4.15"
.head 6 -  Top:    4.25"
.head 6 -  Width:  4.35"
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
.head 2 +  Functions
.head 3 +  Function: SearchCustomer
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nRnk
.head 5 -  String: sOkpo
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Set nCType = NUMBER_Null
.head 5 -  Set hWndParent.frmCard.nCType = nCType
.head 5 -  ! Основные параметры кдиента
.head 5 -  ! nCType = 1-ФО, 2-ЮО
.head 5 +  If not SqlPrepareAndExecute(hSql(), 
"select rnk, okpo, nmk, 
        substr(fio(nmkv,2),1,20) || ' ' || substr(fio(nmkv,1),1,20),
        case
          when (custtype=3 and nvl(trim(sed),'00')<>'91') then 1
          else 2
        end ctype,
        case
          when (custtype=3 and nvl(trim(sed),'00')<>'91') then 'Фізична особа'
          when (custtype=3 and nvl(trim(sed),'00') ='91') then 'Фізична особа-підприємець'
          else 'Юридична особа'
        end custtype
   into :dfRnk, :dfOkpo, :dfFio, :sNmkV, :nCType, :dfCusttype
   from customer
  where " || IifS(nRnk!=NUMBER_Null,
        "rnk  = :nRnk",
        "okpo = :sOkpo") || "
    and custtype in (2,3)" || sCustTypeToSearch)
.head 6 -  Return FALSE
.head 5 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Return FALSE
.head 5 -  ! Адрес
.head 5 -  Call SqlPrepareAndExecute(hSql(),
"select substr(min(decode(tag,'FGIDX', value, null)),1,20),
        substr(min(decode(tag,'FGOBL', value, null)),1,30),
        substr(min(decode(tag,'FGDST', value, null)),1,30),
        substr(min(decode(tag,'FGTWN', value, null)),1,60),
        substr(min(decode(tag,'FGADR', value, null)),1,100)
   into :dfIndex, :dfObl, :dfReg, :dfCity, :dfStreet
   from customerw 
  where rnk = :dfRnk and tag like 'FG%'")
.head 5 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 5 -  ! Паспортные данные
.head 5 -  Call SqlPrepareAndExecute(hSql(),
"select d.name, p.ser, p.numdoc, p.pdate, p.organ, p.bday, p.bplace
   into :dfPassp, :dfSer, :dfNumDoc, :dfPdate, :dfOrgan, :dfBday, :dfBplace
   from person p, passp d
  where p.rnk = :dfRnk and p.passp = d.passp")
.head 5 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 5 -  ! Дівоче прізвище матері
.head 5 -  Call SqlPrepareAndExecute(hSql(),
"select substr(value,1,20) into :sMName
   from customerw
  where rnk = :dfRnk and tag = 'PC_MF'")
.head 5 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Set sMName = STRING_Null
.head 5 -  ! Місце роботи, посада
.head 5 -  Call SqlPrepareAndExecute(hSql(),
"select trim(substr(substr(value,1,instr(value,',')-1),1,30)),
        trim(substr(substr(value,instr(value,',')+1,100),1,25))
   into :sWork, :sOffice
   from customerw
  where rnk = :dfRnk and trim(tag) = 'WORK'")
.head 5 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Set sWork   = STRING_Null
.head 6 -  Set sOffice = STRING_Null
.head 5 -  !
.head 5 -  Set hWndParent.frmCard.nCType  = nCType
.head 5 -  Set hWndParent.frmCard.sNmkV   = sNmkV
.head 5 -  Set hWndParent.frmCard.sMName  = sMName
.head 5 -  Set hWndParent.frmCard.sWork   = sWork
.head 5 -  Set hWndParent.frmCard.sOffice = sOffice
.head 5 -  Set hWndParent.frmCard.nClientRnk = dfRnk
.head 5 -  !
.head 5 -  Call SalEnableWindow(pbClient)
.head 5 -  Call SalEnableWindow(pbRefresh)
.head 5 -  Return TRUE
.head 3 +  Function: SetButton
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Boolean: bFlag
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If bFlag
.head 6 -  Call SalEnableWindow(pbClient)
.head 6 -  Call SalEnableWindow(pbRefresh)
.head 5 +  Else
.head 6 -  Call SalDisableWindow(pbClient)
.head 6 -  Call SalDisableWindow(pbRefresh)
.head 5 -  Return TRUE
.head 3 +  Function: ClearField
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Set nCType = NUMBER_Null
.head 5 -  Set sNmkV  = STRING_Null
.head 5 -  Set sMName = STRING_Null
.head 5 -  Set hWndParent.frmCard.nCType = nCType
.head 5 -  Set hWndParent.frmCard.sNmkV  = sNmkV
.head 5 -  Set hWndParent.frmCard.sMName = sMName
.head 5 -  Set dfFio = STRING_Null
.head 5 -  Set dfCusttype = STRING_Null
.head 5 -  Set dfIndex  = STRING_Null
.head 5 -  Set dfObl    = STRING_Null
.head 5 -  Set dfReg    = STRING_Null
.head 5 -  Set dfCity   = STRING_Null
.head 5 -  Set dfStreet = STRING_Null
.head 5 -  Set dfPassp  = STRING_Null
.head 5 -  Set dfSer    = STRING_Null
.head 5 -  Set dfNumDoc = STRING_Null
.head 5 -  Set dfOrgan  = STRING_Null
.head 5 -  Set dfPdate  = DATETIME_Null
.head 5 -  Set dfBday   = DATETIME_Null
.head 5 -  Set dfBplace = STRING_Null
.head 5 -  Return TRUE
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  String: strPassPar
.head 3 -  String: InParam[4]
.head 3 -  Window Handle: hWndParent
.head 3 -  !
.head 3 -  String: sPK
.head 3 -  String: sSem
.head 3 -  Number: hBtns[*]
.head 3 -  Number: hBtnCustType3
.head 3 -  Number: hBtnCustType2
.head 3 -  Number: hBtnCancel
.head 3 -  Number: nChoose
.head 3 -  Number: nCount
.head 3 -  Number: nCType
.head 3 -  !
.head 3 -  String: sNmkV
.head 3 -  String: sMName
.head 3 -  String: sWork
.head 3 -  String: sOffice
.head 3 -  !
.head 3 -  String: sCustTypeToSearch
.head 2 +  Message Actions
.head 3 +  On PAGEM_Initialize
.head 4 -  ! Инициализация
.head 4 -  Set strPassPar = SalNumberToHString(lParam)
.head 4 +  If SalStrTokenize(strPassPar, '', ';', InParam) < 2
.head 5 -  Return FALSE
.head 4 -  Set hWndParent = SalNumberToWindowHandle(SalStrToNumber(InParam[1]))
.head 4 -  !
.head 4 -  Set nCType = NUMBER_Null
.head 4 -  Set sCustTypeToSearch = STRING_Null
.head 4 -  !
.head 4 -  Call SalDisableWindow(pbClient)
.head 4 -  Call SalDisableWindow(pbRefresh)
.head 4 -  !
.head 4 -  Set hWndParent.frmCard.hWndTabClient = hWndForm
.head 3 +  On UM_Populate
.head 4 -  Call SearchCustomer(dfRnk, '')
.head 3 +  On SAM_DoInit
.head 4 -  ! 0 - закрыть поля (после "Открыть карточку")
.head 4 -  ! 1 - очистить и открыть поля (после "Новая")
.head 4 -  ! 2 - очистить и открыть поля (после "Копировать")
.head 4 -  Set sCustTypeToSearch = STRING_Null
.head 4 +  If wParam = 0
.head 5 -  Call SalDisableWindow(dfRnk)
.head 5 -  Call SalDisableWindow(dfOkpo)
.head 5 -  Call SalDisableWindow(pbSearch)
.head 5 -  Call SalDisableWindow(pbNew)
.head 5 -  Call SalDisableWindow(pbClient)
.head 5 -  Call SalDisableWindow(pbRefresh)
.head 4 +  Else
.head 5 -  Call SalEnableWindow(dfRnk)
.head 5 -  Call SalEnableWindow(dfOkpo)
.head 5 -  Call SalEnableWindow(pbSearch)
.head 5 -  Call SalEnableWindow(pbNew)
.head 5 -  Set dfRnk  = NUMBER_Null
.head 5 -  Set dfOkpo = STRING_Null
.head 5 +  If wParam = 2
.head 6 -  Set sCustTypeToSearch = IifS(nCType=1, 
    " and customer.custtype = 3 ", IifS(nCType=2, 
    " and (customer.custtype = 2 or customer.custtype = 3 and nvl(customer.sed,'00')='91') ", ""))
.head 5 -  Call ClearField()
.head 1 +  Dialog Box: dlgCardCard
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
.head 4 -  Width:  8.9"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.6"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
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
.head 3 -  Group Box: Картка
.head 4 -  Resource Id: 57352
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.05"
.head 5 -  Width:  8.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 5.2"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: Карткова система
.head 4 -  Resource Id: 57370
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.3"
.head 5 -  Width:  2.2"
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
.head 3 +  Combo Box: cmbAccType
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenComboBox_StrId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.5"
.head 5 -  Top:    0.25"
.head 5 -  Width:  5.45"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 3.357"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  String Type: Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Sorted? Class Default
.head 4 -  Always Show List? Class Default
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  List Initialization
.head 4 +  Message Actions
.head 5 +  On UM_ObjActivate
.head 6 -  Set sAccType = '-'
.head 6 +  If cmbAccType.Init(hWndItem)
.head 7 -  Call cmbAccType.Populate(hSql(), "type", "name", "demand_acc_type", "order by card_type, acc_type")
.head 7 -  Call cmbAccType.Add('-', '')
.head 7 -  Call cmbAccType.SetSelectById(sAccType)
.head 7 -  Call SalSendMsg(cmbAccType, SAM_Click, 0, 0)
.head 5 +  On SAM_Click
.head 6 -  Call SalSendClassMessage(SAM_Click, 0, 0)
.head 6 -  Set sAccType = cmbAccType.strCurrentId
.head 6 -  Call ClearField(0)
.head 3 -  !
.head 3 -  Background Text: Валюта
.head 4 -  Resource Id: 57355
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.6"
.head 5 -  Width:  2.2"
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
.head 3 +  Radio Button: rbUAH
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cRadioButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: UAH
.head 4 -  Window Location and Size
.head 5 -  Left:   2.5"
.head 5 -  Top:    0.55"
.head 5 -  Width:  1.4"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call ClearField(0)
.head 3 +  Radio Button: rbUSD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cRadioButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: USD
.head 4 -  Window Location and Size
.head 5 -  Left:   4.0"
.head 5 -  Top:    0.55"
.head 5 -  Width:  1.4"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call ClearField(0)
.head 3 -  !
.head 3 -  Background Text: Категорія клієнта
.head 4 -  Resource Id: 57358
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.183"
.head 5 -  Top:    0.9"
.head 5 -  Width:  2.2"
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
.head 3 +  Data Field: dfKCode
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 1
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    0.85"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Uppercase
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Combo Box: cmbKK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenComboBox_StrId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.55"
.head 5 -  Top:    0.85"
.head 5 -  Width:  4.4"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 3.202"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  String Type: Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Sorted? Class Default
.head 4 -  Always Show List? Class Default
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  List Initialization
.head 4 +  Message Actions
.head 5 +  On UM_ObjActivate
.head 6 -  Set dfKCode = '-'
.head 6 +  If cmbKK.Init(hWndItem)
.head 7 -  Call cmbKK.Populate(hSql(), "kk", "name", "demand_kk", "order by kk")
.head 7 -  Call cmbKK.Add('-', '')
.head 7 -  Call cmbKK.SetSelectById(sAccType)
.head 7 -  Call SalSendMsg(cmbKK, SAM_Click, 0, 0)
.head 5 +  On SAM_Click
.head 6 -  Call SalSendClassMessage(SAM_Click, 0, 0)
.head 6 -  Set dfKCode = cmbKK.strCurrentId
.head 6 -  Call ClearField(0)
.head 3 -  !
.head 3 -  Background Text: Продукт
.head 4 -  Resource Id: 57354
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    1.2"
.head 5 -  Width:  2.2"
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
.head 3 +  Data Field: dfPCode
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 10
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    1.15"
.head 6 -  Width:  1.0"
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
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfPName
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
.head 6 -  Left:   3.55"
.head 6 -  Top:    1.15"
.head 6 -  Width:  4.4"
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
.head 3 +  Picture: pbProduct
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   8.083"
.head 5 -  Top:    1.107"
.head 5 -  Width:  0.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.3"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  File Name: \BARS98\RESOURCE\BMP\FILTER.BMP
.head 4 -  Storage: Internal
.head 4 -  Picture Transparent Color: None
.head 4 -  Fit: Scale
.head 4 -  Scaling
.head 5 -  Width:  100
.head 5 -  Height:  100
.head 4 -  Corners: Square
.head 4 -  Border Style: Raised-Shadow
.head 4 -  Border Thickness: 1
.head 4 -  Tile To Parent? No
.head 4 -  Border Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Продукт')
.head 5 +  On SAM_Click
.head 6 +  If FunNSIGetFiltered("v_bpk_product", "name", 
"v_bpk_product.kv=" || IifS(rbUAH=TRUE, "980", "840") || 
" and custtype = "  || Str(hWndParent.frmCard.nCType) || 
IifS(sAccType='-', "", " and v_bpk_product.type='" || sAccType || "'") ||
IifS(dfKCode ='-', "", " and v_bpk_product.kk='"   || dfKCode  || "'"), sPK, sSem)
.head 7 -  Set dfPCode = Val(sPK)
.head 7 -  Set dfPName = sSem
.head 7 -  Call GetProduct()
.head 3 -  Background Text: ОБ22
.head 4 -  Resource Id: 57356
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    1.5"
.head 5 -  Width:  2.2"
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
.head 3 +  Data Field: dfOb22
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 2
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    1.45"
.head 6 -  Width:  1.0"
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
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfOb22Name
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
.head 6 -  Left:   3.55"
.head 6 -  Top:    1.45"
.head 6 -  Width:  4.4"
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
.head 3 -  !
.head 3 -  Background Text: Код умови рахунку
.head 4 -  Resource Id: 57363
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    1.8"
.head 5 -  Width:  4.3"
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
.head 3 +  Data Field: dfCCode
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 4
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   4.55"
.head 6 -  Top:    1.75"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfCName
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
.head 6 -  Left:   5.6"
.head 6 -  Top:    1.75"
.head 6 -  Width:  2.35"
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
.head 3 -  Background Text: Тривалість строку дії картки (в місяцях)
.head 4 -  Resource Id: 57364
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    2.1"
.head 5 -  Width:  4.3"
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
.head 3 +  Data Field: dfCValid
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
.head 6 -  Left:   4.55"
.head 6 -  Top:    2.05"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Вартість користування кредитом
.head 4 -  Resource Id: 57365
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    2.4"
.head 5 -  Width:  4.3"
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
.head 3 +  Data Field: dfDebIntr
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
.head 6 -  Left:   4.55"
.head 6 -  Top:    2.35"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Стягнення за овердрафт
.head 4 -  Resource Id: 57366
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    2.7"
.head 5 -  Width:  4.3"
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
.head 3 +  Data Field: dfOlimIntr
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
.head 6 -  Left:   4.55"
.head 6 -  Top:    2.65"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Відсоток на залишок по рахунку
.head 4 -  Resource Id: 57367
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    3.0"
.head 5 -  Width:  4.3"
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
.head 3 +  Data Field: dfCredIntr
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
.head 6 -  Left:   4.55"
.head 6 -  Top:    2.95"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  !
.head 3 -  Group Box: Умови кредитування
.head 4 -  Resource Id: 57368
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    3.25"
.head 5 -  Width:  8.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 2.0"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: Ліміт
.head 4 -  Resource Id: 57369
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    3.5"
.head 5 -  Width:  2.2"
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
.head 3 +  Data Field: dfLimit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 16
.head 5 -  Data Type: Number
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    3.45"
.head 6 -  Width:  2.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Decimal
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Check Box: cbKL	! Кредитная линия
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cCheckBoxLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кредитна лінія
.head 4 -  Window Location and Size
.head 5 -  Left:   2.5"
.head 5 -  Top:    3.75"
.head 5 -  Width:  3.4"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Message Actions
.head 2 +  Functions
.head 3 +  Function: ClearField
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nPar
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Set dfPCode = NUMBER_Null
.head 5 -  Set dfPName = STRING_Null
.head 5 -  Set dfOb22  = STRING_Null
.head 5 -  Set dfOb22Name = STRING_Null
.head 5 -  Set dfCCode = NUMBER_Null
.head 5 -  Set dfCName = STRING_Null
.head 5 -  Set dfCValid   = NUMBER_Null
.head 5 -  Set dfDebIntr  = NUMBER_Null
.head 5 -  Set dfOlimIntr = NUMBER_Null
.head 5 -  Set dfCredIntr = NUMBER_Null
.head 5 -  Set dfLimit = NUMBER_Null
.head 5 -  Set cbKL    = FALSE
.head 5 -  Call SalDisableWindow(dfLimit)
.head 5 -  Call SalDisableWindow(cbKL)
.head 5 +  If nPar = 1
.head 6 -  ! Set dfBranch = IifS(hWndParent.frmCard.sOurBranch='', '0', hWndParent.frmCard.sOurBranch)
.head 6 -  Call SalSendMsg(cmbAccType, UM_ObjActivate, 0, 0)
.head 6 -  Call SalSendMsg(cmbKK, UM_ObjActivate, 0, 0)
.head 6 -  ! Call SalSendMsg(cmbBranch, UM_ObjActivate, 0, 0)
.head 5 -  Return TRUE
.head 3 +  Function: GetProduct
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Set hWndParent.frmCard.nProductId = NUMBER_Null
.head 5 +  If not dfPCode
.head 6 -  Return FALSE
.head 5 +  If not SqlPrepareAndExecute(hSql(),
"select b.kv, b.kk, b.cond_set, b.nbs, b.ob22, b.limit, b.id_doc, b.id_doc_cred,
        d.name, d.c_validity, d.deb_intr, d.olim_intr, d.cred_intr, s.txt, a.type
   into :nKv, :dfKCode, :dfCCode, :sNbs, :dfOb22, :nLimit, :sIdDoc, :sIdDocCred,
        :dfCName, :dfCValid, :dfDebIntr, :dfOlimIntr, :dfCredIntr, :dfOb22Name, :sAccType
   from bpk_product b, demand_cond_set d, sb_ob22 s, obpc_tips t, demand_acc_type a
  where b.id = :dfPCode
    and b.card_type = d.card_type
    and b.cond_set  = d.cond_set
    and b.nbs  = s.r020
    and b.ob22 = s.ob22
    and b.ob22 = t.ob22
    and t.tip  = a.tip")
.head 6 -  Return FALSE
.head 5 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Return FALSE
.head 5 -  Call cmbAccType.SetSelectById(sAccType)
.head 5 -  Call cmbKK.SetSelectById(dfKCode)
.head 5 +  If nKv = 980
.head 6 -  Set rbUAH = TRUE
.head 5 +  Else
.head 6 -  Set rbUSD = TRUE
.head 5 +  If nLimit
.head 6 -  Call SalEnableWindow(dfLimit)
.head 6 -  Call SalEnableWindow(cbKL)
.head 5 +  Else
.head 6 -  Set dfLimit = NUMBER_Null
.head 6 -  Set cbKL    = FALSE
.head 6 -  Call SalDisableWindow(dfLimit)
.head 6 -  Call SalDisableWindow(cbKL)
.head 5 -  Set hWndParent.frmCard.nProductId = dfPCode
.head 5 -  Return TRUE
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  String: strPassPar
.head 3 -  String: InParam[4]
.head 3 -  Window Handle: hWndParent
.head 3 -  !
.head 3 -  Number: nKv
.head 3 -  String: sNbs
.head 3 -  Number: nLimit
.head 3 -  String: sIdDoc
.head 3 -  String: sIdDocCred
.head 3 -  !
.head 3 -  String: sPK
.head 3 -  String: sSem
.head 3 -  !
.head 3 -  String: sAccType
.head 2 +  Message Actions
.head 3 +  On PAGEM_Initialize
.head 4 -  ! Инициализация
.head 4 -  Set strPassPar = SalNumberToHString(lParam)
.head 4 +  If SalStrTokenize(strPassPar, '', ';', InParam) < 2
.head 5 -  Return FALSE
.head 4 -  Set hWndParent = SalNumberToWindowHandle(SalStrToNumber(InParam[1]))
.head 4 -  !
.head 4 -  Set rbUAH = TRUE
.head 4 -  ! Set dfBranch = hWndParent.frmCard.sBranch
.head 4 -  !
.head 4 -  Call ClearField(1)
.head 4 -  !
.head 4 -  Set hWndParent.frmCard.hWndTabCard = hWndForm
.head 3 +  On SAM_DoInit
.head 4 -  ! 0 - закрыть поля (после "Открыть карточку")
.head 4 -  ! 1 - очистить и открыть поля (после "Новая")
.head 4 -  ! 2 - открыть поля (после "Копировать")
.head 4 +  If wParam = 0
.head 5 -  Call SalDisableWindow(cmbAccType)
.head 5 -  Call SalDisableWindow(rbUAH)
.head 5 -  Call SalDisableWindow(rbUSD)
.head 5 -  Call SalDisableWindow(cmbKK)
.head 5 -  Call SalDisableWindow(pbProduct)
.head 5 -  Call SalDisableWindow(dfLimit)
.head 5 -  Call SalDisableWindow(cbKL)
.head 5 -  ! Call SalDisableWindow(cmbBranch)
.head 5 -  ! Set dfBranch = hWndParent.frmCard.sBranch
.head 5 -  ! Call cmbBranch.SetSelectById(dfBranch)
.head 4 +  Else
.head 5 -  Call SalEnableWindow(cmbAccType)
.head 5 -  Call SalEnableWindow(rbUAH)
.head 5 -  Call SalEnableWindow(rbUSD)
.head 5 -  Call SalEnableWindow(cmbKK)
.head 5 -  Call SalEnableWindow(pbProduct)
.head 5 -  ! Call SalEnableWindow(cmbBranch)
.head 5 -  Call GetProduct()
.head 5 +  If wParam = 1
.head 6 -  Call ClearField(1)
.head 1 +  Dialog Box: dlgCardDemand
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
.head 4 -  Width:  8.9"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.6"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
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
.head 3 -  Group Box: Demand
.head 4 -  Resource Id: 1610
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.05"
.head 5 -  Width:  8.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 5.2"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: Ім'я та прізвище на картці
.head 4 -  Resource Id: 1611
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.3"
.head 5 -  Width:  3.0"
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
.head 3 +  Data Field: dfDmName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 24
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.3"
.head 6 -  Top:    0.25"
.head 6 -  Width:  5.2"
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
.head 3 -  Background Text: Дівоче прізвище матері
.head 4 -  Resource Id: 1612
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.6"
.head 5 -  Width:  3.0"
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
.head 3 +  Data Field: dfDmMName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 20
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.3"
.head 6 -  Top:    0.55"
.head 6 -  Width:  5.2"
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
.head 3 -  Group Box: Місце роботи
.head 4 -  Resource Id: 1613
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.8"
.head 5 -  Width:  8.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 4.45"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: Місце роботи
.head 4 -  Resource Id: 1614
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    1.05"
.head 5 -  Width:  3.0"
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
.head 3 +  Data Field: dfWork
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 30
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.3"
.head 6 -  Top:    1.0"
.head 6 -  Width:  5.2"
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
.head 3 -  Background Text: Посада
.head 4 -  Resource Id: 1615
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    1.35"
.head 5 -  Width:  3.0"
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
.head 3 +  Data Field: dfOffice
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 25
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.3"
.head 6 -  Top:    1.3"
.head 6 -  Width:  5.2"
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
.head 3 -  Background Text: Телефон
.head 4 -  Resource Id: 1616
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    1.65"
.head 5 -  Width:  3.0"
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
.head 3 +  Data Field: dfWPhone
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 11
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.3"
.head 6 -  Top:    1.6"
.head 6 -  Width:  5.2"
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
.head 3 -  Background Text: Держава
.head 4 -  Resource Id: 1617
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    1.95"
.head 5 -  Width:  3.0"
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
.head 3 +  Data Field: dfWCntry
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 15
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.3"
.head 6 -  Top:    1.9"
.head 6 -  Width:  5.2"
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
.head 3 -  Background Text: Почтовий індекс
.head 4 -  Resource Id: 1618
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    2.25"
.head 5 -  Width:  3.0"
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
.head 3 +  Data Field: dfWPcode
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 6
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.3"
.head 6 -  Top:    2.2"
.head 6 -  Width:  5.2"
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
.head 3 -  Background Text: Місто
.head 4 -  Resource Id: 1619
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    2.55"
.head 5 -  Width:  3.0"
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
.head 3 +  Data Field: dfWCity
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 15
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.3"
.head 6 -  Top:    2.5"
.head 6 -  Width:  5.2"
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
.head 3 -  Background Text: Вулица
.head 4 -  Resource Id: 1620
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    2.85"
.head 5 -  Width:  3.0"
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
.head 3 +  Data Field: dfWStreet
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 30
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.3"
.head 6 -  Top:    2.8"
.head 6 -  Width:  5.2"
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
.head 3 -  Group Box: Філія
.head 4 -  Resource Id: 1621
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    3.1"
.head 5 -  Width:  8.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 2.15"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: Код філії
.head 4 -  Resource Id: 1622
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    3.35"
.head 5 -  Width:  3.0"
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
.head 3 +  Data Field: dfFCode
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 5
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.3"
.head 6 -  Top:    3.3"
.head 6 -  Width:  1.0"
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
.head 5 +  On SAM_Validate
.head 6 +  If SalIsNull(dfFCode)
.head 7 -  Set dfFName   = STRING_Null
.head 7 -  Set dfFCity   = STRING_Null
.head 7 -  Set dfFStreet = STRING_Null
.head 6 +  Else
.head 7 +  If not GetFilial(dfFCode)
.head 8 +  If SalMessageBox("Невірний код філії!" || PutCrLf() || "Вибрати з довідника?", "Увага", MB_IconExclamation | MB_YesNo) = IDNO
.head 9 -  Set dfFCode = ''
.head 9 -  Return VALIDATE_Cancel
.head 8 -  Call SalSendMsg(pbFiliales, SAM_Click, 0, 0)
.head 6 -  Return VALIDATE_Ok
.head 3 +  Data Field: dfFName
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
.head 6 -  Left:   4.35"
.head 6 -  Top:    3.3"
.head 6 -  Width:  3.7"
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
.head 3 +  Picture: pbFiliales
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   8.1"
.head 5 -  Top:    3.25"
.head 5 -  Width:  0.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.3"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  File Name: \BARS98\RESOURCE\BMP\FILTER.BMP
.head 4 -  Storage: Internal
.head 4 -  Picture Transparent Color: None
.head 4 -  Fit: Scale
.head 4 -  Scaling
.head 5 -  Width:  100
.head 5 -  Height:  100
.head 4 -  Corners: Square
.head 4 -  Border Style: Raised-Shadow
.head 4 -  Border Thickness: 1
.head 4 -  Tile To Parent? No
.head 4 -  Border Color: Default
.head 4 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Філія')
.head 5 +  On SAM_Click
.head 6 +  If FunNSIGet("v_bpk_branch_filiales", "name", sPK, sSem)
.head 7 -  Set dfBranch = sPK
.head 7 -  Call GetFilial(dfBranch)
.head 3 -  Background Text: Адреса
.head 4 -  Resource Id: 1623
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    3.65"
.head 5 -  Width:  3.0"
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
.head 3 +  Data Field: dfFCity
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
.head 6 -  Left:   3.3"
.head 6 -  Top:    3.6"
.head 6 -  Width:  2.0"
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
.head 3 +  Data Field: dfFStreet
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
.head 6 -  Left:   5.35"
.head 6 -  Top:    3.6"
.head 6 -  Width:  2.7"
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
.head 3 +  Data Field: dfBranch
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
.head 6 -  Left:   3.3"
.head 6 -  Top:    3.9"
.head 6 -  Width:  4.75"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? No
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
.head 2 +  Functions
.head 3 +  Function: GetFilial
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: sBranch
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If not SqlPrepareAndExecute(hSql(),
"select code, name, city, street
   into :dfFCode, :dfFName, :dfFCity, :dfFStreet
   from v_bpk_branch_filiales
  where branch = :sBranch")
.head 6 -  Return FALSE
.head 5 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Return FALSE
.head 5 -  Return TRUE
.head 3 +  Function: ClearField
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Set dfDmName  = STRING_Null
.head 5 -  Set dfDmMName = STRING_Null
.head 5 -  Set dfWork    = STRING_Null
.head 5 -  Set dfOffice  = STRING_Null
.head 5 -  Set dfWPhone  = STRING_Null
.head 5 -  Set dfWCntry  = STRING_Null
.head 5 -  Set dfWPcode  = STRING_Null
.head 5 -  Set dfWCity   = STRING_Null
.head 5 -  Set dfWStreet = STRING_Null
.head 5 -  Set dfFCode   = STRING_Null
.head 5 -  Set dfFName   = STRING_Null
.head 5 -  Set dfFCity   = STRING_Null
.head 5 -  Set dfFStreet = STRING_Null
.head 5 -  Return TRUE
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  String: strPassPar
.head 3 -  String: InParam[4]
.head 3 -  Window Handle: hWndParent
.head 3 -  !
.head 3 -  String: sPK
.head 3 -  String: sSem
.head 2 +  Message Actions
.head 3 +  On PAGEM_Initialize
.head 4 -  ! Инициализация
.head 4 -  Set strPassPar = SalNumberToHString(lParam)
.head 4 +  If SalStrTokenize(strPassPar, '', ';', InParam) < 2
.head 5 -  Return FALSE
.head 4 -  Set hWndParent = SalNumberToWindowHandle(SalStrToNumber(InParam[1]))
.head 4 -  !
.head 4 -  Call GetFilial(hWndParent.frmCard.sPCBranch)
.head 4 -  !
.head 4 -  Set hWndParent.frmCard.hWndTabDemand = hWndForm
.head 3 +  On SAM_DoInit
.head 4 -  ! 0 - закрыть поля (после "Открыть карточку")
.head 4 -  ! 1 - очистить и открыть поля (после "Новая")
.head 4 -  ! 2 - открыть поля (после "Копировать")
.head 4 +  If wParam = 0
.head 5 -  Call SalDisableWindow(dfDmName)
.head 5 -  Call SalDisableWindow(dfDmMName)
.head 5 -  Call SalDisableWindow(dfWork)
.head 5 -  Call SalDisableWindow(dfOffice)
.head 5 -  Call SalDisableWindow(dfWPhone)
.head 5 -  Call SalDisableWindow(dfWCntry)
.head 5 -  Call SalDisableWindow(dfWPcode)
.head 5 -  Call SalDisableWindow(dfWCity)
.head 5 -  Call SalDisableWindow(dfWStreet)
.head 5 -  Call SalDisableWindow(dfFCode)
.head 5 -  Call SalDisableWindow(pbFiliales)
.head 4 +  Else
.head 5 -  Call SalEnableWindow(dfDmName)
.head 5 -  Call SalEnableWindow(dfDmMName)
.head 5 -  Call SalEnableWindow(dfWork)
.head 5 -  Call SalEnableWindow(dfOffice)
.head 5 -  Call SalEnableWindow(dfWPhone)
.head 5 -  Call SalEnableWindow(dfWCntry)
.head 5 -  Call SalEnableWindow(dfWPcode)
.head 5 -  Call SalEnableWindow(dfWCity)
.head 5 -  Call SalEnableWindow(dfWStreet)
.head 5 -  Call SalEnableWindow(dfFCode)
.head 5 -  Call SalEnableWindow(pbFiliales)
.head 5 +  If wParam = 1 
.head 6 -  Call ClearField()
.head 5 +  Else
.head 6 -  Set dfDmName  = STRING_Null
.head 6 -  Set dfDmMName = STRING_Null
.head 1 +  Table Window: tblProduct
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Продукти БПК
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
.head 4 -  Width:  16.083"
.head 4 -  Width Editable? Class Default
.head 4 -  Height: 7.286"
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
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Додати новий продукт'
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
.head 7 -  Set strTip = 'Видалити продукт'
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
.head 5 -  Resource Id: 11422
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
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Редагування продукту'
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
.head 5 -  Resource Id: 11423
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
.head 5 -  Resource Id: 11424
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
.head 4 -  Title: №
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
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
.head 3 +  Column: colName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Назва
продукту
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 100
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
.head 3 +  Column: colType
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Тип
картки
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 1
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Center
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
.head 3 +  Column: colTypeName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Назва
типу кртки
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 100
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
.head 3 +  Column: colKv
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вал.
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 3
.head 4 -  Data Type: Number
.head 4 -  Justify: Center
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
.head 3 +  Column: colLcv
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вал.
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 3
.head 4 -  Data Type: String
.head 4 -  Justify: Center
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
.head 3 +  Column: colKk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Категорія
клієнта
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 1
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Center
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
.head 3 +  Column: colKkName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Назва
категорії клієнта
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  2.4"
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
.head 3 +  Column: colCondSet
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
умови
рахунку
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
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
.head 3 +  Column: colCondSetName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Назва
коду умови
рахунку
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  1.2"
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
.head 3 +  Column: colCValidity
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Тривалість
строку дії
картки
(в місяцях)
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.2"
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
.head 3 +  Column: colDebIntr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вартість
користування
кредитом
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.2"
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
.head 3 +  Column: colOlimIntr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Стягнення
за
овердрафт
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.2"
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
.head 3 +  Column: colCredIntr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Відсоток
на залишок
по рахунку
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.2"
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
.head 3 +  Column: colNbs
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: БР
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
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
.head 3 +  Column: colNbsName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Назва БР
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 175
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
.head 3 +  Column: colOb22
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ОБ22
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 2
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Center
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
.head 3 +  Column: colOb22Name
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Назва ОБ22
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
.head 3 +  Column: colLimit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ознака
встановлення
ліміту
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Class Default
.head 4 -  Width:  1.0"
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
.head 3 +  Column: colIdDoc
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Шаблон
договору
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  1.2"
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
.head 3 +  Column: colIdDocCred
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Шаблон
кредитного
договору
.head 4 -  Visible? Class Default
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Class Default
.head 4 -  Justify: Class Default
.head 4 -  Width:  1.2"
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
.head 2 +  Window Parameters
.head 3 -  ! nMode - режим: 0-просмотр, 1-редактирование
.head 3 -  Number: nMode
.head 2 -  Window Variables
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Set hWndForm.tblProduct.strFilterTblName = "v_bpk_product"
.head 4 -  Set hWndForm.tblProduct.strPrintFileName = "bpk_product"
.head 4 -  Set hWndForm.tblProduct.strSqlPopulate = 
"select id, name, type, type_name, 
        kv, decode(kv,980,'UAH','USD') lcv, kk, kk_name, cond_set, cond_set_name,
        c_validity, deb_intr, olim_intr, cred_intr,
        nbs, nbs_name, ob22, ob22_name, limit,
        id_doc, id_doc_cred
   into :hWndForm.tblProduct.colId, :hWndForm.tblProduct.colName, 
        :hWndForm.tblProduct.colType, :hWndForm.tblProduct.colTypeName, 
        :hWndForm.tblProduct.colKv, :hWndForm.tblProduct.colLcv,
        :hWndForm.tblProduct.colKk, :hWndForm.tblProduct.colKkName, 
        :hWndForm.tblProduct.colCondSet, :hWndForm.tblProduct.colCondSetName, 
        :hWndForm.tblProduct.colCValidity, :hWndForm.tblProduct.colDebIntr,
        :hWndForm.tblProduct.colOlimIntr, :hWndForm.tblProduct.colCredIntr, 
        :hWndForm.tblProduct.colNbs, :hWndForm.tblProduct.colNbsName, 
        :hWndForm.tblProduct.colOb22, :hWndForm.tblProduct.colOb22Name, :hWndForm.tblProduct.colLimit, 
        :hWndForm.tblProduct.colIdDoc, :hWndForm.tblProduct.colIdDocCred
   from v_bpk_product
  order by id"
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On SAM_DoubleClick
.head 4 +  If SalModalDialog(dlgProduct, hWndForm, colId)
.head 5 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 3 +  On UM_Insert
.head 4 +  If SalModalDialog(dlgProduct, hWndForm, NUMBER_Null)
.head 5 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 3 +  On UM_Update
.head 4 -  Set nRow = TBL_MinRow
.head 4 +  While SalTblFindNextRow(hWndForm, nRow, ROW_MarkDeleted, 0)
.head 5 -  Call SalTblSetContext(hWndForm, nRow)
.head 5 +  If not SqlPLSQLCommand(hSql(), "bars_bpk.product_delete(colId)")
.head 6 -  Call SqlRollbackEx(hSql(), "")
.head 6 -  Break
.head 5 +  Else
.head 6 -  Call SqlCommitEx(hSql(), "")
.head 4 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 1 +  Dialog Box: dlgProduct
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
.head 4 -  Width:  8.9"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 6.25"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
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
.head 3 -  Group Box: Продукт
.head 4 -  Resource Id: 11425
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.05"
.head 5 -  Width:  8.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 5.05"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: Назва продукту
.head 4 -  Resource Id: 11436
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.3"
.head 5 -  Width:  2.2"
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
.head 3 +  Data Field: dfName
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
.head 6 -  Left:   2.5"
.head 6 -  Top:    0.25"
.head 6 -  Width:  5.45"
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
.head 3 -  Background Text: Тип картки
.head 4 -  Resource Id: 11426
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.6"
.head 5 -  Width:  2.2"
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
.head 3 +  Combo Box: cmbAccType
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenComboBox_StrId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.5"
.head 5 -  Top:    0.55"
.head 5 -  Width:  5.45"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 3.357"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  String Type: Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Sorted? Class Default
.head 4 -  Always Show List? Class Default
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  List Initialization
.head 4 +  Message Actions
.head 5 +  On UM_ObjActivate
.head 6 +  If cmbAccType.Init(hWndItem)
.head 7 -  Call cmbAccType.Populate(hSql(), "type", "name", "demand_acc_type", "order by card_type, acc_type")
.head 7 -  Call cmbAccType.SetSelectById(sType)
.head 7 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 5 +  On SAM_User
.head 6 -  Call SqlPrepareAndExecute(hSql(), "select card_type into :nCardType from demand_acc_type where type = :sType")
.head 6 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 6 +  If sType
.head 7 -  Call SalEnableWindow(pbCondSet)
.head 6 -  Call SalSendMsg(cmbOb22, UM_ObjActivate, 0, 0)
.head 5 +  On SAM_Click
.head 6 -  Call SalSendClassMessage(SAM_Click, 0, 0)
.head 6 -  Set sType = cmbAccType.strCurrentId
.head 6 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 6 -  Call ClearCondSet()
.head 3 -  !
.head 3 -  Background Text: Валюта
.head 4 -  Resource Id: 11427
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.9"
.head 5 -  Width:  2.2"
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
.head 3 +  Radio Button: rbUAH
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cRadioButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: UAH
.head 4 -  Window Location and Size
.head 5 -  Left:   2.5"
.head 5 -  Top:    0.85"
.head 5 -  Width:  1.4"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set nKv = 980
.head 6 -  Call ClearCondSet()
.head 3 +  Radio Button: rbUSD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cRadioButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: USD
.head 4 -  Window Location and Size
.head 5 -  Left:   4.0"
.head 5 -  Top:    0.85"
.head 5 -  Width:  1.4"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set nKv = 840
.head 6 -  Call ClearCondSet()
.head 3 -  !
.head 3 -  Background Text: Категорія клієнта
.head 4 -  Resource Id: 11428
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.183"
.head 5 -  Top:    1.2"
.head 5 -  Width:  2.2"
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
.head 3 +  Data Field: dfKk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 1
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    1.15"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Uppercase
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Combo Box: cmbKk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenComboBox_StrId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.55"
.head 5 -  Top:    1.15"
.head 5 -  Width:  4.4"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 3.202"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  String Type: Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Sorted? Class Default
.head 4 -  Always Show List? Class Default
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  List Initialization
.head 4 +  Message Actions
.head 5 +  On UM_ObjActivate
.head 6 +  If cmbKk.Init(hWndItem)
.head 7 -  Call cmbKk.Populate(hSql(), "kk", "name", "demand_kk", "order by kk")
.head 7 -  Call cmbKk.SetSelectById(dfKk)
.head 5 +  On SAM_Click
.head 6 -  Call SalSendClassMessage(SAM_Click, 0, 0)
.head 6 -  Set dfKk = cmbKk.strCurrentId
.head 3 -  !
.head 3 -  Background Text: Балансовий рахунок
.head 4 -  Resource Id: 11429
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    1.5"
.head 5 -  Width:  2.2"
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
.head 3 +  Data Field: dfNbs
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 4
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    1.45"
.head 6 -  Width:  1.0"
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
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Combo Box: cmbNbs
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenComboBox_StrId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.55"
.head 5 -  Top:    1.45"
.head 5 -  Width:  4.4"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 3.048"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  String Type: Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Sorted? Class Default
.head 4 -  Always Show List? Class Default
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  List Initialization
.head 4 +  Message Actions
.head 5 +  On UM_ObjActivate
.head 6 +  If cmbNbs.Init(hWndItem)
.head 7 -  Call cmbNbs.Populate(hSql(), "nbs", "nbs||' '||name", "ps", "where nbs in (select unique nbs from v_bpk_ob22) order by nbs")
.head 7 -  Call cmbNbs.SetSelectById(dfNbs)
.head 7 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 5 +  On SAM_User
.head 6 -  Call SalSendMsg(cmbOb22, UM_ObjActivate, 0, 0)
.head 5 +  On SAM_Click
.head 6 -  Call SalSendClassMessage(SAM_Click, 0, 0)
.head 6 -  Set dfNbs = cmbNbs.strCurrentId
.head 6 -  Call SalSendMsg(hWndItem, SAM_User, 0, 0)
.head 3 -  !
.head 3 -  Background Text: ОБ22
.head 4 -  Resource Id: 11430
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    1.8"
.head 5 -  Width:  2.2"
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
.head 3 +  Data Field: dfOb22
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 2
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    1.75"
.head 6 -  Width:  1.0"
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
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Combo Box: cmbOb22
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenComboBox_StrId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.55"
.head 5 -  Top:    1.75"
.head 5 -  Width:  4.4"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 2.893"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  String Type: Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Sorted? Class Default
.head 4 -  Always Show List? Class Default
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  List Initialization
.head 4 +  Message Actions
.head 5 +  On UM_ObjActivate
.head 6 +  If cmbOb22.Init(hWndItem)
.head 7 +  If dfNbs and sType
.head 8 -  Call cmbOb22.Populate(hSql(), "ob22", "ob22_name", "v_bpk_ob22", 
"where nbs='" || dfNbs || "' and type='" || sType || "' order by ob22")
.head 8 +  If nId
.head 9 -  Call cmbOb22.SetSelectById(dfOb22)
.head 8 +  Else
.head 9 -  Call SalListSetSelect(hWndItem, 0)
.head 8 -  Call SalSendMsg(cmbOb22, SAM_Click, 0, 0)
.head 5 +  On SAM_Click
.head 6 -  Call SalSendClassMessage(SAM_Click, 0, 0)
.head 6 -  Set dfOb22 = cmbOb22.strCurrentId
.head 3 -  !
.head 3 -  Background Text: Код умови рахунку
.head 4 -  Resource Id: 11431
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    2.1"
.head 5 -  Width:  4.3"
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
.head 3 +  Data Field: dfCondSet
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 4
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   4.55"
.head 6 -  Top:    2.05"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfCondSetName
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
.head 6 -  Left:   5.6"
.head 6 -  Top:    2.05"
.head 6 -  Width:  2.35"
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
.head 3 +  Pushbutton: pbCondSet
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbFilter
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   8.05"
.head 5 -  Top:    2.05"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.3"
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
.head 5 +  On SAM_Create
.head 6 -  Set strTip = 'Код умови рахунку'
.head 5 +  On SAM_Click
.head 6 +  If FunNSIGetFilteredAltPK("demand_cond_set", "cond_set", "name", 
"currency=" || IifS(rbUAH=TRUE, "'UAH'", "'USD'") || 
" and card_type=" || Str(nCardType), sPK, sSem)
.head 7 -  Set dfCondSet = Val(sPK)
.head 7 -  Set dfCondSetName = sSem
.head 7 -  Call GetCondSet()
.head 3 -  Background Text: Тривалість строку дії картки (в місяцях)
.head 4 -  Resource Id: 11432
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    2.4"
.head 5 -  Width:  4.3"
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
.head 3 +  Data Field: dfCValid
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
.head 6 -  Left:   4.55"
.head 6 -  Top:    2.35"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Вартість користування кредитом
.head 4 -  Resource Id: 11433
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    2.7"
.head 5 -  Width:  4.3"
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
.head 3 +  Data Field: dfDebIntr
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
.head 6 -  Left:   4.55"
.head 6 -  Top:    2.65"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Стягнення за овердрафт
.head 4 -  Resource Id: 11434
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    3.0"
.head 5 -  Width:  4.3"
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
.head 3 +  Data Field: dfOlimIntr
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
.head 6 -  Left:   4.55"
.head 6 -  Top:    2.95"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Відсоток на залишок по рахунку
.head 4 -  Resource Id: 11435
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    3.3"
.head 5 -  Width:  4.3"
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
.head 3 +  Data Field: dfCredIntr
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
.head 6 -  Left:   4.55"
.head 6 -  Top:    3.25"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  !
.head 3 +  Check Box: cbLimit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cCheckBoxLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ознака встановлення ліміту
.head 4 -  Window Location and Size
.head 5 -  Left:   2.5"
.head 5 -  Top:    3.55"
.head 5 -  Width:  4.8"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Message Actions
.head 3 -  !
.head 3 -  Background Text: Шаблон договору
.head 4 -  Resource Id: 11437
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    3.9"
.head 5 -  Width:  2.2"
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
.head 3 +  Data Field: dfIdDoc
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
.head 6 -  Top:    3.85"
.head 6 -  Width:  5.45"
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
.head 3 +  Data Field: dfDocName
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
.head 6 -  Top:    4.131"
.head 6 -  Width:  5.45"
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
.head 3 +  Pushbutton: pbDoc
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbFilter
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   8.05"
.head 5 -  Top:    3.845"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.3"
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
.head 5 +  On SAM_Create
.head 6 -  Set strTip = 'Шаблон договору'
.head 5 +  On SAM_Click
.head 6 +  If FunNSIGetFiltered("doc_scheme", "name", "id like 'ACC_BPK%'", sPK, sSem)
.head 7 -  Set dfIdDoc = sPK
.head 7 -  Set dfDocName = sSem
.head 3 -  !
.head 3 -  Background Text: Шаблон кред. дог.
.head 4 -  Resource Id: 11438
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    4.5"
.head 5 -  Width:  2.2"
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
.head 3 +  Data Field: dfIdDocCred
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
.head 6 -  Top:    4.45"
.head 6 -  Width:  5.45"
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
.head 3 +  Data Field: dfDocCredName
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
.head 6 -  Top:    4.738"
.head 6 -  Width:  5.45"
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
.head 3 +  Pushbutton: pbDocCred
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbFilter
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   8.05"
.head 5 -  Top:    4.452"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.3"
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
.head 5 +  On SAM_Create
.head 6 -  Set strTip = 'Шаблон кредитного договору'
.head 5 +  On SAM_Click
.head 6 +  If FunNSIGetFiltered("doc_scheme", "name", "id like 'ACC_BPK%'", sPK, sSem)
.head 7 -  Set dfIdDocCred = sPK
.head 7 -  Set dfDocCredName = sSem
.head 3 -  Frame
.head 4 -  Resource Id: 11439
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    5.15"
.head 5 -  Width:  8.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.7"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: Default
.head 3 +  Pushbutton: pbSave
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbUpdate
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Зберегти
.head 4 -  Window Location and Size
.head 5 -  Left:   6.0"
.head 5 -  Top:    5.25"
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
.head 6 -  Set sErr = ''
.head 6 +  If dfName = STRING_Null
.head 7 -  Set sErr = 'Не заповнено <Назва продукту>'
.head 7 -  Set hWinFocus = dfName
.head 6 +  Else If sType = STRING_Null
.head 7 -  Set sErr = 'Не заповнено <Тип картки>'
.head 7 -  Set hWinFocus = cmbAccType
.head 6 +  Else If dfKk  = STRING_Null
.head 7 -  Set sErr = 'Не заповнено <Категорія клієнта>'
.head 7 -  Set hWinFocus = cmbKk
.head 6 +  Else If dfNbs = STRING_Null
.head 7 -  Set sErr = 'Не заповнено <Балансовий рахунок>'
.head 7 -  Set hWinFocus = cmbNbs
.head 6 +  Else If dfOb22 = STRING_Null
.head 7 -  Set sErr = 'Не заповнено <ОБ22>'
.head 7 -  Set hWinFocus = cmbOb22
.head 6 +  Else If dfCondSet = NUMBER_Null
.head 7 -  Set sErr = 'Не заповнено <Код умови рахунку>'
.head 7 -  Set hWinFocus = pbCondSet
.head 6 +  Else If dfIdDoc = STRING_Null
.head 7 -  Set sErr = 'Не заповнено <Шаблон договору>'
.head 7 -  Set hWinFocus = pbDoc
.head 6 +  ! Else If dfIdDocCred = STRING_Null
.head 7 -           Set sErr = 'Не заповнено <Шаблон кредитного договору>'
.head 7 -           Set hWinFocus = pbDocCred
.head 6 +  If sErr
.head 7 -  Call SalMessageBox(sErr, 'Увага!', MB_IconExclamation | MB_Ok)
.head 7 -  Call SalSetFocus(hWinFocus)
.head 7 -  Return FALSE
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 +  If not SaveProduct()
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Return FALSE
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 +  If nId
.head 7 -  Call SalMessageBox("Оновлено продукт БПК №" || Str(nId), "Інформація", MB_IconAsterisk | MB_Ok)
.head 6 +  Else
.head 7 -  Call SalMessageBox("Зареєстровано новий продукт БПК", "Інформація", MB_IconAsterisk | MB_Ok)
.head 6 -  Call SalEndDialog(hWndForm, TRUE)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Відмінити
.head 4 -  Window Location and Size
.head 5 -  Left:   7.283"
.head 5 -  Top:    5.25"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
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
.head 6 -  Call SalEndDialog(hWndForm, FALSE)
.head 2 +  Functions
.head 3 +  Function: ClearCondSet
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Set dfCondSet  = NUMBER_Null
.head 5 -  Set dfCondSetName = STRING_Null
.head 5 -  Set dfCValid   = NUMBER_Null
.head 5 -  Set dfDebIntr  = NUMBER_Null
.head 5 -  Set dfOlimIntr = NUMBER_Null
.head 5 -  Set dfCredIntr = NUMBER_Null
.head 5 +  If sType
.head 6 -  Call SalEnableWindow(pbCondSet)
.head 5 +  Else
.head 6 -  Call SalDisableWindow(pbCondSet)
.head 5 -  Return TRUE
.head 3 +  Function: GetCondSet
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If not SqlPrepareAndExecute(hSql(),
"select d.c_validity, d.deb_intr, d.olim_intr, d.cred_intr
   into :dfCValid, :dfDebIntr, :dfOlimIntr, :dfCredIntr
   from demand_cond_set d
  where d.card_type = :nCardType
    and d.cond_set  = :dfCondSet")
.head 6 -  Return FALSE
.head 5 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Return FALSE
.head 5 -  Return TRUE
.head 3 +  Function: GetDoc
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If dfIdDoc
.head 6 -  Call SqlPrepareAndExecute(hSql(),
"select name into :dfDocName
   from doc_scheme
  where id = :dfIdDoc")
.head 6 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 5 +  If dfIdDocCred
.head 6 -  Call SqlPrepareAndExecute(hSql(),
"select name into :dfDocCredName
   from doc_scheme
  where id = :dfIdDocCred")
.head 6 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 5 -  Return TRUE
.head 3 +  Function: SaveProduct
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If nId
.head 6 +  If not SqlPLSQLCommand(hSql(), 
"bars_bpk.product_change(nId,dfName,sType,nKv,dfKk,dfCondSet,
cbLimit,dfNbs,dfOb22,dfIdDoc,dfIdDocCred)")
.head 7 -  Call SqlRollbackEx(hSql(), "")
.head 7 -  Return FALSE
.head 5 +  Else
.head 6 +  If not SqlPLSQLCommand(hSql(), 
"bars_bpk.product_add(NUMBER_Null,dfName,sType,nKv,dfKk,dfCondSet,
cbLimit,dfNbs,dfOb22,dfIdDoc,dfIdDocCred)")
.head 7 -  Call SqlRollbackEx(hSql(), "")
.head 7 -  Return FALSE
.head 5 -  Call SqlCommitEx(hSql(), "")
.head 5 -  Return TRUE
.head 2 +  Window Parameters
.head 3 -  Number: nId
.head 3 -  ! String: sName
.head 3 -  ! String: sType
.head 3 -  ! Number: nKv
.head 3 -  ! String: sKk
.head 3 -  ! Number: sCondSet
.head 3 -  ! String: sCondSetName
.head 3 -  ! Number: nCValidity
.head 3 -  ! Number: nDebIntr
.head 3 -  ! Number: nOlimIntr
.head 3 -  ! Number: nCredIntr
.head 3 -  ! String: sNbs
.head 3 -  ! String: sOb22
.head 3 -  ! Number: nLimit
.head 3 -  ! String: sIdDoc
.head 3 -  ! String: sIdDocCred
.head 2 +  Window Variables
.head 3 -  String: sType
.head 3 -  Number: nKv
.head 3 -  Number: nCardType
.head 3 -  Number: nCardTypeOld
.head 3 -  String: sPK
.head 3 -  String: sSem
.head 3 -  String: sErr
.head 3 -  Window Handle: hWinFocus
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 +  If nId
.head 5 -  Call SalSetWindowText(hWndForm, "Редагування продукту БПК № " || Str(nId))
.head 4 +  Else
.head 5 -  Call SalSetWindowText(hWndForm, "Реєстрація нового продукту БПК")
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  Set nCardTypeOld = NUMBER_Null
.head 4 +  If nId
.head 5 -  Call SqlPrepareAndExecute(hSql(),
"select name, type, kv, kk, cond_set, cond_set_name,
        c_validity, deb_intr, olim_intr, cred_intr,
        nbs, ob22, limit, id_doc, id_doc_cred
   into :dfName, :sType, :nKv, :dfKk, :dfCondSet, :dfCondSetName,
        :dfCValid, :dfDebIntr, :dfOlimIntr, :dfCredIntr,
        :dfNbs, :dfOb22, :cbLimit, :dfIdDoc, :dfIdDocCred
   from v_bpk_product
  where id = :nId")
.head 5 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 5 -  Call SalSetWindowText(hWndForm, "Редагування продукту БПК № " || Str(nId) || " " || dfName)
.head 5 -  Set nCardTypeOld = nCardType
.head 5 +  If nKv = 980
.head 6 -  Set rbUAH = TRUE
.head 5 +  Else
.head 6 -  Set rbUSD = TRUE
.head 5 -  Call GetDoc()
.head 4 +  Else
.head 5 -  Set rbUAH = TRUE
.head 5 -  Set nKv = 980
.head 5 -  Call SalDisableWindow(pbCondSet)
.head 4 -  Call SalSendMsg(cmbAccType, UM_ObjActivate, 0, 0)
.head 4 -  Call SalSendMsg(cmbKk, UM_ObjActivate, 0, 0)
.head 4 -  Call SalSendMsg(cmbNbs, UM_ObjActivate, 0, 0)
.head 4 -  Call SalSetFocus(pbCancel)
.head 4 -  Call SalWaitCursor(FALSE)
.head 1 +  Table Window: tblFormFileP
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Формування файлів P*
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
.head 4 -  Width:  10.4"
.head 4 -  Width Editable? Class Default
.head 4 -  Height: 5.3"
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
.head 5 -  Resource Id: 42297
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  6.283"
.head 6 -  Begin Y:  -0.036"
.head 6 -  End X:  6.283"
.head 6 -  End Y:  0.429"
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
.head 5 -  Resource Id: 18491
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  4.967"
.head 6 -  Begin Y:  -0.083"
.head 6 -  End X:  4.967"
.head 6 -  End Y:  0.381"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 +  Pushbutton: pbShowiles
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbBrowse
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.017"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\COPY.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Перегляд сформованих файлів'
.head 6 +  On SAM_Click
.head 7 -  Call FunNSIEditF("v_obpc_pfiles", 1 | 0x0010)
.head 4 +  Pushbutton: pbShowFile
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbSwitch
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.45"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\LOGFILE.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Перегляд сформованого файла'
.head 6 +  On SAM_Click
.head 7 +  If colFileName
.head 8 -  Call FunNSIEditFFiltered("v_obpc_pfiles_doc", 1, 
"file_name='" || colFileName || "' and trunc(file_date)=trunc(sysdate)")
.head 4 -  Line
.head 5 -  Resource Id: 42298
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  5.633"
.head 6 -  Begin Y:  -0.012"
.head 6 -  End X:  5.633"
.head 6 -  End Y:  0.452"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 +  Pushbutton: pbFormFiles
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbExecute
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   5.1"
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
.head 7 -  Set strTip = 'Сформувати файли'
.head 6 +  On SAM_Click
.head 7 +  If SalMessageBox("Сформувати відмічені файли?", "Питання", MB_IconQuestion | MB_YesNo) = IDYES
.head 8 -  Call ClearTable()
.head 8 -  Call FormFiles()
.head 8 -  Call SalTblSetContext(hWndForm, 0)
.head 8 -  Call SalPostMsg(hWndForm, SAM_TblDoDetails, 0, 0)
.head 4 -  Line
.head 5 -  Resource Id: 42300
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
.head 6 -  Left:   5.75"
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
.head 5 -  Resource Id: 42299
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
.head 3 +  Column: colFileChar
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Символ
файлу
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Center
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
.head 3 +  Column: colFlag
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Формувати
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  1.2"
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
.head 3 +  Column: colComments
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Результат формування
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 2000
.head 4 -  Data Type: Long String
.head 4 -  Justify: Left
.head 4 -  Width:  6.0"
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
.head 3 +  Column: colFileName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Файл
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.4"
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
.head 3 +  Function: ClearTable
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nRow
.head 4 +  Actions
.head 5 -  Set nRow = TBL_MinRow
.head 5 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 6 -  Call SalTblSetContext(hWndForm, nRow)
.head 6 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_Edited, FALSE)
.head 6 -  Set colComments = STRING_Null
.head 6 -  Set colFileName = STRING_Null
.head 5 -  Return TRUE
.head 3 +  Function: FormFiles
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nRow
.head 5 -  : cFileFormer
.head 6 -  Class: cPA_PC_Former
.head 4 +  Actions
.head 5 -  Set nRow = TBL_MinRow
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 6 -  Call SalTblSetContext(hWndForm, nRow)
.head 6 +  If colFlag
.head 7 -  ! Вызов класса формирования файла
.head 7 +  If cFileFormer.FormFile(sPath, colFileChar)
.head 8 +  If cFileFormer.sLog
.head 9 -  Set colComments = cFileFormer.sLog
.head 9 -  Call SalTblSetCellTextColor(hWndForm.tblFormFileP.colComments, COLOR_DarkRed, FALSE)
.head 8 +  Else
.head 9 -  Set colComments = "Формування успішно завершено!"
.head 9 -  Call VisTblSetRowColor(hWndForm, nRow, COLOR_Black)
.head 8 -  Set colFileName = cFileFormer.sFileFormed
.head 7 +  Else
.head 8 -  Set colComments = cFileFormer.sLog
.head 7 -  Call SaveInfoToLog('OBPC. Формування файлу P' || colFileChar || ': ' || colComments)
.head 6 +  Else
.head 7 -  Set colComments = STRING_Null
.head 6 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_Edited, FALSE)
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  Return TRUE
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  String: sPath
.head 3 -  String: sTmp
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Call SalTblSetTableFlags(hWndForm, TBL_Flag_SingleSelection, TRUE)
.head 4 -  ! Чтение параметров
.head 4 -  Call SalUseRegistry(FALSE, GetIniFileName())
.head 4 -  Call SalGetProfileString('OBPC', 'OBPCOutPath', '', sPath, GetIniFileName())
.head 4 -  !
.head 4 -  Set hWndForm.tblFormFileP.nFlags = GT_ReadOnly
.head 4 -  Set hWndForm.tblFormFileP.strPrintFileName = 'out_files'
.head 4 -  Set hWndForm.tblFormFileP.strSqlPopulate = 
"select unique file_char, 1
   into :hWndForm.tblFormFileP.colFileChar, :hWndForm.tblFormFileP.colFlag
   from obpc_out_files
  order by file_char"
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On SAM_DoubleClick
.head 4 -  Call SalModalDialog(dlgStatus, hWndForm, colComments, 'Статус формування файлу Р' || colFileChar)
.head 3 +  On SAM_TblDoDetails
.head 4 +  If colFileName
.head 5 -  Call SalEnableWindow(pbShowFile)
.head 4 +  Else
.head 5 -  Call SalDisableWindow(pbShowFile)
.head 1 +  Table Window: tblDeleteTran
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Необроблені транзвкції TRAN
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
.head 4 -  Width:  14.5"
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
.head 7 -  Set strTip = 'Видалити транзакцію'
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
.head 5 -  Resource Id: 55827
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
.head 5 -  Resource Id: 55829
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
.head 4 +  Pushbutton: pbKvtTran
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbOk
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.017"
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
.head 7 -  Set strTip = 'Сквітувати транзакцію'
.head 6 +  On SAM_Click
.head 7 +  If colIdn
.head 8 +  If SalModalDialog(dlgKvtTran, hWndForm, colId, colIdn, colCardAcct, colCurrency, colTranType, colAmount, colTranDate)
.head 9 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 4 -  Line
.head 5 -  Resource Id: 55828
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  5.217"
.head 6 -  Begin Y:  0.0"
.head 6 -  End X:  5.217"
.head 6 -  End Y:  0.464"
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
.head 6 -  Left:   4.683"
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
.head 5 -  Resource Id: 55830
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
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
файлу
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
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
.head 3 +  Column: colFileName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ім'я
файлу
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 3
.head 4 -  Data Type: String
.head 4 -  Justify: Center
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
.head 3 +  Column: colCardAcct
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Технічний
рахунок
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.4"
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
.head 6 -  Set sTmp = colCardAcct
.head 5 +  On SAM_AnyEdit
.head 6 -  Set colCardAcct = sTmp
.head 6 -  Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
.head 3 +  Column: colCurrency
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вал.
рах.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 3
.head 4 -  Data Type: String
.head 4 -  Justify: Center
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
.head 3 +  ! Column: colCcy
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вал. 
оп.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 3
.head 4 -  Data Type: String
.head 4 -  Justify: Center
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
.end
.head 4 -    List Values 
.head 4 -    Message Actions 
.head 3 +  Column: colLacct
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Картковий
рахунок
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
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
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Set sTmp = colLacct
.head 5 +  On SAM_AnyEdit
.head 6 -  Set colLacct = sTmp
.head 6 -  Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
.head 3 +  Column: colAmount
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сума в вал.
рахунку
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.2"
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
.head 3 +  Column: colTranType
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Тип
транз.
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
.head 3 +  Column: colTranRuss
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Назва операції
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
.head 3 +  Column: colTranDate
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
операції
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
.head 3 +  ! Column: colCard
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: №
картки
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
.end
.head 4 -    List Values 
.head 4 -    Message Actions 
.head 3 +  ! Column: colSlipNr
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: №
сліпу
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
.end
.head 4 -    List Values 
.head 4 -    Message Actions 
.head 3 +  ! Column: colBatchNr
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: №
пакету
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
.end
.head 4 -    List Values 
.head 4 -    Message Actions 
.head 3 +  Column: colAbvrName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Назва
MERCHANT
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
.head 3 +  Column: colCity
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Місто
MERCHANT
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
.head 3 +  Column: colMerchant
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: MERCHANT
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
.head 3 +  ! Column: colTranAmt
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сума
операції
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.2"
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
.end
.head 4 -    List Values 
.head 4 -    Message Actions 
.head 3 +  ! Column: colPostDate
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дота
обробки
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
.end
.head 4 -    List Values 
.head 4 -    Message Actions 
.head 3 +  ! Column: colCardType
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Тип
картки
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
.end
.head 4 -    List Values 
.head 4 -    Message Actions 
.head 3 +  ! Column: colCountry
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Країна
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Center
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
.end
.head 4 -    List Values 
.head 4 -    Message Actions 
.head 3 +  ! Column: colMccCode
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код торг.
точки
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
.end
.head 4 -    List Values 
.head 4 -    Message Actions 
.head 3 +  ! Column: colTerminal
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
терміналу
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Center
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
.end
.head 4 -    List Values 
.head 4 -    Message Actions 
.head 3 +  Column: colBranch
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Відділення
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
.head 3 +  Column: colIdn
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: №
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
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
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  Number: nCount
.head 3 -  Number: nRow
.head 3 -  String: sTmp
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Set hWndForm.tblDeleteTran.nFlags = GT_NoIns | GT_NoUpd
.head 4 -  Set hWndForm.tblDeleteTran.strFilterTblName = "v_obpc_tran"
.head 4 -  Set hWndForm.tblDeleteTran.strPrintFileName = "tran"
.head 4 -  Set hWndForm.tblDeleteTran.strSqlPopulate = 
"select id, file_name, card_acct, currency, tran_date, tran_type,
        abvr_name, city, merchant, amount, tran_russ, lacct, branch, idn
   into :hWndForm.tblDeleteTran.colId, :hWndForm.tblDeleteTran.colFileName, 
        :hWndForm.tblDeleteTran.colCardAcct, :hWndForm.tblDeleteTran.colCurrency,
        :hWndForm.tblDeleteTran.colTranDate, :hWndForm.tblDeleteTran.colTranType,
        :hWndForm.tblDeleteTran.colAbvrName, :hWndForm.tblDeleteTran.colCity, :hWndForm.tblDeleteTran.colMerchant,
        :hWndForm.tblDeleteTran.colAmount, :hWndForm.tblDeleteTran.colTranRuss, 
        :hWndForm.tblDeleteTran.colLacct, :hWndForm.tblDeleteTran.colBranch, :hWndForm.tblDeleteTran.colIdn
   from v_obpc_tran
  order by id, tran_date, tran_type, amount"
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On UM_Populate
.head 4 -  Set nCount = 0
.head 4 -  Call SalSendClassMessage(UM_Populate, 0, 0)
.head 4 -  Call SalTblDefineSplitWindow(hWndForm, 1, TRUE)
.head 4 -  Set nRow = SalTblInsertRow(hWndForm, TBL_MinRow)
.head 4 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 4 -  Call SalTblSetContext(hWndForm, nRow)
.head 4 -  Set colCardAcct = 'Всього: ' || Str(nCount)
.head 3 +  On SAM_FetchRowDone
.head 4 -  Set nCount = nCount + 1
.head 3 +  On UM_Delete
.head 4 +  If SalTblAnyRows(hWndForm, ROW_Selected, 0)
.head 5 +  If SalMessageBox('Видалити виділені необроблені транзакції?', 'Увага!', MB_IconQuestion | MB_YesNo) = IDYES
.head 6 -  Set nRow = TBL_MinRow
.head 6 +  While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
.head 7 -  Call SalTblSetContext(hWndForm, nRow)
.head 7 +  If SqlPLSQLCommand(hSql(), "obpc.delete_tran(colIdn)")
.head 8 -  Call SqlCommitEx(hSql(), "OBPC. Удалена транзакция в архив, idn=" || Str(colIdn))
.head 7 +  Else
.head 8 -  Call SqlRollbackEx(hSql(), "OBPC. Неуспешное удаление транзакции в архив, idn=" || Str(colIdn))
.head 8 -  Break
.head 6 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 1 +  Dialog Box: dlgKvtTran
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Квитовка транзакції ПЦ
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  8.5"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 3.8"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
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
.head 3 -  Background Text: Референс
.head 4 -  Resource Id: 55837
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.3"
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
.head 3 +  Data Field: dfRef
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 22
.head 5 -  Data Type: Number
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.3"
.head 6 -  Top:    0.25"
.head 6 -  Width:  1.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Validate
.head 6 +  If SalIsNull(dfRef)
.head 7 -  Call SalDisableWindow(pbKvt)
.head 7 -  Set dfNls  = STRING_Null
.head 7 -  Set dfNms  = STRING_Null
.head 7 -  Set dfLcv  = STRING_Null
.head 7 -  Set dfS    = NUMBER_Null
.head 7 -  Set dfVDat = DATETIME_Null
.head 6 +  Else
.head 7 +  If searchDoc()
.head 8 -  Call SalEnableWindow(pbKvt)
.head 7 +  Else
.head 8 -  Call SalDisableWindow(pbKvt)
.head 6 -  Return VALIDATE_Ok
.head 3 -  Group Box: Документ БАРСа
.head 4 -  Resource Id: 51645
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.05"
.head 5 -  Width:  8.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 2.6"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: Рахунок
.head 4 -  Resource Id: 51646
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.6"
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
.head 3 +  Data Field: dfNls
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 14
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.3"
.head 6 -  Top:    0.55"
.head 6 -  Width:  1.6"
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
.head 3 -  Background Text: Валюта
.head 4 -  Resource Id: 51653
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.9"
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
.head 3 +  Data Field: dfLcv
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
.head 6 -  Left:   2.3"
.head 6 -  Top:    0.85"
.head 6 -  Width:  1.6"
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
.head 3 -  Background Text: Сума
.head 4 -  Resource Id: 51647
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    1.5"
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
.head 3 +  Data Field: dfS
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
.head 6 -  Left:   2.3"
.head 6 -  Top:    1.45"
.head 6 -  Width:  1.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Decimal
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Дата валютування
.head 4 -  Resource Id: 51648
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    1.8"
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
.head 3 +  Data Field: dfVDat
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
.head 6 -  Left:   2.3"
.head 6 -  Top:    1.75"
.head 6 -  Width:  1.6"
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
.head 3 +  Data Field: dfNms
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
.head 6 -  Top:    1.15"
.head 6 -  Width:  3.7"
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
.head 3 -  Group Box: Документ ПЦ
.head 4 -  Resource Id: 51649
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.2"
.head 5 -  Top:    0.05"
.head 5 -  Width:  4.1"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 2.6"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: Технічний рахунок
.head 4 -  Resource Id: 51650
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.3"
.head 5 -  Top:    0.3"
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
.head 3 +  Data Field: dfCardAcct
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
.head 6 -  Left:   6.4"
.head 6 -  Top:    0.25"
.head 6 -  Width:  1.6"
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
.head 3 -  Background Text: Картковий рахунок
.head 4 -  Resource Id: 51651
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.3"
.head 5 -  Top:    0.6"
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
.head 3 +  Data Field: dfLacct
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
.head 6 -  Left:   6.4"
.head 6 -  Top:    0.55"
.head 6 -  Width:  1.6"
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
.head 3 -  Background Text: Валюта
.head 4 -  Resource Id: 51654
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.3"
.head 5 -  Top:    0.9"
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
.head 3 +  Data Field: dfCurrency
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
.head 6 -  Left:   6.4"
.head 6 -  Top:    0.85"
.head 6 -  Width:  1.6"
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
.head 3 -  Background Text: Сума
.head 4 -  Resource Id: 51652
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.3"
.head 5 -  Top:    1.5"
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
.head 3 +  Data Field: dfAmount
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
.head 6 -  Left:   6.4"
.head 6 -  Top:    1.45"
.head 6 -  Width:  1.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Decimal
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Дата операції
.head 4 -  Resource Id: 51644
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.3"
.head 5 -  Top:    1.8"
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
.head 3 +  Data Field: dfTranDate
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
.head 6 -  Left:   6.4"
.head 6 -  Top:    1.75"
.head 6 -  Width:  1.6"
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
.head 3 +  Data Field: dfClientN
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
.head 6 -  Left:   4.3"
.head 6 -  Top:    1.15"
.head 6 -  Width:  3.7"
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
.head 3 -  Frame
.head 4 -  Resource Id: 55838
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    2.7"
.head 5 -  Width:  8.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.7"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: Default
.head 3 +  Pushbutton: pbDoc
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbDetail
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Документ
.head 4 -  Window Location and Size
.head 5 -  Left:   0.4"
.head 5 -  Top:    2.85"
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
.head 6 +  If not SalIsNull(dfRef) and not SalIsNull(dfNls)
.head 7 -  Call DocViewContentsEx(hWndForm, dfRef)
.head 3 +  Pushbutton: pbKvt
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сквитувати
.head 4 -  Window Location and Size
.head 5 -  Left:   1.6"
.head 5 -  Top:    2.845"
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
.head 6 +  If kvtTran()
.head 7 -  Call SalEndDialog(hWndForm, TRUE)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Відмінити
.head 4 -  Window Location and Size
.head 5 -  Left:   6.8"
.head 5 -  Top:    2.845"
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
.head 6 -  Call SalEndDialog(hWndForm, FALSE)
.head 2 +  Functions
.head 3 +  Function: searchDoc
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: i
.head 4 +  Actions
.head 5 +  If not SqlPrepareAndExecute(hSql(), 
"select decode(dk,:nDk,nlsb,nlsa), decode(dk,:nDk,nam_b,nam_a),
        decode(decode(dk,:nDk,nvl(kv2,kv),kv),980,'UAH','USD'),
        decode(dk,:nDk,nvl(s2,s),s)/100, vdat
   into :dfNls, :dfNms, :dfLcv, :dfS, :dfVDat
   from oper
  where ref = :dfRef")
.head 6 -  Return FALSE
.head 5 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Call SalMessageBox('Документ не знайдено!', 'Увага!', MB_IconExclamation | MB_Ok)
.head 6 -  Set dfNls  = STRING_Null
.head 6 -  Set dfNms  = STRING_Null
.head 6 -  Set dfLcv  = STRING_Null
.head 6 -  Set dfS    = NUMBER_Null
.head 6 -  Set dfVDat = DATETIME_Null
.head 6 -  Call SalSetFocus(dfRef)
.head 6 -  Return FALSE
.head 5 +  If dfNls != '' and dfLacct != '' and dfNls != dfLacct
.head 6 -  Call SalColorSet(dfNls, COLOR_IndexWindowText, COLOR_DarkRed)
.head 5 +  If dfLcv != dfCurrency
.head 6 -  Call SalColorSet(dfLcv, COLOR_IndexWindowText, COLOR_DarkRed)
.head 5 +  If dfS   != dfAmount
.head 6 -  Call SalColorSet(dfS, COLOR_IndexWindowText, COLOR_DarkRed)
.head 5 -  Call SqlPrepareAndExecute(hSql(), "select 1 into :i from obpc_tran_hist where ref = :dfRef")
.head 5 +  If SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Call SalMessageBox("Документ реф. " || Str(dfRef) || " вже сквитовано!", "Увага!", MB_IconExclamation | MB_Ok)
.head 6 -  Return FALSE
.head 5 -  Return TRUE
.head 3 +  Function: kvtTran
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If SalIsNull(dfRef)
.head 6 -  Return FALSE
.head 5 +  If dfNls != '' and dfLacct != '' and dfNls != dfLacct
.head 6 +  If SalMessageBox("Карткові рахунки транзакції та документу не співпадають!" || PutCrLf() ||
   "Сквитувати транзакцію?", "Увага!", MB_IconQuestion | MB_YesNo) = IDNO
.head 7 -  Return FALSE
.head 5 +  If dfS   != dfAmount
.head 6 +  If SalMessageBox("Суми транзакції та документу не співпадають!" || PutCrLf() ||
   "Сквитувати транзакцію?", "Увага!", MB_IconQuestion | MB_YesNo) = IDNO
.head 7 -  Return FALSE
.head 5 +  If not SqlPLSQLCommand(hSql(), "obpc.set_kvt_flag(nParId, nParIdn, dfRef, nDk)")
.head 6 -  Call SqlRollbackEx(hSql(), "OBPC. Неуспешная квитовка транзакции idn=" || Str(nParIdn))
.head 6 -  Return FALSE
.head 5 -  Call SqlCommitEx(hSql(), "OBPC. Сквитована транзация idn=" || Str(nParIdn) || " с реф." || Str(dfRef))
.head 5 -  Call SalMessageBox("Успішно сквитовано транзакцію.", "Інформація", MB_IconAsterisk | MB_Ok)
.head 5 -  Return TRUE
.head 2 +  Window Parameters
.head 3 -  Number: nParId
.head 3 -  Number: nParIdn
.head 3 -  String: sParCardAcct
.head 3 -  String: sParCurrency
.head 3 -  String: sParTranType
.head 3 -  Number: nParAmount
.head 3 -  Date/Time: dParTranDate
.head 2 +  Window Variables
.head 3 -  Number: nDk
.head 3 -  Number: nKv
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Set dfCardAcct = sParCardAcct
.head 4 -  Set dfCurrency = sParCurrency
.head 4 -  Set dfAmount   = nParAmount
.head 4 -  Set dfTranDate = dParTranDate
.head 4 -  Call SqlPrepareAndExecute(hSql(), "select lacct, client_n into :dfLacct, :dfClientN from obpc_acct where card_acct = :sParCardAcct")
.head 4 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 4 -  Call SqlPrepareAndExecute(hSql(), "select dk into :nDk from obpc_trans where tran_type = :sParTranType")
.head 4 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 4 -  Set nKv = IifN(sParCurrency='UAH', 980, 840)
.head 4 -  Call SalDisableWindow(pbKvt)
.head 1 +  Table Window: tblFormOdbDbf
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Формування odb*.dbf
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
.head 4 -  Width:  16.667"
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
.head 3 -  Maximum Rows in Memory: 100000
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
.head 7 -  Set strTip = 'Видалити рахунки з вигрузки до odb*.dbf'
.head 4 +  Combo Box: cmbDat
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenComboBox_DatId
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.05"
.head 6 -  Top:    0.1"
.head 6 -  Width:  2.0"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 3.667"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Editable? Class Default
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
.head 7 -  Call cmbDat.Init(hWndItem)
.head 7 -  Call cmbDat.Populate(hSql(), "fdat", "to_char(fdat,'dd.MM.yyyy')", "fdat", "order by fdat desc")
.head 7 -  Call cmbDat.SetSelectById(dDat)
.head 6 +  On SAM_Click
.head 7 -  Call SalSendClassMessage(SAM_Click, 0, 0)
.head 7 -  Call SalTblReset(hWndForm)
.head 7 -  Set dDat = cmbDat.dtCurrentId
.head 7 -  Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
.head 4 +  Pushbutton: pbRefresh
.head 5 -  Class Child Ref Key: 35
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.133"
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
.head 6 -  Left:   3.583"
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
.head 4 +  Pushbutton: pbSearch
.head 5 -  Class Child Ref Key: 38
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.05"
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
.head 6 -  Left:   4.5"
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
.head 5 -  Resource Id: 18683
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  8.067"
.head 6 -  Begin Y:  0.0"
.head 6 -  End X:  8.067"
.head 6 -  End Y:  0.464"
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 +  Pushbutton: pbAccount
.head 5 -  Class Child Ref Key: 39
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   5.133"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\OPEN.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Перегляд картки рахунку'
.head 4 +  Pushbutton: pbCustomer
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbDetail
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   5.567"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\CUSTPERS.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Перегляд картки клієнта'
.head 6 +  On SAM_Click
.head 7 +  Select Case colCusttype
.head 8 +  Case 2
.head 9 -  Call EditCustCorpsEx(colRnk, CVIEW_Saldo, hWndForm, 0, '', FALSE)
.head 9 -  Break
.head 8 +  Case 3
.head 9 -  Call EditCustPersonEx(colRnk, CVIEW_Saldo, hWndForm, 0, '', FALSE)
.head 9 -  Break
.head 8 +  Default
.head 9 -  Break
.head 4 +  Pushbutton: pbForm
.head 5 -  Class Child Ref Key: 36
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   6.017"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\TOMAIL.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Сформувати odb*.dbf'
.head 6 +  On SAM_Click
.head 7 +  If SalTblAnyRows(hWndForm, 0, 0)
.head 8 -  Set bErrRow = FALSE
.head 8 +  If FormOdbDbf(bErrRow)
.head 9 -  Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
.head 9 +  If bErrRow
.head 10 -  Call SalMessageBox("Для рахунків, що залишились, треба заповнити обов'язкові реквізити!" || PutCrLf() || PutCrLf() ||
     "Кожне відділення може побачити такі рахунки в довіднику 'БПК. Рахунки до Demand з помилками'" || PutCrLf() ||
     "та заповнити обов'язкові реквізити в карточці клієнта чи рахунку.",
     "Увага!", MB_IconExclamation | MB_Ok)
.head 4 +  Pushbutton: pbArc
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbBrowse
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   6.45"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.467"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\TUDASUDA.BMP
.head 5 -  Picture Transparent Color: White
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Показати відібрані до odb*.dbf рахунки'
.head 7 -  Set bArc = TRUE
.head 6 +  On SAM_Click
.head 7 -  Set sWhereFromFilter = hWndForm.tblFormOdbDbf.cF.GetFilterWhereClause(FALSE)
.head 7 +  If bArc
.head 8 -  Call SalDisableWindow(pbForm)
.head 8 -  Call SalEnableWindow(pbUnForm)
.head 8 -  Set sWhere = " and flag_odb = 1"
.head 8 -  Set strTip = 'Показати рахунки для вигрузки до odb*.dbf'
.head 7 +  Else
.head 8 -  Call SalEnableWindow(pbForm)
.head 8 -  Call SalDisableWindow(pbUnForm)
.head 8 -  Set sWhere = " and flag_odb = 0"
.head 8 -  Set strTip = 'Показати відібрані до odb*.dbf рахунки'
.head 7 -  Set hWndForm.tblFormOdbDbf.strSqlPopulate = sSelect || sWhere || 
    IifS(sWhereFromFilter="", "", " and " || sWhereFromFilter) || sOrder
.head 7 -  Call hWndForm.tblFormOdbDbf.ReInitQueryString()
.head 7 -  Set bArc = not bArc
.head 7 -  Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
.head 4 +  Pushbutton: pbUnForm
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbDetail
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   6.917"
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
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\CHKMAIL.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Зняти відмітку про вигрузку до odb*.dbf'
.head 6 +  On SAM_Click
.head 7 +  If SalMessageBox("Зняти відмітку про вигрузку до odb*.dbf для вибраних рахунків?", "Увага!", MB_IconQuestion | MB_YesNo) = IDYES
.head 8 +  If SetUnFormFlag()
.head 9 -  Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
.head 4 -  Line
.head 5 -  Resource Id: 18684
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  7.433"
.head 6 -  Begin Y:  0.06"
.head 6 -  End X:  7.433"
.head 6 -  End Y:  0.524"
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
.head 6 -  Left:   7.517"
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
.head 5 -  Resource Id: 18685
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  5.017"
.head 6 -  Begin Y:  0.083"
.head 6 -  End X:  5.017"
.head 6 -  End Y:  0.548"
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 2 +  Contents
.head 3 +  Column: colAcc
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
.head 3 +  Column: colBranch	! Branch
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Відділення
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.2"
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
.head 3 +  Column: colRnk
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
.head 3 +  Column: colCusttype
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
.head 3 +  Column: colAccType	! Тип картки
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Тип
картки
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
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
.head 3 +  Column: colCurr		! Валюта рахунку
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вал.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
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
.head 3 +  Column: colClientN	! Власник рахунку
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Власник
рахунку
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.6"
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
.head 3 +  Column: colCondSet	! N Код умови рахунку
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
умови
рахунку
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
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
.head 3 +  Column: colType		! Тип клієнта (T/F)
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Тип
клієнта
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
.head 3 +  Column: colLacct	! рахунок
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Рахунок
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
.head 3 +  Column: colBrn		! Відділення
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Відді
лення
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
.head 3 +  Column: colCrd		! N Дозволений кредит
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дозво
лений
кредит
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
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
.head 3 +  Column: colIdA		! ЗКПО
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ЗКПО
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
.head 3 +  Column: colKk		! Категорія клієнта
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кате
горія
клієнта
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
.head 3 +  Column: colWork		! Місце роботи
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Місце
роботи
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
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
.head 3 +  Column: colRegNr	! Номер реєстрації
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Номер
реєстрації
.head 4 -  Visible? No
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
.head 3 +  Column: colPhone	! Телефон 
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Телефон
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
.head 3 +  Column: colCntry	! Держава
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Держава
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
.head 3 +  Column: colPcode	! Почтовий індекс
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Індекс
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
.head 3 +  Column: colCity		! Місто
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Місто
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
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
.head 3 +  Column: colStreet	! Вулица
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вулица
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
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
.head 3 +  Column: colOffice	! Посада
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Посада
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
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
.head 3 +  Column: colPhoneW	! Телефон місця роботи
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Телефон
місця
роботи
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
.head 3 +  Column: colCntryW	! Держава місця роботи
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Держава
місця
роботи
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
.head 3 +  Column: colPcodeW	! Почтовий індекс місця роботи
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Індекс
місця
роботи
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
.head 3 +  Column: colCityW	! Місто місця роботи
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Місто
місця
роботи
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
.head 3 +  Column: colStreetW	! Вулица місця роботи
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вулица
місця
роботи
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
.head 3 +  Column: colMinBal	! N Мінімальний баланс
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Мінімальний
баланс
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
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
.head 3 +  Column: colDeposit	! N Сума депозиту
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сума
депозиту
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
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
.head 3 +  Column: colResident	! Резидент/Не резидент
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Резид./
Не резид.
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
.head 3 +  Column: colName		! Ім'я та прізвище на картке
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ім'я та прізвище
на картке
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
.head 3 +  Column: colIdC		! Паспорт
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Паспорт
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
.head 3 +  Column: colBDate	! Дата народження матері
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
народж.
матері
.head 4 -  Visible? No
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
.head 3 +  Column: colMname	! Дівоче прізвище матері
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дівоче
прізвище
матері
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
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
.head 3 +  Column: colMt		! Мобільний телефон
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Моб.
тел.
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
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
.head 2 +  Functions
.head 3 +  Function: isNullFields
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If SalIsNull(colCondSet)
or SalIsNull(colKk)
or SalIsNull(colWork)
or SalIsNull(colPcode)
or SalIsNull(colCity)
or SalIsNull(colStreet)
or SalIsNull(colOffice)
or SalIsNull(colName)
or SalIsNull(colMname)
.head 6 -  Return TRUE
.head 5 -  Return FALSE
.head 3 +  Function: FormOdbDbf
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Receive Boolean: bRetErrRow
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Sql Handle: hSqlDbf
.head 5 -  String: sFileName
.head 5 -  String: sFilePath
.head 5 -  Number: nRow
.head 5 -  Boolean: bFl
.head 5 -  !
.head 5 -  String: sAccType
.head 5 -  String: sCurr
.head 5 -  String: sClientN
.head 5 -  Number: nCondSet
.head 5 -  String: sType
.head 5 -  String: sLacct
.head 5 -  String: sBrn
.head 5 -  Number: nCrd
.head 5 -  String: sIdA
.head 5 -  String: sKk
.head 5 -  String: sWork
.head 5 -  String: sRegNr
.head 5 -  String: sPhone
.head 5 -  String: sCntry
.head 5 -  String: sPcode
.head 5 -  String: sCity
.head 5 -  String: sStreet
.head 5 -  String: sOffice
.head 5 -  String: sPhoneW
.head 5 -  String: sCntryW
.head 5 -  String: sPcodeW
.head 5 -  String: sCityW
.head 5 -  String: sStreetW
.head 5 -  Number: nMinBal
.head 5 -  Number: nDeposit
.head 5 -  String: sResident
.head 5 -  String: sName
.head 5 -  String: sIdC
.head 5 -  String: sBDate
.head 5 -  String: sMname
.head 5 -  String: sMt
.head 4 +  Actions
.head 5 -  Set sFileName = 'odb_' || 
    SalStrRightX('0' || Str(SalDateDay(SalDateCurrent())), 2) ||
    SalStrRightX('0' || Str(SalDateMonth(SalDateCurrent())), 2)
.head 5 -  Set sFilePath = GetPrnDir()  || '\\' || sFileName || '.dbf'
.head 5 +  If SalFileSetCurrentDirectory(GetPrnDir())
.head 6 -  Set SqlDatabase = 'dBase_Files'
.head 6 +  If SqlConnect(hSqlDbf)
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  Call VisFileDelete(sFilePath)
.head 7 -  Call SqlPrepareAndExecute(hSqlDbf,
"CREATE TABLE " || sFileName || " (
   ACC_TYPE CHAR(1), CURR CHAR(3), CLIENT_N CHAR(40), COND_SET NUMBER(3),
   TYPE CHAR(1), LACCT CHAR(16), BRN CHAR(5), CRD NUMBER(12,2),
   ID_A CHAR(10), KK CHAR(1), WORK CHAR(30), REG_NR CHAR(10),
   PHONE CHAR(11), CNTRY CHAR(15), PCODE CHAR(6), CITY CHAR(15),
   STREET CHAR(30), OFFICE CHAR(25), PHONE_W CHAR(11), CNTRY_W CHAR(15),
   PCODE_W CHAR(6), CITY_W CHAR(15), STREET_W CHAR(30),
   MIN_BAL NUMBER(12,2), DEPOSIT NUMBER(12,2), RESIDENT CHAR(1),
   NAME CHAR(24), ID_C CHAR(14), B_DATE CHAR(8), M_NAME CHAR(20), MT CHAR(10) )")
.head 7 -  Set bFl = TRUE
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 8 -  Call SalTblFetchRow(hWndForm, nRow)
.head 8 +  If isNullFields()
.head 9 -  Set bRetErrRow = TRUE
.head 8 +  Else
.head 9 -  Set sAccType = colAccType
.head 9 -  Set sCurr    = colCurr
.head 9 -  Set sClientN = StrWinToDosX(colClientN)
.head 9 -  Set nCondSet = IifN(colCondSet=NUMBER_Null, 0, colCondSet)
.head 9 -  Set sType    = colType
.head 9 -  Set sLacct   = colLacct
.head 9 -  Set sBrn     = IifS(colBrn=STRING_Null, '-', colBrn)
.head 9 -  Set nCrd     = colCrd
.head 9 -  Set sIdA     = IifS(colIdA=STRING_Null, '0', colIdA)
.head 9 -  Set sKk      = IifS(colKk=STRING_Null, 'A', colKk)
.head 9 -  Set sWork    = IifS(colWork=STRING_Null, '-', StrWinToDosX(colWork))
.head 9 -  Set sRegNr   = '-'
.head 9 -  Set sPhone   = IifS(colPhone=STRING_Null, '-', colPhone)
.head 9 -  Set sCntry   = IifS(colCntry=STRING_Null, '-', StrWinToDosX(colCntry))
.head 9 -  Set sPcode   = IifS(colPcode=STRING_Null, '-', StrWinToDosX(colPcode))
.head 9 -  Set sCity    = IifS(colCity=STRING_Null, '-', StrWinToDosX(colCity))
.head 9 -  Set sStreet  = IifS(colStreet=STRING_Null, '-', StrWinToDosX(colStreet))
.head 9 -  Set sOffice  = IifS(colOffice=STRING_Null, '-', StrWinToDosX(colOffice))
.head 9 -  Set sPhoneW  = IifS(colPhoneW=STRING_Null, '-', colPhoneW)
.head 9 -  Set sCntryW  = IifS(colCntryW=STRING_Null, '-', StrWinToDosX(colCntryW))
.head 9 -  Set sPcodeW  = IifS(colPcodeW=STRING_Null, '-', StrWinToDosX(colPcodeW))
.head 9 -  Set sCityW   = IifS(colCityW=STRING_Null, '-', StrWinToDosX(colCityW))
.head 9 -  Set sStreetW = IifS(colStreetW=STRING_Null, '-', StrWinToDosX(colStreetW))
.head 9 -  Set nMinBal  = colMinBal
.head 9 -  Set nDeposit = colDeposit
.head 9 -  Set sResident= colResident
.head 9 -  Set sName    = IifS(colName=STRING_Null, '-', StrWinToDosX(colName))
.head 9 -  Set sIdC     = IifS(colIdC=STRING_Null, '-', StrWinToDosX(colIdC))
.head 9 -  Set sBDate   = '01011900'
.head 9 -  Set sMname   = IifS(colMname=STRING_Null, '-', StrWinToDosX(colMname))
.head 9 -  Set sMt      = '0'
.head 9 -  Set bFl = SqlPrepareAndExecute(hSqlDbf,
"INSERT INTO " || sFileName || "
 VALUES (:sAccType, :sCurr, :sClientN, :nCondSet, :sType,
   :sLacct, :sBrn, :nCrd, :sIdA, :sKk, :sWork, :sRegNr, 
   :sPhone, :sCntry, :sPcode, :sCity, :sStreet, :sOffice,
   :sPhoneW, :sCntryW, :sPcodeW, :sCityW, :sStreetW, 
   :nMinBal, :nDeposit, :sResident, :sName, :sIdC, :sBDate, :sMname, :sMt)")
.head 9 +  If not bFl
.head 10 -  Break
.head 9 -  Set bFl = SqlPLSQLCommand(hSql(), "accreg.setAccountwParam(colAcc, 'PK_ODB', '1')")
.head 9 +  If not bFl
.head 10 -  Break
.head 7 +  If bFl
.head 8 -  Call SqlCommit(hSqlDbf)
.head 8 -  Call SqlCommit(hSql())
.head 8 -  Call SalMessageBox("Файл " || sFilePath || " сформовано", "Повідомлення", MB_IconAsterisk | MB_Ok)
.head 7 +  Else
.head 8 -  Call SqlRollback(hSqlDbf)
.head 8 -  Call SqlRollback(hSql())
.head 7 -  Call SqlDisconnect(hSqlDbf)
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  Return TRUE
.head 3 +  Function: SetUnFormFlag
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Set nRow = TBL_MinRow
.head 5 +  While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
.head 6 -  Call SalTblSetContext(hWndForm, nRow)
.head 6 +  If SqlPLSQLCommand(hSql(), "accreg.setAccountwParam(colAcc, 'PK_ODB', '')")
.head 7 -  Call SqlCommit(hSql())
.head 6 +  Else
.head 7 -  Call SqlRollback(hSql())
.head 7 -  Break
.head 5 -  Return TRUE
.head 3 +  Function: DeleteRows
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nRow
.head 4 +  Actions
.head 5 -  Set nRow = TBL_MinRow
.head 5 +  While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
.head 6 -  Call SalTblSetContext(hWndForm, nRow)
.head 6 -  Call SalTblDeleteRow(hWndForm, nRow, TBL_NoAdjust)
.head 6 -  Set nRow = nRow - 1
.head 5 -  Return TRUE
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  Date/Time: dDat
.head 3 -  Boolean: bArc
.head 3 -  String: sSelect
.head 3 -  String: sWhere
.head 3 -  String: sOrder
.head 3 -  String: sWhereFromFilter
.head 3 -  Boolean: bErrRow
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Call SqlPrepareAndExecute(hSql(), "select max(fdat) into :hWndForm.tblFormOdbDbf.dDat from fdat where fdat < bankdate")
.head 4 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 4 -  Call SalDisableWindow(pbUnForm)
.head 4 -  !
.head 4 -  Set hWndForm.tblFormOdbDbf.nFlags = GT_NoIns
.head 4 -  Set hWndForm.tblFormOdbDbf.strFilterTblName = "v_bpk_odb"
.head 4 -  Set hWndForm.tblFormOdbDbf.strPrintFileName = "bpk_odb"
.head 4 -  Set sSelect = "
select acc, branch, rnk, custtype, acc_type, curr, client_n, cond_set, type, lacct, brn,
       crd, id_a, kk, work, reg_nr, phone, cntry, pcode, city, street, office,
       phone_w, cntry_w, pcode_w, city_w, street_w, 
       min_bal, deposit, resident, name, id_c, b_date, m_name, mt
  into :hWndForm.tblFormOdbDbf.colAcc, :hWndForm.tblFormOdbDbf.colBranch, :hWndForm.tblFormOdbDbf.colRnk,
       :hWndForm.tblFormOdbDbf.colCusttype, :hWndForm.tblFormOdbDbf.colAccType,
       :hWndForm.tblFormOdbDbf.colCurr, :hWndForm.tblFormOdbDbf.colClientN,
       :hWndForm.tblFormOdbDbf.colCondSet, :hWndForm.tblFormOdbDbf.colType,
       :hWndForm.tblFormOdbDbf.colLacct, :hWndForm.tblFormOdbDbf.colBrn,
       :hWndForm.tblFormOdbDbf.colCrd, :hWndForm.tblFormOdbDbf.colIdA,
       :hWndForm.tblFormOdbDbf.colKk, :hWndForm.tblFormOdbDbf.colWork,
       :hWndForm.tblFormOdbDbf.colRegNr, :hWndForm.tblFormOdbDbf.colPhone,
       :hWndForm.tblFormOdbDbf.colCntry, :hWndForm.tblFormOdbDbf.colPcode,
       :hWndForm.tblFormOdbDbf.colCity, :hWndForm.tblFormOdbDbf.colStreet, :hWndForm.tblFormOdbDbf.colOffice,
       :hWndForm.tblFormOdbDbf.colPhoneW, :hWndForm.tblFormOdbDbf.colCntryW,
       :hWndForm.tblFormOdbDbf.colPcodeW, :hWndForm.tblFormOdbDbf.colCityW, :hWndForm.tblFormOdbDbf.colStreetW, 
       :hWndForm.tblFormOdbDbf.colMinBal, :hWndForm.tblFormOdbDbf.colDeposit,
       :hWndForm.tblFormOdbDbf.colResident, :hWndForm.tblFormOdbDbf.colName,
       :hWndForm.tblFormOdbDbf.colIdC, :hWndForm.tblFormOdbDbf.colBDate,
       :hWndForm.tblFormOdbDbf.colMname, :hWndForm.tblFormOdbDbf.colMt
  from v_bpk_odb
 where daos = :hWndForm.tblFormOdbDbf.dDat"
.head 4 -  Set sWhere = " and flag_odb = 0"
.head 4 -  Set sOrder = " order by branch, client_n"
.head 4 -  Set hWndForm.tblFormOdbDbf.strSqlPopulate = sSelect || sWhere || sOrder
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On UM_Populate
.head 4 -  Set sWhereFromFilter = hWndForm.tblFormOdbDbf.cF.GetFilterWhereClause(FALSE)
.head 4 +  If sWhereFromFilter
.head 5 -  Call SalSetWindowText(hWndForm, "Формування odb*.dbf [Фільтр]")
.head 4 +  Else
.head 5 -  Call SalSetWindowText(hWndForm, "Формування odb*.dbf")
.head 4 +  If bArc
.head 5 -  Set sWhere = " and flag_odb = 0"
.head 4 +  Else
.head 5 -  Set sWhere = " and flag_odb = 1"
.head 4 -  Set hWndForm.tblFormOdbDbf.strSqlPopulate = sSelect || sWhere || 
    IifS(sWhereFromFilter="", "", " and " || sWhereFromFilter) || sOrder
.head 4 -  Call hWndForm.tblFormOdbDbf.ReInitQueryString()
.head 4 -  Call SalSendClassMessage(UM_Populate, 0, 0)
.head 3 +  On SAM_FetchRowDone
.head 4 +  If SalIsNull(colCondSet)
.head 5 -  Call XSalTblSetCellBackColor(colCondSet, SalColorFromRGB(250, 170, 170))
.head 4 +  If SalIsNull(colIdA)
.head 5 -  Call XSalTblSetCellBackColor(colIdA, SalColorFromRGB(250, 170, 170))
.head 4 +  If SalIsNull(colKk)
.head 5 -  Call XSalTblSetCellBackColor(colKk, SalColorFromRGB(250, 170, 170))
.head 4 +  If SalIsNull(colWork)
.head 5 -  Call XSalTblSetCellBackColor(colWork, SalColorFromRGB(250, 170, 170))
.head 4 +  If SalIsNull(colPcode)
.head 5 -  Call XSalTblSetCellBackColor(colPcode, SalColorFromRGB(250, 170, 170))
.head 4 +  If SalIsNull(colCity)
.head 5 -  Call XSalTblSetCellBackColor(colCity, SalColorFromRGB(250, 170, 170))
.head 4 +  If SalIsNull(colStreet)
.head 5 -  Call XSalTblSetCellBackColor(colStreet, SalColorFromRGB(250, 170, 170))
.head 4 +  If SalIsNull(colOffice)
.head 5 -  Call XSalTblSetCellBackColor(colOffice, SalColorFromRGB(250, 170, 170))
.head 4 +  If SalIsNull(colName)
.head 5 -  Call XSalTblSetCellBackColor(colName, SalColorFromRGB(250, 170, 170))
.head 4 +  If SalIsNull(colMname)
.head 5 -  Call XSalTblSetCellBackColor(colMname, SalColorFromRGB(250, 170, 170))
.head 3 +  On SAM_DoubleClick
.head 4 +  If colAcc
.head 5 -  Call OperWithAccountEx(AVIEW_ALL, colAcc, colRnk, ACCESS_FULL, hWndForm, '')
.head 3 +  On UM_Delete
.head 4 +  If SalMessageBox("Видалити вибрані рахунки з вигрузки до odb*.dbf?", "Увага!", MB_IconQuestion | MB_YesNo) = IDYES
.head 5 -  Call DeleteRows()
.head 1 +  Table Window: tblReport
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: БПК. Звіт по рахунках
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
.head 4 -  Width:  12.0"
.head 4 -  Width Editable? Class Default
.head 4 -  Height: 6.0"
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
.head 3 -  Maximum Rows in Memory: 10000
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
.head 5 -  Resource Id: 43398
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
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Параметри звіту'
.head 6 +  On SAM_Click
.head 7 +  If SalModalDialog(dlgReportParams, hWndForm, smParams, nNumParams)
.head 8 -  Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
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
.head 5 -  Resource Id: 43399
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
.head 5 -  Resource Id: 43400
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
.head 3 +  Column: colCountPk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кількість
карткових
рахунків
.head 4 -  Visible? Yes
.head 4 -  Editable? Class Default
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
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
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Set nTmp = MyValue
.head 5 +  On SAM_AnyEdit
.head 6 -  Set MyValue = nTmp
.head 6 -  Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
.head 5 +  On SAM_DoubleClick
.head 6 -  Call ShowAccounts('acc_pk')
.head 3 +  Column: colCountOvr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кількість
кредитних
рахунків
.head 4 -  Visible? Yes
.head 4 -  Editable? Class Default
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
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
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Set nTmp = MyValue
.head 5 +  On SAM_AnyEdit
.head 6 -  Set MyValue = nTmp
.head 6 -  Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
.head 5 +  On SAM_DoubleClick
.head 6 -  Call ShowAccounts('acc_ovr')
.head 3 +  Column: colCount9129
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кількість
рахунків
9129
.head 4 -  Visible? Yes
.head 4 -  Editable? Class Default
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
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
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Set nTmp = MyValue
.head 5 +  On SAM_AnyEdit
.head 6 -  Set MyValue = nTmp
.head 6 -  Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
.head 5 +  On SAM_DoubleClick
.head 6 -  Call ShowAccounts('acc_9129')
.head 3 +  Column: colCount3570
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кількість
рахунків
3570
.head 4 -  Visible? Yes
.head 4 -  Editable? Class Default
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
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
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Set nTmp = MyValue
.head 5 +  On SAM_AnyEdit
.head 6 -  Set MyValue = nTmp
.head 6 -  Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
.head 5 +  On SAM_DoubleClick
.head 6 -  Call ShowAccounts('acc_3570')
.head 3 +  Column: colCount2208
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кількість
рахунків
2208
.head 4 -  Visible? Yes
.head 4 -  Editable? Class Default
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
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
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Set nTmp = MyValue
.head 5 +  On SAM_AnyEdit
.head 6 -  Set MyValue = nTmp
.head 6 -  Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
.head 5 +  On SAM_DoubleClick
.head 6 -  Call ShowAccounts('acc_2208')
.head 3 +  ! cColumnLabeled: colCountTovr
.winattr class Column:
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кількість
рахунків
техн.овердр.
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
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
.head 4 -    List Values 
.head 4 +    Message Actions 
.head 5 +    On SAM_SetFocus
.head 6 -    Set nTmp = MyValue
.head 5 +    On SAM_AnyEdit
.head 6 -    Set MyValue = nTmp
.head 6 -    Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
.head 5 +    On SAM_DoubleClick
.head 6 -    Call ShowAccounts('acc_tovr')
.head 3 +  Column: colCount2207
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кількість
рах.простр.
2207
.head 4 -  Visible? Yes
.head 4 -  Editable? Class Default
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
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
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Set nTmp = MyValue
.head 5 +  On SAM_AnyEdit
.head 6 -  Set MyValue = nTmp
.head 6 -  Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
.head 5 +  On SAM_DoubleClick
.head 6 -  Call ShowAccounts('acc_2207')
.head 3 +  Column: colCount3579
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кількість
рах.простр.
3579
.head 4 -  Visible? Yes
.head 4 -  Editable? Class Default
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
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
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Set nTmp = MyValue
.head 5 +  On SAM_AnyEdit
.head 6 -  Set MyValue = nTmp
.head 6 -  Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
.head 5 +  On SAM_DoubleClick
.head 6 -  Call ShowAccounts('acc_3579')
.head 3 +  Column: colCount2209
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кількість
рах.простр.
2209
.head 4 -  Visible? Yes
.head 4 -  Editable? Class Default
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
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
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Set nTmp = MyValue
.head 5 +  On SAM_AnyEdit
.head 6 -  Set MyValue = nTmp
.head 6 -  Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
.head 5 +  On SAM_DoubleClick
.head 6 -  Call ShowAccounts('acc_2209')
.head 2 +  Functions
.head 3 +  Function: Populate
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: i
.head 5 -  String: sDecode
.head 5 -  String: sValue
.head 5 -  String: sSubValue
.head 5 -  String: sGrouping
.head 5 -  String: sRollup
.head 5 -  String: sInto
.head 5 -  String: strSelect
.head 4 +  Actions
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 -  Call SalTblReset(hWndForm)
.head 5 -  Call HideColumns()
.head 5 -  Set sDecode   = ''
.head 5 -  Set sValue    = ''
.head 5 -  Set sSubValue = ''
.head 5 -  Set sGrouping = ''
.head 5 -  Set sRollup   = ''
.head 5 -  Set sInto     = ''
.head 5 -  Set nGrColId  = 0
.head 5 -  Set i = 0
.head 5 +  While i < nNumParams
.head 6 +  If i = 0
.head 7 -  Set sDecode = sDecode || "decode(gr_" || smParams[i,0] || ",1,'всього по банку',"
.head 6 +  Else
.head 7 -  Set sDecode = sDecode || "decode(gr_" || smParams[i,0] || ",1,'всього по '||" || smParams[i-1,0] || ","
.head 6 +  If i = nNumParams - 1
.head 7 -  Set sValue = sValue || sDecode || smParams[i,0] || SalStrRepeatX(')', i+1) || " txt, "
.head 6 +  Else
.head 7 -  Set sValue = sValue || smParams[i,0] || ", "
.head 6 -  Set sValue = sValue || "gr_" || smParams[i,0] || ", "
.head 6 -  !
.head 6 -  Set sSubValue = sSubValue || smParams[i,2] || " " || smParams[i,0] || ", "
.head 6 -  Set sGrouping = sGrouping || ", grouping(" || smParams[i,2] || ") gr_" || smParams[i,0] || ""
.head 6 -  Set sRollup   = sRollup   || IifS(sRollup='',"",", ") || smParams[i,2]
.head 6 -  !
.head 6 -  Call ApplyColumn(i*2+1, VisStrSubstitute(smParams[i,1], '~', PutCrLf()), TRUE, sInto)
.head 6 -  Call ApplyColumn(i*2+2, '', FALSE, sInto)
.head 6 -  !
.head 6 -  Set i = i + 1
.head 5 -  ! Для раскраски итогов
.head 5 +  If nNumParams >= 1
.head 6 -  Set nAllBankColId = nNumPermColumns + 2
.head 5 +  If nNumParams >= 2
.head 6 -  Set nGrColId = nNumPermColumns + 4
.head 5 -  !
.head 5 -  Set sInto = sInto || IifS(sInto='',"",",") || " :hWndForm.tblReport.colCountPk, 
     :hWndForm.tblReport.colCountOvr, :hWndForm.tblReport.colCount9129,
    :hWndForm.tblReport.colCount3570, :hWndForm.tblReport.colCount2208,
    :hWndForm.tblReport.colCount2207, :hWndForm.tblReport.colCount3579, :hWndForm.tblReport.colCount2209"
.head 5 +  !
.head 6 -  ! Set strSelect = "
select " || sValue || "
       c_pk, c_ovr, c_9129, c_k, c_d, c_tovr
  into " || sInto || "
  from (      
select " || sSubValue || "
       count(a.acc) c_pk, count(b.acc) c_ovr, count(n.acc) c_9129, 
       count(t.acc) c_tovr, count(k.acc) c_k, count(d.acc) c_d " || sGrouping || "
  from bpk_acc o, accounts a, accounts b, accounts n, accounts t,
       accounts k, accounts d, customer c
 where o.acc_pk   = a.acc and a.dazs is null
   and o.acc_ovr  = b.acc(+) and b.dazs is null
   and o.acc_tovr = t.acc(+) and t.dazs is null
   and o.acc_3570 = k.acc(+) and k.dazs is null
   and o.acc_2208 = d.acc(+) and d.dazs is null
   and o.acc_9129 = n.acc(+) and n.dazs is null
   and a.rnk = c.rnk " || IifS(sRollup='',"","group by rollup (" || sRollup || ")") || ")"
.head 5 -  Set strSelect = "
select " || sValue || "
       c_pk, c_ovr, c_9129, c_k, c_d, c_2207, c_3579, c_2209
  into " || sInto || "
  from (      
select " || sSubValue || "
       count(a.acc) c_pk, count(b.acc) c_ovr, count(n.acc) c_9129, count(k.acc) c_k, count(d.acc) c_d,
       count(a2207.acc) c_2207, count(a3579.acc) c_3579, count(a2209.acc) c_2209 " || sGrouping || "
  from " || sStrFrom  || "
 where " || sStrWhere || IifS(sRollup='',"","group by rollup (" || sRollup || ")") || ")"
.head 5 -  ! Call SaveInfoToLog(strSelect)
.head 5 -  Call SalTblPopulate(hWndForm, hSql(), strSelect, TBL_FillAll)
.head 5 -  Call VisTblAutoSizeColumn(hWndForm, hWndNULL)
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  Return TRUE
.head 3 +  Function: CreateColumns
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: i
.head 5 -  Number: nColId
.head 5 -  Window Handle: hCol
.head 4 +  Actions
.head 5 -  Set nNumPermColumns = 8
.head 5 -  Set nNumAutoColumns = 0
.head 5 -  Call SqlPrepareAndExecute(hSql(), "select count(*) into :nNumAutoColumns from bpk_report_params")
.head 5 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 5 -  Set nNumAutoColumns = nNumAutoColumns * 2
.head 5 -  Set i = 0 
.head 5 +  While i < nNumAutoColumns
.head 6 -  Set nColId = SalTblCreateColumn(hWndForm, i+1, 1.5, 100, '')
.head 6 -  Set hCol   = SalTblGetColumnWindow(hWndForm, nColId, COL_GetID)
.head 6 -  Call SalTblSetColumnFlags(hCol, COL_Editable, FALSE)
.head 6 -  Call SalHideWindow(hCol)
.head 6 -  Set i = i + 1
.head 5 -  Return TRUE
.head 3 +  Function: HideColumns
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: i
.head 5 -  Number: nColId
.head 5 -  Window Handle: hCol
.head 4 +  Actions
.head 5 -  Set i = 0 
.head 5 +  While i < nNumAutoColumns
.head 6 -  Set nColId = i + nNumPermColumns + 1
.head 6 -  Set hCol   = SalTblGetColumnWindow(hWndForm, nColId, COL_GetID)
.head 6 -  Call SalHideWindow(hCol)
.head 6 -  Set i = i + 1
.head 5 -  Return TRUE
.head 3 +  Function: ApplyColumn
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Number: nId
.head 5 -  String: sTitle
.head 5 -  Boolean: bVisible
.head 5 -  Receive String: sInto
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nColId
.head 5 -  Window Handle: hCol
.head 4 +  Actions
.head 5 -  Set nColId = nId + nNumPermColumns
.head 5 -  Set hCol   = SalTblGetColumnWindow(hWndForm, nColId, COL_GetID)
.head 5 -  Call SalTblSetColumnTitle(hCol, sTitle)
.head 5 +  If bVisible
.head 6 -  Call SalShowWindow(hCol)
.head 5 -  Set sInto = sInto || IifS(sInto='',"",",") || ":hWndForm.tblReport#" || Str(nColId)
.head 5 -  Return TRUE
.head 3 +  Function: ShowAccounts
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: sAcc
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sFilter
.head 5 -  String: sWhere
.head 5 -  Number: i
.head 5 -  String: sText
.head 5 -  Number: nColId
.head 4 +  Actions
.head 5 -  Set sWhere = ''
.head 5 -  Set i = 0
.head 5 +  While i < nNumParams
.head 6 -  Set nColId = nNumPermColumns+i*2+1
.head 6 -  Call SalTblGetColumnText(hWndForm, nColId+1, sText)
.head 6 +  If sText = '0'
.head 7 -  Call SalTblGetColumnText(hWndForm, nColId, sText)
.head 7 +  If smParams[i,3] = 'N'
.head 8 -  Set sWhere = sWhere || " and " || smParams[i,2] || IifS(sText='', " is null", "=" || sText)
.head 7 +  Else
.head 8 -  Set sWhere = sWhere || " and " || smParams[i,2] || IifS(sText='', " is null", "='" || sText || "'")
.head 6 -  Set i = i + 1
.head 5 -  !
.head 5 -  Set sFilter = "a.acc in (select " || sAcc || " from (
select o.acc_pk, o.acc_ovr, o.acc_9129, o.acc_3570, o.acc_2208, o.acc_2207, o.acc_3579, o.acc_2209      
  from " || sStrFrom  || "
 where " || sStrWhere || sWhere || "))"
.head 5 -  ! Call SaveInfoToLog(sFilter)
.head 5 -  Call ShowAccList(0, AVIEW_ALL, AVIEW_Financial | AVIEW_Special, sFilter)
.head 5 -  Return TRUE
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  Number: nNumPermColumns	! количество постоянных колонок
.head 3 -  Number: nNumAutoColumns	! количество созданных колонок
.head 3 -  String: sParams
.head 3 -  String: smParams[*,4]
.head 3 -  Number: nNumParams
.head 3 -  Number: nGrColId
.head 3 -  Number: nAllBankColId
.head 3 -  String: strColText
.head 3 -  !
.head 3 -  Number: nTmp
.head 3 -  String: sStrFrom
.head 3 -  String: sStrWhere
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Set hWndForm.tblReport.strPrintFileName = 'bpk_report'
.head 4 -  Set hWndForm.tblReport.nFlags = GT_ReadOnly
.head 4 -  Call CreateColumns()
.head 4 -  Set sStrFrom  = 
      "bpk_all_accounts o, accounts a, accounts b, accounts n, 
       accounts k, accounts d, accounts a2207, accounts a3579, accounts a2209,
       customer c, specparam s, specparam_int i, specparam_int bi"
.head 4 -  Set sStrWhere = 
      "o.acc_pk   = a.acc    and a.dazs    is null
   and o.acc_ovr  = b.acc(+) and b.dazs(+) is null
   and o.acc_3570 = k.acc(+) and k.dazs(+) is null
   and o.acc_2208 = d.acc(+) and d.dazs(+) is null
   and o.acc_9129 = n.acc(+) and n.dazs(+) is null
   and o.acc_2207 = a2207.acc(+) and a2207.dazs(+) is null
   and o.acc_3579 = a3579.acc(+) and a3579.dazs(+) is null
   and o.acc_2209 = a2209.acc(+) and a2209.dazs(+) is null
   and a.rnk = c.rnk
   and a.acc = s.acc(+) 
   and a.acc = i.acc(+) 
   and b.acc = bi.acc(+) "
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalSendMsg(pbDetails, SAM_Click, 0, 0)
.head 3 +  On UM_Populate
.head 4 -  Call Populate()
.head 3 +  On SAM_FetchRowDone
.head 4 +  If nGrColId
.head 5 -  Call SalTblGetColumnText(hWndForm, nGrColId, strColText)
.head 5 +  If strColText = '1'
.head 6 -  Call XSalTblSetRowBackColor(hWndForm, lParam, COLOR_LightGray)
.head 4 +  If nAllBankColId
.head 5 -  Call SalTblGetColumnText(hWndForm, nAllBankColId, strColText)
.head 5 +  If strColText = '1'
.head 6 -  Call XSalTblSetRowBackColor(hWndForm, lParam, COLOR_Gray)
.head 1 +  Dialog Box: dlgReportParams
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Параметри звіту
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  9.7"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 4.5"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
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
.head 4 -  Resource Id: 43403
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.05"
.head 5 -  Width:  9.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 3.35"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: Всі параметри
.head 4 -  Resource Id: 43404
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.1"
.head 5 -  Width:  3.733"
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
.head 3 +  Child Table: tblAllParams
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.2"
.head 6 -  Top:    0.3"
.head 6 -  Width:  3.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 3.0"
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
.head 5 +  Column: colCode
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
.head 6 -  Editable? Class Default
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
.head 5 +  Column: colName
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Назва параметру
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  3.0"
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
.head 5 +  Column: colSrc
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
.head 6 -  Editable? Class Default
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
.head 5 +  Column: colType
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
.head 6 -  Editable? Class Default
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
.head 5 +  Column: colParam
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Назва параметру
.head 6 -  Visible? Class Default
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  3.0"
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
.head 4 +  Functions
.head 5 +  Function: Populate
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 7 -  String: sCode
.head 7 -  String: sName
.head 7 -  String: sSrc
.head 7 -  String: sType
.head 6 +  Actions
.head 7 -  Set nRow = 0
.head 7 -  Call SqlPrepareAndExecute(hSql(), 
"select code, name, src, type
   into :sCode, :sName, :sSrc, :sType
   from bpk_report_params
  order by name")
.head 7 +  While SqlFetchNext(hSql(), nFetchRes)
.head 8 +  If not FindParam(sCode) 
.head 9 -  Call SalTblInsertRow(hWndForm, nRow)
.head 9 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 9 -  Set colCode = sCode
.head 9 -  Set colName = sName
.head 9 -  Set colParam = VisStrSubstitute(sName,'~',' ')
.head 9 -  Set colSrc  = sSrc
.head 9 -  Set colType = sType
.head 9 -  Set nRow = nRow + 1
.head 7 -  Call SalSetFocus(hWndForm)
.head 7 -  Call SalTblSetFocusRow(hWndForm, 0)
.head 7 -  Call SalTblSetContext(hWndForm, 0)
.head 7 -  Return TRUE
.head 5 +  Function: FindParam
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: sParamCode
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Boolean: bFind
.head 7 -  Number: i
.head 6 +  Actions
.head 7 -  Set bFind = FALSE
.head 7 -  Set i = 0
.head 7 +  While i < nNumParams
.head 8 +  If smParams[i,0] = sParamCode
.head 9 -  Set bFind = TRUE
.head 9 -  Break
.head 8 -  Set i = i + 1
.head 7 -  Return bFind
.head 4 -  Window Variables
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalTblSetTableFlags(hWndForm, TBL_Flag_SingleSelection, TRUE)
.head 6 -  Call Populate()
.head 5 +  On SAM_DoubleClick
.head 6 -  Call SalSendMsg(pbAdd, SAM_Click, 0, 0)
.head 3 +  Pushbutton: pbAdd
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbInsert
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.2"
.head 5 -  Top:    0.6"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Arr2tor.bmp
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call AddParam()
.head 3 +  Pushbutton: pbDel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbDelete
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.2"
.head 5 -  Top:    0.95"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Arr2tol.bmp
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call DelParam()
.head 3 -  Background Text: Параметри звіту
.head 4 -  Resource Id: 43405
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.9"
.head 5 -  Top:    0.1"
.head 5 -  Width:  3.733"
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
.head 3 +  Child Table: tblSetParams
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   4.9"
.head 6 -  Top:    0.3"
.head 6 -  Width:  3.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 3.0"
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
.head 5 +  Column: colCode
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
.head 6 -  Editable? Class Default
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
.head 5 +  Column: colName
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Назва параметру
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  3.0"
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
.head 5 +  Column: colSrc
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
.head 6 -  Editable? Class Default
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
.head 5 +  Column: colType
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
.head 6 -  Editable? Class Default
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
.head 5 +  Column: colParam
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Назва параметру
.head 6 -  Visible? Class Default
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  3.0"
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
.head 4 +  Functions
.head 5 +  Function: Populate
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 6 +  Actions
.head 7 -  Set nRow = 0
.head 7 +  While nRow < nNumParams
.head 8 -  Call SalTblInsertRow(hWndForm, nRow)
.head 8 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 8 -  Set colCode = smParams[nRow,0]
.head 8 -  Set colName = smParams[nRow,1]
.head 8 -  Set colParam = VisStrSubstitute(smParams[nRow,1],'~',' ')
.head 8 -  Set colSrc  = smParams[nRow,2]
.head 8 -  Set colType = smParams[nRow,3]
.head 8 -  Set nRow = nRow + 1
.head 7 -  Set nTblRow = nRow
.head 7 -  Call SalSetFocus(hWndForm)
.head 7 -  Call SalTblSetFocusRow(hWndForm, 0)
.head 7 -  Call SalTblSetContext(hWndForm, 0)
.head 7 -  Return TRUE
.head 5 +  Function: Up
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 7 -  String: sCode1
.head 7 -  String: sName1
.head 7 -  String: sSrc1
.head 7 -  String: sType1
.head 7 -  String: sParam1
.head 7 -  String: sCode2
.head 7 -  String: sName2
.head 7 -  String: sSrc2
.head 7 -  String: sType2
.head 7 -  String: sParam2
.head 6 +  Actions
.head 7 -  Set nRow = SalTblQueryContext(hWndForm)
.head 7 +  If nRow > 0
.head 8 +  If colCode
.head 9 -  Set sCode1 = colCode
.head 9 -  Set sName1 = colName
.head 9 -  Set sSrc1  = colSrc
.head 9 -  Set sType1 = colType
.head 9 -  Set sParam1 = colParam
.head 9 -  Call SalTblSetContext(hWndForm, nRow-1)
.head 9 -  Set sCode2 = colCode
.head 9 -  Set sName2 = colName
.head 9 -  Set sSrc2  = colSrc
.head 9 -  Set sType2 = colType
.head 9 -  Set sParam2 = colParam
.head 9 -  Set colCode = sCode1
.head 9 -  Set colName = sName1
.head 9 -  Set colSrc  = sSrc1
.head 9 -  Set colType = sType1
.head 9 -  Set colParam = sParam1
.head 9 -  Call SalTblSetContext(hWndForm, nRow)
.head 9 -  Set colCode = sCode2
.head 9 -  Set colName = sName2
.head 9 -  Set colSrc  = sSrc2
.head 9 -  Set colType = sType2
.head 9 -  Set colParam = sParam2
.head 9 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_Selected, FALSE)
.head 9 -  Call SalSetFocus(hWndForm)
.head 9 -  Call SalTblSetFocusRow(hWndForm, nRow-1)
.head 9 -  Call SalTblSetRowFlags(hWndForm, nRow-1, ROW_Selected, TRUE)
.head 9 -  Call SalTblSetContext(hWndForm, nRow-1)
.head 7 -  Return TRUE
.head 5 +  Function: Down
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 7 -  String: sCode1
.head 7 -  String: sName1
.head 7 -  String: sSrc1
.head 7 -  String: sType1
.head 7 -  String: sParam1
.head 7 -  String: sCode2
.head 7 -  String: sName2
.head 7 -  String: sSrc2
.head 7 -  String: sType2
.head 7 -  String: sParam2
.head 6 +  Actions
.head 7 -  Set nRow = SalTblQueryContext(hWndForm)
.head 7 +  If nRow < nTblRow-1
.head 8 +  If colCode
.head 9 -  Set sCode2 = colCode
.head 9 -  Set sName2 = colName
.head 9 -  Set sSrc2  = colSrc
.head 9 -  Set sType2 = colType
.head 9 -  Set sParam2 = colParam
.head 9 -  Call SalTblSetContext(hWndForm, nRow+1)
.head 9 -  Set sCode1 = colCode
.head 9 -  Set sName1 = colName
.head 9 -  Set sSrc1  = colSrc
.head 9 -  Set sType1 = colType
.head 9 -  Set sParam1 = colParam
.head 9 -  Set colCode = sCode2
.head 9 -  Set colName = sName2
.head 9 -  Set colSrc  = sSrc2
.head 9 -  Set colType = sType2
.head 9 -  Set colParam = sParam2
.head 9 -  Call SalTblSetContext(hWndForm, nRow)
.head 9 -  Set colCode = sCode1
.head 9 -  Set colName = sName1
.head 9 -  Set colSrc  = sSrc1
.head 9 -  Set colType = sType1
.head 9 -  Set colParam = sParam1
.head 9 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_Selected, FALSE)
.head 9 -  Call SalSetFocus(hWndForm)
.head 9 -  Call SalTblSetFocusRow(hWndForm, nRow+1)
.head 9 -  Call SalTblSetRowFlags(hWndForm, nRow+1, ROW_Selected, TRUE)
.head 9 -  Call SalTblSetContext(hWndForm, nRow+1)
.head 7 -  Return TRUE
.head 5 +  Function: getParams
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nRow
.head 6 +  Actions
.head 7 -  Set nNumParams = 0
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 8 -  Call SalTblSetContext(hWndForm, nRow)
.head 8 -  Set smParams[nNumParams,0] = colCode
.head 8 -  Set smParams[nNumParams,1] = colName
.head 8 -  Set smParams[nNumParams,2] = colSrc
.head 8 -  Set smParams[nNumParams,3] = colType
.head 8 -  Set nNumParams = nNumParams + 1
.head 7 -  Return TRUE
.head 4 -  Window Variables
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalTblSetTableFlags(hWndForm, TBL_Flag_SingleSelection, TRUE)
.head 6 -  Call Populate()
.head 5 +  On SAM_DoubleClick
.head 6 -  Call SalSendMsg(pbDel, SAM_Click, 0, 0)
.head 3 +  Pushbutton: pbUp
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbSort
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   8.9"
.head 5 -  Top:    0.6"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Arr2tou.bmp
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call tblSetParams.Up()
.head 3 +  Pushbutton: pbDown
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbSort
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   8.9"
.head 5 -  Top:    0.95"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\ARR2TOD.BMP
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call tblSetParams.Down()
.head 3 -  Frame
.head 4 -  Resource Id: 43406
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    3.45"
.head 5 -  Width:  9.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.7"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: Default
.head 4 -  Background Color: Default
.head 3 +  Pushbutton: pbRefresh
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbRefresh
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Поновити
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    3.548"
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
.head 6 -  Call SalTblReset(tblAllParams)
.head 6 -  Call SalTblReset(tblSetParams)
.head 6 -  Set nNumParams = 0
.head 6 -  Call tblAllParams.Populate()
.head 3 +  Pushbutton: pbOk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Застосувати
.head 4 -  Window Location and Size
.head 5 -  Left:   6.1"
.head 5 -  Top:    3.548"
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
.head 6 -  Call tblSetParams.getParams()
.head 6 -  Call SalEndDialog(hWndForm, TRUE)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Відмінити
.head 4 -  Window Location and Size
.head 5 -  Left:   7.5"
.head 5 -  Top:    3.55"
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
.head 6 -  Call SalEndDialog(hWndForm, FALSE)
.head 2 +  Functions
.head 3 +  Function: AddParam
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nRow
.head 4 +  Actions
.head 5 +  If tblAllParams.colCode
.head 6 -  Set nRow = SalTblInsertRow(tblSetParams, TBL_MaxRow)
.head 6 -  Call SalTblSetRowFlags(tblSetParams, nRow, ROW_New, FALSE)
.head 6 -  Set tblSetParams.colCode = tblAllParams.colCode
.head 6 -  Set tblSetParams.colName = tblAllParams.colName
.head 6 -  Set tblSetParams.colSrc  = tblAllParams.colSrc
.head 6 -  Set tblSetParams.colType = tblAllParams.colType
.head 6 -  Set tblSetParams.colParam = tblAllParams.colParam
.head 6 -  Set nTblRow = nTblRow + 1
.head 6 -  Call SalTblDeleteRow(tblAllParams, SalTblQueryContext(tblAllParams), TBL_NoAdjust)
.head 5 -  Return TRUE
.head 3 +  Function: DelParam
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nRow
.head 4 +  Actions
.head 5 +  If tblSetParams.colCode
.head 6 -  Set nRow = SalTblInsertRow(tblAllParams, TBL_MaxRow)
.head 6 -  Call SalTblSetRowFlags(tblAllParams, nRow, ROW_New, FALSE)
.head 6 -  Set tblAllParams.colCode = tblSetParams.colCode
.head 6 -  Set tblAllParams.colName = tblSetParams.colName
.head 6 -  Set tblAllParams.colSrc  = tblSetParams.colSrc
.head 6 -  Set tblAllParams.colType = tblSetParams.colType
.head 6 -  Set tblAllParams.colParam = tblSetParams.colParam
.head 6 -  Set nTblRow = nTblRow - 1
.head 6 -  Call SalTblDeleteRow(tblSetParams, SalTblQueryContext(tblSetParams), TBL_NoAdjust)
.head 5 -  Return TRUE
.head 2 +  Window Parameters
.head 3 -  Receive String: smParams[*,4]
.head 3 -  Receive Number: nNumParams
.head 2 +  Window Variables
.head 3 -  Number: nTblRow
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 1 +  Table Window: XM3
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Прийом та обробка XML-файла "Зарахування з/п на БПК"
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
.head 4 -  Width:  14.433"
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
.head 6 -  Left:   0.983"
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
.head 5 -  Resource Id: 42069
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
.head 6 -  Left:   1.683"
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
.head 6 -  Left:   2.383"
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
.head 6 -  Left:   3.083"
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
.head 5 -  Resource Id: 42070
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
.head 6 -  Left:   4.483"
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
.head 5 -  Resource Id: 42071
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
.head 4 +  Pushbutton: pb_InsF
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbExecute
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.783"
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
.head 5 -  Picture File Name: \bars98\RESOURCE\BMP\DOC_IN.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Light Green
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Прийом та обробка XML-файла "Зарахування з/п на БПК"'
.head 6 +  On SAM_Click
.head 7 +  If not SalIsNull( ACC )
.head 8 -  Call Ins_File( strTip)
.head 2 +  Contents
.head 3 +  Column: BRANCH
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Бранч
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: 160
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.167"
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
.head 3 +  Column: OB22
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
Об22
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.65"
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
.head 4 -  Title: Код
Вал
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 3
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.533"
.head 4 -  Width Editable? Yes
.head 4 -  Format: #0
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
.head 4 -  Title: Рахунок
Дебет
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: 14
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.617"
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
.head 4 -  Title: Назва
Рахунку Дебет
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: 38
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
.head 3 +  Column: OKPO
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ід.код
Дебет
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: 14
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.617"
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
.head 3 +  Column: OSTC
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Залишок
Фактичний
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  2.217"
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
.head 3 +  Column: OSTB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Залишок
Плановий
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  2.133"
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
.head 3 -  !
.head 3 +  Column: ACC
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ACC
.head 4 -  Visible? No
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.4"
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
.head 3 +  Function: Ins_File
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  String: sTxt1
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strFilters[*]
.head 5 -  Number: nIndex
.head 5 -  String: strFileName
.head 5 -  String: sSPECIFIC
.head 5 -  String: sTxt
.head 4 +  Actions
.head 5 -  Set strFilters[0] = sTxt1
.head 5 -  !
.head 5 -  Set strFilters[1] = '*.xml'
.head 5 -  Set nIndex = 1
.head 5 +  If not SalDlgOpenFile ( hWndForm, 'Вибір файлу зарахувань з/п на БПК', strFilters, 2, nIndex, strFileName, sSPECIFIC )
.head 6 -  Return FALSE
.head 5 -  ! Наташина функция по загрузке файла во врем таблицу
.head 5 -  Set sTxt = 'Виконано ' || sTxt1 || ' ' || strFileName
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 +  If PutFileToTmpLob( hSql(), strFileName, 'C')
.head 6 +  ! If SqlPLSQLCommand( hSql(), "XM3 ( KV, NLS, NMS, OKPO, strFileName ) " )
.head 7 -       Call SqlCommitEx( hSql(),sTxt )
.head 7 -  !
.head 7 -       Call SalWaitCursor(FALSE)
.head 7 -       Call MessageNoWait( sTxt, 'Добрі новини',10,0)
.head 7 -       Return TRUE
.head 6 +  If SqlPLSQLCommand( hSql(), "obpc.pay_xml_file ( ACC, strFileName ) " )
.head 7 -  Call SqlCommitEx( hSql(),sTxt )
.head 7 -  !
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call MessageNoWait( sTxt, 'Добрі новини',10,0)
.head 7 -  Return TRUE
.head 5 +  Else
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Call MessageNoWait('HE ' || sTxt, 'У В А Г А, погані новини ! ', 5, 1)
.head 6 -  Return FALSE
.head 2 +  Window Parameters
.head 3 -  Number: nMode
.head 3 -  Number: nPar
.head 3 -  String: strPar01
.head 3 -  String: strPar02
.head 2 +  Window Variables
.head 3 -  Date/Time: dDat
.head 3 -  Number: n980
.head 3 -  String: aMfo
.head 3 -  String: aOkpo
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Set dDat = GetBankDate()
.head 4 -  Set n980 = GetBaseVal()
.head 4 -  Set aMfo = GetBankMfo()
.head 4 -  Set aOkpo= GetBankOkpoS()
.head 4 -  Set XM3.strFilterTblName = 'ACCOUNTS'
.head 4 -  Set XM3.strSqlPopulate =
"SELECT ACCOUNTS.BRANCH, ACCOUNTS.OB22, ACCOUNTS.KV, ACCOUNTS.NLS, ACCOUNTS.NMS,
        ACCOUNTS.OSTC/100, ACCOUNTS.OSTB/100, ACCOUNTS.ACC, c.okpo
 into :XM3.BRANCH, :XM3.OB22, :XM3.KV  , :XM3.NLS, :XM3.NMS,
      :XM3.OSTC,   :XM3.OSTB, :XM3.ACC , :XM3.OKPO
 FROM ACCOUNTS , customer c
 WHERE ACCOUNTS.KV=" || Str(n980) || "
   and ACCOUNTS.nbs='2924'
   and ACCOUNTS.dazs is null
   and ACCOUNTS.ob22 in ('01','03')
   and ACCOUNTS.rnk = c.rnk
 order by ACCOUNTS.ostc desc "
.head 4 -  !
.head 4 -  ! Call PrepareWindow( hWndForm )
.head 4 -  ! Call SetWindowFullSize(hWndForm)
.head 4 -  ! Call SalTblSetLockedColumns( hWndForm, 5 )
.head 4 -  !
.head 4 -  Call SalSendClassMessage( SAM_Create, 0, 0 )
.head 3 -  ! On SAM_FetchRowDone
.head 3 +  On SAM_DoubleClick
.head 4 +  If not SalIsNull(ACC)
.head 5 -  Call ShowAccList ( NUMBER_Null, AVIEW_ALL, AVIEW_ReadOnly | AVIEW_AllOptions,
" a.acc = " || Str(ACC)  )
.head 1 +  Form Window: frmImpProect
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Імпорт проектів на відкриття договорів БПК
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? No
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
.head 4 -  Width:  13.75"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 7.4"
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
.head 4 -  Size: 0.4"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Contents
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbPrint
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.1"
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
.head 7 -  Set strTip = 'Друк таблиці'
.head 6 +  On SAM_Click
.head 7 +  If dfFileName
.head 8 -  Call SalSendMsg(tblImp, UM_Print, 0, 0)
.head 4 +  Pushbutton: pbOpenCard
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbOk
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.55"
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
.head 7 -  Set strTip = 'Відкрити картки'
.head 6 +  On SAM_Click
.head 7 +  If dfFileName
.head 8 +  If dfBadRows > 0
.head 9 +  If dfBadRows != dfErrRows 
.head 10 -  Call CreateDeal(nId)
.head 9 +  Else
.head 10 -  Call SalMessageBox("Залишились тільки рядки з помилками!", "Інформація", MB_IconAsterisk | MB_Ok)
.head 8 +  Else
.head 9 -  Call SalMessageBox("Немає необроблених рядків!", "Інформація", MB_IconAsterisk | MB_Ok)
.head 4 -  Line
.head 5 -  Resource Id: 44422
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  1.1"
.head 6 -  Begin Y:  0.0"
.head 6 -  End X:  1.1"
.head 6 -  End Y:  0.5"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 +  Pushbutton: pbCancel
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbCancel
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.2"
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
.head 7 -  Set strTip = 'Вийти'
.head 6 +  On SAM_Click
.head 7 -  Call SalDestroyWindow(hWndForm)
.head 2 +  Contents
.head 3 -  Group Box: Файл зарплатного проекту
.head 4 -  Resource Id: 30126
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.05"
.head 5 -  Width:  4.73"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 3.1"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: 3D Shadow Color
.head 4 -  Background Color: Default
.head 3 +  Pushbutton: pbImport
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Імпортувати файл
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.3"
.head 5 -  Width:  4.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.298"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If SalDlgOpenFile(hWndForm, 'Open File', strFilters, 2, nIndex, strFile, dfPath)
.head 7 -  Set dfFileName = dfPath
.head 7 -  Call ImportFile(dfFileName)
.head 3 +  Pushbutton: pbSelect
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вибрати файл з імпортованих
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    0.7"
.head 5 -  Width:  4.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.298"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If FunNSIGetFiltered("v_bpk_imp_proect_files", "file_name", "", sPK, sSem)
.head 7 -  Set nId = Val(sPK)
.head 7 -  Call SelectFile(nId)
.head 3 +  Data Field: dfFileName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 100
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.2"
.head 6 -  Top:    1.2"
.head 6 -  Width:  4.4"
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
.head 3 -  Background Text: Рядків в файлі
.head 4 -  Resource Id: 30127
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    1.55"
.head 5 -  Width:  2.0"
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
.head 3 +  Data Field: dfAllRows
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
.head 6 -  Left:   2.3"
.head 6 -  Top:    1.5"
.head 6 -  Width:  2.3"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Оброблено
.head 4 -  Resource Id: 30128
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    1.85"
.head 5 -  Width:  2.0"
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
.head 3 +  Data Field: dfGoodRows
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
.head 6 -  Left:   2.3"
.head 6 -  Top:    1.8"
.head 6 -  Width:  2.3"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Не оброблено
.head 4 -  Resource Id: 30129
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    2.15"
.head 5 -  Width:  2.0"
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
.head 3 +  Data Field: dfBadRows
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
.head 6 -  Left:   2.3"
.head 6 -  Top:    2.1"
.head 6 -  Width:  2.3"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: З помилками
.head 4 -  Resource Id: 31719
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.2"
.head 5 -  Top:    2.45"
.head 5 -  Width:  2.0"
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
.head 3 +  Data Field: dfErrRows
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
.head 6 -  Left:   2.3"
.head 6 -  Top:    2.4"
.head 6 -  Width:  2.3"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  !
.head 3 -  Background Text: Код філії
.head 4 -  Resource Id: 57789
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.9"
.head 5 -  Top:    0.35"
.head 5 -  Width:  1.2"
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
.head 3 +  Data Field: dfFCode
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 5
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   6.2"
.head 6 -  Top:    0.3"
.head 6 -  Width:  1.0"
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
.head 3 +  Data Field: dfBranch
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
.head 6 -  Left:   7.3"
.head 6 -  Top:    0.298"
.head 6 -  Width:  5.5"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? No
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
.head 3 +  Data Field: dfFName
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
.head 6 -  Left:   7.3"
.head 6 -  Top:    0.3"
.head 6 -  Width:  5.5"
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
.head 3 +  Pushbutton: pbFiliales
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbFilter
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   12.9"
.head 5 -  Top:    0.226"
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
.head 5 +  On SAM_Create
.head 6 -  Set strTip = 'Філія'
.head 5 +  On SAM_Click
.head 6 +  If FunNSIGet("v_bpk_branch_filiales", "branch_name", sPK, sSem)
.head 7 -  Set dfBranch = sPK
.head 7 -  Call GetFilial(dfBranch)
.head 3 -  !
.head 3 -  Background Text: Відповідальний виконавець
.head 4 -  Resource Id: 57790
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.9"
.head 5 -  Top:    0.65"
.head 5 -  Width:  3.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfIspCode
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 10
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   8.2"
.head 6 -  Top:    0.6"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: MS Sans Serif
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfIspName
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
.head 6 -  Left:   9.3"
.head 6 -  Top:    0.6"
.head 6 -  Width:  3.5"
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
.head 3 +  Pushbutton: pbIsp
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbFilter
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   12.9"
.head 5 -  Top:    0.57"
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
.head 5 +  On SAM_Create
.head 6 -  Set strTip = 'Відповідальний виконавець'
.head 5 +  On SAM_Click
.head 6 +  If FunNSIGetFiltered("staff", "fio", "type=1 and active=1 " || IifS(dfBranch!='', "and branch='" || dfBranch || "'", "") || " ORDER BY fio", sPK, sSem)
.head 7 -  Set dfIspCode = Val(sPK)
.head 7 -  Call GetIsp(dfIspCode)
.head 3 -  !
.head 3 -  Group Box: Картка
.head 4 -  Resource Id: 30134
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.8"
.head 5 -  Top:    0.05"
.head 5 -  Width:  8.7"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 3.1"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: 3D Shadow Color
.head 4 -  Background Color: Default
.head 3 -  Background Text: Продукт
.head 4 -  Resource Id: 30135
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.9"
.head 5 -  Top:    0.95"
.head 5 -  Width:  1.2"
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
.head 3 +  Data Field: dfPCode
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 10
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   6.2"
.head 6 -  Top:    0.9"
.head 6 -  Width:  1.0"
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
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfPName
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
.head 6 -  Left:   7.3"
.head 6 -  Top:    0.9"
.head 6 -  Width:  5.5"
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
.head 3 +  Pushbutton: pbProduct
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbFilter
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   12.9"
.head 5 -  Top:    0.905"
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
.head 5 +  On SAM_Create
.head 6 -  Set strTip = 'Продукт'
.head 5 +  On SAM_Click
.head 6 +  ! If FunNSIGetFiltered("v_bpk_product", "name", 
"v_bpk_product.kv=" || IifS(rbUAH=TRUE, "980", "840") || 
" and custtype = "  || Str(hWndParent.frmCard.nCType) || 
IifS(sAccType='-', "", " and v_bpk_product.type='" || sAccType || "'") ||
IifS(dfKCode ='-', "", " and v_bpk_product.kk='"   || dfKCode  || "'"), sPK, sSem)
.head 7 -     Set dfPCode = Val(sPK)
.head 7 -     Set dfPName = sSem
.head 7 -     Call GetProduct()
.head 6 +  If FunNSIGetFiltered("v_bpk_product", "name", "v_bpk_product.kv=980 and custtype = 1", sPK, sSem)
.head 7 -  Set dfPCode = Val(sPK)
.head 7 -  Call GetProduct(dfPCode)
.head 3 -  Background Text: ОБ22
.head 4 -  Resource Id: 30136
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.9"
.head 5 -  Top:    1.25"
.head 5 -  Width:  1.2"
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
.head 3 +  Data Field: dfOb22
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 2
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   6.2"
.head 6 -  Top:    1.2"
.head 6 -  Width:  1.0"
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
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfOb22Name
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
.head 6 -  Left:   7.3"
.head 6 -  Top:    1.2"
.head 6 -  Width:  5.5"
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
.head 3 -  Background Text: Код умови рахунку
.head 4 -  Resource Id: 30137
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.9"
.head 5 -  Top:    1.55"
.head 5 -  Width:  4.3"
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
.head 3 +  Data Field: dfCCode
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 4
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   9.3"
.head 6 -  Top:    1.5"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfCName
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
.head 6 -  Left:   10.4"
.head 6 -  Top:    1.5"
.head 6 -  Width:  2.4"
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
.head 3 -  Background Text: Тривалість строку дії картки (в місяцях)
.head 4 -  Resource Id: 30130
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.9"
.head 5 -  Top:    1.85"
.head 5 -  Width:  4.3"
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
.head 3 +  Data Field: dfCValid
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
.head 6 -  Left:   9.3"
.head 6 -  Top:    1.8"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Вартість користування кредитом
.head 4 -  Resource Id: 30133
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.9"
.head 5 -  Top:    2.15"
.head 5 -  Width:  4.3"
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
.head 3 +  Data Field: dfDebIntr
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
.head 6 -  Left:   9.3"
.head 6 -  Top:    2.1"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Стягнення за овердрафт
.head 4 -  Resource Id: 30132
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.9"
.head 5 -  Top:    2.45"
.head 5 -  Width:  4.3"
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
.head 3 +  Data Field: dfOlimIntr
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
.head 6 -  Left:   9.3"
.head 6 -  Top:    2.4"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Відсоток на залишок по рахунку
.head 4 -  Resource Id: 30131
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.9"
.head 5 -  Top:    2.75"
.head 5 -  Width:  4.3"
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
.head 3 +  Data Field: dfCredIntr
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
.head 6 -  Left:   9.3"
.head 6 -  Top:    2.7"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  !
.head 3 +  Child Table: tblImp
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.1"
.head 6 -  Top:    3.2"
.head 6 -  Width:  13.4"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 3.4"
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
.head 5 -  Discardable? Yes
.head 4 +  Contents
.head 5 +  Column: colStrErr
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Повідомлення
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 254
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
.head 5 +  Column: colNd
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Номер
договору
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
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
.head 5 +  Column: colRnk
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: РНК
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
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
.head 5 +  Column: colNls
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Картковий
рахунок
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
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
.head 6 -  Message Actions
.head 5 +  Column: colName
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: ПІБ
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
.head 5 +  Column: colOkpo
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: ЗКПО
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
.head 5 +  Column: colAdrPcode
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Адреса:
індекс
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
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
.head 5 +  Column: colAdrDomain
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Адреса:
область
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
.head 5 +  Column: colAdrRegion
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Адреса:
район
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
.head 5 +  Column: colAdrCity
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Адреса:
місто
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
.head 5 +  Column: colAdrStreet
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Адреса:
вулиця,
дім, кв.
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
.head 5 +  Column: colPasspSer
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Паспорт:
серія
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
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
.head 5 +  Column: colPasspNumdoc
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Паспорт:
номер
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
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
.head 5 +  Column: colPasspOrgan
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Паспорт:
ким видано
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
.head 5 +  Column: colPasspDate
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Паспорт:
коли
видано
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Justify: Center
.head 6 -  Width:  1.2"
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
.head 5 +  Column: colBDay
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Дата
народж.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Justify: Center
.head 6 -  Width:  1.2"
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
.head 5 +  Column: colBPlace
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Місце
народження
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
.head 5 +  Column: colMName
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Дівоче
прізвище
матері
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
.head 5 +  Column: colWPlace
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Місце
роботи
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
.head 5 +  Column: colWOffice
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Посада
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
.head 5 +  Column: colWPhone
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Телефон
місця
роботи
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
.head 5 +  Column: colWPcode
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Почт.інд.
місця
роботи
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
.head 5 +  Column: colWCity
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Місто
місця
роботи
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
.head 5 +  Column: colWStreet
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Вулиця
місця
роботи
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
.head 4 -  Functions
.head 4 -  Window Variables
.head 4 +  Message Actions
.head 5 +  On UM_Populate
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Set dfAllRows  = 0
.head 6 -  Set dfGoodRows = 0
.head 6 -  Set dfBadRows  = 0
.head 6 -  Set dfErrRows  = 0
.head 6 -  Call SalTblPopulate(hWndForm, hSql(),
"select i.nd, i.rnk, a.nls, i.name, i.okpo, 
        i.adr_pcode, i.adr_domain, i.adr_region, i.adr_city, i.adr_street,
        i.passp_ser, i.passp_numdoc, i.passp_organ, i.passp_date,
        i.bday, i.bplace, i.mname, i.work_place, i.work_office,
        i.work_phone, i.work_pcode, i.work_city, i.work_street, i.str_err     
   into :colNd, :colRnk, :colNls, :colName, :colOkpo, 
        :colAdrPcode, :colAdrDomain, :colAdrRegion, :colAdrCity, :colAdrStreet, 
        :colPasspSer, :colPasspNumdoc, :colPasspOrgan, :colPasspDate, 
        :colBDay, :colBPlace, :colMName, :colWPlace, :colWOffice, 
        :colWPhone, :colWPcode, :colWCity, :colWStreet, :colStrErr
   from bpk_imp_proect_data i, bpk_acc o, accounts a
  where i.id = :nId
    and i.nd = o.nd(+)
    and o.acc_pk = a.acc(+)
  order by i.idn", TBL_FillAll)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On SAM_FetchRowDone
.head 6 -  Set dfAllRows  = dfAllRows  + 1
.head 6 +  If colRnk
.head 7 -  Set dfGoodRows = dfGoodRows + 1
.head 7 -  Set colStrErr  = "Оброблено"
.head 7 -  Call XSalTblSetRowBackColor(hWndForm, lParam, SalColorFromRGB(230,255,230)) ! светло-зеленый
.head 6 +  Else
.head 7 -  Set dfBadRows  = dfBadRows  + 1
.head 7 +  If SalIsNull(colName)
.head 8 -  Call XSalTblSetCellBackColor(colName, SalColorFromRGB(250, 170, 170))
.head 7 +  If SalIsNull(colOkpo)
.head 8 -  Call XSalTblSetCellBackColor(colOkpo, SalColorFromRGB(250, 170, 170))
.head 7 +  If SalIsNull(colAdrStreet)
.head 8 -  Call XSalTblSetCellBackColor(colAdrStreet, SalColorFromRGB(250, 170, 170))
.head 7 +  If SalIsNull(colPasspSer)
.head 8 -  Call XSalTblSetCellBackColor(colPasspSer, SalColorFromRGB(250, 170, 170))
.head 7 +  If SalIsNull(colPasspNumdoc)
.head 8 -  Call XSalTblSetCellBackColor(colPasspNumdoc, SalColorFromRGB(250, 170, 170))
.head 7 +  If SalIsNull(colPasspOrgan)
.head 8 -  Call XSalTblSetCellBackColor(colPasspOrgan, SalColorFromRGB(250, 170, 170))
.head 7 +  If SalIsNull(colPasspDate)
.head 8 -  Call XSalTblSetCellBackColor(colPasspDate, SalColorFromRGB(250, 170, 170))
.head 7 +  If SalIsNull(colBDay)
.head 8 -  Call XSalTblSetCellBackColor(colBDay, SalColorFromRGB(250, 170, 170))
.head 7 +  If SalIsNull(colBPlace)
.head 8 -  Call XSalTblSetCellBackColor(colBPlace, SalColorFromRGB(250, 170, 170))
.head 7 +  If SalIsNull(colMName)
.head 8 -  Call XSalTblSetCellBackColor(colMName, SalColorFromRGB(250, 170, 170))
.head 7 +  If colStrErr
.head 8 -  Call XSalTblSetCellBackColor(colStrErr, SalColorFromRGB(250, 170, 170))
.head 8 -  Set dfErrRows = dfErrRows + 1
.head 5 +  On UM_Print
.head 6 -  Call TablePrint(hWndForm, 'Файл ' || dfFileName, GetPrnDir() || '\\' || 'bpk_impfile', '')
.head 2 +  Functions
.head 3 +  Function: ImportFile
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: sPatch
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sDrive
.head 5 -  String: sDir
.head 5 -  String: sFile
.head 5 -  String: sExt
.head 5 -  String: sFilePath
.head 5 -  String: sFileName
.head 5 -  Number: nCount
.head 5 -  String: sErrMsg
.head 5 -  Number: nFileId
.head 4 +  Actions
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 -  Call VisDosSplitPath(sPatch, sDrive, sDir, sFile, sExt)
.head 5 -  Set sFilePath = sDrive || sDir
.head 5 -  Set sFileName = sFile || sExt
.head 5 -  Call SqlPrepareAndExecute(hSql(), "select count(*) into :nCount from bpk_imp_proect_files where file_name = :sFileName")
.head 5 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 5 +  If nCount
.head 6 +  If SalMessageBox("Файл " || sFileName || " вже оброблявся." || PutCrLf() || 
   "Імпортувати файл ще раз?", "Увага", MB_IconExclamation | MB_YesNo) = IDNO
.head 7 -  Set dfFileName = ''
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Return FALSE
.head 5 +  If not ImportUseMomory(sFilePath, sFileName, 'TEST_BPK_IMPPROECT', 'UKG', 1, sErrMsg)
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Set dfFileName = ''
.head 6 -  Call SalMessageBox("Помилка імпорту файла " || sFileName || ': ' || sErrMsg,
     "Помилка", MB_Ok | MB_IconStop )
.head 6 -  Call SaveInfoToLog("OBPC. " || "Помилка імпору файла " || sFileName || ': ' || sErrMsg)
.head 6 -  Return FALSE 
.head 5 +  If not SqlPLSQLCommand(hSql(), "bars_bpk.imp_proect(sFileName, nFileId)")
.head 6 -  Call SqlRollback(hSql())
.head 6 -  Set dfFileName = ''
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Return FALSE
.head 5 -  Call SqlCommit(hSql())
.head 5 -  Call SalEnableWindow(pbFiliales)
.head 5 -  Call SalEnableWindow(pbIsp)
.head 5 -  Call SalEnableWindow(pbProduct)
.head 5 -  Set nId = nFileId
.head 5 -  Call SalSendMsg(tblImp, UM_Populate, 0, 0)
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  Return TRUE
.head 3 +  Function: SelectFile
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nFileId
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 -  Call SqlPrepareAndExecute(hSql(), 
"select file_name, product_id into :dfFileName, :dfPCode
   from bpk_imp_proect_files
  where id = :nFileId")
.head 5 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 5 -  Call GetFileData(nFileId)
.head 5 +  If dfPCode
.head 6 -  Call SalDisableWindow(pbFiliales)
.head 6 -  Call SalDisableWindow(pbIsp)
.head 6 -  Call SalDisableWindow(pbProduct)
.head 5 +  Else
.head 6 -  Call SalEnableWindow(pbFiliales)
.head 6 -  Call SalEnableWindow(pbIsp)
.head 6 -  Call SalEnableWindow(pbProduct)
.head 6 -  Set dfFName = STRING_Null
.head 6 -  Set dfIspName = STRING_Null
.head 6 -  Set dfPName = STRING_Null
.head 6 -  Set dfOb22 = STRING_Null
.head 6 -  Set dfOb22Name = STRING_Null
.head 6 -  Set dfCCode = NUMBER_Null
.head 6 -  Set dfCName = STRING_Null
.head 6 -  Set dfCValid = NUMBER_Null
.head 6 -  Set dfDebIntr = NUMBER_Null
.head 6 -  Set dfOlimIntr = NUMBER_Null
.head 6 -  Set dfCredIntr = NUMBER_Null
.head 5 -  Set nId = nFileId
.head 5 -  Call SalSendMsg(tblImp, UM_Populate, 0, 0)
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  Return TRUE
.head 3 +  Function: Clear
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Set dfFileName = ''
.head 5 -  Set dfAllRows  = NUMBER_Null
.head 5 -  Set dfGoodRows = NUMBER_Null
.head 5 -  Set dfBadRows  = NUMBER_Null
.head 5 -  Set dfErrRows  = NUMBER_Null
.head 5 -  Call SalTblReset(tblImp)
.head 5 -  Return TRUE
.head 3 +  Function: GetFileData
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nFileId
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SqlPrepareAndExecute(hSql(),
"select branch, filial, isp, product_id
   into :dfBranch, :dfFCode, :dfIspCode, :dfPCode
   from bpk_imp_proect_files
  where id = :nFileId")
.head 5 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 5 -  Call GetFilial(dfBranch)
.head 5 -  Call GetIsp(dfIspCode)
.head 5 -  Call GetProduct(dfPCode)
.head 5 -  Return TRUE
.head 3 +  Function: GetFilial
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: sBranch
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If not SqlPrepareAndExecute(hSql(),
"select code, name
   into :dfFCode, :dfFName
   from v_bpk_branch_filiales
  where branch = :sBranch")
.head 6 -  Return FALSE
.head 5 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Return FALSE
.head 5 -  Return TRUE
.head 3 +  Function: GetIsp
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nIsp
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If not SqlPrepareAndExecute(hSql(),
"select fio
   into :dfIspName
   from staff$base
  where id = :nIsp")
.head 6 -  Return FALSE
.head 5 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Return FALSE
.head 5 -  Return TRUE
.head 3 +  Function: GetProduct
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nProductId
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If not dfPCode
.head 6 -  Return FALSE
.head 5 +  If not SqlPrepareAndExecute(hSql(),
"select b.name, b.cond_set, b.ob22, 
        d.name, d.c_validity, d.deb_intr, d.olim_intr, d.cred_intr, s.txt
   into :dfPName, :dfCCode, :dfOb22, 
        :dfCName, :dfCValid, :dfDebIntr, :dfOlimIntr, :dfCredIntr, :dfOb22Name
   from bpk_product b, demand_cond_set d, sb_ob22 s
  where b.id = :nProductId
    and b.card_type = d.card_type
    and b.cond_set  = d.cond_set
    and b.nbs  = s.r020
    and b.ob22 = s.ob22")
.head 6 -  Return FALSE
.head 5 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Return FALSE
.head 5 -  Return TRUE
.head 3 +  Function: CreateDeal
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nFileId
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If not dfFCode
.head 6 -  Call SalMessageBox("Не вказано код філії!", "Увага!", MB_IconExclamation | MB_Ok)
.head 6 -  Return FALSE
.head 5 +  If not dfIspCode
.head 6 -  Call SalMessageBox("Не вказано відповідального виконавця!", "Увага!", MB_IconExclamation | MB_Ok)
.head 6 -  Return FALSE
.head 5 +  If not dfPCode
.head 6 -  Call SalMessageBox("Не вказано продукт БПК!", "Увага!", MB_IconExclamation | MB_Ok)
.head 6 -  Return FALSE
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 +  If not SqlPLSQLCommand(hSql(), "bars_bpk.create_deal(nFileId, dfPCode, dfFCode, dfBranch, dfIspCode)")
.head 6 -  Call SqlRollbackEx(hSql(), "")
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Return FALSE
.head 5 -  Call SalMessageBox("Відкрито угоди по файлу " || dfFileName, "Інформація", MB_IconAsterisk | MB_Ok)
.head 5 -  Call SqlCommitEx(hSql(), "")
.head 5 -  Call SalSendMsg(tblImp, UM_Populate, 0, 0)
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  Return TRUE
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  String: strFilters[2]
.head 3 -  Number: nIndex
.head 3 -  String: strFile
.head 3 -  String: dfPath
.head 3 -  String: sPK
.head 3 -  String: sSem
.head 3 -  Number: nId
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Set strFilters[0] = 'Dbf-файли'
.head 4 -  Set strFilters[1] = '*.dbf'
.head 4 -  Call SalSetFocus(pbCancel)
.head 1 +  Form Window: frmImportAcct
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Імпорт файлу рахунків ACCT*.dbf
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
.head 4 -  Width:  6.35"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 2.0"
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
.head 3 -  Group Box: Файл для імпорту
.head 4 -  Resource Id: 46895
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.05"
.head 5 -  Width:  6.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.8"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfFileName
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 100
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.2"
.head 6 -  Top:    0.35"
.head 6 -  Width:  4.5"
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
.head 3 +  Pushbutton: pbGetPath
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вибрати
.head 4 -  Window Location and Size
.head 5 -  Left:   4.8"
.head 5 -  Top:    0.35"
.head 5 -  Width:  1.2"
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
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If SalDlgOpenFile(hWndForm, 'Open File', strFilters, 2, nIndex, strFile, dfPath)
.head 7 -  Set dfFileName = dfPath
.head 3 -  Frame
.head 4 -  Resource Id: 46896
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.9"
.head 5 -  Width:  6.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.7"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: Default
.head 4 -  Background Color: Default
.head 3 +  Pushbutton: pbOk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Імпорт
.head 4 -  Window Location and Size
.head 5 -  Left:   3.5"
.head 5 -  Top:    1.0"
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
.head 6 +  If IDYES = SalMessageBox("Виконати імпорт файлу рахунків?", "Увага!", MB_IconQuestion | MB_YesNo)
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  Call ImportAcct(dfFileName)
.head 6 -  Call SalWaitCursor(FALSE)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Відмінити
.head 4 -  Window Location and Size
.head 5 -  Left:   4.8"
.head 5 -  Top:    1.0"
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
.head 6 -  Call SalDestroyWindow(hWndForm)
.head 2 +  Functions
.head 3 +  Function: ImportAcct
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: sPatch
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sDrive
.head 5 -  String: sDir
.head 5 -  String: sFile
.head 5 -  String: sExt
.head 5 -  String: sFilePath
.head 5 -  String: sFileName
.head 5 -  String: sErrMsg
.head 4 +  Actions
.head 5 -  Call VisDosSplitPath(sPatch, sDrive, sDir, sFile, sExt)
.head 5 -  Set sFilePath = sDrive || sDir
.head 5 -  Set sFileName = sFile || sExt
.head 5 -  ! Импорт во временную таблицу
.head 5 +  If not ImportUseMomory(sFilePath, sFileName, 'TEST_OBPC_ACCT_IMP', 'UKG', 1, sErrMsg)
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Call SalMessageBox("Помилка-1 імпорту файла " || sFileName || ': ' || sErrMsg,
     "Помилка", MB_Ok | MB_IconStop)
.head 6 -  Call SaveInfoToLog("OBPC. " || "Помилка-1 імпору файла " || sFileName || ': ' || sErrMsg)
.head 6 -  Return FALSE 
.head 5 +  If not SqlPLSQLCommand(hSql(), "obpc.imp_acct(1)")
.head 6 -  Call SqlRollback(hSql())
.head 6 -  Call SalMessageBox("Помилка-2 імпорту файла " || sFileName || ': ' || sErrMsg,
     "Помилка", MB_Ok | MB_IconStop)
.head 6 -  Call SaveInfoToLog("OBPC. " || "Помилка-2 імпору файла " || sFileName || ': ' || sErrMsg)
.head 6 -  Return FALSE
.head 5 -  Call SalMessageBox("Файл успішно імпортовано", "Інформація", MB_Ok | MB_IconAsterisk)
.head 5 -  Call SaveInfoToLog("OBPC. Імпортовано повний файл рахунків " || sFileName)
.head 5 -  Call SqlCommit(hSql())
.head 5 -  Return TRUE
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  String: strFilters[2]
.head 3 -  Number: nIndex
.head 3 -  String: strFile
.head 3 -  String: dfPath
.head 3 -  ! Number: nFileId
.head 3 -  ! Number: nCount
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Set strFilters[0] = 'Dbf-файли'
.head 4 -  Set strFilters[1] = 'acct*.dbf'
