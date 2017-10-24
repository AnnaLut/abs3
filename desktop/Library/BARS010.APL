Application Description: ! /////////////////////////////////////////////////////////////////////////////////////////////////
		! BARS010.APD - Dynalib ( префикс - PRC )
		! BARS010.APL - Библиотека ф-ций работы с процентами
		! ООО Унити-Барс  ( C )  1996-2011
		! Разработчик: Марценюк М.П.
		! /////////////////////////////////////////////////////////////////////////////////////////////////
	Outline Version - 4.0.26
	Design-time Settings
.data VIEWINFO
0000: 6F00000003000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000B30000 002C000000030000 0003000000000000 0077020000FCFFFF
0040: FFE2FFFFFF000000 0000000000230300 00E3010000010000 0000000000010000
0060: 000F4170706C6963 6174696F6E497465 6D02000000075769 6E646F7773097462
0080: 6C416372496E7400 0001800200020000 0000000000000000 002C000000000000
00A0: 0001000000FFFFFF FFFFFFFFFFF7FFFF FFDCFFFFFF5A0000 005A000000660500
00C0: 00CF020000000000 0000000000050000 000F4170706C6963 6174696F6E497465
00E0: 6D0757696E646F77 730974626C416372 496E7408546F6F6C 2042617208706241
0100: 6363727565000000 00
.enddata
.data DT_MAKERUNDLG
0000: 0200000000001E71 3A5C626172733938 5C6C696272617279 5C524547434C4E45
0020: 582E646C6C1E713A 5C6261727339385C 6C6962726172795C 524547434C4E4558
0040: 2E61706300000101 011E713A5C626172 7339385C6C696272 6172795C52454743
0060: 4C4E45582E72756E 1E713A5C62617273 39385C6C69627261 72795C524547434C
0080: 4E45582E646C6C1E 713A5C6261727339 385C6C6962726172 795C524547434C4E
00A0: 45582E6170630000 010101175C424152 5339385C42494E5C 626172733031302E
00C0: 617064175C424152 5339385C42494E5C 70726F636170692E 646C6C175C424152
00E0: 5339385C42494E5C 70726F636170692E 6170630000010101 001E713A5C626172
0100: 7339385C6C696272 6172795C52454743 4C4E45582E646C6C 1E713A5C62617273
0120: 39385C6C69627261 72795C524547434C 4E45582E61706300 00010101
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
		Dynalib: Service.apd
		Dynalib: nsiapi.apd
		Dynalib: Docview.apd
		Dynalib: custacnt.apd
		!
		File Include: Gentbl.apl
		File Include: Gentbld.apl
		File Include: GENTBLS.APL
		File Include: GENLBUTN.APL
		File Include: Genlist.apl
		File Include: Genlabel.apl
		File Include: Winapi.apl
		File Include: XSALIMG.APL
		File Include: Xsalcpt.apl
		!
		File Include: Docfun6.apl
		File Include: Vtmeter.apl
		File Include: GENTBLF.APL
		File Include: VTTBLWIN.APL
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
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: System Default
				Text Color: System Default
				Background Color: System Default
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
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
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
			Date/Time: dd-MM-yy
			Date/Time: dd/MM/yyyy
			Number: ###00000
			Number: ###00000
			Number: 00000
			Number: ###000;'($'###000')'
			Number: #000
			Number: #00000
			Number: ###0000000
			Number: 0000000
			Number: ###0000000
			Number: ########00000
		External Functions
			! Library name: Financial32.dll
				                                                    Function: Price
					                                                    Description: 
					                                                    Export Ordinal: 0
					                                                    Returns 
						                                                    Number: DOUBLE
					                                                    Parameters 
						                                                    String: LPSTR
						                                                    String: LPSTR
						                                                    Number: DOUBLE
						                                                    Number: DOUBLE
						                                                    Number: DOUBLE
						                                                    Number: INT
						                                                    Number: INT
		Constants
