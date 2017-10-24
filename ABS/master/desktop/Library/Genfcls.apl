Application Description: /// Библиотека функциональных классов ///
		/// Комплекса АБС БАРС98              ///
	Outline Version - 4.0.26
	Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000B30000 002C000000020000 0003000000FFFFFF FFFFFFFFFFFCFFFF
0040: FFE2FFFFFF000000 00000000002C0300 0080010000010000 0001000000010000
0060: 000F4170706C6963 6174696F6E497465 6D00000000
.enddata
.data DT_MAKERUNDLG
0000: 00000000001D513A 5C4241525339385C 4C4942524152595C 47656E66636C732E
0020: 6578651D513A5C42 41525339385C4C49 42524152595C4765 6E66636C732E646C
0040: 6C1D513A5C424152 5339385C4C494252 4152595C47656E66 636C732E61706300
0060: 000101011D513A5C 4241525339385C4C 4942524152595C47 656E66636C732E72
0080: 756E1D513A5C4241 525339385C4C4942 524152595C47656E 66636C732E646C6C
00A0: 1D513A5C42415253 39385C4C49425241 52595C47656E6663 6C732E6170630000
00C0: 0101011D513A5C42 41525339385C4C49 42524152595C4765 6E66636C732E6170
00E0: 641D513A5C424152 5339385C4C494252 4152595C47656E66 636C732E646C6C1D
0100: 513A5C4241525339 385C4C4942524152 595C47656E66636C 732E617063000001
0120: 01011D513A5C4241 525339385C4C4942 524152595C47656E 66636C732E61706C
0140: 1D513A5C42415253 39385C4C49425241 52595C47656E6663 6C732E646C6C1D51
0160: 3A5C424152533938 5C4C494252415259 5C47656E66636C73 2E61706300000101
0180: 01
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
0000: 0818B80BB80B2500
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
		File Include: XSALIMG.APL
		File Include: vtstr.apl
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
		External Functions
			! ! Конвертирует данные между Sql Handle и String типами
			Library name: hsqlwork.dll
				Function: WordToStr
					Description: SqlHandle to String
					Export Ordinal: 0
					Returns
						String: LPSTR
					Parameters
						Sql Handle: HSQLHANDLE
				Function: StrToWord
					Description: String to SqlHandle
					Export Ordinal: 0
					Returns
						Sql Handle: HSQLHANDLE
					Parameters
						String: LPSTR
		Constants
