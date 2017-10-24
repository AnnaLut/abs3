Application Description: DEBREG.APL - содержит ф-ции работы
		с Реестром Должников
		SERG, DIMA
	Outline Version - 4.0.26
	Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000FA0000 002C000000020000 0003000000000000 0077020000F8FFFF
0040: FFE2FFFFFFFFFFFF FF000000007C0200 004D010000010000 0000000000010000
0060: 000F4170706C6963 6174696F6E497465 6D02000000075769 6E646F77730B4445
0080: 425F5245475F424C 4B
.enddata
.data DT_MAKERUNDLG
0000: 02000000001C513A 5C4241525339385C 4C4942524152595C 6465627265672E65
0020: 78651C513A5C4241 525339385C4C4942 524152595C646562 7265672E646C6C1C
0040: 513A5C4241525339 385C4C4942524152 595C646562726567 2E61706300000101
0060: 011C513A5C424152 5339385C4C494252 4152595C64656272 65672E72756E1C51
0080: 3A5C424152533938 5C4C494252415259 5C6465627265672E 646C6C1C513A5C42
00A0: 41525339385C4C49 42524152595C6465 627265672E617063 0000010101165C42
00C0: 41525339385C4249 4E5C646562726567 2E617064165C4241 525339385C42494E
00E0: 5C6465627265672E 646C6C165C424152 5339385C42494E5C 6465627265672E61
0100: 706300000101011C 513A5C4241525339 385C4C4942524152 595C646562726567
0120: 2E61706C1C513A5C 4241525339385C4C 4942524152595C64 65627265672E646C
0140: 6C1C513A5C424152 5339385C4C494252 4152595C64656272 65672E6170630000
0160: 010101
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
0000: 1018B80BB80B2500
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
		File Include: XSALIMG.APL
		Dynalib: Message.apd
		Dynalib: Absapi.apd
		Dynalib: Custacnt.apd
		Dynalib: Docview.apd
		File Include: Winbars2.apl
		File Include: Winapi.apl
		File Include: Gentbl.apl
		File Include: Xsalcpt.apl
		! !
		File Include: vtmeter.apl
		File Include: Vtfile.apl
		File Include: VTDOS.APL
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
			Date/Time: dd-MM-yyyy
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
		Variables
			Boolean: bTB4
			Boolean: bTB1
			Boolean: bTB2
			Number: nFetchRes
			Window Handle: WH
			Window Handle: hW_F
			Window Handle: hW_C
			Window Handle: hW_D
			Window Handle: hW_Q
			Window Handle: hW_Add
			Number: nFetchRes1
			Window Handle: hW_FILE_INFO
			Window Handle: hW_BLK
			Number: nNewRow
			Number: nRow
			! !
			Boolean: bApdInited
		Internal Functions
			Function: DRAcrProc		! __exported
				Description:
				Returns
				Parameters
					Window Handle: hW
					String: sPar
				Static Variables
				Local variables
					Number: nTipKl
					String: sTmp
					String: sPar_
				Actions
					! Call Debug(sPar)
					Set sTmp = Subs(sPar,1,1)
					If sTmp ='0' or  sTmp = '1'
						Set sPar_ = Subs( sPar, 2, SalStrLength(sPar)- 1 )
						Set nTipKl = Val(sTmp)
					Else
						Set sPar_ = sPar
						Set nTipKl = -1
					!
					If sPar_ ='F' ! ! ! ! ! ! ! Подготовка данных
						If not IsWindow(hW_F)
							Set hW_F = SalCreateWindow( DEB_REG_F, hW, sPar_, nTipKl )
						Else
							Call SalBringWindowToTop ( DEB_REG_F )
					Else If sPar_ ='F_MANUAL' ! ! ! ! ! ! ! Ручной ввод
						If not IsWindow(hW_Add)
							Set hW_Add = SalCreateWindow( TA, hWndMDI, sPar_, nTipKl)
						Else
							Call SalBringWindowToTop ( TA )
					Else If sPar_='DR_MIRROR' ! Зеркало реестра
						If not IsWindow(hW_Q)
							Set hW_Q = SalCreateWindow(DEB_REG_MIRROR, hW, sPar_, nTipKl )
						Else
							Call SalBringWindowToTop ( DEB_REG_MIRROR )
					!
					Else If sPar_='C' ! ! ! ! ! Запросы и ответы
						If not IsWindow(hW_C)
							Set hW_C = SalCreateWindow( DEB_REG_C, hW, sPar_, nTipKl )
						Else
							Call SalBringWindowToTop ( DEB_REG_C )
					Else If sPar_='D' ! ! ! ! ! Ответы на наш запрос
						If not IsWindow(hW_D)
							Set hW_D = SalCreateWindow( DEB_REG_D, hW, '',  sPar_, nTipKl )
						Else
							Call SalBringWindowToTop ( DEB_REG_D )
					Else If sPar_='FILE_INFO' ! Инф.о файлах
						If not IsWindow( hW_FILE_INFO)
							Set hW_FILE_INFO = SalCreateWindow(DEB_REG_FILE_INFO, hW, sPar_, nTipKl )
						Else
							Call SalBringWindowToTop ( DEB_REG_FILE_INFO )
					Else If sPar_='PF_BLK'  ! ! Заблок клиен
						If not IsWindow(hW_BLK)
							Set hW_BLK = SalCreateWindow( DEB_REG_BLK, hW, sPar_, nTipKl )
						Else
							Call SalBringWindowToTop ( DEB_REG_BLK )
					Else If sPar_ = 'DBF_IMPORT'
						Call DebRegImportDBF()
					Else If sPar_ = 'TRACE_SQL'
						Call TraceOraSql()
					Else
						Call Debug("Ош.параметр вызова функции "|| sPar )
			Function: TraceOraSql
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
					Number: nRetVal
					Number: id
					Number: MAX_ROW_TO_FETCH
				Actions
					Call SalWaitCursor( TRUE )
					! Call SqlPrepareAndExecute( hSql(), 'alter session set sql_trace=true' )
					! Call SqlPrepareAndExecute( hSql(), "ALTER SESSION SET EVENTS '10053 trace name context forever, level 1'" )
					Call SqlPrepareAndExecute( hSql(), "ALTER SESSION SET EVENTS '10046 trace name context forever, level 4'" )
					Set id = 25
					Set MAX_ROW_TO_FETCH = 30
					! "select lcv,nls,kv,nms,fm from table(tester.get_acc_list(:id,:MAX_ROW_TO_FETCH))" 
					If SqlPrepareAndExecute( hSql(), 
							"select /*+FIRST_ROWS*/ * from 
							(SELECT  
							t.lcv, a.nls, a.nms, sec.fit_umask(a.sec, :id)
							   FROM accounts a, tabval t
							  WHERE a.kv=t.kv
							    AND a.sec is not null
							    AND sec.fit_umask(a.sec, :id)>0
							  ORDER BY a.nls,a.kv
							) where rownum<:MAX_ROW_TO_FETCH
							"
							)
						If SqlFetchNext( hSql(), nRetVal )
							Call Debug( 'Ok' )
						Else
							Call Debug( 'SqlFetchNext error' )
					Else
						Call Debug( 'SqlPrepareAndExecute error' )
					! Call SqlPrepareAndExecute( hSql(), 'alter session set sql_trace=false' )
					! Call SqlPrepareAndExecute( hSql(), "ALTER SESSION SET EVENTS '10053 trace name context off'" )
					Call SqlPrepareAndExecute( hSql(), "ALTER SESSION SET EVENTS '10046 trace name context off'" )
					Call SalWaitCursor( FALSE )
			! Function: DebRegImportDBF
				                               Description: 
				                               Returns 
					                               Boolean: 
				                               Parameters 
					                               String: strImpDir
					                               Boolean: bTrans
				                               Static Variables 
				                               Local variables 
					                               String: strFiles[*]
					                               Number: nFilesCount
					                               Number: i
				                               Actions 
					                               Set nFilesCount=VisDosEnumFiles(strImpDir||'\\*.dbf',FA_Standard,strFiles)
					                               Set i=0
					                               While i < nFilesCount and !CreTabSqlFromDbf(strFiles[i],bTrans)
						                               Set i=i+1
					                               If i < nFilesCount
						                               Return FALSE
					                               Return TRUE
			Function: DebRegImportDBF		! __exported
				Description: ****************************************************************
						   Функция импортирует DBF таблицы (например, из старого БАРСа)
						в таблицы ORACLE. Переделка с dlg_LoadDbf.CreTabSqlFromDbf().
						   Предназначена для использования при сопряжении
						функционирующего старого БАРСа и отдельных задач нового
						комплекса (в данном случае -- Реестра Должников). В контексте
						данной задачи вызывается при открытии дня.
						   Выполняет следующее. Для каждого .DBF файла, находящегося в
						указанном каталоге, создается таблица а ORACLE, если ее нет, или
						обновляется, если она есть, данными из .DBF файла.
						   Детали.
						   Каталог, в котором "валяются" .DBF файлы, предназначенные для
						импорта указывается в .INI файле комплекса в параметре
						DRImpDBFTmp в секции [Directory]. Если этот параметр отсутствует
						или пуст, то функция ругнется и вывалится с ошибкой.
						   Создание таблицы. Таблица в ORACLE создается только в том
						случае, если нет. Ее имя есть имя .DBF файла с добавленным сзади
						подчеркиванием (так как имя файла может совпадать с одним из
						зарезервированных слов SQL). Структура таблицы ORACLE
						соответствует структуре DBF таблицы. Имена полей новой таблицы
						получаются из имен полей DBF таблицы путем добавления к ним
						сзади подчеркивания (воизбежания той же проблемы, что и с именем
						файла). Типы полей преобразовываются cледующим образом:
						   DBF         -> ORACLE
						   -----------    -----------------------------
						   C (CHAR)    -> CHAR или VARCHAR
						   D (DATE)    -> DATE
						   L (LOGICAL) -> CHAR(1)
						   N (NUMERIC) -> SMALLINT, INTEGER или DECIMAL
						После создания таблицы создается PUBLIC SYNONYM, имя которого
						есть имя таблицы дополненое вумя подчеркиваниями сзади (чтобы
						избежать конфликта имен). Далее "нарезаются" гранты на INSERT,
						DELETE и SELECT для роли. Роль должна быть создана заранее. В
						данной реализации имя роли DEB_REG захардкодено. Если что-нибудь
						неудалось сделать, то удалается тадблица и синоним, функция
						ругается и "вываливается" с ошибкой.
						   Обновление таблицы. Точнее было бы сказать -- очистка. Талица
						обновляется только в том случае, если она была создана ранее.
						Функция удаляет все из таблицы. COMMIT выполняется только после
						успешного "населения" всех таблиц. Если удаление не прошло, то
						выполняется ROLLBACK, функция ругается и "вываливается" с
						ошибкой.
						   "Население" таблицы. После того, как таблица успешно создана
						или очищена, она наполняется данными из DBF таблицы. После
						успешного напонения выполняется COMMIT. Если в процессе
						происходит ошибка, то выполняется ROLLBACK, функция ругается и
						"вываливается" с ошибкой (таблица не удаляется).
						****************************************************************
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					File Handle: hFile ! Хендл .DBF файла. Нужен для чтения стуктуры таблицы.
					Sql Handle: hSqlOdbc ! Хендл соединения с ODBC. Нужен при населении таблицы.
					Boolean: fExists ! Хендл соединения с ORACLE. Нужен при населении таблицы.
					Number: i
					Number: j
					Number: k
					Number: nBound
					Number: nFetchRes
					Number: nFilesCount ! Количество .DBF файлов в каталоге импорта.
					Number: nLen1 ! Длина поля в числовой форме.
					Number: nLen2 ! "Точность" числового поля в числовой форме.
					Number: nRec ! Количество записей в .DBF файле.
					Number: NTmp[ * ] ! NUMERIC буфера для перетягивания данных.
					String: CTmp[ * ] ! CHARACTER буфера для перетягивания данных.
					String: sBuf ! "Содержимое" .DBF файла.
					String: sCurDir ! Текущий каталог. Cораняется перед коннектом к ODBC и
							                  восстанавливается после дисконнекта. Приходится менять
							                  каталог на каталог импорта, иначе ODBC ругается на длину
							                  имени таблицы :(
					String: sIniFile ! Имя .INI файла. Для чтения параметров конфикурации.
					String: sItem ! Имя поля.
					String: sLen1 ! Длина поля в текстовой форме.
					String: sLen2 ! "Точность" числового поля в текстовой форме.
					String: sOdbcSel ! Список полей для выборки из .DBF.
					String: sSqlBin ! Список буферов для выборки/вставки.
					String: sSqlItm ! Список полей для создания таблицы.
					String: sSqlSel ! Список полей для вставки в таблицу.
					String: sTab ! Имя таблицы.
					String: sTabSel ! Имя таблицы. Используется при определении существования
							                  таблицы.
					String: strImpDir ! Каталог импорта. Читается из .INI файла.
					String: sTyp ! Тип поля. Используется при разборе структуры таблицы и
							               формировании списков полей и буферов.
					String: strFiles[ * ] ! Список .DBF файлов в каталоге импорта.
					Date/Time: DTmp[ * ] ! DATE буфера для перетягивания данных.
				Actions
					! Получим имя .INI файла конфигурации.
					Set sIniFile = GetIniFileName()
					! Укажем, что необходимый параметр хранится в файле конфигурации, а не в
					! системном реестре.
					Call SalUseRegistry( FALSE, sIniFile )
					! Прочтем путь к импортируемым файлам. Значение поумолчанию -- пустая
					! строка -- признак ошибки.
					Call SalGetProfileString(
							   'Directory', 'DRImpDBFTmp', '', strImpDir, sIniFile )
					If strImpDir = ''
						Call SalMessageBox(
								   'Параметр DRImpDBFTmp (секция Directory в файле ' || sIniFile || ') не задан или пуст.',
								   'Ошибка', MB_OK )
						Return FALSE
					! Далее "прочешем" каталог, указанный в параметре DRImpDBFTmp и импортируем
					! _ВСЕ_ содержащиеся в нем .DBF файлы в ORACLE таблицы.
					Set nFilesCount = VisDosEnumFiles(
							   strImpDir || '\\*.dbf', FA_Standard, strFiles )
					If nFilesCount = 0
						! В каталоге нет .DBF файлов -- значит нет работы.
						Return TRUE
					Call SalFileGetCurrentDirectory( sCurDir )
					Call SalFileSetCurrentDirectory( strImpDir )
					! Побежали по полученному списку .DBF файлов.
					Set SqlDatabase = 'dBase_Files'
					If SqlConnect( hSqlOdbc ) = FALSE
						Call SalFileSetCurrentDirectory( sCurDir )
						Call SalMessageBox(
								   'Нет доступа к базе данных: ' || SqlDatabase, 'Ошибка', MB_OK )
						Return FALSE
					Set k = 0
					While k < nFilesCount
						! Откроем .DBF файл.
						If SalFileOpen(
								   hFile, strImpDir || '\\' || strFiles[ k ], OF_Read ) = FALSE
							Call SqlDisconnect( hSqlOdbc )
							Call SalFileSetCurrentDirectory( sCurDir )
							Call SalMessageBox( 'Не удалось открыть файл: ' || strImpDir || '\\' || strFiles[ k ], 'Ошибка', MB_OK )
							Return FALSE
						! Выделим имя таблицы из имени .DBF файла.
						Set i = SalStrLength( strFiles[ k ] )
						While i > 0
							If SalStrMidX( strFiles[ k ], i - 1, 1) = '\\' or
									   SalStrMidX( strFiles[ k ], i - 1, 1) = '/' or
									   SalStrMidX( strFiles[ k ], i - 1, 1) = ':'
								Break
							Set i = i - 1
						Set sTab =
								   SalStrMidX( strFiles[ k ], i, SalStrLength( strFiles[ k ] ) - i )
						Set i = SalStrScan( sTab, '.' )
						If i >= 0
							Set sTab = SalStrLeftX( sTab, SalStrScan( sTab, '.' ) )
						! Поскипаем первые 32 байта (общая информация заголовка файла).
						Call SalFileRead( hFile, sBuf, 32 )
						! Начальное заполнение списка колонок для создания таблицы.
						Set sSqlItm = ''
						! Соберем имнформацию о структуре DBF таблицы. Каждая запись о поле -- 32
						! байта.
						Set j = 0
						While SalFileRead( hFile, sBuf, 32 ) > 0
							! Разгребание записи заговка (имя поля, тип, размер).
							! Первым делом, получим имя поля.
							Set sItem = SalStrTrimX( sBuf )
							If SalStrLop( sBuf ) = 13
								! Достигнут конец списка полей DBF таблицы.
								! Закроем список полей и завершим обработку заголовка .DBF файла.
								Set sSqlItm = sSqlItm || ')'
								Break
							If SalStrLength( sSqlItm ) = 0
								! Начало составления списка полей DBF таблицы.
								! Откроем список полей.
								Set sSqlItm = '('
								Set sSqlSel = ''
								Set sSqlBin = ''
								Set sOdbcSel = ''
							Else
								! Есть следующее поле. Поставим разделитель в список.
								Set sSqlItm = sSqlItm || ',' || SalNumberToChar( 10 )
								Set sSqlSel = sSqlSel || ','
								Set sSqlBin = sSqlBin || ','
								Set sOdbcSel = sOdbcSel || ','
							! Разгребание записи заголовка (тип, размер поля).
							Set i = 0
							While i < 10
								Call SalStrLop( sBuf )
								Set i = i + 1
							Set sTyp = SalNumberToChar( SalStrLop( sBuf ) )
							If sTyp = 'L'
								Set sTyp = 'C'
							Set i = 0
							While i < 4
								Call SalStrLop( sBuf )
								Set i = i + 1
							Set nLen1 = SalStrLop( sBuf )
							Set sLen1 = SalNumberToStrX( nLen1, 0 )
							Set nLen2 = SalStrLop( sBuf )
							Set sLen2 = SalNumberToStrX( nLen2, 0 )
							! Этот список дополним _ДО_ определния типа данных SQL, так как sTyp
							! будет "испорчен".
							Set sSqlBin =
									   sSqlBin || ':' || sTyp || 'Tmp[' || SalNumberToStrX( j, 0 ) || ']'
							Set j = j + 1
							If sTyp = 'C'
								If nLen1 < 11
									Set sTyp = 'CHAR'
								Else
									Set sTyp = 'VARCHAR'
							Else
								If sTyp = 'N'
									If nLen1 < 5 and nLen2 = 0
										Set sTyp = 'SMALLINT'
										Set sLen1 = ''
									Else
										If nLen1 < 10 and nLen2 = 0
											Set sTyp = 'INTEGER'
											Set sLen1 = ''
										Else
											Set sTyp = 'DECIMAL'
											Set sLen1 = sLen1 || ',' || sLen2
								Else
									If sTyp = 'D'
										Set sTyp = 'DATE'
										Set sLen1 = ''
							! Доплним список полученной информацией.
							Set sSqlItm = sSqlItm || sItem || '_ ' || sTyp
							If sLen1 != ''
								Set sSqlItm = sSqlItm || '(' || sLen1 || ')'
							Set sSqlSel = sSqlSel || sItem || '_'
							Set sOdbcSel = sOdbcSel || sItem
						! Файл уже не нужен.
						Call SalFileClose( hFile )
						If sSqlItm != ''
							! DBF таблица содержит хотябы одно поле.
							! Проверим, существует ли таблица.
							Set fExists = FALSE
							If SqlPrepareAndExecute( hSql(),
									   "SELECT TABLE_NAME INTO :sTabSel FROM USER_TABLES WHERE UPPER(TABLE_NAME) = UPPER('" || SalStrTrimX( sTab ) || "_')" )
								If SqlFetchNext( hSql(), nFetchRes )
									If nFetchRes = FETCH_Ok
										Set fExists = TRUE
							If fExists
								! Существует. Попытаемся ее очистить.
								If SqlPrepareAndExecute(
										   hSql(), 'DELETE FROM ' || sTab || '_' ) = FALSE
									Call SqlRollback( hSql() )
									Call SqlDisconnect( hSqlOdbc )
									Call SalFileSetCurrentDirectory( sCurDir )
									Call SalMessageBox(
											   'Ошибка подготовки к обновлению таблицы ' || sTab || '_',
											   'Ошибка', MB_OK )
									Return FALSE
							Else
								! Существует. Будем создавать. Но сначала на всякий случай попробуем
								! удалить...
								If SqlPrepareAndExecute(
										   hSql(), 'CREATE TABLE ' || sTab || '_ ' || sSqlItm ) = FALSE
									Call SqlDisconnect( hSqlOdbc )
									Call SalFileSetCurrentDirectory( sCurDir )
									Call SalMessageBox(
											   'Ошибка создания таблицы ' || sTab || '_', 'Ошибка', MB_OK )
									Return FALSE
								If SqlPrepareAndExecute( hSql(),
										   'CREATE PUBLIC SYNONYM ' || sTab || '__ FOR ' || GetUserLoginName() || '.' || sTab || '_' ) = FALSE
									Call SqlPrepareAndExecute( hSql(), 'DROP TABLE ' || sTab || '_' )
									Call SqlDisconnect( hSqlOdbc )
									Call SalFileSetCurrentDirectory( sCurDir )
									Call SalMessageBox(
											   'Ошибка создания синонима ' || sTab || '__ таблицы ' || sTab || '_',
											   'Ошибка', MB_OK )
									Return FALSE
								If SqlPrepareAndExecute(
										   hSql(), 'GRANT SELECT ON ' || sTab || '__ TO DEB_REG' ) = FALSE
									Call SqlPrepareAndExecute(
											   hSql(), 'DROP PUBLIC SYNONYM ' || sTab || '__' )
									Call SqlPrepareAndExecute( hSql(), 'DROP TABLE ' || sTab || '_' )
									Call SqlDisconnect( hSqlOdbc )
									Call SalFileSetCurrentDirectory( sCurDir )
									Call SalMessageBox(
											   'Ошибка предоставления прав доступа к таблице ' || sTab || '_',
											   'Ошибка', MB_OK )
									Return FALSE
								If SqlPrepareAndExecute(
										   hSql(), 'GRANT INSERT ON ' || sTab || '__ TO DEB_REG' ) = FALSE
									Call SqlPrepareAndExecute(
											   hSql(), 'DROP PUBLIC SYNONYM ' || sTab || '__' )
									Call SqlPrepareAndExecute( hSql(), 'DROP TABLE ' || sTab || '_' )
									Call SqlDisconnect( hSqlOdbc )
									Call SalFileSetCurrentDirectory( sCurDir )
									Call SalMessageBox(
											   'Ошибка предоставления прав доступа к таблице ' || sTab || '_',
											   'Ошибка', MB_OK )
									Return FALSE
								If SqlPrepareAndExecute(
										   hSql(), 'GRANT DELETE ON ' || sTab || '__ TO DEB_REG' ) = FALSE
									Call SqlPrepareAndExecute(
											   hSql(), 'DROP PUBLIC SYNONYM ' || sTab || '__' )
									Call SqlPrepareAndExecute( hSql(), 'DROP TABLE ' || sTab || '_' )
									Call SqlDisconnect( hSqlOdbc )
									Call SalFileSetCurrentDirectory( sCurDir )
									Call SalMessageBox(
											   'Ошибка предоставления прав доступа к таблице ' || sTab || '_',
											   'Ошибка', MB_OK )
									Return FALSE
							! Таблица готова к заселению.
							! Определим количество записей в DBF таблице.
							Set nRec = 0
							If SqlPrepareAndExecute(
									   hSqlOdbc, 'SELECT count(*) INTO :nRec FROM ' || sTab ) = FALSE
								Call SqlRollback( hSql() )
								Call SqlDisconnect( hSqlOdbc )
								Call SalFileSetCurrentDirectory( sCurDir )
								Call SalMessageBox(
										   'Ошибка заполнения таблицы ' || sTab || '_', 'Ошибка', MB_OK )
								Return FALSE
							If SqlFetchNext( hSqlOdbc, nFetchRes ) = FALSE
								Call SqlRollback( hSql() )
								Call SqlDisconnect( hSqlOdbc )
								Call SalFileSetCurrentDirectory( sCurDir )
								Call SalMessageBox(
										   'Ошибка заполнения таблицы ' || sTab || '_', 'Ошибка', MB_OK )
								Return FALSE
							If nRec > 0
								! Таблица не пуста. Будем выгребать и вставлять по одной записи.
								If SqlPrepareAndExecute( hSqlOdbc,
										   'SELECT ' || sOdbcSel || ' INTO ' || sSqlBin || ' FROM ' || sTab ) = FALSE
									Call SqlRollback( hSql() )
									Call SqlDisconnect( hSqlOdbc )
									Call SalFileSetCurrentDirectory( sCurDir )
									Call SalMessageBox(
											   'Ошибка заполнения таблицы ' || sTab || '_', 'Ошибка', MB_OK )
									Return FALSE
								Set i = 0
								While SqlFetchNext( hSqlOdbc, nFetchRes )
									Call SalArrayGetUpperBound( CTmp, 1, nBound )
									Set j = 0
									While j <= nBound
										If SalStrLength( CTmp[ j ] ) > 0
											Set CTmp[ j ] = SalStrTrimX(
													   IifS( TRUE, StrDosToWinX( CTmp[ j ] ), CTmp[ j ] ) )
										Set j = j + 1
									If SqlPrepareAndExecute( hSql(),
											   'INSERT INTO ' || sTab || '__ (' || sSqlSel || ') VALUES(' || sSqlBin || ')' ) = FALSE
										Call SqlRollback( hSql() )
										Call SqlDisconnect( hSqlOdbc )
										Call SalFileSetCurrentDirectory( sCurDir )
										Call SalMessageBox(
												   'Ошибка заполнения таблицы ' || sTab || '_', 'Ошибка', MB_OK )
										Return FALSE
									Set i = i + 1
								If i < nRec
									Call SqlRollback( hSql() )
									Call SqlDisconnect( hSqlOdbc )
									Call SalFileSetCurrentDirectory( sCurDir )
									Call SalMessageBox(
											   'Ошибка заполнения таблицы ' || sTab || '_', 'Ошибка', MB_OK )
									Return FALSE
						Set k = k + 1
					! Порядок. Подпишемся и отвалим.
					If SqlCommit( hSql() ) = FALSE
						Call SqlRollback( hSql() )
						Call SqlDisconnect( hSqlOdbc )
						Call SalFileSetCurrentDirectory( sCurDir )
						Call SalMessageBox(
								   'Ошибка заполнения таблицы ' || sTab || '_', 'Ошибка', MB_OK )
						Return FALSE
					Call SqlDisconnect( hSqlOdbc )
					Call SalFileSetCurrentDirectory( sCurDir )
					! Конец шоу.
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
		Default Classes
			MDI Window: cBaseMDI
			Form Window:
			Dialog Box:
			Table Window:
			Quest Window:
			Data Field:
			Spin Field:
			Multiline Field:
			Pushbutton: ctb_pbGetValue
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
			On SAM_AppStartup
	Table Window: DEB_REG_F
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: 1. Формування файлу до ЄІС /Дані про боржників
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
				Left:   0.975"
				Top:    1.198"
				Width:  16.533"
				Width Editable? Class Default
				Height: 6.095"
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
			Maximum Rows in Memory: 30000
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
				Data Field: DAT_
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
							Left:   0.417"
							Top:    0.071"
							Width:  1.633"
							Width Editable? Yes
							Height: 0.321"
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
						On SAM_TooltipSetText
							Return XSalTooltipSetText( lParam, 'Розрахункова дата' )
				!
				Pushbutton: pbIns
					Class Child Ref Key: 33
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
						Left:   3.383"
						Top:    0.071"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Yes
					Keyboard Accelerator: Class Default
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
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 65382
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
						Left:   5.383"
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
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   5.883"
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
					Resource Id: 65383
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
						Left:   6.883"
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
					Resource Id: 65384
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
				Pushbutton: pb_DEB_REG_F
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbGetValue
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   6.383"
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
					Picture File Name: \BARS98\RESOURCE\BMP\Arr1tor.bmp
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Поновити реест боржників для передачі в ЦБД'
						On SAM_Click
							! Пока без подписи // Инициализация подписи
							If IDNO = SalMessageBox( 'Поновити реест боржників для передачі в ЦБД?', 
									'Реєстр Боржників', MB_IconQuestion | MB_YesNo )
								Return TRUE
							! If CustomerSign.InitSign()
							Set nRow = TBL_MinRow
							Set bOk=TRUE
							While SalTblFindNextRow( hWndForm, nRow, ROW_Selected, 0 ) and bOk
								Call SalTblSetContext( hWndForm, nRow )
								! If EVENTTYPE =1
									                    Set bOk =
											SqlPrepareAndExecute( hSql(),
											 "INSERT INTO DEBREG (DEBNUM,ADR, CRDAGRNUM, CRDDATE ,CUSTTYPE ,
											     KV,NMK,OKPO, PRINSIDER, SUMM, REZID,DEBDATE, OSN )
											  VALUES (:ACC,:ADR,:CRDAGRNUM, :CRDDATE, :CUSTTYPE,
											    :KV,:NMK,:OKPO,:PRINSIDER,:SUM, :REZID,:DEBDATE, :OSN )" )
								! Else
									                    Set bOk =
											SqlPrepareAndExecute( hSql(),
											 "UPDATE DEBREG set ADR=:ADR,   SUMM=:SUM, 
											                    crddate=:CRDDATE,
											                    CRDAGRNUM=:CRDAGRNUM ,
											                    debdate  =:DEBDATE 
											  WHERE DEBNUM=:ACC" )
								If SqlPLSQLCommand( hSql(),"BARS.DR.REFRESH_DEBREG
										  (ACC,ADR,CRDAGRNUM,CRDDATE,CUSTTYPE,KV,NMK,OKPO,PRINSIDER,SUM_FLOAT*DENOM,REZID,DEBDATE,OSN)")
									Set bOk = TRUE
								Else
									Set bOk = FALSE
								! Здесь подпись строки в DEBREG_QUERY ключ связи DEBNUM
								If bOk
									Set bOk =
											SqlPrepareAndExecute( hSql(),
											  "INSERT INTO DEBREG_QUERY
											   (requestid,debnum,EVENTDATE,EVENTTYPE,PHASEID)
											   VALUES (0,:ACC,:EVENTDATE,:EVENTTYPE,'F') ")
							! TODO: Вызвать процедуру dr.pf_name для назначения имен файлов!!
							If bOk
								If SalStrTrimX(SalStrUpperX(GetDBMS())) = 'ORACLE'
									Set bOk = SqlPrepareAndExecute(hSql(), "begin DR.pf_name; end; " )
							If bOk
								! If SqlPrepareAndExecute( hSql(), "DELETE FROM deb_reg_tmp" ) 
										and SqlCommit(hSql())
								Call SqlCommit(hSql())
								Call MessageInfoEx('Готово.')
							Else
								Call SqlRollback( hSql() )
							Call SalWaitCursor( FALSE )
							! Call SalSendMsg( pbExit, SAM_Click, 0, 0 )
				Pushbutton: pb_Run
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbGetValue
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
					Picture File Name: \bars98\RESOURCE\BMP\Execute.bmp
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Поновити дані з обліку'
						On SAM_Click
							Set nResult = SalMessageBox( 'УВАГА! В ході оновлення данних, поля, відкореговані вручну, будуть змінені.'
									 ||PutCrLf()||'Провести оновлення?' ,
									 'Оновлення данних', MB_IconQuestion|MB_YesNo )
							If nResult = IDYES
								Call SalWaitCursor(TRUE)
								If SalStrTrimX(SalStrUpperX(GetDBMS())) = 'ORACLE'
									If SqlPLSQLCommand(hSql(), "DR.dr_new (DAT_) " )
										Call SqlCommit( hSql() )
										Call SalSendMsg( pbRefresh, SAM_Click, 0, 0 )
									Else
										Call SqlRollback(hSql())
										Call SalWaitCursor(FALSE)
										Call MessageNoWait( 'Ошибка при выполнении процедуры !',"DR.dr_new  " , 30, 1 )
								Call SalWaitCursor(FALSE)
				Pushbutton: pb_Add
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbGetValue
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
					Visible? No
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \bars98\RESOURCE\BMP\Edit.bmp
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Додаткові дані (не з обліку в АБС )'
						On SAM_Click
							If not IsWindow(hW_Add)
								Set hW_Add = SalCreateWindow( TA, hWndMDI, sPar_, nTipKl)
							Else
								Call SalBringWindowToTop ( TA )
				Pushbutton: pb_SyncMirror
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cTBarButton
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   8.183"
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
					Picture File Name: \BARS98\RESOURCE\BMP\QUERY.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Доповнити зеркало новими данними'
						On SAM_Click
							If IDNO = SalMessageBox( 'Доповнити зеркало реєстру новими данними?', 
									'Зеркало реєстра', MB_IconQuestion | MB_YesNo )
								Return TRUE
							Set bOk = SqlPrepareAndExecute( hSql(),
									 "INSERT INTO DEBREG_RES_S (DEBNUM, ADR, CRDAGRNUM, CRDDATE ,CUSTTYPE ,
									     KV, NMK, OKPO, PRINSIDER, SUMM, REZID, DEBDATE,
									  EVENTTYPE, EVENTDATE, REGDATETIME, FILENAME, ILNUM, OSN )
									  SELECT DEBREG.DEBNUM, ADR, CRDAGRNUM, CRDDATE ,CUSTTYPE ,
									     KV, DEBREG.NMK, DEBREG.OKPO, PRINSIDER, SUMM, REZID, DEBDATE,
									     EVENTTYPE, EVENTDATE, BANKDATE_G, DEBREG_QUERY.FILENAME, DEBREG_QUERY.ILNUM,
									     DEBREG.OSN
									  FROM DEBREG, DEBREG_QUERY
									  WHERE DEBREG.DEBNUM = DEBREG_QUERY.DEBNUM AND
									    DEBREG.DEBNUM NOT IN (SELECT DEBNUM FROM DEBREG_RES_S)" )
							If Not bOk
								Call SqlRollback( hSql() )
								Return FALSE
							Set bOk = SqlPrepareAndExecute( hSql(),
									 "UPDATE DEBREG_RES_S s SET (ADR, CRDAGRNUM, CRDDATE ,CUSTTYPE ,
									     KV, NMK, OKPO, PRINSIDER, SUMM, REZID, DEBDATE,
									     EVENTTYPE, EVENTDATE, REGDATETIME, FILENAME, ILNUM, OSN  )=
									  (SELECT ADR, CRDAGRNUM, CRDDATE ,CUSTTYPE ,
									     KV, d.NMK, d.OKPO, PRINSIDER, SUMM, REZID, DEBDATE,
									     EVENTTYPE, EVENTDATE, BANKDATE_G, q.FILENAME, q.ILNUM,
									     DEBREG.OSN
									   FROM DEBREG d, DEBREG_QUERY q
									   WHERE d.DEBNUM = q.DEBNUM AND
									   d.DEBNUM=s.DEBNUM
									   AND (q.requestid,q.eventdate)=
									   	   (select requestid, max(eventdate) from DEBREG_QUERY qq 
										    where q.debnum=qq.debnum group by requestid) 
									  )
									  WHERE DEBNUM IN (SELECT DEBNUM FROM DEBREG_RES_S) " )
							If Not bOk
								Call SqlRollback( hSql() )
								Return FALSE
							Else
								Call SqlCommit(hSql())
								Call MessageInfoEx('Готово.')
		Contents
			Column: ACC
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						строки
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  0.75"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: NMK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Назва 
						клієнта
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.817"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Title: Ід. код 
						клієнта
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
				Width:  1.15"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: REZID
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Р
						е
						з
						и
						д
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  0.4"
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
						Uncheck Value: 2
						Ignore Case? Yes
				List Values
				Message Actions
			Column: CUSTTYPE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ознака
						клієнта
						0-Фіз.
						1-Юр.
				Visible? Yes
				Editable? No
				Maximum Data Length: 1
				Data Type: Number
				Justify: Center
				Width:  0.767"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? No
						Auto Drop Down? No
						Allow Text Editing? No
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: CUSTTYPE_STR
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Тип
						кл
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
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
						Vertical Scroll? No
						Auto Drop Down? No
						Allow Text Editing? No
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: CRDAGRNUM
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Номер 
						кредитної 
						угоди 
						(або рахунок)
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 16
				Data Type: String
				Justify: Left
				Width:  1.233"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: CRNLS
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Рахунок
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 16
				Data Type: String
				Justify: Left
				Width:  1.117"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
						Set sTmp = CRNLS
					On SAM_AnyEdit
						Set CRNLS = sTmp
			Column: CRDDATE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата 
						надання 
						кредиту
				Visible? Yes
				Editable? Yes
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
			Column: KV
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код 
						вал.
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
				Data Type: Number
				Justify: Center
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
						Allow Text Editing? No
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: SUM_STR
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сума
				Visible? No
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
				Width:  1.517"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: SUM_FLOAT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сума 
						простроченої 
						заборгованості 
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.433"
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
			Column: DEBDATE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						виникнення
						просроч.
						боргу
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.117"
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
					On SAM_Validate
						If DEBDATE > DAT_
							Call Debug('Ош.дата')
							Return VALIDATE_Cancel
						Set DAY = DAT_ - DEBDATE
			Column: SUMD
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Заг.
						сума
						боргу
						по клієнту
						(грн)
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.517"
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
			Column: DAY
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Д
						н
						і
						в
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
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
			Column: EVENTTYPE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Тип події: 
						1-новий 
						2 -зміна 
						3-погашено 
						4 вилучити
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
				Width:  1.133"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
						Set EVENTTYPE_ = EVENTTYPE
					On SAM_Validate
						If EVENTTYPE !=4
							Set EVENTTYPE = EVENTTYPE_
			Column: EVENTDATE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						події
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Left
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
			Column: CCOLOR
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Стан: 
						в НБУ - 
						0-не погаш. 
						3-погашен 
						1-новий 
						2-зміна
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
			Column: SUM
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма
				Visible? No
				Editable? Yes
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
			Column: PRINSIDER
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ін
						сай
						дер
				Visible? Yes
				Editable? No
				Maximum Data Length: 99
				Data Type: Number
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
			Column: ADR
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Адреса 
						клієнта
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.35"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: OSN
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дані 
						про керівників 
						та засновників
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.667"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: DENOM
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
		Window Parameters
			String: sPar_
			Number: nTipKl
		Window Variables
			Boolean: bOk
			Number: EVENTTYPE_
			Number: nRow
			! cCustomerSign: CustomerSign
			Number: nLastSortRow
			Number: nSortOrder
			Window Handle: hColumn
			Window Handle: hWndColumn
			Number: nColor
			Number: hFont
			Number: hImage
			Number: nImagePos
			String: sImageFileName
			Number: nCustom
			String: sFontName
			Number: nFontSize
			Number: nFontEnh
			Number: nSplitRow
			Boolean: bSize
			Boolean: bRow
			Boolean: bCol
			Boolean: bCell
			String: szImage1
			String: szImage2
			String: szImage3
			Number: nSUMM
			Number: nEVENTTYPE
			Number: nDRMIRROR
			String: szDRMIRROR
			Number: nRetVal
			Number: nResult
			String: sTmp
		Message Actions
			On SAM_Create
				Set DEB_REG_F.nTabInstance = 1
				Set DEB_REG_F.strPrintFileName = 'DEB_REG_F'
				Set DAT_ = GetBankDate()
				Set DEB_REG_F.nTabInstance = 1
				Set DEB_REG_F.strFilterTblName = 'DEB_REG_TMP'
				Call SetWindowFullSize(hWndForm)
				! Set nLastSortRow = -1
				Set DEB_REG_F.strSqlDelete ="DELETE FROM deb_reg_tmp where acc=:DEB_REG_F.ACC"
				Set DEB_REG_F.strSqlUpdate =
						"UPDATE deb_reg_tmp  SET eventtype=:DEB_REG_F.EVENTTYPE, ADR      =:DEB_REG_F.ADR,
						                         crddate  =:DEB_REG_F.CRDDATE  , CRDAGRNUM=:DEB_REG_F.CRDAGRNUM ,
						                         debdate  =:DEB_REG_F.DEBDATE  , DAY      =:DEB_REG_F.DAY,
						                         osn = :DEB_REG_F.OSN,
									 nmk = :DEB_REG_F.NMK,
									 eventdate = :DEB_REG_F.EVENTDATE,
									 sum = to_number(:DEB_REG_F.SUM_FLOAT)*:DEB_REG_F.DENOM,
									 sumd = to_number(:DEB_REG_F.SUMD)*100
						                     WHERE acc=:DEB_REG_F.ACC "
				! sum = :DEB_REG_F.SUM_FLOAT*:DEB_REG_F.DENOM
				! Сумму долга в валюте(поле SUM) делим на tabval.denom
				! Эквивалент суммы долга в целом по клиента(поле SUMD) делим на 100 потому, что гривна
				Set DEB_REG_F.strSqlPopulate =
						"SELECT deb_reg_tmp.EVENTTYPE, 
							deb_reg_tmp.CCOLOR, 
						        deb_reg_tmp.acc,
						        deb_reg_tmp.nls,
						        deb_reg_tmp.OKPO,
						        deb_reg_tmp.NMK,
						        deb_reg_tmp.ADR,
						        deb_reg_tmp.CUSTTYPE,
						        deb_reg_tmp.PRINSIDER,
							deb_reg_tmp.KV, 
						        deb_reg_tmp.CRDAGRNUM,
						        deb_reg_tmp.CRDDATE,
						        deb_reg_tmp.SUM,
						        deb_reg_tmp.DEBDATE,
							deb_reg_tmp.DAY, 
						        deb_reg_tmp.rezid,
							deb_reg_tmp.SUM/tabval.denom, 
						        to_char(deb_reg_tmp.SUM/tabval.denom, 'FM999G999G999G999G999G999D'||rpad('0',tabval.dig,'0'), 
						               'NLS_NUMERIC_CHARACTERS = ''. '''),
						        deb_reg_tmp.SUMD/100,
						        deb_reg_tmp.osn,
							deb_reg_tmp.eventdate,
						        tabval.denom
						 INTO :DEB_REG_F.EVENTTYPE,
						      :DEB_REG_F.CCOLOR,
						      :DEB_REG_F.ACC,      :DEB_REG_F.CRNLS,
						      :DEB_REG_F.OKPO,     :DEB_REG_F.NMK,   :DEB_REG_F.ADR,
						      :DEB_REG_F.CUSTTYPE, :DEB_REG_F.PRINSIDER,:DEB_REG_F.KV, 
						      :DEB_REG_F.CRDAGRNUM,:DEB_REG_F.CRDDATE,  :DEB_REG_F.SUM,
						      :DEB_REG_F.DEBDATE,:DEB_REG_F.DAY,
						      :DEB_REG_F.REZID,
						      :DEB_REG_F.SUM_FLOAT, 
						      :DEB_REG_F.SUM_STR,
						      :DEB_REG_F.SUMD,
						      :DEB_REG_F.OSN,
						      :DEB_REG_F.EVENTDATE,
						      :DEB_REG_F.DENOM
						 FROM deb_reg_tmp, tabval WHERE deb_reg_tmp.kv=tabval.kv " 
						     || IifS( nTipKl >= 0, "AND deb_reg_tmp.CUSTTYPE="||Str(nTipKl), " ") || "
						 ORDER BY deb_reg_tmp.CUSTTYPE, deb_reg_tmp.okpo"
				Set szDRMIRROR='DRMIRROR'
				Set nDRMIRROR = 0
				If SqlPrepareAndExecute(hSql(), 
						'SELECT to_number(val) INTO :nDRMIRROR FROM params WHERE par=:szDRMIRROR' )
					Call SqlFetchNext(hSql(), nRetVal)
				If nDRMIRROR = 1
					Call SalEnableWindow( pb_SyncMirror )
				Else
					Call SalDisableWindow( pb_SyncMirror )
					Call SalHideWindow( pb_SyncMirror )
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On SAM_FetchRowDone
				! индейская раскраска
				Select Case (CCOLOR)
					Case 1
						Call SetTblRowColor( DEB_REG_F, COLOR_Red )
						Break
					Case 2
						Call SetTblRowColor( DEB_REG_F, COLOR_DarkGreen )
						Break
					Case 3
						Call SetTblRowColor( DEB_REG_F, COLOR_Gray )
						Break
					Default
						Call SetTblRowColor( DEB_REG_F, COLOR_Black )
						Break
	Table Window: DEB_REG_C
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: 3. Запити до ЄІС та відповіді на них 
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
				Width:  12.15"
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
			Maximum Rows in Memory: 30000
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
					Resource Id: 65385
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
						On SAM_Click
							If SalTblAnyRows( hWndForm, ROW_Selected, 0 )
								If not IsWindow(hW_D)
									Set hW_D = SalCreateWindow(DEB_REG_D, hWndMDI, Str(requestid), sPar_, nTipKl )
								Else
									Call SalBringWindowToTop ( DEB_REG_D )
						On SAM_Create
							Set strTip = 'Переглянути відповідь з ЦБД на наш запит'
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
					Resource Id: 65386
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
					Resource Id: 65387
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
			Column: OKPO
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ід. код 
						клієнта
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
				Width:  1.65"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: NMK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Назва клієнта
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.317"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: OSN
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дані про 
						керівників та засновників
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.317"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: QUERYTYPE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Тип запиту 
						до Реєстру : 
						1-поточні, 
						2 -всі дані
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 1
				Data Type: Number
				Justify: Center
				Width:  1.317"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value: 2
						Uncheck Value: 1
						Ignore Case? Yes
				List Values
				Message Actions
					! On SAM_Validate
						                               Call DebugN(QUERYTYPE)
			Column: requestid
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ід №
						запиту
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  0.817"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: SOS
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Стан
						0-Новий
						1-Чекає 
						3- Файл 
						5-Kвитов
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
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
		Functions
		Window Parameters
			String: sPar_
			Number: nTipKl
		Window Variables
		Message Actions
			On SAM_Create
				Set DEB_REG_C.nTabInstance = 1
				Call SetWindowFullSize(hWndForm)
				Set DEB_REG_C.strFilterTblName = 'DEB_REG_C'
				Set DEB_REG_C.strPrintFileName = 'DEBREG_C.txt'
				Set DEB_REG_C.strSqlDelete = 
						"DELETE FROM DEBREG_QUERY where requestid=:DEB_REG_C.requestid and PHASEID='C' "
				Set DEB_REG_C.strSqlInsert = 
						"INSERT into DEBREG_QUERY (requestid, SOS, PHASEID, NMK, OKPO, QUERYTYPE, osn )
						              values (0, 0, 'C', :DEB_REG_C.NMK, :DEB_REG_C.OKPO, :DEB_REG_C.QUERYTYPE, :DEB_REG_C.OSN ) "
				Set DEB_REG_C.strSqlUpdate = 
						"UPDATE DEBREG_QUERY
						              set NMK=:DEB_REG_C.NMK, OKPO=:DEB_REG_C.OKPO, QUERYTYPE=:DEB_REG_C.QUERYTYPE, OSN=:DEB_REG_C.OSN
						              WHERE requestid=:DEB_REG_C.requestid and SOS=0 and PHASEID='C' "
				Set DEB_REG_C.strSqlPopulate =
						"SELECT requestid, SOS, NMK,OKPO, QUERYTYPE, osn
						 INTO  :DEB_REG_C.requestid, :DEB_REG_C.SOS, :DEB_REG_C.NMK, :DEB_REG_C.OKPO, :DEB_REG_C.QUERYTYPE,
						       :DEB_REG_C.OSN
						 FROM DEBREG_QUERY 
						 WHERE PHASEID='C' 
						 ORDER BY okpo "
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On UM_DoubleClick
				Call SalSendMsg( pbDetails, SAM_Click, 0, 0 )
	Table Window: DEB_REG_D
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: 4. Відповіді з ЄІС на наші запити
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
				Left:   0.55"
				Top:    0.458"
				Width:  16.167"
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
			Maximum Rows in Memory: 30000
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
						Left:   0.1"
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
					Resource Id: 65388
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
						Left:   0.567"
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
						Left:   1.033"
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
				Pushbutton: pbDetails
					Class Child Ref Key: 39
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.5"
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
						Left:   1.967"
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
					Resource Id: 65389
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
						Left:   2.433"
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
					Resource Id: 65390
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
		Contents
			Column: MFO
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Умовний 
						№ банку, 
						що надав 
						інф.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.033"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Title: Ід. код 
						клієнта
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.217"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: NMK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Назва клієнта
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.817"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: ADR
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Адреса 
						клієнта
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
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
			Column: osn
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дані про 
						керівників 
						та засновників
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.783"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: DEBDATE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата 
						виникнення 
						простр. 
						заборгов.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.5"
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
			Column: KV
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код 
						вал.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  0.583"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: SUM
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сума 
						простроченої 
						заборгованості 
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.433"
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
			Column: DEBOFFDATE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата 
						погашення 
						простр. 
						заборгов.
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
			Column: REGDATETIME
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата та час 
						занесення 
						в БД 
						реєстру
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.133"
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
			Column: requestid
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ід.№
						запиту
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  0.817"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: NB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Назва банку
						боржника
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
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
		Functions
		Window Parameters
			String: sFiltr
			String: sPar_
			Number: nTipKl
		Window Variables
		Message Actions
			On SAM_Create
				Set DEB_REG_D.nTabInstance = 1
				Call SetWindowFullSize(hWndForm)
				! Call SalSetWindowText( DEB_REG_D, 'Ответ на запрос' )
				Set DEB_REG_D.nFlags = GT_NoUpd | GT_NoDel | GT_NoRet | GT_NoIns
				Set DEB_REG_D.strFilterTblName = 'DEBREG_RES'
				Set DEB_REG_D.strPrintFileName = 'DEBREG_RES.txt'
				Set DEB_REG_D.strSqlDelete = "DELETE FROM DEBREG_RES where requestid=:DEB_REG_D.requestid"
				Set DEB_REG_D.strSqlPopulate =
						"SELECT DEBREG_RES.requestid, DEBREG_RES.REGDATETIME, DEBREG_RES.MFO,
						        DEBREG_RES.OKPO,      DEBREG_RES.NMK,         DEBREG_RES.KV,
						        DEBREG_RES.SUMM/100,  DEBREG_RES.DEBDATE,     DEBREG_RES.DEBOFFDATE,
						        DEBREG_RES.ADR, b.NB, DEBREG_RES.OSN
						 INTO  :DEB_REG_D.requestid, :DEB_REG_D.REGDATETIME, :DEB_REG_D.MFO,
						       :DEB_REG_D.OKPO,       :DEB_REG_D.NMK,         :DEB_REG_D.KV,
						       :DEB_REG_D.SUM,        :DEB_REG_D.DEBDATE,     :DEB_REG_D.DEBOFFDATE,
						       :DEB_REG_D.ADR,        :DEB_REG_D.NB, :DEB_REG_D.osn
						 FROM DEBREG_RES, banks b
						 WHERE DEBREG_RES.MFO=b.mfo (+) " ||
						  IifS( sFiltr !=STRING_Null," and requestid="||sFiltr, "") || "
						 ORDER BY requestid "
				Call SalSendClassMessage(SAM_Create, 0, 0)
	Table Window: DEB_REG_FILE_INFO
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: 5. Інформація про відправку файлів 
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
			Maximum Rows in Memory: 30000
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
					Resource Id: 65391
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  4.5"
						Begin Y:  Class Default
						End X:  4.5"
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
						On SAM_Click
							If SalTblAnyRows( hWndForm, ROW_Selected, 0 )
								If not IsWindow(hW_D)
									Set hW_D = 
											SalCreateWindow(DEB_REG_DETAILS, hWndMDI, DEB_REG_FILE_INFO.FN, DEB_REG_FILE_INFO.DAT)
								Else
									Call SalBringWindowToTop ( DEB_REG_DETAILS )
						On SAM_Create
							Set strTip = 'Перегляд змісту файлу'
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
					Resource Id: 65392
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
						Left:   4.583"
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
					Resource Id: 65393
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
				Pushbutton: pbRecycle
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbGetValue
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.983"
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
					Picture File Name: \BARS98\RESOURCE\BMP\recycle.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Click
							If IDYES=
									SalMessageBox( 'Переформировать файл '||DEB_REG_FILE_INFO.FN||' ?','',  MB_YesNo | MB_IconQuestion)
								If SqlPrepareAndExecute( hSql(),
										"UPDATE ZAG_PF SET otm=1 WHERE fn='"||DEB_REG_FILE_INFO.FN||"'")
									Call SqlCommit(hSql())
									Call SalSendMsg( pbRefresh, SAM_Click, 0, 0 )
						On SAM_Create
							Set strTip = 'Переформировать файл'
		Contents
			Column: FN
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Назва файлу 
						типу F
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Center
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
			Column: DAT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Д+Ч 
						створення
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.517"
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
			Column: N
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Кількість
						записів
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
				Width:  1.017"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: OTM
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Стан
						1- присвоєно імя
						3-файл сформовано
						5-файл сквитовано
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
				Width:  1.933"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: DATK
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
				Width:  1.517"
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
			String: sPar_
			Number: nTipKl
		Window Variables
		Message Actions
			On SAM_Create
				Set DEB_REG_FILE_INFO.nTabInstance = 1
				Call SetWindowFullSize(hWndForm)
				Call PrepareWindow( hWndForm )
				Call SalDisableWindow(pbRecycle)
				Set DEB_REG_FILE_INFO.strPrintFileName = 'fileinfo'
				Set DEB_REG_FILE_INFO.nFlags = GT_NoUpd | GT_NoDel | GT_NoRet | GT_NoIns
				Set DEB_REG_FILE_INFO.strFilterTblName = 'ZAG_PF'
				Set DEB_REG_FILE_INFO.strPrintFileName = 'dr_files.txt'
				Set DEB_REG_FILE_INFO.strSqlPopulate =
						"SELECT fn,dat,n,otm,datk INTO 
						     :DEB_REG_FILE_INFO.FN, :DEB_REG_FILE_INFO.DAT ,
						     :DEB_REG_FILE_INFO.N , :DEB_REG_FILE_INFO.OTM,
						     :DEB_REG_FILE_INFO.DATK FROM ZAG_PF  "
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On UM_DoubleClick
				Call SalSendMsg( pbDetails, SAM_Click, 0, 0 )
			On SAM_Click
				If DEB_REG_FILE_INFO.OTM=3
					Call SalEnableWindow(pbRecycle)
				Else
					Call SalDisableWindow(pbRecycle)
	Table Window: DEB_REG_DETAILS
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Перегляд файлу
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
				Left:   0.275"
				Top:    0.229"
				Width:  14.083"
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
			Maximum Rows in Memory: 30000
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
					Resource Id: 65394
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  4.5"
						Begin Y:  Class Default
						End X:  4.5"
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
					Resource Id: 65395
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
						Left:   3.983"
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
					Resource Id: 65396
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
			Column: num
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: №
						пп
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  0.7"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: okpo
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
			Column: nmk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Назва 
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
			Column: adr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Адреса
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
			Column: custtype
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Тип 
						кл
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
				Width:  0.45"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: rezid
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Р
						е
						з
						и
						д
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
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
			Column: eventtype
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: 1-новий
						2-понов
						3-погаш
						4-вилуч.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
				Width:  0.917"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: eventdate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						
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
			Column: debnum
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Номер
						боргу
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  0.683"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: kv
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Вал
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
				Width:  0.75"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: crdagrnum
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: №
						кредитної
						угоди
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
			Column: crddate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						видачі
						кредиту
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
			Column: summ
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
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: osn
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Директор/Засновник
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.467"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
			String: szFileName
			Date/Time: dtFileDate
		Window Variables
			String: szFileDateStr
		Message Actions
			On SAM_Create
				Set DEB_REG_DETAILS.nTabInstance = 1
				Call SetWindowFullSize(hWndForm)
				Set szFileDateStr = SalFmtFormatDateTime ( dtFileDate, 'dd-MM-yyyy hh:mm' )
				Call SalSetWindowText( DEB_REG_DETAILS,
						'Файл: '||szFileName||' за '||szFileDateStr )
				Set DEB_REG_DETAILS.nFlags = GT_NoUpd | GT_NoDel | GT_NoRet | GT_NoIns
				Set DEB_REG_DETAILS.strFilterTblName = 'debreg_details'
				Set DEB_REG_DETAILS.strPrintFileName = 'DEBREG_I.txt'
				Set DEB_REG_DETAILS.strSqlPopulate =
						"SELECT num,okpo,nmk,adr,custtype,rezid,eventtype,eventdate,debnum,
							kv,crdagrnum,crddate,summ,osn
						 INTO  :DEB_REG_DETAILS.num, :DEB_REG_DETAILS.okpo,:DEB_REG_DETAILS.nmk,:DEB_REG_DETAILS.adr,
							:DEB_REG_DETAILS.custtype,:DEB_REG_DETAILS.rezid,:DEB_REG_DETAILS.eventtype,
							:DEB_REG_DETAILS.eventdate,:DEB_REG_DETAILS.debnum,
							:DEB_REG_DETAILS.kv,:DEB_REG_DETAILS.crdagrnum,:DEB_REG_DETAILS.crddate,
							:DEB_REG_DETAILS.summ, :DEB_REG_DETAILS.osn
						 FROM debreg_details
						 WHERE fn IS NOT NULL " ||
						  IifS( szFileName!=STRING_Null," and fn='"||szFileName||"'", "") || "
						  ORDER BY num"
				Call SalSendClassMessage(SAM_Create, 0, 0)
	Table Window: DEB_REG_BLK
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: 6. Помилки. Неприйняті файли.      
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
				Left:   0.275"
				Top:    0.229"
				Width:  16.033"
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
			Maximum Rows in Memory: 30000
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
					Resource Id: 65397
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  4.5"
						Begin Y:  Class Default
						End X:  4.5"
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
					Resource Id: 65398
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
						Left:   3.983"
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
					Resource Id: 65399
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
			Column: errorcode
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						блокування
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  0.7"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: requestid
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ід №
						запиту
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
			Column: filename
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Назва файлу 
						типу F
				Visible? Yes
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
			Column: filedate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Д+Ч створення 
						файлу F
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.533"
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
			Column: okpo
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ід. код 
						клієнта
				Visible? Yes
				Editable? Yes
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
			Column: nmk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Назва 
						клієнта
				Visible? Yes
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
			Column: adr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Адреса 
						клієнта
				Visible? Yes
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
			Column: custtype
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ознака
						клієнта
						0-Фіз.
						1-Юр.
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
			Column: rezid
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Р
						е
						з
						и
						д
						
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
				Width:  0.417"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: eventtype
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Тип останньої 
						події : 
						1-внесено 
						2 -змінено 
						3-погашено 
						4-вилучено
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
				Width:  1.467"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: eventdate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата 
						останньої 
						події
				Visible? Yes
				Editable? Yes
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
			Column: debnum
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Номер 
						простроченої 
						заборгованості
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.45"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: kv
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код 
						вал.
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
				Width:  0.75"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: crdagrnum
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: №
						кредит
						угоди
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  0.833"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: crddate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата 
						надання 
						кредиту
				Visible? Yes
				Editable? Yes
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
			Column: summ
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сума 
						простроченої 
						заборгованості 
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.55"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: osn
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дані про 
						керівників 
						та засновників
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.067"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
			String: sPar_
			Number: nTipKl
		Window Variables
			Number: nRow
		Message Actions
			On SAM_Create
				Set DEB_REG_BLK.nTabInstance = 1
				Call SetWindowFullSize(hWndForm)
				Set DEB_REG_BLK.nFlags = GT_NoRet | GT_NoIns
				Set DEB_REG_BLK.strFilterTblName = 'debreg_blk'
				Set DEB_REG_BLK.strPrintFileName = 'DR_BLK.txt'
				Set DEB_REG_BLK.strSqlPopulate =
						"SELECT requestid, errorcode,okpo,nmk,adr,custtype,rezid,eventtype,eventdate,debnum,
							kv,crdagrnum,crddate,summ,osn,filename,filedate
						 INTO   :DEB_REG_BLK.requestid,:DEB_REG_BLK.errorcode, :DEB_REG_BLK.okpo,:DEB_REG_BLK.nmk,:DEB_REG_BLK.adr,
							:DEB_REG_BLK.custtype,:DEB_REG_BLK.rezid,:DEB_REG_BLK.eventtype,
							:DEB_REG_BLK.eventdate,:DEB_REG_BLK.debnum,
							:DEB_REG_BLK.kv,:DEB_REG_BLK.crdagrnum,:DEB_REG_BLK.crddate,
							:DEB_REG_BLK.summ,
							:DEB_REG_BLK.osn,
						                :DEB_REG_BLK.filename,:DEB_REG_BLK.filedate
						 FROM debreg_blk"
				Set DEB_REG_BLK.strSqlDelete = " UPDATE debreg_query SET errorcode='  -1'
						WHERE phaseid='F' and REQUESTID=:DEB_REG_BLK.requestid "
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On UM_Update
				Set nRow=TBL_MinRow
				While SalTblFindNextRow( DEB_REG_BLK, nRow, ROW_Edited, 0 )
					Call SalTblSetContext( DEB_REG_BLK, nRow)
					If SqlPrepareAndExecute( hSql(),
							  "UPDATE debreg 
							   SET okpo=:DEB_REG_BLK.okpo,
							       nmk =:DEB_REG_BLK.nmk,adr=:DEB_REG_BLK.adr,
							       kv  =:DEB_REG_BLK.kv,crdagrnum=:DEB_REG_BLK.crdagrnum,crddate=:DEB_REG_BLK.crddate,
							       summ=:DEB_REG_BLK.summ
							   WHERE debnum=:DEB_REG_BLK.debnum") 
							and SqlPrepareAndExecute( hSql(),
							   "UPDATE debreg_query 
							    SET errorcode=:DEB_REG_BLK.errorcode,
							        eventtype=:DEB_REG_BLK.eventtype,
							        eventdate=:DEB_REG_BLK.eventdate
							    WHERE debnum=:DEB_REG_BLK.debnum AND requestid=:DEB_REG_BLK.requestid")
						Call SqlCommit(hSql())
					Else
						Call SqlRollback(hSql())
				Call SalSendClassMessage( UM_Update, 0, 0 )
	Table Window: DEB_REG_MIRROR
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: 2. Дзеркало Реєстру
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
				Width:  14.8"
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
			Maximum Rows in Memory: 30000
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
					Resource Id: 65400
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  3.1"
						Begin Y:  Class Default
						End X:  3.1"
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
						Left:   0.6"
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
						Left:   1.033"
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
						Left:   1.467"
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
						Left:   1.9"
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
					Resource Id: 65401
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  2.433"
						Begin Y:  Class Default
						End X:  2.433"
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
						Left:   2.567"
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
					Resource Id: 65402
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
				Pushbutton: pbSendMirrorRequest
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cTBarButton
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.233"
						Top:    0.071"
						Width:  0.4"
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\QUERY.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Поновити ЗЕРКАЛО РЕЄСТРУ з ЦБД'
						On SAM_Click
							Set DEB_REG_MIRROR.nQueryType = 
									    SalModalDialog(DEB_REG_GETQUERYTYPE,DEB_REG_MIRROR)
							If DEB_REG_MIRROR.nQueryType != 0
								If SqlPrepareAndExecute(hSql(),
										  "INSERT INTO DEBREG_QUERY (REQUESTID,	QUERYTYPE, PHASEID) 
										          VALUES (0,:DEB_REG_MIRROR.nQueryType,'Q')") 
									Call SqlCommit(hSql())
								Else
									Call SqlRollback(hSql())
				Pushbutton: pbDelAll
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cTBarButton
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.933"
						Top:    0.071"
						Width:  0.4"
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
							Set strTip = 'Вилучити всю нашу інформацію з ЦБД'
						On SAM_Click
							Set DEB_REG_MIRROR.nEvtType = 
									    SalModalDialog(DEB_REG_DELALL,DEB_REG_MIRROR)
							If DEB_REG_MIRROR.nEvtType != 0
								If SqlPrepareAndExecute(hSql(),
										  "INSERT INTO DEBREG_QUERY (REQUESTID, EVENTTYPE, EVENTDATE, PHASEID )
											  VALUES (0, :DEB_REG_MIRROR.nEvtType,	SYSDATE,'R' )"	)
									Call SqlCommit(hSql())
								Else
									Call SqlRollback(hSql())
		Contents
			Column: REQUESTID
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ид
						запроса
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  0.883"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Title: Ід. код 
						клієнта
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  0.917"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: NMK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Назва 
						клієнта
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.117"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: CUSTTYPE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ознака
						клієнта
						0-Фіз.
						1-Юр.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  0.767"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: REZID
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Р
						е
						з
						и
						д
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
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
			Column: EVENTTYPE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Тип останньої 
						події : 
						1-внесено 
						2 -змінено 
						3-погашено
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.317"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: EVENTDATE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата 
						останньої 
						події
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Left
				Width:  0.917"
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
			Column: DEBNUM
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Номер 
						простроченої 
						заборгованості
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.417"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
						вал.
						
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  0.483"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: CRDAGRNUM
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Номер 
						кредитної 
						угоди
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.117"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: CRDDATE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата 
						надання 
						кредиту
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Left
				Width:  0.85"
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
			Column: SUMM
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сума 
						простроченої 
						заборгованості 
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.617"
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
			Column: DEBDATE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата 
						виникнення 
						простроченої 
						заборгов.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Left
				Width:  1.217"
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
			Column: REGDATETIME
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата та час 
						занесення в 
						БД реєстру 
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Left
				Width:  1.217"
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
			Column: FILENAME
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Назва файлу 
						типу F, в якому 
						надійшла 
						інформація
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
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
			Column: ADR
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Адреса 
						клієнта
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
			Column: OSN
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дані 
						про керівників 
						та засновників
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.783"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
			String: sPar_
			Number: nTipKl
		Window Variables
			Number: nQueryType
			Number: nEvtType
		Message Actions
			On SAM_Create
				Set DEB_REG_MIRROR.nTabInstance = 1
				Call SetWindowFullSize(hWndForm)
				Set DEB_REG_MIRROR.strFilterTblName = 'DEB_REG_MIRROR'
				Set DEB_REG_MIRROR.strPrintFileName = 'DEBREG_S.txt'
				Set DEB_REG_MIRROR.strSqlPopulate =
							"SELECT
								DEBREG_RES_S.REQUESTID,
								DEBREG_RES_S.OKPO,
								DEBREG_RES_S.NMK,
								DEBREG_RES_S.ADR,
								DEBREG_RES_S.CUSTTYPE,
								DEBREG_RES_S.REZID,
								DEBREG_RES_S.EVENTTYPE,
								DEBREG_RES_S.EVENTDATE,
								DEBREG_RES_S.DEBNUM,
								DEBREG_RES_S.KV,
								DEBREG_RES_S.CRDAGRNUM,
								DEBREG_RES_S.CRDDATE,
								DEBREG_RES_S.SUMM/100,
								DEBREG_RES_S.DEBDATE,
								DEBREG_RES_S.REGDATETIME,
								DEBREG_RES_S.FILENAME,
						                DEBREG_RES_S.OSN
							 INTO
								:DEB_REG_MIRROR.REQUESTID,
								:DEB_REG_MIRROR.OKPO,
								:DEB_REG_MIRROR.NMK,
								:DEB_REG_MIRROR.ADR,
								:DEB_REG_MIRROR.CUSTTYPE,
								:DEB_REG_MIRROR.REZID,
								:DEB_REG_MIRROR.EVENTTYPE,
								:DEB_REG_MIRROR.EVENTDATE,
								:DEB_REG_MIRROR.DEBNUM,
								:DEB_REG_MIRROR.KV,
								:DEB_REG_MIRROR.CRDAGRNUM,
								:DEB_REG_MIRROR.CRDDATE,
								:DEB_REG_MIRROR.SUMM,
								:DEB_REG_MIRROR.DEBDATE,
								:DEB_REG_MIRROR.REGDATETIME,
								:DEB_REG_MIRROR.FILENAME,
						                :DEB_REG_MIRROR.OSN
							 FROM DEBREG_RES_S "|| IifS( nTipKl >=0, " WHERE DEBREG_RES_S.CUSTTYPE="||Str(nTipKl), " " ) 
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On UM_Populate
				Call SalWaitCursor(TRUE)
				Call SalTblDefineSplitWindow(hWndForm, 0, FALSE)
				Call SalTblPopulate(hWndForm, hSql(), DEB_REG_MIRROR.strSqlPopulate, TBL_FillAll)
				Call SalTblSetContext(hWndForm, 0)
				Call SalPostMsg(hWndForm, SAM_TblDoDetails, 0, 0)
				Call SalWaitCursor(FALSE)
	Dialog Box: DEB_REG_GETQUERYTYPE
		Class:
		Property Template:
		Class DLL Name:
		Title: Отримати з ЦБД
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   3.875"
				Top:    3.375"
				Width:  6.667"
				Width Editable? Yes
				Height: 1.619"
				Height Editable? Yes
			Absolute Screen Location? No
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
			Pushbutton: pbDRGQT_OK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbOk
				Property Template:
				Class DLL Name:
				Title: Підтвердити 
				Window Location and Size
					Left:   2.783"
					Top:    0.738"
					Width:  1.7"
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
						If rbDRGQT_DEBRECS
							Call SalEndDialog(DEB_REG_GETQUERYTYPE,1)
						Else If rbDRGQT_ALLRECS
							Call SalEndDialog(DEB_REG_GETQUERYTYPE,2)
						Else
							Call SalEndDialog(DEB_REG_GETQUERYTYPE,0)
			Pushbutton: pbDRGQT_CANCEL
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title: вийти
				Window Location and Size
					Left:   4.683"
					Top:    0.738"
					Width:  1.7"
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
						Call SalEndDialog(DEB_REG_GETQUERYTYPE,0)
			Radio Button: rbDRGQT_DEBRECS
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Тільки непогашені заборгованості
				Window Location and Size
					Left:   0.183"
					Top:    0.071"
					Width:  6.2"
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
			Radio Button: rbDRGQT_ALLRECS
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Всі заборгованості
				Window Location and Size
					Left:   0.183"
					Top:    0.405"
					Width:  6.2"
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
		Functions
		Window Parameters
		Window Variables
		Message Actions
			On SAM_Create
				Set rbDRGQT_DEBRECS = FALSE
				Set rbDRGQT_ALLRECS = TRUE
	Dialog Box: DEB_REG_DELALL
		Class:
		Property Template:
		Class DLL Name:
		Title: Вимога до ЦБД
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   4.175"
				Top:    3.438"
				Width:  6.667"
				Width Editable? Yes
				Height: 1.607"
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
			Pushbutton: pbDRDA_CANCEL
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title: відмінити
				Window Location and Size
					Left:   4.983"
					Top:    0.738"
					Width:  1.4"
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
						Call SalEndDialog(DEB_REG_DELALL,0)
			Pushbutton: pbDRDA_OK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbOk
				Property Template:
				Class DLL Name:
				Title: Підтвердити
				Window Location and Size
					Left:   3.383"
					Top:    0.738"
					Width:  1.4"
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
						If rbDRDA_DELALL
							Call SalEndDialog(DEB_REG_DELALL,4)
						Else If rbDRDA_DEBOFFALL
							Call SalEndDialog(DEB_REG_DELALL,3)
						Else
							Call SalEndDialog(DEB_REG_DELALL,0)
			Radio Button: rbDRDA_DELALL
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Вилучити всю "нашу" інформацію з ЦБД
				Window Location and Size
					Left:   0.183"
					Top:    0.071"
					Width:  6.2"
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
			Radio Button: rbDRDA_DEBOFFALL
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Погасити всю "нашу" заборгованість в ЦБД
				Window Location and Size
					Left:   0.183"
					Top:    0.405"
					Width:  6.2"
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
		Functions
		Window Parameters
		Window Variables
		Message Actions
			On SAM_Create
				Set rbDRDA_DELALL = TRUE
				Set rbDRDA_DEBOFFALL = FALSE
	Dialog Box: dlgAskStartMode
		Class:
		Property Template:
		Class DLL Name:
		Title: Просроченные процентные активы
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  4.75"
				Width Editable? Yes
				Height: 2.345"
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
			Radio Button: rbDoNotRefresh
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Не обновлять данные Реестра
				Window Location and Size
					Left:   0.283"
					Top:    0.155"
					Width:  3.0"
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
			Radio Button: rbRefresh
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Обновить данные Реестра
				Window Location and Size
					Left:   0.283"
					Top:    0.488"
					Width:  3.0"
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
			Pushbutton: pbOk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbOk
				Property Template:
				Class DLL Name:
				Title: Продолжить
				Window Location and Size
					Left:   1.083"
					Top:    1.405"
					Width:  1.5"
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
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
						If rbDoNotRefresh
							Call SalEndDialog(dlgAskStartMode,1)
						Else
							Call SalEndDialog(dlgAskStartMode,2)
			Pushbutton: pbCancel
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   2.883"
					Top:    1.405"
					Width:  1.5"
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
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
						Call SalEndDialog(dlgAskStartMode,0)
			Background Text: В режиме обновления данных все записи введенные "вручную" будут потеряны.
				Resource Id: 28957
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.283"
					Top:    0.845"
					Width:  4.1"
					Width Editable? Yes
					Height: 0.393"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
		Functions
		Window Parameters
		Window Variables
		Message Actions
			On SAM_Create
				Set rbDoNotRefresh=TRUE
				Set rbRefresh=FALSE
				Call SalCenterWindow(dlgAskStartMode)
	Table Window: TA
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Додаткові дані (не з обліку в АБС )
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
				Left:   0.825"
				Top:    0.688"
				Width:  12.9"
				Width Editable? Class Default
				Height: Class Default
				Height Editable? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: Class Default
			Text Color: Class Default
			Background Color: Default
			View: Class Default
			Allow Row Sizing? Class Default
			Lines Per Row: Class Default
		Memory Settings
			Maximum Rows in Memory: 30000
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
					Resource Id: 51094
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
					Resource Id: 51095
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
						Left:   4.683"
						Top:    0.083"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
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
					Resource Id: 51096
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
				Pushbutton: pbSend
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbGetValue
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
					Picture File Name: \BARS98\RESOURCE\BMP\Arr1tor.bmp
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Поновити реест боржників для передачі в ЦБД'
						On SAM_Click
							! Пока без подписи // Инициализация подписи
							! If CustomerSign.InitSign()
							Set nRow = TBL_MinRow
							Set bOk=FALSE
							While SalTblFindNextRow( hWndForm, nRow, ROW_Selected, 0 )
								Call SalTblSetContext( hWndForm, nRow )
								If SqlPLSQLCommand( hSql(),"BARS.DR.REFRESH_DEBREG
										  (ACC,ADR,CRDAGRNUM,CRDDATE,CUSTTYPE,KV,NMK,OKPO,PRINSIDER,SUM,REZID,DEBDATE,OSN)")
									Set bOk = TRUE
								Else
									Set bOk = FALSE
								! If EVENTTYPE =1
									                      Set bOk =
											SqlPrepareAndExecute( hSql(),
											 "INSERT INTO DEBREG (DEBNUM,ADR, CRDAGRNUM, CRDDATE ,CUSTTYPE ,
											     KV,NMK,OKPO, PRINSIDER, SUMM, REZID,DEBDATE,OSN )
											  VALUES (:ACC,:ADR,:CRDAGRNUM, :CRDDATE, :CUSTTYPE,
											    :KV,:NMK,:OKPO,:PRINSIDER,:SUM, :REZID,:DEBDATE,:OSN )" )
								! Else
									                      Set bOk =
											SqlPrepareAndExecute( hSql(),
											 "UPDATE DEBREG set ADR=:ADR,   SUMM=:SUM, 
											                    crddate=:CRDDATE,
											                    CRDAGRNUM=:CRDAGRNUM ,
											                    debdate  =:DEBDATE,
											                    OSN = :OSN 
											  WHERE DEBNUM=:ACC" )
								! Здесь подпись строки в DEBREG_QUERY ключ связи DEBNUM
								If bOk
									Set bOk =
											SqlPrepareAndExecute( hSql(),
											  "INSERT INTO DEBREG_QUERY
											   (requestid,debnum,EVENTDATE,EVENTTYPE,PHASEID)
											   VALUES (0,:ACC,:EVENTDATE,:EVENTTYPE,'F') ")
							If bOk
								Call SqlCommit(hSql())
								Call MessageInfoEx('Готово.')
							Else
								Call SqlRollback( hSql() )
							Call SalWaitCursor( FALSE )
							! Call SalSendMsg( pbExit, SAM_Click, 0, 0 )
		Contents
			Column: ACC
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						строки
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  0.75"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: NMK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Назва 
						позичальника - 
						боржника
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.817"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
						If EVENTTYPE = NUMBER_Null
							Set EVENTTYPE =1
			Column: OKPO
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ЗКПО
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
				Width:  1.15"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: REZID
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Р
						е
						з
						и
						д
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  0.4"
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
						Uncheck Value: 2
						Ignore Case? Yes
				List Values
				Message Actions
			Column: CUSTTYPE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Т
						и
						п
				Visible? Yes
				Editable? Yes
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
						Vertical Scroll? No
						Auto Drop Down? No
						Allow Text Editing? No
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: CRDAGRNUM
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: № угоди
						
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 16
				Data Type: String
				Justify: Left
				Width:  1.117"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: CRDDATE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						видачі 
						кредиту
				Visible? Yes
				Editable? Yes
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
			Column: KV
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Вал
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 3
				Data Type: Number
				Justify: Center
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
						Allow Text Editing? No
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: SUM100
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сума
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.517"
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
						Set SUM = SUM100 * 100
			Column: DEBDATE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						виникнення
						просроч.
						боргу
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.117"
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
			Column: DAY
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Д
						н
						і
						в
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
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
			Column: EVENTTYPE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: 1-новий
						2-зміна
						3-погашено
						4-вилучити
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
				Width:  1.033"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
						Set EVENTTYPE_ = EVENTTYPE
					On SAM_Validate
						If EVENTTYPE !=4
							Set EVENTTYPE = EVENTTYPE_
			Column: EVENTDATE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						події
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Left
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
			Column: SUM
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма
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
			Column: PRINSIDER
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Ін
						сай
						дер
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 99
				Data Type: Number
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
			Column: ADR
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Адреса
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.35"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: OSN
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Директор/Засновник
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.933"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
			String: sPar_
			Number: nTipKl
		Window Variables
			Number: EVENTTYPE_
			Number: nSUMM
			Boolean: bOk
			Number: nETYPE
		Message Actions
			On SAM_Create
				Set TA.nTabInstance = 1
				Call SalMapEnterToTab( TRUE )
				Set TA.strPrintFileName = 'TA'
				Set TA.nTabInstance = 1
				Call SetWindowFullSize(hWndForm)
				Set TA.strSqlPopulate =
						"SELECT EVENTTYPE, acc, OKPO, NMK, ADR, CUSTTYPE, PRINSIDER, KV, CRDAGRNUM,
						        CRDDATE, SUM, DEBDATE,  DAY, rezid, SUM/100, OSN, eventdate
						 INTO  :TA.EVENTTYPE, :TA.ACC, :TA.OKPO, :TA.NMK, :TA.ADR, :TA.CUSTTYPE, :TA.PRINSIDER,
						       :TA.KV, :TA.CRDAGRNUM, :TA.CRDDATE, :TA.SUM, :TA.DEBDATE, :TA.DAY,:TA.REZID, :TA.SUM100,
						       :TA.OSN, :TA.EVENTDATE
						 FROM deb_reg_man 
						 WHERE " || IifS( nTipKl >= 0, "CUSTTYPE="||Str(nTipKl), " ") || "
						 ORDER BY CUSTTYPE, OKPO "
				Set TA.strSqlDelete ="DELETE FROM deb_reg_man where acc=:TA.ACC and acc <0"
				Set TA.strSqlUpdate =
						"UPDATE deb_reg_man  
						 SET EVENTTYPE=:TA.EVENTTYPE, REZID  =:TA.REZID,   OKPO=:TA.OKPO, ADR=:TA.ADR, KV =:TA.KV ,
						     PRINSIDER=:TA.PRINSIDER, DEBDATE=:TA.DEBDATE, NMK =:TA.NMK,  SUM=:TA.SUM, DAY=:TA.DAY,
						     CRDAGRNUM=:TA.CRDAGRNUM, CRDDATE=:TA.CRDDATE, CUSTTYPE=:TA.CUSTTYPE,
						     OSN=:TA.OSN,
						     eventdate=:TA.EVENTDATE
						 WHERE acc=:TA.ACC"
				Set TA.strSqlInsert =
						"INSERT INTO deb_reg_man  (EVENTTYPE, REZID, OKPO,ADR,KV,    PRINSIDER,    DEBDATE,
						     NMK, SUM, DAY, CRDAGRNUM, CRDDATE, CUSTTYPE, acc, osn, eventdate ) 
						 VALUES (1,:hWndForm.TA.REZID,:hWndForm.TA.OKPO,:hWndForm.TA.ADR,:hWndForm.TA.KV,:hWndForm.TA.PRINSIDER,:hWndForm.TA.DEBDATE,
						 :hWndForm.TA.NMK, :hWndForm.TA.SUM, :hWndForm.TA.DAY,:hWndForm.TA.CRDAGRNUM, :hWndForm.TA.CRDDATE, :hWndForm.TA.CUSTTYPE,:hWndForm.TA.ACC, 
						 :hWndForm.TA.OSN, :hWndForm.TA.EVENTDATE) "
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On SAM_FetchRowDone
				If 1=EVENTTYPE
					Call SetTblRowColor( TA, COLOR_Red )
				If SqlPrepareAndExecute(hSqlAux(), 
						'SELECT summ INTO :nSUMM FROM debreg_res_s WHERE debnum=:TA.ACC' )
						= FALSE
					Call SaveErrorToLog( 'Ошибка при обращении к зеркалу реестра (ручной ввод)' )
					Return FALSE
				If SqlFetchNext( hSqlAux(), nFetchRes ) = FALSE
					! строку в зеркале не нашли ==> выходим
					Return FALSE
				If FETCH_Ok = nFetchRes
					Call SetTblRowColor( TA, COLOR_Black )
