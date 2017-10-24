Application Description: ! ///////////////////////////////////////////////
		! TECHSRV.APL - сервисные функции Технолога банка
		! ООО Унити-Барс  (C)  1996-1999
		! Разработчик: Костров С.В., Сыропоршнев Д.Л.
		! ///////////////////////////////////////////////
	Outline Version - 4.0.26
	Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000A10000 002C000000020000 0003000000A00000 00B1010000F8FFFF
0040: FFE2FFFFFFFFFFFF FF000000007C0200 004D010000010000 0000000000010000
0060: 000F4170706C6963 6174696F6E497465 6D00000000
.enddata
.data DT_MAKERUNDLG
0000: 0200000000001951 3A5C424152533938 5C42494E5C736572 766963652E646C6C
0020: 19513A5C42415253 39385C42494E5C73 6572766963652E61 706300000101011D
0040: 513A5C4241525339 385C4C4942524152 595C736572766963 652E72756E1D513A
0060: 5C4241525339385C 4C4942524152595C 736572766963652E 646C6C1D513A5C42
0080: 41525339385C4C49 42524152595C7365 72766963652E6170 630000010101175C
00A0: 4241525339385C42 494E5C7465636873 72762E617064175C 4241525339385C42
00C0: 494E5C7465636873 72762E646C6C175C 4241525339385C42 494E5C7465636873
00E0: 72762E6170630000 010101001D513A5C 4241525339385C4C 4942524152595C73
0100: 6572766963652E64 6C6C1D513A5C4241 525339385C4C4942 524152595C736572
0120: 766963652E617063 0000010101
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
0000: 0118B80BB80B2500
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
		! Dynalib: Bankapi.apd
		Dynalib: Service.apd
		!
		File Include: Constant.apl
		File Include: Genbutn.apl
		File Include: Winbars2.apl
		File Include: Vtmeter.apl
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
			Date/Time: dd/MM/yyyy
		External Functions
		Constants