.data CCDATA
0000: 3000000000000000 0000000000000000 00000000
.enddata
.data CCSIZE
0000: 1400
.enddata
			System
			User
				String: ApdNum   =  '10'
				String: ApdVer   =  '46'
				! История изменений:
				! 01 30-11-01  MIK     Положил начало контролю версий
				! 02 11-12-01  MIK     В назначении платежа добавил наименование клиента
				! 03 11-12-01  MIK     При выплате %% для счетов 3кл ставим VOB=6
				! 04 06-08-02  MIK     При начислении %% для исключения ЛОКОВ перешли на TEMPTABLE
				! 05 29-08-02  MIK     Невозможно было изменить назн платежа при начислении %%
				! 06 02-10-02  MIK     В назн платежа при начисл %% убрал "Ставка" для амортизации
				! 07 04-12-02  MIK     в проводках по %% запоминаем части копеек поле int_acrn(S)
				! 08 13-12-02  MIK     Сделал возможность READ_ONLY для окна "Параметры начисления %%"
				! 09 21-02-03  MIK     Начал делать печать их архива ведомостей
				! 10 15-05-03  MIK     По счету нач %% поставил ОКПО клиента, а по ДохРасх - NMS     
				! 11 10-06-03  MIK     Добавил в ведомости по %% связку по int_accN (для Суховой)     
				! 12 26-08-03  MIK     Сделал ф-ю для начисления %% на старте или на финише   
				! 13 05-01-04  MIK     Сделал переворот документа в кредитовый для операций по списку TTSK_%   
				! 14 19-03-04  MIK     Сделал начисление %% на входящий остаток  
				! 15 24-03-04  MIK     Сделал сохранение измененного назначения платежа 
				! 16 30-11-04  MIK     Сделал использование умалчиваемого назначения платежа 
				! 17 08-02-05  MIK     Сделал инверсию DK и переворот документа для операций по списку TTSK_%
				! 18 25-02-05  MIK     Еще раз переспрашиваем, что БЕЗ проводок
				! 19 25-07-05  MIK     Сделал установку по профилю начисления процентов
				! 20 09-11-05  MIK     Добавил Основной счет для вызова формулы назначения платежа
				! 21 01-03-06  MIK     Сделал режим выполнения проводок по %% с VOB=96
				! 22 18-09-06  MIK     Начало интервала было daos-1 исправил на daos
				! 23 28-02-07  MIK     Расширил значение базовой %% ставки
				! 24 21-03-07  MIK     Расширил значение %% ставки в форме и в назначении платежа
				! 25 20-12-07  MIK     Добавил функцию "Сторно начисленных %%" (бэта)
				! 26 25-12-07  MIK     1-й товарный вариант функции "Сторно начисленных %%"
				! 27 29-12-07  MIK     Переніс процедури "Сторно начисленных %%" в пакедж ACRN
				! 28 11-02-08  NATA    История изменения базовых %% ставок: следим за правильностью ввода значения ставки (###0.0000)
				! 29 12-03-08  NATA    История изменения базовых %% ставок: формат ставки - 8 зн.после запятой, не>100%
				! 30 15-05-08  NATA    В форме добавления/изменения %% ставок исправлены условия по нормальной(br_id not in (2,3,5,6))/ступенчатой(br_id in (2,3,5,6)) %% ставке
				! 31 15-09-08  MIK     Вставил проверку на заполненность валюты в проводках по %%
				! 32 25-03-09  MIK     Переделал оплату по %%, что б не перечитывало после каждой ошибки
				! 33 21-07-09  MIK     Добавил выборку из таблицы типов остатков int_ion
				! 34 01-12-09  MIK     Исправил ошибку с несортированным выполнением проводок по %%
				! 35 26-01-10  MIK     Прибрав сортування по кліку на колонці в проводках по %%
				! 36 27-04-10  MIK     Добавив вирахування Оборотного балансу в выдомості по параметру  OBAL_%
				! 37 17-01-11  MIK     Вставил проверку на кода МФО по выплате %% + признак действующей % ставки
				! 38 17-03-11  MIK     В нарахуванні %% була залежність від довжини strPar02, що давало помилку установки дати нарахування
				! 39 17-08-11  MIK     Додав ключ 'I'-друк номера виконавця в процентній выдомості (потрібно bars010w.qrp)
				! 40 30-09-11  MIK     Неправильно рахувала суму проводки в унціях золота
				! 41 05-12-11  MIK     Вернув назад можливість сортування по кліку на колонці
				! 42 31-05-12  MIK     Додав ключ 'V'-нарахування по V_GL
				! 43 30-11-12  MIK     Расширили вызов CC_KOMISSIA  для б/с 2600,2650
				! 44 07-12-12  MIK     Випр.помилку в формулу призначення платежу не передавалися параметри #(FDAT),#(TDAT)
				! 45 28-12-12  MIK     Виправив внесену помилку з фільтром INFORMIX OUTERВ
				! 46 17-04-13  MIK     Додав роботу з metr=12 (Ощадний DF)
		Resources
		Variables
			String: CP_ ! начисление віполняется из ЦП
			Window Handle: hWin0
			Window Handle: hWin1
			Window Handle: hWin11
			Window Handle: hWin2
			Window Handle: hWin3
			Window Handle: hWin4
			Window Handle: hWin_113
			Window Handle: hWin5
			Window Handle: hWin7
			Number: nHaveTobo
			String: sCurrTobo
			Boolean: bApdInited
		Internal Functions
			! // BARS010.APL - Функции /////////////////////////////////////////////////////////////////////////////////////
			Function: Sel010	! __exported
				Description: Bars010_Selector
				Returns
				Parameters
					Window Handle: hWndParent
					Number: nMode
					Number: nPar
					String: strPar01
					String: strPar02
				Static Variables
				Local variables
					Date/Time: dDat_To
					Number: nFetchRes
				Actions
					Call Ini010()
					Select Case nMode
						Case 0 ! Обычное начисление
							If not IsWindow(hWin0)
								Set CP_ = strPar02
								Set hWin0 = SalCreateWindow(tblAcrInt, hWndParent, nPar, strPar01, 
										IifS(CP_ = "Ц", 'S', strPar02))
							Else
								Call SalBringWindowToTop(hWin0)
							Break
						Case 1
							If not IsWindow(hWin1)
								Set hWin1 = SalCreateWindow( tblAcrPay, hWndParent, nPar, strPar01, strPar02 )
							Else
								Call SalBringWindowToTop ( tblAcrPay )
							Break
						Case 11
							If not IsWindow(hWin11)
								Set hWin11= SalCreateWindow( CAL, hWndParent, nPar, strPar01, strPar02 )
							Else
								Call SalBringWindowToTop ( CAL )
							Break
						Case 2
							! Call SalModalDialog( DlgSOT ,hWndParent, nPar)
							If not IsWindow(hWin2)
								Set hWin2 = SalCreateWindow(DlgSOT, hWndParent, nPar)
							Else
								Call SalBringWindowToTop(hWin2)
							Break
						Case 3  ! Начисление %% и проводки по ним на старте дня
							If strPar01=STRING_Null
								Set dDat_To=GetBankDate()-1
							Else
								If SqlPrepareAndExecute( hSql(), "SELECT to_date("||strPar01||") INTO :dDat_To FROM dual" ) 
										AND NOT SqlFetchNext( hSql(), nFetchRes )
									Set dDat_To=GetBankDate()-1
							Call Interest(1,dDat_To,strPar02,STRING_Null)
							Call Provodki(1,dDat_To,strPar02)
							! Call Interest(1,GetBankDate()-1,strPar02)
							! Call Provodki(1,GetBankDate()-1,strPar02)
						Case 4  ! БЕК %%
							If not IsWindow(hWin4)
								Set hWin4 = SalCreateWindow(tblAcrBack, hWndParent, nPar, strPar01, strPar02)
							Else
								Call SalBringWindowToTop(hWin4)
							Break
			Function: Ini010
				Description: инициализация библиотеки
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					String: strPathToLangResources
					String: strLangId
					String: strFileName
				Actions
					If not bApdInited
						Set bStaticsAsWindows = TRUE
						Set nHaveTobo = GetGlobalOptionEx('HAVETOBO')
						Set sCurrTobo = GetValueStr("SELECT substr(tobopack.GetTOBO,1,30) FROM dual")
						Set strPathToLangResources = GetLangPath()
						Set strLangId = GetLang()
						Set strFileName = strPathToLangResources || "\\" || strLangId || "\\bars010.lng"
						If (NOT strLangId) OR (NOT CurrentLangTable.InitFromFile( strFileName, strLangId ))
							Call CurrentLangTable.Init()
							! ====================================================
							Call CurrentLangTable.AddAtom('cTAt', 'Внимание!')
							Call CurrentLangTable.AddAtom('cTErr','Ошибка!')
							Call CurrentLangTable.AddAtom('cTOk', 'Готово')
							! ====================================================
							! tblAcrInt
							! column
							Call CurrentLangTable.AddAtom('tblAcrInt.cIsp',   'Исп')
							Call CurrentLangTable.AddAtom('tblAcrInt.cId',    'Код')
							Call CurrentLangTable.AddAtom('tblAcrInt.cNMS',   'Наименование~счета')
							Call CurrentLangTable.AddAtom('tblAcrInt.cNls',   'Счет')
							Call CurrentLangTable.AddAtom('tblAcrInt.cLcv',   'Вал~юта')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTT',    'ОП')
							Call CurrentLangTable.AddAtom('tblAcrInt.cDk',    'Дб/~Кр')
							Call CurrentLangTable.AddAtom('tblAcrInt.cNlsA',  'Счет~А')
							Call CurrentLangTable.AddAtom('tblAcrInt.cKvA',   'Код~Вал')
							Call CurrentLangTable.AddAtom('tblAcrInt.cNMSA',  'Наименование~счета начисл.%%')
							Call CurrentLangTable.AddAtom('tblAcrInt.cNlsB',  'Счет~Б')
							Call CurrentLangTable.AddAtom('tblAcrInt.cKvB',   'Код~Вал')
							Call CurrentLangTable.AddAtom('tblAcrInt.cNMSB',  'Наименование~счета ДохРас')
							Call CurrentLangTable.AddAtom('tblAcrInt.cDatF',  'С')
							Call CurrentLangTable.AddAtom('tblAcrInt.cDatT',  'По')
							Call CurrentLangTable.AddAtom('tblAcrInt.cIr',    '%~Ставка')
							Call CurrentLangTable.AddAtom('tblAcrInt.cBr',    'Базовая~Ставка')
							Call CurrentLangTable.AddAtom('tblAcrInt.cOstss', '% число')
							Call CurrentLangTable.AddAtom('tblAcrInt.cOstAs', 'Текущий~остаток')
							Call CurrentLangTable.AddAtom('tblAcrInt.cNAZN',  'Назначение платежа')
							Call CurrentLangTable.AddAtom('tblAcrInt.cNMK',   'Наименование~клиента')
							Call CurrentLangTable.AddAtom('tblAcrInt.cOKPO',  'ОКПО~Клиента')
							Call CurrentLangTable.AddAtom('tblAcrInt.cAcrDs', '%%~в номинале')
							Call CurrentLangTable.AddAtom('tblAcrInt.cAcrDQs','Сумма~вал-А')
							Call CurrentLangTable.AddAtom('tblAcrInt.cBran4', 'Подразделение')
							! button strTip
							Call CurrentLangTable.AddAtom('tblAcrInt.cBTipAccrue',  'Начислить  % по указанную дату вкл')
							Call CurrentLangTable.AddAtom('tblAcrInt.cBTipTudaSuda','Показать проводки по %')
							Call CurrentLangTable.AddAtom('tblAcrInt.cBTipProvodki','Выполнить проводки по %')
							Call CurrentLangTable.AddAtom('tblAcrInt.cBTipToMail',  'Отправить ведомость начисленных %%')
							Call CurrentLangTable.AddAtom('tblAcrInt.cBTipPrint',   'Печать ведомости')
							Call CurrentLangTable.AddAtom('tblAcrInt.cBTipFilter',  'Фильтр')
							Call CurrentLangTable.AddAtom('tblAcrInt.cBTipCompres', 'Сжатие информации')
							Call CurrentLangTable.AddAtom('tblAcrInt.cBTipPreView', 'Просмотр файла печати')
							Call CurrentLangTable.AddAtom('tblAcrInt.cBTipReport',  'Сформировать ведомость')
							! BG
							Call CurrentLangTable.AddAtom('tblAcrInt.bgProc','Начислить  по')
							! nazn text
							Call CurrentLangTable.AddAtom('tblAcrInt.cTNazn1', 'Амортизація рах.')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTNazn11','пропорц.')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTNazn12','по еф.%ст')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTNazn2', '%% по рах.')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTNazn31','з')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTNazn32','по')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTNazn33','вкл.')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTNazn34','Ставка')
							! message text
							Call CurrentLangTable.AddAtom('tblAcrInt.cTMess1', 'Начислить %% по')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTMess12','используя фильтр')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTMess13','все счета')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTMess2', 'Уверены, что БЕЗ проводок ?')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTMess3', 'Не указана валюта начисления для -')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTMess4', 'Счета без макета проводок - не будут обработаны.')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTMessVedomost','Ведомость напечатали ?')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTMessArchiv',  'Сформировать ведомость начисленных %% из АРХИВА?')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTMessInfSave', 'Информация сохранена в файле')
							! error text
							Call CurrentLangTable.AddAtom('tblAcrInt.cTErrSumm','Неверно введена сумма')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTErrInf', 'Неуспех при сжатии информации')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTErrRep1','Ошибка')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTErrRep2','при формировании отчета')
							! constants
							Call CurrentLangTable.AddAtom('tblAcrInt.cTTitle1','Проводки по начислению %%')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTTitle2','Начисление %%')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTTip1',  'Показать начисленные %')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTTip2',  'Показать проводки по %')
							Call CurrentLangTable.AddAtom('tblAcrInt.cTPrint', 'Проводки по нарахованих відсотках')
							! ====================================================
							! dlg_Mess
							! BG
							Call CurrentLangTable.AddAtom('dlg_Mess.bgInfo','Начисление %% будет зафиксировано в базе данных.~~Это действие необратимо.~')
							! button strTip
							Call CurrentLangTable.AddAtom('dlg_Mess.cTWithProv',   'Выполнить проводки')
							Call CurrentLangTable.AddAtom('dlg_Mess.cTWithoutProv','Без проводок')
							Call CurrentLangTable.AddAtom('dlg_Mess.cTExit',       'Выйти и подумать')
							! ====================================================
							! dlg_ProcAccounts
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.cTWndTitle','Параметри нарахування %% по рахунку №')
							! BG
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.bgMetodN','Метод нарахування')
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.bgBaseGN','Базовий рік')
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.bgPeriodN','Періодичність')
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.bgOstatN','Залишок')
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.bgDaty','Дати')
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.bgNachisleni','Нарахування')
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.bgVyplaty','Виплати')
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.bgPrekrasch','Закінчення')
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.bgProv','Операції')
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.bgNachN','Нарах')
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.bgVyplN','Виплат')
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.bgTTN','Тип')
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.bgValN1','Вал')
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.bgNlsN1','Рах нар %%')
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.bgMfoN','МФО')
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.bgValN2','Вал')
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.bgNlsN2','КонтрРахунок')
							!
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.bgOstatN0','Вихідний')
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.bgOstatN1','Вхідний')
							! button strTip
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.cBTipCopy','Перенести параметры из основной карточки')
							! message text
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.cTMess11','Счет')
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.cTMess12','не открыт')
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.cTMess13','Открыть ?')
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.cTMess2', 'Нар.%%')
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.cTMess3', 'АвтоОткрытие сч.')
							! error text
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.cTErrKR', 'Конр.разряд')
							Call CurrentLangTable.AddAtom('dlg_ProcAccounts.cTErrAcc','Не открыт счет с внутренним №')
							! ====================================================
							! DlgSOT
							! button strTip
							Call CurrentLangTable.AddAtom('DlgSOT.cBTipEdit','Редактировать ставку')
							Call CurrentLangTable.AddAtom('DlgSOT.cBTipArchAll','Ставка за все дни')
							Call CurrentLangTable.AddAtom('DlgSOT.cBTipArchTek','Ставка на текущий день')
							! column
							Call CurrentLangTable.AddAtom('DlgSOT.tbl.cDatB','Дата')
							Call CurrentLangTable.AddAtom('DlgSOT.tbl.cKv',  'Валюта')
							Call CurrentLangTable.AddAtom('DlgSOT.tbl.cIr',  'Ставка')
							Call CurrentLangTable.AddAtom('DlgSOT.tbl.cS',   'Сумма')
							Call CurrentLangTable.AddAtom('DlgSOT.tbl.cBranch','Код~подразделения')
							Call CurrentLangTable.AddAtom('DlgSOT.tbl.cBranchName','Наименование~подразделения')
							! constants
							Call CurrentLangTable.AddAtom('DlgSOT.cTPPS','Простая процентная ставка')
							Call CurrentLangTable.AddAtom('DlgSOT.cTSPS','Ступенчатая процентная ставка')
							Call CurrentLangTable.AddAtom('DlgSOT.cTArch','Архив')
							! ====================================================
							! dlgEditBrates
							Call CurrentLangTable.AddAtom('dlgEditBrates.cTWndTitleIns','Добавление процентной ставки')
							Call CurrentLangTable.AddAtom('dlgEditBrates.cTWndTitleEdit','Обновление процентной ставки')
							! pb
							Call CurrentLangTable.AddAtom('dlgEditBrates.pbSave','Применить')
							! BG
							Call CurrentLangTable.AddAtom('dlgEditBrates.bgBranch','Отделение')
							Call CurrentLangTable.AddAtom('dlgEditBrates.bgBrName','Базовая ставка:')
							Call CurrentLangTable.AddAtom('dlgEditBrates.bgKv','Валюта:')
							Call CurrentLangTable.AddAtom('dlgEditBrates.bgBDate','Дата установки:')
							Call CurrentLangTable.AddAtom('dlgEditBrates.bgOldRate','Старое значение:')
							Call CurrentLangTable.AddAtom('dlgEditBrates.bgNewRate','Новое значение:')
							Call CurrentLangTable.AddAtom('dlgEditBrates.bgRate','Значение:')
							! message text
							Call CurrentLangTable.AddAtom('dlgEditBrates.cTMessRekv','Заполнены не все реквизиты!')
							Call CurrentLangTable.AddAtom('dlgEditBrates.cTMessSumm','Не заполнены суммы!')
							Call CurrentLangTable.AddAtom('dlgEditBrates.cTMessRate100','Ставка не должна превышать 100% !!!')
							! constants
							Call CurrentLangTable.AddAtom('dlgEditBrates.cTNotIns','Не удалось добавить ставку')
							Call CurrentLangTable.AddAtom('dlgEditBrates.cTBranch','для отделения')
							Call CurrentLangTable.AddAtom('dlgEditBrates.cTIns','Добавлена ставка')
							Call CurrentLangTable.AddAtom('dlgEditBrates.cTUpdate','Обновлена ставка')
							Call CurrentLangTable.AddAtom('dlgEditBrates.cTNotUpdate','Не удалось обновить ставку')
							Call CurrentLangTable.AddAtom('dlgEditBrates.cTBranch1','Для отделения')
							Call CurrentLangTable.AddAtom('dlgEditBrates.cTSave','уже занесена ставка. Обновить?')
							Call CurrentLangTable.AddAtom('dlgEditBrates.cTDelete','Удалена ставка')
							Call CurrentLangTable.AddAtom('dlgEditBrates.cTNotDelete','Не удалось удалить ставку')
							! column
							Call CurrentLangTable.AddAtom('dlgEditBrates.tblBrTier.colS','Граничная сумма (в коп.)')
							Call CurrentLangTable.AddAtom('dlgEditBrates.tblBrTier.colOldRate','Старое значение')
							Call CurrentLangTable.AddAtom('dlgEditBrates.tblBrTier.colNewRate','Новое значение')
							! button strTip
							! ====================================================
							! tblAcrPay
							Call CurrentLangTable.AddAtom('tblAcrPay.cTWndTitle','Выплата/взыскание %%')
							! button strTip
							Call CurrentLangTable.AddAtom('tblAcrPay.cBTipFilter','Фильтр')
							Call CurrentLangTable.AddAtom('tblAcrPay.cBTipRun',   'Выполнить проводки')
							! column
							Call CurrentLangTable.AddAtom('tblAcrPay.colVob', 'Вид~док.')
							Call CurrentLangTable.AddAtom('tblAcrPay.colTT',  'Код~оп.')
							Call CurrentLangTable.AddAtom('tblAcrPay.colNlsA','Рах~А')
							Call CurrentLangTable.AddAtom('tblAcrPay.colKvA', 'ВАЛ~A')
							Call CurrentLangTable.AddAtom('tblAcrPay.colNlsB','Рах~Б')
							Call CurrentLangTable.AddAtom('tblAcrPay.colKvB', 'ВАЛ~Б')
							Call CurrentLangTable.AddAtom('tblAcrPay.colMfoB','МФО~Б')
							Call CurrentLangTable.AddAtom('tblAcrPay.colDk',  'Д/К')
							Call CurrentLangTable.AddAtom('tblAcrPay.colS',   'Формула~суммы')
							Call CurrentLangTable.AddAtom('tblAcrPay.colOstC','Остаток')
							Call CurrentLangTable.AddAtom('tblAcrPay.colSumR','Сума~документа')
							Call CurrentLangTable.AddAtom('tblAcrPay.colOstB','Остаток')
							Call CurrentLangTable.AddAtom('tblAcrPay.colPlat','Платник')
							Call CurrentLangTable.AddAtom('tblAcrPay.colPolu','Отримувач')
							Call CurrentLangTable.AddAtom('tblAcrPay.colNazn','Призначення платежу')
							Call CurrentLangTable.AddAtom('tblAcrPay.colAcc', 'Внутр~№ Сч.')
							Call CurrentLangTable.AddAtom('tblAcrPay.colOkpoB','ОКПО~Б')
							Call CurrentLangTable.AddAtom('tblAcrPay.colId',  'Тип~ставки')
							! BG
							Call CurrentLangTable.AddAtom('tblAcrPay.bgGroup','Группа')
							! Nazs
							Call CurrentLangTable.AddAtom('tblAcrPay.cTNazn1','Виплата')
							Call CurrentLangTable.AddAtom('tblAcrPay.cTNazn2','Стягнення')
							Call CurrentLangTable.AddAtom('tblAcrPay.cTNazn3','відсотків по рах.')
							! message text
							Call CurrentLangTable.AddAtom('tblAcrPay.cTMess1','Переполнение таблицы. Часть данных не обработана.')
							! constants
							Call CurrentLangTable.AddAtom('tblAcrPay.cTPrint','Таблица Выплата/взыскание %%')
							! ====================================================
							! CAL
							Call CurrentLangTable.AddAtom('CAL.cTWndTitle','Расчет доходности ресурса, вложенного в разные финансовые инструменты')
							! button strTip
							Call CurrentLangTable.AddAtom('CAL.cBTip1', 'Расчитать незаполненное')
							Call CurrentLangTable.AddAtom('CAL.cBTip1x','Очистить')
							! field strTip
							Call CurrentLangTable.AddAtom('CAL.cFTipVAL',  'Код вал ресурса')
							Call CurrentLangTable.AddAtom('CAL.cFTipRES1', 'Сумма вал ресурса')
							Call CurrentLangTable.AddAtom('CAL.cFTipSROK1','Срок Размещение/Привлечения в днях')
							Call CurrentLangTable.AddAtom('CAL.cFTipPR1',  'Годовая % ставка')
							Call CurrentLangTable.AddAtom('CAL.cFTipDOX1', 'Сумма процентного дохода/расхода')
							Call CurrentLangTable.AddAtom('CAL.cFTipNOM2', 'Номинальная (конечная) стоимость')
							Call CurrentLangTable.AddAtom('CAL.cFTipRES2', 'Сумма Покупки/Продажи')
							Call CurrentLangTable.AddAtom('CAL.cFTipDOX2', 'Сумма дисконтного дохода/расхода')
							Call CurrentLangTable.AddAtom('CAL.cFTipSROK2','Кол-во дней до погашения')
							Call CurrentLangTable.AddAtom('CAL.cFTipPR2',  'Приведенная Годовая % ставка')
							Call CurrentLangTable.AddAtom('CAL.cFTipVALB', 'Код вал Продажи')
							Call CurrentLangTable.AddAtom('CAL.cFTipRES3B','Сумма вал Продажи')
							Call CurrentLangTable.AddAtom('CAL.cFTipKURSB','Курс вал Продажи')
							Call CurrentLangTable.AddAtom('CAL.cFTipVALA', 'Код вал Покупки')
							Call CurrentLangTable.AddAtom('CAL.cFTipRES3A','Сумма вал Покупки')
							Call CurrentLangTable.AddAtom('CAL.cFTipKURSA','Курс вал Покупки')
							Call CurrentLangTable.AddAtom('CAL.cFTipSROK3','Кол-во дней между Поступлением и Отправкой')
							! BG
							Call CurrentLangTable.AddAtom('CAL.bgGBProcDox','Процентный доход')
							Call CurrentLangTable.AddAtom('CAL.bgVAL1', 'Валюта')
							Call CurrentLangTable.AddAtom('CAL.bgRES1', 'Ресурс')
							Call CurrentLangTable.AddAtom('CAL.bgSROK1','Срок')
							Call CurrentLangTable.AddAtom('CAL.bgPR1',  '% ставка')
							Call CurrentLangTable.AddAtom('CAL.bgDOX1', 'Доход')
							Call CurrentLangTable.AddAtom('CAL.bgGBDiscDox','Дисконтный  доход')
							Call CurrentLangTable.AddAtom('CAL.bgVAL2', 'Валюта')
							Call CurrentLangTable.AddAtom('CAL.bgNOM2', 'Номинал')
							Call CurrentLangTable.AddAtom('CAL.bgRES2', 'Ресурс')
							Call CurrentLangTable.AddAtom('CAL.bgDOX2', 'Дисконт')
							Call CurrentLangTable.AddAtom('CAL.bgSROK2','Срок')
							Call CurrentLangTable.AddAtom('CAL.bgPR2',  '% ставка')
							Call CurrentLangTable.AddAtom('CAL.bgGBMargDox','Маржинальный  доход')
							Call CurrentLangTable.AddAtom('CAL.bgProd', 'Отправка (Продажа)')
							Call CurrentLangTable.AddAtom('CAL.bgRes',  'Ресурс')
							Call CurrentLangTable.AddAtom('CAL.bgPok',  'Поступление (Покупка)')
							Call CurrentLangTable.AddAtom('CAL.bgSROK3','Срок')
							Call CurrentLangTable.AddAtom('CAL.bgPR3',  'ставка')
							Call CurrentLangTable.AddAtom('CAL.bgMarga','Маржа')
							! error text
							Call CurrentLangTable.AddAtom('CAL.cTErrPar','ош.параметров')
							! ====================================================
						Set bApdInited = TRUE
					Return bApdInited
			Function: SetProcParN    	! __exported
				Description: Установить параметры начисления %%
				Returns
					Boolean:
				Parameters
					Number: nAcc     ! номер счета (внутренний) начисления
					!
					Number: nAccess  ! nAccess=ACCESS_READONLY (=2)  Только просмотр
							                 ! иначе с РЕДАКТИРОВАНИЕМ
					String: sNlsSN   ! номер счета начисленных % для двух ид через запятую
					String: sNlsSD   ! номер счета дох/расх для двух ид через запятую
				Static Variables
				Local variables
					String: sNlsSN0   ! номер счета начисленных %
					String: sNlsSD0   ! номер счета дох/расх
					String: sNlsSN2   ! номер счета начисленных %
					String: sNlsSD2   ! номер счета дох/расх
					Number: i
					Number: n
				Actions
					! Call Ini010()
					! Умолчательній счет нач % для двух ид
					! If sNlsSN != STRING_Null
						                                 Set i=1
						                                 Set n = SalStrLength( sNlsSN )
						                                 While i <= n
							                                 If Subs(sNlsSN,i,1)=','
								                                 Set sNlsSN0 = Subs(sNlsSN, 1, i-1 )
								                                 Set sNlsSN2 = Subs(sNlsSN, i+1, n-i )
								                                 Break 
							                                 Set i=i+1
						                                 If i > n
							                                 Set sNlsSN0 = sNlsSN
							                                 Set sNlsSN2 = STRING_Null
					! Else
						                                 Set sNlsSN0 = STRING_Null
						                                 Set sNlsSN2 = STRING_Null
					! Умолчательній счет доходов для двух ид
					! If sNlsSD != STRING_Null
						                                 Set i=1
						                                 Set n = SalStrLength( sNlsSD )
						                                 While i <= n
							                                 If Subs(sNlsSD,i,1)=','
								                                 Set sNlsSD0 = Subs(sNlsSD, 1, i-1 )
								                                 Set sNlsSD2 = Subs(sNlsSD, i+1, n-i )
								                                 Break 
							                                 Set i=i+1
						                                 If i > n
							                                 Set sNlsSD0 = sNlsSD
							                                 Set sNlsSD2 = STRING_Null
					! Else
						                                 Set sNlsSD0 = STRING_Null
						                                 Set sNlsSD2 = STRING_Null
					! !!
					!
					! Return SalModalDialog( dlg_ProcAccounts, hWndForm, nAcc, nAccess,
							 sNlsSN0, sNlsSD0, sNlsSN2, sNlsSD2)
					! Call SalCreateWindow(frm_ProcAccounts, hWndMDI, nAcc, nAccess,
							 sNlsSN0, sNlsSD0, sNlsSN2, sNlsSD2)
					! Call ShowAccList(-1, nAcc, nAccess, '')
					Call ShowAccList(-1, nAcc, nAccess, sNlsSN || '|' || sNlsSD)
					Return TRUE
			Function: ShowApdVersion
				Description:
				Returns
				Parameters
					String: sWin
				Static Variables
				Local variables
					String: strText
					Number: nLength
				Actions
					Call SalStrSetBufferLength( strText, 160 )
					Set nLength = SalGetWindowText ( hWndForm, strText, 160 )
					Call SalSetWindowText ( hWndForm, ApdNum||sWin||ApdVer||' '||SalStrTrimX(strText) )
			Function: IntCompres
				Description: Сжатие начисленных процентов
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
					If SqlPrepareAndExecute(hSql(), "begin acrn.p_cnds; end;")
						Call SqlCommit(hSql())
					Else
						! Call SqlRollbackEx(hSql(),'Неуспех при сжатии информации')
						Call SqlRollbackEx(hSql(),CurrentLangTable.GetAtomTitle('tblAcrInt.cTErrInf'))
			Function: Interest     	
				Description: Начисление %% за любой период (MIK) (INNA)
				Returns
					Boolean:
				Parameters
					Number: nMode        ! nMode=1 ,"SALDO", "ACCOUNTS"
					Date/Time: dDat      ! дата "по"
					String: sFilt        ! фильтр (если надо)
					String: sAddFrom     ! список "внешних" таблиц (если есть)
				Static Variables
				Local variables
					Date/Time: dDat1
					Date/Time: dDat2
					Date/Time: dDaos
					Number: nAcc
					Number: nAccc
					String: sTip
					Number: nVid 
					Number: nInt
					Number: BASEM
					Number: nCount
					Number: nFetchRes
					Number: nFreq
					Number: nKv
					Number: n980
					Number: nId
					Number: nFLAG
					Number: METR
					Number: BASEY
					String: sNls
					String: sTmp
					: cDocInt
						Class: cDoc
				Actions
					Set n980 = GetBaseVal()
					Set sTmp =
							"SELECT i.METR,i.BASEY,i.BASEM, i.acc , i.id, i.freq, (i.acr_dat+1), i.stp_dat,        s.kv  , s.daos, s.nls , s.ACCC, s.tip        
							   INTO :METR , :BASEY, :BASEM, :nAcc , :nId, :nFreq, :dDat1, :dDat2, :nKv, :dDaos, :sNls , :nAccc, :sTip
							   FROM int_accN i, "||IifS(nMode=1 ,"SALDO", "ACCOUNTS")||" s, 
							        tabval t, customer k "||sAddFrom||"
							  WHERE (i.metr IN (0,1,2,3,4,5,7,8,10,12, 23,515) OR i.metr > 90) 
							    AND i.acc = s.acc  and i.id not in (10,11)  AND s.rnk = k.rnk
							    AND s.kv  = t.kv "||sFilt
					! Call Debug( Subs(sTmp,   1,300))
					! Call Debug( Subs(sTmp,0301,300))
					! Call Debug( Subs(sTmp,0601,300))
					! Call Debug( Subs(sTmp,0901,300))
					! Call Debug( Subs(sTmp,1201,300))
					! Call Debug( Subs(sTmp,1501,300))
					! Call Debug( Subs(sTmp,1801,300))
					! Call Debug( Subs(sTmp,2101,300))
					! Call Debug( Subs(sTmp,2401,300))
					! Call Debug( Subs(sTmp,2701,300))
					! Call Debug( Subs(sTmp,3001,300))
					! ! ! ! ! ! ! ! ! ! ! ! !
					If SqlPrepareAndExecute(hSql(), "SELECT count(*) INTO :nCount FROM int_accN") and
							   SqlFetchNext(hSql(),nFetchRes)
						Call SalCreateWindow(win_meter, hWndForm,'Начисление %%', nCount+1)
						If SqlPrepareAndExecute( hSqlAux(), T(sTmp))
							Set nCount = 0
							While SqlFetchNext(hSqlAux(),nFetchRes)
								If dDat1=DATETIME_Null
									Set dDat1=dDaos
								If dDat2=DATETIME_Null
									Set dDat2=dDat
								If dDat < dDat2
									Set dDat2=dDat
								! Call Debug('a*'|| Str(nFreq)|| ' '|| Str(METR) || ' ' || Str(nId)   )
								If nFreq=1 or
										   nFreq=3 and dDat2-dDat1 >= 7 or
										   nFreq=5 and dDat2 >= AddMonths(dDat1,1) or
										   nFreq=7 and dDat2 >= AddMonths(dDat1,3) or
										   nFreq=180 and dDat2 >= AddMonths(dDat1,6) or
										   nFreq=360 and dDat2 >= AddMonths(dDat1,12)
									If METR  = 7 and nId = 0
										! Метод плав % ставки для ОВЕРД
										! Доначисление % за пред период 
										! Построение графика % ставок на текущий период с нормальным методом начисления
										Call int_OVRP (nAcc,nId,dDat1,dDat2,NUMBER_Null,1)
										!
									Else If METR > 90 and nId = 2 and
											 (Subs(sNls ,1,4)='8999' or Subs(sNls ,1,4)='2600' or Subs(sNls ,1,4)='2650')
										! Начисление комиссий по КП по разным METR > 90
										Call CC_KOMISSIA (METR, nAcc,nId,dDat1,dDat2,NUMBER_Null,1)
									Else
										! Всякие прибамбасы перед нач % 
										!
										! Call Debug('b*'|| Str(BASEY)|| ' '|| Str(nAccc) || ' ' ||sTip  )
										! переменный базовый год (! используется в ЦБ)
										If BASEY = 4 
											Set nFLAG = SqlPLSQLCommand(hSql(), "CP.CP_BASEY (nAcc, dDat  )")
										!
										! Спец.начислениемкупона по ЦБ
										If METR = 8 or METR = 23 or METR = 515 
											Call CP_int( METR, nAcc, nId, dDat1, dDat2, NUMBER_Null, 1 )
										!
										! Фiксована сума з Ануiт.платежу - 18.07.2012 - Сухова
										! Проверим на КП(nAccc >0) + норм.тело(sTip ='SS ') + анутиет (BASEY = 2 and BASEM = 1)
										Else If nAccc >0 and sTip ='SS ' and nId = 0 
												 and BASEY = 2 and BASEM = 1 
											Call INT_METR_A (nAccc, nAcc,nId,dDat1,dDat2,NUMBER_Null,1)
										! !
										Else
											If Subs(CP_,1,1) = "Ц"
												Set nFLAG = SqlPLSQLCommand(hSql(), "CP.CP_Nomin ( nAcc )")
											! Обычное начисление %%
											! Call Debug('c*'|| Str(nAcc)|| ' '|| SalFmtFormatDateTime( dDat1, 'dd.MM.yyyy' ) 
													|| ' '|| SalFmtFormatDateTime( dDat2, 'dd.MM.yyyy' )  )
											Call p_intN (nAcc,nId,dDat1,dDat2,NUMBER_Null,1)
											! If SqlPLSQLCommand(hSql(),
													   "acrn.p_int(nAcc,nId,dDat1,dDat2,nInt,NUMBER_Null,1)")
												! Return nInt
											! Call Debug('d*'|| Str(nInt) )
										!
									Call SalStatusSetText(hWndForm, "Счет №"|| sNls )
								Set nCount=nCount + 1
								Call SalSendMsg(win_meter, UM_Populate,0,nCount)
							Call SqlCommit(hSql())
							Call SalStatusSetText(hWndForm, "Готово")
					If Subs(CP_,1,1) = "Ц"
						Set nFLAG = SqlPLSQLCommand(hSql(), "CP.CP_Nomin ( -22 )")
					Call SalDestroyWindow(win_meter)
			Function: InterestBack
				Description: Возврат начисленных %% за любой период (MIK)
				Returns
					Boolean:
				Parameters
					Number: nMode        ! nMode=1 ,"SALDO", "ACCOUNTS"
					Date/Time: dDat      ! дата "по"
					String: sFilt        ! фильтр (если надо)
					String: sAddFrom     ! список "внешних" таблиц (если есть)
				Static Variables
				Local variables
					Date/Time: dDat1
					Date/Time: dDat2
					Date/Time: dDaos
					Number: nAcc
					Number: nCount
					Number: nFetchRes
					Number: nFreq
					Number: nKv
					Number: nId
					Number: nFLAG
					Number: METR
					Number: BASEY
					String: sNls
					String: sTmp
					: cDocInt
						Class: cDoc
				Actions
					Set sTmp =
							"SELECT i.acc,i.id,s.nls INTO  :nAcc,:nId,:sNls
							 FROM int_accN i, "||IifS(nMode=1 ,"SALDO", "ACCOUNTS")||
							    " s, tabval t, customer k "|| sAddFrom ||"
							 WHERE (i.metr IN (0,1,2,4,5,7,12) or i.METR > 90)
							   AND i.acc=s.acc AND s.rnk=k.rnk AND s.kv=t.kv "||sFilt
					! ! ! ! ! ! ! ! ! ! ! ! !
					If SqlPrepareAndExecute(hSql(), "SELECT count(*) INTO :nCount FROM int_accN") and
							   SqlFetchNext(hSql(),nFetchRes)
						Call SalCreateWindow(win_meter, hWndForm,'Возврат начисленных %%', nCount+1)
						If SqlPrepareAndExecute( hSqlAux(), T(sTmp))
							Set nCount = 0
							While SqlFetchNext(hSqlAux(),nFetchRes)
								Call SalStatusSetText(hWndForm, "Счет №"|| sNls )
								Call SqlPLSQLCommand(hSql(), "acrn.acr_back(nAcc,nId,dDat)")
								Set nCount=nCount + 1
								Call SalSendMsg(win_meter, UM_Populate,0,nCount)
							Call SqlCommit(hSql())
							Call SalStatusSetText(hWndForm, "Готово")
					Call SalDestroyWindow(win_meter)
			Function: Provodki     	
				Description: Выполнение проводок по %% автоматом (MIK)
				Returns
					Boolean:
				Parameters
					Number: nMode        ! не используется
					Date/Time: dDat      ! пока не используется дата "по"
					String: sFilt        ! фильтр (если надо)
				Static Variables
				Local variables
					! Date/Time: dFdat
					Date/Time: dDatTCur
					Date/Time: dDaos
					Number: nAcc
					Number: nCount
					Number: nFetchRes
					Number: nFreq
					Number: nKv
					Number: nId
					String: sNls
					String: sNbs
					String: sKv
					String: sTmp
					: cDocInt
						Class: cDoc
					!
					Date/Time: dDatT
					Date/Time: dDatF
					String: sRat
					Number: nIsp
					Number: nRemi
					Number: nIr
					Number: nBr
					Number: nDk
					Number: nVob
					Number: nRef
					Number: nKvA
					Number: nKvB
					Number: nOsts
					Number: nOstC
					Number: nMetr
					Number: nAcrD
					String: sNazn
					String: sNmk
					String: sTT
					String: sNlsA
					String: sNlsB
					String: sNmsA
					String: sNmsB
					String: sOkpo
					String: sOkpoA
					String: sOperID
					String: sNAZN
					String: sNms
					String: sRowID
					!
					Number: nUserID
					Date/Time: dCurDat 
				Actions
					Set sNAZN = GetGlobalOption('NAZN_%' )
					Set nUserID=GetUserId(  )
					Set dCurDat=GetBankDate(  )
					Set sOkpoA=GetBankOkpoS()
					Set sTmp=
							 "SELECT /* ORDERED */
							         s.isp,a.id,s.kv,s.nls,s.nbs,a.fdat,a.tdat,a.ir,a.br,
							         a.osts,a.acrd,a.remi,s.ostc,s.acc,s.nms,a.rowid,
							         i1.nls,i1.kv,i1.nms,
							         i2.nls,i2.kv,i2.nms,i.tt,k.nmk,k.okpo,i.metr,t.lcv    
							    FROM accounts i1, accounts i2, int_accn i, acr_intn a, 
							         accounts s, customer k, tabval t 
							   WHERE i.acc=s.acc AND i.acc=a.acc AND 
							         i.id=a.id   AND s.rnk=k.rnk AND t.kv=s.kv   AND
							         i.acra=i1.acc (+) AND i.acrb=i2.acc (+) "||sFilt||
							 " ORDER BY a.id,s.kv,SUBSTR(s.nls,1,4)||SUBSTR(s.nls,6),a.fdat
							    INTO :nIsp,:nId,:nKv,:sNls,:sNbs,:dDatF,:dDatT,
							         :nIr,:nBr,:nOsts,:nAcrD,:nRemi,:nOstC,
							         :nAcc,:sNms,:sRowID,
							         :sNlsA,:nKvA,:sNmsA,
							         :sNlsB,:nKvB,:sNmsB,:sTT,:sNmk,:sOkpo,:nMetr, :sKv "
					Call SqlPrepareAndExecute(hSql(), "SELECT count(*) INTO :nCount FROM int_accN")
					If SqlFetchNext(hSql(),nFetchRes)
						Call SalCreateWindow(win_meter, hWndForm,'Проводки по %%', nCount+1)
						Call SqlPrepareAndExecute(hSqlAux3(),sTmp)
						Set nCount = 0
						While SqlFetchNext(hSqlAux3(),nFetchRes)
							! Ведомость ---> архив
							Call SqlPrepareAndExecute( hSqlAux2(), 
									"DELETE FROM tmp_intarc WHERE nls=:sNls AND kv=:nKv AND fdat>=:dDatF ")
							Call SqlPrepareAndExecute( hSqlAux2(), 
									"INSERT INTO tmp_intarc
									    (id,acc,nbs,lcv,nls,fdat,tdat,ir,br,osts,acrd,nms,ostc,kv,userid,bdat)
									 VALUES
									   (:nId,:nAcc,:sNbs,:sKv,:sNls,:dDatF,:dDatT,:nIr,:nBr,:nOsts,:nAcrD,:sNms,
									    :nOstC,:nKv,:nUserID,:dCurDat)")
							!
							If SqlPrepareAndExecute( hSql(),"SELECT acr_dat INTO :dDatTCur FROM int_accN WHERE acc=:nAcc and id=:nId FOR UPDATE OF acc NOWAIT") and
									   SqlFetchNext(hSql(),nFetchRes)
								If not dDatTCur or dDatTCur < dDatF
									If SqlPrepareAndExecute( hSql(),"
											   UPDATE int_accN SET acr_dat = :dDatT, s=:nRemi WHERE acc=:nAcc and id=:nId" )
										Set nRef = NUMBER_Null
										If nKvA=nKvB
											Set nVob=6
										Else
											Set nVob=16
										! !! Проверка на ненулевую сумму!
										If nOsts<0
											Set nDk=1
										Else
											Set nDk=0
										If nMetr = 3 or nMetr = 4
											Set nDk = 1 - nDk
										If nIr>0 AND nBr=0 
											Set sRat=SalNumberToStrX(nIr, 4 )
										Else If nBr>0 AND nIr=0 
											Set sRat=SalNumberToStrX(nBr, 4 )
										Else
											Set sRat=SalNumberToStrX(nIr, 4 )||" @ "||SalNumberToStrX(nBr, 4 )
										Set sNazn = IifS(nMetr = 3 or nMetr = 3, "Амортизація рах.", "%% по рах.")
												          ||SalStrTrimX(sNls 
												                      ||" з " ||SalFmtFormatDateTime(dDatF, 'dd-MM-yy')
												                      ||" по "||SalFmtFormatDateTime(dDatT, 'dd-MM-yy')
												                      ||" вкл." 
												                      ||IifS(nMetr = 3 or nMetr = 4, '', ' Ставка '||sRat))   
										If sNAZN = '1' and not
												(SalStrLeftX( sNlsA, 4 ) = '2628' or 
												 SalStrLeftX( sNlsA, 4 ) = '2638')
											Set sNazn=sNazn||' ('||sNmk||')'
										If nAcrD != 0
											Call cDocInt.SetDoc( 0,sTT,nDk,nVob,'', dDat, dDat, dDat, dDat,
													     sNlsA, sNmsA, GetBankMfo(), '', nKvA, Abs(nAcrD),  sOkpo,
													     sNlsB, sNmsB, GetBankMfo(), '', nKvB, NUMBER_Null, sOkpoA,
													     sNazn,'',sOperID,'',NUMBER_Null,0)
											If not cDocInt.oDoc()
												Call SqlRollback(hSql())
												Break
									Else
										Call SqlRollback(hSql())
										Break
								If not SqlPrepareAndExecute( hSql(),"DELETE FROM acr_intN WHERE rowid=:sRowID")
									Call SqlRollback(hSql())
									Break
							Else
								Call SqlRollback(hSql())
								Break
							Set nCount=nCount + 1
							Call SalSendMsg(win_meter, UM_Populate, 0, nCount)
						Call SqlCommit(hSql())
						Call SalStatusSetText(hWndForm, "Проводки-Готово")
					Call SalDestroyWindow(win_meter)
			Function: CP_int 
				Description: Вычисление % по графику купонных выплат по методу=8, для ЦБ)
				Returns
					Number:
				Parameters
					Number: nMetr   ! Спец.метод
					Number: nAcc    ! внутренний номер счета
					Number: nId     ! ид начисления
					Date/Time: dDat1
					Date/Time: dDat2
					Number: nOst
					Number: nMode   ! режим  Play/Real
				Static Variables
				Local variables
					Number: nInt
				Actions
					! Call Debug('nAcc='||Str(nAcc) ||','||Str(nId)||','||
							SalFmtFormatDateTime(dDat1, 'dd.MM.yyyy' ) ||','||
							SalFmtFormatDateTime(dDat2, 'dd.MM.yyyy' ) ||',' )
					If SqlPLSQLCommand(hSql(),   "INT_CP_P( nMetr,nAcc,nId,dDat1,dDat2,nInt,nOst,nMode)")
						! Call Debug('y')
						Return nInt
					Call SqlRollback(hSql())
					Return 0
			Function: INT_METR_A
				Description: Фiксована сума з Ануiт.платежу
				Returns
					Number:
				Parameters
					Number: nAccc  ! Acc  8999
					Number: nAcc    ! внутренний номер счета 2203
					Number: nId     ! ид начисления = 0
					Date/Time: dDat1
					Date/Time: dDat2
					Number: nOst
					Number: nMode   ! режим  Play/Real
				Static Variables
				Local variables
					Number: nInt
				Actions
					! Call Debug('**nAcc='||Str(nAccc) ||','||Str(nAcc)||','||
							SalFmtFormatDateTime(dDat1, 'dd.MM.yyyy' ) ||','||
							SalFmtFormatDateTime(dDat2, 'dd.MM.yyyy' )  )
					If SqlPLSQLCommand(hSqlAux2(),
							   "CCK.INT_METR_A(nAccc,nAcc,nId,dDat1,dDat2,nInt,nOst,nMode)")
						! Call Debug('y')
						Return nInt
					Call SqlRollback(hSqlAux2())
					Return 0
			Function: int_OVRP 
				Description: Вычисление % по любому счету за интервал  по методу=7, Плавающая % ст (для овердрафта)
				Returns
					Number:
				Parameters
					Number: nAcc    ! внутренний номер счета
					Number: nId     ! ид начисления
					Date/Time: dDat1
					Date/Time: dDat2
					Number: nOst
					Number: nMode   ! режим  Play/Real
				Static Variables
				Local variables
					Number: nInt
				Actions
					If SqlPLSQLCommand(hSql(),
							   "OVR.INT_OVRP(nAcc,nId,dDat1,dDat2,nInt,nOst,nMode)")
						Return nInt
					Call SqlRollback(hSql())
					Return 0
			Function: CC_KOMISSIA
				Description: Вычисление % по любому счету за интервал  по методу=7, Плавающая % ст (для овердрафта)
				Returns
					Number:
				Parameters
					Number: METR_   ! Код методики
					Number: nAcc    ! внутренний номер счета
					Number: nId     ! ид начисления
					Date/Time: dDat1
					Date/Time: dDat2
					Number: nOst
					Number: nMode   ! режим  Play/Real
				Static Variables
				Local variables
					Number: nInt
				Actions
					If SqlPLSQLCommand(hSql(),
							   "CC_KOMISSIA (METR_, nAcc,nId,dDat1,dDat2,nInt,nOst,nMode)")
						Return nInt
					Call SqlRollback(hSql())
					Return 0
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
			Functional Class: cDocDpu
				Description: ПІДМІНА РАХУНКА 8-го КЛАСУ НА РАХУНОК 2-го (для депозитних ліній ЮО)
				Derived From
					Class: cDoc
				Class Variables
				Instance Variables
					String: sTmpNlsA
					String: sTmpNlsB
					String: sTmpNamA
					String: sTmpNamB
					Number: nKvA_
					Number: nKvB_
					String: sNlsA_
					String: sNlsB_
					String: sNamA_
					String: sNamB_
					Number: nFetchRes
				Functions
					Function: f_get_GEN_NLS
						Description: Пошук рахунків генерального договору
						Returns
							Boolean:
						Parameters
							String: sNLS
							Number: nKV
							Receive String: sNLS_GEN
							Receive String: sNMK_GEN
						Static Variables
						Local variables
							Number: nFetchRes
						Actions
							If SalStrMidX(sNLS, 0, 1) = '8'
								! If GetGlobalOption( 'DPT_BANK_TYPE' ) = 'NADRA'
								If NOT SqlPrepareAndExecute( hSql(),
										" SELECT  a.nls, substr(c.nmk,1,38)
										         INTO  :sNLS_GEN, :sNMK_GEN
										       FROM  V_DPU_RELATION_ACC d,  ACCOUNTS a,  CUSTOMER c
										   WHERE  d.DEP_ACC = (SELECT ACC FROM ACCOUNTS WHERE NLS = :sNLS AND KV = :nKV)
										          AND  d.gen_acc = a.acc
										          AND  a.rnk = c.rnk " )
										OR NOT SqlFetchNext( hSql(), nFetchRes )
									Return FALSE
								Else
									Return TRUE
								! << Старий запит для рахунків зв'язаних по (acc = accc) >>
								! If NOT SqlPrepareAndExecute(hSql(), 
										" SELECT  b.nls, substr(c.nmk,1,38)
										         INTO  :sNLS_GEN, :sNMK_GEN
										       FROM  accounts a, accounts b, cust_acc cb, customer c
										   WHERE  a.nls = :sNLS
										          AND  a.kv = :nKV
										          AND  a.accc = b.acc
										          AND  nvl(substr(a.nbs,1,1),0) IN ('0','8')
										          AND  cb.acc = b.acc
										          AND  cb.rnk = c.rnk ")
										OR NOT SqlFetchNext(hSql(), nFetchRes)
									                    Return FALSE
							Else
								Return FALSE
					Function: oDoc
						Description: Вставить и оплатить документ
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							If m_sTT = 'DU%'
								Set nKvA_ = A.Kv
								Set sTmpNlsA = A.Nls
								Set sTmpNamA = A.Nam
								Set nKvB_ = B.Kv
								Set sTmpNlsB = B.Nls
								Set sTmpNamB = B.Nam
								If NOT f_get_GEN_NLS( sTmpNlsA, nKvA_, sNlsA_, sNamA_)
									Set sNlsA_ = A.Nls
									Set sNamA_ = A.Nam
								If NOT f_get_GEN_NLS( sTmpNlsB, nKvB_, sNlsB_, sNamB_)
									Set sNlsB_ = B.Nls
									Set sNamB_ = B.Nam
							Return cDoc.oDoc()
					Function: iDoc
						Description:
						Returns
						Parameters
						Static Variables
						Local variables
						Actions
							If m_sTT = 'DU%'
								Set A.Nls = sNlsA_
								Set A.Nam = sNamA_
								Set B.Nls = sNlsB_
								Set B.Nam = sNamB_
								If NOT cDoc.iDoc()
									Return FALSE
								Set A.Nls = sTmpNlsA
								Set A.Nam = sTmpNamA
								Set B.Nls = sTmpNlsB
								Set B.Nam = sTmpNamB
								Return TRUE
							Else
								Return cDoc.iDoc()
					Function: sDoc
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							If m_sTT = 'DU%'
								Set A.Nls = sNlsA_
								Set A.Nam = sNamA_
								Set B.Nls = sNlsB_
								Set B.Nam = sNamB_
								If NOT cDoc.sDoc()
									Return FALSE
								Set A.Nls = sTmpNlsA
								Set A.Nam = sTmpNamA
								Set B.Nls = sTmpNlsB
								Set B.Nam = sTmpNamB
								Return TRUE
							Else
								Return cDoc.sDoc()
		Default Classes
			MDI Window: cBaseMDI
			Form Window:
			Dialog Box:
			Table Window:
			Quest Window:
			Data Field:
			Spin Field:
			Multiline Field:
			Pushbutton: ctb_pbFilter
			Radio Button:
			Option Button:
			Check Box:
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
			Custom Control:
		Application Actions
			On SAM_AppStartup
	Table Window: tblAcrInt		!! 01 начисление %%
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title:
		Icon File:
		Accesories Enabled? Class Default
		Visible? Class Default
		Display Settings
			Visible at Design time? Yes
			Automatically Created at Runtime? No
			Initial State: Normal
			Maximizable? Class Default
			Minimizable? Class Default
			System Menu? Class Default
			Resizable? Class Default
			Window Location and Size
				Left:   3.45"
				Top:    1.0"
				Width:  16.05"
				Width Editable? Class Default
				Height: 6.655"
				Height Editable? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: Class Default
			Text Color: Class Default
			Background Color: Class Default
			View: Class Default
			Allow Row Sizing? No
			Lines Per Row: Class Default
		Memory Settings
			Maximum Rows in Memory: 5000
			Discardable? No
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Class Default
				Visible? Class Default
				Size: 0.476"
				Size Editable? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
			Contents
				!
				Pushbutton: pbAccrue
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cTBarButton
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   9.283"
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
					Picture File Name: \BARS98\RESOURCE\BMP\A_proc.bmp
					Picture Transparent Color: Gray
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							! Set strTip = 'Начислить  % по указанную дату вкл'
							Set strTip = CurrentLangTable.GetAtomTitle('tblAcrInt.cBTipAccrue')
						On SAM_Click
							If bAccrue = 0 
								If SalMessageBox(CurrentLangTable.GetAtomTitle('tblAcrInt.cTMess1') || ' ' ||
										   SalFmtFormatDateTime(df2dat, 'dd/MM/yyyy') || IifS(SalStrLength(SalStrTrimX(sFilt)), ', ' ||
										   CurrentLangTable.GetAtomTitle('tblAcrInt.cTMess12'), ' ' ||
										   CurrentLangTable.GetAtomTitle('tblAcrInt.cTMess13')) || PutLf() || IifS(obCompres, '+ ', 'Без ') ||
										   CurrentLangTable.GetAtomTitle('tblAcrInt.cBTipCompres') || ' ?', '%%', MB_YesNo | MB_IconQuestion) = IDYES
									Set dVdat = dDat 
									Set bZO = FALSE
									! Если мы на Украине 
									If GetBaseVal() = 980 
										! Если yyyyMM(текущего дня) Больше yyyyMM (df2dat)
										If SalFmtFormatDateTime(dDat, 'yyyyMM') > SalFmtFormatDateTime(df2dat,'yyyyMM')
											! dd(тек.дня) Меньше или Равно ДНЮ действия ЗО (из PARAMS)  Day_ZO
											! Call Debug('1. dDat =   ' || SalFmtFormatDateTime(dDat,   'dd/MM/yyyy'))
											! Call Debug('2. df2dat = ' || SalFmtFormatDateTime(df2dat, 'dd/MM/yyyy'))
											If SqlPrepareAndExecute(hSql(), "
													   SELECT trim(val)
													   into   :Day_ZO
													   from   PARAMS
													   where  upper(par)='DAY_ZO'") and SqlFetchNext(hSql(), nFetchRes)
												! Call Debug('3. Day_ZO = ' || Day_ZO)
												If Val(Day_ZO) >= SalDateDay(dDat)
													! Достанем последний раб день пред мес
													If SqlPrepareAndExecute(hSql(), "
															   SELECT max(FDAT)
															   into   :dTmp
															   from   fdat 
															   where  to_char(fdat,'yyyyMM')<to_char(:dDat,'yyyyMM')") and SqlFetchNext(hSql(), nFetchRes)
														! Call Debug('4. dTmp = ' ||SalFmtFormatDateTime( dTmp, 'dd/MM/yyyy' ))
														! Спросим согласие специалиста на кор.проводки
														If SalMessageBox('Виконати нарахування "Коригуючими" операціями за ' ||
																   SalFmtFormatDateTime(dTmp, 'dd/MM/yyyy') || ' ?', 'Увага !', MB_YesNo | MB_IconQuestion) = IDYES
															Set bZO   = TRUE
															Set nVob  = 96
															Set dVdat = dTmp
															! Call Debug('5. dVdat = ' || SalFmtFormatDateTime(dVdat, 'dd/MM/yyyy'))
									! Call Debug('e*' || sSALDO)
									Call Interest(IifN(sSALDO='ACCOUNTS', 0, 1), df2dat, sFiltP || ' ' || sFilt, sAddFrom)
									If obCompres
										Call IntCompres()
									Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
				Data Field: df2dat
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Property Template:
					Class DLL Name:
					Data
						Maximum Data Length: 10
						Data Type: Date/Time
						Editable? Yes
					Display Settings
						Window Location and Size
							Left:   7.083"
							Top:    0.131"
							Width:  2.1"
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
				Background Text: Начислить  по
					Resource Id: 49661
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   5.633"
						Top:    0.19"
						Width:  1.283"
						Width Editable? Yes
						Height: 0.167"
						Height Editable? Yes
					Visible? Yes
					Justify: Center
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
				Data Field: bgProc
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
				Pushbutton: pbTudaSuda
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbSynchro
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   10.283"
						Top:    0.071"
						Width:  0.433"
						Width Editable? Yes
						Height: 0.321"
						Height Editable? Yes
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: Default
					Font Size: Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\Tudasuda.bmp
					Picture Transparent Color: White
					Image Style: Single
					Text Color: Red
					Background Color: Default
					Message Actions
						On SAM_Click
							If bProvodki
								!
								Call SalShowWindow(tblAcrInt.cDk)
								Call SalShowWindow(tblAcrInt.cTT)
								Call SalHideWindow(tblAcrInt.cNMS)
								Call SalHideWindow(tblAcrInt.cNls)
								Call SalHideWindow(tblAcrInt.cLcv)
								Call SalShowWindow(tblAcrInt.cKvA)
								Call SalShowWindow(tblAcrInt.cNlsA)
								Call SalShowWindow(tblAcrInt.cKvB)
								Call SalShowWindow(tblAcrInt.cNlsB)
								! Call SalShowWindow(tblAcrInt.cAcrDQ)
								Call SalShowWindow(tblAcrInt.cAcrDQs)
								Call SalShowWindow(tblAcrInt.cNAZN)
								Call SalHideWindow(tblAcrInt.cDatF)
								Call SalHideWindow(tblAcrInt.cDatT)
								Call SalHideWindow(tblAcrInt.cIr)
								Call SalHideWindow(tblAcrInt.cBr)
								Call SalHideWindow(tblAcrInt.cOstss)
								Call SalHideWindow(tblAcrInt.cOstAs)
								! Проводки по начислению %%
								Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('tblAcrInt.cTTitle1'))
								! Set strTip = 'Показать начисленные %'
								Set strTip = CurrentLangTable.GetAtomTitle('tblAcrInt.cTTip1')
							Else
								! Call SalHideWindow(tblAcrInt.cAcrDQ )
								Call SalHideWindow(tblAcrInt.cAcrDQs)
								Call SalShowWindow(tblAcrInt.cNMS)
								Call SalShowWindow(tblAcrInt.cLcv)
								Call SalHideWindow(tblAcrInt.cNAZN)
								Call SalHideWindow(tblAcrInt.cTT)
								Call SalHideWindow(tblAcrInt.cDk)
								Call SalHideWindow(tblAcrInt.cKvA)
								Call SalHideWindow(tblAcrInt.cNlsA)
								Call SalHideWindow(tblAcrInt.cKvB)
								Call SalHideWindow(tblAcrInt.cNlsB)
								Call SalShowWindow(tblAcrInt.cNls)
								Call SalShowWindow(tblAcrInt.cDatF)
								Call SalShowWindow(tblAcrInt.cDatT)
								Call SalShowWindow(tblAcrInt.cIr)
								Call SalShowWindow(tblAcrInt.cBr)
								! Call SalShowWindow(tblAcrInt.cOsts)
								Call SalShowWindow(tblAcrInt.cOstss)
								! Call SalShowWindow(tblAcrInt.cOstA)
								Call SalShowWindow(tblAcrInt.cOstAs)
								! Начисление %%
								Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('tblAcrInt.cTTitle2'))
								! Set strTip = 'Показать проводки по %'
								Set strTip = CurrentLangTable.GetAtomTitle('tblAcrInt.cTTip2')
							Set bProvodki = NOT bProvodki
							Call SalTblDefineSplitWindow(hWndForm, 0, FALSE)
							Call ShowApdVersion('01')
							! Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
						On SAM_Create
							! Set strTip = 'Показать проводки по %'
							Set strTip = CurrentLangTable.GetAtomTitle('tblAcrInt.cBTipTudaSuda')
				Line
					Resource Id: 49663
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  10.833"
						Begin Y:  0.024"
						End X:  10.833"
						End Y:  0.488"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Line
					Resource Id: 49664
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  11.483"
						Begin Y:  0.024"
						End X:  11.483"
						End Y:  0.488"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Pushbutton: pbProvodki
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbExecute
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   10.983"
						Top:    0.071"
						Width:  0.433"
						Width Editable? Yes
						Height: 0.321"
						Height Editable? Yes
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\Execute.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_Create
							! Set strTip = 'Выполнить проводки по %'
							Set strTip = CurrentLangTable.GetAtomTitle('tblAcrInt.cBTipProvodki')
						On SAM_Click
							! Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
							! Переформирование ведомости для сброса сортировок пользователя (Inna)
							! Call Debug('ПРОВОДКИ')
							If not bRep
								! If SalMessageBox('Ведомость напечатали ?'), '%%', MB_IconQuestion | MB_YesNo) = IDNO
									   Return TRUE
								If SalMessageBox(CurrentLangTable.GetAtomTitle('tblAcrInt.cTMessVedomost'), '%%', MB_IconQuestion | MB_YesNo) =
										   IDNO
									Return TRUE
							! Насильное формирование ведомости как защита от бестолковых пользователей (Inna)
							Set nRnk = 0
							Set sSab = ''
							Set bRep = TRUE
							Call SalSendMsg(hWndForm, UM_ObjActivate, 0, 0)
							Set bArc = FALSE
							Set nRnk = -1
							!
							Set nChoice = SalModalDialog(dlg_Mess, hWndForm)
							If nChoice = 2
								If SalMessageBox(CurrentLangTable.GetAtomTitle('tblAcrInt.cTMess2'), '%%', MB_YesNo | MB_IconQuestion) != IDYES
									Return TRUE
								! пароль для всех, кроме НБУ
								If not GetGlobalOption('NBUBANK')
									If not ShowInputPassword()
										Return TRUE
								Call SaveInfoToLog("Начисление %%. Выбран режим <Без проводок> [" || sFilNem || "]")
							If nChoice = 1 and bNoNlsKv
								Call SalMessageBox(CurrentLangTable.GetAtomTitle('tblAcrInt.cTMess4'), '%%', MB_Ok | MB_IconExclamation)
							If nChoice = 1 or nChoice = 2
								Set bOk  = TRUE
								Set nI   = 0
								Set sNd  = ''
								Set nAcc = 0
								Call SalTblSortRows(tblAcrInt, SalTblQueryColumnID(cNum), TRUE)
								Set nRow = TBL_MinRow
								While SalTblFindNextRow(tblAcrInt, nRow, 0, ROW_MarkDeleted)
									Call SalTblSetContext(tblAcrInt, nRow)
									Call SalTblSetFocusRow(tblAcrInt, nRow)
									Call SalTblSetRowFlags(tblAcrInt, nRow, ROW_Selected, TRUE)
									Set dfNrow = nRow + 1
									If nAcc != cAcc
										If bOk and nAcc
											Call SqlCommit(hSql())
											! If nRow > 2900
												   Call SalMessageBox( 'Переполнение таблицы. Часть данных не обработана.','Внимание', MB_IconExclamation )
												   Break 
										Set nAcc = cAcc
										Set bOk  = TRUE
									!
									If nRow >= 0 and (nChoice = 2 or nChoice = 1 and tblAcrInt.cKvA and tblAcrInt.cNlsA and tblAcrInt.cKvB and
											   tblAcrInt.cNlsB)
										If SqlPrepareAndExecute(hSql(), "
												   SELECT acr_dat,metr,s
												   INTO   :dDatT,:nMETR7,:nRemi
												   FROM   int_accN
												   WHERE  acc=:tblAcrInt.cAcc and id=:tblAcrInt.cId FOR UPDATE OF acr_dat NOWAIT")
											If SqlFetchNext(hSql(), nFetchRes)
												If (not dDatT or dDatT < tblAcrInt.cDatF) or nMETR7 = 7
													If SqlPrepareAndExecute(hSql(), "
															   UPDATE int_accN
															   SET    acr_dat=:tblAcrInt.cDatT,s=:tblAcrInt.cRemi
															   WHERE  acc=:tblAcrInt.cAcc and id=:tblAcrInt.cId") and SqlPrepareAndExecute(hSql(), "
															   DELETE
															   FROM   acr_intN
															   WHERE  rowid=:tblAcrInt.cRowid")
														If nChoice = 1
															!
															If tblAcrInt.cKvA = NUMBER_Null or tblAcrInt.cNlsA = STRING_Null or tblAcrInt.cKvB = NUMBER_Null or
																	   tblAcrInt.cNlsB = STRING_Null
																Call SqlRollback(hSql())
																Set bOk = FALSE
																! Не вказано код валюти нарахування для 
																Call SalMessageBox(CurrentLangTable.GetAtomTitle('tblAcrInt.cTMess3') || ':' || tblAcrInt.cNls,
																		     '%%', MB_Ok | MB_IconStop)
															Else
																! Валюта капитала = валюте %
																! Call Debug('выч сумму')
																If tblAcrInt.cKvA = tblAcrInt.cKvB
																	Set nVob = 6
																	Set nSummCorr = Abs(tblAcrInt.cAcrDQ)
																Else
																	Set nVob = 16
																	Set nSummCorr = GetSumX(Abs(tblAcrInt.cAcrDQ), dVdat, tblAcrInt.cKvA, tblAcrInt.cKvB)
																If bZO   !! %% враховуються в минулий місяць по даті валютування
																	Set nVob = 96
																! Call DebugN(nSummCorr)
																! Проверка на ненулевую сумму номинала и эквивалента (Инна, 06/12/2006)
																Set nSummCorr = SalNumberRound(nSummCorr)
																If tblAcrInt.cAcrDQ != 0 and nSummCorr != 0
																	If sTtsK and SalStrScan(sTtsK, tblAcrInt.cTT) >= 0
																		If GetBankMfo() = '353575' and nMETR7 = 91
																			! Для Глобы - комиссия по КП
																			Call cDoc.SetDoc(0, tblAcrInt.cTT, 1-tblAcrInt.cDk, nVob, sNd, dDat, dDat, dVdat, dVdat,
																					     tblAcrInt.cNlsB, tblAcrInt.cNMSB, GetBankMfo(), '', 980, Val(cAcrDs)*100, sOkpoA,
																					     tblAcrInt.cNlsA, tblAcrInt.cNMSA, GetBankMfo(), '', 980, Val(cAcrDs)*100,
																					     tblAcrInt.cOKPO, tblAcrInt.cNAZN, '', sOperID, '', NUMBER_Null, 0)
																		Else
																			Call cDoc.SetDoc(0, tblAcrInt.cTT, 1-tblAcrInt.cDk, nVob, sNd, dDat, dDat, dVdat, dVdat,
																					     tblAcrInt.cNlsB, tblAcrInt.cNMSB, GetBankMfo(), '', tblAcrInt.cKvB, nSummCorr, sOkpoA,
																					     tblAcrInt.cNlsA, tblAcrInt.cNMSA, GetBankMfo(), '', tblAcrInt.cKvA,
																					     Abs(tblAcrInt.cAcrDQ), tblAcrInt.cOKPO, tblAcrInt.cNAZN, '', sOperID, '', NUMBER_Null, 0)
																	Else
																		If GetBankMfo()= '353575' and nMETR7 = 91
																			! Для Глобы - комиссия по КП
																			Call cDoc.SetDoc(0, tblAcrInt.cTT, tblAcrInt.cDk, nVob, sNd,  dDat, dDat, dVdat, dVdat,
																					     tblAcrInt.cNlsA, tblAcrInt.cNMSA, GetBankMfo(), '', 980, Val(cAcrDs)*100,
																					     tblAcrInt.cOKPO, tblAcrInt.cNlsB, tblAcrInt.cNMSB, GetBankMfo(), '', 980,
																					     Val(cAcrDs)*100, sOkpoA, tblAcrInt.cNAZN, '', sOperID, '', NUMBER_Null, 0)
																		Else
																			Call cDoc.SetDoc(0, tblAcrInt.cTT, tblAcrInt.cDk, nVob, sNd, dDat, dDat, dVdat, dVdat,
																					     tblAcrInt.cNlsA, tblAcrInt.cNMSA, GetBankMfo(), '', tblAcrInt.cKvA,
																					     Abs(tblAcrInt.cAcrDQ), tblAcrInt.cOKPO, tblAcrInt.cNlsB, tblAcrInt.cNMSB, GetBankMfo(),
																					     '', tblAcrInt.cKvB, nSummCorr, sOkpoA, tblAcrInt.cNAZN, '', sOperID, '', NUMBER_Null, 0)
																	! Call Debug('Перед вызовом оплаты')
																	If cDoc.oDoc()
																		! Call Debug('оплата OK')
																		If bNBUvyt and not sNd
																			Set sNd = cDoc.m_sNd   ! Извращение НБУ: Вытяжка номера документа
																		If sACR_DAT   !! acr_dati
																			If not SqlPLSQLCommand(hSql(), sACR_DAT ||
																					   '(tblAcrInt.cAcc,tblAcrInt.cId,cDoc.m_nRef,dDatT,nRemi)')
																				Call SqlRollback(hSql())
																				Set bOk = FALSE
																		! Для архива по МБ
																		If SalStrLength(strPar02) > 11
																			Set nMBD_K = Val(Subs(strPar02, 12, 10))
																			If not SqlPrepareAndExecute(hSql(), "
																					   INSERT
																					   into   mbd_k_r (nd,ref)
																					   values (:nMBD_K,:cDoc.m_nRef)")
																				Call SqlRollback(hSql())
																				Set bOk = FALSE
																		Set nI = nI + bOk  ! +1 Или +0
																	Else
																		Call SqlRollback(hSql())
																		Set bOk = FALSE
																		! Call Debug('оплата NOT')
													Else
														Call SqlRollback(hSql())  !-- удалось проставить дату начисления
														Set bOk = FALSE
											Else
												Call SqlRollback(hSql())   !-- нету ничего 
												Set bOk = FALSE
										Else
											Call SqlRollback(hSql())   !-- не удалось залочить
											Set bOk = FALSE
									Call SalTblSetRowFlags(tblAcrInt, nRow, ROW_Selected, FALSE)
								If bOk and nAcc
									Call SqlCommit(hSql())
									Call SaveFInfoToLog('Всего выполнено проводок по %%' || SalNumberToStrX(nI, 0))
									Call MessageInfoEx('Готово.')
								Call SalWaitCursor(TRUE)
								Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
								Call SalWaitCursor(FALSE)
				Pushbutton: pbToMail
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cTBarButton
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   11.583"
						Top:    0.071"
						Width:  0.433"
						Width Editable? Yes
						Height: 0.321"
						Height Editable? Yes
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Picture File Name: \BARS98\RESOURCE\BMP\Tomail.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_Click
							Call SqlPrepareAndExecute(hSqlAux(), T("
									     SELECT k.rnk,k.sab
									     INTO   :nRnk,:sSab
									     FROM   acr_intN a, accounts s, customer k
									     WHERE  a.acc=s.acc AND s.rnk=k.rnk AND k.sab IS NOT NULL " || sFiltP || " " || sFilt || "
									     GROUP BY k.rnk,k.sab"))
							While SqlFetchNext(hSqlAux(), nFetchRes)
								If SalStrLength(SalStrTrimX(sSab)) > 0
									Call SalSendMsg(hWndForm, UM_ObjActivate, 0, 0)
						On SAM_Create
							! Set strTip = 'Отправить ведомость начисленных %%'
							Set strTip = CurrentLangTable.GetAtomTitle('tblAcrInt.cBTipToMail')
				Pushbutton: pbIns
					Class Child Ref Key: 33
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.183"
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
				Pushbutton: pbDel
					Class Child Ref Key: 34
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.683"
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
				Pushbutton: pbRefresh
					Class Child Ref Key: 35
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.183"
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
				Pushbutton: pbUpdate
					Class Child Ref Key: 36
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.683"
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
					Resource Id: 20867
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  5.483"
						Begin Y:  0.024"
						End X:  5.483"
						End Y:  0.488"
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
						Left:   2.383"
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
				Pushbutton: pbDetails
					Class Child Ref Key: 39
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.883"
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
						Left:   9.783"
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
					Picture File Name: \bars98\RESOURCE\BMP\EXCEL.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Click
							Call SalGetWindowText(hWndForm, tblAcrInt.strOldTitle, 99)
							Call TablePrint(hWndForm, tblAcrInt.strOldTitle, GetPrnDir() || '\\' || tblAcrInt.strPrintFileName, '')
				Pushbutton: pbPrintRep
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbPrint
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.883"
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
					Picture File Name: \BARS98\RESOURCE\BMP\print.bmp
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: 3D Face Color
					Message Actions
						On SAM_Create
							! Set strTip = 'Печать ведомости'
							Set strTip = CurrentLangTable.GetAtomTitle('tblAcrInt.cBTipPrint')
							Call SalDisableWindow(hWndItem)
						On SAM_Click
							Call DosDirectPrint(sFilNem)
				Line
					Resource Id: 20869
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  12.583"
						Begin Y:  0.024"
						End X:  12.583"
						End Y:  0.488"
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
						Left:   12.683"
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
					Resource Id: 20868
					Class Child Ref Key: 43
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  2.233"
						Begin Y:  0.024"
						End X:  2.233"
						End Y:  0.488"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbFilter
					Class Child Ref Key: 44
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.383"
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
							! Set strTip = 'Фильтр'
							Set strTip = CurrentLangTable.GetAtomTitle('tblAcrInt.cBTipFilter')
						On SAM_Click
							! Call SalModalDialog(dlg_ProcFilt, hWndForm , 'acr_int', sFilt)
							Set sFilt = ''
							If SetQueryFilter(cF)
								If cF.GetFilterWhereClause(FALSE)
									Set sFilt = 'AND '|| cF.GetFilterWhereClause(FALSE)
								If cF.GetFilterFromClause(FALSE)
									Set sAddFrom = ', '|| cF.GetFilterFromClause(FALSE)
							Call SalSendMsg(hWndForm,UM_Populate, 0, 0)
				! cTBarButton: pbCompres
.winattr class Pushbutton:
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cTBarButton
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   12.083"
						Top:    0.071"
						Width:  0.43"
						Width Editable? Yes
						Height: 0.317"
						Height Editable? Yes
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Picture File Name: \BARS98\RESOURCE\BMP\Summ.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
.end
					   Message Actions 
						   On SAM_Create
							! Set strTip = 'Сжатие информации'
							   Set strTip = CurrentLangTable.GetAtomTitle('tblAcrInt.cBTipCompres')
						   On SAM_Click
							   Call SalWaitCursor(TRUE)
							   If SalStrTrimX(SalStrUpperX(GetDBMS())) = 'ORACLE'
								   If SqlPrepareAndExecute(hSql(), "begin acrn.p_cnds; end;")
									   Call SqlCommit(hSql())
								   Else
									! Call SqlRollbackEx(hSql(), 'Неуспех при сжатии информации')
									   Call SqlRollbackEx(hSql(), CurrentLangTable.GetAtomTitle('tblAcrInt.cTErrInf'))
							   Else
								   Call SalMessageBox('Для Informix не реализовано.', 'Внимание.', MB_Ok)
							   Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
							   Call SalWaitCursor(FALSE)
				Pushbutton: pbPreView
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cTBarButton
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.383"
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
					Picture File Name: \BARS98\RESOURCE\BMP\Docview.bmp
					Picture Transparent Color: Gray
					Image Style: Class Default
					Text Color: Class Default
					Background Color: 3D Face Color
					Message Actions
						On SAM_Create
							! Set strTip = 'Просмотр файла печати'
							Set strTip = CurrentLangTable.GetAtomTitle('tblAcrInt.cBTipPreView')
							Call SalDisableWindow(hWndItem)
						On SAM_Click
							Call DirectView(sFilNem)
				Pushbutton: pbUnHideSum
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cTBarButton
					Property Template:
					Class DLL Name:
					Title: UnHide
					Window Location and Size
						Left:   11.533"
						Top:    0.095"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? No
					Keyboard Accelerator: F8
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
							! Call SalEnableWindow(tblAcrInt.cAcrD)
							Call SalEnableWindow(tblAcrInt.cAcrDs)
				Pushbutton: pbReport
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cTBarButton
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.883"
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
					Picture File Name: \BARS98\RESOURCE\BMP\Logfile.bmp
					Picture Transparent Color: Gray
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							! Set strTip = 'Сформировать ведомость'
							Set strTip = CurrentLangTable.GetAtomTitle('tblAcrInt.cBTipReport')
						On SAM_Click
							If bProvodki
								Set nRnk = 0
								Set sSab = ''
								Set bRep = TRUE
								Call SalSendMsg(hWndForm, UM_ObjActivate, 0, 0)
								Set bArc = FALSE
							Else
								Set sFilNem = GetFilNem('PRCN' || SalFmtFormatDateTime(tblAcrInt.df2dat, 'ddMM'))
								! Call TablePrint(tblAcrInt, 'Проводки по нарахованих відсотках', sFilNem, '')
								Call TablePrint(tblAcrInt, CurrentLangTable.GetAtomTitle('tblAcrInt.cTPrint'), sFilNem, '')
							Call SalEnableWindow(pbPrintRep)
							Call SalEnableWindow(pbPreView)
							! Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
				Pushbutton: pbArcReport
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cTBarButton
					Property Template:
					Class DLL Name:
					Title: ArcRep
					Window Location and Size
						Left:   11.667"
						Top:    0.107"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? No
					Keyboard Accelerator: F6
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
							If bProvodki
								Set bArc = TRUE
								! If SalMessageBox('Сформировать ведомость начисленных %% из АРХИВА?', 'Внимание!', MB_IconQuestion | MB_YesNo) =
										  IDYES
									   Call SalSendMsg(pbReport, SAM_Click, 0, 0)
								If SalMessageBox(CurrentLangTable.GetAtomTitle('tblAcrInt.cTMessArchiv'), CurrentLangTable.GetAtomTitle('cTAt'),
										   MB_IconQuestion | MB_YesNo ) = IDYES
									Call SalSendMsg(pbReport, SAM_Click, 0, 0)
				Data Field: dfNrow
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Property Template:
					Class DLL Name:
					Data
						Maximum Data Length: 5
						Data Type: Number
						Editable? No
					Display Settings
						Window Location and Size
							Left:   13.571"
							Top:    0.115"
							Width:  0.85"
							Width Editable? Yes
							Height: 0.25"
							Height Editable? Yes
						Visible? Yes
						Border? No
						Justify: Center
						Format: Unformatted
						Country: Default
						Font Name: Default
						Font Size: 10
						Font Enhancement: Bold
						Text Color: Default
						Background Color: 3D Face Color
						Input Mask: Unformatted
					Message Actions
				Option Button: obCompres
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   12.083"
						Top:    0.071"
						Width:  0.429"
						Width Editable? Yes
						Height: 0.321"
						Height Editable? Yes
					Visible? Yes
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Picture File Name: \BARS98\RESOURCE\BMP\Summ.bmp
					Picture Transparent Color: None
					Button Style: Check
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_TooltipSetText
							! Set sT = 'Сжатие информации'
							Return XSalTooltipSetText(lParam, IifS(obCompres, 'Без ', '+ ') ||
									       CurrentLangTable.GetAtomTitle('tblAcrInt.cBTipCompres'))
						On SAM_Click
							Call SalSendMsg(pbAccrue, SAM_Click, 0, 0)
		Contents
			Column: cIsp
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Исп
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
				Data Type: Number
				Justify: Right
				Width:  0.429"
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
			Column: cId
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Код
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
				Data Type: Number
				Justify: Right
				Width:  0.429"
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
			Column: cNMS
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Наименование
						счета
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.314"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cNls
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Счет
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.583"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cLcv
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Вал
						осн
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
				Data Type: Number
				Justify: Center
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
			Column: cTT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: ОП
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
				Data Type: String
				Justify: Center
				Width:  0.567"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cDk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Дб/
						 Кр
				Visible? Yes
				Editable? No
				Maximum Data Length: 1
				Data Type: Number
				Justify: Center
				Width:  0.417"
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
			Column: cNlsA
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Счет
						А
				Visible? Yes
				Editable? No
				Maximum Data Length: 14
				Data Type: String
				Justify: Left
				Width:  1.671"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cKvA
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Вал
						А
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
				Data Type: Number
				Justify: Center
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
			Column: cNMSA
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Наименование
						счета начисл.%%
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.314"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cNlsB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Счет
						Б
				Visible? Yes
				Editable? No
				Maximum Data Length: 14
				Data Type: String
				Justify: Left
				Width:  1.586"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cKvB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Вал
						Б
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
				Data Type: Number
				Justify: Center
				Width:  0.5"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cNMSB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Наименование
						счета ДохРас
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.314"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cDatF
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: С
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Left
				Width:  1.017"
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
			Column: cDatT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: По
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Left
				Width:  1.017"
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
			Column: cIr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: %
						Ставка
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
			Column: cBr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Базовая
						Ставка
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
			Column: cAcrD
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: !!!!!!!!!!!!!!!
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.433"
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
			Column: cRemi
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: %%
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.433"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cAcrDs
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: %%
						в номинале
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
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
					On SAM_Validate
						! Убираем все пробелы
						Set nScan = SalStrScan(cAcrDs, ' ')
						While nScan != -1
							Set cAcrDs = SalStrReplaceX(cAcrDs, nScan, 1, '')
							Set nScan = SalStrScan(cAcrDs, ' ')
						! Проверяем на str to number
						If not SalStrIsValidNumber(cAcrDs)
							! Call SalMessageBox('Неверно введена сумма', 'Внимание!', MB_Ok)
							Call SalMessageBox( CurrentLangTable.GetAtomTitle('tblAcrInt.cTErrSumm'), CurrentLangTable.GetAtomTitle('cTAt'),
									     MB_Ok)
							Return VALIDATE_Cancel
						! Переприсваиваем значения
						Set cAcrD  = cAcrD/Abs(cAcrD) * Abs(SalNumberRound(SalStrToNumber(cAcrDs) * SalNumberPower(10, cDig)))
						Set cAcrDs = Dig4(Abs(cAcrD)/100, cDig, nMaxDig)
						Set cAcrDf = cAcrD * SalNumberPower(10, -cDig)
						! Валюта счета осн.капитала НЕ = валюте счета нач %% (Сухова)
						Set cAcrDQ = cAcrD
						If cLcv != cKvA
							! If cKvA = n980
								   Set sTmp_Sql = "gl.p_Icurval(:cLcv,:cAcrD,:dVdat)"
							! Else If cLcv = n980
								   Set sTmp_Sql = "gl.p_Ncurval(:cKvA,:cAcrD,:dVdat)"
							! Else
								   Set sTmp_Sql = "gl.p_Ncurval(:cKvA,gl.p_Icurval(:cLcv,:cAcrD,:dVdat),:dVdat)"
							! If SqlPrepareAndExecute(hSqlAux2(), "
									   SELECT " || sTmp_Sql || "
									   into   :cAcrDQ
									   from   dual") and SqlFetchNext(hSqlAux2(), nFetchRes)
							Set cAcrDQ = GetSumX(cAcrD, dVdat, cKvA, cLcv)
						Set cAcrDQ  = Abs(cAcrDQ)
						Set tblAcrInt.cAcrDQs = Dig4(Abs(tblAcrInt.cAcrDQ)/100, cDigA, nMaxDig)
						Set tblAcrInt.cAcrDQf = tblAcrInt.cAcrDQ * SalNumberPower(10, -cDigA)
						Return VALIDATE_Ok
			Column: cAcrDQ
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: %%
						вал-А
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.3"
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
			Column: cAcrDQf
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title:
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
			Column: cAcrDQs
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Сумма %%
						вал-А
				Visible? Yes
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Class Default
				Justify: Right
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
			Column: cAcrDf
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: %%
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.433"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cOsts
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: % число 
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.683"
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
			Column: cOstss
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: % число 
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
				Width:  1.683"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cOstsf
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: % число 
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.683"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cOstA
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Текущий
						остаток 
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.683"
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
			Column: cOstAs
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Текущий
						остаток 
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
				Width:  1.683"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cOstAf
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Текущий
						остаток 
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.683"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cNAZN
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Назначение платежа
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 160
				Data Type: String
				Justify: Left
				Width:  7.0"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cRowid
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: RowId
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
			Column: cAcc
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Внутр № счета
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
			Column: cNMK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Наименование
						клиента
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.314"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cOKPO
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: ОКПО
						Клиента
				Visible? No
				Editable? No
				Maximum Data Length: 10
				Data Type: String
				Justify: Left
				Width:  3.314"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cDig
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: dig
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
			Column: cDigA
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
			Column: cBran4
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Подразделение
				Visible? Class Default
				Editable? No
				Maximum Data Length: Default
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
			Column: cRNK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: РНК клієнта
				Visible? Class Default
				Editable? No
				Maximum Data Length: Default
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
			Column: cND
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Референс 
						договору
				Visible? Class Default
				Editable? No
				Maximum Data Length: Default
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
			Column: cCC_ID
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: № договору
				Visible? Class Default
				Editable? No
				Maximum Data Length: Default
				Data Type: Class Default
				Justify: Left
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
			Column: cTip
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Тип сч
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
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
			Column: cNum
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title:
				Visible? No
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
				List Values
				Message Actions
		Functions
			Function: SetColorRow
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
					If cOsts < 0 
						Set nInd = COLOR_Red
						Set cOsts = -cOsts
					Else If cOsts > 0
						Set nInd = COLOR_DarkBlue
					Else
						Set nInd = COLOR_Black
					Call SalTblSetCellTextColor(cOsts, nInd, FALSE)
					Call SalTblSetCellTextColor(cOstss, nInd, FALSE)
					If cOstA < 0
						Set nInd = COLOR_Red
						Set cOstA = -cOstA
					Else If cOstA > 0
						Set nInd = COLOR_DarkBlue
					Else
						Set nInd = COLOR_Black
					Call SalTblSetCellTextColor(cOstA, nInd, FALSE)
					Call SalTblSetCellTextColor(cOstAs, nInd, FALSE)
					If cAcrD < 0
						Set nInd = COLOR_Red
						! Set cAcrD = -cAcrD
					Else If cAcrD > 0
						Set nInd = COLOR_DarkBlue
					Else
						Set nInd = COLOR_Black
					! Call SalTblSetCellTextColor(cAcrD, nInd, FALSE)
					Call SalTblSetCellTextColor(cAcrDs, nInd, FALSE)
			Function: GetFilNem
				Description: Ищет "свободное" имя файла
				Returns
					String:
				Parameters
					String: sFn
				Static Variables
				Local variables
					Number: i
					String: sTmp
					Date/Time: dDatTmp
				Actions
					Set i=0
					While i <= 999
						Set sTmp = GetPrnDir() || '\\' || sFn || '.' || SalFmtFormatNumber(i, '000')
						If SalFileGetDateTime(sTmp, dDatTmp)
							Set i = i + 1
						Else
							Break
					Return sTmp
			Function: sTranN ! Трансляция формул в назначении платежа
				Description:
				Returns
					Boolean:
				Parameters
					Receive String: rsNazn
					String: sNazn     !! Исходная строка
					String: sTT       !! Тип операции
					String: sNls      !! Основной счет 
					Number: nKv       !! Код вал основного счета
					String: sNls1     !! Счет-А
					String: sBank1    !! МФО-А
					Number: nKv1      !! Код вал-А
					Number: nS1       !! Сумма-А
					String: sNls2     !! Счет-Б
					String: sBank2    !! МФО-Б
					Number: nKv2      !! Код вал-Б
					Number: nS2       !! Сумма-Б
					String: sRat      !! Запись о курсе
					String: sDatF     !! Запись о дате начала
					String: sDatT     !! Запись о дате конца
					String: TIP_      !! Тип сч
					Number: ACC_      !! АСС сч
				Static Variables
				Local variables
					String: S    !
					String: S2   ! для
					String: Kv   !
					String: KvA  ! при вычислении суммы операции
					String: KvB  !
					!
					String: sS
					String: sFormula
					String: sNazD
					Number: i
					Number: j
					Number: nFetchRes
					Number: nLen
				Actions
					!
					Set sS = sNazn
					Set i = SalStrScan(sS, '?')
					While i >= 0 and (SalStrMidX(sS, i+3, 1) = ' ' or SalStrMidX(sS, i+3, 1) = STRING_Null) and
							      SalStrMidX(sS, i+1, 1) >= '0' and SalStrMidX(sS, i+1, 1) <= '9' and SalStrMidX(sS, i+2, 1) >= '0' and
							      SalStrMidX(sS, i+2, 1) <= '9'
						Call SqlPrepareAndExecute(hSql(), "
								     SELECT TRIM(txt)
								     INTO   :sNazD
								     FROM   tnaznf
								     WHERE  n=" || SalStrMidX(sS, i+1, 2))
						If SqlFetchNext(hSql(), nFetchRes)
							Set sS = SalStrLeftX(sS, i) || '#{' || SalStrTrimX(sNazD) || '}' || SalStrRightX(sS, SalStrLength(sS)-i-3)
						Else
							Break
						Set i = SalStrScan(sS, '?')
					Set rsNazn = sS
					If SalStrScan(sS,'#{') < 0 and SalStrScan(sS, '#(') < 0
						Return TRUE
					Else
						Set S   = SalNumberToStrX(nS1, 0)  ! Сумма платежа
						Set S2  = SalNumberToStrX(nS2, 0)  ! Сумма платежа
						Set Kv  = SalNumberToStrX(nKv, 0)  ! Код валюты основного счета
						Set KvA = SalNumberToStrX(nKv1, 0) ! Код валюты А
						Set KvB = SalNumberToStrX(nKv2, 0) ! Код валюты B
						Set sS = ' ' || sS                 ! SalStrUpperX(' ' || sS)
						While SalStrScan(sS, '#(TIP)') > 0
							Set sS = SalStrReplaceX(sS, SalStrScan(sS, '#(TIP)'), 6, TIP_)
						While SalStrScan(sS, '#(ACC)') > 0
							Set sS = SalStrReplaceX(sS, SalStrScan(sS, '#(ACC)'), 6, Str(ACC_))
						While SalStrScan(sS, '#(S)') > 0
							Set sS = SalStrReplaceX(sS, SalStrScan(sS, '#(S)'), 4, S)
						While SalStrScan(sS, '#(S2)') > 0
							Set sS = SalStrReplaceX(sS, SalStrScan(sS, '#(S2)'), 5, S2)
						While SalStrScan(sS,'#(NLS)') > 0
							Set sS = SalStrReplaceX(sS, SalStrScan(sS, '#(NLS)'), 6, sNls)
						While SalStrScan(sS,'#(NLSA)') > 0
							Set sS = SalStrReplaceX(sS, SalStrScan(sS, '#(NLSA)'), 7, sNls1)
						While SalStrScan(sS,'#(NLSB)') > 0
							Set sS = SalStrReplaceX(sS, SalStrScan(sS, '#(NLSB)'), 7, sNls2)
						While SalStrScan(sS,'#(MFOA)') > 0
							Set sS = SalStrReplaceX(sS, SalStrScan(sS, '#(MFOA)'), 7, sBank1)
						While SalStrScan(sS,'#(MFOB)') > 0
							Set sS = SalStrReplaceX(sS, SalStrScan(sS, '#(MFOB)'), 7, sBank2)
						While SalStrScan(sS,'#(KV)') > 0
							Set sS = SalStrReplaceX(sS, SalStrScan(sS, '#(KV)'), 5, Kv)
						While SalStrScan(sS,'#(KVA)') > 0
							Set sS = SalStrReplaceX(sS, SalStrScan(sS, '#(KVA)'), 6, KvA)
						While SalStrScan(sS,'#(KVB)') > 0
							Set sS = SalStrReplaceX(sS, SalStrScan(sS, '#(KVB)'), 6, KvB)
						While SalStrScan(sS,'#(TT)') > 0
							Set sS = SalStrReplaceX(sS, SalStrScan(sS, '#(TT)'), 5, "'" || sTT || "'")
						While SalStrScan(sS,'#(RAT)') > 0
							Set sS = SalStrReplaceX(sS, SalStrScan(sS, '#(RAT)'), 6, sRat)
						While SalStrScan(sS,'#(DAT1)') > 0
							Set sS = SalStrReplaceX(sS, SalStrScan(sS, '#(DAT1)'), 7, "'" || sDatF || "'")
						While SalStrScan(sS,'#(DAT2)') > 0
							Set sS = SalStrReplaceX(sS, SalStrScan(sS, '#(DAT2)'), 7, "'" || sDatT || "'")
						Set i = SalStrScan(sS, '#{')
						While i>=0
							Set sFormula = SalStrMidX(sS, i+2, SalStrLength(sS)-i-2)
							Set j = SalStrScan(sFormula, '}')
							If j >= 0
								Set sFormula = SalStrLeftX(sFormula, j)
								If not SqlPrepareAndExecute(hSql(), "
										   SELECT SUBSTR(" || sFormula || ",1,160)
										   INTO   :sNazD
										   FROM   dual")
									Return FALSE
								If not SqlFetchNext(hSql(),nFetchRes)
									Return FALSE
								Set sS = SalStrLeftX(sS, i) || SalStrTrimX(sNazD) || SalStrRightX(sS, SalStrLength(sS)-j-i-3)
							Set i = SalStrScan(sS, '#{')
						Set rsNazn = SalStrTrimX(sS)
						! Set bbbb = Str(SalStrLength(rsNazn)) || '*' || rsNazn || '*'
					Return TRUE
			Function: GetSumX 
				Description: Вычисление суммы в валюте Б
				Returns
					Number:
				Parameters
					Number: nSum
					Date/Time: dDat
					Number: nKvA
					Number: nKvB
				Static Variables
				Local variables
					! Number: nRatO
					! Number: nRatB
					! Number: nRatS
					Number: nSumX
				Actions
					If nKvA = nKvB
						Return nSum
					Else
						If nKvA = n980 and nKvB != n980
							Set sTmp = "gl.p_Ncurval(:nKvB,:nSum,:dDat)"
						Else If nKvA != n980 and nKvB = n980
							Set sTmp = "gl.p_Icurval(:nKvA,:nSum,:dDat)"
						Else
							Set sTmp = "gl.p_Ncurval(:nKvA,gl.p_Icurval(:nKvB,:nSum,:dDat),:dDat)"
						! Call Debug('SQL: ' || sTmp || ',' || Str(nKvA) || ',' || Str(nKvB) || ',' || Str(nSum) || ',' ||
								     SalFmtFormatDateTime(dDat, 'dd/MM/yyyy'))
						If SqlPrepareAndExecute(hSqlAux(), "
								   SELECT " || sTmp || "
								   INTO   :nSumX
								   FROM   dual") and SqlFetchNext(hSqlAux(), nFetchRes)
						! Call Debug('SQL: После ' || Str(nSumX))
						Return nSumX
						! If SqlPLSQLCommand(hSqlAux(), "gl.x_rat(nRatO,nRatB,nRatS,nKvA,nKvB,dDat)")
							   Set nSumEqv = nSum * nRatO * SalNumberPower(10, nDig980-cDig)
							   Return nSumEqv
						! Else
							   Return NUMBER_Null
			Function: IsHolyDay
				Description:
				Returns
					Boolean:
				Parameters
					Number: nKv
					Date/Time: dDat
				Static Variables
				Local variables
					Number: nn
				Actions
					Call SqlPrepareAndExecute( hSql(), "
							     SELECT kv
							     INTO   :nn
							     FROM   holiday
							     WHERE  kv=:nKv and holiday=" || DateInQuery(SalFmtFormatDateTime(dDat, 'MM/dd/yyyy')))
					Return SqlFetchNext(hSql(), nFetchRes)
			Function: GetRateInStr
				Description: отображение инд.ставки в назначении платежа
				Returns
					String:
				Parameters
					Number: nRate
				Static Variables
				Local variables
					String: sA
					String: sRate
					Number: nT
					Number: nRate4
				Actions
					! Раньше:
					! проц.ставка в назначении платежа обрезалась до 4-х знаков после запятой
					! Теперь:
					! обычные ставки показываются, как и прежде, - 99.9999
					! ставки с >=5 знаками после запятой показываются как есть - 99.999999
					Set sA = Str(nRate)
					Set nT = Max(At('.', sA), At(',', sA))
					Set nRate4 = Val(IifS(nT > 0, Left(sA, nT) || Subs(sA, nT + 1, 4), sA))
					If nRate <= nRate4 
						Set sRate = SalNumberToStrX(nRate, 4)
					Else
						Set sRate = Str(nRate)
					Return sRate
			Function: DeData ! Виділити дату з рядка параметрів
				Description:
				Returns
					String:
				Parameters
					String: sStr
				Static Variables
				Local variables
					String: sTmp
					Number: nChr
				Actions
					Set sTmp = ''
					While SalStrFirstC(sStr, nChr)
						If nChr >= 48 and nChr <= 57
							Set sTmp = sTmp || SalNumberToChar(nChr)
					Return sTmp
		Window Parameters
			Number: nPar      ! 0 - по серьйозному, 1 - побаловаться
			String: sFiltP    ! Внешний фильтр
			String: strPar02  ! В ведомости "наименование"  S/K  счета или клиента + [дата]
		Window Variables
			Number: bAccrue
			String: sSALDO
			Number: nAccess ! Для манипулирования с процентной карточкой
					                  nAccess = ACCESS_READONLY (=2)  Только просмотр
					                  иначе с РЕДАКТИРОВАНИЕМ
			: cF
				Class: cGenFilter
			String: sPar
			Date/Time: dDatT
			!
			Number: n980
			String: sTmp_Sql
			!
			String: Day_ZO !! ДЕНЬ действия ЗО (из PARAMS)
			Date/Time: dTmp
			!
			Number: nMBD_K
			Number: nInd
			Number: nUserID
			Number: nVob
			Number: nOsts
			Number: nOstc
			Number: nAcrD
			Number: nColo
			Number: nRow
			Number: nRnk
			Number: nMETR7
			Number: nRemi
			Number: nAcc
			String: sFilt
			String: sAddFrom
			String: sRat
			Boolean: bProvodki
			Boolean: bOk
			Long String: lsSign
			String: sOkpoA
			! String: sOkpoB
			String: sNBS
			String: sOperID
			!
			String: sSab
			Number: nErrorSign
			Boolean: bRep
			Boolean: bArc   ! Признак печати ведомости начисленных %% из архива
			Boolean: bIsp   ! Признак печати кода исполнителя ведомости начисленных %%
			Boolean: bZO    ! Признак заключительных оборотов (виправних проводок)
			Boolean: bCmp   ! Сжимать проценты-1  или нет-0
			Boolean: bOba   ! Признак вычисления оборотного баланса
			Number: nOba	! Сума оборотного баланса
			Date/Time: dBdat_arc
			Number: nUser_arc
			Number: arcISP
			Number: arcKV
			String: arcNLS
			Date/Time: arcDAT
			Date/Time: arcDAT2
			String: arcNAM
			!
			String: strErrorSign
			String: strSqlPopulate
			Number: nFetchRes
			Date/Time: dDatTmp
			Date/Time: dDat
			String: sFilNem
			Number: nChoice
			String: sTT
			String: sBankMfo
			String: sBankName
			Number: nI
			String: sNms
			! cDoc: cDoc
.winattr class :
				Class: cDoc
.end
			: cDoc
				Class: cDocDpu
			!
			String: strBind
			String: strInput
			String: sTmp
			Date/Time: dFdat
			Date/Time: dTdat
			Date/Time: dVdat  ! Дата валютирования
			Number: nIr
			Number: nBr
			String: sKv
			String: sBal
			String: sNls
			Number: nTmp
			Number: nId
			Number: nId0
			Number: nKv
			Number: nKv0
			Number: nIsp
			!
			Number: nMetr
			String: sTYPNACH
			String: sVALNAME
			String: sDeviceDef
			String: sDriverDef
			String: sPortDef
			String: sNAZN
			Number: nNaznNoRate
			Number: nMaxDig
			Number: nScan
			Number: nSummCorr
			!
			String: sTtsK        ! список операций для переворота в кредитовые
			Number: NACH_
			String: sNd          ! номер документа для НБУ (извр)
			Boolean: bNoNlsKv    ! флаг отсутствия номера счета или валюты в проекте проводок
			Boolean: bNBUvyt     ! флаг для извращенного номера документа НБУ
			Boolean: bTTSNazn    ! флаг для чтения формулы назначения платежа из TTS
			String: sACR_DAT     ! Флаг-название процедуры ведения истории дат начисления и проводок
			Number: nFindBoss    ! флаг для чтения ФИО распорядителя средств в ведомости нач.%% из спр-ка INT_STAFF
			String: sBossFio
			Number: nDig
			Number: nDig980
			!
			Number: nHaveTobo
			String: sColName4Branch
			String: sTblName4Branch
			String: sWhereCl4Branch
			String: strPar1
			!
			! Number: nJ
			! Window Handle: hWndChild
		Message Actions
			On SAM_Create
				Call SalCenterWindow(hWndForm)
				Call SetWindowFullSize(hWndForm)
				Call SetWindowFont(hWndForm)
				! Присваиваем значения многоязыковым объектам
				Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
				Set tblAcrInt.nTabInstance = 1
				Set tblAcrInt.strFilterTblName = 'Bars010'
				Set n980  = GetBaseVal()
				Set dDat  = GetBankDate()
				Set dVdat = dDat !! дата валютирования
				Set nDig980 = Val(GetValueStr("select dig from tabval where kv=" || Str(n980)))
				!
				If nPar = 1
					Call SalHideWindow(pbProvodki) 
					Call SalHideWindow(pbToMail)
				If GetAccountStructure(nTmp, nTmp, nTmp, nTmp) ! Прижимать влево или вправо
					Call SalTblSetColumnFlags(cNls,  COL_RightJustify, TRUE)
					Call SalTblSetColumnFlags(cNlsA, COL_RightJustify, TRUE)
					Call SalTblSetColumnFlags(cNlsB, COL_RightJustify, TRUE)
				Set sNAZN = GetGlobalOption('NAZN_%')
				Set sTtsK = GetGlobalOption('TTSK_%')
				Set sACR_DAT    = GetGlobalOption('ACR_DATS')  ! Проц.история дат начисления и проводок
				Set nFindBoss   = GetGlobalOptionEx('BOSS_%')
				Set bOba        = GetGlobalOptionEx('OBAL_%')  ! В ведомости вычислять оюоротный баланс
				Set obCompres   = GetGlobalOptionEx('KOMP_%')  ! Автоматически сжимать начисленные проценты
				Set nNaznNoRate = GetGlobalOptionEx('NAZN_R_%')
				If GetGlobalOption('NBUD_%')
					Set bNBUvyt = 1
				If GetGlobalOption('NAZNF%')
					Set bTTSNazn = 1
				If GetGlobalOption('NACH%') = '0'
					Set NACH_ = 0
				Else
					Set NACH_ = 1
				Call SetWindowFont(hWndForm)
				Call SetWindowFullSize(hWndForm)
				! Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
				! Set sFilt = sFiltP
				Set nFlags = GT_NoRet | GT_NoIns
				Set sOkpoA = GetBankOkpoS()
				! Set sOkpoB = GetBankOkpoS()
				Set sOperID = GetIdOper()
				Set nUserID = GetUserId()
				Set sBankMfo  = GetBankMfo()
				Set sBankName = GetBankName()
				! Дефолтное значение параметра
				Set nAccess = ACCESS_READONLY  !!! =2
				If GetGlobalOption('SEL_010')
					Set nAccess = 1
				!
				Set df2dat= dDat - NACH_
				!
				If SalStrScan(strPar02, 'S') >= 0       ! В ведомости "наименование" счета
					Set sPar = 'S'
				Else If SalStrScan(strPar02, 'P') >= 0  ! В ведомости "наименование" родительского счета (Иначе - клмента)
					Set sPar = 'P'
				Else ! Иначе - клиента
					Set sPar = 'K'
				! N   Кнопка "начислить" закрыта.
						Специфическое Начисление "под-ГПК" сделано предварительно.
						И зафиксировано в acr_intN
						Можно распечатать протокол начисления и выполнить проводки
				If SalStrScan(strPar02, 'N') >= 0
					Call SalDisableWindow(pbAccrue) 
					If SqlPLSQLCommand(hSql(), "cck.INT_METR_FL(dDat, 0)")
						Set bAccrue = 1
				Else
					Set bAccrue = 0
				!
				If SalStrScan(strPar02, 'I') >= 0  ! Печать кода исполнителя в ведомости
					Set bIsp = TRUE
				!
				If SalStrScan(strPar02, 'Q') >= 0  ! Кнопка вжата (со сжатием)
					Set obCompres = TRUE
				!
				If SalStrScan(strPar02, 'X') >= 0  ! Кнопка сжатие закрыта
					Call SalDisableWindow(pbProvodki)
				!
				If SalStrScan(strPar02, 'Z') >= 0  ! Мишино ЗО
					Set df2dat = SalDateMonthBegin(dDat)-1
					Call SalDisableWindow(df2dat)
					Set bZO = TRUE
					Set dVdat = df2dat
					While IsHolyDay(n980, dVdat)
						Set dVdat =  dVdat - 1
				!
				If SalStrScan(strPar02, 'A') >= 0  ! Начислять по ACCOUNTS
					Set sSALDO = 'ACCOUNTS'
					Call cF.Init('ACCOUNTS', 's')
				Else If SalStrScan(strPar02, 'V') >= 0  ! Начислять по V_GL
					Set sSALDO = 'V_GL'
					Call cF.Init('V_GL', 's')
				Else ! иначе - по SALDO
					Set sSALDO = 'SALDO'
					Call cF.Init('SALDO', 's')
				!
				If SalStrLength(strPar02) >= 10  ! + предустановленная дата
					! Call Debug(strPar02)
					Set sTmp = DeData(strPar02)
					If SalStrLength(sTmp) = 8
						Set df2dat = SalDateConstruct(Val(Subs(sTmp, 5, 4)), Val(Subs(sTmp, 3, 2)), Val(Subs(sTmp, 1, 2)), 0, 0, 0)
				! ========================================
				! Set sPar = Subs(strPar02, 1, 1)
				! If sPar != 'S' and sPar != 'P' 
					   Set sPar = 'K'
				! If SalStrLength(strPar02) = 2 AND Subs(strPar02,2,1) = 'A' !! длина =2, по ACCOUNTS
					   Set sPar = 'S'
					   Set sSALDO = 'ACCOUNTS'
					   Call cF.Init('ACCOUNTS', 's')
				! Else
					   Set sSALDO = 'SALDO'
					   Call cF.Init('SALDO', 's')
					   If SalStrLength(strPar02) > 2  ! + что-то еще
						! Разные варианты
						   If Subs(strPar02, 2, 2) = 'ZO' ! Мишино ЗО
							   Set df2dat = SalDateMonthBegin(dDat)-1
							   Call SalDisableWindow(df2dat)
							   Set bZO = TRUE
							   Set dVdat = df2dat
							   While IsHolyDay(n980, dVdat)
								   Set dVdat =  dVdat - 1
						   Else ! предустановленная дата
							   Set df2dat = SalDateConstruct(Val(Subs(strPar02, 8, 4)), Val(Subs(strPar02, 5, 2)), Val(Subs(strPar02, 2, 2)), 0, 0,
									    0)
				!
				! Set dDat = bDATE 
				! Call SalPrtGetDefault(sDeviceDef, sDriverDef, sPortDef)
				Set tblAcrInt.strSqlDelete = T("
						    DELETE
						    FROM   acr_intN
						    WHERE  rowid=:tblAcrInt.cRowid")
				Set tblAcrInt.strSqlUpdate = T("
						    UPDATE acr_intN
						    SET    acrd=:tblAcrInt.cAcrD,nazn=:tblAcrInt.cNAZN
						    WHERE  rowid=:tblAcrInt.cRowid")
				!
				! Отображение отделения в экранной форме ведомости
				Set nHaveTobo = GetGlobalOptionEx('HAVETOBO')
				If nHaveTobo = 2 OR nHaveTobo = 1
					Set sColName4Branch = IifS(nHaveTobo=2, ", b.branch|| ' - ' || b.name ", ", b.tobo || ' - ' || b.name ")
					Set sTblName4Branch = IifS(nHaveTobo=2, ", branch b ",                ", tobo b ")
					Set sWhereCl4Branch = IifS(nHaveTobo=2, " AND s.branch=b.branch ", " AND s.tobo=b.tobo ")
					Call SalShowWindow(tblAcrInt.cBran4)
				Else
					Set sColName4Branch = ", null"
					Set sTblName4Branch = ""
					Set sWhereCl4Branch = ""
					Call SalHideWindow(tblAcrInt.cBran4)
				!
				If DigInit() != -1
					Set nMaxDig = DigInit()
				Else
					Set nMaxDig = 4
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On SAM_CreateComplete
				Call SalEnableWindow(pbFilter)
				Call SalSendMsg(tblAcrInt.pbTudaSuda, SAM_Click, 0, 0)
				Call SalWaitCursor(FALSE)
				Call SalSendMsg(tblAcrInt.pbAccrue, SAM_Click, 0, 0)
			On SAM_FetchRowDone
				If tblAcrInt.cOsts < 0
					Set tblAcrInt.cDk = 1
				Else
					Set tblAcrInt.cDk = 0
				If nMetr = 3 or nMetr = 4 or nMetr = 5
					Set tblAcrInt.cDk = 1-tblAcrInt.cDk
				If tblAcrInt.cIr > 0 and tblAcrInt.cBr = 0
					Set sRat = GetRateInStr(tblAcrInt.cIr)
					! Set sRat = SalNumberToStrX(tblAcrInt.cIr, 4)
				Else If tblAcrInt.cBr > 0 and tblAcrInt.cIr = 0
					Set sRat = GetRateInStr(tblAcrInt.cBr)
					! Set sRat = SalNumberToStrX(tblAcrInt.cBr, 4)
				Else
					Set sRat = GetRateInStr(tblAcrInt.cIr) || " @ "|| GetRateInStr(tblAcrInt.cBr)
					! Set sRat = SalNumberToStrX(tblAcrInt.cIr, 4) || " @ " || SalNumberToStrX(tblAcrInt.cBr, 4)
				Call SetColorRow()
				Set nOsts = nOsts + tblAcrInt.cOsts
				Set nAcrD = nAcrD + Abs(tblAcrInt.cAcrD)
				! Валюта счета осн.капитала НЕ = валюте счета нач %% (Сухова)
				Set cAcrDQ = cAcrD
				If cLcv != cKvA and nMetr != 97
					If cKvA = n980
						Set sTmp_Sql = "gl.p_Icurval(:cLcv,:cAcrD,:dVdat)"
					Else If cLcv=n980
						Set sTmp_Sql = "gl.p_Ncurval(:cKvA,:cAcrD,:dVdat)"
					Else
						Set sTmp_Sql = "gl.p_Ncurval(:cKvA,gl.p_Icurval(:cLcv,:cAcrD,:dVdat),:dVdat)"
					If SqlPrepareAndExecute(hSqlAux2(), "
							   SELECT " || sTmp_Sql || "
							   into   :cAcrDQ
							   from   dual") and SqlFetchNext(hSqlAux2(), nFetchRes)
				Set cAcrDQ = Abs(cAcrDQ)
				! !!
				Set tblAcrInt.cAcrDs  = Dig4(Abs(tblAcrInt.cAcrD)/100, cDig, nMaxDig)
				Set tblAcrInt.cAcrDQs = Dig4(Abs(tblAcrInt.cAcrDQ)/100, cDigA, nMaxDig)
				Set tblAcrInt.cOstss  = Dig4(tblAcrInt.cOsts/100, cDig, nMaxDig)
				Set tblAcrInt.cOstAs  = Dig4(tblAcrInt.cOstA/100, cDig, nMaxDig)
				Set tblAcrInt.cAcrDf  = tblAcrInt.cAcrD *  SalNumberPower(10, -cDig)
				Set tblAcrInt.cAcrDQf = tblAcrInt.cAcrDQ * SalNumberPower(10, -cDigA)
				Set tblAcrInt.cOstsf  = tblAcrInt.cOsts *  SalNumberPower(10, -cDig)
				Set tblAcrInt.cOstAf  = tblAcrInt.cOstA *  SalNumberPower(10, -cDig)
				Set dfNrow = lParam + 1
				Set tblAcrInt.cNum = lParam + 1
				! ----------------------------------------------------------------------------------
				! Блок генерации назначения платежа
				! ----------------------------------------------------------------------------------
				If sTmp   ! Если есть назначение платежа в таблице, то берем его, иначе - генерируем
					Set cNAZN = sTmp
				Else
					! Если установлен параметр NAZNF% то пытаемся выполнить подстановку суммы
					If bTTSNazn
						If SqlPrepareAndExecute(hSqlAux2(), "
								   SELECT nazn
								   INTO   :sTmp
								   FROM   tts
								   WHERE  tt=:cTT")
							If not SqlFetchNext(hSqlAux2(), nFetchRes)
								Set sTmp = ''
							If SalStrTrimX(sTmp)
								If not sTranN(cNAZN, sTmp, cTT, cNls, cLcv, cNlsA, sBankMfo, cKvA, cAcrDQ, cNlsB, sBankMfo, cKvB, 0, sRat,
										   SalFmtFormatDateTime(cDatF, 'dd-MM-yy'), SalFmtFormatDateTime(cDatT, 'dd-MM-yy'), cTip, cAcc)
									Call MessageErrorEx('Ошибка формирования назначения платежа ' || sTmp)
					If not cNAZN       ! Если ничего не присвоилось то идем по стандарту
						! Если параметр NAZN_R_% = 1, то не печатаем %-ную ставку в назначении платежа (Ровно Укоопспилка)
						Set cNAZN = IifS(nMetr=3 or nMetr=4 or nMetr=5, CurrentLangTable.GetAtomTitle('tblAcrInt.cTNazn1') || "(" ||
								    IifS(nMetr=3 or nMetr=4, CurrentLangTable.GetAtomTitle('tblAcrInt.cTNazn11'),
								    CurrentLangTable.GetAtomTitle('tblAcrInt.cTNazn12')) || ")", IifS(cId=2 and Subs(cNlsA,1,1)='8', "Пеня по рах.",
								    CurrentLangTable.GetAtomTitle('tblAcrInt.cTNazn2'))) || " " || SalStrTrimX(tblAcrInt.cNls || " " ||
								    CurrentLangTable.GetAtomTitle('tblAcrInt.cTNazn31') || " " || SalFmtFormatDateTime(tblAcrInt.cDatF, 'dd-MM-yy') ||
								    " " || CurrentLangTable.GetAtomTitle('tblAcrInt.cTNazn32') || " " ||
								    SalFmtFormatDateTime(tblAcrInt.cDatT, 'dd-MM-yy') || " " || CurrentLangTable.GetAtomTitle('tblAcrInt.cTNazn33'))
						If nNaznNoRate != 1
							Set tblAcrInt.cNAZN = tblAcrInt.cNAZN|| " " || IifS(nMetr=3 or nMetr=4 or nMetr=5, '',
									    CurrentLangTable.GetAtomTitle('tblAcrInt.cTNazn34') || ' ' || sRat)
						If sNAZN = '1' and not (SalStrLeftX(tblAcrInt.cNlsA, 4) = '2628' or SalStrLeftX(tblAcrInt.cNlsA, 4) = '2638')
							Set tblAcrInt.cNAZN = tblAcrInt.cNAZN || ' (' || tblAcrInt.cNMK || ')'
				! Покрасим 
				If nAcc != tblAcrInt.cAcc
					Set nAcc = tblAcrInt.cAcc
					If nColo = 0 or nColo = COLOR_LightGray
						Set nColo = COLOR_IndexWindow
					Else
						Set nColo = COLOR_LightGray
				If tblAcrInt.cKvA = NUMBER_Null or tblAcrInt.cNlsA = STRING_Null or tblAcrInt.cKvB = NUMBER_Null or
						   tblAcrInt.cNlsB = STRING_Null
					Set bNoNlsKv = TRUE
					Set nColo = COLOR_Sky
				If nColo = COLOR_LightGray or nColo = COLOR_Sky
					Call XSalTblSetRowBackColor(hWndForm, lParam, nColo) ! серый
			On UM_Populate
				Set nAcc     = 0
				Set nOsts    = 0
				Set nAcrD    = 0
				Set nColo    = 0
				Set dfNrow   = 0
				Set bNoNlsKv = FALSE
				!
				! Set strSqlPopulate = T(
						 "SELECT * FROM (SELECT /* ORDERED */
						         s.isp, a.id, s.kv, s.nls, s.tip, a.fdat, a.tdat, a.ir, a.br,
						         a.osts, a.acrd, a.remi, s.ostc, s.acc, s.nms, a.rowid rwd, t.dig,
						         i1.nls nls1, nvl(i1.kv,s.kv) kv1, i1.nms nms1, t1.dig dig1,
						         i2.nls nls2, i2.kv kv2, i2.nms nms2, i.tt, k.nmk, k.okpo,
						         i.metr,  a.nazn " || sColName4Branch ||
						       ",d.rnk, d.nd, d.cc_id
						    FROM acr_intn a,  int_accn i, "||  sSALDO ||" s,
						         accounts i1, accounts i2, tabval t, tabval t1, customer k "||
						         sTblName4Branch || " " || sAddFrom || "
						        ,cc_deal d, cc_add c
						   WHERE a.acc =i.acc     AND a.id  = i.id  AND i.id   not in (10, 11)
						     AND a.acc =s.acc     AND s.rnk = k.rnk AND s.kv   = t.kv
						     AND i.acra=i1.acc(+) AND i.acrb = i2.acc(+)
						     AND i1.kv =t1.kv (+) "||sWhereCl4Branch||" "||sFiltP||" "||sFilt ||
						    "and c.accs(+)=s.acc  and d.nd(+)=c.nd
						   ORDER BY a.id, s.kv, substr(s.nls, 1, 4) || substr(s.nls, 6), a.fdat)
						   WHERE rownum<=5000
						   ORDER BY id, kv, substr(nls, 1, 4) || substr(nls, 6), fdat
						    INTO :tblAcrInt.cIsp,  :tblAcrInt.cId,   :tblAcrInt.cLcv,   :tblAcrInt.cNls, :tblAcrInt.cTip,
						         :tblAcrInt.cDatF, :tblAcrInt.cDatT, :tblAcrInt.cIr,    :tblAcrInt.cBr,
						         :tblAcrInt.cOsts, :tblAcrInt.cAcrD, :tblAcrInt.cRemi,  :tblAcrInt.cOstA,
						         :tblAcrInt.cAcc,  :tblAcrInt.cNMS,  :tblAcrInt.cRowid, :tblAcrInt.cDig,
						         :tblAcrInt.cNlsA, :tblAcrInt.cKvA,  :tblAcrInt.cNMSA,  :tblAcrInt.cDigA,
						         :tblAcrInt.cNlsB, :tblAcrInt.cKvB,  :tblAcrInt.cNMSB,  :tblAcrInt.cTT,
						         :tblAcrInt.cNMK,  :tblAcrInt.cOKPO, :nMetr,            :sTmp,
						         :tblAcrInt.cBran4
						        ,:tblAcrInt.cRNK,  :tblAcrInt.cND,   :tblAcrInt.cCC_ID
						  " )
				! Set strSqlPopulate = T(
						 "SELECT * FROM (SELECT /* ORDERED */
						         s.isp, a.id, s.kv, s.nls, s.tip, a.fdat, a.tdat, a.ir, a.br,
						         a.osts, a.acrd, a.remi, s.ostc, s.acc, s.nms, a.rowid rwd, t.dig,
						         i1.nls nls1, nvl(i1.kv,s.kv) kv1, i1.nms nms1, t1.dig dig1,
						         i2.nls nls2, i2.kv kv2, i2.nms nms2, i.tt, k.nmk, k.okpo,
						         i.metr,  a.nazn " || sColName4Branch ||
						       ",i1.rnk, sd.nd, sd.cc_id
						    FROM acr_intn a,  int_accn i, "||  sSALDO ||" s,
						         accounts i1, accounts i2, tabval t, tabval t1, customer k "||
						         sTblName4Branch || " " || sAddFrom || "
						        ,(select d.nd, d.cc_id, n.acc from cc_deal d, nd_acc n where n.nd=d.nd and d.vidd in (1,2,3,11,12,13)) sd
						   WHERE a.acc =i.acc     AND a.id  = i.id  AND i.id   not in (10, 11)
						     AND a.acc =s.acc     AND s.rnk = k.rnk AND s.kv   = t.kv
						     AND i.acra=i1.acc(+) AND i.acrb = i2.acc(+)
						     AND i1.kv =t1.kv (+) "||sWhereCl4Branch||" "||sFiltP||" "||sFilt ||
						    "and sd.acc(+)=s.acc
						   ORDER BY a.id, s.kv, substr(s.nls, 1, 4) || substr(s.nls, 6), a.fdat)
						   WHERE rownum<=5000
						   ORDER BY id, kv, substr(nls, 1, 4) || substr(nls, 6), fdat
						    INTO :tblAcrInt.cIsp,  :tblAcrInt.cId,   :tblAcrInt.cLcv,   :tblAcrInt.cNls, :tblAcrInt.cTip,
						         :tblAcrInt.cDatF, :tblAcrInt.cDatT, :tblAcrInt.cIr,    :tblAcrInt.cBr,
						         :tblAcrInt.cOsts, :tblAcrInt.cAcrD, :tblAcrInt.cRemi,  :tblAcrInt.cOstA,
						         :tblAcrInt.cAcc,  :tblAcrInt.cNMS,  :tblAcrInt.cRowid, :tblAcrInt.cDig,
						         :tblAcrInt.cNlsA, :tblAcrInt.cKvA,  :tblAcrInt.cNMSA,  :tblAcrInt.cDigA,
						         :tblAcrInt.cNlsB, :tblAcrInt.cKvB,  :tblAcrInt.cNMSB,  :tblAcrInt.cTT,
						         :tblAcrInt.cNMK,  :tblAcrInt.cOKPO, :nMetr,            :sTmp,
						         :tblAcrInt.cBran4
						        ,:tblAcrInt.cRNK,  :tblAcrInt.cND,   :tblAcrInt.cCC_ID
						  " )
				Set strSqlPopulate = T(
						 "SELECT * FROM (SELECT /* ORDERED */
						         s.isp, a.id, s.kv, s.nls, s.tip, a.fdat, a.tdat, a.ir, a.br,
						         a.osts, a.acrd, a.remi, s.ostc, s.acc, s.nms, a.rowid rwd, t.dig,
						         i1.nls nls1, nvl(i1.kv,s.kv) kv1, i1.nms nms1, t1.dig dig1,
						         i2.nls nls2, i2.kv kv2, i2.nms nms2, i.tt, k.nmk, k.okpo,
						         i.metr,  a.nazn " || sColName4Branch ||
						       ",sd.rnk, sd.nd, sd.cc_id
						    FROM acr_intn a,  int_accn i, "||  sSALDO ||" s,
						         accounts i1, accounts i2, tabval t, tabval t1, customer k "||
						         sTblName4Branch || " " || sAddFrom || "
						        ,(select d.rnk, d.nd, d.cc_id, n.acc from cc_deal d, nd_acc n where n.nd=d.nd and d.vidd in (1,2,3,11,12,13)) sd
						   WHERE a.acc =i.acc     AND a.id  = i.id  AND i.id   not in (10, 11)
						     AND a.acc =s.acc     AND s.rnk = k.rnk AND s.kv   = t.kv
						     AND i.acra=i1.acc(+) AND i.acrb = i2.acc(+)
						     AND i1.kv =t1.kv (+) "||sWhereCl4Branch||" "||sFiltP||" "||sFilt ||
						    " and sd.acc(+)=s.acc
						   ORDER BY a.id, s.kv, substr(s.nls, 1, 4) || substr(s.nls, 6), a.fdat)
						   WHERE rownum<=5000
						   ORDER BY id, kv, substr(nls, 1, 4) || substr(nls, 6), fdat
						    INTO :tblAcrInt.cIsp,  :tblAcrInt.cId,   :tblAcrInt.cLcv,   :tblAcrInt.cNls, :tblAcrInt.cTip,
						         :tblAcrInt.cDatF, :tblAcrInt.cDatT, :tblAcrInt.cIr,    :tblAcrInt.cBr,
						         :tblAcrInt.cOsts, :tblAcrInt.cAcrD, :tblAcrInt.cRemi,  :tblAcrInt.cOstA,
						         :tblAcrInt.cAcc,  :tblAcrInt.cNMS,  :tblAcrInt.cRowid, :tblAcrInt.cDig,
						         :tblAcrInt.cNlsA, :tblAcrInt.cKvA,  :tblAcrInt.cNMSA,  :tblAcrInt.cDigA,
						         :tblAcrInt.cNlsB, :tblAcrInt.cKvB,  :tblAcrInt.cNMSB,  :tblAcrInt.cTT,
						         :tblAcrInt.cNMK,  :tblAcrInt.cOKPO, :nMetr,            :sTmp,
						         :tblAcrInt.cBran4
						        ,:tblAcrInt.cRNK,  :tblAcrInt.cND,   :tblAcrInt.cCC_ID
						  " )
				! Call Debug ('3 население табл на екран')
				! Call Debug (Subs(strSqlPopulate, 001,200))
				! Call Debug (Subs(strSqlPopulate, 201,200))
				! Call Debug (Subs(strSqlPopulate, 401,200))
				! Call Debug (Subs(strSqlPopulate, 601,200))
				! Call Debug (Subs(strSqlPopulate, 801,200))
				! Call Debug (Subs(strSqlPopulate,1001,200))
				! Call Debug (Subs(strSqlPopulate,1201,200))
				Call SalWaitCursor(TRUE)
				Call SalTblPopulate(hWndForm, cMain.hSql(), strSqlPopulate , TBL_FillAll)
				!
				! Call SalTblSetContext(tblAcrInt, 0)
				! If tblAcrInt.cRNK = NUMBER_Null
					   Set nI = 0
					   Set hWndChild = SalGetFirstChild(tblAcrInt, TYPE_TableColumn)
					   Loop
						   If hWndChild = hWndNULL
							! No more children
							   Break
						   Set hWndChild = SalGetNextChild(hWndChild, TYPE_TableColumn)
						   Set nI = nI + 1
					!
					! Set hWndCol = SalTblGetColumnWindow(tblAcrInt, cRNK, COL_GetID)
					   Set nJ = 0
					   Set hWndChild = SalGetFirstChild(tblAcrInt, TYPE_TableColumn)
					   Loop
						   If hWndChild = hWndNULL
							! No more children
							   Break
						   Set hWndChild = SalGetNextChild(hWndChild, TYPE_TableColumn)
						   Set nJ = nJ + 1
						   If nJ >= nI - 2
							   Call SalHideWindow(hWndChild)
							   Call DebugN(nJ)
					! Call SalDestroyWindow(tblAcrInt.cRNK)
					! Call SalTblSetColumnWidth(tblAcrInt.cRNK, -1)
				! If tblAcrInt.cREFD = NUMBER_Null
					! Set hWndCol = SalTblGetColumnWindow(tblAcrInt, cREFD, COL_GetID)
					   Call SalTblSetColumnWidth(tblAcrInt.cREFD, -1)
				! If tblAcrInt.cND = STRING_Null
					! Set hWndCol = SalTblGetColumnWindow(tblAcrInt, cND, COL_GetID)
					   Call SalTblSetColumnWidth(tblAcrInt.cND, -1)
				!
				Call SalWaitCursor(FALSE)
				Call SalTblDefineSplitWindow(tblAcrInt, 1, TRUE)
				Set nTmp = SalTblInsertRow(tblAcrInt, TBL_MinRow)
				Call SalTblSetContext(tblAcrInt, nTmp)
				Call SalTblSetRowFlags(tblAcrInt, nTmp, ROW_New, FALSE)
				Set tblAcrInt.cOsts  = nOsts
				Set tblAcrInt.cOstss = Str(tblAcrInt.cOsts)
				Set tblAcrInt.cAcrD  = nAcrD
				Set tblAcrInt.cAcrDs = Str(tblAcrInt.cAcrD)
				Set tblAcrInt.cIsp   = dfNrow
			On UM_ObjActivate
				!
				If nRnk = 0
					Set sFilNem = GetFilNem('PR_' || SalFmtFormatDateTime(tblAcrInt.df2dat, 'ddMM'))
				Else
					Set sFilNem = GetFilNem('_P' || sSab || Sep98md(dDat))
				Call SalWaitCursor(TRUE)
				Call SalStatusSetText(hWndForm, sFilNem)
				Set nInd = RPT_NoToolbar
				If bArc !! печать из архива
					Set strBind  = 'nId,sKv,sBal,sNls,dFdat,dTdat,nIr,nBr,nOsts,nAcrD,sNms,nOstc,dBdat_arc,nUser_arc'
					Set strInput = 'ID,KV,BAL,NLS,FDAT,TDAT,IR,BR,OSTS,ACRD,NMS,OSTC,DAT_ARC,USER_ARC'
					Call SalReportPrintToFile(hWndForm, GetTemplateDir() || '\\BARS010H.QRP', sFilNem, strBind, strInput, 1, RPT_PrintAll, 1,
							     1, FALSE, nInd)
				Else If bIsp  ! Печать номера исполнителя в ведомости
					Set strBind  = 'nId,sKv,sBal,sNls,dFdat,dTdat,nIr,nBr,nOsts,nAcrD,sNms,nOstc,nIsp'
					Set strInput = 'ID,KV,BAL,NLS,FDAT,TDAT,IR,BR,OSTS,ACRD,NMS,OSTC,ISP'
					Call SalReportPrintToFile(hWndForm, GetTemplateDir() || '\\BARS010W.QRP', sFilNem, strBind, strInput, 1, RPT_PrintAll, 1,
							     1, FALSE, nInd)
				Else
					Set strBind  = 'nId,sKv,sBal,sNls,dFdat,dTdat,nIr,nBr,nOsts,nAcrD,sNms,nOstc'
					Set strInput = 'ID,KV,BAL,NLS,FDAT,TDAT,IR,BR,OSTS,ACRD,NMS,OSTC'
					Call SalReportPrintToFile(hWndForm, GetTemplateDir() || '\\BARS010' || SalStrLeftX(GetLang(),1) || '.QRP', sFilNem,
							     strBind, strInput, 1, RPT_PrintAll, 1, 1, FALSE, nInd)
				!
				If nInd > 4
					! Call SalMessageBox('Ошибка ' || SalNumberToStrX(nInd, 0 ) || ' при формировании отчета', 'Внимание',
							   MB_IconExclamation)
					Call SalMessageBox(CurrentLangTable.GetAtomTitle('tblAcrInt.cTErrRep1') || ' ' || SalNumberToStrX(nInd, 0) || ' ' ||
							     CurrentLangTable.GetAtomTitle('tblAcrInt.cTErrRep2'), CurrentLangTable.GetAtomTitle('cTAt'), MB_IconExclamation)
				Call zarez12(sFilNem, 90, sDeviceDef)
				Call SalWaitCursor(FALSE)
				Call SalStatusSetText(hWndForm, 'Готово')
			On SAM_ReportStart
				If nRnk = 0
					Set sTmp = sFiltP || ' ' || sFilt
				Else
					Set sTmp = ' AND k.rnk=:nRnk '
				If bArc !! печать из архива
					Set arcISP  = GetUserId()
					Set arcKV   = NUMBER_Null
					Set arcNLS  = ''
					Set arcDAT  = dDat
					Set arcDAT2 = dDat
					If SalModalDialog(dlg_INTARC, hWndForm, arcISP, arcKV, arcNLS, arcDAT, arcDAT2) != 1
						Call SalDestroyWindow(hWndForm)
						Return FALSE
					Set arcNAM = " and s.bdat>=:arcDAT and s.bdat<=:arcDAT2 "
					If arcKV != NUMBER_Null
						Set arcNAM = arcNAM || " and s.kv=" || Str(arcKV)
					If arcNLS != ''
						Set arcNAM = arcNAM || " and trim(s.nls) LIKE \'" || arcNLS || "\'"
					If arcISP != NUMBER_Null
						Set arcNAM = arcNAM || " and s.userid=:arcISP "
					Call SqlPrepare(hSql(), T("
							     SELECT s.id,s.acc,s.nbs,s.lcv,s.nls,s.fdat,s.tdat,s.ir,s.br,s.osts,s.acrd,s.nms,s.ostc,s.kv,s.bdat,s.userid,t.dig"
							            || IifS(bOba, ',gl.p_icurval(s.kv,s.acrd,s.bdat)', '') || "
							     INTO   :nId,:nAcc,:sBal,:sKv,:sNls,:dFdat,:dTdat,:nIr,:nBr,:nOsts,:nAcrD,:sNms,:nOstc,:nKv,:dBdat_arc,:nUser_arc,
							            :nDig" || IifS(bOba, ',:nTmp', '') || "
							     FROM   tmp_intarc s, int_accN i, tabval t
							     WHERE  s.acc=i.acc AND s.id=i.id AND s.kv=t.kv" || sFiltP || arcNAM || "
							     ORDER BY s.id,s.kv,SUBSTR(s.nls,1,4)||SUBSTR(s.nls,6),s.fdat"))
					Call SalReportSetDateTimeVar(SalNumberToWindowHandle(wParam), 'ArcReport_date1', arcDAT)
					Call SalReportSetDateTimeVar(SalNumberToWindowHandle(wParam), 'ArcReport_date2', arcDAT2)
				Else If sPar = 'S'    !! с наименованием СЧЕТА
					Call SqlPrepare(hSql(), T("
							     SELECT a.id,s.acc,s.nbs,t.lcv,s.nls,a.fdat,a.tdat,a.ir,a.br,a.osts,a.acrd,s.nms,s.ostc,s.kv,t.dig" || IifS(bOba,',
							            gl.p_icurval(s.kv,a.acrd,:dDat) ', '') || IifS(bIsp, ',s.isp', '') || "
							     INTO   :nId,:nAcc,:sBal,:sKv,:sNls,:dFdat,:dTdat,:nIr,:nBr,:nOsts,:nAcrD,:sNms,:nOstc,:nKv,:nDig" ||
							            IifS(bOba, ',:nTmp', '') || IifS (bIsp, ',:nIsp', '') || "
							     FROM   " || sSALDO || " s, acr_intN a, tabval t, int_accN i " || sAddFrom || "
							     WHERE  a.acc=s.acc AND s.kv=t.kv AND a.acc=i.acc AND a.id=i.id " || sTmp || "
							     ORDER BY a.id,s.kv,SUBSTR(s.nls,1,4)||SUBSTR(s.nls,6),a.fdat"))
				Else If sPar = 'P'    !! с номером РОДИТЕЛЬСКОГО счета и наименованием КЛИЕНТА
					Call SqlPrepare(hSql(), T("
							     SELECT a.id,s.acc,r.nbs,t.lcv,r.nls,a.fdat,a.tdat,a.ir,a.br,a.osts,a.acrd,k.nmk,s.ostc,s.kv,t.dig " ||
							            IifS(bOba, ',gl.p_icurval(s.kv,a.acrd,:dDat) ', '') || IifS(bIsp, ',s.isp', '') || "
							     INTO   :nId,:nAcc,:sBal,:sKv,:sNls,:dFdat,:dTdat,:nIr,:nBr,:nOsts,:nAcrD,:sNms,:nOstc,:nKv,:nDig" || IifS(bOba,
							            ',:nTmp', '') || IifS(bIsp, ',:nIsp', '') || "
							     FROM   acr_intN a, " || sSALDO || " s, int_accN i, tabval t, customer k, accounts r " || sAddFrom || "
							     WHERE  a.acc=s.acc AND s.kv=t.kv AND a.acc=i.acc AND a.id=i.id AND s.rnk=k.rnk AND nvl(s.accc,s.acc)=r.acc " || sTmp
							            || "
							     ORDER BY a.id,s.kv,SUBSTR(r.nls,1,4)||SUBSTR(r.nls,6),a.fdat"))
				Else !! If sPar = 'K' !! с наименованием КЛИЕНТА
					Call SqlPrepare(hSql(), T("
							     SELECT a.id,s.acc,s.nbs,t.lcv,s.nls,a.fdat,a.tdat,a.ir,a.br,a.osts,a.acrd,k.nmk,s.ostc,s.kv,t.dig " || IifS(bOba,
							            ',gl.p_icurval(s.kv,a.acrd,:dDat) ', '') || IifS(bIsp, ',s.isp', '') || "
							     INTO   :nId,:nAcc,:sBal,:sKv,:sNls,:dFdat,:dTdat,:nIr,:nBr,:nOsts,:nAcrD,:sNms,:nOstc,:nKv,:nDig" || IifS(bOba,
							            ',:nTmp', '') || IifS(bIsp, ',:nIsp', '') || "
							     FROM   " || sSALDO || " s, acr_intN a, tabval t, customer k, int_accN i " || sAddFrom || "
							     WHERE  a.acc=s.acc AND s.kv=t.kv AND s.rnk=k.rnk AND a.acc=i.acc AND a.id=i.id " || sTmp || "
							     ORDER BY a.id,s.kv,SUBSTR(s.nls,1,4)||SUBSTR(s.nls,6),a.fdat"))
				! Call Debug(Str(bOba) || sPar)
				Set nId0 = NUMBER_Null
				Set nKv0 = NUMBER_Null
				Set nOba = 0
				Set nTmp = 0
				Call SalReportSetStringVar(SalNumberToWindowHandle(wParam),   'SAB',         sSab)
				Call SalReportSetStringVar(SalNumberToWindowHandle(wParam),   'aMFO',        sBankMfo)
				Call SalReportSetStringVar(SalNumberToWindowHandle(wParam),   'aNAME',       sBankName)
				Call SalReportSetDateTimeVar(SalNumberToWindowHandle(wParam), 'Report_date', dDat)
				Call SalReportSetStringVar(SalNumberToWindowHandle(wParam),   'BOS',         GetGlobalOption('PROCMAN'))
				Call SalReportSetStringVar(SalNumberToWindowHandle(wParam),   'VYK',         GetUserRealName())
			On SAM_ReportFetchInit
				Return SqlExecute(hSql())
			On SAM_ReportFetchNext
				If SqlFetchNext(hSql(), nFetchRes)
					If not bArc  ! помещение в архив ведомостей
						Call SqlPrepareAndExecute(hSqlAux(), '
								     DELETE
								     FROM   tmp_intarc
								     WHERE  acc=:nAcc AND id=:nId AND fdat>=:dFdat')
						Call SqlPrepareAndExecute(hSqlAux(), '
								     INSERT
								     INTO   tmp_intarc(id,acc,nbs,lcv,nls,fdat,tdat,ir,br,osts,acrd,nms,ostc,kv,userid,bdat)
								     VALUES (:nId,:nAcc,:sBal,:sKv,:sNls,:dFdat,:dTdat,:nIr,:nBr,:nOsts,:nAcrD,:sNms,:nOstc,:nKv,:nUserID,:dDat)')
					Set nOstc = nOstc/SalNumberPower(10, nDig)
					Set nOsts = SalNumberAbs(nOsts)/SalNumberPower(10, nDig)
					Set nAcrD = SalNumberAbs(nAcrD)/SalNumberPower(10, nDig)
					Set nOba  = nOba + SalNumberAbs(IifN(nKv=980, nTmp, nTmp*2))
					! Call Debug(Str(bOba) || sPar || Str(nTmp) || ',' || Str(nOba) || '[' || Str(nAcrD))
					Return TRUE
			On SAM_ReportFinish
				If nRnk = 0
					! Call MessageInfo('Информация сохранена в файле: ' || sFilNem)
					Call MessageInfo(CurrentLangTable.GetAtomTitle('tblAcrInt.cTMessInfSave') || ': ' || sFilNem)
				If not bArc
					Call SqlCommit(hSqlAux())
			On SAM_ReportNotify
				If lParam = RPT_BeforeBreakHeader2
					If nId != nId0 
						Set nId0 = nId
						Call SqlPrepareAndExecute(hSqlAux(), '
								     SELECT name
								     INTO   :sTYPNACH
								     FROM   int_idn
								     WHERE  id=:nId')
						If SqlFetchNext(hSqlAux(), nFetchRes)
							Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'TYPNACH', sTYPNACH)
					If nKv != nKv0
						Set nKv0 = nKv
						Call SqlPrepareAndExecute(hSqlAux(), '
								     SELECT name
								     INTO   :sVALNAME
								     FROM   tabval
								     WHERE  kv=:nKv')
						If SqlFetchNext(hSqlAux(), nFetchRes)
							Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'VALNAME', sVALNAME)
					! Выбор ФИО распорядителя средств из справочника INT_USER (Inna)
					If nFindBoss = 1
						Call SqlPrepareAndExecute(hSqlAux(), "
								     SELECT s.fio
								     INTO   :sBossFio
								     FROM   int_user i, staff s
								     WHERE  i.userid=:nUserID AND i.procman=s.id AND i.kv=" || IifS(nKv=GetBaseVal(), "0", "1"))
						If SqlFetchNext(hSqlAux(), nFetchRes)
							Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'BOS', sBossFio)
						Else
							Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'BOS', GetGlobalOption('PROCMAN'))
				If lParam = RPT_BeforeReportFooter
					Call SalReportSetNumberVar(SalNumberToWindowHandle(wParam), 'OBAL', nOba)
					! Call DebugN(bOba)
					! Call DebugN(nOba)
			On UM_DoubleClick
				Call SetProcParN(cAcc, nAccess , '', '')
				Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
			On SAM_Destroy
				! Call SalPrtSetDefault(sDeviceDef, sDriverDef, sPortDef)
				! If SalStrTrimX(SalStrUpperX(GetDBMS())) = 'ORACLE'
					   Call XRoleUnset(hSql(), 'AcrProc(hWndMDI," ")')
			! On SAM_ColumnSelectClick      ! Пустую не убирать !!!!
			On SAM_ColumnSelectClick
				Call SalWaitCursor(TRUE)
				Call SalTblSetColumnFlags(SalNumberToWindowHandle(wParam), COL_Selected, FALSE)
				Set bSortOrd = not bSortOrd
				If SalNumberToWindowHandle(wParam) = SalTblGetColumnWindow(tblAcrInt, SalTblQueryColumnID(cAcrDs), COL_GetID)
					Set wParam = SalWindowHandleToNumber(SalTblGetColumnWindow(tblAcrInt, SalTblQueryColumnPos(cAcrDf), COL_GetID))
				If SalNumberToWindowHandle(wParam) = SalTblGetColumnWindow(tblAcrInt, SalTblQueryColumnID(cAcrDQs), COL_GetID)
					Set wParam = SalWindowHandleToNumber(SalTblGetColumnWindow(tblAcrInt, SalTblQueryColumnPos(cAcrDQf), COL_GetID))
				If SalNumberToWindowHandle(wParam) = SalTblGetColumnWindow(tblAcrInt, SalTblQueryColumnID(cOstss), COL_GetID)
					Set wParam = SalWindowHandleToNumber(SalTblGetColumnWindow(tblAcrInt, SalTblQueryColumnPos(cOstsf), COL_GetID))
				If SalNumberToWindowHandle(wParam) = SalTblGetColumnWindow(tblAcrInt, SalTblQueryColumnID(cOstAs), COL_GetID)
					Set wParam = SalWindowHandleToNumber(SalTblGetColumnWindow(tblAcrInt, SalTblQueryColumnPos(cOstAf), COL_GetID))
				Call SalTblSortRows(hWndForm, SalTblQueryColumnID(SalNumberToWindowHandle(wParam)), bSortOrd)
				Call SalWaitCursor(FALSE)
	Table Window: tblAcrPay		!! 02 выплата %%
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Выплата / взыскание  %%
		Icon File:
		Accesories Enabled? Class Default
		Visible? No
		Display Settings
			Visible at Design time? Yes
			Automatically Created at Runtime? Class Default
			Initial State: Maximized
			Maximizable? Class Default
			Minimizable? Class Default
			System Menu? Class Default
			Resizable? Class Default
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  10.36"
				Width Editable? Class Default
				Height: Class Default
				Height Editable? Class Default
			Font Name: Arial
			Font Size: 10
			Font Enhancement: Bold
			Text Color: Class Default
			Background Color: Sky
			View: Class Default
			Allow Row Sizing? Class Default
			Lines Per Row: Class Default
		Memory Settings
			Maximum Rows in Memory: 1000
			Discardable? No
		Description: Выплата / взыскание %%
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
					Resource Id: 11610
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  4.533"
						Begin Y:  Class Default
						End X:  4.533"
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Line
					Resource Id: 6995
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  9.783"
						Begin Y:  -0.012"
						End X:  9.783"
						End Y:  0.452"
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
						On SAM_Create
							! Set strTip = 'Фильтр'
							Set strTip = CurrentLangTable.GetAtomTitle('tblAcrPay.cBTipFilter')
						On SAM_Click
							If SetQueryFilter( cF )
								If cF.GetFilterWhereClause( FALSE )
									Set sFilt = 'AND '|| cF.GetFilterWhereClause( FALSE )
							Call SalSendMsg(hWndForm,UM_Populate,0,0)
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
						On SAM_Click
							! Call TablePrint(tblAcrPay, 'Таблица Выплата / взыскание %%', 
									GetPrnDir() ||  '\\'   ||   'XX'  || SalStrMidX( sBankMfo, 1, 2 )  ||  
									 SalStrMidX( sBankMfo, 4, 2 ) , '' )
							Call TablePrint(tblAcrPay, CurrentLangTable.GetAtomTitle('tblAcrPay.cTPrint'), 
									GetPrnDir() ||  '\\'   ||   'XX'  || SalStrMidX( sBankMfo, 1, 2 )  ||  
									 SalStrMidX( sBankMfo, 4, 2 ) , '' )
				Line
					Resource Id: 11611
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
					Resource Id: 11612
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
				Background Text: Группа
					Resource Id: 11613
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   4.833"
						Top:    0.119"
						Width:  1.35"
						Width Editable? Yes
						Height: 0.226"
						Height Editable? Yes
					Visible? Yes
					Justify: Right
					Font Name: Default
					Font Size: 10
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
				Data Field: bgGroup
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
				Combo Box: cmbGroups
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cGenComboBox_NumId
					Property Template:
					Class DLL Name:
					Window Location and Size
						Left:   6.433"
						Top:    0.095"
						Width:  3.1"
						Width Editable? Class Default
						Height: 1.81"
						Height Editable? Class Default
					Visible? Class Default
					Editable? No
					String Type: Class Default
					Maximum Data Length: Class Default
					Sorted? Class Default
					Always Show List? Class Default
					Vertical Scroll? Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Bold
					Text Color: Class Default
					Background Color: Class Default
					Input Mask: Class Default
					List Initialization
					Message Actions
						On SAM_Create
							If cmbGroups.Init( hWndItem )
								Call cmbGroups.Populate( hSql(), 'id', 'name', 'int_idn', '' )
								Call cmbGroups.SetSelectById( nGrp )
						On SAM_Click
							Call SalSendClassMessage( SAM_Click, 0, 0 )
							Set nGrp=cmbGroups.nCurrentId
							Call SalSendMsg( hWndForm, UM_Populate, 0, 0 )
				Pushbutton: pbRun
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbExecute
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   9.983"
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
							Set bOk=TRUE
							Set sNlsA = STRING_Null
							Set nKvA = 0
							Set nRow = TBL_MinRow
							While SalTblFindNextRow( tblAcrPay, nRow, 0, ROW_MarkDeleted )
								Call SalTblSetContext( tblAcrPay, nRow )
								If SalTblQueryRowFlags( hWndForm, nRow, ROW_UnusedFlag2 )
								Else
									Set dfNrow=nRow+1 
									If sNlsA != tblAcrPay.colNlsA
										If bOk and sNlsA and nKvA
											Call SqlCommit(hSql())
											If nRow > 980 
												! Call SalMessageBox( 'Переполнение таблицы. Часть данных не обработана.','Внимание', MB_IconExclamation )
												Call SalMessageBox( CurrentLangTable.GetAtomTitle('tblAcrPay.cTMess1'),
														  CurrentLangTable.GetAtomTitle('cTErr'), MB_IconExclamation )
												Break
										Set sNlsA=tblAcrPay.colNlsA
										Set nKvA=tblAcrPay.colKvA
										Set bOk=TRUE
									If bOk and colSumR
										If SqlPrepareAndExecute( hSql(),"
												   UPDATE int_accN SET apl_dat = :dDat WHERE acc=:tblAcrPay.colAcc and id=:nGrp" )
											Call cDoc.SetDoc( 0, colTT, colDk, colVob,'', dDat, dDat, dDat, dDat,
													     colNlsA, colPlat, sBankMfo,'', colKvA, colSumR, sOkpoA,
													     colNlsB, colPolu,  colMfoB,'', colKvB, NUMBER_Null, colOkpoB, colNazn, '',GetIdOper(),'',NUMBER_Null,0 )
											If not cDoc.oDoc()
												Call SqlRollback(hSql())
												Set bOk=FALSE
										Else
											Call SqlRollback(hSql())
											Set bOk=FALSE
							If bOk and sNlsA and nKvA
								Call SqlCommit(hSql())
								Call MessageInfoEx('Готово.')
							Call SalWaitCursor( TRUE )
							Call SalSendMsg( hWndForm, UM_Populate, 0, 0 )
							Call SalWaitCursor( FALSE )
						On SAM_Create
							! Set strTip = 'Выполнить проводки'
							Set strTip = CurrentLangTable.GetAtomTitle('tblAcrPay.cBTipRun')
				Data Field: dfNrow
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Property Template:
					Class DLL Name:
					Data
						Maximum Data Length: 5
						Data Type: Number
						Editable? No
					Display Settings
						Window Location and Size
							Left:   10.633"
							Top:    0.119"
							Width:  0.85"
							Width Editable? Yes
							Height: 0.25"
							Height Editable? Yes
						Visible? Yes
						Border? No
						Justify: Right
						Format: Unformatted
						Country: Default
						Font Name: Default
						Font Size: 10
						Font Enhancement: Bold
						Text Color: Default
						Background Color: 3D Face Color
						Input Mask: Unformatted
					Message Actions
		Contents
			Column: colVob
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Вид
						док.
				Visible? Yes
				Editable? No
				Maximum Data Length: 6
				Data Type: Number
				Justify: Center
				Width:  0.486"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colTT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Код
						оп.
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
				Data Type: String
				Justify: Center
				Width:  0.486"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
					On SAM_Create
						If sUnHide='1'
							Call SalEnableWindow( hWndItem )
			Column: colNlsA
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Рах
						А
				Visible? Yes
				Editable? No
				Maximum Data Length: 14
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
			Column: colKvA
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: ВАЛ
						A
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
				Data Type: Number
				Justify: Center
				Width:  0.457"
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
			Column: colNlsB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Рах
						Б
				Visible? Yes
				Editable? No
				Maximum Data Length: 14
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
					On SAM_Create
						If sUnHide='1'
							Call SalEnableWindow( hWndItem )
			Column: colKvB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: ВАЛ
						Б
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
				Data Type: Number
				Justify: Center
				Width:  0.433"
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
			Column: colMfoB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: МФО
						Б
				Visible? Yes
				Editable? No
				Maximum Data Length: 9
				Data Type: String
				Justify: Center
				Width:  1.3"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
					On SAM_Create
						If sUnHide='1'
							Call SalEnableWindow( hWndItem )
			Column: colDk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Д/К
				Visible? Yes
				Editable? No
				Maximum Data Length: 1
				Data Type: Number
				Justify: Center
				Width:  0.414"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Формула
						суммы
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.567"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colOstC
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Остаток
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.867"
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
			Column: colSumR
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Сума
						документа
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.5"
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
					On SAM_Create
						If sUnHide='1'
							Call SalEnableWindow( hWndItem )
			Column: colOstB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Остаток
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.867"
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
			Column: colPlat
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Платник
				Visible? Yes
				Editable? No
				Maximum Data Length: 38
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
			Column: colPolu
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Отримувач
				Visible? Yes
				Editable? No
				Maximum Data Length: 38
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
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Призначення платежу                         
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 160
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
			Column: colAcc
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Внутр
						# Сч.
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  Default
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
			Column: colOkpoB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: ОКПО
						Б
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.567"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Тип
						ставки
				Visible? No
				Editable? No
				Maximum Data Length: 3
				Data Type: Number
				Justify: Center
				Width:  0.5"
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
		Functions
		Window Parameters
			Number: nPar
			String: sFiltP
			String: sUnHide    ! Возможность корректировать TT mfob nlsb
		Window Variables
			Number: nGrp
			Number: nRow
			String: sBankMfo
			String: sOkpoA
			: cDoc
				Class: cDoc
			Date/Time: dDat
			String: ACC
			String: sS
			Number: nFetchRes
			Number: nAcc
			String: sNlsA
			Number: nKvA
			Boolean: bOk
			Number: nTmp
			Number: nSumD
			Number: nRowC
			String: sNls
			String: sNms
			String: sNmk
			Number: nFli
			: cF
				Class: cGenFilter
			String: sFilt
		Message Actions
			On SAM_Create
				Call PrepareWindow( hWndForm )
				Call SetWindowFont( hWndForm )
				Call SetWindowFullSize( hWndForm )
				! Присваиваем значения многоязыковым объектам
				Call SalSendMsgToChildren( hWndForm, UM_QueryLabelText, 0, 0 )
				Call SalSetWindowText( hWndForm, CurrentLangTable.GetAtomTitle('tblAcrPay.cTWndTitle'))
				!
				Call cF.Init('SALDO', 's')
				Set nFlags=GT_NoRet | GT_NoIns 
				If nPar
					Set nGrp=nPar
					Call SalDisableWindow(cmbGroups)
				Else
					Set nGrp=0
				! Set sFilt=sFiltP
				Set dDat=GetBankDate()
				Set sBankMfo=GetBankMfo()
				Set sOkpoA=GetBankOkpoS()
				Call ShowApdVersion('02')
				Call SalSendClassMessage( SAM_Create, 0, 0 )
			On SAM_CreateComplete
				Call SalEnableWindow(pbFilter)
				Call SalWaitCursor( FALSE )
				Call SalSendMsg(tblAcrPay.pbFilter,SAM_Click, 0, 0)
			On SAM_FetchRowDone
				If nFli=1
					Set colPlat=GetBankName()  ! было nms
				Else
					Set colPlat=sNms
				If colSumR<0
					Set colDk=0
				Else
					Set colDk=1
				Set colSumR=SalNumberAbs( colSumR )
				! Set colAmount=colSumR
				If colNazn
				Else
					! Set colNazn=IifS(colDk,'Виплата','Стягнення')||' відсотків по рах.'||sNls 
					Set colNazn=IifS(colDk,
							  CurrentLangTable.GetAtomTitle('tblAcrPay.cTNazn1'),
							  CurrentLangTable.GetAtomTitle('tblAcrPay.cTNazn2'))||' '||
							  CurrentLangTable.GetAtomTitle('tblAcrPay.cTNazn3')||sNls 
				Set nRowC=nRowC+1
				Set dfNrow=nRowC
				Set nSumD=nSumD+tblAcrPay.colSumR
			On UM_Populate
				Set tblAcrPay.strPrintFileName='vpl100.'||SalStrRightX('000'||SalNumberToStrX(nGrp,0),3)
				Set tblAcrPay.strSqlPopulate='
						SELECT i.ttb,DECODE(a.kv,i.kvb,
						       DECODE(i.mfob,'||GetBankMfo()||',6,
						       DECODE(SUBSTR(s.nls,1,1),\'2\',1,6)),16),
						       a.nls,a.kv,i.mfob,i.nlsb,i.kvb,a.ostc,
						       i.namb,i.nazn,i.acc,nvl(i.okpo,k.okpo),a.nms,k.nmk,t.fli,s.nls
						  FROM int_accN i, accounts a, customer k, tts t,saldo s
						 WHERE i.acra=a.acc AND a.rnk=k.rnk AND
						       i.id=:tblAcrPay.nGrp AND a.ostc<>0 AND a.ostc=a.ostb AND 
						       i.ttb=t.tt AND i.acc=s.acc '||sFiltP||' '||sFilt||
						 ' ORDER BY a.nls,a.kv 
						  INTO :tblAcrPay.colTT,  :tblAcrPay.colVob,
						       :tblAcrPay.colNlsA,:tblAcrPay.colKvA,:tblAcrPay.colMfoB,
						       :tblAcrPay.colNlsB,:tblAcrPay.colKvB, 
						       :tblAcrPay.colSumR,
						       :tblAcrPay.colPolu,:tblAcrPay.colNazn,
						       :tblAcrPay.colAcc, :tblAcrPay.colOkpoB,
						       :tblAcrPay.sNms,   :tblAcrPay.sNmk,  :tblAcrPay.nFli
						       :tblAcrPay.sNls'       
				!
				Set dfNrow=0
				Set nSumD=0
				Set nRowC=0
				Call SalWaitCursor(TRUE)
				Call SalTblPopulate(hWndForm, cMain.hSql(), T(strSqlPopulate), TBL_FillAll)
				Call SalWaitCursor(FALSE)
				Call SalTblDefineSplitWindow ( hWndForm, 1, TRUE )
				Set nTmp=SalTblInsertRow (  hWndForm, TBL_MinRow )
				Call SalTblSetContext ( hWndForm, nTmp)              
				Call SalTblSetRowFlags( hWndForm, nTmp, ROW_New, FALSE )
				Call SalTblSetRowFlags( hWndForm, nTmp, ROW_UnusedFlag2, TRUE )
				Set tblAcrPay.colSumR=nSumD
				Set tblAcrPay.colVob=nRowC
			On UM_DoubleClick
				Call SetProcParN(colAcc,NUMBER_Null,'','')
				Call SalSendMsg(hWndForm,UM_Populate,0,0)
			On UM_Update
				Set nRow = TBL_MinRow
				While SalTblFindNextRow(hWndForm, nRow, ROW_MarkDeleted, 0)
					Call SalTblSetContext(hWndForm, nRow )
					Set nRowC=nRowC-1
					Set dfNrow=nRowC
					Set nSumD=nSumD-tblAcrPay.colSumR
					Call SalTblDeleteRow(hWndForm, nRow, TBL_NoAdjust)
				Set nRow = TBL_MinRow  !! Исправить итоговую строку после удаления
				If SalTblFindNextRow(hWndForm, nRow, ROW_UnusedFlag2, 0)
					Call SalTblSetContext(hWndForm, nRow )
					Set tblAcrPay.colSumR=nSumD
					Set tblAcrPay.colVob=nRowC
	Dialog Box: dlg_Mess			!! 04
		Class:
		Property Template:
		Class DLL Name:
		Title: Внимание
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   1.638"
				Top:    1.938"
				Width:  8.033"
				Width Editable? Yes
				Height: 1.714"
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
			Pushbutton: pb3
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cPushButtonLabeled
				Property Template:
				Class DLL Name:
				Title: Выйти и подумать
				Window Location and Size
					Left:   5.033"
					Top:    0.988"
					Width:  2.7"
					Width Editable? Yes
					Height: 0.298"
					Height Editable? Yes
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: 10
				Font Enhancement: None
				Picture File Name:
				Picture Transparent Color: None
				Image Style: Single
				Text Color: Default
				Background Color: Default
				Message Actions
					On SAM_Click
						Call SalEndDialog( hWndForm,3)
			Pushbutton: pb1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cPushButtonLabeled
				Property Template:
				Class DLL Name:
				Title: Выполнить проводки
				Window Location and Size
					Left:   0.167"
					Top:    0.988"
					Width:  2.7"
					Width Editable? Yes
					Height: 0.298"
					Height Editable? Yes
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: 10
				Font Enhancement: None
				Picture File Name:
				Picture Transparent Color: None
				Image Style: Single
				Text Color: Default
				Background Color: Default
				Message Actions
					On SAM_Click
						Call SalEndDialog( hWndForm,1)
			Pushbutton: pb2
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cPushButtonLabeled
				Property Template:
				Class DLL Name:
				Title: Без проводок
				Window Location and Size
					Left:   2.983"
					Top:    0.988"
					Width:  1.933"
					Width Editable? Yes
					Height: 0.298"
					Height Editable? Yes
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: 10
				Font Enhancement: None
				Picture File Name:
				Picture Transparent Color: None
				Image Style: Single
				Text Color: Default
				Background Color: Default
				Message Actions
					On SAM_Click
						Call SalEndDialog( hWndForm,2)
			Background Text: Начисление  %% будет зафиксировано в базе данных.
					
					Это действие необратимо.
					
				Resource Id: 32114
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.233"
					Top:    0.131"
					Width:  7.5"
					Width Editable? Yes
					Height: 0.702"
					Height Editable? Yes
				Visible? Yes
				Justify: Center
				Font Name: Arial Cyr
				Font Size: 11
				Font Enhancement: Bold
				Text Color: Blue
				Background Color: Default
			Data Field: bgInfo
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
			Frame
				Resource Id: 32115
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.167"
					Top:    0.071"
					Width:  7.617"
					Width Editable? Yes
					Height: 0.81"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Drop-Shadow
				Border Thickness: 1
				Border Color: Default
				Background Color: Default
		Functions
		Window Parameters
		Window Variables
		Message Actions
			On SAM_Create
				Call SalCenterWindow( hWndItem )
				Call SetWindowFont( hWndForm )
				Call ShowApdVersion('04')
				! Присваиваем значения многоязыковым объектам
				Call SalSendMsgToChildren( hWndForm, UM_QueryLabelText, 0, 0 )
				Call SalSetWindowText( hWndForm, CurrentLangTable.GetAtomTitle('cTAt')  )
				!
	Form Window: CAL
		Class:
		Property Template:
		Class DLL Name:
		Title: Расчет доходности ресурса, вложенного в разные финансовые инструменты
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
				Left:   0.163"
				Top:    0.677"
				Width:  12.633"
				Width Editable? Yes
				Height: 5.869"
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
			Group Box: Процентный доход
				Resource Id: 53903
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.25"
					Top:    0.119"
					Width:  3.5"
					Width Editable? Yes
					Height: 1.929"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: 10
				Font Enhancement: Bold
				Text Color: Red
				Background Color: Default
			Data Field: bgGBProcDox
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
			Background Text: Валюта
				Resource Id: 53904
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.417"
					Top:    0.44"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Data Field: bgVAL1
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
			Data Field: VAL1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 3
					Data Type: Number
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   1.467"
						Top:    0.405"
						Width:  0.617"
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
						Call F360(1, VAL1)
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Код вал ресурса' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipVAL') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Data Field: K1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 3
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.067"
						Top:    0.405"
						Width:  0.617"
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
			Background Text: Ресурс
				Resource Id: 53905
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.417"
					Top:    0.702"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Data Field: bgRES1
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
			Data Field: RES1
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
						Left:   1.467"
						Top:    0.655"
						Width:  2.117"
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
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Сумма вал ресурса' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipRES1') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Background Text: Срок
				Resource Id: 53906
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.417"
					Top:    1.464"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Data Field: bgSROK1
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
			Data Field: SROK1
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
						Left:   1.467"
						Top:    1.405"
						Width:  1.417"
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
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Срок Размещение/Привлечения в днях' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipRES1') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Background Text: % ставка
				Resource Id: 53907
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.417"
					Top:    1.69"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Data Field: bgPR1
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
			Data Field: PR1
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
						Left:   1.467"
						Top:    1.655"
						Width:  1.417"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: ###00000
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Годовая % ставка' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipPR1') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Background Text: Доход
				Resource Id: 53908
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.417"
					Top:    1.214"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Data Field: bgDOX1
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
			Data Field: DOX1
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
						Left:   1.467"
						Top:    1.155"
						Width:  1.417"
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
					On SAM_TooltipSetText
						Return XSalTooltipSetText( lParam, 'Сумма процентного дохода/расхода' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipDOX1') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Pushbutton: pb1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbGetValue
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   2.95"
					Top:    1.595"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name: \BARS98\RESOURCE\BMP\Ok.bmp
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						If RES1  != NUMBER_Null and SROK1 != NUMBER_Null and 
								   PR1   != NUMBER_Null and DOX1   = NUMBER_Null
							Set DOX1=(RES1 * SROK1 * PR1)/(K1*100)
						!
						Else If RES1  != NUMBER_Null and  DOX1  != NUMBER_Null and 
								        PR1   != NUMBER_Null and SROK1   = NUMBER_Null
							Set SROK1= SalNumberRound( (DOX1 * (K1*100) )/(RES1 * PR1) )
						!
						Else If SROK1 != NUMBER_Null and    DOX1  != NUMBER_Null and 
								        PR1   != NUMBER_Null and    RES1   = NUMBER_Null
							Set RES1 =( DOX1 * (K1*100) )/(SROK1 * PR1)
						!
						Else If SROK1 != NUMBER_Null and    DOX1  != NUMBER_Null and 
								        RES1  != NUMBER_Null and    PR1    = NUMBER_Null
							Set PR1  =( DOX1 * (K1*100) )/(SROK1 * RES1)
						Else
							! Call Debug('ош.параметров')
							Call Debug(CurrentLangTable.GetAtomTitle('CAL.cTErrPar'))
					On SAM_Create
						! Set strTip = 'Расчитать незаполненное'
						Set strTip = CurrentLangTable.GetAtomTitle('CAL.cBTip1')
			Pushbutton: pb1x
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbDelete
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   2.933"
					Top:    1.238"
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
						Set RES1 = NUMBER_Null
						Set SROK1 = NUMBER_Null
						Set PR1 = NUMBER_Null
						Set DOX1 = NUMBER_Null
					On SAM_Create
						! Set strTip = 'Очистить'
						Set strTip = CurrentLangTable.GetAtomTitle('CAL.cBTip1x')
			!
			Group Box: Дисконтный  доход
				Resource Id: 53909
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   3.933"
					Top:    0.119"
					Width:  8.217"
					Width Editable? Yes
					Height: 1.929"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: 10
				Font Enhancement: Bold
				Text Color: Dark Green
				Background Color: Default
			Data Field: bgGBDiscDox
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
			Background Text: Валюта
				Resource Id: 53910
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   3.983"
					Top:    0.452"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Data Field: bgVAL2
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
			Data Field: VAL2
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 3
					Data Type: Number
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   5.05"
						Top:    0.405"
						Width:  0.617"
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
						Call F360(2, VAL2)
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Код вал ресурса' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipVAL') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Data Field: K2
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 3
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   5.7"
						Top:    0.405"
						Width:  0.617"
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
			Background Text: Номинал
				Resource Id: 53911
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   3.983"
					Top:    0.94"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Data Field: bgNOM2
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
			Data Field: NOM2
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
						Left:   5.05"
						Top:    0.905"
						Width:  2.117"
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
					On SAM_Validate
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Номинальная (конечная) стоимость' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipNOM2') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Background Text: Ресурс
				Resource Id: 53912
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   3.983"
					Top:    0.702"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Data Field: bgRES2
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
			Data Field: RES2
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
						Left:   5.05"
						Top:    0.655"
						Width:  2.117"
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
					On SAM_Validate
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Сумма Покупки/Продажи' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipRES2') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Background Text: Дисконт
				Resource Id: 53913
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   3.983"
					Top:    1.214"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Data Field: bgDOX2
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
			Data Field: DOX2
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
						Top:    1.155"
						Width:  1.417"
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
					On SAM_Validate
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Сумма дисконтного дохода/расхода' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipDOX2') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Background Text: Срок
				Resource Id: 53914
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   3.983"
					Top:    1.464"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Data Field: bgSROK2
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
			Data Field: SROK2
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
						Left:   5.05"
						Top:    1.405"
						Width:  1.417"
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
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Кой-во дней до погашения' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipSROK2') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Background Text: % ставка
				Resource Id: 53915
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   3.983"
					Top:    1.69"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Data Field: bgPr2
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
			Data Field: PR2
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
						Left:   5.05"
						Top:    1.655"
						Width:  1.417"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: ###00000
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Приведенная Годовая % ставка' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipPR2') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Pushbutton: pb2
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbGetValue
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   6.5"
					Top:    1.595"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name: \BARS98\RESOURCE\BMP\Ok.bmp
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						If NOM2  != NUMBER_Null and 
								   RES2  != NUMBER_Null and 
								   SROK2 != NUMBER_Null and    
								   PR2    = NUMBER_Null
							Set DOX2= NOM2 - RES2
							Set PR2  =( DOX2 * (K2*100) )/(SROK2 * RES2)
						If RES2  != NUMBER_Null and 
								   SROK2 != NUMBER_Null and 
								   PR2   != NUMBER_Null and 
								   NOM2   = NUMBER_Null
							Set DOX2 = (RES2 * SROK2 * PR2)/ (K2*100)
							Set NOM2 = RES2 + DOX2
						If RES2  != NUMBER_Null and 
								   NOM2  != NUMBER_Null and 
								   PR2   != NUMBER_Null and 
								   SROK2  = NUMBER_Null
							Set DOX2 = NOM2 - RES2
							Set SROK2=SalNumberRound( ( DOX2 * (K2*100) )/(RES2 * PR2) )
						If SROK2 != NUMBER_Null and 
								   NOM2  != NUMBER_Null and 
								   PR2   != NUMBER_Null and 
								   RES2   = NUMBER_Null
							Set DOX2 = (NOM2 * SROK2 * PR2) / ( (K2*100) + (SROK2 *PR2))
							Set RES2 = NOM2 - DOX2
					On SAM_Create
						! Set strTip = 'Расчитать незаполненное'
						Set strTip = CurrentLangTable.GetAtomTitle('CAL.cBTip1')
			Pushbutton: pb2x
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbDelete
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   6.5"
					Top:    1.238"
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
						Set RES2 = NUMBER_Null
						Set SROK2 = NUMBER_Null
						Set PR2 = NUMBER_Null
						Set DOX2 = NUMBER_Null
						Set NOM2 = NUMBER_Null
					On SAM_Create
						! Set strTip = 'Очистить'
						Set strTip = CurrentLangTable.GetAtomTitle('CAL.cBTip1x')
			!
			Data Field: NOM22
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
						Left:   7.483"
						Top:    0.881"
						Width:  2.117"
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
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Номинальная (конечная) стоимость' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipNOM2') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Data Field: RES22
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
						Left:   7.483"
						Top:    0.655"
						Width:  2.117"
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
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Сумма Покупки/Продажи' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipRES2') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Data Field: DOX22
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
						Left:   7.483"
						Top:    1.143"
						Width:  1.417"
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
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Сумма дисконтного дохода/расхода' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipDOX2') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Data Field: SROK22
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
						Left:   7.483"
						Top:    1.393"
						Width:  1.417"
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
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Кол-во дней до погашения' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipSROK2') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Data Field: PR22
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
						Left:   7.483"
						Top:    1.643"
						Width:  1.417"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: ###00000
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Приведенная Годовая % ставка' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipPR2') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Pushbutton: pb22
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbGetValue
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   8.983"
					Top:    1.595"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name: \BARS98\RESOURCE\BMP\Ok.bmp
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						If DOX22  != NUMBER_Null and 
								   RES22  != NUMBER_Null and 
								   SROK22 != NUMBER_Null and    
								   PR22    = NUMBER_Null
							Set NOM22 = DOX22 + RES22
							Set PR22  =( DOX22 * (K2*100) )/(SROK22 * RES22)
						If RES22  != NUMBER_Null and 
								   SROK22 != NUMBER_Null and 
								   PR22   != NUMBER_Null and 
								   DOX22   = NUMBER_Null
							Set DOX22 = (RES22 * SROK22 * PR22)/ (K2*100)
							Set NOM22 = RES22 + DOX22
						If RES22  != NUMBER_Null and 
								   DOX22  != NUMBER_Null and 
								   PR22   != NUMBER_Null and 
								   SROK22  = NUMBER_Null
							Set NOM22 = DOX22 + RES22
							Set SROK22=SalNumberRound( ( DOX22 * (K2*100) )/(RES22 * PR22) )
						If SROK22 != NUMBER_Null and 
								   DOX22  != NUMBER_Null and 
								   PR22   != NUMBER_Null and 
								   RES22   = NUMBER_Null
							Set RES22 =( DOX22 * (K2*100) )/(SROK22 * PR22)
							Set NOM22 = DOX22 + RES22
					On SAM_Create
						! Set strTip = 'Расчитать незаполненное'
						Set strTip = CurrentLangTable.GetAtomTitle('CAL.cBTip1')
			Pushbutton: pb22x
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbDelete
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   8.983"
					Top:    1.238"
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
						Set RES22 = NUMBER_Null
						Set SROK22 = NUMBER_Null
						Set PR22 = NUMBER_Null
						Set DOX22 = NUMBER_Null
						Set NOM22 = NUMBER_Null
					On SAM_Create
						! Set strTip = 'Очистить'
						Set strTip = CurrentLangTable.GetAtomTitle('CAL.cBTip1x')
			!
			Data Field: NOM21
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
						Left:   9.8"
						Top:    0.881"
						Width:  2.117"
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
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Номинальная (конечная) стоимость' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipNOM2') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Data Field: RES21
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
						Left:   9.8"
						Top:    0.655"
						Width:  2.117"
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
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Сумма Покупки/Продажи' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipRES2') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Data Field: DOX21
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
						Left:   9.8"
						Top:    1.143"
						Width:  1.417"
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
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Сумма дисконтного дохода/расхода' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipDOX2') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Data Field: SROK21
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
						Left:   9.8"
						Top:    1.393"
						Width:  1.417"
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
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Кол-во дней до погашения' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipSROK2') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Data Field: PR21
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
						Left:   9.8"
						Top:    1.643"
						Width:  1.417"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: ###00000
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Приведенная Годовая % ставка' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipPR2') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Pushbutton: pb21
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbGetValue
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   11.283"
					Top:    1.571"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name: \BARS98\RESOURCE\BMP\Ok.bmp
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						If NOM21  != NUMBER_Null and 
								   DOX21  != NUMBER_Null and 
								   SROK21 != NUMBER_Null and 
								   PR21    = NUMBER_Null
							Set RES21 = NOM21 - DOX21 
							Set PR21  =( DOX21 * (K2*100) )/(SROK21 * RES21)
						If NOM21  != NUMBER_Null and 
								   SROK21 != NUMBER_Null and 
								   PR21   != NUMBER_Null and 
								   DOX21   = NUMBER_Null
							Set DOX21 = (NOM21 * SROK21 * PR21) / ( (K2*100) + SROK21 * PR21)
							Set RES21 = NOM21 - DOX21
						If NOM21  != NUMBER_Null and 
								   DOX21  != NUMBER_Null and 
								   PR21   != NUMBER_Null and 
								   SROK21  = NUMBER_Null
							Set RES21= NOM21 - DOX21 
							Set SROK21=SalNumberRound( ( DOX21 * (K2*100) )/(RES21 * PR21) )
						If SROK21 != NUMBER_Null and 
								   DOX21  != NUMBER_Null and 
								   PR21   != NUMBER_Null and 
								   NOM21   = NUMBER_Null
							Set RES21 =( DOX21 * (K2*100) /SROK21) / PR21
							Set NOM21 = DOX21 + RES21
					On SAM_Create
						! Set strTip = 'Расчитать незаполненное'
						Set strTip = CurrentLangTable.GetAtomTitle('CAL.cBTip1')
			Pushbutton: pb21x
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbDelete
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   11.283"
					Top:    1.214"
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
						Set RES21 = NUMBER_Null
						Set SROK21 = NUMBER_Null
						Set PR21 = NUMBER_Null
						Set DOX21 = NUMBER_Null
						Set NOM21 = NUMBER_Null
					On SAM_Create
						! Set strTip = 'Очистить'
						Set strTip = CurrentLangTable.GetAtomTitle('CAL.cBTip1x')
			!
			Group Box: Маржинальный  доход
				Resource Id: 53916
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.3"
					Top:    2.44"
					Width:  8.35"
					Width Editable? Yes
					Height: 2.19"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: 10
				Font Enhancement: Bold
				Text Color: Blue
				Background Color: Default
			Data Field: bgGBMargDox
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
			Background Text: Отправка (Продажа)
				Resource Id: 53917
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   2.067"
					Top:    2.762"
					Width:  1.917"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Data Field: bgProd
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
			Background Text: Ресурс
				Resource Id: 53918
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.55"
					Top:    2.976"
					Width:  0.767"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Data Field: bgRes
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
			Data Field: VALB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 3
					Data Type: Number
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   1.417"
						Top:    2.94"
						Width:  0.617"
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
						Call F360(3, VALB)
						If VALB  != NUMBER_Null and  RES3B  != NUMBER_Null 
							Call F3B()
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Код вал Продажи' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipVALB') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Data Field: K3
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 3
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   1.433"
						Top:    3.179"
						Width:  0.617"
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
			Data Field: RES3B
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
						Left:   2.05"
						Top:    2.94"
						Width:  2.117"
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
					On SAM_Validate
						If VALB  != NUMBER_Null and  RES3B  != NUMBER_Null 
							Call F3B()
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Сумма вал Продажи' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipRES3B') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Data Field: EQVB
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
						Left:   3.217"
						Top:    2.94"
						Width:  1.917"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? No
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
			Data Field: KURSB
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
						Left:   2.05"
						Top:    3.179"
						Width:  1.417"
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
						If RES3B  != NUMBER_Null and  KURSB != NUMBER_Null
							Set RES3A = RES3B * KURSB
							Set KURSA=1/KURSB
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Курс вал Продажи' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipKURSB') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			!
			Background Text: Поступление (Покупка)
				Resource Id: 53919
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   5.333"
					Top:    2.786"
					Width:  2.033"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Data Field: bgPok
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
			Data Field: VALA
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 3
					Data Type: Number
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   5.333"
						Top:    2.94"
						Width:  0.617"
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
						If VALA  != NUMBER_Null and  RES3A  != NUMBER_Null 
							Call F3A()
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Код вал Покупки' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipVALA') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Data Field: RES3A
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
						Left:   5.95"
						Top:    2.94"
						Width:  2.117"
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
					On SAM_Validate
						If VALA  != NUMBER_Null and  RES3A  != NUMBER_Null 
							Call F3A()
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Сумма вал Покупки' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipRES3A') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Data Field: EQVA
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
						Left:   3.217"
						Top:    3.702"
						Width:  1.917"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? No
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
			Data Field: KURSA
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
						Left:   5.95"
						Top:    3.179"
						Width:  1.417"
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
						If RES3A  != NUMBER_Null and  KURSA != NUMBER_Null
							Set RES3B = RES3A * KURSA
							Set KURSB=1/KURSA
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Курс вал Покупки' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipKURSA') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			!
			Background Text: Срок
				Resource Id: 53920
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   3.0"
					Top:    3.512"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Data Field: bgSROK3
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
			Data Field: SROK3
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
						Left:   4.1"
						Top:    3.464"
						Width:  1.417"
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
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Кол-во дней между Поступлением и Отправкой' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipSROK3') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Background Text: % ставка
				Resource Id: 53921
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   3.0"
					Top:    3.774"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Data Field: bgPR3
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
			Data Field: PR3
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
						Left:   4.1"
						Top:    3.726"
						Width:  1.417"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: ###00000
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_TooltipSetText
						! Return XSalTooltipSetText( lParam, 'Приведенная Годовая % ставка' )
						Return XSalTooltipSetText( lParam, CurrentLangTable.GetAtomTitle('CAL.cFTipPR2') )
					On SAM_SetFocus
						Call SalMapEnterToTab( TRUE )
			Background Text: Маржа
				Resource Id: 53922
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   3.0"
					Top:    4.048"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Data Field: bgMarga3
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
			Data Field: DOX3
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
						Left:   4.1"
						Top:    4.0"
						Width:  1.417"
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
			Pushbutton: pb3
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbGetValue
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   5.55"
					Top:    3.929"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name: \BARS98\RESOURCE\BMP\Ok.bmp
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						If VALB  != NUMBER_Null and  RES3B  != NUMBER_Null and 
								   VALA  != NUMBER_Null and  RES3A  != NUMBER_Null and 
								   SROK3 != NUMBER_Null and 
								   PR3    = NUMBER_Null
							Call F3B()
							Call F3A()
							Call F3R()
							Set PR3  =( DOX3 * (K3*100) )/(SROK3 * EQVB)
						If VALB  != NUMBER_Null and  RES3B  != NUMBER_Null and 
								   VALA  != NUMBER_Null and  RES3A  != NUMBER_Null and 
								   PR3   != NUMBER_Null and 
								   SROK3  = NUMBER_Null
							Call F3B()
							Call F3A()
							Call F3R()
							Set SROK3 = SalNumberRound( ( (K3*100) * DOX3)/ (EQVB*PR3) )
							Call F3R()
						If VALB  != NUMBER_Null and  RES3B  != NUMBER_Null and 
								   PR3   != NUMBER_Null and 
								   SROK3 != NUMBER_Null and
								   (VALA  = NUMBER_Null or RES3A  = NUMBER_Null )
							Call F3B()
							Set EQVA = EQVB + (EQVB * PR3 * SROK3)/ (K3*100) 
							Call F3R()
							Call F3An()
						If VALA  != NUMBER_Null and  RES3A  != NUMBER_Null and 
								   PR3   != NUMBER_Null and 
								   SROK3 != NUMBER_Null and
								   (VALB  = NUMBER_Null or RES3B  = NUMBER_Null )
							Call F3A()
							Set EQVB = EQVA / ( 1 +  (PR3 * SROK3)/ (K3*100) )
							Call F3R()
							Call F3Bn()
			Pushbutton: pb3x
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbDelete
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   5.55"
					Top:    3.571"
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
						Set VALB = NUMBER_Null
						Set K3 = NUMBER_Null
						Set RES3B = NUMBER_Null
						Set EQVB = NUMBER_Null
						Set KURSB = NUMBER_Null
						!
						Set VALA = NUMBER_Null
						Set RES3A = NUMBER_Null
						Set EQVA = NUMBER_Null
						Set KURSA = NUMBER_Null
						!
						Set SROK3 = NUMBER_Null
						Set PR3 = NUMBER_Null
						Set DOX3 = NUMBER_Null
			!
		Functions
			Function: F3B
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
					If VALB = n980
						Set EQVB=RES3B
					Else
						Set nTmp =RES3B*100
						If SqlPrepareAndExecute( hSql(),
								"SELECT gl.p_icurval(:VALB, :nTmp,:bDat)/100 INTO :EQVB FROM dual") 
								and SqlFetchNext( hSql(), nFetchRes )
			Function: F3Bn
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
					If VALB = n980
						Set RES3B = EQVB
					Else
						Set nTmp =EQVB *100
						If SqlPrepareAndExecute( hSql(),
								"SELECT gl.p_ncurval(:VALB, :nTmp,:bDat)/100 INTO :RES3B FROM dual") 
								and SqlFetchNext( hSql(), nFetchRes )
			Function: F3A
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
					If VALA = n980
						Set EQVA=RES3A
					Else
						Set nTmp =RES3A*100
						If SqlPrepareAndExecute( hSql(),
								"SELECT gl.p_icurval(:VALA, :nTmp,:bDat)/100 INTO :EQVA FROM dual") 
								and SqlFetchNext( hSql(), nFetchRes )
			Function: F3An
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
					If VALA = n980
						Set RES3A = EQVA
					Else
						Set nTmp =EQVA *100
						If SqlPrepareAndExecute( hSql(),
								"SELECT gl.p_ncurval(:VALA, :nTmp,:bDat)/100 INTO :RES3A FROM dual") 
								and SqlFetchNext( hSql(), nFetchRes )
			Function: F3R
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
					Set DOX3 = EQVA - EQVB
					Set KURSB=EQVB/EQVA
					Set KURSA=1/KURSB
			Function: F360
				Description:
				Returns
				Parameters
					Number: nI
					Number: nKv
				Static Variables
				Local variables
					Number: nBASEY
					Number: K360
				Actions
					If SqlPrepareAndExecute( hSql(),
							  "SELECT nvl(basey,0) INTO :nBASEY FROM tabval WHERE kv=:nKv" )
							 and not SqlFetchNext( hSql(), nFetchRes)
						Set K360=365
					Else
						Set K360 =IifN( nBASEY=3, 360 , 365+FL_God) 
					If nI=1
						Set K1=K360
					Else If nI=2
						Set K2=K360
					Else If nI=3
						Set K3=K360
		Window Parameters
			Number: nPar
			String: strPar01
			String: strPar02
		Window Variables
			Number: n980
			Number: nTmp
			Date/Time: bDat
			Number: nFetchRes
			Number: FL_God
		Message Actions
			On SAM_Create
				Call SetWindowFont( hWndForm )
				! Присваиваем значения многоязыковым объектам
				Call SalSendMsgToChildren( hWndForm, UM_QueryLabelText, 0, 0 )
				Call SalSetWindowText( hWndForm, CurrentLangTable.GetAtomTitle('CAL.cTWndTitle')  )
				!
				Set n980=GetBaseVal()
				Set bDat=GetBankDate()
				! Set K360=36500
				Set VAL1=n980
				Set VAL2=n980
				Set VALB=n980
				Set FL_God= IifN(SalNumberMod(SalDateYear(GetBankDate()),4)=0,1,0)
				Call F360(1, n980)
				Call F360(2, n980)
				Call F360(3, n980)
				Call SalMapEnterToTab( TRUE )
	Dialog Box: dlg_INTARC
		Class:
		Property Template:
		Class DLL Name:
		Title: ОТБОР счетов для печати ведомости начисленных %% 
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   0.625"
				Top:    0.625"
				Width:  8.6"
				Width Editable? Yes
				Height: 2.167"
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
			Background Text: Код валюты:
				Resource Id: 13341
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    0.262"
					Width:  1.633"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Data Field: KV
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 3
					Data Type: Number
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   1.917"
						Top:    0.238"
						Width:  0.671"
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
						If SqlPrepareAndExecute( hSql(),
								  "SELECT kv,name INTO :kv,:sKV FROM tabval WHERE kv=:KV")
								and SqlFetchNext(  hSql(), nTmp )
						Return VALIDATE_Ok
			Data Field: sKV
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
						Left:   2.583"
						Top:    0.238"
						Width:  5.614"
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
			Background Text: Код исполнителя:
				Resource Id: 13343
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    0.512"
					Width:  1.633"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Data Field: ISP
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 3
					Data Type: Number
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   1.917"
						Top:    0.488"
						Width:  0.671"
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
						If SalIsNull(ISP) 
							Set isp=NUMBER_Null
							Set sFIO=STRING_Null
							Return VALIDATE_Ok
						If SqlPrepareAndExecute( hSql(),
								  "SELECT id,fio INTO :isp,:sFIO FROM staff WHERE id=:ISP")
								and SqlFetchNext(  hSql(), nTmp )
							Return VALIDATE_Ok
			Data Field: sFIO
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
						Left:   2.583"
						Top:    0.488"
						Width:  5.614"
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
			Background Text: Маска счета:
				Resource Id: 13342
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    0.762"
					Width:  1.633"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Data Field: NLS
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
						Left:   1.917"
						Top:    0.738"
						Width:  2.067"
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
						Set nls=SalStrTrimX(StrMatches2Like( NLS ))
						Return VALIDATE_Ok
			!
			Background Text: За период с:
				Resource Id: 13344
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    1.012"
					Width:  1.633"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Data Field: FDAT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: Date/Time
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   1.917"
						Top:    0.988"
						Width:  1.367"
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
					! On SAM_Validate
						                                                                                                                                                                                                                   If SqlPrepareAndExecute( hSql(),
								  "SELECT fdat INTO :dat FROM fdat WHERE fdat=:FDAT")
								and SqlFetchNext(  hSql(), nTmp )
						                                                                                                                                                                                                                   Return VALIDATE_Ok
			Background Text: по
				Resource Id: 64991
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   3.383"
					Top:    1.012"
					Width:  0.4"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Center
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Data Field: FDAT2
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: Date/Time
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   3.85"
						Top:    0.988"
						Width:  1.367"
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
					! On SAM_Validate
						                                                                                                                                                                                                                   If SqlPrepareAndExecute( hSql(),
								  "SELECT fdat INTO :dat2 FROM fdat WHERE fdat=:FDAT2")
								and SqlFetchNext(  hSql(), nTmp )
						                                                                                                                                                                                                                   Return VALIDATE_Ok
			!
			Pushbutton: pb1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Утвердить
				Window Location and Size
					Left:   2.617"
					Top:    1.357"
					Width:  1.529"
					Width Editable? Yes
					Height: 0.344"
					Height Editable? Yes
				Visible? Yes
				Keyboard Accelerator: Enter
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
						If SalIsNull( FDAT ) 
							Set dat=GetBankDate(  )
						Else
							Set dat=FDAT
						If SalIsNull( FDAT2 )
							Set dat2=GetBankDate(  )
						Else
							Set dat2=FDAT2
						Call SalEndDialog(hWndForm, 1)
		Functions
		Window Parameters
			Receive Number: isp
			Receive Number: kv
			Receive String: nls
			Receive Date/Time: dat
			Receive Date/Time: dat2
		Window Variables
			Number: nTmp
		Message Actions
			On SAM_Create
				Call SalCenterWindow(hWndItem)
				Call SetWindowFont( hWndForm )
				Call SalWaitCursor( FALSE )
				Set ISP=isp
				Set FDAT=dat
				Set FDAT2=dat2
				If SqlPrepareAndExecute( hSql(),
						  "SELECT fio INTO :sFIO FROM staff WHERE id=:ISP")
						and SqlFetchNext(  hSql(), nTmp )
	Form Window: win_meter
		Class:
		Property Template:
		Class DLL Name:
		Title:
		Icon File:
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Etched
			Visible at Design time? No
			Automatically Created at Runtime? No
			Initial State: Normal
			Maximizable? No
			Minimizable? No
			System Menu? Yes
			Resizable? No
			Window Location and Size
				Left:   2.763"
				Top:    2.073"
				Width:  5.2"
				Width Editable? Yes
				Height: 1.262"
				Height Editable? Yes
			Form Size
				Width:  Default
				Height: Default
				Number of Pages: 0
			Font Name: MS Sans Serif
			Font Size: 8
			Font Enhancement: Bold
			Text Color: Default
			Background Color: Default
		Description: Process indicator dialog
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
			Custom Control: ProcIndicator
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
						Left:   0.329"
						Top:    0.325"
						Width:  4.429"
						Width Editable? Class Default
						Height: 0.333"
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
					Text Color: Dark Blue
					Background Color: System Window Color
					DLL Settings
				Message Actions
		Functions
		Window Parameters
			String: PIndTitle
			Number: Bound
		Window Variables
			Number: nPerCent
		Message Actions
			On SAM_Create
				Call SalSetWindowText(hWndForm, PIndTitle)
				Call SetWindowFont( hWndForm )
				Call SalCenterWindow(hWndForm)
			On SAM_Close
				Return FALSE
			On UM_Populate
				Set nPerCent = SalNumberRound((lParam / Bound) * 100)
				Call ProcIndicator.SetProgress (nPerCent)
				Return TRUE
	Dialog Box: dlgEditBrates
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
				Width:  7.75"
				Width Editable? Yes
				Height: 4.65"
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
					Left:   0.08"
					Top:    0.06"
					Width:  7.5"
					Width Editable? Yes
					Height: 3.55"
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
			Background Text: Отделение
				Resource Id: 27730
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.2"
					Top:    0.2"
					Width:  6.55"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Dark Blue
				Background Color: Default
			Data Field: bgBranch
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
			Background Text: Базовая ставка:
				Resource Id: 27732
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.267"
					Top:    0.583"
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
			Data Field: bgBrName
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
			Data Field: dfBrName
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
						Top:    0.5"
						Width:  4.9"
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
			Background Text: Валюта:
				Resource Id: 37301
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.267"
					Top:    0.881"
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
			Data Field: bgKv
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
			Data Field: dfKv
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 3
					Data Type: Number
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    0.8"
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
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_Validate
						Call SqlPrepareAndExecute(hSql(),
								"SELECT kv INTO :dfKv FROM tabval WHERE kv=:dfKv AND (d_close is null or d_close>bankdate)")
						If not SqlFetchNext(hSql(), nFetchRes)
							Set dfKv  = NUMBER_Null
						Call cmbKv.SetSelectById(dfKv)
						Return VALIDATE_Ok
			Combo Box: cmbKv
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_NumId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   3.4"
					Top:    0.8"
					Width:  4.0"
					Width Editable? Class Default
					Height: 2.274"
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
						If cmbKv.Init(hWndItem)
							Call cmbKv.Populate(hSql(), 'kv', 'name', 'tabval', 'order by skv')
							Call cmbKv.SetSelectById(dfKv)
					On SAM_Click
						Call SalSendClassMessage(SAM_Click, 0, 0)
						Set dfKv = cmbKv.GetCurrentKey()
			Background Text: Дата установки:
				Resource Id: 27731
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.267"
					Top:    1.179"
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
			Data Field: bgBDate
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
			Data Field: dfBDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: Default
					Data Type: Date/Time
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    1.1"
						Width:  2.0"
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
			Background Text: Старое значение:
				Resource Id: 27733
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.267"
					Top:    1.488"
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
			Data Field: bgOldRate
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
			Data Field: dfOldRate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 11
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    1.4"
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
			Background Text: Новое значение:
				Resource Id: 27734
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.267"
					Top:    1.786"
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
			Data Field: bgNewRate
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
			Data Field: dfNewRate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 11
					Data Type: Number
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    1.7"
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
					On SAM_Validate
						! Формат ставки
						Set dfNewRate = Abs(dfNewRate)
						If dfNewRate > 100
							! Ставка не должна превышать 100% !!!
							Call SalMessageBox(CurrentLangTable.GetAtomTitle('dlgEditBrates.cTMessRate100'), 
									     CurrentLangTable.GetAtomTitle('cTAt'), MB_IconExclamation | MB_Ok)
							Return VALIDATE_Cancel
						Set dfNewRate = dfNewRate - SalNumberMod(dfNewRate,1) + 
								    Val(Subs(Str(SalNumberMod(dfNewRate,1)*SalNumberPower(10,8)),1,8))/SalNumberPower(10,8)
						Return VALIDATE_Ok
			Pushbutton: pbIns
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbInsert
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   6.033"
					Top:    1.631"
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
						Call SalSendMsg(tblBrTier, UM_Insert, 0, 0)
			Pushbutton: pbDel
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbDelete
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   6.517"
					Top:    1.631"
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
						Call SalSendMsg(tblBrTier, UM_Delete, 0, 0)
			Child Table: tblBrTier
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Display Settings
					Window Location and Size
						Left:   0.2"
						Top:    2.0"
						Width:  7.2"
						Width Editable? Yes
						Height: 1.5"
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
					Column: colS
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Граничная сумма (в коп.)
						Visible? Class Default
						Editable? Class Default
						Maximum Data Length: 24
						Data Type: String
						Justify: Right
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
					Column: colOldRate
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Старое значение
						Visible? Class Default
						Editable? No
						Maximum Data Length: 11
						Data Type: Number
						Justify: Right
						Width:  1.7"
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
					Column: colNewRate
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Новое значение
						Visible? Class Default
						Editable? Class Default
						Maximum Data Length: 11
						Data Type: Number
						Justify: Right
						Width:  1.7"
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
							On SAM_Validate
								! Формат ставки
								Set colNewRate = Abs(colNewRate)
								If colNewRate > 100
									! Ставка не должна превышать 100% !!!
									Call SalMessageBox(CurrentLangTable.GetAtomTitle('dlgEditBrates.cTMessRate100'), 
											     CurrentLangTable.GetAtomTitle('cTAt'), MB_IconExclamation | MB_Ok)
									Return VALIDATE_Cancel
								Set colNewRate = colNewRate - SalNumberMod(colNewRate,1) + 
										    Val(Subs(Str(SalNumberMod(colNewRate,1)*SalNumberPower(10,8)),1,8))/SalNumberPower(10,8)
								Return VALIDATE_Ok
				Functions
				Window Variables
					Number: nRow
					Number: nCount
					String: sTmpBranch
				Message Actions
					On SAM_Create
						Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
						! Ступенчатая
						If nBrType = 2 or nBrType = 3 or nBrType = 5 or nBrType = 6 or nBrType = 7 or nBrType = 8
							Set nRow = 0
							Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
					On UM_Populate
						Call SqlPrepareAndExecute(hSql(), 
								"SELECT count(*) INTO :nCount FROM br_tier_edit 
								 WHERE br_id=:nBrId AND bdate=:dBDate AND kv=:nKv AND branch=:sBranch")
						If SqlFetchNext(hSql(), nFetchRes) AND nCount > 0
							Set sTmpBranch = sBranch
						Else
							Set sTmpBranch = sCurrTobo
						Call SalTblPopulate(hWndForm, hSql(), 
								"SELECT to_char(s), rate INTO :colS, :colOldRate 
								 FROM br_tier_edit 
								 WHERE br_id=:nBrId AND bdate=:dBDate AND kv=:nKv AND branch=:sTmpBranch", TBL_FillAll)
					On UM_Insert
						Set nRow = SalTblInsertRow(hWndForm, nRow)
						Call SalTblSetContext(hWndForm, nRow)
						Call SalTblSetFocusCell(hWndForm, nRow, colS, 0, 1)
					On UM_Delete
						Set nRow = TBL_MinRow
						While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
							If NOT SalTblQueryRowFlags(hWndForm, nRow, ROW_New)
								Call SalTblSetRowFlags(hWndForm, nRow, ROW_MarkDeleted,
										  not SalTblQueryRowFlags(hWndForm, nRow, ROW_MarkDeleted))
							Else
								Call SalTblDeleteRow(hWndForm, nRow, TBL_NoAdjust)
					On SAM_FetchRowDone
						Set colNewRate = colOldRate
						Set nRow = nRow + 1
			Picture: pic2
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   0.08"
					Top:    3.65"
					Width:  7.5"
					Width Editable? Yes
					Height: 0.65"
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
			Pushbutton: pbSave
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbLabeledOk
				Property Template:
				Class DLL Name:
				Title: Применить
				Window Location and Size
					Left:   4.65"
					Top:    3.75"
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
						! Ступенчатая
						If nBrType = 2 or nBrType = 3 or nBrType = 5 or nBrType = 6 or nBrType = 7 or nBrType = 8
							! Проверка на заполнение таблицы
							Set nRow = TBL_MinRow
							Set nRowUpdate = 0
							While SalTblFindNextRow(tblBrTier, nRow, 0, ROW_MarkDeleted)
								Call SalTblSetContext(tblBrTier, nRow)
								Set smS[nRowUpdate]    = tblBrTier.colS
								Set nmRate[nRowUpdate] = tblBrTier.colNewRate
								Set nRowUpdate = nRowUpdate + 1
							If nRowUpdate = 0
								! Не заполнены суммы!
								Call SalMessageBox(CurrentLangTable.GetAtomTitle('dlgEditBrates.cTMessSumm'), 
										     CurrentLangTable.GetAtomTitle('cTAt'), MB_IconExclamation | MB_Ok)
								Return FALSE
							! Добавление
							If nEdit = 0
								If dfKv    = NUMBER_Null
										or dfBDate = DATETIME_Null
									! Заполнены не все реквизиты!
									Call SalMessageBox(CurrentLangTable.GetAtomTitle('dlgEditBrates.cTMessRekv'), 
											     CurrentLangTable.GetAtomTitle('cTAt'), MB_IconExclamation | MB_Ok)
									Return FALSE
								Else
									If NOT insTierRate(sBranch)
										Return FALSE
									If bAll
										If NOT updTierRateSub(sBranch)
											Return FALSE
							! Обновление
							Else If nEdit = 1
								If NOT updTierRate(sBranch)
									Return FALSE
								If bAll
									If NOT updTierRateSub(sBranch)
										Return FALSE
						! Нормальная
						Else
							! Добавление
							If nEdit = 0
								If dfNewRate = NUMBER_Null
										or dfKv      = NUMBER_Null
										or dfBDate   = DATETIME_Null
									! Заполнены не все реквизиты!
									Call SalMessageBox(CurrentLangTable.GetAtomTitle('dlgEditBrates.cTMessRekv'), 
											     CurrentLangTable.GetAtomTitle('cTAt'), MB_IconExclamation | MB_Ok)
									Return FALSE
								Else
									If NOT insNormalRate(sBranch)
										Return FALSE
									If bAll
										If NOT updNormalRateSub(sBranch)
											Return FALSE
							! Обновление
							Else If nEdit = 1
								If NOT updNormalRate(sBranch)
									Return FALSE
								If bAll
									If NOT updNormalRateSub(sBranch)
										Return FALSE
						Call SalEndDialog(hWndForm, TRUE)
			Pushbutton: pbCancel
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbLabeledCancel
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   6.2"
					Top:    3.75"
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
						Call SalEndDialog(hWndForm, 0)
		Functions
			Function: insNormalRate
				Description:
				Returns
					Boolean:
				Parameters
					String: sTobo
				Static Variables
				Local variables
				Actions
					If NOT SqlPrepareAndExecute(hSql(), 
							"INSERT INTO br_normal_edit(br_id, bdate, kv, rate, branch)
							 VALUES (:nBrId, :dfBDate, :dfKv, :dfNewRate, :sTobo)")
						Call SqlRollbackEx(hSql(), "BRATES. Не удалось добавить ставку " || Str(nBrId) || " для отделения " || sTobo)
						Return FALSE
					! Добавлена ставка nBrId (type=nBrType kv=dfKv bdate=dfBDate)=dfNewRate для отделения sTobo
					Call SqlCommitEx(hSql(), "BRATES. " || CurrentLangTable.GetAtomTitle('dlgEditBrates.cTIns') || " " || Str(nBrId) || 
							     " (type=" || Str(nBrType) || " kv=" || Str(dfKv) || " bdate=" || SalFmtFormatDateTime(dfBDate, 'dd/MM/yyyy') || ")=" || Str(dfNewRate) || " " || 
							     CurrentLangTable.GetAtomTitle('dlgEditBrates.cTBranch') || " " || sTobo)
					Return TRUE
			Function: updNormalRate
				Description:
				Returns
					Boolean:
				Parameters
					String: sTobo
				Static Variables
				Local variables
				Actions
					If SqlPrepareAndExecute(hSql(), 
							"BEGIN
							   UPDATE br_normal_edit SET rate=" || VisStrSubstitute(Str(dfNewRate), ",", ".") || " 
							    WHERE br_id=" || Str(nBrId) || " 
							      AND bdate=to_date('" || SalFmtFormatDateTime(dfBDate, 'dd/MM/yyyy') || "', 'dd/MM/yyyy') 
							      AND kv=" || Str(dfKv) || "
							      AND branch='" || sTobo || "';
							   if sql%rowcount=0 then
							     INSERT INTO br_normal_edit(br_id, bdate, kv, rate, branch)
							     VALUES (" || Str(nBrId) || ", to_date('" || SalFmtFormatDateTime(dfBDate, 'dd/MM/yyyy') || "', 'dd/MM/yyyy'), " || 
							       Str(dfKv) || ", " || VisStrSubstitute(Str(dfNewRate), ",", ".") || ", '" || sTobo || "');
							   end if;
							 END;")
						! Обновлена ставка nBrId (type=nBrType kv=dfKv bdate=dfBDate)=dfNewRate для отделения sTobo
						Call SqlCommitEx(hSql(), "BRATES. " || CurrentLangTable.GetAtomTitle('dlgEditBrates.cTUpdate') || " " || Str(nBrId) || 
								     " (type=" || Str(nBrType) || " kv=" || Str(dfKv) || " bdate=" || SalFmtFormatDateTime(dfBDate, 'dd/MM/yyyy') || ")=" || Str(dfNewRate) || " " || 
								     CurrentLangTable.GetAtomTitle('dlgEditBrates.cTBranch') || " " || sTobo)
					Else
						! Не удалось обновить ставку nBrId для отделения sTobo
						Call SqlRollbackEx(hSql(), "BRATES. " || CurrentLangTable.GetAtomTitle('dlgEditBrates.cTNotUpdate') || " " || Str(nBrId) || " " || 
								     CurrentLangTable.GetAtomTitle('dlgEditBrates.cTBranch') || " " || sTobo)
						Return FALSE
					Return TRUE
			Function: updNormalRateSub
				Description:
				Returns
					Boolean:
				Parameters
					String: sTobo
				Static Variables
				Local variables
					String: sBranchTmp
					String: smBranch[*]
					Number: nNumBranch
					Number: i
				Actions
					Set nNumBranch = 0
					Call SqlPrepareAndExecute(hSql(), 
							"SELECT branch INTO :sBranchTmp FROM br_normal_edit
							  WHERE br_id=:nBrId AND bdate=:dfBDate AND kv=:dfKv AND branch<>:sTobo
							    AND branch like '" || sTobo || "%'")
					While SqlFetchNext(hSql(), nFetchRes)
						! Для отделения sBranchTmp уже занесена ставка. Обновить?
						If SalMessageBox(CurrentLangTable.GetAtomTitle('dlgEditBrates.cTBranch1') || " " || sBranchTmp || PutCrLf() || 
								   CurrentLangTable.GetAtomTitle('dlgEditBrates.cTSave'), 
								   CurrentLangTable.GetAtomTitle('cTAt'), MB_IconExclamation | MB_YesNo) = IDYES
							Set smBranch[nNumBranch] = sBranchTmp
							Set nNumBranch = nNumBranch + 1
					If nNumBranch > 0
						Set i = 0
						While i < nNumBranch
							Set sBranchTmp = smBranch[i]
							If NOT SqlPrepareAndExecute(hSql(), 
									"DELETE FROM br_normal_edit 
									  WHERE br_id=:nBrId AND bdate=:dfBDate AND kv=:dfKv AND branch=:sBranchTmp")
								! Не удалось обновить ставку nBrId для отделения sBranchTmp
								Call SqlRollbackEx(hSql(), "BRATES. " || CurrentLangTable.GetAtomTitle('dlgEditBrates.cTNotUpdate') || " " || Str(nBrId) || " " || 
										     CurrentLangTable.GetAtomTitle('dlgEditBrates.cTBranch') || " " || sBranchTmp)
								Return FALSE
							! Обновлена ставка nBrId (type=nBrType kv=dfKv bdate=dfBDate)=dfNewRate для отделения sBranchTmp
							Call SqlCommitEx(hSql(), "BRATES. " || CurrentLangTable.GetAtomTitle('dlgEditBrates.cTUpdate') || " " || Str(nBrId) || 
									     " (type=" || Str(nBrType) || " kv=" || Str(dfKv) || " bdate=" || SalFmtFormatDateTime(dfBDate, 'dd/MM/yyyy') || ")=" || Str(dfNewRate) || " " || 
									     CurrentLangTable.GetAtomTitle('dlgEditBrates.cTBranch') || " " || sBranchTmp)
							Set i = i + 1
					Return TRUE
			Function: insTierRate
				Description:
				Returns
					Boolean:
				Parameters
					String: sTobo
				Static Variables
				Local variables
					Number: j
					String: sS
					Number: nNewRate
				Actions
					Set j = 0
					While j < nRowUpdate
						Set sS    = smS[j]
						Set nRate = nmRate[j]
						If SqlPrepareAndExecute(hSql(), 
								"INSERT INTO br_tier_edit(br_id, bdate, kv, s, rate, branch)
								 VALUES (:nBrId, :dfBDate, :dfKv, to_number(:sS), :nRate, :sTobo)")
							! Добавлена ставка nBrId (type=nBrType kv=dfKv bdate=dfBDate)=nNewRate, s=nS для отделения sTobo
							Call SqlCommitEx(hSql(), "BRATES. " || CurrentLangTable.GetAtomTitle('dlgEditBrates.cTIns') || " " || Str(nBrId) || 
									     " (type=" || Str(nBrType) || " kv=" || Str(dfKv) || " bdate=" || SalFmtFormatDateTime(dfBDate, 'dd/MM/yyyy') || ")=" || Str(nNewRate) ||
									     ", s=" || sS || " " || 
									     CurrentLangTable.GetAtomTitle('dlgEditBrates.cTBranch') || " " || sTobo)
						Else
							! Не удалось добавить ставку nBrId для отделения sTobo
							Call SqlRollbackEx(hSql(), "BRATES. " || CurrentLangTable.GetAtomTitle('dlgEditBrates.cTNotIns') || " " || Str(nBrId) || " " || 
									     CurrentLangTable.GetAtomTitle('dlgEditBrates.cTBranch') || " " || sTobo)
							Return FALSE
						Set j = j + 1
					Return TRUE
			Function: updTierRate
				Description:
				Returns
					Boolean:
				Parameters
					String: sTobo
				Static Variables
				Local variables
				Actions
					If SqlPrepareAndExecute(hSql(), 
							"DELETE FROM br_tier_edit 
							  WHERE br_id=:nBrId AND bdate=:dfBDate AND kv=:dfKv AND branch=:sTobo")
						! Удалена ставка nBrId (type=nBrType) для отделения sTobo
						Call SqlCommitEx(hSql(), CurrentLangTable.GetAtomTitle('dlgEditBrates.cTDelete') || " " || Str(nBrId) || "(type=" || Str(nBrType) || " " || 
								     CurrentLangTable.GetAtomTitle('dlgEditBrates.cTBranch') || " " || sTobo)
					Else
						! Не удалось удалить ставку nBrId для отделения sTobo
						Call SqlRollbackEx(hSql(), "BRATES. " || CurrentLangTable.GetAtomTitle('dlgEditBrates.cTNotDelete') || " " || Str(nBrId) || " " || 
								     CurrentLangTable.GetAtomTitle('dlgEditBrates.cTBranch') || " " || sTobo)
						Return FALSE
					Return insTierRate(sTobo)
			Function: updTierRateSub
				Description:
				Returns
					Boolean:
				Parameters
					String: sTobo
				Static Variables
				Local variables
					String: sBranchTmp
					String: smBranch[*]
					Number: nNumBranch
					Number: i
				Actions
					Set nNumBranch = 0
					Call SqlPrepareAndExecute(hSql(), 
							"SELECT distinct branch INTO :sBranchTmp FROM br_tier_edit
							  WHERE br_id=:nBrId AND bdate=:dfBDate AND kv=:dfKv AND branch<>:sTobo
							    AND branch like '" || sTobo || "%'")
					While SqlFetchNext(hSql(), nFetchRes)
						! Для отделения sBranchTmp уже занесена ставка. Обновить?
						If SalMessageBox(CurrentLangTable.GetAtomTitle('dlgEditBrates.cTBranch1') || " " || sBranchTmp || PutCrLf() || 
								   CurrentLangTable.GetAtomTitle('dlgEditBrates.cTSave'), 
								   CurrentLangTable.GetAtomTitle('cTAt'), MB_IconExclamation | MB_YesNo) = IDYES
							Set smBranch[nNumBranch] = sBranchTmp
							Set nNumBranch = nNumBranch + 1
					If nNumBranch > 0
						Set i = 0
						While i < nNumBranch
							Set sBranchTmp = smBranch[i]
							If NOT SqlPrepareAndExecute(hSql(), 
									"DELETE FROM br_tier_edit 
									  WHERE br_id=:nBrId AND bdate=:dfBDate AND kv=:dfKv AND branch=:sBranchTmp")
								! Не удалось обновить ставку nBrId для отделения sBranchTmp
								Call SqlRollbackEx(hSql(), "BRATES. " || CurrentLangTable.GetAtomTitle('dlgEditBrates.cTNotUpdate') || " " || Str(nBrId) || " " || 
										     CurrentLangTable.GetAtomTitle('dlgEditBrates.cTBranch') || " " || sBranchTmp)
								Return FALSE
							! Обновлена ставка nBrId (type=nBrType kv=dfKv bdate=dfBDate)=dfNewRate для отделения sBranchTmp
							Call SqlCommitEx(hSql(), "BRATES. " || CurrentLangTable.GetAtomTitle('dlgEditBrates.cTUpdate') || " " || Str(nBrId) || 
									     " (type=" || Str(nBrType) || " kv=" || Str(dfKv) || " bdate=" || SalFmtFormatDateTime(dfBDate, 'dd/MM/yyyy') || ")=" || Str(dfNewRate) || " " || 
									     CurrentLangTable.GetAtomTitle('dlgEditBrates.cTBranch') || " " || sBranchTmp)
							Set i = i + 1
					Return TRUE
		Window Parameters
			Number: nEdit	! =0 -insert, =1 -update
			String: sBranch
			String: sBranchName
			Number: nBrId
			Number: nKv
			Date/Time: dBDate
			String: sBrName
			Number: nBrType
			Number: nRate
		Window Variables
			Number: nX
			Number: nY
			Number: nFetchRes
			Number: nRow
			String: smS[*]
			Number: nmRate[*]
			Number: nRowUpdate
			Boolean: bAll
			Number: nRateTmp
		Message Actions
			On SAM_Create
				! Присваиваем значения многоязыковым объектам
				Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
				! Добавление процентной ставки / Обновление процентной ставки
				Call SalSetWindowText(hWndForm, IifS(nEdit=0,
						     CurrentLangTable.GetAtomTitle('dlgEditBrates.cTWndTitleIns'), 
						     CurrentLangTable.GetAtomTitle('dlgEditBrates.cTWndTitleEdit')))
				! Ступенчатая
				If nBrType = 2 or nBrType = 3 or nBrType = 5 or nBrType = 6 or nBrType = 7 or nBrType = 8
					Call SalHideWindowAndLabel(bgOldRate)
					Call SalHideWindowAndLabel(bgNewRate)
					Call SalHideWindow(dfOldRate)
					Call SalHideWindow(dfNewRate)
					Call SalSetWindowLoc(pbIns, 0.2, 1.6)
					Call SalSetWindowLoc(pbDel, 0.7, 1.6)
					If nEdit = 0
						Call SalHideWindow(tblBrTier.colOldRate)
					Else
						Call SalDisableWindow(dfBDate)
						Call SalDisableWindow(dfKv)
						Call SalDisableWindow(cmbKv)
				! Нормальная
				Else
					Call SalHideWindow(pbIns)
					Call SalHideWindow(pbDel)
					Call SalHideWindow(tblBrTier)
					Call SalGetWindowSize(pic1, nX, nY)
					Call SalSetWindowSize(pic1, nX, nY-1.5)
					Call SalGetWindowLoc(pic2, nX, nY)
					Call SalSetWindowLoc(pic2, nX, nY-1.5)
					Call SalGetWindowLoc(pbSave, nX, nY)
					Call SalSetWindowLoc(pbSave, nX, nY-1.5)
					Call SalGetWindowLoc(pbCancel, nX, nY)
					Call SalSetWindowLoc(pbCancel, nX, nY-1.5)
					Call SalGetWindowSize(hWndForm, nX, nY)
					Call SalSetWindowSize(hWndForm, nX, nY-1.5)
					If nEdit = 0
						! Значение:
						Call SalSetWindowLabelText(bgOldRate, CurrentLangTable.GetAtomTitle('dlgEditBrates.bgRate'))
						Call SalHideWindowAndLabel(bgNewRate)
						Call SalHideWindow(dfOldRate)
						Call SalGetWindowLoc(dfOldRate, nX, nY)
						Call SalSetWindowLoc(dfNewRate, nX, nY)
						Call SalGetWindowSize(pic1, nX, nY)
						Call SalSetWindowSize(pic1, nX, nY-0.3)
						Call SalGetWindowLoc(pic2, nX, nY)
						Call SalSetWindowLoc(pic2, nX, nY-0.3)
						Call SalGetWindowLoc(pbSave, nX, nY)
						Call SalSetWindowLoc(pbSave, nX, nY-0.3)
						Call SalGetWindowLoc(pbCancel, nX, nY)
						Call SalSetWindowLoc(pbCancel, nX, nY-0.3)
						Call SalGetWindowSize(hWndForm, nX, nY)
						Call SalSetWindowSize(hWndForm, nX, nY-0.3)
					Else
						Call SalDisableWindow(dfBDate)
						Call SalDisableWindow(dfKv)
						Call SalDisableWindow(cmbKv)
				!
				Call SalSetWindowLabelText(bgBranch, sBranchName)
				Set bAll = FALSE
				If sBranch = '-' OR sBranch = sCurrTobo
					Set bAll = TRUE
					Set sBranch = sCurrTobo
				Set dfKv      = IifN(nKv=0, NUMBER_Null, nKv)
				Set dfBDate   = dBDate
				Set dfOldRate = nRate
				Set dfNewRate = nRate
				Set dfBrName  = sBrName
				Call SalCenterWindow(hWndForm)
	Form Window: DlgSOT		!! 05 Ведення базових процентних ставок
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
			Initial State: Normal
			Maximizable? Class Default
			Minimizable? Class Default
			System Menu? Class Default
			Resizable? Class Default
			Window Location and Size
				Left:   0.54"
				Top:    0.667"
				Width:  6.85"
				Width Editable? Class Default
				Height: 6.0"
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
		Description: Ведення базових процентних ставок
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
							If nHaveTobo = 2
								! bEdit = 0 - добавление
								If dfBrId > 0
									If SalModalDialog(dlgEditBrates, hWndForm, 0, sBranch, 
											   cmbBranch.GetNameById(IifS(sBranch='-',sCurrTobo,sBranch)), 
											   dfBrId, NUMBER_Null, GetBankDate(), dfBrName, nBrType, NUMBER_Null)
										Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
							Else
								Call SalSendClassMessage(SAM_Click, 0, 0)
				Pushbutton: pbDel
					Class Child Ref Key: 15
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
					Class Child Ref Key: 16
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
					Resource Id: 127
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
				Pushbutton: pbSearch
					Class Child Ref Key: 19
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
					Class Child Ref Key: 21
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
					Resource Id: 128
					Class Child Ref Key: 23
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
				Pushbutton: pbEdit
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbEdit
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.05"
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
							! bEdit = 1 - редактирование
							If dfBrId > 0 AND tbl.cKv
								If SalModalDialog(dlgEditBrates, hWndForm, 1, sBranch, 
										   cmbBranch.GetNameById(IifS(sBranch='-',sCurrTobo,sBranch)), 
										   dfBrId, tbl.cKv, tbl.cDatB, dfBrName, nBrType, tbl.cIr)
									Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
						On SAM_TooltipSetText
							! 'Редактировать ставку'
							Return XSalTooltipSetText(lParam, CurrentLangTable.GetAtomTitle('DlgSOT.cBTipEdit'))
				Pushbutton: pbArch
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbSwitch
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.5"
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
					Picture File Name: \BARS98\RESOURCE\BMP\TUDASUDA.BMP
					Picture Transparent Color: White
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Click
							Set bArch = NOT bArch
							Call SalSendMsg(hWndForm, SAM_User, 0, 0)
							Call SalSendMsg(tbl, UM_Populate, 0, 0)
						On SAM_TooltipSetText
							If NOT bArch
								! За все дни'
								Return XSalTooltipSetText(lParam, CurrentLangTable.GetAtomTitle('DlgSOT.cBTipArchAll'))
							Else
								! 'На текущий день'
								Return XSalTooltipSetText(lParam, CurrentLangTable.GetAtomTitle('DlgSOT.cBTipArchTek'))
				Line
					Resource Id: 130
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  5.033"
						Begin Y:  0.429"
						End X:  5.033"
						End Y:  0.012"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Pushbutton: pbExit
					Class Child Ref Key: 24
					Class ChildKey: 0
					Class: cGenericTableFrm
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   5.133"
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
					Resource Id: 129
					Class Child Ref Key: 25
					Class ChildKey: 0
					Class: cGenericTableFrm
					Coordinates
						Begin X:  5.667"
						Begin Y:  0.44"
						End X:  5.667"
						End Y:  0.024"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
		Contents
			Data Field: dfBrId
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
						Left:   0.1"
						Top:    0.1"
						Width:  0.8"
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
			Data Field: dfBrName
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
						Left:   0.95"
						Top:    0.1"
						Width:  5.15"
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
			Pushbutton: pbBrate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbFilter
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   6.15"
					Top:    0.024"
					Width:  0.45"
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
						If FunNSIGetFiltered("brates", "name", "brates.br_type in (1,2,3,5,6,7,8) " ||
								   IifS(GetGlobalOption('BRATINUS')=STRING_Null, "", " and brates.inuse=1 ") ||
								   "order by br_id", s1, s2)
							Set dfBrId = Val(s1)
							Set dfBrName = s2
							Call SqlPrepareAndExecute(hSql(), "select br_type into :nBrType from brates where br_id = :dfBrId") 
							Call SqlFetchNext(hSql(), nFetchRes)
							Call SalSendMsg(hWndForm, SAM_User, 0, 0)
							Call SalSendMsg(tbl, UM_Populate, 0, 0)
						Else
							Set dfBrId   = NUMBER_Null
							Set dfBrName = STRING_Null
							Set nBrType  = NUMBER_Null
							Call SalTblReset(tbl)
			! cGenComboBox_NumId: cmb_Brate
.winattr class Combo Box:
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_NumId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   7.417"
					Top:    0.917"
					Width:  5.1"
					Width Editable? Yes
					Height: 3.667"
					Height Editable? Yes
				Visible? Yes
				Editable? Yes
				String Type: String
				Maximum Data Length: Default
				Sorted? No
				Always Show List? No
				Vertical Scroll? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
				Input Mask: Unformatted
.end
				                           List Initialization 
				                           Message Actions 
					                           On SAM_Create
						                           Call SqlPrepareAndExecute(hSql(), 
								"SELECT name, br_id, br_type INTO :sTmp, :nBrId, :nBrTy
								   FROM brates WHERE br_type in (1,2,3,5,6,7) " ||
								        IifS(GetGlobalOption('BRATINUS')=STRING_Null, "", " AND inuse=1 ") ||
								" ORDER by br_id") 
						                           Set nTmp = 0
						                           Call SalArraySetUpperBound(mId, 1, -1)
						                           Call SalListClear(hWndItem)
						                           While SqlFetchNext(hSql(), nFetchRes)
							                           Call SalListAdd(hWndItem, sTmp)
							                           Set mId[nTmp] = nBrId
							                           Set mTy[nTmp] = nBrTy
							                           Set nTmp = nTmp + 1
						                           If nTmp = 1
							                           Call SalDisableWindow(hWndItem)
						                           Call SalListSetSelect(hWndItem, 0)
						                           Call SalSendMsg(hWndItem, SAM_Click, 0, 0)
					                           On SAM_Click
						                           Set nTmp = SalListQuerySelection(hWndItem)
						                           If nTmp >= 0
							                           Set nBrId = mId[nTmp]
							                           Set nBrTy = mTy[nTmp]
						                           Else 
							                           Set nBrId = 0
							                           Set nBrTy = 0
						                           Set dfBrId = nBrId
						                           Call SalSendMsg(hWndForm, SAM_User, 0, 0)
						                           Call SalSendMsg(tbl, UM_Populate, 0, 0)
						                           Call SalWaitCursor(FALSE)
			Combo Box: cmbBranch
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_StrId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   0.1"
					Top:    0.4"
					Width:  6.5"
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
						If cmbBranch.Init(hWndItem)
							Call cmbBranch.Populate(hSql(), "BRANCH", "BRANCH || ' ' || NAME", "OUR_BRANCH", " ORDER BY BRANCH")
							Call cmbBranch.Add('-', 'Все отделения')
							Call cmbBranch.SetSelectById(sBranch)
					On SAM_Click
						Call SalSendClassMessage(SAM_Click, 0, 0)
						Set sBranch = cmbBranch.GetCurrentKey()
						Call SalSendMsg(hWndForm, SAM_User, 0, 0)
						Call SalSendMsg(tbl, UM_Populate, 0, 0)
			Child Table: tbl
				Class Child Ref Key: 1
				Class ChildKey: 0
				Class: cGenericTableFrm
				Property Template:
				Class DLL Name:
				Display Settings
					Window Location and Size
						Left:   0.1"
						Top:    0.7"
						Width:  6.5"
						Width Editable? Class Default
						Height: 3.929"
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
					Maximum Rows in Memory: Class Default
					Discardable? Class Default
				Contents
					Column: cDatB
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Дата
						Visible? Class Default
						Editable? Class Default
						Maximum Data Length: Class Default
						Data Type: Date/Time
						Justify: Center
						Width:  1.067"
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
					Column: cKv
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Валюта
						Visible? Class Default
						Editable? Class Default
						Maximum Data Length: 3
						Data Type: Number
						Justify: Center
						Width:  0.967"
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
					Column: cIr
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Ставка
						Visible? Class Default
						Editable? Class Default
						Maximum Data Length: 11
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
							On SAM_Validate
								! Формат ставки
								Set cIr = Abs(cIr)
								If cIr > 100
									! Ставка не должна превышать 100% !!!
									Call SalMessageBox(CurrentLangTable.GetAtomTitle('dlgEditBrates.cTMessRate100'), 
											     CurrentLangTable.GetAtomTitle('cTAt'), MB_IconExclamation | MB_Ok)
									Return VALIDATE_Cancel
								Set cIr = cIr - SalNumberMod(cIr,1) + 
										    Val(Subs(Str(SalNumberMod(cIr,1)*SalNumberPower(10,8)),1,8))/SalNumberPower(10,8)
								Return VALIDATE_Ok
					Column: cS
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Сумма
						Visible? Class Default
						Editable? Class Default
						Maximum Data Length: Class Default
						Data Type: Class Default
						Justify: Right
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
					Column: cRowid
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
					Column: cBranch
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Код
								подразделения
						Visible? Class Default
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
					Column: cBranchName
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Наименование
								подразделения
						Visible? Class Default
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
				Functions
				Window Variables
				Message Actions
					On SAM_Create
						! Присваиваем значения многоязыковым объектам
						Call SalSendMsgToChildren( hWndForm, UM_QueryLabelText, 0, 0 )
					On UM_Populate
						If nHaveTobo = 2
							Call SalTblPopulate(hWndForm, hSql(), sPopulate, TBL_FillAll)
							Call SalTblSetContext(hWndForm, 0)
						Else
							Call SalSendClassMessage(UM_Populate, 0, 0)
						Call SalWaitCursor(FALSE)
						Call VisTblAutoSizeColumn(hWndForm, cDatB)
						Call VisTblAutoSizeColumn(hWndForm, cKv)
						Call VisTblAutoSizeColumn(hWndForm, cBranch)
						Call VisTblAutoSizeColumn(hWndForm, cBranchName)
		Functions
		Window Parameters
			Number: nType
		Window Variables
			Date/Time: dBD
			String: sPopulate
			! Number: nBrId
			Number: nBrType
			! Number: mId[*]
			! Number: mTy[*]
			! Number: nTmp
			! String: sTmp
			Number: nFetchRes
			String: sBranch
			Boolean: bArch
			Number: nX
			Number: nY
			Number: nWinX0
			Number: nWinY0
			Number: nWinWidth
			Number: nWinHeight
			String: sDopTbl
			String: s1
			String: s2
		Message Actions
			On SAM_Create
				! Присваиваем значения многоязыковым объектам
				Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
				Call SalDisableWindow(pbDetails)
				!
				Set dBD = GetBankDate()
				!
				If nHaveTobo = 2
					Set sBranch = sCurrTobo
					Set bArch   = FALSE
					Call SalDisableWindow(tbl.cDatB)
					Call SalDisableWindow(tbl.cKv)
					Call SalDisableWindow(tbl.cIr)
					Call SalDisableWindow(tbl.cS)
					Call SalSendMsg(cmbBranch, UM_ObjActivate, 0, 0)
				Else
					Call SalHideWindow(pbEdit)
					Call SalHideWindow(pbArch)
					Call SalHideWindow(DlgSOT.tbl.cBranch)
					Call SalHideWindow(DlgSOT.tbl.cBranchName)
					Call SalHideWindow(cmbBranch)
					Call SalGetWindowLoc(tbl, nX, nY)
					Call SalSetWindowLoc(tbl, nX, nY-0.3)
				!
				Call SalSendMsg(hWndForm, SAM_User, 0, 0)
			On SAM_User
				Set nFlags = GT_NoRet
				!
				If nHaveTobo = 2
					If sBranch != '-'
						Call SalHideWindow(tbl.cBranch)
						Call SalHideWindow(tbl.cBranchName)
					Else
						Call SalShowWindow(tbl.cBranch)
						Call SalShowWindow(tbl.cBranchName)
				!
				! Ступенчатая
				If nBrType = 2 or nBrType = 3 or nBrType = 5 or nBrType = 6 or nBrType = 7 or nBrType = 8
					! Ступенчатая процентная ставка
					Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('DlgSOT.cTSPS') || IifS(bArch, 
							     ' (' || CurrentLangTable.GetAtomTitle('DlgSOT.cTArch') || ')', ''))
					Call SalShowWindow(DlgSOT.tbl.cS)
					If nHaveTobo = 2
						Set DlgSOT.strSqlPopulate = ''
						If sBranch = '-'
							Set sDopTbl = 'br_tier_edit'
						Else
							Set sDopTbl = 
									"(SELECT b.br_id, b.bdate, b.kv, b.rate, b.s, b.branch
									    FROM br_tier_edit b  
									   WHERE b.branch=:sBranch 
									   union 
									  SELECT b.br_id, b.bdate, b.kv, b.rate, b.s, :sBranch
									    FROM br_tier_edit b, branch_mfo m
									   WHERE b.branch='/'||m.mfo||'/' 
									     and :sBranch like '/'||m.mfo||'/%' 
									     and (b.br_id, b.bdate, b.kv) not in 
									         (SELECT b.br_id, b.bdate, b.kv
									            FROM br_tier_edit b  
									           WHERE b.branch=:sBranch )
									   union 
									  SELECT b.br_id, b.bdate, b.kv, b.rate, b.s, :sBranch
									    FROM br_tier_edit b  
									   WHERE b.branch='/' 
									     and (b.br_id, b.bdate, b.kv) not in 
									         (SELECT b.br_id, b.bdate, b.kv
									            FROM br_tier_edit b  , branch_mfo m
									           WHERE b.branch in ('/'||m.mfo||'/', :sBranch)
									             and :sBranch like '/'||m.mfo||'/%' ) )"
						! На текущую дату
						If NOT bArch
							Set sPopulate = 
									"SELECT a.bdate, a.kv, b.rate, to_char(b.s), b.branch, r.name
									   INTO :DlgSOT.tbl.cDatB, :DlgSOT.tbl.cKv, :DlgSOT.tbl.cIr, 
									        :DlgSOT.tbl.cS, :DlgSOT.tbl.cBranch, :DlgSOT.tbl.cBranchName
									   FROM (SELECT br_id, max(bdate) bdate, kv, branch
									           FROM " || sDopTbl || "
									          WHERE br_id = :dfBrId and bdate <= :dBD
									          GROUP BY br_id, kv, branch) a, " || sDopTbl || " b, branch r
									  WHERE a.br_id=b.br_id AND a.bdate=b.bdate AND a.kv=b.kv 
									    AND a.branch=b.branch AND a.branch like '" || sCurrTobo||"%'" || IifS(sBranch='-', "", " AND b.branch=:sBranch") || "
									    AND a.branch=r.branch
									  ORDER BY a.bdate DESC, a.kv, b.s"
						! За все дни
						Else
							Set sPopulate = 
									"SELECT a.bdate, a.kv, a.rate, to_char(a.s), a.branch, r.name
									   FROM " || sDopTbl || " a, branch r
									   INTO :DlgSOT.tbl.cDatB, :DlgSOT.tbl.cKv, :DlgSOT.tbl.cIr, 
									        :DlgSOT.tbl.cS, :DlgSOT.tbl.cBranch, :DlgSOT.tbl.cBranchName
									  WHERE a.br_id=:dfBrId AND a.branch like '" || sCurrTobo||"%'" || IifS(sBranch='-', "", " AND a.branch=:sBranch") || "
									    AND a.branch=r.branch
									  ORDER BY a.bdate DESC, a.kv, a.s"
						Set DlgSOT.strSqlInsert = 
								"INSERT INTO br_tier_edit(br_id, bdate, kv, rate, s, branch)
								 VALUES (:DlgSOT.dfBrId, :DlgSOT.tbl.cDatB, :DlgSOT.tbl.cKv, :DlgSOT.tbl.cIr, 
								         to_number(:DlgSOT.tbl.cS), :DlgSOT.tbl.cBranch)"
						Set DlgSOT.strSqlDelete = 
								"DELETE FROM br_tier_edit 
								 WHERE br_id=:DlgSOT.dfBrId AND bdate=:DlgSOT.tbl.cDatB AND kv=:DlgSOT.tbl.cKv 
								   AND s=to_number(:DlgSOT.tbl.cS) AND branch=:DlgSOT.tbl.cBranch"
					Else
						Set DlgSOT.strSqlPopulate = 
								"SELECT bdate, kv, rate, to_char(s), rowid 
								   FROM br_tier
								   INTO :DlgSOT.tbl.cDatB, :DlgSOT.tbl.cKv, :DlgSOT.tbl.cIr, :DlgSOT.tbl.cS, :DlgSOT.tbl.cRowid
								  WHERE br_id=:dfBrId ORDER BY bdate DESC, kv, s"
						Set DlgSOT.strSqlInsert = 
								"INSERT INTO br_tier(br_id, bdate, kv, rate, s)
								 VALUES (:DlgSOT.dfBrId, :DlgSOT.tbl.cDatB, :DlgSOT.tbl.cKv, :DlgSOT.tbl.cIr, to_number(:DlgSOT.tbl.cS))"
						Set DlgSOT.strSqlUpdate = 
								"UPDATE br_tier
								 SET bdate=:DlgSOT.tbl.cDatB, kv=:DlgSOT.tbl.cKv,
								     rate=:DlgSOT.tbl.cIr, s=to_number(:DlgSOT.tbl.cS)
								 WHERE rowid=:DlgSOT.tbl.cRowid"
						Set DlgSOT.strSqlDelete = 
								"DELETE FROM br_tier WHERE rowid=:DlgSOT.tbl.cRowid"
				! Нормальная
				Else
					! Простая процентная ставка
					Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('DlgSOT.cTPPS') || IifS(bArch, 
							     ' (' || CurrentLangTable.GetAtomTitle('DlgSOT.cTArch') || ')', ''))
					Call SalHideWindow(DlgSOT.tbl.cS)
					If nHaveTobo = 2
						Set DlgSOT.strSqlPopulate = ''
						If sBranch = '-'
							Set sDopTbl = 'br_normal_edit'
						Else
							Set sDopTbl = 
									"(SELECT b.br_id, b.bdate, b.kv, b.rate, b.branch
									 FROM br_normal_edit b  
									 WHERE b.branch=:sBranch 
									 union 
									 SELECT b.br_id, b.bdate, b.kv, b.rate, :sBranch
									 FROM br_normal_edit b, branch_mfo m
									 WHERE b.branch='/'||m.mfo||'/' 
									   and :sBranch like '/'||m.mfo||'/%' 
									   and (b.br_id, b.bdate, b.kv) not in 
									       (SELECT b.br_id, b.bdate, b.kv
									        FROM br_normal_edit b  
									        WHERE b.branch=:sBranch )
									 union 
									 SELECT b.br_id, b.bdate, b.kv, b.rate, :sBranch
									 FROM br_normal_edit b  
									 WHERE b.branch='/' 
									   and (b.br_id, b.bdate, b.kv) not in 
									       (SELECT b.br_id, b.bdate, b.kv
									        FROM br_normal_edit b  , branch_mfo m
									        WHERE b.branch in ('/'||m.mfo||'/', :sBranch)
									          and :sBranch like '/'||m.mfo||'/%' ) )"
						! На текущую дату
						If NOT bArch
							Set sPopulate = 
									"SELECT a.bdate, a.kv, b.rate, b.branch, r.name
									   INTO :DlgSOT.tbl.cDatB, :DlgSOT.tbl.cKv, :DlgSOT.tbl.cIr, 
									        :DlgSOT.tbl.cBranch, :DlgSOT.tbl.cBranchName
									   FROM (SELECT br_id, max(bdate) bdate, kv, branch
									           FROM " || sDopTbl || "
									          WHERE br_id=:dfBrId and bdate<=:dBD
									          GROUP BY br_id, kv, branch) a, " || sDopTbl || " b, branch r
									  WHERE a.br_id=b.br_id AND a.bdate=b.bdate AND a.kv=b.kv 
									    AND a.branch=b.branch AND a.branch like '" || sCurrTobo||"%'
									    AND a.branch=r.branch
									  ORDER BY a.bdate, a.kv DESC, b.branch"
						! За все дни
						Else
							Set sPopulate = 
									"SELECT a.bdate, a.kv, a.rate, a.branch, r.name
									   INTO :DlgSOT.tbl.cDatB, :DlgSOT.tbl.cKv, :DlgSOT.tbl.cIr, 
									        :DlgSOT.tbl.cBranch, :DlgSOT.tbl.cBranchName
									   FROM " || sDopTbl || " a, branch r
									  WHERE a.br_id=:dfBrId AND a.branch like '" || sCurrTobo||"%'" || IifS(sBranch='-', "", " AND a.branch=:sBranch") || " 
									    AND a.branch=r.branch
									  ORDER BY a.bdate, a.kv DESC, a.branch"
						Set DlgSOT.strSqlInsert = 
								"INSERT INTO br_normal_edit(br_id, bdate, kv, rate, branch)
								 VALUES(:DlgSOT.dfBrId, :DlgSOT.tbl.cDatB, :DlgSOT.tbl.cKv, :DlgSOT.tbl.cIr, :DlgSOT.tbl.cBranch)"
						Set DlgSOT.strSqlDelete = 
								"DELETE FROM br_normal_edit 
								 WHERE br_id=:DlgSOT.dfBrId AND bdate=:DlgSOT.tbl.cDatB AND kv=:DlgSOT.tbl.cKv 
								   AND branch=:DlgSOT.tbl.cBranch"
					Else
						Set DlgSOT.strSqlPopulate = 
								"SELECT bdate, kv, rate, rowid 
								   INTO :DlgSOT.tbl.cDatB, :DlgSOT.tbl.cKv, :DlgSOT.tbl.cIr, :DlgSOT.tbl.cRowid
								   FROM br_normal
								  WHERE br_id=:DlgSOT.dfBrId ORDER BY bdate, kv DESC"
						Set DlgSOT.strSqlInsert = 
								"INSERT INTO br_normal(br_id, bdate, kv, rate)
								 VALUES(:DlgSOT.dfBrId, :DlgSOT.tbl.cDatB, :DlgSOT.tbl.cKv, :DlgSOT.tbl.cIr)"
						Set DlgSOT.strSqlUpdate = 
								"UPDATE br_normal 
								 SET bdate=:DlgSOT.tbl.cDatB, kv=:DlgSOT.tbl.cKv, rate=:DlgSOT.tbl.cIr
								 WHERE rowid=:DlgSOT.tbl.cRowid"
						Set DlgSOT.strSqlDelete = 
								"DELETE FROM br_normal WHERE rowid=:DlgSOT.tbl.cRowid"
				!
				Call ShowApdVersion('06')
				Call PrepareWindowEx(hWndForm)
				If tbl.cMain.IsConnected()
					Call tbl.cMain.Disconnect()
				Call SaveInfoToLog(sPopulate)
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On UM_Print
				Call TablePrint(DlgSOT.tbl, dfBrName, GetPrnDir()||'\\'||
						'BSTA' || SalFmtFormatDateTime(GetBankDate(), 'ddMM') || '.txt', '')
			On SAM_Destroy
				If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
					Call XRoleUnset(hSql(),' SetBrat() ')
			On WM_Size
				Call GetClientRect(hWndForm, nWinX0, nWinY0, nWinWidth, nWinHeight)
				Call SalSetWindowSize(hWndForm.DlgSOT.tbl,
						  SalPixelsToFormUnits(hWndForm.DlgSOT.tbl, nWinWidth, FALSE)-0.15,
						  SalPixelsToFormUnits(hWndForm.DlgSOT.tbl, nWinHeight, TRUE)-IifN(nHaveTobo=2,0.75,0.45))
				Call SalInvalidateWindow(hWndForm)
	Form Window: tblAcrBack		!! 06 Сторно нарахованих %%
.data CLASSPROPS
0000: 56543A53706C6974 746572002B000100 00000000000090B0 A800C8D8D8005880
0020: 7800020000000000 0000010000000100 0000000000000001 00000000
.enddata
.data CLASSPROPSSIZE
0000: 3C00
.enddata
		Class: cGenericTableSpl
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
			Initial State: Normal
			Maximizable? Class Default
			Minimizable? Class Default
			System Menu? Class Default
			Resizable? Class Default
			Window Location and Size
				Left:   0.81"
				Top:    1.075"
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
				Pushbutton: pbIns
					Class Child Ref Key: 15
					Class ChildKey: 0
					Class: cGenericTableSpl
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
					Class Child Ref Key: 16
					Class ChildKey: 0
					Class: cGenericTableSpl
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
							Call SalSendMsg(tbl2, UM_Delete, 0, 0)
				Pushbutton: pbRefresh
					Class Child Ref Key: 17
					Class ChildKey: 0
					Class: cGenericTableSpl
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
					Class Child Ref Key: 18
					Class ChildKey: 0
					Class: cGenericTableSpl
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
							Call SalSendMsg(tbl2, UM_Update, 0, 0)
				Line
					Resource Id: 33040
					Class Child Ref Key: 19
					Class ChildKey: 0
					Class: cGenericTableSpl
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
					Class Child Ref Key: 20
					Class ChildKey: 0
					Class: cGenericTableSpl
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
					Class Child Ref Key: 21
					Class ChildKey: 0
					Class: cGenericTableSpl
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
							If SetQueryFilter( cF )
								Set sf = cF.GetFilterWhereClause( FALSE )
								Set sfrom = cF.GetFilterFromClause( FALSE )
							Call SalSendMsg(tbl, UM_Populate, 0, 0)
				Pushbutton: pbDetails
					Class Child Ref Key: 31
					Class ChildKey: 0
					Class: cGenericTableSpl
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
							Call SalSendMsg(tbl2, SAM_DoubleClick, 0, 0)
				Pushbutton: pbPrint
					Class Child Ref Key: 22
					Class ChildKey: 0
					Class: cGenericTableSpl
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
					Resource Id: 33041
					Class Child Ref Key: 23
					Class ChildKey: 0
					Class: cGenericTableSpl
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
					Class Child Ref Key: 25
					Class ChildKey: 0
					Class: cGenericTableSpl
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
					Resource Id: 33042
					Class Child Ref Key: 26
					Class ChildKey: 0
					Class: cGenericTableSpl
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbAccrueBack
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cTBarButton
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.8"
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
					Picture File Name: \BARS98\RESOURCE\BMP\EXECUTE.BMP
					Picture Transparent Color: Gray
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Вернуть начисленные %% c указанной даты вкл'
							! Set strTip = CurrentLangTable.GetAtomTitle('tblAcrInt.cBTipAccrue')
						On SAM_Click
							Set dBackDat    = GetBankDate()
							If SalModalDialog( dlgAcrBack, hWndForm, dBackDat)=IDOK
								If SalMessageBox('Вернуть начисленные %% с'||
										' '||SalFmtFormatDateTime( dBackDat, 'dd/MM/yyyy' )||
										IifS(SalStrLength(SalStrTrimX(sf)),', '||
										CurrentLangTable.GetAtomTitle('tblAcrInt.cTMess12'),' '||
										CurrentLangTable.GetAtomTitle('tblAcrInt.cTMess13'))||' ?','%%',MB_YesNo | MB_IconQuestion )=IDYES
									Call InterestBack( 0 ,dBackDat,sFiltP||IifS(sf    ='','',' AND '||sf    ),'')
									Call SalSendMsg(tbl2,UM_Populate,0,0)
		Contents
			Custom Control: ccSplitter
				Class Child Ref Key: 1
				Class ChildKey: 0
				Class: cGenericTableSpl
				Property Template:
				Class DLL Name:
				Display Settings
					DLL Name:
					MS Windows Class Name:
					Style:  Class Default
					ExStyle:  Class Default
					Title:
					Window Location and Size
						Left:   0.0"
						Top:    2.417"
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
					Tile To Parent? Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Text Color: Class Default
					Background Color: Class Default
					DLL Settings
				Message Actions
			Child Table: tbl
				Class Child Ref Key: 28
				Class ChildKey: 0
				Class: cGenericTableSpl
				Property Template:
				Class DLL Name:
				Display Settings
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
					View: Class Default
					Allow Row Sizing? Class Default
					Lines Per Row: Class Default
				Memory Settings
					Maximum Rows in Memory: Class Default
					Discardable? Class Default
				Contents
					Column: colNls
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Account
								Number
						Visible? Class Default
						Editable? Class Default
						Maximum Data Length: Class Default
						Data Type: Class Default
						Justify: Class Default
						Width:  2.057"
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
						Title: Curr
								ency
								
						Visible? Class Default
						Editable? Class Default
						Maximum Data Length: Class Default
						Data Type: Number
						Justify: Center
						Width:  0.643"
						Width Editable? Class Default
						Format: #0
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
					Column: colNms
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Account Name
						Visible? Class Default
						Editable? Class Default
						Maximum Data Length: Class Default
						Data Type: Class Default
						Justify: Class Default
						Width:  6.886"
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
					Column: colId
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: А/П
						Visible? Class Default
						Editable? Class Default
						Maximum Data Length: Class Default
						Data Type: Number
						Justify: Right
						Width:  0.95"
						Width Editable? Class Default
						Format: #0
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
					Column: colAcrDat
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Last Accrual
								Date
						Visible? Class Default
						Editable? Class Default
						Maximum Data Length: Class Default
						Data Type: Date/Time
						Justify: Center
						Width:  1.329"
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
						Width:  0.433"
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
				Functions
				Window Variables
					String: strSqlPopulate	! Строка SQL SELECT
					String: strSqlInsert	! Строка SQL INSERT
					String: strSqlDelete	! Строка SQL DELETE
					String: strSqlUpdate	! Строка SQL UPDATE
					String: strTitleAux
				Message Actions
					On UM_Populate
						Set strSqlPopulate='
								SELECT s.nls, s.kv, s.nms, i.id, i.acr_dat, s.acc
								  INTO :colNls,:colKv,:colNms,:colId,:colAcrDat,:colAcc
								  FROM accounts s, int_accn i
								 WHERE s.acc=i.acc '||
								  IifS(sFiltP='','',' AND '||sFiltP) ||
								  IifS(sf    ='','',' AND '||sf    ) || ' ORDER BY s.nbs '
						Call SalWaitCursor(TRUE)
						! Call Debug(strSqlPopulate)
						Call SalTblPopulate(hWndForm, hSql(), strSqlPopulate,TBL_FillAll)
						Set nRow = VisTblFindString (tbl, 0, colNls, sNls)
						If nRow=-1
							Call SalTblSetContext( hWndForm, 0 )
						Else
							Call SalTblSetContext( hWndForm, nRow )
							Call SalTblSetRowFlags( hWndForm, nRow, ROW_Selected, TRUE )
							Call SalTblSetFocusRow( hWndForm, nRow )
						Call VisTblAutoSizeColumn(hWndForm, hWndNULL)
						Call SalSendMsg( hWndForm, SAM_TblDoDetails, 0, 0 )
						Call SalWaitCursor(FALSE)
					On SAM_TblDoDetails
						Set nAcc=colAcc
						Set nId =colId
						Call SalSendMsg( tbl2, UM_Populate, 0, 0 )
					On SAM_KillFocus
						Set hWndLost=hWndForm
						Set sNls=colNls
			Child Table: tbl2
				Class Child Ref Key: 27
				Class ChildKey: 0
				Class: cGenericTableSpl
				Property Template:
				Class DLL Name:
				Display Settings
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
					View: Class Default
					Allow Row Sizing? Class Default
					Lines Per Row: Class Default
				Memory Settings
					Maximum Rows in Memory: Class Default
					Discardable? Class Default
				Contents
					Column: colADAT
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Accrual
								Date
						Visible? Class Default
						Editable? Class Default
						Maximum Data Length: Class Default
						Data Type: Date/Time
						Justify: Center
						Width:  1.329"
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
					Column: colID
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: ID
						Visible? No
						Editable? Yes
						Maximum Data Length: Default
						Data Type: Number
						Justify: Left
						Width:  0.486"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colREF
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Document
								reference
						Visible? Class Default
						Editable? Class Default
						Maximum Data Length: Class Default
						Data Type: Number
						Justify: Right
						Width:  1.183"
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
							! On SAM_SetFocus
								                                                                                               Set sTmpRef = colREF
							! On SAM_AnyEdit
								                                                                                               Set colREF = sTmpRef
								                                                                                               Call SalTblSetRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_Edited, FALSE)
					Column: colTT
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Transaction
								code
						Visible? Yes
						Editable? No
						Maximum Data Length: 3
						Data Type: String
						Justify: Center
						Width:  1.183"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colUser
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: User
								#
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  0.543"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colND
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Document
								number
						Visible? Class Default
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
					Column: colMFOA
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: MFO - A
								
						Visible? Yes
						Editable? No
						Maximum Data Length: 12
						Data Type: String
						Justify: Left
						Width:  1.1"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colNLSA
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Account - A
						Visible? Yes
						Editable? No
						Maximum Data Length: 14
						Data Type: String
						Justify: Left
						Width:  1.529"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colSn           !numb
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сума
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.5"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colS    !str
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Amount
						Visible? Class Default
						Editable? No
						Maximum Data Length: Class Default
						Data Type: String
						Justify: Right
						Width:  1.486"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colISO
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Curr
								ency
						Visible? Yes
						Editable? No
						Maximum Data Length: 3
						Data Type: String
						Justify: Center
						Width:  0.717"
						Width Editable? Yes
						Format: Uppercase
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colKV
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Код
								вал. А
						Visible? No
						Editable? No
						Maximum Data Length: 3
						Data Type: Number
						Justify: Right
						Width:  0.533"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colDig
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Ccy Digits
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
					Column: colVDAT
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Value
								Date
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Date/Time
						Justify: Center
						Width:  1.167"
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
					Column: colS2n          !numb
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сума
								в валютi - B
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.5"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colS2   !str
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Amount
								in Currency - B
						Visible? Class Default
						Editable? No
						Maximum Data Length: Class Default
						Data Type: String
						Justify: Right
						Width:  1.486"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colKV2
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Код
								вал. Б
						Visible? No
						Editable? No
						Maximum Data Length: 3
						Data Type: Number
						Justify: Right
						Width:  0.533"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
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
						Title: Ccy Digits
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
					Column: colISO2
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Curr
								ency - B
						Visible? Yes
						Editable? No
						Maximum Data Length: 3
						Data Type: String
						Justify: Center
						Width:  0.857"
						Width Editable? Yes
						Format: Uppercase
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colMFOB
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: MFO - B
								
						Visible? Yes
						Editable? No
						Maximum Data Length: 12
						Data Type: String
						Justify: Left
						Width:  1.086"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colNLSB
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Account - B
						Visible? Yes
						Editable? No
						Maximum Data Length: 14
						Data Type: String
						Justify: Left
						Width:  1.429"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colDK
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Db
								Cr
						Visible? Yes
						Editable? No
						Maximum Data Length: 1
						Data Type: Number
						Justify: Center
						Width:  0.383"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colSK
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Cash
								symbol
						Visible? Yes
						Editable? No
						Maximum Data Length: 2
						Data Type: Number
						Justify: Center
						Width:  0.783"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colVOB
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Type
						Visible? No
						Editable? No
						Maximum Data Length: 2
						Data Type: Number
						Justify: Right
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
					Column: colDDAT
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Document
								date
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Date/Time
						Justify: Center
						Width:  1.083"
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
					Column: colFN_A
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: EPS. Inbound
								filename
						Visible? Yes
						Editable? No
						Maximum Data Length: 12
						Data Type: String
						Justify: Left
						Width:  1.414"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colDAT_A
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: File date
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Date/Time
						Justify: Center
						Width:  1.233"
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
					Column: colREC_A
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Record
								number
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.483"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colFN_B
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: EPS. Outgoing
								filename
						Visible? Yes
						Editable? No
						Maximum Data Length: 12
						Data Type: String
						Justify: Left
						Width:  1.414"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colDAT_B
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: File date
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Date/Time
						Justify: Center
						Width:  1.233"
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
					Column: colREC_B
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Record
								number
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.483"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colNAZN
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Transaction Details
						Visible? Yes
						Editable? No
						Maximum Data Length: 160
						Data Type: String
						Justify: Left
						Width:  7.733"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colSOS
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Sos
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
					Column: colCOMM
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Comment
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
					Column: colCount
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
					Column: colTOBO
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Код безбал.
								отделения
						Visible? No
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
					Column: colNAM_A
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Sender
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
					Column: colNB_A
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Sender Bank
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
					Column: colNAM_B
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Receiver
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
					Column: colNB_B
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Receiver Bank
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
					Column: colBranchA
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Код
								отделения А
						Visible? No
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
					Column: colBranchB
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Код
								отделения B
						Visible? No
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
					! Function: SetXnX
						                                                                                             Description:
						                                                                                             Returns
						                                                                                             Parameters
							                                                                                             Number: nDk
							                                                                                             Number: nXn
						                                                                                             Static Variables
						                                                                                             Local variables
							                                                                                             Number: nRow
						                                                                                             Actions
							                                                                                             Set nRow = TBL_MinRow
							                                                                                             While SalTblFindNextRow( tbl2, nRow, 0, 0)
								                                                                                             Call SalTblSetContext ( tbl2, nRow )
								                                                                                             If tbl.colDn=nDk
									                                                                                             Set tbl.colXn=nXn
									                                                                                             Call SetColumnImage( tbl.colX, hImage20, hImage21, tbl.colXn )
				Window Variables
					String: strSqlPopulate	! Строка SQL SELECT
					String: strSqlInsert	! Строка SQL INSERT
					String: strSqlDelete	! Строка SQL DELETE
					String: strSqlUpdate	! Строка SQL UPDATE
					String: strTitleAux
					String: sTmp
					String: strSqlFields
					String: strSqlBinds
					Number: nFetchRes
					Number: nMaxDig
					Number: nTmp
					Boolean: bBlank
				Message Actions
					On UM_Update
						If SalTblQueryRowFlags ( hWndForm, nTmp, ROW_MarkDeleted )
							If SalMessageBox(tbl.colNls||'('||Str(tbl.colKv)||'):'||PutCrLf()||
									   CurrentLangTable.GetAtomTitle('tblAcrBack.cTMess')||' '||
									   SalFmtFormatDateTime ( colADAT, 'dd/MM/yyyy' )||' ?','%%',MB_YesNo | MB_IconQuestion )!=IDYES
								Return TRUE
							If SqlPLSQLCommand(hSql(), "acrn.acr_back(nAcc,nId,colADAT)")
								Call SqlCommit(hSql())
								Call SaveFInfoToLog( 'Возврат начисленных процентов'||SalFmtFormatDateTime ( colADAT, 'd/M/yyyy' ) )
								Call MessageInfoEx('Готово.')
							Else
								Call SqlRollback(hSql())
						Call SalSendMsg( hWndForm, UM_Populate, 0, 0 )
					On SAM_Create
						! ! Лишние колонки -- вон
						Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
						Call SalHideWindow( colMFOA )
						Call SalHideWindow( colFN_B )
						Call SalHideWindow( colDAT_B )
						Call SalHideWindow( colREC_B )
						Call SalHideWindow( colFN_A )
						Call SalHideWindow( colDAT_A )
						Call SalHideWindow( colREC_A )
						Call SalHideWindow( colNAM_A )
						Call SalHideWindow( colNB_A )
						Call SalHideWindow( colNAM_B )
						Call SalHideWindow( colNB_B )
						! !
						Set strSqlFields =
								'a.dat,a.mfoa, a.mfob, a.nlsa, a.nlsb, a.s, a.kv, a.s2, a.kv2, a.sk,
								 a.dk, a.vob, a.data, a.vdat, a.tt, a.ref, a.ref, a.sos, a.userid,
								 a.nd, a.nazn, 1 '
						Set strSqlBinds =
								':colADAT,
								 :colMFOA, :colMFOB, :colNLSA, :colNLSB, :colSn, :colKV, :colS2n, :colKV2, :colSK,
								 :colDK,   :colVOB,  :colDDAT, :colVDAT, :colTT, :colID, :colREF, :colSOS, :colUser,
								 :colND,   :colNAZN, :colCount '
						Set strSqlPopulate=
								'SELECT '||strSqlFields||
								 ' INTO '||strSqlBinds ||
								 ' FROM acr_datsv a
								 WHERE a.acc=:nAcc and a.id=:nId
								 ORDER BY a.dat DESC NULLS LAST '
					On UM_Populate
						Call SalWaitCursor(TRUE)
						! Call SalTblDefineSplitWindow(hWndForm, 0, FALSE)
						Call SalTblPopulate(hWndForm, hSql(), T(strSqlPopulate),TBL_FillAll)
						Call VisTblAutoSizeColumn(hWndForm, hWndNULL)
						Call SalWaitCursor(FALSE)
					On SAM_DoubleClick
						If colREF
							Call DocViewContentsEx(hWndMDI, colREF )
					On SAM_FetchRowDone
						If SqlPrepareAndExecute( hSqlAux(), 'SELECT lcv, dig INTO :colISO,  :colDig FROM tabval WHERE kv=:colKV')
							Call SqlFetchNext( hSqlAux(), nFetchRes )
						If SqlPrepareAndExecute( hSqlAux(), 'SELECT lcv, dig INTO :colISO2, :colDig2 FROM tabval WHERE kv=:colKV2')
							Call SqlFetchNext( hSqlAux(), nFetchRes )
						! проверка на 3 знака
						! colSn, colS2n - сумма в коп. валюты
						Set colSn  = colSn  * SalNumberPower( 10, -colDig )
						Set colS2n = colS2n * SalNumberPower( 10, -colDig2 )
						!
						Set colS  = Dig4( colSn *SalNumberPower( 10, colDig  )/100, colDig,  nMaxDig )
						Set colS2 = Dig4( colS2n*SalNumberPower( 10, colDig2 )/100, colDig2, nMaxDig )
						!
						If colSOS < 5
							Select Case colSOS
								Case DOC_PAY_BACK
									Call SetTblRowColor( hWndForm, COLOR_Red )
									Break
								Case DOC_PAY_STORNO
									Call SetTblRowColor( hWndForm, COLOR_Red )
									Break
								Case DOC_PAY_INFO
									Call SetTblRowColor( hWndForm, COLOR_Teal )
									Break
								Case DOC_PAY_BOOKED
									Call SetTblRowColor( hWndForm, COLOR_DarkGreen )
									Break
								Case DOC_PAY_FEATURE
									Call SetTblRowColor( hWndForm, COLOR_Blue )
									Break
								Default
									Call SetTblRowColor( hWndForm, COLOR_Purple )
									Break
					On UM_Delete
						Set nTmp = SalTblQueryContext ( hWndForm )
						Set bBlank = not SalTblQueryRowFlags ( hWndForm, nTmp, ROW_MarkDeleted )
						Set nRow = TBL_MinRow
						! Call DebugN(nTmp)
						While SalTblFindNextRow(hWndForm, nRow, 0, 0)
							Call SalTblSetRowFlags(hWndForm, nRow, ROW_MarkDeleted, bBlank and nRow <= nTmp)
							! Call DebugN(nRow)
		Functions
		Window Parameters
			Number: nPar      !
			String: sFiltP    ! Внешний фильтр
			String: strPar02  !
		Window Variables
			: cF
				Class: cGenFilter
			String: sf
			String: sfrom
			Number: nRow
			Window Handle: hWndLost
			! cABSConnect: cMain
			! Boolean: bFlag
			Date/Time: dBackDat
			Number: nTmp
			Number: nAcc
			Number: nId
			String: sNls
			String: strFilterTblName ! Имя основной таблицы для фильтра
		Message Actions
			On SAM_Create
				Call cF.Init('Accounts', 's')
				Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
				Call SalSetWindowText( hWndForm, CurrentLangTable.GetAtomTitle('tblAcrBack.cTWndTitle'))
				Call PrepareWindowEx( hWndForm )
				Call SetWindowFullSize( hWndForm )
				Call ShowApdVersion('06')
				Set nFlags = GT_NoRet | GT_NoIns
				Call SalSendClassMessage( SAM_Create, 0, 0 )
			! 26308001031070
			On SAM_CreateComplete
				! *** Indicate that all child windows are now created
				Set m_fCreateComplete = TRUE
				! *** Invoke function to assign initial child panes
				Call AssociateChildren()
				!
				! *** Make form visible and cause it to be drawn
				Call SalShowWindow(hWndForm)
				Call SalUpdateWindow(hWndForm)
				!
				Call SalEnableWindow( pbFilter )
				Call SalSendMsg(pbFilter, SAM_Click, 0, 0)
				Call SalWaitCursor(FALSE)
	Dialog Box: dlgAcrBack			!! Установить дату сторно
		Class:
		Property Template:
		Class DLL Name:
		Title: Запрос
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? No
			Type of Dialog: Modal
			Window Location and Size
				Left:   3.74"
				Top:    2.4"
				Width:  4.467"
				Width Editable? Yes
				Height: 1.635"
				Height Editable? Yes
			Absolute Screen Location? Yes
			Font Name: MS Sans Serif
			Font Size: 8
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description: Ввод даты сторно
		Tool Bar
			Display Settings
				Display Style? Default
				Location? Top
				Visible? No
				Size: Default
				Size Editable? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Contents
		Contents
			Data Field: dfSDat
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 10
					Data Type: Date/Time
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   1.186"
						Top:    0.573"
						Width:  2.0"
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
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_Validate
						If not SalIsValidDateTime( hWndItem )
							Call SalMessageBox( 'Ош. формат даты', 'Ошибка.', MB_IconExclamation )
							Return VALIDATE_Cancel
						Set dDat = dfSDat
						Return VALIDATE_OkClearFlag
					On SAM_Create
						Set dfSDat = GetBankDate()
					! On SAM_KillFocus
						                                                                                         Call SalEndDialog(hWndForm, TRUE)
			Data Field: dfFiller
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
						Left:   0.186"
						Top:    0.26"
						Width:  3.9"
						Width Editable? Yes
						Height: 0.229"
						Height Editable? Yes
					Visible? Yes
					Border? No
					Justify: Center
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: 3D Face Color
					Input Mask: Unformatted
				Message Actions
					On SAM_SetFocus
						Call SalEndDialog(hWndForm, TRUE)
					On SAM_Create
						Set dfFiller='Дата для СТОРНО процентов:'
			Pushbutton: bEsc
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   Default
					Top:    Default
					Width:  Default
					Width Editable? Yes
					Height: Default
					Height Editable? Yes
				Visible? No
				Keyboard Accelerator: Esc
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
						Call SalEndDialog(hWndForm, FALSE)
			Frame
				Resource Id: 925
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    0.06"
					Width:  4.15"
					Width Editable? Yes
					Height: 1.01"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Border Color: 3D Shadow Color
				Background Color: 3D Face Color
			! Background Text: Дата для СТОРНО процентов:
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.186"
					Top:    0.26"
					Width:  3.9"
					Width Editable? Yes
					Height: 0.229"
					Height Editable? Yes
				Visible? Yes
				Justify: Center
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
.end
		Functions
		Window Parameters
			Receive Date/Time: dDat
		Window Variables
		Message Actions
			On SAM_Create
				Call SalCenterWindow(hWndForm)
				Set dfSDat = GetBankDate()
				Call SalSetFocus(dfSDat)
				Call SalMapEnterToTab(TRUE)
			On SAM_Destroy
				Call SalMapEnterToTab(FALSE)
			On SAM_Close
				Call SalEndDialog(hWndForm, FALSE)
