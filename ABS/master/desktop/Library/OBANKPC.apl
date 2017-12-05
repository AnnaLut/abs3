Application Description: ! OBANKPC.APL -  Интерфейс с процессинговым 
		! центром для ОЩАДБАНКА
		! ООО Унити-Барс  (C)  2001-2003
		! Разработчик: Малышев И.В., Чупахина Н.А.
		! ///////////////////////////////////////////
	Outline Version - 4.0.26
	Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400800000
0020: 0000000000C80000 002C000000030000 00030000000E0300 000B000000F8FFFF
0040: FFE1FFFFFF200000 0015000000EA0200 00D7010000010000 0000000000010000
0060: 000F4170706C6963 6174696F6E497465 6D02000000075769 6E646F77730C7462
0080: 6C506F7274666F6C 696F
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
0000: 0418B80BB80B2500
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
		Dynalib: Message.apd
		Dynalib: Absapi.apd
		Dynalib: Nsiapi.apd
		Dynalib: DOCVIEW.APD
		Dynalib: custacnt.apd
		Dynalib: CC_DOC.APD
		Dynalib: techbank.apd
		Dynalib: openway.apd
		!
		File Include: GenTbl.apl
		File Include: GenTblS.apl
		File Include: Constant.apl
		File Include: Genbutn.apl
		File Include: Genemnu.apl
		File Include: Genlist.apl
		File Include: Winapi.apl
		File Include: Winbars2.apl
		File Include: Sqlnsi.apl
		!
		File Include: DOCFUN6.APL
		!
		File Include: Vtcal.apl
		File Include: Vtmeter.apl
		File Include: Vttblwin.apl
		File Include: vtsplit.apl
		File Include: vtlbx.apl
		File Include: vtdos.apl
		File Include: Vtmsgbox.apl
		File Include: VTFILE.APL
		File Include: XSalImg.apl
		File Include: xsalcpt.apl
		File Include: QCKTABS.APL
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
			Input: 9999
			Date/Time: dd.MM.yyyy
		External Functions
		Constants
.data CCDATA
0000: 3000000000000000 0000000000000000 00000000
.enddata
.data CCSIZE
0000: 1400
.enddata
			System
			User
		Resources
			Icon: icon_Folder1
				File Name: \Bars98\Resource\Ico\Folder.ico
		Variables
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
			Number: nFetchRes
			Window Handle: hWnd6
			Window Handle: hWnd7
			Window Handle: hWnd8
			Window Handle: hWnd10
			Window Handle: hWnd11
			Window Handle: hWnd12
			Window Handle: hWnd13
			Window Handle: hWnd14
			Window Handle: hWnd15
			Window Handle: hWnd16
			Window Handle: hWnd19
			Window Handle: hWnd20
			Window Handle: hWnd21
			Window Handle: hWnd22
			Window Handle: hWnd23
			Window Handle: hWnd24
			Window Handle: hWnd25
			String: sFileName
			File Handle: hFile
			String: sStatusText
		Internal Functions
			Function: FOBPC_Select			! __exported
				Description: Интерфейс для вызова всех функций в 
						OBANKPC.APD
				Returns
					Boolean:
				Parameters
					Number: nFuncCode
					String: sFuncParams
				Static Variables
				Local variables
				Actions
					If nFuncCode > 100 
						Call OpenWay(hWndMDI, nFuncCode-100, 0, 0, sFuncParams, '')
					Else
						Select Case nFuncCode
							Case 1		! Формирование файлов P~
								Call FormPCFiles(sFuncParams)
								Break
							! Просмотр карточных документов
							Case 2		! Просмотр внутр. не отправленных документов по карточным счетам
								Call DocList(hWndMDI, 2, 0, '', '', '',
										" a.ref IN (SELECT ref FROM PKK_QUE WHERE sos=0) and a.sos >= 0",
										"Внутрішні не відправлені карткові документи")
								Break
							Case 3		! Просмотр внутр. не сквитованных документов по карточным счетам
								Call DocList(hWndMDI, 2, 0, '', '', '',
										" a.ref IN (SELECT ref FROM PKK_QUE WHERE sos=1) ",
										"Внутрішні не заквитовані карткові документи")
								Break
							Case 4		! Просмотр внеш. не отправленных документов по карточным счетам
								! Call DocList( 
											hWndMDI,1,0,'','','',
											' a.ref IN (SELECT ref FROM PKK_QUE WHERE sos=0) ',
											'Внешние не отправленные карточные документы')
								Call DocList(hWndMDI, 1, 0, '', '', '',
										" a.rec in ( select rec from arc_rrp where ref in (select ref from pkk_que where sos = 0)
										             union all
										             select rec from pkk_inf ) ",
										"Зовнішні не відправлені карткові документи")
								Break
							Case 5		! Просмотр внеш. не сквитованных документов по карточным счетам
								Call DocList(hWndMDI, 1, 0, '', '', '',
										" a.ref IN (SELECT ref FROM PKK_QUE WHERE sos=1) ",
										"Зовнішні не заквитовані карткові документи")
								Break
							Case 6		! Прием файлов процессингового центра
								If not IsWindow(hWnd6)
									Set hWnd6 = SalCreateWindow(frm_ImportPCFiles, hWndMDI)
								Else
									Call SalBringWindowToTop(hWnd6)
								Break
							Case 7		! Прием файлов из локальных задач
								If not IsWindow(hWnd7)
									Set hWnd7 = SalCreateWindow(frm_ImportInternalTasks, hWndMDI, sFuncParams)
								Else
									Call SalBringWindowToTop(hWnd7)
								Break
							Case 8		! Доввод доп. реквизитов
								If not IsWindow(hWnd8)
									Set hWnd8 = SalCreateWindow(frm_AuxReenter, hWndMDI)
								Else
									Call SalBringWindowToTop(hWnd8)
								Break
							Case 9		! Сброс таблицы импортированных файлов ПЦ
								Call ResetImportedFiles()
								Break
							Case 10		! Ручная квитовка док-тов
								If not IsWindow(hWnd10)
									Set hWnd10 = SalCreateWindow(frm_HandReceipe, hWndMDI)
								Else
									Call SalBringWindowToTop(hWnd10)
								Break
							Case 11		! Портфель
								If not IsWindow(hWnd11)
									Set hWnd11 = SalCreateWindow(tblPortfolio, hWndMDI, 1, sFuncParams)
								Else
									Call SalBringWindowToTop(hWnd11)
								Break
							Case 12		! Продукты БПК
								If not IsWindow(hWnd12)
									Set hWnd12 = SalCreateWindow(tblProduct, hWndMDI, nFuncCode)
								Else
									Call SalBringWindowToTop(hWnd12)
								Break
							Case 13		! Формирование odb*.dbf
								If not IsWindow(hWnd13)
									Set hWnd13 = SalCreateWindow(tblFormOdbDbf, hWndMDI)
								Else
									Call SalBringWindowToTop(hWnd13)
								Break
							Case 14		! Импорт зарплатного файла
								If not IsWindow(hWnd14)
									Set hWnd14 = SalCreateWindow(frm_ImportZP, hWndMDI, sFuncParams)
								Else
									Call SalBringWindowToTop(hWnd14)
								Break
							Case 15		! Пополнение карт. счетов с одного транзита (задаем техн. счет)
								If not IsWindow(hWnd15)
									Set hWnd15 = SalCreateWindow(frm_PayCard, hWndMDI, sFuncParams, 0)
								Else
									Call SalBringWindowToTop(hWnd15)
								Break
							Case 16		! Ручная корректировка документов для ПЦ
								If not IsWindow(hWnd16)
									Set hWnd16 = SalCreateWindow(tblObpcPkkque, hWndMDI, sFuncParams)
								Else
									Call SalBringWindowToTop(hWnd16)
								Break
							Case 17		! Пополнение карт. счетов с одного транзита (задаем карт. счет)
								If not IsWindow(hWnd15)
									Set hWnd15 = SalCreateWindow(frm_PayCard, hWndMDI, sFuncParams, 1)
								Else
									Call SalBringWindowToTop(hWnd15)
								Break
							Case 18		! Импорт справочников, синхронизация
								Call ImportReference(sFuncParams)
								Break
							Case 19		! Формирование файлов P*
								If not IsWindow(hWnd19)
									Set hWnd19 = SalCreateWindow(tblFormFileP, hWndMDI)
								Else
									Call SalBringWindowToTop(hWnd19)
								Break
							Case 20		! Удаление в архив необработанных транзакций ПЦ
								If not IsWindow(hWnd20)
									Set hWnd20 = SalCreateWindow(tblDeleteTran, hWndMDI)
								Else
									Call SalBringWindowToTop(hWnd20)
								Break
							Case 21		! Отчет
								If not IsWindow(hWnd21)
									Set hWnd20 = SalCreateWindow(tblReport, hWndMDI)
								Else
									Call SalBringWindowToTop(hWnd21)
								Break
							Case 22         ! ОБ РУ - XML - Зачисление з/п на каоточные счета
								If not IsWindow(hWnd22)
									Set hWnd22 = SalCreateWindow(XM3, hWndMDI, 0, 0, '', '')
								Else
									Call SalBringWindowToTop(hWnd22)
								Break
							Case 23         ! Импорт зарплатных проэктов - открытие карточек
								If not IsWindow(hWnd23)
									Set hWnd23 = SalCreateWindow(frmImpProect, hWndMDI)
								Else
									Call SalBringWindowToTop(hWnd23)
								Break
							Case 24         ! Импорт ACCT (всего файла)
								If not IsWindow(hWnd24)
									Set hWnd24 = SalCreateWindow(frmImportAcct, hWndMDI)
								Else
									Call SalBringWindowToTop(hWnd24)
								Break
							Case 25		! Портфель-просмотр
								If not IsWindow(hWnd25)
									Set hWnd25 = SalCreateWindow(tblPortfolio, hWndMDI, 0, sFuncParams)
								Else
									Call SalBringWindowToTop(hWnd25)
								Break
							Default
								Break
					Return TRUE
			Function: FormPCFiles
				Description: Формирование файлов для процессингового центра
				Returns
				Parameters
					String: sFileType
				Static Variables
					: cFileFormer
						Class: cPA_PC_Former
				Local variables
					Boolean: fNeedStatus
					String: sPath
				Actions
					If sFileType
						Call SaveInfoToLog('OBPC. Формування файлу P' || sFileType || '*')
						Set fNeedStatus = FALSE
						! Чтение параметров
						Call SalUseRegistry(FALSE, GetIniFileName())
						Call SalGetProfileString('OBPC', 'OBPCOutPath', '', sPath, GetIniFileName())
						! Вызов класса формирования файла
						If cFileFormer.FormFile(sPath, sFileType)
							If cFileFormer.sLog
								Set fNeedStatus = TRUE
						Else
							Set fNeedStatus = TRUE
						If fNeedStatus
							Call SalModalDialog(dlgStatus, hWndForm, cFileFormer.sLog, 'Статус формування файлу Р~')
							Call SaveInfoToLog('OBPC. ' || cFileFormer.sLog)
						Else
							Call SalMessageBox('Формування успішно завершено!', 'Формування файлів', 0)
					Else
						Call FOBPC_Select(19, '')
			Function: ResetImportedFiles
				Description: Сброс таблицы импортированных файлов ПЦ
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					: cOra
						Class: cABSConnect
				Actions
					If SalMessageBox("Ви дійсно бажаєте помістити в архів прийняті файли ПЦ ?", 
							   "Увага!", MB_YesNo | MB_IconExclamation | MB_DefButton2) = IDYES
						Call SalWaitCursor(TRUE)
						Call XConnectGetParams(cOra)
						If cOra.Connect()
							If SqlPLSQLCommand(cOra.hSql(), "obpc.arc_pc_files(NUMBER_Null)")
								Call SqlCommitEx(cOra.hSql(), 'OBPC. Файли ПЦ перенесены в архив!' )
								Call SalMessageBox('Архівацію завершено!', 'Інформація', 0)
							Else
								Call SqlRollbackEx(cOra.hSql(), 'OBPC. Неуспешное выполнение процедуры архивации файлов ПЦ!' )
							Call cOra.Disconnect()
						Call SalWaitCursor(FALSE)
					Return TRUE
			!
			Function: ImportReference
				Description:
				Returns
					Boolean:
				Parameters
					String: sFileName
				Static Variables
				Local variables
					Boolean: bRet
					String: sPath
					String: sFile
					File Handle: hFile
					String: sErrMsg
					String: sMsg
				Actions
					Set bRet = FALSE
					! Чтение параметров
					Call SalUseRegistry(FALSE, '')
					Call SalGetProfileString('OBPC', 'OBPCInPath', '', sPath, GetIniFileName())
					Loop
						If sFileName = STRING_Null
							Call SalMessageBox("Не задано довідник для імпорту!", "Помилка", MB_Ok | MB_IconStop)
							Call SaveInfoToLog("OBPC. Не задано довідник для імпорту!")
							Break
						Set sFile = sPath || sFileName || '.DBF'
						If not SalFileOpen(hFile, sFile, OF_Exist)
							Call SalMessageBox("Файл не знайдено: " || sFile, "Помилка", MB_Ok | MB_IconStop)
							Call SaveInfoToLog("OBPC. Файл не знайдено: " || sFile)
							Break
						! Импорт во временную таблицу
						Call SalWaitCursor(TRUE)
						If not ImportUseMomory(sPath, sFileName || '.DBF', 'PCIMP_' || sFileName, 'UKG', 1, sErrMsg)
							Break
						If not SqlPLSQLCommand(hSql(), "obpc.sync_reference(sFileName, sMsg)")
							Call SqlRollbackEx(hSql(), "OBPC. Ошибка синхронизации " || sFileName)
							Break
						Call SqlCommitEx(hSql(), "OBPC. Синхронизирован справочник " || sFileName)
						Call SalWaitCursor(FALSE)
						Call SalMessageBox("Імпорт файлу " || sFileName || " завершено", "Інформація", MB_IconAsterisk)
						If sMsg
							Call SalMessageBox(sMsg, "Інформація", MB_IconAsterisk)
						Set bRet = TRUE
						Break
					Call SalWaitCursor(FALSE)
					Return bRet
			!
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
			!
		Named Menus
			Menu: pmStatusPrint
				Resource Id: 1717
				Title:
				Description:
				Enabled when:
				Status Text:
				Menu Item Name:
				Menu Item: Распечатать статус
					Resource Id: 1718
					Keyboard Accelerator: (none)
					Status Text:
					Menu Settings
						Enabled when:
						Checked when:
					Menu Actions
						Set sFileName = GetPrnDir() || "\\" || SalFmtFormatDateTime(SalDateCurrent(), 'ddMMhhss') || '.txt'
						Call VisFileOpen(hFile, sFileName, OF_Create)
						Call VisFileWriteString(hFile, sStatusText)
						Call VisFileClose(hFile)
						Call DosDirectPrint(sFileName)
					Menu Item Name:
		Class Definitions
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
			Functional Class: cPA_PC_Former
				Description: Класс формирования файлов
						интерфейса с процессинговым центром
				Derived From
				Class Variables
				Instance Variables
					! Коорд. файла
					String: sFilePath
					String: sFileName
					! Имя файла - пусто, если файл не сформировался
					String: sFileFormed
					! Кол-во строк в файле
					Number: nRowCount
					Number: nInfoRowCount
					! Соединения
					! Для выборок
					: cMain
						Class: cABSConnect
					! Для оновлений
					: cAux
						Class: cABSConnect
					! Файл
					File Handle: hFile
					! Текстовое представление файла (текст. буфер)
					String: sFile
					! Лог. сообщений
					String: sLog
					! Сумма файла
					Number: nFileSum
					! Дата/время формирования файла
					Date/Time: dtFormDate
					! № файла
					String: sFileNo
					! Тип файла A,C
					String: sFileType
					! Код филиала
					String: sBranchCode
					! End-Of-Line
					String: sEOL
					! Заголовок
					String: rLineHeader
				Functions
					! Ключевой метод
					Function: FormFile
						Description: Формирует файл путем вызова методов класса
						Returns
							Boolean:
						Parameters
							String: pFilePath
							String: pFileName
						Static Variables
						Local variables
							Boolean: bResult
							String: sTip
							String: sCurTip
						Actions
							Set bResult = FALSE
							! Иниц. переменных класса
							Set sEOL  = SalNumberToChar(13) || SalNumberToChar(10)
							Set sLog  = ''
							Set sFile = ''
							! Др. параметры
							Set sFilePath = pFilePath
							Set sFileName = pFileName
							Set nRowCount = 0
							Set nInfoRowCount = 0
							Set dtFormDate  = SalDateCurrent()
							Set sBranchCode = GetGlobalOption('PC_KF')
							Set sFileFormed = STRING_Null
							! Формирование
							If SetDbConnect()
								Loop
									! Вид карточек
									Set sFileType = pFileName
									Set sTip = ''
									If SqlPrepareAndExecute(cMain.hSql(), 'SELECT ACC_TYPE INTO :sCurTip FROM OBPC_OUT_FILES WHERE FILE_CHAR=:sFileType')
										While SqlFetchNext(cMain.hSql(), nFetchRes)
											If not sTip
												Set sTip = "'" || sCurTip || "'"
											Else
												Set sTip = sTip || ", '" || sCurTip || "'"
									Else
										Break
									If not sTip
										Call PutLog('Задано невідомий тип файлу ' || sFileType)
										Break
									! Проверка наличия данных для формирования файла
									If not CheckForData(sTip)
										Call PutLog('Відсутні дані для формування файлу!')
										Break
									! Вычисление имени файла
									If not EvalFilename()
										Call PutLog('Помилка визначення імені файлу (EvalFilename)!')
										Break
									! Формирование файла
									If not DoBeforeFileForm()
										Call PutLog('Помилка відкриття файлу (DoBeforeFileForm)!')
										Break
									If not DoLinesHeader()
										Call PutLog('Помилка формування заголовку файлу (DoLinesHeader)!')
										Break
									If not DoLines(sTip)
										Call PutLog('Помилка формування інформаційних рядків файлу (DoLines)!')
										Break
									If not DoLinesFooter()
										Call PutLog('Помилка формування закінчення набору рядків (DoLinesFooter)!')
										Break
									If not DoAfterFileForm()
										Call PutLog('Помилка при закінченні формування файлу(DoAfterFileForm)!')
										Break
									Set bResult = TRUE
									Break
								Call CloseDbConnect()
							Return bResult
					! Методы реализации функциональности
					Function: SetDbConnect
						Description: Установка соединения с БД и подготовительные действия
								Возвр. TRUE если соед. установлено
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							Call XConnectGetParams(cMain)
							Call cAux.Clone(cMain, FALSE)
							Return cMain.Connect() AND cAux.Connect()
					Function: CloseDbConnect
						Description: Закрытие соединения с БД
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							Call cMain.Disconnect()
							Call cAux.Disconnect()
					!
					Function: CheckForData
						Description: Проверяет наличие данных для формирования файла
						Returns
							Boolean:
						Parameters
							String: sTip
						Static Variables
						Local variables
							Number: nTotal
						Actions
							Set nTotal = 0
							! Проверяем наличие данных
							If SqlPrepareAndExecute(cMain.hSql(), 
									"select count(*) into :nTotal 
									   from v_obpc_pfiles_form
									  where tip in (" || sTip || ")")
								Call SqlFetchNext(cMain.hSql(), nFetchRes)
							Return nTotal > 0
					!
					Function: EvalFilename
						Description: Вычисление имени файла
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							If not SqlPLSQLCommand(cMain.hSql(), "obpc.get_p_file_name(sFileType, sFileName)")
								Call SqlRollback(cMain.hSql())
								Return FALSE
							Return TRUE
					!
					Function: DoBeforeFileForm
						Description: Действия перед формированием файла
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							Set nFileSum = 0
							Return TRUE
					Function: DoAfterFileForm
						Description: Действия после формирования файла
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							Boolean: bOk
						Actions
							If nInfoRowCount = 0
								Call PutLog('Недостатньо даних для формування файлу!')
								Call PutLog('Черга на відправку документів по карткам даного типу в ПЦ')
								Call PutLog('містить тільки неправильні документи.')
								Call SqlRollback(cMain.hSql())
							Else If SalStrLength(sFile) > 0
								Set bOk = TRUE
								Loop
									! Открытие файла
									If not SalFileOpen(hFile, sFilePath || sFileName, OF_Create | OF_ReadWrite | OF_Share_Exclusive)
										Set bOk = FALSE
										Break
									! Пишем в файл
									Call SalFileWrite(hFile, sFile, SalStrLength(sFile))
									! Закрываем файл
									If not SalFileClose(hFile)
										Set bOk = FALSE
										Break
									Break
								If not bOk
									Call SqlRollbackEx(cAux.hSql(), 'Помилка при записі файлу: ' || sFileName)
									Return FALSE
								Call SqlCommitEx(cAux.hSql(), 'OBPC. Файл сформовано: ' || sFileName)
								Call SqlCommit(cMain.hSql())
								Set sFileFormed = sFileName
							Return TRUE
					!
					Function: DoLinesHeader
						Description: Формирование заголовка файла
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							String: rCode
							String: rFile_date
							String: rFile_time
							String: sHour
							String: sMin
							String: sSec
							String: rSource
							String: rPaym_ord_no
							String: rPaym_ord_date
							String: rPaym_ord_sum
						Actions
							! заголовок файла
							Set rCode = '00'
							Set rFile_date = SalFmtFormatDateTime(dtFormDate, 'yyyyMMdd')
							Set sHour = SalFmtFormatDateTime(dtFormDate, 'hhhh')
							Set sMin  = SalFmtFormatDateTime(dtFormDate, 'mm')
							Set sSec  = SalFmtFormatDateTime(dtFormDate, 'ss')
							Set rFile_time = SalStrRightX('00' || sHour, 2) || 
									    SalStrRightX('00' || sMin, 2) || 
									    SalStrRightX('00' || sSec, 2)
							Set rSource = ' '
							Set rPaym_ord_no = SalStrRightX('00000000' || sFileNo, 8)
							Set rPaym_ord_date = SalFmtFormatDateTime(GetBankDate(), 'yyyyMMdd')
							Set rLineHeader =
									    rCode ||
									    rFile_date ||
									    rFile_time ||
									    rSource ||
									    sFileName ||
									    rPaym_ord_no ||
									    rPaym_ord_date
							Return TRUE
					Function: DoLinesFooter
						Description: Формирование окончания набора строк
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							String: rCode
							String: rRecord_cnt
							String: rPaym_ord_sum
							String: rChek_sum
							String: rLineFooter
						Actions
							Set rCode = '99'
							Set rRecord_cnt   = PadL(SalNumberToStrX(nInfoRowCount, 0), 10)
							Set rPaym_ord_sum = PadL(VisStrSubstitute(SalNumberToStrX(nFileSum/100, 2), ',', '.'), 12)
							Set rChek_sum = rPaym_ord_sum
							Set rLineFooter =
									    rCode ||
									    rRecord_cnt ||
									    rPaym_ord_sum ||
									    rChek_sum
							Set rLineHeader = rLineHeader || rPaym_ord_sum
							Call PutLine(rLineHeader, FALSE)
							Call PutLine(rLineFooter, TRUE)
							Return TRUE
					!
					Function: DoLines
						Description: Формирование информационной строки
								Возвр. TRUE значит строка успешно сформированна
						Returns
							Boolean:
						Parameters
							String: sTip
						Static Variables
						Local variables
							Boolean: bCardAcctExists
							String: rCode
							String: rCard_no
							String: rTran_date
							String: rBill_ref_no
							String: rTran_type
							String: rAmount
							String: rCurrency
							String: rBank_code
							String: rBranch_code
							String: rWrpl_no
							String: rTab_no
							String: rInfoString
							Number: nFetchRes
							Number: nCorCount
							String: sCardAcct
							! Свойства инф. строки
							Number: dbDocType
							Number: dbRef
							Number: dbDk
							String: dbCard_Acc
							String: dbCardNo
							Date/Time: dbDat
							String: dbTt
							Number: dbAmount
							String: dbLcv
							String: dbNls
							String: dbBrn
						Actions
							If not SqlPrepareAndExecute(cMain.hSql(), 
									"select doc_type, ref, dk, card_acc, vdat, tran_type, s, lcv, nls, brn 
									   into :dbDocType, :dbRef, :dbDk, :dbCard_Acc, :dbDat, :dbTt, :dbAmount, :dbLcv, :dbNls, :dbBrn
									   from v_obpc_pfiles_form
									  where tip in (" || sTip || ") 
									  order by ref")
								Return FALSE
							While SqlFetchNext(cMain.hSql(), nFetchRes)
								Set bCardAcctExists = FALSE
								Set nCorCount = 0
								! Проверка наличия доп. рек.
								If not dbCard_Acc
									If SqlPrepareAndExecute(cAux.hSql(), 
											"select card_acct into :dbCard_Acc 
											   from v_obpc_acct
											  where lacct = :dbNls and currency = :dbLcv
											    and doc_type = :dbDocType")
										While SqlFetchNext(cAux.hSql(), nFetchRes)
											Set nCorCount = nCorCount + 1
										! в справочнике счетов obpc_acct не указан техн. счет для карточного (нет записи)
										If nCorCount = 0
											Call PutLog(IifS(dbDocType=1,"Реф.№","REC №") || SalNumberToStrX(dbRef, 0) || " - невідомий технічний рахунок.")
											Set bCardAcctExists = FALSE
										! у одного карт. счета м.б. неск. технических
										Else If nCorCount > 1
											Call PutLog(IifS(dbDocType=1,"Реф.№","REC №") || SalNumberToStrX(dbRef, 0) || " - присутній неоднозначний зв'язок з технічним рахунком.")
											Set bCardAcctExists = FALSE 
										Else
											Set bCardAcctExists = TRUE
								! Проверка правильности доп. рек."Техн. счет"
								Else
									If SqlPrepareAndExecute(cAux.hSql(), 
											"select card_acct into :sCardAcct
											   from v_obpc_acct
											  where lacct = :dbNls and currency = :dbLcv
											    and doc_type = :dbDocType")
										! если карт. счет новый, известен его техн. счет, но техн. счета еще нет в obpc_acct - проверка не нужна, на совесть вводившего доп. рекв.
										While SqlFetchNext(cAux.hSql(), nFetchRes)
											Set nCorCount = nCorCount + 1
											If dbCard_Acc = sCardAcct
												Set bCardAcctExists = TRUE 
												Break
											Else
												Call PutLog(IifS(dbDocType=1,"Реф.№","REC №") || SalNumberToStrX(dbRef, 0) || " - невірно вказано технічний рахунок.")
												Set bCardAcctExists = FALSE 
										If nCorCount = 0
											Call PutLog(IifS(dbDocType=1,"Реф.№","REC №")|| SalNumberToStrX(dbRef, 0) || " - невірно вказано технічний рахунок.")
											Set bCardAcctExists = FALSE 
								! Если определен технический счет, формируем строку
								If bCardAcctExists
									! Формирую детальную строку
									If dbCard_Acc
										Set rCode = '11'
									Else
										Set rCode = '10'
									If rCode = '10'
										Set rCard_no = PadL(dbCardNo, 19)
									Else
										Set rCard_no = PadL(dbCard_Acc, 19)
									Set rTran_date   = SalFmtFormatDateTime(dbDat, 'yyyyMMdd')
									Set rBill_ref_no = PadL('', 7)
									Set rTran_type   = PadL(dbTt, 2)
									Set rAmount      = PadL(VisStrSubstitute(SalNumberToStrX(dbAmount/100,2), ',', '.'), 12)
									Set rCurrency    = PadL(dbLcv, 3)
									! Главное ОПЕРУ
									! Set rBank_code   = '04'
									! Set rBranch_code = '000'
									! Set rBranch_code = SalStrRightX('000' || sBranchCode, 3)
									If Len(dbBrn) != 5 or Subs(dbBrn,1,2) != '04'
										Set rBranch_code = '04' || SalStrRightX('000' || sBranchCode, 3)
									Else
										Set rBranch_code = dbBrn
									! UserId
									Set rWrpl_no = SalStrRightX('   ', 3)
									Set rTab_no  = SalStrRightX('   ', 3)
									Set rInfoString =
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
									! Вычисляем сумму файла
									Set nFileSum      = nFileSum + dbAmount
									Set nInfoRowCount = nInfoRowCount + 1
									If not SqlPLSQLCommand(cAux.hSql(), "obpc.set_form_flag(dbDocType, dbRef, dbDk, sFileName, dtFormDate, dbCard_Acc, dbTt, dbAmount)")
										Call SqlRollbackEx(cAux.hSql(), 'Помилка на obpc.set_form_flag - ' || IifS(dbDocType=1,"Реф.№","REC №") ||Str(dbRef))
										Return FALSE
									Call PutLine(rInfoString, TRUE)
							Return TRUE
					!
					Function: PutLine
						Description: Вставка строки в файл
						Returns
							Boolean:
						Parameters
							String: sString
							Boolean: fToTheEnd
						Static Variables
						Local variables
						Actions
							If SalStrLength(sString) > 0
								If SalStrLength(sFile) > 0
									If fToTheEnd
										Set sFile = sFile || sEOL || sString
									Else
										Set sFile = sString || sEOL || sFile
								Else
									Set sFile = sString
								Set nRowCount = nRowCount + 1
							Return TRUE
					Function: PutLog
						Description: Вставка строки в ЛОГ
						Returns
							Boolean:
						Parameters
							String: sString
						Static Variables
						Local variables
						Actions
							If SalStrLength(sString) > 0
								If SalStrLength(sLog) > 0
									Set sLog = sLog || sEOL || sString
								Else
									Set sLog = sString
							Return TRUE
			Functional Class: cFilesImporter
				Description: Импорт файла с разделителями колонок
						Ключ. свойства
						 sSeparator	- Разделитель колонок
						 nValueCount	- Количество колонок
						 sValues	- Значения колонок
						Ключ. методы
						 Open		- Открыть файл
						 Close		- Закрыть файл
						 FetchNext	- Прочитать след. строку
				Derived From
				Class Variables
				Instance Variables
					! Разделитель колонок
					String: sSeparator
					! Количество колонок
					Number: nValueCount
					! Значения колонок
					String: sValues[*]
					! Внутр. свойства
					File Handle: hFile
					Boolean: fActive
				Functions
					! Открыть файл
					Function: Open
						Description:
						Returns
							Boolean:
						Parameters
							String: sFileName
							String: aSeparator
						Static Variables
						Local variables
						Actions
							If SalFileOpen( hFile, sFileName, OF_Read | OF_Text )
								Set sSeparator = aSeparator
								Set fActive    = TRUE
								Return TRUE
							Return FALSE
					! Закрыть файл
					Function: Close
						Description:
						Returns
						Parameters
						Static Variables
						Local variables
						Actions
							Call SalFileClose( hFile )
							Set fActive=TRUE
							Set nValueCount=0
							Call SalArraySetUpperBound( sValues, 1, -1 )
					! Прочитать след. строку
					Function: FetchNext
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							String: sLine
						Actions
							If fActive
								If SalFileGetStr( hFile, sLine, 1024 )
									Call SalArraySetUpperBound( sValues, 1, -1 )
									Set nValueCount=SalStrTokenize( sLine, sSeparator, sSeparator, sValues )
									If nValueCount>0
										Return TRUE
							Else
								Return FALSE
			! Functional Class: cBPKProduct
.winattr
.end
				            Description: 
				            Derived From 
				            Class Variables 
				            Instance Variables 
					            Number: nId
					            String: sName
					            String: sType
					            Number: nKv
					            String: sLcv
					            String: sKk
					            String: sCondSet
					            String: sCondSetName
					            Number: nCValidity
					            Number: nDebIntr
					            Number: nOlimIntr
					            Number: nCredIntr
					            String: sNbs
					            String: sOb22
					            Number: nLimit
					            String: sIdDoc
					            String: sIdDocCred
				            Functions 
					            Function: setProduct
						            Description: 
						            Returns 
						            Parameters 
							            Number: nProductId
						            Static Variables 
						            Local variables 
						            Actions 
							            Set nId = 
							            Set sName = 
							            Set sType = 
							            Set nKv   = 
							            Set sLcv  =
							            Set sKk   = 
							            Set sCondSet = 
							            Set sCondSetName = 
							            Set nCValidity = 
							            Set nDebIntr = 
							            Set nOlimIntr =
							            Set nCredIntr = 
							            Set sNbs = 
							            Set sOb22 = 
							            Set nLimit = 
							            Set sIdDoc = 
							            Set sIdDocCred = 
							            Call setProduct(colId, colName, colType, colTypeName, 
									     colKv, colKk, colKkName, colCondSet, colCondSetName,
									     colCValidity, colDebIntr, colOlimIntr, colCredIntr,
									     colNbs, colNbsName, colOb22, colOb22Name, colLimit,
									     colIdDoc, colIdDocCred)
		Default Classes
			MDI Window: cBaseMDI
			Form Window:
			Dialog Box:
			Table Window:
			Quest Window:
			Data Field:
			Spin Field:
			Multiline Field:
			Pushbutton: cpbRefresh
			Radio Button: cRadioButtonLabeled
			Option Button:
			Check Box: cCheckBoxLabeled
			Child Table:
			Quest Child Window: cQuickDatabase
			List Box:
			Combo Box: cGenComboBox_StrId
			Picture:
			Vertical Scroll Bar:
			Horizontal Scroll Bar:
			Column:
			Background Text:
			Group Box:
			Line:
			Frame:
			Custom Control: cMeter
		Application Actions
	! Импорт/Экспорт
	Form Window: frm_ImportPCFiles
		Class:
		Property Template:
		Class DLL Name:
		Title: Імпорт файлів ПЦ
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
				Width:  7.0"
				Width Editable? Yes
				Height: 3.8"
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
		Description: Импорт файлов процессингового центра
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
			Background Text: XXXX_
				Resource Id: 13685
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   1.0"
					Top:    0.1"
					Width:  1.2"
					Width Editable? Yes
					Height: 0.31"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Courier New CYR
				Font Size: 16
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Background Text: .DBF
				Resource Id: 13686
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   3.4"
					Top:    0.1"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.31"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: Courier New CYR
				Font Size: 16
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
					Maximum Data Length: 3
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   2.3"
						Top:    0.08"
						Width:  1.0"
						Width Editable? Yes
						Height: 0.35"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Center
					Format: Unformatted
					Country: Default
					Font Name: Courier New CYR
					Font Size: 16
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Pushbutton: pbExecute
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbExecute
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   4.5"
					Top:    0.1"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Enter
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
						Call SalWaitCursor(TRUE)
						Call SaveInfoToLog("OBPC. Пользователь выбрал Обработку файлов")
						Call ImportPCFiles()
						Call SalWaitCursor(FALSE)
			Pushbutton: pbImpOnly
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Тільки імпорт
				Window Location and Size
					Left:   5.0"
					Top:    0.1"
					Width:  1.5"
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
						Call SaveInfoToLog("OBPC. Пользователь выбрал Только импорт")
						Call ImportDBFData()
			Line
				Resource Id: 13687
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Coordinates
					Begin X:  0.05"
					Begin Y:  1.25"
					End X:  6.65"
					End Y:  1.25"
				Visible? Yes
				Line Style: Etched
				Line Thickness: 2
				Line Color: Default
			Check Box: cbImpAcc
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Імпорт файлу рахунків
				Window Location and Size
					Left:   0.3"
					Top:    0.6"
					Width:  6.2"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: 12
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
				Message Actions
			Check Box: cbImpOper
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Імпорт файлу операцій
				Window Location and Size
					Left:   0.3"
					Top:    0.9"
					Width:  6.2"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: 12
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
				Message Actions
			Line
				Resource Id: 13688
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Coordinates
					Begin X:  0.05"
					Begin Y:  2.3"
					End X:  6.65"
					End Y:  2.3"
				Visible? Yes
				Line Style: Etched
				Line Thickness: 2
				Line Color: Default
			Check Box: cbParams
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Оновлення параметрів карткових рахунків
				Window Location and Size
					Left:   0.3"
					Top:    1.35"
					Width:  6.2"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: 12
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
				Message Actions
			Check Box: cbComplete
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Квитовка операцій банку
				Window Location and Size
					Left:   0.3"
					Top:    1.65"
					Width:  6.2"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: 12
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
				Message Actions
			Check Box: cbPay
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Оплата операцій ПЦ
				Window Location and Size
					Left:   0.3"
					Top:    1.95"
					Width:  6.2"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: 12
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
				Message Actions
			Line
				Resource Id: 41575
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Coordinates
					Begin X:  0.05"
					Begin Y:  2.75"
					End X:  6.65"
					End Y:  2.75"
				Visible? Yes
				Line Style: Etched
				Line Thickness: 2
				Line Color: Default
			Check Box: cbCheck
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Перевірка цілістності даних
				Window Location and Size
					Left:   0.3"
					Top:    2.4"
					Width:  6.2"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: 12
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
				Message Actions
			Line
				Resource Id: 26202
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Coordinates
					Begin X:  0.05"
					Begin Y:  3.2"
					End X:  6.65"
					End Y:  3.2"
				Visible? Yes
				Line Style: Etched
				Line Thickness: 2
				Line Color: Default
			Custom Control: ccMeter
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cMeter
				Property Template:
				Class DLL Name:
				Display Settings
					DLL Name:
					MS Windows Class Name:
					Style:  Class Default
					ExStyle:  Class Default
					Title:
					Window Location and Size
						Left:   0.1"
						Top:    2.85"
						Width:  6.55"
						Width Editable? Class Default
						Height: 0.25"
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
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Green
					Background Color: Dark Gray
					DLL Settings
				Message Actions
					On SAM_User
						! Прогресс
						If wParam = 0
							If (nDone <= nTotal) AND (nTotal != 0)
								Call ccMeter.SetProgress( nDone/nTotal*100 )
							Else
								Call ccMeter.SetProgress( 100 )
						! Сброс
						Else If wParam = 1
							Call ccMeter.SetProgress( 0 )
						! 100%
						Else If wParam = 2
							Call ccMeter.SetProgress( 100 )
			Line
				Resource Id: 13689
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Coordinates
					Begin X:  0.05"
					Begin Y:  0.5"
					End X:  6.65"
					End Y:  0.5"
				Visible? Yes
				Line Style: Etched
				Line Thickness: 2
				Line Color: Default
		Functions
			Function: InitInfoWindow
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
				Actions
					Call SalHideWindow(cbImpAcc)
					Call SalHideWindow(cbImpOper)
					Call SalHideWindow(cbParams)
					Call SalHideWindow(cbComplete)
					Call SalHideWindow(cbPay)
					Call SalHideWindow(cbCheck)
					Call SalHideWindow(ccMeter)
					Set cbImpAcc   = FALSE
					Set cbImpOper  = FALSE
					Set cbParams   = FALSE
					Set cbComplete = FALSE
					Set cbPay      = FALSE
					Set cbCheck    = FALSE
					Call SalDisableWindow(cbImpAcc)
					Call SalDisableWindow(cbImpOper)
					Call SalDisableWindow(cbParams)
					Call SalDisableWindow(cbComplete)
					Call SalDisableWindow(cbPay)
					Call SalDisableWindow(cbCheck)
					Set sLog = ''
					Return TRUE
			Function: ImportPCFiles
				Description: Импорт файлов пришедших из ПЦ=
						Квитовка собственных операций
						+
						Оплата новых
				Returns
				Parameters
				Static Variables
				Local variables
					Number: nFileId
				Actions
					! Инициализация интерфейса
					Call InitInfoWindow()
					If IsBankDayOpen()
						If dfFileName
							! Инициализация индикатора
							Set nDone  = 0
							Set nTotal = 4
							Call SalShowWindow(ccMeter)
							Call SalSendMsg(ccMeter, SAM_User, 1, 0)
							Set nFileId = ImportData(SalStrUpperX(dfFileName), FALSE)
							! Импорт выполнен
							If nFileId > 0
								! Установка параметров
								Call SetAccParams(nFileId)
								! Квитовка операций банка
								Call CompleteOpers(nFileId)
								! Оплата операций ПЦ
								Call PayOpers(nFileId)
								! Проверки
								Call CheckAcctTran(nFileId)
								! Log
								If not sLog
									Set sLog = 'Файли успішно оброблено'
								Call SalModalDialog(dlgStatus, hWndForm, sLog, 'Статус імпорту файлів ПЦ')
								Call SaveInfoToLog('OBPC. ' || sLog)
							! Ощибка при импорте
							Else If nFileId = 0
								Call SalMessageBox("Імпорт припинений", "Увага!", MB_IconExclamation | MB_Ok)
							! Импорт не производился
							Else If nFileId < 0
							Call SalHideWindow(ccMeter)
					Else
						Call SalMessageBox("Банківський день закрито!", "Увага!", MB_Ok | MB_IconStop)
			Function: ImportDBFData
				Description: Импорт файлов пришедших из ПЦ
				Returns
				Parameters
				Static Variables
				Local variables
					Number: nFileId
				Actions
					! Инициализация интерфейса
					Call InitInfoWindow()
					If IsBankDayOpen()
						If dfFileName
							! Инициализация индикатора
							Call SalShowWindow(ccMeter)
							Set nDone  = 0
							Set nTotal = 4
							Call SalShowWindow(ccMeter)
							Call SalSendMsg(ccMeter, SAM_User, 1, 0)
							Set nFileId = ImportData(SalStrUpperX(dfFileName), TRUE)
							If nFileId > 0
								Set sLog = 'Файли успішно проімпортовано'
								Call SalModalDialog(dlgStatus, hWndForm, sLog, 'Статус імпорту файлів ПЦ')
							Call SalHideWindow(ccMeter)
					Else
						Call SalMessageBox("Банківський день закрито!", "Увага!", MB_Ok | MB_IconStop)
			Function: ImportData
				Description: Импорт информации из DBF во временные таблицы
				Returns
					Number:
				Parameters
					String: sFileSufix
					Boolean: bImpOnly
				Static Variables
				Local variables
					String: sErrMsg
					! Путь
					String: sPath
					! Файл (для проверки существования)
					File Handle: hFile
					! Имя файла счетов
					String: sAcctFile
					! Имя файла операций
					String: sTranFile
					! Понты
					Number: nFetchRes
					! Код файла
					Number: nFileId
					! Результат этой функции
					Number: Result
				Actions
					Set Result  = 0
					Set nFileId = 0
					! Чтение параметров
					Call SalUseRegistry(FALSE, '')
					Call SalGetProfileString('OBPC', 'OBPCInPath', '', sPath, GetIniFileName())
					!
					Loop
						! Проверка повторного импортирования
						If SqlPrepareAndExecute(hSql(), "SELECT id INTO :nFileId FROM OBPC_FILES WHERE FILE_NAME = :sFileSufix and nvl(arc,0) = 0")
							If SqlFetchNext(hSql(), nFetchRes)
								! Файл уже импортился
								If nFileId
									If bImpOnly
										Call SalMessageBox( 
												     "Файл " || sFileSufix || " вже імпортувався!",
												     "Увага!", MB_Ok | MB_IconStop)
										Set Result = -1
										Call SaveInfoToLog("OBPC. Файл " || sFileSufix || " вже імпортувався!")
										Break
									Else
										If SalMessageBox( 
												   "Файл " || sFileSufix || " вже імпортувався!" || PutCrLf() ||
												   "Провести повторну обробку даних в БД?",
												   "Увага!", MB_YesNo | MB_IconQuestion) = IDYES
											Call SaveInfoToLog("OBPC. Повторная обработка файла " || sFileSufix)
											Set Result = nFileId
											Break
										Else
											Set Result = -1
											Call SaveInfoToLog("OBPC. Пользователь отказался от повторной обработки файла " || sFileSufix)
											Break
						! Нахожу файлы
						Set sAcctFile = sPath || 'ACCT_' || sFileSufix || '.DBF'
						Set sTranFile = sPath || 'TRAN_' || sFileSufix || '.DBF'
						If SalFileOpen(hFile, sAcctFile, OF_Exist) AND
								   SalFileOpen(hFile, sTranFile, OF_Exist)
							! =============================================
							Set sAcctFile = 'ACCT_' || sFileSufix
							Set sTranFile = 'TRAN_' || sFileSufix
							Set nDone = nDone + 1
							Call SalSendMsg(ccMeter, SAM_User, 0, 0)
							! =============================================
							! Счета
							Call SaveInfoToLog("OBPC. Импорт файла счетов.")
							! Показываем пункт
							Call SalShowWindow(cbImpAcc)
							Call SalUpdateWindow(hWndForm)
							! Импорт во временную таблицу
							If not ImportUseMomory(sPath, sAcctFile || '.DBF', 'TEST_OBPC_ACCT_' || sBankMfo, 'UKG', 1, sErrMsg)
								Call SalMessageBox("Помилка імпорту файла " || sAcctFile || '.DBF ' || sErrMsg,
										     "Помилка", MB_Ok | MB_IconStop )
								Call SaveInfoToLog("OBPC. " || "Помилка імпору файла " || sAcctFile || '.DBF: ' || sErrMsg)
								Break
							! Отметка об импорте
							Set cbImpAcc = TRUE
							Call SalUpdateWindow(hWndForm)
							Set nDone = nDone + 1
							Call SalSendMsg(ccMeter, SAM_User, 0, 0)
							Call SaveInfoToLog("OBPC. Импорт файла счетов окончен")
							! =============================================
							! Операции
							Call SaveInfoToLog("OBPC. Импорт файла операций.")
							! Показываем пункт
							Call SalShowWindow(cbImpOper)
							Call SalUpdateWindow(hWndForm)
							! Импорт во временную таблицу
							If not ImportUseMomory(sPath, sTranFile || '.DBF', 'TEST_OBPC_TRAN_' || sBankMfo, 'UKG', 1, sErrMsg)
								Call SalMessageBox("Помилка імпорту файла " || sTranFile || '.DBF ' || sErrMsg,
										     "Помилка", MB_Ok | MB_IconStop )
								Call SaveInfoToLog("OBPC. " || "Помилка імпору файла " || sAcctFile || '.DBF: ' || sErrMsg)
								Break
							! Отметка об импорте
							Set cbImpOper = TRUE
							Call SalUpdateWindow(hWndForm)
							Set nDone = nDone + 1
							Call SalSendMsg(ccMeter, SAM_User, 0, 0)
							Call SaveInfoToLog("OBPC. Импорт файла операций окончен")
							! =============================================
							! Импорт в табл. obpc* 
							If SqlPLSQLCommand(hSql(), "obpc.import_data(sFileSufix, nFileId)")
								Set Result = nFileId
							Set nDone = nDone + 1
							Call SalSendMsg(ccMeter, SAM_User, 0, 0)
							! =============================================
							! Commit/Rollback
							If Result
								Call SqlCommitEx(hSql(), "OBPC. Успешный импорт файла " || sFileSufix)
								! =============================================
								! Переименование файлов
								Call VisFileRename(
										     sPath || 'ACCT_' || sFileSufix || '.DBF', 
										     sPath || 'ACCT_' || sFileSufix || '.OLD' )
								Call VisFileRename(
										     sPath || 'TRAN_' || sFileSufix || '.DBF', 
										     sPath || 'TRAN_' || sFileSufix || '.OLD' )
								! =============================================
							Else
								Call SqlRollbackEx(hSql(), "OBPC. Неуспешный импорт файла " || sFileSufix)
							! =============================================
							Call SalSendMsg(ccMeter, SAM_User, 2, 0)
						Else
							Call SalMessageBox("Один або обидва файли не існують: " || sAcctFile || ", " || sTranFile || "." ,
									     "Помилка", MB_Ok | MB_IconStop )
							Call SaveInfoToLog("OBPC. Один или оба файла не существуют: " || sAcctFile || ", " || sTranFile)
							Set Result = -1
							Break
						Break
					!
					Return Result
			Function: SetAccParams
				Description: Фаза установки лимитов на счетах
				Returns
				Parameters
					Number: nFileId
				Static Variables
				Local variables
				Actions
					Call SaveInfoToLog("OBPC. Обновление параметров счетов по файлу acct.")
					! Показываем пункт
					Call SalShowWindow(cbParams)
					Call SalUpdateWindow(hWndForm)
					! Установка лимитов
					If not SqlPLSQLCommand(hSql(), "obpc.set_acc_params(nFileId)")
						Call SqlRollbackEx(hSql(), "OBPC. Ощибка выполнения процедуры обновления параметров счетов по файлу acct.")
					Else
						Call SqlCommitEx(hSql(), "OBPC. Выполнено обновление параметров счетов по файлу acct.")
						! Отметка об окончании
						Set cbParams = TRUE
					Call SalUpdateWindow(hWndForm)
					! Перечитываем индикатор
					Set nDone = nDone + 1
					Call SalSendMsg(ccMeter, SAM_User, 0, 0)
					Return TRUE
			Function: CompleteOpers
				Description: Фаза квитовки операций
				Returns
				Parameters
					Number: nFileId
				Static Variables
				Local variables
					Number: nCount
				Actions
					Call SaveInfoToLog("OBPC. Квитовка операций банка.")
					! Показываем пункт
					Call SalShowWindow(cbComplete)
					Call SalUpdateWindow(hWndForm)
					! Квитовка операций
					If not SqlPLSQLCommand(hSql(), "obpc.kvt_oper(nFileId)")
						Call SqlRollbackEx(hSql(), "OBPC. Неуспешное выполнение процедуры квитовки операций банка")
					Else
						Call SqlCommitEx(hSql(), "OBPC. Выполнена процедура квитовки операций банка")
						! Отметка об окончании квитовки операций
						Set cbComplete = TRUE
					Call SalUpdateWindow(hWndForm)
					! Перечитываем индикатор
					Set nDone = nDone + 1
					Call SalSendMsg(ccMeter, SAM_User, 0, 0)
					Return TRUE
			Function: PayOpers
				Description: Фаза оплаты операций ПЦ
				Returns
					Boolean:
				Parameters
					Number: nFileId
				Static Variables
				Local variables
				Actions
					Call SaveInfoToLog("OBPC. Оплата операций ПЦ.")
					! Показываем пункт
					Call SalShowWindow(cbPay)
					Call SalUpdateWindow(hWndForm)
					! Оплата операций
					If not SqlPLSQLCommand(hSql(), "obpc.pay_oper(nFileId)")
						Call SqlRollbackEx(hSql(), "OBPC. Неуспешное выполнение процедуры оплаты операций ПЦ")
					Else
						Call SqlCommitEx(hSql(), "OBPC. Выполнена процедура оплаты операций ПЦ")
						! Отметка об окончании оплаты
						Set cbPay = TRUE
					Call SalUpdateWindow(hWndForm)
					! Перечитываем индикатор
					Set nDone = nDone + 1
					Call SalSendMsg(ccMeter, SAM_User, 0, 0)
					Return TRUE
			! Проверка целостности
			Function: CheckAcctTran
				Description: проверки после обработки файлов
				Returns
					Boolean:
				Parameters
					Number: nFileId
				Static Variables
				Local variables
					: cMain
						Class: cABSConnect
					: cAux
						Class: cABSConnect
					Number: nFetchRes
					Number: nCount
					! Свойства документа для оплаты
					String: sTt
					String: sTtAll
					!
					String: sDataList
					Number: nDataCount
					!
					Boolean: fError
					!
					Date/Time: dBDate
				Actions
					Call XConnectGetParams(cMain)
					Call cAux.Clone(cMain, FALSE)
					If cMain.Connect() AND cAux.Connect()
						! Инициализация индикатора
						Call SalShowWindow(ccMeter)
						Set nDone  = 0
						Set nTotal = 10
						Call SalSendMsg(ccMeter, SAM_User, 1, 0)
						Call SalShowWindow(cbCheck)
						Call SalUpdateWindow(hWndForm)
						! 1: Проверка несквитованных документов банка
						If SqlPrepareAndExecute(cMain.hSql(), "SELECT COUNT(*) INTO :nCount FROM PKK_QUE WHERE sos=1")
							If SqlFetchNext(cMain.hSql(), nFetchRes) 
								If nCount
									Call PutLog(SalNumberToStrX(nCount, 0) || ' несквітованних документів БАНКА після квітовки!')
						Set nDone = nDone + 1
						Call SalSendMsg(ccMeter, SAM_User, 0, 0)
						! 2: Проверка несквитованных документов ПЦ
						If SqlPrepareAndExecute(hSql(),
								"SELECT COUNT(*) INTO :nCount
								   FROM OBPC_TRAN A, OBPC_TRANS B
								  WHERE a.id = :nFileId
								    AND a.tran_type = b.tran_type AND b.bof = 1")
							If SqlFetchNext(hSql(), nFetchRes)
								If nCount
									Call PutLog(SalNumberToStrX(nCount, 0) || ' несквітованих документів ПЦ після квітовки!')
						Set nDone = nDone + 1
						Call SalSendMsg(ccMeter, SAM_User, 0, 0)
						! 3: Проверка необработанных документов ПЦ
						If SqlPrepareAndExecute(cMain.hSql(), 
								"SELECT COUNT(*) INTO :nCount
								   FROM OBPC_TRAN A, OBPC_TRANS B
								  WHERE a.id = :nFileId 
								    AND a.tran_type = b.tran_type AND b.bof = 0 ")
							If SqlFetchNext(cMain.hSql(), nFetchRes) 
								If nCount
									Call PutLog(SalNumberToStrX(nCount, 0) || ' необроблених документів ПЦ після оплати.')
						Set nDone = nDone + 1
						Call SalSendMsg(ccMeter, SAM_User, 0, 0)
						! 4: Проверка необработанных документов (всего)
						If SqlPrepareAndExecute(cMain.hSql(), 
								"SELECT COUNT(*) INTO :nCount
								   FROM OBPC_TRAN A
								  WHERE a.id = :nFileId")
							If SqlFetchNext(cMain.hSql(), nFetchRes) 
								If nCount
									Call PutLog('ВСЬОГО ' || SalNumberToStrX(nCount, 0) || ' необроблених документів після імпорту.')
						Set nDone = nDone + 1
						Call SalSendMsg(ccMeter, SAM_User, 0, 0)
						! 5: Проверка настройки импортных операций
						If SqlPrepareAndExecute(cMain.hSql(), 
								"SELECT DISTINCT A.TRAN_TYPE INTO :sTt 
								   FROM OBPC_TRAN A, OBPC_TRANS B 
								  WHERE a.id = :nFileId
								    AND a.tran_type = b.tran_type AND b.bof = 0 
								    AND ( b.tran_type not in (select tran_type from obpc_trans_in)
								       or b.tran_type in (select tran_type from obpc_trans_in where tt is null) )
								 ORDER BY tran_type")
							Set sTtAll = ''
							While SqlFetchNext(cMain.hSql(), nFetchRes) 
								If sTtAll
									Set sTtAll = sTtAll || ',' || sTt
								Else
									Set sTtAll = sTt
							If sTtAll
								Call PutLog('Для слід. типів операцій ПЦ не задано види операцій:')
								Call PutLog(sTtAll || '.')
						Set nDone = nDone + 1
						Call SalSendMsg(ccMeter, SAM_User, 0, 0)
						! 6: Проверка транзитных счетов
						If SqlPrepareAndExecute(cMain.hSql(), 
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
							Set sTtAll = ''
							While SqlFetchNext(cMain.hSql(), nFetchRes) 
								If sTtAll
									Set sTtAll = sTtAll || PutCrLf() || sTt
								Else
									Set sTtAll = sTt
							If sTtAll
								Call PutLog('Для слід. типів операцій ПЦ не задано транзитний рахунок:')
								Call PutLog(sTtAll)
						Set nDone = nDone + 1
						Call SalSendMsg(ccMeter, SAM_User, 0, 0)
						! Проверка целостности
						! 7: Проверка закрытых счетов, по кот. шли операции
						If CheckIntegrity(cMain.hSql(),
								"select unique a.tobo || '   ' || a.nls || ' ' || o.currency
								   into :sData
								   from accounts a, obpc_acct o, obpc_tran t
								  where t.id = " || Str(nFileId) || "
								    and t.card_acct = o.card_acct
								    and o.acc = a.acc
								    and a.dazs is not null
								  order by 1", sDataList, nDataCount)
							If sDataList
								Call PutLog('Рахунки, закриті в АБС, по яким були операції в TRAN*.dbf:' || sEOL || sDataList)
						Set nDone = nDone + 1
						Call SalSendMsg(ccMeter, SAM_User, 0, 0)
						! 8: Бал. счета из ACCT_*.DBF не открытые в АБС
						If CheckIntegrity(cMain.hSql(),
								"select unique a.branch || '   ' || a.lacct || ' ' || a.currency INTO :sData 
								   from obpc_acct a, obpc_tran t
								  where t.id = " || Str(nFileId) || "
								    and t.card_acct = a.card_acct
								    and a.acc is null
								    and nvl(a.status,'0') <> '4'
								  order by 1", sDataList, nDataCount)
							If nDataCount > 500
								Call PutLog('Більше 500 карт. рахунків з ACCT_*.DBF не відкрито в АБС!')
							Else If sDataList
								Call PutLog('Карт. рахунки з ACCT_*.DBF не відкриті в АБС:' || sEOL || sDataList)
						Set nDone = nDone + 1
						Call SalSendMsg(ccMeter, SAM_User, 0, 0)
						! 9: Тех. счета из TRAN_*.DBF отсутствующие в ACCT_*.DBF
						If CheckIntegrity(cMain.hSql(),
								"SELECT DISTINCT card_acct INTO :sData 
								   FROM OBPC_TRAN 
								  WHERE id = " || Str(nFileId) || "
								    AND card_acct NOT IN (SELECT card_acct FROM OBPC_ACCT)", sDataList, nDataCount)
							If nDataCount > 500
								Call PutLog('Більше 500 тех. рахунків з TRAN_*.DBF відсутні в ACCT_*.DBF!')
							Else If sDataList
								Call PutLog('Тех. рахунки з TRAN_*.DBF відсутні в ACCT_*.DBF:' || sEOL || sDataList)
						Set nDone = nDone + 1
						Call SalSendMsg(ccMeter, SAM_User, 0, 0)
						Set cbCheck = TRUE
						Call SalUpdateWindow(hWndForm)
					Return TRUE
			Function: CheckIntegrity
				Description:
				Returns
					Boolean:
				Parameters
					Sql Handle: hSql
					String: sSqlText
					Receive String: sOverideList
					Receive Number: nOverideCount
				Static Variables
				Local variables
					String: sData
					Number: nFetchRes
				Actions
					Set nOverideCount = 0
					Set sOverideList  = ''
					If SqlPrepareAndExecute(hSql, sSqlText)
						While SqlFetchNext(hSql, nFetchRes)
							If sOverideList
								Set sOverideList = sOverideList || ',' || sEOL || sData
							Else
								Set sOverideList = sData
							Set nOverideCount = nOverideCount + 1
							If nOverideCount > 500
								Break
					Return nOverideCount > 0
			Function: PutLog
				Description: Вставка строки в ЛОГ
				Returns
					Boolean:
				Parameters
					String: sString
				Static Variables
				Local variables
				Actions
					If SalStrLength(sString) > 0
						If SalStrLength(sLog) > 0
							Set sLog = sLog || sEOL || sString
						Else
							Set sLog = sString
		Window Parameters
		Window Variables
			Number: nHAVETOBO
			! Для прогресс-индикатора
			Number: nTotal
			Number: nDone
			! Log
			String: sLog
			!
			Boolean: fLogCalled
			!
			String: sEOL
			String: sBankMfo
		Message Actions
			On SAM_Create
				Set nHAVETOBO = GetGlobalOptionEx('HAVETOBO')
				Set sEOL = SalNumberToChar(13) || SalNumberToChar(10)
				Call PrepareWindowEx(hWndForm)
				Call SalHideWindow(pbImpOnly)
				Set fLogCalled = FALSE
				! Инициализация интерфейса
				Call InitInfoWindow()
				!
			On SAM_CreateComplete
				If nHAVETOBO = 2
					If not SqlPrepareAndExecute(hSql(), "select substr(bc.extract_mfo,1,6) into :sBankMfo from dual")
							or not SqlFetchNext(hSql(), nFetchRes)
						Call SalDestroyWindow(hWndForm)
	!
	Form Window: frm_ImportInternalTasks
		Class:
		Property Template:
		Class DLL Name:
		Title: Импорт файлов локальных задач
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
				Width:  8.6"
				Width Editable? Yes
				Height: 4.5"
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
		Description: Импорт файлов локальных задач
				Зарплата и депозиты
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
			! Background Text: Транзит З/П:
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.117"
					Top:    0.06"
					Width:  2.767"
					Width Editable? Yes
					Height: 0.262"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: Courier New CYR
				Font Size: 16
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
.end
			! Group Box: Счет З/П
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    0.1"
					Width:  4.0"
					Width Editable? Yes
					Height: 0.65"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
.end
			Background Text: Счет З/П
				Resource Id: 51468
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    0.1"
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
			Data Field: dfTransNls
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
						Left:   0.2"
						Top:    0.35"
						Width:  3.0"
						Width Editable? Yes
						Height: 0.286"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Courier New CYR
					Font Size: 12
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_Validate
						If not SalIsNull(dfTransNls)
							Call SqlPrepareAndExecute(hSql(), "select acc, nms into :nTransAcc, :sTransNms from accounts where nls = :dfTransNls and kv = 980")
							If not SqlFetchNext(hSql(), nFetchRes)
								Call SalMessageBox("Счет " || dfTransNls || "/UAH не найден!", "Внимание!", MB_IconStop | MB_Ok)
								Return VALIDATE_Cancel
							Call SalSetWindowLabelText(bgTransNms, sTransNms)
						Return VALIDATE_Ok
			Background Text: Название счета
				Resource Id: 51467
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   3.3"
					Top:    0.4"
					Width:  5.0"
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
			Data Field: bgTransNms
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
			!
			Group Box: Справочник счетов-клиентов
				Resource Id: 38655
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    0.8"
					Width:  4.0"
					Width Editable? Yes
					Height: 1.0"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfSpravFile
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 8
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   0.2"
						Top:    1.05"
						Width:  2.0"
						Width Editable? Yes
						Height: 0.3"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Courier New CYR
					Font Size: 16
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: .TXT
				Resource Id: 38652
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   2.25"
					Top:    1.1"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.3"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: Courier New CYR
				Font Size: 16
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Check Box: cbImportSprav
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Импорт
				Window Location and Size
					Left:   0.2"
					Top:    1.45"
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
			Pushbutton: pbAll
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbExecute
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   3.4"
					Top:    1.05"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: (none)
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
						Call SalWaitCursor(TRUE)
						Call ImportInFiles(TRUE, TRUE)
						Call SalWaitCursor(FALSE)
					On SAM_Create
						Set strTip = 'Выполнить импорт зарплаты и депозитов'
			Pushbutton: pbCheck
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbRelation
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   3.4"
					Top:    1.4"
					Width:  0.4"
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
						Call SalWaitCursor(TRUE)
						Call PeformIntegrityCheck()
						Call SalWaitCursor(FALSE)
					On SAM_Create
						Set strTip = 'Проверка целостности данных'
			!
			Group Box: Начисление З/П
				Resource Id: 38656
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    1.9"
					Width:  4.0"
					Width Editable? Yes
					Height: 1.0"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfElplatFile
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 8
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   0.2"
						Top:    2.15"
						Width:  2.0"
						Width Editable? Yes
						Height: 0.3"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Courier New CYR
					Font Size: 16
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: .TXT
				Resource Id: 38654
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   2.25"
					Top:    3.3"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.3"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: Courier New CYR
				Font Size: 16
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Check Box: cbImportElplat
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Импорт
				Window Location and Size
					Left:   0.2"
					Top:    2.55"
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
			Pushbutton: pbExecutePlat
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbExecute
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   3.4"
					Top:    2.15"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: (none)
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
						Call SalWaitCursor(TRUE)
						Call ImportInFiles(TRUE, FALSE)
						Call SalWaitCursor(FALSE)
					On SAM_Create
						Set strTip = 'Выполнить импорт зарплаты'
			!
			Group Box: Начисление ДЕПОЗИТОВ
				Resource Id: 38657
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    3.0"
					Width:  4.0"
					Width Editable? Yes
					Height: 1.0"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Background Text: DP
				Resource Id: 38653
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    3.3"
					Width:  0.5"
					Width Editable? Yes
					Height: 0.3"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: Courier New CYR
				Font Size: 16
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfDpFile
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 6
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   0.7"
						Top:    3.25"
						Width:  1.5"
						Width Editable? Yes
						Height: 0.3"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Courier New CYR
					Font Size: 16
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: .TXT
				Resource Id: 38658
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   2.25"
					Top:    2.2"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.3"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: Courier New CYR
				Font Size: 16
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Check Box: cbImportDp
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Импорт
				Window Location and Size
					Left:   0.2"
					Top:    3.65"
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
			Pushbutton: pbExecuteDep
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbExecute
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   3.383"
					Top:    3.25"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: (none)
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
						Call SalWaitCursor(TRUE)
						Call ImportInFiles(FALSE, TRUE)
						Call SalWaitCursor(FALSE)
					On SAM_Create
						Set strTip = 'Выполнить импорт депозитов'
			!
			Check Box: cb1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Импорт текстового файла
				Window Location and Size
					Left:   4.3"
					Top:    1.05"
					Width:  4.0"
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
			Custom Control: ccMeter1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cMeter
				Property Template:
				Class DLL Name:
				Display Settings
					DLL Name:
					MS Windows Class Name:
					Style:  Class Default
					ExStyle:  Class Default
					Title:
					Window Location and Size
						Left:   4.3"
						Top:    1.45"
						Width:  4.0"
						Width Editable? Class Default
						Height: 0.25"
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
					Font Size: 8
					Font Enhancement: Class Default
					Text Color: Green
					Background Color: Dark Gray
					DLL Settings
				Message Actions
					On SAM_User
						! Прогресс
						If wParam=0
							If (nDone<=nTotal) AND (nTotal!=0)
								Call ccMeter1.SetProgress( nDone/nTotal*100 )
							Else
								Call ccMeter1.SetProgress( 100 )
						! Сброс
						Else If wParam=1
							Call ccMeter1.SetProgress( 0 )
						! 100%
						Else If wParam=2
							Call ccMeter1.SetProgress( 100 )
			Check Box: cb2
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Импорт текстового файла
				Window Location and Size
					Left:   4.3"
					Top:    2.15"
					Width:  4.0"
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
			Custom Control: ccMeter2
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cMeter
				Property Template:
				Class DLL Name:
				Display Settings
					DLL Name:
					MS Windows Class Name:
					Style:  Class Default
					ExStyle:  Class Default
					Title:
					Window Location and Size
						Left:   4.3"
						Top:    2.55"
						Width:  4.0"
						Width Editable? Class Default
						Height: 0.25"
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
					Font Size: 8
					Font Enhancement: Class Default
					Text Color: Green
					Background Color: Dark Gray
					DLL Settings
				Message Actions
					On SAM_User
						! Прогресс
						If wParam=0
							If (nDone<=nTotal) AND (nTotal!=0)
								Call ccMeter2.SetProgress( nDone/nTotal*100 )
							Else
								Call ccMeter2.SetProgress( 100 )
						! Сброс
						Else If wParam=1
							Call ccMeter2.SetProgress( 0 )
						! 100%
						Else If wParam=2
							Call ccMeter2.SetProgress( 100 )
			Check Box: cb3
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Импорт текстового файла
				Window Location and Size
					Left:   4.3"
					Top:    3.25"
					Width:  4.0"
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
			Custom Control: ccMeter3
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cMeter
				Property Template:
				Class DLL Name:
				Display Settings
					DLL Name:
					MS Windows Class Name:
					Style:  Class Default
					ExStyle:  Class Default
					Title:
					Window Location and Size
						Left:   4.3"
						Top:    3.65"
						Width:  4.0"
						Width Editable? Class Default
						Height: 0.25"
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
					Font Size: 8
					Font Enhancement: Class Default
					Text Color: Green
					Background Color: Dark Gray
					DLL Settings
				Message Actions
					On SAM_User
						! Прогресс
						If wParam=0
							If (nDone<=nTotal) AND (nTotal!=0)
								Call ccMeter3.SetProgress( nDone/nTotal*100 )
							Else
								Call ccMeter3.SetProgress( 100 )
						! Сброс
						Else If wParam=1
							Call ccMeter3.SetProgress( 0 )
						! 100%
						Else If wParam=2
							Call ccMeter3.SetProgress( 100 )
		Functions
			Function: ImportInFiles
				Description: Импорт файлов локальных задач
						Зарплата и депозиты
				Returns
					Boolean:
				Parameters
					Boolean: fElplat
					Boolean: fDp
				Static Variables
				Local variables
					Number: nFileId
				Actions
					! Проверка ввода
					If fDp
						If cbImportSprav and not dfSpravFile
							Call SalMessageBox('Не задан файл импорта!', 'Ошибка', MB_Ok | MB_IconStop)
							Call SalSetFocus(dfSpravFile)
							Return FALSE
						If cbImportDp and not dfDpFile
							Call SalMessageBox('Не задан файл импорта!', 'Ошибка', MB_Ok | MB_IconStop)
							Call SalSetFocus(dfDpFile)
							Return FALSE
					If fElplat
						If cbImportSprav and not dfSpravFile
							Call SalMessageBox('Не задан файл импорта!', 'Ошибка', MB_Ok | MB_IconStop)
							Call SalSetFocus(dfSpravFile)
							Return FALSE
						If cbImportElplat and not dfElplatFile
							Call SalMessageBox('Не задан файл импорта!', 'Ошибка', MB_Ok | MB_IconStop)
							Call SalSetFocus(dfElplatFile)
							Return FALSE
					Call InitIntf()
					Set sLog = ''
					If ImportData((fDp OR fElplat) AND cbImportSprav, fElplat AND cbImportElplat, fDp AND cbImportDp, TRUE)
						If fElplat
							Call PayPlatFile()
						If fDp
							Call PayDepFile()
					If sLog
						Call SalModalDialog(dlgStatus, hWndForm, sLog, 'Статус импорта файлов ПЦ')
					Call FinalIntf()
			Function: ImportData
				Description:
				Returns
					Boolean:
				Parameters
					Boolean: fSprav
					Boolean: fElplat
					Boolean: fDp
					Boolean: fRenameSources
				Static Variables
				Local variables
					String: sFileName
					! Соед. c БД
					: cOra
						Class: cABSConnect
					: cImporter
						Class: cFilesImporter
					String: sPath
					String: sCurFileName
					! Поля SPRAV
					Number: nNum_Conv
					Number: nVid_z
					Number: nVid_s
					String: sFio
					String: sAcc_Sbon
					String: sAcc_Card
					String: sAcc_Bal
					! Поля ELPLAT
					String: sNls
					Number: sSum
					! Поля DP
					Number: nInt_d
					Number: nInt_ss
					Number: nInt_cr
					!
					Number: nId
					Number: nFetchRes
				Actions
					If not IsBankDayOpen()
						Call SalMessageBox('Банковский день закрыт!', 'Ошибка', MB_Ok | MB_IconStop)
						Return FALSE
					! Чтение параметров
					Call SalUseRegistry(FALSE, '')
					Call SalGetProfileString('OBPC', 'OBPCInPath', '', sPath, GetIniFileName())
					Call XConnectGetParams(cOra)
					If cOra.Connect()
						! Импорт SPRAV.TXT
						If fSprav
							Call SalShowWindow(cb1)
							Call SalUpdateWindow(hWndForm)
							Set sCurFileName = sPath || dfSpravFile || '.TXT'
							If cImporter.Open(sCurFileName, '|')
								! Чистим справочник
								Call SqlPrepareAndExecute(cOra.hSql(), "DELETE FROM OBPC_SPRAV")
								Loop
									If cImporter.FetchNext()
										Set nNum_Conv = SalStrToNumber(cImporter.sValues[2])
										If nNum_Conv != 0
											When SqlError
												Call PutLog('Не уникальные записи для номера конверта: ' || cImporter.sValues[2])
												Return TRUE
											Set nVid_z    = SalStrToNumber( cImporter.sValues[3] )
											Set nVid_s    = SalStrToNumber( cImporter.sValues[4] )
											Set sFio      = StrDosToWinX( SalStrTrimX( cImporter.sValues[0] ) )
											Set sAcc_Sbon = SalStrTrimX( cImporter.sValues[5] )
											Set sAcc_Card = SalStrTrimX( cImporter.sValues[6] )
											Set sAcc_Bal  = SalStrTrimX( cImporter.sValues[7] )
											Call SqlPrepareAndExecute(cOra.hSql(), 
													"INSERT INTO OBPC_SPRAV (NUM_CONV, VID_Z, VID_S, FIO, ACC_SBON, ACC_CARD, ACC_BAL) 
													 VALUES (:nNum_Conv, :nVid_z, :nVid_s, :sFio, :sAcc_Sbon, :sAcc_Card, :sAcc_Bal)")
									Else
										Break
								Call cImporter.Close()
								! Переименовываем
								If fRenameSources
									Call VisFileRename(sCurFileName, sPath || dfSpravFile || '.OLD')
							Else
								Call SalMessageBox('Не могу открыть файл: ' || sCurFileName, 'Ошибка', MB_Ok | MB_IconStop)
								Return FALSE
							Set cb1 = TRUE
							Call SalUpdateWindow(hWndForm)
						! Импорт ELPLAT1.TXT
						If fElplat
							Call SalShowWindow(cb2)
							Call SalUpdateWindow(hWndForm)
							Set sCurFileName = sPath || dfElplatFile || '.TXT'
							If cImporter.Open(sCurFileName, ',')
								! Чистим справочник
								Call SqlPrepareAndExecute(cOra.hSql(), "DELETE FROM OBPC_ELPLAT")
								Loop
									If cImporter.FetchNext()
										Set sNls = SalStrTrimX(cImporter.sValues[1])
										Set sSum = SalStrToNumber(cImporter.sValues[2])
										If SqlPrepareAndExecute(cOra.hSql(), "SELECT S_OBPC_ELPLAT.NEXTVAL INTO :nId FROM DUAL")
											If SqlFetchNext(cOra.hSql(), nFetchRes)
												Call SqlPrepareAndExecute(cOra.hSql(), 
														"INSERT INTO OBPC_ELPLAT (ID, NLS,S ) 
														 VALUES (:nId, :sNls, :sSum)")
									Else
										Break
								Call cImporter.Close()
								! Переименовываем
								If fRenameSources
									Call VisFileRename(sCurFileName, sPath || dfElplatFile || '.OLD')
							Else
								Call SalMessageBox( 'Не могу открыть файл: ' || sCurFileName, 'Ошибка', MB_Ok | MB_IconStop )
								Return FALSE
							Set cb2 = TRUE
							Call SalUpdateWindow(hWndForm)
						! Импорт DP*.TXT
						If fDp
							Call SalShowWindow(cb3)
							Call SalUpdateWindow(hWndForm)
							Set sCurFileName = sPath || 'DP' || dfDpFile || '.TXT'
							If cImporter.Open(sCurFileName, '|')
								! Чистим справочник
								Call SqlPrepareAndExecute(cOra.hSql(), "DELETE FROM OBPC_DP")
								Loop
									If cImporter.FetchNext()
										Set nNum_Conv = SalStrToNumber(cImporter.sValues[1])
										Set nInt_d    = SalStrToNumber(cImporter.sValues[4])
										Set nInt_ss   = SalStrToNumber(cImporter.sValues[5])
										Set nInt_cr   = SalStrToNumber(cImporter.sValues[6])
										If SqlPrepareAndExecute(cOra.hSql(), "SELECT S_OBPC_DP.NEXTVAL INTO :nId FROM DUAL")
											If SqlFetchNext(cOra.hSql(), nFetchRes)
												Call SqlPrepareAndExecute(cOra.hSql(), 
														"INSERT INTO OBPC_DP (ID, NUM_CONV, S_INT_D, S_INT_SS, S_INT_CR ) 
														 VALUES (:nId, :nNum_Conv, :nInt_d, :nInt_ss, :nInt_cr)")
									Else
										Break
								Call cImporter.Close()
								! Переименовываем
								If fRenameSources
									Call VisFileRename(sCurFileName, sPath || 'DP' || dfDpFile || '.OLD')
							Else
								Call SalMessageBox( 'Не могу открыть файл: ' || sCurFileName, 'Ошибка', MB_Ok | MB_IconStop )
								Return FALSE
							Set cb3 = TRUE
							Call SalUpdateWindow(hWndForm)
						Call SqlCommitEx(cOra.hSql(), 'OBPC. Импорт из файлов локальных задач в БД завершен!')
						Call cOra.Disconnect()
						Return TRUE
					Return FALSE
			Function: PayPlatFile
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Number: nCount
				Actions
					Call SaveInfoToLog("OBPC. Начисление зарплаты.")
					! Показываем пункт
					Call SalShowWindow(ccMeter2)
					Call SalSendMsg(ccMeter2, SAM_User, 1, 0)
					Set nDone = 0
					! Квитовка операций
					If not SqlPLSQLCommand(hSql(), "obpc.pay_elplat(nTransAcc)")
						Call SqlRollbackEx(hSql(), "OBPC. Неуспешное выполнение процедуры начисления зарплаты")
					Else
						Call SqlCommitEx(hSql(), "OBPC. Выполнена процедура начисления зарплаты")
					! Перечитываем индикатор
					Set nDone = nDone + 1
					Call SalSendMsg(ccMeter2, SAM_User, 2, 0)
					! Количество не оплаченых документов
					If SqlPrepareAndExecute(hSql(), 
							"select count(*) into :nCount
							   from obpc_elplat d, obpc_sprav s
							  where d.nls = s.acc_bal
							    and s.vid_z = 1
							    and d.sos = 0")
						If SqlFetchNext(hSql(), nFetchRes)
							If nCount > 0
								Call PutLog(SalNumberToStrX(nCount, 0) || ' неоплаченных документов по начислению зарплаты')
					Return TRUE
			Function: PayDepFile
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Number: nCount
				Actions
					Call SaveInfoToLog("OBPC. Начисление депозитов.")
					! Показываем пункт
					Call SalShowWindow(ccMeter3)
					Call SalSendMsg(ccMeter3, SAM_User, 1, 0)
					Set nDone = 0
					! Квитовка операций
					If not SqlPLSQLCommand(hSql(), "obpc.pay_dp(nTransAcc)")
						Call SqlRollbackEx(hSql(), "OBPC. Неуспешное выполнение процедуры начисления депозитов")
					Else
						Call SqlCommitEx(hSql(), "OBPC. Выполнена процедура начисления депозитов")
					! Перечитываем индикатор
					Set nDone = nDone + 1
					Call SalSendMsg(ccMeter3, SAM_User, 2, 0)
					! Количество не оплаченых документов
					If SqlPrepareAndExecute(hSql(), 
							"select count(*) into :nCount 
							   from obpc_dp d, obpc_sprav s
							  where d.num_conv = s.num_conv 
							    and s.vid_z = 2 and s.vid_s = 2
							    and d.sos = 0")
						If SqlFetchNext(hSql(), nFetchRes)
							If nCount > 0
								Call PutLog(SalNumberToStrX(nCount, 0) || ' неоплаченных документов по начислению депозитов')
					Return TRUE
			Function: PeformIntegrityCheck
				Description: Проверка целостности данных,
						принимаемых из локальных задач
				Returns
				Parameters
				Static Variables
				Local variables
					: cSel
						Class: cABSConnect
					!
					String: sDataList
					Number: nDataCount
				Actions
					Call InitIntf()
					If ImportData(TRUE, TRUE, TRUE, FALSE)
						Call XConnectGetParams(cSel)
						If cSel.Connect()
							!
							! Проверка целостности
							Set nDone = 0
							Set nTotal = 4
							Call SalShowWindow(ccMeter1)
							Call SalSendMsg(ccMeter1, SAM_User, 1, 0)
							! 1. Бал. счета из SPRAV.TXT не открытые в ОДБ
							Call SalWaitCursor(TRUE)
							Call CheckIntegrity(cSel.hSql(),
									"SELECT acc_bal INTO :sData 
									 FROM OBPC_SPRAV 
									 WHERE acc_bal NOT IN (SELECT nls FROM ACCOUNTS WHERE DAZS IS NULL)
									 ORDER BY acc_bal", sDataList, nDataCount)
							If nDataCount > 500
								Call PutLog('Более 500 бал. счетов из SPRAV.TXT не открыты в ОДБ!')
							Else If sDataList
								Call PutLog('Бал. счета из SPRAV.TXT не открытые в ОДБ:' || PutCrLf() || sDataList)
							Set nDone = nDone + 1
							Call SalSendMsg(ccMeter1, SAM_User, 0, 0)
							! 2. Бал. счета из ELPLAT.TXT не открытые в ОДБ
							Call SalWaitCursor(TRUE)
							Call CheckIntegrity(cSel.hSql(),
									"SELECT nls INTO :sData 
									 FROM OBPC_ELPLAT 
									 WHERE nls NOT IN (SELECT nls FROM ACCOUNTS WHERE DAZS IS NULL)
									 ORDER BY nls", sDataList, nDataCount)
							If nDataCount > 500
								Call PutLog('Более 500 бал. счетов из ELPLAT.TXT не открыты в ОДБ!')
							Else If sDataList
								Call PutLog('Бал. счета из ELPLAT.TXT не открытые в ОДБ:' || PutCrLf() || sDataList)
							Set nDone = nDone + 1
							Call SalSendMsg(ccMeter1, SAM_User, 0, 0)
							Call SalWaitCursor(TRUE)
							! 3. Бал. счета из  ELPLAT.TXT отсутствующие в SPRAV.TXT
							Call CheckIntegrity(cSel.hSql(),
									"SELECT nls INTO :sData 
									 FROM OBPC_ELPLAT 
									 WHERE nls NOT IN (SELECT acc_bal FROM OBPC_SPRAV WHERE vid_z=1)
									ORDER BY nls", sDataList, nDataCount)
							If nDataCount > 500
								Call PutLog('Более 500 бал. счет из ELPLAT.TXT отсутствуют в SPRAV.TXT!')
							Else If sDataList
								Call PutLog('Бал. счета из  ELPLAT.TXT отсутствующие в SPRAV.TXT:' || PutCrLf() || sDataList)
							Set nDone = nDone + 1
							Call SalSendMsg(ccMeter1, SAM_User, 0, 0)
							! 4. Номера конвертов из DP*.TXT отсутствующие в SPRAV.TXT
							Call SalWaitCursor(TRUE)
							Call CheckIntegrity(cSel.hSql(),
									"SELECT num_conv INTO :sData 
									 FROM OBPC_DP 
									 WHERE num_conv NOT IN (SELECT num_conv FROM OBPC_SPRAV WHERE vid_z=2)
									ORDER BY num_conv ", sDataList, nDataCount)
							If nDataCount > 500
								Call PutLog('Более 500 номеров конвертов из DP*.TXT отсутствуют в SPRAV.TXT!')
							Else If sDataList
								Call PutLog('Номера конвертов из DP*.TXT отсутствующие в SPRAV.TXT:' || PutCrLf() || sDataList)
							Set nDone = nDone + 1
							Call SalSendMsg(ccMeter1, SAM_User, 0, 0)
							Call cSel.Disconnect()
					If sLog
						Call SalModalDialog(dlgStatus, hWndForm, sLog, 'Статус импорта файлов ПЦ')
					Call FinalIntf()
			!
			Function: PutLog
				Description: Вставка строки в ЛОГ
				Returns
					Boolean:
				Parameters
					String: sString
				Static Variables
				Local variables
				Actions
					If SalStrLength(sString) > 0
						If SalStrLength(sLog) > 0
							Set sLog = sLog || PutCrLf() || sString
						Else
							Set sLog = sString
			Function: InitIntf
				Description: ! Инициализация интерфейса
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
					Call SalEnableWindow(cb1)
					Call SalEnableWindow(cb2)
					Call SalEnableWindow(cb3)
					Call SalHideWindow(cb1)
					Call SalHideWindow(cb2)
					Call SalHideWindow(cb3)
					Call SalHideWindow(ccMeter1)
					Call SalHideWindow(ccMeter2)
					Call SalHideWindow(ccMeter3)
					Set cb1 = FALSE
					Set cb2 = FALSE
					Set cb3 = FALSE
			Function: FinalIntf
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
					Call SalDisableWindow(cb1)
					Call SalDisableWindow(cb2)
					Call SalDisableWindow(cb3)
			!
			Function: CheckIntegrity
				Description:
				Returns
				Parameters
					Sql Handle: hSql
					String: sSqlText
					Receive String: sOverideList
					Receive Number: nOverideCount
				Static Variables
				Local variables
					String: sData
					Number: nFetchRes
				Actions
					Set nOverideCount = 0
					Set sOverideList = ''
					If SqlPrepareAndExecute(hSql, sSqlText)
						Loop
							If SqlFetchNext(hSql, nFetchRes)
								If sOverideList
									Set sOverideList = sOverideList || ',' || PutCrLf() || sData
								Else
									Set sOverideList = sData
								Set nOverideCount = nOverideCount+1
								If nOverideCount > 500
									Break
							Else
								Break
		Window Parameters
			String: sTransNls
		Window Variables
			! Для прогресс-индикатора
			Number: nTotal
			Number: nDone
			! Log
			String: sLog
			Boolean: fLogCalled
			!
			Number: nTransAcc
			String: sTransNms
		Message Actions
			On SAM_Create
				Call PrepareWindowEx(hWndForm)
				Call SalSetWindowLabelText(bgTransNms, '')
				If sTransNls
					Set dfTransNls = sTransNls
					Call SalSendMsg(dfTransNls, SAM_Validate, 0, 0)
				Set dfSpravFile  = 'SPRAV'
				Set dfElplatFile = 'ELPLAT1'
				Set dfDpFile     = ''
				Set cbImportSprav  = TRUE
				Set cbImportElplat = TRUE
				Set cbImportDp     = TRUE
				Call SalHideWindow(cb1)
				Call SalHideWindow(ccMeter1)
				Call SalHideWindow(cb2)
				Call SalHideWindow(ccMeter2)
				Call SalHideWindow(cb3)
				Call SalHideWindow(ccMeter3)
				Set fLogCalled = FALSE
				!
				Call SalSetFocus(pbAll)
	!
	! Ручная квитовка документов
	Table Window: frm_HandReceipe
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Ручна квитовка/видалення документів ПЦ з черги на відправку
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
				Width:  13.533"
				Width Editable? Class Default
				Height: 6.31"
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
		Description: Форма ручной квитовки/удаление документов
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
					Resource Id: 42630
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
					Keyboard Accelerator: Enter
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
					Resource Id: 42631
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
					Resource Id: 42632
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
				Pushbutton: pbReceipe
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.7"
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
							Set strTip = 'Зквитувати/видалити вибранні документи'
						On SAM_Click
							If SalMessageBox('Ви впевнені, що бажаїте зквитувати вибрані документи?', 
									   'Квитовка', MB_YesNo | MB_IconQuestion) = IDYES
								Set nRow = TBL_MinRow
								Loop
									If SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
										Call SalTblSetContext(hWndForm, nRow)
										Call ReceipeDoc(colDocType, colRef, colDk)
									Else
										Break
								Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
				Line
					Resource Id: 21168
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  5.25"
						Begin Y:  0.024"
						End X:  5.25"
						End Y:  0.488"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
		Contents
			Column: colStatus
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Стан
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
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
			Column: colFileName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ім'я
						файлу
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
			Column: colFileDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						файлу
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
			Column: colRef
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Референс
						документу
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
			Column: colTt
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						ОП
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
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
			Column: colVDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						валютування
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.2"
				Width Editable? Yes
				Format: dd/MM/yyyy
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
				Title: Дб
						Кр
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
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
			Column: colNls
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Кортковий
						рахунок
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
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.6"
				Width Editable? Yes
				Format: ###000
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
				Title: Вал
						юта
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
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
				Title: Назва
						карткового рахунку
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
			Column: colNlsb
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Рахунок-Б
				Visible? Yes
				Editable? Yes
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
			Column: colNmsb
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Назва
						рахунку-Б
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
			Column: colUserId
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: User
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
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
			Column: colDDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						документу
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.2"
				Width Editable? Yes
				Format: dd/MM/yyyy
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
			Column: colSos
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сост
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  0.617"
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
			Column: colDocType
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: DocType
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  0.617"
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
			Function: ReceipeDoc
				Description: Сквитовать документ
				Returns
				Parameters
					Number: nDocType
					Number: nRef
					Number: nDk
				Static Variables
				Local variables
				Actions
					If SqlPLSQLCommand(cAux.hSql(), 'obpc.del_pkkque(nDocType, nRef, nDk)')
						Call SqlCommitEx(cAux.hSql(), 'OBPC. Документ REF=' || SalNumberToStrX(nRef, 0) || ' вручную удален из очереди на отправку в ПЦ!' )
					Else
						Call SqlRollback(cAux.hSql())
		Window Parameters
		Window Variables
			: cAux
				Class: cABSConnect
			Number: nRow
		Message Actions
			On SAM_Create
				Call PrepareWindowEx(hWndForm)
				Set hWndForm.frm_HandReceipe.nFlags = GT_ReadOnly
				Set hWndForm.frm_HandReceipe.fFilterAtStart = TRUE
				Set hWndForm.frm_HandReceipe.strFilterTblName = "v_obpc_pkkque"
				! Можем удалить/сквитовать любые наши документы (doc_type = 1)
				! и удалить документы отделений-мфо ( doc_type = 2 and f_n is null )
				Set hWndForm.frm_HandReceipe.strSqlPopulate = 
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
				Call XConnectGetParams(cAux)
				If NOT cAux.Connect()
					Call SalWaitCursor(FALSE)
					Call SalDestroyWindow(hWndForm)
				Call SalSendClassMessage(UM_Create, 0, 0)
			On UM_DoubleClick
				If colRef
					Call DocViewContentsEx(hWndForm, colRef)
			On SAM_FetchRowDone
				If colDocType = 2
					Call XSalTblSetRowBackColor(hWndForm, lParam, SalColorFromRGB(230,255,255)) ! голубой
				Else If colSos > 0 and colSos < 5
					Call VisTblSetRowColor(hWndForm, lParam, COLOR_DarkGreen)
	! Доввод доп. реквизитов
	Table Window: frm_AuxReenter
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Доввод дополнительных реквизитов документов
		Icon File:
		Accesories Enabled? Yes
		Visible? No
		Display Settings
			Visible at Design time? Yes
			Automatically Created at Runtime? No
			Initial State: Normal
			Maximizable? Yes
			Minimizable? Yes
			System Menu? Yes
			Resizable? Yes
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  11.117"
				Width Editable? Yes
				Height: 6.131"
				Height Editable? Yes
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
			Discardable? No
		Description: Форма доввода доп. реквизитов
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Default
				Location? Top
				Visible? Yes
				Size: 0.427"
				Size Editable? Yes
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: None
				Text Color: Default
				Background Color: Default
			Contents
				Pushbutton: pbIns
					Class Child Ref Key: 33
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.086"
						Top:    0.073"
						Width:  0.43"
						Width Editable? No
						Height: 0.317"
						Height Editable? No
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: Default
					Font Size: Default
					Font Enhancement: None
					Picture File Name: \BARS98\RESOURCE\BMP\Insert.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
				Pushbutton: pbDel
					Class Child Ref Key: 34
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.514"
						Top:    0.073"
						Width:  0.43"
						Width Editable? No
						Height: 0.317"
						Height Editable? No
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: Default
					Font Size: Default
					Font Enhancement: None
					Picture File Name: \BARS98\RESOURCE\BMP\Delrec.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
				Pushbutton: pbRefresh
					Class Child Ref Key: 35
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.943"
						Top:    0.073"
						Width:  0.43"
						Width Editable? No
						Height: 0.317"
						Height Editable? No
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: Default
					Font Size: Default
					Font Enhancement: None
					Picture File Name: \BARS98\RESOURCE\BMP\Refresh.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
				Pushbutton: pbUpdate
					Class Child Ref Key: 36
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.371"
						Top:    0.073"
						Width:  0.43"
						Width Editable? No
						Height: 0.317"
						Height Editable? No
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: Default
					Font Size: Default
					Font Enhancement: None
					Picture File Name: \BARS98\RESOURCE\BMP\Save.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
				Line
					Resource Id: 54911
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  4.557"
						Begin Y:  -0.01"
						End X:  4.557"
						End Y:  0.448"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Pushbutton: pbSearch
					Class Child Ref Key: 38
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.043"
						Top:    0.073"
						Width:  0.43"
						Width Editable? No
						Height: 0.317"
						Height Editable? No
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: Default
					Font Size: Default
					Font Enhancement: None
					Picture File Name: \BARS98\RESOURCE\BMP\search.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
				Pushbutton: pbFilter
					Class Child Ref Key: 44
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.471"
						Top:    0.073"
						Width:  0.43"
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
					Message Actions
				Pushbutton: pbDetails
					Class Child Ref Key: 39
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.9"
						Top:    0.073"
						Width:  0.43"
						Width Editable? No
						Height: 0.317"
						Height Editable? No
					Visible? Yes
					Keyboard Accelerator: Enter
					Font Name: Default
					Font Size: Default
					Font Enhancement: None
					Picture File Name: \BARS98\RESOURCE\BMP\open.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.329"
						Top:    0.073"
						Width:  0.43"
						Width Editable? No
						Height: 0.317"
						Height Editable? No
					Visible? Yes
					Keyboard Accelerator: F5
					Font Name: Default
					Font Size: Default
					Font Enhancement: None
					Picture File Name: \BARS98\RESOURCE\BMP\print.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
				Line
					Resource Id: 54912
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  3.886"
						Begin Y:  -0.01"
						End X:  3.886"
						End Y:  0.448"
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
						Left:   4.014"
						Top:    0.073"
						Width:  0.43"
						Width Editable? No
						Height: 0.317"
						Height Editable? No
					Visible? Yes
					Keyboard Accelerator: Esc
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Picture File Name: \BARS98\RESOURCE\BMP\Discard.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
				Line
					Resource Id: 54913
					Class Child Ref Key: 43
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  1.9"
						Begin Y:  -0.01"
						End X:  1.9"
						End Y:  0.448"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Pushbutton: pbDoc
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbBrowse
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.7"
						Top:    0.071"
						Width:  0.43"
						Width Editable? Yes
						Height: 0.317"
						Height Editable? Yes
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Default
					Picture File Name: \BARS98\RESOURCE\BMP\Doc.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_Create
							Set strTip='Просмотреть документ'
						On SAM_Click
							If colRef
								Call DocViewContentsEx(hWndForm,colRef)
				Line
					Resource Id: 54914
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  5.267"
						Begin Y:  0.0"
						End X:  5.267"
						End Y:  0.464"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
		Contents
			Column: colRef
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Референс
						документа
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
			Column: colTt
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						ОП
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
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
			Column: colUserId
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: User
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  0.717"
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
				Title: Счет - А
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.717"
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
			Column: colS1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сума
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.25"
				Width Editable? Yes
				Format: ###000
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
			Column: colLcvA
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Вал
						юта
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  0.617"
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
			Column: colVDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						валютирования
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Left
				Width:  1.533"
				Width Editable? Yes
				Format: dd/MM/yyyy
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
				Title: Сумма в
						валюте - Б
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  Default
				Width Editable? Yes
				Format: ###000
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
			Column: colLcvB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Вал
						Б
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  0.55"
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
				Title: МФО - Б
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  0.95"
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
				Title: Счет - Б
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
			Column: colDk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дб
						Кр
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  0.517"
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
			Column: colSk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: СКП
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  0.467"
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
			Column: colDDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						документа
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Left
				Width:  1.117"
				Width Editable? Yes
				Format: dd/MM/yyyy
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
			Column: colDig1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						документа
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
			Column: colDig2
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						документа
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
		Window Parameters
		Window Variables
			: cAux
				Class: cABSConnect
		Message Actions
			On SAM_Create
				Call PrepareWindowEx(hWndForm)
				Set nFlags = GT_ReadOnly
				Set strFilterTblName = 'OPER'
				Set fFilterAtStart = TRUE
				Set strSqlPopulate =
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
				Call XConnectGetParams(cAux)
				If NOT cAux.Connect()
					Call SalWaitCursor(FALSE)
					Call SalDestroyWindow(hWndForm)
				Call SalSendClassMessage(UM_Create, 0, 0)
			On UM_DoubleClick
				Call SalCreateWindow(frm_AuxEnter, hWndMDI, colRef, cAux.hSql())
			On SAM_FetchRowDone
				Set colS1 = colS1/SalNumberPower(10, colDig1)
				Set colS2 = colS2/SalNumberPower(10, colDig2)
	Table Window: frm_AuxEnter
		Class:
		Property Template:
		Class DLL Name:
		Title: Ввод доп. реквизитов
		Icon File:
		Accesories Enabled? Yes
		Visible? No
		Display Settings
			Visible at Design time? Yes
			Automatically Created at Runtime? No
			Initial State: Normal
			Maximizable? No
			Minimizable? No
			System Menu? Yes
			Resizable? Yes
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  10.85"
				Width Editable? Yes
				Height: 5.381"
				Height Editable? Yes
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
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Default
				Location? Top
				Visible? Yes
				Size: 0.56"
				Size Editable? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Contents
				Pushbutton: pbSave
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cpbOk
					Property Template:
					Class DLL Name:
					Title: Сохранить
					Window Location and Size
						Left:   0.083"
						Top:    0.071"
						Width:  1.2"
						Width Editable? Yes
						Height: 0.45"
						Height Editable? Yes
					Visible? Yes
					Keyboard Accelerator: Enter
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Default
					Picture File Name: \BARS98\RESOURCE\BMP\Apply.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_Click
							! Меняем флаги
							Set iContext = 0
							Loop
								If iContext < (iCount)
									If SalTblSetContext(hWndForm, iContext)
										! Только редактированные
										If SalTblQueryRowFlags(hWndForm, iContext, ROW_Edited)
											Set nCount = 0
											Set fAuxExists = FALSE
											! Call Debug( SalNumberToStrX( nRef, 0 ) || ' ' || colTAG )
											If SqlPrepareAndExecute(hSql, 
													"SELECT COUNT(*) INTO :nCount 
													 FROM operw WHERE ref=:nRef AND tag=:colTAG ")
												If SqlFetchNext(hSql, nFetchRes)
													Set fAuxExists = (nCount>0)
											! Не существует и есть значение
											If NOT fAuxExists AND colVALUE
												! Удаляем редактирование
												Call SalTblSetRowFlags(hWndForm, iContext, ROW_Edited, FALSE)
												! Добавляем вставку
												Call SalTblSetRowFlags(hWndForm, iContext, ROW_New, TRUE)
											! Не существует и нет значения
											Else If NOT fAuxExists AND NOT colVALUE
												! Удаляем редактирование
												Call SalTblSetRowFlags(hWndForm, iContext, ROW_Edited, FALSE)
								Else
									Break
								Set iContext = iContext + 1
							! Сохраняем доп. реквизиты
							Call SqlPrepare(hSql, 
									"INSERT INTO OPERW (ref, tag, value) 
									 VALUES(:nRef, :colTAG, :colVALUE)")
							Set fModResult = SalTblDoInserts(hWndForm, hSql, TRUE)
							Call SqlPrepare(hSql, 
									"UPDATE OPERW SET value = :colVALUE
									 WHERE ref=:nRef and tag=:colTAG ")
							Set fModResult = fModResult OR SalTblDoUpdates(hWndForm, hSql, TRUE)
							If fModResult
								Call SqlCommitEx(hSql, 'Доп.реквизиты для документа #' || SalNumberToStrX( nRef, 0 ) || ' вставлены/изменены!')
							Call SalDestroyWindow(hWndForm)
				Pushbutton: pbCancel
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cpbCancel
					Property Template:
					Class DLL Name:
					Title: Отменить
					Window Location and Size
						Left:   1.383"
						Top:    0.071"
						Width:  1.2"
						Width Editable? Yes
						Height: 0.45"
						Height Editable? Yes
					Visible? Yes
					Keyboard Accelerator: Esc
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Default
					Picture File Name: \BARS98\RESOURCE\BMP\Discard.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_Click
							Call SalDestroyWindow(hWndForm)
		Contents
			Column: colTAG
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
				Width:  0.967"
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
			Column: colNAME
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Наименование доп. реквизита
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  5.533"
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
			Column: colVALUE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Значение
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 200
				Data Type: String
				Justify: Left
				Width:  4.4"
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
					On SAM_DoubleClick
						! Лезем в справочник
						If colSELECT
							Set nType = SalCompileAndEvaluate( colSELECT,
									    nError, nPos, nTmp, sTmp, dTmp, hTmp, TRUE, SalContextCurrent())
							If nError = 0
								If nType = EVAL_Number
									Set sTmp = SalNumberToStrX(nTmp, 0)
								Else If nType = EVAL_String
									! Set dfValue = sBrowserRet
								Else If nType = EVAL_Date
									Call SalDateToStr ( dTmp, sTmp )
								Set colVALUE=sTmp
								Call SalTblSetRowFlags( hWndForm, SalTblQueryContext( hWndForm ),ROW_Edited , TRUE )
							Else
								Call SalMessageBox( 'Невозможно вызвать '||colSELECT, 'Информация', MB_IconInformation )
								Return FALSE
			Column: colSELECT
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
		Functions
		Window Parameters
			Number: aRef
			Sql Handle: aSql
		Window Variables
			Number: nRef
			Sql Handle: hSql
			Number: iContext
			Number: iCount
			Number: nCount
			Number: nFetchRes
			Boolean: fAuxExists
			String: sValue
			Number: nType
			Number: nError
			Number: nPos
			Number: nTmp
			String: sTmp
			Window Handle: hTmp
			Date/Time: dTmp
			Boolean: fModResult
		Message Actions
			On SAM_Create
				Call PrepareWindowEx(hWndForm)
				Set nRef = aRef
				Set hSql = aSql
				Set iCount = 0
				Call SalTblPopulate(hWndForm, hSql, 
						"SELECT r.tag, f.name, NVL(ww.value,''),f.browser 
						 INTO :hWndForm.colTAG,:hWndForm.colNAME, 
						      :hWndForm.colVALUE,:hWndForm.colSELECT 
						 FROM oper o, op_rules r, op_field f, 
						      (SELECT ff.tag, NVL(w.value,'') value 
						       FROM operw w, op_field ff 
						       WHERE w.ref (+) = :nRef AND w.tag (+) = ff.tag ) ww 
						 WHERE o.ref = :nRef AND o.tt = r.tt AND r.tag = f.tag AND r.tag=ww.tag ", TBL_FillAll)
			On SAM_FetchRowDone
				Set iCount = iCount + 1
	!
	Table Window: tblPortfolio
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Портфель БПК
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
				Width:  11.067"
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
				Pushbutton: pbIns
					Class Child Ref Key: 33
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.033"
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
							Set strTip = 'Нова картка'
				Pushbutton: pbRefresh
					Class Child Ref Key: 35
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.083"
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
				Pushbutton: pbFilter
					Class Child Ref Key: 44
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.517"
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
						Left:   0.967"
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
						Left:   1.4"
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
					Resource Id: 4225
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  6.75"
						Begin Y:  -0.048"
						End X:  6.75"
						End Y:  0.417"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Line
					Resource Id: 54132
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  2.567"
						Begin Y:  0.012"
						End X:  2.567"
						End Y:  0.476"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Pushbutton: pbLink
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.683"
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
							Set strTip = 'Відкрити Кредитну лінію для вибраної угоди'
						On SAM_Click
							If colNd
								Call OpenKL()
				Pushbutton: pbDel
					Class Child Ref Key: 34
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.133"
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
							Set strTip = 'Закрити угоду'
				Line
					Resource Id: 5447
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  3.65"
						Begin Y:  0.0"
						End X:  3.65"
						End Y:  0.464"
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
						Left:   3.767"
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
						Left:   4.217"
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
				Pushbutton: pbAccounts
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbBrowse
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.683"
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
							Set strTip = 'Рахунки угоди'
						On SAM_Click
							If colNd
								Call ShowAccList(colCust_rnk, AVIEW_CUST, nAccsFlags, 
										"a.acc in (select acc from v_bpk_nd_acc where nd = " || Str(colNd) || " and acc is not null)")
				Pushbutton: pbAccHistory
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbBrowse
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   5.117"
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
						Left:   5.567"
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
					Resource Id: 4226
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  6.083"
						Begin Y:  -0.048"
						End X:  6.083"
						End Y:  0.417"
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
						Left:   6.217"
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
					Resource Id: 4227
					Class Child Ref Key: 43
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  1.917"
						Begin Y:  0.0"
						End X:  1.917"
						End Y:  0.464"
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
			Column: colCard_acct	! S Технический счет
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Технічний
						рахунок
				Visible? Class Default
				Editable? Class Default
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
					On SAM_SetFocus
						Set sTmp = colCard_acct
					On SAM_AnyEdit
						Set colCard_acct = sTmp
						Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
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
			Column: colAcc_tipname	! S Тип счета
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Тип
						рахунку
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
			Column: colCard_servname	! S Категория клиента
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Категорія
						клієнта
				Visible? Class Default
				Editable? No
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
		Functions
			Function: OpenKL
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Number: nAccOvr
					String: sNlsOvr
				Actions
					Set sNlsOvr = STRING_Null
					! -- Проверка: для картсчета уже открыта кредитная линия? 
					Call SqlPrepareAndExecute(hSql(),
							"select b.nls into :sNlsOvr
							   from bpk_acc o, accounts b
							  where o.nd = :colNd
							    and o.acc_ovr = b.acc")
					If SqlFetchNext(hSql(), nFetchRes)
						If sNlsOvr
							Call SalMessageBox("Для карткового рахунку " || colAcc_nls || " вже відкрито кредитну лінію - рахунок " || sNlsOvr, 
									     "Інфорація", MB_IconAsterisk | MB_Ok)
							Return TRUE
					Call SalWaitCursor(TRUE)
					If not SqlPLSQLCommand(hSql(), "obpc.open_acc(colNd, '2203', nAccOvr)")
						Call SalWaitCursor(FALSE)
						Call SqlRollbackEx(hSql(), "Помилка при відкритті кредитної лінії")
						Call SalMessageBox("Помилка при відкритті кредитної лінії",
								     "Помилка", MB_IconAsterisk | MB_Ok)
						Return FALSE
					Call SqlPrepareAndExecute(hSql(), "select nls into :sNlsOvr from accounts where acc = :nAccOvr")
					Call SqlFetchNext(hSql(), nFetchRes)
					Call SalWaitCursor(FALSE)
					Call SqlCommitEx(hSql(), "Відкрито кредитну лінію " || sNlsOvr || " для карткового рахунку " || colAcc_nls)
					Call SalMessageBox("Відкрито кредитну лінію " || sNlsOvr || " для карткового рахунку " || colAcc_nls,
							     "Інфорація", MB_IconAsterisk | MB_Ok)
					Return TRUE
			Function: CloseCard
				Description:
				Returns
					Boolean:
				Parameters
					Number: nNd
					String: sNls
					String: sLcv
				Static Variables
				Local variables
					String: sMsg
				Actions
					If SalMessageBox("Закрити угоду " || Str(nNd) || PutCrLf() ||
							   "(картковий рахунок " || sNls|| "/" || sLcv || PutCrLf() || 
							   "та всі пов'язані з ним рахунки)?", "Увага!", MB_IconQuestion | MB_YesNo) = IDNO
						Return TRUE
					If not SqlPLSQLCommand(hSql(), "bars_bpk.can_close_deal(nNd, sMsg)")
						Return FALSE
					If sMsg
						If SalMessageBox(sMsg, "Увага!", MB_IconQuestion | MB_YesNo) = IDNO
							Return TRUE
					If not SqlPLSQLCommand(hSql(), "bars_bpk.close_deal(nNd, sMsg)")
						Call SqlRollbackEx(hSql(), "OBPC. cannot execute bars_bpk.close_deal")
						Return FALSE
					Call SqlCommitEx(hSql(), "OBPC. Угода " || Str(nNd) || ": " || sMsg)
					Call SalMessageBox("Угода " || Str(nNd) || ":" || PutCrLf() || sMsg, "Повідомлення", MB_IconAsterisk | MB_Ok)
					Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
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
					Call SalSetWindowText(hWndForm, "Портфель БПК")
					Set nCustFlags = CVIEW_Saldo
					Set nAccsFlags = AVIEW_Financial | AVIEW_Special | AVIEW_NoOpen
					Set nAccAccess = ACCESS_FULL
				! Портфель БПК - перегляд
				Else
					Call SalSetWindowText(hWndForm, "Портфель БПК - перегляд")
					Set nCustFlags = CVIEW_Saldo | CVIEW_ReadOnly
					Set nAccsFlags = AVIEW_Financial | AVIEW_Special | AVIEW_NoOpen | AVIEW_ReadOnly
					Set nAccAccess = ACCESS_READONLY
					Call SalDisableWindow(pbIns)
					Call SalDisableWindow(pbLink)
					Call SalDisableWindow(pbDel)
				Call PrepareWindowEx(hWndForm)
				Call SetWindowFullSize(hWndForm)
				Set hWndForm.tblPortfolio.strFilterTblName = 'obpc_deal'
				Set hWndForm.tblPortfolio.strPrintFileName = 'pk_deal'
				Set hWndForm.tblPortfolio.fFilterAtStart = TRUE
				Set hWndForm.tblPortfolio.nTabInstance   = 1
				Set hWndForm.tblPortfolio.strSqlPopulate = 
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
				Call cF_BPK.Init('obpc_deal', '')
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On SAM_CreateComplete
				Call SalWaitCursor(FALSE)
				Call hWndForm.tblPortfolio.cF_BPK.cSimpleFilter.NewString('ACC_DAOS',SalFmtFormatDateTime(GetBankDate(), 'dd.MM.yyyy'))
				If SetQueryFilterEx(cF_BPK)
					If cF_BPK.GetFilterWhereClause(TRUE) != ''
						Call SalPostMsg(hWndForm, UM_Populate, 0, 0)
				Else
					Call SalPostMsg(pbExit, SAM_Click, 0, 0)
			On UM_Populate
				Call SalWaitCursor(TRUE)
				Set nCount = 0
				!
				Call cQ.Init(hWndForm.tblPortfolio.strSqlPopulate)
				Set strDynSql = cQ.GetFullSQLStringEx(cF_BPK)
				Call SalTblPopulate(hWndForm, hSql(), T(strDynSql), TBL_FillAll)
				!
				Call SalTblDefineSplitWindow(hWndForm, 1, TRUE)
				Set nRow = SalTblInsertRow(hWndForm, TBL_MinRow)
				Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
				Call SalTblSetContext(hWndForm, nRow)
				Set colBranch  = 'Рахунків всього:'
				Set colAcc_nls = Str(nCount)
				Call SalWaitCursor(FALSE)
			On SAM_FetchRowDone
				If colAcc_dazs
					Call VisTblSetRowColor(hWndForm, lParam, COLOR_DarkRed)
				If colAcc_ost < 0
					Call SalTblSetCellTextColor(colAcc_ost, COLOR_Red, FALSE)
				Set nCount = nCount + 1
			On UM_Insert
				Call SalCreateWindow(frmCard, hWndMDI, hWndForm)
			On UM_Delete
				If colNd
					Call CloseCard(colNd, colAcc_nls, colAcc_lcv)
			On SAM_DoubleClick
				If colNd
					Call OperWithAccountEx(AVIEW_ALL, colAcc_acc, colCust_rnk, 
							     IifN(colAcc_dazs!=DATETIME_Null, ACCESS_READONLY, nAccAccess), hWndForm, '')
	Form Window: frm_ImportZP
		Class:
		Property Template:
		Class DLL Name:
		Title: Прийом зарплатних файлів
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
				Width:  16.3"
				Width Editable? Yes
				Height: 8.4"
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
				Pushbutton: pbRefresh
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbRefresh
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.033"
						Top:    0.048"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: F3
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
							Set strTip = 'Перечитати стан директорії'
						On SAM_Click
							Call clearFields(FALSE)
							Call SalSendMsg(cFiles, SAM_Create, 0, 0)
				Pushbutton: pbPrint
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbPrint
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.483"
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
							Set strTip = 'Друк таблиці'
						On SAM_Click
							Call tblCard.printFile(GetPrnDir() || '\\' || sCurrFile)
				Line
					Resource Id: 57138
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  1.0"
						Begin Y:  0.0"
						End X:  1.0"
						End Y:  0.476"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: Default
				Pushbutton: pbImport
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbExecute
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.117"
						Top:    0.048"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: F10
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
							Set strTip = 'Оплатити файл'
						On SAM_Click
							If sCurrFile
								If checkFile()
									Call tblCard.payFile()
				Line
					Resource Id: 57139
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  1.633"
						Begin Y:  -0.048"
						End X:  1.633"
						End Y:  0.429"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: Default
				Pushbutton: pbCancel
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbCancel
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.783"
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
			List Box: cFiles
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cOutlineListBox
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   Default
					Top:    0.0"
					Width:  3.0"
					Width Editable? Class Default
					Height: 7.55"
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
					On SAM_Create
						Call SalWaitCursor(TRUE)
						If h1stChild
							Call cFiles.DeleteChild(0)
						Call cFiles.SetStyle(LBS_ShowHorzScrollBar | LBS_ShowSelectTextPicture | LBS_Explorer | LBS_VisExtensions | LBS_FmtUppercase)
						If NOT hRoot
							Set hRoot = cFiles.GetRoot()
						If hRoot
							Set h1stChild = cFiles.LoadChild(hRoot, hPicRoot1, hPicRoot1, sFilePath, 0, 0)
							If h1stChild
								Set nFiles = VisDosEnumFiles(sFilePath || '\\*.TXT', FA_Standard, smFile)
								Set nIterator = 0
								While nIterator < nFiles
									Call cFiles.LoadChild(h1stChild, hPicNull, hPicNull, smFile[nIterator], nIterator+1, 0)
									Set nIterator = nIterator + 1
								!
								Set nFiles = VisDosEnumFiles(sFilePath || '\\*.DBF', FA_Standard, smFile)
								Set nIterator = 0
								While nIterator < nFiles
									Call cFiles.LoadChild(h1stChild, hPicNull, hPicNull, smFile[nIterator], nIterator+1, 0)
									Set nIterator = nIterator + 1
								!
								Set nFiles = VisDosEnumFiles(sFilePath || '\\*.XML', FA_Standard, smFile)
								Set nIterator = 0
								While nIterator < nFiles
									Call cFiles.LoadChild(h1stChild, hPicNull, hPicNull, smFile[nIterator], nIterator+1, 0)
									Set nIterator = nIterator + 1
							Call cFiles.ShowOutline(1)
						Call SalWaitCursor(FALSE)
					On VTM_OutlineCornerClick
						Set nCurrentFlag = GetItemFlags(GetItemHandle(wParam))
						If (nCurrentFlag & ITEM_IsParent)
							If (nCurrentFlag &  ITEM_IsExpanded)
								Call Collapse(wParam)
							Else
								Call Expand(wParam)
					On VTM_KeyDown
						Set nCurrentFlag = GetItemFlags( GetItemHandle( VisListGetFocusIndex( hWndItem )))
						Select Case wParam
							Case VK_Left
								If nCurrentFlag & ITEM_CanCollapse
									Call Collapse( VisListGetFocusIndex( hWndItem ) )
								Break
							Case VK_Right
								If nCurrentFlag & ITEM_CanExpand
									Call Expand( VisListGetFocusIndex( hWndItem ) )
								Break
							Default
								Call SalSendClassMessage( VTM_KeyDown, wParam, lParam )
								Break
					On SAM_Click
						Call SalSendClassMessage(SAM_Click, wParam, lParam)
						Call clearFields(TRUE)
						If SalListQuerySelection(cFiles) > 0
							Set sCurrFile = VisListGetText(cFiles, SalListQuerySelection(cFiles))
							Call SalWaitCursor(TRUE)
							Call readFile(sCurrFile)
							Call SalWaitCursor(FALSE)
						Else
							Set sCurrFile = ''
						If sCurrFile
							Call SalSetWindowText(hWndForm, "Обробка файлу " || sCurrFile)
						Else
							Call SalSetWindowText(hWndForm, "Прийом зарплатних файлів")
			!
			Background Text: Операція
				Resource Id: 26079
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   3.2"
					Top:    0.1"
					Width:  2.4"
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
			Data Field: dfTranType
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
						Left:   5.7"
						Top:    0.05"
						Width:  0.6"
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
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Data Field: dfTt
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 3
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   6.35"
						Top:    0.05"
						Width:  0.8"
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
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Combo Box: cmbTt
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_StrId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   7.2"
					Top:    0.05"
					Width:  4.55"
					Width Editable? Class Default
					Height: 1.345"
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
						If cmbTt.Init(hWndItem)
							If sParTt
								Call cmbTt.Populate(hSql(), "tt", "name", "v_bpk_tt_for_listpay", "where tt='" || sParTt || "' order by tt")
								If cmbTt.nItemNum = 0
									Call SalDestroyWindow(hWndForm)
								Else
									Call cmbTt.SetSelectById(sParTt)
									Call SalDisableWindow(hWndItem)
									Call SalSendMsg(hWndItem, SAM_Click, 0, 0)
							Else
								Call cmbTt.Populate(hSql(), "tt", "name", "v_bpk_tt_for_listpay", "order by tt")
					On SAM_Click
						Call SalSendClassMessage(SAM_Click, 0, 0)
						Set dfTt = cmbTt.strCurrentId
						Call SqlPrepareAndExecute(hSql(), "select tran_type into :dfTranType from obpc_trans_out where tt = :dfTt")
						Call SqlFetchNext(hSql(), nFetchRes)
						Call SqlPrepareAndExecute(hSql(), "select nvl(nazn,name) into :dfNazn from tts where tt = :dfTt")
						Call SqlFetchNext(hSql(), nFetchRes)
						Call SqlPrepareAndExecute(hSql(), "select val into :dfZB from op_rules where tt = :dfTt and tag = 'SK_ZB'")
						If SqlFetchNext(hSql(), nFetchRes)
							Call cmbZB.SetSelectById(dfZB)
						Else
							Set dfZB = ''
							Call SalListSetSelect(cmbZB, -1)
			Data Field: dfTransitNls
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
						Left:   5.7"
						Top:    0.35"
						Width:  3.9"
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
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_Validate
						If not SalIsNull(dfTransitNls)
							If not getTransit("a.nls = :dfTransitNls and a.kv = :nKv")
								Return VALIDATE_Cancel
						Return VALIDATE_Ok
			Data Field: dfLcv
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 3
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   9.65"
						Top:    0.35"
						Width:  0.8"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Center
					Format: Uppercase
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_Validate
						If SalIsNull(hWndItem)
							Set dfLcv = Str(nBaseVal)
						If SalIsValidInteger(hWndItem)
							Set sTmp = 'kv'
						Else
							Set sTmp = 'lcv'
						Call SqlPrepareAndExecute(hSql(), "select lcv, dig into :dfLcv, :nDig from tabval where " || sTmp || " = :dfLcv")
						If not SqlFetchNext(hSql(), nFetchRes)
							Call SalMessageBox("Невідома валюта "|| " " || dfLcv,
									     "Увага!", MB_IconExclamation)
							Set dfLcv = 'UAH'
							Return VALIDATE_Cancel
						Return VALIDATE_Ok
			Data Field: dfTransitNms
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 38
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   5.7"
						Top:    0.65"
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
			Pushbutton: pbSelectTransit
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cPushButtonLabeled
				Property Template:
				Class DLL Name:
				Title: Вибрати...
				Window Location and Size
					Left:   10.5"
					Top:    0.35"
					Width:  1.2"
					Width Editable? Yes
					Height: 0.25"
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
						If sCurrFile
							If FunNSIGetFiltered("v_bpk_transit", "acc", "v_bpk_transit.lcv='" || dfLcv || "'", sPK, sSem)
								Call getTransit("a.acc=:sPK")
			Background Text: Залишок фактичний
				Resource Id: 72
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   11.9"
					Top:    0.4"
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
			Data Field: dfOstc
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
						Left:   14.2"
						Top:    0.35"
						Width:  1.8"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Decimal
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Залишок плановий
				Resource Id: 73
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   11.9"
					Top:    0.7"
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
			Data Field: dfOstb
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
						Left:   14.2"
						Top:    0.65"
						Width:  1.8"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Decimal
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Data Field: dfNazn
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 160
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   5.7"
						Top:    0.95"
						Width:  10.3"
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
			Data Field: dfZB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 2
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   5.7"
						Top:    1.25"
						Width:  0.6"
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
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_Validate
						If SalIsNull(dfZB)
							Call SalListSetSelect(cmbZB, -1)
							Return VALIDATE_OkClearFlag
						Call cmbZB.SetSelectById(dfZB)
						If cmbZB.strCurrentId
							Return VALIDATE_Ok
						Else
							Call SalMessageBox('Невідомий позабалансовий символ!', 'Увага', MB_Ok | MB_IconExclamation)
							Return VALIDATE_Cancel
			Combo Box: cmbZB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_StrId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   6.35"
					Top:    1.25"
					Width:  9.65"
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
						If cmbZB.Init(hWndItem)
							Call cmbZB.Populate(hSql(), 'd010', "d010 || ' ' || txt", 'kl_d010', "where d010>='84' order by d010")
							Call SalListSetSelect(cmbZB, -1)
					On SAM_Click
						Call SalSendClassMessage(SAM_Click, 0, 0)
						Set dfZB = cmbZB.strCurrentId
			Child Table: tblCard
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Display Settings
					Window Location and Size
						Left:   3.2"
						Top:    1.6"
						Width:  12.8"
						Width Editable? Yes
						Height: 5.1"
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
					Maximum Rows in Memory: 20000
					Discardable? No
				Contents
					Column: colCardAcc	! Счет из файла (техн./аналитич.)
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Технічний/
								аналітичний
								рахунок
						Visible? Yes
						Editable? Yes
						Maximum Data Length: 14
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
							On SAM_SetFocus
								Set sTmp = colCardAcc
							On SAM_AnyEdit
								Set colCardAcc = sTmp
								Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
					Column: colS
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сума
						Visible? Yes
						Editable? No
						Maximum Data Length: 16
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
					Column: colNls
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Картковий
								рахунок
						Visible? Yes
						Editable? Yes
						Maximum Data Length: 14
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
					Column: colTip
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Tip
						Visible? No
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
					Column: colOkpo
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title:
						Visible? No
						Editable? Yes
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
					Column: colError
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
					Column: colCardAcct	! Техн. счет
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
				Functions
					Function: newRow
						Description:
						Returns
							Boolean:
						Parameters
							String: sFileAcc
							Number: sFileSum
							String: sPkNls
							String: sPkNms
							String: sPkTip
							String: sPkOkpo
							String: sCardAcct
							String: sErr
						Static Variables
						Local variables
							Number: nRow
						Actions
							Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
							Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
							Set colCardAcc = sFileAcc
							Set colS     = sFileSum
							Set colNls   = sPkNls
							Set colNms   = sPkNms
							Set colTip   = sPkTip
							Set colOkpo  = sPkOkpo
							Set colCardAcct = sCardAcct
							Set colError = sErr
							If sErr
								Call XSalTblSetRowBackColor(hWndForm, nRow, SalColorFromRGB(250, 170, 170))
							Return TRUE
					Function: payFile
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							Boolean: bError
							String: sError
							!
							: ccDoc
								Class: cDoc
							Number: nDk
							String: sNlsT	! Транзитный счет (obpc_trans.transit)
							String: sNlsK	! Карточный счет 2625
							String: sPlat	! Наим. плательщика (транзит)
							String: sPolu	! Наим. получателя (карт. счет)
							Number: nS	! Сумма
							String: sOkpo
							!
							Date/Time: dValDate
							String: sBankMfo
							Number: nVob
							Number: nRef
							!
							Number: nRow
							!
							File Handle: hF
							Boolean: bDirExist
							String: sBackUpDir
							!
							Number: nPayAcc
							Number: nPaySum
							Number: nFileId
						Actions
							If SalIsNull(dfTt)
								Call SalMessageBox('Не задано операцію для оплати!', 'Увага!', MB_IconExclamation | MB_Ok)
								Call SalSetFocus(cmbTt)
								Return FALSE
							If SalIsNull(dfTransitNls)
								Call SalMessageBox('Не задано транзитний рахунок!', 'Увага!', MB_IconExclamation | MB_Ok)
								Call SalSetFocus(dfTransitNls)
								Return FALSE
							If SalIsNull(dfNazn)
								Call SalMessageBox('Не задано призначення платежу!', "Увага!", MB_IconExclamation | MB_Ok)
								Call SalSetFocus(dfNazn)
								Return FALSE
							If SalIsNull(dfZB)
								Call SalMessageBox('Не задано позабалансовий символ!', 'Увага!', MB_IconExclamation | MB_Ok)
								Call SalSetFocus(dfZB)
								Return FALSE
							If dfPayAcc = 0 or dfPaySum = 0
								Call SalMessageBox('Немає документів для оплати!', 'Увага!', MB_IconExclamation | MB_Ok)
								Return FALSE
							If SalMessageBox(cmbTt || PutCrLf() || PutCrLf() ||
									   "Оплатити " || Str(dfPayAcc) || " документів на " || SalNumberToStrX(dfPaySum, 2) || " " || dfLcv || "?", 
									   "Увага!", MB_IconQuestion | MB_YesNo) = IDNO
								Return FALSE
							If dfOstc != NUMBER_Null and dfOstc < dfPaySum
								If SalMessageBox("На транзитному рахунку недостатньо коштів для проведення операції." || PutCrLf() || 
										   "Оплатити документи?", "Увага!", MB_IconExclamation | MB_YesNo) = IDNO
									Return FALSE
							Set bError = FALSE
							Set sError = ''
							If not SqlPrepareAndExecute(hSql(), "select s_obpczpfiles.nextval into :nFileId from dual")
								Return FALSE
							If not SqlFetchNext(hSql(), nFetchRes)
								Return FALSE
							Set nPayAcc = 0
							Set nPaySum = 0
							!
							Set nDk   = 1
							Set sNlsT = dfTransitNls
							Set sPlat = Subs(dfTransitNms,1,38)
							Set sNazn = dfNazn
							! -- Дата валютирования
							Set dValDate = GetBankDate()
							! -- МФО
							Set sBankMfo = GetBankMfo()
							! -- Мем. ордер
							Set nVob = 6
							!
							Call SalWaitCursor(TRUE)
							Set nRow = TBL_MinRow
							While SalTblFindNextRow(hWndForm, nRow, 0, 0)
								Call SalTblSetContext(hWndForm, nRow)
								If colNls and colS > 0
									! -- Счет
									Set sNlsK = colNls
									Set sPolu = colNms
									Set sOkpo = colOkpo
									! -- Сумма
									Set nS = colS * SalNumberPower(10, nDig)
									!
									Call ccDoc.SetDoc(0, dfTt, nDk, nVob, '',
											     dValDate, dValDate, dValDate, dValDate,
											     sNlsT, sPlat, sBankMfo, '', nKv, nS, sTransitOkpo,
											     sNlsK, sPolu, sBankMfo, '', nKv, nS, sOkpo,
											     sNazn, '', GetIdOper(), '', NUMBER_Null, 0)
									If not ccDoc.oDoc()
										Set bError = TRUE
										Set sError = 'Неуспешная оплата документа ' || dfTt || ' Д' || sNlsT || ' К' || sNlsK
										Break
									! -- Вставка доп. реквизитов если есть
									Set nRef = ccDoc.m_nRef
									If SalStrLeftX(colTip, 2) = 'PK'
										If not SqlPrepareAndExecute(hSql(), 
												"insert into operw (ref, tag, value) 
												 values (:nRef, 'CDAC', :colCardAcct)")
											Set bError = TRUE
											Set sError = 'Неуспішне виконання процедури додовання дод. реквизиту CDAC'
											Break
									If not SqlPrepareAndExecute(hSql(), 
											"insert into operw (ref, tag, value) 
											 values (:nRef, 'ZP_FN', :sCurrFile)")
										Set bError = TRUE
										Set sError = 'Неуспішне виконання процедури додовання дод. реквизиту ZP_FN'
										Break
									If not SqlPrepareAndExecute(hSql(), 
											"insert into operw (ref, tag, value) 
											 values (:nRef, 'ZP_ID', :nFileId)")
										Set bError = TRUE
										Set sError = 'Неуспішне виконання процедури додовання дод. реквизиту ZP_ID'
										Break
									If not SqlPrepareAndExecute(hSql(), 
											"insert into operw (ref, tag, value) 
											 values (:nRef, 'SK_ZB', :dfZB)")
										Set bError = TRUE
										Set sError = 'Неуспішне виконання процедури додовання дод. реквизиту SK_ZB'
										Break
									Set nPayAcc = nPayAcc + 1
									Set nPaySum = nPaySum + nS
							Call SalWaitCursor(TRUE)
							!
							If not bError
								Call SqlCommitEx(hSql(), "OBPC. Оплачено " || Str(nPayAcc) || " документів на " || Str(nPaySum/SalNumberPower(10, nDig)) || " " || dfLcv)
								Call SalMessageBox("Оплачено " || Str(nPayAcc) || " документів на " || SalNumberToStrX(nPaySum/SalNumberPower(10, nDig), 2) || " " || dfLcv, 
										     "Інформація", MB_IconAsterisk)
								! Переименовываем
								Set sBackUpDir = sFilePath || '\\backup\\' || SalFmtFormatDateTime(SalDateCurrent(), 'yyyyMMdd')
								! 16ZP____.___ - зарплатный файл, 1-2 симв - код района, 3-4 симв. - признак ЗП файла
								If Subs(SalStrUpperX(sCurrFile), 3, 2) = 'ZP'
									Set sBackUpDir = sBackUpDir || '\\' || Subs(sCurrFile, 1, 2)
								Set bDirExist = TRUE
								If not VisDosExist(sBackUpDir)
									Set bDirExist = FALSE
									If VisDosMakeAllDir(sBackUpDir) = VTERR_Ok
										Set bDirExist = TRUE
								If VisFileCopy(sFilePath || '\\' || sCurrFile, 
										   IifS(bDirExist=TRUE, sBackUpDir, sFilePath) || '\\' || SalStrReplaceX(sCurrFile, Len(sCurrFile)-3, 3, 'OLD'))
									Call SalFileOpen(hF, sFilePath || sCurrFile, OF_Delete)
								Call printFile(IifS(bDirExist=TRUE, sBackUpDir, sFilePath) || '\\' || SalStrReplaceX(sCurrFile, Len(sCurrFile)-3, 3, 'LOG'))
							Else
								Call SqlRollbackEx(hSql(), "OBPC. " || sError)
							! сохраняем инф. о файле
							If not bError
								If not SqlPrepareAndExecute(hSql(), 
										"insert into obpc_zp_files(id, file_name, transit_acc, file_acc, file_sum, pay_acc, pay_sum)
										 values (:nFileId, :sCurrFile, :nTransitAcc, :dfFileAcc, :dfFileSum * power(10,:nDig), :nPayAcc, :nPaySum)")
									Call SqlRollbackEx(hSql(), "OBPC. Ошибка сохранения инф. о З/П файле " || sCurrFile)
								Else
									Call SqlCommitEx(hSql(), "OBPC. Сохранена инф. о З/П файле " || sCurrFile)
							Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
							Return TRUE
					Function: printFile
						Description:
						Returns
							Boolean:
						Parameters
							String: sFileName
						Static Variables
						Local variables
							Number: nRow
							File Handle: hF
							String: sBadCardAcc
							String: sBadTipAcc
						Actions
							If not SalFileOpen(hF, sFileName, OF_Write | OF_Text)
								Call SalMessageBox('Неможливо відкрити файл ' || GetPrnDir()  || '\\' || sCurrFile, 'Ошибка!', MB_IconStop | MB_Ok)
								Return FALSE
							Call SalFilePutStr(hF, sCurrFile || ' ' || SalFmtFormatDateTime(SalDateCurrent(), 'dd.MM.yyyy hhhh:mm:ss'))
							If dfTransitNls
								Call SalFilePutStr(hF, dfTransitNls || ' ' || dfLcv || ' ' || dfTransitNms)
							Set nRow = TBL_MinRow
							While SalTblFindNextRow(hWndForm, nRow, 0, 0)
								Call SalTblSetContext(hWndForm, nRow)
								Call SalFilePutStr(hF, 
										     PadR(colCardAcc,14) || ' ' || 
										     PadL(SalNumberToStrX(colS,2), 16) || ' ' || 
										     IifS(colNls='', '', PadR(colNls, 14) || ' ') || 
										     IifS(colNms='', '', PadR(colNms, 38) || ' ') || 
										     IifS(colError='','',colError))
							Call SalFilePutStr(hF, '')
							Call SalFilePutStr(hF, 'Всьго рахунків: ' || Str(dfFileAcc))
							Call SalFilePutStr(hF, 'Сума файлу    : ' || SalNumberToStrX(dfFileSum,2))
							If nBadAccCard
								Call SalFilePutStr(hF, 'Технічних рахунків не знайдено: ' || Str(nBadAccCard))
								Call SalFilePutStr(hF, '   ' || sBadAccCard)
							If nBadAccTip
								Call SalFilePutStr(hF, 'Рахунки не є картковими: ' || Str(nBadAccTip))
								Call SalFilePutStr(hF, '   ' || sBadAccTip)
							If nBadAccSum
								Call SalFilePutStr(hF, 'Рахунки з нульовими сумами: ' || Str(nBadAccSum))
								Call SalFilePutStr(hF, '   ' || sBadAccSum)
							If nBadAccOkpo
								Call SalFilePutStr(hF, 'Невідповіднисть ЗКПО: ' || Str(nBadAccOkpo))
								Call SalFilePutStr(hF, '   ' || sBadAccOkpo)
							Call SalFilePutStr(hF, 'Рахунків до сплати: ' || Str(dfPayAcc))
							Call SalFilePutStr(hF, 'Сума до сплати    : ' || SalNumberToStrX(dfPaySum,2))
							Call SalFileClose(hF)
							Return TRUE
				Window Variables
					Number: nRow
				Message Actions
			!
			Picture: picItog
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   3.2"
					Top:    6.8"
					Width:  12.8"
					Width Editable? Yes
					Height: 0.75"
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
				Border Color: Default
				Background Color: 3D Face Color
				Message Actions
			Data Field: bgFileAcc
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
						Left:   3.4"
						Top:    6.952"
						Width:  1.6"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? No
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Bold
					Text Color: Default
					Background Color: 3D Face Color
					Input Mask: Unformatted
				Message Actions
			Data Field: dfFileAcc
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
						Left:   5.05"
						Top:    6.9"
						Width:  1.6"
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
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Data Field: dfFileSum
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
						Left:   5.05"
						Top:    7.2"
						Width:  1.6"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Decimal
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Data Field: bgFileSum
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
						Left:   3.4"
						Top:    7.25"
						Width:  1.6"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? No
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Bold
					Text Color: Default
					Background Color: 3D Face Color
					Input Mask: Unformatted
				Message Actions
			Data Field: bgError
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
						Left:   6.8"
						Top:    6.952"
						Width:  3.4"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? No
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Bold
					Text Color: Dark Red
					Background Color: 3D Face Color
					Input Mask: Unformatted
				Message Actions
			Data Field: dfError
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
						Left:   10.25"
						Top:    6.9"
						Width:  1.6"
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
					Font Enhancement: Bold
					Text Color: Dark Red
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			! Data Field: bgBadAccTip
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
						Left:   6.8"
						Top:    7.25"
						Width:  3.4"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? No
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Bold
					Text Color: Dark Red
					Background Color: 3D Face Color
					Input Mask: Unformatted
.end
				 Message Actions 
			! Data Field: dfBadAccTip
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
						Left:   10.25"
						Top:    7.2"
						Width:  1.6"
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
					Font Enhancement: Bold
					Text Color: Dark Red
					Background Color: Default
					Input Mask: Unformatted
.end
				 Message Actions 
			Data Field: bgPayAcc
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
						Left:   12.1"
						Top:    6.952"
						Width:  2.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? No
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Bold
					Text Color: Default
					Background Color: 3D Face Color
					Input Mask: Unformatted
				Message Actions
			Data Field: dfPayAcc
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
						Left:   14.15"
						Top:    6.9"
						Width:  1.6"
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
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Data Field: bgPaySum
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
						Left:   12.1"
						Top:    7.25"
						Width:  2.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? No
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Bold
					Text Color: Default
					Background Color: 3D Face Color
					Input Mask: Unformatted
				Message Actions
			Data Field: dfPaySum
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
						Left:   14.15"
						Top:    7.2"
						Width:  1.6"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Decimal
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Транзитний рахунок
				Resource Id: 26082
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   3.2"
					Top:    0.4"
					Width:  2.4"
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
			Background Text: Призначення платежу
				Resource Id: 26080
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   3.2"
					Top:    1.0"
					Width:  2.4"
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
			Background Text: Позабаланс. символ
				Resource Id: 26081
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   3.2"
					Top:    1.3"
					Width:  2.4"
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
		Functions
			Function: readFile
				Description:
				Returns
					Boolean:
				Parameters
					String: sFName
				Static Variables
				Local variables
					Boolean: bError
					String: sError
				Actions
					Set bError = FALSE
					Set sError = ''
					Call clearFields(TRUE)
					!
					If SalStrUpperX(SalStrMidX(sFName, Len(sFName)-3, 3)) = 'TXT'
						Set bError = not readFileTxt(sFName, sError)
					Else If SalStrUpperX(SalStrMidX(sFName, Len(sFName)-3, 3)) = 'DBF'
						Set bError = not readFileDbf(sFName, sError)
					Else If SalStrUpperX(SalStrMidX(sFName, Len(sFName)-3, 3)) = 'XML'
						Set bError = not readFileXml(sFName, sError)
					!
					If bError
						Call SalMessageBox(sError, "Увага!", MB_IconExclamation)
					Else
						Set dfFileAcc = nAllAcc
						Set dfFileSum = nAllSum
						Set dfError   = nBadAccCard + nBadAccTip + nBadAccSum + nBadAccOkpo
						Set dfPayAcc  = nPayAcc
						Set dfPaySum  = nPaySum
						If dfError > 0
							Call SalShowWindowAndLabel(bgError)
							Call SalShowWindow(dfError)
						Else
							Call SalHideWindowAndLabel(bgError)
							Call SalHideWindow(dfError)
					Return TRUE
			Function: readFileTxt
				Description:
				Returns
					Boolean:
				Parameters
					String: sFName
					Receive String: sRetError
				Static Variables
				Local variables
					Number: nCountLine
					Number: nError
					String: sError
					!
					String: sFileName
					File Handle: hFile
					String: sLine
					String: sFileAcc
					String: sFileFio
					Number: nFileSum
					!
					String: sPkNls
					String: sPkNms
					String: sPkTip
					String: sPkOkpo
					String: sCardAcct
					String: sOkpo
					! Количество колонок
					Number: nValueCount
					! Значения колонок
					String: sValues[*]
				Actions
					! -- Открываем файл
					Set sFileName = sFilePath || sFName
					If not SalFileOpen(hFile, sFileName, OF_Read | OF_Text )
						Set sRetError = "Неможливо відкрити Файл " || sFileName
						Return FALSE
					! -- Обработка файла
					Set nCountLine = 0
					Call SalWaitCursor(TRUE)
					While SalFileGetStr(hFile, sLine, 1024)
						If SalStrTrim(sLine, sLine) > 0
							! Проверка на транзитный счет в первой строке
							If nCountLine = 0 and Len(sLine) <= 14
								! Транзитный счет
								Set dfTransitNls = sLine
								Call SalSendMsg(dfTransitNls, SAM_Validate, 0, 0)
							Else
								Call SalArraySetUpperBound(sValues, 1, -1)
								Set nValueCount = SalStrTokenize(sLine, ',', ',', sValues)
								If nValueCount != 4
									Set sRetError = "Порушено структуру файлу: рядок " || Str(nCountLine+1)
									Return FALSE
								! -- Данные из файла
								! Счет
								Set sFileAcc = SalStrTrimX(sValues[0])
								! ФИО
								Set sFileFio = SalStrTrimX(StrDosToWinX(sValues[1]))
								! Сумма
								Set nFileSum = SalStrToNumber(sValues[2])
								! ОКПО
								Set sPkOkpo = SalStrTrimX(sValues[3])
								!
								If not checkLine(sFileAcc, nFileSum, nError, sError, sPkNls, sPkNms, sPkTip, sOkpo, sCardAcct)
									Call tblCard.newRow(sFileAcc, nFileSum, STRING_Null, sFileFio, sPkTip, STRING_Null, STRING_Null, sError)
									! Рахунок не знайдено
									If nError = 1
										Set sBadAccCard = sBadAccCard || IifS(sBadAccCard='', '', ',') || sFileAcc
										Set nBadAccCard = nBadAccCard + 1
									! Рахунок не є картковим
									If nError = 2
										Set sBadAccTip = sBadAccTip || IifS(sBadAccTip='', '', ',') || sPkNls
										Set nBadAccTip = nBadAccTip + 1
									! Нульова сума
									If nError = 3
										Set sBadAccSum = sBadAccSum || IifS(sBadAccSum='', '', ',') || sPkNls
										Set nBadAccSum = nBadAccSum + 1
								Else
									If sOkpo != sPkOkpo
										Call tblCard.newRow(sFileAcc, nFileSum, STRING_Null, sFileFio, sPkTip, STRING_Null, STRING_Null, "Невідповідність ЗКПО")
										Set sBadAccOkpo = sBadAccOkpo || IifS(sBadAccOkpo='', '', ',') || sPkNls
										Set nBadAccOkpo = nBadAccOkpo + 1
									Else
										Call tblCard.newRow(sFileAcc, nFileSum, sPkNls, sPkNms, sPkTip, sPkOkpo, sCardAcct, "")
										Set nPayAcc = nPayAcc + 1
										Set nPaySum = nPaySum + nFileSum
								!
								Set nAllAcc = nAllAcc + 1
								Set nAllSum = nAllSum + nFileSum
						Set nCountLine = nCountLine + 1
					Call SalWaitCursor(FALSE)
					! -- Закрываем файл
					Call SalFileClose(hFile)
					!
					Return TRUE
			Function: readFileDbf
				Description:
				Returns
					Boolean:
				Parameters
					String: sFName
					Receive String: sRetError
				Static Variables
				Local variables
					Number: nCountLine
					Number: nError
					String: sError
					!
					String: sFileAcc
					String: sFileFio
					Number: nFileSum
					!
					String: sPkNls
					String: sPkNms
					String: sPkTip
					String: sPkOkpo
					String: sCardAcct
					String: sOkpo
					!
					Sql Handle: hODBC
				Actions
					! -- Открываем файл
					Set sFileName = sFilePath || sFName
					Call SalFileSetCurrentDirectory(sFilePath)
					If not SalFileOpen(hFile, sFileName, OF_Exist)
						Call SalMessageBox("Неможливо відкрити Файл " || sFileName, 
								     "Увага!", MB_IconExclamation | MB_Ok)
						Return FALSE
					! -- Импорт
					Call SalWaitCursor(TRUE)
					Set SqlDatabase = 'dBase_Files'
					If SqlConnect(hODBC)
						! -- Обработка файла
						Set nCountLine = 0
						If SqlPrepareAndExecute(hODBC, 
								"select count_no, fio, amount, id_kod
								   into :sFileAcc, :sFileFio, :nFileSum, :sPkOkpo
								   from " || Subs(sFName, 1, Len(sFName)-4))
							While SqlFetchNext(hODBC, nFetchRes)
								Set sFileAcc = SalStrTrimX(sFileAcc)
								Set sFileFio = StrDosToWinX(SalStrTrimX(sFileFio))
								!
								If not checkLine(sFileAcc, nFileSum, nError, sError, sPkNls, sPkNms, sPkTip, sOkpo, sCardAcct)
									Call tblCard.newRow(sFileAcc, nFileSum, STRING_Null, sFileFio, sPkTip, STRING_Null, STRING_Null, sError)
									! Рахунок не знайдено
									If nError = 1
										Set sBadAccCard = sBadAccCard || IifS(sBadAccCard='', '', ',') || sFileAcc
										Set nBadAccCard = nBadAccCard + 1
									! Рахунок не є картковим
									If nError = 2
										Set sBadAccTip = sBadAccTip || IifS(sBadAccTip='', '', ',') || sPkNls
										Set nBadAccTip = nBadAccTip + 1
									! Нульова сума
									If nError = 3
										Set sBadAccSum = sBadAccSum || IifS(sBadAccSum='', '', ',') || sPkNls
										Set nBadAccSum = nBadAccSum + 1
								Else
									If sOkpo != sPkOkpo
										Call tblCard.newRow(sFileAcc, nFileSum, STRING_Null, sFileFio, sPkTip, STRING_Null, STRING_Null, "Невідповідність ЗКПО")
										Set sBadAccOkpo = sBadAccOkpo || IifS(sBadAccOkpo='', '', ',') || sPkNls
										Set nBadAccOkpo = nBadAccOkpo + 1
									Else
										Call tblCard.newRow(sFileAcc, nFileSum, sPkNls, sPkNms, sPkTip, sPkOkpo, sCardAcct, "")
										Set nPayAcc = nPayAcc + 1
										Set nPaySum = nPaySum + nFileSum
								!
								Set nAllAcc = nAllAcc + 1
								Set nAllSum = nAllSum + nFileSum
								Set nCountLine = nCountLine + 1
					Call SqlDisconnect(hODBC)
					Call SalWaitCursor(FALSE)
					!
					Return TRUE
			Function: readFileXml
				Description:
				Returns
					Boolean:
				Parameters
					String: sFName
					Receive String: sRetError
				Static Variables
				Local variables
					Number: nCountLine
					Number: nError
					String: sError
					!
					String: sFileAcc
					String: sFileFio
					Number: nFileSum
					!
					String: sPkNls
					String: sPkNms
					String: sPkTip
					String: sPkOkpo
					String: sCardAcct
					String: sOkpo
				Actions
					! -- Открываем файл
					Set sFileName = sFilePath || sFName
					If not PutFileToTmpLob(hSql(), sFileName, 'C')
						Set sRetError = "Не вдалося загрузити файл " || sFName
						Return FALSE
					If not SqlPLSQLCommand(hSql(), "obpc.load_xml_file(0)")
						Call SqlRollback(hSql())
						Set sRetError = "Не вдалося загрузити файл " || sFName
						Return FALSE
					Call SqlCommit(hSql())
					! -- Данные из файла
					Set nCountLine = 0
					Call SqlPrepareAndExecute(hSqlAux(),
							"select nls, nms, okpo, s/100
							   into :sFileAcc, :sFileFio, :sPkOkpo, :nFileSum
							   from tmp_bpk_salary")
					While SqlFetchNext(hSqlAux(), nFetchRes)
						If not checkLine(sFileAcc, nFileSum, nError, sError, sPkNls, sPkNms, sPkTip, sOkpo, sCardAcct)
							Call tblCard.newRow(sFileAcc, nFileSum, STRING_Null, sFileFio, sPkTip, STRING_Null, STRING_Null, sError)
							! Рахунок не знайдено
							If nError = 1
								Set sBadAccCard = sBadAccCard || IifS(sBadAccCard='', '', ',') || sFileAcc
								Set nBadAccCard = nBadAccCard + 1
							! Рахунок не є картковим
							If nError = 2
								Set sBadAccTip = sBadAccTip || IifS(sBadAccTip='', '', ',') || sPkNls
								Set nBadAccTip = nBadAccTip + 1
							! Нульова сума
							If nError = 3
								Set sBadAccSum = sBadAccSum || IifS(sBadAccSum='', '', ',') || sPkNls
								Set nBadAccSum = nBadAccSum + 1
						Else
							If sOkpo != sPkOkpo
								Call tblCard.newRow(sFileAcc, nFileSum, STRING_Null, sFileFio, sPkTip, STRING_Null, STRING_Null, "Невідповідність ЗКПО")
								Set sBadAccOkpo = sBadAccOkpo || IifS(sBadAccOkpo='', '', ',') || sPkNls
								Set nBadAccOkpo = nBadAccOkpo + 1
							Else
								Call tblCard.newRow(sFileAcc, nFileSum, sPkNls, sPkNms, sPkTip, sPkOkpo, sCardAcct, "")
								Set nPayAcc = nPayAcc + 1
								Set nPaySum = nPaySum + nFileSum
						Set nAllAcc = nAllAcc + 1
						Set nAllSum = nAllSum + nFileSum
						Set nCountLine = nCountLine + 1
					!
					Return TRUE
			Function: clearFields
				Description:
				Returns
					Boolean:
				Parameters
					Boolean: bFlag
				Static Variables
				Local variables
				Actions
					Call SalTblReset(tblCard)
					If not sParTt
						Set dfTranType = STRING_Null
						Set dfTt = STRING_Null
						Call SalListSetSelect(cmbTt, -1)
						Call EnableWindow(cmbTt, bFlag)
						Set dfNazn = ''
					Set dfTransitNls = ''
					Set dfTransitNms = ''
					Set dfOstc = NUMBER_Null
					Set dfOstb = NUMBER_Null
					Set dfZB = ''
					Call SalListSetSelect(cmbZB, -1)
					Set dfFileAcc = 0
					Set dfFileSum = 0
					Set dfError   = 0
					Set dfPayAcc  = 0
					Set dfPaySum  = 0
					Set nBadAccCard = 0
					Set sBadAccCard = ''
					Set nBadAccTip  = 0
					Set sBadAccTip  = ''
					Set nBadAccSum  = 0
					Set sBadAccSum  = ''
					Set nBadAccOkpo = 0
					Set sBadAccOkpo = ''
					Set nAllAcc = 0
					Set nPayAcc = 0
					Set nAllSum = 0
					Set nPaySum = 0
					Call EnableWindow(dfTransitNls, bFlag)
					If bFlag
						Call SalEnableWindow(pbSelectTransit)
					Else
						Call SalDisableWindow(pbSelectTransit)
					Call EnableWindow(dfNazn, bFlag)
					Call EnableWindow(dfZB, bFlag)
					Call EnableWindow(cmbZB, bFlag)
					If sParTt
						Call SqlPrepareAndExecute(hSql(), "select val into :dfZB from op_rules where tt = :dfTt and tag = 'SK_ZB'")
						If SqlFetchNext(hSql(), nFetchRes)
							Call cmbZB.SetSelectById(dfZB)
					Return TRUE
			Function: checkFile
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					String: sFName
					Date/Time: dFDat
					Number: nFAcc
					Number: nFSum
				Actions
					If not SqlPrepareAndExecute(hSql(), 
							"select z.file_name, z.file_date, z.file_acc, z.file_sum/power(10, :nDig)
							   into :sFName, :dFDat, :nFAcc, :nFSum
							   from obpc_zp_files z, accounts a
							  where a.acc = z.transit_acc
							    and z.transit_acc = :nTransitAcc
							    and z.file_sum = :dfFileSum * power(10, :nDig)
							    and trunc(z.file_date) = trunc(sysdate)")
						Return FALSE
					If SqlFetchNext(hSql(), nFetchRes)
						If SalMessageBox("Файл з транзитним рахунком " || dfTransitNls || " на суму " || SalNumberToStrX(dfFileSum,2) || " сьогодні вже приймався!" || PutCrLf() ||
								"   ім'я файлу: " || sFName || PutCrLf() ||
								"   дата файлу: " || SalFmtFormatDateTime(dFDat, 'dd.MM.yyyy hhhh:mm:ss') || PutCrLf() ||
								"   кіл-ть рахунків: " || Str(nFAcc) || PutCrLf() ||
								"   сума файлу: " || SalNumberToStrX(nFSum,2) || PutCrLf() ||
								"Прийняти файл?", "Увага!", MB_IconExclamation | MB_YesNo) = IDNO
							Return FALSE
					Return TRUE
			Function: checkLine
				Description:
				Returns
					Boolean:
				Parameters
					String: sCheckNls
					Number: nCheckSum
					Receive Number: nErr
					Receive String: sErr
					Receive String: sRetNls
					Receive String: sRetNms
					Receive String: sRetTip
					Receive String: sRetOkpo
					Receive String: sRetCardAcct
				Static Variables
				Local variables
					Date/Time: dDazs
				Actions
					Set nErr = 0
					Set sErr = ''
					Set sRetNls = ''
					Set sRetNms = ''
					Set sRetTip = ''
					Set sRetOkpo = ''
					Set sRetCardAcct = ''
					If Subs(sCheckNls,1,4) = '2625'
						Call SqlPrepareAndExecute(hSql(), 
								"select a.nls, substr(a.nms,1,38), a.tip, c.okpo, a.dazs
								   into :sRetNls, :sRetNms, :sRetTip, :sRetOkpo, :dDazs
								   from accounts a, customer c
								  where a.nls = :sCheckNls
								    and a.kv  = :nBaseVal
								    and a.rnk = c.rnk")
						If not SqlFetchNext(hSql(), nFetchRes)
							Set nErr = 1
							Set sErr = "Рахунок не знайдено"
							Return FALSE
						If SalStrLeftX(sRetTip, 2) != 'PK' and SalStrLeftX(sRetTip, 2) != 'W4'
							Set nErr = 2
							Set sErr = "Рахунок не є картковим"
							Return FALSE
						If SalStrLeftX(sRetTip, 2) = 'PK'
							! если счет PK закрыт
							If dDazs != DATETIME_Null
								! ищем новый счет W4
								Call SqlPrepareAndExecute(hSql(), 
										"select nls, substr(a.nms,1,38), a.tip, a.dazs
										   into :sRetNls, :sRetNms, :sRetTip, :dDazs
										   from accounts a
										  where a.nlsalt = :sCheckNls
										    and a.kv     = :nBaseVal
										    and a.tip like 'W4%'")
								If not SqlFetchNext(hSql(), nFetchRes)
									Set nErr = 1
									Set sErr = "Рахунок закрито"
									Return FALSE
							Else
								Call SqlPrepareAndExecute(hSql(), "select card_acct into :sRetCardAcct from obpc_acct where lacct = :sCheckNls and currency = 'UAH'")
								If not SqlFetchNext(hSql(), nFetchRes)
									Set nErr = 1
									Set sErr = "Рахунок не знайдено в ACCT"
									Return FALSE
						If SalStrLeftX(sRetTip, 2) = 'W4' and dDazs != DATETIME_Null
							Set nErr = 1
							Set sErr = "Рахунок закрито"
							Return FALSE
					Else
						Call SqlPrepareAndExecute(hSql(), 
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
						If not SqlFetchNext(hSql(), nFetchRes)
							Set nErr = 1
							Set sErr = "Рахунок не знайдено"
							Return FALSE
						If SalStrLeftX(sRetTip, 2) != 'PK'
							Set nErr = 2
							Set sErr = "Рахунок не є картковим"
							Return FALSE
					If nCheckSum = 0
						Set nErr = 3
						Set sErr = "Нульова сума"
						Return FALSE
					Return TRUE
			Function: getTransit
				Description:
				Returns
					Boolean:
				Parameters
					String: sWhere
				Static Variables
				Local variables
				Actions
					If not SqlPrepareAndExecute(hSql(), 
							"select a.acc, a.nls, a.nms, c.okpo, a.ostc/100, a.ostb/100
							   into :nTransitAcc, :dfTransitNls, :dfTransitNms,
							        :sTransitOkpo, :dfOstc, :dfOstb
							   from accounts a, customer c
							  where a.rnk = c.rnk and " || sWhere )
							or not SqlFetchNext(hSql(), nFetchRes)
						Set dfTransitNls = ''
						Set dfTransitNms = ''
						Set dfOstc = NUMBER_Null
						Set dfOstb = NUMBER_Null
						Call SalMessageBox("Рахунок не знайдено!", "Увага!", MB_IconExclamation | MB_Ok)
						Return FALSE
					Return TRUE
		Window Parameters
			String: sParTt
		Window Variables
			String: sFilePath
			Number: nBaseVal
			Number: nKv
			Number: nDig
			String: sTransitOkpo
			Number: nTransitAcc
			String: sNazn	! Назначение платежа
			String: sTtName	! Наименование операции
			!
			String: smFile[*]
			Number: nFiles
			Number: nIterator
			Number: hRoot
			Number: h1stChild
			Number: nCurrentFlag
			Number: nIndex
			Number: hPicRoot1
			String: sCurrFile
			!
			String: sTmp
			String: sPK
			String: sSem
			!
			Number: nAllAcc
			Number: nPayAcc
			Number: nAllSum
			Number: nPaySum
			!
			Number: nBadAccCard
			String: sBadAccCard
			Number: nBadAccTip
			String: sBadAccTip
			Number: nBadAccSum
			String: sBadAccSum
			Number: nBadAccOkpo
			String: sBadAccOkpo
			Number: nBadAcc
			!
			Number: nWW
			Number: nWH
			Number: nX
			Number: nY
			Number: nW
			Number: nH
			Number: nCX
			Number: nCY
			Number: nCW
			Number: nCH
		Message Actions
			On SAM_Create
				! Установка оптимального размера окна в зависимости от настроек рабочей станции
				Call SetWindowFullSize(hWndForm)
				Call SalGetWindowSize(hWndForm, nWW, nWH)
				If nWH < 5
					Set nWH = 5
				Else If nWH > 8.4
					Set nWH = 8.4
				Call SalSetWindowSize(hWndForm, 16.3, nWH)
				Call PrepareWindowEx(hWndForm)
				Call SalUseRegistry(FALSE, '')
				Call SalGetProfileString('OBPC', 'OBPCZpPath', '', sFilePath, GetIniFileName())
				If sFilePath = ''
					Call SalGetProfileString('OBPC', 'OBPCInPath', '', sFilePath, GetIniFileName())
				Set hPicRoot1 = VisPicLoad(PIC_LoadSWinRes | PIC_FormatIcon | PIC_LoadSmallIcon, 'icon_Folder1', '')
				Set nBaseVal = GetBaseVal()
				Set nKv      = nBaseVal
				Set dfLcv    = Str(nBaseVal)
				Call SalSendMsg(dfLcv, SAM_Validate, 0, 0)
				!
				Call SalHideWindowAndLabel(bgError)
				Call SalHideWindow(dfError)
				Set bgFileAcc = 'Всьго рахунків:'
				Set bgFileSum = 'Сума файлу:'
				Set bgError   = 'Помилки:'
				Set bgPayAcc  = 'Рахунків до сплати:'
				Set bgPaySum  = 'Сума до сплати:'
				Call clearFields(FALSE)
			On WM_Size
				Call SalGetWindowSize(hWndForm, nWW, nWH)
				If nWH < 5
					Set nWH = 5
				Call SalSetWindowSize(hWndForm, 16.3, nWH)
				!
				Call GetClientRect(hWndForm, nX, nY, nW, nH)
				!
				Call SalGetWindowSize(hWndForm.frm_ImportZP.cFiles, nWW, nWH)
				Call SalSetWindowSize(hWndForm.frm_ImportZP.cFiles,
						     nWW, SalPixelsToFormUnits(hWndForm.frm_ImportZP.cFiles, nH, TRUE)-0.05)
				Call SalGetWindowSize(hWndForm.frm_ImportZP.tblCard, nCW, nCH)
				Call SalSetWindowSize(hWndForm.frm_ImportZP.tblCard,
						     nCW, SalPixelsToFormUnits(hWndForm.frm_ImportZP.tblCard, nH, TRUE)-2.4)
				! Итоги
				Call SalGetWindowLoc(hWndForm.frm_ImportZP.picItog, nCX, nCY)
				Call SalSetWindowLoc(hWndForm.frm_ImportZP.picItog,
						     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.8)
				!
				Call SalGetWindowLoc(hWndForm.frm_ImportZP.bgFileAcc, nCX, nCY)
				Call SalSetWindowLoc(hWndForm.frm_ImportZP.bgFileAcc,
						     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.6)
				Call SalGetWindowLoc(hWndForm.frm_ImportZP.dfFileAcc, nCX, nCY)
				Call SalSetWindowLoc(hWndForm.frm_ImportZP.dfFileAcc,
						     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.65)
				!
				Call SalGetWindowLoc(hWndForm.frm_ImportZP.bgFileSum, nCX, nCY)
				Call SalSetWindowLoc(hWndForm.frm_ImportZP.bgFileSum,
						     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.35)
				Call SalGetWindowLoc(hWndForm.frm_ImportZP.dfFileSum, nCX, nCY)
				Call SalSetWindowLoc(hWndForm.frm_ImportZP.dfFileSum,
						     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.4)
				!
				Call SalGetWindowLoc(hWndForm.frm_ImportZP.bgError, nCX, nCY)
				Call SalSetWindowLoc(hWndForm.frm_ImportZP.bgError,
						     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.6)
				Call SalGetWindowLoc(hWndForm.frm_ImportZP.dfError, nCX, nCY)
				Call SalSetWindowLoc(hWndForm.frm_ImportZP.dfError,
						     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.65)
				!
				! Call SalGetWindowLoc(hWndForm.frm_ImportZP.bgBadAccTip, nCX, nCY)
				! Call SalSetWindowLoc(hWndForm.frm_ImportZP.bgBadAccTip,
						     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.35)
				! Call SalGetWindowLoc(hWndForm.frm_ImportZP.dfBadAccTip, nCX, nCY)
				! Call SalSetWindowLoc(hWndForm.frm_ImportZP.dfBadAccTip,
						     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.4)
				!
				Call SalGetWindowLoc(hWndForm.frm_ImportZP.bgPayAcc, nCX, nCY)
				Call SalSetWindowLoc(hWndForm.frm_ImportZP.bgPayAcc,
						     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.6)
				Call SalGetWindowLoc(hWndForm.frm_ImportZP.dfPayAcc, nCX, nCY)
				Call SalSetWindowLoc(hWndForm.frm_ImportZP.dfPayAcc,
						     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.65)
				!
				Call SalGetWindowLoc(hWndForm.frm_ImportZP.bgPaySum, nCX, nCY)
				Call SalSetWindowLoc(hWndForm.frm_ImportZP.bgPaySum,
						     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.35)
				Call SalGetWindowLoc(hWndForm.frm_ImportZP.dfPaySum, nCX, nCY)
				Call SalSetWindowLoc(hWndForm.frm_ImportZP.dfPaySum,
						     nCX, SalPixelsToFormUnits(hWndForm, nH, TRUE)-0.4)
				!
				Call SalInvalidateWindow(hWndForm)
	Form Window: frm_PayCard
		Class:
		Property Template:
		Class DLL Name:
		Title: Поповнення карткових рахунків
		Icon File:
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Automatically Created at Runtime? No
			Initial State: Normal
			Maximizable? Yes
			Minimizable? Yes
			System Menu? Yes
			Resizable? Yes
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  9.55"
				Width Editable? Yes
				Height: 7.4"
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
			Frame
				Resource Id: 16727
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    0.1"
					Width:  9.2"
					Width Editable? Yes
					Height: 6.0"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Border Color: 3D Shadow Color
				Background Color: Default
			Background Text: Операція
				Resource Id: 19139
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    0.25"
					Width:  2.4"
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
			Data Field: dfTranType
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
						Left:   2.7"
						Top:    0.2"
						Width:  0.6"
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
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Data Field: dfTt
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 3
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   3.35"
						Top:    0.2"
						Width:  0.8"
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
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Combo Box: cmbTt
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_StrId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   4.2"
					Top:    0.2"
					Width:  4.95"
					Width Editable? Class Default
					Height: 1.036"
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
						If cmbTt.Init(hWndItem)
							If sParTt
								Call cmbTt.Populate(hSql(), "tt", "name", "v_bpk_tt_for_listpay", "where tt='" || sParTt || "' order by tt")
								If cmbTt.nItemNum = 0
									Call SalDestroyWindow(hWndForm)
								Else
									Call cmbTt.SetSelectById(sParTt)
									Call SalDisableWindow(hWndItem)
									Call SalSendMsg(hWndItem, SAM_Click, 0, 0)
							Else
								Call cmbTt.Populate(hSql(), "tt", "name", "v_bpk_tt_for_listpay", "order by tt")
					On SAM_Click
						Call SalSendClassMessage(SAM_Click, 0, 0)
						Set dfTt = cmbTt.strCurrentId
						Call SqlPrepareAndExecute(hSql(), "select tran_type into :dfTranType from obpc_trans_out where tt = :dfTt")
						Call SqlFetchNext(hSql(), nFetchRes)
						Call SqlPrepareAndExecute(hSql(), "select nvl(nazn,name) into :dfNazn from tts where tt = :dfTt")
						Call SqlFetchNext(hSql(), nFetchRes)
						Call SqlPrepareAndExecute(hSql(), "select val into :dfZB from op_rules where tt = :dfTt and tag = 'SK_ZB'")
						If SqlFetchNext(hSql(), nFetchRes)
							Call cmbZB.SetSelectById(dfZB)
						Else
							Set dfZB = ''
							Call SalListSetSelect(cmbZB, -1)
			!
			Background Text: Транзитний рахунок
				Resource Id: 16724
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    0.55"
					Width:  2.433"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfTransitNls
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
						Left:   2.7"
						Top:    0.5"
						Width:  2.4"
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
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_Validate
						If not SalIsNull(dfTransitNls)
							If not SqlPrepareAndExecute(hSql(), 
									"select acc, nls, nms into :nTransitAcc, :dfTransitNls, :dfTransitNms
									   from saldod
									  where nls = :dfTransitNls and kv = :nKv")
									or not SqlFetchNext(hSql(), nFetchRes)
								Set nTransitAcc  = NUMBER_Null
								Set dfTransitNls = ''
								Set dfTransitNms = ''
								Call SalMessageBox("Рахунок не знайдено або недоступно на дебет!", "Увага!", MB_IconExclamation | MB_Ok)
								Return VALIDATE_Cancel
						Return VALIDATE_Ok
			Data Field: dfLcv
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 3
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   5.15"
						Top:    0.5"
						Width:  0.8"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Center
					Format: Uppercase
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_Validate
						If SalIsNull(hWndItem)
							Set dfLcv = Str(nBaseVal)
						If SalIsValidInteger(hWndItem)
							Set sTmp = 'kv'
						Else
							Set sTmp = 'lcv'
						Call SqlPrepareAndExecute(hSql(), "select kv, lcv, dig into :nKv, :dfLcv, :nDig from tabval where " || sTmp || " = :dfLcv")
						If not SqlFetchNext(hSql(), nFetchRes)
							Call SalMessageBox("Невідома валюта "|| " " || dfLcv,
									     "Увага!", MB_IconExclamation )
							Set dfLcv = 'UAH'
							Return VALIDATE_Cancel
						Return VALIDATE_Ok
			Pushbutton: pbSelectTransit
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cPushButtonLabeled
				Property Template:
				Class DLL Name:
				Title: Вибрати...
				Window Location and Size
					Left:   6.0"
					Top:    0.48"
					Width:  1.2"
					Width Editable? Yes
					Height: 0.3"
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
						If FunNSIGetFiltered("v_bpk_transit", "acc", "v_bpk_transit.lcv='" || dfLcv || "'", sPK, sSem)
							Call SqlPrepareAndExecute(hSql(), "select nls, nms into :dfTransitNls, :dfTransitNms from accounts where acc=:sPK")
							Call SqlFetchNext(hSql(), nFetchRes)
			Data Field: dfTransitNms
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
						Left:   2.7"
						Top:    0.8"
						Width:  6.5"
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
			Background Text: Призначення платежу
				Resource Id: 16723
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    1.15"
					Width:  2.4"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfNazn
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 160
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   2.7"
						Top:    1.1"
						Width:  6.5"
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
			Background Text: Позабаланс. символ
				Resource Id: 24108
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    1.45"
					Width:  2.4"
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
			Data Field: dfZB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 2
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   2.7"
						Top:    1.4"
						Width:  0.6"
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
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_Validate
						If SalIsNull(dfZB)
							Call SalListSetSelect(cmbZB, -1)
							Return VALIDATE_OkClearFlag
						Call cmbZB.SetSelectById(dfZB)
						If cmbZB.strCurrentId
							Return VALIDATE_Ok
						Else
							Call SalMessageBox('Невідомий позабалансовий символ!', 'Увага', MB_Ok | MB_IconExclamation)
							Return VALIDATE_Cancel
					On SAM_KillFocus
						If wParam = SalWindowHandleToNumber(tblCard)
							Call SalSendMsg(tblCard, UM_Clear, 0, 0)
			Combo Box: cmbZB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_StrId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   3.35"
					Top:    1.4"
					Width:  5.85"
					Width Editable? Class Default
					Height: 2.119"
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
						If cmbZB.Init(hWndItem)
							Call cmbZB.Populate(hSql(), 'd010', "d010 || ' ' || txt", 'kl_d010', "where d010>='84' order by d010")
							Call SalListSetSelect(cmbZB, -1)
					On SAM_Click
						Call SalSendClassMessage(SAM_Click, 0, 0)
						Set dfZB = cmbZB.strCurrentId
					On SAM_KillFocus
						If wParam = SalWindowHandleToNumber(tblCard)
							Call SalSendMsg(tblCard, UM_Clear, 0, 0)
			!
			Child Table: tblCard
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Display Settings
					Window Location and Size
						Left:   0.2"
						Top:    1.75"
						Width:  9.0"
						Width Editable? Yes
						Height: 3.6"
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
					Maximum Rows in Memory: 2000
					Discardable? No
				Contents
					Column: colCardAcc
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Технічний
								рахунок
						Visible? Yes
						Editable? Yes
						Maximum Data Length: 10
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
							On SAM_Validate
								If not SalIsNull(colCardAcc)
									Call SqlPrepareAndExecute(hSql(), 
											"select s.acc, s.nls, s.nms, c.okpo
											   into :colAcc, :colNls, :colNms, :colOkpo
											   from obpc_acct a, accounts s, tabval v, customer c
											  where a.card_acct = :colCardAcc and a.lacct = s.nls and s.kv = :nKv
											    and s.kv = v.kv and v.lcv = a.currency
											    and s.rnk = c.rnk")
									If not SqlFetchNext(hSql(), nFetchRes)
										Call SalMessageBox("Не знайдено картковий рахунок для " || colCardAcc || " " || dfLcv,
												     "Увага!", MB_IconExclamation )
										Return VALIDATE_Cancel
								Else
									Set colNls = ''
									Set colNms = ''
								Return VALIDATE_Ok
					Column: colS
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сума
						Visible? Yes
						Editable? Yes
						Maximum Data Length: 16
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
							On SAM_Validate
								Call DecPoint(hWndItem)
								Call checkSum()
								Return VALIDATE_Ok
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
						Maximum Data Length: 14
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
							On SAM_Validate
								If not SalIsNull(colNls)
									Call SqlPrepareAndExecute(hSql(),
											"select a.acc, a.nms, a.tip, c.okpo
											   into :colAcc, :colNms, :colTip, :colOkpo
											   from accounts a, customer c
											  where a.nls = :colNls and a.kv = :nKv
											    and a.rnk = c.rnk")
									If not SqlFetchNext(hSql(), nFetchRes)
										Call SalMessageBox("Не знайдено рахунок " || colNls || "/ " || dfLcv,
												     "Увага!", MB_IconExclamation )
										Return VALIDATE_Cancel
									If SalStrLeftX(colTip, 2) = 'PK'
										Call SqlPrepareAndExecute(hSql(), "select card_acct into :colCardAcc from obpc_acct where lacct = :colNls and currency = :dfLcv")
										If not SqlFetchNext(hSql(), nFetchRes)
											Call SalMessageBox("Не знайдено технічний рахунок для " || colNls || "/" || dfLcv,
													     "Увага!", MB_IconExclamation )
											Return VALIDATE_Cancel
									Else If SalStrLeftX(colTip, 2) = 'W4'
										Set colCardAcc = 'WAY4'
									Else
										Call SalMessageBox("Вказано не картковий рахунок " || colNls || "/" || dfLcv,
												     "Увага!", MB_IconExclamation )
										Return VALIDATE_Cancel
								Else
									Set colCardAcc = ''
									Set colNms = ''
									Set colTip = ''
								Return VALIDATE_Ok
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
					Column: colTip
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Tip
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
					Column: colOkpo
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
				Functions
					Function: checkSum
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							Number: nRow
							Number: nCountAcc
							Number: nSum
						Actions
							Set nCountAcc = 0
							Set nSum = 0
							Set nRow = TBL_MinRow
							While SalTblFindNextRow(hWndForm, nRow, ROW_Edited, 0)
								Call SalTblSetContext(hWndForm, nRow)
								If SalIsNull(colCardAcc) and SalIsNull(colS)
								Else If not SalIsNull(colCardAcc) and not SalIsNull(colS) and colS > 0
									Set nSum = nSum + colS
									Set nCountAcc = nCountAcc + 1
									Call XSalTblSetCellBackColor(colCardAcc, COLOR_White)
									Call XSalTblSetCellBackColor(colS, COLOR_White)
								Else
									Call XSalTblSetCellBackColor(colCardAcc, SalColorFromRGB(250, 170, 170))
									Call XSalTblSetCellBackColor(colS, SalColorFromRGB(250, 170, 170))
							Set dfSum = nSum
							Set dfCountAcc = nCountAcc
							Return TRUE
					Function: payOper
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							Boolean: bError
							String: sError
							!
							: ccDoc
								Class: cDoc
							String: sTt
							Number: nDk
							String: sNlsT	! Транзитный счет
							String: sNlsK	! Карточный счет 2625
							String: sPlat	! Наим. плательщика (транзит)
							String: sPolu	! Наим. получателя (карт. счет)
							String: sOkpoA	! ОКПО плательщика (транзит)
							String: sOkpoB	! ОКПО получателя (карт. счет)
							String: sNazn	! Назначение платежа
							Number: nS	! Сумма
							!
							Date/Time: dValDate
							String: sBankMfo
							Number: nVob
							Number: nRef
							!
							Number: nRow
						Actions
							If SalIsNull(dfTt)
								Call SalMessageBox('Не задано операцію для оплати!', 'Увага!', MB_IconExclamation | MB_Ok)
								Call SalSetFocus(cmbTt)
								Return FALSE
							If SalIsNull(dfTransitNls)
								Call SalMessageBox('Не задано транзитний рахунок!', "Увага!", MB_IconExclamation | MB_Ok)
								Call SalSetFocus(dfTransitNls)
								Return FALSE
							If SalIsNull(dfNazn)
								Call SalMessageBox('Не задано призначення платежу!', "Увага!", MB_IconExclamation | MB_Ok)
								Call SalSetFocus(dfNazn)
								Return FALSE
							If SalIsNull(dfZB)
								Call SalMessageBox('Не задано Позабалансовий символ!', "Увага!", MB_IconExclamation | MB_Ok)
								Call SalSetFocus(dfZB)
								Return FALSE
							Call checkSum()
							If SalIsNull(dfCountAcc) or dfSum = 0
								Call SalMessageBox('Немає документів для оплати!', "Увага!", MB_IconExclamation | MB_Ok)
								Return FALSE
							If SalMessageBox("Оплатити " || Str(dfCountAcc) || " документів на " || Str(dfSum) || " " || dfLcv || "?", 
									   "Увага!", MB_IconQuestion | MB_YesNo) = IDNO
								Return FALSE
							Set bError = FALSE
							Set sError = ''
							! -- Инициализация переменных
							Set sTt   = dfTt
							Set nDk   = 1
							Set sNlsT = dfTransitNls
							Set sPlat = dfTransitNms
							Set sNazn = dfNazn
							! -- Дата валютирования
							Set dValDate = GetBankDate()
							! -- МФО
							Set sBankMfo = GetBankMfo()
							! -- Мем. ордер
							Set nVob = 6
							! -- ОКПО-А
							Call SqlPrepareAndExecute(hSql(), 
									"select c.okpo into :sOkpoA
									   from accounts a, customer c
									  where a.rnk = c.rnk and a.acc = :nTransitAcc")
							Call SqlFetchNext(hSql(), nFetchRes)
							!
							Set nRow = TBL_MinRow
							While SalTblFindNextRow(hWndForm, nRow, ROW_Edited, 0)
								Call SalTblSetContext(hWndForm, nRow)
								If not SalIsNull(colNls) and colS > 0
									! -- Счет
									Set sNlsK = colNls
									Set sPolu = colNms
									Set sOkpoB = colOkpo
									! -- Сумма
									Set nS = colS * SalNumberPower(10, nDig)
									! -- Оплата
									Call ccDoc.SetDoc(0, sTt, nDk, nVob, '',
											     dValDate, dValDate, dValDate, dValDate,
											     sNlsT, sPlat, sBankMfo, '', nKv, nS, sOkpoA,
											     sNlsK, sPolu, sBankMfo, '', nKv, nS, sOkpoB,
											     sNazn, '', GetIdOper(), '', NUMBER_Null, 0)
									If not ccDoc.oDoc()
										Set bError = TRUE
										Set sError = 'Неуспішна оплата документа.'
										Break
									! -- Вставка доп. реквизитов если есть
									Set nRef = ccDoc.m_nRef
									If SalStrLeftX(colTip, 2) = 'PK'
										If not SqlPrepareAndExecute(hSqlAux(), 
												"insert into operw (ref, tag, value) 
												 values (:nRef, 'CDAC', :colCardAcc)")
											Set bError = TRUE
											Set sError = 'Неуспішне виконання процедури додання дод. реквизиту CDAC'
											Break
									If not SqlPrepareAndExecute(hSql(), 
											"insert into operw (ref, tag, value) 
											 values (:nRef, 'SK_ZB', :dfZB)")
										Set bError = TRUE
										Set sError = 'Неуспішне виконання процедури додовання дод. реквизиту SK_ZB'
										Break
							!
							If not bError
								Call SqlCommitEx(hSql(), "OBPC. Оплачено " || Str(dfCountAcc) || " документів на " || Str(dfSum) || " " || dfLcv)
								Call SalMessageBox("Оплачено " || Str(dfCountAcc) || " документів на " || Str(dfSum) || " " || dfLcv, 
										     "Інформація", MB_IconAsterisk)
							Else
								Call SqlRollbackEx(hSql(), "OBPC. " || sError)
							!
							Return not bError
					Function: DecPoint      ! Корректировка символа "десятичной точки"
						Description:
						Returns
						Parameters
							Window Handle: hWnd
						Static Variables
						Local variables
							String: sTmp
						Actions
							Set sTmp = SalStrRepeatX(' ', 20)
							Call SalGetWindowText(hWnd, sTmp, 20)
							While SalStrScan(sTmp, sDecimal2) > 0
								Set sTmp = SalStrReplaceX(sTmp, SalStrScan(sTmp,sDecimal2), 1, sDecimal)
							Call SalFmtStrToField(hWnd, sTmp, TRUE)
							Return TRUE
					Function: PrintData
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							String: sFileName
							File Handle: hF
							Number: nRow
						Actions
							! Set sFileName = GetPrnDir() || '\\' || 'PK_' || 
									    SalStrRightX(SalStrRepeatX('0', 4) || Str(SalDateYear(SalDateCurrent())), 4)  || 
									    SalStrRightX(SalStrRepeatX('0', 2) || Str(SalDateMonth(SalDateCurrent())), 2) || 
									    SalStrRightX(SalStrRepeatX('0', 2) || Str(SalDateDay(SalDateCurrent())), 2) || 
									    SalStrRightX(SalStrRepeatX('0', 2) || Str(SalDateHour(SalDateCurrent())), 2) || 
									    SalStrRightX(SalStrRepeatX('0', 2) || Str(SalDateMinute(SalDateCurrent())), 2) || 
									    SalStrRightX(SalStrRepeatX('0', 2) || Str(SalDateSecond(SalDateCurrent())), 2)
							Set sFileName = GetPrnDir() || '\\' || 'PK_' || 
									    SalStrRightX(SalStrRepeatX('0', 2) || Str(SalDateMonth(SalDateCurrent())), 2) || 
									    SalStrRightX(SalStrRepeatX('0', 2) || Str(SalDateDay(SalDateCurrent())), 2) || 
									    SalStrRightX(SalStrRepeatX('0', 2) || Str(SalDateHour(SalDateCurrent())), 2) || 
									    SalStrRightX(SalStrRepeatX('0', 2) || Str(SalDateMinute(SalDateCurrent())), 2)
							If not SalFileOpen(hF, sFileName, OF_Write | OF_Text)
								Call SalMessageBox('Неможливо відкрити файл ' || sFileName, 'Ошибка!', MB_IconStop | MB_Ok)
								Return FALSE
							Call SalFilePutStr(hF, SalFmtFormatDateTime(SalDateCurrent(), 'dd.MM.yyyy hhhh:mm:ss'))
							Call SalFilePutStr(hF, '')
							Call SalFilePutStr(hF, 'Операція: ' || cmbTt)
							Call SalFilePutStr(hF, 'Транзитний рахунок:  ' || dfTransitNls || ' ' || dfLcv || ' ' || dfTransitNms)
							Call SalFilePutStr(hF, 'Призначення платежу: ' || dfNazn)
							Call SalFilePutStr(hF, '')
							Set nRow = TBL_MinRow
							While SalTblFindNextRow(hWndForm, nRow, 0, 0)
								Call SalTblSetContext(hWndForm, nRow)
								Call SalFilePutStr(hF, 
										     IifS(colNls='', '', PadR(colNls, 14) || ' ') || 
										     PadL(SalNumberToStrX(colS,2), 16) || ' ' || 
										     IifS(colNms='', '', PadR(colNms, 38) || ' '))
							Call SalFilePutStr(hF, '')
							Call SalFilePutStr(hF, 'Рахунків всього: ' || Str(dfCountAcc))
							Call SalFilePutStr(hF, 'Сума           : ' || SalNumberToStrX(dfSum,2))
							Call SalFileClose(hF)
							Call SalMessageBox('Інформацію збережео в файл ' || sFileName, 'Ошибка!', MB_IconAsterisk | MB_Ok)
							Return TRUE
				Window Variables
					Number: nRow
				Message Actions
					On SAM_Create
						If nMode = 1
							Call SalTblSetColumnPos(colNls, 1)
							Call SalTblSetColumnPos(colCardAcc, 3)
							Call SalEnableWindow(colNls)
							Call SalDisableWindow(colCardAcc)
						Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
						Call SalTblSetContext(hWndForm, nRow)
						Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
					On UM_Clear
						If not SalTblAnyRows(hWndForm, 0, 0)
							Call SalSendMsg(hWndForm, UM_Insert, 0, 0)
						Else
							If nMode = 0
								Call SalTblSetFocusCell(hWndForm, nRow, colCardAcc, 0, 1)
							Else
								Call SalTblSetFocusCell(hWndForm, nRow, colNls, 0, 1)
					On SAM_EndCellTab
						Call SalSendMsg(hWndForm, UM_Insert, 0, 0)
						Return TRUE
					On UM_Insert
						Set nRow = SalTblInsertRow(hWndForm, TBL_MaxRow)
						Call SalTblSetContext(hWndForm, nRow)
						Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
						If nMode = 0
							Call SalTblSetFocusCell(hWndForm, nRow, colCardAcc, 0, 1)
						Else
							Call SalTblSetFocusCell(hWndForm, nRow, colNls, 0, 1)
			!
			Background Text: Рахунків всього:
				Resource Id: 16720
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    5.45"
					Width:  2.1"
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
			Data Field: dfCountAcc
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
						Left:   2.4"
						Top:    5.4"
						Width:  1.6"
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
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Сума
				Resource Id: 16721
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    5.75"
					Width:  2.1"
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
			Data Field: dfSum
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
						Left:   2.4"
						Top:    5.7"
						Width:  1.6"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Decimal
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Frame
				Resource Id: 16722
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    6.15"
					Width:  9.2"
					Width Editable? Yes
					Height: 0.75"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Border Color: 3D Shadow Color
				Background Color: Default
			Pushbutton: pbCheck
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbDetail
				Property Template:
				Class DLL Name:
				Title: Перерахувати
				Window Location and Size
					Left:   2.4"
					Top:    6.3"
					Width:  1.6"
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name: \BARS98\RESOURCE\BMP\SUMM.BMP
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						Call tblCard.checkSum()
			Pushbutton: pbRefresh
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbRefresh
				Property Template:
				Class DLL Name:
				Title: Очистити
				Window Location and Size
					Left:   4.2"
					Top:    6.3"
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
						Set bPay = FALSE
						Call SalDisableWindow(pbPrint)
						Call SalTblReset(tblCard)
						Call SalEnableWindow(tblCard.colCardAcc)
						Call SalEnableWindow(tblCard.colNls)
						Call SalEnableWindow(tblCard.colS)
						Call SalSendMsg(tblCard, UM_Clear, 0, 0)
						Set dfCountAcc = 0
						Set dfSum = 0
			Pushbutton: pbPrint
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbPrint
				Property Template:
				Class DLL Name:
				Title: Друк
				Window Location and Size
					Left:   5.4"
					Top:    6.3"
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
						Call tblCard.PrintData()
			Pushbutton: pbPay
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbExecute
				Property Template:
				Class DLL Name:
				Title: Оплатити
				Window Location and Size
					Left:   6.6"
					Top:    6.3"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: F10
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
						If not bPay
							If tblCard.payOper()
								Set bPay = TRUE
								Call SalEnableWindow(pbPrint)
								Call SalDisableWindow(tblCard.colCardAcc)
								Call SalDisableWindow(tblCard.colNls)
								Call SalDisableWindow(tblCard.colS)
			Pushbutton: pbCancel
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title: Відмінити
				Window Location and Size
					Left:   7.8"
					Top:    6.3"
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
		Window Parameters
			String: sParTt	! PKR - зачисление на карт. счет
			Number: nMode	! Режим ввода: 0-по техн.счету, 1-по карт.счету
		Window Variables
			Number: nBaseVal
			Number: nKv
			Boolean: bPay
			Number: nDig
			String: sDecimal   ! симв десятичной точки
			String: sDecimal2  ! симв десятичной точки alt
			String: sPK
			String: sSem
			String: sTmp
			Number: nTransitAcc
		Message Actions
			On SAM_Create
				Call PrepareWindowEx(hWndForm)
				Call SalMapEnterToTab(TRUE)
				!
				Set nBaseVal = GetBaseVal()
				Set dfLcv    = Str(nBaseVal)
				Call SalSendMsg(dfLcv, SAM_Validate, 0, 0)
				Set bPay = FALSE
				!
				Set sDecimal = SalStrMidX(SalNumberToStrX(1.1,1),1,1)
				If sDecimal = '.'
					Set sDecimal2 = ','
				Else
					Set sDecimal2 = '.'
				!
				Set dfCountAcc = 0
				Set dfSum = 0
				Call SalDisableWindow(pbPrint)
			On SAM_CreateComplete
				If dfZB
					Call cmbZB.SetSelectById(dfZB)
			On SAM_Destroy
				Call SalMapEnterToTab(FALSE)
	Table Window: tblObpcPkkque
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Ручне коректування документів для ПЦ
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
				Width:  16.0"
				Width Editable? Class Default
				Height: 8.4"
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
		Description: Ручне коректування документів для ПЦ
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
					Resource Id: 22624
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  5.167"
						Begin Y:  -0.024"
						End X:  5.167"
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
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.917"
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
					Resource Id: 33367
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  3.433"
						Begin Y:  0.012"
						End X:  3.433"
						End Y:  0.476"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Pushbutton: pbDoc
					Class Child Ref Key: 39
					Class ChildKey: 0
					Class: cGenericTable
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
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Перегляд документу'
				Pushbutton: pbAccCard
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.967"
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
							If colDocType = 1
								If SqlPrepareAndExecute(hSql(), 
										"select acc, rnk into :nAcc, :nRnk
										   from accounts
										  where nls = :hWndForm.tblObpcPkkque.colNls 
										    and kv  = :hWndForm.tblObpcPkkque.colKv")
										and SqlFetchNext(hSql(), nFetchRes)
									Call OperWithAccountEx(AVIEW_ALL, nAcc, nRnk, ACCESS_FULL, hWndForm, '')
				Line
					Resource Id: 22625
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  4.5"
						Begin Y:  -0.024"
						End X:  4.5"
						End Y:  0.44"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbUnForm
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbSynchro
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.633"
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
					Picture Transparent Color: Gray
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = "Зняти відмітку про відправку"
						On SAM_Click
							Call UnForm()
				Line
					Resource Id: 22626
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
				Pushbutton: pbExit
					Class Child Ref Key: 42
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   5.317"
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
		Contents
			Column: colStatus
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Стан
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
			Column: colCardAcct
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Технічний
						рахунок
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 10
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
					On SAM_SetFocus
						Set sTmp = colCardAcct
					On SAM_AnyEdit
						If colFileName or colDocType = 2
							Set colCardAcct = sTmp
							Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
			Column: colFileName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ім'я
						файлу
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
			Column: colFileDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						файлу
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
			Column: colTt
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						оп.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
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
			Column: colVdat
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						валютування.
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
			Column: colNls
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Картковий
						рахунок
				Visible? Yes
				Editable? Yes
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
				Title: Сума
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  Default
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
			Column: colLcv
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Вал
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
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
			Column: colNms
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Назва
						карткового рахунку
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
			Column: colNlsb
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Рахунок-Б
				Visible? Yes
				Editable? Yes
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
					On SAM_SetFocus
						Set sTmp = colNlsb
					On SAM_AnyEdit
						Set colNlsb = sTmp
						Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
			Column: colNmsb
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Назва
						рахунку-Б
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
				Title: Призначення
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
			Column: colUserid
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						корист.
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
			Column: colDatd
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						документу
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
			Column: colSos
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: SOS
				Visible? No
				Editable? Yes
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
			Column: colDocType
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: DocType
				Visible? No
				Editable? Yes
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
			Function: UnForm
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Number: nRow
					Boolean: bError
				Actions
					If SalMessageBox("Зняти відмітку про відправку по вибраним документам?" || PutCrLf() ||
							   "Документи відправляться в ПЦ повторно!", "Увага!", MB_IconQuestion | MB_YesNo) = IDYES
						Set bError = FALSE
						Set nRow = TBL_MinRow
						While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
							Call SalTblSetContext(hWndForm, nRow)
							If not SqlPLSQLCommand(hSql(), "obpc.set_unform_flag(hWndForm.tblObpcPkkque.colDocType, hWndForm.tblObpcPkkque.colRef, hWndForm.tblObpcPkkque.colDk)")
								Set bError = TRUE
								Break
							Else
								Call SaveInfoToLog("OBPC. Снята отметка об отправке док." || Str(colRef))
						If bError
							Call SqlRollbackEx(hSql(), "OBPC. Ошибка при попытке снять отметку об отправке док.")
						Else
							Call SqlCommitEx(hSql(), "OBPC. Успешно снята отметка об отправке док.")
						Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
					Return TRUE
		Window Parameters
			String: sPar
		Window Variables
			Number: nCount
			Number: nAcc
			Number: nRnk
			String: sTmp
			Number: nRow
		Message Actions
			On SAM_Create
				Call PrepareWindowEx(hWndForm)
				Set hWndForm.tblObpcPkkque.nFlags = GT_NoIns | GT_NoDel
				Set hWndForm.tblObpcPkkque.fFilterAtStart = TRUE
				Set hWndForm.tblObpcPkkque.strPrintFileName = "pkk_status"
				Set hWndForm.tblObpcPkkque.strFilterTblName = "v_obpc_pkkque"
				Set hWndForm.tblObpcPkkque.strSqlPopulate = 
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
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On UM_Populate
				Set nCount = 0
				Call SalSendClassMessage(UM_Populate, 0, 0)
				Call SalTblDefineSplitWindow(hWndForm, 1, TRUE)
				Set nRow = SalTblInsertRow(hWndForm, TBL_MinRow)
				Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
				Call SalTblSetContext(hWndForm, nRow)
				Set colFileName  = 'Док. всього:'
				Set colRef  = nCount
			On SAM_FetchRowDone
				Set nCount = nCount + 1
				If colDocType = 2
					Call XSalTblSetRowBackColor(hWndForm, lParam, SalColorFromRGB(230,255,255)) ! голубой
				Else If colSos > 0 and colSos < 5
					Call VisTblSetRowColor(hWndForm, lParam, COLOR_DarkGreen)
			On UM_Update
				Set nRow = TBL_MinRow
				While SalTblFindNextRow(hWndForm, nRow, ROW_Edited, 0)
					Call SalTblSetContext(hWndForm, nRow)
					If colDocType = 1
						If SqlPLSQLCommand(hSql(), "obpc.set_doc_cardacct(colRef, colDk, colCardAcct)")
							Call SqlCommitEx(hSql(), "OBPC. Установлен тех.счет для Реф.№" || Str(colRef))
						Else
							Call SqlRollbackEx(hSql(), "OBPC. Ошибка установки тех.счета для Реф.№" || Str(colRef))
				Call SalSendClassMessage(UM_Populate, 0, 0)
			On SAM_DoubleClick
				If colDocType
					! 1-DOC_EXTERNAL, 2-DOC_INTERNAL, 0-DB_SRC_ACTIVE
					If colDocType = 1
						Call DocView(hWndMDI, hWndForm.tblObpcPkkque.colRef, 2, 0, '')
					Else
						Call DocView(hWndMDI, hWndForm.tblObpcPkkque.colRef, 1, 0, '')
			On SAM_RowHeaderClick
				If colRef
					If colStatus = 'О'
						Set sTmp = 'Відправлений'
					Else If colStatus = 'Н'
						Set sTmp = 'Невідправлений'
					If colDocType = 2
						Set sTmp = sTmp || IifS(sTmp="", "", ", ") || "Інформаційний"
					Else If colSos > 0 and colSos < 5
						Set sTmp = sTmp || IifS(sTmp="", "", ", ") || "Незавізований"
					Call XSalTooltipSetColors(COLOR_Black, COLOR_LightGray)
					Call XSalTooltipShow(hWndForm, sTmp)
					Call XSalTooltipSetColors(COLOR_Black, COLOR_White)
	Dialog Box: dlgStatus
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
				Left:   4.638"
				Top:    3.771"
				Width:  7.0"
				Width Editable? Yes
				Height: 3.3"
				Height Editable? Yes
			Absolute Screen Location? No
			Font Name: Default
			Font Size: Default
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description: Форма показа статуса
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
			Multiline Field: mlMessage
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 100000
					String Type: String
					Editable? No
				Display Settings
					Border? Yes
					Word Wrap? Yes
					Vertical Scroll? Yes
					Window Location and Size
						Left:   0.0"
						Top:    0.0"
						Width:  6.95"
						Width Editable? Yes
						Height: 3.0"
						Height Editable? Yes
					Visible? Yes
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
				Message Actions
					On SAM_ContextMenu
						Set sStatusText = mlMessage
						Call SalTrackPopupMenu(hWndForm, "pmStatusPrint", TPM_CursorX | TPM_CursorY , 0, 0)
		Functions
		Window Parameters
			String: sMessage
			String: sTitle
		Window Variables
		Message Actions
			On SAM_Create
				Call PrepareWindowEx(hWndForm)
				Call SalSetWindowText(hWndForm, sTitle)
				Set mlMessage = sMessage
	Form Window: frmCard
		Class: cQuickTabsForm
		Property Template:
		Class DLL Name:
		Title: Нова угода
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
				Width:  9.35"
				Width Editable? Class Default
				Height: 6.6"
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
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\COPY.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Копія картки'
						On SAM_Click
							Call SalSetWindowText(hWndForm, "Нова угода (копія, " || IifS(nCType=1, "фізична особа", "юридична особа") || ")")
							Call SetButton(2)
							Call picTabs.BringToTop(0, TRUE)
				Line
					Resource Id: 60123
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
					Resource Id: 60124
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
					Resource Id: 60125
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
				Tile To Parent? Class Default
				Border Color: Default
				Background Color: 3D Face Color
				Message Actions
					On SAM_Create
						Call SalSendClassMessage(SAM_Create, wParam, lParam)
						! Инициализация закладок
						Call picTabs.InitializeFormPages(
								     SalNumberToStrX(0,0) || ';' ||
								     Str(SalWindowHandleToNumber(hWndForm)))
						Call picTabs.BringToTop(2, TRUE)
						Call picTabs.BringToTop(1, TRUE)
						Call picTabs.BringToTop(0, TRUE)
						Set fActivate = TRUE
					On TABSM_TabActivateStart
						If fActivate
							Call GetName(wParam, sTabName)
							If sTabName = 'CardClient'
								If not bCardOpen
									Call SalSetFocus(hWndTabClient.dlgCardClient.dfOkpo)
							If sTabName = 'CardCard'
								If not nCType or bCardOpen
									Call SalSendMsg(hWndTabCard, SAM_DoInit, 0, 0)
								Else If (nCType and not bCardOpen) or bCardCopy
									Call SalSendMsg(hWndTabCard, SAM_DoInit, 2, 0)
							If sTabName = 'CardDemand'
								If not bCardOpen
									! если сменился клиент, нужно перечитать имена
									If nClientRnk != nDemandRnk
										Set hWndTabDemand.dlgCardDemand.dfDmName  = sNmkV
										Set hWndTabDemand.dlgCardDemand.dfDmMName = sMName
										Set hWndTabDemand.dlgCardDemand.dfWork    = sWork
										Set hWndTabDemand.dlgCardDemand.dfOffice  = sOffice
										Set hWndTabDemand.dlgCardDemand.dfWCntry  = 'Україна' 
										Set nDemandRnk = nClientRnk
									Else
										If hWndTabDemand.dlgCardDemand.dfDmName  = ''
											Set hWndTabDemand.dlgCardDemand.dfDmName = sNmkV
										If hWndTabDemand.dlgCardDemand.dfDmMName = ''
											Set hWndTabDemand.dlgCardDemand.dfDmMName = sMName
										If hWndTabDemand.dlgCardDemand.dfWork = ''
											Set hWndTabDemand.dlgCardDemand.dfWork = sWork
										If hWndTabDemand.dlgCardDemand.dfOffice = ''
											Set hWndTabDemand.dlgCardDemand.dfOffice = sOffice
										If hWndTabDemand.dlgCardDemand.dfWCntry = ''
											Set hWndTabDemand.dlgCardDemand.dfWCntry = 'Україна'
										If hWndTabDemand.dlgCardDemand.dfFCode = ''
											Call hWndTabDemand.dlgCardDemand.GetFilial(sPCBranch)
									Call SalSetFocus(hWndTabDemand.dlgCardDemand.dfDmName)
		Functions
			Function: check
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
				Actions
					If SalIsNull(hWndTabClient.dlgCardClient.dfRnk)
						Call SalMessageBox("Не вказано клієнта!", "Увага!", MB_IconExclamation | MB_Ok)
						Call SetFocus(0, hWndTabClient.dlgCardClient.dfRnk)
						Return FALSE
					If SalIsNull(hWndTabCard.dlgCardCard.dfPCode)
						Call SalMessageBox("Не вибрано продукт БПК!", "Увага!", MB_IconExclamation | MB_Ok)
						Call SetFocus(1, hWndTabCard.dlgCardCard.pbProduct)
						Return FALSE
					If hWndTabDemand.dlgCardDemand.dfDmName = ''
						Set hWndTabDemand.dlgCardDemand.dfDmName = sNmkV
					If SalIsNull(hWndTabDemand.dlgCardDemand.dfDmName)
						Call SalMessageBox("Не заповнено ім'я та прізвище на картці!", "Увага!", MB_IconExclamation | MB_Ok)
						Call SetFocus(2, hWndTabDemand.dlgCardDemand.dfDmName)
						Return FALSE
					If hWndTabDemand.dlgCardDemand.dfDmMName = ''
						Set hWndTabDemand.dlgCardDemand.dfDmMName = sMName
					If SalIsNull(hWndTabDemand.dlgCardDemand.dfDmMName)
						Call SalMessageBox("Не заповнено дівоче прізвище матері!", "Увага!", MB_IconExclamation | MB_Ok)
						Call SetFocus(2, hWndTabDemand.dlgCardDemand.dfDmMName)
						Return FALSE
					If SalIsNull(hWndTabDemand.dlgCardDemand.dfWork)
						Call SalMessageBox("Не заповнено місце роботи!", "Увага!", MB_IconExclamation | MB_Ok)
						Call SetFocus(2, hWndTabDemand.dlgCardDemand.dfWork)
						Return FALSE
					If SalIsNull(hWndTabDemand.dlgCardDemand.dfOffice)
						Call SalMessageBox("Не заповнено посаду!", "Увага!", MB_IconExclamation | MB_Ok)
						Call SetFocus(2, hWndTabDemand.dlgCardDemand.dfOffice)
						Return FALSE
					If SalIsNull(hWndTabDemand.dlgCardDemand.dfFCode)
						Call SalMessageBox("Не вибрано філію!", "Увага!", MB_IconExclamation | MB_Ok)
						Call SetFocus(2, hWndTabDemand.dlgCardDemand.dfFCode)
						Return FALSE
					Set nRnk = hWndTabClient.dlgCardClient.dfRnk
					Set sFio = hWndTabClient.dlgCardClient.dfFio
					Set sNbs = hWndTabCard.dlgCardCard.sNbs
					Set nProductId = hWndTabCard.dlgCardCard.dfPCode
					Set nLimit   = hWndTabCard.dlgCardCard.dfLimit
					Set nKL      = hWndTabCard.dlgCardCard.cbKL
					Set sDmName  = hWndTabDemand.dlgCardDemand.dfDmName
					Set sDmMName = hWndTabDemand.dlgCardDemand.dfDmMName
					Set sWork    = hWndTabDemand.dlgCardDemand.dfWork
					Set sOffice  = hWndTabDemand.dlgCardDemand.dfOffice
					Set sWPhone  = hWndTabDemand.dlgCardDemand.dfWPhone
					Set sWCntry  = hWndTabDemand.dlgCardDemand.dfWCntry
					Set sWPcode  = hWndTabDemand.dlgCardDemand.dfWPcode
					Set sWCity   = hWndTabDemand.dlgCardDemand.dfWCity
					Set sWStreet = hWndTabDemand.dlgCardDemand.dfWStreet
					Set sFilial  = hWndTabDemand.dlgCardDemand.dfFCode
					Set sBranch  = hWndTabDemand.dlgCardDemand.dfBranch
					Set sCardName = hWndTabCard.dlgCardCard.cmbAccType
					Set sCardLcv  = IifS(hWndTabCard.dlgCardCard.rbUAH=TRUE, 'UAH', 'USD')
					Return TRUE
			Function: OpenCard
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Boolean: bRet
				Actions
					If not check()
						Return FALSE
					If SalMessageBox("Відкрити картку " || sCardName || "-" || sCardLcv || " (" ||
							   sNbs || ") для " || 
							   IifS(nCType=1, "фіз.особи", "юр.особи") || PutCrLf() || sFio || " ?",
							   "Увага!", MB_IconQuestion | MB_YesNo) = IDNO
						Return FALSE
					Set bRet = TRUE
					Call SalWaitCursor(TRUE)
					If not SqlPLSQLCommand(hSql(), "bars_bpk.open_card(nRnk, nProductId, sFilial, nLimit*100, nKL, sBranch,
							   sDmName, sDmMName, sWork, sOffice, sWPhone, sWCntry, sWPcode, sWCity, sWStreet, nNd)") 
						Call SqlRollbackEx(hSql(), "OBPC. Неуспешное заведение сделки.")
						Set bRet = FALSE
					Else
						Call SqlCommitEx(hSql(), "OBPC. Зарегистрирован новый договор №" || Str(nNd))
						Call SalMessageBox("Зареєстровано нову угоду №" || Str(nNd), "Інформація", MB_IconAsterisk | MB_Ok)
						Set bParentRefresh = TRUE
					Call SalWaitCursor(FALSE)
					Return bRet
			Function: SetFocus
				Description:
				Returns
					Boolean:
				Parameters
					Number: nTab
					Window Handle: hWnd
				Static Variables
				Local variables
				Actions
					Call picTabs.BringToTop(nTab, TRUE)
					Call SalSetFocus(hWnd)
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
					Set bCardCopy = FALSE
					If nPar = 0
						Set bCardOpen = TRUE
						Call SalEnableWindow(pbNew)
						Call SalEnableWindow(pbCopy)
						Call SalEnableWindow(pbShowAcc)
						Call SalEnableWindow(pbPrint)
						Call SalDisableWindow(pbOpen)
					Else
						If nPar = 2
							Set bCardCopy = TRUE
						Set nNd     = NUMBER_Null
						Set nCType  = NUMBER_Null
						Set sNmkV   = STRING_Null
						Set sMName  = STRING_Null
						Set sWork   = STRING_Null
						Set sOffice = STRING_Null
						Call SalDisableWindow(pbNew)
						Call SalDisableWindow(pbCopy)
						Call SalDisableWindow(pbShowAcc)
						Call SalDisableWindow(pbPrint)
						Call SalEnableWindow(pbOpen)
					Call SalSendMsg(hWndTabClient, SAM_DoInit, nPar, 0)
					Call SalSendMsg(hWndTabCard,   SAM_DoInit, nPar, 0)
					Call SalSendMsg(hWndTabDemand, SAM_DoInit, nPar, 0)
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
		Window Parameters
			Window Handle: hWndParent
		Window Variables
			Boolean: bParentRefresh
			Boolean: fActivate
			Boolean: bCardOpen
			Boolean: bCardCopy
			Window Handle: hWndTabClient
			Window Handle: hWndTabCard
			Window Handle: hWndTabDemand
			String: sOurBranch
			String: sBranch
			String: sPCBranch
			Number: nCType
			Number: nCount
			Number: hBtns[*]
			Number: hBtnCustType3
			Number: hBtnCustType2
			Number: hBtnCancel
			String: sTabName
			!
			Number: nNd
			Number: nRnk
			String: sFio
			String: sNbs
			Number: nProductId
			Number: nLimit
			Number: nKL
			String: sFilial
			! String: sBranch
			String: sDmName
			String: sDmMName
			String: sDmTel
			String: sWork
			String: sOffice
			String: sWPhone
			String: sWCntry
			String: sWPcode
			String: sWCity
			String: sWStreet
			!
			String: sNmkV
			String: sMName
			String: sCardName
			String: sCardLcv
			Number: nClientRnk	!Rnk из закладки "Клиент", нужно для закладки "Demand", чтоб перечитывать имена
			Number: nDemandRnk	!Rnk из закладки "Demand"
		Message Actions
			On SAM_Create
				Call PrepareWindow(hWndForm)
				Set bParentRefresh = FALSE
				Set fActivate = FALSE
				Set bCardOpen = FALSE
				Set bCardCopy = FALSE
				Set nCType    = NUMBER_Null
				!
				Set sOurBranch = GetValueStr("select substr(sys_context('bars_context','user_branch'), 1, 30) from dual")
				! Для ГРЦ sBranch = 0
				Set sBranch = IifS(sOurBranch='', '0', sOurBranch)
				!
				Call SqlPrepareAndExecute(hSql(), 
						"select code into :sPCBranch
						   from v_bpk_branch_filiales
						  where branch = :sBranch")
				Call SqlFetchNext(hSql(), nFetchRes)
				!
				Call SalDisableWindow(pbNew)
				Call SalDisableWindow(pbCopy)
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
				Height: 5.6"
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
				Resource Id: 38343
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
				Picture Transparent Color: None
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
						If FunNSIGetFiltered('customer', 'rnk', "customer.custtype in (2,3)" || IifS(wParam=1, " and okpo='" || dfOkpo || "'", "") || sCustTypeToSearch, sPK, sSem)
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
				Picture Transparent Color: None
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
				Picture Transparent Color: None
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
				Picture Transparent Color: None
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
				Resource Id: 38328
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
				Resource Id: 38329
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
							Call SqlPrepareAndExecute(hSql(), "select count(*) into :nCount from customer where okpo=:dfOkpo and custtype in (2,3)" || sCustTypeToSearch)
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
				Resource Id: 38330
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
			Background Text: Тип клієнта
				Resource Id: 29900
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
						Top:    1.15"
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
				Resource Id: 27346
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    1.45"
					Width:  8.6"
					Width Editable? Yes
					Height: 3.8"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Background Text: Індекс
				Resource Id: 38331
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
						Top:    1.65"
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
				Resource Id: 38332
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
						Top:    1.95"
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
				Resource Id: 38333
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
			Background Text: Місто
				Resource Id: 38334
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
			Background Text: Вулиця, дім, кв.
				Resource Id: 38335
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
			!
			Group Box: Паспортні дані
				Resource Id: 27347
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    3.15"
					Width:  8.6"
					Width Editable? Yes
					Height: 2.1"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Background Text: Вид документу
				Resource Id: 38336
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    3.4"
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
						Top:    3.35"
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
				Resource Id: 38337
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
						Top:    3.65"
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
						Top:    3.65"
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
				Resource Id: 38339
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
						Top:    3.95"
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
			Background Text: Дата, місце народж.
				Resource Id: 38341
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
					Set hWndParent.frmCard.nCType = nCType
					! Основные параметры кдиента
					! nCType = 1-ФО, 2-ЮО
					If not SqlPrepareAndExecute(hSql(), 
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
						Return FALSE
					If not SqlFetchNext(hSql(), nFetchRes)
						Return FALSE
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
					! Дівоче прізвище матері
					Call SqlPrepareAndExecute(hSql(),
							"select substr(value,1,20) into :sMName
							   from customerw
							  where rnk = :dfRnk and tag = 'PC_MF'")
					If not SqlFetchNext(hSql(), nFetchRes)
						Set sMName = STRING_Null
					! Місце роботи, посада
					Call SqlPrepareAndExecute(hSql(),
							"select trim(substr(substr(value,1,instr(value,',')-1),1,30)),
							        trim(substr(substr(value,instr(value,',')+1,100),1,25))
							   into :sWork, :sOffice
							   from customerw
							  where rnk = :dfRnk and trim(tag) = 'WORK'")
					If not SqlFetchNext(hSql(), nFetchRes)
						Set sWork   = STRING_Null
						Set sOffice = STRING_Null
					!
					Set hWndParent.frmCard.nCType  = nCType
					Set hWndParent.frmCard.sNmkV   = sNmkV
					Set hWndParent.frmCard.sMName  = sMName
					Set hWndParent.frmCard.sWork   = sWork
					Set hWndParent.frmCard.sOffice = sOffice
					Set hWndParent.frmCard.nClientRnk = dfRnk
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
					Set sNmkV  = STRING_Null
					Set sMName = STRING_Null
					Set hWndParent.frmCard.nCType = nCType
					Set hWndParent.frmCard.sNmkV  = sNmkV
					Set hWndParent.frmCard.sMName = sMName
					Set dfFio = STRING_Null
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
			!
			String: sNmkV
			String: sMName
			String: sWork
			String: sOffice
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
				!
				Set hWndParent.frmCard.hWndTabClient = hWndForm
			On UM_Populate
				Call SearchCustomer(dfRnk, '')
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
					If wParam = 2
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
				Height: 5.6"
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
				Resource Id: 57352
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
			Background Text: Карткова система
				Resource Id: 57370
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
			Combo Box: cmbAccType
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
					On UM_ObjActivate
						Set sAccType = '-'
						If cmbAccType.Init(hWndItem)
							Call cmbAccType.Populate(hSql(), "type", "name", "demand_acc_type", "order by card_type, acc_type")
							Call cmbAccType.Add('-', '')
							Call cmbAccType.SetSelectById(sAccType)
							Call SalSendMsg(cmbAccType, SAM_Click, 0, 0)
					On SAM_Click
						Call SalSendClassMessage(SAM_Click, 0, 0)
						Set sAccType = cmbAccType.strCurrentId
						Call ClearField(0)
			!
			Background Text: Валюта
				Resource Id: 57355
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
			Radio Button: rbUAH
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cRadioButtonLabeled
				Property Template:
				Class DLL Name:
				Title: UAH
				Window Location and Size
					Left:   2.5"
					Top:    0.55"
					Width:  1.4"
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
						Call ClearField(0)
			Radio Button: rbUSD
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cRadioButtonLabeled
				Property Template:
				Class DLL Name:
				Title: USD
				Window Location and Size
					Left:   4.0"
					Top:    0.55"
					Width:  1.4"
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
						Call ClearField(0)
			!
			Background Text: Категорія клієнта
				Resource Id: 57358
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
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
			Data Field: dfKCode
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 1
					Data Type: String
					Editable? No
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
					Justify: Center
					Format: Uppercase
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Combo Box: cmbKK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_StrId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   3.55"
					Top:    0.85"
					Width:  4.4"
					Width Editable? Class Default
					Height: 3.202"
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
					On UM_ObjActivate
						Set dfKCode = '-'
						If cmbKK.Init(hWndItem)
							Call cmbKK.Populate(hSql(), "kk", "name", "demand_kk", "order by kk")
							Call cmbKK.Add('-', '')
							Call cmbKK.SetSelectById(sAccType)
							Call SalSendMsg(cmbKK, SAM_Click, 0, 0)
					On SAM_Click
						Call SalSendClassMessage(SAM_Click, 0, 0)
						Set dfKCode = cmbKK.strCurrentId
						Call ClearField(0)
			!
			Background Text: Продукт
				Resource Id: 57354
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
			Data Field: dfPCode
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
						Top:    1.15"
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
			Data Field: dfPName
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
						Left:   3.55"
						Top:    1.15"
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
			Picture: pbProduct
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   8.083"
					Top:    1.107"
					Width:  0.4"
					Width Editable? Yes
					Height: 0.3"
					Height Editable? Yes
				Visible? Yes
				Editable? No
				File Name: \BARS98\RESOURCE\BMP\FILTER.BMP
				Storage: Internal
				Picture Transparent Color: None
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
						Return XSalTooltipSetText(lParam, 'Продукт')
					On SAM_Click
						If FunNSIGetFiltered("v_bpk_product", "name", 
								"v_bpk_product.kv=" || IifS(rbUAH=TRUE, "980", "840") || 
								" and custtype = "  || Str(hWndParent.frmCard.nCType) || 
								IifS(sAccType='-', "", " and v_bpk_product.type='" || sAccType || "'") ||
								IifS(dfKCode ='-', "", " and v_bpk_product.kk='"   || dfKCode  || "'"), sPK, sSem)
							Set dfPCode = Val(sPK)
							Set dfPName = sSem
							Call GetProduct()
			Background Text: ОБ22
				Resource Id: 57356
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
						Left:   2.5"
						Top:    1.45"
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
			Data Field: dfOb22Name
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
						Left:   3.55"
						Top:    1.45"
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
			!
			Background Text: Код умови рахунку
				Resource Id: 57363
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    1.8"
					Width:  4.3"
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
			Data Field: dfCCode
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 4
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   4.55"
						Top:    1.75"
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
			Data Field: dfCName
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
						Left:   5.6"
						Top:    1.75"
						Width:  2.35"
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
			Background Text: Тривалість строку дії картки (в місяцях)
				Resource Id: 57364
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    2.1"
					Width:  4.3"
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
			Data Field: dfCValid
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
						Left:   4.55"
						Top:    2.05"
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
			Background Text: Вартість користування кредитом
				Resource Id: 57365
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    2.4"
					Width:  4.3"
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
			Data Field: dfDebIntr
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
						Left:   4.55"
						Top:    2.35"
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
			Background Text: Стягнення за овердрафт
				Resource Id: 57366
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    2.7"
					Width:  4.3"
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
			Data Field: dfOlimIntr
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
						Left:   4.55"
						Top:    2.65"
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
			Background Text: Відсоток на залишок по рахунку
				Resource Id: 57367
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    3.0"
					Width:  4.3"
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
			Data Field: dfCredIntr
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
						Left:   4.55"
						Top:    2.95"
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
			!
			Group Box: Умови кредитування
				Resource Id: 57368
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    3.25"
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
			Background Text: Ліміт
				Resource Id: 57369
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    3.5"
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
			Data Field: dfLimit
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 16
					Data Type: Number
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    3.45"
						Width:  2.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Decimal
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Check Box: cbKL	! Кредитная линия
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cCheckBoxLabeled
				Property Template:
				Class DLL Name:
				Title: Кредитна лінія
				Window Location and Size
					Left:   2.5"
					Top:    3.75"
					Width:  3.4"
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
					Set dfPCode = NUMBER_Null
					Set dfPName = STRING_Null
					Set dfOb22  = STRING_Null
					Set dfOb22Name = STRING_Null
					Set dfCCode = NUMBER_Null
					Set dfCName = STRING_Null
					Set dfCValid   = NUMBER_Null
					Set dfDebIntr  = NUMBER_Null
					Set dfOlimIntr = NUMBER_Null
					Set dfCredIntr = NUMBER_Null
					Set dfLimit = NUMBER_Null
					Set cbKL    = FALSE
					Call SalDisableWindow(dfLimit)
					Call SalDisableWindow(cbKL)
					If nPar = 1
						! Set dfBranch = IifS(hWndParent.frmCard.sOurBranch='', '0', hWndParent.frmCard.sOurBranch)
						Call SalSendMsg(cmbAccType, UM_ObjActivate, 0, 0)
						Call SalSendMsg(cmbKK, UM_ObjActivate, 0, 0)
						! Call SalSendMsg(cmbBranch, UM_ObjActivate, 0, 0)
					Return TRUE
			Function: GetProduct
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
				Actions
					Set hWndParent.frmCard.nProductId = NUMBER_Null
					If not dfPCode
						Return FALSE
					If not SqlPrepareAndExecute(hSql(),
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
						Return FALSE
					If not SqlFetchNext(hSql(), nFetchRes)
						Return FALSE
					Call cmbAccType.SetSelectById(sAccType)
					Call cmbKK.SetSelectById(dfKCode)
					If nKv = 980
						Set rbUAH = TRUE
					Else
						Set rbUSD = TRUE
					If nLimit
						Call SalEnableWindow(dfLimit)
						Call SalEnableWindow(cbKL)
					Else
						Set dfLimit = NUMBER_Null
						Set cbKL    = FALSE
						Call SalDisableWindow(dfLimit)
						Call SalDisableWindow(cbKL)
					Set hWndParent.frmCard.nProductId = dfPCode
					Return TRUE
		Window Parameters
		Window Variables
			String: strPassPar
			String: InParam[4]
			Window Handle: hWndParent
			!
			Number: nKv
			String: sNbs
			Number: nLimit
			String: sIdDoc
			String: sIdDocCred
			!
			String: sPK
			String: sSem
			!
			String: sAccType
		Message Actions
			On PAGEM_Initialize
				! Инициализация
				Set strPassPar = SalNumberToHString(lParam)
				If SalStrTokenize(strPassPar, '', ';', InParam) < 2
					Return FALSE
				Set hWndParent = SalNumberToWindowHandle(SalStrToNumber(InParam[1]))
				!
				Set rbUAH = TRUE
				! Set dfBranch = hWndParent.frmCard.sBranch
				!
				Call ClearField(1)
				!
				Set hWndParent.frmCard.hWndTabCard = hWndForm
			On SAM_DoInit
				! 0 - закрыть поля (после "Открыть карточку")
				! 1 - очистить и открыть поля (после "Новая")
				! 2 - открыть поля (после "Копировать")
				If wParam = 0
					Call SalDisableWindow(cmbAccType)
					Call SalDisableWindow(rbUAH)
					Call SalDisableWindow(rbUSD)
					Call SalDisableWindow(cmbKK)
					Call SalDisableWindow(pbProduct)
					Call SalDisableWindow(dfLimit)
					Call SalDisableWindow(cbKL)
					! Call SalDisableWindow(cmbBranch)
					! Set dfBranch = hWndParent.frmCard.sBranch
					! Call cmbBranch.SetSelectById(dfBranch)
				Else
					Call SalEnableWindow(cmbAccType)
					Call SalEnableWindow(rbUAH)
					Call SalEnableWindow(rbUSD)
					Call SalEnableWindow(cmbKK)
					Call SalEnableWindow(pbProduct)
					! Call SalEnableWindow(cmbBranch)
					Call GetProduct()
					If wParam = 1
						Call ClearField(1)
	Dialog Box: dlgCardDemand
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
				Height: 5.6"
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
			Group Box: Demand
				Resource Id: 1610
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
			Background Text: Ім'я та прізвище на картці
				Resource Id: 1611
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
			Data Field: dfDmName
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
			Background Text: Дівоче прізвище матері
				Resource Id: 1612
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
			Data Field: dfDmMName
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
			Group Box: Місце роботи
				Resource Id: 1613
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    0.8"
					Width:  8.6"
					Width Editable? Yes
					Height: 4.45"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Background Text: Місце роботи
				Resource Id: 1614
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    1.05"
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
			Data Field: dfWork
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 30
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   3.3"
						Top:    1.0"
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
				Resource Id: 1615
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    1.35"
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
			Data Field: dfOffice
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 25
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   3.3"
						Top:    1.3"
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
			Background Text: Телефон
				Resource Id: 1616
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    1.65"
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
			Data Field: dfWPhone
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 11
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   3.3"
						Top:    1.6"
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
			Background Text: Держава
				Resource Id: 1617
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    1.95"
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
			Data Field: dfWCntry
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 15
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   3.3"
						Top:    1.9"
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
			Background Text: Почтовий індекс
				Resource Id: 1618
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    2.25"
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
			Data Field: dfWPcode
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 6
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   3.3"
						Top:    2.2"
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
			Background Text: Місто
				Resource Id: 1619
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    2.55"
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
			Data Field: dfWCity
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 15
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   3.3"
						Top:    2.5"
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
			Background Text: Вулица
				Resource Id: 1620
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    2.85"
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
			Data Field: dfWStreet
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 30
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   3.3"
						Top:    2.8"
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
			Group Box: Філія
				Resource Id: 1621
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    3.1"
					Width:  8.6"
					Width Editable? Yes
					Height: 2.15"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Background Text: Код філії
				Resource Id: 1622
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    3.35"
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
			Data Field: dfFCode
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 5
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   3.3"
						Top:    3.3"
						Width:  1.0"
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
			Data Field: dfFName
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
						Left:   4.35"
						Top:    3.3"
						Width:  3.7"
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
			Picture: pbFiliales
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
				Picture Transparent Color: None
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
						Return XSalTooltipSetText(lParam, 'Філія')
					On SAM_Click
						If FunNSIGet("v_bpk_branch_filiales", "name", sPK, sSem)
							Set dfBranch = sPK
							Call GetFilial(dfBranch)
			Background Text: Адреса
				Resource Id: 1623
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    3.65"
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
			Data Field: dfFCity
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
						Top:    3.6"
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
			Data Field: dfFStreet
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
						Left:   5.35"
						Top:    3.6"
						Width:  2.7"
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
						Left:   3.3"
						Top:    3.9"
						Width:  4.75"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? No
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
			Function: GetFilial
				Description:
				Returns
					Boolean:
				Parameters
					String: sBranch
				Static Variables
				Local variables
				Actions
					If not SqlPrepareAndExecute(hSql(),
							"select code, name, city, street
							   into :dfFCode, :dfFName, :dfFCity, :dfFStreet
							   from v_bpk_branch_filiales
							  where branch = :sBranch")
						Return FALSE
					If not SqlFetchNext(hSql(), nFetchRes)
						Return FALSE
					Return TRUE
			Function: ClearField
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
				Actions
					Set dfDmName  = STRING_Null
					Set dfDmMName = STRING_Null
					Set dfWork    = STRING_Null
					Set dfOffice  = STRING_Null
					Set dfWPhone  = STRING_Null
					Set dfWCntry  = STRING_Null
					Set dfWPcode  = STRING_Null
					Set dfWCity   = STRING_Null
					Set dfWStreet = STRING_Null
					Set dfFCode   = STRING_Null
					Set dfFName   = STRING_Null
					Set dfFCity   = STRING_Null
					Set dfFStreet = STRING_Null
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
				Call GetFilial(hWndParent.frmCard.sPCBranch)
				!
				Set hWndParent.frmCard.hWndTabDemand = hWndForm
			On SAM_DoInit
				! 0 - закрыть поля (после "Открыть карточку")
				! 1 - очистить и открыть поля (после "Новая")
				! 2 - открыть поля (после "Копировать")
				If wParam = 0
					Call SalDisableWindow(dfDmName)
					Call SalDisableWindow(dfDmMName)
					Call SalDisableWindow(dfWork)
					Call SalDisableWindow(dfOffice)
					Call SalDisableWindow(dfWPhone)
					Call SalDisableWindow(dfWCntry)
					Call SalDisableWindow(dfWPcode)
					Call SalDisableWindow(dfWCity)
					Call SalDisableWindow(dfWStreet)
					Call SalDisableWindow(dfFCode)
					Call SalDisableWindow(pbFiliales)
				Else
					Call SalEnableWindow(dfDmName)
					Call SalEnableWindow(dfDmMName)
					Call SalEnableWindow(dfWork)
					Call SalEnableWindow(dfOffice)
					Call SalEnableWindow(dfWPhone)
					Call SalEnableWindow(dfWCntry)
					Call SalEnableWindow(dfWPcode)
					Call SalEnableWindow(dfWCity)
					Call SalEnableWindow(dfWStreet)
					Call SalEnableWindow(dfFCode)
					Call SalEnableWindow(pbFiliales)
					If wParam = 1 
						Call ClearField()
					Else
						Set dfDmName  = STRING_Null
						Set dfDmMName = STRING_Null
	Table Window: tblProduct
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Продукти БПК
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
				Width:  16.083"
				Width Editable? Class Default
				Height: 7.286"
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
						On SAM_Create
							Set strTip = 'Додати новий продукт'
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
							Set strTip = 'Видалити продукт'
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
					Resource Id: 11422
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
						On SAM_Create
							Set strTip = 'Редагування продукту'
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
					Resource Id: 11423
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
					Resource Id: 11424
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
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: №
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Number
				Justify: Right
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
			Column: colName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Назва
						продукту
				Visible? Class Default
				Editable? No
				Maximum Data Length: 100
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
			Column: colType
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Тип
						картки
				Visible? Class Default
				Editable? No
				Maximum Data Length: 1
				Data Type: Class Default
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
			Column: colTypeName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Назва
						типу кртки
				Visible? Class Default
				Editable? No
				Maximum Data Length: 100
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
			Column: colKv
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Вал.
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
			Column: colLcv
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Вал.
				Visible? Class Default
				Editable? No
				Maximum Data Length: 3
				Data Type: String
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
			Column: colKk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Категорія
						клієнта
				Visible? Class Default
				Editable? No
				Maximum Data Length: 1
				Data Type: Class Default
				Justify: Center
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
			Column: colKkName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Назва
						категорії клієнта
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Class Default
				Justify: Class Default
				Width:  2.4"
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
			Column: colCondSet
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Код
						умови
						рахунку
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Number
				Justify: Right
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
			Column: colCondSetName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Назва
						коду умови
						рахунку
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
			Column: colCValidity
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Тривалість
						строку дії
						картки
						(в місяцях)
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
			Column: colDebIntr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Вартість
						користування
						кредитом
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
			Column: colOlimIntr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Стягнення
						за
						овердрафт
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
			Column: colCredIntr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Відсоток
						на залишок
						по рахунку
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
			Column: colNbs
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: БР
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Class Default
				Justify: Class Default
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
			Column: colNbsName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Назва БР
				Visible? Class Default
				Editable? No
				Maximum Data Length: 175
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
			Column: colOb22
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: ОБ22
				Visible? Class Default
				Editable? No
				Maximum Data Length: 2
				Data Type: Class Default
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
			Column: colOb22Name
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Назва ОБ22
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
			Column: colLimit
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Ознака
						встановлення
						ліміту
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
			Column: colIdDoc
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Шаблон
						договору
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
			Column: colIdDocCred
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Шаблон
						кредитного
						договору
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
		Functions
		Window Parameters
			! nMode - режим: 0-просмотр, 1-редактирование
			Number: nMode
		Window Variables
		Message Actions
			On SAM_Create
				Call PrepareWindowEx(hWndForm)
				Call SetWindowFullSize(hWndForm)
				Set hWndForm.tblProduct.strFilterTblName = "v_bpk_product"
				Set hWndForm.tblProduct.strPrintFileName = "bpk_product"
				Set hWndForm.tblProduct.strSqlPopulate = 
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
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On SAM_DoubleClick
				If SalModalDialog(dlgProduct, hWndForm, colId)
					Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
			On UM_Insert
				If SalModalDialog(dlgProduct, hWndForm, NUMBER_Null)
					Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
			On UM_Update
				Set nRow = TBL_MinRow
				While SalTblFindNextRow(hWndForm, nRow, ROW_MarkDeleted, 0)
					Call SalTblSetContext(hWndForm, nRow)
					If not SqlPLSQLCommand(hSql(), "bars_bpk.product_delete(colId)")
						Call SqlRollbackEx(hSql(), "")
						Break
					Else
						Call SqlCommitEx(hSql(), "")
				Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
	Dialog Box: dlgProduct
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
				Height: 6.25"
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
			Group Box: Продукт
				Resource Id: 11425
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    0.05"
					Width:  8.6"
					Width Editable? Yes
					Height: 5.05"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Background Text: Назва продукту
				Resource Id: 11436
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
			Data Field: dfName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    0.25"
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
			Background Text: Тип картки
				Resource Id: 11426
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
			Combo Box: cmbAccType
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
					On UM_ObjActivate
						If cmbAccType.Init(hWndItem)
							Call cmbAccType.Populate(hSql(), "type", "name", "demand_acc_type", "order by card_type, acc_type")
							Call cmbAccType.SetSelectById(sType)
							Call SalSendMsg(hWndItem, SAM_User, 0, 0)
					On SAM_User
						Call SqlPrepareAndExecute(hSql(), "select card_type into :nCardType from demand_acc_type where type = :sType")
						Call SqlFetchNext(hSql(), nFetchRes)
						If sType
							Call SalEnableWindow(pbCondSet)
						Call SalSendMsg(cmbOb22, UM_ObjActivate, 0, 0)
					On SAM_Click
						Call SalSendClassMessage(SAM_Click, 0, 0)
						Set sType = cmbAccType.strCurrentId
						Call SalSendMsg(hWndItem, SAM_User, 0, 0)
						Call ClearCondSet()
			!
			Background Text: Валюта
				Resource Id: 11427
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
			Radio Button: rbUAH
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cRadioButtonLabeled
				Property Template:
				Class DLL Name:
				Title: UAH
				Window Location and Size
					Left:   2.5"
					Top:    0.85"
					Width:  1.4"
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
						Set nKv = 980
						Call ClearCondSet()
			Radio Button: rbUSD
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cRadioButtonLabeled
				Property Template:
				Class DLL Name:
				Title: USD
				Window Location and Size
					Left:   4.0"
					Top:    0.85"
					Width:  1.4"
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
						Set nKv = 840
						Call ClearCondSet()
			!
			Background Text: Категорія клієнта
				Resource Id: 11428
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
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
			Data Field: dfKk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 1
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    1.15"
						Width:  1.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Center
					Format: Uppercase
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Combo Box: cmbKk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_StrId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   3.55"
					Top:    1.15"
					Width:  4.4"
					Width Editable? Class Default
					Height: 3.202"
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
					On UM_ObjActivate
						If cmbKk.Init(hWndItem)
							Call cmbKk.Populate(hSql(), "kk", "name", "demand_kk", "order by kk")
							Call cmbKk.SetSelectById(dfKk)
					On SAM_Click
						Call SalSendClassMessage(SAM_Click, 0, 0)
						Set dfKk = cmbKk.strCurrentId
			!
			Background Text: Балансовий рахунок
				Resource Id: 11429
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
			Data Field: dfNbs
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 4
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    1.45"
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
			Combo Box: cmbNbs
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_StrId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   3.55"
					Top:    1.45"
					Width:  4.4"
					Width Editable? Class Default
					Height: 3.048"
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
					On UM_ObjActivate
						If cmbNbs.Init(hWndItem)
							Call cmbNbs.Populate(hSql(), "nbs", "nbs||' '||name", "ps", "where nbs in (select unique nbs from v_bpk_ob22) order by nbs")
							Call cmbNbs.SetSelectById(dfNbs)
							Call SalSendMsg(hWndItem, SAM_User, 0, 0)
					On SAM_User
						Call SalSendMsg(cmbOb22, UM_ObjActivate, 0, 0)
					On SAM_Click
						Call SalSendClassMessage(SAM_Click, 0, 0)
						Set dfNbs = cmbNbs.strCurrentId
						Call SalSendMsg(hWndItem, SAM_User, 0, 0)
			!
			Background Text: ОБ22
				Resource Id: 11430
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
						Left:   2.5"
						Top:    1.75"
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
			Combo Box: cmbOb22
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_StrId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   3.55"
					Top:    1.75"
					Width:  4.4"
					Width Editable? Class Default
					Height: 2.893"
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
					On UM_ObjActivate
						If cmbOb22.Init(hWndItem)
							If dfNbs and sType
								Call cmbOb22.Populate(hSql(), "ob22", "ob22_name", "v_bpk_ob22", 
										"where nbs='" || dfNbs || "' and type='" || sType || "' order by ob22")
								If nId
									Call cmbOb22.SetSelectById(dfOb22)
								Else
									Call SalListSetSelect(hWndItem, 0)
								Call SalSendMsg(cmbOb22, SAM_Click, 0, 0)
					On SAM_Click
						Call SalSendClassMessage(SAM_Click, 0, 0)
						Set dfOb22 = cmbOb22.strCurrentId
			!
			Background Text: Код умови рахунку
				Resource Id: 11431
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    2.1"
					Width:  4.3"
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
			Data Field: dfCondSet
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 4
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   4.55"
						Top:    2.05"
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
			Data Field: dfCondSetName
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
						Left:   5.6"
						Top:    2.05"
						Width:  2.35"
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
			Pushbutton: pbCondSet
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbFilter
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   8.05"
					Top:    2.05"
					Width:  Class Default
					Width Editable? Class Default
					Height: 0.3"
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
						Set strTip = 'Код умови рахунку'
					On SAM_Click
						If FunNSIGetFilteredAltPK("demand_cond_set", "cond_set", "name", 
								"currency=" || IifS(rbUAH=TRUE, "'UAH'", "'USD'") || 
								" and card_type=" || Str(nCardType), sPK, sSem)
							Set dfCondSet = Val(sPK)
							Set dfCondSetName = sSem
							Call GetCondSet()
			Background Text: Тривалість строку дії картки (в місяцях)
				Resource Id: 11432
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    2.4"
					Width:  4.3"
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
			Data Field: dfCValid
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
						Left:   4.55"
						Top:    2.35"
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
			Background Text: Вартість користування кредитом
				Resource Id: 11433
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    2.7"
					Width:  4.3"
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
			Data Field: dfDebIntr
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
						Left:   4.55"
						Top:    2.65"
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
			Background Text: Стягнення за овердрафт
				Resource Id: 11434
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    3.0"
					Width:  4.3"
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
			Data Field: dfOlimIntr
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
						Left:   4.55"
						Top:    2.95"
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
			Background Text: Відсоток на залишок по рахунку
				Resource Id: 11435
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    3.3"
					Width:  4.3"
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
			Data Field: dfCredIntr
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
						Left:   4.55"
						Top:    3.25"
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
			!
			Check Box: cbLimit
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cCheckBoxLabeled
				Property Template:
				Class DLL Name:
				Title: Ознака встановлення ліміту
				Window Location and Size
					Left:   2.5"
					Top:    3.55"
					Width:  4.8"
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
			!
			Background Text: Шаблон договору
				Resource Id: 11437
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    3.9"
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
			Data Field: dfIdDoc
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
						Top:    3.85"
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
			Data Field: dfDocName
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
						Top:    4.131"
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
			Pushbutton: pbDoc
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbFilter
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   8.05"
					Top:    3.845"
					Width:  Class Default
					Width Editable? Class Default
					Height: 0.3"
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
						Set strTip = 'Шаблон договору'
					On SAM_Click
						If FunNSIGetFiltered("doc_scheme", "name", "id like 'ACC_BPK%'", sPK, sSem)
							Set dfIdDoc = sPK
							Set dfDocName = sSem
			!
			Background Text: Шаблон кред. дог.
				Resource Id: 11438
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    4.5"
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
			Data Field: dfIdDocCred
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
						Top:    4.45"
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
			Data Field: dfDocCredName
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
						Top:    4.738"
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
			Pushbutton: pbDocCred
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbFilter
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   8.05"
					Top:    4.452"
					Width:  Class Default
					Width Editable? Class Default
					Height: 0.3"
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
						Set strTip = 'Шаблон кредитного договору'
					On SAM_Click
						If FunNSIGetFiltered("doc_scheme", "name", "id like 'ACC_BPK%'", sPK, sSem)
							Set dfIdDocCred = sPK
							Set dfDocCredName = sSem
			Frame
				Resource Id: 11439
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    5.15"
					Width:  8.6"
					Width Editable? Yes
					Height: 0.7"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Border Color: 3D Shadow Color
				Background Color: Default
			Pushbutton: pbSave
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbUpdate
				Property Template:
				Class DLL Name:
				Title: Зберегти
				Window Location and Size
					Left:   6.0"
					Top:    5.25"
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
						Set sErr = ''
						If dfName = STRING_Null
							Set sErr = 'Не заповнено <Назва продукту>'
							Set hWinFocus = dfName
						Else If sType = STRING_Null
							Set sErr = 'Не заповнено <Тип картки>'
							Set hWinFocus = cmbAccType
						Else If dfKk  = STRING_Null
							Set sErr = 'Не заповнено <Категорія клієнта>'
							Set hWinFocus = cmbKk
						Else If dfNbs = STRING_Null
							Set sErr = 'Не заповнено <Балансовий рахунок>'
							Set hWinFocus = cmbNbs
						Else If dfOb22 = STRING_Null
							Set sErr = 'Не заповнено <ОБ22>'
							Set hWinFocus = cmbOb22
						Else If dfCondSet = NUMBER_Null
							Set sErr = 'Не заповнено <Код умови рахунку>'
							Set hWinFocus = pbCondSet
						Else If dfIdDoc = STRING_Null
							Set sErr = 'Не заповнено <Шаблон договору>'
							Set hWinFocus = pbDoc
						! Else If dfIdDocCred = STRING_Null
							          Set sErr = 'Не заповнено <Шаблон кредитного договору>'
							          Set hWinFocus = pbDocCred
						If sErr
							Call SalMessageBox(sErr, 'Увага!', MB_IconExclamation | MB_Ok)
							Call SalSetFocus(hWinFocus)
							Return FALSE
						Call SalWaitCursor(TRUE)
						If not SaveProduct()
							Call SalWaitCursor(FALSE)
							Return FALSE
						Call SalWaitCursor(FALSE)
						If nId
							Call SalMessageBox("Оновлено продукт БПК №" || Str(nId), "Інформація", MB_IconAsterisk | MB_Ok)
						Else
							Call SalMessageBox("Зареєстровано новий продукт БПК", "Інформація", MB_IconAsterisk | MB_Ok)
						Call SalEndDialog(hWndForm, TRUE)
			Pushbutton: pbCancel
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title: Відмінити
				Window Location and Size
					Left:   7.283"
					Top:    5.25"
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
		Functions
			Function: ClearCondSet
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
				Actions
					Set dfCondSet  = NUMBER_Null
					Set dfCondSetName = STRING_Null
					Set dfCValid   = NUMBER_Null
					Set dfDebIntr  = NUMBER_Null
					Set dfOlimIntr = NUMBER_Null
					Set dfCredIntr = NUMBER_Null
					If sType
						Call SalEnableWindow(pbCondSet)
					Else
						Call SalDisableWindow(pbCondSet)
					Return TRUE
			Function: GetCondSet
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
				Actions
					If not SqlPrepareAndExecute(hSql(),
							"select d.c_validity, d.deb_intr, d.olim_intr, d.cred_intr
							   into :dfCValid, :dfDebIntr, :dfOlimIntr, :dfCredIntr
							   from demand_cond_set d
							  where d.card_type = :nCardType
							    and d.cond_set  = :dfCondSet")
						Return FALSE
					If not SqlFetchNext(hSql(), nFetchRes)
						Return FALSE
					Return TRUE
			Function: GetDoc
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
				Actions
					If dfIdDoc
						Call SqlPrepareAndExecute(hSql(),
								"select name into :dfDocName
								   from doc_scheme
								  where id = :dfIdDoc")
						Call SqlFetchNext(hSql(), nFetchRes)
					If dfIdDocCred
						Call SqlPrepareAndExecute(hSql(),
								"select name into :dfDocCredName
								   from doc_scheme
								  where id = :dfIdDocCred")
						Call SqlFetchNext(hSql(), nFetchRes)
					Return TRUE
			Function: SaveProduct
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
				Actions
					If nId
						If not SqlPLSQLCommand(hSql(), 
								"bars_bpk.product_change(nId,dfName,sType,nKv,dfKk,dfCondSet,
								cbLimit,dfNbs,dfOb22,dfIdDoc,dfIdDocCred)")
							Call SqlRollbackEx(hSql(), "")
							Return FALSE
					Else
						If not SqlPLSQLCommand(hSql(), 
								"bars_bpk.product_add(NUMBER_Null,dfName,sType,nKv,dfKk,dfCondSet,
								cbLimit,dfNbs,dfOb22,dfIdDoc,dfIdDocCred)")
							Call SqlRollbackEx(hSql(), "")
							Return FALSE
					Call SqlCommitEx(hSql(), "")
					Return TRUE
		Window Parameters
			Number: nId
			! String: sName
			! String: sType
			! Number: nKv
			! String: sKk
			! Number: sCondSet
			! String: sCondSetName
			! Number: nCValidity
			! Number: nDebIntr
			! Number: nOlimIntr
			! Number: nCredIntr
			! String: sNbs
			! String: sOb22
			! Number: nLimit
			! String: sIdDoc
			! String: sIdDocCred
		Window Variables
			String: sType
			Number: nKv
			Number: nCardType
			Number: nCardTypeOld
			String: sPK
			String: sSem
			String: sErr
			Window Handle: hWinFocus
		Message Actions
			On SAM_Create
				If nId
					Call SalSetWindowText(hWndForm, "Редагування продукту БПК № " || Str(nId))
				Else
					Call SalSetWindowText(hWndForm, "Реєстрація нового продукту БПК")
				Call PrepareWindow(hWndForm)
				Set nCardTypeOld = NUMBER_Null
				If nId
					Call SqlPrepareAndExecute(hSql(),
							"select name, type, kv, kk, cond_set, cond_set_name,
							        c_validity, deb_intr, olim_intr, cred_intr,
							        nbs, ob22, limit, id_doc, id_doc_cred
							   into :dfName, :sType, :nKv, :dfKk, :dfCondSet, :dfCondSetName,
							        :dfCValid, :dfDebIntr, :dfOlimIntr, :dfCredIntr,
							        :dfNbs, :dfOb22, :cbLimit, :dfIdDoc, :dfIdDocCred
							   from v_bpk_product
							  where id = :nId")
					Call SqlFetchNext(hSql(), nFetchRes)
					Call SalSetWindowText(hWndForm, "Редагування продукту БПК № " || Str(nId) || " " || dfName)
					Set nCardTypeOld = nCardType
					If nKv = 980
						Set rbUAH = TRUE
					Else
						Set rbUSD = TRUE
					Call GetDoc()
				Else
					Set rbUAH = TRUE
					Set nKv = 980
					Call SalDisableWindow(pbCondSet)
				Call SalSendMsg(cmbAccType, UM_ObjActivate, 0, 0)
				Call SalSendMsg(cmbKk, UM_ObjActivate, 0, 0)
				Call SalSendMsg(cmbNbs, UM_ObjActivate, 0, 0)
				Call SalSetFocus(pbCancel)
				Call SalWaitCursor(FALSE)
	Table Window: tblFormFileP
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Формування файлів P*
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
				Width:  10.4"
				Width Editable? Class Default
				Height: 5.3"
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
					Resource Id: 42297
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  6.283"
						Begin Y:  -0.036"
						End X:  6.283"
						End Y:  0.429"
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
					Resource Id: 18491
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  4.967"
						Begin Y:  -0.083"
						End X:  4.967"
						End Y:  0.381"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Pushbutton: pbShowiles
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbBrowse
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.017"
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
					Picture File Name: \BARS98\RESOURCE\BMP\COPY.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Перегляд сформованих файлів'
						On SAM_Click
							Call FunNSIEditF("v_obpc_pfiles", 1 | 0x0010)
				Pushbutton: pbShowFile
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbSwitch
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.45"
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
					Picture File Name: \BARS98\RESOURCE\BMP\LOGFILE.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Перегляд сформованого файла'
						On SAM_Click
							If colFileName
								Call FunNSIEditFFiltered("v_obpc_pfiles_doc", 1, 
										"file_name='" || colFileName || "' and trunc(file_date)=trunc(sysdate)")
				Line
					Resource Id: 42298
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  5.633"
						Begin Y:  -0.012"
						End X:  5.633"
						End Y:  0.452"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Pushbutton: pbFormFiles
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbExecute
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
							Set strTip = 'Сформувати файли'
						On SAM_Click
							If SalMessageBox("Сформувати відмічені файли?", "Питання", MB_IconQuestion | MB_YesNo) = IDYES
								Call ClearTable()
								Call FormFiles()
								Call SalTblSetContext(hWndForm, 0)
								Call SalPostMsg(hWndForm, SAM_TblDoDetails, 0, 0)
				Line
					Resource Id: 42300
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
						Left:   5.75"
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
					Resource Id: 42299
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
			Column: colFileChar
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Символ
						файлу
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
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
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colFlag
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Формувати
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  1.2"
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
			Column: colComments
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Результат формування
				Visible? Yes
				Editable? No
				Maximum Data Length: 2000
				Data Type: Long String
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
			Column: colFileName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Файл
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
		Functions
			Function: ClearTable
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Number: nRow
				Actions
					Set nRow = TBL_MinRow
					While SalTblFindNextRow(hWndForm, nRow, 0, 0)
						Call SalTblSetContext(hWndForm, nRow)
						Call SalTblSetRowFlags(hWndForm, nRow, ROW_Edited, FALSE)
						Set colComments = STRING_Null
						Set colFileName = STRING_Null
					Return TRUE
			Function: FormFiles
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Number: nRow
					: cFileFormer
						Class: cPA_PC_Former
				Actions
					Set nRow = TBL_MinRow
					Call SalWaitCursor(TRUE)
					While SalTblFindNextRow(hWndForm, nRow, 0, 0)
						Call SalTblSetContext(hWndForm, nRow)
						If colFlag
							! Вызов класса формирования файла
							If cFileFormer.FormFile(sPath, colFileChar)
								If cFileFormer.sLog
									Set colComments = cFileFormer.sLog
									Call SalTblSetCellTextColor(hWndForm.tblFormFileP.colComments, COLOR_DarkRed, FALSE)
								Else
									Set colComments = "Формування успішно завершено!"
									Call VisTblSetRowColor(hWndForm, nRow, COLOR_Black)
								Set colFileName = cFileFormer.sFileFormed
							Else
								Set colComments = cFileFormer.sLog
							Call SaveInfoToLog('OBPC. Формування файлу P' || colFileChar || ': ' || colComments)
						Else
							Set colComments = STRING_Null
						Call SalTblSetRowFlags(hWndForm, nRow, ROW_Edited, FALSE)
					Call SalWaitCursor(FALSE)
					Return TRUE
		Window Parameters
		Window Variables
			String: sPath
			String: sTmp
		Message Actions
			On SAM_Create
				Call PrepareWindowEx(hWndForm)
				Call SalTblSetTableFlags(hWndForm, TBL_Flag_SingleSelection, TRUE)
				! Чтение параметров
				Call SalUseRegistry(FALSE, GetIniFileName())
				Call SalGetProfileString('OBPC', 'OBPCOutPath', '', sPath, GetIniFileName())
				!
				Set hWndForm.tblFormFileP.nFlags = GT_ReadOnly
				Set hWndForm.tblFormFileP.strPrintFileName = 'out_files'
				Set hWndForm.tblFormFileP.strSqlPopulate = 
						"select unique file_char, 1
						   into :hWndForm.tblFormFileP.colFileChar, :hWndForm.tblFormFileP.colFlag
						   from obpc_out_files
						  order by file_char"
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On SAM_DoubleClick
				Call SalModalDialog(dlgStatus, hWndForm, colComments, 'Статус формування файлу Р' || colFileChar)
			On SAM_TblDoDetails
				If colFileName
					Call SalEnableWindow(pbShowFile)
				Else
					Call SalDisableWindow(pbShowFile)
	Table Window: tblDeleteTran
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Необроблені транзвкції TRAN
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
							Set strTip = 'Видалити транзакцію'
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
					Resource Id: 55827
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
					Resource Id: 55829
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
				Pushbutton: pbKvtTran
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.017"
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
							Set strTip = 'Сквітувати транзакцію'
						On SAM_Click
							If colIdn
								If SalModalDialog(dlgKvtTran, hWndForm, colId, colIdn, colCardAcct, colCurrency, colTranType, colAmount, colTranDate)
									Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
				Line
					Resource Id: 55828
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  5.217"
						Begin Y:  0.0"
						End X:  5.217"
						End Y:  0.464"
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
						Left:   4.683"
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
					Resource Id: 55830
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
				Title: Ім'я
						файлу
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
				Data Type: String
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
			Column: colCardAcct
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Технічний
						рахунок
				Visible? Yes
				Editable? Yes
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
					On SAM_SetFocus
						Set sTmp = colCardAcct
					On SAM_AnyEdit
						Set colCardAcct = sTmp
						Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
			Column: colCurrency
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Вал.
						рах.
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
				Data Type: String
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
			! Column: colCcy
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Вал. 
						оп.
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
				Data Type: String
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
.end
				   List Values 
				   Message Actions 
			Column: colLacct
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Картковий
						рахунок
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
						Set sTmp = colLacct
					On SAM_AnyEdit
						Set colLacct = sTmp
						Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
			Column: colAmount
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сума в вал.
						рахунку
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
			Column: colTranType
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Тип
						транз.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
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
			Column: colTranRuss
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Назва операції
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
			Column: colTranDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						операції
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
			! Column: colCard
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: №
						картки
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
.end
				   List Values 
				   Message Actions 
			! Column: colSlipNr
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: №
						сліпу
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
.end
				   List Values 
				   Message Actions 
			! Column: colBatchNr
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: №
						пакету
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
.end
				   List Values 
				   Message Actions 
			Column: colAbvrName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Назва
						MERCHANT
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
			Column: colCity
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Місто
						MERCHANT
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
			Column: colMerchant
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: MERCHANT
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
			! Column: colTranAmt
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сума
						операції
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
.end
				   List Values 
				   Message Actions 
			! Column: colPostDate
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дота
						обробки
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
.end
				   List Values 
				   Message Actions 
			! Column: colCardType
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Тип
						картки
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
.end
				   List Values 
				   Message Actions 
			! Column: colCountry
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Країна
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
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
.end
				   List Values 
				   Message Actions 
			! Column: colMccCode
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код торг.
						точки
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
.end
				   List Values 
				   Message Actions 
			! Column: colTerminal
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						терміналу
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
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
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
.end
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
			Column: colIdn
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: №
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
		Functions
		Window Parameters
		Window Variables
			Number: nCount
			Number: nRow
			String: sTmp
		Message Actions
			On SAM_Create
				Call PrepareWindowEx(hWndForm)
				Call SetWindowFullSize(hWndForm)
				Set hWndForm.tblDeleteTran.nFlags = GT_NoIns | GT_NoUpd
				Set hWndForm.tblDeleteTran.strFilterTblName = "v_obpc_tran"
				Set hWndForm.tblDeleteTran.strPrintFileName = "tran"
				Set hWndForm.tblDeleteTran.strSqlPopulate = 
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
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On UM_Populate
				Set nCount = 0
				Call SalSendClassMessage(UM_Populate, 0, 0)
				Call SalTblDefineSplitWindow(hWndForm, 1, TRUE)
				Set nRow = SalTblInsertRow(hWndForm, TBL_MinRow)
				Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
				Call SalTblSetContext(hWndForm, nRow)
				Set colCardAcct = 'Всього: ' || Str(nCount)
			On SAM_FetchRowDone
				Set nCount = nCount + 1
			On UM_Delete
				If SalTblAnyRows(hWndForm, ROW_Selected, 0)
					If SalMessageBox('Видалити виділені необроблені транзакції?', 'Увага!', MB_IconQuestion | MB_YesNo) = IDYES
						Set nRow = TBL_MinRow
						While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
							Call SalTblSetContext(hWndForm, nRow)
							If SqlPLSQLCommand(hSql(), "obpc.delete_tran(colIdn)")
								Call SqlCommitEx(hSql(), "OBPC. Удалена транзакция в архив, idn=" || Str(colIdn))
							Else
								Call SqlRollbackEx(hSql(), "OBPC. Неуспешное удаление транзакции в архив, idn=" || Str(colIdn))
								Break
						Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
	Dialog Box: dlgKvtTran
		Class:
		Property Template:
		Class DLL Name:
		Title: Квитовка транзакції ПЦ
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  8.5"
				Width Editable? Yes
				Height: 3.8"
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
			Background Text: Референс
				Resource Id: 55837
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    0.3"
					Width:  2.0"
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
			Data Field: dfRef
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 22
					Data Type: Number
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   2.3"
						Top:    0.25"
						Width:  1.6"
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
						If SalIsNull(dfRef)
							Call SalDisableWindow(pbKvt)
							Set dfNls  = STRING_Null
							Set dfNms  = STRING_Null
							Set dfLcv  = STRING_Null
							Set dfS    = NUMBER_Null
							Set dfVDat = DATETIME_Null
						Else
							If searchDoc()
								Call SalEnableWindow(pbKvt)
							Else
								Call SalDisableWindow(pbKvt)
						Return VALIDATE_Ok
			Group Box: Документ БАРСа
				Resource Id: 51645
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    0.05"
					Width:  8.2"
					Width Editable? Yes
					Height: 2.6"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Background Text: Рахунок
				Resource Id: 51646
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    0.6"
					Width:  2.0"
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
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.3"
						Top:    0.55"
						Width:  1.6"
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
			Background Text: Валюта
				Resource Id: 51653
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    0.9"
					Width:  2.0"
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
			Data Field: dfLcv
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
						Left:   2.3"
						Top:    0.85"
						Width:  1.6"
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
			Background Text: Сума
				Resource Id: 51647
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
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfS
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
						Width:  1.6"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Decimal
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Дата валютування
				Resource Id: 51648
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
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfVDat
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
						Left:   2.3"
						Top:    1.75"
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
					Input Mask: Unformatted
				Message Actions
			Data Field: dfNms
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
						Top:    1.15"
						Width:  3.7"
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
					Background Color: 3D Face Color
					Input Mask: Unformatted
				Message Actions
			Group Box: Документ ПЦ
				Resource Id: 51649
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.2"
					Top:    0.05"
					Width:  4.1"
					Width Editable? Yes
					Height: 2.6"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Background Text: Технічний рахунок
				Resource Id: 51650
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.3"
					Top:    0.3"
					Width:  2.0"
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
			Data Field: dfCardAcct
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
						Left:   6.4"
						Top:    0.25"
						Width:  1.6"
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
			Background Text: Картковий рахунок
				Resource Id: 51651
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.3"
					Top:    0.6"
					Width:  2.0"
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
			Data Field: dfLacct
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
						Left:   6.4"
						Top:    0.55"
						Width:  1.6"
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
			Background Text: Валюта
				Resource Id: 51654
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.3"
					Top:    0.9"
					Width:  2.0"
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
			Data Field: dfCurrency
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
						Left:   6.4"
						Top:    0.85"
						Width:  1.6"
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
			Background Text: Сума
				Resource Id: 51652
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.3"
					Top:    1.5"
					Width:  2.0"
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
			Data Field: dfAmount
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
						Left:   6.4"
						Top:    1.45"
						Width:  1.6"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Decimal
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Дата операції
				Resource Id: 51644
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.3"
					Top:    1.8"
					Width:  2.0"
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
			Data Field: dfTranDate
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
						Left:   6.4"
						Top:    1.75"
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
					Input Mask: Unformatted
				Message Actions
			Data Field: dfClientN
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
						Left:   4.3"
						Top:    1.15"
						Width:  3.7"
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
					Background Color: 3D Face Color
					Input Mask: Unformatted
				Message Actions
			Frame
				Resource Id: 55838
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    2.7"
					Width:  8.2"
					Width Editable? Yes
					Height: 0.7"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Border Color: 3D Shadow Color
				Background Color: Default
			Pushbutton: pbDoc
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbDetail
				Property Template:
				Class DLL Name:
				Title: Документ
				Window Location and Size
					Left:   0.4"
					Top:    2.85"
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
						If not SalIsNull(dfRef) and not SalIsNull(dfNls)
							Call DocViewContentsEx(hWndForm, dfRef)
			Pushbutton: pbKvt
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbOk
				Property Template:
				Class DLL Name:
				Title: Сквитувати
				Window Location and Size
					Left:   1.6"
					Top:    2.845"
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
						If kvtTran()
							Call SalEndDialog(hWndForm, TRUE)
			Pushbutton: pbCancel
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title: Відмінити
				Window Location and Size
					Left:   6.8"
					Top:    2.845"
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
			Function: searchDoc
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Number: i
				Actions
					If not SqlPrepareAndExecute(hSql(), 
							"select decode(dk,:nDk,nlsb,nlsa), decode(dk,:nDk,nam_b,nam_a),
							        decode(decode(dk,:nDk,nvl(kv2,kv),kv),980,'UAH','USD'),
							        decode(dk,:nDk,nvl(s2,s),s)/100, vdat
							   into :dfNls, :dfNms, :dfLcv, :dfS, :dfVDat
							   from oper
							  where ref = :dfRef")
						Return FALSE
					If not SqlFetchNext(hSql(), nFetchRes)
						Call SalMessageBox('Документ не знайдено!', 'Увага!', MB_IconExclamation | MB_Ok)
						Set dfNls  = STRING_Null
						Set dfNms  = STRING_Null
						Set dfLcv  = STRING_Null
						Set dfS    = NUMBER_Null
						Set dfVDat = DATETIME_Null
						Call SalSetFocus(dfRef)
						Return FALSE
					If dfNls != '' and dfLacct != '' and dfNls != dfLacct
						Call SalColorSet(dfNls, COLOR_IndexWindowText, COLOR_DarkRed)
					If dfLcv != dfCurrency
						Call SalColorSet(dfLcv, COLOR_IndexWindowText, COLOR_DarkRed)
					If dfS   != dfAmount
						Call SalColorSet(dfS, COLOR_IndexWindowText, COLOR_DarkRed)
					Call SqlPrepareAndExecute(hSql(), "select 1 into :i from obpc_tran_hist where ref = :dfRef")
					If SqlFetchNext(hSql(), nFetchRes)
						Call SalMessageBox("Документ реф. " || Str(dfRef) || " вже сквитовано!", "Увага!", MB_IconExclamation | MB_Ok)
						Return FALSE
					Return TRUE
			Function: kvtTran
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
				Actions
					If SalIsNull(dfRef)
						Return FALSE
					If dfNls != '' and dfLacct != '' and dfNls != dfLacct
						If SalMessageBox("Карткові рахунки транзакції та документу не співпадають!" || PutCrLf() ||
								   "Сквитувати транзакцію?", "Увага!", MB_IconQuestion | MB_YesNo) = IDNO
							Return FALSE
					If dfS   != dfAmount
						If SalMessageBox("Суми транзакції та документу не співпадають!" || PutCrLf() ||
								   "Сквитувати транзакцію?", "Увага!", MB_IconQuestion | MB_YesNo) = IDNO
							Return FALSE
					If not SqlPLSQLCommand(hSql(), "obpc.set_kvt_flag(nParId, nParIdn, dfRef, nDk)")
						Call SqlRollbackEx(hSql(), "OBPC. Неуспешная квитовка транзакции idn=" || Str(nParIdn))
						Return FALSE
					Call SqlCommitEx(hSql(), "OBPC. Сквитована транзация idn=" || Str(nParIdn) || " с реф." || Str(dfRef))
					Call SalMessageBox("Успішно сквитовано транзакцію.", "Інформація", MB_IconAsterisk | MB_Ok)
					Return TRUE
		Window Parameters
			Number: nParId
			Number: nParIdn
			String: sParCardAcct
			String: sParCurrency
			String: sParTranType
			Number: nParAmount
			Date/Time: dParTranDate
		Window Variables
			Number: nDk
			Number: nKv
		Message Actions
			On SAM_Create
				Call PrepareWindowEx(hWndForm)
				Set dfCardAcct = sParCardAcct
				Set dfCurrency = sParCurrency
				Set dfAmount   = nParAmount
				Set dfTranDate = dParTranDate
				Call SqlPrepareAndExecute(hSql(), "select lacct, client_n into :dfLacct, :dfClientN from obpc_acct where card_acct = :sParCardAcct")
				Call SqlFetchNext(hSql(), nFetchRes)
				Call SqlPrepareAndExecute(hSql(), "select dk into :nDk from obpc_trans where tran_type = :sParTranType")
				Call SqlFetchNext(hSql(), nFetchRes)
				Set nKv = IifN(sParCurrency='UAH', 980, 840)
				Call SalDisableWindow(pbKvt)
	Table Window: tblFormOdbDbf
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Формування odb*.dbf
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
				Width:  16.667"
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
			Maximum Rows in Memory: 100000
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
							Set strTip = 'Видалити рахунки з вигрузки до odb*.dbf'
				Combo Box: cmbDat
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cGenComboBox_DatId
					Property Template:
					Class DLL Name:
					Window Location and Size
						Left:   1.05"
						Top:    0.1"
						Width:  2.0"
						Width Editable? Class Default
						Height: 3.667"
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
							Call cmbDat.Init(hWndItem)
							Call cmbDat.Populate(hSql(), "fdat", "to_char(fdat,'dd.MM.yyyy')", "fdat", "order by fdat desc")
							Call cmbDat.SetSelectById(dDat)
						On SAM_Click
							Call SalSendClassMessage(SAM_Click, 0, 0)
							Call SalTblReset(hWndForm)
							Set dDat = cmbDat.dtCurrentId
							Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
				Pushbutton: pbRefresh
					Class Child Ref Key: 35
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.133"
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
						Left:   3.583"
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
						Left:   4.05"
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
						Left:   4.5"
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
					Resource Id: 18683
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  8.067"
						Begin Y:  0.0"
						End X:  8.067"
						End Y:  0.464"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbAccount
					Class Child Ref Key: 39
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   5.133"
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
					Picture File Name: \BARS98\RESOURCE\BMP\OPEN.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Перегляд картки рахунку'
				Pushbutton: pbCustomer
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbDetail
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   5.567"
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
							Set strTip = 'Перегляд картки клієнта'
						On SAM_Click
							Select Case colCusttype
								Case 2
									Call EditCustCorpsEx(colRnk, CVIEW_Saldo, hWndForm, 0, '', FALSE)
									Break
								Case 3
									Call EditCustPersonEx(colRnk, CVIEW_Saldo, hWndForm, 0, '', FALSE)
									Break
								Default
									Break
				Pushbutton: pbForm
					Class Child Ref Key: 36
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   6.017"
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
					Picture File Name: \BARS98\RESOURCE\BMP\TOMAIL.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Сформувати odb*.dbf'
						On SAM_Click
							If SalTblAnyRows(hWndForm, 0, 0)
								Set bErrRow = FALSE
								If FormOdbDbf(bErrRow)
									Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
									If bErrRow
										Call SalMessageBox("Для рахунків, що залишились, треба заповнити обов'язкові реквізити!" || PutCrLf() || PutCrLf() ||
												     "Кожне відділення може побачити такі рахунки в довіднику 'БПК. Рахунки до Demand з помилками'" || PutCrLf() ||
												     "та заповнити обов'язкові реквізити в карточці клієнта чи рахунку.",
												     "Увага!", MB_IconExclamation | MB_Ok)
				Pushbutton: pbArc
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbBrowse
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   6.45"
						Top:    0.071"
						Width:  0.467"
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\TUDASUDA.BMP
					Picture Transparent Color: White
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Показати відібрані до odb*.dbf рахунки'
							Set bArc = TRUE
						On SAM_Click
							Set sWhereFromFilter = hWndForm.tblFormOdbDbf.cF.GetFilterWhereClause(FALSE)
							If bArc
								Call SalDisableWindow(pbForm)
								Call SalEnableWindow(pbUnForm)
								Set sWhere = " and flag_odb = 1"
								Set strTip = 'Показати рахунки для вигрузки до odb*.dbf'
							Else
								Call SalEnableWindow(pbForm)
								Call SalDisableWindow(pbUnForm)
								Set sWhere = " and flag_odb = 0"
								Set strTip = 'Показати відібрані до odb*.dbf рахунки'
							Set hWndForm.tblFormOdbDbf.strSqlPopulate = sSelect || sWhere || 
									    IifS(sWhereFromFilter="", "", " and " || sWhereFromFilter) || sOrder
							Call hWndForm.tblFormOdbDbf.ReInitQueryString()
							Set bArc = not bArc
							Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
				Pushbutton: pbUnForm
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbDetail
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   6.917"
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
							Set strTip = 'Зняти відмітку про вигрузку до odb*.dbf'
						On SAM_Click
							If SalMessageBox("Зняти відмітку про вигрузку до odb*.dbf для вибраних рахунків?", "Увага!", MB_IconQuestion | MB_YesNo) = IDYES
								If SetUnFormFlag()
									Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
				Line
					Resource Id: 18684
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  7.433"
						Begin Y:  0.06"
						End X:  7.433"
						End Y:  0.524"
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
						Left:   7.517"
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
					Resource Id: 18685
					Class Child Ref Key: 43
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  5.017"
						Begin Y:  0.083"
						End X:  5.017"
						End Y:  0.548"
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
			Column: colBranch	! Branch
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
			Column: colRnk
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
			Column: colCusttype
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
			Column: colAccType	! Тип картки
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Тип
						картки
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
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
			Column: colCurr		! Валюта рахунку
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
				Justify: Left
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
			Column: colClientN	! Власник рахунку
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Власник
						рахунку
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.6"
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
			Column: colCondSet	! N Код умови рахунку
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						умови
						рахунку
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
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
			Column: colType		! Тип клієнта (T/F)
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Тип
						клієнта
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
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
			Column: colLacct	! рахунок
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
			Column: colBrn		! Відділення
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Відді
						лення
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
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
			Column: colCrd		! N Дозволений кредит
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дозво
						лений
						кредит
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
			Column: colIdA		! ЗКПО
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
			Column: colKk		! Категорія клієнта
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Кате
						горія
						клієнта
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
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
			Column: colWork		! Місце роботи
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
			Column: colRegNr	! Номер реєстрації
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Номер
						реєстрації
				Visible? No
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
			Column: colPhone	! Телефон 
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Телефон
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
			Column: colCntry	! Держава
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Держава
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
			Column: colPcode	! Почтовий індекс
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Індекс
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
			Column: colCity		! Місто
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Місто
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
			Column: colStreet	! Вулица
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Вулица
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
			Column: colOffice	! Посада
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
			Column: colPhoneW	! Телефон місця роботи
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Телефон
						місця
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
			Column: colCntryW	! Держава місця роботи
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Держава
						місця
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
			Column: colPcodeW	! Почтовий індекс місця роботи
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Індекс
						місця
						роботи
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
			Column: colCityW	! Місто місця роботи
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Місто
						місця
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
			Column: colStreetW	! Вулица місця роботи
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Вулица
						місця
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
			Column: colMinBal	! N Мінімальний баланс
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Мінімальний
						баланс
				Visible? No
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
			Column: colDeposit	! N Сума депозиту
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сума
						депозиту
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
			Column: colResident	! Резидент/Не резидент
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Резид./
						Не резид.
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
			Column: colName		! Ім'я та прізвище на картке
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ім'я та прізвище
						на картке
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
			Column: colIdC		! Паспорт
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Паспорт
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
			Column: colBDate	! Дата народження матері
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						народж.
						матері
				Visible? No
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
			Column: colMname	! Дівоче прізвище матері
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
			Column: colMt		! Мобільний телефон
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Моб.
						тел.
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
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
		Functions
			Function: isNullFields
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
				Actions
					If SalIsNull(colCondSet)
							or SalIsNull(colKk)
							or SalIsNull(colWork)
							or SalIsNull(colPcode)
							or SalIsNull(colCity)
							or SalIsNull(colStreet)
							or SalIsNull(colOffice)
							or SalIsNull(colName)
							or SalIsNull(colMname)
						Return TRUE
					Return FALSE
			Function: FormOdbDbf
				Description:
				Returns
					Boolean:
				Parameters
					Receive Boolean: bRetErrRow
				Static Variables
				Local variables
					Sql Handle: hSqlDbf
					String: sFileName
					String: sFilePath
					Number: nRow
					Boolean: bFl
					!
					String: sAccType
					String: sCurr
					String: sClientN
					Number: nCondSet
					String: sType
					String: sLacct
					String: sBrn
					Number: nCrd
					String: sIdA
					String: sKk
					String: sWork
					String: sRegNr
					String: sPhone
					String: sCntry
					String: sPcode
					String: sCity
					String: sStreet
					String: sOffice
					String: sPhoneW
					String: sCntryW
					String: sPcodeW
					String: sCityW
					String: sStreetW
					Number: nMinBal
					Number: nDeposit
					String: sResident
					String: sName
					String: sIdC
					String: sBDate
					String: sMname
					String: sMt
				Actions
					Set sFileName = 'odb_' || 
							    SalStrRightX('0' || Str(SalDateDay(SalDateCurrent())), 2) ||
							    SalStrRightX('0' || Str(SalDateMonth(SalDateCurrent())), 2)
					Set sFilePath = GetPrnDir()  || '\\' || sFileName || '.dbf'
					If SalFileSetCurrentDirectory(GetPrnDir())
						Set SqlDatabase = 'dBase_Files'
						If SqlConnect(hSqlDbf)
							Call SalWaitCursor(TRUE)
							Call VisFileDelete(sFilePath)
							Call SqlPrepareAndExecute(hSqlDbf,
									"CREATE TABLE " || sFileName || " (
									   ACC_TYPE CHAR(1), CURR CHAR(3), CLIENT_N CHAR(40), COND_SET NUMBER(3),
									   TYPE CHAR(1), LACCT CHAR(16), BRN CHAR(5), CRD NUMBER(12,2),
									   ID_A CHAR(10), KK CHAR(1), WORK CHAR(30), REG_NR CHAR(10),
									   PHONE CHAR(11), CNTRY CHAR(15), PCODE CHAR(6), CITY CHAR(15),
									   STREET CHAR(30), OFFICE CHAR(25), PHONE_W CHAR(11), CNTRY_W CHAR(15),
									   PCODE_W CHAR(6), CITY_W CHAR(15), STREET_W CHAR(30),
									   MIN_BAL NUMBER(12,2), DEPOSIT NUMBER(12,2), RESIDENT CHAR(1),
									   NAME CHAR(24), ID_C CHAR(14), B_DATE CHAR(8), M_NAME CHAR(20), MT CHAR(10) )")
							Set bFl = TRUE
							Set nRow = TBL_MinRow
							While SalTblFindNextRow(hWndForm, nRow, 0, 0)
								Call SalTblFetchRow(hWndForm, nRow)
								If isNullFields()
									Set bRetErrRow = TRUE
								Else
									Set sAccType = colAccType
									Set sCurr    = colCurr
									Set sClientN = StrWinToDosX(colClientN)
									Set nCondSet = IifN(colCondSet=NUMBER_Null, 0, colCondSet)
									Set sType    = colType
									Set sLacct   = colLacct
									Set sBrn     = IifS(colBrn=STRING_Null, '-', colBrn)
									Set nCrd     = colCrd
									Set sIdA     = IifS(colIdA=STRING_Null, '0', colIdA)
									Set sKk      = IifS(colKk=STRING_Null, 'A', colKk)
									Set sWork    = IifS(colWork=STRING_Null, '-', StrWinToDosX(colWork))
									Set sRegNr   = '-'
									Set sPhone   = IifS(colPhone=STRING_Null, '-', colPhone)
									Set sCntry   = IifS(colCntry=STRING_Null, '-', StrWinToDosX(colCntry))
									Set sPcode   = IifS(colPcode=STRING_Null, '-', StrWinToDosX(colPcode))
									Set sCity    = IifS(colCity=STRING_Null, '-', StrWinToDosX(colCity))
									Set sStreet  = IifS(colStreet=STRING_Null, '-', StrWinToDosX(colStreet))
									Set sOffice  = IifS(colOffice=STRING_Null, '-', StrWinToDosX(colOffice))
									Set sPhoneW  = IifS(colPhoneW=STRING_Null, '-', colPhoneW)
									Set sCntryW  = IifS(colCntryW=STRING_Null, '-', StrWinToDosX(colCntryW))
									Set sPcodeW  = IifS(colPcodeW=STRING_Null, '-', StrWinToDosX(colPcodeW))
									Set sCityW   = IifS(colCityW=STRING_Null, '-', StrWinToDosX(colCityW))
									Set sStreetW = IifS(colStreetW=STRING_Null, '-', StrWinToDosX(colStreetW))
									Set nMinBal  = colMinBal
									Set nDeposit = colDeposit
									Set sResident= colResident
									Set sName    = IifS(colName=STRING_Null, '-', StrWinToDosX(colName))
									Set sIdC     = IifS(colIdC=STRING_Null, '-', StrWinToDosX(colIdC))
									Set sBDate   = '01011900'
									Set sMname   = IifS(colMname=STRING_Null, '-', StrWinToDosX(colMname))
									Set sMt      = '0'
									Set bFl = SqlPrepareAndExecute(hSqlDbf,
											"INSERT INTO " || sFileName || "
											 VALUES (:sAccType, :sCurr, :sClientN, :nCondSet, :sType,
											   :sLacct, :sBrn, :nCrd, :sIdA, :sKk, :sWork, :sRegNr, 
											   :sPhone, :sCntry, :sPcode, :sCity, :sStreet, :sOffice,
											   :sPhoneW, :sCntryW, :sPcodeW, :sCityW, :sStreetW, 
											   :nMinBal, :nDeposit, :sResident, :sName, :sIdC, :sBDate, :sMname, :sMt)")
									If not bFl
										Break
									Set bFl = SqlPLSQLCommand(hSql(), "accreg.setAccountwParam(colAcc, 'PK_ODB', '1')")
									If not bFl
										Break
							If bFl
								Call SqlCommit(hSqlDbf)
								Call SqlCommit(hSql())
								Call SalMessageBox("Файл " || sFilePath || " сформовано", "Повідомлення", MB_IconAsterisk | MB_Ok)
							Else
								Call SqlRollback(hSqlDbf)
								Call SqlRollback(hSql())
							Call SqlDisconnect(hSqlDbf)
					Call SalWaitCursor(FALSE)
					Return TRUE
			Function: SetUnFormFlag
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
				Actions
					Set nRow = TBL_MinRow
					While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
						Call SalTblSetContext(hWndForm, nRow)
						If SqlPLSQLCommand(hSql(), "accreg.setAccountwParam(colAcc, 'PK_ODB', '')")
							Call SqlCommit(hSql())
						Else
							Call SqlRollback(hSql())
							Break
					Return TRUE
			Function: DeleteRows
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Number: nRow
				Actions
					Set nRow = TBL_MinRow
					While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
						Call SalTblSetContext(hWndForm, nRow)
						Call SalTblDeleteRow(hWndForm, nRow, TBL_NoAdjust)
						Set nRow = nRow - 1
					Return TRUE
		Window Parameters
		Window Variables
			Date/Time: dDat
			Boolean: bArc
			String: sSelect
			String: sWhere
			String: sOrder
			String: sWhereFromFilter
			Boolean: bErrRow
		Message Actions
			On SAM_Create
				Call PrepareWindowEx(hWndForm)
				Call SetWindowFullSize(hWndForm)
				Call SqlPrepareAndExecute(hSql(), "select max(fdat) into :hWndForm.tblFormOdbDbf.dDat from fdat where fdat < bankdate")
				Call SqlFetchNext(hSql(), nFetchRes)
				Call SalDisableWindow(pbUnForm)
				!
				Set hWndForm.tblFormOdbDbf.nFlags = GT_NoIns
				Set hWndForm.tblFormOdbDbf.strFilterTblName = "v_bpk_odb"
				Set hWndForm.tblFormOdbDbf.strPrintFileName = "bpk_odb"
				Set sSelect = "
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
				Set sWhere = " and flag_odb = 0"
				Set sOrder = " order by branch, client_n"
				Set hWndForm.tblFormOdbDbf.strSqlPopulate = sSelect || sWhere || sOrder
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On UM_Populate
				Set sWhereFromFilter = hWndForm.tblFormOdbDbf.cF.GetFilterWhereClause(FALSE)
				If sWhereFromFilter
					Call SalSetWindowText(hWndForm, "Формування odb*.dbf [Фільтр]")
				Else
					Call SalSetWindowText(hWndForm, "Формування odb*.dbf")
				If bArc
					Set sWhere = " and flag_odb = 0"
				Else
					Set sWhere = " and flag_odb = 1"
				Set hWndForm.tblFormOdbDbf.strSqlPopulate = sSelect || sWhere || 
						    IifS(sWhereFromFilter="", "", " and " || sWhereFromFilter) || sOrder
				Call hWndForm.tblFormOdbDbf.ReInitQueryString()
				Call SalSendClassMessage(UM_Populate, 0, 0)
			On SAM_FetchRowDone
				If SalIsNull(colCondSet)
					Call XSalTblSetCellBackColor(colCondSet, SalColorFromRGB(250, 170, 170))
				If SalIsNull(colIdA)
					Call XSalTblSetCellBackColor(colIdA, SalColorFromRGB(250, 170, 170))
				If SalIsNull(colKk)
					Call XSalTblSetCellBackColor(colKk, SalColorFromRGB(250, 170, 170))
				If SalIsNull(colWork)
					Call XSalTblSetCellBackColor(colWork, SalColorFromRGB(250, 170, 170))
				If SalIsNull(colPcode)
					Call XSalTblSetCellBackColor(colPcode, SalColorFromRGB(250, 170, 170))
				If SalIsNull(colCity)
					Call XSalTblSetCellBackColor(colCity, SalColorFromRGB(250, 170, 170))
				If SalIsNull(colStreet)
					Call XSalTblSetCellBackColor(colStreet, SalColorFromRGB(250, 170, 170))
				If SalIsNull(colOffice)
					Call XSalTblSetCellBackColor(colOffice, SalColorFromRGB(250, 170, 170))
				If SalIsNull(colName)
					Call XSalTblSetCellBackColor(colName, SalColorFromRGB(250, 170, 170))
				If SalIsNull(colMname)
					Call XSalTblSetCellBackColor(colMname, SalColorFromRGB(250, 170, 170))
			On SAM_DoubleClick
				If colAcc
					Call OperWithAccountEx(AVIEW_ALL, colAcc, colRnk, ACCESS_FULL, hWndForm, '')
			On UM_Delete
				If SalMessageBox("Видалити вибрані рахунки з вигрузки до odb*.dbf?", "Увага!", MB_IconQuestion | MB_YesNo) = IDYES
					Call DeleteRows()
	Table Window: tblReport
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: БПК. Звіт по рахунках
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
				Width:  12.0"
				Width Editable? Class Default
				Height: 6.0"
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
			Maximum Rows in Memory: 10000
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
					Resource Id: 43398
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
						On SAM_Create
							Set strTip = 'Параметри звіту'
						On SAM_Click
							If SalModalDialog(dlgReportParams, hWndForm, smParams, nNumParams)
								Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
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
					Resource Id: 43399
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
					Resource Id: 43400
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
			Column: colCountPk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Кількість
						карткових
						рахунків
				Visible? Yes
				Editable? Class Default
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
					On SAM_SetFocus
						Set nTmp = MyValue
					On SAM_AnyEdit
						Set MyValue = nTmp
						Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
					On SAM_DoubleClick
						Call ShowAccounts('acc_pk')
			Column: colCountOvr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Кількість
						кредитних
						рахунків
				Visible? Yes
				Editable? Class Default
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
					On SAM_SetFocus
						Set nTmp = MyValue
					On SAM_AnyEdit
						Set MyValue = nTmp
						Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
					On SAM_DoubleClick
						Call ShowAccounts('acc_ovr')
			Column: colCount9129
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Кількість
						рахунків
						9129
				Visible? Yes
				Editable? Class Default
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
					On SAM_SetFocus
						Set nTmp = MyValue
					On SAM_AnyEdit
						Set MyValue = nTmp
						Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
					On SAM_DoubleClick
						Call ShowAccounts('acc_9129')
			Column: colCount3570
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Кількість
						рахунків
						3570
				Visible? Yes
				Editable? Class Default
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
					On SAM_SetFocus
						Set nTmp = MyValue
					On SAM_AnyEdit
						Set MyValue = nTmp
						Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
					On SAM_DoubleClick
						Call ShowAccounts('acc_3570')
			Column: colCount2208
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Кількість
						рахунків
						2208
				Visible? Yes
				Editable? Class Default
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
					On SAM_SetFocus
						Set nTmp = MyValue
					On SAM_AnyEdit
						Set MyValue = nTmp
						Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
					On SAM_DoubleClick
						Call ShowAccounts('acc_2208')
			! cColumnLabeled: colCountTovr
.winattr class Column:
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Кількість
						рахунків
						техн.овердр.
				Visible? Yes
				Editable? Yes
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
.end
				   List Values 
				   Message Actions 
					   On SAM_SetFocus
						   Set nTmp = MyValue
					   On SAM_AnyEdit
						   Set MyValue = nTmp
						   Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
					   On SAM_DoubleClick
						   Call ShowAccounts('acc_tovr')
			Column: colCount2207
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Кількість
						рах.простр.
						2207
				Visible? Yes
				Editable? Class Default
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
					On SAM_SetFocus
						Set nTmp = MyValue
					On SAM_AnyEdit
						Set MyValue = nTmp
						Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
					On SAM_DoubleClick
						Call ShowAccounts('acc_2207')
			Column: colCount3579
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Кількість
						рах.простр.
						3579
				Visible? Yes
				Editable? Class Default
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
					On SAM_SetFocus
						Set nTmp = MyValue
					On SAM_AnyEdit
						Set MyValue = nTmp
						Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
					On SAM_DoubleClick
						Call ShowAccounts('acc_3579')
			Column: colCount2209
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Кількість
						рах.простр.
						2209
				Visible? Yes
				Editable? Class Default
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
					On SAM_SetFocus
						Set nTmp = MyValue
					On SAM_AnyEdit
						Set MyValue = nTmp
						Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
					On SAM_DoubleClick
						Call ShowAccounts('acc_2209')
		Functions
			Function: Populate
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Number: i
					String: sDecode
					String: sValue
					String: sSubValue
					String: sGrouping
					String: sRollup
					String: sInto
					String: strSelect
				Actions
					Call SalWaitCursor(TRUE)
					Call SalTblReset(hWndForm)
					Call HideColumns()
					Set sDecode   = ''
					Set sValue    = ''
					Set sSubValue = ''
					Set sGrouping = ''
					Set sRollup   = ''
					Set sInto     = ''
					Set nGrColId  = 0
					Set i = 0
					While i < nNumParams
						If i = 0
							Set sDecode = sDecode || "decode(gr_" || smParams[i,0] || ",1,'всього по банку',"
						Else
							Set sDecode = sDecode || "decode(gr_" || smParams[i,0] || ",1,'всього по '||" || smParams[i-1,0] || ","
						If i = nNumParams - 1
							Set sValue = sValue || sDecode || smParams[i,0] || SalStrRepeatX(')', i+1) || " txt, "
						Else
							Set sValue = sValue || smParams[i,0] || ", "
						Set sValue = sValue || "gr_" || smParams[i,0] || ", "
						!
						Set sSubValue = sSubValue || smParams[i,2] || " " || smParams[i,0] || ", "
						Set sGrouping = sGrouping || ", grouping(" || smParams[i,2] || ") gr_" || smParams[i,0] || ""
						Set sRollup   = sRollup   || IifS(sRollup='',"",", ") || smParams[i,2]
						!
						Call ApplyColumn(i*2+1, VisStrSubstitute(smParams[i,1], '~', PutCrLf()), TRUE, sInto)
						Call ApplyColumn(i*2+2, '', FALSE, sInto)
						!
						Set i = i + 1
					! Для раскраски итогов
					If nNumParams >= 1
						Set nAllBankColId = nNumPermColumns + 2
					If nNumParams >= 2
						Set nGrColId = nNumPermColumns + 4
					!
					Set sInto = sInto || IifS(sInto='',"",",") || " :hWndForm.tblReport.colCountPk, 
							     :hWndForm.tblReport.colCountOvr, :hWndForm.tblReport.colCount9129,
							    :hWndForm.tblReport.colCount3570, :hWndForm.tblReport.colCount2208,
							    :hWndForm.tblReport.colCount2207, :hWndForm.tblReport.colCount3579, :hWndForm.tblReport.colCount2209"
					!
						! Set strSelect = "
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
					Set strSelect = "
							select " || sValue || "
							       c_pk, c_ovr, c_9129, c_k, c_d, c_2207, c_3579, c_2209
							  into " || sInto || "
							  from (      
							select " || sSubValue || "
							       count(a.acc) c_pk, count(b.acc) c_ovr, count(n.acc) c_9129, count(k.acc) c_k, count(d.acc) c_d,
							       count(a2207.acc) c_2207, count(a3579.acc) c_3579, count(a2209.acc) c_2209 " || sGrouping || "
							  from " || sStrFrom  || "
							 where " || sStrWhere || IifS(sRollup='',"","group by rollup (" || sRollup || ")") || ")"
					! Call SaveInfoToLog(strSelect)
					Call SalTblPopulate(hWndForm, hSql(), strSelect, TBL_FillAll)
					Call VisTblAutoSizeColumn(hWndForm, hWndNULL)
					Call SalWaitCursor(FALSE)
					Return TRUE
			Function: CreateColumns
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
					Number: i
					Number: nColId
					Window Handle: hCol
				Actions
					Set nNumPermColumns = 8
					Set nNumAutoColumns = 0
					Call SqlPrepareAndExecute(hSql(), "select count(*) into :nNumAutoColumns from bpk_report_params")
					Call SqlFetchNext(hSql(), nFetchRes)
					Set nNumAutoColumns = nNumAutoColumns * 2
					Set i = 0 
					While i < nNumAutoColumns
						Set nColId = SalTblCreateColumn(hWndForm, i+1, 1.5, 100, '')
						Set hCol   = SalTblGetColumnWindow(hWndForm, nColId, COL_GetID)
						Call SalTblSetColumnFlags(hCol, COL_Editable, FALSE)
						Call SalHideWindow(hCol)
						Set i = i + 1
					Return TRUE
			Function: HideColumns
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
					Number: i
					Number: nColId
					Window Handle: hCol
				Actions
					Set i = 0 
					While i < nNumAutoColumns
						Set nColId = i + nNumPermColumns + 1
						Set hCol   = SalTblGetColumnWindow(hWndForm, nColId, COL_GetID)
						Call SalHideWindow(hCol)
						Set i = i + 1
					Return TRUE
			Function: ApplyColumn
				Description:
				Returns
				Parameters
					Number: nId
					String: sTitle
					Boolean: bVisible
					Receive String: sInto
				Static Variables
				Local variables
					Number: nColId
					Window Handle: hCol
				Actions
					Set nColId = nId + nNumPermColumns
					Set hCol   = SalTblGetColumnWindow(hWndForm, nColId, COL_GetID)
					Call SalTblSetColumnTitle(hCol, sTitle)
					If bVisible
						Call SalShowWindow(hCol)
					Set sInto = sInto || IifS(sInto='',"",",") || ":hWndForm.tblReport#" || Str(nColId)
					Return TRUE
			Function: ShowAccounts
				Description:
				Returns
					Boolean:
				Parameters
					String: sAcc
				Static Variables
				Local variables
					String: sFilter
					String: sWhere
					Number: i
					String: sText
					Number: nColId
				Actions
					Set sWhere = ''
					Set i = 0
					While i < nNumParams
						Set nColId = nNumPermColumns+i*2+1
						Call SalTblGetColumnText(hWndForm, nColId+1, sText)
						If sText = '0'
							Call SalTblGetColumnText(hWndForm, nColId, sText)
							If smParams[i,3] = 'N'
								Set sWhere = sWhere || " and " || smParams[i,2] || IifS(sText='', " is null", "=" || sText)
							Else
								Set sWhere = sWhere || " and " || smParams[i,2] || IifS(sText='', " is null", "='" || sText || "'")
						Set i = i + 1
					!
					Set sFilter = "a.acc in (select " || sAcc || " from (
							select o.acc_pk, o.acc_ovr, o.acc_9129, o.acc_3570, o.acc_2208, o.acc_2207, o.acc_3579, o.acc_2209      
							  from " || sStrFrom  || "
							 where " || sStrWhere || sWhere || "))"
					! Call SaveInfoToLog(sFilter)
					Call ShowAccList(0, AVIEW_ALL, AVIEW_Financial | AVIEW_Special, sFilter)
					Return TRUE
		Window Parameters
		Window Variables
			Number: nNumPermColumns	! количество постоянных колонок
			Number: nNumAutoColumns	! количество созданных колонок
			String: sParams
			String: smParams[*,4]
			Number: nNumParams
			Number: nGrColId
			Number: nAllBankColId
			String: strColText
			!
			Number: nTmp
			String: sStrFrom
			String: sStrWhere
		Message Actions
			On SAM_Create
				Call PrepareWindowEx(hWndForm)
				Set hWndForm.tblReport.strPrintFileName = 'bpk_report'
				Set hWndForm.tblReport.nFlags = GT_ReadOnly
				Call CreateColumns()
				Set sStrFrom  = 
						      "bpk_all_accounts o, accounts a, accounts b, accounts n, 
						       accounts k, accounts d, accounts a2207, accounts a3579, accounts a2209,
						       customer c, specparam s, specparam_int i, specparam_int bi"
				Set sStrWhere = 
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
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On SAM_CreateComplete
				Call SalSendMsg(pbDetails, SAM_Click, 0, 0)
			On UM_Populate
				Call Populate()
			On SAM_FetchRowDone
				If nGrColId
					Call SalTblGetColumnText(hWndForm, nGrColId, strColText)
					If strColText = '1'
						Call XSalTblSetRowBackColor(hWndForm, lParam, COLOR_LightGray)
				If nAllBankColId
					Call SalTblGetColumnText(hWndForm, nAllBankColId, strColText)
					If strColText = '1'
						Call XSalTblSetRowBackColor(hWndForm, lParam, COLOR_Gray)
	Dialog Box: dlgReportParams
		Class:
		Property Template:
		Class DLL Name:
		Title: Параметри звіту
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  9.7"
				Width Editable? Yes
				Height: 4.5"
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
			Frame
				Resource Id: 43403
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    0.05"
					Width:  9.4"
					Width Editable? Yes
					Height: 3.35"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Border Color: Default
				Background Color: Default
			Background Text: Всі параметри
				Resource Id: 43404
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    0.1"
					Width:  3.733"
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
			Child Table: tblAllParams
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Display Settings
					Window Location and Size
						Left:   0.2"
						Top:    0.3"
						Width:  3.8"
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
					Maximum Rows in Memory: Default
					Discardable? Yes
				Contents
					Column: colCode
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title:
						Visible? No
						Editable? Class Default
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
					Column: colName
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Назва параметру
						Visible? No
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
					Column: colSrc
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title:
						Visible? No
						Editable? Class Default
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
					Column: colType
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title:
						Visible? No
						Editable? Class Default
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
					Column: colParam
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Назва параметру
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
				Functions
					Function: Populate
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							Number: nRow
							String: sCode
							String: sName
							String: sSrc
							String: sType
						Actions
							Set nRow = 0
							Call SqlPrepareAndExecute(hSql(), 
									"select code, name, src, type
									   into :sCode, :sName, :sSrc, :sType
									   from bpk_report_params
									  order by name")
							While SqlFetchNext(hSql(), nFetchRes)
								If not FindParam(sCode) 
									Call SalTblInsertRow(hWndForm, nRow)
									Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
									Set colCode = sCode
									Set colName = sName
									Set colParam = VisStrSubstitute(sName,'~',' ')
									Set colSrc  = sSrc
									Set colType = sType
									Set nRow = nRow + 1
							Call SalSetFocus(hWndForm)
							Call SalTblSetFocusRow(hWndForm, 0)
							Call SalTblSetContext(hWndForm, 0)
							Return TRUE
					Function: FindParam
						Description:
						Returns
							Boolean:
						Parameters
							String: sParamCode
						Static Variables
						Local variables
							Boolean: bFind
							Number: i
						Actions
							Set bFind = FALSE
							Set i = 0
							While i < nNumParams
								If smParams[i,0] = sParamCode
									Set bFind = TRUE
									Break
								Set i = i + 1
							Return bFind
				Window Variables
				Message Actions
					On SAM_Create
						Call SalTblSetTableFlags(hWndForm, TBL_Flag_SingleSelection, TRUE)
						Call Populate()
					On SAM_DoubleClick
						Call SalSendMsg(pbAdd, SAM_Click, 0, 0)
			Pushbutton: pbAdd
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbInsert
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   4.2"
					Top:    0.6"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name: \BARS98\RESOURCE\BMP\Arr2tor.bmp
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						Call AddParam()
			Pushbutton: pbDel
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbDelete
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   4.2"
					Top:    0.95"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name: \BARS98\RESOURCE\BMP\Arr2tol.bmp
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						Call DelParam()
			Background Text: Параметри звіту
				Resource Id: 43405
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.9"
					Top:    0.1"
					Width:  3.733"
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
			Child Table: tblSetParams
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Display Settings
					Window Location and Size
						Left:   4.9"
						Top:    0.3"
						Width:  3.8"
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
					Maximum Rows in Memory: Default
					Discardable? Yes
				Contents
					Column: colCode
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title:
						Visible? No
						Editable? Class Default
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
					Column: colName
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Назва параметру
						Visible? No
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
					Column: colSrc
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title:
						Visible? No
						Editable? Class Default
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
					Column: colType
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title:
						Visible? No
						Editable? Class Default
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
					Column: colParam
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Назва параметру
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
				Functions
					Function: Populate
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							Number: nRow
						Actions
							Set nRow = 0
							While nRow < nNumParams
								Call SalTblInsertRow(hWndForm, nRow)
								Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
								Set colCode = smParams[nRow,0]
								Set colName = smParams[nRow,1]
								Set colParam = VisStrSubstitute(smParams[nRow,1],'~',' ')
								Set colSrc  = smParams[nRow,2]
								Set colType = smParams[nRow,3]
								Set nRow = nRow + 1
							Set nTblRow = nRow
							Call SalSetFocus(hWndForm)
							Call SalTblSetFocusRow(hWndForm, 0)
							Call SalTblSetContext(hWndForm, 0)
							Return TRUE
					Function: Up
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							Number: nRow
							String: sCode1
							String: sName1
							String: sSrc1
							String: sType1
							String: sParam1
							String: sCode2
							String: sName2
							String: sSrc2
							String: sType2
							String: sParam2
						Actions
							Set nRow = SalTblQueryContext(hWndForm)
							If nRow > 0
								If colCode
									Set sCode1 = colCode
									Set sName1 = colName
									Set sSrc1  = colSrc
									Set sType1 = colType
									Set sParam1 = colParam
									Call SalTblSetContext(hWndForm, nRow-1)
									Set sCode2 = colCode
									Set sName2 = colName
									Set sSrc2  = colSrc
									Set sType2 = colType
									Set sParam2 = colParam
									Set colCode = sCode1
									Set colName = sName1
									Set colSrc  = sSrc1
									Set colType = sType1
									Set colParam = sParam1
									Call SalTblSetContext(hWndForm, nRow)
									Set colCode = sCode2
									Set colName = sName2
									Set colSrc  = sSrc2
									Set colType = sType2
									Set colParam = sParam2
									Call SalTblSetRowFlags(hWndForm, nRow, ROW_Selected, FALSE)
									Call SalSetFocus(hWndForm)
									Call SalTblSetFocusRow(hWndForm, nRow-1)
									Call SalTblSetRowFlags(hWndForm, nRow-1, ROW_Selected, TRUE)
									Call SalTblSetContext(hWndForm, nRow-1)
							Return TRUE
					Function: Down
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							Number: nRow
							String: sCode1
							String: sName1
							String: sSrc1
							String: sType1
							String: sParam1
							String: sCode2
							String: sName2
							String: sSrc2
							String: sType2
							String: sParam2
						Actions
							Set nRow = SalTblQueryContext(hWndForm)
							If nRow < nTblRow-1
								If colCode
									Set sCode2 = colCode
									Set sName2 = colName
									Set sSrc2  = colSrc
									Set sType2 = colType
									Set sParam2 = colParam
									Call SalTblSetContext(hWndForm, nRow+1)
									Set sCode1 = colCode
									Set sName1 = colName
									Set sSrc1  = colSrc
									Set sType1 = colType
									Set sParam1 = colParam
									Set colCode = sCode2
									Set colName = sName2
									Set colSrc  = sSrc2
									Set colType = sType2
									Set colParam = sParam2
									Call SalTblSetContext(hWndForm, nRow)
									Set colCode = sCode1
									Set colName = sName1
									Set colSrc  = sSrc1
									Set colType = sType1
									Set colParam = sParam1
									Call SalTblSetRowFlags(hWndForm, nRow, ROW_Selected, FALSE)
									Call SalSetFocus(hWndForm)
									Call SalTblSetFocusRow(hWndForm, nRow+1)
									Call SalTblSetRowFlags(hWndForm, nRow+1, ROW_Selected, TRUE)
									Call SalTblSetContext(hWndForm, nRow+1)
							Return TRUE
					Function: getParams
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							Number: nRow
						Actions
							Set nNumParams = 0
							Set nRow = TBL_MinRow
							While SalTblFindNextRow(hWndForm, nRow, 0, 0)
								Call SalTblSetContext(hWndForm, nRow)
								Set smParams[nNumParams,0] = colCode
								Set smParams[nNumParams,1] = colName
								Set smParams[nNumParams,2] = colSrc
								Set smParams[nNumParams,3] = colType
								Set nNumParams = nNumParams + 1
							Return TRUE
				Window Variables
				Message Actions
					On SAM_Create
						Call SalTblSetTableFlags(hWndForm, TBL_Flag_SingleSelection, TRUE)
						Call Populate()
					On SAM_DoubleClick
						Call SalSendMsg(pbDel, SAM_Click, 0, 0)
			Pushbutton: pbUp
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbSort
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   8.9"
					Top:    0.6"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name: \BARS98\RESOURCE\BMP\Arr2tou.bmp
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						Call tblSetParams.Up()
			Pushbutton: pbDown
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbSort
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   8.9"
					Top:    0.95"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name: \BARS98\RESOURCE\BMP\ARR2TOD.BMP
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						Call tblSetParams.Down()
			Frame
				Resource Id: 43406
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    3.45"
					Width:  9.4"
					Width Editable? Yes
					Height: 0.7"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Border Color: Default
				Background Color: Default
			Pushbutton: pbRefresh
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbRefresh
				Property Template:
				Class DLL Name:
				Title: Поновити
				Window Location and Size
					Left:   0.2"
					Top:    3.548"
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
						Call SalTblReset(tblAllParams)
						Call SalTblReset(tblSetParams)
						Set nNumParams = 0
						Call tblAllParams.Populate()
			Pushbutton: pbOk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbOk
				Property Template:
				Class DLL Name:
				Title: Застосувати
				Window Location and Size
					Left:   6.1"
					Top:    3.548"
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
						Call tblSetParams.getParams()
						Call SalEndDialog(hWndForm, TRUE)
			Pushbutton: pbCancel
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title: Відмінити
				Window Location and Size
					Left:   7.5"
					Top:    3.55"
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
			Function: AddParam
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Number: nRow
				Actions
					If tblAllParams.colCode
						Set nRow = SalTblInsertRow(tblSetParams, TBL_MaxRow)
						Call SalTblSetRowFlags(tblSetParams, nRow, ROW_New, FALSE)
						Set tblSetParams.colCode = tblAllParams.colCode
						Set tblSetParams.colName = tblAllParams.colName
						Set tblSetParams.colSrc  = tblAllParams.colSrc
						Set tblSetParams.colType = tblAllParams.colType
						Set tblSetParams.colParam = tblAllParams.colParam
						Set nTblRow = nTblRow + 1
						Call SalTblDeleteRow(tblAllParams, SalTblQueryContext(tblAllParams), TBL_NoAdjust)
					Return TRUE
			Function: DelParam
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Number: nRow
				Actions
					If tblSetParams.colCode
						Set nRow = SalTblInsertRow(tblAllParams, TBL_MaxRow)
						Call SalTblSetRowFlags(tblAllParams, nRow, ROW_New, FALSE)
						Set tblAllParams.colCode = tblSetParams.colCode
						Set tblAllParams.colName = tblSetParams.colName
						Set tblAllParams.colSrc  = tblSetParams.colSrc
						Set tblAllParams.colType = tblSetParams.colType
						Set tblAllParams.colParam = tblSetParams.colParam
						Set nTblRow = nTblRow - 1
						Call SalTblDeleteRow(tblSetParams, SalTblQueryContext(tblSetParams), TBL_NoAdjust)
					Return TRUE
		Window Parameters
			Receive String: smParams[*,4]
			Receive Number: nNumParams
		Window Variables
			Number: nTblRow
		Message Actions
			On SAM_Create
				Call PrepareWindowEx(hWndForm)
	Table Window: XM3
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Прийом та обробка XML-файла "Зарахування з/п на БПК"
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
				Width:  14.433"
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
				Size: 0.488"
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
						Left:   0.983"
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
					Resource Id: 42069
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? No
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
						Left:   1.683"
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
						Left:   2.383"
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
						Left:   3.083"
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
					Resource Id: 42070
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? No
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
						Left:   4.483"
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
					Resource Id: 42071
					Class Child Ref Key: 43
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? No
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pb_InsF
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbExecute
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.783"
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
					Picture File Name: \bars98\RESOURCE\BMP\DOC_IN.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Light Green
					Message Actions
						On SAM_Create
							Set strTip = 'Прийом та обробка XML-файла "Зарахування з/п на БПК"'
						On SAM_Click
							If not SalIsNull( ACC )
								Call Ins_File( strTip)
		Contents
			Column: BRANCH
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Бранч
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 160
				Data Type: String
				Justify: Left
				Width:  2.167"
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
			Column: OB22
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						Об22
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  0.65"
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
			Column: KV
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						Вал
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
				Data Type: Number
				Justify: Right
				Width:  0.533"
				Width Editable? Yes
				Format: #0
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
			Column: NLS
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Рахунок
						Дебет
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 14
				Data Type: String
				Justify: Left
				Width:  1.617"
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
			Column: NMS
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Назва
						Рахунку Дебет
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 38
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
			Column: OKPO
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ід.код
						Дебет
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 14
				Data Type: String
				Justify: Left
				Width:  1.617"
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
			Column: OSTC
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Залишок
						Фактичний
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  2.217"
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
			Column: OSTB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Залишок
						Плановий
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  2.133"
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
			!
			Column: ACC
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ACC
				Visible? No
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
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
		Functions
			Function: Ins_File
				Description:
				Returns
				Parameters
					String: sTxt1
				Static Variables
				Local variables
					String: strFilters[*]
					Number: nIndex
					String: strFileName
					String: sSPECIFIC
					String: sTxt
				Actions
					Set strFilters[0] = sTxt1
					!
					Set strFilters[1] = '*.xml'
					Set nIndex = 1
					If not SalDlgOpenFile ( hWndForm, 'Вибір файлу зарахувань з/п на БПК', strFilters, 2, nIndex, strFileName, sSPECIFIC )
						Return FALSE
					! Наташина функция по загрузке файла во врем таблицу
					Set sTxt = 'Виконано ' || sTxt1 || ' ' || strFileName
					Call SalWaitCursor(TRUE)
					If PutFileToTmpLob( hSql(), strFileName, 'C')
						! If SqlPLSQLCommand( hSql(), "XM3 ( KV, NLS, NMS, OKPO, strFileName ) " )
							      Call SqlCommitEx( hSql(),sTxt )
							!
							      Call SalWaitCursor(FALSE)
							      Call MessageNoWait( sTxt, 'Добрі новини',10,0)
							      Return TRUE
						If SqlPLSQLCommand( hSql(), "obpc.pay_xml_file ( ACC, strFileName ) " )
							Call SqlCommitEx( hSql(),sTxt )
							!
							Call SalWaitCursor(FALSE)
							Call MessageNoWait( sTxt, 'Добрі новини',10,0)
							Return TRUE
					Else
						Call SalWaitCursor(FALSE)
						Call MessageNoWait('HE ' || sTxt, 'У В А Г А, погані новини ! ', 5, 1)
						Return FALSE
		Window Parameters
			Number: nMode
			Number: nPar
			String: strPar01
			String: strPar02
		Window Variables
			Date/Time: dDat
			Number: n980
			String: aMfo
			String: aOkpo
		Message Actions
			On SAM_Create
				Set dDat = GetBankDate()
				Set n980 = GetBaseVal()
				Set aMfo = GetBankMfo()
				Set aOkpo= GetBankOkpoS()
				Set XM3.strFilterTblName = 'ACCOUNTS'
				Set XM3.strSqlPopulate =
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
				!
				! Call PrepareWindow( hWndForm )
				! Call SetWindowFullSize(hWndForm)
				! Call SalTblSetLockedColumns( hWndForm, 5 )
				!
				Call SalSendClassMessage( SAM_Create, 0, 0 )
			! On SAM_FetchRowDone
			On SAM_DoubleClick
				If not SalIsNull(ACC)
					Call ShowAccList ( NUMBER_Null, AVIEW_ALL, AVIEW_ReadOnly | AVIEW_AllOptions,
							" a.acc = " || Str(ACC)  )
	Form Window: frmImpProect
		Class:
		Property Template:
		Class DLL Name:
		Title: Імпорт проектів на відкриття договорів БПК
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
				Width:  13.75"
				Width Editable? Yes
				Height: 7.4"
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
										Call CreateDeal(nId)
									Else
										Call SalMessageBox("Залишились тільки рядки з помилками!", "Інформація", MB_IconAsterisk | MB_Ok)
								Else
									Call SalMessageBox("Немає необроблених рядків!", "Інформація", MB_IconAsterisk | MB_Ok)
				Line
					Resource Id: 44422
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
				Resource Id: 30126
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    0.05"
					Width:  4.73"
					Width Editable? Yes
					Height: 3.1"
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
					Top:    0.3"
					Width:  4.4"
					Width Editable? Yes
					Height: 0.298"
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
							Call ImportFile(dfFileName)
			Pushbutton: pbSelect
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Вибрати файл з імпортованих
				Window Location and Size
					Left:   0.2"
					Top:    0.7"
					Width:  4.4"
					Width Editable? Yes
					Height: 0.298"
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
						If FunNSIGetFiltered("v_bpk_imp_proect_files", "file_name", "", sPK, sSem)
							Set nId = Val(sPK)
							Call SelectFile(nId)
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
						Top:    1.2"
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
				Resource Id: 30127
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    1.55"
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
						Top:    1.5"
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
				Resource Id: 30128
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    1.85"
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
						Top:    1.8"
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
				Resource Id: 30129
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    2.15"
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
						Top:    2.1"
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
				Resource Id: 31719
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    2.45"
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
						Top:    2.4"
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
			Background Text: Код філії
				Resource Id: 57789
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.9"
					Top:    0.35"
					Width:  1.2"
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
			Data Field: dfFCode
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 5
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   6.2"
						Top:    0.3"
						Width:  1.0"
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
						Left:   7.3"
						Top:    0.298"
						Width:  5.5"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? No
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
			Data Field: dfFName
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
						Left:   7.3"
						Top:    0.3"
						Width:  5.5"
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
			Pushbutton: pbFiliales
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbFilter
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   12.9"
					Top:    0.226"
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
						Set strTip = 'Філія'
					On SAM_Click
						If FunNSIGet("v_bpk_branch_filiales", "branch_name", sPK, sSem)
							Set dfBranch = sPK
							Call GetFilial(dfBranch)
			!
			Background Text: Відповідальний виконавець
				Resource Id: 57790
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.9"
					Top:    0.65"
					Width:  3.0"
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
						Left:   8.2"
						Top:    0.6"
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
						Left:   9.3"
						Top:    0.6"
						Width:  3.5"
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
					Top:    0.57"
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
						If FunNSIGetFiltered("staff", "fio", "type=1 and active=1 " || IifS(dfBranch!='', "and branch='" || dfBranch || "'", "") || " ORDER BY fio", sPK, sSem)
							Set dfIspCode = Val(sPK)
							Call GetIsp(dfIspCode)
			!
			Group Box: Картка
				Resource Id: 30134
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.8"
					Top:    0.05"
					Width:  8.7"
					Width Editable? Yes
					Height: 3.1"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: 3D Shadow Color
				Background Color: Default
			Background Text: Продукт
				Resource Id: 30135
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.9"
					Top:    0.95"
					Width:  1.2"
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
			Data Field: dfPCode
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
						Left:   6.2"
						Top:    0.9"
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
			Data Field: dfPName
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
						Left:   7.3"
						Top:    0.9"
						Width:  5.5"
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
			Pushbutton: pbProduct
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbFilter
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   12.9"
					Top:    0.905"
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
						! If FunNSIGetFiltered("v_bpk_product", "name", 
								"v_bpk_product.kv=" || IifS(rbUAH=TRUE, "980", "840") || 
								" and custtype = "  || Str(hWndParent.frmCard.nCType) || 
								IifS(sAccType='-', "", " and v_bpk_product.type='" || sAccType || "'") ||
								IifS(dfKCode ='-', "", " and v_bpk_product.kk='"   || dfKCode  || "'"), sPK, sSem)
							    Set dfPCode = Val(sPK)
							    Set dfPName = sSem
							    Call GetProduct()
						If FunNSIGetFiltered("v_bpk_product", "name", "v_bpk_product.kv=980 and custtype = 1", sPK, sSem)
							Set dfPCode = Val(sPK)
							Call GetProduct(dfPCode)
			Background Text: ОБ22
				Resource Id: 30136
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.9"
					Top:    1.25"
					Width:  1.2"
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
						Left:   6.2"
						Top:    1.2"
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
			Data Field: dfOb22Name
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
						Left:   7.3"
						Top:    1.2"
						Width:  5.5"
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
			Background Text: Код умови рахунку
				Resource Id: 30137
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.9"
					Top:    1.55"
					Width:  4.3"
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
			Data Field: dfCCode
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 4
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   9.3"
						Top:    1.5"
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
			Data Field: dfCName
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
						Left:   10.4"
						Top:    1.5"
						Width:  2.4"
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
			Background Text: Тривалість строку дії картки (в місяцях)
				Resource Id: 30130
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.9"
					Top:    1.85"
					Width:  4.3"
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
			Data Field: dfCValid
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
						Left:   9.3"
						Top:    1.8"
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
			Background Text: Вартість користування кредитом
				Resource Id: 30133
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.9"
					Top:    2.15"
					Width:  4.3"
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
			Data Field: dfDebIntr
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
						Left:   9.3"
						Top:    2.1"
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
			Background Text: Стягнення за овердрафт
				Resource Id: 30132
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.9"
					Top:    2.45"
					Width:  4.3"
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
			Data Field: dfOlimIntr
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
						Left:   9.3"
						Top:    2.4"
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
			Background Text: Відсоток на залишок по рахунку
				Resource Id: 30131
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.9"
					Top:    2.75"
					Width:  4.3"
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
			Data Field: dfCredIntr
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
						Left:   9.3"
						Top:    2.7"
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
						Top:    3.2"
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
					Column: colName
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: ПІБ
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
					Column: colWPlace
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
					Column: colWOffice
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
					Column: colWPhone
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Телефон
								місця
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
					Column: colWPcode
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Почт.інд.
								місця
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
					Column: colWCity
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Місто
								місця
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
					Column: colWStreet
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Вулиця
								місця
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
				Functions
				Window Variables
				Message Actions
					On UM_Populate
						Call SalWaitCursor(TRUE)
						Set dfAllRows  = 0
						Set dfGoodRows = 0
						Set dfBadRows  = 0
						Set dfErrRows  = 0
						Call SalTblPopulate(hWndForm, hSql(),
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
						Call SalWaitCursor(FALSE)
					On SAM_FetchRowDone
						Set dfAllRows  = dfAllRows  + 1
						If colRnk
							Set dfGoodRows = dfGoodRows + 1
							Set colStrErr  = "Оброблено"
							Call XSalTblSetRowBackColor(hWndForm, lParam, SalColorFromRGB(230,255,230)) ! светло-зеленый
						Else
							Set dfBadRows  = dfBadRows  + 1
							If SalIsNull(colName)
								Call XSalTblSetCellBackColor(colName, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colOkpo)
								Call XSalTblSetCellBackColor(colOkpo, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colAdrStreet)
								Call XSalTblSetCellBackColor(colAdrStreet, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colPasspSer)
								Call XSalTblSetCellBackColor(colPasspSer, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colPasspNumdoc)
								Call XSalTblSetCellBackColor(colPasspNumdoc, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colPasspOrgan)
								Call XSalTblSetCellBackColor(colPasspOrgan, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colPasspDate)
								Call XSalTblSetCellBackColor(colPasspDate, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colBDay)
								Call XSalTblSetCellBackColor(colBDay, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colBPlace)
								Call XSalTblSetCellBackColor(colBPlace, SalColorFromRGB(250, 170, 170))
							If SalIsNull(colMName)
								Call XSalTblSetCellBackColor(colMName, SalColorFromRGB(250, 170, 170))
							If colStrErr
								Call XSalTblSetCellBackColor(colStrErr, SalColorFromRGB(250, 170, 170))
								Set dfErrRows = dfErrRows + 1
					On UM_Print
						Call TablePrint(hWndForm, 'Файл ' || dfFileName, GetPrnDir() || '\\' || 'bpk_impfile', '')
		Functions
			Function: ImportFile
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
					Number: nCount
					String: sErrMsg
					Number: nFileId
				Actions
					Call SalWaitCursor(TRUE)
					Call VisDosSplitPath(sPatch, sDrive, sDir, sFile, sExt)
					Set sFilePath = sDrive || sDir
					Set sFileName = sFile || sExt
					Call SqlPrepareAndExecute(hSql(), "select count(*) into :nCount from bpk_imp_proect_files where file_name = :sFileName")
					Call SqlFetchNext(hSql(), nFetchRes)
					If nCount
						If SalMessageBox("Файл " || sFileName || " вже оброблявся." || PutCrLf() || 
								   "Імпортувати файл ще раз?", "Увага", MB_IconExclamation | MB_YesNo) = IDNO
							Set dfFileName = ''
							Call SalWaitCursor(FALSE)
							Return FALSE
					If not ImportUseMomory(sFilePath, sFileName, 'TEST_BPK_IMPPROECT', 'UKG', 1, sErrMsg)
						Call SalWaitCursor(FALSE)
						Set dfFileName = ''
						Call SalMessageBox("Помилка імпорту файла " || sFileName || ': ' || sErrMsg,
								     "Помилка", MB_Ok | MB_IconStop )
						Call SaveInfoToLog("OBPC. " || "Помилка імпору файла " || sFileName || ': ' || sErrMsg)
						Return FALSE 
					If not SqlPLSQLCommand(hSql(), "bars_bpk.imp_proect(sFileName, nFileId)")
						Call SqlRollback(hSql())
						Set dfFileName = ''
						Call SalWaitCursor(FALSE)
						Return FALSE
					Call SqlCommit(hSql())
					Call SalEnableWindow(pbFiliales)
					Call SalEnableWindow(pbIsp)
					Call SalEnableWindow(pbProduct)
					Set nId = nFileId
					Call SalSendMsg(tblImp, UM_Populate, 0, 0)
					Call SalWaitCursor(FALSE)
					Return TRUE
			Function: SelectFile
				Description:
				Returns
					Boolean:
				Parameters
					Number: nFileId
				Static Variables
				Local variables
				Actions
					Call SalWaitCursor(TRUE)
					Call SqlPrepareAndExecute(hSql(), 
							"select file_name, product_id into :dfFileName, :dfPCode
							   from bpk_imp_proect_files
							  where id = :nFileId")
					Call SqlFetchNext(hSql(), nFetchRes)
					Call GetFileData(nFileId)
					If dfPCode
						Call SalDisableWindow(pbFiliales)
						Call SalDisableWindow(pbIsp)
						Call SalDisableWindow(pbProduct)
					Else
						Call SalEnableWindow(pbFiliales)
						Call SalEnableWindow(pbIsp)
						Call SalEnableWindow(pbProduct)
						Set dfFName = STRING_Null
						Set dfIspName = STRING_Null
						Set dfPName = STRING_Null
						Set dfOb22 = STRING_Null
						Set dfOb22Name = STRING_Null
						Set dfCCode = NUMBER_Null
						Set dfCName = STRING_Null
						Set dfCValid = NUMBER_Null
						Set dfDebIntr = NUMBER_Null
						Set dfOlimIntr = NUMBER_Null
						Set dfCredIntr = NUMBER_Null
					Set nId = nFileId
					Call SalSendMsg(tblImp, UM_Populate, 0, 0)
					Call SalWaitCursor(FALSE)
					Return TRUE
			Function: Clear
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
				Actions
					Set dfFileName = ''
					Set dfAllRows  = NUMBER_Null
					Set dfGoodRows = NUMBER_Null
					Set dfBadRows  = NUMBER_Null
					Set dfErrRows  = NUMBER_Null
					Call SalTblReset(tblImp)
					Return TRUE
			Function: GetFileData
				Description:
				Returns
					Boolean:
				Parameters
					Number: nFileId
				Static Variables
				Local variables
				Actions
					Call SqlPrepareAndExecute(hSql(),
							"select branch, filial, isp, product_id
							   into :dfBranch, :dfFCode, :dfIspCode, :dfPCode
							   from bpk_imp_proect_files
							  where id = :nFileId")
					Call SqlFetchNext(hSql(), nFetchRes)
					Call GetFilial(dfBranch)
					Call GetIsp(dfIspCode)
					Call GetProduct(dfPCode)
					Return TRUE
			Function: GetFilial
				Description:
				Returns
					Boolean:
				Parameters
					String: sBranch
				Static Variables
				Local variables
				Actions
					If not SqlPrepareAndExecute(hSql(),
							"select code, name
							   into :dfFCode, :dfFName
							   from v_bpk_branch_filiales
							  where branch = :sBranch")
						Return FALSE
					If not SqlFetchNext(hSql(), nFetchRes)
						Return FALSE
					Return TRUE
			Function: GetIsp
				Description:
				Returns
					Boolean:
				Parameters
					Number: nIsp
				Static Variables
				Local variables
				Actions
					If not SqlPrepareAndExecute(hSql(),
							"select fio
							   into :dfIspName
							   from staff$base
							  where id = :nIsp")
						Return FALSE
					If not SqlFetchNext(hSql(), nFetchRes)
						Return FALSE
					Return TRUE
			Function: GetProduct
				Description:
				Returns
					Boolean:
				Parameters
					Number: nProductId
				Static Variables
				Local variables
				Actions
					If not dfPCode
						Return FALSE
					If not SqlPrepareAndExecute(hSql(),
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
						Return FALSE
					If not SqlFetchNext(hSql(), nFetchRes)
						Return FALSE
					Return TRUE
			Function: CreateDeal
				Description:
				Returns
					Boolean:
				Parameters
					Number: nFileId
				Static Variables
				Local variables
				Actions
					If not dfFCode
						Call SalMessageBox("Не вказано код філії!", "Увага!", MB_IconExclamation | MB_Ok)
						Return FALSE
					If not dfIspCode
						Call SalMessageBox("Не вказано відповідального виконавця!", "Увага!", MB_IconExclamation | MB_Ok)
						Return FALSE
					If not dfPCode
						Call SalMessageBox("Не вказано продукт БПК!", "Увага!", MB_IconExclamation | MB_Ok)
						Return FALSE
					Call SalWaitCursor(TRUE)
					If not SqlPLSQLCommand(hSql(), "bars_bpk.create_deal(nFileId, dfPCode, dfFCode, dfBranch, dfIspCode)")
						Call SqlRollbackEx(hSql(), "")
						Call SalWaitCursor(FALSE)
						Return FALSE
					Call SalMessageBox("Відкрито угоди по файлу " || dfFileName, "Інформація", MB_IconAsterisk | MB_Ok)
					Call SqlCommitEx(hSql(), "")
					Call SalSendMsg(tblImp, UM_Populate, 0, 0)
					Call SalWaitCursor(FALSE)
					Return TRUE
		Window Parameters
		Window Variables
			String: strFilters[2]
			Number: nIndex
			String: strFile
			String: dfPath
			String: sPK
			String: sSem
			Number: nId
		Message Actions
			On SAM_Create
				Call PrepareWindowEx(hWndForm)
				Set strFilters[0] = 'Dbf-файли'
				Set strFilters[1] = '*.dbf'
				Call SalSetFocus(pbCancel)
	Form Window: frmImportAcct
		Class:
		Property Template:
		Class DLL Name:
		Title: Імпорт файлу рахунків ACCT*.dbf
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
				Width:  6.35"
				Width Editable? Yes
				Height: 2.0"
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
				Resource Id: 46895
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
			Frame
				Resource Id: 46896
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
					Left:   3.5"
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
						If IDYES = SalMessageBox("Виконати імпорт файлу рахунків?", "Увага!", MB_IconQuestion | MB_YesNo)
							Call SalWaitCursor(TRUE)
							Call ImportAcct(dfFileName)
						Call SalWaitCursor(FALSE)
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
		Functions
			Function: ImportAcct
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
				Actions
					Call VisDosSplitPath(sPatch, sDrive, sDir, sFile, sExt)
					Set sFilePath = sDrive || sDir
					Set sFileName = sFile || sExt
					! Импорт во временную таблицу
					If not ImportUseMomory(sFilePath, sFileName, 'TEST_OBPC_ACCT_IMP', 'UKG', 1, sErrMsg)
						Call SalWaitCursor(FALSE)
						Call SalMessageBox("Помилка-1 імпорту файла " || sFileName || ': ' || sErrMsg,
								     "Помилка", MB_Ok | MB_IconStop)
						Call SaveInfoToLog("OBPC. " || "Помилка-1 імпору файла " || sFileName || ': ' || sErrMsg)
						Return FALSE 
					If not SqlPLSQLCommand(hSql(), "obpc.imp_acct(1)")
						Call SqlRollback(hSql())
						Call SalMessageBox("Помилка-2 імпорту файла " || sFileName || ': ' || sErrMsg,
								     "Помилка", MB_Ok | MB_IconStop)
						Call SaveInfoToLog("OBPC. " || "Помилка-2 імпору файла " || sFileName || ': ' || sErrMsg)
						Return FALSE
					Call SalMessageBox("Файл успішно імпортовано", "Інформація", MB_Ok | MB_IconAsterisk)
					Call SaveInfoToLog("OBPC. Імпортовано повний файл рахунків " || sFileName)
					Call SqlCommit(hSql())
					Return TRUE
		Window Parameters
		Window Variables
			String: strFilters[2]
			Number: nIndex
			String: strFile
			String: dfPath
			! Number: nFileId
			! Number: nCount
		Message Actions
			On SAM_Create
				Call PrepareWindowEx(hWndForm)
				Set strFilters[0] = 'Dbf-файли'
				Set strFilters[1] = 'acct*.dbf'