.data CCDATA
0000: 3000000000000000 0000000000000000 00000000
.enddata
.data CCSIZE
0000: 1400
.enddata
			System
				! Number: AM_MtrMove = SAM_User + 150
			User
				String: MSG_Q_R_U_Sure = 'Вы уверены во внесенных изменениях?'
				String: MSG_Q_R_U_Sure_Again = 'Вы действительно хотите сохранить изменения? '
				!
				String: MSG_PSDangerWarn = 'Необоснованное или некорректное изменение может привести к остановке платежной системы!'
				!
				String: MSG_AuditKSequenceP1 = 'Изменен порядковый номер очередного К-файла для '
				String: MSG_AuditKSequenceP2 = ' на номер '
				!
				String: MSG_VerbLock2 = 'Блокировать '
				String: MSG_VerbUnLock2 = 'Разблокировать '
				String: MSG_Q_StartDirLock2 = '"начальные" для подчиненных РП?'
				String: MSG_Q_KFilesProcess2 = 'Формировать файлы "K" на участников СЭП?'
				String: MSG_Q_BackDirLock2 = '"ответные" для подчиненных РП?'
				String: MSG_Q_AllDirLock2 = 'все направления для подчиненных РП?'
		Resources
		Variables
			! //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			!
			Number: nFetchRes
			!
		Internal Functions
			Function: ShowChangeModeSign	! __exported
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
					Call SalModalDialog( dlg_ChangeModeSign, hWndForm )
			Function: ShowChangeKeyAccount	! __exported
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
					! //////////////////////////////////////////////////////////////////////////////////////////////////////////////
					!
					If ShowInputPassword() = FALSE
						Return FALSE
					!
					Call SalModalDialog( dlg_ChangeKeyAccount, hWndForm )
					!
					! //////////////////////////////////////////////////////////////////////////////////////////////////////////////
			Function: ShowInfSequenceFileK	! __exported
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
					Call SalModalDialog( dlg_InfSequenceFileK, hWndForm )
			Function: ShowSetTechFlags	! __exported
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
					Call SalModalDialog( dlg_SetTechFlags, hWndForm )
			Function: ShowSendMessage	! __exported
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
					Call SalModalDialog( dlg_SendMessage, hWndForm )
			Function: ShowExportAccounts	! __exported
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
					Call SalModalDialog( dlg_ExportAccounts, hWndForm )
			Function: ShowDirection		! __exported
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
					Call SalModalDialog( dlg_Direction, hWndForm )
			Function: CreateFlagFile	! __exported
				Description: создать флаг-файл для процессинга
				Returns
					Boolean:
				Parameters
					String: strFlagDir
					String: strFlag
				Static Variables
				Local variables
					File Handle: hFile
				Actions
					If SalFileOpen( hFile, strFlagDir || '\\' || strFlag, OF_Binary | OF_Create )
						Call SalFileClose( hFile )
						Return TRUE
					Else
						Return FALSE
			!
			Function: CreateMessageFile
				Description:
				Returns
					Boolean:
				Parameters
					String: strSabCode
					Long String: strMessage
				Static Variables
				Local variables
					File Handle: hFile
					String: strMsgDirEx
					String: strBkpMsgDirEx
				Actions
					Call WaitCursorOn()
					!
					Set strMsgDirEx = GetMsgDir() || FILE_MSG() || strSabCode || Sep98md(GetBankDate())||'.' || GetCurrentHmm()
					Set strBkpMsgDirEx = GetDir() || '\\Messages\\' || 
							                     SalFmtFormatDateTime( SalDateCurrent(), 'yyMMdd' )
					!
					Call SalFileCreateDirectory( GetDir() || '\\Messages' )
					Call SalFileCreateDirectory( strBkpMsgDirEx )
					!
					If SalFileOpen( hFile, strMsgDirEx, OF_Text | OF_Create  | OF_ReadWrite )
						Call SalFilePutStr( hFile, StrWinToDosX( strMessage ) )
						Call SalFileClose( hFile )
					Else
						Return MessageError( 'Ошибка создания файла-сообщения в каталоге: ' || strMsgDirEx )
					If SalFileOpen( hFile, strBkpMsgDirEx || '\\' || FILE_MSG() || strSabCode || '.' || GetCurrentHmm(), 
							                       OF_Text | OF_Create  | OF_ReadWrite )
						Call SalFilePutStr( hFile, StrWinToDosX( strMessage ) )
						Call SalFileClose( hFile )
					Else
						Return MessageError( 'Копия файла-сообщения не создана в каталоге: ' || strBkpMsgDirEx )
					!
					Call WaitCursorOff()
					!
					Return TRUE
			!
		Named Menus
		Class Definitions
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
			Child Table: cQuickTable
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
			Custom Control: cCalendarDropDown
		Application Actions
	!
	Dialog Box: dlg_InfSequenceFileK
		Class:
		Property Template:
		Class DLL Name:
		Title: Информация о текущих номерах файлов СЭП K
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? No
			Type of Dialog: Modal
			Window Location and Size
				Left:   0.625"
				Top:    0.625"
				Width:  10.25"
				Width Editable? Yes
				Height: 5.845"
				Height Editable? Yes
			Absolute Screen Location? Yes
			Font Name: MS Sans Serif
			Font Size: 8
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description: Информация о текущих номерах файлов СЭП K
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
			Child Table: tblLklRrp
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Display Settings
					Window Location and Size
						Left:   0.086"
						Top:    0.06"
						Width:  10.0"
						Width Editable? Yes
						Height: 4.75"
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
					Column: colMFO
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: МФО
						Visible? Yes
						Editable? No
						Maximum Data Length: 6
						Data Type: String
						Justify: Right
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
					Column: colNAME
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Наименование банка
						Visible? Yes
						Editable? No
						Maximum Data Length: 35
						Data Type: String
						Justify: Left
						Width:  4.283"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
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
						Class:
						Property Template:
						Class DLL Name:
						Title: Код Валюты
						Visible? No
						Editable? No
						Maximum Data Length: 3
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
					Column: colLCV
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Валюта
						Visible? Yes
						Editable? No
						Maximum Data Length: 3
						Data Type: String
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
					Column: colNUM
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Номер
								файла К
						Visible? Yes
						Editable? Yes
						Maximum Data Length: 3
						Data Type: Number
						Justify: Right
						Width:  0.971"
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
							On SAM_AnyEdit
								! ////////////////////////////////////////////////////////////////////////////////////////////////////////
								!
								Call SalEnableWindow( pbSave )
								!
								! ////////////////////////////////////////////////////////////////////////////////////////////////////////
				Functions
				Window Variables
				Message Actions
					On SAM_Create
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
						!
						Call SalTblPopulate( tblLklRrp, hSql(), T( " SELECT 
								 a.mfo, b.nb, a.kv, v.lcv, a.kn    FROM Lkl_rrp a, Banks b, Tabval v
								   INTO :tblLklRrp.colMFO, :tblLklRrp.colNAME, :tblLklRrp.colKV, :tblLklRrp.colLCV, :tblLklRrp.colNUM
								  WHERE  b.mfo=a.mfo AND b.kodn<>1 AND a.kv=v.kv ORDER BY 1,3" ), TBL_FillNormal )
						!
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
			!
			Pushbutton: pbSave
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbUpdate
				Property Template:
				Class DLL Name:
				Title: Сохранить
				Window Location and Size
					Left:   3.0"
					Top:    4.948"
					Width:  1.5"
					Width Editable? Class Default
					Height: 0.45"
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
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
						!
						If SalTblAnyRows( tblLklRrp, ROW_Edited, 0 )
							If MessageQuestion( MSG_Q_R_U_Sure ) = IDYES
								If MessageQuestion( MSG_Q_R_U_Sure_Again || MSG_PSDangerWarn ) = IDYES
									Call SqlPrepare( hSql(),  T( "UPDATE Lkl_rrp  SET  
											kn = :tblLklRrp.colNUM  WHERE  mfo = :tblLklRrp.colMFO AND kv=:tblLklRrp.colKV" ) )
									If SalTblDoUpdates( tblLklRrp, hSql(), FALSE )
										Call SqlCommitEx( hSql(), 'Установка номеров файлов СЭП K' )
										Set nRow=TBL_MinRow
										While SalTblFindNextRow( tblLklRrp, nRow, ROW_Edited, 0 )
											Call SalTblFetchRow( tblLklRrp, nRow )
											Call SaveInfoToLog( MSG_AuditKSequenceP1 || tblLklRrp.colMFO || MSG_AuditKSequenceP2 || SalNumberToStrX( tblLklRrp.colNUM, 0 ) )
									Else
										Call SqlRollback( hSql() )
									Call SalEndDialog( hWndForm, TRUE )
								Else
									Return FALSE
							Else
								Return FALSE
						Else
							Call SalEndDialog( hWndForm, 0 )
						!
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
			Pushbutton: pbExit
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title: Выход
				Window Location and Size
					Left:   4.586"
					Top:    4.948"
					Width:  1.5"
					Width Editable? Class Default
					Height: 0.45"
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
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
						!
						Call SalEndDialog( hWndForm, FALSE )
						!
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
			!
			Frame
				Resource Id: 1043
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.086"
					Top:    4.881"
					Width:  10.0"
					Width Editable? Yes
					Height: 0.583"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Border Color: 3D Shadow Color
				Background Color: 3D Face Color
		Functions
		Window Parameters
		Window Variables
			Number: nRow
		Message Actions
			On SAM_Create
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				!
				Call PrepareWindow( hWndForm )
				!
				Call SalDisableWindow( pbSave )
				Call SalSetFocus( pbExit )
				!
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			On SAM_CreateComplete
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				!
				Call WaitCursorOff()
				!
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			On SAM_Destroy
				! Disactivation call function' role
				If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
					Call XRoleUnset(hSql(), ' ShowInfSequenceFileK() ' )
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				!
				Call WaitCursorOff()
				!
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	Dialog Box: dlg_ChangeModeSign
		Class:
		Property Template:
		Class DLL Name:
		Title: Изменение режима ЭЦП НБУ
		Accesories Enabled? Yes
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? No
			Type of Dialog: Modal
			Window Location and Size
				Left:   1.588"
				Top:    1.646"
				Width:  4.586"
				Width Editable? Yes
				Height: 2.135"
				Height Editable? Yes
			Absolute Screen Location? Yes
			Font Name: MS Sans Serif
			Font Size: 8
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description: Изменение режима ЭЦП НБУ
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
			! //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			!
			Radio Button: rbMode1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: "мягкий" режим ЭЦП
				Window Location and Size
					Left:   0.514"
					Top:    0.167"
					Width:  3.371"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
				Message Actions
			Radio Button: rbMode2
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: "жесткий" режим ЭЦП
				Window Location and Size
					Left:   0.514"
					Top:    0.464"
					Width:  3.371"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
				Message Actions
			!
			Pushbutton: pbAccept
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbOk
				Property Template:
				Class DLL Name:
				Title: Сохранить
				Window Location and Size
					Left:   0.371"
					Top:    1.0"
					Width:  1.5"
					Width Editable? Class Default
					Height: 0.45"
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
					On SAM_SetFocus
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
						!
						Call SalStatusSetText( hWndForm, 'Установить режим ЭЦП НБУ' )
						!
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
					On SAM_Click
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
						!
						If MessageQuestion( 'Установить выбранный режим ЭЦП НБУ?' ) = IDYES
							If rbMode1=TRUE
								Call PutGlobalOption( 'SOFTSIGN', '0' )
							If rbMode2=TRUE
								Call PutGlobalOption( 'SOFTSIGN', '1' )
							!
							Call SqlCommitEx( hSql(), 'Установка режима ЭЦП НБУ' )
							!
							Call SalEndDialog( hWndForm, TRUE )
						!
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
			Pushbutton: pbExit
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title: Выход
				Window Location and Size
					Left:   2.586"
					Top:    1.0"
					Width:  1.5"
					Width Editable? Class Default
					Height: 0.45"
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
					On SAM_SetFocus
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
						!
						Call SalStatusSetText( hWndForm, 'Завершить работу с диалогом' )
						!
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
					On SAM_Click
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
						!
						Call SalEndDialog( hWndForm, FALSE )
						!
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
			!
			Frame
				Resource Id: 50778
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.043"
					Top:    0.031"
					Width:  4.4"
					Width Editable? Yes
					Height: 0.833"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Border Color: 3D Shadow Color
				Background Color: 3D Face Color
			Frame
				Resource Id: 50779
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.043"
					Top:    0.917"
					Width:  4.4"
					Width Editable? Yes
					Height: 0.607"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Border Color: 3D Shadow Color
				Background Color: 3D Face Color
			!
			! //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		Functions
		Window Parameters
		Window Variables
		Message Actions
			On SAM_Create
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				!
				Call PrepareWindowEx( hWndForm )
				!
				If ShowInputPassword() = FALSE
					Return SalEndDialog( hWndForm, FALSE )
				!
				Call WaitCursorOn()
				Call SalSetFocus( pbExit )
				!
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			On SAM_CreateComplete
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				!
				Call WaitCursorOff()
				!
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			On SAM_Destroy
				! Disactivation call function' role
				If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
					Call XRoleUnset(hSql(), ' ShowChangeModeSign() ' )
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				!
				Call WaitCursorOff()
				!
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	Dialog Box: dlg_ChangeKeyAccount
		Class:
		Property Template:
		Class DLL Name:
		Title: Пересчет контрольного разряда лицевых счетов
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? No
			Type of Dialog: Modal
			Window Location and Size
				Left:   1.263"
				Top:    0.51"
				Width:  10.817"
				Width Editable? Yes
				Height: 5.667"
				Height Editable? Yes
			Absolute Screen Location? Yes
			Font Name: MS Sans Serif
			Font Size: 8
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description: Пересчет контрольного разряда лицевых счетов
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
			Child Table: tblAccounts
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Display Settings
					Window Location and Size
						Left:   0.063"
						Top:    0.042"
						Width:  10.567"
						Width Editable? Yes
						Height: 4.583"
						Height Editable? Yes
					Visible? Yes
					Font Name: Default
					Font Size: 8
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					View: Table
					Allow Row Sizing? Yes
					Lines Per Row: Default
				Memory Settings
					Maximum Rows in Memory: 65535
					Discardable? No
				Contents
					Column: colACC
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Внутренний
								номер счета
						Visible? No
						Editable? No
						Maximum Data Length: 5
						Data Type: Number
						Justify: Right
						Width:  1.2"
						Width Editable? Yes
						Format: 0
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colOLDACC
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Cчет старый
						Visible? Yes
						Editable? No
						Maximum Data Length: 20
						Data Type: String
						Justify: Right
						Width:  1.733"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colNEWACC
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Счет новый
						Visible? Yes
						Editable? No
						Maximum Data Length: 20
						Data Type: String
						Justify: Right
						Width:  1.75"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colNMS
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Наименование счета
						Visible? Yes
						Editable? No
						Maximum Data Length: 70
						Data Type: String
						Justify: Left
						Width:  6.4"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
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
					On SAM_Create
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
						!
						Call WaitCursorOn()
						Call SalTblPopulate( tblAccounts, hSql(), T("SELECT 
								acc,  trim(nls), nms FROM Accounts INTO :tblAccounts.colACC, 
								 :tblAccounts.colOLDACC, :tblAccounts.colNMS
								  WHERE nls IS NOT NULL And nls <>0 ORDER BY acc" ), TBL_FillAll )
						Call WaitCursorOff()
						!
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
					On SAM_CreateComplete
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
						!
						Call WaitCursorOn()
						!
						Set nRow=TBL_MinRow
						!
						While SalTblFindNextRow( tblAccounts, nRow, 0, 0 )
							Call SalTblFetchRow( tblAccounts, nRow )
							!
							Set tblAccounts.colNEWACC=KeyAccount( SalStrTrimX(strBankMfo), SalStrTrimX(colOLDACC) )
							!
							If tblAccounts.colOLDACC != tblAccounts.colNEWACC
								Call SalTblSetRowFlags( tblAccounts, nRow, ROW_Edited, TRUE )
								Call SalEnableWindow( pbSave )
						!
						Call WaitCursorOff()
						!
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
					On SAM_Destroy
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
						!
						Call WaitCursorOff()
						!
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
			!
			Pushbutton: pbSave
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbUpdate
				Property Template:
				Class DLL Name:
				Title: Сохранить
				Window Location and Size
					Left:   2.643"
					Top:    4.771"
					Width:  1.5"
					Width Editable? Class Default
					Height: 0.45"
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
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
						!
						If MessageQuestion( 'Выполнить пересчет Контрольных разрядов лицевых счетов?' ) = IDNO
							Return FALSE
						!
						Set nRow=TBL_MinRow
						!
						Call SqlIsolationExclusive( hSql() )
						Call WaitCursorOn()
						!
						While SalTblFindNextRow( tblAccounts, nRow, 0, 0 )
							Call SalTblFetchRow( tblAccounts, nRow )
							!
							If tblAccounts.colOLDACC != tblAccounts.colNEWACC AND tblAccounts.colNEWACC != ''
								If SqlPrepareAndExecute( hSql(), T("UPDATE Accounts 
										SET nls = :tblAccounts.colNEWACC 
										 WHERE acc=:tblAccounts.colACC")  ) 
									If SqlCommitEx( hSql(), 'Пересчет контрольного разряда лицевого счета: ' || tblAccounts.colNEWACC ) = FALSE
										Call SqlRollback( hSql() )
										Call SqlIsolationNormal( hSql() )
										Return MessageError( 'Ошибка пересчета контрольного разряда лицевого счета: ' || tblAccounts.colOLDACC )
								Else
									Call SqlRollback( hSql() )
						Call SqlIsolationNormal( hSql() )
						Call SalDisableWindow( pbSave )
						!
						Call SalSendMsg( tblAccounts, SAM_Create, 0, 0 )
						Call SalSendMsg( tblAccounts, SAM_CreateComplete, 0, 0 )
						!
						Call WaitCursorOff()
						!
						Call MessageInfo( 'Пересчет контрольных разрядов лицевых счетов успешно выполнен!' )
						!
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
			Pushbutton: pbExit
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title: Выход
				Window Location and Size
					Left:   6.814"
					Top:    4.771"
					Width:  1.5"
					Width Editable? Class Default
					Height: 0.45"
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
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
						!
						Call SalEndDialog( hWndForm, FALSE )
						!
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
			!
			Frame
				Resource Id: 45180
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.083"
					Top:    4.69"
					Width:  10.55"
					Width Editable? Yes
					Height: 0.619"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Border Color: 3D Shadow Color
				Background Color: 3D Face Color
		Functions
		Window Parameters
		Window Variables
			Number: nRow
			String: strBankMfo
			String: strOldAccount
		Message Actions
			On SAM_Create
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				!
				Call PrepareWindow( hWndForm )
				!
				Call SalDisableWindow( pbSave )
				Call SalSetFocus( pbExit )
				!
				Set strBankMfo=SalStrTrimX(GetBankMfo())
				!
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			On SAM_CreateComplete
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				!
				Call WaitCursorOff()
				!
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			On SAM_Destroy
				! Disactivation call function' role
				If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
					Call XRoleUnset(hSql(), ' ShowShangeKeyAccount() ' )
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				!
				Call WaitCursorOff()
				!
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	Dialog Box: dlg_SetTechFlags
		Class:
		Property Template:
		Class DLL Name:
		Title: Технологические флаги СЭП
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? No
			Type of Dialog: Modal
			Window Location and Size
				Left:   0.625"
				Top:    0.625"
				Width:  9.071"
				Width Editable? Yes
				Height: 5.0"
				Height Editable? Yes
			Absolute Screen Location? Yes
			Font Name: MS Sans Serif
			Font Size: 8
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
			Radio Button: rbK0
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сформировать файлы "K0"
				Window Location and Size
					Left:   0.214"
					Top:    0.167"
					Width:  4.85"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
				Message Actions
			Radio Button: rbPauseInt
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Пауза Файл-процессингу ( ВПС )
				Window Location and Size
					Left:   0.183"
					Top:    0.524"
					Width:  4.85"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
				Message Actions
			Radio Button: rbPauseExt
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Пауза Файл-процессингу ( НБУ )
				Window Location and Size
					Left:   0.183"
					Top:    0.844"
					Width:  4.85"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
				Message Actions
			Radio Button: rbIpsInt
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сформировать запрос в ИПС ( ВПС )
				Window Location and Size
					Left:   0.183"
					Top:    1.208"
					Width:  4.85"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
				Message Actions
			Radio Button: rbIpsExt
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сформировать запрос в ИПС ( НБУ )
				Window Location and Size
					Left:   0.183"
					Top:    1.488"
					Width:  4.85"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
				Message Actions
			Radio Button: rbVall
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сформировать файлы-выписки "V"
				Window Location and Size
					Left:   0.183"
					Top:    1.845"
					Width:  4.85"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
				Message Actions
			Radio Button: rbVbank
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сформировать файл-выписки "V" банка
				Window Location and Size
					Left:   0.183"
					Top:    2.131"
					Width:  4.35"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
				Message Actions
			Radio Button: rbZ
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сформировать файл "Z" для НБУ ( ГРЦ )
				Window Location and Size
					Left:   0.183"
					Top:    2.56"
					Width:  4.85"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
				Message Actions
			Radio Button: rbZ3
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сформировать файл "Z3" 
				Window Location and Size
					Left:   0.186"
					Top:    3.01"
					Width:  4.85"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
				Message Actions
			Radio Button: rbLimits
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сформировать файлы-лимиты для филиалов по 1ой модели
				Window Location and Size
					Left:   0.183"
					Top:    3.49"
					Width:  7.343"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
				Message Actions
			Pushbutton: pbSetFlag
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbExecute
				Property Template:
				Class DLL Name:
				Title: Выполнить
				Window Location and Size
					Left:   1.771"
					Top:    4.01"
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
						If rbZ
							Set strFlag = FILE_Z()
							Set strFlagDir = IifS( cb1,GetIntDir(),GetExtDir())
							Set sTxt=''
							Set sdat=GetBankDateEx(  )
							If cb1
								Call SqlPrepareAndExecute( hSql(),"select sab from banks where kodn=4 and mfo='820172'  INTO :strBankSab ")
								If not SqlFetchNext( hSql(), nFetchRes )
									Set strBankSab=GetBankSab()
							Else
								Set strBankSab=GetBankSab()
							Call SqlPrepareAndExecute( hSql(),T(
									 "SELECT fn FROM zag_a WHERE DATE(dat)= :sdat AND otm<5 AND
									         fn LIKE '$B"||strBankSab||"%' 
									  UNION 
									  SELECT fn FROM zag_b WHERE DATE(dat)= :sdat AND otm<5 AND
									         fn LIKE '$A"||strBankSab||"%'
									  ORDER BY Fn
									  INTO :sTmp"))
							While SqlFetchNext( hSql(), nFetchRes )
								Set sTxt = sTxt || 'Файл ' || sTmp || ' не заквитован.' || PutCrLf()
							If sTxt
								Call MessageErrorEx( sTxt )
						Else If rbZ3
							Set strFlag = '\\Z3'
							Set strFlagDir = GetExtDir()
						Else If rbVall
							Set strFlag = FILE_V()
							Set strFlagDir = GetIntDir()
						Else If rbVbank
							If SalIsNull( cmbBanks )
								Return MessageInfoEx( 'Выберите банк, для которого необходимо сформировать файл-выписку V!' )
							Set strFlag = FILE_V() || strBankSab
							Set strFlagDir = GetIntDir()
						Else If rbK0
							Set strFlag = FILE_K0()
							Set strFlagDir = GetIntDir()
						Else If rbIpsInt
							Set strFlag = FILE_Q()
							Set strFlagDir = GetIntDir()
						Else If rbIpsExt
							Set strFlag = FILE_Q()
							Set strFlagDir = GetExtDir()
						Else If rbPauseInt
							Set strFlag = FILE_PAUSE()
							Set strFlagDir = GetIntDir()
						Else If rbPauseExt
							Set strFlag = FILE_PAUSE()
							Set strFlagDir = GetExtDir()
						Else If rbLimits
							Set strFlag = "\\FL"
							Set strFlagDir = GetExtDir()
						!
						! Call Debug(sSab||':'|| strFlagDir || strFlag)
						If MessageQuestion( 'Сформировать технологический флаг '||IifS( cb1,'ВПС: ','СЭП: ' )|| strFlag || ' ?' ) = IDNO
							Return FALSE
						!
						If SalFileOpen( hFile, strFlagDir || strFlag, OF_Binary | OF_Create )
							Call SalFileClose( hFile )
							Call MessageInfoEx( 'Технологический флаг  '||IifS( cb1,'ВПС: ','СЭП: ' )|| strFlag || ' успешно сформирован!' )
						Else
							Return MessageError( 'Ошибка создания файла-флага ' || strFlag || ' в каталоге: ' || strFlagDir )
			Pushbutton: pbExit
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   5.586"
					Top:    4.01"
					Width:  1.5"
					Width Editable? Class Default
					Height: 0.448"
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
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
						Call SalEndDialog( hWndForm, FALSE )
			!
			Combo Box: cmbBanks
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   4.633"
					Top:    2.156"
					Width:  4.217"
					Width Editable? Yes
					Height: 1.655"
					Height Editable? Yes
				Visible? Yes
				Editable? No
				String Type: String
				Maximum Data Length: Default
				Sorted? No
				Always Show List? No
				Vertical Scroll? Yes
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
				Input Mask: Unformatted
				List Initialization
				Message Actions
					On SAM_Create
						Call SalListPopulate( cmbBanks, hSql(), T( "SELECT nb  
								FROM  Banks WHERE mfop = :strBankMfo AND 
								 mfo!=:strBankMfo" ) )
					On SAM_Click
						Call SqlPrepareAndExecute( hSql(), T( "SELECT sab
								 FROM  Banks  WHERE  nb = :cmbBanks
								 INTO :strBankSab" ) )
						Call SqlFetchNext( hSql(), nFetchRes )
						!
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
			Frame
				Resource Id: 60209
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.071"
					Top:    0.06"
					Width:  8.843"
					Width Editable? Yes
					Height: 3.781"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Border Color: 3D Shadow Color
				Background Color: Default
			Frame
				Resource Id: 60210
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.071"
					Top:    3.917"
					Width:  8.843"
					Width Editable? Yes
					Height: 0.646"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Border Color: 3D Shadow Color
				Background Color: 3D Face Color
			Line
				Resource Id: 60211
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Coordinates
					Begin X:  0.1"
					Begin Y:  0.5"
					End X:  8.886"
					End Y:  0.5"
				Visible? Yes
				Line Style: Etched
				Line Thickness: 1
				Line Color: 3D Shadow Color
			Line
				Resource Id: 60212
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Coordinates
					Begin X:  0.086"
					Begin Y:  1.125"
					End X:  8.9"
					End Y:  1.125"
				Visible? Yes
				Line Style: Etched
				Line Thickness: 1
				Line Color: 3D Shadow Color
			Line
				Resource Id: 60213
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Coordinates
					Begin X:  0.086"
					Begin Y:  1.792"
					End X:  8.9"
					End Y:  1.792"
				Visible? Yes
				Line Style: Etched
				Line Thickness: 1
				Line Color: 3D Shadow Color
			Line
				Resource Id: 60214
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Coordinates
					Begin X:  0.086"
					Begin Y:  2.479"
					End X:  8.9"
					End Y:  2.479"
				Visible? Yes
				Line Style: Etched
				Line Thickness: 1
				Line Color: 3D Shadow Color
			Line
				Resource Id: 60215
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Coordinates
					Begin X:  0.086"
					Begin Y:  2.896"
					End X:  8.9"
					End Y:  2.896"
				Visible? Yes
				Line Style: Etched
				Line Thickness: 1
				Line Color: 3D Shadow Color
			Line
				Resource Id: 60216
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Coordinates
					Begin X:  0.071"
					Begin Y:  3.344"
					End X:  8.886"
					End Y:  3.344"
				Visible? Yes
				Line Style: Etched
				Line Thickness: 1
				Line Color: 3D Shadow Color
			!
			Check Box: cb1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ВПС
				Window Location and Size
					Left:   7.283"
					Top:    2.571"
					Width:  1.4"
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
					On SAM_Create
						If SalStrLeftX(strBankMfo,1)!='8'
							Call SalDisableWindow( hWndItem )
		Functions
		Window Parameters
		Window Variables
			File Handle: hFile
			String: strBankMfo
			String: strBankSab
			String: strFlag
			String: strFlagDir
			String: sTxt
			String: sdat
			String: sTmp
		Message Actions
			On SAM_Create
				Call PrepareWindowEx( hWndForm )
				If ShowInputPassword() = FALSE
					Return SalEndDialog( hWndForm, FALSE )
				Call WaitCursorOn()
				If not (GetGlobalOption( 'NUMMODEL' ) ='3' or
						        GetGlobalOption( 'NUMMODEL' ) ='V')
					Call SalDisableWindow( rbK0 )
					Call SalDisableWindow( rbPauseInt )
					Call SalDisableWindow( rbIpsInt )
					Call SalDisableWindow( rbVall )
					Call SalDisableWindow( rbVbank )
					Call SalDisableWindow( cmbBanks )
				If GetGlobalOption( 'NUMMODEL' ) != '1'
					Call SalDisableWindow( rbLimits )
				If GetGlobalOption( 'NUMMODEL' ) != '3'
					Call SalDisableWindow( rbZ3 )
				Call SalSetFocus( pbExit )
				Set strBankMfo=GetBankMfo()
				Set rbPauseInt=TRUE
				! Скрываем флаги паузы
				Call SalDisableWindow( rbPauseInt )
				Call SalDisableWindow( rbPauseExt )
			On SAM_CreateComplete
				Call WaitCursorOff()
			On SAM_Destroy
				! Disactivation call function' role
				If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
					Call XRoleUnset(hSql(), ' ShowSetTechFlags() ' )
				Call WaitCursorOff()
	Dialog Box: dlg_SendMessage
		Class:
		Property Template:
		Class DLL Name:
		Title: Сообщения участникам ВПС
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? No
			Type of Dialog: Modal
			Window Location and Size
				Left:   0.625"
				Top:    0.625"
				Width:  9.733"
				Width Editable? Yes
				Height: 5.417"
				Height Editable? Yes
			Absolute Screen Location? Yes
			Font Name: MS Sans Serif
			Font Size: 8
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description: Послать сообщение участникам ВПС. (АгроБанк)
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
			Background Text: Банк получатель:
				Resource Id: 10582
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.217"
					Top:    0.179"
					Width:  2.033"
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
			Combo Box: cmbBanks
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   2.383"
					Top:    0.143"
					Width:  4.583"
					Width Editable? Yes
					Height: 5.369"
					Height Editable? Yes
				Visible? Yes
				Editable? No
				String Type: String
				Maximum Data Length: Default
				Sorted? No
				Always Show List? No
				Vertical Scroll? Yes
				Font Name: Default
				Font Size: 8
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
				Input Mask: Unformatted
				List Initialization
				Message Actions
					On SAM_Create
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
						!
						Call SalListPopulate( cmbBanks, hSql(),
								T( "SELECT sab||' - '||trim(nb) FROM Banks WHERE mfop = :strBankMfo AND 
								 mfo <> :strBankMfo AND (kodn=4 OR kodn=6)" ) )
						Call SalListAdd( cmbBanks, '*' )
						!
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
					On SAM_Click
						While TRUE
							If cmbBanks='*'
								Break
							If NOT SqlPrepareAndExecute( hSql(), T("SELECT sab 
									 FROM Banks WHERE sab = SUBSTR(:cmbBanks,1,4) INTO :strSab" ) ) 
								Break
							If NOT SqlFetchNext( hSql(), nFetchRes )
								Break
							Break
			!
			Multiline Field: mlMsgText
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 4096
					String Type: String
					Editable? Yes
				Display Settings
					Border? Yes
					Word Wrap? Yes
					Vertical Scroll? Yes
					Window Location and Size
						Left:   0.067"
						Top:    0.536"
						Width:  9.5"
						Width Editable? Yes
						Height: 3.844"
						Height Editable? Yes
					Visible? Yes
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
				Message Actions
					On SAM_AnyEdit
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
						!
						Call SalEnableWindow( pbSend )
						!
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
			!
			Pushbutton: pbSend
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbExecute
				Property Template:
				Class DLL Name:
				Title: Выполнить
				Window Location and Size
					Left:   1.743"
					Top:    4.531"
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
						If MessageQuestion( 'Сформировать сообщение для участника ВПС?' ) = IDNO
							Return FALSE
						!
						If GetMsgDir()=''
							Call SetMsgDir( GetPrnDir() )
						!
						If cmbBanks='*'
							Set i=0
							Loop
								If NOT SalListSetSelect( cmbBanks, i ) 
									! Call Debug( 'SalListSetSelect failed. i='||SalNumberToStrX( i, 0 ) )
									Break
								!
								If cmbBanks != '*'
									Set strSab = SalStrRepeatX( ' ', 4 )
									Set bOk = SqlPrepareAndExecute( hSql(), T( "SELECT sab 
											    FROM Banks WHERE sab = SUBSTR(:cmbBanks,1,4) INTO :strSab" ) )
									If bOk
										Call SqlFetchNext( hSql(), nFetchRes )
										If FETCH_Ok = nFetchRes
											Call CreateMessageFile( strSab, mlMsgText )
										Else
											Call SalMessageBox ( 'SqlFetchNext was not successful.'||
													PutCrLf()||'FETCH_Res='||SalNumberToStrX(nFetchRes,0), 'Error', MB_Ok )
									Else
										Call SalMessageBox ( 'SqlPrepareAndExecute was not successful','Error', MB_Ok )
									!
									!
								Set i=i+1
						Else
							Call SqlPrepareAndExecute( hSql(), T( "SELECT sab
									 FROM Banks WHERE sab = SUBSTR(:cmbBanks,1,4) INTO :strSab" ) )
							Call SqlFetchNext( hSql(), nFetchRes )
							!
							Call CreateMessageFile( strSab, mlMsgText )
						!
						Call MessageInfoEx( 'Сообщение для участника ВПС успешно сформировано!' )
			Pushbutton: pbExit
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   6.414"
					Top:    4.542"
					Width:  1.5"
					Width Editable? Class Default
					Height: 0.448"
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
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
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
						!
						Call SalEndDialog( hWndForm, FALSE )
						!
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
			!
			Frame
				Resource Id: 10583
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.083"
					Top:    0.06"
					Width:  9.467"
					Width Editable? Yes
					Height: 0.429"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Border Color: 3D Shadow Color
				Background Color: Default
			Frame
				Resource Id: 10584
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.086"
					Top:    4.458"
					Width:  9.467"
					Width Editable? Yes
					Height: 0.615"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Border Color: 3D Shadow Color
				Background Color: 3D Face Color
		Functions
		Window Parameters
		Window Variables
			String: strBankMfo
			String: strSab
			Number: i
			Boolean: bOk
		Message Actions
			On SAM_Create
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				!
				Call PrepareWindowEx( hWndForm )
				!
				If ShowInputPassword() = FALSE
					Return SalEndDialog( hWndForm, FALSE )
				!
				Call WaitCursorOn()
				Call SalSetFocus( pbExit )
				Call SalDisableWindow( pbSend )
				!
				Set strBankMfo=GetBankMfo()
				!
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			On SAM_CreateComplete
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				!
				Call WaitCursorOff()
				!
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			On SAM_Destroy
				! Disactivation call function' role
				If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
					Call XRoleUnset(hSql(), ' ShowSendMessage() ' )
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				!
				Call WaitCursorOff()
				!
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	Dialog Box: dlg_ExportAccounts
		Class:
		Property Template:
		Class DLL Name:
		Title: Экспорт состояния счетов банка
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? No
			Type of Dialog: Modal
			Window Location and Size
				Left:   0.7"
				Top:    0.927"
				Width:  5.971"
				Width Editable? Yes
				Height: 2.635"
				Height Editable? Yes
			Absolute Screen Location? Yes
			Font Name: MS Sans Serif
			Font Size: 8
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description: Экспорт состояния счетов банка
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
			Background Text: Банковская дата:
				Resource Id: 56900
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.086"
					Top:    0.09"
					Width:  1.8"
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
			List Box: lbListDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   0.086"
					Top:    0.31"
					Width:  2.286"
					Width Editable? Yes
					Height: 1.896"
					Height Editable? Yes
				Visible? Yes
				Multiple selection? No
				Sorted? No
				Vertical Scroll? Yes
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
				Horizontal Scroll? No
				List Initialization
				Message Actions
					On SAM_Create
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
						!
						If SqlPrepareAndExecute( hSql(), T( "SELECT fdat FROM
								 Saldoa  INTO  :dtFdat  WHERE  fdat <= date( current )
								  GROUP BY  fdat  ORDER BY 1 DESC" ) )
							While SqlFetchNext( hSql(), nFetchRes )
								Call SalListAdd( lbListDate, SalFmtFormatDateTime( dtFdat, ddMMyyyy() ) )
							!
							If SalListQueryCount( lbListDate ) = 0
								Call SalSendMsg( lbListDate, SAM_User, 0, 0 )
							Else
								Call SalListSetSelect( lbListDate, 0 )
								Call SalSendMsg( lbListDate, SAM_Click, 0, 0 )
						Else
							Call SalSendMsg( lbListDate, SAM_User, 0, 0 )
						!
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
					On SAM_Click
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
						!
						Set strDate=SalListQueryTextX( lbListDate, SalListQuerySelection( lbListDate ) )
						Set strDate= '_' || SalStrMidX( strDate, 0, 2 ) || SalStrMidX( strDate, 3, 2 )
						Set dfFileName=GetPrnDir() || '\\INF' || strDate || '.EXP'
						!
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
					On SAM_User
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
						!
						Call SalDisableWindow( lbListDate )
						Call SalDisableWindow( dfFileName )
						Call SalDisableWindow( pbOk )
						!
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
			Background Text: Наименование файла:
				Resource Id: 56901
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   2.433"
					Top:    0.09"
					Width:  2.35"
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
			Data Field: dfFileName
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
						Left:   2.383"
						Top:    0.31"
						Width:  3.45"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			!
			Pushbutton: pbOk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbExecute
				Property Template:
				Class DLL Name:
				Title: Выполнить
				Window Location and Size
					Left:   2.557"
					Top:    1.656"
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
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
						!
						Call WaitCursorOn()
						!
						Set strDate=SalListQueryTextX( lbListDate, SalListQuerySelection( lbListDate ) )
						Set strDate=SalStrMidX( strDate, 3, 2 ) || '-' || SalStrLeftX( strDate, 2 ) || '-' || SalStrRightX( strDate, 4 )
						!
						Set sDat=strDate
						Call SqlPrepareAndExecute( hSql(), T( "SELECT 
								 b.mfo, s.nms, (a.ostf-a.dos+a.kos), r.sort_id
								 FROM Saldoa a, Banks b, Bank_acc c, Saldo s, Sort_order r
								  WHERE DATE(a.fdat) = :sDat  AND c.acc=a.acc AND 
								        b.mfo=c.mfo AND s.acc=a.acc AND   r.mfo=b.mfo AND 
								 s.nbs   IN ( SELECT nbs FROM Expacc )
								  INTO :strMfo, :strName, :nOs, :nOrder
								 ORDER BY r.sort_id" ) )
						!
						If SalFileOpen( hFile, dfFileName, OF_Create | OF_Write | OF_Text )
							While SqlFetchNext( hSql(), nFetchRes )
								Set strAsciiName=StrWinToDosX( strName )
								Call SalFilePutStr( hFile, strMfo || ',"' || strAsciiName || '",' || SalNumberToStrX( nOs, 0) )
							Call SalFileClose( hFile )
							!
							Call MessageInfo( 'Файл состояния счетов банка: ' || dfFileName || ' успешно создан!' )
						Else
							Return MessageError( 'Ошибка открытия файла: ' || dfFileName )
						!
						Call WaitCursorOff()
						!
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
			Pushbutton: pbExit
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   4.186"
					Top:    1.656"
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
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
						!
						Call SalEndDialog( hWndForm, FALSE )
						!
						! ////////////////////////////////////////////////////////////////////////////////////////////////////////////
			!
			Frame
				Resource Id: 58294
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   2.433"
					Top:    1.552"
					Width:  3.35"
					Width Editable? Yes
					Height: 0.656"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Border Color: 3D Shadow Color
				Background Color: Default
		Functions
		Window Parameters
		Window Variables
			! //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			String: sDat
			!
			File Handle: hFile
			!
			String: strMfo
			String: strName
			String: strAsciiName
			String: strDate
			!
			Date/Time: dtFdat
			!
			Number: nOs
			Number: nOrder
			Number: nFetchRes
			!
			! //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		Message Actions
			On SAM_Create
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				!
				Call PrepareWindow( hWndForm )
				!
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			On SAM_CreateComplete
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				!
				Call WaitCursorOff()
				!
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			On SAM_Destroy
				! Disactivation call function' role
				If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
					Call XRoleUnset(hSql(), ' ShowExportAccounts() ' )
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				!
				Call WaitCursorOff()
				!
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	Dialog Box: dlg_Direction
		Class:
		Property Template:
		Class DLL Name:
		Title: Блокирование направлений СЭП
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   1.15"
				Top:    1.604"
				Width:  7.343"
				Width Editable? Yes
				Height: 3.333"
				Height Editable? Yes
			Absolute Screen Location? Yes
			Font Name: Default
			Font Size: Default
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description: Блокировки направлений СЭП
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
			!
			Radio Button: rbLockNp
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Блокировать формирование начальных платежей СЭП
				Window Location and Size
					Left:   0.143"
					Top:    0.177"
					Width:  6.9"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
				Message Actions
			Radio Button: rbUnLockNp
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Разблокировать формирование начальных платежей СЭП
				Window Location and Size
					Left:   0.143"
					Top:    0.479"
					Width:  6.9"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
				Message Actions
			Radio Button: rbLockOp
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Блокировать формирование ответных платежей СЭП
				Window Location and Size
					Left:   0.143"
					Top:    0.893"
					Width:  6.9"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
				Message Actions
			Radio Button: rbUnLockOp
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Разблокировать формирование ответных платежей СЭП
				Window Location and Size
					Left:   0.143"
					Top:    1.179"
					Width:  6.9"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
				Message Actions
			Radio Button: rbLockAll
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Блокировать все направления СЭП
				Window Location and Size
					Left:   0.143"
					Top:    1.619"
					Width:  6.9"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
				Message Actions
			Radio Button: rbUnLockAll
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Разблокировать все направления СЭП
				Window Location and Size
					Left:   0.143"
					Top:    1.905"
					Width:  6.9"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
				Message Actions
			!
			Pushbutton: pbOk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbExecute
				Property Template:
				Class DLL Name:
				Title: Выполнить
				Window Location and Size
					Left:   1.314"
					Top:    2.406"
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
						If rbLockNp
							Call BnkLockPtsOutDir()
						Else If rbUnLockNp
							Call BnkUnLockPtsOutDir()
						Else If rbLockOp
							Call BnkLockPtsInDir()
						Else If rbUnLockOp
							Call BnkUnLockPtsInDir()
						Else If rbLockAll
							Call BnkLockPtsAllDir()
						Else If rbUnLockAll
							Call BnkUnLockPtsAllDir()
						Call SalEndDialog( hWndForm, TRUE )
			Pushbutton: pbExit
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   4.586"
					Top:    2.406"
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
						Call SalEndDialog( hWndForm, FALSE )
			!
			Frame
				Resource Id: 24769
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.083"
					Top:    2.321"
					Width:  7.071"
					Width Editable? Yes
					Height: 0.615"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Border Color: 3D Shadow Color
				Background Color: 3D Face Color
			Frame
				Resource Id: 24770
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.057"
					Top:    0.06"
					Width:  7.114"
					Width Editable? Yes
					Height: 2.198"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Border Color: 3D Shadow Color
				Background Color: Default
		Functions
			Function: BnkLockPtsOutDir
				Description: Блокировать начальные платежи
				Returns
				Parameters
				Static Variables
				Local variables
					File Handle: hFile
					String: strBankMfo
				Actions
					If MessageQuestion( MSG_VerbLock2 || MSG_Q_StartDirLock2 ) = IDYES
						Set strBankMfo=GetBankMfo()
						If SqlPrepareAndExecute( hSql(), T("UPDATE lkl_rrp SET blk=blk+1
								    WHERE blk IN (0,2) AND mfo in ( select mfo from banks where mfop = :strBankMfo AND kodn IN (3,4) )" ) )
							Call SqlCommitEx( hSql(), 'Блокировка начальных платежей' )
							If SalFileOpen( hFile, GetIntDir() || FILE_K(), OF_Create | OF_Binary | OF_Write ) = TRUE
								Call SalFileClose( hFile )
							Else
								Return MessageError( 'Ошибка создания файла-флага K в директории: ' || GetIntDir() )
			Function: BnkUnLockPtsOutDir
				Description: Разблокировать начальные платежи
				Returns
				Parameters
				Static Variables
				Local variables
					File Handle: hFile
					String: strBankMfo
				Actions
					If MessageQuestion( MSG_VerbUnLock2 || MSG_Q_StartDirLock2 ) = IDYES
						Set strBankMfo=GetBankMfo()
						If SqlPrepareAndExecute( hSql(), T("UPDATE lkl_rrp SET blk=blk-1
								   WHERE blk IN (1,3) AND mfo in (select mfo from banks where mfop = :strBankMfo AND kodn IN(3,4))" ) )
							Call SqlCommitEx( hSql(), 'Разблокировка начальных платежей' )
							If MessageQuestion( MSG_Q_KFilesProcess2 ) = IDYES
								If SalFileOpen( hFile, GetIntDir() || FILE_K(), OF_Create | OF_Binary | OF_Write ) = TRUE
									Call SalFileClose( hFile )
								Else
									Return MessageError( 'Ошибка создания файла-флага K в директории: ' || GetIntDir() )
			Function: BnkLockPtsInDir
				Description: Блокировать ответные платежи
				Returns
				Parameters
				Static Variables
				Local variables
					File Handle: hFile
					String: strBankMfo
				Actions
					If MessageQuestion( MSG_VerbLock2 || MSG_Q_BackDirLock2 ) = IDYES
						Set strBankMfo=GetBankMfo()
						If SqlPrepareAndExecute( hSql(), T("UPDATE lkl_rrp SET blk=blk+2
								    WHERE blk IN (0,1) AND mfo in (select mfo from banks where mfop = :strBankMfo AND kodn IN (3,4))")  )
							Call SqlCommitEx( hSql(), 'Блокировка ответных платежей' )
							If SalFileOpen( hFile, GetIntDir() || FILE_K(), OF_Create | OF_Binary | OF_Write ) = TRUE
								Call SalFileClose( hFile )
							Else
								Return MessageError( 'Ошибка создания файла-флага K в директории: ' || GetIntDir() )
			Function: BnkUnLockPtsInDir
				Description: Разблокировать ответные платежи
				Returns
				Parameters
				Static Variables
				Local variables
					File Handle: hFile
					String: strBankMfo
				Actions
					If MessageQuestion( MSG_VerbUnLock2 || MSG_Q_BackDirLock2 ) = IDYES
						Set strBankMfo=GetBankMfo()
						If SqlPrepareAndExecute( hSql(), T("UPDATE lkl_rrp SET blk=blk-2
								   WHERE blk IN (2,3) AND mfo in (select mfo from banks where mfop = :strBankMfo AND kodn IN (3,4))")  )
							Call SqlCommitEx( hSql(), 'Разблокировка ответных платежей' )
							If MessageQuestion( MSG_Q_KFilesProcess2 ) = IDYES
								If SalFileOpen( hFile, GetIntDir() || FILE_K(), OF_Create | OF_Binary | OF_Write ) = TRUE
									Call SalFileClose( hFile )
								Else
									Return MessageError( 'Ошибка создания файла-флага K в директории: ' || GetIntDir() )
			Function: BnkLockPtsAllDir
				Description: Блокировать все направления
				Returns
				Parameters
				Static Variables
				Local variables
					File Handle: hFile
					String: strBankMfo
				Actions
					If MessageQuestion( MSG_VerbLock2 || MSG_Q_AllDirLock2 ) = IDYES
						Set strBankMfo=GetBankMfo()
						If SqlPrepareAndExecute( hSql(),T("UPDATE lkl_rrp SET blk=3
								    WHERE mfo in (select mfo from banks where mfop = :strBankMfo AND kodn IN (3,4)) " ) )
							Call SqlCommitEx( hSql(), 'Блокировка всех направлений' )
							If SalFileOpen( hFile, GetIntDir() || FILE_K(), OF_Create | OF_Binary | OF_Write ) = TRUE
								Call SalFileClose( hFile )
							Else
								Return MessageError( 'Ошибка создания файла-флага K в директории: ' || GetIntDir() )
			Function: BnkUnLockPtsAllDir
				Description: Разблокировать все направления
				Returns
				Parameters
				Static Variables
				Local variables
					File Handle: hFile
					String: strBankMfo
				Actions
					If MessageQuestion( MSG_VerbUnLock2 || MSG_Q_AllDirLock2 ) = IDYES
						Set strBankMfo=GetBankMfo()
						If SqlPrepareAndExecute( hSql(),T(" UPDATE lkl_rrp SET blk=0
								   WHERE blk IN (1,2,3) AND mfo in (select mfo from banks where mfop = :strBankMfo AND kodn IN(3,4))") )
							Call SqlCommitEx( hSql(), 'Разблокировка всех направлений' )
							If MessageQuestion( MSG_Q_KFilesProcess2 ) = IDYES
								If SalFileOpen( hFile, GetIntDir() || FILE_K(), OF_Create | OF_Binary | OF_Write ) = TRUE
									Call SalFileClose( hFile )
								Else
									Return MessageError( 'Ошибка создания файла-флага K в директории: ' || GetIntDir() )
		Window Parameters
		Window Variables
			! //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			!
			Number: nCount
			Number: nMfo
			String: sSab
			String: sSab_p
			String: sNb
			String: sNbw
			Number: nNls
			String: sMod
			String: sMdl
			Number: nMfop
			String: sBlk
			String: sFv
			String: sFs
			String: sArm2
			String: sFn
			Number: nHdr
			Sql Handle: hSqlOdbc
			!
			Number: nPos
			Number: nDelta
			!
			String: strMessage
			!
			! //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		Message Actions
			On SAM_Create
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				!
				Call PrepareWindowEx( hWndForm )
				!
				If ShowInputPassword() = FALSE
					Return SalEndDialog( hWndForm, FALSE )
				!
				Call WaitCursorOn()
				Call SalSetFocus( pbExit )
				!
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			On SAM_CreateComplete
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				!
				Call WaitCursorOff()
				!
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			On SAM_Destroy
				! Disactivation call function' role
				If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
					Call XRoleUnset(hSqlOdbc, ' ShowDirection() ' )
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				!
				Call WaitCursorOff()
				!
				! ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
