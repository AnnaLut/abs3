Application Description: ! OPENWAY.APL - функции по взаимодействию с CardMake и Way4
		! ООО Унити-Барс  (C)  2012
		! Чупахина Н.А.
		! ///////////////////////////////////////////////
	Outline Version - 4.0.26
	Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000B20000 002C000000030000 00030000000E0300 000B000000F8FFFF
0040: FFE2FFFFFF200000 0015000000EA0200 00D7010000010000 0001000000010000
0060: 000F4170706C6963 6174696F6E497465 6D00000000
.enddata
.data DT_MAKERUNDLG
0000: 0200000000001C51 3A5C424152533938 5C4C494252415259 5C4162736170692E
0020: 646C6C1C513A5C42 41525339385C4C49 42524152595C4162 736170692E617063
0040: 00000101011C513A 5C4241525339385C 4C4942524152595C 4162736170692E72
0060: 756E1C513A5C4241 525339385C4C4942 524152595C416273 6170692E646C6C1C
0080: 513A5C4241525339 385C4C4942524152 595C416273617069 2E61706300000101
00A0: 01175C4241525339 385C42494E5C6F70 656E7761792E6170 64165C4241525339
00C0: 385C42494E5C4162 736170692E646C6C 165C424152533938 5C42494E5C416273
00E0: 6170692E61706300 00010101001C513A 5C4241525339385C 4C4942524152595C
0100: 4162736170692E64 6C6C1C513A5C4241 525339385C4C4942 524152595C416273
0120: 6170692E61706300 00010101
.enddata
		Outline Window State: Normal
		Outline Window Location and Size
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
			Left:   -0.013"
			Top:    0.0"
			Width:  8.013"
			Height: 4.969"
		Options Box Location
.data VIEWINFO
0000: 0518B80BB80B2500
.enddata
.data VIEWSIZE
0000: 0800
.enddata
			Visible? Yes
			Left:   4.15"
			Top:    1.885"
			Width:  3.8"
			Height: 2.073"
		Class Editor Location
			Visible? No
			Left:   0.575"
			Top:    0.094"
			Width:  5.063"
			Height: 2.719"
		Tool Palette Location
			Visible? No
			Left:   6.388"
			Top:    0.729"
		Fully Qualified External References? Yes
		Reject Multiple Window Instances? No
		Enable Runtime Checks Of External References? Yes
		Use Release 4.0 Scope Rules? No
	Libraries
		Dynalib: Global.apd
		Dynalib: Absapi.apd
		Dynalib: nsiapi.apd
		Dynalib: docview.apd
		Dynalib: custacnt.apd
		Dynalib: CC_DOC.APD
		Dynalib: techbank.apd
		Dynalib: BARS017.APD
		Dynalib: BARS017r.APD
		File Include: GENLIST.APL
		File Include: Gentbl.apl
		File Include: Gentblf.apl
		File Include: GENTIMER.APL
		File Include: QCKTABS.APL
		File Include: VTCAL.APL
		File Include: VTCOMM.APL
		File Include: VTDOS.APL
		File Include: VTFILE.APL
		File Include: XSALCPT.APL
		File Include: XSALSPL.APL
		File Include: DOCWIS6.APL
	Global Declarations
		Window Defaults
			Tool Bar
				Display Style? Etched
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: System Default
				Text Color: System Default
				Background Color: System Default
			Form Window
				Display Style? Etched
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: System Default
				Text Color: System Default
				Background Color: System Default
			Dialog Box
				Display Style? Etched
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: System Default
				Text Color: System Default
				Background Color: System Default
			Top Level Table Window
				Font Name: Arial Cyr
				Font Size: 8
				Font Enhancement: Bold
				Text Color: System Default
				Background Color: System Window Color
			Data Field
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Multiline Field
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Spin Field
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Background Text
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Pushbutton
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
			Radio Button
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Check Box
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Option Button
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
			Group Box
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Child Table Window
				Font Name: Arial Cyr
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Use Parent
				Background Color: System Window Color
			List Box
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Combo Box
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Line
				Line Color: Use Parent
			Frame
				Border Color: Use Parent
				Background Color: 3D Face Color
			Picture
				Border Color: Use Parent
				Background Color: Use Parent
		Formats
			Number: 0'%'
			Number: #0
			Number: ###000
			Number: ###000;'($'###000')'
			Date/Time: hh:mm:ss AMPM
			Date/Time: M/d/yy
			Date/Time: MM-dd-yy
			Date/Time: dd-MMM-yyyy
			Date/Time: MMM d, yyyy
			Date/Time: MMM d, yyyy hh:mm AMPM
			Date/Time: MMMM d, yyyy hh:mm AMPM
			Input: 99/99/99
			Number: ###00000
			Date/Time: dd/MM/yyyy
			Date/Time: dd/MM/yy
			Date/Time: dd
			Date/Time: dd-MM-yyyy
			Date/Time: ddMMyy
			Date/Time: dd/MM/yyyy hhhh:mm:ss
			Date/Time: dd.MM.yyyy hhhh:mm:ss
		External Functions
			Library name: loader.dll
				Function: StartProgress
					Description: StartProgress(ParentWnd: Integer; Caption: PChar; Text: PChar)
					Export Ordinal: 0
					Returns
					Parameters
						Number: INT
						String: LPCSTR
						String: LPCSTR
				Function: StopProgress
					Description: StopProgress()
					Export Ordinal: 0
					Returns
					Parameters
				Function: UploadWay4Xml
					Description: UploadWay4Xml(ParentWnd: Integer; Caption: PChar; Text: PChar;
							Server: PChar; User: PChar; Password: PChar;
							Role: PChar; ID: Integer; Path: PChar)
					Export Ordinal: 0
					Returns
						Number: LONG
					Parameters
						Number: INT
						String: LPCSTR
						String: LPCSTR
						String: LPCSTR
						String: LPCSTR
						String: LPCSTR
						String: LPCSTR
						Number: INT
						String: LPCSTR
		Constants
.data CCDATA
0000: 3000000000000000 0000000000000000 00000000
.enddata
.data CCSIZE
0000: 1400
.enddata
			System
			User
				! 28.08.2015
				String: AppVersion = '58. '
				!
				String: ATRANSFERS = 'ATRANSFERS'
				String: FTRANSFERS = 'FTRANSFERS'
				String: STRANSFERS = 'STRANSFERS'
				String: DOCUMENTS  = 'DOCUMENTS'
				String: RIIC       = 'R_IIC_DOCUMENTS'
				! Number: OIC_ImpId  = -1
				! Number: CNG_ImpId  = -2
				! Number: IIC_ImpId  = -3
				! Number: XA_ImpId   = -4
				! Number: RIIC_ImpId = -5
				! Number: RXA_ImpId  = -6
				! Number: CRV_ImpId  = -8
				! Number: RCRV_ImpId = -9
				! OpenPack - файл на изменение реквизитов клиентов
				! Number: OP_ImpId   = -10
				! Number: ROP_ImpId  = -11
				! F*.xml
				Number: F_ImpId  = -12
				! C_CARDINFO*.xml
				! Number: C_ImpId = -13
		Resources
		Variables
			Window Handle: hWin0
			Window Handle: hWin1
			Window Handle: hWin3
			Window Handle: hWin4
			Window Handle: hWin5
			Window Handle: hWin7
			Window Handle: hWin8
			Window Handle: hWin9
			Window Handle: hWin11
			Window Handle: hWin15
			Window Handle: hWin16
			Window Handle: hWin17
			Window Handle: hWin19
			Window Handle: hWin20
			Window Handle: hWin21
			Window Handle: hWin22
			Window Handle: hWin23
			Window Handle: hWin24
			Window Handle: hWin27
			Window Handle: hWinCngImport
			! Доп.архив
			Window Handle: hWin28
			Number: nFetchRes
			Number: W4_LC
		Internal Functions
			!
			Function: OpenWay                !__exported
				Description:
				Returns
					Boolean:
				Parameters
					Window Handle: hWndParent
					Number: nMode
					Number: nPar1
					Number: nPar2
					String: strPar1
					String: strPar2
				Static Variables
				Local variables
					Number: nP1
				Actions
					Call SqlPrepareAndExecute(hSql(), "select to_number(val) into :W4_LC from ow_params where par = 'W4_LC'")
					Call SqlFetchNext(hSql(), nFetchRes)
					Call DocWisInit('frmInputDoc.')
					Select Case nMode
						Case 1		! Импорт файлов OIC*.xml
							If not IsWindow(hWin1)
								Set hWin1 = SalCreateWindow(tblImportOICFiles, hWndParent, strPar1)
							Else
								Call SalBringWindowToTop(hWin1)
							Break
						Case 2		! Импорт файла баланса
							Call ImportBalance(hWndParent)
							Break
						Case 3		! Импорт файлов ЦРВ для регистрации карточек
							If not IsWindow(hWin3)
								Set hWin3 = SalCreateWindow(frmImportFile, hWndParent, 1)
							Else
								Call SalBringWindowToTop(hWin3)
							Break
						Case 4		! Формирование файла XADVAPL*.* для регистрации карточек ЦРВ
							If W4_LC = 1
								Call SalMessageBox("Налаштовано маршрут створення карток через CardMake." || PutCrLf() ||
										     "Заборонено користуватися цією функцією.", "Повідомлення", MB_IconAsterisk | MB_Ok)
							Else
								Call ExportAccountsToW4(1)
							Break
						Case 5		! Обработка квитанций RXADVAPL*.* из Way4
							If not IsWindow(hWin5)
								Set hWin5 = SalCreateWindow(tblTickets, hWndParent, strPar1)
							Else
								Call SalBringWindowToTop(hWin5)
							Break
						Case 6		! Формирование файла пополнения/списания IIC_Documents*.xml
							Call FormIICFilesToW4(Val(strPar1))
							Break
						Case 7		! Архив файлов XA
							If not IsWindow(hWin7)
								Set hWin7 = SalCreateWindow(tblArchiveXA, hWndMDI)
							Else
								Call SalBringWindowToTop(hWin7)
							Break
						Case 8		! Архив файлов IIC
							If strPar1=''
								If not IsWindow(hWin8)
									Set nP1 = 0
									Set hWin8 = SalCreateWindow(tblArchiveIIC, hWndMDI,nP1)
								Else
									Call SalBringWindowToTop(hWin8)
							If strPar1='1'
								If not IsWindow(hWin28)
									Set nP1 = 1
									Set hWin28 = SalCreateWindow(tblArchiveIIC, hWndMDI, nP1)
								Else
									Call SalBringWindowToTop(hWin28)
							Break
						Case 9		! PkkQue - документы к отправке / несквитованные
							If not IsWindow(hWin8)
								Set hWin9 = SalCreateWindow(tblPkkQue, hWndMDI, Val(strPar1))
							Else
								Call SalBringWindowToTop(hWin9)
							Break
						Case 11		! Портфель
							If not IsWindow(hWin11)
								Set hWin11 = SalCreateWindow(tblW4Portfolio, hWndMDI, 1, strPar1)
							Else
								Call SalBringWindowToTop(hWin11)
							Break
						Case 14		! Формирование файла XADVAPL*.* для закрытия карточек ЦРВ
							If W4_LC = 1
								Call SalMessageBox("Налаштовано маршрут створення карток через CardMake." || PutCrLf() ||
										     "Заборонено користуватися цією функцією.", "Повідомлення", MB_IconAsterisk | MB_Ok)
							Else
								Call ExportAccountsToW4(0)
							Break
						Case 15         ! Импорт зарплатных проектов - открытие карточек
							If not IsWindow(hWin15)
								Set hWin15 = SalCreateWindow(frmImportProect, hWndMDI, 'SALARY')
							Else
								Call SalBringWindowToTop(hWin15)
							Break
						Case 16         ! Архив зарплатных файлов
							If not IsWindow(hWin16)
								Set hWin16 = SalCreateWindow(tblArchiveSalaryFiles, hWndMDI)
							Else
								Call SalBringWindowToTop(hWin16)
							Break
						Case 17         ! Создание запросов в Way4 по нац.карте W4V
							If W4_LC = 1
								Call SalMessageBox("Налаштовано маршрут створення карток через CardMake." || PutCrLf() ||
										     "Заборонено користуватися цією функцією.", "Повідомлення", MB_IconAsterisk | MB_Ok)
							Else
								If not IsWindow(hWin17)
									Set hWin17 = SalCreateWindow(tblLocalCard, hWndMDI)
								Else
									Call SalBringWindowToTop(hWin17)
							Break
						Case 18         ! Формирование файлов XA в Way4 по нац.карте W4V
							If W4_LC = 1
								Call SalMessageBox("Налаштовано маршрут створення карток через CardMake." || PutCrLf() ||
										     "Заборонено користуватися цією функцією.", "Повідомлення", MB_IconAsterisk | MB_Ok)
							Else
								Call FormXAFilesToW4()
							Break
						Case 19         ! Заявки в CardMake
							If not IsWindow(hWin19)
								Set hWin19 = SalCreateWindow(tblCMRequest, hWndMDI, 1, strPar1)
							Else
								Call SalBringWindowToTop(hWin19)
							Break
						Case 20         ! Заявки в CardMake - просмотр
							If not IsWindow(hWin20)
								Set hWin20 = SalCreateWindow(tblCMRequest, hWndMDI, 0, strPar1)
							Else
								Call SalBringWindowToTop(hWin20)
							Break
						Case 21         ! Миграция PK в Way4
							If not IsWindow(hWin21)
								Set hWin21 = SalCreateWindow(tblMigrPkToW4, hWndMDI)
							Else
								Call SalBringWindowToTop(hWin21)
							Break
						Case 22		! Импорт файлов для обновления реквизитов клиентов
							If not IsWindow(hWin22)
								Set hWin22 = SalCreateWindow(frmImportFile, hWndParent, 2)
							Else
								Call SalBringWindowToTop(hWin22)
							Break
						Case 23		! Запрос на крты Instant
							If not IsWindow(hWin23)
								Set hWin23 = SalCreateWindow(frmW4CardInstant, hWndParent)
							Else
								Call SalBringWindowToTop(hWin23)
							Break
						Case 24		! Петрокоммерц: Импорт файлов для обновления реквизитов клиентов
							If not IsWindow(hWin24)
								Set hWin24 = SalCreateWindow(tblImportFFiles, hWndParent)
							Else
								Call SalBringWindowToTop(hWin24)
							Break
						Case 25		! Петрокоммерц: Печать анкеты для ФГ
							Call SalModalDialog(dlgPrintAnketa, hWndParent, Val(strPar1))
							Break
						Case 26		! Формирование файла закрытых счетов для ЦРВ C*.xml
							Call FormCFilesToCrv()
							Break
						Case 27         ! Импорт файлов на открытие карточек
							If not IsWindow(hWin27)
								Set hWin27 = SalCreateWindow(frmImportProect, hWndMDI, strPar1)
							Else
								Call SalBringWindowToTop(hWin27)
							Break
						Default
							Break
					Return TRUE
			Function: OW_BackUpFile
				Description:
				Returns
					Boolean:
				Parameters
					String: sFilePath
					String: sFileName
					String: sBackUpPath
				Static Variables
				Local variables
					String: sBackUpFile
					File Handle: hF
				Actions
					If sBackUpPath = ''
						Call SalMessageBox("Не описано каталог для архіву файлів (BackUp)", "Увага!", MB_IconStop | MB_Ok)
						Return FALSE
					!
					Set sBackUpPath = sBackUpPath || '\\' || SalFmtFormatDateTime(SalDateCurrent(), 'yyMMdd')
					Set sBackUpFile = sBackUpPath || '\\' || sFileName
					!
					If not VisDosExist(sBackUpPath)
						If VisDosMakeAllDir(sBackUpPath) != VTERR_Ok
							Call SalMessageBox('Неможливо створити каталог копій - ' || sBackUpPath, 'Ошибка', MB_Ok )
							Call SaveErrorToLog('Way4. Неможливо створити каталог копій - ' || sBackUpPath)
							Return FALSE
					If SalFileCopy(sFilePath || '\\' || sFileName, sBackUpFile, TRUE) != FILE_CopyOK
						Call SalMessageBox('Неможливо скопіювати файл з ' || sFilePath || ' в ' || sBackUpPath, 'Ошибка', MB_Ok )
						Call SaveErrorToLog('Way4. Неможливо скопіювати файл з ' || sFilePath || ' в ' || sBackUpPath )
						Return FALSE
					Call SalFileOpen(hF, sFilePath || '\\' || sFileName, OF_Delete)
					Call SaveInfoToLog('Way4. Файл ' || sFileName || ' перемещен в архив дня ' || sBackUpPath)
					Return TRUE
			Function: ImportBalance
				Description:
				Returns
					Boolean:
				Parameters
					Window Handle: hWndParent
				Static Variables
				Local variables
					String: sPathImport
					String: sPathBackUp
					Number: nW4CngJobId
					Number: nFiles
					String: smFile[*]
					String: sFileName
					Number: nId
					String: sMsg
					String: sFileList
				Actions
					Call SaveInfoToLog("Way4. Импорт файла балансов")
					If IsWindow(hWinCngImport)
						Call SalMessageBox("Дочекайтесь обробки попереднього файлу балансу!", "Повідомлення", MB_IconAsterisk)
						Return TRUE
					! Чтение параметров
					Set sPathImport = GetValueStr("select substr(val,1,100) from ow_params where par = 'CNGFILEDIR'")
					Set sPathBackUp = GetValueStr("select substr(val,1,100) from ow_params where par = 'CNGBACKDIR'")
					Set nW4CngJobId = GetGlobalOptionEx("JOB_W4CNG")
					If sPathImport = ''
						Call SalMessageBox("Не описано каталог файлів CNGEXPORT", "Увага!", MB_IconStop | MB_Ok)
						Call SaveInfoToLog("Way4. Не описано каталог файлів CNGEXPORT")
						Return FALSE
					If not VisDosExist(sPathImport)
						Call SalMessageBox("Вказано неіснуючий каталог файлів CNGEXPORT: " || sPathImport, "Увага!", MB_IconStop | MB_Ok)
						Call SaveInfoToLog("Way4. Вказано неіснуючий каталог файлів CNGEXPORT: " || sPathImport)
						Return FALSE
					If not nW4CngJobId
						Call SalMessageBox("JOB!!!", "Увага!", MB_IconStop | MB_Ok)
						Call SaveInfoToLog("Way4. JOB!!!")
						Return FALSE
					! Смотрим в каталог импорта
					Set nFiles = VisDosEnumFiles(sPathImport || '\\' || 'CNGEXPORT*.*', FA_Standard, smFile)
					! Если файлов для импорта нет - выходим
					If nFiles < 0
						Call SalMessageBox("Відсутні файли для імпорта в " || sPathImport, "Увага!", MB_IconStop | MB_Ok)
						Call SaveInfoToLog("Way4. Відсутні файли для імпорта в " || sPathImport)
						Return FALSE
					! Импорт файлов
					Set sFileList = ""
					Set i = 0
					While i < nFiles
						! Импорт файла
						Set sFileName = smFile[i]
						! Импорт файла во временную таблицу
						If not LoadFile(hWndParent, 'Завантаження файлу балансів', sFileName, sPathImport || Chr(92) || sFileName, nId)
							Return FALSE
						! Импорт файла в таблицу ow_files
						If not SqlPLSQLCommand(hSql(), "bars_ow.import_file(sFileName, nId, sMsg)")
							Call SqlRollback(hSql())
							Call SaveInfoToLog("Way4. Неуспешная загрузка файла " || sFileName )
							Return FALSE
						Call SqlCommit(hSql())
						! Если ошибка - выходим
						If sMsg
							Call SalMessageBox("Помилка імпорту: " || sMsg, "Помилка", MB_IconAsterisk)
							Call SaveInfoToLog("Way4. " || sFileName || "- Помилка імпорту: " || sMsg )
							Return FALSE
						! Помещаем файл в архив
						Call OW_BackUpFile(sPathImport, sFileName, sPathBackUp)
						Set sFileList = IifS(sFileList="", "", sFileList || ",") || "'" || SalStrUpperX(sFileName) || "'"
						Set i = i + 1
					! Запускаем джоб для обработки файлов
					If not SqlPLSQLCommand(hSql(), "bars_job.start_job(nW4CngJobId)")
						Call SqlRollback(hSql())
						Call SaveInfoToLog("Way4. not execute job")
						Return FALSE
					Call SqlCommit(hSql())
					! Обработка файла
					If not IsWindow(hWinCngImport)
						Set hWinCngImport = SalCreateWindow(frmCngImport, hWndParent, nFiles, sFileList)
					Else
						Call SalBringWindowToTop(hWinCngImport)
					Return TRUE
			Function: ExportAccountsToW4
				Description:
				Returns
					Boolean:
				Parameters
					Number: nMode
				Static Variables
				Local variables
					Boolean: bRet
					String: sPathExport
					String: sFileName
					String: sFullName
					Number: nCount
					String: sFileList
				Actions
					! CRV_XADIR - каталог для экспорта файлов XA
					Set sPathExport = GetValueStr("select substr(val,1,100) from ow_params where par = 'CRV_XADIR'")
					If sPathExport = ''
						Call SalMessageBox("Не описано каталог файлів XA", "Увага!", MB_IconStop | MB_Ok)
						Return FALSE
					If not VisDosExist(sPathExport)
						Call SalMessageBox("Вказано неіснуючий каталог файлів XA: " || sPathExport, "Увага!", MB_IconStop | MB_Ok)
						Return FALSE
					! проверка на наличие данных для формирования файла
					If nMode = 1
						Call SqlPrepareAndExecute(hSql(), "select count(*) into :nCount from v_ow_xa_accounts")
						Call SqlFetchNext(hSql(), nFetchRes)
					Else
						Call SqlPrepareAndExecute(hSql(), "select count(*) into :nCount from v_ow_xaclose_accounts")
						Call SqlFetchNext(hSql(), nFetchRes)
					If nCount = 0
						Call SalMessageBox("Відсутні картки для експорту", "Увага!", MB_IconExclamation | MB_Ok)
						Return TRUE
					!
					Call SalWaitCursor(TRUE)
					Set bRet = TRUE
					Set sFileList = ''
					While TRUE
						Set sFileName = ''
						! формируем данные для файла
						If not SqlPLSQLCommand(hSql(), "bars_owcrv.form_xa_file(nMode, sFileName)")
							Set bRet = FALSE
							Call SqlRollback(hSql())
							Break
						Call SqlCommit(hSql())
						If sFileName
							Set sFullName = sPathExport || '\\' || sFileName
							! If not PutClobToFile(hSql(), sFullName, 'OW_IMPFILE', 'ID', 'FILE_DATA', XA_ImpId, STRING_Null, STRING_Null)
								                                Set bRet = FALSE
								                                Call SalMessageBox('Помилка формування файлу', 'Помилка', MB_Ok | MB_IconStop)
								                                Break
							Call SaveInfoToLog("WAY4. Сформовано файл " || sFullName)
							Set sFileList = sFileList || PutCrLf() || sFullName
						Else
							Break
					Call SalWaitCursor(FALSE)
					If sFileList
						Call SalMessageBox('Сформовано файли ' || sFileList, 'Інформація', MB_IconAsterisk | MB_Ok)
					Return bRet
			Function: FormXAFilesToW4
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Boolean: bRet
					String: sPathExport
					String: sFileName
					String: sFullName
					Number: nCount
					String: sFileList
				Actions
					! CRV_XADIR - каталог для экспорта файлов XA
					Set sPathExport = GetValueStr("select substr(val,1,100) from ow_params where par = 'CRV_XADIR'")
					If sPathExport = ''
						Call SalMessageBox("Не описано каталог файлів XA", "Увага!", MB_IconStop | MB_Ok)
						Return FALSE
					If not VisDosExist(sPathExport)
						Call SalMessageBox("Вказано неіснуючий каталог файлів XA: " || sPathExport, "Увага!", MB_IconStop | MB_Ok)
						Return FALSE
					! проверка на наличие данных для формирования файла
					! - на открытие
					Call SqlPrepareAndExecute(hSql(), "select count(*) into :nCount from v_ow_xa_accounts")
					Call SqlFetchNext(hSql(), nFetchRes)
					! -на закрытие
					If nCount = 0
						Call SqlPrepareAndExecute(hSql(), "select count(*) into :nCount from v_ow_xaclose_accounts")
						Call SqlFetchNext(hSql(), nFetchRes)
					! - другие запросы
					If nCount = 0
						Call SqlPrepareAndExecute(hSql(), "select count(*) into :nCount from ow_crvacc_request")
						Call SqlFetchNext(hSql(), nFetchRes)
					If nCount = 0
						Call SalMessageBox("Відсутні дані для формування файлів.", "Увага!", MB_IconExclamation | MB_Ok)
						Return TRUE
					!
					Call SalWaitCursor(TRUE)
					Set bRet = TRUE
					Set sFileList = ''
					While TRUE
						Set sFileName = ''
						! формируем данные для файла
						If not SqlPLSQLCommand(hSql(), "bars_owcrv.form_xa_file(NUMBER_Null, sFileName)")
							Set bRet = FALSE
							Call SqlRollback(hSql())
							Break
						Call SqlCommit(hSql())
						If sFileName
							Set sFullName = sPathExport || '\\' || sFileName
							! If not PutClobToFile(hSql(), sFullName, 'OW_IMPFILE', 'ID', 'FILE_DATA', XA_ImpId, STRING_Null, STRING_Null)
								                                Set bRet = FALSE
								                                Call SalMessageBox('Помилка формування файлу', 'Помилка', MB_Ok | MB_IconStop)
								                                Break
							Call SaveInfoToLog("WAY4. Сформовано файл " || sFullName)
							Set sFileList = sFileList || PutCrLf() || sFullName
						Else
							Break
					Call SalWaitCursor(FALSE)
					If sFileList
						Call SalMessageBox('Сформовано файли ' || sFileList, 'Інформація', MB_IconAsterisk | MB_Ok)
					Return bRet
			Function: FormIICFilesToW4
				Description:
				Returns
					Boolean:
				Parameters
					Number: nMode
				Static Variables
				Local variables
					Boolean: bRet
					String: sPathExport
					String: sFileName
					String: sFullName
					Number: nCount
					String: sFileList
					String: sSqlCount
					Number: nImpFileId
				Actions
					Call SaveInfoToLog("WAY4. Формування файлів IIC*.xml")
					! IICFILEDIR - каталог файлов IIC*.xml
					Set sPathExport = GetValueStr("select substr(val,1,100) from ow_params where par = 'IICFILEDIR'")
					If sPathExport = ''
						Call SalMessageBox("Не описано каталог файлів IIC*.xml", "Увага!", MB_IconStop | MB_Ok)
						Call SaveInfoToLog("WAY4. Не описано каталог файлів IIC*.xml")
						Return FALSE
					If not VisDosExist(sPathExport)
						Call SalMessageBox("Вказано неіснуючий каталог файлів IIC*.xml: " || sPathExport, "Увага!", MB_IconStop | MB_Ok)
						Call SaveInfoToLog("WAY4. Вказано неіснуючий каталог файлів IIC*.xml: " || sPathExport)
						Return FALSE
					! проверка на наличие данных для формирования файла
					If nMode = NUMBER_Null OR nMode = 0
						Set sSqlCount =  "select count(*) into :nCount from v_ow_iicfiles_form"
					If nMode = 1
						Set sSqlCount =  "select count(*) into :nCount from v_ow_iicfiles_form_kd"
					If nMode = 2
						Set sSqlCount =  "select count(*) into :nCount from v_ow_iicfiles_form_sto"
					If nMode = 3
						Set sSqlCount =  "select count(*) into :nCount from V_OW_OICREVFILES_FORM"
					Call SqlPrepareAndExecute(hSql(),  sSqlCount)
					Call SqlFetchNext(hSql(), nFetchRes)
					If nCount = 0
						Call SalMessageBox('Відсутні документи для формування файлу', 'Інформація', MB_IconAsterisk | MB_Ok)
						Call SaveInfoToLog("WAY4. Відсутні документи для формування файлу")
						Return TRUE
					!
					Call SalWaitCursor(TRUE)
					Set bRet = TRUE
					Set sFileList = ''
					While TRUE
						Set sFileName = ''
						! формируем данные для файла
						If not SqlPLSQLCommand(hSql(), "bars_ow.form_iic_file(nMode, sFileName, nImpFileId)")
							Call SqlRollback(hSql())
							Set bRet = FALSE
							Break
						Call SqlCommit(hSql())
						If sFileName
							Set sFullName = sPathExport || '\\' || sFileName
							If not PutClobToFile(hSql(), sFullName, 'OW_IMPFILE', 'ID', 'FILE_DATA', nImpFileId, STRING_Null, STRING_Null)
								Set bRet = FALSE
								Call SalMessageBox('Помилка формування файлу', 'Помилка', MB_IconStop | MB_Ok)
								Call SaveInfoToLog("WAY4. Помилка формування файлу")
								Break
							Call SaveInfoToLog("WAY4. Сформовано файл " || sFullName)
							Set sFileList = sFileList || PutCrLf() || sFullName
						Else
							Break
					Call SalWaitCursor(FALSE)
					If sFileList
						Call SalMessageBox('Сформовано файли ' || sFileList, 'Інформація', MB_IconAsterisk | MB_Ok)
					Else
						Call SalMessageBox('Файли не сформовано', 'Інформація', MB_IconAsterisk | MB_Ok)
					Return bRet
			Function: FormCFilesToCrv
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Boolean: bRet
					String: sPathExport
					String: sFileName
					String: sFullName
					Number: nCount
					Number: nImpid
				Actions
					Call SaveInfoToLog("WAY4. Формування файлів C_CARDINFO*.xml")
					! CRV_CDIR - каталог файлов C_CARDINFO*.xml
					Set sPathExport = GetValueStr("select substr(val,1,100) from ow_params where par = 'CRV_CDIR'")
					If sPathExport = ''
						Call SalMessageBox("Не описано каталог файлів C_CARDINFO*.xml", "Увага!", MB_IconStop | MB_Ok)
						Call SaveInfoToLog("WAY4. Не описано каталог файлів C_CARDINFO*.xml")
						Return FALSE
					If not VisDosExist(sPathExport)
						Call SalMessageBox("Вказано неіснуючий каталог файлів C_CARDINFO*.xml: " || sPathExport, "Увага!", MB_IconStop | MB_Ok)
						Call SaveInfoToLog("WAY4. Вказано неіснуючий каталог файлів C_CARDINFO*.xml: " || sPathExport)
						Return FALSE
					! проверка на наличие данных для формирования файла
					Call SqlPrepareAndExecute(hSql(), "select count(*) into :nCount from w4_crv_acc_close")
					Call SqlFetchNext(hSql(), nFetchRes)
					If nCount = 0
						Call SalMessageBox('Відсутні закриті рахунки для формування файлу', 'Інформація', MB_IconAsterisk | MB_Ok)
						Call SaveInfoToLog("WAY4. Відсутні закриті рахунки для формування файлу")
						Return TRUE
					!
					Call SalWaitCursor(TRUE)
					Set bRet = TRUE
					While TRUE
						! формируем данные для файла
						If not SqlPLSQLCommand(hSql(), "bars_owcrv.form_c_file(sFileName, nImpid)")
							Call SqlRollback(hSql())
							Set bRet = FALSE
							Break
						Call SqlCommit(hSql())
						If not sFileName
							Break
						Set sFullName = sPathExport || '\\' || sFileName
						If not PutClobToFile(hSql(), sFullName, 'OW_IMPFILE', 'ID', 'FILE_DATA', nImpid, STRING_Null, STRING_Null)
							Set bRet = FALSE
							Call SalMessageBox('Помилка формування файлу', 'Помилка', MB_IconStop | MB_Ok)
							Call SaveInfoToLog("WAY4. Помилка формування файлу")
							Break
						Call SaveInfoToLog("WAY4. Сформовано файл " || sFullName)
						Call SalMessageBox('Сформовано файл ' || sFullName, 'Інформація', MB_IconAsterisk | MB_Ok)
						Break
					Call SalWaitCursor(FALSE)
					Return bRet
			Function: ImportUseMomory
				Description: Импорт через память (переменная в bars_dbf)
				Returns
					Boolean:
				Parameters
					String: sFilePath          ! путь к файлу dbf
					String: sFileName          ! имя файла dbf
					String: sTableName         ! имя таблицы для импорта
					String: sEncode            ! кодировка DBF файла
					Number: nForceMode         ! =0-пересоздать таблицу, =1-создать новую с хвостом времени, =2-не создавать
					Receive String: sErrMsg    ! текст ошибки обработки
				Static Variables
				Local variables
					String: sFilePathName
					Number: nIsMemoExists
				Actions
					! загрузка DBF файла в переменную пакета
					! Set sFilePathName = sFilePath||'\\'||sFileName
					Set sFilePathName = sFilePath || IifS(Right(sFilePath,1)='\\', '', '\\') || sFileName
					Call SaveInfoToLog("OBPC. " || "Импорт файла " || sFilePathName)
					If not LoadDBFfile(hSql(), sFilePathName, 'DBF', sErrMsg)
						Return FALSE
					Else
						! Существует ли мемо поле
						If not SqlPLSQLCommand(hSql(),"bars_dbf.is_memo_exists_cnt(nIsMemoExists)")
							Set sErrMsg = 'Ошибка проверки на наличия МЕМО поля'
							Return FALSE
						Else
							! Существует мемо поле - подтянуть файл для него
							If nIsMemoExists = 1
								Set sFilePathName = sFilePath||'\\'||SalStrLeftX(sFileName, SalStrScan(sFileName,'.'))||'.dbt'
								If not LoadDBFfile( hSql(), sFilePathName, 'DBT', sErrMsg)
									Set sErrMsg = 'Неуспешная загрузка файла *.DBT для мемо поля в БД: ' ||sErrMsg
									Return FALSE
							! импорт DBF файла из переменной пакета
							If not SqlPLSQLCommand(hSql(),"bars_dbf.import_dbf_cnt(sTableName, nForceMode, sEncode, 'WIN')")
								Set sErrMsg = 'Ошибка импорта DBF файла'
								Return FALSE
							Else
								Call SqlCommitEx(hSql(),'Выполнен импорт данных файла '|| sFilePathName ||' в таблицу '||sTableName)
						Return TRUE
			Function: LoadDBFfile
				Description: Загрузить файл в переменную пакета bars_dbf
				Returns
					Boolean:
				Parameters
					! SQL соединение
					Sql Handle: hSqlHandle
					! Имя файла загружаемого в БД
					String: strFileName
					! Тип файла (DBF или DBT)
					String: strFileType
					Receive String: sErrMsg
				Static Variables
				Local variables
					! Файл
					File Handle: hFile
					! Ошибка при открытии файла
					Number: nErrCode
					! Буфер чтения файла
					Long String: sBuffer
					! Максимальный размер буфера (3999)
					Number: nBufferSize
					! Количество прочитанных байт
					Number: nBytesRead
				Actions
					! Это максимальный теоритический предел для вставки в БД
					Set nBufferSize = 3999
					! Здесь мы удаляем даные из временной таблицы
					! Открываем файл для чтения
					Set nErrCode = VisFileOpen(hFile, strFileName, OF_Binary | OF_Read)
					If nErrCode
						Set sErrMsg =  'Не удалось открыть файл ' || strFileName
						Return FALSE
					! В цикле по частям вычитываем файл и складываем его во временую таблицу БД
					Loop
						If SalStrSetBufferLength(sBuffer, nBufferSize+1)
							Set nBytesRead = VisFileRead(hFile, sBuffer, nBufferSize)
							Call SalStrSetBufferLength(sBuffer, nBufferSize+1)
							If nBytesRead
								If not SqlPLSQLCommand(hSql(),"bars_dbf.set_buffer(sBuffer,strFileType,nBytesRead)")
									Call SqlRollback(hSqlHandle)
									Set sErrMsg =  'Ошибка вычитки файла в буффер. Размер буффера - '||SalNumberToStrX(nBytesRead,0)
									Return FALSE
								If nBytesRead < nBufferSize
									Break
							Else
								Break
						Else
							Return FALSE
					! Закрываем файл
					Call VisFileClose(hFile)
					! Сохраняем изменения
					Call SqlCommit(hSqlHandle)
					Return TRUE
			Function: GetImpId
				Description:
				Returns
					Boolean:
				Parameters
					Receive Number: nImpId
				Static Variables
				Local variables
				Actions
					If not SqlPrepareAndExecute(hSql(), "select bars_ow.get_impid(0) into :nImpId from dual")
						Return FALSE
					Call SqlFetchNext(hSql(), nFetchRes)
					Return TRUE
			Function: LoadFile
				Description:
				Returns
					Boolean:
				Parameters
					Window Handle: hWndParent
					String: sTitle
					String: sFileName
					String: sFullName
					Receive Number: nImpId
				Static Variables
				Local variables
				Actions
					If not GetImpId(nImpId)
						Return FALSE
					! Импорт файла во временную таблицу
					! 0 - хорошо, -1 - плохо
					If -1 = UploadWay4Xml(SalWindowHandleToNumber(hWndParent), sTitle, sFileName,
							     SqlDatabase, SqlUser, SqlPassword,
							     'OW', nImpId, sFullName)
						Call SaveInfoToLog("Way4. Ошибка при выполнении процедуры загрузки файла UploadWay4Xml")
						Return FALSE
					Call SaveInfoToLog("Way4. Файл " || sFileName || " загружен в промежуточную таблицу")
					Return TRUE
		Named Menus
		Class Definitions
.data RESOURCE 0 0 1 25218691
0000: 37010000A2000000 0000000000000000 0200000200FFFF01 00160000436C6173
0020: 73566172004F7574 6C696E6552006567 496E666F22003C00 000A630047656E46
0040: 696C746500727400 00000400001E0002 0400C10001000000 3F8001F800000037
0060: 040001F00D000000 FF1F110000DC0002 00FF7F1570000000 0100FFFF21018022
0080: 000001C200000B63 47F8444669B30004 00770200F601004F 800100FE008D0400
00A0: 010DFD00FF371100 02F700FFDF15DC00 0100FF7F
.enddata
			Functional Class: cCardTab
				Description:
				Derived From
				Class Variables
				Instance Variables
					Number: TabNum
					String: Label
					String: Name
					String: DlgName
				Functions
		Default Classes
			MDI Window: cBaseMDI
			Form Window:
			Dialog Box:
			Table Window:
			Quest Window:
			Data Field:
			Spin Field:
			Multiline Field:
			Pushbutton:
			Radio Button: cRadioButtonLabeled
			Option Button:
			Check Box:
			Child Table:
			Quest Child Window: cQuickDatabase
			List Box:
			Combo Box: cGenComboBox_NumId
			Picture:
			Vertical Scroll Bar:
			Horizontal Scroll Bar:
			Column:
			Background Text:
			Group Box:
			Line:
			Frame:
			Custom Control:
		Application Actions
	Dialog Box: dlgSelectFiles
		Class:
		Property Template:
		Class DLL Name:
		Title: Вибір файлів для імпорту
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   2.513"
				Top:    1.063"
				Width:  7.5"
				Width Editable? Yes
				Height: 3.952"
				Height Editable? Yes
			Absolute Screen Location? Yes
			Font Name: Default
			Font Size: Default
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description:
		Tool Bar
			Display Settings
				Display Style? Default
				Location? Top
				Visible? Yes
				Size: Default
				Size Editable? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Contents
		Contents
			Child Table: tblFiles
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Display Settings
					Window Location and Size
						Left:   0.067"
						Top:    0.464"
						Width:  7.2"
						Width Editable? Yes
						Height: 2.3"
						Height Editable? Yes
					Visible? Yes
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					View: Table
					Allow Row Sizing? No
					Lines Per Row: Default
				Memory Settings
					Maximum Rows in Memory: 10000
					Discardable? Yes
				Contents
					Column: colId
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title:
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colFileName
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Ім'я файла
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  5.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colSelect
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Імпортувати
						Visible? Yes
						Editable? Yes
						Maximum Data Length: Default
						Data Type: Number
						Justify: Left
						Width:  1.4"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Check Box
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value: 1
								Uncheck Value: 0
								Ignore Case? Yes
						List Values
						Message Actions
				Functions
					Function: setFilesFlag
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							Set nRow = TBL_MinRow
							While SalTblFindNextRow(hWndForm, nRow, 0, 0)
								Call SalTblSetContext(hWndForm, nRow)
								Set bmFilesFlag[colId] = colSelect
							Return TRUE
				Window Variables
					Number: i
					Number: nRow
				Message Actions
					On UM_Populate
						Call SalWaitCursor(TRUE)
						Set i = 0
						While i < nFiles
							Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
							Call SalTblSetContext(hWndForm, nRow)
							Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
							Set colId = i
							Set colFileName = SalStrUpperX(smFile[i])
							Set colSelect = TRUE
							Set i = i + 1
						Call SalWaitCursor(FALSE)
			Frame
				Resource Id: 65445
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.067"
					Top:    2.821"
					Width:  7.2"
					Width Editable? Yes
					Height: 0.7"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Border Color: 3D Shadow Color
				Background Color: Default
			Pushbutton: pbOk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbOk
				Property Template:
				Class DLL Name:
				Title: Імпортувати
				Window Location and Size
					Left:   0.467"
					Top:    2.917"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name:
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						Call tblFiles.setFilesFlag()
						Call SalEndDialog(hWndForm, TRUE)
			Pushbutton: pbCancel
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title: Відмінити
				Window Location and Size
					Left:   5.667"
					Top:    2.917"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Esc
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name:
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						Call SalEndDialog(hWndForm, FALSE)
			Pushbutton: pbInv
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Інвертувати відмітки
				Window Location and Size
					Left:   5.35"
					Top:    0.083"
					Width:  1.9"
					Width Editable? Yes
					Height: 0.298"
					Height Editable? Yes
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Picture File Name:
				Picture Transparent Color: None
				Image Style: Single
				Text Color: Jade
				Background Color: Sky
				Message Actions
					On SAM_Click
						Set nRow = TBL_MinRow
						While SalTblFindNextRow(tblFiles, nRow, 0, 0)
							Call SalTblSetContext(tblFiles, nRow)
							Set tblFiles.colSelect = not tblFiles.colSelect
			Pushbutton: pbDel
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Зняти відмітки для всіх
				Window Location and Size
					Left:   0.067"
					Top:    0.083"
					Width:  2.1"
					Width Editable? Yes
					Height: 0.298"
					Height Editable? Yes
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: Default
				Font Enhancement: None
				Picture File Name:
				Picture Transparent Color: None
				Image Style: Single
				Text Color: Black
				Background Color: Light Gray
				Message Actions
					On SAM_Click
						Set nRow = TBL_MinRow
						While SalTblFindNextRow(tblFiles, nRow, 0, 0)
							Call SalTblSetContext(tblFiles, nRow)
							Set tblFiles.colSelect = 0
			Pushbutton: pbIns
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Встановити відмітки для всіх
				Window Location and Size
					Left:   2.467"
					Top:    0.083"
					Width:  2.583"
					Width Editable? Yes
					Height: 0.298"
					Height Editable? Yes
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: Default
				Font Enhancement: Underline
				Picture File Name:
				Picture Transparent Color: None
				Image Style: Single
				Text Color: Midnight Blue
				Background Color: Light Green
				Message Actions
					On SAM_Click
						Set nRow = TBL_MinRow
						While SalTblFindNextRow(tblFiles, nRow, 0, 0)
							Call SalTblSetContext(tblFiles, nRow)
							Set tblFiles.colSelect = 1
		Functions
		Window Parameters
			Number: nFiles
			String: smFile[*]
			Receive Boolean: bmFilesFlag[*]
		Window Variables
			Number: nRow
		Message Actions
			On SAM_Create
				Call PrepareWindowEx(hWndForm)
				Call SalSendMsg(tblFiles, UM_Populate, 0, 0)
	Table Window: tblDocs
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title:
		Icon File:
		Accesories Enabled? Class Default
		Visible? Class Default
		Display Settings
			Visible at Design time? Yes
			Automatically Created at Runtime? Class Default
			Initial State: Class Default
			Maximizable? Class Default
			Minimizable? Class Default
			System Menu? Class Default
			Resizable? Class Default
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  15.967"
				Width Editable? Class Default
				Height: Class Default
				Height Editable? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: Class Default
			Text Color: Class Default
			Background Color: Class Default
			View: Class Default
			Allow Row Sizing? Class Default
			Lines Per Row: Class Default
		Memory Settings
			Maximum Rows in Memory: 64000
			Discardable? Class Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Class Default
				Visible? Class Default
				Size: Class Default
				Size Editable? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
			Contents
				Pushbutton: pbIns
					Class Child Ref Key: 33
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbDel
					Class Child Ref Key: 34
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Видалити транзакцію (без оплати)'
				Pushbutton: pbRefresh
					Class Child Ref Key: 35
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbUpdate
					Class Child Ref Key: 36
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 31798
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  4.767"
						Begin Y:  Class Default
						End X:  4.767"
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbSearch
					Class Child Ref Key: 38
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbFilter
					Class Child Ref Key: 44
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbDetails
					Class Child Ref Key: 39
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.583"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\APPLY.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Оплатити документ'
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.933"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 31799
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  3.467"
						Begin Y:  Class Default
						End X:  3.467"
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Line
					Resource Id: 22051
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  4.1"
						Begin Y:  -0.036"
						End X:  4.1"
						End Y:  0.429"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Pushbutton: pbExit
					Class Child Ref Key: 42
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.233"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 31800
					Class Child Ref Key: 43
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
		Contents
			Column: colIdn
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: №
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  0.8"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colSynthCode
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код синт.
						проводки
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colNazn
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Опис
				Visible? Yes
				Editable? No
				Maximum Data Length: 254
				Data Type: String
				Justify: Left
				Width:  3.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colDocDrn
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: № док.
						Way4
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colDocOrn
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: № оп.
						Way4
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colNlsA
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Рахунок
						Дебет
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.8"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colS
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сума
						Дебет
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.6"
				Width Editable? Yes
				Format: Decimal
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colKv
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Валюта
						Дебет
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
				Width:  0.8"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colMfoB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: МФО-Б
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colNlsB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Рахунок
						Кредит
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.8"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colS2
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сума
						Кредит
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.6"
				Width Editable? Yes
				Format: Decimal
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colKv2
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Валюта
						Кредит
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
				Width:  0.8"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colNamB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Отримувач
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colIdB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ЗКПО-Б
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colErrText
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Повідомлення
				Visible? Yes
				Editable? No
				Maximum Data Length: 254
				Data Type: String
				Justify: Left
				Width:  6.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colDk		!  заполнен только для операций, иниц. банком (%BACA)
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title:
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  Default
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
		Functions
			Function: MatchingDoc
				Description:
				Returns
					Boolean:
				Parameters
					Number: nDk
				Static Variables
				Local variables
					String: sPk
					String: sSem
					Number: nRef
					String: sNls
					Number: nKv
					Number: nS
				Actions
					If FunNSIGetFiltered("v_ow_pkkque", "dk", "pkk_sos=1 and dk=" || Str(nDk), sPk, sSem)
						Set nRef = Val(sPk)
						If nRef
							Call SqlPrepareAndExecute(hSql(),
									"select nls, kv, s
									   into :sNls, :nKv, :nS
									   from v_ow_pkkque
									  where ref = :nRef and dk = :nDk")
							Call SqlFetchNext(hSql(), nFetchRes)
							If (sNls != colNlsA or nKv != colKv)
									and (sNls != colNlsB or nKv != colKv2)
								If SalMessageBox("Карткові рахунки рядка файла та документу не співпадають!" || PutCrLf() ||
										   "Сквитувати документ?", "Увага!", MB_IconExclamation | MB_YesNo) = IDNO
									Return FALSE
							If nS != colS
								If SalMessageBox("Суми рядка файла та документу не співпадають!" || PutCrLf() ||
										   "Сквитувати документ?", "Увага!", MB_IconExclamation | MB_YesNo) = IDNO
									Return FALSE
							If not SqlPLSQLCommand(hSql(), "bars_ow.matching_ref(nFileId, colIdn, nRef, nPar)")
								Call SqlRollback(hSql())
								Return FALSE
							Call SqlCommitEx(hSql(), 'Way4. Документ №' || Str(nRef) || ' успішно сквитовано')
							Call SalMessageBox('Документ №' || Str(nRef) || ' успішно сквитовано', 'Повідомлення', MB_IconAsterisk | MB_Ok)
					Return TRUE
		Window Parameters
			Window Handle: hWndParent
			! nPar = 1-data, 0-hist
			Number: nPar
			Number: nFileId
			String: sFileType
			String: sFileName
		Window Variables
			Number: hBtns[*]
			Number: hBtnKvt
			Number: hBtnPay
			Number: hBtnClose
			Number: nChoose
		Message Actions
			On SAM_Create
				! Просмотр неоплаченных с возможностью оплаты/квитовки и удаления
				If nPar
					Call SalSetWindowText(hWndForm, AppVersion || 'Way4. Перегляд необроблених документів файлу ' || sFileName)
					Set hWndForm.tblDocs.nFlags = GT_NoIns | GT_NoUpd
					If sFileType = ATRANSFERS or sFileType = FTRANSFERS
						Set hWndForm.tblDocs.strSqlPopulate =
								"select idn, synthcode, doc_drn, doc_orn, dk, nlsa, s/100, kv, nlsb, s2/100, kv2, nazn, err_text
								   into :hWndForm.tblDocs.colIdn, :hWndForm.tblDocs.colSynthCode,
								        :hWndForm.tblDocs.colDocDrn, :hWndForm.tblDocs.colDocOrn, :hWndForm.tblDocs.colDk,
								        :hWndForm.tblDocs.colNlsA, :hWndForm.tblDocs.colS,  :hWndForm.tblDocs.colKv,
								        :hWndForm.tblDocs.colNlsB, :hWndForm.tblDocs.colS2, :hWndForm.tblDocs.colKv2,
								        :hWndForm.tblDocs.colNazn, :hWndForm.tblDocs.colErrText
								   from v_ow_oic_atransfers_data ow_oic_data
								  where id = :hWndForm.tblDocs.nFileId
								  order by idn"
					Else If sFileType = STRANSFERS
						Set hWndForm.tblDocs.strSqlPopulate =
								"select idn, nlsa, s/100, kv, nlsb, s2/100, kv2, nazn, err_text
								   into :hWndForm.tblDocs.colIdn,
								        :hWndForm.tblDocs.colNlsA, :hWndForm.tblDocs.colS,  :hWndForm.tblDocs.colKv,
								        :hWndForm.tblDocs.colNlsB, :hWndForm.tblDocs.colS2, :hWndForm.tblDocs.colKv2,
								        :hWndForm.tblDocs.colNazn, :hWndForm.tblDocs.colErrText
								   from v_ow_oic_stransfers_data ow_oic_data
								  where id = :hWndForm.tblDocs.nFileId
								  order by idn"
					Else If sFileType = DOCUMENTS
						Set hWndForm.tblDocs.strSqlPopulate =
								"select idn, nlsa, kv, s/100,
								        mfob, id_b, nam_b, nlsb, kv2, s2/100, nazn, err_text
								   into :hWndForm.tblDocs.colIdn,
								        :hWndForm.tblDocs.colNlsA, :hWndForm.tblDocs.colKv,  :hWndForm.tblDocs.colS,
								        :hWndForm.tblDocs.colMfoB, :hWndForm.tblDocs.colIdB, :hWndForm.tblDocs.colNamB,
								        :hWndForm.tblDocs.colNlsB, :hWndForm.tblDocs.colKv2, :hWndForm.tblDocs.colS2,
								        :hWndForm.tblDocs.colNazn, :hWndForm.tblDocs.colErrText
								   from v_ow_oic_documents_data ow_oic_data
								  where id = :hWndForm.tblDocs.nFileId
								  order by idn"
				! Просмотр удаленных
				Else
					Call SalSetWindowText(hWndForm, AppVersion || 'Way4. Перегляд видалених транзакцій файлу ' || sFileName)
					Set hWndForm.tblDocs.nFlags = GT_ReadOnly
					If sFileType = ATRANSFERS or sFileType = FTRANSFERS
						Set hWndForm.tblDocs.strSqlPopulate =
								"select idn, synthcode, doc_drn, doc_orn, dk, nlsa, s/100, kv, nlsb, s2/100, kv2, nazn
								   into :hWndForm.tblDocs.colIdn, :hWndForm.tblDocs.colSynthCode,
								        :hWndForm.tblDocs.colDocDrn, :hWndForm.tblDocs.colDocOrn, :hWndForm.tblDocs.colDk,
								        :hWndForm.tblDocs.colNlsA, :hWndForm.tblDocs.colS,  :hWndForm.tblDocs.colKv,
								        :hWndForm.tblDocs.colNlsB, :hWndForm.tblDocs.colS2, :hWndForm.tblDocs.colKv2,
								        :hWndForm.tblDocs.colNazn
								   from v_ow_oic_atransfers_hist ow_oic_data
								  where id = :hWndForm.tblDocs.nFileId
								    and ref is null
								  order by idn"
					Else If sFileType = STRANSFERS
						Set hWndForm.tblDocs.strSqlPopulate =
								"select idn, nlsa, s/100, kv, nlsb, s2/100, kv2, nazn
								   into :hWndForm.tblDocs.colIdn,
								        :hWndForm.tblDocs.colNlsA, :hWndForm.tblDocs.colS,  :hWndForm.tblDocs.colKv,
								        :hWndForm.tblDocs.colNlsB, :hWndForm.tblDocs.colS2, :hWndForm.tblDocs.colKv2,
								        :hWndForm.tblDocs.colNazn
								   from v_ow_oic_stransfers_hist ow_oic_data
								  where id = :hWndForm.tblDocs.nFileId
								  order by idn"
					Else If sFileType = DOCUMENTS
						Set hWndForm.tblDocs.strSqlPopulate =
								"select idn, nlsa, kv, s/100,
								        mfob, id_b, nam_b, nlsb, kv2, s2/100, nazn
								   into :hWndForm.tblDocs.colIdn,
								        :hWndForm.tblDocs.colNlsA, :hWndForm.tblDocs.colKv,  :hWndForm.tblDocs.colS,
								        :hWndForm.tblDocs.colMfoB, :hWndForm.tblDocs.colIdB, :hWndForm.tblDocs.colNamB,
								        :hWndForm.tblDocs.colNlsB, :hWndForm.tblDocs.colKv2, :hWndForm.tblDocs.colS2,
								        :hWndForm.tblDocs.colNazn
								   from v_ow_oic_documents_hist ow_oic_data
								  where id = :hWndForm.tblDocs.nFileId
								  order by idn"
					! Call SalDisableWindow(pbDetails)
					Call SalHideWindow(colErrText)
					Call SalDisableWindow(colMfoB)
					Call SalDisableWindow(colNamB)
					Call SalDisableWindow(colIdB)
				Call SetWindowFullSize(hWndForm)
				Call PrepareWindowEx(hWndForm)
				Set hWndForm.tblDocs.strFilterTblName = "ow_oic_data"
				If sFileType = ATRANSFERS or sFileType = FTRANSFERS
					Call SalHideWindow(colMfoB)
					Call SalHideWindow(colNamB)
					Call SalHideWindow(colIdB)
				Else If sFileType = STRANSFERS
					Call SalHideWindow(colSynthCode)
					Call SalHideWindow(colDocDrn)
					Call SalHideWindow(colDocOrn)
					Call SalHideWindow(colMfoB)
					Call SalHideWindow(colNamB)
					Call SalHideWindow(colIdB)
				Else If sFileType = DOCUMENTS
					Call SalHideWindow(colSynthCode)
					Call SalHideWindow(colDocDrn)
					Call SalHideWindow(colDocOrn)
				Set hBtnKvt   = VisMessageLoadButton('Сквитувати', 0)
				Set hBtnPay   = VisMessageLoadButton('Оплатити', 1)
				Set hBtnClose = VisMessageLoadButton('Відмінити', 2)
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On SAM_FetchRowDone
				! %BACA
				If sFileType = ATRANSFERS and colDk != NUMBER_Null
					! голубой
					Call XSalTblSetRowBackColor(hWndForm, lParam, SalColorFromRGB(230, 255, 255))
			On SAM_DoubleClick
				! квитовка %BACA
				If sFileType = ATRANSFERS and colDk != NUMBER_Null
					Call VisMessageSetBkgdColor(COLOR_Salmon)
					Set hBtns[0] = hBtnKvt
					Set hBtns[1] = hBtnPay
					Set hBtns[2] = hBtnClose
					Set nChoose = VisMessageBox('Документ СКВИТУВАТИ чи ОПЛАТИТИ БЕЗ КВИТОВКИ?', 'Увага!', MBF_IconQuestion, hBtns, 3)
					If nChoose = 0
						If MatchingDoc(colDk)
							Call SalPostMsg(hWndForm, UM_Populate, 0, 0)
					If nChoose = 1
						Call SalCreateWindow(frmInputDoc, hWndMDI, hWndForm, sFileType, nFileId, colIdn, nPar,
								     IifS(sFileType=DOCUMENTS and colMfoB!=GetBankMfo(), 'OW3',
								     IifS(colKv=colKv2, 'OW1', 'OW2')),
								     colNlsA, colKv, colS*100, colNlsB, colKv2, colS2*100, colMfoB, colIdB, colNamB, colNazn)
				! оплата
				Else
					Call SalCreateWindow(frmInputDoc, hWndMDI, hWndForm, sFileType, nFileId, colIdn, nPar,
							     IifS(sFileType=DOCUMENTS and colMfoB!=GetBankMfo(), 'OW3', IifS(colKv=colKv2, 'OW1', 'OW2')),
							     colNlsA, colKv,
							     IifN(colKv=colKv2, colS*100, colS),
							     colNlsB, colKv2,
							     IifN(colKv=colKv2, colS2*100, colS2),
							     colMfoB, colIdB, colNamB, colNazn)
			On UM_Delete
				If SalTblAnyRows(hWndForm, ROW_Selected, 0)
					If SalMessageBox('Видалити виділені необроблені транзакції?', 'Увага!', MB_IconQuestion | MB_YesNo) = IDYES
						Set nRow = TBL_MinRow
						While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
							Call SalTblSetContext(hWndForm, nRow)
							If SqlPLSQLCommand(hSql(), "bars_ow.delete_tran(nFileId, colIdn)")
								Call SqlCommitEx(hSql(), "Way4. Удалена транзакция в архив: файл " || sFileName || " idn=" || Str(colIdn))
							Else
								Call SqlRollbackEx(hSql(), "Way4. Неуспешное удаление транзакции в архив: файл " || sFileName || " idn=" || Str(colIdn))
								Break
						Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
			On SAM_Destroy
				Call VisMessageFreeButton(hBtnKvt)
				Call VisMessageFreeButton(hBtnPay)
				Call VisMessageFreeButton(hBtnClose)
				Call SalPostMsg(hWndParent, UM_Populate, 0, 0)
	Form Window: frmInputDoc
		Class: cDocW
		Property Template:
		Class DLL Name:
		Title:
		Icon File:
		Accesories Enabled? Class Default
		Visible? Class Default
		Display Settings
			Display Style? Class Default
			Visible at Design time? Yes
			Automatically Created at Runtime? Class Default
			Initial State: Class Default
			Maximizable? Class Default
			Minimizable? Class Default
			System Menu? Class Default
			Resizable? Class Default
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  Class Default
				Width Editable? Class Default
				Height: Class Default
				Height Editable? Class Default
			Form Size
				Width:  Class Default
				Height: Class Default
				Number of Pages: Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: Class Default
			Text Color: Class Default
			Background Color: Class Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Class Default
				Visible? Class Default
				Size: Class Default
				Size Editable? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
			Contents
				Pushbutton: pbPayDoc
					Class Child Ref Key: 27
					Class ChildKey: 0
					Class: cDocW
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbExit
					Class Child Ref Key: 29
					Class ChildKey: 0
					Class: cDocW
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbPrtDoc
					Class Child Ref Key: 30
					Class ChildKey: 0
					Class: cDocW
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 31802
					Class Child Ref Key: 33
					Class ChildKey: 0
					Class: cDocW
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Background Text:
					Resource Id: 31803
					Class Child Ref Key: 75
					Class ChildKey: 0
					Class: cDocW
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Justify: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
				Line
					Resource Id: 31804
					Class Child Ref Key: 34
					Class ChildKey: 0
					Class: cDocW
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Line
					Resource Id: 31805
					Class Child Ref Key: 59
					Class ChildKey: 0
					Class: cDocW
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Data Field: dfZn
					Class Child Ref Key: 35
					Class ChildKey: 0
					Class: cDocW
					Property Template:
					Class DLL Name:
					Data
						Maximum Data Length: Class Default
						Data Type: Class Default
						Editable? Class Default
					Display Settings
						Window Location and Size
							Left:   Class Default
							Top:    Class Default
							Width:  Class Default
							Width Editable? Class Default
							Height: Class Default
							Height Editable? Class Default
						Visible? Class Default
						Border? Class Default
						Justify: Class Default
						Format: Class Default
						Country: Class Default
						Font Name: Class Default
						Font Size: Class Default
						Font Enhancement: Class Default
						Text Color: Class Default
						Background Color: Class Default
						Input Mask: Class Default
					Message Actions
				Data Field: dfOst
					Class Child Ref Key: 31
					Class ChildKey: 0
					Class: cDocW
					Property Template:
					Class DLL Name:
					Data
						Maximum Data Length: Class Default
						Data Type: Class Default
						Editable? Class Default
					Display Settings
						Window Location and Size
							Left:   Class Default
							Top:    Class Default
							Width:  Class Default
							Width Editable? Class Default
							Height: Class Default
							Height Editable? Class Default
						Visible? Class Default
						Border? Class Default
						Justify: Class Default
						Format: Class Default
						Country: Class Default
						Font Name: Class Default
						Font Size: Class Default
						Font Enhancement: Class Default
						Text Color: Class Default
						Background Color: Class Default
						Input Mask: Class Default
					Message Actions
				Pushbutton: pbNewDoc
					Class Child Ref Key: 53
					Class ChildKey: 0
					Class: cDocW
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbNewTTs
					Class Child Ref Key: 60
					Class ChildKey: 0
					Class: cDocW
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbDocBal
					Class Child Ref Key: 72
					Class ChildKey: 0
					Class: cDocW
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbHelp
					Class Child Ref Key: 62
					Class ChildKey: 0
					Class: cDocW
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbSaveKor
					Class Child Ref Key: 64
					Class ChildKey: 0
					Class: cDocW
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbLocalD
					Class Child Ref Key: 148
					Class ChildKey: 0
					Class: cDocW
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 31806
					Class Child Ref Key: 77
					Class ChildKey: 0
					Class: cDocW
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbHotVytyag
					Class Child Ref Key: 138
					Class ChildKey: 0
					Class: cDocW
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbHotFio
					Class Child Ref Key: 141
					Class ChildKey: 0
					Class: cDocW
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbHotName
					Class Child Ref Key: 137
					Class ChildKey: 0
					Class: cDocW
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbHotOstat
					Class Child Ref Key: 150
					Class ChildKey: 0
					Class: cDocW
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
		Contents
			Data Field: dfValD1
				Class Child Ref Key: 25
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Combo Box: cmbVob
				Class Child Ref Key: 39
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   Class Default
					Top:    Class Default
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Editable? Class Default
				String Type: Class Default
				Maximum Data Length: Class Default
				Sorted? Class Default
				Always Show List? Class Default
				Vertical Scroll? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Input Mask: Class Default
				List Initialization
				Message Actions
			Background Text:
				Resource Id: 31801
				Class Child Ref Key: 36
				Class ChildKey: 0
				Class: cDocW
				Window Location and Size
					Left:   Class Default
					Top:    Class Default
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Justify: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
			Data Field: dfNd
				Class Child Ref Key: 23
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfDateFrom
				Class Child Ref Key: 155
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfDocD
				Class Child Ref Key: 22
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfBankA
				Class Child Ref Key: 4
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfKvA
				Class Child Ref Key: 50
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfNlsA
				Class Child Ref Key: 2
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfPlat
				Class Child Ref Key: 8
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfNamA
				Class Child Ref Key: 7
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfOkpoA
				Class Child Ref Key: 139
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfPlatB
				Class Child Ref Key: 9
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfNbA
				Class Child Ref Key: 6
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfBankB
				Class Child Ref Key: 13
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfPoluB
				Class Child Ref Key: 18
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfNbB
				Class Child Ref Key: 15
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfKvB
				Class Child Ref Key: 51
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfNlsB
				Class Child Ref Key: 11
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfPolu
				Class Child Ref Key: 17
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfNamB
				Class Child Ref Key: 16
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
					On SAM_Create
						If sParNamB
							Set dfNamB = sParNamB
							Call SalSendMsg(hWndItem, SAM_Validate, 0, 0)
			Data Field: dfOkpoB
				Class Child Ref Key: 140
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
					On SAM_Create
						If sParIdB
							Set dfOkpoB = sParIdB
			Data Field: dfSumNA
				Class Child Ref Key: 135
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfSumA
				Class Child Ref Key: 20
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfSumNB
				Class Child Ref Key: 122
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfSumB
				Class Child Ref Key: 21
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfRatNomN
				Class Child Ref Key: 123
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfRatNom
				Class Child Ref Key: 57
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfSumNC
				Class Child Ref Key: 125
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfSumC
				Class Child Ref Key: 44
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
					On SAM_Create
						If frmInputDoc.nFlv
							Call SalDisableWindow(hWndItem)
							Call SalHideWindow(hWndItem)
							Set dfSumC = NUMBER_Null
							Set dfSumA = nParS1
							Set dfSumB = nParS2
						Else
							Call SalShowWindow(hWndItem)
							Call frmInputDoc.UnHideIt(hWndItem)
							Set dfSumC = frmInputDoc.nS
							Set dfSumA = dfSumC
							Set dfSumB = dfSumC
			Data Field: dfEquivN
				Class Child Ref Key: 144
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfEquiv
				Class Child Ref Key: 145
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			List Box: lb1
				Class Child Ref Key: 85
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   Class Default
					Top:    Class Default
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Multiple selection? Class Default
				Sorted? Class Default
				Vertical Scroll? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Horizontal Scroll? Class Default
				List Initialization
				Message Actions
			Multiline Field: dfNazn
				Class Child Ref Key: 24
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					String Type: Class Default
					Editable? Class Default
				Display Settings
					Border? Class Default
					Word Wrap? Class Default
					Vertical Scroll? Class Default
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
				Message Actions
					On SAM_Create
						Call frmInputDoc.UnHideIt(hWndItem)
						If sParNazn
							Set dfNazn = Subs(sParNazn,1,160)
							Set frmInputDoc.aVal[0] = dfNazn
							Call SalSendMsg(hWndItem, SAM_Validate, 0, 0)
			Data Field: dfSkN
				Class Child Ref Key: 115
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfSk
				Class Child Ref Key: 48
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfValD1N
				Class Child Ref Key: 160
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfValD2N
				Class Child Ref Key: 131
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfValD2
				Class Child Ref Key: 66
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfD
				Class Child Ref Key: 132
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfK
				Class Child Ref Key: 133
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfLocDat
				Class Child Ref Key: 149
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Check Box: cbUgrnt
				Class Child Ref Key: 130
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   Class Default
					Top:    Class Default
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
			Data Field: dfVytyagN
				Class Child Ref Key: 142
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Picture: pic1f
				Class Child Ref Key: 156
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   Class Default
					Top:    Class Default
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Editable? Class Default
				File Name:
				Storage: Class Default
				Picture Transparent Color: Class Default
				Fit: Class Default
				Scaling
					Width:  Class Default
					Height:  Class Default
				Corners: Class Default
				Border Style: Class Default
				Border Thickness: Class Default
				Tile To Parent? Class Default
				Border Color: Class Default
				Background Color: Class Default
				Message Actions
			Picture: pic2f
				Class Child Ref Key: 157
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   Class Default
					Top:    Class Default
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Editable? Class Default
				File Name:
				Storage: Class Default
				Picture Transparent Color: Class Default
				Fit: Class Default
				Scaling
					Width:  Class Default
					Height:  Class Default
				Corners: Class Default
				Border Style: Class Default
				Border Thickness: Class Default
				Tile To Parent? Class Default
				Border Color: Class Default
				Background Color: Class Default
				Message Actions
			Picture: pic3f
				Class Child Ref Key: 158
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   Class Default
					Top:    Class Default
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Editable? Class Default
				File Name:
				Storage: Class Default
				Picture Transparent Color: Class Default
				Fit: Class Default
				Scaling
					Width:  Class Default
					Height:  Class Default
				Corners: Class Default
				Border Style: Class Default
				Border Thickness: Class Default
				Tile To Parent? Class Default
				Border Color: Class Default
				Background Color: Class Default
				Message Actions
			Data Field: dfSub
				Class Child Ref Key: 167
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfSubN
				Class Child Ref Key: 166
				Class ChildKey: 0
				Class: cDocW
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
		Functions
			Function: oDoc
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Number: nCount
					Number: nDocRef
				Actions
					If nPar = 1
						Call SqlPrepareAndExecute(hSql(),
								"select count(*) into :nCount
								   from ow_oic_" || IifS(sFileType=ATRANSFERS or sFileType=FTRANSFERS, ATRANSFERS, sFileType) || "_data
								  where id  = :nFileId
								    and idn = :nFileIdn")
						Call SqlFetchNext(hSql(), nFetchRes)
						If nCount = 0
							Call SalMessageBox("Документ файлу вже оплачено!", "Увага!", MB_IconStop | MB_Ok)
							Return FALSE
					If not cDocW.oDoc()
						Return FALSE
					If not SqlPLSQLCommand(hSql(), "bars_ow.set_pay_flag(nFileId, nFileIdn, frmInputDoc.m_nRef, nPar)")
						Return FALSE
					Return TRUE
		Window Parameters
			Window Handle: hWndParent
			String: sFileType
			Number: nFileId
			Number: nFileIdn
			! nPar = 1-data, 0-hist
			Number: nPar
			String: sParTt
			String: sParNlsA
			Number: nParKvA
			Number: nParS1
			String: sParNlsB
			Number: nParKvB
			Number: nParS2
			String: sParMfoB
			String: sParIdB
			String: sParNamB
			String: sParNazn
		Window Variables
		Message Actions
			On SAM_Create
				Call SalSendClassMessage(SAM_Create, 0, 0)
				Set dfOkpoB = sParIdB
				Set dfNamB = sParNamB
			On UM_Choose
				Set sTT = sParTt
				Set sNlsA_TT = sParNlsA
				Set nKvA_TT  = nParKvA
				Set sNlsB_TT = sParNlsB
				Set nKvB_TT  = nParKvB
				Set nS = nParS1/100
				Set sBankB_TT = sParMfoB
				Call SqlPrepareAndExecute(hSql(),
						"SELECT name, flags, fli, flv, dk, sk
						   INTO :sTTN, :sFlags, :nFli, :nFlv,:nDk, :nSk_TT
						   FROM tts
						  WHERE tt = :sTT")
				Call SqlFetchNext(hSql(),nFetchRes)
				!
				Call SalSetWindowText(hWndForm, "Введення документу " || sTT || "-" || sTTN)
				Call SalSendClassMessage(UM_Clear, 0, 0)
			On SAM_Destroy
				Call SalSendClassMessage(SAM_Destroy, 0, 0)
				Call SalPostMsg(hWndParent, UM_Populate, 0, 0)
	Form Window: frmImportFile
		Class:
		Property Template:
		Class DLL Name:
		Title: ЦРВ-Way4. Відкриття карток по файлу з ЦРВ
		Icon File:
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Automatically Created at Runtime? Yes
			Initial State: Normal
			Maximizable? Yes
			Minimizable? Yes
			System Menu? Yes
			Resizable? Yes
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  6.9"
				Width Editable? Yes
				Height: 5.3"
				Height Editable? Yes
			Form Size
				Width:  Default
				Height: Default
				Number of Pages: Dynamic
			Font Name: Default
			Font Size: Default
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Default
				Location? Top
				Visible? Yes
				Size: Default
				Size Editable? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Contents
		Contents
			Group Box: Файл для імпорту
				Resource Id: 19313
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    0.05"
					Width:  6.0"
					Width Editable? Yes
					Height: 0.8"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfFileName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 100
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   0.2"
						Top:    0.35"
						Width:  4.5"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Pushbutton: pbGetPath
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Вибрати
				Window Location and Size
					Left:   4.8"
					Top:    0.35"
					Width:  1.2"
					Width Editable? Yes
					Height: 0.298"
					Height Editable? Yes
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Picture File Name:
				Picture Transparent Color: None
				Image Style: Single
				Text Color: Default
				Background Color: Default
				Message Actions
					On SAM_Click
						If SalDlgOpenFile(hWndForm, 'Open File', strFilters, 2, nIndex, strFile, dfPath)
							Set dfFileName = dfPath
							Call SalDisableWindow(pbPrint)
							Call SalHideWindow(tblErr)
							Call SalTblReset(tblErr)
							Call SalSetWindowSize(hWndForm, 6.5, 2.15)
			Frame
				Resource Id: 19314
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    0.9"
					Width:  6.0"
					Width Editable? Yes
					Height: 0.7"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Border Color: Default
				Background Color: Default
			Pushbutton: pbOk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbOk
				Property Template:
				Class DLL Name:
				Title: Імпорт
				Window Location and Size
					Left:   0.2"
					Top:    1.0"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name:
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						If dfFileName
							If nPar = 1
								Call ImportFileCrv(dfFileName)
							Else If nPar = 2
								Call ImportFileRekv(dfFileName)
			Pushbutton: pbPrint
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbPrint
				Property Template:
				Class DLL Name:
				Title: Друк
				Window Location and Size
					Left:   1.5"
					Top:    1.0"
					Width:  1.217"
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name:
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						Call TablePrint(tblErr, dfFileName, GetPrnDir() || '\\crv_err', '')
			Pushbutton: pbCancel
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title: Відмінити
				Window Location and Size
					Left:   4.8"
					Top:    1.0"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name:
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						Call SalDestroyWindow(hWndForm)
			Child Table: tblErr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Display Settings
					Window Location and Size
						Left:   0.1"
						Top:    1.65"
						Width:  6.05"
						Width Editable? Yes
						Height: 3.0"
						Height Editable? Yes
					Visible? Yes
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					View: Table
					Allow Row Sizing? No
					Lines Per Row: Default
				Memory Settings
					Maximum Rows in Memory: 64000
					Discardable? Yes
				Contents
					Column: colStrErr
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Помилка
						Visible? Yes
						Editable? No
						Maximum Data Length: 254
						Data Type: String
						Justify: Left
						Width:  4.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colCrvRnk
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: РНК
								в ЦРВ
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colCrvDbCode
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: dbcode
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colBranch
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Відділення
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.6"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colFirstName
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Ім'я
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colLastName
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Прізвище
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colMiddleName
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: По-батькові
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colOkpo
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: ЗКПО
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colAdrPcode
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Адреса:
								індекс
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colAdrDomain
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Адреса:
								область
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colAdrRegion
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Адреса:
								район
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colAdrCity
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Адреса:
								місто
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colAdrStreet
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Адреса:
								вулиця,
								дім, кв.
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colPhone1
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Телефон-1
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colPhone2
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Телефон-2
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colPhone3
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Телефон-3
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colPasspSer
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Паспорт:
								серія
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colPasspNumdoc
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Паспорт:
								номер
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colPasspOrgan
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Паспорт:
								ким видано
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colPasspDate
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Паспорт:
								коли
								видано
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Date/Time
						Justify: Center
						Width:  Default
						Width Editable? Yes
						Format: Date
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colBDay
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Дата
								народж.
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Date/Time
						Justify: Center
						Width:  Default
						Width Editable? Yes
						Format: Date
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colBPlace
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Місце
								народження
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colSex
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Стать
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Center
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colWord
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Таємне
								слово
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
				Functions
				Window Variables
				Message Actions
					On UM_Populate
						Call SalWaitCursor(TRUE)
						Call SalTblPopulate(hWndForm, hSql(),
								"select str_err, branch, first_name, last_name, mdl_name, okpo,
								        adr_pcode, adr_domain, adr_region, adr_city, adr_street,
								        phone1, phone2, phone3,
								        passp_ser, passp_num, passp_org, passp_date,
								        bday, bplace, sex, word, crv_rnk, crv_dbcode
								   into :colStrErr, :colBranch, :colFirstName, :colLastName, :colMiddleName, :colOkpo,
								        :colAdrPcode, :colAdrDomain, :colAdrRegion, :colAdrCity, :colAdrStreet,
								        :colPhone1, :colPhone2, :colPhone3,
								        :colPasspSer, :colPasspNumdoc, :colPasspOrgan, :colPasspDate,
								        :colBDay, :colBPlace, :colSex, :colWord, :colCrvRnk, :colCrvDbCode
								   from ow_crvfiles_data
								  where id = :nFileId
								    and err_code > 0", TBL_FillAll)
						Call VisTblAutoSizeColumn(hWndForm, hWndNULL)
						Call SalWaitCursor(FALSE)
		Functions
			Function: ImportFileRekv
				Description:
				Returns
					Boolean:
				Parameters
					String: sPatch
				Static Variables
				Local variables
					String: sDrive
					String: sDir
					String: sFile
					String: sExt
					String: sFilePath
					String: sFileName
					Number: nImpId
					String: sErrMsg
					Number: nErrCode
					Number: nCountNd
					Number: nCountErr
				Actions
					If sPatch = ''
						Return TRUE
					Call SalWaitCursor(TRUE)
					Call VisDosSplitPath(sPatch, sDrive, sDir, sFile, sExt)
					Set sFilePath = sDrive || sDir
					Set sFileName = sFile || sExt
					! Импорт файла во временную таблицу
					If not LoadFile(hWndForm, 'Завантаження файлу', sFileName, sFilePath || Chr(92) || sFileName, nImpId)
						Return FALSE
					! Обработка файла
					If not SqlPLSQLCommand(hSql(), "bars_ow.import_op_file(nImpId, nErrCode)")
						Call SqlRollback(hSql())
						Return FALSE
					Call SqlCommit(hSql())
					Call SalWaitCursor(FALSE)
					Call SaveInfoToLog("WAY4. Виконано поновлення реквізитів клієнтів по файлу " || sFileName)
					Call SalMessageBox("Виконано поновлення реквізитів клієнтів по файлу " || sFileName, "Повідомлення", MB_IconAsterisk | MB_Ok)
					Call CreateTicketRekv(sPatch, nImpId)
					Return TRUE
			Function: ImportFileCrv
				Description:
				Returns
					Boolean:
				Parameters
					String: sPatch
				Static Variables
				Local variables
					String: sDrive
					String: sDir
					String: sFile
					String: sExt
					String: sFilePath
					String: sFileName
					String: sErrMsg
					Number: nErrCode
					Number: nCountNd
					Number: nCountErr
				Actions
					If sPatch = ''
						Return TRUE
					Call SalWaitCursor(TRUE)
					Call VisDosSplitPath(sPatch, sDrive, sDir, sFile, sExt)
					Set sFilePath = sDrive || sDir
					Set sFileName = sFile || sExt
					If not GetImpId(nFileId)
						Return FALSE
					! Импорт файла во временную таблицу
					If not PutFileToClob(hSql(), sPatch, 'ow_impfile', 'id', 'file_data', nFileId, STRING_Null, STRING_Null, 1)
						Return FALSE
					! Обработка файла
					If not SqlPLSQLCommand(hSql(), "bars_owcrv.import_crvfile(sFileName, nFileId, nErrCode)")
						Call SqlRollback(hSql())
						Return FALSE
					Call SqlCommit(hSql())
					Call SalWaitCursor(FALSE)
					Call SqlPrepareAndExecute(hSql(),
							"select sum(decode(err_code,0,1,0)), sum(decode(err_code,0,0,1))
							   into :nCountNd, :nCountErr
							   from ow_crvfiles_data
							  where id = :nFileId")
					Call SqlFetchNext(hSql(), nFetchRes)
					Call SaveInfoToLog("WAY4. " || sFileName || ": " ||
							     IifS(nCountErr>0,"Файл оброблено з помилками!" || "Помилкових рядків: " || Str(nCountErr), "") ||
							     IifS(nCountNd>0, "Відкрито карток: " || Str(nCountNd), ""))
					Call SalMessageBox(
							     IifS(nCountErr>0,"Файл оброблено з помилками!" || PutCrLf() || "Помилкових рядків: " || Str(nCountErr) || PutCrLf(), "") ||
							     IifS(nCountNd>0, "Відкрито карток: " || Str(nCountNd), ""), sFileName, MB_IconAsterisk | MB_Ok)
					If nCountErr > 0
						Call SalEnableWindow(pbPrint)
						Call SalShowWindow(pbPrint)
						Call SalShowWindow(tblErr)
						Call SalSetWindowSize(hWndForm, 6.5, 5.2)
						Call SalSendMsg(tblErr, UM_Populate, 0, 0)
					Call CreateTicketCrv(sPatch, nFileId)
					Return TRUE
			Function: CreateTicketRekv
				Description:
				Returns
					Boolean:
				Parameters
					String: sPatch
					Number: nImpId
				Static Variables
				Local variables
					String: sDrive
					String: sDir
					String: sFile
					String: sExt
					String: sFileName
				Actions
					Call SalWaitCursor(TRUE)
					Call VisDosSplitPath(sPatch, sDrive, sDir, sFile, sExt)
					Set sFileName = sDrive || sDir || '\\' || 'R_' || sFile || '.txt'
					If not PutClobToFile(hSql(), sFileName, 'OW_IMPFILE', 'ID', 'FILE_DATA', nImpId, STRING_Null, STRING_Null)
						Call SalWaitCursor(FALSE)
						Call SalMessageBox('Помилка формування квитанції', 'Помилка', MB_IconStop | MB_Ok)
						Return FALSE
					Call SqlCommit(hSql())
					Call SalWaitCursor(FALSE)
					Call SalMessageBox('Сформовано квитанцію ' || sFileName, "Повідомлення", MB_IconAsterisk | MB_Ok)
					Return TRUE
			Function: CreateTicketCrv
				Description:
				Returns
					Boolean:
				Parameters
					String: sPatch
					Number: nFileId
				Static Variables
				Local variables
					String: sDrive
					String: sDir
					String: sFile
					String: sExt
					String: sFileName
				Actions
					Call SalWaitCursor(TRUE)
					Call VisDosSplitPath(sPatch, sDrive, sDir, sFile, sExt)
					Set sFileName = sDrive || sDir || '\\' || 'R_' || sFile || sExt
					! формируем данные для файла
					If not SqlPLSQLCommand(hSql(), "bars_owcrv.form_ticket(nFileId)")
						Call SqlRollback(hSql())
						Call SalWaitCursor(FALSE)
						Return FALSE
					If not PutClobToFile(hSql(), sFileName, 'OW_IMPFILE', 'ID', 'FILE_DATA', nFileId, STRING_Null, STRING_Null)
						Call SalWaitCursor(FALSE)
						Call SalMessageBox('Помилка формування квитанції', 'Помилка', MB_IconStop | MB_Ok)
						Return FALSE
					Call SqlCommit(hSql())
					Call SalWaitCursor(FALSE)
					Call SalMessageBox('Сформовано квитанцію ' || sFileName, "Повідомлення", MB_IconAsterisk | MB_Ok)
					Return TRUE
			Function: PrintDoc
				Description:
				Returns
					Boolean:
				Parameters
					Number: nFileId
				Static Variables
				Local variables
					String: sTemplateId
					String: sPath
					Number: ND
					String: sNls
					Long String: sDoc
					: cCnc
						Class: cABSConnect
					: cCnc2
						Class: cABSConnect
					String: sDocName
					File Handle: hFile
				Actions
					Set sTemplateId = GetGlobalOption('W4_DOC')
					If sTemplateId = ''
						Call SalMessageBox('Не описано шаблон для друку договорів!', 'Увага!', MB_Ok | MB_IconExclamation)
						Return FALSE
					! Путь к квитанциям
					Set sPath = GetPrnDir() || '\\W4_DOC'
					Call SalFileCreateDirectory(sPath)
					If SqlPrepareAndExecute(hSql(),
							'select w.nd, a.nls into :ND, :sNls
							   from ow_crvfiles_data w, ow_crv_deal d, accounts a
							  where w.id = :nFileId
							    and w.nd = d.nd
							    and d.acc_pk = a.acc')
						While SqlFetchNext(hSql(), nFetchRes)
							Call XConnectGetParams(cCnc)
							If cCnc.Connect() and cCnc2.Clone(cCnc, TRUE)
								Set sDoc = cdoc_CreateDocFromTemplate(cCnc.hSql(), cCnc2.hSql(), sTemplateId, ND, 0)
								If sDoc
									Set sDocName = GetTempFileName()
									If SalFileOpen(hFile, sDocName, OF_Write | OF_Create | OF_Text)
										Call SalFileWrite(hFile, sDoc, SalStrLength(sDoc))
										Call SalFileClose(hFile)
										Call SalFileCopy(sDocName, sPath || '\\' || sNls || '.rtf', TRUE)
								Call cCnc.Disconnect()
								Call cCnc2.Disconnect()
					Return TRUE
		Window Parameters
			! nPar:
			! 1 - Импорт файлов из ЦРВ
			! 2 - Импорт файлов на обновление реквизитов клиентов
			! 3 - импорт файлов F (Петрокоммерц) Oracle 9.0
			Number: nPar
		Window Variables
			String: strFilters[2]
			Number: nIndex
			String: strFile
			String: dfPath
			Number: nFileId
			! !
			Number: nWinX0
			Number: nWinY0
			Number: nWinWidth
			Number: nWinHeight
		Message Actions
			On SAM_Create
				Call SalSetWindowText(hWndForm, AppVersion || IifS(nPar=1,
						     "ЦРВ-Way4. Відкриття карток по файлу з ЦРВ",
						     "Way4. Імпорт файлів F"))
				Call PrepareWindowEx(hWndForm)
				! Set strFilters[0] = 'Файли ЦРВ *.xml'
				! Set strFilters[1] = '*.xml'
				Call SalHideWindow(pbPrint)
				Call SalHideWindow(tblErr)
				Call SalSetWindowSize(hWndForm, 6.5, 2.15)
			On WM_Size
				Call GetClientRect(hWndForm, nWinX0, nWinY0, nWinWidth, nWinHeight)
				Call SalSetWindowSize(hWndForm.frmImportFile.tblErr,
						     SalPixelsToFormUnits(hWndForm.frmImportFile.tblErr, nWinWidth, FALSE)-0.25,
						     SalPixelsToFormUnits(hWndForm.frmImportFile.tblErr, nWinHeight, TRUE)-1.8)
				Call SalInvalidateWindow(hWndForm)
	Table Window: tblTickets
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Way4. Обробка квитанцій з Way4
		Icon File:
		Accesories Enabled? Class Default
		Visible? Class Default
		Display Settings
			Visible at Design time? Yes
			Automatically Created at Runtime? Class Default
			Initial State: Class Default
			Maximizable? Class Default
			Minimizable? Class Default
			System Menu? Class Default
			Resizable? Class Default
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  13.3"
				Width Editable? Class Default
				Height: 6.4"
				Height Editable? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: Class Default
			Text Color: Class Default
			Background Color: Class Default
			View: Class Default
			Allow Row Sizing? Class Default
			Lines Per Row: Class Default
		Memory Settings
			Maximum Rows in Memory: Class Default
			Discardable? Class Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Class Default
				Visible? Class Default
				Size: Class Default
				Size Editable? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
			Contents
				Pushbutton: pbIns
					Class Child Ref Key: 33
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbDel
					Class Child Ref Key: 34
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbRefresh
					Class Child Ref Key: 35
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbUpdate
					Class Child Ref Key: 36
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\CHKMAIL.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = "Обробити квитанції"
				Line
					Resource Id: 50586
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbSearch
					Class Child Ref Key: 38
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbFilter
					Class Child Ref Key: 44
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbDetails
					Class Child Ref Key: 39
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 50587
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbExit
					Class Child Ref Key: 42
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 50588
					Class Child Ref Key: 43
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
		Contents
			Column: colTickName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ім'я
						файла-квитанції
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colStatus
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Статус файла
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colAcceptRec
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Кількість
						прийнятих
						заяв
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colRejectRec
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Кількість
						НЕприйнятих
						заяв
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colComment
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Коментар
				Visible? Yes
				Editable? No
				Maximum Data Length: 254
				Data Type: String
				Justify: Left
				Width:  4.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colId
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title:
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  Default
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
		Functions
			Function: ImportTickets
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Number: nFiles
					String: smFile[*]
					Number: i
					Number: nRow
					String: sErr
				Actions
					If sPathTicket = ''
						Call SalMessageBox("Не описано каталог для квитанцій!", "Увага!", MB_IconStop | MB_Ok)
						Return FALSE
					If sPathBackUp = ''
						Call SalMessageBox("Не описано архівний каталог!", "Увага!", MB_IconStop | MB_Ok)
						Return FALSE
					Set nFiles = VisDosEnumFiles(sPathTicket || '\\' || sTickMaska ||'*.*', FA_Standard, smFile)
					! Если квитанций нет - выходим
					If nFiles < 0
						Call SalMessageBox("Відсутні квитанції в " || sPathTicket, "Увага!", MB_IconExclamation | MB_Ok)
						Return FALSE
					! Обработка квитанций
					! Импорт файлов
					Call SalWaitCursor(TRUE)
					! Set nFilesCount = 0
					Set i = 0
					While i < nFiles
						Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
						Call SalTblSetContext(hWndForm, nRow)
						Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
						Set colTickName = SalStrUpperX(smFile[i])
						If not ImportFile(sPathTicket, colTickName, colId, sErr)
							Set colComment = 'Помилка імпорту: ' || sErr
							Call SalColorSet(colComment, COLOR_IndexCellText, COLOR_Red)
						Else
							If colId > 0
								Call SqlPrepareAndExecute(hSql(), "select err_text into :sErr from ow_files where file_name = upper(:colTickName)")
								Call SqlFetchNext(hSql(), nFetchRes)
								If sErr
									Call XSalTblSetRowBackColor(hWndForm, SalTblQueryContext(hWndForm), COLOR_Salmon)
									Set colComment = sErr
								Else
									Set colComment = 'Квитанцію оброблено'
								! Читаем данные квитовки
								Call SqlPrepareAndExecute(hSql(),
										"select tick_status, tick_accept_rec, tick_reject_rec
										   into :colStatus, :colAcceptRec, :colRejectRec
										   from " || sSqlTable || "
										  where upper(file_name) = substr(:colTickName,:nPos)
										    and trunc(tick_date) = trunc(sysdate)")
								Call SqlFetchNext(hSql(), nFetchRes)
								If colAcceptRec = 0 and colRejectRec > 0
									Call XSalTblSetRowBackColor(hWndForm, SalTblQueryContext(hWndForm), COLOR_Salmon)
								Else If colRejectRec > 0
									Call XSalTblSetRowBackColor(hWndForm, SalTblQueryContext(hWndForm), SalColorFromRGB(255,200,200))
							Else
								If sErr
									Call XSalTblSetRowBackColor(hWndForm, SalTblQueryContext(hWndForm), COLOR_Salmon)
									Set colComment = sErr
						Set i = i + 1
					Call VisTblAutoSizeColumn(hWndForm, colTickName)
					Call VisTblAutoSizeColumn(hWndForm, colComment)
					Call SalWaitCursor(FALSE)
					Return TRUE
			Function: ImportFile
				Description:
				Returns
					Boolean:
				Parameters
					String: sFilePath
					String: sFileName
					Receive Number: nId
					Receive String: sErr
				Static Variables
				Local variables
					Number: i
				Actions
					! Импорт файла во временную таблицу
					If not LoadFile(hWndForm, 'Завантаження файлу', sFileName, sFilePath || Chr(92) || sFileName, nId)
						Return FALSE
					! Обработка файла - может свалиться на импорте файла, может на оплате
					Call SalWaitCursor(TRUE)
					! вызываем окно выполнения
					Call StartProgress(SalWindowHandleToNumber(hWndForm), 'Обробка файлу', sFileName)
					! без этого не показывается окно выполнения :)
					Call SalCreateWindow(Dummy, hWndForm)
					Call SalDestroyWindow(Dummy)
					Call SalInvalidateWindow(hWndForm)
					! Обработка файла
					If not SqlPLSQLCommand(hSql(), "bars_ow.import_file(sFileName, nId, sErr)")
						Call SqlRollback(hSql())
						Call SaveInfoToLog("Way4. Неуспешная загрузка файла " || sFileName )
						! закрываем окно выполнения
						Call StopProgress()
						Return FALSE
					If nId > 0
						Call SqlCommitEx(hSql(), "Way4. " || sFileName || ": Файл записано до БД")
						! Помещаем файл в архив
						Call OW_BackUpFile(sFilePath, sFileName, sPathBackUp)
						! Обработка файла
						If not SqlPLSQLCommand(hSql(), "p_job_w4importfiles(nId)")
							Call SqlRollback(hSql())
							Set sErr = 'Помилка обробки файлу'
							Call SaveInfoToLog("Way4. Неуспешный разбор файла " || sFileName )
							! закрываем окно выполнения
							Call StopProgress()
							Return FALSE
						Call SqlCommitEx(hSql(), "Обработана квитанция " || sFileName)
					Else
						Call SqlRollback(hSql())
					! закрываем окно выполнения
					Call StopProgress()
					Return TRUE
		Window Parameters
			String: sTickMaska
		Window Variables
			String: sPathTicket
			String: sPathBackUp
			String: sSqlTable
			Number: nPos
		Message Actions
			On SAM_Create
				If sTickMaska = 'RXA'
					Call SalSetWindowText(hWndForm, AppVersion || "Way4. Обробка квитанцій RXA з Way4")
					! CRV_RXADIR - каталог для импорта квитанций RXA
					Set sPathTicket = GetValueStr("select substr(val,1,100) from ow_params where par = 'CRV_RXADIR'")
					Set sPathBackUp = GetValueStr("select substr(val,1,100) from ow_params where par = 'CRV_BCKDIR'")
					Set sSqlTable     = "ow_xafiles"
					Set nPos = 2
				Else If sTickMaska = 'R_IIC'
					Call SalSetWindowText(hWndForm, AppVersion || "Way4. Обробка квитанцій R_IIC з Way4")
					! RIICFDIR - каталог для импорта квитанций R_IIC
					Set sPathTicket = GetValueStr("select substr(val,1,100) from ow_params where par = 'RIICFDIR'")
					Set sPathBackUp = GetValueStr("select substr(val,1,100) from ow_params where par = 'RIICBCKDIR'")
					Set sSqlTable     = "ow_iicfiles"
					Set nPos = 3
				Else If sTickMaska = 'R_OIC'
					Call SalSetWindowText(hWndForm, AppVersion || "Way4. Обробка квитанцій R_OIC з Way4")
					! RIICFDIR - каталог для импорта квитанций R_OIC
					Set sPathTicket = GetValueStr("select substr(val,1,100) from ow_params where par = 'RIICFDIR'")
					Set sPathBackUp = GetValueStr("select substr(val,1,100) from ow_params where par = 'RIICBCKDIR'")
					Set sSqlTable     = "OW_OICREVFILES"
					Set nPos = 3
				Call PrepareWindowEx(hWndForm)
				Set hWndForm.tblTickets.nFlags = GT_NoIns | GT_NoDel
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On UM_Populate
				Call SalTblReset(hWndForm)
			On UM_Update
				Call ImportTickets()
	Table Window: tblW4Portfolio
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Way4. Портфель БПК
		Icon File:
		Accesories Enabled? Class Default
		Visible? Class Default
		Display Settings
			Visible at Design time? Yes
			Automatically Created at Runtime? Class Default
			Initial State: Class Default
			Maximizable? Class Default
			Minimizable? Class Default
			System Menu? Class Default
			Resizable? Class Default
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  Class Default
				Width Editable? Class Default
				Height: Class Default
				Height Editable? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: Class Default
			Text Color: Class Default
			Background Color: Class Default
			View: Class Default
			Allow Row Sizing? Class Default
			Lines Per Row: Class Default
		Memory Settings
			Maximum Rows in Memory: 64000
			Discardable? Class Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Class Default
				Visible? Class Default
				Size: Class Default
				Size Editable? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
			Contents
				!
				Pushbutton: pbRefresh
					Class Child Ref Key: 35
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.05"
						Top:    0.06"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbFilter
					Class Child Ref Key: 44
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.5"
						Top:    0.06"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Click
							If SetQueryFilterEx(cF_BPK)
								Call SalPostMsg(hWndForm, UM_Populate, 0, 0)
				Pushbutton: pbSearch
					Class Child Ref Key: 38
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.95"
						Top:    0.06"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.4"
						Top:    0.06"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 57657
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  8.5"
						Begin Y:  0.0"
						End X:  8.5"
						End Y:  0.5"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbIns
					Class Child Ref Key: 33
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.0"
						Top:    0.06"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Нова картка'
				Pushbutton: pbCngCardType
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.45"
						Top:    0.06"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \bars98\RESOURCE\BMP\CHEKIN.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Змінити тип картки'
						On SAM_Click
							If colNd
								If CngCardType(colNd, colCard_code)
									Call SalPostMsg(hWndForm, UM_Populate, 0, 0)
				Pushbutton: pbUpdate
					Class Child Ref Key: 36
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.9"
						Top:    0.06"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \bars98\RESOURCE\BMP\SAVE.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Зберегти зміни'
				Pushbutton: pbDel
					Class Child Ref Key: 34
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.9"
						Top:    0.06"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? No
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 57658
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  3.4"
						Begin Y:  0.0"
						End X:  3.4"
						End Y:  0.5"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbCreateRequest
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.5"
						Top:    0.06"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\UNDO1.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Сформувати запит до CardMake'
						On SAM_Click
							If colNd
								Call SendQuery()
				Line
					Resource Id: 48843
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  4.0"
						Begin Y:  0.0"
						End X:  4.0"
						End Y:  0.5"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Pushbutton: pbCustomer
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbBrowse
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.1"
						Top:    0.06"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\CUSTPERS.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Картка клієнта'
						On SAM_Click
							If colNd
								Select Case colCust_type
									Case 2
										Call EditCustCorpsEx(colCust_rnk, nCustFlags, hWndForm, 0, '', FALSE)
										Break
									Case 3
										Call EditCustPersonEx(colCust_rnk, nCustFlags, hWndForm, 0, '', FALSE)
										Break
									Default
										Break
				Pushbutton: pbDetails
					Class Child Ref Key: 39
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.55"
						Top:    0.06"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Картковий рахунок'
				Pushbutton: pbAccounts
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbBrowse
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   5.0"
						Top:    0.06"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\BOOK.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Рахунки угоди'
						On SAM_Click
							If colNd
								Call ShowAccList(colCust_rnk, AVIEW_CUST, nAccsFlags,
										"a.acc in (select acc from v_w4_nd_acc where nd = " || Str(colNd) || " and acc is not null)")
				Pushbutton: pbAccHistory
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbBrowse
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   5.45"
						Top:    0.06"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\BOOKS.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Історя рахунку'
						On SAM_Click
							If colNd
								Call Show_Sal_Day_P(colAcc_acc, STRING_Null, NUMBER_Null, DATETIME_Null, DATETIME_Null)
				Pushbutton: pbDocs
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   5.9"
						Top:    0.06"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\DOCS.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Документи по рахунку'
						On SAM_Click
							If colNd
								Call ShowAllDocs(hWndMDI,1,0,
										   "(a.nlsa='" || colAcc_nls || "' and a.kv=" || Str(colAcc_kv) ||
										" or a.nlsb='" || colAcc_nls || "' and nvl(a.kv2,a.kv)=" || Str(colAcc_kv) || ")",
										"Документи по рахунку " || colAcc_nls || "/" || colAcc_lcv)
				Line
					Resource Id: 2261
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  6.4"
						Begin Y:  0.0"
						End X:  6.4"
						End Y:  0.5"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Line
					Resource Id: 39446
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  7.9"
						Begin Y:  0.0"
						End X:  7.9"
						End Y:  0.5"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Pushbutton: pbZalog
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cTBarButton
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   6.5"
						Top:    0.06"
						Width:  0.433"
						Width Editable? Class Default
						Height: 0.321"
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\A_accs.bmp
					Picture Transparent Color: Gray
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Новые Договора ОБЕСПЕЧЕНИЯ'
						On SAM_Click
							If colNd
								! Call Sel017(hWndMDI, IifN(nParEdit=0, 90, 30), 2, NETTO.ND, Str(NETTO.nGrp), Str(NETTO.RNKK), NETTO.ACC)
								! ND=0
								Call Sel017(hWndMDI, IifN(nPar=1,30,90), 2, 0, '', Str(colCust_rnk), colAcc_acc)
				Pushbutton: pbZalog_All
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cTBarButton
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   6.95"
						Top:    0.06"
						Width:  0.433"
						Width Editable? Class Default
						Height: 0.321"
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\Pach.bmp
					Picture Transparent Color: Gray
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Существующие Договора ОБЕСПЕЧЕНИЯ'
						On SAM_Click
							! Call Sel017(hWndMDI, IifN(nParEdit=0, 90, 30), 11, NETTO.ND, Str(NETTO.nGrp), Str(NETTO.RNKK), NETTO.ACC)
							! ND=0
							Call Sel017(hWndMDI, IifN(nPar=1,30,90), 11, colNd, '', Str(colCust_rnk), colAcc_acc)
				Pushbutton: pbZ
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cTBarButton
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   7.4"
						Top:    0.06"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \bars98\RESOURCE\BMP\Tudasuda.bmp
					Picture Transparent Color: White
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Light Gray
					Message Actions
						On SAM_Create
							Set strTip = 'Связь Договоров ОБЕСПЕЧЕНИЯ'
						On SAM_Click
							! Call Bars017r1(IifN(nParEdit=0,101,NUMBER_Null), NUMBER_Null, NUMBER_Null,
									" and KU_109.ACCK in (select acc from nd_acc where nd=" || Str(NETTO.ND) || " )")
							Call Bars017r1(IifN(nPar=1,NUMBER_Null,101), NUMBER_Null, NUMBER_Null, "")
				Pushbutton: pbExit
					Class Child Ref Key: 42
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   8.0"
						Top:    0.06"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 57659
					Class Child Ref Key: 43
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  1.9"
						Begin Y:  Class Default
						End X:  1.9"
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
		Contents
			Column: colNd		! N Номер договора
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Номер
						угоди
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Number
				Justify: Class Default
				Width:  1.0"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colBranch	! S Код отделения
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Код
						відділення
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Class Default
				Justify: Class Default
				Width:  2.2"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colAcc_acc	! N
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Acc
				Visible? No
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Number
				Justify: Class Default
				Width:  Class Default
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colAcc_nls	! S Номер счета
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Картковий
						рахунок
				Visible? Class Default
				Editable? Class Default
				Maximum Data Length: Class Default
				Data Type: Class Default
				Justify: Class Default
				Width:  1.8"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
					On SAM_SetFocus
						Set sTmp = colAcc_nls
					On SAM_AnyEdit
						Set colAcc_nls = sTmp
						Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
			Column: colAcc_kv	! N Код вал.
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Код
						вал.
				Visible? No
				Editable? No
				Maximum Data Length: 3
				Data Type: Number
				Justify: Center
				Width:  0.8"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colAcc_lcv	! S Код вал.
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Код
						вал.
				Visible? Class Default
				Editable? No
				Maximum Data Length: 3
				Data Type: Class Default
				Justify: Center
				Width:  0.6"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colAcc_ob22	! S
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: ОБ22
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Class Default
				Justify: Center
				Width:  0.6"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colAcc_tip	! S
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Tip
				Visible? No
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Class Default
				Justify: Class Default
				Width:  Class Default
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colAcc_tipname	! S Тип счета (Субпродукт)
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Субпродукт
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Class Default
				Justify: Left
				Width:  3.0"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colCard_code	! S Тип карты
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Тип
						картки
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Class Default
				Justify: Class Default
				Width:  3.0"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colAcc_ost	! N Остаток
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Залишок
						на рахунку
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Class Default
				Format: Decimal
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colAcc_fost	! N Остаток
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Розрахун-
						ковий
						залишок
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Class Default
				Format: Decimal
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colAcc_daos	! D Дата открытия счета
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Дата
						відкриття
						рахунку
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.2"
				Width Editable? Class Default
				Format: Date
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colCust_rnk	! N Рег.номер клиента
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Реєстр.
						номер
						клієнта
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colCust_name	! S ФИО (наименование) клиента
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: ПІБ (назва)
						клієнта
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Class Default
				Justify: Class Default
				Width:  4.0"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colCust_okpo	! S ОКПО клиента
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: ЗКПО
						клієнта
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Class Default
				Justify: Class Default
				Width:  1.2"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colCust_type	! N
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Custtype
				Visible? No
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Number
				Justify: Class Default
				Width:  Class Default
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colAcc_dazs	! D Дата закрытия счета
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Дата
						закриття
						рахунку
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.2"
				Width Editable? Class Default
				Format: Date
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colPassDate	! D Дата передачі справи
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Дата
						передачі
						справи
				Visible? Class Default
				Editable? Class Default
				Maximum Data Length: Class Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.2"
				Width Editable? Class Default
				Format: Date
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colPassState		! N Стан передачі справ до Бек-офісу
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title:
				Visible? No
				Editable? Class Default
				Maximum Data Length: Class Default
				Data Type: Number
				Justify: Class Default
				Width:  Class Default
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colPassStateName	! S Стан передачі справ до Бек-офісу
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenColComboBox_NumId
				Property Template:
				Class DLL Name:
				Title: Стан передачі
						справ
						до Бек-офісу
				Visible? Class Default
				Editable? Class Default
				Maximum Data Length: Class Default
				Data Type: Class Default
				Justify: Class Default
				Width:  2.0"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
					On SAM_Create
						Call colPassStateName.Init(hWndItem)
						Call colPassStateName.Add(1, 'передано')
						Call colPassStateName.Add(2, 'перевірено')
						Call colPassStateName.Add(3, 'повернуто на доопрацювання')
						Call colPassStateName.SetSelectById(colPassState)
						Call SalSendMsg(hWndItem, SAM_Click, 0, 0)
					On SAM_AnyEdit
						Set colPassState = colPassStateName.GetKey(SalListQuerySelection(colPassStateName))
			Column: colDatOgigCA	! D Дата передачі оригіналів договорів в ЦА
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Дата
						передачі
						оригіналів
						договорів
						в ЦА
				Visible? Class Default
				Editable? Class Default
				Maximum Data Length: Class Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.2"
				Width Editable? Class Default
				Format: Date
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colDatCalcPay	! D Дата розрахунку платоспроможності клієнта
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Дата
						розрахунку
						платоспром.
						клієнта
				Visible? Class Default
				Editable? Class Default
				Maximum Data Length: Class Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.2"
				Width Editable? Class Default
				Format: Date
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
		Functions
			Function: SendQuery
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					String: sPk
					String: sSem
					Number: nOperType
				Actions
					If FunNSIGetFiltered("v_cm_opertype", "name", "clienttype is null or clienttype=" || Str(IifN(Subs(colAcc_nls,1,4)='2625',2,1)), sPk, sSem)
						If SalMessageBox("Сформувати запит" || PutCrLf() || sSem || PutCrLf() || "для" || PutCrLf() || colAcc_nls || ' ' || colCust_name || "?", "Увага!", MB_IconQuestion | MB_YesNo) = IDYES
							Set nOperType = Val(sPk)
							If SqlPLSQLCommand(hSql(), 'bars_ow.add_deal_to_cmque(colNd, nOperType, NUMBER_Null, STRING_Null, NUMBER_Null)')
								Call SqlCommitEx(hSql(), "Сформовано запит " || sSem || " для " || colAcc_nls || ' ' || colCust_name)
								Call SalMessageBox("Сформовано запит" || PutCrLf() || sSem || PutCrLf() || "для" || PutCrLf() || colAcc_nls || ' ' || colCust_name, "Повідомлення", MB_IconAsterisk | MB_Ok)
							Else
								Call SqlRollback(hSql())
					Return TRUE
			Function: CngCardType
				Description:
				Returns
					Boolean:
				Parameters
					Number: nNd
					String: sOldCardCode
				Static Variables
				Local variables
					String: sCardCode
					String: sCardSubCode
				Actions
					If FunNSIGetFilteredAltPK("w4_card", "code", "subcode",
							   " nvl(w4_card.date_open,bankdate) <= bankdate
							 and nvl(w4_card.date_close,bankdate+1) > bankdate
							 and w4_card.code in ( " ||
							   "select d.code from w4_card c, w4_product p, w4_card d
							     where c.code = '" || sOldCardCode || "'
							       and c.product_code = p.code
							       and p.grp_code <> 'SALARY'
							       and c.product_code = d.product_code and d.code <> '" || sOldCardCode || "'
							     union
							    select d.code from w4_card c, w4_product p, w4_card d, bpk_proect b, bpk_proect_card t
							     where c.code = '" || sOldCardCode || "'
							       and c.product_code = p.code
							       and p.grp_code = 'SALARY'
							       and c.product_code = d.product_code and d.code <> '" || sOldCardCode || "'
							       and d.product_code = b.product_code
							       and b.okpo = t.okpo and nvl(b.okpo_n,0) = t.okpo_n and d.code = t.card_code  )", sCardCode, sCardSubCode)
						If SalMessageBox("Поміняти тип картки для " || PutCrLf() || colAcc_nls || " " || colCust_name || PutCrLf() ||
								   "з "  || sOldCardCode || PutCrLf() ||
								   "на " || sCardCode, "Увага!", MB_IconQuestion | MB_YesNo) = IDYES
							If SqlPLSQLCommand(hSql(), 'bars_ow.cng_card(nNd, sCardCode)')
								Call SqlCommitEx(hSql(), "Змінено тип картки для " || colAcc_nls || " " || colCust_name)
								Call SalMessageBox("Змінено тип картки для " || PutCrLf() || colAcc_nls || " " || colCust_name, "Повідомлення", MB_IconAsterisk | MB_Ok)
							Else
								Call SqlRollback(hSql())
					Return TRUE
		Window Parameters
			Number: nPar
			String: sFilter
		Window Variables
			: cF_BPK
				Class: cGenFilterEx
			String: strDynSql
			Number: nCount
			Number: nRow
			String: sTmp
			Number: nCustFlags
			Number: nAccsFlags
			Number: nAccAccess
		Message Actions
			On SAM_Create
				! Портфель БПК
				If nPar = 1
					Call SalSetWindowText(hWndForm, AppVersion || "Way4. Портфель БПК")
					Set nCustFlags = CVIEW_Saldo
					Set nAccsFlags = AVIEW_Financial | AVIEW_Special | AVIEW_NoOpen
					Set nAccAccess = ACCESS_FULL
					Set hWndForm.tblW4Portfolio.nFlags = GT_NoDel
				! Портфель БПК - перегляд
				Else
					Call SalSetWindowText(hWndForm, AppVersion || "Way4. Портфель БПК - перегляд")
					Set nCustFlags = CVIEW_Saldo | CVIEW_ReadOnly
					Set nAccsFlags = AVIEW_Financial | AVIEW_Special | AVIEW_NoOpen | AVIEW_ReadOnly
					Set nAccAccess = ACCESS_READONLY
					Set hWndForm.tblW4Portfolio.nFlags = GT_ReadOnly
					Call SalDisableWindow(pbIns)
					Call SalDisableWindow(pbUpdate)
					Call SalDisableWindow(pbDel)
					Call SalDisableWindow(hWndForm.tblW4Portfolio.colPassDate)
					Call SalDisableWindow(hWndForm.tblW4Portfolio.colPassStateName)
					Call SalDisableWindow(hWndForm.tblW4Portfolio.colDatOgigCA)
					Call SalDisableWindow(hWndForm.tblW4Portfolio.colDatCalcPay)
				Call PrepareWindowEx(hWndForm)
				Call SetWindowFullSize(hWndForm)
				Call SalTblSetTableFlags(hWndForm, TBL_Flag_SingleSelection, TRUE)
				Set hWndForm.tblW4Portfolio.strFilterTblName = 'w4_deal'
				Set hWndForm.tblW4Portfolio.strPrintFileName = 'w4_deal'
				Set hWndForm.tblW4Portfolio.fFilterAtStart = TRUE
				Set hWndForm.tblW4Portfolio.nTabInstance   = 1
				Set hWndForm.tblW4Portfolio.strSqlPopulate =
						"select w4_deal.nd, w4_deal.card_code, w4_deal.branch, w4_deal.acc_acc, w4_deal.acc_nls, w4_deal.acc_kv, w4_deal.acc_lcv,
						        w4_deal.acc_ob22, w4_deal.acc_tip, w4_deal.acc_tipname, w4_deal.acc_ost, w4_deal.acc_fost, w4_deal.acc_daos, w4_deal.acc_dazs,
						        w4_deal.cust_rnk, w4_deal.cust_name, w4_deal.cust_okpo, w4_deal.cust_type, w4_deal.pass_date, w4_deal.pass_state,
						        w4_deal.dat_orig_ca, w4_deal.dat_calc_pay
						   into :hWndForm.tblW4Portfolio.colNd, :hWndForm.tblW4Portfolio.colCard_code, :hWndForm.tblW4Portfolio.colBranch,
						        :hWndForm.tblW4Portfolio.colAcc_acc, :hWndForm.tblW4Portfolio.colAcc_nls,
						        :hWndForm.tblW4Portfolio.colAcc_kv, :hWndForm.tblW4Portfolio.colAcc_lcv,
						        :hWndForm.tblW4Portfolio.colAcc_ob22, :hWndForm.tblW4Portfolio.colAcc_tip, :hWndForm.tblW4Portfolio.colAcc_tipname,
						        :hWndForm.tblW4Portfolio.colAcc_ost, :hWndForm.tblW4Portfolio.colAcc_fost,
						        :hWndForm.tblW4Portfolio.colAcc_daos, :hWndForm.tblW4Portfolio.colAcc_dazs,
						        :hWndForm.tblW4Portfolio.colCust_rnk,  :hWndForm.tblW4Portfolio.colCust_name,
						        :hWndForm.tblW4Portfolio.colCust_okpo, :hWndForm.tblW4Portfolio.colCust_type,
						        :hWndForm.tblW4Portfolio.colPassDate, :hWndForm.tblW4Portfolio.colPassState,
						        :hWndForm.tblW4Portfolio.colDatOgigCA, :hWndForm.tblW4Portfolio.colDatCalcPay
						   from w4_deal " || IifS(sFilter='', "", " where (" || sFilter || ")") || "
						  order by nd desc"
				Call cF_BPK.Init('w4_deal', '')
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On SAM_CreateComplete
				Call SalWaitCursor(FALSE)
				Call hWndForm.tblW4Portfolio.cF_BPK.cSimpleFilter.NewString('ACC_DAOS',SalFmtFormatDateTime(GetBankDate(), 'dd.MM.yyyy'))
				If SetQueryFilterEx(cF_BPK)
					If cF_BPK.GetFilterWhereClause(TRUE) != ''
						Call SalPostMsg(hWndForm, UM_Populate, 0, 0)
				Else
					Call SalPostMsg(pbExit, SAM_Click, 0, 0)
			On UM_Populate
				Call SalWaitCursor(TRUE)
				Set nCount = 0
				!
				Call cQ.Init(hWndForm.tblW4Portfolio.strSqlPopulate)
				Set strDynSql = cQ.GetFullSQLStringEx(cF_BPK)
				Call SalTblPopulate(hWndForm, hSql(), T(strDynSql), TBL_FillAll)
				!
				Call SalTblDefineSplitWindow(hWndForm, 1, TRUE)
				Set nRow = SalTblInsertRow(hWndForm, TBL_MinRow)
				Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
				Call SalTblSetContext(hWndForm, nRow)
				Set colBranch  = 'Рахунків всього:'
				Set colAcc_nls = Str(nCount)
				Call SalTblSetContext(hWndForm, 0)
				Call SalSendMsg(hWndForm, SAM_TblDoDetails, 0, 0)
				Call SalWaitCursor(FALSE)
			On SAM_FetchRowDone
				If colAcc_dazs
					Call VisTblSetRowColor(hWndForm, lParam, COLOR_DarkRed)
				If colAcc_ost < 0
					Call SalTblSetCellTextColor(colAcc_ost, COLOR_Red, FALSE)
				If colPassState
					Call colPassStateName.SetSelectById(colPassState)
				Set nCount = nCount + 1
			On UM_Insert
				Call SalCreateWindow(frmW4Card, hWndMDI, hWndForm)
			On UM_Update
				Set nRow = TBL_MinRow
				While SalTblFindNextRow(hWndForm, nRow, ROW_Edited, 0)
					Call SalTblSetContext(hWndForm, nRow)
					If not SqlPLSQLCommand(hSql(), "bars_ow.set_pass_date(colNd, colPassDate, colPassState)")
							or not SqlPLSQLCommand(hSql(), "bars_ow.set_nd_param_indate(colNd, 'DAT_ORIG_CA', colDatOgigCA)")
							or not SqlPLSQLCommand(hSql(), "bars_ow.set_nd_param_indate(colNd, 'DAT_CALC_PAY', colDatCalcPay)")
						Call SqlRollbackEx(hSql(), 'Way4. Помилка збереження параметрів договору ' || Str(colNd))
					Else
						Call SqlCommitEx(hSql(), 'Way4. Збережені параметри договору ' || Str(colNd))
				Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
			On SAM_DoubleClick
				If colNd
					Call OperWithAccountEx(AVIEW_ALL, colAcc_acc, colCust_rnk,
							     IifN(colAcc_dazs!=DATETIME_Null, ACCESS_READONLY, nAccAccess), hWndForm, '')
	Form Window: frmW4Card
		Class: cQuickTabsForm
		Property Template:
		Class DLL Name:
		Title: Way4. Нова угода
		Icon File:
		Accesories Enabled? Yes
		Visible? No
		Display Settings
			Display Style? Class Default
			Visible at Design time? Yes
			Automatically Created at Runtime? Class Default
			Initial State: Class Default
			Maximizable? Class Default
			Minimizable? Class Default
			System Menu? Class Default
			Resizable? Class Default
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  9.4"
				Width Editable? Class Default
				Height: 6.9"
				Height Editable? Class Default
			Form Size
				Width:  Class Default
				Height: Class Default
				Number of Pages: Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: Class Default
			Text Color: Class Default
			Background Color: Class Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Class Default
				Visible? Class Default
				Size: 0.4"
				Size Editable? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
			Contents
				Pushbutton: pbNew	! Нова картка
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbInsert
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.15"
						Top:    0.05"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Нова картка'
						On SAM_Click
							Call SalSetWindowText(hWndForm, "Нова угода")
							Call SetButton(1)
							Call picTabs.BringToTop(0, TRUE)
				Pushbutton: pbCopy	! Копія картки
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbInsert
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.583"
						Top:    0.048"
						Width:  0.0"
						Width Editable? No
						Height: 0.0"
						Height Editable? No
					Visible? No
					Keyboard Accelerator: (none)
					Font Name:
					Font Size: 0
					Font Enhancement: Default
					Picture File Name: \BARS98\RESOURCE\BMP\COPY.BMP
					Picture Transparent Color: None
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_Create
							Set strTip = 'Копія картки'
						On SAM_Click
							Call SalSetWindowText(hWndForm, "Нова угода (копія, " || IifS(nCType=1, "фізична особа", "юридична особа") || ")")
							Call SetButton(2)
							Call picTabs.BringToTop(0, TRUE)
				Line
					Resource Id: 57660
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  1.117"
						Begin Y:  0.0"
						End X:  1.117"
						End Y:  0.476"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: Default
				Pushbutton: pbShowAcc	! Рахунки угоди
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbChilds
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.25"
						Top:    0.048"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\BOOK.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Рахунки угоди'
						On SAM_Click
							Call ShowAccList(nRnk, AVIEW_CUST, AVIEW_Financial | AVIEW_ExistOnly,
									"a.acc in (select acc from v_w4_nd_acc where nd = " || Str(nNd) || ")")
				Pushbutton: pbPrint	! Друк договорів
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbPrint
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.7"
						Top:    0.048"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Друк договорів'
						On SAM_Click
							Call PrintDoc()
				Line
					Resource Id: 57661
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  2.25"
						Begin Y:  0.036"
						End X:  2.25"
						End Y:  0.512"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: Default
				Pushbutton: pbOpen	! Зареєструвати картку
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.367"
						Top:    0.048"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Зареєструвати картку'
						On SAM_Click
							If OpenCard()
								Call SetButton(0)
				Line
					Resource Id: 57662
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  2.9"
						Begin Y:  -0.012"
						End X:  2.9"
						End Y:  0.464"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: Default
				Pushbutton: pbCancel	! Вийти
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbCancel
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.0"
						Top:    0.048"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Вийти'
						On SAM_Click
							Call SalDestroyWindow(hWndForm)
		Contents
			Picture: picTabs
.data CLASSPROPS
0000: 546162546F704D61 7267696E00020030 0000546162466F72 6D50616765730001
0020: 0000005461624472 61775374796C6500 0B0057696E393553 74796C6500005461
0040: 6252696768744D61 7267696E00020030 00005461624E616D 6573000100000054
0060: 61624C6162656C73 0001000000546162 50616765436F756E 7400020031000054
0080: 6162426F74746F6D 4D617267696E0002 0030000054616243 757272656E740001
00A0: 0000005461624C65 66744D617267696E 0002003000005461 624F7269656E7461
00C0: 74696F6E00010000 0000000000000000 0000000000000000 00000000000000
.enddata
.data CLASSPROPSSIZE
0000: DF00
.enddata
.data INHERITPROPS
0000: 0100
.enddata
				Class Child Ref Key: 1
				Class ChildKey: 0
				Class: cQuickTabsForm
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   0.1"
					Top:    0.05"
					Width:  9.0"
					Width Editable? Class Default
					Height: 5.7"
					Height Editable? Class Default
				Visible? Class Default
				Editable? Class Default
				File Name:
				Storage: Class Default
				Picture Transparent Color: Class Default
				Fit: Class Default
				Scaling
					Width:  Class Default
					Height:  Class Default
				Corners: Class Default
				Border Style: Class Default
				Border Thickness: Class Default
				Tile To Parent? Yes
				Border Color: Default
				Background Color: 3D Face Color
				Message Actions
					On SAM_Create
						Call SalSendClassMessage(SAM_Create, wParam, lParam)
						Call createTab(cTabCardClient, 0, 'Клієнт', 'CardClient', 'dlgCardClient')
						Call createTab(cTabCardCard,   1, 'Картка', 'CardCard', 'dlgCardCard')
						Call createTab(cTabCardWay4,   2, 'Way4',   'CardWay4', 'dlgCardWay4')
						! Удаляем последнюю пустую закладку
						Call picTabs.Delete(3, TRUE)
						! Инициализация закладок
						Call picTabs.InitializeFormPages(
								     SalNumberToStrX(0,0) || ';' ||
								     Str(SalWindowHandleToNumber(hWndForm)))
						! Показываем первую закладку
						Call picTabs.BringToTop(0, TRUE)
						Set fActivate = TRUE
					On TABSM_TabActivateStart
						If fActivate
							Set nTabNum = GetTop()
							Call GetName(wParam, sTabName)
							If sTabName = 'CardClient'
								If not bCardOpen
									Call SalSendMsg(picTabs.Items[nTabNum].m_hWndPage, SAM_User, 0, 0)
							If sTabName = 'CardCard'
								If not nCType or bCardOpen
									Call SalSendMsg(picTabs.Items[nTabNum].m_hWndPage, SAM_DoInit, 0, 0)
								Else If nCType and not bCardOpen
									Call SalSendMsg(picTabs.Items[nTabNum].m_hWndPage, SAM_DoInit, 2, 0)
							If sTabName = 'CardWay4'
								If not bCardOpen
									Call SalSendMsg(picTabs.Items[nTabNum].m_hWndPage, SAM_User, 0, 0)
									Call SalSendMsg(picTabs.Items[nTabNum].m_hWndPage, SAM_DoInit, 2, 0)
								Else
									Call SalSendMsg(picTabs.Items[nTabNum].m_hWndPage, SAM_User, 1, 0)
									Call SalSendMsg(picTabs.Items[nTabNum].m_hWndPage, SAM_DoInit, 0, 0)
		Functions
			Function: check
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					String: sMsg
				Actions
					If not SalSendMsg(picTabs.Items[0].m_hWndPage, SAM_User, 10, 0)
						Call SetFocus(0)
						Return FALSE
					If not SalSendMsg(picTabs.Items[1].m_hWndPage, SAM_User, 10, 0)
						Call SetFocus(1)
						Return FALSE
					If not SalSendMsg(picTabs.Items[2].m_hWndPage, SAM_User, 10, 0)
						Call SetFocus(2)
						Return FALSE
					If NOT SqlPrepareAndExecute(hSql(), "select substr(bars_ow.check_opencard(:nRnk, :sCardType),1,254) into :sMsg from dual")
						Return FALSE
					Call SqlFetchNext(hSql(), nFetchRes)
					If sMsg
						If SalMessageBox(sMsg || PutCrLf() || "Продовжити реєстрацію картки?", "Увага!", MB_IconExclamation | MB_YesNo) = IDNO
							Return FALSE
					Return TRUE
			Function: OpenCard
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Boolean: bRet
					Number: iRet
				Actions
					If not check()
						Return FALSE
					If sInstantNls
						If SalMessageBox("Зареєструвати картку " || sCardName || " / " || sCardLcv || PutCrLf() ||
								   "на " || IifS(nCType=1, "фіз.особу", "юр.особу") || " " || sFio || " ?",
								   "Увага!", MB_IconQuestion | MB_YesNo) = IDNO
							Return FALSE
					Else
						If SalMessageBox("Відкрити картку " || sCardName || " / " || sCardLcv || PutCrLf() ||
								   "продукт " || sProductName || PutCrLf() ||
								   "для " || IifS(nCType=1, "фіз.особи", "юр.особи") || " " || sFio || " ?",
								   "Увага!", MB_IconQuestion | MB_YesNo) = IDNO
							Return FALSE
					Set bRet = TRUE
					Call SalWaitCursor(TRUE)
					If not SqlPLSQLCommand(hSql(), "bars_ow.open_card(nRnk, sInstantNls, sCardType, sCardBranch, sEmbFirstName,
							   sEmbLastName, sSecName, sWork, sOffice, dWDate, nSalaryProect, nTerm, sCardBranchIssue, STRING_Null, STRING_Null,
							   NUMBER_Null, nNd, iRet)")
						Call SqlRollbackEx(hSql(), "WAY4. Неуспешное заведение договора.")
						Set bRet = FALSE
					Else
						Call SqlCommitEx(hSql(), "WAY4. Зарегистрирован новый договор №" || Str(nNd))
						Call SalMessageBox("Зареєстровано нову угоду №" || Str(nNd), "Інформація", MB_IconAsterisk | MB_Ok)
						Set bParentRefresh = TRUE
					Call SalWaitCursor(FALSE)
					Return bRet
			Function: SetFocus
				Description:
				Returns
				Parameters
					Number: nTab
				Static Variables
				Local variables
				Actions
					Call picTabs.BringToTop(nTab, TRUE)
					Call SalSetFocus(picTabs.Items[nTab].m_hWndPage)
					Return TRUE
			Function: SetButton
				Description:
				Returns
					Boolean:
				Parameters
					! nPar: =0-после "Открыть", =1-после "Новая карточка", =2-после "Копировать карточку"
					Number: nPar
				Static Variables
				Local variables
				Actions
					Set bCardOpen = FALSE
					If nPar = 0
						Set bCardOpen = TRUE
						Call SalEnableWindow(pbNew)
						Call SalEnableWindow(pbShowAcc)
						Call SalEnableWindow(pbPrint)
						Call SalDisableWindow(pbOpen)
					Else
						Set nNd    = NUMBER_Null
						Set nCType = NUMBER_Null
						Set sEmbFirstName = STRING_Null
						Set sEmbLastName  = STRING_Null
						Set sSecName      = STRING_Null
						Set sWork   = STRING_Null
						Set sOffice = STRING_Null
						Set dWDate  = DATETIME_Null
						Call SalDisableWindow(pbNew)
						Call SalDisableWindow(pbShowAcc)
						Call SalDisableWindow(pbPrint)
						Call SalEnableWindow(pbOpen)
					Call SalSendMsg(picTabs.Items[0].m_hWndPage, SAM_DoInit, nPar, 0)
					Call SalSendMsg(picTabs.Items[1].m_hWndPage, SAM_DoInit, nPar, 0)
					Call SalSendMsg(picTabs.Items[2].m_hWndPage, SAM_DoInit, nPar, 0)
					Return TRUE
			Function: PrintDoc
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Number: nAcc
					String: sIdDoc
					String: sIdDocCred
					String: sTemplateId
					Long String: sDoc
					: cCnc
						Class: cABSConnect
					: cCnc2
						Class: cABSConnect
				Actions
					! Выбираем шаблоны по коду продукта
					If not SqlPrepareAndExecute(hSql(),
							"select id_doc, id_doc_cred into :sIdDoc, :sIdDocCred
							   from bpk_product
							  where id = :nProductId")
						Return FALSE
					If not SqlFetchNext(hSql(), nFetchRes)
						Return FALSE
					If sIdDoc or sIdDocCred
						! Acc
						If not SqlPrepareAndExecute(hSql(), "select acc_pk into :nAcc from bpk_acc where nd = :nNd")
							Return FALSE
						If not SqlFetchNext(hSql(), nFetchRes)
							Return FALSE
						!
						If not cdoc_SelectDocTemplate("DOC_SCHEME", "ID", "NAME",
								" ID in ('" || sIdDoc || "', '" || sIdDocCred || "') ", sTemplateId)
							Return FALSE
						If sTemplateId
							Call XConnectGetParams(cCnc)
							If cCnc.Connect() and cCnc2.Clone(cCnc, TRUE)
								Set sDoc = cdoc_CreateDocFromTemplate(cCnc.hSql(), cCnc2.hSql(), sTemplateId,  nAcc, 0)
								If sDoc
									Call cdoc_ShowDoc(sDoc, TRUE, FALSE)
								Call cCnc.Disconnect()
								Call cCnc2.Disconnect()
					Return TRUE
			Function: createTab
				Description:
				Returns
					Boolean:
				Parameters
					: CardTab
						Class: cCardTab
					Number: nTabNum
					String: sTabLabel
					String: sTabName
					String: sTabDlg
				Static Variables
				Local variables
				Actions
					Set CardTab.Label   = sTabLabel
					Set CardTab.Name    = sTabName
					Set CardTab.DlgName = sTabDlg
					Call picTabs.Insert(nTabNum, TRUE)
					Call picTabs.SetLabel(nTabNum, CardTab.Label, TRUE)
					Call picTabs.SetName(nTabNum, CardTab.Name)
					Call picTabs.AddPage(CardTab.Name, CardTab.DlgName, hWndNULL)
					Call picTabs.Enable(nTabNum, TRUE)
					Call picTabs.CreatePage(CardTab.Name)
					Return TRUE
			Function: ReReadTab
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
				Actions
					! Call Debug('nCType=>' || Str(nCType) || ' nCTypeOld=>' || Str(nCTypeOld))
					If nCTypeOld != NUMBER_Null and nCType != nCTypeOld
						Call SalSendMsg(picTabs.Items[1].m_hWndPage, SAM_DoInit, 1, 0)
						Call SalSendMsg(picTabs.Items[2].m_hWndPage, SAM_DoInit, 1, 0)
						Call SalSendMsg(picTabs.Items[2].m_hWndPage, SAM_User, 0, 0)
					Set nCTypeOld = nCType
					Return TRUE
		Window Parameters
			Window Handle: hWndParent
		Window Variables
			Boolean: bParentRefresh
			Boolean: fActivate
			Boolean: bCardOpen
			String: sOurBranch
			String: sBranch
			Number: nCType
			Number: nCTypeOld
			Number: nCount
			String: sTabName
			Number: nTabNum
			!
			Number: nNd
			Number: nRnk
			String: sFio
			String: sCardType
			String: sCardBranch
			String: sCardBranchIssue
			Number: nSalaryProect
			Number: nTerm
			String: sEmbFirstName
			String: sEmbLastName
			String: sSecName
			String: sWork
			String: sOffice
			Date/Time: dWDate
			!
			String: sProductName
			String: sCardName
			String: sCardLcv
			String: sInstantNls
			Number: nClientRnk	!Rnk из закладки "Клиент", нужно для закладки "Way4, чтоб перечитывать имена
			Number: nWay4Rnk	!Rnk из закладки "Way4"
			!
			: cTabCardClient
				Class: cCardTab
			: cTabCardCard
				Class: cCardTab
			: cTabCardWay4
				Class: cCardTab
		Message Actions
			On SAM_Create
				Call SalSetWindowText(hWndForm, AppVersion || "Way4. Нова угода")
				Call PrepareWindow(hWndForm)
				Set bParentRefresh = FALSE
				Set fActivate = FALSE
				Set bCardOpen = FALSE
				Set nCType    = NUMBER_Null
				Set nCTypeOld = NUMBER_Null
				!
				Set sOurBranch = GetValueStr("select substr(sys_context('bars_context','user_branch'), 1, 30) from dual")
				! Для ГРЦ sBranch = 0
				Set sBranch = IifS(sOurBranch='', '0', IifS(Len(sOurBranch)>=15,sOurBranch,''))
				!
				Call SalDisableWindow(pbNew)
				Call SalDisableWindow(pbShowAcc)
				Call SalDisableWindow(pbPrint)
			On SAM_CreateComplete
				Call SalWaitCursor(FALSE)
			On SAM_Destroy
				If bParentRefresh
					Call SalPostMsg(hWndParent, UM_Populate, 0, 0)
	Dialog Box: dlgCardClient
		Class:
		Property Template:
		Class DLL Name:
		Title:
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  8.9"
				Width Editable? Yes
				Height: 5.85"
				Height Editable? Yes
			Absolute Screen Location? Yes
			Font Name: Default
			Font Size: Default
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description:
		Tool Bar
			Display Settings
				Display Style? Default
				Location? Top
				Visible? Yes
				Size: Default
				Size Editable? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Contents
		Contents
			Group Box: Клієнт
				Resource Id: 57663
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    0.05"
					Width:  8.6"
					Width Editable? Yes
					Height: 5.4"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Picture: pbSearch
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   4.55"
					Top:    0.202"
					Width:  0.4"
					Width Editable? Yes
					Height: 0.3"
					Height Editable? Yes
				Visible? Yes
				Editable? No
				File Name: \BARS98\RESOURCE\BMP\SEARCH.BMP
				Storage: Internal
				Picture Transparent Color: Gray
				Fit: Scale
				Scaling
					Width:  100
					Height:  100
				Corners: Square
				Border Style: Raised-Shadow
				Border Thickness: 1
				Tile To Parent? No
				Border Color: Default
				Background Color: 3D Face Color
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Пошук клієнта')
					On SAM_Click
						! wParam=1, если ввели ОКПО, а клиентов с таким ОКПО несколько
						If FunNSIGetFiltered('customer', 'rnk', "customer.custtype in (2,3) and date_off is null" ||
								   IifS(wParam=1, " and okpo='" || dfOkpo || "'", "") || sCustTypeToSearch, sPK, sSem)
							Set dfRnk = Val(sPK)
							Call SearchCustomer(dfRnk, '')
			Picture: pbNew
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   5.0"
					Top:    0.202"
					Width:  0.4"
					Width Editable? Yes
					Height: 0.3"
					Height Editable? Yes
				Visible? Yes
				Editable? No
				File Name: \BARS98\RESOURCE\BMP\INSERT.BMP
				Storage: Internal
				Picture Transparent Color: Gray
				Fit: Scale
				Scaling
					Width:  100
					Height:  100
				Corners: Square
				Border Style: Raised-Shadow
				Border Thickness: 1
				Tile To Parent? No
				Border Color: Default
				Background Color: 3D Face Color
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Реєстрація нового клієнта')
					On SAM_Click
						Set hBtnCustType3 = VisMessageLoadButton('Фіз. особа', 3)
						Set hBtnCustType2 = VisMessageLoadButton('Юр. особа', 2)
						Set hBtnCancel    = VisMessageLoadButton('Відмінити', 0)
						Set hBtns[0] = hBtnCustType3
						Set hBtns[1] = hBtnCustType2
						Set hBtns[2] = hBtnCancel | MBF_DefButton
						Call VisMessageSetBkgdColor(COLOR_LightGray)
						Set nChoose = VisMessageBox('Виберіть тип клієнта', 'Запит', MBF_IconQuestion, hBtns, 3)
						If nChoose
							Set dfRnk  = NUMBER_Null
							Set dfOkpo = STRING_Null
							Call SetButton(FALSE)
							Call ClearField()
							If nChoose = 3
								Call EditCustPerson(0, ACCESS_FULL, hWndForm)
							If nChoose = 2
								Call EditCustCorps(0, ACCESS_FULL, hWndForm)
			Picture: pbClient
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   5.45"
					Top:    0.202"
					Width:  0.4"
					Width Editable? Yes
					Height: 0.3"
					Height Editable? Yes
				Visible? Yes
				Editable? No
				File Name: \BARS98\RESOURCE\BMP\CUSTPERS.BMP
				Storage: Internal
				Picture Transparent Color: Gray
				Fit: Scale
				Scaling
					Width:  100
					Height:  100
				Corners: Square
				Border Style: Raised-Shadow
				Border Thickness: 1
				Tile To Parent? No
				Border Color: Default
				Background Color: 3D Face Color
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Картка клієнта')
					On SAM_Click
						If dfRnk
							Select Case nCType
								Case 1
									Call EditCustPersonEx(dfRnk, ACCESS_FULL, hWndForm, 0, '', FALSE)
									Break
								Case 2
									Call EditCustCorpsEx(dfRnk, ACCESS_FULL, hWndForm, 0, '', FALSE)
									Break
								Default
									Break
			Picture: pbRefresh
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   5.9"
					Top:    0.202"
					Width:  0.4"
					Width Editable? Yes
					Height: 0.3"
					Height Editable? Yes
				Visible? Yes
				Editable? No
				File Name: \BARS98\RESOURCE\BMP\REFRESH.BMP
				Storage: Internal
				Picture Transparent Color: Gray
				Fit: Scale
				Scaling
					Width:  100
					Height:  100
				Corners: Square
				Border Style: Raised-Shadow
				Border Thickness: 1
				Tile To Parent? No
				Border Color: Default
				Background Color: 3D Face Color
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Перечитати дані клієнта')
					On SAM_Click
						If dfRnk
							Call SearchCustomer(dfRnk, '')
			Background Text: Реєстр. номер
				Resource Id: 57664
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    0.3"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfRnk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: Number
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    0.25"
						Width:  2.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_AnyEdit
						Set dfOkpo = ''
						Set dfFio  = ''
					On SAM_Validate
						If not SalIsNull(dfRnk)
							If not SearchCustomer(dfRnk, '')
								Set dfRnk  = NUMBER_Null
								Set dfOkpo = ''
								If SalMessageBox('Клієнта не знайдено! Вибрати з довідника?', 'Увага!', MB_IconExclamation | MB_YesNo) = IDYES
									Call SalSendMsg(pbSearch, SAM_Click, 0, 0)
						If dfRnk
							Call SetButton(TRUE)
						Else
							Call SetButton(FALSE)
							Call ClearField()
						Return VALIDATE_Ok
			Background Text: ЗКПО
				Resource Id: 57665
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    0.6"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfOkpo
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 14
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    0.55"
						Width:  2.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_AnyEdit
						Set dfRnk = NUMBER_Null
						Set dfFio = ''
					On SAM_Validate
						If not SalIsNull(dfOkpo)
							Call SqlPrepareAndExecute(hSql(), "select count(*) into :nCount from customer where okpo=:dfOkpo and " ||
									     "custtype in (2,3)" || sCustTypeToSearch)
							Call SqlFetchNext(hSql(), nFetchRes)
							If nCount = 0
								Set dfRnk  = NUMBER_Null
								Set dfOkpo = ''
								Set dfFio  = ''
								If SalMessageBox('Клієнта не знайдено! Вибрати з довідника?', 'Увага!', MB_IconExclamation | MB_YesNo) = IDYES
									Call SalSendMsg(pbSearch, SAM_Click, 0, 0)
							Else If nCount = 1
								Call SearchCustomer(NUMBER_Null, dfOkpo)
							Else
								If SalMessageBox("Знайдено декілька клієнтів з ЗКПО " || dfOkpo || "! Вибрати з довідника по ЗКПО?", "Увага!", MB_IconExclamation | MB_YesNo) = IDYES
									Call SalSendMsg(pbSearch, SAM_Click, 1, 0)
								Else
									Set dfRnk  = NUMBER_Null
									Set dfOkpo = ''
						If dfRnk
							Call SetButton(TRUE)
						Else
							Call SetButton(FALSE)
							Call ClearField()
						Return VALIDATE_Ok
			Background Text: ПІБ
				Resource Id: 57666
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    0.9"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfFio
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    0.85"
						Width:  6.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Data Field: dfLastName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 105
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    1.15"
						Width:  2.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Data Field: dfFirstName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 105
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   4.5"
						Top:    1.15"
						Width:  2.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Data Field: dfMiddleName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 105
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   6.5"
						Top:    1.15"
						Width:  2.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Тип клієнта
				Resource Id: 57667
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    1.5"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfCusttype
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    1.45"
						Width:  6.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			!
			Group Box: Адреса
				Resource Id: 57668
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    1.75"
					Width:  8.6"
					Width Editable? Yes
					Height: 3.7"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Background Text: Індекс
				Resource Id: 57669
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    2.0"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfIndex
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 20
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    1.95"
						Width:  2.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Область
				Resource Id: 57670
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    2.3"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfObl
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 30
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    2.25"
						Width:  6.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Район
				Resource Id: 57671
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    2.6"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfReg
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 30
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    2.55"
						Width:  6.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Місто
				Resource Id: 57672
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    2.9"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfCity
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 60
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    2.85"
						Width:  6.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Вулиця, дім, кв.
				Resource Id: 57673
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    3.2"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfStreet
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 100
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    3.15"
						Width:  6.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			!
			Group Box: Паспортні дані
				Resource Id: 57674
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    3.45"
					Width:  8.6"
					Width Editable? Yes
					Height: 2.0"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Background Text: Вид документу
				Resource Id: 57675
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    3.7"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfPassp
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    3.65"
						Width:  6.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Серія, номер
				Resource Id: 57676
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    4.0"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfSer
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 6
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    3.95"
						Width:  1.6"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Uppercase
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Data Field: dfNumDoc
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 15
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   4.15"
						Top:    3.95"
						Width:  4.35"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Коли, ким видано
				Resource Id: 57677
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    4.3"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfPdate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: Date/Time
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    4.25"
						Width:  1.6"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Center
					Format: Date
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: 99/99/9999
				Message Actions
			Data Field: dfOrgan
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   4.15"
						Top:    4.25"
						Width:  4.35"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Дата, місце народж.
				Resource Id: 57678
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    4.6"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfBday
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: Date/Time
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    4.55"
						Width:  1.6"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Center
					Format: Date
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: 99/99/9999
				Message Actions
			Data Field: dfBplace
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 70
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   4.15"
						Top:    4.55"
						Width:  4.35"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
		Functions
			Function: SearchCustomer
				Description:
				Returns
					Boolean:
				Parameters
					Number: nRnk
					String: sOkpo
				Static Variables
				Local variables
				Actions
					Set nCType = NUMBER_Null
					Set hWndParent.frmW4Card.nCType = nCType
					! Основные параметры кдиента
					! nCType = 1-ФО, 2-ЮО
					If not SqlPrepareAndExecute(hSql(),
							"select rnk, okpo, nmk,
							        substr(fio(nmkv,2),1,30), substr(fio(nmkv,1),1,30),
							        case
							          when (custtype=3 and nvl(trim(sed),'00')<>'91') then 1
							          else 2
							        end ctype,
							        case
							          when (custtype=3 and nvl(trim(sed),'00')<>'91') then 'Фізична особа'
							          when (custtype=3 and nvl(trim(sed),'00') ='91') then 'Фізична особа-підприємець'
							          else 'Юридична особа'
							        end custtype
							   into :dfRnk, :dfOkpo, :dfFio,
							        :sNmkVFirst, :sNmkVLast, :nCType, :dfCusttype
							   from customer
							  where " || IifS(nRnk!=NUMBER_Null,
							        "rnk  = :nRnk",
							        "okpo = :sOkpo") || "
							    and custtype in (2,3)" || sCustTypeToSearch)
						Return FALSE
					If not SqlFetchNext(hSql(), nFetchRes)
						Return FALSE
					! ФИО
					Call SqlPrepareAndExecute(hSql(),
							"select substr(min(decode(tag,'PC_MF', value, null)),1,20),
							        substr(min(decode(tag,'SN_FN', value, null)),1,105),
							        substr(min(decode(tag,'SN_LN', value, null)),1,105),
							        substr(min(decode(tag,'SN_MN', value, null)),1,105),
							        substr(min(decode(tag,'WORK ', value, null)),1,254)
							   into :sMName, :dfFirstName, :dfLastName, :dfMiddleName, :sWork
							   from customerw
							  where rnk = :dfRnk and tag in ('PC_MF', 'SN_FN', 'SN_LN', 'SN_MN', 'WORK ')")
					Call SqlFetchNext(hSql(), nFetchRes)
					! Адрес
					Call SqlPrepareAndExecute(hSql(),
							"select substr(min(decode(tag,'FGIDX', value, null)),1,20),
							        substr(min(decode(tag,'FGOBL', value, null)),1,30),
							        substr(min(decode(tag,'FGDST', value, null)),1,30),
							        substr(min(decode(tag,'FGTWN', value, null)),1,60),
							        substr(min(decode(tag,'FGADR', value, null)),1,100)
							   into :dfIndex, :dfObl, :dfReg, :dfCity, :dfStreet
							   from customerw
							  where rnk = :dfRnk and tag like 'FG%'")
					Call SqlFetchNext(hSql(), nFetchRes)
					! Паспортные данные
					Call SqlPrepareAndExecute(hSql(),
							"select d.name, p.ser, p.numdoc, p.pdate, p.organ, p.bday, p.bplace
							   into :dfPassp, :dfSer, :dfNumDoc, :dfPdate, :dfOrgan, :dfBday, :dfBplace
							   from person p, passp d
							  where p.rnk = :dfRnk and p.passp = d.passp")
					Call SqlFetchNext(hSql(), nFetchRes)
					!
					Set hWndParent.frmW4Card.nCType = nCType
					Set hWndParent.frmW4Card.sEmbFirstName = sNmkVFirst
					Set hWndParent.frmW4Card.sEmbLastName  = sNmkVLast
					Set hWndParent.frmW4Card.sSecName      = sMName
					Set hWndParent.frmW4Card.sWork         = sWork
					Set hWndParent.frmW4Card.nClientRnk = dfRnk
					Call hWndParent.frmW4Card.ReReadTab()
					!
					Call SalEnableWindow(pbClient)
					Call SalEnableWindow(pbRefresh)
					Return TRUE
			Function: SetButton
				Description:
				Returns
					Boolean:
				Parameters
					Boolean: bFlag
				Static Variables
				Local variables
				Actions
					If bFlag
						Call SalEnableWindow(pbClient)
						Call SalEnableWindow(pbRefresh)
					Else
						Call SalDisableWindow(pbClient)
						Call SalDisableWindow(pbRefresh)
					Return TRUE
			Function: ClearField
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
				Actions
					Set nCType = NUMBER_Null
					Set sNmkVFirst = STRING_Null
					Set sNmkVLast  = STRING_Null
					Set sMName     = STRING_Null
					Set sWork      = STRING_Null
					Set hWndParent.frmW4Card.nRnk = dfRnk
					Set hWndParent.frmW4Card.nCType = nCType
					Set hWndParent.frmW4Card.sEmbFirstName = sNmkVFirst
					Set hWndParent.frmW4Card.sEmbLastName  = sNmkVLast
					Set hWndParent.frmW4Card.sSecName      = sMName
					Set hWndParent.frmW4Card.sWork         = sWork
					Set dfFio = STRING_Null
					Set dfLastName   = STRING_Null
					Set dfFirstName  = STRING_Null
					Set dfMiddleName = STRING_Null
					Set dfCusttype = STRING_Null
					Set dfIndex  = STRING_Null
					Set dfObl    = STRING_Null
					Set dfReg    = STRING_Null
					Set dfCity   = STRING_Null
					Set dfStreet = STRING_Null
					Set dfPassp  = STRING_Null
					Set dfSer    = STRING_Null
					Set dfNumDoc = STRING_Null
					Set dfOrgan  = STRING_Null
					Set dfPdate  = DATETIME_Null
					Set dfBday   = DATETIME_Null
					Set dfBplace = STRING_Null
					Return TRUE
		Window Parameters
		Window Variables
			String: strPassPar
			String: InParam[4]
			Window Handle: hWndParent
			!
			String: sPK
			String: sSem
			Number: hBtns[*]
			Number: hBtnCustType3
			Number: hBtnCustType2
			Number: hBtnCancel
			Number: nChoose
			Number: nCount
			Number: nCType
			String: sMName
			String: sWork
			!
			String: sNmkVFirst
			String: sNmkVLast
			!
			String: sCustTypeToSearch
		Message Actions
			On PAGEM_Initialize
				! Инициализация
				Set strPassPar = SalNumberToHString(lParam)
				If SalStrTokenize(strPassPar, '', ';', InParam) < 2
					Return FALSE
				Set hWndParent = SalNumberToWindowHandle(SalStrToNumber(InParam[1]))
				!
				Set nCType = NUMBER_Null
				Set sCustTypeToSearch = STRING_Null
				!
				Call SalDisableWindow(pbClient)
				Call SalDisableWindow(pbRefresh)
			On UM_Populate
				Call SearchCustomer(dfRnk, '')
			On SAM_User
				If wParam = 0
					Call SalSetFocus(dfOkpo)
				! проверка перед сохранением
				Else If wParam = 10
					If SalIsNull(dfRnk)
						Call SalMessageBox("Не вказано клієнта!", "Увага!", MB_IconExclamation | MB_Ok)
						Call SalSetFocus(dfRnk)
						Return FALSE
					Set hWndParent.frmW4Card.nRnk = dfRnk
					Set hWndParent.frmW4Card.sFio = dfFio
					Return TRUE
			On SAM_DoInit
				! 0 - закрыть поля (после "Открыть карточку")
				! 1 - очистить и открыть поля (после "Новая")
				! 2 - очистить и открыть поля (после "Копировать")
				Set sCustTypeToSearch = STRING_Null
				If wParam = 0
					Call SalDisableWindow(dfRnk)
					Call SalDisableWindow(dfOkpo)
					Call SalDisableWindow(pbSearch)
					Call SalDisableWindow(pbNew)
					Call SalDisableWindow(pbClient)
					Call SalDisableWindow(pbRefresh)
				Else
					Call SalEnableWindow(dfRnk)
					Call SalEnableWindow(dfOkpo)
					Call SalEnableWindow(pbSearch)
					Call SalEnableWindow(pbNew)
					Set dfRnk  = NUMBER_Null
					Set dfOkpo = STRING_Null
					! If wParam = 2
						                                                                                                                                                    Set sCustTypeToSearch = IifS(nCType=1,
								    " and customer.custtype = 3 ", IifS(nCType=2,
								    " and (customer.custtype = 2 or customer.custtype = 3 and nvl(customer.sed,'00')='91') ", ""))
					Call ClearField()
	Dialog Box: dlgCardCard
		Class:
		Property Template:
		Class DLL Name:
		Title:
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  8.9"
				Width Editable? Yes
				Height: 5.85"
				Height Editable? Yes
			Absolute Screen Location? Yes
			Font Name: Default
			Font Size: Default
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description:
		Tool Bar
			Display Settings
				Display Style? Default
				Location? Top
				Visible? Yes
				Size: Default
				Size Editable? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Contents
		Contents
			Group Box: Картка
				Resource Id: 57679
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    0.05"
					Width:  8.6"
					Width Editable? Yes
					Height: 5.4"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Background Text: Група продуктів
				Resource Id: 57680
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    0.3"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Combo Box: cmbProductGroup
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_StrId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   2.5"
					Top:    0.25"
					Width:  5.45"
					Width Editable? Class Default
					Height: 3.357"
					Height Editable? Class Default
				Visible? Class Default
				Editable? Class Default
				String Type: Class Default
				Maximum Data Length: Class Default
				Sorted? Class Default
				Always Show List? Class Default
				Vertical Scroll? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Input Mask: Class Default
				List Initialization
				Message Actions
					On SAM_DoInit
						If cmbProductGroup.Init(hWndItem)
							Call cmbProductGroup.Populate(hSql(), "code", "name", "v_w4_productgrp_clienttype",
									"where client_type=" || Str(hWndParent.frmW4Card.nCType) ||
									" order by name")
					On SAM_Click
						Call SalSendClassMessage(SAM_Click, 0, 0)
						Set sProductGrp = cmbProductGroup.strCurrentId
						Call ClearField(1)
			!
			Background Text: З/П проект
				Resource Id: 57694
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    0.6"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfSalaryProectCode
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 10
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    1.75"
						Width:  1.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? No
					Border? Yes
					Justify: Center
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Data Field: dfSalaryProectName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    0.55"
						Width:  5.45"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Picture: pbSalaryProect
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   8.0"
					Top:    0.5"
					Width:  0.4"
					Width Editable? Yes
					Height: 0.3"
					Height Editable? Yes
				Visible? Yes
				Editable? No
				File Name: \BARS98\RESOURCE\BMP\FILTER.BMP
				Storage: Internal
				Picture Transparent Color: Gray
				Fit: Scale
				Scaling
					Width:  100
					Height:  100
				Corners: Square
				Border Style: Raised-Shadow
				Border Thickness: 1
				Tile To Parent? No
				Border Color: Default
				Background Color: 3D Face Color
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Зарплатний проект')
					On SAM_Click
						If FunNSIGetFiltered("bpk_proect", "name", sProectFilter, sPK, sSem)
							Set dfSalaryProectCode = Val(sPK)
							Set dfSalaryProectName = sSem
							Set hWndParent.frmW4Card.sWork = dfSalaryProectName
							Call ClearField(4)
			!
			Background Text: Продукт
				Resource Id: 57683
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    0.9"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Combo Box: cmbProduct
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_StrId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   2.5"
					Top:    0.85"
					Width:  5.45"
					Width Editable? Class Default
					Height: 3.357"
					Height Editable? Class Default
				Visible? Class Default
				Editable? Class Default
				String Type: Class Default
				Maximum Data Length: Class Default
				Sorted? Class Default
				Always Show List? Class Default
				Vertical Scroll? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Input Mask: Class Default
				List Initialization
				Message Actions
					On SAM_DoInit
						If cmbProduct.Init(hWndItem)
							Call cmbProduct.Populate(hSql(), "code", "name", "v_w4_product_clienttype",
									"where grp_code = '" || sProductGrp || "' and client_type=" || Str(hWndParent.frmW4Card.nCType) ||
									" order by name")
							! Call cmbProductGroup.SetSelectById(sAccType)
							! Call SalSendMsg(cmbProduct, SAM_Click, 0, 0)
					On SAM_Click
						Call SalSendClassMessage(SAM_Click, 0, 0)
						Set sProductId = cmbProduct.strCurrentId
						Call ClearField(2)
			!
			Background Text: Тип картки
				Resource Id: 57692
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    1.2"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Combo Box: cmbCardType
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_StrId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   2.5"
					Top:    1.15"
					Width:  5.45"
					Width Editable? Class Default
					Height: 3.357"
					Height Editable? Class Default
				Visible? Class Default
				Editable? Class Default
				String Type: Class Default
				Maximum Data Length: Class Default
				Sorted? Class Default
				Always Show List? Class Default
				Vertical Scroll? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Input Mask: Class Default
				List Initialization
				Message Actions
					On SAM_DoInit
						If cmbCardType.Init(hWndItem)
							If sProductGrp = 'SALARY'
								Call cmbCardType.Populate(hSql(), "code", "sub_name", "v_w4_card",
										"where code in (select card_code from bpk_proect_card where okpo = '" || sSalaryProectOkpo || "' and to_char(okpo_n) = nvl('" || Str(nSalaryProectOkpon) || "','0')) order by code")
							Else
								Call cmbCardType.Populate(hSql(), "code", "sub_name", "v_w4_card", "where product_code='" || sProductId || "' order by code")
					On SAM_Click
						Call SalSendClassMessage(SAM_Click, 0, 0)
						Set sCardType = cmbCardType.strCurrentId
						Call SqlPrepareAndExecute(hSql(), "select sub_code into :sSubCode from w4_card where code = :sCardType")
						Call SqlFetchNext(hSql(), nFetchRes)
						Call ClearField(3)
			!
			Check Box: cbInstant
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Видати миттєву картку
				Window Location and Size
					Left:   2.5"
					Top:    1.45"
					Width:  5.45"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
				Message Actions
					On SAM_Click
						If cbInstant
							Call SalEnableWindow(dfNls)
						Else
							Set dfNls = STRING_Null
							Call SalDisableWindow(dfNls)
			Background Text: Рахунок
				Resource Id: 51764
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    1.8"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfNls
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 14
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    1.75"
						Width:  5.45"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_Validate
						If not SalIsNull(dfNls)
							If not CheckInstantNls(dfNls)
								Return VALIDATE_Cancel
						Return VALIDATE_Ok
			!
			Background Text: Валюта
				Resource Id: 57681
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    2.85"
					Width:  4.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfCurrencyName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   4.5"
						Top:    2.8"
						Width:  3.45"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			!
			Background Text: Балансовий рахунок
				Resource Id: 57695
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    2.55"
					Width:  4.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfNbs
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   4.5"
						Top:    2.5"
						Width:  0.95"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Center
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: ОБ22
				Resource Id: 57684
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   5.8"
					Top:    2.55"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfOb22
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 2
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   6.95"
						Top:    2.5"
						Width:  1.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Center
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			!
			Background Text: Схема рахунків
				Resource Id: 57685
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    3.15"
					Width:  4.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfScheme
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   4.5"
						Top:    3.1"
						Width:  3.45"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			!
			! Background Text: Річна плата за обслуговування (грн.)
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    2.85"
					Width:  4.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
.end
			! Data Field: dfTarif
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   4.5"
						Top:    2.8"
						Width:  3.45"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
.end
				                                                                                                                              Message Actions
			Background Text: Кількість місяців дії картки
				Resource Id: 39440
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    2.25"
					Width:  4.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfTerm
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: Number
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   4.5"
						Top:    2.2"
						Width:  1.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Center
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Відсоток на залишок по рахунку
				Resource Id: 57689
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    3.6"
					Width:  4.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfAccRate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   4.5"
						Top:    3.55"
						Width:  3.45"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Відсоток на "Мобільні заощадження"
				Resource Id: 57697
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    3.9"
					Width:  4.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfMobiRate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   4.5"
						Top:    3.85"
						Width:  3.45"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Відсоток за кредитом
				Resource Id: 57687
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    4.2"
					Width:  4.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfCredRate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   4.5"
						Top:    4.15"
						Width:  3.45"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Відсоток на недозволений овердрафт
				Resource Id: 57688
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    4.5"
					Width:  4.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfOvrRate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   4.5"
						Top:    4.45"
						Width:  3.45"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Відсоток за невикористаний ліміт
				Resource Id: 59421
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    4.8"
					Width:  4.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfNotUsedLimitRate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   4.5"
						Top:    4.75"
						Width:  3.45"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Відсоток за корист. кред. у Грейс-період
				Resource Id: 59422
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    5.1"
					Width:  4.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfGraceRate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   4.5"
						Top:    5.05"
						Width:  3.45"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			!
			Line
				Resource Id: 57698
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Coordinates
					Begin X:  0.1"
					Begin Y:  2.1"
					End X:  8.7"
					End Y:  2.1"
				Visible? Yes
				Line Style: Etched
				Line Thickness: 1
				Line Color: Default
			Line
				Resource Id: 2316
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Coordinates
					Begin X:  0.1"
					Begin Y:  3.45"
					End X:  8.7"
					End Y:  3.45"
				Visible? Yes
				Line Style: Etched
				Line Thickness: 1
				Line Color: Default
		Functions
			Function: ClearField
				Description:
				Returns
					Boolean:
				Parameters
					Number: nPar
				Static Variables
				Local variables
				Actions
					! Set nKv = NUMBER_Null
					! 0 - чистим все
					If nPar = 0
						Set dfCurrencyName = STRING_Null
						Set nMmMax     = NUMBER_Null
						Set dfTerm     = NUMBER_Null
						Set dfNbs      = STRING_Null
						Set dfOb22     = STRING_Null
						Set dfScheme   = STRING_Null
						Set dfAccRate  = NUMBER_Null
						Set dfMobiRate = NUMBER_Null
						Set dfCredRate = NUMBER_Null
						Set dfOvrRate  = NUMBER_Null
						Set dfNotUsedLimitRate = NUMBER_Null
						Set dfGraceRate = NUMBER_Null
						!
						Set sProductGrp = STRING_Null
						Call SalDisableWindow(cmbProductGroup)
						Call SalListSetSelect(cmbProductGroup, -1)
						Set dfSalaryProectCode = NUMBER_Null
						Set dfSalaryProectName = STRING_Null
						Set hWndParent.frmW4Card.sWork = STRING_Null
						Set sSalaryProectOkpo  = STRING_Null
						Set nSalaryProectOkpon = NUMBER_Null
						Call SalDisableWindow(pbSalaryProect)
						Set sProductId = STRING_Null
						Call SalDisableWindow(cmbProduct)
						Call SalListSetSelect(cmbProduct, -1)
						Set sCardType = STRING_Null
						Call SalDisableWindow(cmbCardType)
						Call SalListSetSelect(cmbCardType, -1)
						Set cbInstant = FALSE
						Call SalEnableWindow(cbInstant)
						Set dfNls = STRING_Null
						Call SalDisableWindow(dfNls)
						Call SalEnableWindow(dfTerm)
						!
						If hWndParent.frmW4Card.nCType
							Call SalEnableWindow(cmbProductGroup)
							Call SalSendMsg(cmbProductGroup, SAM_DoInit, 0, 0)
					! 1 - выбрали группу продуктов
					If nPar = 1
						! схема счетов
						Call SqlPrepareAndExecute(hSql(),
								"select s.name into :dfScheme
								   from w4_product_groups g, bpk_scheme s
								  where g.scheme_id = s.id
								    and g.code = :sProductGrp")
						Call SqlFetchNext(hSql(), nFetchRes)
						If sProductGrp = 'SALARY'
							Set sProectFilter = "product_code is not null and nvl(used_w4,0)=1"
							Call SalEnableWindow(pbSalaryProect)
							Call SalDisableWindow(cmbProduct)
						Else
							Set sProectFilter = STRING_Null
							Call SalDisableWindow(pbSalaryProect)
							Call SalEnableWindow(cmbProduct)
						Set dfSalaryProectCode = NUMBER_Null
						Set dfSalaryProectName = STRING_Null
						Set hWndParent.frmW4Card.sWork = STRING_Null
						!
						Set cbInstant = FALSE
						Set dfNls = STRING_Null
						Call SalDisableWindow(dfNls)
						!
						Set dfCurrencyName = STRING_Null
						Set dfNbs      = STRING_Null
						Set dfOb22     = STRING_Null
						Set dfAccRate  = NUMBER_Null
						Set dfMobiRate = NUMBER_Null
						Set dfCredRate = NUMBER_Null
						Set dfOvrRate  = NUMBER_Null
						Set dfNotUsedLimitRate = NUMBER_Null
						Set dfGraceRate = NUMBER_Null
						!
						Set sProductId = STRING_Null
						Call SalListSetSelect(cmbProduct, -1)
						Set sCardType = STRING_Null
						Call SalDisableWindow(cmbCardType)
						Call SalListSetSelect(cmbCardType, -1)
						Call SalSendMsg(cmbProduct, SAM_DoInit, 0, 0)
					! 4 - выбрали З/П проект
					If nPar = 4
						Call SqlPrepareAndExecute(hSql(),
								"select b.okpo, b.okpo_n, p.code, t.lcv, t.name, p.nbs, p.ob22,
								        c.percent_osn, c.percent_mob, c.percent_cred, c.percent_over,
								        c.percent_notusedlimit, c.percent_grace, c.mm_max
								   into :sSalaryProectOkpo, :nSalaryProectOkpon, :sProductId, :sLcv, :dfCurrencyName, :dfNbs, :dfOb22,
								        :dfAccRate, :dfMobiRate, :dfCredRate, :dfOvrRate,
								        :dfNotUsedLimitRate, :dfGraceRate, :nMmMax
								   from w4_product p, tabval t, cm_product c, bpk_proect b
								  where p.kv = t.kv
								    and p.code = c.product_code(+)
								    and p.code = b.product_code
								    and b.id = :dfSalaryProectCode")
						Call SqlFetchNext(hSql(), nFetchRes)
						Call cmbProduct.SetSelectById(sProductId)
						Set sCardType = STRING_Null
						Call SalEnableWindow(cmbCardType)
						Call SalListSetSelect(cmbCardType, -1)
						Call SalSendMsg(cmbCardType, SAM_DoInit, 0, 0)
					! 2 - выбрали продукт
					If nPar = 2
						Call SqlPrepareAndExecute(hSql(),
								"select t.kv, t.lcv, t.name, p.nbs, p.ob22,
								        c.percent_osn, c.percent_mob, c.percent_cred, c.percent_over,
								        c.percent_notusedlimit, c.percent_grace, c.mm_max
								   into :nKv, :sLcv, :dfCurrencyName, :dfNbs, :dfOb22,
								        :dfAccRate, :dfMobiRate, :dfCredRate, :dfOvrRate,
								        :dfNotUsedLimitRate, :dfGraceRate, :nMmMax
								   from w4_product p, tabval t, cm_product c
								  where p.kv = t.kv
								    and p.code = c.product_code(+)
								    and p.code = :sProductId")
						Call SqlFetchNext(hSql(), nFetchRes)
						Set sCardType = STRING_Null
						Call SalEnableWindow(cmbCardType)
						Call SalListSetSelect(cmbCardType, -1)
						Call SalSendMsg(cmbCardType, SAM_DoInit, 0, 0)
					! 3 - выбрали карточку
					! If nPar = 3
					If nMmMax != NUMBER_Null
						Set dfTerm = nMmMax
					Return TRUE
			Function: CheckInstantNls
				Description:
				Returns
					Boolean:
				Parameters
					String: sNls
				Static Variables
				Local variables
					String: sInstantSubCode
				Actions
					Call SqlPrepareAndExecute(hSql(),
							"select sub_code into :sInstantSubCode
							   from v_w4_acc_instant
							  where nls = :sNls and kv = :nKv")
					If not SqlFetchNext(hSql(), nFetchRes)
						Call SalMessageBox("Рахунок не знайдено!", "Увага!", MB_IconExclamation | MB_Ok)
						Return FALSE
					! MGold_500  like  MGold%
					If sSubCode != '' and Subs(sSubCode,1,Len(sInstantSubCode)) != sInstantSubCode
						Call SalMessageBox("Рахунок не відповідає вибраному типу картки!", "Увага!", MB_IconExclamation | MB_Ok)
						Return FALSE
					Return TRUE
		Window Parameters
		Window Variables
			String: strPassPar
			String: InParam[4]
			Window Handle: hWndParent
			!
			String: sProductGrp
			String: sProductId
			String: sCardType
			String: sSubCode
			Number: nKv
			String: sLcv
			Number: nMmMax
			! Number: nCountProect
			String: sSalaryProectOkpo
			Number: nSalaryProectOkpon
			String: sProectFilter
			!
			String: sPK
			String: sSem
		Message Actions
			On PAGEM_Initialize
				! Инициализация
				Set strPassPar = SalNumberToHString(lParam)
				If SalStrTokenize(strPassPar, '', ';', InParam) < 2
					Return FALSE
				Set hWndParent = SalNumberToWindowHandle(SalStrToNumber(InParam[1]))
				!
				Call ClearField(0)
				!
				! Set hWndParent.frmW4Card.hWndTabCard = hWndForm
			On SAM_DoInit
				! 0 - закрыть поля (после "Открыть карточку")
				! 1 - очистить и открыть поля (после "Новая")
				! 2 - клиент выбран, карточка не открыта [открыть поля (после "Копировать")]
				If wParam = 0
					Call SalDisableWindow(cmbProductGroup)
					Call SalDisableWindow(cmbProduct)
					Call SalDisableWindow(cmbCardType)
					Call SalDisableWindow(pbSalaryProect)
					Call SalDisableWindow(cbInstant)
					Call SalDisableWindow(dfNls)
					Call SalDisableWindow(dfTerm)
				Else
					If wParam = 1
						Call ClearField(0)
					Else If wParam = 2
						Call SalEnableWindow(cmbProductGroup)
						If sProductGrp = ''
							Call SalSendMsg(cmbProductGroup, SAM_DoInit, 0, 0)
						If sProductId != ''
							Call SalEnableWindow(cmbProduct)
						If sCardType  != ''
							Call SalEnableWindow(cmbCardType)
						Call SalEnableWindow(cbInstant)
						If not cbInstant
							Set dfNls = STRING_Null
							Call SalDisableWindow(dfNls)
						Call SalEnableWindow(dfTerm)
			On SAM_User
				! проверка перед сохранением
				If wParam = 10
					If sCardType = ''
						Call SalMessageBox("Не вибрано картку!", "Увага!", MB_IconExclamation | MB_Ok)
						Call SalSetFocus(cmbCardType)
						Return FALSE
					If cbInstant and SalIsNull(dfNls)
						Call SalMessageBox("Не вказано рахунок Instant!", "Увага!", MB_IconExclamation | MB_Ok)
						Call SalSetFocus(dfNls)
						Return FALSE
					Set hWndParent.frmW4Card.sProductName  = cmbProduct
					Set hWndParent.frmW4Card.sCardType     = sCardType
					Set hWndParent.frmW4Card.sCardName     = cmbCardType
					Set hWndParent.frmW4Card.sCardLcv      = sLcv
					Set hWndParent.frmW4Card.sInstantNls   = dfNls
					Set hWndParent.frmW4Card.nSalaryProect = dfSalaryProectCode
					Set hWndParent.frmW4Card.nTerm         = dfTerm
					Return TRUE
	Dialog Box: dlgCardWay4
		Class:
		Property Template:
		Class DLL Name:
		Title:
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  8.9"
				Width Editable? Yes
				Height: 5.85"
				Height Editable? Yes
			Absolute Screen Location? Yes
			Font Name: Default
			Font Size: Default
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description:
		Tool Bar
			Display Settings
				Display Style? Default
				Location? Top
				Visible? Yes
				Size: Default
				Size Editable? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Contents
		Contents
			Group Box: Way4
				Resource Id: 57699
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    0.05"
					Width:  8.6"
					Width Editable? Yes
					Height: 5.4"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Background Text: Ім'я на картці
				Resource Id: 57700
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    0.3"
					Width:  3.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: bgFName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cLabelControl
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Default
						Top:    Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfEmbFirstName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 24
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   3.3"
						Top:    0.25"
						Width:  5.2"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Прізвище на картці
				Resource Id: 6241
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    0.6"
					Width:  3.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: bgLName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cLabelControl
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Default
						Top:    Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfEmbLastName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 24
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   3.3"
						Top:    0.55"
						Width:  5.2"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Таємне слово
				Resource Id: 57701
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    0.9"
					Width:  3.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfSecName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 20
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   3.3"
						Top:    0.85"
						Width:  5.2"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Group Box: Місце роботи
				Resource Id: 57702
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    1.15"
					Width:  8.6"
					Width Editable? Yes
					Height: 4.3"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Background Text: Місце роботи
				Resource Id: 57703
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    1.4"
					Width:  3.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: bgWork
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cLabelControl
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Default
						Top:    Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfWork
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 254
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   3.3"
						Top:    1.35"
						Width:  5.2"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Посада
				Resource Id: 57704
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    1.7"
					Width:  3.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: bgOffice
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cLabelControl
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Default
						Top:    Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfOffice
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 32
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   3.3"
						Top:    1.65"
						Width:  5.2"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Дата прийняття на роботу
				Resource Id: 57705
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    2.0"
					Width:  3.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: bgWDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cLabelControl
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Default
						Top:    Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfWDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 11
					Data Type: Date/Time
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   3.3"
						Top:    1.95"
						Width:  5.2"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Date
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Group Box: Відділення
				Resource Id: 52653
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    3.1"
					Width:  8.6"
					Width Editable? Yes
					Height: 2.35"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfBranch
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   0.2"
						Top:    3.3"
						Width:  3.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
				! Message Actions
					        On SAM_Validate
						        If SalIsNull(dfFCode)
							        Set dfFName   = STRING_Null
							        Set dfFCity   = STRING_Null
							        Set dfFStreet = STRING_Null
						        Else
							        If not GetFilial(dfFCode)
								        If SalMessageBox("Невірний код філії!" || PutCrLf() || "Вибрати з довідника?", "Увага", MB_IconExclamation | MB_YesNo) = IDNO
									        Set dfFCode = ''
									        Return VALIDATE_Cancel
								        Call SalSendMsg(pbFiliales, SAM_Click, 0, 0)
						        Return VALIDATE_Ok
			Data Field: dfBranchName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   3.3"
						Top:    3.3"
						Width:  4.7"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
				! Message Actions
			Picture: pbBranch
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   8.1"
					Top:    3.25"
					Width:  0.4"
					Width Editable? Yes
					Height: 0.3"
					Height Editable? Yes
				Visible? Yes
				Editable? No
				File Name: \BARS98\RESOURCE\BMP\FILTER.BMP
				Storage: Internal
				Picture Transparent Color: Gray
				Fit: Scale
				Scaling
					Width:  100
					Height:  100
				Corners: Square
				Border Style: Raised-Shadow
				Border Thickness: 1
				Tile To Parent? No
				Border Color: Default
				Background Color: 3D Face Color
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Вибрати віддділення')
					On SAM_Click
						If FunNSIGetFiltered("our_branch", "name", "length(branch)>=15", sPK, sSem)
							Set dfBranch = sPK
							Set dfBranchName = sSem
							If dfBranchIssue = ''
								Set dfBranchIssue = dfBranch
								Set dfBranchIssueName = dfBranchName
			Group Box: Адреса доставки карти
				Resource Id: 4265
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    3.8"
					Width:  8.6"
					Width Editable? Yes
					Height: 1.65"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfBranchIssue
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   0.2"
						Top:    4.0"
						Width:  3.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
				! Message Actions
					        On SAM_Validate
						        If SalIsNull(dfFCode)
							        Set dfFName   = STRING_Null
							        Set dfFCity   = STRING_Null
							        Set dfFStreet = STRING_Null
						        Else
							        If not GetFilial(dfFCode)
								        If SalMessageBox("Невірний код філії!" || PutCrLf() || "Вибрати з довідника?", "Увага", MB_IconExclamation | MB_YesNo) = IDNO
									        Set dfFCode = ''
									        Return VALIDATE_Cancel
								        Call SalSendMsg(pbFiliales, SAM_Click, 0, 0)
						        Return VALIDATE_Ok
			Data Field: dfBranchIssueName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   3.3"
						Top:    4.0"
						Width:  4.7"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
				! Message Actions
			Picture: pbBranchIssue
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   8.1"
					Top:    3.95"
					Width:  0.4"
					Width Editable? Yes
					Height: 0.3"
					Height Editable? Yes
				Visible? Yes
				Editable? No
				File Name: \BARS98\RESOURCE\BMP\FILTER.BMP
				Storage: Internal
				Picture Transparent Color: Gray
				Fit: Scale
				Scaling
					Width:  100
					Height:  100
				Corners: Square
				Border Style: Raised-Shadow
				Border Thickness: 1
				Tile To Parent? No
				Border Color: Default
				Background Color: 3D Face Color
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Вибрати віддділення')
					On SAM_Click
						If FunNSIGetFiltered("v_branch_obu", "name", "", sPK, sSem)
							Set dfBranchIssue = sPK
							Set dfBranchIssueName = sSem
		Functions
			Function: GetBranch
				Description:
				Returns
					Boolean:
				Parameters
					String: sBranch
				Static Variables
				Local variables
				Actions
					If SqlPrepareAndExecute(hSql(),
							"select branch, name
							   into :dfBranch, :dfBranchName
							   from our_branch
							  where branch = :sBranch")
						Call SqlFetchNext(hSql(), nFetchRes)
					Return TRUE
			Function: ClearField
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
				Actions
					Set dfEmbFirstName  = STRING_Null
					Set dfEmbLastName = STRING_Null
					Set dfSecName = STRING_Null
					Set dfWork   = STRING_Null
					Set dfOffice = STRING_Null
					Set dfWDate  = DATETIME_Null
					! Set dfWCntry  = STRING_Null
					! Set dfWPcode  = STRING_Null
					! Set dfWCity   = STRING_Null
					! Set dfWStreet = STRING_Null
					! Set dfFCode   = STRING_Null
					! Set dfFName   = STRING_Null
					! Set dfFCity   = STRING_Null
					! Set dfFStreet = STRING_Null
					Return TRUE
		Window Parameters
		Window Variables
			String: strPassPar
			String: InParam[4]
			Window Handle: hWndParent
			!
			String: sPK
			String: sSem
		Message Actions
			On PAGEM_Initialize
				! Инициализация
				Set strPassPar = SalNumberToHString(lParam)
				If SalStrTokenize(strPassPar, '', ';', InParam) < 2
					Return FALSE
				Set hWndParent = SalNumberToWindowHandle(SalStrToNumber(InParam[1]))
				!
				Call GetBranch(hWndParent.frmW4Card.sBranch)
			On SAM_DoInit
				! 0 - закрыть поля (после "Открыть карточку")
				! 1 - очистить и открыть поля (после "Новая")
				! 2 - открыть поля (после "Копировать")
				If wParam = 0
					Call SalDisableWindow(dfEmbFirstName)
					Call SalDisableWindow(dfEmbLastName)
					Call SalDisableWindow(dfSecName)
					Call SalDisableWindow(dfWork)
					Call SalDisableWindow(dfOffice)
					Call SalDisableWindow(dfWDate)
					Call SalDisableWindow(pbBranch)
					Call SalDisableWindow(pbBranchIssue)
				Else
					Call SalEnableWindow(dfEmbFirstName)
					Call SalEnableWindow(dfEmbLastName)
					Call SalEnableWindow(dfSecName)
					Call SalEnableWindow(dfWork)
					Call SalEnableWindow(dfOffice)
					Call SalEnableWindow(dfWDate)
					Call SalEnableWindow(pbBranch)
					Call SalEnableWindow(pbBranchIssue)
					If wParam = 1
						Call ClearField()
					! Call SalEnableWindow(dfWPhone)
					! Call SalEnableWindow(dfWCntry)
					! Call SalEnableWindow(dfWPcode)
					! Call SalEnableWindow(dfWCity)
					! Call SalEnableWindow(dfWStreet)
					! Call SalEnableWindow(dfFCode)
					! Call SalEnableWindow(pbFiliales)
					! If wParam = 1
						                                                                                                                                      Call ClearField()
					! Else
						                                                                                                                                      Set dfEmbFirstName = STRING_Null
						                                                                                                                                      Set dfEmbLastName = STRING_Null
						                                                                                                                                      Set dfSecName = STRING_Null
				!
				If hWndParent.frmW4Card.nCType = 1
					Call SalSetWindowLabelText(bgFName, "Ім'я на картці")
					Call SalSetWindowLabelText(bgLName, "Прізвище на картці")
					Call SalShowWindowAndLabel(bgWork)
					Call SalShowWindowAndLabel(bgOffice)
					Call SalShowWindowAndLabel(bgWDate)
					Call SalShowWindow(dfWork)
					Call SalShowWindow(dfOffice)
					Call SalShowWindow(dfWDate)
				Else If hWndParent.frmW4Card.nCType = 2
					! Call SalDisableWindow(dfFirstName)
					! Call SalDisableWindow(dfLastName)
					! Call SalDisableWindow(dfMiddleName)
					! Set dfFirstName  = ''
					! Set dfLastName   = ''
					! Set dfMiddleName = ''
					Call SalSetWindowLabelText(bgFName, 'Назва компанії на картці')
					Call SalSetWindowLabelText(bgLName, "Прізвище контактної особи")
					Call SalHideWindowAndLabel(bgWork)
					Call SalHideWindowAndLabel(bgOffice)
					Call SalHideWindowAndLabel(bgWDate)
					Call SalHideWindow(dfWork)
					Call SalHideWindow(dfOffice)
					Call SalHideWindow(dfWDate)
				Else
					Call SalHideWindowAndLabel(bgWork)
					Call SalHideWindowAndLabel(bgOffice)
					Call SalHideWindowAndLabel(bgWDate)
					Call SalHideWindow(dfWork)
					Call SalHideWindow(dfOffice)
					Call SalHideWindow(dfWDate)
			On SAM_User
				If wParam = 0
					! если сменился клиент, нужно перечитать имена
					If hWndParent.frmW4Card.nClientRnk != hWndParent.frmW4Card.nWay4Rnk
						If hWndParent.frmW4Card.nCType = 1
							Set dfEmbFirstName = hWndParent.frmW4Card.sEmbFirstName
							Set dfEmbLastName  = hWndParent.frmW4Card.sEmbLastName
						Set dfSecName = hWndParent.frmW4Card.sSecName
						Set dfWork    = hWndParent.frmW4Card.sWork
						Set dfOffice  = hWndParent.frmW4Card.sOffice
						Set dfWDate   = hWndParent.frmW4Card.dWDate
						Set hWndParent.frmW4Card.nWay4Rnk = hWndParent.frmW4Card.nClientRnk
					Else
						If hWndParent.frmW4Card.nCType = 1
							If dfEmbFirstName = ''
								Set dfEmbFirstName = hWndParent.frmW4Card.sEmbFirstName
							If dfEmbLastName  = ''
								Set dfEmbLastName = hWndParent.frmW4Card.sEmbLastName
						If dfSecName = ''
							Set dfSecName = hWndParent.frmW4Card.sSecName
						If dfWork    = ''
							Set dfWork = hWndParent.frmW4Card.sWork
						If dfOffice  = ''
							Set dfOffice = hWndParent.frmW4Card.sOffice
						If dfWDate   = DATETIME_Null
							Set dfWDate = hWndParent.frmW4Card.dWDate
						If dfBranch  = ''
							Call GetBranch(hWndParent.frmW4Card.sBranch)
					Call SalSetFocus(dfEmbFirstName)
				! проверка перед сохранением
				Else If wParam = 10
					If SalIsNull(dfEmbFirstName)
						Call SalMessageBox("Не заповнено " || IifS(hWndParent.frmW4Card.nCType=1, "Ім'я на картці", "Назва компанії на картці"), "Увага!", MB_IconExclamation | MB_Ok)
						Call SalSetFocus(dfEmbFirstName)
						Return FALSE
					If SalIsNull(dfEmbLastName) and hWndParent.frmW4Card.nCType = 1
						Call SalMessageBox("Не заповнено Прізвище на картці!", "Увага!", MB_IconExclamation | MB_Ok)
						Call SalSetFocus(dfEmbLastName)
						Return FALSE
					If SalIsNull(dfSecName)
						Call SalMessageBox("Не заповнено Таємне слово!", "Увага!", MB_IconExclamation | MB_Ok)
						Call SalSetFocus(dfSecName)
						Return FALSE
					If SalIsNull(dfBranch)
						Call SalMessageBox("Не заповнено Відділення!", "Увага!", MB_IconExclamation | MB_Ok)
						Call SalSetFocus(dfBranch)
						Return FALSE
					If SalIsNull(dfBranchIssue)
						Call SalMessageBox("Не заповнено Адреса доставки карти!", "Увага!", MB_IconExclamation | MB_Ok)
						Call SalSetFocus(dfBranchIssue)
						Return FALSE
					Set hWndParent.frmW4Card.sCardBranch = dfBranch
					Set hWndParent.frmW4Card.sCardBranchIssue = dfBranchIssue
					Set hWndParent.frmW4Card.sEmbFirstName = dfEmbFirstName
					Set hWndParent.frmW4Card.sEmbLastName  = dfEmbLastName
					Set hWndParent.frmW4Card.sSecName = dfSecName
					Set hWndParent.frmW4Card.sWork    = dfWork
					Set hWndParent.frmW4Card.sOffice  = dfOffice
					Set hWndParent.frmW4Card.dWDate   = dfWDate
					Return TRUE
	Table Window: tblArchiveXA
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Way4. Архів файлів XA
		Icon File:
		Accesories Enabled? Class Default
		Visible? Class Default
		Display Settings
			Visible at Design time? Yes
			Automatically Created at Runtime? Class Default
			Initial State: Class Default
			Maximizable? Class Default
			Minimizable? Class Default
			System Menu? Class Default
			Resizable? Class Default
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  Class Default
				Width Editable? Class Default
				Height: Class Default
				Height Editable? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: Class Default
			Text Color: Class Default
			Background Color: Class Default
			View: Class Default
			Allow Row Sizing? Class Default
			Lines Per Row: Class Default
		Memory Settings
			Maximum Rows in Memory: 20000
			Discardable? Class Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Class Default
				Visible? Class Default
				Size: Class Default
				Size Editable? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
			Contents
				Pushbutton: pbIns
					Class Child Ref Key: 33
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbDel
					Class Child Ref Key: 34
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbRefresh
					Class Child Ref Key: 35
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbUpdate
					Class Child Ref Key: 36
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 43613
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  5.183"
						Begin Y:  -0.024"
						End X:  5.183"
						End Y:  0.44"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbSearch
					Class Child Ref Key: 38
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbFilter
					Class Child Ref Key: 44
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Click
							If SetQueryDFilterEx(cF)
								Call SalPostMsg(hWndForm, UM_Populate, 0, 0)
				Pushbutton: pbDetails
					Class Child Ref Key: 39
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 43614
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbUnFormFile
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.0"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\BACK.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Розформувати файли'
						On SAM_Click
							If SalMessageBox('Розформувати відмічені файли?', 'Увага!', MB_IconQuestion | MB_YesNo) = IDYES
								Call UnFormFiles()
				Line
					Resource Id: 43616
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  4.517"
						Begin Y:  0.012"
						End X:  4.517"
						End Y:  0.476"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Pushbutton: pbExit
					Class Child Ref Key: 42
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.65"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 43615
					Class Child Ref Key: 43
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
		Contents
			Column: colFileName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ім'я файла
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colFileDat
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата файла
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.8"
				Width Editable? Yes
				Format: DateTime
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colFileN
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Кількість
						рядків
						у файлі
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colTickName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Квитанція
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colTickDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата квитовки
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.8"
				Width Editable? Yes
				Format: DateTime
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colStatus
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Статус
						обробки
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colAcceptRec
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Кількість
						прийнятих
						заяв
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colRejectRec
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Кількість
						НЕприйнятих
						заяв
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colUnFormFlag
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ознака
						розформування
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colUnFormUser
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Розформував
						файл
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colUnFormDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						розформування
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.8"
				Width Editable? Yes
				Format: DateTime
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
		Functions
			Function: UnFormFiles
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Boolean: bRet
					Number: nRow
					Number: nCount
				Actions
					Set bRet = TRUE
					Set nCount = 0
					Set nRow = TBL_MinRow
					While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
						Call SalTblSetContext(hWndForm, nRow)
						If colUnFormFlag = 0
							Set nCount = nCount + 1
							If not SqlPLSQLCommand(hSql(), "bars_owcrv.unform_xa_file(colFileName)")
								Set bRet = FALSE
								Break
					If nCount
						If bRet
							Call SqlCommit(hSql())
							Call SalMessageBox('Файли розформовано', 'Інформація', MB_IconAsterisk | MB_Ok)
						Else
							Call SqlRollback(hSql())
						Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
					Return TRUE
		Window Parameters
		Window Variables
			: cF
				Class: cGenDFilterEx
		Message Actions
			On SAM_Create
				Call SalSetWindowText(hWndForm, AppVersion || "Way4. Архів файлів XA")
				Call PrepareWindowEx(hWndForm)
				Call SetWindowFullSize(hWndForm)
				Set hWndForm.tblArchiveXA.nFlags = GT_NoIns | GT_NoDel
				Set hWndForm.tblArchiveXA.strFilterTblName = 'ow_xafiles'
				Set hWndForm.tblArchiveXA.strPrintFileName = 'xafiles'
				Set hWndForm.tblArchiveXA.fFilterAtStart = TRUE
				Set hWndForm.tblArchiveXA.strSqlPopulate =
						"select ow_xafiles.file_name, ow_xafiles.file_date, ow_xafiles.file_n, ow_xafiles.tick_name, ow_xafiles.tick_date,
						        ow_xafiles.tick_status, ow_xafiles.tick_accept_rec, ow_xafiles.tick_reject_rec,
						        nvl(ow_xafiles.unform_flag,0), s.fio, ow_xafiles.unform_date
						   into :hWndForm.tblArchiveXA.colFileName, :hWndForm.tblArchiveXA.colFileDat, :hWndForm.tblArchiveXA.colFileN,
						        :hWndForm.tblArchiveXA.colTickName, :hWndForm.tblArchiveXA.colTickDate,
						        :hWndForm.tblArchiveXA.colStatus, :hWndForm.tblArchiveXA.colAcceptRec,
						        :hWndForm.tblArchiveXA.colRejectRec, :hWndForm.tblArchiveXA.colUnFormFlag,
						        :hWndForm.tblArchiveXA.colUnFormUser, :hWndForm.tblArchiveXA.colUnFormDate
						   from ow_xafiles, staff$base s
						  where ow_xafiles.file_type = 1
						    and ow_xafiles.unform_user = s.id(+)
						  order by ow_xafiles.file_date desc, ow_xafiles.file_name desc"
				Call SalSendClassMessage(SAM_Create, 0, 0)
				Call cF.Init(strFilterTblName, strFilterTblName)
			On UM_Populate
				If strSqlPopulate != ''
					If fFilterAtStart
						If SetQueryDFilterEx(cF)
							Set fFilterAtStart = NOT fFilterAtStart
					If NOT fFilterAtStart
						Call SalWaitCursor(TRUE)
						Call SalTblDefineSplitWindow(hWndForm, 0, FALSE)
						Set strDSql = cQ.GetFullSQLStringDEx(cF)
						Call BindList.ActivateBinds()
						Call SalTblPopulate(hWndForm, cMain.hSql(), T(strDSql), nTabPopulateMethod)
						Call SalTblSetContext(hWndForm, 0)
						Call SalSendMsg(hWndForm, SAM_RowSetContext, 0, 0)
						Call SalWaitCursor(FALSE)
					Else
						Call SalDestroyWindow(hWndForm)
			On SAM_FetchRowDone
				! только ошибочные строки
				If colAcceptRec = 0 and colRejectRec > 0
					Call XSalTblSetRowBackColor(hWndForm, SalTblQueryContext(hWndForm), COLOR_Salmon)
				! частично принятый файл
				Else If colRejectRec > 0
					Call XSalTblSetRowBackColor(hWndForm, SalTblQueryContext(hWndForm), SalColorFromRGB(255,200,200))
			On SAM_DoubleClick
				If colFileName
					Call SalCreateWindow(tblArchiveXAAcc, hWndMDI, colFileName)
	Table Window: tblArchiveXAAcc
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Way4. Архів рахунків файлу XA
		Icon File:
		Accesories Enabled? Class Default
		Visible? Class Default
		Display Settings
			Visible at Design time? Yes
			Automatically Created at Runtime? Class Default
			Initial State: Class Default
			Maximizable? Class Default
			Minimizable? Class Default
			System Menu? Class Default
			Resizable? Class Default
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  Class Default
				Width Editable? Class Default
				Height: Class Default
				Height Editable? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: Class Default
			Text Color: Class Default
			Background Color: Class Default
			View: Class Default
			Allow Row Sizing? Class Default
			Lines Per Row: Class Default
		Memory Settings
			Maximum Rows in Memory: 20000
			Discardable? Class Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Class Default
				Visible? Class Default
				Size: Class Default
				Size Editable? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
			Contents
				Pushbutton: pbIns
					Class Child Ref Key: 33
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbDel
					Class Child Ref Key: 34
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbRefresh
					Class Child Ref Key: 35
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbUpdate
					Class Child Ref Key: 36
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 43617
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  5.183"
						Begin Y:  -0.024"
						End X:  5.183"
						End Y:  0.44"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbSearch
					Class Child Ref Key: 38
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbFilter
					Class Child Ref Key: 44
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbDetails
					Class Child Ref Key: 39
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 43618
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbUnFormAcc
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.0"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\BACK.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Розформувати рядки'
						On SAM_Click
							If SalMessageBox('Розформувати відмічені рядки файлу?', 'Увага!', MB_IconQuestion | MB_YesNo) = IDYES
								Call UnFormAcc()
				Line
					Resource Id: 43619
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  4.517"
						Begin Y:  0.012"
						End X:  4.517"
						End Y:  0.476"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Pushbutton: pbExit
					Class Child Ref Key: 42
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.65"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 43620
					Class Child Ref Key: 43
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
		Contents
			Column: colAcc
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Acc
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colNls
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Рахунок
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.8"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
					On SAM_SetFocus
						Set sTmp = colNls
					On SAM_AnyEdit
						Set colNls = sTmp
						Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
			Column: colRegNumber
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: RegNumber
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.4"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
					On SAM_SetFocus
						Set sTmp = colNls
					On SAM_AnyEdit
						Set colNls = sTmp
						Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
			Column: colRnk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Rnk
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colRespClass
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Статус
						обробки
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.4"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colRespCode
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						обробки
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colRespText
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Повідомлення
				Visible? Yes
				Editable? No
				Maximum Data Length: 254
				Data Type: String
				Justify: Left
				Width:  3.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colUnFormFlag
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ознака
						розформування
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colUnFormUser
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Розформував
						рядок файлу
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colUnFormDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						розформування
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.8"
				Width Editable? Yes
				Format: DateTime
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
		Functions
			Function: UnFormAcc
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Boolean: bRet
					Number: nRow
					Number: nCount
				Actions
					Set bRet = TRUE
					Set nCount = 0
					Set nRow = TBL_MinRow
					While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
						Call SalTblSetContext(hWndForm, nRow)
						If colUnFormFlag = 0
							Set nCount = nCount + 1
							If not SqlPLSQLCommand(hSql(), "bars_owcrv.unform_xa_acc(sFileName, colRnk, colAcc)")
								Set bRet = FALSE
								Break
					If nCount
						If bRet
							Call SqlCommit(hSql())
							Call SalMessageBox('Рядки файла розформовано', 'Інформація', MB_IconAsterisk | MB_Ok)
						Else
							Call SqlRollback(hSql())
						Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
					Return TRUE
		Window Parameters
			String: sFileName
		Window Variables
			String: sTmp
		Message Actions
			On SAM_Create
				Call SalSetWindowText(hWndForm, AppVersion || "Way4. Архів рахунків файлу " || sFileName)
				Call PrepareWindowEx(hWndForm)
				Call SetWindowFullSize(hWndForm)
				Set hWndForm.tblArchiveXAAcc.nFlags = GT_NoIns | GT_NoDel
				Set hWndForm.tblArchiveXAAcc.strFilterTblName = 'v_ow_xadata'
				Set hWndForm.tblArchiveXAAcc.strPrintFileName = 'xadata'
				Set hWndForm.tblArchiveXAAcc.strSqlPopulate =
						"select acc, nls, regnumber, rnk, resp_class, resp_code, resp_text,
						        unform_flag, fio, unform_date
						   into :hWndForm.tblArchiveXAAcc.colAcc, :hWndForm.tblArchiveXAAcc.colNls,
						        :hWndForm.tblArchiveXAAcc.colRegNumber, :hWndForm.tblArchiveXAAcc.colRnk,
						        :hWndForm.tblArchiveXAAcc.colRespClass, :hWndForm.tblArchiveXAAcc.colRespCode,
						        :hWndForm.tblArchiveXAAcc.colRespText, :hWndForm.tblArchiveXAAcc.colUnFormFlag,
						        :hWndForm.tblArchiveXAAcc.colUnFormUser, :hWndForm.tblArchiveXAAcc.colUnFormDate
						   from v_ow_xadata
						  where file_name = :hWndForm.tblArchiveXAAcc.sFileName"
				Call SalSendClassMessage(SAM_Create, 0, 0)
	Table Window: tblArchiveIIC
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Way4. Архів файлів IIC
		Icon File:
		Accesories Enabled? Class Default
		Visible? Class Default
		Display Settings
			Visible at Design time? Yes
			Automatically Created at Runtime? Class Default
			Initial State: Class Default
			Maximizable? Class Default
			Minimizable? Class Default
			System Menu? Class Default
			Resizable? Class Default
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  Class Default
				Width Editable? Class Default
				Height: Class Default
				Height Editable? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: Class Default
			Text Color: Class Default
			Background Color: Class Default
			View: Class Default
			Allow Row Sizing? Class Default
			Lines Per Row: Class Default
		Memory Settings
			Maximum Rows in Memory: 20000
			Discardable? Class Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Class Default
				Visible? Class Default
				Size: Class Default
				Size Editable? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
			Contents
				Pushbutton: pbIns
					Class Child Ref Key: 33
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbDel
					Class Child Ref Key: 34
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbRefresh
					Class Child Ref Key: 35
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbUpdate
					Class Child Ref Key: 36
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 6885
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  4.567"
						Begin Y:  -0.012"
						End X:  4.567"
						End Y:  0.452"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbSearch
					Class Child Ref Key: 38
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbFilter
					Class Child Ref Key: 44
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Click
							If SetQueryDFilterEx(cF)
								Call SalPostMsg(hWndForm, UM_Populate, 0, 0)
				Pushbutton: pbDetails
					Class Child Ref Key: 39
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Документи файла'
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 6886
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbExit
					Class Child Ref Key: 42
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 6888
					Class Child Ref Key: 43
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
		Contents
			Column: colFileName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ім'я файла
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  4.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colFileDat
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата файла
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.8"
				Width Editable? Yes
				Format: DateTime
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colFileN
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Кількість
						документів
						у файлі
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colFileS
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сума
						документів
						у файлі
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Yes
				Format: Decimal
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colFileR
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Кількість
						знятих
						відміток
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colTickName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Квитанція
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colTickDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата квитовки
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.8"
				Width Editable? Yes
				Format: DateTime
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colStatus
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Статус
						обробки
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colAcceptRec
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Кількість
						прийнятих
						документів
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colRejectRec
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Кількість
						НЕприйнятих
						документів
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
		Functions
		Window Parameters
			Number: nP1
		Window Variables
			: cF
				Class: cGenDFilterEx
			String: sFormTitle
			String: sViewName
		Message Actions
			On SAM_Create
				If nP1 = 0
					Set sFormTitle = "Way4. Архів файлів IIC"
					Set sViewName = "v_ow_iicfiles"
					Set hWndForm.tblArchiveIIC.strFilterTblName = 'v_ow_iicfiles'
				If nP1 = 1
					Set sFormTitle = "Way4. Архів файлів OIC*LOCKPAYREV"
					Set sViewName = "v_ow_oicrevfiles"
					Set hWndForm.tblArchiveIIC.strFilterTblName = 'v_ow_oicrevfiles'
				Call SalSetWindowText(hWndForm, AppVersion || sFormTitle)
				Call PrepareWindowEx(hWndForm)
				Call SetWindowFullSize(hWndForm)
				Set hWndForm.tblArchiveIIC.nFlags = GT_NoIns | GT_NoDel
				Set hWndForm.tblArchiveIIC.strPrintFileName = 'iicfiles'
				Set hWndForm.tblArchiveIIC.fFilterAtStart = TRUE
				Set hWndForm.tblArchiveIIC.strSqlPopulate =
						"select file_name, file_date, file_n, file_s, file_r,
						        tick_name, tick_date, tick_status, tick_accept_rec, tick_reject_rec
						   into :hWndForm.tblArchiveIIC.colFileName, :hWndForm.tblArchiveIIC.colFileDat,
						        :hWndForm.tblArchiveIIC.colFileN, :hWndForm.tblArchiveIIC.colFileS, :hWndForm.tblArchiveIIC.colFileR,
						        :hWndForm.tblArchiveIIC.colTickName, :hWndForm.tblArchiveIIC.colTickDate,
						        :hWndForm.tblArchiveIIC.colStatus, :hWndForm.tblArchiveIIC.colAcceptRec, :hWndForm.tblArchiveIIC.colRejectRec
						   from " ||  sViewName || "
						  order by file_date desc, file_name desc"
				Call SalSendClassMessage(SAM_Create, 0, 0)
				Call cF.Init(strFilterTblName, strFilterTblName)
			On UM_Populate
				If strSqlPopulate != ''
					If fFilterAtStart
						If SetQueryDFilterEx(cF)
							Set fFilterAtStart = NOT fFilterAtStart
					If NOT fFilterAtStart
						Call SalWaitCursor(TRUE)
						Call SalTblDefineSplitWindow(hWndForm, 0, FALSE)
						Set strDSql = cQ.GetFullSQLStringDEx(cF)
						Call BindList.ActivateBinds()
						Call SalTblPopulate(hWndForm, cMain.hSql(), T(strDSql), nTabPopulateMethod)
						Call SalTblSetContext(hWndForm, 0)
						Call SalSendMsg(hWndForm, SAM_RowSetContext, 0, 0)
						Call SalWaitCursor(FALSE)
					Else
						Call SalDestroyWindow(hWndForm)
			On SAM_FetchRowDone
				! только ошибочные строки
				If colAcceptRec = 0 and colRejectRec > 0
					Call XSalTblSetRowBackColor(hWndForm, SalTblQueryContext(hWndForm), COLOR_Salmon)
				! частично принятый файл
				Else If colRejectRec > 0
					Call XSalTblSetRowBackColor(hWndForm, SalTblQueryContext(hWndForm), SalColorFromRGB(255,200,200))
			On SAM_DoubleClick
				If colFileName
					Call SalCreateWindow(tblArchiveIICDoc, hWndMDI, colFileName)
	Table Window: tblArchiveIICDoc
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Way4. Архів документів файлу
		Icon File:
		Accesories Enabled? Class Default
		Visible? Class Default
		Display Settings
			Visible at Design time? Yes
			Automatically Created at Runtime? Class Default
			Initial State: Class Default
			Maximizable? Class Default
			Minimizable? Class Default
			System Menu? Class Default
			Resizable? Class Default
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  Class Default
				Width Editable? Class Default
				Height: Class Default
				Height Editable? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: Class Default
			Text Color: Class Default
			Background Color: Class Default
			View: Class Default
			Allow Row Sizing? Class Default
			Lines Per Row: Class Default
		Memory Settings
			Maximum Rows in Memory: 20000
			Discardable? Class Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Class Default
				Visible? Class Default
				Size: Class Default
				Size Editable? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
			Contents
				Pushbutton: pbIns
					Class Child Ref Key: 33
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbDel
					Class Child Ref Key: 34
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbRefresh
					Class Child Ref Key: 35
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbUpdate
					Class Child Ref Key: 36
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 6889
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  5.183"
						Begin Y:  -0.024"
						End X:  5.183"
						End Y:  0.44"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbSearch
					Class Child Ref Key: 38
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbFilter
					Class Child Ref Key: 44
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbDoc
					Class Child Ref Key: 39
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Перегляд документа'
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 6890
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbUnFormDoc
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.0"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\BACK.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = "Зняти відмітку про відправку"
						On SAM_Click
							If SalMessageBox("Зняти відмітку про відправку по вибраним документам" || PutCrLf() ||
									   "(тільки для несквітованих документів)?" || PutCrLf() ||
									   "Документи відправляться в ПЦ повторно!", "Увага!", MB_IconQuestion | MB_YesNo) = IDYES
								Call UnFormDoc()
				Line
					Resource Id: 6891
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  4.517"
						Begin Y:  0.012"
						End X:  4.517"
						End Y:  0.476"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Pushbutton: pbExit
					Class Child Ref Key: 42
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.65"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 6892
					Class Child Ref Key: 43
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
		Contents
			Column: colFlagKvt
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Реф.
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colRef
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Реф.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colDk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Д/К
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
				Width:  0.4"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colTt
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Оп.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Center
				Width:  0.6"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colAcc
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ACC
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
				Width:  0.4"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colNls
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Рахунок
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.8"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
					On SAM_SetFocus
						Set sTmp = colNls
					On SAM_AnyEdit
						Set colNls = sTmp
						Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
			Column: colS
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сума док.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.4"
				Width Editable? Yes
				Format: Decimal
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colLcv
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Вал.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Center
				Width:  0.6"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colNms
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Назва рахунку
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colBranch
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Відділення
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colNazn
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Призначення платежу
				Visible? Yes
				Editable? No
				Maximum Data Length: 160
				Data Type: String
				Justify: Left
				Width:  3.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colRespClass
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Статус
						обробки
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.4"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colRespCode
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						обробки
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colRespText
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Повідомлення
				Visible? Yes
				Editable? No
				Maximum Data Length: 254
				Data Type: String
				Justify: Left
				Width:  3.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
		Functions
			Function: UnFormDoc
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Boolean: bRet
					Number: nRow
					Number: nCount
				Actions
					Set bRet = TRUE
					Set nCount = 0
					Set nRow = TBL_MinRow
					While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
						Call SalTblSetContext(hWndForm, nRow)
						If not colFlagKvt
							Set nCount = nCount + 1
							If colRef
								If not SqlPLSQLCommand(hSql(), "bars_ow.unform_iic_doc(sFileName, colRef, colDk)")
									Set bRet = FALSE
									Break
								Else
									Call SaveInfoToLog("Way4. Снята отметка об отправке док." || Str(colRef))
							Else
								If not SqlPLSQLCommand(hSql(), "bars_ow.unform_iic_acc(sFileName, colAcc)")
									Set bRet = FALSE
									Break
								Else
									Call SaveInfoToLog("Way4. Снята отметка об отправке информации об аресте суммы по счету " || colNls)
					If nCount
						If bRet
							Call SqlCommit(hSql())
							Call SalMessageBox("Розформовано документи", "Інформація", MB_IconAsterisk | MB_Ok)
						Else
							Call SqlRollback(hSql())
						Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
					Return TRUE
		Window Parameters
			String: sFileName
		Window Variables
			String: sTmp
		Message Actions
			On SAM_Create
				Call SalSetWindowText(hWndForm, AppVersion || "Way4. Архів документів файлу " || sFileName)
				Call PrepareWindowEx(hWndForm)
				Call SetWindowFullSize(hWndForm)
				Set hWndForm.tblArchiveIICDoc.nFlags = GT_NoIns | GT_NoDel
				Set hWndForm.tblArchiveIICDoc.fFilterAtStart = TRUE
				Set hWndForm.tblArchiveIICDoc.strFilterTblName = "v_ow_iicfiles_doc"
				Set hWndForm.tblArchiveIICDoc.strPrintFileName = "iicdoc"
				Set hWndForm.tblArchiveIICDoc.strSqlPopulate =
						"select flag_kvt, ref, dk, tt, acc, nls, s, lcv, nms, branch, nazn,
						        resp_class, resp_code, resp_text
						   into :hWndForm.tblArchiveIICDoc.colFlagKvt, :hWndForm.tblArchiveIICDoc.colRef, :hWndForm.tblArchiveIICDoc.colDk,
						        :hWndForm.tblArchiveIICDoc.colTt, :hWndForm.tblArchiveIICDoc.colAcc, :hWndForm.tblArchiveIICDoc.colNls,
						        :hWndForm.tblArchiveIICDoc.colS, :hWndForm.tblArchiveIICDoc.colLcv,
						        :hWndForm.tblArchiveIICDoc.colNms, :hWndForm.tblArchiveIICDoc.colBranch,
						        :hWndForm.tblArchiveIICDoc.colNazn, :hWndForm.tblArchiveIICDoc.colRespClass,
						        :hWndForm.tblArchiveIICDoc.colRespCode, :hWndForm.tblArchiveIICDoc.colRespText
						   from v_ow_iicfiles_doc
						  where file_name = :hWndForm.tblArchiveIICDoc.sFileName"
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On SAM_DoubleClick
				If colRef
					! 1-DOC_EXTERNAL, 2-DOC_INTERNAL, 0-DB_SRC_ACTIVE
					Call DocView(hWndMDI, hWndForm.tblArchiveIICDoc.colRef, 2, 0, '')
			On SAM_FetchRowDone
				! сквитованные - нельзя расформировать
				If colFlagKvt
					Call SetTblRowColor(hWndForm, COLOR_Blue)
				! необработанные
				Else If colRespCode != '' and colRespCode != '0'
					Call XSalTblSetRowBackColor(hWndForm, lParam, SalColorFromRGB(255,200,200))
	Table Window: tblPkkQue
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Way4. Архів документів файлу
		Icon File:
		Accesories Enabled? Class Default
		Visible? Class Default
		Display Settings
			Visible at Design time? Yes
			Automatically Created at Runtime? Class Default
			Initial State: Class Default
			Maximizable? Class Default
			Minimizable? Class Default
			System Menu? Class Default
			Resizable? Class Default
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  Class Default
				Width Editable? Class Default
				Height: Class Default
				Height Editable? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: Class Default
			Text Color: Class Default
			Background Color: Class Default
			View: Class Default
			Allow Row Sizing? Class Default
			Lines Per Row: Class Default
		Memory Settings
			Maximum Rows in Memory: 20000
			Discardable? Class Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Class Default
				Visible? Class Default
				Size: Class Default
				Size Editable? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
			Contents
				Pushbutton: pbIns
					Class Child Ref Key: 33
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbDel
					Class Child Ref Key: 34
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = "Видалити документ з черги на відправку"
						On SAM_Click
							If SalMessageBox("Видалити вибрані документи з черги на відправку в ПЦ?", "Увага!", MB_IconQuestion | MB_YesNo) = IDYES
								Call DelDoc()
				Pushbutton: pbRefresh
					Class Child Ref Key: 35
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbUpdate
					Class Child Ref Key: 36
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 859
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  6.25"
						Begin Y:  -0.06"
						End X:  6.25"
						End Y:  0.405"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbSearch
					Class Child Ref Key: 38
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbFilter
					Class Child Ref Key: 44
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.933"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 860
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  3.467"
						Begin Y:  Class Default
						End X:  3.467"
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbDoc
					Class Child Ref Key: 39
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.567"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Перегляд документа'
				Pushbutton: pbAccCard
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.0"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\BOOK.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Перегляд картки рахунку'
						On SAM_Click
							If colAcc
								Call OperWithAccountEx(AVIEW_ALL, colAcc, colRnk, ACCESS_FULL, hWndForm, '')
				Line
					Resource Id: 863
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  4.533"
						Begin Y:  -0.012"
						End X:  4.533"
						End Y:  0.452"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Pushbutton: pbUnFormDoc
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.65"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\BACK.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = "Зняти відмітку про відправку"
						On SAM_Click
							If SalMessageBox("Зняти відмітку про відправку по вибраним документам" || PutCrLf() ||
									   "Документи відправляться в ПЦ повторно!", "Увага!", MB_IconQuestion | MB_YesNo) = IDYES
								Call UnFormDoc()
				Pushbutton: pbPay
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   5.1"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = "Оплата без квитовки"
						On SAM_Click
							If SalMessageBox("Оплатити вибрані документи без підтвердження з ПЦ?", "Увага!", MB_IconQuestion | MB_YesNo) = IDYES
								Call PayDoc()
				Line
					Resource Id: 861
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  5.617"
						Begin Y:  -0.012"
						End X:  5.617"
						End Y:  0.452"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Pushbutton: pbExit
					Class Child Ref Key: 42
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   5.717"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 862
					Class Child Ref Key: 43
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
		Contents
			Column: colRef
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Реф.
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
					On SAM_SetFocus
						Set nTmp = colRef
					On SAM_AnyEdit
						Set colRef = nTmp
						Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
			Column: colDk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Д/К
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
				Width:  0.4"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colPkkSos
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Sos
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
				Width:  0.4"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colFileName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ім'я файла
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.6"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colFileDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата файла
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.8"
				Width Editable? Yes
				Format: DateTime
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colAcc
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Acc
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
				Width:  0.4"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colNls
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Рахунок
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.8"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
					On SAM_SetFocus
						Set sTmp = colNls
					On SAM_AnyEdit
						Set colNls = sTmp
						Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
			Column: colKv
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Вал.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
				Width:  0.6"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colNms
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Назва рахунку
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colRnk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Rnk
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
				Width:  0.4"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colS
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сума док.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.4"
				Width Editable? Yes
				Format: Decimal
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colVdat
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						валют.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.2"
				Width Editable? Yes
				Format: Date
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colTt
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Оп.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Center
				Width:  0.6"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colNazn
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Призначення платежу
				Visible? Yes
				Editable? No
				Maximum Data Length: 160
				Data Type: String
				Justify: Left
				Width:  3.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colBranch
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Відділення
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colOperSos
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Sos
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
				Width:  0.4"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colRespClass
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Статус
						обробки
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.4"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colRespCode
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						обробки
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colRespText
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Повідомлення
				Visible? Yes
				Editable? No
				Maximum Data Length: 254
				Data Type: String
				Justify: Left
				Width:  3.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colUnformFio
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Розформував
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colUnformDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						розформування
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.8"
				Width Editable? Yes
				Format: DateTime
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
		Functions
			Function: UnFormDoc
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Boolean: bRet
					Number: nRow
					Number: nCount
				Actions
					Set bRet = TRUE
					Set nCount = 0
					Set nRow = TBL_MinRow
					While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
						Call SalTblSetContext(hWndForm, nRow)
						If not colUnformDate
							Set nCount = nCount + 1
							If not SqlPLSQLCommand(hSql(), "bars_ow.unform_iic_doc(colFileName, colRef, colDk)")
								Set bRet = FALSE
								Break
							Else
								Call SaveInfoToLog("Way4. Снята отметка об отправке док." || Str(colRef))
					If nCount
						If bRet
							Call SqlCommit(hSql())
							Call SalMessageBox("Розформовано документи", "Інформація", MB_IconAsterisk | MB_Ok)
						Else
							Call SqlRollback(hSql())
						Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
					Return TRUE
			Function: PayDoc
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Boolean: bRet
					Number: nRow
				Actions
					Set bRet = TRUE
					Set nRow = TBL_MinRow
					While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
						Call SalTblSetContext(hWndForm, nRow)
						If not SqlPLSQLCommand(hSql(), "bars_ow.payment_ref(colRef, colDk)")
							Set bRet = FALSE
							Break
						Else
							Call SaveInfoToLog("Way4. Ручная оплата (без квитовки) док." || Str(colRef))
					If bRet
						Call SqlCommit(hSql())
						Call SalMessageBox("Документи оплачено", "Інформація", MB_IconAsterisk | MB_Ok)
					Else
						Call SqlRollback(hSql())
					Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
					Return TRUE
			Function: DelDoc
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Boolean: bRet
					Number: nRow
				Actions
					Set bRet = TRUE
					Set nRow = TBL_MinRow
					While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
						Call SalTblSetContext(hWndForm, nRow)
						If not SqlPLSQLCommand(hSql(), "bars_ow.del_pkkque(colRef, colDk)")
							Set bRet = FALSE
							Break
						Else
							Call SaveInfoToLog("Way4. Удаление док." ||  Str(colRef) || " из очереди на отправку в ПЦ")
					If bRet
						Call SqlCommit(hSql())
						Call SalMessageBox("Документи вилучено", "Інформація", MB_IconAsterisk | MB_Ok)
					Else
						Call SqlRollback(hSql())
					Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
					Return TRUE
		Window Parameters
			Number: nSos
		Window Variables
			Number: nCount
			Number: nS
			String: sTmp
			Number: nTmp
		Message Actions
			On SAM_Create
				Call SetWindowFullSize(hWndForm)
				If nSos = 0
					Call SalSetWindowText(hWndForm, AppVersion || "Way4. Документи до відправки")
					Set hWndForm.tblPkkQue.nFlags = GT_NoIns | GT_NoUpd
					Call SalDisableWindow(pbUnFormDoc)
					Call SalDisableWindow(pbPay)
					Call SalHideWindow(colFileName)
					Call SalHideWindow(colFileDate)
					Call SalHideWindow(colRespClass)
					Call SalHideWindow(colRespCode)
					Call SalHideWindow(colRespText)
				Else If nSos = 1
					Call SalSetWindowText(hWndForm, AppVersion || "Way4. Несквитовані документи")
					Set hWndForm.tblPkkQue.nFlags = GT_ReadOnly
					Call SalHideWindow(colUnformFio)
					Call SalHideWindow(colUnformDate)
				Call PrepareWindowEx(hWndForm)
				Set hWndForm.tblPkkQue.fFilterAtStart = TRUE
				Set hWndForm.tblPkkQue.strFilterTblName = "v_ow_pkkque"
				Set hWndForm.tblPkkQue.strPrintFileName = "pkkque"
				Set hWndForm.tblPkkQue.strSqlPopulate =
						"select ref, dk, pkk_sos, f_n, f_d, acc, nls, kv, nms, rnk,
						        s, vdat, tt, nazn, branch, oper_sos,
						        resp_class, resp_code, resp_text, unform_fio, unform_date
						   into :hWndForm.tblPkkQue.colRef, :hWndForm.tblPkkQue.colDk, :hWndForm.tblPkkQue.colPkkSos,
						        :hWndForm.tblPkkQue.colFileName, :hWndForm.tblPkkQue.colFileDate,
						        :hWndForm.tblPkkQue.colAcc, :hWndForm.tblPkkQue.colNls,
						        :hWndForm.tblPkkQue.colKv, :hWndForm.tblPkkQue.colNms, :hWndForm.tblPkkQue.colRnk,
						        :hWndForm.tblPkkQue.colS, :hWndForm.tblPkkQue.colVdat,
						        :hWndForm.tblPkkQue.colTt, :hWndForm.tblPkkQue.colNazn,
						        :hWndForm.tblPkkQue.colBranch, :hWndForm.tblPkkQue.colOperSos,
						        :hWndForm.tblPkkQue.colRespClass, :hWndForm.tblPkkQue.colRespCode, :hWndForm.tblPkkQue.colRespText
						        :hWndForm.tblPkkQue.colUnformFio, :hWndForm.tblPkkQue.colUnformDate
						   from v_ow_pkkque
						  where pkk_sos = :hWndForm.tblPkkQue.nSos
						  order by ref desc"
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On SAM_FetchRowDone
				Set nCount = nCount + 1
				Set nS = nS + colS
				! плановые - зеленый текст
				If colOperSos > 0 and colOperSos < 5
					Call VisTblSetRowColor(hWndForm, lParam, COLOR_DarkGreen)
				! sos=0: расформированные - розовый фон
				If nSos = 0 and colUnformDate
					Call XSalTblSetRowBackColor(hWndForm, lParam, SalColorFromRGB(255,200,200))
				! sos=1: квитанция с ошибкой - розовый фон
				If nSos = 1 and colRespCode != '' and colRespCode != '0'
					Call XSalTblSetRowBackColor(hWndForm, lParam, SalColorFromRGB(255,200,200))
			On UM_Populate
				Set nCount = 0
				Set nS = 0
				Call SalSendClassMessage(UM_Populate, 0, 0)
				Call SalTblDefineSplitWindow(hWndForm, 1, TRUE)
				Set nRow = SalTblInsertRow(hWndForm, TBL_MinRow)
				Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
				Call SalTblSetContext(hWndForm, nRow)
				Set colNms = 'Док. всього:   ' || Str(nCount)
				Set colS   = nS
				Call SalTblSetContext(hWndForm, 0)
				Call SalSendMsg(hWndForm, SAM_TblDoDetails, 0, 0)
			On SAM_DoubleClick
				If colRef
					! 1-DOC_EXTERNAL, 2-DOC_INTERNAL, 0-DB_SRC_ACTIVE
					Call DocView(hWndMDI, hWndForm.tblPkkQue.colRef, 2, 0, '')
			On SAM_TblDoDetails
				If nSos = 1
					If colFileName = STRING_Null
						Call SalDisableWindow(pbUnFormDoc)
						Call SalDisableWindow(pbPay)
					Else
						Call SalEnableWindow(pbUnFormDoc)
						Call SalEnableWindow(pbPay)
	Form Window: frmImportProect
		Class:
		Property Template:
		Class DLL Name:
		Title:
		Icon File:
		Accesories Enabled? Yes
		Visible? No
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Automatically Created at Runtime? Yes
			Initial State: Normal
			Maximizable? Yes
			Minimizable? Yes
			System Menu? Yes
			Resizable? Yes
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  13.9"
				Width Editable? Yes
				Height: 6.85"
				Height Editable? Yes
			Form Size
				Width:  Default
				Height: Default
				Number of Pages: Dynamic
			Font Name: Default
			Font Size: Default
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Default
				Location? Top
				Visible? Yes
				Size: 0.4"
				Size Editable? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Contents
				Pushbutton: pbPrint
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbPrint
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.1"
						Top:    0.05"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Друк таблиці'
						On SAM_Click
							If dfFileName
								Call SalSendMsg(tblImp, UM_Print, 0, 0)
				Pushbutton: pbOpenCard
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.55"
						Top:    0.05"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Відкрити картки'
						On SAM_Click
							If dfFileName
								If dfBadRows > 0
									If dfBadRows != dfErrRows
										If tblImp.CreateDeal(nId)
											Set dfOpen = ''
											Call SalDisableWindow(pbOpenCard)
											Call SalHideWindow(tblImp.colOpen)
									Else
										Call SalMessageBox("Залишились тільки рядки з помилками!", "Інформація", MB_IconAsterisk | MB_Ok)
								Else
									Call SalMessageBox("Немає необроблених рядків!", "Інформація", MB_IconAsterisk | MB_Ok)
				Line
					Resource Id: 38398
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  1.1"
						Begin Y:  0.0"
						End X:  1.1"
						End Y:  0.5"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Pushbutton: pbCancel
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbCancel
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.2"
						Top:    0.05"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Вийти'
						On SAM_Click
							Call SalDestroyWindow(hWndForm)
		Contents
			Group Box: Файл зарплатного проекту
				Resource Id: 38383
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    0.05"
					Width:  4.73"
					Width Editable? Yes
					Height: 2.4"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: 3D Shadow Color
				Background Color: Default
			Pushbutton: pbImport
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Імпортувати файл
				Window Location and Size
					Left:   0.2"
					Top:    0.35"
					Width:  4.4"
					Width Editable? Yes
					Height: 0.35"
					Height Editable? Yes
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Picture File Name:
				Picture Transparent Color: None
				Image Style: Single
				Text Color: Default
				Background Color: Default
				Message Actions
					On SAM_Click
						If SalDlgOpenFile(hWndForm, 'Open File', strFilters, 2, nIndex, strFile, dfPath)
							Set dfFileName = dfPath
							If ImportFile(dfFileName)
								! Населяем таблицу
								Call SalSendMsg(tblImp, UM_Populate, 0, 0)
								Call tblImp.checkOpenCard()
								Call SalEnableWindow(pbOpenCard)
			Data Field: dfFileName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 100
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   0.2"
						Top:    0.85"
						Width:  4.4"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Рядків в файлі
				Resource Id: 38384
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    1.2"
					Width:  2.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfAllRows
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.3"
						Top:    1.15"
						Width:  2.3"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Оброблено
				Resource Id: 38385
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    1.5"
					Width:  2.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfGoodRows
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.3"
						Top:    1.45"
						Width:  2.3"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Не оброблено
				Resource Id: 38386
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    1.8"
					Width:  2.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfBadRows
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.3"
						Top:    1.75"
						Width:  2.3"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: З помилками
				Resource Id: 38387
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    2.1"
					Width:  2.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfErrRows
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.3"
						Top:    2.05"
						Width:  2.3"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			!
			Group Box: Картка
				Resource Id: 38390
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.8"
					Top:    0.05"
					Width:  8.7"
					Width Editable? Yes
					Height: 2.4"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: 3D Shadow Color
				Background Color: Default
			Background Text: Відділення
				Resource Id: 38388
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.9"
					Top:    0.3"
					Width:  2.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfBranch
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   7.0"
						Top:    0.25"
						Width:  5.8"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Data Field: dfBranchName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   7.0"
						Top:    0.55"
						Width:  5.8"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Pushbutton: pbBranch
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbFilter
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   12.9"
					Top:    0.179"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name:
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Create
						Set strTip = 'Відділення'
					On SAM_Click
						If FunNSIGetFiltered("our_branch", "name", "length(branch)>=15", sPK, sSem)
							Set dfBranch = sPK
							Set dfBranchName = sSem
			!
			Background Text: Відп.виконавець
				Resource Id: 38389
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.9"
					Top:    0.9"
					Width:  2.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfIspCode
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 10
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   7.0"
						Top:    0.85"
						Width:  1.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Data Field: dfIspName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   8.05"
						Top:    0.85"
						Width:  4.75"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Pushbutton: pbIsp
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbFilter
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   12.9"
					Top:    0.774"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name:
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Create
						Set strTip = 'Відповідальний виконавець'
					On SAM_Click
						If FunNSIGetFiltered("staff", "fio", "type=1 and active=1 " || IifS(dfBranch!='', "and " || sStaffBranchColumn || "='" || dfBranch || "'", "") || " ORDER BY fio", sPK, sSem)
							Set dfIspCode = Val(sPK)
							Set dfIspName = sSem
							! Call GetIsp(dfIspCode)
			!
			Background Text: З/П проект
				Resource Id: 38399
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.9"
					Top:    1.2"
					Width:  2.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: bgProect
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cLabelControl
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Default
						Top:    Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Data Field: dfSalaryProectCode
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 10
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    1.75"
						Width:  1.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? No
					Border? Yes
					Justify: Center
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Data Field: dfSalaryProectName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   7.0"
						Top:    1.15"
						Width:  5.8"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Picture: pbSalaryProect
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   12.9"
					Top:    1.12"
					Width:  0.433"
					Width Editable? Yes
					Height: 0.3"
					Height Editable? Yes
				Visible? Yes
				Editable? No
				File Name: \BARS98\RESOURCE\BMP\FILTER.BMP
				Storage: Internal
				Picture Transparent Color: Gray
				Fit: Scale
				Scaling
					Width:  100
					Height:  100
				Corners: Square
				Border Style: Raised-Shadow
				Border Thickness: 1
				Tile To Parent? No
				Border Color: Default
				Background Color: 3D Face Color
				Message Actions
					On SAM_TooltipSetText
						If sGrpCode = 'SALARY'
							Return XSalTooltipSetText(lParam, 'Зарплатний проект')
						Else
							Return XSalTooltipSetText(lParam, 'Продукт')
					On SAM_Click
						If sGrpCode = 'SALARY'
							If FunNSIGetFiltered("bpk_proect", "name", "", sPK, sSem)
								Set dfSalaryProectCode = Val(sPK)
								Set dfSalaryProectName = sSem
								Set dfCardCode = ''
								Set dfCardName = ''
								Call SqlPrepareAndExecute(hSql(), "select product_code into :sProductCode from bpk_proect where id = :dfSalaryProectCode")
								Call SqlFetchNext(hSql(), nFetchRes)
						Else
							If FunNSIGetFiltered("v_w4_product_clienttype", "name", "grp_code = '" || sGrpCode || "' and client_type=1 order by name", sPK, sSem)
								Set sProductCode = sPK
								Set dfSalaryProectCode = NUMBER_Null
								Set dfSalaryProectName = sSem
								Set dfCardCode = ''
								Set dfCardName = ''
			!
			Background Text: Тип картки
				Resource Id: 38391
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.9"
					Top:    1.5"
					Width:  2.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfCardCode
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   7.0"
						Top:    1.45"
						Width:  5.8"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Data Field: dfCardName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   7.0"
						Top:    1.75"
						Width:  5.8"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Pushbutton: pbCard
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbFilter
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   12.9"
					Top:    1.452"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name:
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Create
						Set strTip = 'Продукт'
					On SAM_Click
						If FunNSIGetFiltered("v_w4_card", "sub_name", IifS(sProductCode='',"","product_code='" || sProductCode || "'"), sPK, sSem)
							Set dfCardCode = sPK
							Set dfCardName = sSem
						Call tblImp.checkOpenCard()
			Data Field: dfOpen
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   4.9"
						Top:    2.1"
						Width:  7.8"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? No
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Bold
					Text Color: Red
					Background Color: 3D Face Color
					Input Mask: Unformatted
				Message Actions
			!
			Child Table: tblImp
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Display Settings
					Window Location and Size
						Left:   0.1"
						Top:    2.5"
						Width:  13.4"
						Width Editable? Yes
						Height: 3.4"
						Height Editable? Yes
					Visible? Yes
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					View: Table
					Allow Row Sizing? No
					Lines Per Row: Default
				Memory Settings
					Maximum Rows in Memory: 30000
					Discardable? Yes
				Contents
					Column: colIdn
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Idn
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Left
						Width:  1.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colOpen
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Відкрити
						Visible? Yes
						Editable? Yes
						Maximum Data Length: Default
						Data Type: Number
						Justify: Center
						Width:  1.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Check Box
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value: 1
								Uncheck Value: 0
								Ignore Case? Yes
						List Values
						Message Actions
							On SAM_AnyEdit
								! 1) если colFlagOpen=0 - ошибка - флаг всегда снят (не открываем карточку)
								! 2) если colFlagOpen=1 - нет ошибки - флаг всегда установлен (открываем карточку)
								! 3) если colFlagOpen=2 ("Вже відкрито картку")- разрешаем снимать/устанавливать флаг
								If colFlagOpen = 0
									Set colOpen = FALSE
								Else If colFlagOpen = 1
									Set colOpen = TRUE
					Column: colFlagOpen
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Відкрити
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Center
						Width:  1.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value: 1
								Uncheck Value: 0
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colStrErr
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Повідомлення
						Visible? Yes
						Editable? No
						Maximum Data Length: 254
						Data Type: String
						Justify: Left
						Width:  3.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colNd
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Номер
								договору
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Left
						Width:  1.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colRnk
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: РНК
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Left
						Width:  1.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colNls
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Картковий
								рахунок
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.6"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colOkpo
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: ЗКПО
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.2"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colFirstName
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Ім'я
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  2.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colLastName
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Прізвище
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  2.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colMiddleName
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: По-батькові
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  2.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colTypeDoc
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Тип
								док.
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colPaspSer
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Паспорт:
								серія
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colPaspNum
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Паспорт:
								номер
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colPaspIssuer
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Паспорт:
								ким видано
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  2.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colPaspDate
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Паспорт:
								коли
								видано
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Date/Time
						Justify: Center
						Width:  1.2"
						Width Editable? Yes
						Format: Date
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colBDay
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Дата
								народж.
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Date/Time
						Justify: Center
						Width:  1.2"
						Width Editable? Yes
						Format: Date
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					! Column: colBPlace
.winattr
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Місце
								народження
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.2"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
.end
						                                                                                                                        List Values
						                                                                                                                        Message Actions
					Column: colCountry
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Громадян
								ство
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colResident
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Резидент
								ність
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colGender
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Стать
						Visible? Yes
						Editable? Yes
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colPhoneHome
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Телефон
								дом.
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colPhoneMob
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Телефон
								моб.
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colEmail
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: e-mail
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colEngFirstName
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Ім'я
								для
								ембосування
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  2.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colEngLastName
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Прізвище
								для
								ембосування
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  2.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colMName
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Дівоче
								прізвище
								матері
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.2"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colAddr1Cityname
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Адреса
								реєстрації:
								місто
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.2"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colAddr1Pcode
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Адреса
								реєстрації:
								індекс
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colAddr1Domain
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Адреса
								реєстрації:
								область
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.2"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colAddr1Region
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Адреса
								реєстрації
								район
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.2"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colAddr1Street
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Адреса
								реєстрації:
								вулиця, дім, кв.
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.2"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colAddr2Cityname
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Адреса
								проживання:
								місто
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.2"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colAddr2Pcode
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Адреса
								проживання:
								індекс
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colAddr2Domain
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Адреса
								проживання:
								область
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.2"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colAddr2Region
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Адреса
								проживання:
								район
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.2"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colAddr2Street
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Адреса
								проживання:
								вулиця, дім, кв.
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.2"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colWork
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Місце
								роботи
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.2"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colOffice
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Посада
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.2"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colDateW
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Дата
								прийняття
								на роботу
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Date/Time
						Justify: Center
						Width:  1.2"
						Width Editable? Yes
						Format: Date
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colOkpoW
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Код ЗКПО
								організації
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.2"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colPersCat
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Категорія
								персоналу
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.2"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colAverSum
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Середньоміс.
								доход
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Left
						Width:  1.2"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colTabn
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Табельний
								номер
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
				Functions
					Function: checkOpenCard
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							If dfAllRows and dfCardCode
								Call SalShowWindow(colOpen)
								If not SqlPLSQLCommand(hSql(), "bars_ow.check_salary_opencard(nId,dfCardCode)")
									Call SqlRollbackEx(hSql(), "WAY4. Ошибка выполнения bars_ow.check_salary_opencard")
									Return FALSE
								Call SqlCommit(hSql())
								Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
							Else
								Call SalHideWindow(colOpen)
							Return TRUE
					Function: CreateDeal
						Description:
						Returns
							Boolean:
						Parameters
							Number: nFileId
						Static Variables
						Local variables
							Number: nRow
							String: sTickName
							String: sDrive
							String: sDir
							String: sFile
							String: sExt
							String: sFullName
						Actions
							If not dfBranch
								Call SalMessageBox("Не вказано відділення!", "Увага!", MB_IconExclamation | MB_Ok)
								Return FALSE
							If not dfIspCode
								Call SalMessageBox("Не вказано відповідального виконавця!", "Увага!", MB_IconExclamation | MB_Ok)
								Return FALSE
							If not dfCardCode
								Call SalMessageBox("Не вказано тип картки!", "Увага!", MB_IconExclamation | MB_Ok)
								Return FALSE
							Call SalWaitCursor(TRUE)
							Set nRow = TBL_MinRow
							While SalTblFindNextRow(hWndForm, nRow, 0, 0)
								Call SalTblSetContext(hWndForm, nRow)
								If colFlagOpen = 2 and colOpen
									If not SqlPLSQLCommand(hSql(), "bars_ow.set_salary_flagopen(nFileId, colIdn, 1)")
										Call SqlRollback(hSql())
										Call SalWaitCursor(FALSE)
										Return FALSE
							If not SqlPLSQLCommand(hSql(), "bars_ow.create_salary_deal(nFileId, dfSalaryProectCode, dfCardCode, dfBranch, dfIspCode)")
								Call SqlRollbackEx(hSql(), "")
								Call SalWaitCursor(FALSE)
								Return FALSE
							Call SalMessageBox("Відкрито угоди по файлу " || dfFileName, "Інформація", MB_IconAsterisk | MB_Ok)
							Call SqlCommitEx(hSql(), "WAY4. " || "Відкрито угоди по файлу " || dfFileName)
							! формируем данные для квитанции
							If not SqlPLSQLCommand(hSql(), "bars_ow.form_salary_ticket(nFileId, sTickName)")
								Call SqlRollback(hSql())
								Call SalMessageBox('Помилка формування квитанції (sql)', 'Помилка', MB_IconStop | MB_Ok)
								Return FALSE
							Call SqlCommit(hSql())
							If sTickName
								Call VisDosSplitPath(dfFileName, sDrive, sDir, sFile, sExt)
								Set sFullName = sDrive || sDir || '\\' || sTickName
								If not PutClobToFile(hSql(), sFullName, 'OW_IMPFILE', 'ID', 'FILE_DATA', nFileId, STRING_Null, STRING_Null)
									Call SalMessageBox('Помилка формування квитанції (файла)', 'Помилка', MB_IconStop | MB_Ok)
									Return FALSE
								Call SalMessageBox('Сформовано квитанцію ' || sFullName, 'Повідомлення', MB_IconAsterisk | MB_Ok)
							Call SalSendMsg(tblImp, UM_Populate, 0, 0)
							Call SalWaitCursor(FALSE)
							Return TRUE
				Window Variables
				Message Actions
					On UM_Populate
						Call SalWaitCursor(TRUE)
						Set dfAllRows  = 0
						Set dfGoodRows = 0
						Set dfBadRows  = 0
						Set dfErrRows  = 0
						Set nOpen  = 0
						Set dfOpen = ''
						Call SalTblPopulate(hWndForm, hSql(),
								"select i.idn, i.nd, i.rnk, a.nls, i.okpo, i.first_name, i.last_name, i.middle_name,
								        i.type_doc, i.paspseries, i.paspnum, i.paspissuer, i.paspdate, i.bday,
								        i.country, i.resident, i.gender, i.phone_home, i.phone_mob, i.email,
								        i.eng_first_name, i.eng_last_name, i.mname,
								        i.addr1_cityname, i.addr1_pcode, i.addr1_domain, i.addr1_region, i.addr1_street,
								        i.addr2_cityname, i.addr2_pcode, i.addr2_domain, i.addr2_region, i.addr2_street,
								        i.work, i.office, i.date_w, i.okpo_w, i.pers_cat, i.aver_sum, i.tabn, i.str_err, nvl(i.flag_open,0)
								   into :colIdn, :colNd, :colRnk, :colNls, :colOkpo, :colFirstName, :colLastName, :colMiddleName,
								        :colTypeDoc, :colPaspSer, :colPaspNum, :colPaspIssuer, :colPaspDate, :colBDay,
								        :colCountry, :colResident, :colGender, :colPhoneHome, :colPhoneMob, :colEmail,
								        :colEngFirstName, :colEngLastName, :colMName,
								        :colAddr1Cityname, :colAddr1Pcode, :colAddr1Domain, :colAddr1Region, :colAddr1Street,
								        :colAddr2Cityname, :colAddr2Pcode, :colAddr2Domain, :colAddr2Region, :colAddr2Street,
								        :colWork, :colOffice, :colDateW, :colOkpoW, :colPersCat, :colAverSum, :colTabn, :colStrErr, :colFlagOpen
								   from ow_salary_data i, w4_acc o, accounts a
								  where i.id = :nId
								    and i.nd = o.nd(+)
								    and o.acc_pk = a.acc(+)
								  order by i.str_err, i.idn", TBL_FillAll)
						If nOpen
							Set dfOpen = Str(nOpen) || ' клієнтам вже відкрито рахунок такого продукту.'
						Call SalWaitCursor(FALSE)
					On SAM_FetchRowDone
						Set dfAllRows = dfAllRows  + 1
						If colNd
							Set dfGoodRows = dfGoodRows + 1
							Set colStrErr  = "Відкрито картку"
							Call XSalTblSetRowBackColor(hWndForm, lParam, SalColorFromRGB(230,255,230)) ! светло-зеленый
						Else
							Set dfBadRows = dfBadRows + 1
							If SalIsNull(colOkpo)
								Call XSalTblSetCellBackColor(colOkpo, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colFirstName)
								Call XSalTblSetCellBackColor(colFirstName, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colLastName)
								Call XSalTblSetCellBackColor(colLastName, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colTypeDoc)
								Call XSalTblSetCellBackColor(colTypeDoc, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colPaspSer)
								Call XSalTblSetCellBackColor(colPaspSer, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colPaspNum)
								Call XSalTblSetCellBackColor(colPaspNum, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colPaspIssuer)
								Call XSalTblSetCellBackColor(colPaspIssuer, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colPaspDate)
								Call XSalTblSetCellBackColor(colPaspDate, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colBDay)
								Call XSalTblSetCellBackColor(colBDay, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colCountry)
								Call XSalTblSetCellBackColor(colCountry, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colResident)
								Call XSalTblSetCellBackColor(colResident, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colGender)
								Call XSalTblSetCellBackColor(colGender, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colMName)
								Call XSalTblSetCellBackColor(colMName, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colAddr1Cityname)
								Call XSalTblSetCellBackColor(colAddr1Cityname, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colAddr1Street)
								Call XSalTblSetCellBackColor(colAddr1Street, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colOkpoW)
								Call XSalTblSetCellBackColor(colOkpoW, SalColorFromRGB(250, 170, 170))
							If colStrErr and colFlagOpen = 0
								Call XSalTblSetCellBackColor(colStrErr, SalColorFromRGB(250, 170, 170))
								Set dfErrRows = dfErrRows + 1
						If colFlagOpen = 1
							Set colOpen = TRUE
						Else If colFlagOpen = 2
							Call SalTblSetCellTextColor(colStrErr, COLOR_Red, FALSE)
							Set nOpen = nOpen + 1
					On UM_Print
						Call TablePrint(hWndForm, 'Файл ' || dfFileName, GetPrnDir() || '\\' || 'bpk_impfile', '')
		Functions
			Function: ImportFile
				Description:
				Returns
					Boolean:
				Parameters
					String: sPath
				Static Variables
				Local variables
					String: sDrive
					String: sDir
					String: sFile
					String: sExt
					String: sFilePath
					String: sFileName
					Boolean: bRet
				Actions
					Call SalWaitCursor(TRUE)
					Call VisDosSplitPath(sPath, sDrive, sDir, sFile, sExt)
					Set sFilePath = sDrive || sDir
					Set sFileName = sFile || sExt
					Set bRet = FALSE
					Loop
						If not GetImpId(nId)
							Return FALSE
						! Импорт файла во временную таблицу
						If not PutFileToClob(hSql(), sPath, 'ow_impfile', 'id', 'file_data', nId, STRING_Null, STRING_Null, 1)
							Break
						! Обработка файла
						If not SqlPLSQLCommand(hSql(), "bars_ow.import_salary_file(sFileName, nId)")
							Call SqlRollback(hSql())
							Break
						! nId = -1 - нарушена структура файла
						If nId = -1
							Call SalMessageBox("Порушено структуру файлу", "Помилка", MB_IconExclamation)
							Break
						Call SqlCommitEx(hSql(), "Выполнен импорт файла " || sFileName)
						Set bRet = TRUE
						Break
					If not bRet
						Set dfFileName = STRING_Null
						Set dfAllRows  = NUMBER_Null
						Set dfGoodRows = NUMBER_Null
						Set dfBadRows  = NUMBER_Null
						Set dfErrRows  = NUMBER_Null
						Call SalTblReset(tblImp)
					Call SalWaitCursor(FALSE)
					Return bRet
		Window Parameters
			String: sGrpCode
		Window Variables
			Number: nHAVETOBO
			String: sStaffBranchColumn
			String: strFilters[2]
			Number: nIndex
			String: strFile
			String: dfPath
			String: sPK
			String: sSem
			Number: nId
			String: sProductCode
			Number: nOpen
		Message Actions
			On SAM_Create
				Call SalSetWindowText(hWndForm, AppVersion || "Way4. Імпорт проектів на відкриття договорів БПК")
				Call PrepareWindowEx(hWndForm)
				Set strFilters[0] = 'Xml-файли'
				Set strFilters[1] = '*.xml'
				Set sProductCode = ''
				Set nHAVETOBO = GetGlobalOptionEx('HAVETOBO')
				If nHAVETOBO = 2
					Call SqlPrepareAndExecute(hSql(),
							"select sys_context('bars_context','user_branch'), substr(branch_usr.get_branch_name,1,100)
							   into :dfBranch, :dfBranchName
							   from dual")
					Call SqlFetchNext(hSql(), nFetchRes)
					Set sStaffBranchColumn = "branch"
				! Для ГРЦ sBranch = 0
				Else
					Set dfBranch = '0'
					Call SqlPrepareAndExecute(hSql(), "select name into :dfBranchName from tobo where tobo = :dfBranch")
					Call SqlFetchNext(hSql(), nFetchRes)
					Set sStaffBranchColumn = "tobo"
				If sGrpCode != 'SALARY'
					Call SalSetWindowLabelText(bgProect, 'Продукт')
					Call SalHideWindow(tblImp.colOkpoW)
					Call SalHideWindow(tblImp.colPersCat)
					Call SalHideWindow(tblImp.colAverSum)
					Call SalHideWindow(tblImp.colTabn)
				Call SalHideWindow(tblImp.colOpen)
				Call SalDisableWindow(pbOpenCard)
				Call SalSetFocus(pbCancel)
	Table Window: tblArchiveSalaryFiles
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title:
		Icon File:
		Accesories Enabled? Class Default
		Visible? Class Default
		Display Settings
			Visible at Design time? Yes
			Automatically Created at Runtime? Class Default
			Initial State: Class Default
			Maximizable? Class Default
			Minimizable? Class Default
			System Menu? Class Default
			Resizable? Class Default
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  Class Default
				Width Editable? Class Default
				Height: Class Default
				Height Editable? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: Class Default
			Text Color: Class Default
			Background Color: Class Default
			View: Class Default
			Allow Row Sizing? Class Default
			Lines Per Row: Class Default
		Memory Settings
			Maximum Rows in Memory: Class Default
			Discardable? Class Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Class Default
				Visible? Class Default
				Size: Class Default
				Size Editable? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
			Contents
				Pushbutton: pbIns
					Class Child Ref Key: 33
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbDel
					Class Child Ref Key: 34
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbRefresh
					Class Child Ref Key: 35
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbUpdate
					Class Child Ref Key: 36
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 28557
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  5.183"
						Begin Y:  Class Default
						End X:  5.183"
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbSearch
					Class Child Ref Key: 38
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbFilter
					Class Child Ref Key: 44
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbDetails
					Class Child Ref Key: 39
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 28558
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbTicket
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.0"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\CHKMAIL.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = "Сформувати квитанцію на файл"
						On SAM_Click
							Call FormTicket()
				Line
					Resource Id: 28560
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  4.517"
						Begin Y:  -0.012"
						End X:  4.517"
						End Y:  0.452"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Pushbutton: pbExit
					Class Child Ref Key: 42
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.65"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 28559
					Class Child Ref Key: 43
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
		Contents
			Column: colFileId
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						файлу
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  0.8"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colFileName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ім'я файла
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colFileDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата файла
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.8"
				Width Editable? Yes
				Format: DateTime
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colFileN
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Кількість
						заяв
						у файлі
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colFileDeal
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Кількість
						зареєстр.
						угод
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colCardCode
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Тип картки
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colBranch
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Відділення
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colIsp
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Вик.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
		Functions
			Function: FormTicket
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Number: nFileId
					Number: nRow
					String: sTickName
					String: sFullName
				Actions
					Set nRow = TBL_MinRow
					While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
						Call SalTblSetContext(hWndForm, nRow)
						! формируем данные для квитанции
						Set nFileId = colFileId
						If not SqlPLSQLCommand(hSql(), "bars_ow.form_salary_ticket(nFileId, sTickName)")
							Call SqlRollback(hSql())
							Call SalMessageBox('Помилка формування квитанції (sql)', 'Помилка', MB_IconStop | MB_Ok)
							Return FALSE
						Call SqlCommit(hSql())
						If sTickName
							Set sFullName = GetPrnDir() || '\\' || sTickName
							If not PutClobToFile(hSql(), sFullName, 'OW_IMPFILE', 'ID', 'FILE_DATA', nFileId, STRING_Null, STRING_Null)
								Call SalMessageBox('Помилка формування квитанції (файла)', 'Помилка', MB_IconStop | MB_Ok)
								Return FALSE
							Call SalMessageBox('Сформовано квитанцію ' || sFullName, 'Повідомлення', MB_IconAsterisk | MB_Ok)
					Return TRUE
		Window Parameters
		Window Variables
		Message Actions
			On SAM_Create
				Call SalSetWindowText(hWndForm, AppVersion || "Way4. Архів файлів зарплатних проектів")
				Call PrepareWindowEx(hWndForm)
				Call SetWindowFullSize(hWndForm)
				Set hWndForm.tblArchiveSalaryFiles.nFlags = GT_NoIns | GT_NoDel
				Set hWndForm.tblArchiveSalaryFiles.strFilterTblName = 'v_ow_salary_files'
				Set hWndForm.tblArchiveSalaryFiles.strPrintFileName = 'salary_files'
				Set hWndForm.tblArchiveSalaryFiles.fFilterAtStart = TRUE
				Set hWndForm.tblArchiveSalaryFiles.strSqlPopulate =
						"select id, file_name, file_date, file_n, file_deal,
						        card_code, branch, isp
						   into :hWndForm.tblArchiveSalaryFiles.colFileId, :hWndForm.tblArchiveSalaryFiles.colFileName, :hWndForm.tblArchiveSalaryFiles.colFileDate,
						        :hWndForm.tblArchiveSalaryFiles.colFileN, :hWndForm.tblArchiveSalaryFiles.colFileDeal,
						        :hWndForm.tblArchiveSalaryFiles.colCardCode, :hWndForm.tblArchiveSalaryFiles.colBranch, :hWndForm.tblArchiveSalaryFiles.colIsp
						   from v_ow_salary_files
						  order by file_date desc, file_name"
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On SAM_FetchRowDone
				If colFileDeal != NUMBER_Null and colFileN != colFileDeal
					Call XSalTblSetRowBackColor(hWndForm, SalTblQueryContext(hWndForm), SalColorFromRGB(255,200,200))
			On SAM_DoubleClick
				If colFileName
					Call FunNSIEditFFiltered("ow_salary_data", 1, "file_name='" || colFileName || "'")
	Table Window: tblLocalCard
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title:
		Icon File:
		Accesories Enabled? Class Default
		Visible? Class Default
		Display Settings
			Visible at Design time? Yes
			Automatically Created at Runtime? Class Default
			Initial State: Class Default
			Maximizable? Class Default
			Minimizable? Class Default
			System Menu? Class Default
			Resizable? Class Default
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  13.25"
				Width Editable? Class Default
				Height: Class Default
				Height Editable? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: Class Default
			Text Color: Class Default
			Background Color: Class Default
			View: Class Default
			Allow Row Sizing? Class Default
			Lines Per Row: Class Default
		Memory Settings
			Maximum Rows in Memory: Class Default
			Discardable? Class Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Class Default
				Visible? Class Default
				Size: Class Default
				Size Editable? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
			Contents
				Pushbutton: pbIns
					Class Child Ref Key: 33
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? No
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbDel
					Class Child Ref Key: 34
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? No
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbUpdate
					Class Child Ref Key: 36
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? No
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				!
				Pushbutton: pbRefresh
					Class Child Ref Key: 35
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.083"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbFilter
					Class Child Ref Key: 44
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.517"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Click
							If SetQueryFilterEx(FCard)
								Call SalPostMsg(hWndForm, UM_Populate, 0, 0)
				Pushbutton: pbSearch
					Class Child Ref Key: 38
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.95"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.383"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 26944
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  4.733"
						Begin Y:  -0.024"
						End X:  4.733"
						End Y:  0.44"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbCustomer
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbBrowse
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.017"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\CUSTPERS.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Картка клієнта'
						On SAM_Click
							If colNd
								Call EditCustPersonEx(colRnk, CVIEW_Saldo | CVIEW_ReadOnly, hWndForm, 0, '', FALSE)
				Pushbutton: pbDetails
					Class Child Ref Key: 39
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.467"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Перегляд картки рахунку'
				Line
					Resource Id: 26945
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  2.983"
						Begin Y:  -0.024"
						End X:  2.983"
						End Y:  0.44"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbFormRequest
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.1"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\UNDO1.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Сформувати запит'
						On SAM_Click
							If colNd
								If FunNSIGet('v_ow_crv_request', 'name', sPk, sSem)
									If SalMessageBox("Сформувати запит на" || PutCrLf() || sSem || PutCrLf() || "для" || PutCrLf() || colNmk || "?", "Увага!", MB_IconQuestion | MB_YesNo) = IDYES
										Set nId = Val(sPk)
										If SqlPLSQLCommand(hSql(), 'bars_owcrv.form_request(nId,colNd)')
											Call SqlCommitEx(hSql(), "Сформовано запит на " || sSem || " для " || colNmk)
											Call SalMessageBox("Сформовано запит на" || PutCrLf() || sSem || PutCrLf() || "для" || PutCrLf() || colNmk, "Увага!", MB_IconAsterisk | MB_Ok)
										Else
											Call SqlRollback(hSql())
				Pushbutton: pbArcQuery
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.533"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\ADDRESS.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Архів запитів'
						On SAM_Click
							If colNd
								Call SalCreateWindow(tblCRVRequestHist, hWndMDI, colAcc, colNls, colNmk)
				Line
					Resource Id: 26947
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  4.067"
						Begin Y:  0.024"
						End X:  4.067"
						End Y:  0.488"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Pushbutton: pbExit
					Class Child Ref Key: 42
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.2"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 26946
					Class Child Ref Key: 43
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
		Contents
			Column: colNd
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Номер
						угоди
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  Default
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colBranch
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Відділення
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.4"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colAcc
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title:
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  Default
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colNls
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Рахунок
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.8"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colKv
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title:
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  Default
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colOst
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Залишок
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.6"
				Width Editable? Yes
				Format: Decimal
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colNmk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Клієнт
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  4.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colOkpo
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ЗКПО
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colRnk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: РНК
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colDaos
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						відкриття
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.2"
				Width Editable? Yes
				Format: Date
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
		Functions
		Window Parameters
		Window Variables
			: FCard
				Class: cGenFilterEx
			String: sPk
			String: sSem
			Number: nId
		Message Actions
			On SAM_Create
				Call SalSetWindowText(hWndForm, AppVersion || "Way4. Національні картки")
				Call PrepareWindowEx(hWndForm)
				Call SetWindowFullSize(hWndForm)
				Set hWndForm.tblLocalCard.nFlags = GT_ReadOnly
				Set hWndForm.tblLocalCard.strFilterTblName = 'w4_local_card'
				Set hWndForm.tblLocalCard.strPrintFileName = 'w4_local_card'
				Set hWndForm.tblLocalCard.strSqlPopulate =
						"select nd, branch, acc, nls, kv, daos, ostc/100, rnk, nmk, okpo
						   into :hWndForm.tblLocalCard.colNd, :hWndForm.tblLocalCard.colBranch,
						        :hWndForm.tblLocalCard.colAcc, :hWndForm.tblLocalCard.colNls,
						        :hWndForm.tblLocalCard.colKv, :hWndForm.tblLocalCard.colDaos,
						        :hWndForm.tblLocalCard.colOst, :hWndForm.tblLocalCard.colRnk,
						        :hWndForm.tblLocalCard.colNmk, :hWndForm.tblLocalCard.colOkpo
						   from w4_local_card
						  order by branch, nmk"
				Call SalSendClassMessage(SAM_Create, 0, 0)
				Call FCard.Init(strFilterTblName, strFilterTblName)
			On SAM_CreateComplete
				Call SalWaitCursor(FALSE)
				If SetQueryFilterEx(FCard)
					Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
				Else
					Call SalSendMsg(pbExit, SAM_Click, 0, 0)
			On UM_Populate
				If strSqlPopulate != ''
					Call SalWaitCursor(TRUE)
					Call SalTblDefineSplitWindow(hWndForm, 0, FALSE)
					Set strDSql = cQ.GetFullSQLStringEx(FCard)
					Call BindList.ActivateBinds()
					Call SalTblPopulate(hWndForm, cMain.hSql(), T(strDSql), nTabPopulateMethod)
					Call SalTblSetContext(hWndForm, 0)
					Call SalPostMsg(hWndForm, SAM_TblDoDetails, 0, 0)
					Call SalWaitCursor(FALSE)
			On SAM_DoubleClick
				If colNd
					Call OperWithAccountEx(AVIEW_ALL, colAcc, colRnk, ACCESS_READONLY, hWndForm, '')
	Table Window: tblCRVRequestHist
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title:
		Icon File:
		Accesories Enabled? Class Default
		Visible? Class Default
		Display Settings
			Visible at Design time? Yes
			Automatically Created at Runtime? Class Default
			Initial State: Class Default
			Maximizable? Class Default
			Minimizable? Class Default
			System Menu? Class Default
			Resizable? Class Default
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  13.167"
				Width Editable? Class Default
				Height: Class Default
				Height Editable? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: Class Default
			Text Color: Class Default
			Background Color: Class Default
			View: Class Default
			Allow Row Sizing? Class Default
			Lines Per Row: Class Default
		Memory Settings
			Maximum Rows in Memory: Class Default
			Discardable? Class Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Class Default
				Visible? Class Default
				Size: Class Default
				Size Editable? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
			Contents
				Pushbutton: pbIns
					Class Child Ref Key: 33
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbDel
					Class Child Ref Key: 34
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbRefresh
					Class Child Ref Key: 35
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbUpdate
					Class Child Ref Key: 36
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 27821
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbSearch
					Class Child Ref Key: 38
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbFilter
					Class Child Ref Key: 44
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbDetails
					Class Child Ref Key: 39
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 27822
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbExit
					Class Child Ref Key: 42
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 27823
					Class Child Ref Key: 43
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
		Contents
			Column: colRequestName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Запит
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  4.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colFileName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ім'я файлу
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colFileDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата файлу
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.8"
				Width Editable? Yes
				Format: DateTime
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colTickName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ім'я тікету
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colTickDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата тікету
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.8"
				Width Editable? Yes
				Format: DateTime
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colTickStatus
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Статус
						обробки файлу
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colRespClass
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Повідомлення
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colRespCode
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						повідомлення
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colRespText
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Текст повідомлення
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  4.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
		Functions
		Window Parameters
			Number: nAcc
			String: sNls
			String: sNmk
		Window Variables
		Message Actions
			On SAM_Create
				Call SalSetWindowText(hWndForm, AppVersion || "Way4. Архів запитів по рахунку " || sNls || " " || sNmk)
				Call PrepareWindowEx(hWndForm)
				Call SetWindowFullSize(hWndForm)
				Set hWndForm.tblCRVRequestHist.nFlags = GT_ReadOnly
				Set hWndForm.tblCRVRequestHist.strFilterTblName = 'v_ow_crvacc_request_history'
				Set hWndForm.tblCRVRequestHist.strPrintFileName = 'w4v_request_hist'
				Set hWndForm.tblCRVRequestHist.strSqlPopulate =
						"select request_name, file_name, file_date,
						        tick_name, tick_date, tick_status,
						        resp_class, resp_code, resp_text
						   into :hWndForm.tblCRVRequestHist.colRequestName, :hWndForm.tblCRVRequestHist.colFileName,
						        :hWndForm.tblCRVRequestHist.colFileDate, :hWndForm.tblCRVRequestHist.colTickName,
						        :hWndForm.tblCRVRequestHist.colTickDate, :hWndForm.tblCRVRequestHist.colTickStatus,
						        :hWndForm.tblCRVRequestHist.colRespClass, :hWndForm.tblCRVRequestHist.colRespCode,
						        :hWndForm.tblCRVRequestHist.colRespText
						   from v_ow_crvacc_request_history
						  where acc = :hWndForm.tblCRVRequestHist.nAcc
						  order by file_date desc"
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On UM_Populate
				Call SalSendClassMessage(UM_Populate, 0, 0)
				Call VisTblAutoSizeColumn(hWndForm, hWndNULL)
	Table Window: tblCMRequest
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title:
		Icon File:
		Accesories Enabled? Class Default
		Visible? Class Default
		Display Settings
			Visible at Design time? Yes
			Automatically Created at Runtime? Class Default
			Initial State: Class Default
			Maximizable? Class Default
			Minimizable? Class Default
			System Menu? Class Default
			Resizable? Class Default
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  Class Default
				Width Editable? Class Default
				Height: Class Default
				Height Editable? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: Class Default
			Text Color: Class Default
			Background Color: Class Default
			View: Class Default
			Allow Row Sizing? Class Default
			Lines Per Row: Class Default
		Memory Settings
			Maximum Rows in Memory: 64000
			Discardable? Class Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Class Default
				Visible? Class Default
				Size: Class Default
				Size Editable? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
			Contents
				Pushbutton: pbIns
					Class Child Ref Key: 33
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? No
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbUpdate
					Class Child Ref Key: 36
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? No
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				!
				Pushbutton: pbRefresh
					Class Child Ref Key: 35
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.083"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbFilter
					Class Child Ref Key: 44
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.517"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbSearch
					Class Child Ref Key: 38
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.917"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.383"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 62798
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  5.533"
						Begin Y:  -0.048"
						End X:  5.533"
						End Y:  0.417"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbCustomer
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbBrowse
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.017"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\CUSTPERS.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Картка клієнта'
						On SAM_Click
							If colRnk
								Select Case colClientType
									Case 1
										Call EditCustCorpsEx(colRnk, nCustFlags, hWndForm, 0, '', FALSE)
										Break
									Case 2
										Call EditCustPersonEx(colRnk, nCustFlags, hWndForm, 0, '', FALSE)
										Break
									Default
										Break
				Pushbutton: pbDetails
					Class Child Ref Key: 39
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.45"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Картковий рахунок'
				Pushbutton: pbArcQuery
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.9"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\ADDRESS.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Деталі запиту'
						On SAM_Click
							If colId
								Call FunNSIEditFFiltered('v_cm_client', 1, 'id=' || Str(colId))
				Line
					Resource Id: 62799
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  3.383"
						Begin Y:  -0.024"
						End X:  3.383"
						End Y:  0.44"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbDel
					Class Child Ref Key: 34
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.483"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Видалити запит'
						On SAM_Click
							Call DelReq()
							! If colId
								                                If colOperStatus = 1 or colOperStatus = 10
									                                If SalMessageBox("Видалити запит " || Str(colId) || PutCrLf() || colNls || " " || colName || "?", "Увага!", MB_IconQuestion | MB_YesNo) = IDYES
										                                If SqlPrepareAndExecute(hSql(), "delete from cm_client_que where id=:hWndForm.tblCMRequest.colId")
											                                Call SqlCommitEx(hSql(), "Видалено запит " || Str(colId))
											                                Call SalMessageBox("Видалено запит " || Str(colId) || PutCrLf() || colNls || " " || colName, "Повідомлення", MB_IconAsterisk | MB_Ok)
											                                Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
										                                Else
											                                Call SqlRollback(hSql())
				Pushbutton: pbUnFormStatus10
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.917"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\BACK.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Переформувати запит'
						On SAM_Click
							Call UnFormReq()
							! If colOperStatus = 1 or colOperStatus = 10
								                                If SalMessageBox("Переформувати запит для" || PutCrLf() || colNls || ' ' || colName || "?", "Увага!", MB_IconQuestion | MB_YesNo) = IDYES
									                                If SqlPLSQLCommand(hSql(), 'bars_ow.form_request(colId,NUMBER_Null)')
										                                Call SqlCommitEx(hSql(), "Переформовано запит для " || colNls || ' ' || colName)
										                                Call SalMessageBox("Переформовано запит для" || PutCrLf() || colNls || ' ' || colName, "Повідомлення", MB_IconAsterisk | MB_Ok)
										                                Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
									                                Else
										                                Call SqlRollback(hSql())
				Pushbutton: pbFormRequest
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.367"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\UNDO1.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Сформувати запит'
						On SAM_Click
							Call FormReq()
							! If colOperStatus = 1 or colOperStatus = 10
								                                If FunNSIGetFiltered('v_cm_opertype', 'name', 'clienttype is null or clienttype='||Str(colClientType), sPk, sSem)
									                                If SalMessageBox("Сформувати запит" || PutCrLf() || sSem || PutCrLf() || "для" || PutCrLf() || colNls || ' ' || colName || "?", "Увага!", MB_IconQuestion | MB_YesNo) = IDYES
										                                Set nOperType = Val(sPk)
										                                If SqlPLSQLCommand(hSql(), 'bars_ow.form_request(colId,nOperType)')
											                                Call SqlCommitEx(hSql(), "Сформовано запит" || sSem || " для " || colNls || ' ' || colName)
											                                Call SalMessageBox("Сформовано запит" || PutCrLf() || sSem || PutCrLf() || "для" || PutCrLf() || colNls || ' ' || colName, "Повідомлення", MB_IconAsterisk | MB_Ok)
											                                Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
										                                Else
											                                Call SqlRollback(hSql())
				Line
					Resource Id: 62801
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  4.867"
						Begin Y:  -0.036"
						End X:  4.867"
						End Y:  0.429"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Pushbutton: pbExit
					Class Child Ref Key: 42
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.983"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 62800
					Class Child Ref Key: 43
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
		Contents
			Column: colId
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ід.
						запиту
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colDateIn
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						запиту
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.8"
				Width Editable? Yes
				Format: DateTime
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colDateMod
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						обробки
						в CardMake
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.8"
				Width Editable? Yes
				Format: DateTime
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colOperStatus
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Статус
						запиту
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  Default
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colOperStatusName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Статус
						запиту
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  Default
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colOperType
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Тип
						операції
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  Default
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colOperTypeName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Тип
						операції
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  Default
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colRespTxt
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Опис помилки
				Visible? Yes
				Editable? No
				Maximum Data Length: 254
				Data Type: String
				Justify: Left
				Width:  2.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colNls
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Рахунок
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.8"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Клієнт
				Visible? Yes
				Editable? No
				Maximum Data Length: 254
				Data Type: String
				Justify: Left
				Width:  4.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colRnk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: РНК
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  Default
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colOkpo
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ЗКПО
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  Default
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colBranch
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Відділення
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.4"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colAcc
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ACC
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  Default
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colClientType
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: тип клиента
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  Default
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
		Functions
			Function: DelReq
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Number: nRow
				Actions
					If not SalTblAnyRows(hWndForm, ROW_Selected, 0)
						Call SalMessageBox("Не помічено жодного рядка!", "Увага!", MB_IconAsterisk | MB_Ok)
						Return TRUE
					! проверка
					Set nRow = TBL_MinRow
					While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
						Call SalTblSetContext(hWndForm, nRow)
						If colOperStatus != 1 and colOperStatus != 10
							Call SalMessageBox("Заборонено видаляти запити зі статусом '" || colOperStatusName || "'", "Повідомлення", MB_IconAsterisk | MB_Ok)
							Return TRUE
					If SalMessageBox("Видалити помічені запити?", "Увага!", MB_IconQuestion | MB_YesNo) = IDNO
						Return TRUE
					! Удаление
					Set nRow = TBL_MinRow
					While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
						Call SalTblSetContext(hWndForm, nRow)
						If colOperStatus = 1 or colOperStatus = 10
							If SqlPrepareAndExecute(hSql(), "delete from cm_client_que where id=:colId")
								Call SqlCommitEx(hSql(), "Видалено запит " || Str(colId))
							Else
								Call SqlRollbackEx(hSql(), "Помилка видалення запиту " || Str(colId))
					Call SalMessageBox("Запити видалено", "Повідомлення", MB_IconAsterisk | MB_Ok)
					Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
					Return TRUE
			Function: UnFormReq
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
				Actions
					If not SalTblAnyRows(hWndForm, ROW_Selected, 0)
						Call SalMessageBox("Не помічено жодного рядка!", "Увага!", MB_IconAsterisk | MB_Ok)
						Return TRUE
					! проверка
					Set nRow = TBL_MinRow
					While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
						Call SalTblSetContext(hWndForm, nRow)
						If colOperStatus != 1 and colOperStatus != 10
							Call SalMessageBox("Заборонено переформовувати запити зі статусом '" || colOperStatusName || "'", "Повідомлення", MB_IconAsterisk | MB_Ok)
							Return TRUE
					If SalMessageBox("Переформувати помічені запити?", "Увага!", MB_IconQuestion | MB_YesNo) = IDNO
						Return TRUE
					! Переформирование
					Set nRow = TBL_MinRow
					While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
						Call SalTblSetContext(hWndForm, nRow)
						If colOperStatus = 1 or colOperStatus = 10
							If SqlPLSQLCommand(hSql(), "bars_ow.form_request(colId,NUMBER_Null)")
								Call SqlCommitEx(hSql(), "Переформовано запит " || Str(colId))
							Else
								Call SqlRollbackEx(hSql(), "Помилка переформування запиту " || Str(colId))
					Call SalMessageBox("Запити переформовано", "Повідомлення", MB_IconAsterisk | MB_Ok)
					Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
					Return TRUE
			Function: FormReq
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Number: nOperType
					String: sPk
					String: sSem
				Actions
					If not SalTblAnyRows(hWndForm, ROW_Selected, 0)
						Call SalMessageBox("Не помічено жодного рядка!", "Увага!", MB_IconAsterisk | MB_Ok)
						Return TRUE
					! проверка
					Set nRow = TBL_MinRow
					While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
						Call SalTblSetContext(hWndForm, nRow)
						If colOperStatus != 1 and colOperStatus != 10
							Call SalMessageBox("Заборонено формовувати нові запити по запитам зі статусом '" || colOperStatusName || "'", "Повідомлення", MB_IconAsterisk | MB_Ok)
							Return TRUE
					! Выбор типа запроса
					If not FunNSIGetFiltered('v_cm_opertype', 'name', 'clienttype is null or clienttype='||Str(colClientType), sPk, sSem)
						Return TRUE
					If SalMessageBox("Сформувати нові запити '" || sSem || "' по помічених запитах?", "Увага!", MB_IconQuestion | MB_YesNo) = IDNO
						Return TRUE
					Set nOperType = Val(sPk)
					! Фомирование
					Set nRow = TBL_MinRow
					While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
						Call SalTblSetContext(hWndForm, nRow)
						If colOperStatus = 1 or colOperStatus = 10
							If SqlPLSQLCommand(hSql(), "bars_ow.form_request(colId,nOperType)")
								Call SqlCommitEx(hSql(), "Сформовано запит '" || sSem || "' для " || colNls || ' ' || colName)
							Else
								Call SqlRollbackEx(hSql(), "Помилка формування нового запиту '" || sSem || "' по запиту " || Str(colId))
					Call SalMessageBox("Запити сформовано", "Повідомлення", MB_IconAsterisk | MB_Ok)
					Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
					Return TRUE
		Window Parameters
			! nMode: 1-редактирование, 0-просмотр
			Number: nMode
			String: sFilter
		Window Variables
			String: strDynSql
			Number: nCustFlags
			Number: nAccAccess
		Message Actions
			On SAM_Create
				If nMode = 1
					Call SalSetWindowText(hWndForm, AppVersion || "Way4. Запити до CardMake")
					Set hWndForm.tblCMRequest.nFlags = GT_NoIns | GT_NoUpd
					Set nCustFlags = CVIEW_Saldo
					Set nAccAccess = ACCESS_FULL
				Else
					Call SalSetWindowText(hWndForm, AppVersion || "Way4. Запити до CardMake - перегляд")
					Set hWndForm.tblCMRequest.nFlags = GT_ReadOnly
					Call SalDisableWindow(pbUnFormStatus10)
					Call SalDisableWindow(pbFormRequest)
					Set nCustFlags = CVIEW_Saldo | CVIEW_ReadOnly
					Set nAccAccess = ACCESS_READONLY
				Call PrepareWindowEx(hWndForm)
				Call SetWindowFullSize(hWndForm)
				! Call SalTblSetTableFlags(hWndForm, TBL_Flag_SingleSelection, TRUE)
				Set hWndForm.tblCMRequest.strFilterTblName = 'v_cm_request'
				Set hWndForm.tblCMRequest.strPrintFileName = 'w4_request'
				Set hWndForm.tblCMRequest.fFilterAtStart = TRUE
				Set hWndForm.tblCMRequest.strSqlPopulate =
						"select id, datein, datemod, oper_status, operstatus_name,
						        oper_type, opertype_name, substr(resp_txt,1,254),
						        branch, clienttype, rnk, okpo, substr(name,1,254), acc, nls
						   into :hWndForm.tblCMRequest.colId, :hWndForm.tblCMRequest.colDateIn, :hWndForm.tblCMRequest.colDateMod,
						        :hWndForm.tblCMRequest.colOperStatus, :hWndForm.tblCMRequest.colOperStatusName,
						        :hWndForm.tblCMRequest.colOperType, :hWndForm.tblCMRequest.colOperTypeName, :hWndForm.tblCMRequest.colRespTxt,
						        :hWndForm.tblCMRequest.colBranch, :hWndForm.tblCMRequest.colClientType,
						        :hWndForm.tblCMRequest.colRnk, :hWndForm.tblCMRequest.colOkpo, :hWndForm.tblCMRequest.colName,
						        :hWndForm.tblCMRequest.colAcc, :hWndForm.tblCMRequest.colNls
						   from v_cm_request " || IifS(sFilter='', "", "where "||sFilter) || "
						  order by id desc"
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On UM_Populate
				Call SalSendClassMessage(UM_Populate, 0, 0)
				Call VisTblAutoSizeColumn(hWndForm, colOperStatusName)
				Call VisTblAutoSizeColumn(hWndForm, colOperTypeName)
				Call SalTblSetContext(hWndForm, 0)
				Call SalPostMsg(hWndForm, SAM_TblDoDetails, 0, 0)
			On SAM_FetchRowDone
				Select Case colOperStatus
					Case 1
						Call SetTblRowColor(hWndForm, COLOR_Blue)
						Break
					Case 2
						Call SetTblRowColor(hWndForm, COLOR_DarkGreen)
						Break
					Case 10
						Call SetTblRowColor(hWndForm, COLOR_Red)
						Break
					Default
						Break
			On SAM_TblDoDetails
				If nMode = 1
					If colOperStatus = 1 or colOperStatus = 10
						Call SalEnableWindow(pbDel)
						Call SalEnableWindow(pbUnFormStatus10)
						Call SalEnableWindow(pbFormRequest)
					Else
						Call SalDisableWindow(pbDel)
						Call SalDisableWindow(pbUnFormStatus10)
						Call SalDisableWindow(pbFormRequest)
			On SAM_DoubleClick
				If colAcc
					Call OperWithAccountEx(AVIEW_ALL, colAcc, colRnk, nAccAccess, hWndForm, '')
	Table Window: tblMigrPkToW4
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title:
		Icon File:
		Accesories Enabled? Class Default
		Visible? Class Default
		Display Settings
			Visible at Design time? Yes
			Automatically Created at Runtime? Class Default
			Initial State: Class Default
			Maximizable? Class Default
			Minimizable? Class Default
			System Menu? Class Default
			Resizable? Class Default
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  Class Default
				Width Editable? Class Default
				Height: Class Default
				Height Editable? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: Class Default
			Text Color: Class Default
			Background Color: Class Default
			View: Class Default
			Allow Row Sizing? Class Default
			Lines Per Row: Class Default
		Memory Settings
			Maximum Rows in Memory: Class Default
			Discardable? Class Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Class Default
				Visible? Class Default
				Size: Class Default
				Size Editable? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
			Contents
				Pushbutton: pbIns
					Class Child Ref Key: 33
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? No
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbDel
					Class Child Ref Key: 34
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? No
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbRefresh
					Class Child Ref Key: 35
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.083"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbFilter
					Class Child Ref Key: 44
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.517"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Click
							If SetQueryFilterEx(cF_Migr)
								Call SalPostMsg(hWndForm, UM_Populate, 0, 0)
				Pushbutton: pbSearch
					Class Child Ref Key: 38
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.95"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.383"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 43068
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  3.633"
						Begin Y:  0.0"
						End X:  3.633"
						End Y:  0.464"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbUpdate
					Class Child Ref Key: 36
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.0"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\CHEKIN.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Перевипуск карток'
				Pushbutton: pbRepay
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.45"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\UNDO1.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Перенесення залишку'
						On SAM_Click
							Call RepayCard()
				Pushbutton: pbDetails
					Class Child Ref Key: 39
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? No
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 43069
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  2.967"
						Begin Y:  0.0"
						End X:  2.967"
						End Y:  0.464"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbExit
					Class Child Ref Key: 42
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.1"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 43070
					Class Child Ref Key: 43
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Check Box: cbOtm
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Property Template:
					Class DLL Name:
					Title: Помітити всі
					Window Location and Size
						Left:   4.0"
						Top:    0.1"
						Width:  2.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_Click
							Call SetOtm(cbOtm)
		Contents
			Column: colOtm
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Помітити
				Visible? Class Default
				Editable? Class Default
				Maximum Data Length: Class Default
				Data Type: Number
				Justify: Class Default
				Width:  1.0"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Check Box
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value: 1
						Uncheck Value: 0
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colNd		! N Номер договора
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Номер
						угоди
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Number
				Justify: Class Default
				Width:  1.0"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colCardAcct	! S
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Технічний
						рахунок
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Class Default
				Justify: Left
				Width:  1.4"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
					On SAM_SetFocus
						Set sTmp = colCardAcct
					On SAM_AnyEdit
						Set colCardAcct = sTmp
						Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
			Column: colAcc		! N
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Acc
				Visible? No
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Number
				Justify: Class Default
				Width:  Class Default
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colNls		! S Номер счета
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Картковий
						рахунок
				Visible? Class Default
				Editable? Class Default
				Maximum Data Length: Class Default
				Data Type: Class Default
				Justify: Class Default
				Width:  1.8"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
					On SAM_SetFocus
						Set sTmp = colNls
					On SAM_AnyEdit
						Set colNls = sTmp
						Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
			Column: colKv		! N Код вал.
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Код
						вал.
				Visible? Class Default
				Editable? No
				Maximum Data Length: 3
				Data Type: Number
				Justify: Center
				Width:  0.6"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colOst		! N
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Залишок
						на картці
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Number
				Justify: Right
				Width:  1.6"
				Width Editable? Class Default
				Format: ###000
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colExpiry	! D
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Строк
						закінчення
						дії картки
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.2"
				Width Editable? Class Default
				Format: Date
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colRnk		! N Рег.номер клиента
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Реєстр.
						номер
						клієнта
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Number
				Justify: Right
				Width:  1.2"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colOkpo		! S ОКПО клиента
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: ЗКПО
						клієнта
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Class Default
				Justify: Class Default
				Width:  1.4"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colNmk		! S ФИО (наименование) клиента
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: ПІБ (назва)
						клієнта
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Class Default
				Justify: Class Default
				Width:  3.0"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colWorks	! S
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Місце
						роботи
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Class Default
				Justify: Class Default
				Width:  3.0"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colWOkpo	! S
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: ЗКПО
						організації
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Class Default
				Justify: Class Default
				Width:  1.4"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
			Column: colW4Nls	! S
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Рахунок
						Way4
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Class Default
				Justify: Class Default
				Width:  1.8"
				Width Editable? Class Default
				Format: Class Default
				Country: Class Default
				Input Mask: Class Default
				Cell Options
					Cell Type? Class Default
					Multiline Cell? Class Default
					Cell DropDownList
						Sorted? Class Default
						Vertical Scroll? Class Default
						Auto Drop Down? Class Default
						Allow Text Editing? Class Default
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Class Default
				List Values
				Message Actions
					On SAM_SetFocus
						Set sTmp = colW4Nls
					On SAM_AnyEdit
						Set colW4Nls = sTmp
						Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
		Functions
			Function: SetOtm
				Description:
				Returns
					Boolean:
				Parameters
					Boolean: bOtm
				Static Variables
				Local variables
				Actions
					Set nRow = TBL_MinRow
					While SalTblFindNextRow(hWndForm, nRow, 0, 0)
						Call SalTblSetContext(hWndForm, nRow)
						Set colOtm = bOtm
					Return TRUE
			Function: ReopenCard
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Boolean: bReopen
					Number: nRow
					String: sPk
					String: sSem
					String: sProductGrp
					Number: nSalaryProectCode
					String: sProductCode
					String: sCardCode
				Actions
					If not SqlPrepareAndExecute(hSql(), "delete from bpk_pktow4 where id=user_id")
						Call SqlRollback(hSql())
						Return FALSE
					Set bReopen = FALSE
					Set nRow = TBL_MinRow
					While SalTblFindNextRow(hWndForm, nRow, 0, 0)
						Call SalTblSetContext(hWndForm, nRow)
						If colOtm
							Set bReopen = TRUE
							Break
					If not bReopen
						Call SalMessageBox("Не відмічено жодного рядка", "Повідомлення", MB_IconStop | MB_Ok)
						Return TRUE
					If SalMessageBox("Виконати перевипуск відмічених карток?", "Питання", MB_IconQuestion | MB_YesNo) = IDNO
						Return TRUE
					! выбираем группу продуктов
					If FunNSIGetFiltered("w4_product_groups", "name", "", sPk, sSem)
						Set sProductGrp = sPk
						! выбираем З/П проект
						If FunNSIGetFiltered("v_bpk_proect", "product_code", "grp_code='" || sProductGrp || "'", sPk, sSem)
							Set nSalaryProectCode = Val(sPk)
							Set sProductCode = sSem
							! если для З/П проекта не указан продукт, выбираем из продуктов
							If sProductCode = ''
								If FunNSIGetFiltered("v_cm_product", "product_name", "product_code in (select code from w4_product where grp_code='" || sProductGrp || "')", sPk, sSem)
									Set sProductCode = sPk
								Else
									Return TRUE
							! выбираем карточку
							If FunNSIGetFiltered("w4_card", "sub_code", "product_code='" || sProductCode || "'", sPk, sSem)
								Set sCardCode = sPk
								Set nRow = TBL_MinRow
								While SalTblFindNextRow(hWndForm, nRow, 0, 0)
									Call SalTblSetContext(hWndForm, nRow)
									If colOtm
										If not SqlPrepareAndExecute(hSql(), "insert into bpk_pktow4(id,nd) values(user_id, :colNd)")
											Call SqlRollback(hSql())
											Return FALSE
								Call SalWaitCursor(TRUE)
								If not SqlPLSQLCommand(hSql(), "bars_ow.pk_reopen_card(sCardCode,nSalaryProectCode)")
									Call SqlRollback(hSql())
									Call SalWaitCursor(FALSE)
									Return FALSE
								Call SqlCommitEx(hSql(), "WAY4. Виконано перевипуск карток")
								Call SalWaitCursor(FALSE)
								Call SalMessageBox("Виконано перевипуск карток", "Повідомлення", MB_IconAsterisk | MB_Ok)
								Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
					Return TRUE
			Function: RepayCard
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Boolean: bRepay
					Number: nRow
				Actions
					Set bRepay = FALSE
					Set nRow = TBL_MinRow
					While SalTblFindNextRow(hWndForm, nRow, 0, 0)
						Call SalTblSetContext(hWndForm, nRow)
						If colOtm
							Set bRepay = TRUE
							Break
					If not bRepay
						Call SalMessageBox("Не відмічено жодного рядка", "Повідомлення", MB_IconStop | MB_Ok)
						Return TRUE
					If SalMessageBox("Виконати перенесення залишку для відмічених карток?", "Питання", MB_IconQuestion | MB_YesNo) = IDNO
						Return TRUE
					Call SalWaitCursor(TRUE)
					Set nRow = TBL_MinRow
					While SalTblFindNextRow(hWndForm, nRow, 0, 0)
						Call SalTblSetContext(hWndForm, nRow)
						If colOtm
							If not SqlPLSQLCommand(hSql(), "bars_ow.pk_repay_card(colNd)")
								Call SqlRollback(hSql())
								Call SalWaitCursor(FALSE)
								Return FALSE
					Call SqlCommitEx(hSql(), "WAY4. Виконано перенесення залишку")
					Call SalWaitCursor(FALSE)
					Call SalMessageBox("Виконано перенесення залишку", "Повідомлення", MB_IconAsterisk | MB_Ok)
					Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
					Return TRUE
		Window Parameters
		Window Variables
			: cF_Migr
				Class: cGenFilterEx
			String: sTmp
		Message Actions
			On SAM_Create
				Call SalSetWindowText(hWndForm, AppVersion || "Way4. Міграція картрахунків до Way4")
				Call PrepareWindowEx(hWndForm)
				Call SetWindowFullSize(hWndForm)
				Set hWndForm.tblMigrPkToW4.nFlags = GT_NoDel | GT_NoIns
				Set hWndForm.tblMigrPkToW4.strFilterTblName = 'obpc_w4'
				Set hWndForm.tblMigrPkToW4.strPrintFileName = 'obpc_w4'
				Set hWndForm.tblMigrPkToW4.fFilterAtStart = TRUE
				Set hWndForm.tblMigrPkToW4.nTabInstance   = 1
				Set hWndForm.tblMigrPkToW4.strSqlPopulate =
						"select nd, acc, nls, kv, ost, card_acct, expiry,
						        rnk, okpo, nmk, works, w_okpo, w4_nls
						   into :hWndForm.tblMigrPkToW4.colNd, :hWndForm.tblMigrPkToW4.colAcc, :hWndForm.tblMigrPkToW4.colNls,
						        :hWndForm.tblMigrPkToW4.colKv, :hWndForm.tblMigrPkToW4.colOst,
						        :hWndForm.tblMigrPkToW4.colCardAcct, :hWndForm.tblMigrPkToW4.colExpiry,
						        :hWndForm.tblMigrPkToW4.colRnk, :hWndForm.tblMigrPkToW4.colOkpo, :hWndForm.tblMigrPkToW4.colNmk,
						        :hWndForm.tblMigrPkToW4.colWorks, :hWndForm.tblMigrPkToW4.colWOkpo, :hWndForm.tblMigrPkToW4.colW4Nls
						   from obpc_w4
						  order by nd desc"
				Call cF_Migr.Init('obpc_w4', '')
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On UM_Populate
				If strSqlPopulate != ''
					If fFilterAtStart
						If SetQueryFilterEx(cF_Migr)
							Set fFilterAtStart = NOT fFilterAtStart
					If NOT fFilterAtStart
						Call SalWaitCursor(TRUE)
						Call SalTblDefineSplitWindow(hWndForm, 0, FALSE)
						Set strDSql = cQ.GetFullSQLStringEx(cF_Migr)
						Call BindList.ActivateBinds()
						Call SalTblPopulate(hWndForm, hSql(), strDSql, nTabPopulateMethod)
						Call SalTblSetContext(hWndForm, 0)
						Call SalPostMsg(hWndForm, SAM_TblDoDetails, 0, 0)
						Call SalWaitCursor(FALSE)
					Else
						Call SalDestroyWindow(hWndForm)
			On SAM_FetchRowDone
				If colOst < 0
					Set colOst = Abs(colOst)
					Call SalTblSetCellTextColor(colOst, COLOR_Red, FALSE)
			On UM_Update
				Call ReopenCard()
	Form Window: Dummy
		Class:
		Property Template:
		Class DLL Name:
		Title:
		Icon File:
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Automatically Created at Runtime? Yes
			Initial State: Normal
			Maximizable? Yes
			Minimizable? Yes
			System Menu? Yes
			Resizable? Yes
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  2.2"
				Width Editable? Yes
				Height: 0.452"
				Height Editable? Yes
			Form Size
				Width:  Default
				Height: Default
				Number of Pages: Dynamic
			Font Name: Default
			Font Size: Default
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Default
				Location? Top
				Visible? Yes
				Size: Default
				Size Editable? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Contents
		Contents
		Functions
		Window Parameters
		Window Variables
		Message Actions
			On SAM_Create
				Call SalCenterWindow(hWndForm)
	Form Window: frmCngImport
		Class:
		Property Template:
		Class DLL Name:
		Title:
		Icon File:
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Automatically Created at Runtime? Yes
			Initial State: Normal
			Maximizable? Yes
			Minimizable? Yes
			System Menu? Yes
			Resizable? Yes
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  2.2"
				Width Editable? Yes
				Height: 0.452"
				Height Editable? Yes
			Form Size
				Width:  Default
				Height: Default
				Number of Pages: Dynamic
			Font Name: Default
			Font Size: Default
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Default
				Location? Top
				Visible? Yes
				Size: Default
				Size Editable? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Contents
		Contents
			Pushbutton: cpbTimer
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cTimer
				Property Template:
				Class DLL Name:
				Title: timer
				Window Location and Size
					Left:   0.214"
					Top:    0.531"
					Width:  1.2"
					Width Editable? Yes
					Height: 0.292"
					Height Editable? Yes
				Visible? No
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Picture File Name:
				Picture Transparent Color: None
				Image Style: Single
				Text Color: Default
				Background Color: Default
				Message Actions
					On UM_TimerFired
						Call SqlPrepareAndExecute(hSql(),
								"select count(*), sum(decode(file_status,3,1,0))
								   into :nCount, :nErr
								   from ow_files
								  where file_type = 'CNGEXPORT'
								    and file_name in (" || sFileList || ")
								    and file_status <> 0")
						Call SqlFetchNext(hSql(), nFetchRes)
						If nCount = nFiles
							Call cpbTimer.Kill()
							Set sMsg = "Обробку файлів балансів завершено." || PutCrLf() ||
									    "Оброблено " || Str(nCount) || " файлів:" || PutCrLf() ||
									    IifS(nCount-nErr>0, "   " || Str(nCount-nErr) || " - успішно" || PutCrLf(), "") ||
									    IifS(nErr>0, "   " || Str(nErr) || " - з помилками", "")
							Call SaveInfoToLog("Way4. " || VisStrSubstitute(sMsg, PutCrLf(), " "))
							If nErr
								If SalMessageBox(sMsg || PutCrLf() || "Перегланути протокол обробки файлів?", "Повідомлення", MB_IconAsterisk | MB_YesNo) = IDYES
									Call OpenWay(hWndForm, 1, 0, 0, '', '')
							Else
								Call SalMessageBox(sMsg, "Повідомлення", MB_IconAsterisk)
							Call SalDestroyWindow(hWndForm)
		Functions
		Window Parameters
			Number: nFiles
			String: sFileList
		Window Variables
			Number: nCount
			Number: nErr
			String: sMsg
		Message Actions
			On SAM_Create
				Call SalHideWindow(hWndForm)
			On SAM_CreateComplete
				Call SalMessageBox("Розпочато обробку файлів балансів." || PutCrLf() || "Для звірки балансів дочекайтесь повідомлення.", "Повідомлення", MB_IconAsterisk)
				Call SaveInfoToLog("Way4. Розпочато обробку файлів балансів.")
				Call cpbTimer.Init(5, 0, TRUE)
	Form Window: frmW4CardInstant
		Class:
		Property Template:
		Class DLL Name:
		Title:
		Icon File:
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Automatically Created at Runtime? Yes
			Initial State: Normal
			Maximizable? Yes
			Minimizable? Yes
			System Menu? Yes
			Resizable? Yes
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  9.2"
				Width Editable? Yes
				Height: 4.0"
				Height Editable? Yes
			Form Size
				Width:  Default
				Height: Default
				Number of Pages: Dynamic
			Font Name: Default
			Font Size: Default
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Default
				Location? Top
				Visible? Yes
				Size: Default
				Size Editable? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Contents
		Contents
			! Group Box: Картка
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    0.05"
					Width:  8.6"
					Width Editable? Yes
					Height: 5.2"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
.end
			Frame
				Resource Id: 59052
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    0.1"
					Width:  8.6"
					Width Editable? Yes
					Height: 3.3"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Solid
				Border Thickness: 1
				Border Color: Default
				Background Color: Default
			!
			Background Text: Продукт
				Resource Id: 59053
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    0.3"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Combo Box: cmbProduct
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_StrId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   2.5"
					Top:    0.25"
					Width:  5.45"
					Width Editable? Class Default
					Height: 3.357"
					Height Editable? Class Default
				Visible? Class Default
				Editable? Class Default
				String Type: Class Default
				Maximum Data Length: Class Default
				Sorted? Class Default
				Always Show List? Class Default
				Vertical Scroll? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Input Mask: Class Default
				List Initialization
				Message Actions
					On SAM_Create
						If cmbProduct.Init(hWndItem)
							Call cmbProduct.Populate(hSql(), "code", "name", "w4_product", "where grp_code = 'INSTANT' and nvl(date_close,bankdate+1)>bankdate order by name")
					On SAM_Click
						Call SalSendClassMessage(SAM_Click, 0, 0)
						Set sProductId = cmbProduct.strCurrentId
						! Call ClearField(2)
						Call SqlPrepareAndExecute(hSql(),
								"select t.kv, t.lcv, t.name, p.nbs
								   into :nKv, :sLcv, :dfCurrencyName, :dfNbs
								   from w4_product p, tabval t
								  where p.code = :sProductId
								    and p.kv = t.kv")
						Call SqlFetchNext(hSql(), nFetchRes)
						Set sCardType = STRING_Null
						! Call SalEnableWindow(cmbCardType)
						Call SalListSetSelect(cmbCardType, -1)
						Call SalSendMsg(cmbCardType, SAM_DoInit, 0, 0)
			!
			Background Text: Тип картки
				Resource Id: 59054
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    0.6"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Combo Box: cmbCardType
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_StrId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   2.5"
					Top:    0.55"
					Width:  5.45"
					Width Editable? Class Default
					Height: 3.357"
					Height Editable? Class Default
				Visible? Class Default
				Editable? Class Default
				String Type: Class Default
				Maximum Data Length: Class Default
				Sorted? Class Default
				Always Show List? Class Default
				Vertical Scroll? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Input Mask: Class Default
				List Initialization
				Message Actions
					On SAM_DoInit
						If cmbCardType.Init(hWndItem)
							Call cmbCardType.Populate(hSql(), "code", "sub_name", "v_w4_card", "where product_code='" || sProductId || "' order by code")
					On SAM_Click
						Call SalSendClassMessage(SAM_Click, 0, 0)
						Set sCardType = cmbCardType.strCurrentId
			!
			! Background Text: Відділення
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    0.9"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
.end
			! Data Field: dfBranch
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    0.85"
						Width:  5.45"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
.end
				                                              Message Actions
			! Data Field: dfBranchName
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    1.15"
						Width:  5.45"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
.end
				                                              Message Actions
			! ctb_pbFilter: pbBranch
.winattr class Pushbutton:
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbFilter
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   8.0"
					Top:    0.8"
					Width:  0.4"
					Width Editable? Yes
					Height: 0.317"
					Height Editable? Yes
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Default
				Picture File Name: \BARS98\RESOURCE\BMP\Filter.bmp
				Picture Transparent Color: Gray
				Image Style: Single
				Text Color: Default
				Background Color: Default
.end
				                                              Message Actions
					                                              On SAM_TooltipSetText
						                                              Return XSalTooltipSetText(lParam, 'Відділення')
					                                              On SAM_Click
						! FunNSIGetFiltered("branch", "name", "", sPK, sSem)
						                                              If FunNSIGetFiltered("our_branch", "name", "length(branch)>=15", sPK, sSem)
							                                              Set dfBranch = sPK
							                                              Set dfBranchName = sSem
			!
			Background Text: Кількість карток
				Resource Id: 59056
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    0.9"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfCount
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 4
					Data Type: Number
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    0.85"
						Width:  1.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_Validate
						If not SalIsNull(dfCount)
							If dfCount < 1 or dfCount > 1000
								Call SalMessageBox("Вказана кількість карток не відповідає дозволеному діапазону (від 1 до 1000)!", "Увага!", MB_IconExclamation | MB_Ok)
								Return VALIDATE_Cancel
						Return VALIDATE_Ok
			!
			Background Text: Валюта
				Resource Id: 59057
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    2.0"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfCurrencyName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    1.95"
						Width:  5.45"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			!
			Background Text: Балансовий рахунок
				Resource Id: 59058
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    1.7"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfNbs
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    1.65"
						Width:  0.95"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Center
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			!
			Line
				Resource Id: 59059
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Coordinates
					Begin X:  0.1"
					Begin Y:  1.5"
					End X:  8.6"
					End Y:  1.5"
				Visible? Yes
				Line Style: Etched
				Line Thickness: 1
				Line Color: Default
			Line
				Resource Id: 59060
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Coordinates
					Begin X:  0.1"
					Begin Y:  2.6"
					End X:  8.6"
					End Y:  2.6"
				Visible? Yes
				Line Style: Etched
				Line Thickness: 1
				Line Color: Default
			Pushbutton: pbOk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbOk
				Property Template:
				Class DLL Name:
				Title: Відкрити
				Window Location and Size
					Left:   5.45"
					Top:    2.75"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name:
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						If not OpenInstantCards()
							Return FALSE
						Call SalDestroyWindow(hWndForm)
			Pushbutton: pbCancel
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title: Відмінити
				Window Location and Size
					Left:   6.7"
					Top:    2.75"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name:
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						Call SalDestroyWindow(hWndForm)
		Functions
			Function: OpenInstantCards
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
				Actions
					If sProductId = STRING_Null
						Call SalMessageBox("Не вибрано продукт!", "Увага!", MB_IconExclamation | MB_Ok)
						Call SalSetFocus(cmbProduct)
						Return FALSE
					If sCardType = STRING_Null
						Call SalMessageBox("Не вибрано картку!", "Увага!", MB_IconExclamation | MB_Ok)
						Call SalSetFocus(cmbCardType)
						Return FALSE
					! If dfBranch = STRING_Null
						                                              Call SalMessageBox("Не вибрано відділення!", "Увага!", MB_IconExclamation | MB_Ok)
						                                              Call SalSetFocus(pbBranch)
						                                              Return FALSE
					If dfCount = NUMBER_Null
						Call SalMessageBox("Не заповнено кількість карток!", "Увага!", MB_IconExclamation | MB_Ok)
						Call SalSetFocus(dfCount)
						Return FALSE
					If not SqlPLSQLCommand(hSql(), "bars_ow.create_instant_cards(sCardType, sBranch, dfCount)")
						Call SqlRollback(hSql())
						Return FALSE
					Call SqlCommitEx(hSql(), "WAY4. Створено " || Str(dfCount) || " запитів на миттєві картки")
					Call SalMessageBox("Створено " || Str(dfCount) || " запитів на миттєві картки", "Повідомлення", MB_IconAsterisk | MB_Ok)
					Return TRUE
		Window Parameters
		Window Variables
			String: sProductId
			String: sCardType
			Number: nKv
			String: sLcv
			String: sPK
			String: sSem
			! String: sOurBranch
			String: sBranch
		Message Actions
			On SAM_Create
				Call SalSetWindowText(hWndForm, AppVersion || "Way4. Запит на миттєві картки")
				Call PrepareWindowEx(hWndForm)
				! Set sOurBranch = GetValueStr("select substr(sys_context('bars_context','user_branch'), 1, 30) from dual")
				! Для ГРЦ dfBranch = 0
				! If sOurBranch = ''
					                                              Set dfBranch = '0'
					                                              Call SalDisableWindow(pbBranch)
					                                              If SqlPrepareAndExecute(hSql(), "select name into :dfBranchName from our_branch where branch = :dfBranch")
						                                              Call SqlFetchNext(hSql(), nFetchRes)
				Set sBranch = GetValueStr("select substr(sys_context('bars_context','user_branch'), 1, 8) from dual")
				! Для ГРЦ dfBranch = 0
				If sBranch = ''
					Set sBranch = '0'
	Table Window: tblImportFFiles
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Way4. Імпорт файлів F*.xml, формування файлів для ФГ
		Icon File:
		Accesories Enabled? Class Default
		Visible? Class Default
		Display Settings
			Visible at Design time? Yes
			Automatically Created at Runtime? Class Default
			Initial State: Class Default
			Maximizable? Class Default
			Minimizable? Class Default
			System Menu? Class Default
			Resizable? Class Default
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  14.5"
				Width Editable? Class Default
				Height: 6.2"
				Height Editable? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: Class Default
			Text Color: Class Default
			Background Color: Class Default
			View: Class Default
			Allow Row Sizing? Class Default
			Lines Per Row: Class Default
		Memory Settings
			Maximum Rows in Memory: 20000
			Discardable? Class Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Class Default
				Visible? Class Default
				Size: Class Default
				Size Editable? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
			Contents
				Pushbutton: pbIns
					Class Child Ref Key: 33
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? No
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbDel
					Class Child Ref Key: 34
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? No
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbUpdate
					Class Child Ref Key: 36
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? No
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbDetails
					Class Child Ref Key: 39
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.4"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? No
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				!
				Pushbutton: pbRefresh
					Class Child Ref Key: 35
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.1"
						Top:    0.07"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbFilter
					Class Child Ref Key: 44
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.55"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbSearch
					Class Child Ref Key: 38
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.0"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.45"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 38757
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  3.275"
						Begin Y:  -0.024"
						End X:  3.275"
						End Y:  0.44"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbImpExp
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.1"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \bars98\RESOURCE\BMP\EXECUTE.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Прийняти файли F, сформуваи файли J, FG'
						On SAM_Click
							Call ImportExportFiles()
				! ctb_pbOk: pbExport
.winattr class Pushbutton:
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.6"
						Top:    0.071"
						Width:  0.43"
						Width Editable? No
						Height: 0.317"
						Height Editable? No
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: Default
					Font Size: Default
					Font Enhancement: None
					Picture File Name: \bars98\RESOURCE\BMP\TOMAIL.BMP
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
.end
					                                                           Message Actions
						                                                           On SAM_Create
							                                                           Set strTip = 'Сформувати файли'
						                                                           On SAM_Click
							                                                           Call ExportFiles()
				Line
					Resource Id: 38758
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  2.625"
						Begin Y:  -0.024"
						End X:  2.625"
						End Y:  0.44"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbExit
					Class Child Ref Key: 42
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.75"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 38759
					Class Child Ref Key: 43
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  1.975"
						Begin Y:  0.012"
						End X:  1.975"
						End Y:  0.476"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
		Contents
			Column: colInstNum
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Номер
						інституту
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colFileName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ім'я
						файла
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colFileDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						імпорту
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  2.0"
				Width Editable? Yes
				Format: DateTime
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colFileStatus
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Статус
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colComment
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Статус
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  4.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colRepDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						звіту
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.6"
				Width Editable? Yes
				Format: Date
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			! Column: colFgFileExt
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: colFgFileExt
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Center
				Width:  1.2"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
.end
				                                                                         List Values
				                                                                         Message Actions
			Column: colJFileName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ім'я
						файла J
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colFgFileName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ім'я
						файла FG
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
		Functions
			Function: ImportExportFiles
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Number: nFiles
					String: smFile[*]
					String: sFileList
					Number: i
				Actions
					Call SaveInfoToLog("Way4. Выполнение процедуры импорта файлов F / формирования файлов J, FG")
					! Смотрим в каталог импорта
					If sPathImport = ''
						Call SalMessageBox("Не описано каталог для імпорту файлів " || sFileMask, "Увага!", MB_IconStop | MB_Ok)
						Call SaveInfoToLog("Way4. Не описано каталог для імпорту файлів " || sFileMask)
						Return FALSE
					! Смотрим в каталог экспорта
					If sPathExport = ''
						Call SalMessageBox("Не описано каталог для екпорту файлів", "Увага!", MB_IconStop | MB_Ok)
						Call SaveInfoToLog("Way4. Не описано каталог для екпорту файлів")
						Return FALSE
					If not VisDosExist(sPathExport)
						Call SalMessageBox("Вказано неіснуючий каталог для екпорту файлів: " || sPathExport, "Увага!", MB_IconStop | MB_Ok)
						Call SaveInfoToLog("WAY4. Вказано неіснуючий каталог для екпорту файлів: " || sPathExport)
						Return FALSE
					!
					Set nFiles = VisDosEnumFiles(sPathImport || '\\' || sFileMask, FA_Standard, smFile)
					! Если файлов для импорта нет - выходим
					If nFiles < 0
						Call SaveInfoToLog("Way4. Відсутні файли для імпорта в " || sPathImport)
						If SalMessageBox("Відсутні файли для імпорта в " || sPathImport || PutCrLf() ||
								"Виконати формування файлів J, FG по існуючим даним?", "Увага!", MB_IconAsterisk | MB_YesNo) = IDNO
							Return FALSE
						Call ExportFiles()
					Else
						Call SaveInfoToLog("Way4. " || Str(nFiles) || " файлов для импорта в каталоге " || sPathImport)
						Set sFileList = ''
						Set i = 0
						While i < nFiles
							Set sFileList = sFileList || PutCrLf() || "  " || smFile[i]
							Set i = i + 1
						If SalMessageBox("Виконати імпорт файлів з " || sPathImport || " ?" || sFileList, "Увага!", MB_IconQuestion | MB_YesNo) = IDNO
							Call SaveInfoToLog("Way4. Пользователь отказался от импорта файлов")
							Return FALSE
						Call ImportFiles(nFiles, smFile)
					Call SaveInfoToLog("Way4. Выполнение процедуры импорта файлов F / формирования файлов J, FG завершено")
					Return TRUE
			Function: ImportFiles
				Description:
				Returns
					Boolean:
				Parameters
					Number: nFiles
					String: smFile[*]
				Static Variables
				Local variables
					String: sFileName
					Date/Time: dFileDate
					Number: i
					Number: nRow
					Number: nFilesCount
					Number: nInstNum
				Actions
					Call SaveInfoToLog("Way4. Импорт файлов")
					Call SalHideWindow(colJFileName)
					Call SalHideWindow(colFgFileName)
					! Смотрим в каталог импорта
					! If sPathImport = ''
						                                                           Call SalMessageBox("Не описано каталог для імпорту файлів " || sFileMask, "Увага!", MB_IconStop | MB_Ok)
						                                                           Call SaveInfoToLog("Way4. Не описано каталог для імпорту файлів " || sFileMask)
						                                                           Return FALSE
					! Set nFiles = VisDosEnumFiles(sPathImport || '\\' || sFileMask, FA_Standard, smFile)
					! Если файлов для импорта нет - выходим
					! If nFiles < 0
						                                                           Call SalMessageBox("Відсутні файли для імпорта в " || sPathImport, "Увага!", MB_IconStop | MB_Ok)
						                                                           Call SaveInfoToLog("Way4. Відсутні файли для імпорта в " || sPathImport)
						                                                           Return FALSE
					! Else
						                                                           Call SaveInfoToLog("Way4. " || Str(nFiles) || " файлов для импорта в каталоге " || sPathImport)
						                                                           Set sFileList = ''
						                                                           Set i = 0
						                                                           While i < nFiles
							                                                           Set sFileList = sFileList || PutCrLf() || "  " || smFile[i]
							                                                           Set i = i + 1
						                                                           If SalMessageBox("Виконати імпорт файлів з " || sPathImport || " ?" || sFileList, "Увага!", MB_IconQuestion | MB_YesNo) = IDNO
							                                                           Call SaveInfoToLog("Way4. Пользователь отказался от импорта файлов")
							                                                           Return FALSE
					! Импорт файлов
					Call SalWaitCursor(TRUE)
					Set nFilesCount = 0
					Set i = 0
					While i < nFiles
						Set nFilesCount = nFilesCount + 1
						Set sFileName = SalStrUpperX(smFile[i])
						Set nInstNum  = Val(Subs(sFileName, 2, 3))
						Call ImportFile(sPathImport, sFileName, nInstNum)
						Set i = i + 1
					Call SalWaitCursor(FALSE)
					Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
					If nFilesCount
						! Call SalMessageBox("Оброблено " || Str(nFilesCount) || " файлів", "Інформація", MB_IconAsterisk | MB_Ok)
						Call MessageNoWait("Оброблено " || Str(nFilesCount) || " файлів", "Інформація", 3, 0)
						Call SalTblSetContext(hWndForm, 0)
						Call SalSendMsg(hWndForm, SAM_TblDoDetails, 0, 0)
					Call ExportFiles()
					Return TRUE
			Function: ImportFile
				Description:
				Returns
					Boolean:
				Parameters
					! String: sPatch
					String: sFilePath
					String: sFileName
					Number: nInstNum
				Static Variables
				Local variables
					! String: sDrive
					! String: sDir
					! String: sFile
					! String: sExt
					! String: sFilePath
					! String: sFileName
					! String: sErrMsg
					Number: nErrCode
					! Number: nCountNd
					! Number: nCountErr
				Actions
					! Импорт файла во временную таблицу
					! If not PutFileToClob(hSql(), sFilePath || '\\' || sFileName, 'ow_inst', 'inst_num', 'f_file_body', nInstNum, STRING_Null, STRING_Null, 0)
						                                                      If not SqlPLSQLCommand(hSql(), "bars_ow.set_filestatus(nInstNum, sFilename, 0, STRING_Null, DATETIME_Null)")
							                                                      Call SqlRollback(hSql())
							                                                      Return FALSE
						                                                      If not SqlCommit(hSql())
							                                                      Return FALSE
						                                                      Return FALSE
					! If not SqlPLSQLCommand(hSql(), "bars_ow.set_filestatus(nInstNum, sFileName, 1, STRING_Null, DATETIME_Null)")
						                                                      Call SqlRollback(hSql())
						                                                      Return FALSE
					! If not SqlCommit(hSql())
						                                                      Return FALSE
					!
					! Чистим таблицу
					If not SqlPrepareAndExecute(hSql(), "delete from ow_impfile where id = " || Str(F_ImpId))
						Call SqlRollback(hSql())
						Return FALSE
					If not SqlCommit(hSql())
						Return FALSE
					! Импорт файла во временную таблицу
					Call UploadWay4Xml(SalWindowHandleToNumber(hWndForm), 'Завантаження файлу', sFileName,
							     SqlDatabase, SqlUser, SqlPassword,
							     'OW', F_ImpId, sFilePath || Chr(92) || sFileName)
					Call SaveInfoToLog("Way4. Файл " || sFileName || " помещен в БД")
					!
					If not SqlPLSQLCommand(hSql(), "bars_ow.set_filestatus(nInstNum, sFileName, 1, STRING_Null, DATETIME_Null)")
						! Call SqlRollback(hSql())
						! Return FALSE
					If not SqlCommit(hSql())
						! Return FALSE
					!
					! Обработка файла
					If not SqlPLSQLCommand(hSql(), "bars_ow.import_f_file(sFileName)")
						Call SqlRollback(hSql())
						Return FALSE
					Call SqlCommit(hSql())
					! Помещаем файл в архив
					Call OW_BackUpFile(sFilePath, sFileName, sPathBackUp)
					Return TRUE
			Function: ExportFiles
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Boolean: bRet
					String: sFileName
					String: sFullName
					String: sFileList
					Number: nInstNum
					String: sJFileName
					String: sFgFileName
				Actions
					Call SaveInfoToLog("Way4. Экспорт файлов")
					! Смотрим в каталог экспорта
					! If sPathExport = ''
						                                                           Call SalMessageBox("Не описано каталог для екпорту файлів", "Увага!", MB_IconStop | MB_Ok)
						                                                           Call SaveInfoToLog("Way4. Не описано каталог для екпорту файлів")
						                                                           Return FALSE
					! If not VisDosExist(sPathExport)
						                                                           Call SalMessageBox("Вказано неіснуючий каталог для екпорту файлів: " || sPathExport, "Увага!", MB_IconStop | MB_Ok)
						                                                           Call SaveInfoToLog("WAY4. Вказано неіснуючий каталог для екпорту файлів: " || sPathExport)
						                                                           Return FALSE
					!
					Call SalWaitCursor(TRUE)
					! формируем данные для файлов
					If not SqlPLSQLCommand(hSql(), "bars_ow.form_fg_files(sFileName)")
						Call SqlRollback(hSql())
						Return FALSE
					Call SqlCommit(hSql())
					!
					Set bRet = TRUE
					Set sFileList = ''
					Call SqlPrepareAndExecute(hSql(),
							"select inst_num, j_file_name, fg_file_name
							   into :nInstNum, :sJFileName, :sFgFileName
							   from ow_inst
							  where j_file_name is not null
							     or fg_file_name is not null")
					While SqlFetchNext(hSql(), nFetchRes)
						If sJFileName
							Set sFullName = sPathExport || '\\' || sJFileName
							If not PutClobToFile(hSqlAux(), sFullName, 'OW_INST', 'inst_num', 'J_FILE_BODY', nInstNum, STRING_Null, STRING_Null)
								Set bRet = FALSE
								Call SalMessageBox('Помилка формування файлу', 'Помилка', MB_IconStop | MB_Ok)
								Call SaveInfoToLog("WAY4. Помилка формування файлу")
								Break
							Set sFileList = sFileList || PutCrLf() || sFullName
						If sFgFileName
							Set sFullName = sPathExport || '\\' || sFgFileName
							If not PutClobToFile(hSqlAux(), sFullName, 'OW_INST', 'inst_num', 'FG_FILE_BODY', nInstNum, STRING_Null, STRING_Null)
								Set bRet = FALSE
								Call SalMessageBox('Помилка формування файлу', 'Помилка', MB_IconStop | MB_Ok)
								Call SaveInfoToLog("WAY4. Помилка формування файлу")
								Break
							Set sFileList = sFileList || PutCrLf() || sFullName
					!
					Call SalWaitCursor(FALSE)
					Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
					Call SalShowWindow(colJFileName)
					Call SalShowWindow(colFgFileName)
					If sFileList
						Call SaveInfoToLog("Way4. Сформовано файли " || sFileList)
						Call SalMessageBox("Сформовано файли " || sFileList, "Інформація", MB_IconAsterisk | MB_Ok)
					Else
						Call SaveInfoToLog("Way4. Файли НЕ сформовано")
						Call SalMessageBox("Файли НЕ сформовано", "Інформація", MB_IconAsterisk | MB_Ok)
					Return bRet
		Window Parameters
		Window Variables
			String: sPathImport
			String: sPathExport
			String: sPathBackUp
			String: sFileMask
		Message Actions
			On SAM_Create
				Call SalSetWindowText(hWndForm, AppVersion || "Way4. Імпорт файлів F*.xml, формування файлів для ФГ")
				Call SetWindowFullSize(hWndForm)
				Call PrepareWindowEx(hWndForm)
				Call SalHideWindow(colJFileName)
				Call SalHideWindow(colFgFileName)
				Set sFileMask   = 'F*.xml'
				Set sPathImport = GetValueStr("select substr(val,1,100) from ow_params where par = 'FFILE_IN'")
				Set sPathExport = GetValueStr("select substr(val,1,100) from ow_params where par = 'FFILE_OUT'")
				Set sPathBackUp = GetValueStr("select substr(val,1,100) from ow_params where par = 'FFILE_BACK'")
				Set hWndForm.tblImportFFiles.nFlags = GT_ReadOnly
				Set hWndForm.tblImportFFiles.strFilterTblName = "ow_inst"
				Set hWndForm.tblImportFFiles.strSqlPopulate =
						"select inst_num, f_file_name, f_file_date, f_file_status,
						        f_file_error, f_rep_date, j_file_name, fg_file_name
						   into :hWndForm.tblImportFFiles.colInstNum, :hWndForm.tblImportFFiles.colFileName,
						        :hWndForm.tblImportFFiles.colFileDate, :hWndForm.tblImportFFiles.colFileStatus,
						        :hWndForm.tblImportFFiles.colComment, :hWndForm.tblImportFFiles.colRepDate,
						        :hWndForm.tblImportFFiles.colJFileName, :hWndForm.tblImportFFiles.colFgFileName
						   from ow_inst
						  order by inst_num"
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On UM_Populate
				Call ReInitQueryString()
				Call SalSendClassMessage(UM_Populate, 0, 0)
				! Call SalHideWindow(colComment)
			On SAM_FetchRowDone
				If colFileStatus != NUMBER_Null
					Select Case colFileStatus
						Case 0
							Set colComment = 'Помилка завантаження файлу'
							! Call XSalTblSetRowBackColor(hWndForm, lParam, SalColorFromRGB(255,190,190))
							Call XSalTblSetRowBackColor(hWndForm, nRow, COLOR_Salmon)
							Break
						Case 1
							Set colComment = 'Файл внесено до БД'
							Break
						Case 2
							Set colComment = 'Помилка обробки файлу: ' || colComment
							! Call XSalTblSetRowBackColor(hWndForm, lParam, SalColorFromRGB(255,190,190))
							Call XSalTblSetRowBackColor(hWndForm, nRow, COLOR_Salmon)
							Break
						Case 3
							Set colComment = 'Файл оброблено'
							Break
						Default
							Break
	Dialog Box: dlgPrintAnketa
		Class:
		Property Template:
		Class DLL Name:
		Title: Печать...
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  4.8"
				Width Editable? Yes
				Height: 3.55"
				Height Editable? Yes
			Absolute Screen Location? Yes
			Font Name: Default
			Font Size: Default
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description:
		Tool Bar
			Display Settings
				Display Style? Default
				Location? Top
				Visible? Yes
				Size: Default
				Size Editable? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Contents
		Contents
			Picture: pic1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   0.2"
					Top:    0.15"
					Width:  4.3"
					Width Editable? Yes
					Height: 2.0"
					Height Editable? Yes
				Visible? Yes
				Editable? No
				File Name:
				Storage: External
				Picture Transparent Color: None
				Fit: Scale
				Scaling
					Width:  100
					Height:  100
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Tile To Parent? No
				Border Color: 3D Shadow Color
				Background Color: 3D Face Color
				Message Actions
			Background Text: Выберите дату
				Resource Id: 52535
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.3"
					Top:    0.05"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: Default
				Font Size: 10
				Font Enhancement: Bold
				Text Color: 3D Shadow Color
				Background Color: Default
			Data Field: bgCalendar
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cLabelControl
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Class Default
					Data Type: Class Default
					Editable? Class Default
				Display Settings
					Window Location and Size
						Left:   Default
						Top:    Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Justify: Class Default
					Format: Class Default
					Country: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
				Message Actions
			Custom Control: cCalendar
.data CLASSPROPSSIZE
0000: 4200
.enddata
.data CLASSPROPS
0000: 56543A43616C656E 646172436F6D626F 426F78002B000100 0000010101010000
0020: 0200000001010101 0101000000000000 01000000000A6464 2F4D4D2F79797979
0040: 0000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cCalendarDropDown
				Property Template:
				Class DLL Name:
				Display Settings
					DLL Name:
					MS Windows Class Name:
					Style:  Class Default
					ExStyle:  Class Default
					Title:
					Window Location and Size
						Left:   0.5"
						Top:    0.3"
						Width:  3.7"
						Width Editable? Class Default
						Height: 0.3"
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Etched Border? Class Default
					Hollow? Class Default
					Vertical Scroll? Class Default
					Horizontal Scroll? Class Default
					Tab Stop? Class Default
					Tile To Parent? Class Default
					Font Name: Class Default
					Font Size: 12
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					DLL Settings
				Message Actions
					On SAM_Create
						Call GetMonthArray(strMonth)
						Call GetWeekDayArray(strWeekDays)
						Call cCalendar.SetMonthText(strMonth)
						Call cCalendar.SetWeekDayText(strWeekDays)
						! ! - - - - - - - - - - - - Инициализация дат календаря  cCalendarFrom - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - -
						Call cCalendar.SpecialDate(SPECIAL_Weekly, DATETIME_Null, DAY_Sunday, SEQ_Unset,  COLOR_Black, COLOR_Gray, TRUE)
						Call cCalendar.SpecialDate(SPECIAL_Weekly, DATETIME_Null, DAY_Monday, SEQ_Unset, COLOR_Black, COLOR_Gray, TRUE)
						Call cCalendar.SpecialDate(SPECIAL_Weekly, DATETIME_Null, DAY_Tuesday, SEQ_Unset, COLOR_Black, COLOR_Gray, TRUE)
						Call cCalendar.SpecialDate(SPECIAL_Weekly, DATETIME_Null, DAY_Wednesday, SEQ_Unset, COLOR_Black, COLOR_Gray, TRUE)
						Call cCalendar.SpecialDate(SPECIAL_Weekly, DATETIME_Null, DAY_Thursday, SEQ_Unset, COLOR_Black, COLOR_Gray, TRUE)
						Call cCalendar.SpecialDate(SPECIAL_Weekly, DATETIME_Null, DAY_Friday, SEQ_Unset, COLOR_Black, COLOR_Gray, TRUE)
						Call cCalendar.SpecialDate(SPECIAL_Weekly, DATETIME_Null, DAY_Saturday, SEQ_Unset, COLOR_Black, COLOR_Gray, TRUE)
						Call cCalendar.SpecialDate(SPECIAL_OneTime, GetBankDate(), DAY_Unset, SEQ_Unset, COLOR_Blue,  COLOR_Cyan, TRUE)
						!
						Call SqlPrepareAndExecute(hSql(), T("select fdat into :dDat from fdat"))
						While SqlFetchNext(hSql(), nFetchRes)
							Call cCalendar.SpecialDate(SPECIAL_OneTime, dDat, DAY_Unset, SEQ_Unset, COLOR_Blue, COLOR_Cyan, TRUE)
			Picture: pic2
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   0.2"
					Top:    2.3"
					Width:  4.3"
					Width Editable? Yes
					Height: 0.8"
					Height Editable? Yes
				Visible? Yes
				Editable? No
				File Name:
				Storage: External
				Picture Transparent Color: None
				Fit: Scale
				Scaling
					Width:  100
					Height:  100
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Tile To Parent? No
				Border Color: 3D Shadow Color
				Background Color: 3D Face Color
				Message Actions
			Pushbutton: pbOk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbLabeledOk
				Property Template:
				Class DLL Name:
				Title: Применить
				Window Location and Size
					Left:   0.5"
					Top:    2.452"
					Width:  1.217"
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name:
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						Call SalGetWindowText(cCalendar, sDat, 10)
						Set nDay   = SalDateDay(SalStrToDate(sDat))
						Set nMonth = SalDateMonth(SalStrToDate(sDat))
						Set nYear  = SalDateYear(SalStrToDate(sDat))
						Set sDat   = IifS(nDay>9, SalNumberToStrX(nDay, 0), "0" || SalNumberToStrX(nDay,0)) || '/' ||
								    IifS(nMonth>9, SalNumberToStrX(nMonth, 0), '0' || SalNumberToStrX(nMonth, 0)) || '/' ||
								    SalNumberToStrX(nYear, 0)
						Set dDatPrnt = SalStrToDate(sDat)
						Call Print()
						Call SalEndDialog(hWndForm, TRUE)
			Pushbutton: pbCancel
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbLabeledCancel
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   2.9"
					Top:    2.45"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name:
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						Call SalEndDialog(hWndForm, FALSE)
		Functions
			Function: Print
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					String: sTemplateId
					Long String: sDoc
					: cCnc
						Class: cABSConnect
					: cCnc2
						Class: cABSConnect
					String: sValue
					Number: nDat
				Actions
					Set nDat = Val(
							    SalNumberToStrX(SalDateDay(dDatPrnt), 0) ||
							    SalStrRightX('00' || SalNumberToStrX(SalDateMonth(dDatPrnt), 0), 2) ||
							    SalNumberToStrX(SalDateYear(dDatPrnt), 0))
					If NOT cdoc_SelectDocTemplate("DOC_SCHEME", "ID", "NAME", " ID LIKE 'FG%' ", sTemplateId)
						Return FALSE
					If sTemplateId
						Call XConnectGetParams(cCnc)
						If cCnc.Connect() and cCnc2.Clone(cCnc, TRUE)
							Set sDoc = cdoc_CreateDocFromTemplate(cCnc.hSql(), cCnc2.hSql(), sTemplateId,  nIdClient, nDat)
							If sDoc
								Call cdoc_ShowDoc(sDoc, TRUE, FALSE)
							Call cCnc.Disconnect()
							Call cCnc2.Disconnect()
					Return TRUE
		Window Parameters
			Number: nIdClient
		Window Variables
			Date/Time: dDatPrnt
			String: strMonth[12]
			String: strWeekDays[7]
			Date/Time: dDat
			Number: nDay
			Number: nMonth
			Number: nYear
			String: sDat
		Message Actions
			On SAM_Create
				Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
				Call PrepareWindowEx(hWndForm)
				Set dDatPrnt = SalDateCurrent()
				Call SalSetWindowText(cCalendar, SalFmtFormatDateTime(dDatPrnt, 'dd/MM/yyyy'))
	Form Window: tblImportOICFiles
		Class: cGenericTableFrm
		Property Template:
		Class DLL Name:
		Title:
		Icon File:
		Accesories Enabled? Class Default
		Visible? Class Default
		Display Settings
			Display Style? Class Default
			Visible at Design time? Yes
			Automatically Created at Runtime? Class Default
			Initial State: Class Default
			Maximizable? Class Default
			Minimizable? Class Default
			System Menu? Class Default
			Resizable? Class Default
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  16.0"
				Width Editable? Class Default
				Height: 8.631"
				Height Editable? Class Default
			Form Size
				Width:  Class Default
				Height: Class Default
				Number of Pages: Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: Class Default
			Text Color: Class Default
			Background Color: Class Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Class Default
				Visible? Class Default
				Size: Class Default
				Size Editable? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
			Contents
				Pushbutton: pbIns
					Class Child Ref Key: 14
					Class ChildKey: 0
					Class: cGenericTableFrm
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? No
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbUpdate
					Class Child Ref Key: 17
					Class ChildKey: 0
					Class: cGenericTableFrm
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? No
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				!
				Pushbutton: pbRefresh
					Class Child Ref Key: 16
					Class ChildKey: 0
					Class: cGenericTableFrm
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.1"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbFilter
					Class Child Ref Key: 20
					Class ChildKey: 0
					Class: cGenericTableFrm
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.55"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbSearch
					Class Child Ref Key: 19
					Class ChildKey: 0
					Class: cGenericTableFrm
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.0"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Pushbutton: pbPrint
					Class Child Ref Key: 22
					Class ChildKey: 0
					Class: cGenericTableFrm
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.45"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 58392
					Class Child Ref Key: 18
					Class ChildKey: 0
					Class: cGenericTableFrm
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				!
				Pushbutton: pbDel
					Class Child Ref Key: 15
					Class ChildKey: 0
					Class: cGenericTableFrm
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.1"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Видалити файл'
						On SAM_Click
							Call tblFiles.DelFile()
				Line
					Resource Id: 58393
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  2.65"
						Begin Y:  0.4"
						End X:  2.65"
						End Y:  0.0"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Pushbutton: pbImport
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.75"
						Top:    0.06"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\DOC_IN.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Прийняти файли'
						On SAM_Click
							Call tblFiles.ImportFiles()
				Pushbutton: pbPay
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbExecute
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.2"
						Top:    0.06"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Обробити/Оплатити файл'
						On SAM_Click
							Call tblFiles.PayFile()
				Pushbutton: pbShowPayDocs
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.65"
						Top:    0.06"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\DOCS.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Перегляд оплачених документів файлу'
						On SAM_Click
							If tblFiles.colId and tblFiles.colNOpl
								Call DocViewListInt(hWndMDI,
										"a.ref in (select ref from ow_oic_ref where id=" || Str(tblFiles.colId) || ")",
										"Документи по файлу " || tblFiles.colFileName)
				Pushbutton: pbShowNotPayDocs
					Class Child Ref Key: 21
					Class ChildKey: 0
					Class: cGenericTableFrm
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.1"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Перегляд НЕоплачених документів файлу'
				Pushbutton: pbShowDelDocs
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbSwitch
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.55"
						Top:    0.06"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\DELETE.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Перегляд видалених транзакцій файлу'
						On SAM_Click
							If tblFiles.colId and tblFiles.colFileType and tblFiles.colNDel
								Call SalCreateWindow(tblDocs, hWndMDI, tblFiles, 0, tblFiles.colId, tblFiles.colFileType, tblFiles.colFileName)
				!
				Line
					Resource Id: 58394
					Class Child Ref Key: 23
					Class ChildKey: 0
					Class: cGenericTableFrm
					Coordinates
						Begin X:  5.1"
						Begin Y:  0.405"
						End X:  5.1"
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbExit
					Class Child Ref Key: 24
					Class ChildKey: 0
					Class: cGenericTableFrm
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   5.2"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 58395
					Class Child Ref Key: 25
					Class ChildKey: 0
					Class: cGenericTableFrm
					Coordinates
						Begin X:  5.75"
						Begin Y:  Class Default
						End X:  5.75"
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Check Box: cbDat
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cCheckBoxLabeled
					Property Template:
					Class DLL Name:
					Title: Файли, прийняті сьогодні
					Window Location and Size
						Left:   6.0"
						Top:    0.1"
						Width:  3.2"
						Width Editable? Class Default
						Height: 0.25"
						Height Editable? Class Default
					Visible? Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Bold
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Click
							Call SalTblReset(hWndForm)
							If cbDat
								Set hWndForm.tblImportOICFiles.strSqlPopulate = sSelect || sWhere || IifS(sWhere=STRING_Null, " where ", " and ")
										    || sWhereDat || sOrder
								Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
							Else
								Set hWndForm.tblImportOICFiles.strSqlPopulate = sSelect || sWhere || sOrder
								Call SalSendMsg(pbFilter, SAM_Click, 0, 0)
		Contents
			Custom Control: cHSpl
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cXSalHSplitter
				Property Template:
				Class DLL Name:
				Display Settings
					DLL Name:
					MS Windows Class Name:
					Style:  Class Default
					ExStyle:  Class Default
					Title:
					Window Location and Size
						Left:   Default
						Top:    Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Border? Class Default
					Etched Border? Class Default
					Hollow? Class Default
					Vertical Scroll? Class Default
					Horizontal Scroll? Class Default
					Tab Stop? Class Default
					Tile To Parent? Yes
					Font Name: Class Default
					Font Size: 10
					Font Enhancement: Bold
					Text Color: Black
					Background Color: Class Default
					DLL Settings
				Message Actions
			Child Table: tblFiles
				Class Child Ref Key: 1
				Class ChildKey: 0
				Class: cGenericTableFrm
				Property Template:
				Class DLL Name:
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  15.017"
						Width Editable? Class Default
						Height: 3.44"
						Height Editable? Class Default
					Visible? Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					View: Class Default
					Allow Row Sizing? Class Default
					Lines Per Row: Class Default
				Memory Settings
					Maximum Rows in Memory: 2000
					Discardable? Class Default
				Contents
					Column: colId
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title:
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colFileType
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title:
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  Default
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colFileName
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Ім'я
								файла
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  6.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colFileDate
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Дата
								імпорту
								файла
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Date/Time
						Justify: Center
						Width:  1.8"
						Width Editable? Yes
						Format: DateTime
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colFileN
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Кількість
								рядків
								у файлі
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Center
						Width:  1.2"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colNOpl
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Кількість
								документів
								оброблених
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Center
						Width:  1.6"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colNAbs
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Кількість
								документів
								АБС
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Center
						Width:  1.6"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colNErr
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Кількість
								документів
								необроблених
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Center
						Width:  1.6"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colNDel
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Кількість
								документів
								видалених
								з обробки
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Center
						Width:  1.6"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colFileStatus
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Статус файла
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Center
						Width:  1.6"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colStatusName
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Статус
								файла
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  3.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colComment
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Примітка
						Visible? Yes
						Editable? No
						Maximum Data Length: 254
						Data Type: String
						Justify: Left
						Width:  5.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colErrText
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Примітка
						Visible? No
						Editable? No
						Maximum Data Length: 254
						Data Type: String
						Justify: Left
						Width:  5.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
				Functions
					Function: SetLine
						Description:
						Returns
							Boolean:
						Parameters
							Number: nRow
						Static Variables
						Local variables
							Number: nColor
						Actions
							Set nColor = COLOR_White
							Select Case colFileStatus
								Case 0
									Set colStatusName = 'Файл внесено до БД'
									Set nColor = SalColorFromRGB(230, 255, 255)
									Break
								Case 1
									Set colStatusName = 'Файл внесено до таблиці БД'
									Break
								Case 2
									Set colStatusName = 'Файл оброблено'
									Break
								Case 3
									Set colStatusName = 'Помилка'
									Set colComment = colErrText
									Set nColor =  COLOR_Salmon
									Break
								Default
									Break
							! только ошибочные строки
							If colNOpl = 0 and colNErr > 0
								Set nColor =  COLOR_Salmon
							If colNErr
								Set nColor = SalColorFromRGB(255, 200, 200)
								If colFileType = ATRANSFERS or colFileType = FTRANSFERS or colFileType = STRANSFERS or colFileType = DOCUMENTS
									Set colComment = IifS(colFileStatus=3, colErrText, 'Є неоплачені документи')
							Call XSalTblSetRowBackColor(hWndForm, SalTblQueryContext(hWndForm), nColor)
							Return TRUE
					Function: PayFile
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							If SalTblAnyRows(hWndForm, ROW_Selected, 0)
								If colId > 0
									If colFileN = NUMBER_Null or colNErr > 0
										If SalMessageBox(IifS(Subs(colFileName,1,3)='OIC', "Оплатити необроблені документи файла " || colFileName ||
												   "?", "Обробити файл " || colFileName || "?"), "Увага!", MB_IconQuestion | MB_YesNo) = IDYES
											If ProcessFile(colId, colFileName)
												Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
									Else
										Call SalMessageBox("Файл вже оброблено!", "Інформація", MB_IconAsterisk | MB_Ok)
								Else
									Call SalMessageBox("Обновіть дані в таблиці!", "Інформація", MB_IconAsterisk | MB_Ok)
							Return TRUE
					Function: ImportFiles
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							Number: nFiles
							String: smFile[*]
							Boolean: bmFilesFlag[*]
							Number: nFileId
							! String: sFileName
							Date/Time: dFileDate
							Number: i
							Number: nRow
							Number: nFilesCount
							!
							! String: sMsg
							Number: nFileN
							Number: nFileOpl
							Number: nFileErr
							Number: nFileDel
							Number: nFileAbs
						Actions
							Call SaveInfoToLog("Way4. Импорт файлов")
							! Смотрим в каталог импорта
							If sPathImport = ''
								Call SalMessageBox("Не описано каталог для імпорту файлів " || sFileMask, "Увага!", MB_IconStop | MB_Ok)
								Call SaveInfoToLog("Way4. Не описано каталог для імпорту файлів " || sFileMask)
								Return FALSE
							Set nFiles = VisDosEnumFiles(sPathImport || '\\' || sFileMask, FA_Standard, smFile)
							! Если файлов для импорта нет - выходим
							If nFiles < 0
								Call SalMessageBox("Відсутні файли для імпорта в " || sPathImport, "Увага!", MB_IconStop | MB_Ok)
								Call SaveInfoToLog("Way4. Відсутні файли для імпорта в " || sPathImport)
								Return FALSE
							Call SaveInfoToLog("Way4. " || Str(nFiles) || " файлов для импорта в каталоге " || sPathImport)
							! Вызываем окно выбора файлов
							! Если отказались от импорта - выходим
							If not SalModalDialog(dlgSelectFiles, hWndForm, nFiles, smFile, bmFilesFlag)
								Call SaveInfoToLog("Way4. Не выбраны файлы для импорта")
								Return FALSE
							Call SalTblReset(hWndForm)
							Call SalShowWindow(colComment)
							Call SalInvalidateWindow(hWndForm)
							! Импорт файлов
							Call SalWaitCursor(TRUE)
							Set nFilesCount = 0
							Set i = 0
							While i < nFiles
								! Импортируем только те файлы, которые отмечены для импорта
								If bmFilesFlag[i]
									Set nFilesCount = nFilesCount + 1
									Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
									Call SalTblSetContext(hWndForm, nRow)
									Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
									Set colFileName = SalStrUpperX(smFile[i])
									! Проверка повторного импорта
									Set nFileId = 0
									If SqlPrepareAndExecute(hSql(),
											"select id, file_date into :nFileId, :dFileDate
											   from ow_files
											  where file_name = :colFileName")
										Call SqlFetchNext(hSql(), nFetchRes)
										! Файл уже импортировался
										If nFileId
											Set colComment = 'Файл вже імпортувався ' || SalFmtFormatDateTime(dFileDate, 'dd.MM.yyyy hhhh:mm:ss')
											Call SalColorSet(colComment, COLOR_IndexCellText, COLOR_Red)
											Call SaveInfoToLog("Way4. " || colFileName || ": Файл вже імпортувався")
										! Импорт файла
										Else
											If not ImportFile(sPathImport, colFileName, colId, colFileStatus, colComment)
												Call SalColorSet(colComment, COLOR_IndexCellText, COLOR_Red)
												Call SaveInfoToLog("Way4. " || colFileName || ": " || colComment)
											Else
												If colId
													! Читаем кол-во оплаченных/неоплаченных документов
													Call SqlPrepareAndExecute(hSql(),
															"select file_date, file_status, file_n, n_opl, n_err, n_del, n_abs, err_text
															 into   :colFileDate, :colFileStatus, :colFileN, :colNOpl, :colNErr, :colNDel, :colNAbs, :colErrText
															 from   v_ow_oic_files
															 where  id = :colId")
													Call SqlFetchNext(hSql(), nFetchRes)
													Call SetLine(SalTblQueryContext(hWndForm))
												Else
													Call SalColorSet(colComment, COLOR_IndexCellText, COLOR_Red)
													Call SaveInfoToLog("Way4. " || colFileName || ": " || colComment)
								Call SalInvalidateWindow(hWndForm)
								Set i = i + 1
							Call SalWaitCursor(FALSE)
							If nFilesCount
								Call SalMessageBox("Оброблено " || Str(nFilesCount) || " файлів", "Інформація", MB_IconAsterisk | MB_Ok)
								Call SalTblSetContext(hWndForm, 0)
								Call SalSendMsg(hWndForm, SAM_TblDoDetails, 0, 0)
							Return TRUE
					Function: ImportFile
						Description:
						Returns
							Boolean:
						Parameters
							String: sFilePath
							String: sFileName
							Receive Number: nId
							Receive Number: nStatus
							Receive String: sMsg
						Static Variables
						Local variables
							String: sFileType
						Actions
							Call SaveInfoToLog("Way4. Импорт файла " || sFileName)
							! Set nFileN   = NUMBER_Null
							! Set nFileErr = NUMBER_Null
							Set nId = NUMBER_Null
							Set nStatus = NUMBER_Null
							Set sMsg = STRING_Null
							!
							! Определяем тип файла
							! 1. ATRANSFERS
							! у ATransfers и FTransfers одинаковая структура
							If SalStrScan(sFileName, ATRANSFERS) != -1
								Set sFileType = ATRANSFERS
							Else If SalStrScan(sFileName, FTRANSFERS) != -1
								Set sFileType = FTRANSFERS
							! 2. STRANSFERS
							Else If SalStrScan(sFileName, STRANSFERS) != -1
								Set sFileType = STRANSFERS
							! 3. DOCUMENTS
							Else If SalStrScan(sFileName, DOCUMENTS) != -1
								Set sFileType = DOCUMENTS
							! 4. Неизвестный тип файла
							Else
								Set sFileType = ""
							Call SaveInfoToLog("Way4. Тип файла - " || sFileType)
							!
							If sFileType
								! Импорт файла во временную таблицу
								If not LoadFile(hWndForm, 'Завантаження файлу', sFileName, sPathImport || Chr(92) || sFileName, nId)
									Return FALSE
								! Обработка файла - может свалиться на импорте файла, может на оплате
								Call SalWaitCursor(TRUE)
								! вызываем окно выполнения
								Call StartProgress(SalWindowHandleToNumber(hWndForm), 'Обробка файлу', sFileName)
								! без этого не показывается окно выполнения :)
								Call SalCreateWindow(Dummy, hWndForm)
								Call SalDestroyWindow(Dummy)
								Call SalInvalidateWindow(hWndForm)
								If not SqlPLSQLCommand(hSql(), "bars_ow.import_file(sFileName, nId, sMsg)")
									Call SqlRollback(hSql())
									Set nStatus = 3
									Set sMsg = 'Помилка імпорту'
									Call SaveInfoToLog("Way4. Неуспешная загрузка файла " || sFileName )
									! закрываем окно выполнения
									Call StopProgress()
									Return FALSE
								! nId = null - ошибка
								If nId > 0
									Set nStatus = 0
									Call SqlCommitEx(hSql(), "Way4. " || sFileName || ": Файл записано до БД")
									! Помещаем файл в архив
									Call OW_BackUpFile(sFilePath, sFileName, sPathBackUp)
									! Обработка файла
									Set colFileStatus = 0
									If not SqlPLSQLCommand(hSql(), "p_job_w4importfiles(nId)")
										Call SqlRollback(hSql())
										Set nStatus = 3
										Set sMsg = 'Помилка обробки файлу'
										Call SaveInfoToLog("Way4. Неуспешный разбор/оплата файла " || sFileName )
										! закрываем окно выполнения
										Call StopProgress()
										Return FALSE
									Else
										If SignDocFile(nId) < 0
											Call SqlRollback(hSql())
											Set nStatus = 3
											Set sMsg = 'Помилка обробки при підпису файлу'
											Call SaveInfoToLog("Way4. Неуспешная подпись документов файла " || sFileName)
									Set nStatus = 2
									Call SqlCommitEx(hSql(), "Way4. " || sFileName || ": Файл оброблено")
								Else
									Call SqlRollback(hSql())
									Set nStatus = 3
								! закрываем окно выполнения
								Call StopProgress()
								Call SalWaitCursor(FALSE)
							Else
								Set sMsg = 'Невідомий тип файла'
							Return TRUE
					Function: ProcessFile
						Description:
						Returns
							Boolean:
						Parameters
							Number: nId
							String: sFileName
						Static Variables
						Local variables
							Number: nRef
						Actions
							Call SaveInfoToLog("Way4. Оплата по требованию файла " || sFileName)
							Call SalWaitCursor(TRUE)
							If not SqlPLSQLCommand(hSql(), "p_job_w4importfiles(nId)")
								Call SqlRollback(hSql())
								Call SaveInfoToLog("Way4. Неуспешная оплата по требованию файла " || sFileName)
								Call SalWaitCursor(FALSE)
								Return FALSE
							Else
								If SignDocFile(nId) < 0
									Call SqlRollback(hSql())
									Call SalWaitCursor(FALSE)
									Return FALSE
							Call SqlCommitEx(hSql(), "Way4. Выполнена оплата по требованию файла " || sFileName)
							Call SalWaitCursor(FALSE)
							Call SalMessageBox("Виконано обробку файла " || sFileName, "Інформація", MB_IconAsterisk | MB_Ok)
							Return TRUE
					Function: DelFile
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							If SalTblAnyRows(hWndForm, ROW_Selected, 0)
								If colId > 0
									If SalMessageBox("Видалити файл " || colFileName || "?", "Увага!", MB_IconQuestion | MB_YesNo) = IDYES
										If not SqlPLSQLCommand(hSql(), "bars_ow.delete_file(colId)")
											Call SqlRollback(hSql())
											Call SaveInfoToLog("Way4. Неуспешное удаление файла " || colFileName)
											Call SalWaitCursor(FALSE)
											Return FALSE
										Call SqlCommitEx(hSql(), "Way4. Удален файл " || colFileName)
										Call SalWaitCursor(FALSE)
										Call SalMessageBox("Видалено файл " || colFileName, "Інформація", MB_IconAsterisk | MB_Ok)
										Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
							Return TRUE
					Function: SignDocFile
						Description:
						Returns
							Number:
						Parameters
							Number: nId
						Static Variables
						Local variables
							Number: nRef
						Actions
							If GetSignOn()
								If SqlPrepareAndExecute(hSqlAux(), "
										   SELECT ref
										   INTO   :nRef
										   FROM   OW_OIC_REF
										   WHERE  id=:nId")
									While SqlFetchNext(hSqlAux(), nFetchRes)
										If not cDocWay.SetDocR(nRef, TRUE)
											! Call SaveInfoToLog("Way4. Неуспешная оплата по требованию файла " || sFileName || ' (подпись 2 SetDocR)')
											Return -2
										Set cDocWay.m_sOperId = GetIdOper()
										If not cDocWay.sDoc()
											! Call SaveInfoToLog("Way4. Неуспешная оплата по требованию файла " || sFileName || ' (подпись 3 sDoc)')
											Return -3
										Else
											If SqlPrepare(hSql(), "
													   UPDATE oper
													   SET sign=:cDocWay.m_lsSign,ref_a=:cDocWay.m_sRef_A,id_o=:cDocWay.m_sOperId
													   WHERE ref=:cDocWay.m_nRef")
												If SqlSetLongBindDatatype(1, BLOB_BYTE)
													If not SqlExecute(hSql())
														! Call SaveInfoToLog("Way4. Неуспешная оплата по требованию файла " || sFileName ||
																     ' (подпись 5 SetSign)')
														Return -5
													Else
														Return 0
												Else
													! Call SaveInfoToLog("Way4. Неуспешная оплата по требованию файла " || sFileName ||
															     ' (подпись 6 SetLong)')
													Return -6
											Else
												! Call SaveInfoToLog("Way4. Неуспешная оплата по требованию файла " || sFileName || ' (подпись 4 GetSign)')
												Return -4
								Else
									! Call SaveInfoToLog("Way4. Неуспешная оплата по требованию файла " || sFileName || ' (подпись 1 GetRef)')
									Return -1
							Else
								Return 0
				Window Variables
				Message Actions
					On UM_Populate
						Call tblImportOICFiles.ReInitQueryString()
						Call SalSendClassMessage(UM_Populate, 0, 0)
					On SAM_TblDoDetails
						If Subs(sFileMask,1,3) = 'OIC'
							If colNOpl
								Call SalEnableWindow(pbShowPayDocs)
							Else
								Call SalDisableWindow(pbShowPayDocs)
							If colNErr
								Call SalEnableWindow(pbShowNotPayDocs)
								Call SalEnableWindow(pbPay)
							Else
								Call SalDisableWindow(pbShowNotPayDocs)
								Call SalDisableWindow(pbPay)
							If colNDel
								Call SalEnableWindow(pbShowDelDocs)
							Else
								Call SalDisableWindow(pbShowDelDocs)
							If colFileStatus = 0 or colFileStatus = 1
								Call SalEnableWindow(pbPay)
						Else
							Call SalDisableWindow(pbPay)
							Call SalDisableWindow(pbShowPayDocs)
							Call SalDisableWindow(pbShowNotPayDocs)
							Call SalDisableWindow(pbShowDelDocs)
							Call SalSetWindowText(cHSpl, ';Інформація по файлу ' || colFileName)
							Call tblInfo.Populate(colFileType, colFileN, colNOpl, colNAbs, colNErr, colNDel)
							If colFileType = ATRANSFERS or colFileType = FTRANSFERS or colFileType = STRANSFERS or colFileType = DOCUMENTS
								! colFileStatus:
								! 0 - тело файла (clob) помещено в БД
								! 1 - строки файла помещены в таблицу
								! 2 - строки файла обработаны (возможно, остались необработанные документы)
								If colFileStatus = 0 or colFileStatus = 1 or (colFileStatus = 2 and colNErr != 0)
									Call SalEnableWindow(pbPay)
								If colFileStatus = 2
									If colNOpl
										Call SalEnableWindow(pbShowPayDocs)
									Else
										Call SalDisableWindow(pbShowPayDocs)
									If colNErr
										Call SalEnableWindow(pbShowNotPayDocs)
										Call SalEnableWindow(pbPay)
									Else
										Call SalDisableWindow(pbShowNotPayDocs)
										Call SalDisableWindow(pbPay)
									If colNDel
										Call SalEnableWindow(pbShowDelDocs)
									Else
										Call SalDisableWindow(pbShowDelDocs)
							Else If colFileStatus = 0
								Call SalEnableWindow(pbPay)
					On SAM_FetchRowDone
						Call SetLine(lParam)
					On SAM_DoubleClick
						If colId and colFileType and colNErr
							Call SalCreateWindow(tblDocs, hWndMDI, hWndForm, 1, colId, colFileType, colFileName)
			Child Table: tblInfo
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Display Settings
					Window Location and Size
						Left:   0.183"
						Top:    3.905"
						Width:  14.9"
						Width Editable? Yes
						Height: 3.167"
						Height Editable? Yes
					Visible? Yes
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					View: Table
					Allow Row Sizing? No
					Lines Per Row: Default
				Memory Settings
					Maximum Rows in Memory: Default
					Discardable? Yes
				Contents
					Column: colFileN
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Кількість
								рядків
								у файлі
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Center
						Width:  2.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colNOpl
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Кількість
								документів
								оброблених
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Center
						Width:  2.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colNAbs
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Кількість
								документів
								АБС
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Center
						Width:  2.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colNErr
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Кількість
								документів
								необроблених
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Center
						Width:  2.0"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colNDel
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Кількість
								документів
								видалених з обробки
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Center
						Width:  2.2"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
				Functions
					Function: Populate
						Description:
						Returns
							Boolean:
						Parameters
							String: sFileType
							Number: nFileN
							Number: nNOpl
							Number: nNAbs
							Number: nNErr
							Number: nNDel
						Static Variables
						Local variables
						Actions
							Call SalHideWindow(colFileN)
							Call SalHideWindow(colNOpl)
							Call SalHideWindow(colNAbs)
							Call SalHideWindow(colNErr)
							Call SalHideWindow(colNDel)
							If sFileType = ATRANSFERS or sFileType = FTRANSFERS or sFileType = STRANSFERS or sFileType = DOCUMENTS
								Call SalShowWindow(colFileN)
								Call SalShowWindow(colNOpl)
								Call SalShowWindow(colNAbs)
								Call SalShowWindow(colNErr)
								Call SalShowWindow(colNDel)
								Call SalTblSetColumnTitle(colNOpl, 'Кількість' || PutCrLf() || 'документів' || PutCrLf() || 'оброблених')
								Call SalTblSetColumnTitle(colNErr, 'Кількість' || PutCrLf() || 'документів' || PutCrLf() || 'необроблених')
							Else If sFileType = RIIC
								Call SalShowWindow(colFileN)
								Call SalShowWindow(colNOpl)
								Call SalShowWindow(colNErr)
								Call SalTblSetColumnTitle(colNOpl, 'Кількість' || PutCrLf() || 'прийнятих' || PutCrLf() || 'документів')
								Call SalTblSetColumnTitle(colNErr, 'Кількість' || PutCrLf() || 'НЕприйнятих' || PutCrLf() || 'документів')
							Set colFileN = nFileN
							Set colNOpl  = nNOpl
							Set colNAbs  = nNAbs
							Set colNErr  = nNErr
							Set colNDel  = nNDel
							Call SetLine(0)
							Return TRUE
					Function: SetLine
						Description:
						Returns
							Boolean:
						Parameters
							Number: nRow
						Static Variables
						Local variables
							Number: nColor
						Actions
							Set nColor = COLOR_White
							! только ошибочные строки
							If colNOpl = 0 and colNErr > 0
								Set nColor =  COLOR_Salmon
							If colNErr
								Set nColor = SalColorFromRGB(255, 200, 200)
							Call XSalTblSetRowBackColor(hWndForm, SalTblQueryContext(hWndForm), nColor)
							Return TRUE
				Window Variables
				Message Actions
					On SAM_Create
						Call SalTblInsertRow(hWndForm, 0)
						Call SalTblSetRowFlags(tblInfo, 0, ROW_New, FALSE)
		Functions
		Window Parameters
			String: sFileMask
		Window Variables
			String: sPathImport
			String: sPathBackUp
			String: sSelect
			String: sWhere
			String: sWhereDat
			String: sOrder
			: cDocWay
				Class: cDoc
		Message Actions
			On SAM_Create
				If Subs(sFileMask,1,3) = 'OIC'
					Call SalSetWindowText(hWndForm, AppVersion || "Way4. Імпорт та обробка файлів " || sFileMask || "*.xml")
					Call cHSpl.setBarPosition(1000)
					Call cHSpl.setTopFrame(tblFiles)
					Set sPathImport = GetValueStr("select substr(val,1,100) from ow_params where par = 'OICFILEDIR'")
					Set sPathBackUp = GetValueStr("select substr(val,1,100) from ow_params where par = 'OICBACKDIR'")
					Set hWndForm.tblImportOICFiles.nFlags = GT_ReadOnly
					Set hWndForm.tblImportOICFiles.strFilterTblName = "v_ow_oic_files"
					Set sSelect =
							"select id, file_type, file_name, file_date, file_status, err_text, file_n, n_opl, n_err, n_del, n_abs
							 into   :tblImportOICFiles.tblFiles.colId, :tblImportOICFiles.tblFiles.colFileType,
							        :tblImportOICFiles.tblFiles.colFileName, :tblImportOICFiles.tblFiles.colFileDate,
							        :tblImportOICFiles.tblFiles.colFileStatus, :tblImportOICFiles.tblFiles.colErrText,
							        :tblImportOICFiles.tblFiles.colFileN, :tblImportOICFiles.tblFiles.colNOpl, :tblImportOICFiles.tblFiles.colNErr,
							        :tblImportOICFiles.tblFiles.colNDel, :tblImportOICFiles.tblFiles.colNAbs
							 from   v_ow_oic_files"
					Set sWhere = " where file_name like '" || sFileMask || "%'"
					Set sFileMask = sFileMask || '*.xml'
				Else If sFileMask
					Call SalSetWindowText(hWndForm, AppVersion || "Way4. Протокол обробки файлів " || sFileMask || "*.xml")
					Call cHSpl.setBarPosition(600)
					Call cHSpl.setTopFrame(tblFiles)
					Call cHSpl.setBottomFrame(tblInfo)
					Call SalColorSet(cHSpl, COLOR_IndexWindow, SalColorFromRGB(180, 210, 255))
					Call SalHideWindow(tblFiles.colFileN)
					Call SalHideWindow(tblFiles.colNOpl)
					Call SalHideWindow(tblFiles.colNAbs)
					Call SalHideWindow(tblFiles.colNErr)
					Call SalHideWindow(tblFiles.colNDel)
					Call SalDisableWindow(pbImport)
					Set hWndForm.tblImportOICFiles.nFlags = GT_NoIns | GT_NoUpd
					Set hWndForm.tblImportOICFiles.strFilterTblName = "v_ow_files"
					Set sSelect =
							"select id, file_type, file_name, file_date, file_status, err_text, file_n, n_opl, n_err, n_del, n_abs
							 into   :tblImportOICFiles.tblFiles.colId, :tblImportOICFiles.tblFiles.colFileType,
							        :tblImportOICFiles.tblFiles.colFileName, :tblImportOICFiles.tblFiles.colFileDate,
							        :tblImportOICFiles.tblFiles.colFileStatus, :tblImportOICFiles.tblFiles.colErrText,
							        :tblImportOICFiles.tblFiles.colFileN, :tblImportOICFiles.tblFiles.colNOpl, :tblImportOICFiles.tblFiles.colNErr,
							        :tblImportOICFiles.tblFiles.colNDel, :tblImportOICFiles.tblFiles.colNAbs
							 from   v_ow_files"
					Set sWhere = " where file_name like '" || sFileMask || "%'"
				Else
					Call SalSetWindowText(hWndForm, AppVersion || "Way4. Протокол обробки файлів від ПЦ")
					Call cHSpl.setBarPosition(600)
					Call cHSpl.setTopFrame(tblFiles)
					Call cHSpl.setBottomFrame(tblInfo)
					Call SalColorSet(cHSpl, COLOR_IndexWindow, SalColorFromRGB(180, 210, 255))
					Call SalHideWindow(tblFiles.colFileN)
					Call SalHideWindow(tblFiles.colNOpl)
					Call SalHideWindow(tblFiles.colNAbs)
					Call SalHideWindow(tblFiles.colNErr)
					Call SalHideWindow(tblFiles.colNDel)
					Call SalDisableWindow(pbImport)
					Set hWndForm.tblImportOICFiles.nFlags = GT_NoIns | GT_NoUpd
					Set hWndForm.tblImportOICFiles.strFilterTblName = "v_ow_files"
					Set sSelect =
							"select id, file_type, file_name, file_date, file_status, err_text, file_n, n_opl, n_err, n_del, n_abs
							 into   :tblImportOICFiles.tblFiles.colId, :tblImportOICFiles.tblFiles.colFileType,
							        :tblImportOICFiles.tblFiles.colFileName, :tblImportOICFiles.tblFiles.colFileDate,
							        :tblImportOICFiles.tblFiles.colFileStatus, :tblImportOICFiles.tblFiles.colErrText,
							        :tblImportOICFiles.tblFiles.colFileN, :tblImportOICFiles.tblFiles.colNOpl, :tblImportOICFiles.tblFiles.colNErr,
							        :tblImportOICFiles.tblFiles.colNDel, :tblImportOICFiles.tblFiles.colNAbs
							 from   v_ow_files"
					Set sWhere = STRING_Null
				Call SetWindowFullSize(hWndForm)
				Call PrepareWindowEx(hWndForm)
				!
				Set sWhereDat = " trunc(file_date) = trunc(sysdate)"
				Set sOrder = " order by file_date desc, file_name"
				Set hWndForm.tblImportOICFiles.strSqlPopulate = sSelect || sWhere || IifS(sWhere=STRING_Null, " where ", " and ") ||
						    sWhereDat || sOrder
				Set cbDat = TRUE
				Call SalSendClassMessage(SAM_Create, 0, 0)