.data CCDATA
0000: 3000000000000000 0000000000000000 00000000
.enddata
.data CCSIZE
0000: 1400
.enddata
			System
			User
				String: INI_ProductName		= 'Bars98'
				String: INI_CompanyName		= 'UnityBars'
				!
				String: INI_CommonParameters	= 'Common Parameters'
				String: INI_BridgeParameters	= 'Bridge Parameters'
				String: INI_CrcModules		= 'Crc Modules'
				String: INI_DigitalSignature	= 'Digital Signature'
				String: INI_Directory		= 'Directory'
				String: INI_ElektroKlients	= 'ElektroKlients'
				!
				String: INI_WindowsSettings	= 'Windows Settings'
				String: INI_Connect		= 'Connect'
				String: INI_CreditsLoans	= 'Credit&Loans'
				String: INI_Language		= 'Language'
				String: INI_Print		= 'Print'
				String: INI_TM			= 'DigitalSign'
				!
				String: INI_TabColumns		= 'Tables Layout'
		Resources
			Bitmap: bmpCustTable
				File Name: /Bars98/Resource/Bmp/adptable.bmp
		Variables
		Internal Functions
			Function: SalSqlHandleToStr			! __exported
				Description: Хэндл в строку
				Returns
					String: strRet
				Parameters
					Sql Handle: hHandle
				Static Variables
				Local variables
				Actions
					Return WordToStr( hHandle )
			Function: SalStrToSqlHandle			! __exported
				Description: Строку в хэндл
				Returns
					Sql Handle: hRet
				Parameters
					String: strHandle
				Static Variables
				Local variables
				Actions
					Return StrToWord( strHandle )
		Named Menus
		Class Definitions
			! Для построения древовидного меню
			Functional Class: cNodePoint
				Description: Класс узла дерева (для "плоского" дерева, без повторяющихся узлов)
				Derived From
				Class Variables
				Instance Variables
					Number: nNodeId		! Идентификатор узла из БД
					Number: nHNode		! Хандлер узла
					Number: nPNodeId	! Идентификатор родительского узла из БД
					String: strNodeName	! Имя узла
					String: strNodeComm	! Семантическое описание
					String: strNodeFunc	! Строка вызова
					String: strNodeRole	! Роль
					Boolean: fTerminal	! Признак "листа"
				Functions
			Functional Class: cNodePointBis
				Description: Класс узла дерева (с повторяющимися узлами)
				Derived From
					Class: cNodePoint
				Class Variables
				Instance Variables
					Number: nQId		! Идентификатор уникального родителя из БД
				Functions
			Functional Class: cNodeList
				Description: Класс описания списка узлов дерева (без повторяющихся узлов)
				Derived From
				Class Variables
				Instance Variables
					Number: nNodeNum	! Число узлов дерева
					Number: nCurChild	! Номер текущего "дитя" в поиске
					: NodeList[*]	! Массив узлов
						Class: cNodePoint
				Functions
					Function: Init
						Description: Проинициализировать переменные класса
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							Set nNodeNum = 0
							Set nCurChild = -1
							Return TRUE
					Function: New
						Description: Создать новую запись
						Returns
							Boolean:
						Parameters
							Number: nId
							Number: nHandle
							Number: nPId
							String: strName
							String: strSemantic
							String: sFuncName
							String: sRoleName
							Number: fEndNode
						Static Variables
						Local variables
						Actions
							Set NodeList[nNodeNum].nNodeId     = nId
							Set NodeList[nNodeNum].nHNode      = nHandle
							Set NodeList[nNodeNum].nPNodeId    = nPId
							Set NodeList[nNodeNum].fTerminal   = fEndNode
							Set NodeList[nNodeNum].strNodeName = strName
							Set NodeList[nNodeNum].strNodeComm = strSemantic
							Set NodeList[nNodeNum].strNodeFunc = sFuncName
							Set NodeList[nNodeNum].strNodeRole = sRoleName
							Set nNodeNum = nNodeNum + 1
							Return TRUE
					Function: GetId
						Description: Возвращает ид по хандлу
						Returns
							Number:
						Parameters
							Number: nHandle
						Static Variables
						Local variables
							Number: nIterator
						Actions
							Set nIterator = 0
							Loop
								If nIterator >= nNodeNum
									Break
								If NodeList[nIterator].nHNode = nHandle
									Break
								Set nIterator = nIterator + 1
							If nIterator >= nNodeNum
								Return -1
							Else
								Return NodeList[nIterator].nNodeId
					Function: GetSequentNumber
						Description: Возвращает индекс в массиве по Id
						Returns
							Number:
						Parameters
							Number: nId
						Static Variables
						Local variables
							Number: nIterator
						Actions
							Set nIterator = 0
							Loop
								If nIterator >= nNodeNum
									Break
								If NodeList[nIterator].nNodeId = nId
									Break
								Set nIterator = nIterator + 1
							If nIterator >= nNodeNum
								Return -1
							Else
								Return nIterator
					Function: GetHandle
						Description: Возвращает хандл по Id
						Returns
							Number:
						Parameters
							Number: nId
						Static Variables
						Local variables
							Number: nIterator
						Actions
							Set nIterator = GetSequentNumber( nId )
							If nIterator = -1
								Return 0
							Else
								Return NodeList[nIterator].nHNode
					Function: GetParent
						Description: Возвращает parent Id по Id
						Returns
							Number:
						Parameters
							Number: nId
						Static Variables
						Local variables
							Number: nIterator
						Actions
							Set nIterator = GetSequentNumber( nId )
							If nIterator = -1
								Return 0
							Else
								Return NodeList[nIterator].nPNodeId
					Function: GetName
						Description:
						Returns
							String:
						Parameters
							Number: nId
						Static Variables
						Local variables
							Number: nIterator
						Actions
							Set nIterator = GetSequentNumber( nId )
							If nIterator = -1
								Return ''
							Else
								Return NodeList[nIterator].strNodeName
					Function: GetSemantic
						Description:
						Returns
							String:
						Parameters
							Number: nId
						Static Variables
						Local variables
							Number: nIterator
						Actions
							Set nIterator = GetSequentNumber( nId )
							If nIterator = -1
								Return ''
							Else
								Return NodeList[nIterator].strNodeComm
					Function: GetFunc
						Description:
						Returns
							String:
						Parameters
							Number: nId
						Static Variables
						Local variables
							Number: nIterator
						Actions
							Set nIterator = GetSequentNumber( nId )
							If nIterator = -1
								Return ''
							Else
								Return NodeList[nIterator].strNodeFunc
					Function: GetRole
						Description:
						Returns
							String:
						Parameters
							Number: nId
						Static Variables
						Local variables
							Number: nIterator
						Actions
							Set nIterator = GetSequentNumber( nId )
							If nIterator = -1
								Return ''
							Else
								Return NodeList[nIterator].strNodeRole
					Function: IsItem
						Description:
						Returns
							Boolean:
						Parameters
							Number: nId
						Static Variables
						Local variables
							Number: nIterator
						Actions
							Set nIterator = GetSequentNumber( nId )
							If nIterator < 0
								Return 0
							Else
								Return NodeList[nIterator].fTerminal
					Function: GetFirstChild
						Description: Находит первого "дитя" заданого узла
						Returns
							Number:
						Parameters
							Number: nId
						Static Variables
						Local variables
						Actions
							Set nCurChild = 0
							Loop
								If nCurChild > nNodeNum
									Break
								If NodeList[nCurChild].nPNodeId = nId
									Break
								Set nCurChild = nCurChild + 1
							If nCurChild >= nNodeNum
								Return -1
							Else
								Return NodeList[nCurChild].nNodeId
					Function: GetNextChild
						Description: Возвращает следующего "дитя"
						Returns
							Number:
						Parameters
							Number: nId
						Static Variables
						Local variables
						Actions
							Set nCurChild = nCurChild + 1
							Loop
								If nCurChild > nNodeNum
									Break
								If NodeList[nCurChild].nPNodeId = nId
									Break
								Set nCurChild = nCurChild + 1
							If nCurChild >= nNodeNum
								Return -1
							Else
								Return NodeList[nCurChild].nNodeId
			Functional Class: cNodeListBis
				Description: Класс описания списка узлов дерева (без повторяющихся узлов)
				Derived From
				Class Variables
				Instance Variables
					Number: nNodeNum	! Число узлов дерева
					Number: nCurChild	! Номер текущего "дитя" в поиске
					: NodeList[*]	! Массив узлов
						Class: cNodePointBis
				Functions
					Function: Init
						Description: Проинициализировать переменные класса
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							Set nNodeNum = 0
							Set nCurChild = -1
							Return TRUE
					Function: New
						Description: Создать новую запись
						Returns
							Boolean:
						Parameters
							Number: nQId
							Number: nId
							Number: nHandle
							Number: nPId
							String: strName
							String: strSemantic
							String: sFuncName
							String: sRoleName
							Number: fEndNode
						Static Variables
						Local variables
						Actions
							Set NodeList[nNodeNum].nQId        = nQId
							Set NodeList[nNodeNum].nNodeId     = nId
							Set NodeList[nNodeNum].nHNode      = nHandle
							Set NodeList[nNodeNum].nPNodeId    = nPId
							Set NodeList[nNodeNum].fTerminal   = fEndNode
							Set NodeList[nNodeNum].strNodeName = strName
							Set NodeList[nNodeNum].strNodeComm = strSemantic
							Set NodeList[nNodeNum].strNodeFunc = sFuncName
							Set NodeList[nNodeNum].strNodeRole = sRoleName
							Set nNodeNum = nNodeNum + 1
							Return TRUE
					Function: GetId
						Description: Возвращает ид по хандлу
						Returns
							Number:
						Parameters
							Number: nHandle
						Static Variables
						Local variables
							Number: nIterator
						Actions
							Set nIterator = 0
							Loop
								If nIterator >= nNodeNum
									Break
								If NodeList[nIterator].nHNode = nHandle
									Break
								Set nIterator = nIterator + 1
							If nIterator >= nNodeNum
								Return -1
							Else
								Return NodeList[nIterator].nNodeId
					Function: GetQId
						Description: Получить уникальный идентификатор по хандлу
						Returns
							Number:
						Parameters
							Number: nHandle
						Static Variables
						Local variables
							Number: nIterator
						Actions
							Set nIterator = 0
							Loop
								If nIterator >= nNodeNum
									Break
								If NodeList[nIterator].nHNode = nHandle
									Break
								Set nIterator = nIterator + 1
							If nIterator >= nNodeNum
								Return -1
							Else
								Return NodeList[nIterator].nQId
					Function: GetSequentNumber
						Description: Возвращает индекс в массиве по Id
						Returns
							Number:
						Parameters
							Number: nQId
							Number: nId
						Static Variables
						Local variables
							Number: nIterator
						Actions
							Set nIterator = 0
							Loop
								If nIterator >= nNodeNum
									Break
								If NodeList[nIterator].nNodeId = nId AND NodeList[nIterator].nQId = nQId
									Break
								Set nIterator = nIterator + 1
							If nIterator >= nNodeNum
								Return -1
							Else
								Return nIterator
					Function: GetHandle
						Description: Возвращает хандл по Id
						Returns
							Number:
						Parameters
							Number: nQId
							Number: nId
						Static Variables
						Local variables
							Number: nIterator
						Actions
							Set nIterator = GetSequentNumber( nQId, nId )
							If nIterator = -1
								Return 0
							Else
								Return NodeList[nIterator].nHNode
					Function: GetParent
						Description: Возвращает parent Id по Id
						Returns
							Number:
						Parameters
							Number: nQId
							Number: nId
						Static Variables
						Local variables
							Number: nIterator
						Actions
							Set nIterator = GetSequentNumber( nQId, nId )
							If nIterator = -1
								Return 0
							Else
								Return NodeList[nIterator].nPNodeId
					Function: GetName
						Description:
						Returns
							String:
						Parameters
							Number: nQId
							Number: nId
						Static Variables
						Local variables
							Number: nIterator
						Actions
							Set nIterator = GetSequentNumber( nQId, nId )
							If nIterator = -1
								Return ''
							Else
								Return NodeList[nIterator].strNodeName
					Function: GetSemantic
						Description:
						Returns
							String:
						Parameters
							Number: nQId
							Number: nId
						Static Variables
						Local variables
							Number: nIterator
						Actions
							Set nIterator = GetSequentNumber( nQId, nId )
							If nIterator = -1
								Return ''
							Else
								Return NodeList[nIterator].strNodeComm
					Function: GetFunc
						Description:
						Returns
							String:
						Parameters
							Number: nQId
							Number: nId
						Static Variables
						Local variables
							Number: nIterator
						Actions
							Set nIterator = GetSequentNumber( nQId, nId )
							If nIterator = -1
								Return ''
							Else
								Return NodeList[nIterator].strNodeFunc
					Function: GetRole
						Description:
						Returns
							String:
						Parameters
							Number: nQId
							Number: nId
						Static Variables
						Local variables
							Number: nIterator
						Actions
							Set nIterator = GetSequentNumber( nQId, nId )
							If nIterator = -1
								Return ''
							Else
								Return NodeList[nIterator].strNodeRole
					Function: IsItem
						Description:
						Returns
							Boolean:
						Parameters
							Number: nQId
							Number: nId
						Static Variables
						Local variables
							Number: nIterator
						Actions
							Set nIterator = GetSequentNumber( nQId, nId )
							If nIterator < 0
								Return 0
							Else
								Return NodeList[nIterator].fTerminal
					Function: GetFirstChild
						Description: Находит первого "дитя" заданого узла
						Returns
							Number:
						Parameters
							Number: nQId
							Number: nId
						Static Variables
						Local variables
						Actions
							Set nCurChild = 0
							Loop
								If nCurChild > nNodeNum
									Break
								If (NodeList[nCurChild].nPNodeId = nId AND NodeList[nCurChild].nQId = nQId AND nId != 0) OR
										   (NodeList[nCurChild].nPNodeId = nId AND nId = 0)
									Break
								Set nCurChild = nCurChild + 1
							If nCurChild >= nNodeNum
								Return -1
							Else
								Return NodeList[nCurChild].nNodeId
					Function: GetNextChild
						Description: Возвращает следующего "дитя"
						Returns
							Number:
						Parameters
							Number: nQId
							Number: nId
						Static Variables
						Local variables
						Actions
							Set nCurChild = nCurChild + 1
							Loop
								If nCurChild > nNodeNum
									Break
								If (NodeList[nCurChild].nPNodeId = nId AND NodeList[nCurChild].nQId = nQId AND nId != 0) OR
										   (NodeList[nCurChild].nPNodeId = nId AND nId = 0)
									Break
								Set nCurChild = nCurChild + 1
							If nCurChild >= nNodeNum
								Return -1
							Else
								Return NodeList[nCurChild].nNodeId
			! Для работы с глобальными переменными
			Functional Class: cABSVarPool
				Description: Pool глобальных переменных комплекса
						с функциями доступа к ним...
				Derived From
				Class Variables
				Instance Variables
					Boolean: fInit
					Boolean: fGlobalVarLock
					String: strBars98ini	! Имя INI-файла
					!
					! Переменные INI среды
					! ---------------------------------------------------------------
					Boolean: bAutoLogon	! Признак автологина
					Boolean: bEnhSecurity	! Признак отключения усиленной схемы безопасности
					Boolean: bConfirmExit	! Признак подтверждения выхода из форм
					!
					String: strDbs		! Имя рабочей базы данных
					String: strDbsArc	! Имя архивной базы данных
					String: strHost		! Имя Хоста (сервера)
					String: strRdb		! Имя engina
					!
					String: strABSDir	! Директория комплекса
					String: strLogDir	! Директория LOG-файлов
					String: strMsgDir	! Директория файлов-сообщений
					String: strHlpDir	! Директория Help файлов (c названием файла)
					String: strTemplateDir	! Директория QRP-файлов и QRD-файлов
					String: strIntDir	! Директория флагов вн. направления СЭП
					String: strExtDir	! Директория флагов вшн. направления СЭП
					String: strInformationalFlagsDir ! Директория флагов для Информационных задач: ИПС и пр.
					String: strPrnDir	! Директория сохранения выходных форм
					String: strRatesDir	! Директория файлов курсов НБУ
					! E-Clients
					String: sTempKPath	! Директория временных файлов К-Б
					String: sElKDir		! Директория с п/я элек. клиентов
					String: sElKDirIN	! Директория IN элек. клиентов
					String: sElKDirOUT	! Директория OUT элек. клиентов
					String: sOpKeyPath	! Путь к открытым ключам К-Б
					String: sLicenPath	! Путь к файлу лицензии (МФО.lcw)
					String: sSecKeyDrv	! Путь к файлу секретного ключа К-Б
					String: sArchiv_KB	! Путь к АРХИВАМ элек. клиентов
					Number: nArch_DAYS	! К-во календарных дней наполнения АРХИВОВ по датам
					Number: nWaitPeriod	! К-во секунд ожидания обработки файлов К-Б
					! Электронная подпись
					String: strSignType	! 'NBU' - НБУ/'UKR' - Банк 'Украина'/'OTH' - др.
					Number: nSignOn		! Режим использования системы ЭЦП
					String: strOpenKeyDir	! Директория Открытых ключей
					String: strSecretKeyDrv	! Устройство хранения Секретных ключей
					String: strDebugIdOper	! Идентификатор Пользователя для ОТЛАДКИ
					String: strDebugKeyDate	! Дата действия ключа для ОТЛАДКИ
					Number: nTMType		! Тип Touch Memory
					Number: nTMPort		! Номер порта
					Number: nTMAdapter	! Тип адаптера Touch Memory
					String: strTMSystem	! Тип системы TouchMemory --
							                          (RAW-сырое устройство, FILE-файловая система)
					Number: nUseGateway	! Режим использования технологии криптошлюза
					! Проверка исполняемых модулей
					Number: nFileCheckOn	! Режим проверкаи файлов математики
					! Фонты, размеры фонтов
					Boolean: fUseCustomFonts	! Использовать настройки фонтов пользователя
					!
					String: strFontGeneral		! Дискриптор фонта для окон (общий)
					String: strFontDataFields	! Дискриптор фонта для полей ввода
					String: strFontListBoxes	! Дискриптор фонта для списков (простых и комбинированых) 
					String: strFontTables		! Дискриптор фонта для таблиц и окон-таблиц
					String: strFontButtons		! Дискриптор фонта для кнопок
					!
					! Переменные для задачи кредитных ресурcов
					String: strRtfTmp	! Имя temp файла для редактирования договора
					String: strRtfEditor	! Имя редактора файлов rtf формата, с путем
					String: strRtfPrint	! Имя инструмента печати файлов rtf формата, с путем
					!
					! Переменные для языковых установок
					String: strLanguageId	! Идентификатор языка
					String: strLanguagePath	! Дисковый каталог, где хранятся языковые ресурсы
					!
					! Переменные для печати
					String: strPrintCoding	! Кодировка печати (DOS - WIN)
					Boolean: fRunPrinterDlg	! Запускать диалог выбора принтера
					String: strUkrCharSet	! Кодировка украинских букв (Std DOS, NBU)
					Boolean: bUseBatchPrint	! Признак использования пакетного режима печати
					Boolean: bPrintTrnModel ! Признак печати бухгалтерской модели проводки
					Boolean: bPrintSWIFTMsg	! Признак печати SWIFT сообщения
					! ---------------------------------------------------------------
					!
					! Переменные среды СУБД
					! ---------------------------------------------------------------
					Number: nParamsNum	! Количество параметров
					String: strParams[*,2]	! Массив параметров
					!
					Number: nUserId		! Идентификатор пользователя
					Number: nUserMark	! Уровень приоритета пользователя
					Number: nSessionId	! Идентификатор сессии
					String: strUserLogName	! Имя для логина
					String: strUserRealName	! Реальное имя
					String: strUserTabN     ! Табельный номер
					!
					String: strLcvBaseVal	! Символьный код валюты
					String: strBankSab	! Элктронный адрес нашего банка
					String: strIdOper	! Идентификатор Пользователя
					! ---------------------------------------------------------------
					String: sVobForBadVob
					Number: nVobForBadVob
					! Параметры моста: используются при работе через шлюз BARS Gateway
					! Содержатся в разделе [Bridge Parameters]
					! Listener
					String: strListenerHost	! имя прослушиваемого хоста
					Number: nListenerPort	! номер прослушиваемого порта
					String: strListenerID	! ID ключа слушателя
					Boolean: bListenerAuth	! флаг аутентификации для слушателя
					Boolean: bListenerEnc	! флаг шифрования трафика слушателя
					! Remote
					String: strRemoteHost	! имя удаленного хоста
					Number: nRemotePort	! номер удаленного порта
					String: strRemoteID	! ID ключа удаленного хоста
					Boolean: bRemoteAuth	! флаг аутентификации для удаленного хоста
					Boolean: bRemoteEnc	! флаг шифрования трафика удаленного хоста
					!
					! Параметры моста 2
					!
					String: strListener2Host
					Number: nListener2Port
					String: strListener2ID
					Boolean: bListener2Auth
					Boolean: bListener2Enc
					String: strRemote2Host
					Number: nRemote2Port
					String: strRemote2ID
					Boolean: bRemote2Auth
					Boolean: bRemote2Enc
					!
					! Параметры моста 3
					!
					String: strListener3Host
					Number: nListener3Port
					String: strListener3ID
					Boolean: bListener3Auth
					Boolean: bListener3Enc
					String: strRemote3Host
					Number: nRemote3Port
					String: strRemote3ID
					Boolean: bRemote3Auth
					Boolean: bRemote3Enc
					!
					! Параметры моста 4
					!
					String: strListener4Host
					Number: nListener4Port
					String: strListener4ID
					Boolean: bListener4Auth
					Boolean: bListener4Enc
					String: strRemote4Host
					Number: nRemote4Port
					String: strRemote4ID
					Boolean: bRemote4Auth
					Boolean: bRemote4Enc
					!
					! Прочие параметры
					String: strIconPath	! Путь к иконке(.ico) для отображения в некоторых диалогах
					String: strCardReaderName  ! имя устройства типа CardReader
					String: strCardReaderPin  ! pin-код устройства типа CardReader
				Functions
					Function: Init
						Description: Функция инициализации списка переменных
								(установка умолчательных параметров)
								! Должна быть вызвана перед любыми вызовами
								  других функций.
						Returns
							Boolean:
						Parameters
							String: strMode
						Static Variables
						Local variables
						Actions
							If strMode = 'INI'
								Set strBars98ini = 'BARS98.INI'
								Set bAutoLogon   = FALSE
								Set bConfirmExit = TRUE
								Set strDbs = 'N/A'
								Set strHost = 'N/A'
								Set strRdb = 'oracle'
								Set strLogDir = './LOG'
								Set strMsgDir = './MSG'
								Set strHlpDir = './HELP'
								Set strTemplateDir = './TEMPLATE.RPT'
								Set strIntDir = './FLAGS'
								Set strExtDir = './FLAGS'
								Set strInformationalFlagsDir = './FLAGS'
								Set strPrnDir = './PRINT'
								Set strRatesDir = './RATES'
								Set nArch_DAYS = 9999
								Set nWaitPeriod = 100
								Set strSignType = 'NBU'
								Set nSignOn = 1
								Set strOpenKeyDir = './OPENKEY'
								Set strSecretKeyDrv = 'A:'
								Set strDebugKeyDate = '2000/01/01 10:10:10'
							If strMode = 'REG'
								Set nTMType = 1995
								Set nTMPort = 1
								Set nTMAdapter = 4
								Set strTMSystem = 'RAW'
								Set strFontGeneral    = 'Arial Cyr;Regular;9'
								Set strFontTables     = 'Arial Cyr;Regular;9'
								Set strFontListBoxes  = 'Arial Cyr;Regular;9'
								Set strFontButtons    = 'Arial Cyr;Regular;9'
								Set strFontDataFields = 'Arial Cyr;Regular;9'
								Set bUseBatchPrint = FALSE
								Set strPrintCoding = 'DOS'
								Set strUkrCharSet  = 'NBU'
								Set fRunPrinterDlg = FALSE
								Set bPrintTrnModel = TRUE
								Set bPrintSWIFTMsg = TRUE
								Set strCardReaderName = "ICS Reader378 0"
								Set strCardReaderPin = STRING_Null
							If strMode = 'DBS'
								Set bEnhSecurity = FALSE
							!
							Set fInit = TRUE
							Return fInit
					Function: ReadSettingsFromIni
						Description: Читать переменные из Ini файла
						Returns
							Boolean:
						Parameters
							String: strIniFileName
						Static Variables
						Local variables
							String: strCurDir
						Actions
							If not fInit
								Call Init('INI')
							! Проверяем наименование INI файла или устанавливем его
							Call SalFileGetCurrentDirectory(strCurDir)
							If SalStrTrimX(strIniFileName) = ''
								Set strBars98ini = strCurDir || '/BARS98.INI'
							Else
								Set strBars98ini = SalStrTrimX(strIniFileName)
							Call SalUseRegistry(FALSE, '')
							Call SalGetProfileString(INI_Directory, 'Dir', '',  strABSDir, strBars98ini)
							Call SalGetProfileString(INI_Directory, 'LogDir', '', strLogDir, strBars98ini)
							Call SalGetProfileString(INI_Directory, 'MsgDir', '', strMsgDir, strBars98ini)
							Call SalGetProfileString(INI_Directory, 'HelpFile', strABSDir || '\\HELP\\ABS.HLP', strHlpDir, strBars98ini)
							Call SalGetProfileString(INI_CommonParameters, 'Database', '', strDbs, strBars98ini)
							Call SalGetProfileString(INI_CommonParameters, 'RDBMS', '', strRdb, strBars98ini)
							Call SalGetProfileString(INI_CommonParameters, 'Host', '', strHost, strBars98ini)
							Call SalGetProfileString(INI_CommonParameters, 'InternalFlagsDir', '', strIntDir, strBars98ini)
							Call SalGetProfileString(INI_CommonParameters, 'ExternalFlagsDir', '', strExtDir, strBars98ini)
							Call SalGetProfileString(INI_CommonParameters, 'InformationalFlagsDir', '', strInformationalFlagsDir, strBars98ini)
							Call SalGetProfileString(INI_CommonParameters, 'PrintDir', '', strPrnDir, strBars98ini)
							Call SalGetProfileString(INI_CommonParameters, 'TemplateDir', '', strTemplateDir, strBars98ini)
							Call SalGetProfileString(INI_CommonParameters, 'CurRatesDir', '', strRatesDir, strBars98ini)
							Set strRdb = SalStrLowerX(strRdb)
							Set strDbs = SalStrUpperX(strDbs)
							Set nUseGateway = SalGetProfileInt(INI_CommonParameters, 'UseGateway', 0, strBars98ini)
							Set nSignOn     = SalGetProfileInt(INI_DigitalSignature, 'SignOn', 1, strBars98ini)
							Call SalGetProfileString(INI_DigitalSignature, 'SignType', '', strSignType, strBars98ini)
							Call SalGetProfileString(INI_DigitalSignature, 'OpenKey', '', strOpenKeyDir, strBars98ini)
							Call SalGetProfileString(INI_DigitalSignature, 'SecretKeyDrv', 'A:', strSecretKeyDrv, strBars98ini)
							Call SalGetProfileString(INI_DigitalSignature, 'DebugIdOper', '', strDebugIdOper, strBars98ini)
							Call SalGetProfileString(INI_DigitalSignature, 'DebugKeyDate', '', strDebugKeyDate, strBars98ini)
							Set nFileCheckOn = SalGetProfileInt(INI_CrcModules, 'CheckFile', 0, strBars98ini)
							! "Клиентские параметры"
							Call SalGetProfileString(INI_ElektroKlients, 'TempKPath', strCurDir, sTempKPath, strBars98ini)
							Call SalGetProfileString(INI_ElektroKlients, 'BoxesPath', strCurDir, sElKDir, strBars98ini)
							Call SalGetProfileString(INI_ElektroKlients, 'SBB_IN', strCurDir, sElKDirIN, strBars98ini)
							Call SalGetProfileString(INI_ElektroKlients, 'SBB_OUT', strCurDir, sElKDirOUT, strBars98ini)
							Call SalGetProfileString(INI_ElektroKlients, 'OpKeyPath', strCurDir, sOpKeyPath, strBars98ini)
							Call SalGetProfileString(INI_ElektroKlients, 'LicenPath', strCurDir, sLicenPath, strBars98ini)
							Call SalGetProfileString(INI_ElektroKlients, 'SecKeyDrv', 'A:\\', sSecKeyDrv, strBars98ini)
							Call SalGetProfileString(INI_ElektroKlients, 'Archiv_KB', strCurDir, sArchiv_KB, strBars98ini)
							Set nArch_DAYS = SalGetProfileInt(INI_ElektroKlients, 'Arch_DAYS', 99999, strBars98ini)
							Set nWaitPeriod = SalGetProfileInt(INI_ElektroKlients, 'WaitPeriod', 30, strBars98ini)
							If SalStrRightX(sTempKPath, 1) != '\\'
								Set sTempKPath = sTempKPath || '\\'
							If SalStrRightX(sElKDir,    1) != '\\'
								Set sElKDir = sElKDir || '\\'
							If SalStrRightX(sElKDirIN,  1) != '\\'
								Set sElKDirIN = sElKDirIN || '\\'
							If SalStrRightX(sElKDirOUT, 1) != '\\'
								Set sElKDirOUT = sElKDirOUT || '\\'
							If SalStrRightX(sOpKeyPath, 1) != '\\'
								Set sOpKeyPath = sOpKeyPath || '\\'
							If SalStrRightX(sLicenPath, 1) != '\\'
								Set sLicenPath = sLicenPath || '\\'
							If SalStrRightX(sSecKeyDrv, 1) != '\\'
								Set sSecKeyDrv = sSecKeyDrv || '\\'
							If SalStrRightX(sArchiv_KB, 1) != '\\'
								Set sArchiv_KB = sArchiv_KB || '\\'
							! Иконка для диалогов
							Call SalGetProfileString(INI_CommonParameters, 'IconPath', '', strIconPath, strBars98ini)
							! Параметры моста для шлюза BARS Gateway
							Call SalGetProfileString(INI_BridgeParameters, 'listener.host', STRING_Null, strListenerHost, strBars98ini)
							Set nListenerPort = SalGetProfileInt(INI_BridgeParameters, 'listener.port', 0, strBars98ini)
							Call SalGetProfileString(INI_BridgeParameters, 'listener.id', STRING_Null, strListenerID, strBars98ini)
							Set bListenerAuth = SalGetProfileInt(INI_BridgeParameters, 'listener.authentication', 0, strBars98ini)
							Set bListenerEnc = SalGetProfileInt(INI_BridgeParameters, 'listener.encryption', 0, strBars98ini)
							Call SalGetProfileString(INI_BridgeParameters, 'remote.host', STRING_Null, strRemoteHost, strBars98ini)
							Set nRemotePort = SalGetProfileInt(INI_BridgeParameters, 'remote.port', 0, strBars98ini)
							Call SalGetProfileString(INI_BridgeParameters, 'remote.id', STRING_Null, strRemoteID, strBars98ini)
							Set bRemoteAuth = SalGetProfileInt(INI_BridgeParameters, 'remote.authentication', 0, strBars98ini)
							Set bRemoteEnc = SalGetProfileInt(INI_BridgeParameters, 'remote.encryption', 0, strBars98ini)
							!
							! Параметры моста 2
							Call SalGetProfileString(INI_BridgeParameters, 'listener2.host', STRING_Null, strListener2Host, strBars98ini)
							Set nListener2Port = SalGetProfileInt(INI_BridgeParameters, 'listener2.port', 0, strBars98ini)
							Call SalGetProfileString(INI_BridgeParameters, 'listener2.id', STRING_Null, strListener2ID, strBars98ini)
							Set bListener2Auth = SalGetProfileInt(INI_BridgeParameters, 'listener2.authentication', 0, strBars98ini)
							Set bListener2Enc = SalGetProfileInt(INI_BridgeParameters, 'listener2.encryption', 0, strBars98ini)
							Call SalGetProfileString(INI_BridgeParameters, 'remote2.host', STRING_Null, strRemote2Host, strBars98ini)
							Set nRemote2Port = SalGetProfileInt(INI_BridgeParameters, 'remote2.port', 0, strBars98ini)
							Call SalGetProfileString(INI_BridgeParameters, 'remote2.id', STRING_Null, strRemote2ID, strBars98ini)
							Set bRemote2Auth = SalGetProfileInt(INI_BridgeParameters, 'remote2.authentication', 0, strBars98ini)
							Set bRemote2Enc = SalGetProfileInt(INI_BridgeParameters, 'remote2.encryption', 0, strBars98ini)
							!
							! Параметры моста 3
							Call SalGetProfileString(INI_BridgeParameters, 'listener3.host', STRING_Null, strListener3Host, strBars98ini)
							Set nListener3Port = SalGetProfileInt(INI_BridgeParameters, 'listener3.port', 0, strBars98ini)
							Call SalGetProfileString(INI_BridgeParameters, 'listener3.id', STRING_Null, strListener3ID, strBars98ini)
							Set bListener3Auth = SalGetProfileInt(INI_BridgeParameters, 'listener3.authentication', 0, strBars98ini)
							Set bListener3Enc = SalGetProfileInt(INI_BridgeParameters, 'listener3.encryption', 0, strBars98ini)
							Call SalGetProfileString(INI_BridgeParameters, 'remote3.host', STRING_Null, strRemote3Host, strBars98ini)
							Set nRemote3Port = SalGetProfileInt(INI_BridgeParameters, 'remote3.port', 0, strBars98ini)
							Call SalGetProfileString(INI_BridgeParameters, 'remote3.id', STRING_Null, strRemote3ID, strBars98ini)
							Set bRemote3Auth = SalGetProfileInt(INI_BridgeParameters, 'remote3.authentication', 0, strBars98ini)
							Set bRemote3Enc = SalGetProfileInt(INI_BridgeParameters, 'remote3.encryption', 0, strBars98ini)
							!
							! Параметры моста 4
							Call SalGetProfileString(INI_BridgeParameters, 'listener4.host', STRING_Null, strListener4Host, strBars98ini)
							Set nListener4Port = SalGetProfileInt(INI_BridgeParameters, 'listener4.port', 0, strBars98ini)
							Call SalGetProfileString(INI_BridgeParameters, 'listener4.id', STRING_Null, strListener4ID, strBars98ini)
							Set bListener4Auth = SalGetProfileInt(INI_BridgeParameters, 'listener4.authentication', 0, strBars98ini)
							Set bListener4Enc = SalGetProfileInt(INI_BridgeParameters, 'listener4.encryption', 0, strBars98ini)
							Call SalGetProfileString(INI_BridgeParameters, 'remote4.host', STRING_Null, strRemote4Host, strBars98ini)
							Set nRemote4Port = SalGetProfileInt(INI_BridgeParameters, 'remote4.port', 0, strBars98ini)
							Call SalGetProfileString(INI_BridgeParameters, 'remote4.id', STRING_Null, strRemote4ID, strBars98ini)
							Set bRemote4Auth = SalGetProfileInt(INI_BridgeParameters, 'remote4.authentication', 0, strBars98ini)
							Set bRemote4Enc = SalGetProfileInt(INI_BridgeParameters, 'remote4.encryption', 0, strBars98ini)
							! Call SalMessageBox( strListenerHost, 'listener.host', MB_Ok )
							Return TRUE
					Function: ReadSettingsFromParam
						Description: Чтение настроек из таблицы Params
						Returns
							Boolean:
						Parameters
							Sql Handle: hSqlLocal
						Static Variables
						Local variables
							Number: nFRes
							String: strParName
							String: strParVal
							Number: nParVal
							Number: nClsId
						Actions
							If not fInit
								Call Init('DBS')
							If SqlPrepareAndExecute(hSqlLocal, '
									     SELECT par,val
									     INTO :strParName,:strParVal
									     FROM params
									     ORDER BY par')
								Set fGlobalVarLock = TRUE
								Set nParamsNum = 0
								While SqlFetchNext(hSqlLocal, nFRes)
									Set nParamsNum = nParamsNum + 1
									Set strParams[nParamsNum-1,0] = SalStrTrimX(SalStrUpperX(strParName))
									Set strParams[nParamsNum-1,1] = SalStrTrimX(strParVal)
								Set fGlobalVarLock = FALSE
								!
								Set strParVal = ReadGlobalOptionValue('MFO')
								If SqlPrepareAndExecute(hSqlLocal, '
										     SELECT sab
										     FROM banks
										     INTO :strBankSab
										     WHERE mfo=:strParVal')
									Call SqlFetchNext(hSqlLocal, nFRes)
								Set nParVal = SalStrToNumber(ReadGlobalOptionValue('BASEVAL'))
								If SqlPrepareAndExecute(hSqlLocal, '
										     SELECT lcv
										     FROM tabval
										     INTO :strLcvBaseVal
										     WHERE kv=:nParVal')
									Call SqlFetchNext(hSqlLocal, nFRes)
								Set nVobForBadVob = SalStrToNumber(ReadGlobalOptionValue('VOB2SEP'))
								If NOT nVobForBadVob
									Set nVobForBadVob = 1
							If SqlPrepareAndExecute(hSqlLocal, '
									     SELECT id,fio,logname,tabn,clsid
									     FROM staff
									     INTO :nUserId,:strUserRealName,:strUserLogName,
									          :strUserTabN, :nClsId
									     WHERE logname=USER')
								Call SqlFetchNext(hSqlLocal, nFRes)
								If SqlPrepareAndExecute(hSqlLocal, '
										     SELECT mark INTO :nUserMark FROM staff_class WHERE clsid = :nClsId' )
									Call SqlFetchNext(hSqlLocal, nFRes)
							If SalStrUpperX(strRdb) = 'ORACLE'
								Call SqlPrepareAndExecute(hSqlLocal, "
										     SELECT userenv('sessionid')
										     FROM dual INTO :nSessionId")
							Else
								Call SqlPrepareAndExecute(hSqlLocal, "
										     SELECT dbinfo('sessionid')
										     FROM dk
										     WHERE dk=1
										     INTO :nSessionId")
							Call SqlFetchNext(hSqlLocal, nFRes)
							Return TRUE
					Function: ReadSettingsFromRegistry
						Description: Вычитать значения переменных из регистра
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							String: strMyPrintDir
						Actions
							If not fInit
								Call Init('REG')
							Call SalUseRegistry(TRUE, INI_CompanyName)
							!
							Set bAutoLogon=SalGetProfileInt(INI_Connect, 'AutoLogon', 0, INI_ProductName)
							!
							Set fUseCustomFonts = SalGetProfileInt(INI_WindowsSettings, 'UseCustomFonts', 0, INI_ProductName)
							Set bConfirmExit = SalGetProfileInt(INI_WindowsSettings, 'ConfirmExit', 1, INI_ProductName)
							Call SalGetProfileString(INI_WindowsSettings, 'FontGeneral', 'MS Sans Serif;Regular;8', strFontGeneral, INI_ProductName)
							Call SalGetProfileString(INI_WindowsSettings, 'FontDataFields', 'MS Sans Serif;Regular;8', strFontDataFields, INI_ProductName)
							Call SalGetProfileString(INI_WindowsSettings, 'FontListBoxes', 'MS Sans Serif;Regular;8', strFontListBoxes, INI_ProductName)
							Call SalGetProfileString(INI_WindowsSettings, 'FontTables', 'MS Sans Serif;Regular;8', strFontTables, INI_ProductName)
							Call SalGetProfileString(INI_WindowsSettings, 'FontButtons', 'MS Sans Serif;Regular;8', strFontButtons, INI_ProductName)
							!
							Call SalGetProfileString(INI_CreditsLoans, 'RtfTempFile', '', strRtfTmp, INI_ProductName)
							Call SalGetProfileString(INI_CreditsLoans, 'RtfEditor', '', strRtfEditor, INI_ProductName)
							Call SalGetProfileString(INI_CreditsLoans, 'RtfPrint', '', strRtfPrint, INI_ProductName)
							!
							Call SalGetProfileString(INI_Language, 'LangId', '', strLanguageId, INI_ProductName)
							Call SalGetProfileString(INI_Language, 'LangSrcPath', '', strLanguagePath, INI_ProductName)
							!
							Set fRunPrinterDlg = SalGetProfileInt(INI_Print, 'ChoosePrinter', 0, INI_ProductName)
							Set bUseBatchPrint = SalGetProfileInt(INI_Print, 'UseBatchPrint', 0, INI_ProductName)
							Set bPrintTrnModel = SalGetProfileInt(INI_Print, 'NoPrintTrnModel', 1, INI_ProductName)
							Set bPrintSWIFTMsg = SalGetProfileInt(INI_Print, 'NoPrintSwiftMsg', 1, INI_ProductName)
							Call SalGetProfileString(INI_Print, 'MyPrintDir', strPrnDir, strMyPrintDir, INI_ProductName)
							If strMyPrintDir
								Set strPrnDir = strMyPrintDir
							Call SalGetProfileString(INI_Print, 'PrintCharSet', 'DOS', strPrintCoding, INI_ProductName)
							Call SalGetProfileString(INI_Print, 'UkrCharCoding', 'CP866', strUkrCharSet, INI_ProductName)
							!
							Set nTMType = SalGetProfileInt(INI_TM, 'TouchMemoryType', 1995, INI_ProductName)
							Set nTMPort = SalGetProfileInt(INI_TM, 'PortNumber', 1, INI_ProductName)
							Set nTMAdapter = SalGetProfileInt(INI_TM, 'AdapterType', 4, INI_ProductName)
							Call SalGetProfileString(INI_TM, 'TouchMemorySystem', 'RAW', strTMSystem, INI_ProductName)
							! параметры устройства типа CardReader
							Call SalGetProfileString(INI_TM, 'CardReaderName', 'ICS Reader378 0', strCardReaderName, INI_ProductName)
							Call SalGetProfileString(INI_TM, 'CardReaderPin', STRING_Null, strCardReaderPin, INI_ProductName)
							!
							Return TRUE
					Function: ReadGlobalOptionValue
						Description: Чиатет значение глобального параметра из
								массива переменных базы данных
						Returns
							String:
						Parameters
							String: strPName
						Static Variables
						Local variables
							Number: nI
						Actions
							If not fInit
								Call Init('DBS')
							! Ожидаем, если перечитывание.
							Loop
								If NOT fGlobalVarLock 
									Break
							!
							Set strPName = SalStrTrimX(SalStrUpperX(strPName))
							Set nI = 0
							While nI < nParamsNum
								If strParams[nI,0] = strPName
									Break
								Set nI = nI + 1
							If nI >= nParamsNum
								Return ''
							If (strPName = 'BANKDATE' OR strPName = 'BASEVAL') AND SalStrTrimX(strParams[nI,1]) = ''
								Call SalMessageBeep( MB_IconAsterisk )
								Call SalMessageBox( 'Ошибка чтения глобальных параметров!', strPName, MB_Ok | MB_IconAsterisk )
							Return strParams[nI,1]
					Function: SetGlobalOptionValue
						Description: Устанавливает значение глобального параметра
								в массив переменных
						Returns
							Boolean:
						Parameters
							String: strPName
							String: strPVal
						Static Variables
						Local variables
							Number: nI
						Actions
							! Ожидаем, если перечитывание.
							Loop
								If NOT fGlobalVarLock
									Break
							!
							Set strPName = SalStrTrimX(SalStrUpperX(strPName))
							Set strPVal = SalStrTrimX(strPVal)
							Set nI = 0
							While nI < nParamsNum
								If strParams[nI,0] = strPName
									Set strParams[nI,1] = strPVal
									Break
								Set nI = nI + 1
							If nI >= nParamsNum
								Return FALSE
							Return TRUE
			! Для работы с хендлами коннектов
			Functional Class: cABSConnect
				Description: класс коннекта к базе данных
				Derived From
				Class Variables
				Instance Variables
					String: strUserName		! Logname пользоватля
					String: strPassword		! Пароль пользователя на сессию
					String: strDBName		! Имя базы данных
					Boolean: fIsConnected		! Признак активности коннекта
					Sql Handle: hSqlConnect		! Хендл коннекта
				Functions
					Function: Define
						Description: Определяет параметры коннекта
						Returns
							Boolean:
						Parameters
							String: strDbName
							String: strUName
							String: strPasswd
							Boolean: fConnectNow
						Static Variables
						Local variables
						Actions
							Set strUserName = strUName
							Set strPassword = strPasswd
							Set strDBName = strDbName
							If fConnectNow
								Return Connect()
							Else
								Return TRUE
					Function: Clone
						Description: Копировать параметры коннекта
						Returns
							Boolean:
						Parameters
							: cConnect
								Class: cABSConnect
							Boolean: fConnectNow
						Static Variables
						Local variables
						Actions
							Set strDBName = cConnect.strDBName
							Set strUserName = cConnect.strUserName
							Set strPassword = cConnect.strPassword
							If fConnectNow
								Return Connect()
							Else
								Return TRUE
					!
					Function: Connect
						Description: Подсоединение к базе данных
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							When SqlError
								Return FALSE
							Set SqlUser = strUserName
							Set SqlPassword = strPassword
							Set SqlDatabase = strDBName
							Set fIsConnected = SqlConnect( hSqlConnect )
							Return fIsConnected
					Function: Disconnect
						Description: Отсоединение от базы данных
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							When SqlError
								Return FALSE
							If SqlDisconnect( hSqlConnect )
								Set fIsConnected = FALSE
								Return NOT fIsConnected
					!
					Function: GetLoginName
						Description: Вернуть логин-имя
						Returns
							String:
						Parameters
						Static Variables
						Local variables
						Actions
							Return strUserName
					Function: GetDbName
						Description: Возвращает имя базы данных
						Returns
							String:
						Parameters
						Static Variables
						Local variables
						Actions
							Return strDBName
					Function: hSql
						Description: Возвращает хендл коннекта
						Returns
							Sql Handle:
						Parameters
						Static Variables
						Local variables
						Actions
							Return hSqlConnect
					Function: IsConnected
						Description: Возвращает статус коннекта
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							Return fIsConnected
			! Класс упаковки/распаковки параметров в одну строку (Иван)
			Functional Class: cParams
				Description: Класс упаковки/распаковки параметров в одну строку
				Derived From
				Class Variables
				Instance Variables
					! Поля только для внутреннего доступа!
					! Для получени значений используйте объявленые функции
					String: ParamNames[*]
					String: ParamValues[*]
					String: ParamsText
				Functions
					! Ключевые функции объекта
					! Работа со строкой упакованых параметров
					Function: SetParams
						Description: Импортировать строку параметров в объект
						Returns
							Boolean: bOk
						Parameters
							String: strParams
						Static Variables
						Local variables
						Actions
							Call Clear( )
							Set ParamsText=strParams
							Return Decompress(  )
					Function: GetParams
						Description: Возвращает строку упакованных параметров из объекта
						Returns
							String: strRet
						Parameters
						Static Variables
						Local variables
						Actions
							If Compress( )
								Return ParamsText
							Else
								Return ''
					! Операции с параметрами
					Function: Clear
						Description: Отчистить определение параметров
						Returns
						Parameters
						Static Variables
						Local variables
						Actions
							Call SalArraySetUpperBound( ParamNames, 1, -1 )
							Call SalArraySetUpperBound( ParamValues, 1, -1 )
					Function: ParamsCount
						Description: Количество параметров
						Returns
							Number: nRet
						Parameters
						Static Variables
						Local variables
							Number: nLength
						Actions
							Call SalArrayGetUpperBound( ParamNames, 1, nLength )
							If nLength=0 AND ParamNames[0]='' AND ParamValues[0]=''
								Return 0
							Return nLength+1
					Function: ParamName
						Description: Имена параметров по номеру от 0 до ParamsCount-1
						Returns
							String: strRet
						Parameters
							Number: nIndex
						Static Variables
						Local variables
							Number: nLength
						Actions
							Call SalArrayGetUpperBound( ParamNames, 1, nLength )
							If nIndex<=nLength
								Return ParamNames[nIndex]
							Else
								Return ''
					Function: AddParam
						Description: Добавляет параметр с указаным именем,
								возвращает индекс параметра,
								-1 - если параметр уже существует
						Returns
							Number: nIndex
						Parameters
							String: strParamName
						Static Variables
						Local variables
							Number: nLength
							Number: i
						Actions
							Call SalArrayGetUpperBound( ParamNames, 1, nLength )
							If (nLength=0) AND ( SalStrLength( ParamNames[0] ) = 0)
								Set nLength=-1
							Set i=0
							Loop
								If i<=nLength
									If ParamNames[i]=strParamName
										Return -1
								Else
									Break
								Set i=i+1
							Call SalArraySetUpperBound( ParamNames, 1, nLength+1 )
							Call SalArraySetUpperBound( ParamValues, 1, nLength+1 )
							Call SalStrTrim( strParamName, strParamName )
							Set ParamNames[nLength+1]=strParamName
							Return nLength+1
					Function: IndexOf
						Description: Возвращает индекс параметра по имени
								(от 0 до ParamsCount-1)
								-1 если не существует
						Returns
							Number: nIndex
						Parameters
							String: strParamName
						Static Variables
						Local variables
							Number: nLength
							Number: i
						Actions
							Call SalArrayGetUpperBound( ParamNames, 1, nLength )
							Set i=0
							Loop
								If i<=nLength
									If strParamName=ParamNames[i]
										Return i
								Else
									Break
								Set i=i+1
							Return -1
					! Функции доступа
					! Чтение
					Function: GetAsString
						Description: Возвращает указаный параметр строкой
						Returns
							String: Value
						Parameters
							String: strParamName
						Static Variables
						Local variables
							Number: i
						Actions
							Set i=IndexOf(strParamName)
							If i!=-1
								Return ParamValues[i]
							Else
								Return ''
					Function: GetAsBoolean
						Description: Возвращает указаный параметр строкой
						Returns
							Boolean: bRet
						Parameters
							String: strParamName
						Static Variables
						Local variables
							Number: i
						Actions
							Set i=IndexOf(strParamName)
							If i!=-1
								If ParamValues[i]='True'
									Return TRUE
								Else
									Return FALSE
							Else
								Return FALSE
					Function: GetAsInteger
						Description: Возвращает указаный параметр числом
						Returns
							Number: Value
						Parameters
							String: strParamName
						Static Variables
						Local variables
							Number: i
						Actions
							Set i=IndexOf(strParamName)
							If i!=-1
								If SalStrIsValidNumber( ParamValues[i] )
									Return SalStrToNumber( ParamValues[i] )
								Else
									Return 0
							Else
								Return 0
					Function: GetAsDateTime
						Description: Возвращает указаный параметр датой-временем
						Returns
							Date/Time: Value
						Parameters
							String: strParamName
						Static Variables
						Local variables
							Number: i
						Actions
							Set i=IndexOf(strParamName)
							If i!=-1
								If SalStrIsValidDateTime( ParamValues[i] )
									Return SalStrToDate( ParamValues[i] )
								Else
									Return SalStrToDate('0000-00-00-00.00.00.000000')
							Else
								Return SalStrToDate('0000-00-00-00.00.00.000000')
					Function: GetAsHWND
						Description: Возвращает указаный параметр хэндлом окна
						Returns
							Window Handle: Value
						Parameters
							String: strParamName
						Static Variables
						Local variables
							Number: i
						Actions
							Set i=IndexOf(strParamName)
							If i!=-1
								If SalStrIsValidNumber( ParamValues[i] )
									Return SalNumberToWindowHandle( SalStrToNumber( ParamValues[i] ) )
								Else
									Return hWndNULL
							Else
								Return hWndNULL
					Function: GetAsHSQL
						Description: Возвращает указаный параметр SQL хэндлом
						Returns
							Sql Handle: Value
						Parameters
							String: strParamName
						Static Variables
						Local variables
							Number: i
						Actions
							Set i=IndexOf(strParamName)
							If i!=-1
								If SalStrIsValidNumber( ParamValues[i] )
									Return SalStrToSqlHandle( ParamValues[i] )
								Else
									Return SalStrToSqlHandle( '0' )
							Else
								Return SalStrToSqlHandle( '0' )
					! Запись
					Function: SetAsString
						Description: Устанавливает указаный параметр строкой
						Returns
						Parameters
							String: strParamName
							String: Value
						Static Variables
						Local variables
							Number: i
						Actions
							Set i=IndexOf(strParamName)
							If i=-1
								Set i=ParamsCount()
								Set ParamNames[i]=strParamName
							Set ParamValues[i]=Value
					Function: SetAsBoolean
						Description: Устанавливает указаный параметр строкой
						Returns
						Parameters
							String: strParamName
							Boolean: Value
						Static Variables
						Local variables
							Number: i
						Actions
							Set i=IndexOf(strParamName)
							If i=-1
								Set i=ParamsCount()
								Set ParamNames[i]=strParamName
							If Value
								Set ParamValues[i]='True'
							Else
								Set ParamValues[i]='False'
					Function: SetAsInteger
						Description: Устанавливает указаный параметр числом
						Returns
						Parameters
							String: strParamName
							Number: Value
						Static Variables
						Local variables
							Number: i
							String: strValue
						Actions
							Set i=IndexOf(strParamName)
							If i=-1
								Set i=ParamsCount()
								Set ParamNames[i]=strParamName
							Call SalNumberToStr( Value, 0, strValue )
							Set ParamValues[i]=strValue
					Function: SetAsDateTime
						Description: Устанавливает указаный параметр датой-временем
						Returns
						Parameters
							String: strParamName
							Date/Time: Value
						Static Variables
						Local variables
							Number: i
							String: strValue
						Actions
							Set i=IndexOf(strParamName)
							If i=-1
								Set i=ParamsCount()
								Set ParamNames[i]=strParamName
							Call SalDateToStr( Value, strValue )
							Set ParamValues[i]=strValue
					Function: SetAsHWND
						Description: Устанавливает указаный параметр хэндлом окна
						Returns
						Parameters
							String: strParamName
							Window Handle: Value
						Static Variables
						Local variables
							Number: i
							Number: nValue
							String: strValue
						Actions
							Set i=IndexOf(strParamName)
							If i=-1
								Set i=ParamsCount()
								Set ParamNames[i]=strParamName
							Call SalNumberToStr( SalWindowHandleToNumber( Value ), 0, strValue )
							Set ParamValues[i]=strValue
					Function: SetAsHSQL
						Description: Устанавливает указаный параметр SQL хэндлом
						Returns
						Parameters
							String: strParamName
							Sql Handle: Value
						Static Variables
						Local variables
							Number: i
						Actions
							Set i=IndexOf(strParamName)
							If i=-1
								Set i=ParamsCount()
								Set ParamNames[i]=strParamName
							Set ParamValues[i]=SalSqlHandleToStr( Value )
					! Функции только для внутреннего вызова
					! На прямую не вызывать
					Function: Compress
						Description: Преобразовать Имена и Значения в упакованую строку параметров
						Returns
							Boolean: bOk
						Parameters
						Static Variables
						Local variables
							Number: i
							Number: nLength
							String: strValChar		! Символ выделения значения
							String: strEqChar		! Символ приравнивания
							String: strDlmChar		! Символ разделения значений
							String: RetStr
						Actions
							Set strValChar="'"		! Кавычка
							Set strEqChar='='
							Set strDlmChar=','		!Запятая
							Call SalArrayGetUpperBound( ParamNames, 1, nLength )
							Set i=0
							Set RetStr=''
							Loop
								If i<=nLength
									If i!=0
										Set RetStr=RetStr || strDlmChar
									Set RetStr=RetStr || ParamNames[i] || strEqChar || strValChar || ParamValues[i] || strValChar
								Else
									Break
								Set i=i+1
							Set ParamsText=RetStr
							Return TRUE
					Function: Decompress
						Description: Преобразовать упакованую строку параметров в Имена и Значения
						Returns
							Boolean: bOk
						Parameters
						Static Variables
						Local variables
							String: strValChar		! Символ выделения значения
							String: strEqChar		! Символ приравнивания
							String: strDlmChar		! Символ разделения значений
							String: strVal		! Для хранения значения
							String: strNam		! Для хранения имени
							Boolean: fNam		! Флаг имени
							Boolean: fVal		! Флаг значения
							String: wrkStr		!Рабочая переменная
						Actions
							Set strValChar="'"		! Кавычка
							Set strEqChar='='
							Set strDlmChar=','		!Запятая
							Set wrkStr=ParamsText
							Set fNam=TRUE
							Set fVal=FALSE
							Set strNam=''
							Set strVal=''
							Loop
								If fNam
									If SalStrLeftX( wrkStr, 1 )=strEqChar	!Конец имени
										Set fNam=FALSE
									Else
										Set strNam=strNam || SalStrLeftX( wrkStr, 1 )
								Else If fVal
									If SalStrLeftX( wrkStr, 1 )=strValChar	!Конец значения
										Set fVal = FALSE
										Call AddParam( strNam )
										Call SetAsString( strNam, strVal )
										Set strNam=''
										Set strVal=''
									Else
										Set strVal=strVal || SalStrLeftX( wrkStr, 1 )
								Else
									If SalStrLeftX( wrkStr, 1 )=strDlmChar		! Начало следующего имени
										Set fNam=TRUE
									Else If SalStrLeftX( wrkStr, 1 )=strValChar	! Начало следующего значения
										Set fVal=TRUE
									Else ! Ошибка компрессии: текущий символ - незначащий
								If SalStrLength( wrkStr )=1		! Конец рабочей переменной
									Break
								Else
									Set wrkStr=SalStrRightX( wrkStr, SalStrLength( wrkStr ) - 1 )	!Уменьшает рабочую переменную
					Function: SetCount
						Description: Уст. количества параметров
						Returns
							Number: nRet
						Parameters
							Number: nCount
						Static Variables
						Local variables
						Actions
							Call SalArraySetUpperBound( ParamNames, 1, nCount-1 )
							Call SalArraySetUpperBound( ParamValues, 1, nCount-1 )
							Return nCount
			! Классs-хранилище ролей пользователя
			Functional Class: cABSRole
				Description: Струкутра для хранения роли
				Derived From
				Class Variables
				Instance Variables
					String: strFuncName
					String: strRoleName
					Boolean: InUse
				Functions
			Functional Class: cABSRolePool
				Description: Хранилище ролей в АБС БАРС
				Derived From
				Class Variables
				Instance Variables
					Number: nRecordNum
					: Role[*]
						Class: cABSRole
				Functions
					Function: Init
						Description: Constructor
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							Set nRecordNum = 0
					Function: AddRole
						Description: Добавить роль
						Returns
							Boolean:
						Parameters
							String: strFunc
							String: strRole
						Static Variables
						Local variables
							Number: i
						Actions
							Call SalStrUpper( strFunc, strFunc )
							Call SalStrUpper( strRole, strRole )
							Set i = FindRole( strFunc, strRole )
							If i = -1
								Set Role[nRecordNum].strFuncName = strFunc
								Set Role[nRecordNum].strRoleName = strRole
								Set Role[nRecordNum].InUse = TRUE
								Set nRecordNum = nRecordNum + 1
							Else
								Set Role[i].InUse = TRUE
							Return TRUE
					Function: DelRole
						Description: Удалить роль из списка
						Returns
							Boolean:
						Parameters
							String: strFunc
						Static Variables
						Local variables
							Number: i
						Actions
							Call SalStrUpper( strFunc, strFunc )
							Set i = 0
							While i < nRecordNum
								If Role[i].strFuncName = strFunc
									Set Role[i].InUse = FALSE
								Set i = i + 1
							Return TRUE
					Function: GetSetRoleString
						Description: получить строку SET ROLE для активных ролей
						Returns
							String:
						Parameters
						Static Variables
						Local variables
							Number: i
							String: strRes
						Actions
							Set i = 0
							Set strRes = ''
							While i < nRecordNum
								If Role[i].InUse
									If strRes != ''
										Set strRes = strRes || ','
									Set strRes = strRes || Role[i].strRoleName
								Set i = i + 1
							If strRes != ''
								Set strRes = 'SET ROLE ' || strRes
							Return strRes
					Function: FindRole
						Description: Найти роль в списке
						Returns
							Number:
						Parameters
							String: strFunc
							String: strRole
						Static Variables
						Local variables
							Number: i
						Actions
							Call SalStrUpper( strFunc, strFunc )
							Call SalStrUpper( strRole, strRole )
							Set i = 0
							While i < nRecordNum
								If Role[i].strFuncName = strFunc AND Role[i].strRoleName = strRole
									Break
								Set i = i + 1
							If i >= nRecordNum
								Set i = -1
							Return i
			! Класс для обслуживания визуализации таблиц комплекса
			Functional Class: cABSTabColumn
				Description: Колонка таблицы комплекса
				Derived From
				Class Variables
				Instance Variables
					Window Handle: hColumn
					String: strColName
					String: strColTitle
					Number: nPosition
					Boolean: fShow
					Boolean: fSystemHidden
				Functions
					Function: SetValues
						Description: установить значения параметров колонки
						Returns
							Boolean:
						Parameters
							: cSrc
								Class: cABSTabColumn
						Static Variables
						Local variables
						Actions
							Set hColumn     = cSrc.hColumn
							Set strColName  = cSrc.strColName
							Set strColTitle = VisStrSubstitute( cSrc.strColTitle, SalNumberToChar( 13 ) || SalNumberToChar( 10 ), ' ' )
							Set nPosition   = cSrc.nPosition
							Set fShow       = cSrc.fShow
							Set fSystemHidden  = cSrc.fSystemHidden
							Return TRUE
			Functional Class: cABSTab
				Description: Таблица комплекса
				Derived From
				Class Variables
				Instance Variables
					Window Handle: hTable
					String: strTabName		! Полное имя таблицы
					: TabColumn[*]	! Список колонок
						Class: cABSTabColumn
					Number: nColNum			! Количество колонок
					String: strUserName
					Boolean: fColPosChangeAllowed	! Разрешено сохранение изменения порядка колонок
					Number: hBitmap
				Functions
					Function: Init
						Description: Конструктор
						Returns
							Boolean:
						Parameters
							Window Handle: hTab
							Number: nMod
							String: strUser
							Boolean: fColPosChange
						Static Variables
						Local variables
						Actions
							Set hTable      = hTab
							Set strUserName = SalStrUpperX( strUser )
							Set strTabName  = GetFullTableName( hTable ) || '$' || SalNumberToStrX( nMod, 0 )
							Set nColNum     = 0
							Set fColPosChangeAllowed = fColPosChange
							Set hBitmap     = XSalBitmapFromResource( 'bmpCustTable' )
							!
							Return FetchColumnsSettings()
					Function: InitNSI
						Description: Конструктор НСИ
						Returns
							Boolean:
						Parameters
							Window Handle: hTab
							Number: nMod
							String: strUser
							Boolean: fColPosChange
							String: strParNSITableName
						Static Variables
						Local variables
						Actions
							Set hTable      = hTab
							Set strUserName = SalStrUpperX(strUser)
							Set strTabName  = GetFullTableName(hTable) || '$' || SalNumberToStrX(nMod, 0) || strParNSITableName
							Set nColNum     = 0
							Set fColPosChangeAllowed = fColPosChange
							Set hBitmap     = XSalBitmapFromResource('bmpCustTable')
							!
							Return FetchColumnsSettings()
					!
					Function: GetFullTableName
						Description: Получить полное имя таблицы (полная ссылка)
						Returns
							String:
						Parameters
							Window Handle: hCurrent
						Static Variables
						Local variables
							String: strCurrent
							String: strParent
						Actions
							If NOT hCurrent
								Return ''
							Call SalGetItemName( hCurrent, strCurrent )
							Set strParent = GetFullTableName( SalParentWindow( hCurrent ))
							If strParent
								Set strParent = strParent || '.'
							Return strParent || strCurrent
					Function: GetColumnId
						Description: Получить идентификатор колонки по имени
						Returns
							Number:
						Parameters
							String: strColName
						Static Variables
						Local variables
							Number: nI
						Actions
							Set nI = 0
							While nI < nColNum
								If TabColumn[nI].strColName = strColName
									Return nI
								Set nI = nI + 1
							Return -1
					Function: GetColumnIdByHandle
						Description: Получить идентификатор колонки по хэндлу
						Returns
							Number:
						Parameters
							Window Handle: hCol
						Static Variables
						Local variables
							Number: nI
						Actions
							Set nI = 0
							While nI < nColNum
								If TabColumn[nI].hColumn = hCol
									Return nI
								Set nI = nI + 1
							Return -1
					Function: GetColumnIdByPos
						Description: Получить идентификатор колонки по позиции
						Returns
							Number:
						Parameters
							Number: nPos
						Static Variables
						Local variables
							Number: nI
						Actions
							Set nI = 0
							While nI < nColNum
								If TabColumn[nI].nPosition = nPos
									Return nI
								Set nI = nI + 1
							Return -1
					Function: ApplyColumnsSettings
						Description: Применить настройки к колонкам таблицы
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							Number: nI
							Number: nPos
							Window Handle: hCol
						Actions
							! Проставим для колонок их свойства в порядке позиции.
							Set nPos = 1
							While nPos <= nColNum
								Set nI = GetColumnIdByPos( nPos )
								If nI != -1
									! Call SalMessageBox(SalNumberToStrX(nPos,0) || '. ' || TabColumn[nI].strColTitle, "Debug", MB_Ok) 
									If NOT TabColumn[nI].fSystemHidden
										If TabColumn[nI].fShow 
											Call SalShowWindow( TabColumn[nI].hColumn )
											If fColPosChangeAllowed
												Call SalTblSetColumnPos( TabColumn[nI].hColumn, nPos )
										Else
											Call SalHideWindow( TabColumn[nI].hColumn )
								Set nPos = nPos + 1
							Return TRUE
					Function: FetchColumnsSettings
						Description: Вычитать колонки из таблицы
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							Window Handle: hCol
							: cCol
								Class: cABSTabColumn
							Number: nHidPos
						Actions
							Set hCol = SalGetFirstChild( hTable, TYPE_TableColumn )
							Set nColNum = 0
							Set nHidPos = 900
							While hCol
								Set cCol.hColumn = hCol
								If SalGetItemName( hCol, cCol.strColName )
									Call SalTblGetColumnTitle( hCol, cCol.strColTitle, 100 )
									Set cCol.fSystemHidden = FALSE
									If NOT ReadColumnSettings( cCol )
										Set cCol.fShow = TRUE
										Set cCol.fSystemHidden = TRUE
										Set cCol.nPosition = nHidPos + SalTblQueryColumnPos( hCol )
									Call TabColumn[nColNum].SetValues( cCol )
									Set nColNum = nColNum + 1
								Set hCol = SalGetNextChild( hCol, TYPE_TableColumn )
							Return ApplyColumnsSettings(  )
					Function: FetchColumnsPosition
						Description: Вычитать колонки из таблицы
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							Number: nI
						Actions
							Set nI = 0
							While nI < nColNum
								Set TabColumn[nI].nPosition = SalTblQueryColumnPos( TabColumn[nI].hColumn )
								If SalIsWindowVisible( TabColumn[nI].hColumn ) AND TabColumn[nI].fSystemHidden
									Set TabColumn[nI].fSystemHidden = FALSE
								Set nI = nI + 1
							Return TRUE
					Function: SaveColumnsSettings
						Description: Сохранить массив данных о колонках в реестре
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							Number: nI
							String: strVal
						Actions
							Call SalUseRegistry( TRUE, INI_CompanyName )
							Set nI = 0
							While nI < nColNum
								If NOT TabColumn[nI].fSystemHidden
									If fColPosChangeAllowed
										Set strVal = SalNumberToStrX( TabColumn[nI].nPosition, 0 )
									Else
										Set strVal = '0'
									If TabColumn[nI].fShow
										Set strVal = strVal || ',VISIBLE'
									Else
										Set strVal = strVal || ',INVISIBLE'
									Call SalSetProfileString( INI_TabColumns || '\\' || strUserName || '\\' || strTabName, 
												TabColumn[nI].strColName, strVal, INI_ProductName )
								Set nI = nI + 1
							Return TRUE
					!
					Function: ReadColumnSettings
						Description: Прочитать данные из рееестра по колонке таблицы
						Returns
							Boolean:
						Parameters
							: cCol
								Class: cABSTabColumn
						Static Variables
						Local variables
							String: strVal
							String: strDet[*]
							Number: nDet
						Actions
							Call SalUseRegistry( TRUE, INI_CompanyName )
							If SalGetProfileString( INI_TabColumns || '\\' || strUserName || '\\' || strTabName, 
										cCol.strColName, '', strVal, INI_ProductName )
								Set nDet = SalStrTokenize( strVal, '', ',', strDet )
								If nDet > 0 AND nDet >=2
									Set cCol.nPosition = SalStrToNumber( strDet[0] )
									If SalStrUpperX(SalStrTrimX( strDet[1] )) = 'INVISIBLE'
										Set cCol.fShow     = FALSE
									Else
										Set cCol.fShow     = TRUE
								Else
									Set cCol.nPosition = -1
									Set cCol.fShow     = TRUE
								Return TRUE
							Return FALSE
					!
					Function: MarkTableAsCustomisable
						Description: Нарисовать картинку в уголочке таблицы
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return XSalBitmapDraw( hTable, hBitmap, 0, 0, 18, 18, FALSE )
					!
					Function: RefreshColumnSetting
						Description: Установить начальные значения
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							Number: nI
							String: strVal
						Actions
							Call SalUseRegistry( TRUE, INI_CompanyName )
							Set nI = 0
							While nI < nColNum
								If NOT TabColumn[nI].fSystemHidden
									Set strVal = '0,VISIBLE'
									Call SalSetProfileString( INI_TabColumns || '\\' || strUserName || '\\' || strTabName, 
												TabColumn[nI].strColName, strVal, INI_ProductName )
								Set nI = nI + 1
							Call FetchColumnsSettings()
							Return TRUE
					!
					Function: Destructor
						Description: Destructor
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							Call XSalBitmapClose( hBitmap )
			! Класс для обслуживания таблиц с колонками длинных данных
			Functional Class: cLongBind
				Description: Элемет списка длинных биндов
				Derived From
				Class Variables
				Instance Variables
					Number: nBindPos
					Number: nBindType
				Functions
			Functional Class: cLongBindList
				Description: Cписок динных биндов для таблицы
				Derived From
				Class Variables
				Instance Variables
					: LongBind[*]
						Class: cLongBind
				Functions
					Function: Init
						Description: Конструктор
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							Return SalArraySetUpperBound( LongBind, 1, -1 )
					Function: AddBind
						Description: Добавить бинд
						Returns
							Boolean:
						Parameters
							Number: nBindPos
							Number: nBindType
						Static Variables
						Local variables
							Number: nNewIndex
						Actions
							Set nNewIndex = GetBindCount()
							Set LongBind[nNewIndex].nBindPos  = nBindPos
							Set LongBind[nNewIndex].nBindType = nBindType
							Return TRUE
					Function: GetBindCount
						Description: Получить количество элементов
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
							Number: nCount
						Actions
							If SalArrayGetUpperBound( LongBind, 1, nCount )
								Return nCount
							Else
								Return -1
					Function: ActivateBinds
						Description: Активизировать бинды
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							Number: iterator
							Number: upperbound
						Actions
							If NOT SalArrayIsEmpty( LongBind )
								Set iterator = 0
								Set upperbound = GetBindCount()
								While iterator <= upperbound
									Call SqlSetLongBindDatatype( LongBind[iterator].nBindPos, LongBind[iterator].nBindType )
									Set iterator = iterator + 1
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
			Radio Button:
			Option Button:
			Check Box:
			Child Table:
			Quest Child Window: cQuickDatabase
			List Box:
			Combo Box:
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
