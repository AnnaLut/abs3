Application Description: Импортно-Экспортные контракты
		***********************************************
		* Разработчики: Панина И.А.  	              *
		*               под надзором Чупашки          *                 		*
		* (C) Унити-БАРС, 2003     	              *
		***********************************************
		
	Outline Version - 4.0.26
	Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400800000
0020: 0000000000CE0000 002C000000020000 0003000000000000 0082020000F8FFFF
0040: FFE2FFFFFFFFFFFF FF000000007C0200 004D010000010000 0000000000010000
0060: 000F4170706C6963 6174696F6E497465 6D02000000075769 6E646F777308534F
0080: 53545F455850
.enddata
.data DT_MAKERUNDLG
0000: 020000000016713A 5C6261727339385C 62696E5C50425F31 2E61706418713A5C
0020: 6261727339385C62 696E5C6E65776170 702E646C6C18713A 5C6261727339385C
0040: 62696E5C6E657761 70702E6170630000 01010115433A5C43 454E545552415C6E
0060: 65776170702E7275 6E15433A5C43454E 545552415C6E6577 6170702E646C6C15
0080: 433A5C43454E5455 52415C6E65776170 702E617063000001 0101175C42415253
00A0: 39385C42494E5C42 4152533030372E41 5044165C42415253 39385C42494E5C6E
00C0: 65776170702E646C 6C165C4241525339 385C42494E5C6E65 776170702E617063
00E0: 000001010115433A 5C43454E54555241 5C6E65776170702E 61706C15433A5C43
0100: 454E545552415C6E 65776170702E646C 6C15433A5C43454E 545552415C6E6577
0120: 6170702E61706300 00010101
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
		Reject Multiple Window Instances? Yes
		Enable Runtime Checks Of External References? Yes
		Use Release 4.0 Scope Rules? No
	Libraries
		File Include: Gentbl.apl
		File Include: GENTBLS.APL
		File Include: Genlist.apl
		File Include: XSALCPT.APL
		Dynalib: NSIAPI.APD
		File Include: XSALIMG.APL
		File Include: Winbars2.apl
		!
		Dynalib: Absapi.apd
		Dynalib: Global.apd
		Dynalib: Custacnt.apd
		Dynalib: otcn.apd
		Dynalib: Docview.apd
		File Include: Genbutn.apl
		! File Include: DOCFUN6.APL
		File Include: GENLABEL.APL
		Dynalib: CHCKINNR.APD
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
				Font Name: Arial
				Font Size: 8
				Font Enhancement: Bold
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
			Number: #00000
			Number: 0000
			Number: #0000
			Number: 000000
			Number: 00000000
			Date/Time: dd/MM/yyyy
			Input: 99/99/9999
			Number: 0000000
			Number: #0000000
			Number: #000000
		External Functions
		Constants
.data CCDATA
0000: 3000000000000000 0000000000000000 00000000
.enddata
.data CCSIZE
0000: 1400
.enddata
			System
				Number: UM_Filter	= SAM_User+301
			User
		Resources
		Variables
			: connect
				Class: cABSConnect
			Sql Handle: hSqlTmp1
			Sql Handle: hSqlTmp2
			Sql Handle: hSqlTmp3
			Number: z1
			Number: z2
			Number: z3
			Number: z4
			Number: z5
			Boolean: fzay1
			Boolean: fzay2
			Boolean: fzay3
			Window Handle: hWndEIK
			Window Handle: hWndFinDocs
			Window Handle: hWndF98
			Window Handle: hWndJ
			Window Handle: hWndS
			Window Handle: hWndM
			Window Handle: hWndAvansT  
			Window Handle: hWndTDR
			Window Handle: hWndAvansP
			Window Handle: hWndRee
			Window Handle: hWndPrint
			Window Handle: hWndAlien
			! Window Handle: hR3
			Boolean: bApdInited
		Internal Functions
			Function: GetFirstEditableColumn
				Description: Получить первую редактируюмую колонку
				Returns
					Window Handle:
				Parameters
					Window Handle: hWndTbl
				Static Variables
				Local variables
					Number: nCol
					Window Handle: hWndCol
				Actions
					Set nCol=1
					Loop
						Set hWndCol = SalTblGetColumnWindow(hWndTbl, nCol, COL_GetPos)
						If hWndCol = hWndNULL
							Break
						If SalTblQueryColumnFlags(hWndCol, COL_Editable) and
								   SalIsWindowVisible(hWndCol)
							Break
						Set nCol = nCol + 1
					Return hWndCol
			Function: SelFirstRow
				Description: Select first row in the table, unselects all others
				Returns
				Parameters
					Window Handle: hTbl
				Static Variables
				Local variables
				Actions
					Call SalTblClearSelection( hTbl )
					Call SalTblSetContext( hTbl, 0 )
					Call SalTblSetRowFlags( hTbl, 0, ROW_Selected, TRUE )
			Function: GetNewRef
				Description:
				Returns
					Boolean: bOK
				Parameters
					! Window Handle: hParent
					Number: nImpExp
				Static Variables
				Local variables
					Date/Time: dDate
				Actions
					If SalStrTrimX(SalStrUpperX(GetDBMS())) = 'ORACLE'
						Set dDate = GetBankDate(  )
						If SqlPLSQLCommand(hSql(),"bars.p_contract_ref(nImpExp, dDate)")
							Call SqlCommit( hSql())
					Return TRUE
			Function: GetXRate
				Description:
				Returns
					Boolean:
				Parameters
					Receive Number: nRatO
					Receive Number: nRatB
					Receive Number: nRatS
					Number: nKv1
					Number: nKv2
					Date/Time: dDat
				Static Variables
				Local variables
					Number: nFetchRes
				Actions
					While TRUE
						If SalStrTrimX(SalStrUpperX( GetDBMS() ))='ORACLE'
							If not SqlPLSQLCommand( hSqlAux(),"gl.x_rat(nRatO,nRatB,nRatS,nKv1,nKv2,dDat)")
								Break
						Else
							If not SqlRetrieve( hSqlAux(), "informix.x_rat",":nKv1,:nKv2,:dDat", ":nRatO,:nRatB,:nRatS" )
								Break
							If not SqlExecute ( hSqlAux() )
								Break
							If not SqlFetchNext( hSqlAux(), nFetchRes )
								Break
						Set nRatO=SalNumberTruncate( nRatO, 10, 6 )
						Return TRUE
					Call SqlRollback( hSqlAux() )
					Return FALSE
			Function: Sel007 	! __exported
				Description: Bars007_Selector
				Returns
				Parameters
					Window Handle: hWndParent
					Number: nMode
					Number: nPar
					String: strPar01
					String: strPar02
				Static Variables
				Local variables
				Actions
					Call Ini007()
					Select Case nMode
						Case 0 !! Контракты + ТД + Платежи (ЭКСП)
							If IsWindow(hWndEIK)
								Call SalBringWindowToTop( hWndEIK )
							Else
								Set hWndEIK = SalCreateWindow(EIK, hWndParent, nMode, nPar, strPar01, strPar02)
							Break
						Case 1 !! Контракты + ТД + Платежи (ИМП)
							If IsWindow(hWndEIK)
								Call SalBringWindowToTop( hWndEIK )
							Else
								Set hWndEIK = SalCreateWindow(EIK, hWndParent, nMode, nPar, strPar01, strPar02  )
							Break
						Case 2 !! Ввод ТД с реестра
							If IsWindow(hWndTDR)
								Call SalBringWindowToTop( hWndTDR )
							Else
								Set hWndTDR = SalCreateWindow(AvansTDR, hWndParent, nPar, strPar01, strPar02)
							Break
						Case 4 !! Ввод реестра для ТД  
							If IsWindow(hWndRee)
								Call SalBringWindowToTop( hWndRee )
							Else
								Set hWndRee = SalCreateWindow(EIT_Reestr, hWndParent, nPar, strPar01, strPar02)
							Break
						Case 5 !! Санкции
							If IsWindow(hWndF98)
								Call SalBringWindowToTop( hWndF98 )
							Else
								Set hWndF98 = SalCreateWindow(F98, hWndParent, nPar, strPar01, strPar02)
							Break
			Function: Ini007
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
						Set strPathToLangResources = GetLangPath()
						Set strLangId = GetLang()
						Set strFileName = strPathToLangResources || "\\" || strLangId || "\\bars007.lng"
						If (NOT strLangId) OR (NOT CurrentLangTable.InitFromFile( strFileName, strLangId ))
							Call CurrentLangTable.Init()
						Set bApdInited = TRUE
					Return bApdInited
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
			Pushbutton: ctb_pbCancel
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
			Custom Control: cMeter
		Application Actions
	Table Window: AvansRef
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Неразобранные платежи
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
				Width:  14.417"
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
		Description: Авансовые ПЛАТЕЖИ
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
					Picture File Name: \BARS98\RESOURCE\BMP\INSERT.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Ввести платеж-фантом'
						On SAM_Click
							If SalMessageBox( 'Вы действительно хотите ввести платеж-фантом?', 'Внимание', MB_OkCancel )=IDOK
								Call SalSendMsg( AvansRef, UM_Insert, 0, 0 )
							Else
								Call SalSendMsg( AvansRef, UM_Populate, 0, 0 )
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
					Picture File Name: \BARS98\RESOURCE\BMP\Delrec.bmp
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Изъять документ из базы авансовых платежей'
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
						On SAM_Click
							Call GetNewRef( IMPEXP )
							Call SalSendMsg( AvansRef, UM_Populate, 0, 0 )
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
					Resource Id: 37962
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  5.1"
						Begin Y:  -0.012"
						End X:  5.1"
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
						Left:   2.05"
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
						Left:   2.483"
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
						Left:   2.48"
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
							Set strTip = 'Просмотр документа'
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.92"
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
					Resource Id: 37964
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
				Pushbutton: pbStorno
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbHelp
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.65"
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
					Picture File Name: \BARS98\RESOURCE\BMP\DELETE.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Сторнировать документ'
						On SAM_Click
							If AvansRef.SOS>=0
								If nCheckId=NUMBER_Null
									Call SalMessageBox( 'Не определена группа визирования валютного контроля!', 'Ошибка!', MB_IconStop|MB_OK )
								Else
									If SalTblAnyRows(AvansRef, ROW_Selected, 0)
										Call SalMessageBeep(MB_IconQuestion)
										If SalMessageBox('Вы уверены, что хотите возвратить ' ||
												   'отмеченные документы плательщику ?',
												   'Сторно документов',
												   MB_IconQuestion | MB_YesNo | MB_DefButton1) = IDYES
											Set sStornoReasonId = ''
											Set sStornoReason = ''
											If FunNSIGet('BP_REASON', '', sStornoReasonId,  sStornoReason)
												If sStornoReasonId AND sStornoReason
													Call SalWaitCursor(TRUE)
													Set nRow = TBL_MinRow
													While SalTblFindNextRow(AvansRef, nRow, ROW_Selected, 0)
														Call SalTblFetchRow(AvansRef, nRow)
														If Pay_Bck(AvansRef.REF, 5, '')
															Set nStatus=3
															Set nUserId=GetUserId()
															Set strHexMark2Ret =
																	    SalStrTrimX(AvansRef.CHK) ||
																	    SalStrRightX('00' ||
																	    NumberToHexSX(nCheckId), 2) ||
																	    SalStrRightX('0000' ||
																	    NumberToHexSX(nUserId), 4)
															!
															If SqlPrepareAndExecute(hSql(), '
																	     UPDATE oper
																	     SET chk=:strHexMark2Ret
																	     WHERE ref=:AvansRef.REF')
																If SqlPrepareAndExecute( hSql(), 
																		   "INSERT INTO operw(ref,tag,value) 
																		    VALUES (:AvansRef.REF, 'BACKR', :sStornoReason)" )
																	If SqlPrepareAndExecute(hSql(),
																			   "INSERT INTO oper_visa (ref, dat, userid, groupid, status) 
																			    VALUES (:AvansRef.REF,sysdate,:nUserId,:nCheckId,:nStatus)")
																		If SqlPrepareAndExecute(hSql(),
																				   "DELETE FROM contract_p WHERE idp=:AvansRef.IDP")
																			Call SqlCommitEx( hSql(), 'Возврат документа отправителю. Ref = ' || SalNumberToStrX(AvansRef.REF, 0))
																	Else
																		Call Debug('Ош. INSERT INTO oper_visa')
																		Call SqlRollback(hSql())
																Else
																	Call SqlRollback(hSql())
																	Call Debug('Ош. insert into operw')
															Else
																Call SqlRollback(hSql())
																Call Debug('Ош. UPDATE oper')
														Else
															Call SqlRollback(hSql())
													Call SalWaitCursor(FALSE)
													Call SalSendMsg(AvansRef, UM_Populate, 0, 0)
												Else
													Call SalMessageBeep(MB_IconStop)
													Call SalMessageBox('Причина отказа не была ' ||
															     'выбрана или пуста! Повторите операцию',
															     'Сторно документов, ошибка', MB_IconStop)
											Else
												Call SalMessageBeep(MB_IconStop)
												Call SalMessageBox('Причина отказа не была выбрана '
														     || '! Повторите операцию',
														     'Сторно документов, ошибка', MB_IconStop)
				Pushbutton: pbVisa
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbBrowse
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.09"
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
					Picture File Name: \BARS98\RESOURCE\BMP\EDIT.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Завизировать документ'
						On SAM_Click
							If AvansRef.SOS>=0 AND AvansRef.SOS<5
								If nCheckId=NUMBER_Null
									Call SalMessageBox( 'Не определена группа визирования валютного контроля!', 'Ошибка!', MB_IconStop|MB_OK )
								Else
									If SalTblAnyRows(AvansRef, ROW_Selected, 0)
										Call SalMessageBeep(MB_IconQuestion)
										If SalMessageBox('Завизировать отмеченные документы?','Внимание', MB_IconQuestion | MB_YesNo ) = IDYES
											Call SalWaitCursor(TRUE)
											Set nRow = TBL_MinRow
											While SalTblFindNextRow(AvansRef, nRow, ROW_Selected, 0)
												Call SalTblFetchRow(AvansRef, nRow)
												If NOT VIZA(AvansRef.REF,AvansRef.CHK) 
													Call SalMessageBox( 'Ошибка при наложении визы!', 'Внимание', MB_IconStop|MB_OK )
													Call SQL_ROLLBACK(  )
											Call SalWaitCursor(FALSE)
										Else
											Call SQL_ROLLBACK(  )
										Call SalSendMsg(AvansRef, UM_Populate, 0, 0)
				Pushbutton: pbAll
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbSwitch
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.52"
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
					Picture File Name: \BARS98\RESOURCE\BMP\TUDASUDA.BMP
					Picture Transparent Color: White
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Авансовые платежи по контракту/по клиенту'
						On SAM_Click
							Set nAll=1-nAll
							Call SalSendMsg( AvansRef, UM_Populate, 0, 0 )
				Line
					Resource Id: 32323
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  5.883"
						Begin Y:  -0.012"
						End X:  5.883"
						End Y:  0.452"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Line
					Resource Id: 2648
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  6.683"
						Begin Y:  -0.012"
						End X:  6.683"
						End Y:  0.452"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Pushbutton: pbOK
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbHelp
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   5.283"
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
							Set strTip = 'Привязать платеж к контракту'
						On SAM_Click
							If AvansRef.SOS>=0 OR AvansRef.SOS=NUMBER_Null
								If IMPEXP=0
									If MODE = 1
										! Курс + Сумма + Комиссия
										Call SalModalDialog(dlg_EXPL, hWndMDI, 1, 
												                    AvansRef.IDP, 
												                    AvansRef.REF,
												                    AvansRef.KVK,
												                    AvansRef.SUMDEBT,
												                    nKURS_O,
												                    nS2Calc,
												                    nKomiss)
										If nKURS_O!=NUMBER_Null AND nS2Calc!=NUMBER_Null AND nKomiss!=NUMBER_Null
											!
											If not SalTblAnyRows(SOST_EXP.tblP, ROW_New, 0)
												Call SalTblDefineSplitWindow(SOST_EXP.tblP, 3, TBL_Split_Adjustable)
											Set nRow = SalTblInsertRow(SOST_EXP.tblP, TBL_MinRow)
											Call SalTblSetContext(SOST_EXP.tblP, nRow)
											!
											Set SOST_EXP.tblP.IDP  =  AvansRef.IDP
											Set SOST_EXP.tblP.REF  =  AvansRef.REF
											Set SOST_EXP.tblP.FDAT =  AvansRef.FDAT
											Set SOST_EXP.tblP.KV   =  AvansRef.KV
											Set SOST_EXP.tblP.NLS  =  AvansRef.NLS
											Set SOST_EXP.tblP.NAZN =  AvansRef.NAZN
											Set SOST_EXP.tblP.DIG  =  AvansRef.DIG
											Set SOST_EXP.tblP.KURS    =  AvansRef.nKURS_O
											Set SOST_EXP.tblP.S       = AvansRef.nS2Calc/100
											Set SOST_EXP.tblP.KOMISS  = AvansRef.nKomiss
											Set SOST_EXP.tblP.nPAYD  = AvansRef.S100
											!
											Call SqlPrepareAndExecute( hSqlAux2(),
													     "SELECT lcv, dig INTO :SOST_EXP.tblP.ISO, :SOST_EXP.tblP.DIG
													      FROM tabval WHERE kv=:SOST_EXP.tblP.KV")
											If SqlFetchNext( hSqlAux2(), nFetchRes )
												Set SOST_EXP.tblP.Ss = Dig4( SOST_EXP.tblP.S, DIG, DIG )
												Set SOST_EXP.tblP.SK = (SOST_EXP.tblP.S+SOST_EXP.tblP.KOMISS/100)*SOST_EXP.tblP.KURS
												Set SOST_EXP.tblP.SKs = Dig4( SOST_EXP.tblP.SK, DIG, DIG )
												Set SOST_EXP.tblP.KOMISSs = Dig4(SOST_EXP.tblP.KOMISS/100,DIG, DIG)
											!
											Call SalTblSetFocusCell(SOST_EXP.tblP, nRow, GetFirstEditableColumn(SOST_EXP.tblP), 0, 1)
											Call SalDestroyWindow( AvansRef )
									Else
										If AvansRef.nPID=NUMBER_Null
											If SalMessageBox('Привязать платеж к контракту '||sNAME||'?','Внимание', MB_IconQuestion|MB_YesNo )=IDYES 
												Call SalModalDialog(dlg_EXPL, hWndMDI, 0,
														                    AvansRef.IDP,
														                    AvansRef.REF,
														                    AvansRef.KVK,
														                    AvansRef.SUMDEBT,
														                    nKURS_O,
														                    nS2Calc,
														                    nKomiss)
												If nKURS_O != NUMBER_Null AND nS2Calc != NUMBER_Null AND nKomiss != NUMBER_Null
													!
													Set nDelta = AvansRef.S100 - AvansRef.nS2Calc
													If SqlPrepareAndExecute(hSql(), 
															   "UPDATE contract_p SET 
															           kurs = :nKURS_O, 
															           s = :nS2Calc, 
															           pid = :AvansRef.IDK,
															           komiss = :nKomiss  
															    WHERE idp=:AvansRef.IDP")
														If nDelta > 0
															If SqlPrepareAndExecute(hSql(), 
																	   "INSERT INTO contract_p 
																	      (idp,ref,fdat,kv,s,acc,rnk,impexp,details,id_parent) 
																	    VALUES
																	      (0,:AvansRef.REF,:AvansRef.FDAT,:AvansRef.KV,:nDelta,
																	       :AvansRef.ACC,:AvansRef.RNK,:AvansRef.IMPEXP,:AvansRef.NAZN,:AvansRef.IDP)")
																Call SqlCommit(hSql())
														Call SqlCommit(hSql())
													Else
														Call SqlRollback(hSql())
								Else
									Call ATTACH_IMP(0)
							Call SalSendMsg(AvansRef, UM_Populate, 0, 0)
				Pushbutton: pbOK_Part
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbHelp
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   6.067"
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
					Picture File Name: \BARS98\RESOURCE\BMP\APP1.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							If IMPEXP=1
								Set strTip = 'Привязать ЧАСТЬ платежа к контракту'
							Else
								Set strTip = 'Отвязать платеж от контракта в аванс по клиенту'
						On SAM_Click
							If IMPEXP=0
								If AvansRef.nPID != NUMBER_Null
									! Наименование контракта
									If SqlPrepareAndExecute( hSql(), 
											   "SELECT name INTO :sTmp FROM top_contracts WHERE pid=:AvansRef.nPID" ) 
											AND NOT SqlFetchNext( hSql(), nFetchRes )
										Set sTmp = STRING_Null
									If SalMessageBox('Отвязать платеж от контракта '||sTmp||' в аванс по клиенту?', 
											                 'Внимание', MB_IconQuestion|MB_YesNo )=IDYES 
										If SqlPrepareAndExecute(hSql(), 
												   "UPDATE contract_p SET 
												           pid = NULL, 
												          kurs = NULL, 
												        komiss = 0 
												     WHERE idp = :AvansRef.IDP")
											Call SqlCommit(hSql())
										Else
											Call SqlRollback(hSql())
							Else
								If AvansRef.SOS>=0 OR AvansRef.SOS=NUMBER_Null
									Call ATTACH_IMP(1)
							Call SalSendMsg(AvansRef, UM_Populate, 0, 0)
				Line
					Resource Id: 37963
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  3.483"
						Begin Y:  Class Default
						End X:  3.483"
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
						Left:   6.917"
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
			Column: IDP
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						платежа
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
			Column: nPID
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Реф.
						контр.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  0.717"
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
			Column: nRNK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Регистр.
						№
						клиента
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
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
					On SAM_Validate
			Column: sND
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: №
						договора
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
				Width:  1.167"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: sNMK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Наименование
						клиента
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.233"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: REF
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Референс
						платежа
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
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
			Column: FDAT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						валютир
				Visible? Yes
				Editable? Yes
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
			Column: KV
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код 
						вал
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 3
				Data Type: Number
				Justify: Right
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
					On SAM_Validate
						Call SqlPrepareAndExecute( hSql(), 
								    "SELECT lcv, dig INTO :AvansRef.ISO, :AvansRef.DIG 
								     FROM tabval WHERE kv=:AvansRef.KV "||
								IifS( KVK != GetBaseVal(), " AND to_char(kv)<>"||Str(GetBaseVal())," ") )
						If NOT SqlFetchNext( hSql(), nFetchRes )
							Call Debug('Неверно указан код валюты')
							Set KV=NUMBER_Null
							Set DIG=2
			Column: ISO
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Вал
						Пл
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
				Width:  0.529"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: S
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма
						Платежа
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.571"
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
			Column: S100
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма
						Платежа
						в коп
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.571"
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
			Column: Ss
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма
						Платежа
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
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
					On SAM_Validate
						Set S100 = Val(Ss)*SalNumberPower( 10, DIG )
						Set S=S100/100
			Column: KURS
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Курс
				Visible? Yes
				Editable? Yes
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
			Column: SKs
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма
						аванс. ПЛ
						в вал. К
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
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
			Column: ACC
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код 
						вал
				Visible? No
				Editable? No
				Maximum Data Length: 3
				Data Type: Number
				Justify: Right
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
			Column: NLS
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Лиц.
						Счет
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.514"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: KOMISS
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма
						комиссии
				Visible? No
				Editable? Yes
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
			Column: KOMISSs
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма
						комиссии
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
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
					On SAM_Validate
						Set KOMISS = Val(KOMISSs)*SalNumberPower( 10, DIG )
			Column: NAZN
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Назначение платежа
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 160
				Data Type: String
				Justify: Left
				Width:  5.843"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: DIG
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
			Column: SOS
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
			Column: CHK
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
		Functions
			Function: VIZA
				Description: Наложение визы валютного контроля
				Returns
					Boolean: bOK
				Parameters
					Number: nRef
					String: sChk
				Static Variables
				Local variables
				Actions
					If nCheckId=NUMBER_Null
						Call SalMessageBox( 'Не определена группа визирования валютного контроля!', 'Ошибка!', MB_IconStop|MB_OK )
						Return FALSE
					If DocumentCheck(nRef, nCheckId, sChk, FALSE) = MBEx_Cancel
						Return FALSE
					Return TRUE
			Function: ATTACH_IMP
				Description:
				Returns
				Parameters
					Number: TIP
					! TIP=0 - привязка всей суммы
					! TIP=1 - частичная привязка
				Static Variables
				Local variables
				Actions
					If IMPEXP=1 AND (AvansRef.SOS>=0 OR AvansRef.SOS=NUMBER_Null)
						! Курс+параметры для 1-ПБ
						Call SalModalDialog(dlg_KURS_1PB,hWndMDI, TIP, 
								                    AvansRef.REF,AvansRef.KVK,AvansRef.KV,AvansRef.FDAT,
								                    AvansRef.S, SUMDEBT, nKURS_O, nS2Calc)
						If nKURS_O > 0 AND nS2Calc > 0
							If not SalTblAnyRows(SOST_IMP.tblP, ROW_New, 0)
								Call SalTblDefineSplitWindow(SOST_IMP.tblP, 3, TBL_Split_Adjustable)
							Set nRow = SalTblInsertRow(SOST_IMP.tblP, TBL_MinRow)
							Call SalTblSetContext(SOST_IMP.tblP, nRow)
							Set SOST_IMP.tblP.REF  =  AvansRef.REF
							Set SOST_IMP.tblP.IDP   =  AvansRef.IDP
							Set SOST_IMP.tblP.FDAT =  AvansRef.FDAT
							Set SOST_IMP.tblP.KV   =  AvansRef.KV
							Set SOST_IMP.tblP.NLS  =  AvansRef.NLS
							Set SOST_IMP.tblP.ACC  =  AvansRef.ACC
							Set SOST_IMP.tblP.NAZN =  AvansRef.NAZN
							Set SOST_IMP.tblP.DIG  =  AvansRef.DIG
							Set SOST_IMP.tblP.CHK  =  AvansRef.CHK
							Set SOST_IMP.tblP.SOS  =  AvansRef.SOS
							Set SOST_IMP.tblP.KURS=nKURS_O
							!
							Set SOST_IMP.tblP.S     = AvansRef.nS2Calc
							Set SOST_IMP.tblP.Ss    = Dig4( SOST_IMP.tblP.S, SOST_IMP.tblP.DIG, nMaxDig )
							Set SOST_IMP.tblP.Ss    = Dig4( SOST_IMP.tblP.S, SOST_IMP.tblP.DIG, nMaxDig )
							! Call Debug('AvansRef.S='||Str(AvansRef.S))
							! Call Debug('AvansRef.nS2Calc='||Str(AvansRef.nS2Calc))
							Set SOST_IMP.tblP.nSumP = (AvansRef.S - AvansRef.nS2Calc)*100
							! Call Debug('nSumP='||Str(SOST_IMP.tblP.nSumP))
							Call SqlPrepareAndExecute( hSqlAux2(),
									     "SELECT v.lcv, v.dig  
									      INTO :SOST_IMP.tblP.ISO,:SOST_IMP.tblP.DIG
									      FROM tabval v
									      WHERE v.kv=:SOST_IMP.tblP.KV  " )
							If SqlFetchNext( hSqlAux2(), nFetchRes )
								Set SOST_IMP.tblP.Ss  = Dig4( SOST_IMP.tblP.S, DIG, nMaxDig )
								Set SOST_IMP.tblP.SK  = SOST_IMP.tblP.S*SOST_IMP.tblP.KURS
								Set SOST_IMP.tblP.SKs = Dig4( SOST_IMP.tblP.SK, DIG, nMaxDig )
							!
							Call SalTblSetFocusCell(SOST_IMP.tblP, nRow, GetFirstEditableColumn(SOST_IMP.tblP), 0, 1)
							Call SalDestroyWindow( AvansRef )
			Function: ENABLE_BUTTON
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
					! К Н О П К И
					! Привязка ПЛ к К/ТД
					If IDK = 0
						Call SalDisableWindow( pbOK )
						Call SalDisableWindow( pbOK_Part )
						Call SalHideWindow( KURS )
						Call SalHideWindow( SKs )
					Else If SUMDEBT = 0
						Call SalDisableWindow( pbOK )
						Call SalHideWindow( KURS )
						Call SalHideWindow( SKs )
						If IMPEXP=1
							Call SalDisableWindow( pbOK_Part )
					Else
						If MODE = 2
							Call SalEnableWindow( pbOK )
							Call SalEnableWindow( pbOK_Part )
						Else If MODE = 1
							Call SalEnableWindow( pbOK )
							Call SalEnableWindow( pbOK_Part )
						Else
							Call SalDisableWindow( pbOK )
							Call SalDisableWindow( pbOK_Part )
					! Визирование
					If IMPEXP = 0
						Call SalDisableWindow( pbStorno )
						Call SalDisableWindow( pbVisa   )
						Call SalShowWindow( KOMISSs )
					Else
						Call SalEnableWindow( pbStorno )
						Call SalEnableWindow( pbVisa )
						Call SalHideWindow( KOMISSs )
					! Просморт аванс.ПЛ по Контракту/Клиенту
					If IMPEXP=0 AND IDK!=0
						Call SalEnableWindow( pbAll )
					Else
						Call SalDisableWindow( pbAll )
					! Ввод фантомов
					If IDK!=0
						Call SalEnableWindow( pbIns )
					Else
						Call SalDisableWindow( pbIns )
					!
					If nAll=1
						Call SalDisableWindow( pbOK )
						Call SalDisableWindow( pbIns )
					!
					If MODE = 9
						Call SalDisableWindow( pbOK )
						Call SalDisableWindow( pbOK_Part )
						Call SalDisableWindow( pbIns )
						Call SalDisableWindow( pbDel )
						Call SalDisableWindow( pbUpdate )
						Call SalDisableWindow( pbStorno )
						Call SalDisableWindow( pbVisa )
		Window Parameters
			Number: IMPEXP
			Number: MODE
			! 0 - просмотр неразобранных документов (кнопки  pbOK и pbOK_Part закрыты)
			! 1 - привязка ПЛ к ТД (экспорт)        (кнопки  pbOK и pbOK_Part открыты)
			! 2 - привязка ПЛ к К  (импорт)           - - - - - // - - - - - - - - - -  
					  или привязка ПЛ к К  (экспорт)
			! 9 - просмотр неразобранных документов (все кнопки закрыты)
			Number: IDK
			Number: RNK
			Number: KVK
			Number: SUMDEBT
			Window Handle: hWndParent
		Window Variables
			String: sNAME
			String: sNmk
			String: sTmp
			Number: nEIK_ND
			Number: nAll
			Number: nMaxDig
			Number: nRow
			Number: nFetchRes
			Number: nKURS_O
			Number: nS2Calc
			Number: nKomiss
			Number: nDelta
			! Возврат с визы
			String: sStornoReasonId
			String: sStornoReason
			Number: nStatus
			Number: nUserId
			String: strHexMark2Ret
			Number: nCheckId
		Message Actions
			On SAM_Create
				Call SalCenterWindow( hWndForm )
				Set AvansRef.strPrintFileName = 'contref'
				Set AvansRef.strFilterTblName = 'CONTRACT_P'
				Set AvansRef.nTabInstance = 1
				Set nAll = 0
				If IDK != 0
					If SqlPrepareAndExecute(hSql(), 
							  "SELECT name INTO :sNAME 
							     FROM top_contracts 
							    WHERE pid = :AvansRef.IDK")
						Call SqlFetchNext( hSql(), nFetchRes )
				If RNK != 0
					If SqlPrepareAndExecute(hSql(), 
							  "SELECT nmk INTO :sNMK 
							     FROM customer 
							    WHERE rnk = :AvansRef.RNK")
						Call SqlFetchNext( hSql(), nFetchRes )
				! Показ поля "Номер договора с клиентом"
				If SqlPrepareAndExecute( hSql(), 
						   "SELECT nvl(to_number(val),0) 
						      INTO :nEIK_ND 
						      FROM birja 
						     WHERE par = 'EIK_ND'") 
						AND NOT SqlFetchNext( hSql(), nFetchRes )
					Set nEIK_ND = 0
				If nEIK_ND = 0  
					Call SalHideWindow( sND )
				Else
					Call SalShowWindow( sND )
				! К Н О П К И
				! Привязка ПЛ к К/ТД
				Call ENABLE_BUTTON()
				!
				Call SalWaitCursor( TRUE )
				Call GetNewRef( IMPEXP )
				Set nCheckId = SalStrToNumber(GetGlobalOption( 'VALKVISA' ))
				!
				Set strSqlInsert =
						   "INSERT INTO contract_p 
						     (idp,pid,fdat,kv,s,rnk,kurs,impexp,details) 
						    VALUES
						     (0,:AvansRef.IDK,:AvansRef.FDAT,:AvansRef.KV,
						      :AvansRef.S100,:AvansRef.RNK,:AvansRef.KURS,
						      :AvansRef.IMPEXP,:AvansRef.NAZN)"
				!
				Set strSqlUpdate = 
						   "UPDATE contract_p SET 
						       details = :AvansRef.NAZN 
						     WHERE idp = :AvansRef.IDP"
				!
				Set strSqlDelete = 
						   "DELETE FROM contract_p 
						     WHERE idp = :AvansRef.IDP"
				!
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On UM_Populate
				Call SalSetWindowText(hWndForm, 
						                      IifS(IDK = 0,"Неразобранные платежи",
						                      IifS(nAll = 0,"Авансовые платежи по контракту: "||sNAME,
						                                    "Авансовые платежи по клиенту: "||sNMK)))
				Call ENABLE_BUTTON()
				!
				Set AvansRef.strSqlPopulate =
						   "SELECT p.idp, p.pid, p.ref, p.rnk, c.nmk, c.nd, 
						           p.fdat, nvl(p.s,o.s), nvl(p.s,o.s)/100, 
						           p.kv, p.kurs, nvl(p.komiss,0), 
						           p.acc, a.nls, nvl(p.details,o.nazn), 
						           o.chk, nvl(o.sos,5), t.dig   
						      INTO :AvansRef.IDP,:AvansRef.nPID,:AvansRef.REF,
						           :AvansRef.nRNK,:AvansRef.sNMK,:AvansRef.sND,
						           :AvansRef.FDAT,:AvansRef.S100,:AvansRef.S,
						           :AvansRef.KV,:AvansRef.KURS,:AvansRef.KOMISS, 
						           :AvansRef.ACC,:AvansRef.NLS,:AvansRef.NAZN,
						           :AvansRef.CHK,:AvansRef.SOS,:AvansRef.DIG  
						      FROM contract_p p, customer c, tabval t, oper o, accounts a
						     WHERE p.rnk = c.rnk 
						       AND t.kv = p.kv 
						       AND p.ref = o.ref(+) 
						       AND p.acc = a.acc(+) 
						       AND p.impexp = "||Str(IMPEXP)||
						     " AND ( "||
						  IifS(IDK = 0, " p.pid IS NULL AND p.id IS NULL AND (p.ref IS NOT NULL AND o.sos > 0 OR p.ref IS NULL) ", 
						                " p.pid = "||Str(IDK)||" AND p.id IS NULL ")||
						 " OR "||
						  IifS(RNK = 0, " p.pid IS NOT NULL AND p.ref IS NOT NULL AND o.sos < 0 ", 
						                " p.rnk = "||Str(RNK)||" AND p.pid IS NULL AND p.id IS NULL AND (p.ref IS NOT NULL AND o.sos > 0 OR p.ref IS NULL) ")||
						  IifS(IDK = 0, " ", " OR "||
						                IifS(nAll = 0, 
						                  " p.pid = "||Str(IDK)||" AND p.id IS NULL AND  p.ref IS NOT NULL AND o.sos > 0 ", 
						                  " p.rnk = "||Str(RNK)||" AND p.id IS NULL AND (p.ref IS NOT NULL AND o.sos > 0 OR p.ref IS NULL) "))||
						 " ) ORDER BY 6, 4, 7"
				Call SalTblPopulate( hWndForm, hSql(), strSqlPopulate, TBL_FillAll )
			On SAM_DoubleClick
				If SalTblAnyRows( hWndForm, ROW_Selected, 0 ) AND  AvansRef.REF > 0 
					Call DocViewContentsEx(hWndForm, AvansRef.REF)
			On SAM_FetchRowDone
				Set AvansRef.Ss = Dig4( AvansRef.S, AvansRef.DIG, AvansRef.DIG )
				Set AvansRef.KOMISSs = Dig4( AvansRef.KOMISS/100, AvansRef.DIG, AvansRef.DIG )
				If SalIsNull(AvansRef.REF)
					Call SetTblRowColor( hWndForm, COLOR_Purple )
				Else
					If AvansRef.SOS < 0
						Call SetTblRowColor( hWndForm, COLOR_Red )
					Else If AvansRef.SOS = 1
						Call SetTblRowColor( hWndForm, COLOR_DarkGreen )
					Else If AvansRef.SOS = 3
						Call SetTblRowColor( hWndForm, COLOR_Blue )
					Else
						Call SetTblRowColor( hWndForm, COLOR_Black )
				!
				If NOT SalIsNull(AvansRef.KURS)
					Set AvansRef.SKs = Dig4( AvansRef.S*AvansRef.KURS, AvansRef.DIG, AvansRef.DIG )
			On SAM_Destroy
				Set hWndAvansP = hWndNULL
				Call SalSendClassMessage( SAM_Destroy, 0, 0 )
	Table Window: AvansTD
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
				Width:  16.017"
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
		Description: Авансовые ТД
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
					Resource Id: 40263
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  5.05"
						Begin Y:  Class Default
						End X:  5.05"
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
					Picture File Name: \BARS98\RESOURCE\BMP\BROWSE.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Ввести № и дату реестра ТД'
						On SAM_Click
							Call F_Reestr()
							Call SalSendMsg( AvansTD, UM_Populate, 0, 0 )
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
					Resource Id: 40264
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
						Left:   5.217"
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
					Resource Id: 40265
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
				Pushbutton: pbOK
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbHelp
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.02"
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
							Set strTip = 'Выбрать ТД'
						On SAM_Click
							! nSumOk - Общая сумма выделенных ТД в данной валюте
							Set nTmp = TBL_MinRow
							Set nSumOk = 0
							Set nCount = 0
							While SalTblFindNextRow (AvansTD, nTmp, ROW_Selected, ROW_MarkDeleted)
								Call SalTblSetContext(AvansTD,nTmp)
								Set nCount = nCount + 1
								Set nSumOk = nSumOk + AvansTD.SK
							!
							If nCount = 1 OR (nCount > 1 AND nSumOk <= SUMDEBT/100)
								Set nTmp = TBL_MinRow
								While SalTblFindNextRow (AvansTD, nTmp, ROW_Selected, ROW_MarkDeleted)
									Call SalTblSetContext(AvansTD,nTmp)
									Set AvansTD.nSK_PART = IifN(AvansTD.SK<AvansTD.SUMDEBT/100,AvansTD.SK,AvansTD.SUMDEBT/100 )
									Set AvansTD.sSK_PART = Dig4( AvansTD.nSK_PART,  AvansTD.DIG,  AvansTD.DIG )
									Set AvansTD.nS = IifN(AvansTD.SK<AvansTD.SUMDEBT/100,AvansTD.S,AvansTD.SUMDEBT*AvansTD.KURS_T/100 )
									Call Ret(nS, nSK_PART, sSK_PART)
								Call SalDestroyWindow( AvansTD )
							Else
								Call SalMessageBox( 'Сумма выделенных ТД превышает остаток проплат!', 'Ошибка', MB_IconExclamation )
				Check Box: cbMC2EIK
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Property Template:
					Class DLL Name:
					Title: Прием ТД из файлов MC
					Window Location and Size
						Left:   9.383"
						Top:    0.071"
						Width:  2.9"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Bold
					Text Color: Teal
					Background Color: Default
					Message Actions
						On SAM_Click
							Set nEIK_MC = IifN( cbMC2EIK, 1, 0 )
							If cbMC2EIK
								Call SalShowWindow( FL )
							Else
								Call SalHideWindow( FL )
							Call SalSendMsg( pbRefresh, SAM_Click, 0, 0 )
		Contents
			Column: IDT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						ТД/АКТа
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.067"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: NAME
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Номер 
						ТД / АКТа
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.1"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: DATEDOC
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						ТД/АКТа
				Visible? Yes
				Editable? Yes
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
					On SAM_Validate
						Call F_KURS_TD(AvansTD.DATEDOC, AvansTD.KVK, AvansTD.KV)
			Column: S
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма
						ТД/АКТа
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.583"
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
						Set S100 = S*100
						If SalIsNull( DIG )
							Set DIG = 2
						If NOT SalIsNull(KURS_T) AND KURS_T != 0
							Set SK = S/KURS_T
							Set SKs = Dig4( SK, DIG, DIG )
						Return VALIDATE_Ok
			Column: ISO
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Вал
						ТД/АКТа
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 3
				Data Type: String
				Justify: Center
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
					On SAM_Validate
						If SalIsNull (ISO) 
							Set KV = 0
							Return VALIDATE_Ok
						If SalIsValidInteger(ISO)
							Set sTmp = 'kv'
						Else
							Set sTmp = 'lcv'
							Set ISO = SalStrUpperX( ISO )
						Call SqlPrepareAndExecute( hSql(), 
								    "SELECT kv, lcv, dig 
								       INTO :KV,:ISO,:DIG 
								       FROM tabval 
								      WHERE "||sTmp||"=:ISO" )
						If not SqlFetchNext( hSql(), nFetchRes )
							Return VALIDATE_Cancel
						!
						Call F_KURS_TD(AvansTD.DATEDOC, AvansTD.KVK, AvansTD.KV)
						!
						If NOT SalIsNull(S) AND NOT SalIsNull(KURS_T) AND KURS_T != 0
							If SalIsNull(DIG)
								Set DIG = 2
							Set SK = S/KURS_T
							Set SKs = Dig4( SK, DIG, DIG )
						Return VALIDATE_Ok
			Column: KV
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
			Column: KURS_T
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Курс
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.383"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
						If NOT SalIsNull(S) AND NOT SalIsNull(KURS_T) AND KURS_T != 0
							If SalIsNull(DIG)
								Set DIG = 2
							Set SK = S/KURS_T
							Set SKs = Dig4( SK, DIG, DIG )
						Return VALIDATE_Ok
			Column: DIG
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
			Column: SKs
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма в вал. 
						контракта
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
				Width:  1.633"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: ISOK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Вал
						контр.
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
				Data Type: String
				Justify: Center
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
			Column: REESTR
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: № реестра
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 50
				Data Type: String
				Justify: Left
				Width:  2.02"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: DATR
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						реестра
				Visible? Yes
				Editable? Yes
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
			Column: SK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма ТД
						в валюте
						контракта
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.667"
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
			Column: S100
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма
						из ТД
				Visible? No
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.329"
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
					On SAM_Validate
						Set S100 = S*100
						Return VALIDATE_Ok
			Column: PPID
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма
						из ТД
				Visible? No
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.329"
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
					On SAM_Validate
						Set S100 = S*100
						Return VALIDATE_Ok
			Column: FL
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Отм.
						MC*
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  0.533"
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
						If SOS = 1 AND FL
							Call SalTblSetRowFlags( AvansTD, SalTblQueryContext( AvansTD ), ROW_Edited, FALSE )
							Call SalTblSetRowFlags( AvansTD, SalTblQueryContext( AvansTD ), ROW_New, TRUE )
						If SOS = 1 AND NOT FL
							Call SalTblSetRowFlags( AvansTD, SalTblQueryContext( AvansTD ), ROW_Edited, FALSE )
							Call SalTblSetRowFlags( AvansTD, SalTblQueryContext( AvansTD ), ROW_New, FALSE )
			! SOS=0 - существующие ТД (tamozhdoc)
			! SOS=1 - прием ТД из МС  (customs_decl)
			! SOS=2 - ручной ввод ТД  (insert)
			Column: SOS
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
			! Имя и дата создания файла МС, № информ.строки
			Column: MC_FN
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
			Column: MC_DAT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title:
				Visible? No
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Date/Time
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
			Column: MC_N
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
			Function: Ret
				Description: Вставка строки с ТД в соответствующую SOST 
				Returns
				Parameters
					! !! Сумма в ГРН, деленная на 100
					Number: pS
					! !! Сумма в вал.контракта, деленная на 100
					Number: pSK_PART
					String: pSK_PARTs
				Static Variables
				Local variables
				Actions
					If IMPEXP = 0
						If not SalTblAnyRows(SOST_EXP.tblT, ROW_New, 0)
							Call SalTblDefineSplitWindow(SOST_EXP.tblT, 3, TBL_Split_Adjustable)
						Set nRow = SalTblInsertRow(SOST_EXP.tblT, TBL_MinRow)
						Call SalTblSetContext(SOST_EXP.tblT, nRow)
						!
						Set SOST_EXP.tblT.IDT     =  AvansTD.IDT
						Set SOST_EXP.tblT.NAME    =  AvansTD.NAME
						Set SOST_EXP.tblT.DATEDOC =  AvansTD.DATEDOC
						Set SOST_EXP.tblT.S       =  pS
						Set SOST_EXP.tblT.S100    =  SalNumberRound(pS*100)
						Set SOST_EXP.tblT.SK      =  pSK_PART
						Set SOST_EXP.tblT.SKs     =  pSK_PARTs
						Set SOST_EXP.tblT.KURS_T  =  AvansTD.KURS_T
						Set SOST_EXP.tblT.ISO     =  AvansTD.ISO
						Set SOST_EXP.tblT.KV      =  AvansTD.KV
						Set SOST_EXP.tblT.DIG     =  AvansTD.DIG
						Set SOST_EXP.tblT.REESTR  =  AvansTD.REESTR
						Set SOST_EXP.tblT.DATR    =  AvansTD.DATR
						Call SalTblSetFocusCell(SOST_EXP.tblT, nRow, GetFirstEditableColumn(SOST_EXP.tblT), 0, 1)
					Else
						If not SalTblAnyRows(SOST_IMP.tblT, ROW_New, 0)
							Call SalTblDefineSplitWindow(SOST_IMP.tblT, 3, TBL_Split_Adjustable)
						Set nRow = SalTblInsertRow(SOST_IMP.tblT, TBL_MinRow)
						Call SalTblSetContext(SOST_IMP.tblT, nRow)
						! Ввод кросс-курса АКТа/ТД по отношению к валюте ПЛАТЕЖА
						If KVP != NUMBER_Null AND KVP != KV
							Call SalModalDialog( dlg_IMPTD, hWndMDI, nAkt, AvansTD.KVP, AvansTD.KV, pS, AvansTD.DATEDOC, nKURSPL)
						Else
							Set nKURSPL = 1
						!
						Set SOST_IMP.tblT.IDT     =  AvansTD.IDT
						Set SOST_IMP.tblT.NAME    =  AvansTD.NAME
						Set SOST_IMP.tblT.DATEDOC =  AvansTD.DATEDOC
						Set SOST_IMP.tblT.S       =  pS
						Set SOST_IMP.tblT.S100    =  SalNumberRound(pS*100)
						Set SOST_IMP.tblT.SK      =  pSK_PART
						Set SOST_IMP.tblT.SKs     =  pSK_PARTs
						Set SOST_IMP.tblT.ISO     =  AvansTD.ISO
						Set SOST_IMP.tblT.KV      =  AvansTD.KV
						Set SOST_IMP.tblT.KURS_T  =  AvansTD.KURS_T
						Set SOST_IMP.tblT.REESTR  =  AvansTD.REESTR
						Set SOST_IMP.tblT.DATR    =  AvansTD.DATR
						Set SOST_IMP.tblT.KURS_PL =  AvansTD.nKURSPL
						Call SalTblSetFocusCell(SOST_IMP.tblT, nRow, GetFirstEditableColumn(SOST_IMP.tblT), 0, 1)
			Function: F_Reestr
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					String: rNAME
					Date/Time: rDAT
					Number: nTmp
				Actions
					Call SalModalDialog(dlg_REESTR, hWndForm, rNAME, rDAT)
					If rNAME != STRING_Null AND rDAT != DATETIME_Null
						Set nTmp = TBL_MinRow
						Loop
							If SalTblFindNextRow (AvansTD, nTmp, ROW_Selected, 0)
								Call SalTblSetContext(AvansTD, nTmp)
								If nTmp >=0
									If SqlPrepareAndExecute(hSql(),
											  "UPDATE tamozhdoc 
											      SET registry_num = :rNAME,
											          registry_dat = :rDAT
											    WHERE idt = :AvansTD.IDT")
										Call SqlCommit(hSql())
									Else
										Call Debug('Ошибка при сохранении изменений!')
										Call SqlRollback(hSql())
							Else
								Break
					Else
						Call Debug('Не указан номер и/или дата реестра!')
						Return FALSE
					!
					Return TRUE
			Function: F_KURS_TD
				Description: Вычисление курса ТД (кросс-курса или относит.ГРН)
				Returns
				Parameters
					Date/Time: dDAT
					Number: nKVK
					Number: nKVT
				Static Variables
				Local variables
					Number: nKurs
				Actions
					If dDAT != DATETIME_Null AND nKVK != NUMBER_Null AND nKVT != NUMBER_Null
						If nKVK = nKVT 
							If nAkt = 0
								If SqlPrepareAndExecute( hSqlAux2(),
										   "SELECT rate_o/bsum INTO :AvansTD.KURS_T
										    FROM cur_rates
										    WHERE kv=:nKVT AND VDATE =
										         (SELECT max(VDATE) FROM cur_rates
										          WHERE kv=:nKVT and vdate <=:dDAT)")
									Call SqlFetchNext( hSqlAux2(), nFetchRes )
							Else
								Set AvansTD.KURS_T = 1
						Else
							If GetXRate( nKurs, nKurs, nKurs, nKVK, nKVT, dDAT )
								Set AvansTD.KURS_T = SalStrToNumber(SalNumberToStrX(nKurs,8))
			Function: TITLE
				Description:
				Returns
					Boolean: bOK
				Parameters
					Number: nAct
				Static Variables
				Local variables
				Actions
					If nAct = 0
						Call SalTblSetColumnTitle( AvansTD.IDT, 
								'Код 
								ТД ')
						Call SalTblSetColumnTitle( AvansTD.NAME,
								'Номер 
								ТД')
						Call SalTblSetColumnTitle( AvansTD.DATEDOC,
								'Дата 
								ТД')
						Call SalTblSetColumnTitle( AvansTD.S,
								'Сумма ТД 
								в нац.валюте' )
						Call SalTblSetColumnTitle( AvansTD.ISO,
								'Вал 
								ТД')
						Call SalTblSetColumnTitle( AvansTD.KURS_T,
								'Курс')
					Else
						Call SalTblSetColumnTitle( AvansTD.IDT,
								'Код 
								АКТа')
						Call SalTblSetColumnTitle( AvansTD.NAME,
								'Номер 
								АКТа')
						Call SalTblSetColumnTitle( AvansTD.DATEDOC,
								'Дата 
								АКТа')
						Call SalTblSetColumnTitle( AvansTD.S,
								'Сумма АКТа')
						Call SalTblSetColumnTitle( AvansTD.ISO,
								'Вал 
								 АКТа')
						Call SalTblSetColumnTitle( AvansTD.KURS_T,
								'Кросс- 
								 курс')
					Return TRUE
		Window Parameters
			Number: IMPEXP
			Number: MODE !! 9 - просмотр  
			Number: RNK
			Number: PID
			String: NAMEK
			Number: KVK
			Number: KVP
			Number: SUMDEBT
			Window Handle: hWndParent
		Window Variables
			Number: nRow
			String: sNMK
			String: sKV
			String: sKV_NAME
			Number: nDIG
			Number: nCOUNTRY
			Date/Time: dDAT1
			Date/Time: dDAT2
			String: sTmp
			Number: nFetchRes
			Number: nS
			Number: nSK_PART
			String: sSK_PART
			Number: nTmp
			Number: nSumOk
			Number: nCount
			Number: nMin
			Number: nEIK_MC
			Number: nAkt
			!
			Number: mIDT
			String: mNAME
			Date/Time: mDATEDOC
			Number: mS
			Number: mS100
			Number: mKURS_T
			Number: mKV
			String: mISO
			Number: mDIG
			Number: mSK
			Number: mSOS
			String: mFN
			Date/Time: mDAT
			Number: mNS
			String: mNAMER
			Date/Time: mDATER
			!
			Number: nKURSPL
		Message Actions
			On SAM_Create
				Call SalWaitCursor( TRUE )
				Call SalCenterWindow( hWndForm )
				Set AvansTD.strFilterTblName = 'tamozhdoc'
				Set AvansTD.strPrintFileName='avans_td'
				If SqlPrepareAndExecute( hSql(), 
						   "SELECT nmk INTO :sNMK FROM customer WHERE rnk=:AvansTD.RNK" )
					Call SqlFetchNext( hSql(), nFetchRes )
				! Валюта ТД может отличаться от валюты контракта
				If AvansTD.KVK != NUMBER_Null
					If SqlPrepareAndExecute( hSql(), 
							   "SELECT lcv, dig, upper(name) 
							    INTO :sKV, :nDIG, :sKV_NAME 
							    FROM tabval 
							    WHERE kv=:AvansTD.KVK" )
						Call SqlFetchNext( hSql(), nFetchRes )
				!
				Set nAkt = 0
				If AvansTD.PID != NUMBER_Null
					Call SalShowWindow( ISOK )
					If SqlPrepareAndExecute( hSql(), 
							   "SELECT benefcountry, dateopen, dateclose, 
							           DECODE(nvl(id_oper,1), 1, 0, 1) 
							      INTO :nCOUNTRY, :dDAT1, :dDAT2, :nAkt 
							      FROM top_contracts 
							     WHERE pid = :AvansTD.PID" )
						Call SqlFetchNext( hSql(), nFetchRes )
					! Подбор ТД из файлов MC*
					If SqlPrepareAndExecute( hSql(), 
							   "SELECT nvl(to_number(val),0) INTO :nEIK_MC FROM birja WHERE par='MC2EIK'") 
							AND NOT SqlFetchNext( hSql(), nFetchRes )
						Set nEIK_MC = 0
					If nAkt = 1
						Set nEIK_MC = 0
					Set cbMC2EIK = IifN( nEIK_MC = 1, TRUE, FALSE )
					If nEIK_MC = 0
						Call SalHideWindow( cbMC2EIK )
						Call SalHideWindow( FL )
					Else
						Call SalShowWindow( cbMC2EIK )
						Call SalShowWindow( FL )
					If AvansTD.PID = 0
						Set nAkt = 0
				Else
					Call SalHideWindow( cbMC2EIK )
					Call SalHideWindow( FL )
					Call SalHideWindow( ISOK )
				!
				If nAkt = 0
					! Call SalEnableWindow(S)
					! Call SalEnableWindow(KURS_T)
					! Call SalDisableWindow(SKs)
					! Call SalShowWindow(KURS_T)
					! Call SalShowWindow(S)
					Call SalShowWindow(REESTR)
					Call SalShowWindow(DATR)
				Else
					! Call SalDisableWindow(S)
					! Call SalDisableWindow(KURS_T)
					! Call SalEnableWindow(SKs)
					! Call SalHideWindow(KURS_T)
					! Call SalHideWindow(S)
					Call SalHideWindow(REESTR)
					Call SalHideWindow(DATR)
				Call TITLE (nAkt)
				!
				If SUMDEBT <= 0
					Call SalDisableWindow( pbOK )
				! Просмотр
				If MODE = 9
					Set hWndForm.AvansTD.nFlags = GT_ReadOnly    
					Call SalDisableWindow( pbDetails )
					Call SalDisableWindow( pbOK )
				! Заголовок окна
				Call SalSetWindowText( hWndForm, 
						   IifS (nAkt = 0, 'Авансовые таможенные декларации ', 'Акты выполненных работ ')||
						   IifS(AvansTD.NAMEK=STRING_Null,
						                 'по клиенту '||Str(AvansTD.RNK)||' '||sNMK, 
						                 'по контракту: ' ||AvansTD.NAMEK )||
						   IifS(AvansTD.sKV=STRING_Null,' ','.  Валюта: ' ||AvansTD.sKV_NAME ))
				!
				Set AvansTD.strSqlPopulate =
						    "SELECT tamozhdoc.idt, tamozhdoc.name, tamozhdoc.datedoc,
						            tamozhdoc.s/100, tamozhdoc.s, tamozhdoc.kurs,
						            tamozhdoc.kv, v.lcv, v.dig, 
						            tamozhdoc.s/tamozhdoc.kurs/100, tamozhdoc.registry_num, tamozhdoc.registry_dat,
						            tamozhdoc.pid, 1, 0 
						       INTO :AvansTD.IDT,   :AvansTD.NAME,  :AvansTD.DATEDOC,
						            :AvansTD.S,     :AvansTD.S100,  :AvansTD.KURS_T,
						            :AvansTD.KV,    :AvansTD.ISO,   :AvansTD.DIG,   
						            :AvansTD.SK,    :AvansTD.REESTR,:AvansTD.DATR,  
						            :AvansTD.PPID,  :AvansTD.FL,    :AvansTD.SOS 
						       FROM tamozhdoc, 
						            tabval v
						      WHERE tamozhdoc.kv = v.kv 
						        AND tamozhdoc.id IS NULL 
						        AND tamozhdoc.impexp = :AvansTD.IMPEXP 
						        AND tamozhdoc.rnk = "||Str(AvansTD.RNK)||
						       IifS(AvansTD.PID = NUMBER_Null," ",
						    "   AND (tamozhdoc.pid IS NULL OR tamozhdoc.pid=:AvansTD.PID) ")||
						    " ORDER BY tamozhdoc.datedoc"    
				Set AvansTD.strSqlInsert =
						    "INSERT INTO tamozhdoc
						      (idt, name, datedoc, s, kv, kurs, pid, rnk, registry_num, registry_dat, impexp) 
						     VALUES 
						      (0,:AvansTD.NAME,:AvansTD.DATEDOC,:AvansTD.S100,
						         :AvansTD.KV,  :AvansTD.KURS_T, :AvansTD.PID,
						         :AvansTD.RNK, :AvansTD.REESTR, :AvansTD.DATR, :AvansTD.IMPEXP)" 
				Set AvansTD.strSqlUpdate = 
						    "UPDATE tamozhdoc SET 
						          name = :AvansTD.NAME,
						       datedoc = :AvansTD.DATEDOC,
						             s = :AvansTD.S100,
						            kv = :AvansTD.KV,
						          kurs = :AvansTD.KURS_T,
						  registry_num = :AvansTD.REESTR,
						  registry_dat = :AvansTD.DATR,
						           rnk = :AvansTD.RNK  
						     WHERE idt = :AvansTD.IDT" 
				Set AvansTD.strSqlDelete = 
						   "DELETE FROM tamozhdoc WHERE idt=:AvansTD.IDT"
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On UM_Populate
				Call SalWaitCursor( TRUE )
				Call SalSendClassMessage(UM_Populate, 0, 0)
				! Подбор ТД из файлов MC*
				If nEIK_MC = 1
					Call SalTblDefineSplitWindow ( hWndForm, 6 , TRUE )
					If SqlPrepareAndExecute(hSqlAux(),
							  "SELECT id_td, name_td, date_td, kv_td, lcv, dig, s_td/100, s_td, 
							          kurs_td, round(s_td/kurs_td/100, 2), name_r, date_r, 1, 
							          mc_fn, mc_dat, mc_num
							     INTO :mIDT,
							          :mNAME,
							          :mDATEDOC,
							          :mKV,
							          :mISO,
							          :mDIG,
							          :mS,
							          :mS100,
							          :mKURS_T,
							          :mSK,
							          :mNAMER,
							          :mDATER,
							          :mSOS,
							          :mFN,
							          :mDAT,
							          :mNS
							     FROM v_tamozhdoc_free
							    WHERE fl                  = 1
							      AND rnk                 = "           ||Str(AvansTD.RNK)                             ||"
							      AND impexp              = "           ||Str(AvansTD.IMPEXP)                          ||"
							      AND benefcountry        = "           ||Str(nCOUNTRY)                                ||"
							      AND trim(upper(name_k)) = '"          ||SalStrTrimX(SalStrUpperX(AvansTD.NAMEK))||"'"||"
							      AND to_char(date_k, 'dd.mm.yyyy') = '"||SalFmtFormatDateTime(dDAT1,'dd.MM.yyyy')||"'"||"
							    ORDER BY date_td")
						While SqlFetchNext( hSqlAux(),nFetchRes )
							Set nRow = TBL_MinRow
							Call SalTblInsertRow( AvansTD,  nRow)
							Call XSalTblSetCellBackColor( AvansTD.IDT,     SalColorFromRGB( 230,255,255 ))
							Call XSalTblSetCellBackColor( AvansTD.NAME,    SalColorFromRGB( 230,255,255 ))  
							Call XSalTblSetCellBackColor( AvansTD.DATEDOC, SalColorFromRGB( 230,255,255 ))
							Call XSalTblSetCellBackColor( AvansTD.S,       SalColorFromRGB( 230,255,255 ))
							Call XSalTblSetCellBackColor( AvansTD.ISO,     SalColorFromRGB( 230,255,255 ))
							Call XSalTblSetCellBackColor( AvansTD.KURS_T,  SalColorFromRGB( 230,255,255 ))
							Call XSalTblSetCellBackColor( AvansTD.SKs,     SalColorFromRGB( 230,255,255 ))
							Call XSalTblSetCellBackColor( AvansTD.REESTR,  SalColorFromRGB( 230,255,255 ))
							Call XSalTblSetCellBackColor( AvansTD.DATR,    SalColorFromRGB( 230,255,255 ))
							Call XSalTblSetCellBackColor( AvansTD.FL,      SalColorFromRGB( 230,255,255 ))
							Call SalTblSetContext(AvansTD,nRow)
							Set AvansTD.IDT = mIDT
							Set AvansTD.NAME = mNAME
							Set AvansTD.DATEDOC = mDATEDOC
							Set AvansTD.S = mS
							Set AvansTD.S100 = mS100
							Set AvansTD.KURS_T = mKURS_T
							Set AvansTD.KV = mKV
							Set AvansTD.ISO = mISO
							Set AvansTD.DIG = mDIG
							Set AvansTD.SK = mSK
							Set AvansTD.SKs = Dig4( mSK, mDIG, mDIG )
							Set AvansTD.SOS = mSOS
							Set AvansTD.REESTR = mNAMER
							Set AvansTD.DATR = mDATER
							Set AvansTD.MC_FN = mFN 
							Set AvansTD.MC_DAT = mDAT 
							Set AvansTD.MC_N = mNS
					Call SalTblSetFlagsAnyRows( hWndForm, ROW_New, FALSE, 0, 0 )
				! If nEIK_MC = 1
					              Call SalTblDefineSplitWindow ( hWndForm, 6 , TRUE )
					              If SqlPrepareAndExecute(hSqlAux(),
							  "SELECT v.cnum_cst || '/' || substr(v.cnum_year,-1,1) || '/' || v.cnum_num, 
							          trunc(v.allow_dat), 
							          v.kv, 
							          t.lcv, 
							          t.dig, 
							          v.s/100, 
							          v.s, 
							          v.kurs/power(10,8), 
							          round((v.s/100) / (v.kurs/power(10,8)), 2), 
							          1, 
							          v.fn, 
							          v.dat, 
							          v.n
							     INTO :mNAME,
							          :mDATEDOC,
							          :mKV,
							          :mISO,
							          :mDIG,
							          :mS,
							          :mS100,
							          :mKURS_T,
							          :mSK,
							          :mSOS,
							          :mFN,
							          :mDAT,
							          :mNS
							     FROM customs_decl v, country c, customer k, tabval t
							    WHERE v.kv = t.kv  
							      AND to_number(v.f_country) = c.country      
							      AND v.isnull = 1 
							      AND nvl(v.fl_eik,0) = 0       
							      AND v.f_okpo = k.okpo 
							      AND k.rnk                                  = "||Str(AvansTD.RNK)|| 
							  "   AND decode(to_number(v.cmode_code),40,1,0) = "||Str(AvansTD.IMPEXP)|| 
							  "   AND to_number(v.f_country)                 = "||Str(nCOUNTRY)||
							  "   AND trim(upper(TranslateDos2Win(v.doc)))   = '"||SalStrTrimX(SalStrUpperX(AvansTD.NAMEK))||"'"||
							  "   AND to_char(v.sdate,'dd.mm.yyyy')          = '"||SalFmtFormatDateTime( dDAT1, 'dd.MM.yyyy' )||"'"||
							  " ORDER BY trunc(v.allow_dat)")
						              While SqlFetchNext( hSqlAux(),nFetchRes )
							              Set nRow = TBL_MinRow
							              Call SalTblInsertRow( AvansTD,  nRow)
							              Call XSalTblSetCellBackColor( AvansTD.IDT,     SalColorFromRGB( 230,255,255 ))
							              Call XSalTblSetCellBackColor( AvansTD.NAME,    SalColorFromRGB( 230,255,255 ))  
							              Call XSalTblSetCellBackColor( AvansTD.DATEDOC, SalColorFromRGB( 230,255,255 ))
							              Call XSalTblSetCellBackColor( AvansTD.S,       SalColorFromRGB( 230,255,255 ))
							              Call XSalTblSetCellBackColor( AvansTD.ISO,     SalColorFromRGB( 230,255,255 ))
							              Call XSalTblSetCellBackColor( AvansTD.KURS_T,  SalColorFromRGB( 230,255,255 ))
							              Call XSalTblSetCellBackColor( AvansTD.SKs,     SalColorFromRGB( 230,255,255 ))
							              Call XSalTblSetCellBackColor( AvansTD.REESTR,  SalColorFromRGB( 230,255,255 ))
							              Call XSalTblSetCellBackColor( AvansTD.DATR,    SalColorFromRGB( 230,255,255 ))
							              Call XSalTblSetCellBackColor( AvansTD.FL,      SalColorFromRGB( 230,255,255 ))
							              Call SalTblSetContext(AvansTD,nRow)
							              Set AvansTD.NAME = mNAME
							              Set AvansTD.DATEDOC = mDATEDOC
							              Set AvansTD.S = mS
							              Set AvansTD.S100 = mS100
							              Set AvansTD.KURS_T = mKURS_T
							              Set AvansTD.KV = mKV
							              Set AvansTD.ISO = mISO
							              Set AvansTD.DIG = mDIG
							              Set AvansTD.SK = mSK
							              Set AvansTD.SKs = Dig4( mSK, mDIG, mDIG )
							              Set AvansTD.SOS = mSOS
							              Set AvansTD.MC_FN = mFN 
							              Set AvansTD.MC_DAT = mDAT 
							              Set AvansTD.MC_N = mNS
					              Call SalTblSetFlagsAnyRows( hWndForm, ROW_New, FALSE, 0, 0 )
				Call SalWaitCursor( FALSE )
			On UM_Insert
				Call SalSendClassMessage( UM_Insert, 0, 0 )
				If nAkt = 1
					Set NAME = 'АКТ '
				If AvansTD.KVK != NUMBER_Null
					Set AvansTD.KV   = AvansTD.KVK
					Set AvansTD.ISO  = AvansTD.sKV
					Set AvansTD.DIG  = AvansTD.nDIG
					Set AvansTD.ISOK = sKV
				Set SOS = 2
				Call SalTblSetFocusCell(hWndForm, SalTblQueryContext( hWndForm ), NAME, 0, -1)
			On UM_Update
				Set nMin = TBL_MinRow
				While SalTblFindNextRow( AvansTD, nMin, ROW_New, ROW_MarkDeleted )
					Call SalTblSetContext( AvansTD, nMin )
					If SOS = 1 AND FL
						Call SqlPrepareAndExecute(hSql(),
								"UPDATE customs_decl SET 
								     fl_eik = 1
								  WHERE  fn = :AvansTD.MC_FN
								    AND dat = :AvansTD.MC_DAT
								    AND   n = :AvansTD.MC_N")
				!
				Set nMin = TBL_MinRow
				While SalTblFindNextRow( AvansTD, nMin, ROW_MarkDeleted, 0 )
					Call SalTblSetContext( AvansTD, nMin )
					If SOS = 1
						Call SqlPrepareAndExecute(hSql(),
								"UPDATE customs_decl SET 
								     fl_eik = 1
								  WHERE  fn = :AvansTD.MC_FN
								    AND dat = :AvansTD.MC_DAT
								    AND   n = :AvansTD.MC_N")
				!
				Call SalSendClassMessage(UM_Update, 0, 0)
			On SAM_FetchRowDone
				Set SKs = Dig4( SK, DIG, DIG )
				If SalIsNull( PPID )
					Call XSalTblSetRowBackColor( AvansTD, lParam, COLOR_LightGray )
				If AvansTD.KVK != NUMBER_Null AND AvansTD.KV != AvansTD.KVK
					Call SetTblRowColor( AvansTD, COLOR_DarkGreen )
				If AvansTD.KVK != NUMBER_Null
					Set AvansTD.ISOK = sKV
			On SAM_Destroy
				Set hWndAvansT = hWndNULL
				Call SalSendClassMessage( SAM_Destroy, 0, 0 )
	Table Window: AvansTDR
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
				Width:  16.067"
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
		Description: ВВод ТД с реестра или импорт из файлов MC
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
					Resource Id: 48473
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  5.05"
						Begin Y:  Class Default
						End X:  5.05"
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
					Picture File Name: \BARS98\RESOURCE\BMP\BROWSE.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Ввести № и дату реестра ТД'
						On SAM_Click
							Call F_Reestr()
							Call SalSendMsg( AvansTDR, UM_Populate, 0, 0 )
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
					Resource Id: 48474
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
						Left:   4.017"
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
					Resource Id: 48475
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
			Column: FL
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ТД
						из
						MC*
				Visible? No
				Editable? No
				Maximum Data Length: 1
				Data Type: Number
				Justify: Left
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
						Check Value: 1
						Uncheck Value: 0
						Ignore Case? Yes
				List Values
				Message Actions
			Column: OTM
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Виза
						для
						MC*
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  0.567"
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
						If FL = 1 AND OTM
							Call SalTblSetRowFlags( AvansTDR, SalTblQueryContext( AvansTDR ), ROW_Edited, FALSE )
							Call SalTblSetRowFlags( AvansTDR, SalTblQueryContext( AvansTDR ), ROW_New,    TRUE )
						If FL = 1 AND NOT OTM
							Call SalTblSetRowFlags( AvansTDR, SalTblQueryContext( AvansTDR ), ROW_Edited, FALSE )
							Call SalTblSetRowFlags( AvansTDR, SalTblQueryContext( AvansTDR ), ROW_New,    FALSE )
			!
			Column: IDT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						ТД
						
				Visible? Yes
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
			Column: RNK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Рег.№
						клиента
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  0.967"
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
					On SAM_Validate
						If SqlPrepareAndExecute(hSqlAux(),
								  "SELECT nmk, okpo, nd 
								     INTO :AvansTDR.NMK,:AvansTDR.OKPO,:AvansTDR.ND 
								     FROM customer 
								    WHERE rnk = "||Str(RNK))
								and not SqlFetchNext(hSqlAux(), nFetchRes)
							Return VALIDATE_Cancel
						Return VALIDATE_Ok
			Column: ND
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: №
						договора
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
				Width:  0.983"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Title: Клиент
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.05"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Title: Код ОКПО
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 14
				Data Type: String
				Justify: Right
				Width:  1.283"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
						If SqlPrepareAndExecute(hSqlAux(),
								  "SELECT rnk, nmk, nd
								     INTO :AvansTDR.RNK,:AvansTDR.NMK,:AvansTDR.ND 
								     FROM customer 
								    WHERE rownum = 1 
								      AND date_off IS NULL 
								      AND okpo = :AvansTDR.OKPO")
								and not SqlFetchNext(hSqlAux(), nFetchRes)
							Return VALIDATE_Cancel
						Return VALIDATE_Ok
			Column: NAME
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Тамож.
						Документ
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
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
			Column: DATEDOC
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						из ТД
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
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
			Column: S
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма в
						нац.вал.
						из ТД
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.5"
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
						Set S100 = S*100
						If SalIsNull(DIG)
							Set DIG = 2
						If NOT SalIsNull(KURS_T) AND KURS_T != 0
							Set SK = S/KURS_T
							Set SKs = Dig4(SK, DIG, DIG)
						Return VALIDATE_Ok
			Column: ISO
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						вал
						
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
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
					On SAM_Validate
						If SalIsNull(ISO) 
							Set KV = 0
							Return VALIDATE_Ok
						If SalIsValidInteger(ISO)
							Set sTmp = 'kv'
						Else
							Set sTmp = 'lcv'
							Set ISO = SalStrUpperX(ISO)
						Call SqlPrepareAndExecute(hSql(), 
								    "SELECT kv, lcv, dig 
								       INTO :KV,:ISO,:DIG 
								       FROM tabval 
								      WHERE "||sTmp||" = :ISO")
						If not SqlFetchNext(hSql(), nFetchRes)
							Return VALIDATE_Cancel
						If NOT SalIsNull(S) AND NOT SalIsNull(KURS_T) AND KURS_T != 0
							If SalIsNull(DIG)
								Set DIG = 2
							Set SK = S/KURS_T
							Set SKs = Dig4(SK, DIG, DIG)
						Return VALIDATE_Ok
			Column: KV
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
			Column: KURS_T
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Курс
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
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
					On SAM_Validate
						If NOT SalIsNull(S) AND NOT SalIsNull(KURS_T) AND KURS_T != 0
							If SalIsNull(DIG)
								Set DIG = 2
							Set SK = S/KURS_T
							Set SKs = Dig4(SK, DIG, DIG)
						Return VALIDATE_Ok
			Column: DIG
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
			Column: SKs
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма ТД
						в валюте
						контракта
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
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
			Column: REESTR
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: № реестра
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 50
				Data Type: String
				Justify: Left
				Width:  1.883"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: DATR
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						реестра
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.05"
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
			Column: SK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма ТД
						в валюте
						контракта
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.667"
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
			Column: S100
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма
						из ТД
				Visible? No
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.329"
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
					On SAM_Validate
						Set S100 = S*100
						Return VALIDATE_Ok
			! Имя и дата создания файла МС, № информ.строки
			Column: MC_FN
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
			Column: MC_DAT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title:
				Visible? No
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Date/Time
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
			Column: MC_N
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
			! Данные о контракте (только для FL = 1)
			Column: NAMEK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Номер
						контракта
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
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
			Column: DATEK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						контракта
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.033"
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
			Column: BENEFCOUNTRY
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						страны
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
				Data Type: Number
				Justify: Right
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
			Column: BENEFNAME
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Наименование
						нерезидента
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.383"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
			Function: F_Reestr
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					String: rNAME
					Date/Time: rDAT
					Number: nTmp
				Actions
					Call SalModalDialog(dlg_REESTR, hWndForm, rNAME, rDAT)
					If rNAME != STRING_Null AND rDAT != DATETIME_Null
						Set nTmp = TBL_MinRow
						While SalTblFindNextRow (AvansTDR, nTmp, ROW_Selected, 0)
							Call SalTblSetContext(AvansTDR,nTmp)
							If FL = 0
								If SqlPrepareAndExecute(hSql(),
										  "UPDATE tamozhdoc 
										      SET registry_num = :rNAME,
										          registry_dat = :rDAT
										    WHERE idt = :AvansTDR.IDT")
									Call SqlCommit(hSql())
								Else
									Call Debug('Ошибка при сохранении изменений!')
									Call SqlRollback(hSql())
					Else
						Call Debug('Не указан номер и/или дата реестра!')
						Return FALSE
					Return TRUE
		Window Parameters
			Number: IMPEXP
			String: sAccessType   !! ''-полный доступ, 'READ_ONLY' - просмотр
			String: sOuterFilter  !! внешний фильтр
		Window Variables
			Number: nRow
			Date/Time: dBD
			Number: nEIK_ND
			String: sTmp
			Number: nFetchRes
			Number: nS
			Number: nSumOk
			Number: nIDT
			Number: nCount
			Number: nMin
		Message Actions
			On SAM_Create
				Call SalCenterWindow(hWndForm)
				Set AvansTDR.nTabInstance = 1
				Set dBD = GetBankDate(  )
				Set AvansTDR.fFilterAtStart = TRUE
				Set AvansTDR.strPrintFileName = 'TD_FREE'
				Set AvansTDR.strFilterTblName = 'V_TAMOZHDOC_FREE'
				Set nIDT = 0
				! Заголовок окна 
				Call SalSetWindowText(hWndForm,
						     'Ввод/прием таможенных деклараций '||
						     IifS(AvansTDR.IMPEXP = 0, 'по экспорту', 'по импорту'))
				Call SalWaitCursor(TRUE)
				! Показ поля "Номер договора с клиентом"
				If SqlPrepareAndExecute(hSql(), 
						   "SELECT nvl(to_number(val),0) 
						      INTO :nEIK_ND 
						      FROM birja 
						     WHERE par = 'EIK_ND'") 
						AND NOT SqlFetchNext(hSql(), nFetchRes)
					Set nEIK_ND = 0
				If nEIK_ND = 0  
					Call SalHideWindow(ND)
				Else
					Call SalShowWindow(ND)
				! Полный доступ / просмотр
				If sAccessType = 'READ_ONLY'
					Call SalDisableWindow( pbDetails    )
					Call SalDisableWindow( pbIns        ) 
					Call SalDisableWindow( pbDel        )
					Call SalDisableWindow( pbUpdate     )
					Call SalHideWindow   ( AvansTDR.OTM )
				Else
					Call SalEnableWindow( pbDetails    )
					Call SalEnableWindow( pbIns        ) 
					Call SalEnableWindow( pbDel        )
					Call SalEnableWindow( pbUpdate     )
					Call SalShowWindow  ( AvansTDR.OTM )
				!
				Set AvansTDR.strSqlPopulate =
						    "SELECT rnk, nmk, okpo, nd, 
						            id_td, name_td, date_td, 
						            kv_td, s_td/100, s_td, kurs_td, 
						            lcv, dig, round(s_td/kurs_td/100,2),
						            name_r, date_r, 
						            fl, name_k, date_k, 
						            benefcountry, benefname,
						            mc_fn, mc_dat, mc_num
						       INTO :AvansTDR.RNK,   :AvansTDR.NMK,    :AvansTDR.OKPO,   :AvansTDR.ND,
						            :AvansTDR.IDT,   :AvansTDR.NAME,   :AvansTDR.DATEDOC,
						            :AvansTDR.KV,    :AvansTDR.S,      :AvansTDR.S100,   :AvansTDR.KURS_T,
						            :AvansTDR.ISO,   :AvansTDR.DIG,    :AvansTDR.SK,          
						            :AvansTDR.REESTR, :AvansTDR.DATR,
						            :AvansTDR.FL,    :AvansTDR.NAMEK,  :AvansTDR.DATEK,
						            :AvansTDR.BENEFCOUNTRY,            :AvansTDR.BENEFNAME,
						            :AvansTDR.MC_FN, :AvansTDR.MC_DAT, :AvansTDR.MC_N
						       FROM v_tamozhdoc_free
						      WHERE impexp = "||Str(AvansTDR.IMPEXP)
						     ||  IifS(sOuterFilter = STRING_Null, " ", " AND "||sOuterFilter)
						     ||  " ORDER BY rnk, date_k, name_k, date_td, name_td"    
				Set AvansTDR.strSqlInsert =
						    "INSERT INTO tamozhdoc
						      (idt, name, datedoc, s, kv, kurs, rnk, registry_num, registry_dat, impexp) 
						     VALUES 
						      (:AvansTDR.nIDT,:AvansTDR.NAME,:AvansTDR.DATEDOC,:AvansTDR.S100,:AvansTDR.KV,
						       :AvansTDR.KURS_T,:AvansTDR.RNK,:AvansTDR.REESTR,:AvansTDR.DATR,:AvansTDR.IMPEXP)" 
				Set AvansTDR.strSqlUpdate = 
						    "UPDATE tamozhdoc SET 
						          name = :AvansTDR.NAME, 
						       datedoc = :AvansTDR.DATEDOC, 
						             s = :AvansTDR.S100,
						            kv = :AvansTDR.KV, 
						          kurs = :AvansTDR.KURS_T, 
						  registry_num = :AvansTDR.REESTR, 
						  registry_dat = :AvansTDR.DATR,
						           rnk = :AvansTDR.RNK  
						     WHERE idt = :AvansTDR.IDT" 
				Set AvansTDR.strSqlDelete =
						    "DELETE FROM tamozhdoc WHERE idt = :AvansTDR.IDT"
				!
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On SAM_FetchRowDone
				Set SKs = Dig4(SK, DIG, DIG)
				If FL = 0
					Call XSalTblSetRowBackColor( AvansTDR, lParam, COLOR_Sky )
			On UM_Update
				Set nMin = TBL_MinRow
				While SalTblFindNextRow(hWndForm, nMin, 0, 0)
					Call SalTblSetContext(hWndForm, nMin)
					If SalTblQueryRowFlags(hWndForm, nMin, ROW_New)
						If FL = 0
							Call SqlPrepareAndExecute(hSql(), AvansTDR.strSqlInsert)
						Else If FL = 1 AND OTM
							If SqlPrepareAndExecute(hSql(),
									  "SELECT s_tamozhdoc.NEXTVAL INTO :nIDT FROM DUAL" )
									AND SqlFetchNext( hSql(), nFetchRes )
								If SqlPrepareAndExecute(hSql(),
										"UPDATE customs_decl SET 
										     fl_eik = 1,
										        idt = :AvansTDR.nIDT,
										       datj = :dBD
										  WHERE  fn = :AvansTDR.MC_FN
										    AND dat = :AvansTDR.MC_DAT
										    AND   n = :AvansTDR.MC_N")
									Call SqlPrepareAndExecute(hSql(), AvansTDR.strSqlInsert)
					If SalTblQueryRowFlags(hWndForm, nMin, ROW_Edited )
						If FL = 0
							Call SqlPrepareAndExecute(hSql(), AvansTDR.strSqlUpdate)
					If SalTblQueryRowFlags(hWndForm, nMin, ROW_MarkDeleted )
						If FL = 0
							Call SqlPrepareAndExecute(hSql(), AvansTDR.strSqlDelete)
						Else
							Call SqlPrepareAndExecute(hSql(),
									"UPDATE customs_decl SET 
									     fl_eik = 1,
									        idt = 1
									  WHERE  fn = :AvansTDR.MC_FN
									    AND dat = :AvansTDR.MC_DAT
									    AND   n = :AvansTDR.MC_N")
				Call SqlCommit( hSql())
				Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
			On SAM_Destroy
				Set hWndTDR = hWndNULL
				Call SalSendClassMessage( SAM_Destroy, 0, 0 )
			On UM_Insert
				Call SalSendClassMessage( UM_Insert, 0, 0 )
				Set FL = 0
	Table Window: EIK
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Экспортно-Импортные контракты
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
				Left:   0.14"
				Top:    0.467"
				Width:  14.367"
				Width Editable? Class Default
				Height: 5.896"
				Height Editable? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: None
			Text Color: Class Default
			Background Color: Class Default
			View: Class Default
			Allow Row Sizing? Class Default
			Lines Per Row: Class Default
		Memory Settings
			Maximum Rows in Memory: 30000
			Discardable? Class Default
		Description: Таблица контрактов
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Default
				Location? Class Default
				Visible? Class Default
				Size: 0.405"
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
						On SAM_Click
							Call SalCreateWindow(EID, hWndMDI, 0, 0, hWndForm.EIK.PAR, hWndForm )
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
						On SAM_Click
							Call SalTblQueryFocus(hWndForm, nFocusRow, hFocusCol)
							Call SalSendClassMessage(SAM_Click, 0, 0)
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
						On SAM_Click
							If F_CLOSE()
								Call SalSendClassMessage( SAM_Click, 0, 0 )
							Else
								Call SalSendMsg( EIK, UM_Populate, 0, 0)
				Line
					Resource Id: 5023
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  7.25"
						Begin Y:  Class Default
						End X:  7.25"
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
				Pushbutton: pbContract
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
					Picture File Name: \BARS98\RESOURCE\BMP\VIEW.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Карточка контракта'
						On SAM_Click
							Call SalCreateWindow( EID, hWndMDI, hWndForm.EIK.ID, IifN(MODE=9,9,1), hWndForm.EIK.PAR, hWndForm )
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
					Picture File Name: \BARS98\RESOURCE\BMP\print.bmp
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 5024
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
						Left:   7.37"
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
					Resource Id: 5025
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
				!
				Pushbutton: pbClo
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbGetValue
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.94"
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
					Picture File Name: \BARS98\RESOURCE\BMP\Tudasuda.bmp
					Picture Transparent Color: White
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Открытые/Закрытые контракты'
						On SAM_Click
							Set nClose=1-nClose
							Call SalSendMsg( pbRefresh, SAM_Click, 0, 0 )
				Pushbutton: pbPasport
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbBrowse
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.07"
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
					Picture File Name: \BARS98\RESOURCE\BMP\Custpers.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_Create
							Set strTip = 'Паспорт клиента'
						On SAM_Click
							If TIP =2
								Call EditCustCorps( RNK,   CVIEW_ReadOnly | CVIEW_Accounts, hWndMDI)
							Else If TIP =3
								Call EditCustPerson( RNK,  CVIEW_ReadOnly | CVIEW_Accounts, hWndMDI)
							Else If TIP =1
								Call EditCustBanks( RNK,  CVIEW_ReadOnly | CVIEW_Accounts, hWndMDI)
				Pushbutton: pbSubContracts
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbChilds
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.5"
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
					Picture File Name: \BARS98\RESOURCE\BMP\Childs.bmp
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Состояние контракта'
						On SAM_Click
							If PAR=0
								If not IsWindow(hWndS)
									Set hWndS = SalCreateWindow(SOST_EXP, hWndMDI, hWndForm.EIK.ID, MODE)
								Else
									Call SalBringWindowToTop( SOST_EXP )
							Else
								If not IsWindow(hWndM)
									Set hWndM = SalCreateWindow(SOST_IMP, hWndMDI,hWndForm.EIK.ID, MODE)
								Else
									Call SalBringWindowToTop( SOST_IMP )
				Pushbutton: pbSost
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbHelp
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   6.783"
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
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Состояние контракта'
						On SAM_Click
							Call SalSendMsg( hWndForm, SAM_DoubleClick, 0, 0 )
				Pushbutton: pbRef
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbRelation
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   5.36"
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
					Picture File Name: \BARS98\RESOURCE\BMP\CURRCONV.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Просмотр неразобранных документов'
						On SAM_Click
							If hWndAvansP
								Call SalDestroyWindow( hWndAvansP )
							Set hWndAvansP = SalCreateWindow( AvansRef, hWndMDI, PAR, IifN(MODE=9,9,0), 0, 0, 0, 0, hWndForm )
				Pushbutton: pbAvansTD
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbHelp
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   5.8"
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
							Set strTip = 'Просмотр авансовых ТД'
						On SAM_Click
							If hWndAvansT
								Call SalDestroyWindow( hWndAvansT )
							If hWndForm.EIK.RNK>0
								Set hWndAvansT=SalCreateWindow( AvansTD, hWndMDI, PAR, MODE, hWndForm.EIK.RNK, NUMBER_Null, STRING_Null, NUMBER_Null, NUMBER_Null, 0, hWndForm )
				Pushbutton: pbReestr
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbBrowse
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   6.24"
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
							Set strTip = 'Реестры ТД'
						On SAM_Click
							If NOT IsWindow(hWndRee)
								Set hWndRee=SalCreateWindow(EIT_Reestr, hWndMDI, hWndForm.EIK.PAR, Str(MODE),'' )
							Else
								Call SalBringWindowToTop( EIT_Reestr )
				Pushbutton: pbFinDocs
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbBrowse
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   6.66"
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
					Picture File Name: \BARS98\RESOURCE\BMP\LOOK.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Поиск платежей'
						On SAM_Click
							If hWndFinDocs
								Call SalDestroyWindow( hWndFinDocs )
							Set hWndFinDocs = SalCreateWindow(FINDOCS, hWndMDI, PAR, MODE)
				!
				Background Text: Сумма ПЛ:
					Resource Id: 22155
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   7.983"
						Top:    0.095"
						Width:  1.1"
						Width Editable? Yes
						Height: 0.167"
						Height Editable? Yes
					Visible? Yes
					Justify: Left
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Bold
					Text Color: Midnight Blue
					Background Color: Default
				Data Field: dfSUM_PL
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
							Left:   9.083"
							Top:    0.071"
							Width:  1.5"
							Width Editable? Yes
							Height: 0.25"
							Height Editable? Yes
						Visible? Yes
						Border? Yes
						Justify: Right
						Format: ###000
						Country: Default
						Font Name: MS Sans Serif
						Font Size: 8
						Font Enhancement: Bold
						Text Color: Midnight Blue
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
						On SAM_TooltipSetText
							Return XSalTooltipSetText( lParam, 'Общая сумма платежей по контракту' )
				Background Text: Сумма ТД:
					Resource Id: 22156
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   10.683"
						Top:    0.095"
						Width:  1.1"
						Width Editable? Yes
						Height: 0.167"
						Height Editable? Yes
					Visible? Yes
					Justify: Left
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Bold
					Text Color: Purple
					Background Color: Default
				Data Field: dfSUM_TD
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
							Left:   11.783"
							Top:    0.071"
							Width:  1.5"
							Width Editable? Yes
							Height: 0.25"
							Height Editable? Yes
						Visible? Yes
						Border? Yes
						Justify: Right
						Format: ###000
						Country: Default
						Font Name: MS Sans Serif
						Font Size: 8
						Font Enhancement: Bold
						Text Color: Purple
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
						On SAM_TooltipSetText
							Return XSalTooltipSetText( lParam, 'Общая сумма тамож.деклараций/актов по контракту' )
		Contents
			Column: ID
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Рефе-
						ренс
						контр.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  0.817"
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
			Column: IMPEXP
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: 1И
						0Э
				Visible? No
				Editable? Yes
				Maximum Data Length: 1
				Data Type: Number
				Justify: Center
				Width:  0.257"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: XEI
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Экс
						Им
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Center
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
			Column: NAME
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: №
						контракта
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.7"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: RNK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Регистр.
						№ 
						клиента
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  0.833"
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
			Column: ND
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: №
						договора
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
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
			Column: OKPO
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ОКПО
				Visible? No
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
				Width:  0.914"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Title: Наименование
						нашего клиента
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.083"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: DAT1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						начала
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.03"
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
			Column: DAT2
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						окончания
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.03"
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
						вал
				Visible? No
				Editable? No
				Maximum Data Length: 3
				Data Type: Number
				Justify: Right
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
			Column: ISO
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						вал
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
				Data Type: String
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
			Column: S
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма
						контракта
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.533"
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
			Column: Ss
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма
						контракта
						
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
				Width:  1.667"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: S100
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма
						контракта
				Visible? No
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.329"
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
			Column: BENEFNAME
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Наименование
						контрагента-
						нерезидента
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.733"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: BENEFCOUNTRY
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Страна
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
			Column: CLO
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Урег
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  0.55"
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
			Column: DIG
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
			Column: TIP
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
			Column: BRANCH
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Подразделение
						банка
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
			Function: F_SIGNAL
				Description: Уведомление  о незавизированных док-тах
				Returns
				Parameters
				Static Variables
				Local variables
					Number: nREF_OK
					Number: nREF_BACK
					Number: nTimer
					String: sNote
					String: sNote91
				Actions
					If SqlPrepareAndExecute( hSqlAux2(), 
							   "SELECT to_number(val) INTO :nTimer  
							    FROM birja WHERE par='IMEXSIGN' ") 
							AND NOT SqlFetchNext( hSqlAux2(), nFetchRes )
						Set nTimer=5
					! Кол-во поступивших документов
					If SqlPrepareAndExecute( hSqlAux2(), 
							   " SELECT count(*) INTO :nREF_OK  
							     FROM contract_p p, oper o
							     WHERE p.ref=o.ref(+) AND p.pid IS NULL     AND 
							          (p.id IS NULL   AND p.ref IS NOT NULL AND o.sos>0 OR  
							           p.id IS NULL   AND p.ref IS NULL)    AND  
							           p.impexp="||Str(PAR) )  AND NOT SqlFetchNext( hSqlAux2(), nFetchRes )
						Set nREF_OK=0
					! Кол-во возвращенных документов
					If SqlPrepareAndExecute(hSqlAux2(), 
							   "SELECT count(*) INTO :nREF_BACK  
							      FROM contract_p p, oper o
							     WHERE p.ref=o.ref 
							       AND o.sos<0 
							       AND (p.id IS NOT NULL OR p.pid IS NOT NULL)  
							       AND p.ref IS NOT NULL
							       AND o.pdat BETWEEN sysdate-7 AND sysdate
							       AND p.impexp="||Str(PAR) )
							AND NOT SqlFetchNext( hSqlAux2(), nFetchRes )
						Set nREF_BACK=0
					Set sNote=IifS(nREF_OK>0,'Поступило документов: '||Str(nREF_OK),'')||PutCrLf(  )||PutCrLf(  )||
							          IifS(nREF_BACK>0,IifS(PAR=1,'С подбора корсчета возращено документов: ',
							                                      'Сторнировано документов: ')||Str(nREF_BACK),'')
					If nREF_OK>0 OR nREF_BACK
						Call MessageNoWait( sNote,'Сообщение',nTimer ,0 )
			Function: F_91DAY
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
					String: sAlert
					String: sTmp
					Date/Time: dDATA
				Actions
					Set sAlert=STRING_Null
					Set dDATA=GetBankDate(  )
					If SqlPrepareAndExecute(hSqlAux2(), 
							   "SELECT 'ТД № '||t.name||' по контракту № '||k.pid||' клиента '||substr(kl.nmk,1,30)||' (РНК='||k.rnk||')'
							    INTO :sTmp     
							    FROM top_contracts k, contracts c, tamozhdoc t, contract_p p, customer kl
							    WHERE k.impexp=0   AND k.closed=0   AND   k.pid=c.pid           AND 
								  c.id=t.id    AND c.id=p.id(+) AND   kl.rnk=k.rnk          AND 
							          t.dat91=:dDATA   
							    GROUP BY t.name,k.pid,kl.nmk,k.rnk,t.s,t.kurs
							    HAVING round(t.s/t.kurs)-sum(nvl(round((p.s+nvl(p.komiss,0))*p.kurs),0))>100
							    ORDER BY k.rnk, k.pid, t.name")
						While SqlFetchNext( hSqlAux2(), nFetchRes )
							Set sAlert=IifS(sAlert=STRING_Null,sTmp,sAlert||PutCrLf(  )||sTmp)
					If sAlert!=STRING_Null
						Call SalMessageBox( sAlert, 'Внимание! Сегодня первый день нарушения для: ', MB_IconInformation )
			Function: F_CLOSE
				Description: Закрытие контракта в архив
				Returns
				Parameters
				Static Variables
				Local variables
					Number: nPermitFlg
					Number: nSubPL
					Number: nSubTD
					Number: i
				Actions
					Set i = TBL_MinRow
					! Удаление ошибочного контракта
					If SalTblFindNextRow(EIK, i, ROW_MarkDeleted, 0) 
						Call SalTblSetContext( EIK, i )
						! Не удаляем, если есть платежи или таможенные декларации по контракту
						If SqlPrepareAndExecute( hSqlAux2(), 
								   "SELECT count(idp) INTO :nSubPL FROM contract_p
								    WHERE pid="|| Str(hWndForm.EIK.ID)) 
								AND NOT SqlFetchNext( hSqlAux2(), nFetchRes )
							Set nSubPL=0
						If SqlPrepareAndExecute( hSqlAux2(), 
								   "SELECT count(idt) INTO :nSubTD FROM tamozhdoc
								    WHERE pid="|| Str(hWndForm.EIK.ID)) 
								AND NOT SqlFetchNext( hSqlAux2(), nFetchRes )
							Set nSubTD=0
						If nSubPL + nSubTD > 0
							Call SalMessageBox( 'Ошибка удаления контракта '||EIK.NAME , 'Ошибка', MB_IconStop|MB_OK )
							Return FALSE
					! Перемещение контракта в архив
					While SalTblFindNextRow(EIK, i, ROW_Edited, 0)
						Call SalTblSetContext(EIK, i)
						If nClose = 1 
							! Предупреждение о незакрытых суммах по контракту
							If SqlPrepareAndExecute(hSql(), 
									  "SELECT bars_eik.get_permit2clos(pid, 'AMOUNTS') 
									     INTO :nPermitFlg  
									     FROM top_contracts 
									    WHERE pid = :hWndForm.EIK.ID") 
									AND NOT SqlFetchNext(hSql(), nFetchRes)
								Set nPermitFlg = 0
							If nPermitFlg = 0 
								If SalMessageBox('По контракту №'||EIK.NAME||' незакрыты суммы! Продолжить?',
										                 'Внимание', 
										                 MB_IconQuestion|MB_YesNo) = IDNO
									Return FALSE
							! Предупреждение о ТД без реестра
							If SqlPrepareAndExecute(hSql(), 
									  "SELECT bars_eik.get_permit2clos(pid, 'REGISTER') 
									     INTO :nPermitFlg  
									     FROM top_contracts 
									    WHERE pid = :hWndForm.EIK.ID") 
									AND NOT SqlFetchNext(hSql(), nFetchRes)
								Set nPermitFlg = 0
							If nPermitFlg = 0 
								Call SalMessageBox('По контракту №'||EIK.NAME||' есть ТД без реестра!', 
										                   'Предупреждение',  
										                    MB_IconStop)
								Return FALSE
					Return TRUE
		Window Parameters
			Number: PAR      !! 1 - импорт, 0-экспорт
			Number: MODE    !! 0 - редактирование, 9 - просмотр 
			String: sPar     !! не используется
			String: sFilt2   !! внешний фильтр
		Window Variables
			Number: nFetchRes
			Number: nEIK_ND
			Number: nClose
			Number: nMaxDig
			Number: nFocusRow
			Window Handle: hFocusCol
			: cCust
				Class: cGenFilter
		Message Actions
			On SAM_Create
				Call SalWaitCursor( TRUE )
				Call SetWindowFullSize( hWndForm )
				Set nClose = 1
				Set fFilterAtStart=TRUE
				Set hWndForm.EIK.nTabInstance=1
				Set hWndForm.EIK.strPrintFileName='CONTRACT'
				Set hWndForm.EIK.strFilterTblName = 'TOP_CONTRACTS'
				Call cCust.Init('Customer', 'a')
				! Показ поля "Номер договора с клиентом"
				If SqlPrepareAndExecute( hSql(), 
						   "SELECT nvl(to_number(val),0) 
						      INTO :nEIK_ND 
						      FROM birja 
						     WHERE par='EIK_ND'") 
						AND NOT SqlFetchNext( hSql(), nFetchRes )
					Set nEIK_ND = 0
				If nEIK_ND = 0  
					Call SalHideWindow( ND )
				Else
					Call SalShowWindow( ND )
				! Экспорт - напоминание о 91-ом дне ТД
				If PAR=0
					Call F_91DAY()
				! Работа модуля в подразделениях банка
				If GetGlobalOptionEx('HAVETOBO') > 0
					Call SalShowWindow(BRANCH)
				Else
					Call SalHideWindow(BRANCH)
				! Просмотр(9) / редактирование(0) 
				If MODE = 9
					Set hWndForm.EIK.nFlags = GT_ReadOnly
				Set hWndForm.EIK.strSqlPopulate =
						 "SELECT top_contracts.pid, 
						         top_contracts.impexp, 
						         substr(y.name,1,3),
						         top_contracts.name, 
						         top_contracts.closed,
						         a.rnk, 
						         a.okpo, 
						         a.custtype, 
						         substr(a.nmk,1,30), 
						         a.nd,
						         top_contracts.benefname, 
						         c.name,
						         top_contracts.dateopen, 
						         top_contracts.dateclose,
						         top_contracts.kv, 
						         v.lcv, 
						         top_contracts.s/100, 
						         top_contracts.s, 
						         v.dig,
						         top_contracts.branch 
						   INTO :hWndForm.EIK.ID,
						        :hWndForm.EIK.IMPEXP,
						        :hWndForm.EIK.XEI,
						        :hWndForm.EIK.NAME,
						        :hWndForm.EIK.CLO,
						        :hWndForm.EIK.RNK,
						        :hWndForm.EIK.OKPO,
						        :hWndForm.EIK.TIP,
						        :hWndForm.EIK.NMK,
						        :hWndForm.EIK.ND,
						        :hWndForm.EIK.BENEFNAME,
						        :hWndForm.EIK.BENEFCOUNTRY, 
						        :hWndForm.EIK.DAT1,
						        :hWndForm.EIK.DAT2,
						        :hWndForm.EIK.KV,
						        :hWndForm.EIK.ISO,
						        :hWndForm.EIK.S,
						        :hWndForm.EIK.S100,
						        :hWndForm.EIK.DIG,
						        :hWndForm.EIK.BRANCH
						   FROM top_contracts, customer a, tabval v, contrtype y, country c 
						  WHERE top_contracts.impexp = y.r_impexp
						    AND top_contracts.rnk    = a.rnk
						    AND top_contracts.kv     = v.kv (+)
						    AND top_contracts.benefcountry = c.country(+) 
						    AND top_contracts.impexp = :hWndForm.EIK.PAR
						    AND top_contracts.closed <> :hWndForm.EIK.nClose 
						"|| IifS(sFilt2 = STRING_Null, " ", " AND "||sFilt2)
						 ||" ORDER BY top_contracts.dateopen, a.rnk, top_contracts.kv, top_contracts.s "   
				Set hWndForm.EIK.strSqlDelete ="DELETE FROM top_contracts WHERE pid=:hWndForm.EIK.ID"
				Set hWndForm.EIK.strSqlUpdate ="UPDATE top_contracts SET closed=:hWndForm.EIK.CLO WHERE pid=:hWndForm.EIK.ID"
				If DigInit() != -1
					Set nMaxDig = DigInit()
				Else
					! ?
				Call SalWaitCursor( FALSE )
				Call SalSendClassMessage(SAM_Create, 0, 0)
				Call SalFontSet(hWndForm.EIK.dfSUM_PL, "MS Sans Serif", 8, FONT_EnhBold)
				Call SalFontSet(hWndForm.EIK.dfSUM_TD, "MS Sans Serif", 8, FONT_EnhBold)
			On SAM_FetchRowDone
				Set Ss  = Dig4( S100/100, DIG, nMaxDig )
			On UM_Populate
				Call SalTblQueryFocus(hWndForm, nFocusRow, hFocusCol)
				Call SalSetWindowText( hWndForm, 
						                          IifS(PAR = 1,"Импортные контракты","Экспортные контракты")||
						                          IifS(nClose != 1," (закрытые)"," (на контроле)")||
						                          IifS(MODE = 9," ПРОСМОТР",""))
				Call SalSendClassMessage(UM_Populate, 0, 0)
				If nClose=1
					Call F_SIGNAL()
				Call SalTblSetFocusRow( hWndForm, nFocusRow)
				Call SalTblSetContext( hWndForm, nFocusRow )
				Call SalTblSetRowFlags( hWndForm, nFocusRow, ROW_Selected, TRUE )
				Call SalSendMsg( hWndForm, SAM_RowSetContext, 0, 0)
			On SAM_DoubleClick
				Call SalSendMsg( pbSubContracts, SAM_Click, 0, 0 )
			On SAM_RowSetContext
				Call SalEnableWindow(pbContract)
				! Общая сумма ТД по контракту
				Call SqlPrepareAndExecute( hSqlAux2(), 
						    "SELECT nvl(sum(round(t.s/t.kurs)), 0)/100 
						      INTO :hWndForm.EIK.dfSUM_TD        
						      FROM top_contracts tc, tamozhdoc t 
						      WHERE tc.pid=t.pid AND tc.pid=:hWndForm.EIK.ID" )
				If NOT SqlFetchNext( hSqlAux2(), nFetchRes )
					Set hWndForm.EIK.dfSUM_TD=0
				! Общая сумма ПЛ по контракту
				Call SqlPrepareAndExecute( hSqlAux2(), 
						    "SELECT nvl(sum(round((nvl(p.s,0)+nvl(p.komiss,0))*nvl(p.kurs,1))), 0)/100
						       INTO :hWndForm.EIK.dfSUM_PL        
						       FROM top_contracts tc, contract_p p  
						      WHERE tc.pid = p.pid AND tc.pid = :hWndForm.EIK.ID")
				If NOT SqlFetchNext( hSqlAux2(), nFetchRes )
					Set hWndForm.EIK.dfSUM_PL=0
				!
				If dfSUM_PL=S AND dfSUM_TD=S 
					Call SetTblRowColor( EIK, COLOR_Blue )
				Else
					Call SetTblRowColor( EIK, COLOR_Default )
			On SAM_Destroy
				Set hWndEIK = hWndNULL
				Call SalSendClassMessage( SAM_Destroy, 0, 0 )
	Table Window: EIT_Reestr
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Реестр таможенных деклараций
		Icon File:
		Accesories Enabled? Yes
		Visible? Yes
		Display Settings
			Visible at Design time? Yes
			Automatically Created at Runtime? No
			Initial State: Normal
			Maximizable? Yes
			Minimizable? Yes
			System Menu? Yes
			Resizable? Yes
			Window Location and Size
				Left:   0.03"
				Top:    0.592"
				Width:  11.667"
				Width Editable? Yes
				Height: 5.375"
				Height Editable? Yes
			Font Name: Default
			Font Size: Default
			Font Enhancement: None
			Text Color: Default
			Background Color: Default
			View: Table
			Allow Row Sizing? No
			Lines Per Row: Default
		Memory Settings
			Maximum Rows in Memory: 30000
			Discardable? No
		Description: Заполнение реестра таможенных деклараций
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Default
				Location? Top
				Visible? Yes
				Size: 0.571"
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
						Top:    0.071"
						Width:  0.43"
						Width Editable? No
						Height: 0.317"
						Height Editable? No
					Visible? No
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
						Left:   1.383"
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
					Picture File Name: \BARS98\RESOURCE\BMP\Save.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_Click
							Call F_Save()
							Call SalSendMsg( EIT_Reestr, UM_Populate, 0, 0 )
				Line
					Resource Id: 47111
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
						Left:   2.483"
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
				Pushbutton: pbContract
					Class Child Ref Key: 39
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.917"
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
					Picture File Name: \BARS98\RESOURCE\BMP\VIEW.BMP
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_Create
							Set strTip = 'Карточка контракта'
						On SAM_Click
							Call SalCreateWindow( EID, hWndMDI, EIT_Reestr.PID, IifN(sMODE='9',9,1), EIT_Reestr.IMPEXP, hWndForm )
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.35"
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
					Resource Id: 47112
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
				Pushbutton: pbClosed
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbGetValue
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.523"
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
					Picture File Name: \BARS98\RESOURCE\BMP\Tudasuda.bmp
					Picture Transparent Color: White
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Просмотр/редактирование реестров ТД'
						On SAM_Click
							Set nEdit=1-nEdit
							Set EIT_Reestr.fFilterAtStart = TRUE
							Call SalSendMsg( hWndForm, UM_Populate, 0, 0 )
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
					Resource Id: 47113
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
		Contents
			Column: PID
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Референс
						контракта
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
			Column: NAME
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Номер 
						контракта
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
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
			Column: DATEOPEN
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата 
						контракта
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.1"
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
			Column: RNK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Регистр.
						№
						клиента
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
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
			Column: ND
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: № 
						договора
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
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
			Column: NMK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Клиент
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.1"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
			Column: IDT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Реф
						ТД
						
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
			Column: NAMET
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Тамож.
						Документ
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
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
			Column: DATEDOC
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						из ТД
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.1"
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
			Column: S
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма в
						нац.вал.
						из ТД
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.533"
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
			Column: SK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма ТД
						в валюте
						контракта
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.667"
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
			Column: ISO
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						вал
						
				Visible? Yes
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
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: SKs
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма ТД
						в валюте
						контракта
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
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
			Column: KURS_T
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Курс
						из ТД
						
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
			Column: DAT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						ввода
						 ТД
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.1"
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
			!
			Column: OTM
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Отм
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  0.657"
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
						Set nOtm=nOtm + IifN(OTM=1,1,-1)
						If nOtm>0
							Call SalEnableWindow( pbUpdate )
						Else
							Call SalDisableWindow( pbUpdate )
			Column: REESTR
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: № 
						реестра
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.533"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: DATR
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата 
						реестра
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.1"
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
			Column: DIG
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Вал
						
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
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
			Function: F_Save
				Description: Заполнение № и даты реестра ТД
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Number: nKOL
					String: rNAME
					Date/Time: rDAT
				Actions
					If nOtm>0
						Set nKOL=0
						Call SalModalDialog(dlg_REESTR, hWndForm, rNAME, rDAT)
						If rNAME != STRING_Null AND rDAT != DATETIME_Null
							Set nTmp = TBL_MinRow
							Loop
								If SalTblFindNextRow (EIT_Reestr, nTmp, ROW_Edited, 0)
									Call SalTblSetContext(EIT_Reestr,nTmp)
									If nTmp >=0
										If EIT_Reestr.OTM = 1
											If SqlPrepareAndExecute( hSql(),
													  "UPDATE tamozhdoc 
													      SET registry_num = :rNAME,
													          registry_dat = :rDAT 
													    WHERE idt          = :EIT_Reestr.IDT")
												Call SqlCommit( hSql() )
											Else
												Call Debug('Ошибка при сохранении изменений!')
												Call SqlRollback(hSql())
											Set nKOL=nKOL+1
								Else
									If nKOL > 0
										Call SalMessageBox('Обработано ТД: '||Str(nKOL)||' !','Выполнено успешно',MB_IconInformation)
									Break
						Else
							Call Debug('Не указан номер и/или дата реестра!')
							Return FALSE
					Else
						Return FALSE
					Return TRUE
		Window Parameters
			Number: IMPEXP   !! 1-ИМП, 0-ЭКСП  2-ВСЕ
			String: sMODE
			String: sFilt2
		Window Variables
			Number: nTmp
			Number: nEIK_ND
			Number: nOtm
			Number: nEdit
			Number: nFetchRes
			String: sSelect0
			String: sSelect1
			String: sSelect_Avans0
			String: sSelect_Avans1
			String: sOrderBy
			String: sFilter
		Message Actions
			On SAM_Create
				Call SalWaitCursor( TRUE )
				Call SetWindowFullSize( hWndForm )
				Set EIT_Reestr.fFilterAtStart=TRUE
				Set nEdit=1
				If sMODE = '9'
					Set hWndForm.EIT_Reestr.nFlags = GT_ReadOnly
				Set EIT_Reestr.nTabInstance=1
				Set EIT_Reestr.strPrintFileName = 'REESTR_TD'
				Set EIT_Reestr.strFilterTblName = 'TAMOZHDOC'
				! Показ поля "Номер договора с клиентом"
				If SqlPrepareAndExecute( hSql(), 
						   "SELECT nvl(to_number(val),0) 
						      INTO :nEIK_ND 
						      FROM birja 
						     WHERE par='EIK_ND'") 
						AND NOT SqlFetchNext( hSql(), nFetchRes )
					Set nEIK_ND = 0
				If nEIK_ND = 0  
					Call SalHideWindow( ND )
				Else
					Call SalShowWindow( ND )
				!
				Set strSqlInsert = ""
				Set strSqlDelete = ""
				Set strSqlUpdate = ""
				Set EIT_Reestr.sOrderBy = " ORDER BY 2, 1"
				Set EIT_Reestr.sSelect1 =
						   "SELECT tamozhdoc.idt,
						           tamozhdoc.pid, 
						           top_contracts.name, 
						           top_contracts.dateopen, 
						           tamozhdoc.rnk, 
						           customer.nmk, 
						           customer.nd,
						           tamozhdoc.name, 
						           tamozhdoc.datedoc, 
						           tamozhdoc.dat,
						           tamozhdoc.s/tamozhdoc.kurs/100, 
						           tamozhdoc.s/100, 
						           tamozhdoc.kurs, 
						           tabval.lcv, 
						           tabval.dig
						      INTO :EIT_Reestr.IDT,
						           :EIT_Reestr.PID,
						           :EIT_Reestr.NAME,
						           :EIT_Reestr.DATEOPEN,
						           :EIT_Reestr.RNK,
						           :EIT_Reestr.NMK,
						           :EIT_Reestr.ND,
						           :EIT_Reestr.NAMET,
						           :EIT_Reestr.DATEDOC,
						           :EIT_Reestr.DAT,
						           :EIT_Reestr.SK,
						           :EIT_Reestr.S,
						           :EIT_Reestr.KURS_T,
						           :EIT_Reestr.ISO,
						           :EIT_Reestr.DIG      
						      FROM top_contracts, 
						           tamozhdoc,
						           customer, 
						           tabval           
						     WHERE top_contracts.rnk     = tamozhdoc.rnk 
						       AND top_contracts.pid     = tamozhdoc.pid       
						       AND tamozhdoc.rnk         = customer.rnk 
						       AND tamozhdoc.kv          = tabval.kv 
						       AND top_contracts.closed != 1 
						       AND tamozhdoc.registry_num IS NULL "
						||IifS(IMPEXP=2, "", " AND top_contracts.impexp = "||Str(IMPEXP))
				Set EIT_Reestr.sSelect0 =
						   "SELECT tamozhdoc.idt,
						           tamozhdoc.pid,
						           top_contracts.name,
						           top_contracts.dateopen,
						           tamozhdoc.rnk,
						           customer.nmk,
						           customer.nd,
						           tamozhdoc.name,
						           tamozhdoc.datedoc,
						           tamozhdoc.dat,
						           tamozhdoc.s/tamozhdoc.kurs/100,
						           tamozhdoc.s/100,
						           tamozhdoc.kurs,
						           tabval.lcv,
						           tabval.dig,
						           tamozhdoc.registry_num,
						           tamozhdoc.registry_dat
						      INTO :EIT_Reestr.IDT,
						           :EIT_Reestr.PID,
						           :EIT_Reestr.NAME,
						           :EIT_Reestr.DATEOPEN,
						           :EIT_Reestr.RNK,
						           :EIT_Reestr.NMK,
						           :EIT_Reestr.ND,
						           :EIT_Reestr.NAMET,
						           :EIT_Reestr.DATEDOC,
						           :EIT_Reestr.DAT,
						           :EIT_Reestr.SK,
						           :EIT_Reestr.S,
						           :EIT_Reestr.KURS_T,
						           :EIT_Reestr.ISO,
						           :EIT_Reestr.DIG,
						           :EIT_Reestr.REESTR,
						           :EIT_Reestr.DATR       
						      FROM top_contracts, 
						           tamozhdoc,
						           customer, 
						           tabval           
						     WHERE top_contracts.rnk     = tamozhdoc.rnk
						       AND top_contracts.pid     = tamozhdoc.pid
						       AND tamozhdoc.rnk         = customer.rnk
						       AND tamozhdoc.kv          = tabval.kv 
						       AND top_contracts.closed != 1 "
						||IifS(IMPEXP = 2, "", " AND top_contracts.impexp = "||Str(IMPEXP))
				Call SalWaitCursor( FALSE )
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On SAM_FetchRowDone
				Set SKs = Dig4( SK, DIG, DIG )
			On UM_Populate
				Set nOtm=0
				If fFilterAtStart
					Set EIT_Reestr.fFilterAtStart = NOT EIT_Reestr.fFilterAtStart
					If NOT SetQueryFilter( cF )
						Call SalDestroyWindow( hWndForm )
				Set sFilter=cF.GetFilterWhereClause(FALSE)
				Call SalWaitCursor( TRUE )
				Call SalSetWindowText( hWndForm, 
						  "Реестры ТД по " ||
						   IifS(IMPEXP=2,"экспортно-импортным контрактам",IifS(IMPEXP=1,"импортным контрактам","экспортным контрактам"))||
						   IifS(nEdit!=1," (просмотр)"," (редактирование)"))
				If nEdit=1
					Call SalDisableWindow( pbDel )
					Call SalDisableWindow( pbIns )
					Call SalHideWindow( REESTR )
					Call SalHideWindow( DATR )
					Call SalShowWindow( OTM )
					Set EIT_Reestr.strSqlPopulate =
							    EIT_Reestr.sSelect1 ||IifS(sFilter=STRING_Null," "," AND "||sFilter)||EIT_Reestr.sOrderBy
				Else
					Call SalDisableWindow( pbDel )
					Call SalDisableWindow( pbIns )
					Call SalDisableWindow( pbUpdate )
					Call SalShowWindow( REESTR )
					Call SalShowWindow( DATR )
					Call SalHideWindow( OTM )
					Set EIT_Reestr.strSqlPopulate =
							    EIT_Reestr.sSelect0 ||IifS(sFilter=STRING_Null," "," AND "||sFilter)||EIT_Reestr.sOrderBy
				Call SalTblPopulate( hWndForm, hSql(), strSqlPopulate, TBL_FillAll )
				Call SalWaitCursor( FALSE )
			On SAM_Destroy
				Set hWndRee = hWndNULL
				Call SalSendClassMessage( SAM_Destroy, 0, 0 )
	Table Window: FINDOCS
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
				Width:  15.6"
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
					Resource Id: 16107
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  5.05"
						Begin Y:  Class Default
						End X:  5.05"
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
							Set strTip = 'Просмотр документа'
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.8"
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
					Resource Id: 16108
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  4.383"
						Begin Y:  Class Default
						End X:  4.383"
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
						Left:   4.517"
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
					Resource Id: 16109
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
				Pushbutton: pbContract
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbDetail
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.35"
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
					Picture File Name: \BARS98\RESOURCE\BMP\CHILDS.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Состояние контракта'
						On SAM_Click
							If TIP = 0
								If not IsWindow(hWndS)
									Set hWndS = SalCreateWindow(SOST_EXP, hWndMDI, hWndForm.FINDOCS.PID, MODE)
								Else
									Call SalBringWindowToTop( SOST_EXP )
							Else
								If not IsWindow(hWndM)
									Set hWndM = SalCreateWindow(SOST_IMP, hWndMDI, hWndForm.FINDOCS.PID, MODE)
								Else
									Call SalBringWindowToTop( SOST_IMP )
		Contents
			Column: RNK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Рег.№
						клиента
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
			Column: ND
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Номер
						договора
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
			Column: NMK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Наименование
						клиента
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
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
			Column: PID
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						контр.
				Visible? No
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
			Column: NAME
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Номер
						контракта
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
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
			Column: DATEOPEN
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						контракта
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.0"
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
			Column: IDP
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						платежа
				Visible? No
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
			Column: REF
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Референс
						платежа
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
			Column: FDAT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						платежа
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.0"
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
			Column: S
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма
						платежа
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.4"
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
			Column: KV
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						вал
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
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
			Column: KURS
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Курс
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
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
			Column: SK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма
						в вал.контр.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.4"
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
			Column: ACC
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
			Column: NLS
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Номер 
						счета
				Visible? Yes
				Editable? No
				Maximum Data Length: 14
				Data Type: String
				Justify: Left
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
			Column: NAZN
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Назначение платежа
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
			Column: SOS
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
			Number: TIP
			! 0 - экспорт, 1- импорт
			Number: MODE 
			! 0 - редактирование, 9 - просмотр 
		Window Variables
			Number: nEIK_ND
			Number: nFetchRes
		Message Actions
			On SAM_Create
				Call SalCenterWindow( hWndForm )
				Set FINDOCS.strPrintFileName = 'FINDOCS'
				Set nFlags = GT_ReadOnly
				Set FINDOCS.strFilterTblName = 'OPER'
				Set FINDOCS.fFilterAtStart = TRUE
				Set FINDOCS.nTabInstance = 1
				! Показ поля "Номер договора с клиентом"
				If SqlPrepareAndExecute( hSql(), 
						   "SELECT nvl(to_number(val),0) 
						      INTO :nEIK_ND 
						      FROM birja 
						     WHERE par='EIK_ND'") 
						AND NOT SqlFetchNext( hSql(), nFetchRes )
					Set nEIK_ND = 0
				If nEIK_ND = 0  
					Call SalHideWindow( ND )
				Else
					Call SalShowWindow( ND )
				!
				Call SalSetWindowText(hWndForm, 
						     "Поиск платежей по "||
						     IifS(TIP = 0, " экспортным", " импортным")||
						     " контрактам"    )
				Set FINDOCS.strSqlPopulate =
						   "SELECT p.idp, p.ref, p.rnk, c.nmk,  
						           c.nd, t.pid, t.name, t.dateopen,  
						           p.fdat, p.s/100, v.lcv, p.kurs, 
						           p.acc, a.nls, nvl(p.details,oper.nazn), oper.sos   
						      INTO :FINDOCS.IDP, :FINDOCS.REF, :FINDOCS.RNK, :FINDOCS.NMK,
						           :FINDOCS.ND,  :FINDOCS.PID, :FINDOCS.NAME,:FINDOCS.DATEOPEN,
						           :FINDOCS.FDAT,:FINDOCS.S,   :FINDOCS.KV,  :FINDOCS.KURS,
						           :FINDOCS.ACC, :FINDOCS.NLS, :FINDOCS.NAZN,:FINDOCS.SOS  
						      FROM contract_p p, customer c, top_contracts t, oper, 
						           accounts a, tabval v
						     WHERE p.rnk = c.rnk 
						       AND t.pid = p.pid 
						       AND p.ref = oper.ref 
						       AND p.kv  = v.kv
						       AND p.acc = a.acc(+) 
						       AND p.impexp = "||Str(TIP)||
						   " ORDER BY 3, 7, 8, 9, 2"
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On SAM_DoubleClick
				If SalTblAnyRows( hWndForm, ROW_Selected, 0 ) and  FINDOCS.REF > 0 
					Call DocViewContentsEx(hWndForm, FINDOCS.REF)
			On SAM_FetchRowDone
				If FINDOCS.SOS < 0
					Call SetTblRowColor( hWndForm, COLOR_Red )
				Else If FINDOCS.SOS = 1
					Call SetTblRowColor( hWndForm, COLOR_DarkGreen )
				Else If FINDOCS.SOS = 3
					Call SetTblRowColor( hWndForm, COLOR_Blue )
				Else
					Call SetTblRowColor( hWndForm, COLOR_Black )
				!
				If NOT SalIsNull(FINDOCS.KURS)
					Set FINDOCS.SK = FINDOCS.S * FINDOCS.KURS
			On SAM_Destroy
				Set hWndFinDocs = hWndNULL
				Call SalSendClassMessage( SAM_Destroy, 0, 0 )
	Dialog Box: dlg_KURS_1PB
		Class:
		Property Template:
		Class DLL Name:
		Title: Выбор курса валюты и редактирование кодов для 1_ПБ
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  10.1"
				Width Editable? Yes
				Height: 3.226"
				Height Editable? Yes
			Absolute Screen Location? Yes
			Font Name: Default
			Font Size: Default
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description: Выбор курса валют
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
			Group Box: Сумма и курс платежа
				Resource Id: 32324
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.083"
					Top:    0.071"
					Width:  9.7"
					Width Editable? Yes
					Height: 1.0"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 10
				Font Enhancement: Bold
				Text Color: 3D Shadow Color
				Background Color: Default
			Background Text: Сумма платежа:
				Resource Id: 32325
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.383"
					Top:    0.429"
					Width:  2.3"
					Width Editable? Yes
					Height: 0.226"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: MS Sans Serif
				Font Size: 10
				Font Enhancement: Bold
				Text Color: Midnight Blue
				Background Color: Default
			Data Field: dfSumP
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
						Left:   2.683"
						Top:    0.405"
						Width:  1.8"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: ###000
					Country: Default
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Default
					Text Color: Midnight Blue
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Долг по контракту:
				Resource Id: 32326
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.283"
					Top:    0.679"
					Width:  2.4"
					Width Editable? Yes
					Height: 0.226"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: MS Sans Serif
				Font Size: 10
				Font Enhancement: Bold
				Text Color: Midnight Blue
				Background Color: Default
			Data Field: dfSumD
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
						Left:   2.683"
						Top:    0.655"
						Width:  1.8"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: ###000
					Country: Default
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Default
					Text Color: Midnight Blue
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Кросс-курс:
				Resource Id: 4154
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   6.083"
					Top:    0.429"
					Width:  1.7"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: MS Sans Serif
				Font Size: 10
				Font Enhancement: Bold
				Text Color: Jade
				Background Color: Default
			Data Field: dfK
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
						Left:   7.783"
						Top:    0.405"
						Width:  1.8"
						Width Editable? Yes
						Height: 0.271"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Jade
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Расчетная сумма:
				Resource Id: 32327
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   5.383"
					Top:    0.679"
					Width:  2.4"
					Width Editable? Yes
					Height: 0.226"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: MS Sans Serif
				Font Size: 10
				Font Enhancement: Bold
				Text Color: Red
				Background Color: Default
			Data Field: dfSum2Pay
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
						Left:   7.783"
						Top:    0.655"
						Width:  1.8"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: ###000
					Country: Default
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Default
					Text Color: Red
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_Validate
						If dfSum2Pay > dfSumP
							Call SalMessageBox( 'Введенная сумма превышает сумму платежа!', 'Ошибка', MB_IconStop )
							Return VALIDATE_Cancel
			!
			Group Box: Параметры для 1-ПБ
				Resource Id: 23246
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.083"
					Top:    1.071"
					Width:  9.7"
					Width Editable? Yes
					Height: 1.083"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 10
				Font Enhancement: Bold
				Text Color: 3D Shadow Color
				Background Color: Default
			Background Text: КОД банка:
				Resource Id: 23244
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    1.345"
					Width:  3.3"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: MS Sans Serif
				Font Size: 10
				Font Enhancement: Bold
				Text Color: Dark Blue
				Background Color: Default
			Data Field: dfKOD_B
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 4
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   3.483"
						Top:    1.321"
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
						Call cmbKOD_B.SetSelectById(dfKOD_B)
			Combo Box: cmbKOD_B
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_StrId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   4.483"
					Top:    1.321"
					Width:  5.083"
					Width Editable? Class Default
					Height: 1.5"
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
						Call cmbKOD_B.Init( hWndItem )
						Call cmbKOD_B.Populate( hSqlAux2(), "REGNUM", "NAME", "bopbank"," WHERE REGNUM IS NOT NULL ORDER BY REGNUM" )
						Call cmbKOD_B.SetSelectById( dfKOD_B )
					On SAM_Click
						Set dfKOD_B = cmbKOD_B.GetKey( SalListQuerySelection( hWndItem ) )
			Background Text: КОД назначения платежа:
				Resource Id: 23245
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    1.595"
					Width:  3.3"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: MS Sans Serif
				Font Size: 10
				Font Enhancement: Bold
				Text Color: Midnight Blue
				Background Color: Default
			Data Field: dfKOD_N
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 7
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   3.483"
						Top:    1.571"
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
						Call cmbKOD_N.SetSelectById(dfKOD_N)
			Combo Box: cmbKOD_N
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_StrId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   4.483"
					Top:    1.571"
					Width:  5.083"
					Width Editable? Class Default
					Height: 1.5"
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
						Call cmbKOD_N.Init( hWndItem )
						Call cmbKOD_N.Populate( hSqlAux2(), "TRANSCODE", "TRANSDESC", "BOPCODE"," WHERE TRANSCODE IS NOT NULL ORDER BY TRANSCODE" )
						Call cmbKOD_N.SetSelectById( dfKOD_N )
					On SAM_Click
						Set dfKOD_N = cmbKOD_N.GetKey( SalListQuerySelection( hWndItem ) )
			Background Text: КОД государства бенеф.:
				Resource Id: 23243
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    1.845"
					Width:  3.3"
					Width Editable? Yes
					Height: 0.226"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: MS Sans Serif
				Font Size: 10
				Font Enhancement: Bold
				Text Color: Dark Blue
				Background Color: Default
			Data Field: dfKOD_G
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
						Left:   3.483"
						Top:    1.821"
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
						Call cmbKOD_G.SetSelectById(dfKOD_G)
			Combo Box: cmbKOD_G
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_StrId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   4.483"
					Top:    1.821"
					Width:  5.083"
					Width Editable? Class Default
					Height: 1.5"
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
						Call cmbKOD_G.Init( hWndItem )
						Call cmbKOD_G.Populate( hSqlAux2(),"KODC", "COUNTRY", "BOPCOUNT"," WHERE KODC IS NOT NULL ORDER BY KODC" )
						Call cmbKOD_G.SetSelectById( dfKOD_G )
					On SAM_Click
						Set dfKOD_G = cmbKOD_G.GetKey( SalListQuerySelection( hWndItem ) )
			!
			Pushbutton: pbOK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Выбрать
				Window Location and Size
					Left:   2.083"
					Top:    2.321"
					Width:  1.2"
					Width Editable? Yes
					Height: 0.5"
					Height Editable? Yes
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Picture File Name: \BARS98\RESOURCE\BMP\Execute.bmp
				Picture Transparent Color: None
				Image Style: Single
				Text Color: Default
				Background Color: Default
				Message Actions
					On SAM_Click
						If dfK !=NUMBER_Null
							Set ncurs=dfK
						Else
							Set ncurs=1
						If GetGlobalOptionEx( 'IMEX_1PB' )=1 AND
								   (dlg_KURS_1PB.REF != 0 AND dlg_KURS_1PB.REF != NUMBER_Null) AND
								   (dfKOD_G = STRING_Null OR dfKOD_N = STRING_Null)
							Call SalMessageBox( 'Не заполнены реквизиты для 1-ПБ!', 'Внимание!', MB_IconStop )
						Else
							If dlg_KURS_1PB.REF != 0 AND dlg_KURS_1PB.REF != NUMBER_Null
								If sKOD_G != STRING_Null AND sKOD_G!=dfKOD_G
									If SqlPrepareAndExecute( hSqlAux2(), 
											   "UPDATE operw SET value=:dfKOD_G WHERE ref=:REF AND tag='KOD_G'" )
										Call SqlCommit( hSqlAux2() )
									Else
										Call SqlRollback( hSqlAux2() )
										Call Debug('Невозможно сохранить параметры для 1-ПБ!')
								If sKOD_G  = STRING_Null AND dfKOD_G!=STRING_Null
									Call SqlPrepareAndExecute( hSqlAux2(), 
											     "SELECT 1 INTO :nTemp FROM operw WHERE ref=:REF AND tag='KOD_G' AND value IS NOT NULL" )
									If NOT SqlFetchNext( hSqlAux2(), nFetchRes )
										If SqlPrepareAndExecute( hSqlAux2(), 
												   "INSERT INTO operw (ref, tag,value) VALUES (:REF,'KOD_G',:dfKOD_G) " )
											Call SqlCommit( hSqlAux2() )
										Else
											Call SqlRollback( hSqlAux2() )
											Call Debug('Невозможно сохранить параметры для 1-ПБ!')
									Else
										If SqlPrepareAndExecute( hSqlAux2(), 
												   "UPDATE operw SET value=:dfKOD_G WHERE ref=:REF AND tag='KOD_G'")
											Call SqlCommit( hSqlAux2() )
										Else
											Call SqlRollback( hSqlAux2() )
											Call Debug('Невозможно сохранить параметры для 1-ПБ!')
								!
								If sKOD_B != STRING_Null AND sKOD_B!=dfKOD_B
									If SqlPrepareAndExecute( hSqlAux2(), 
											   "UPDATE operw SET value=:dfKOD_B WHERE ref=:REF AND tag='KOD_B'" )
										Call SqlCommit( hSqlAux2() )
									Else
										Call SqlRollback( hSqlAux2() )
										Call Debug('Невозможно сохранить параметры для 1-ПБ!')
								If sKOD_B  = STRING_Null AND dfKOD_B!=STRING_Null
									Call SqlPrepareAndExecute( hSqlAux2(), 
											     "SELECT 1 INTO :nTemp FROM operw WHERE ref=:REF AND tag='KOD_B' AND value IS NOT NULL" )
									If NOT SqlFetchNext( hSqlAux2(), nFetchRes )
										If SqlPrepareAndExecute( hSqlAux2(), 
												   "INSERT INTO operw (ref, tag,value) VALUES (:REF,'KOD_B',:dfKOD_B) " )
											Call SqlCommit( hSqlAux2() )
										Else
											Call SqlRollback( hSqlAux2() )
											Call Debug('Невозможно сохранить параметры для 1-ПБ!')
									Else
										If SqlPrepareAndExecute( hSqlAux2(), 
												   "UPDATE operw SET value=:dfKOD_B WHERE ref=:REF AND tag='KOD_B'")
											Call SqlCommit( hSqlAux2() )
										Else
											Call SqlRollback( hSqlAux2() )
											Call Debug('Невозможно сохранить параметры для 1-ПБ!')
								!
								If sKOD_N != STRING_Null AND sKOD_N!=dfKOD_N
									If SqlPrepareAndExecute( hSqlAux2(), 
											   "UPDATE operw SET value=:dfKOD_N WHERE ref=:REF AND tag='KOD_N'" )
										Call SqlCommit( hSqlAux2() )
									Else
										Call SqlRollback( hSqlAux2() )
										Call Debug('Невозможно сохранить параметры для 1-ПБ!')
								If sKOD_N  = STRING_Null AND dfKOD_N!=STRING_Null
									Call SqlPrepareAndExecute( hSqlAux2(), 
											     "SELECT 1 INTO :nTemp FROM operw WHERE ref=:REF AND tag='KOD_N' AND value IS NOT NULL" )
									If NOT SqlFetchNext( hSqlAux2(), nFetchRes )
										If SqlPrepareAndExecute( hSqlAux2(), 
												   "INSERT INTO operw (ref, tag,value) VALUES (:REF,'KOD_N',:dfKOD_N) " )
											Call SqlCommit( hSqlAux2() )
										Else
											Call SqlRollback( hSqlAux2() )
											Call Debug('Невозможно сохранить параметры для 1-ПБ!')
									Else
										If SqlPrepareAndExecute( hSqlAux2(), 
												   "UPDATE operw SET value=:dfKOD_N WHERE ref=:REF AND tag='KOD_N'")
											Call SqlCommit( hSqlAux2() )
										Else
											Call SqlRollback( hSqlAux2() )
											Call Debug('Невозможно сохранить параметры для 1-ПБ!')
							!
							! Расчетная сумма
							If dfSum2Pay * dfK > dfSumD
								Call SalMessageBox( 'Сумма платежа в валюте контракта превышает остаток проплат по контракту!'||PutCrLf(  )||
										                    'Документ не может быть привязан к данному контракту', 'Ошибка', MB_IconStop )
							Else
								Set nsum=dfSum2Pay
								Call SalDestroyWindow( hWndForm )
			Pushbutton: pbExit
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   5.583"
					Top:    2.321"
					Width:  Class Default
					Width Editable? Class Default
					Height: 0.5"
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
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
						Set ncurs = 0
						Set nsum  = 0
						Call SalDestroyWindow( hWndForm )
		Functions
		Window Parameters
			! TIP=1 - коррекция суммы, 0 - сумма не меняется
			Number: TIP
			Number: REF
			Number: KVK
			Number: KVP
			Date/Time: DAT
			Number: S_PL
			Number: S_DEBT
			Receive Number: ncurs
			Receive Number: nsum
		Window Variables
			Sql Handle: hSql
			Number: ncurs_b
			Number: ncurs_o
			Number: ncurs_s
			Number: nFetchRes
			Number: nTemp
			String: sKOD_G
			String: sKOD_B
			String: sKOD_N
		Message Actions
			On SAM_Create
				Call SalCenterWindow( dlg_KURS_1PB )
				If TIP=0
					Call SalDisableWindow(dfSum2Pay)
				Else
					Call SalEnableWindow(dfSum2Pay)
				Set dfSum2Pay=S_PL
				Set dfSumP=S_PL
				Set dfSumD=S_DEBT
				If dlg_KURS_1PB.REF = 0 OR dlg_KURS_1PB.REF = NUMBER_Null
					Call SalDisableWindow( dfKOD_B )
					Call SalDisableWindow( dfKOD_G )
					Call SalDisableWindow( dfKOD_N )
					Call SalDisableWindow( cmbKOD_B )
					Call SalDisableWindow( cmbKOD_G )
					Call SalDisableWindow( cmbKOD_N )
				!
				If KVK=KVP
					Set dfK=1
					Call SalDisableWindow( dfK )
				Else
					Call GetXRate( ncurs_o, ncurs_b, ncurs_s, KVP, KVK, DAT )
					Set dfK=ncurs_o
					Call SalEnableWindow( dfK )
				!
				Call SqlPrepareAndExecute( hSqlAux2(), 
						  "SELECT max(decode(tag,'KOD_B',RPAD(substr(value,1,4),4,' '),'')),
						          max(decode(tag,'KOD_G',RPAD(substr(value,1,3),3,' '),'')),
							  max(decode(tag,'KOD_N',RPAD(substr(value,1,7),7,' '),''))
						   INTO :sKOD_B, :sKOD_G, :sKOD_N
						   FROM operw 
						   WHERE ref=:dlg_KURS_1PB.REF AND tag IN ('KOD_B','KOD_G','KOD_N')" )
				If SqlFetchNext( hSqlAux2(), nFetchRes )
					Set dfKOD_G=sKOD_G
					Set dfKOD_B=sKOD_B
					Set dfKOD_N=sKOD_N
					Call cmbKOD_G.SetSelectById( dfKOD_G )
					Call cmbKOD_B.SetSelectById( dfKOD_B )
					Call cmbKOD_N.SetSelectById( dfKOD_N )
	Dialog Box: dlg_EXPL
		Class:
		Property Template:
		Class DLL Name:
		Title: Ввод суммы, курса и комиссии
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  6.083"
				Width Editable? Yes
				Height: 2.512"
				Height Editable? Yes
			Absolute Screen Location? Yes
			Font Name: Default
			Font Size: Default
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description: Выбор комиссии
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
			Background Text: Валюта контракта:
				Resource Id: 39903
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    0.179"
					Width:  2.4"
					Width Editable? Yes
					Height: 0.226"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: MS Sans Serif
				Font Size: 10
				Font Enhancement: Bold
				Text Color: Jade
				Background Color: Default
			Data Field: dfKvK
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
						Top:    0.155"
						Width:  3.1"
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
					Text Color: Jade
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Валюта платежа:
				Resource Id: 34213
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    0.429"
					Width:  2.4"
					Width Editable? Yes
					Height: 0.226"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: MS Sans Serif
				Font Size: 10
				Font Enhancement: Bold
				Text Color: Jade
				Background Color: Default
			Data Field: dfKvP
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
						Top:    0.405"
						Width:  3.1"
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
					Text Color: Jade
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Долг по Контр./ТД:
				Resource Id: 21573
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    1.095"
					Width:  2.4"
					Width Editable? Yes
					Height: 0.226"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: MS Sans Serif
				Font Size: 10
				Font Enhancement: Bold
				Text Color: Midnight Blue
				Background Color: Default
			Data Field: dfSumDebt
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
						Left:   2.583"
						Top:    1.071"
						Width:  1.533"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: ###000
					Country: Default
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Default
					Text Color: Dark Blue
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Сумма платежа:
				Resource Id: 34212
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    0.845"
					Width:  2.4"
					Width Editable? Yes
					Height: 0.226"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: MS Sans Serif
				Font Size: 10
				Font Enhancement: Bold
				Text Color: Midnight Blue
				Background Color: Default
			Data Field: dfSumP
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
						Left:   2.583"
						Top:    0.821"
						Width:  1.533"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: ###000
					Country: Default
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Default
					Text Color: Midnight Blue
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Курс:
				Resource Id: 34214
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    1.595"
					Width:  2.4"
					Width Editable? Yes
					Height: 0.226"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: MS Sans Serif
				Font Size: 10
				Font Enhancement: Bold
				Text Color: Midnight Blue
				Background Color: Default
			Data Field: dfKurs
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
						Left:   2.583"
						Top:    1.571"
						Width:  1.533"
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
					Text Color: Midnight Blue
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Комиссия:
				Resource Id: 39902
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    1.345"
					Width:  2.4"
					Width Editable? Yes
					Height: 0.226"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: MS Sans Serif
				Font Size: 10
				Font Enhancement: Bold
				Text Color: Dark Blue
				Background Color: Default
			Data Field: dfSumKomiss
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
						Left:   2.583"
						Top:    1.321"
						Width:  1.533"
						Width Editable? Yes
						Height: 0.271"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: ###000
					Country: Default
					Font Name: MS Sans Serif
					Font Size: Default
					Font Enhancement: Default
					Text Color: Midnight Blue
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Расчетная сумма:
				Resource Id: 34215
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    1.845"
					Width:  2.4"
					Width Editable? Yes
					Height: 0.226"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: MS Sans Serif
				Font Size: 10
				Font Enhancement: Bold
				Text Color: Red
				Background Color: Default
			Data Field: dfSum2Pay
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
						Left:   2.583"
						Top:    1.821"
						Width:  1.533"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: ###000
					Country: Default
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Default
					Text Color: Red
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Pushbutton: pbOK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Выбрать
				Window Location and Size
					Left:   4.483"
					Top:    0.821"
					Width:  1.2"
					Width Editable? Yes
					Height: 0.452"
					Height Editable? Yes
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Picture File Name: \BARS98\RESOURCE\BMP\Execute.bmp
				Picture Transparent Color: None
				Image Style: Single
				Text Color: Default
				Background Color: Default
				Message Actions
					On SAM_Click
						If dfSumKomiss = NUMBER_Null
							Set dfSumKomiss = 0
						If dfKvK = dfKvP
							Set dfKurs = 1
						If dfKvK != dfKvP AND (dfKurs = NUMBER_Null OR dfKurs = 0)
							Call Debug('Не указан кросс-курс!')
							Call SalSetFocus( dfKurs )
						!
						Else
							Set nSmax = 
									    NumbeRound(IifN(SUMDEBT/100<NumbeRound((dfSumP+dfSumKomiss)*dfKurs),
									                    SUMDEBT/100,
									                    (dfSumP+dfSumKomiss)*dfKurs)/dfKurs-dfSumKomiss)
							If dfSum2Pay > nSmax
								Call Debug('Указанная сумма превышает макс.допустимую! ('||SalNumberToStrX(nSmax,2)||')')
								Set dfSum2Pay = nSmax
								Call SalSetFocus( dfSum2Pay )
							Else
								Set KURS = dfKurs
								Set SUM2PAY = dfSum2Pay*100
								Set KOMISS = dfSumKomiss*100
								Call SalDestroyWindow( hWndForm )
			Pushbutton: pbCancel
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   4.483"
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
				Picture File Name:
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						Set KURS = NUMBER_Null
						Set SUM2PAY = NUMBER_Null
						Set KOMISS = NUMBER_Null
						Call SalDestroyWindow( hWndForm )
		Functions
			Function: NumbeRound
				Description:
				Returns
				Parameters
					Number: nNotRounded
				Static Variables
				Local variables
					Number: nI
				Actions
					Set nI = SalStrToNumber(SalNumberToStrX( nNotRounded, 2 ))
					Return nI
		Window Parameters
			Number: TIP
			! 1 - привязка ПЛ к ТД
			! 0 - привязка ПЛ к Контракту
			Number: IDP
			Number: REF
			Number: KVK
			Number: SUMDEBT
			Receive Number: KURS
			Receive Number: SUM2PAY
			Receive Number: KOMISS
		Window Variables
			Number: nFetchRes
			Date/Time: dDATP
			Number: nKURS_B
			Number: nKURS_S
			Number: nKVP
			Number: nSK
			Number: nKURS
			Number: nSmax
			Number: nTaken
		Message Actions
			On SAM_Create
				Call SalCenterWindow(dlg_EXPL)
				Set SUMDEBT = SalNumberRound( SUMDEBT )
				If SqlPrepareAndExecute(hSql(), 
						  "SELECT kv, s/100, fdat, kurs, nvl(komiss,0)
						     INTO :nKVP,:dfSumP,:dDATP,:nKURS,:nSK
						     FROM contract_p 
						    WHERE idp = :dlg_EXPL.IDP") 
					Call SqlFetchNext( hSql(), nFetchRes )
				! Была ли взята комиссия с платежа с таким РЕФ 
				If TIP = 1
					If REF != NUMBER_Null
						Call SqlPrepareAndExecute(hSql(), 
								    "SELECT nvl(sum(komiss),0) 
								       INTO :nTaken 
								       FROM contract_p 
								      WHERE idp <> :dlg_EXPL.IDP 
								        AND ref = :dlg_EXPL.REF") 
						If not SqlFetchNext( hSql(), nFetchRes )
							Set nTaken = 0
					Else
						Set nTaken = 0
					If nTaken != 0
						Set dfSumKomiss = 0
						Call SalDisableWindow( dfSumKomiss )
					Else
						Call SalEnableWindow( dfSumKomiss )
				Else
					Set dfSumKomiss = 0
					! Call SalDisableWindow( dfSumKomiss )
				!
				If SqlPrepareAndExecute(hSql(), 
						  "SELECT name INTO :dfKvP FROM tabval WHERE kv = :dlg_EXPL.nKVP") 
					Call SqlFetchNext( hSql(), nFetchRes )
				If SqlPrepareAndExecute(hSql(), 
						  "SELECT name INTO :dfKvK FROM tabval WHERE kv = :dlg_EXPL.KVK") 
					Call SqlFetchNext( hSql(), nFetchRes )
				! Кросс-курс
				If nKURS = NUMBER_Null
					Call GetXRate( nKURS, nKURS_B, nKURS_S, nKVP, KVK, dDATP )
				If KVK = nKVP
					Set nKURS = 1
					Call SalDisableWindow( dfKurs )
				Set dfKurs = nKURS
				! Сумма комиссии
				Set dfSumKomiss = nSK/100
				! Сумма долга
				Set dfSumDebt = SUMDEBT/100
				! Расчетная сумма платежа
				If dfKurs != NUMBER_Null AND dfKurs != 0
					Set dfSum2Pay = NumbeRound(
							                IifN(SUMDEBT/100<NumbeRound((dfSumP+dfSumKomiss)*dfKurs),
							                     SUMDEBT/100,
							                    (dfSumP+dfSumKomiss)*dfKurs
							                     )/dfKurs-dfSumKomiss)
				Call SalSetFocus( dfSumKomiss )
	Dialog Box: dlg_IMPTD
		Class:
		Property Template:
		Class DLL Name:
		Title: Пересчет суммы ТД/АКТа в валюту платежа
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  6.083"
				Width Editable? Yes
				Height: 2.298"
				Height Editable? Yes
			Absolute Screen Location? Yes
			Font Name: Default
			Font Size: Default
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description: Выбор кросс-курса
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
			Background Text: Валюта платежа:
				Resource Id: 40266
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    0.429"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.226"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: MS Sans Serif
				Font Size: 10
				Font Enhancement: Bold
				Text Color: Dark Blue
				Background Color: Default
			Data Field: dfKvPl
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
						Left:   2.383"
						Top:    0.405"
						Width:  3.5"
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
					Text Color: Dark Blue
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Data Field: dfTitleKv
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
						Left:   0.183"
						Top:    0.179"
						Width:  2.2"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? No
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: MS Sans Serif
					Font Size: 10
					Font Enhancement: Bold
					Text Color: Jade
					Background Color: 3D Face Color
					Input Mask: Unformatted
				Message Actions
			Data Field: dfKvTd
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
						Left:   2.383"
						Top:    0.155"
						Width:  3.5"
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
					Text Color: Jade
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Data Field: dfTitleSum
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
						Left:   0.183"
						Top:    0.679"
						Width:  2.2"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? No
					Justify: Right
					Format: Unformatted
					Country: Default
					Font Name: MS Sans Serif
					Font Size: 10
					Font Enhancement: Bold
					Text Color: Dark Blue
					Background Color: 3D Face Color
					Input Mask: Unformatted
				Message Actions
			Data Field: dfSumTd
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
						Left:   2.383"
						Top:    0.655"
						Width:  1.7"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: ###000
					Country: Default
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Default
					Text Color: Jade
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Data Field: dfSumPl
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
						Left:   4.183"
						Top:    0.655"
						Width:  1.7"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: ###000
					Country: Default
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Default
					Text Color: Dark Blue
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Background Text: Кросс-курс:
				Resource Id: 40269
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.15"
					Top:    0.929"
					Width:  2.2"
					Width Editable? Yes
					Height: 0.226"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: MS Sans Serif
				Font Size: 10
				Font Enhancement: Bold
				Text Color: Red
				Background Color: Default
			Data Field: dfKurs
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
						Left:   2.383"
						Top:    0.905"
						Width:  3.5"
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
					Text Color: Red
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			Pushbutton: pbCalc
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbSearch
				Property Template:
				Class DLL Name:
				Title: Рассчитать
				Window Location and Size
					Left:   1.183"
					Top:    1.321"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name: \BARS98\RESOURCE\BMP\ACCOUNTS.BMP
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						If dfKurs != NUMBER_Null AND dfKurs != 0
							Set dfSumPl = NumbeRound( SUM_TD * dfKurs )
			Pushbutton: pbOK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Выбрать
				Window Location and Size
					Left:   3.583"
					Top:    1.321"
					Width:  1.2"
					Width Editable? Yes
					Height: 0.452"
					Height Editable? Yes
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Picture File Name: \BARS98\RESOURCE\BMP\Execute.bmp
				Picture Transparent Color: None
				Image Style: Single
				Text Color: Default
				Background Color: Default
				Message Actions
					On SAM_Click
						If dfKurs = NUMBER_Null OR dfKurs = 0
							Call Debug('Не указан кросс-курс!')
							Call SalSetFocus( dfKurs )
						Else
							Set KURS = dfKurs
							Call SalDestroyWindow( hWndForm )
		Functions
			Function: NumbeRound
				Description:
				Returns
				Parameters
					Number: nNotRounded
				Static Variables
				Local variables
					Number: nI
				Actions
					Set nI = SalStrToNumber(SalNumberToStrX( nNotRounded, 2 ))
					Return nI
		Window Parameters
			Number: AKT
			Number: KV_PL
			Number: KV_TD
			Number: SUM_TD
			Date/Time: DAT_TD
			Receive Number: KURS
		Window Variables
			Number: nFetchRes
			Number: nKURS
			Number: nKURS_B
			Number: nKURS_S
		Message Actions
			On SAM_Create
				Call SalCenterWindow(dlg_IMPTD)
				!
				If AKT = 1
					Set dfTitleKv = 'Валюта АКТа:'
					Set dfTitleSum = 'Сумма АКТа:'
				Else
					Set dfTitleKv = 'Валюта ТД:'
					Set dfTitleSum = 'Сумма ТД:'
				!
				If SqlPrepareAndExecute(hSql(), 
						  "SELECT name INTO :dfKvPl FROM tabval WHERE kv=:dlg_IMPTD.KV_PL") 
					Call SqlFetchNext( hSql(), nFetchRes )
				If SqlPrepareAndExecute(hSql(), 
						  "SELECT name INTO :dfKvTd FROM tabval WHERE kv=:dlg_IMPTD.KV_TD") 
					Call SqlFetchNext( hSql(), nFetchRes )
				! Кросс-курс
				Call GetXRate( nKURS, nKURS_B, nKURS_S, KV_TD, KV_PL, DAT_TD )
				Set dfKurs = nKURS
				! Сумма ТД в валюте ТД
				Set dfSumTd = SUM_TD
				! Сумма ТД в валюте ПЛ
				If dfKurs != NUMBER_Null AND dfKurs != 0
					Set dfSumPl = NumbeRound( SUM_TD * dfKurs )
			On SAM_Destroy
				Set KURS = dfKurs
				Call SalDestroyWindow( hWndForm )
	Dialog Box: dlg_REESTR
		Class:
		Property Template:
		Class DLL Name:
		Title: Ввод реестра ТД
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  4.767"
				Width Editable? Yes
				Height: 2.369"
				Height Editable? Yes
			Absolute Screen Location? Yes
			Font Name: Default
			Font Size: Default
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description: Ввод реестра
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
			Data Field: dfReestr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 50
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   1.483"
						Top:    0.488"
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
			Data Field: dfDatR
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
						Left:   1.483"
						Top:    0.738"
						Width:  1.2"
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
			Pushbutton: pbOK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Выполнить
				Window Location and Size
					Left:   1.483"
					Top:    1.321"
					Width:  1.2"
					Width Editable? Yes
					Height: 0.56"
					Height Editable? Yes
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Picture File Name: \BARS98\RESOURCE\BMP\Execute.bmp
				Picture Transparent Color: None
				Image Style: Single
				Text Color: Default
				Background Color: Default
				Message Actions
					On SAM_Click
						If dfReestr !=STRING_Null
							Set sNAMER=dfReestr
						If dfDatR !=DATETIME_Null
							Set dDATER=dfDatR
						Call SalDestroyWindow( hWndForm )
			Background Text: Номер:
				Resource Id: 47114
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.383"
					Top:    0.488"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: MS Sans Serif
				Font Size: 10
				Font Enhancement: Bold
				Text Color: 3D Shadow Color
				Background Color: Default
			Background Text: Дата:
				Resource Id: 47115
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.383"
					Top:    0.762"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: MS Sans Serif
				Font Size: 10
				Font Enhancement: Bold
				Text Color: 3D Shadow Color
				Background Color: Default
			Group Box: Реестр ТД
				Resource Id: 47116
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    0.071"
					Width:  4.3"
					Width Editable? Yes
					Height: 1.167"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 12
				Font Enhancement: Bold
				Text Color: 3D Shadow Color
				Background Color: Default
		Functions
		Window Parameters
			Receive String: sNAMER
			Receive Date/Time: dDATER
		Window Variables
		Message Actions
			On SAM_Create
				Call SalCenterWindow( hWndForm )
	Form Window: EID
		Class:
		Property Template:
		Class DLL Name:
		Title:
		Icon File:
		Accesories Enabled? Yes
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
				Left:   0.475"
				Top:    0.865"
				Width:  8.7"
				Width Editable? Yes
				Height: 8.798"
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
		Description: Карточка контракта
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Default
				Location? Top
				Visible? Yes
				Size: 0.417"
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
						Left:   0.3"
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
							Set strTip = 'Перечитать'
						On SAM_Click
							Call SalPostMsg( hWndForm, UM_Populate, 0, 0 )
				Pushbutton: pbSave
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbUpdate
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.733"
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
							Set strTip = 'Сохранить'
						On SAM_Click
							If IDK = 0 
								Call SalWaitCursor(TRUE)
								If CheckData() AND Dublicate()
									If dfDAYS = NUMBER_Null
										Set dfDAYS = nCTRLDAYS_DFL
									If dfID_OPER = NUMBER_Null
										Set dfID_OPER = 1
									If dfBRANCH  = STRING_Null
										Set dfBRANCH = '0'
									If SqlPrepareAndExecute(hSql(), 
											"SELECT s_top_contracts.NEXTVAL INTO :nIDKTmp from dual") AND 
											   SqlFetchNext(hSql(), nFetchRes) AND nIDKTmp > 0 
										If SqlPrepareAndExecute( hSql(),
												   "INSERT INTO top_contracts 
												        (pid, impexp, name, rnk,
												         dateopen, dateclose, kv, s, closed,
												         benefname, benefcountry, benefacc,
												         benefbank, benefbic, benefadr,
												         bank_code, bankcountry,
												         continued, aim, cond, id_oper,
												         details, oe, control_days, branch) 
												    VALUES 
												        (:nIDKTmp,       :EID.PAR,    :EID.dfNAME, :EID.dfRNK,
												         :EID.dfDAT1,    :EID.dfDAT2, :EID.dfKV,   :EID.dfS100, 0,
												         :EID.dfNK,      :EID.dfCK,   :EID.dfAK,
												         :EID.dfBK,      :EID.dfBIC,  :EID.dfDK,
												         :EID.dfB010,    :EID.dfBCK,
												         :EID.dfLITS,    :EID.dfAIM,  :EID.dfCOND, :EID.dfID_OPER,
												         :EID.mlDETAILS, :EID.dfOE,   :EID.dfDAYS, :EID.dfBRANCH)")
											Call SqlCommit( hSql() )
											Set IDK = nIDKTmp
											Call SalDisableWindow( pbSave )
											Call SalEnableWindow( pbLicense )
										Else
											Call SqlRollback( hSql() )
								Call SalWaitCursor(FALSE)
								Call SalSetFocus( pbExit )
							Else
								If MODE = 1 
									Call SalWaitCursor(TRUE)
									If CheckData() AND AskCtrlDays() 
										If SqlPrepareAndExecute( hSql(), 
												   "UPDATE top_contracts 
												       SET name         = :EID.dfNAME,
												           dateopen     = :EID.dfDAT1,
												           dateclose    = :EID.dfDAT2,
												           kv           = :EID.dfKV,
												           s            = :EID.dfS100,
												           benefname    = :EID.dfNK,
												           benefcountry = :EID.dfCK,
												           benefacc     = :EID.dfAK,
												           benefbank    = :EID.dfBK,
												           benefbic     = :EID.dfBIC,
												           benefadr     = :EID.dfDK,
												           bank_code    = :EID.dfB010,
												           bankcountry  = :EID.dfBCK,        
												           continued    = :EID.dfLITS,
												           aim          = :EID.dfAIM,
												           cond         = :EID.dfCOND,
												           id_oper      = :EID.dfID_OPER,
												           details      = :EID.mlDETAILS,
												           oe           = :EID.dfOE,
												           control_days = :EID.dfDAYS,
												           branch       = :EID.dfBRANCH
												     WHERE pid = :EID.IDK")
											If nCTRLDAYS_OLD != dfDAYS AND 
													  (NOT SqlPrepareAndExecute(hSql(), 
													      "UPDATE contract_p SET dat91 = fdat + "||Str(dfDAYS)||" + 1 WHERE pid=:EID.IDK")
													    OR 
													   NOT SqlPrepareAndExecute(hSql(), 
													      "UPDATE tamozhdoc SET dat91 = datedoc + "||Str(dfDAYS)||" + 1 WHERE pid=:EID.IDK")
													   )
												Call SqlRollback( hSql() )
											Else
												Call SqlCommit( hSql() )
										Else
											Call SqlRollback( hSql() )
									Call SalWaitCursor(FALSE)
									Call SalSetFocus( pbExit )
							Call SalPostMsg( hWndForm, UM_Populate, 0, 0 )
				Pushbutton: pbLicense
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbBrowse
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.167"
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
					Picture File Name: \BARS98\RESOURCE\BMP\ATTACH.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Лицензии'
						On SAM_Click
							Call SalCreateWindow(Tbl_License, hWndMDI, MODE, IDK)
				Pushbutton: pbExit
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbCancel
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.6"
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
							Set strTip = 'Завершить'
						On SAM_Click
							Call SalDestroyWindow(hWndForm)
		Contents
			!
			Group Box: Клиент
				Resource Id: 52453
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    0.012"
					Width:  7.883"
					Width Editable? Yes
					Height: 0.679"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 12
				Font Enhancement: Bold
				Text Color: 3D Shadow Color
				Background Color: Default
			Pushbutton: pbKlient
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbGetValue
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   7.483"
					Top:    0.262"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name: \BARS98\RESOURCE\BMP\Look.bmp
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Create
						Set strTip = 'Искать клиента'
					On SAM_Click
						Call SalCreateWindow( KLIENT, hWndMDI )
			Data Field: dfRNK
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
						Left:   0.983"
						Top:    0.298"
						Width:  0.833"
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
			Data Field: dfNAMEK
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
						Left:   1.82"
						Top:    0.298"
						Width:  5.567"
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
			Group Box: Контракт
				Resource Id: 40412
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    0.655"
					Width:  7.883"
					Width Editable? Yes
					Height: 1.405"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 12
				Font Enhancement: Bold
				Text Color: 3D Shadow Color
				Background Color: Default
			Background Text: Номер:
				Resource Id: 52003
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.883"
					Top:    1.012"
					Width:  0.867"
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
			Data Field: dfNAME
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 50
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   1.783"
						Top:    0.988"
						Width:  2.5"
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
			Background Text: Тип:
				Resource Id: 51999
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.983"
					Top:    1.262"
					Width:  0.767"
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
			Data Field: dfIMPEXP
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
						Left:   1.783"
						Top:    1.238"
						Width:  2.5"
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
			Background Text: Сумма:
				Resource Id: 40410
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.883"
					Top:    1.512"
					Width:  0.867"
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
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   1.783"
						Top:    1.488"
						Width:  2.5"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Right
					Format: ###000
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_Validate
						Set dfS100=dfS*100
						Return VALIDATE_Ok
			Data Field: dfS100
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
						Left:   Default
						Top:    Default
						Width:  Default
						Width Editable? Yes
						Height: Default
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
			Background Text: Валюта:
				Resource Id: 40411
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.783"
					Top:    1.762"
					Width:  0.967"
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
			Data Field: dfKV
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
						Left:   1.783"
						Top:    1.738"
						Width:  0.483"
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
						If SalIsNull( dfKV )
							Call SalListSetSelect( cmb_Kv, -1 )
							Return VALIDATE_OkClearFlag
						Call cmb_Kv.SetSelectById( dfKV )
						If cmb_Kv.nCurrentId
							Return VALIDATE_Ok
						Else
							Call SalMessageBox( 'Неверно указан код валюты!', 'Ошибка', MB_IconStop )
							Return VALIDATE_Cancel
			Data Field: dfISO
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
						Left:   3.667"
						Top:    1.19"
						Width:  0.55"
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
			Combo Box: cmb_Kv
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_NumId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   2.283"
					Top:    1.738"
					Width:  2.0"
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
						Call cmb_Kv.Init(hWndItem)
						Call cmb_Kv.Populate(hSql(),"KV","NAME","TABVAL"," WHERE d_close IS NULL ORDER BY 1 desc")
						Call cmb_Kv.SetSelectById( dfKV )
					On SAM_Click
						Set dfKV = cmb_Kv.GetKey( SalListQuerySelection( cmb_Kv))
			Background Text: Период действия:
				Resource Id: 40409
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.583"
					Top:    1.0"
					Width:  1.933"
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
			Data Field: dfDAT1
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
						Left:   4.383"
						Top:    1.238"
						Width:  1.183"
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
			Data Field: dfDAT2
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
						Left:   5.583"
						Top:    1.238"
						Width:  1.183"
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
			Data Field: dfID_OPER
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
						Left:   Default
						Top:    Default
						Width:  Default
						Width Editable? Yes
						Height: Default
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
			Radio Button: rb1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Поставка товара
				Window Location and Size
					Left:   4.383"
					Top:    1.55"
					Width:  2.2"
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
						Set EID.dfID_OPER=1
			Radio Button: rb2
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Выполнение работ
				Window Location and Size
					Left:   4.383"
					Top:    1.755"
					Width:  2.2"
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
						Set EID.dfID_OPER=2
			!
			Line
				Resource Id: 52027
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Coordinates
					Begin X:  6.783"
					Begin Y:  0.821"
					End X:  6.783"
					End Y:  1.988"
				Visible? Yes
				Line Style: Etched
				Line Thickness: 3
				Line Color: 3D Shadow Color
			Background Text: Контрол.
				Resource Id: 52028
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   6.933"
					Top:    0.857"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Center
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Background Text: срок:
				Resource Id: 52029
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   6.933"
					Top:    1.048"
					Width:  1.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Center
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Radio Button: rb90
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: 90 дн.
				Window Location and Size
					Left:   6.933"
					Top:    1.238"
					Width:  1.0"
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
						Set EID.dfDAYS=90
			Radio Button: rb180
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: 180 дн.
				Window Location and Size
					Left:   6.933"
					Top:    1.488"
					Width:  1.0"
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
						Set EID.dfDAYS=180
			Radio Button: rb500
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: 500 дн.
				Window Location and Size
					Left:   6.933"
					Top:    1.762"
					Width:  1.0"
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
						Set EID.dfDAYS=500
			Data Field: dfDAYS
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
						Left:   Default
						Top:    Default
						Width:  Default
						Width Editable? Yes
						Height: Default
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
			!
			Group Box: Контрагент
				Resource Id: 51998
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    2.155"
					Width:  7.883"
					Width Editable? Yes
					Height: 2.167"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 12
				Font Enhancement: Bold
				Text Color: 3D Shadow Color
				Background Color: Default
			Pushbutton: pbAlien
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbPrint
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   7.483"
					Top:    2.488"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name: \BARS98\RESOURCE\BMP\USER.BMP
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Create
						Set strTip = 'Справочник контрагентов'
					On SAM_Click
						If NOT SalIsNull( dfRNK )	
							If SalIsNull( dfNK ) AND SalIsNull( COUNTRY )	 
								If hWndAlien
									Call SalDestroyWindow( hWndAlien )
								Set hWndAlien = SalCreateWindow( RNK_ALIEN, hWndMDI, dfRNK, 1 )
							Else
								If hWndAlien
									Call SalDestroyWindow( hWndAlien )
								Set hWndAlien = SalCreateWindow( RNK_ALIEN, hWndMDI, dfRNK, 0 )
						Else
							Call SalMessageBox( 'Укажите клиента!', 'Внимание', MB_IconExclamation )
			Pushbutton: pbSW
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbOk
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   7.483"
					Top:    3.25"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name: \BARS98\RESOURCE\BMP\HELP.BMP
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Create
						Set strTip = 'Искать банк'
					On SAM_Click
						If NOT SalIsNull( dfBIC ) OR NOT SalIsNull( dfB010 )
							Call SalCreateWindow( SW_BANKS, hWndMDI, dfBIC, dfB010 )
						Else
							Call SalMessageBox( 'Укажите код банка или маску BIC-кода!', 'Внимание', MB_IconExclamation )
			!
			Background Text: Наименование:
				Resource Id: 52454
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.23"
					Top:    2.44"
					Width:  1.55"
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
			Data Field: dfNK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 50
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   1.783"
						Top:    2.405"
						Width:  5.6"
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
			Background Text: Страна:
				Resource Id: 40414
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.583"
					Top:    2.679"
					Width:  1.15"
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
			Data Field: dfCK
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
						Left:   1.783"
						Top:    2.655"
						Width:  0.533"
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
						If SalIsNull( dfCK )
							Call SalListSetSelect( COUNTRY, -1 )
							Return VALIDATE_OkClearFlag
						Call COUNTRY.SetSelectById( dfCK )
						If COUNTRY.nCurrentId
							Return VALIDATE_Ok
						Else
							Call SalMessageBox( 'Неверно указан код страны!', 'Ошибка', MB_IconStop )
							Return VALIDATE_Cancel
			Combo Box: COUNTRY
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_NumId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   2.3"
					Top:    2.655"
					Width:  5.083"
					Width Editable? Class Default
					Height: 2.429"
					Height Editable? Class Default
				Visible? Class Default
				Editable? Class Default
				String Type: Class Default
				Maximum Data Length: Class Default
				Sorted? Class Default
				Always Show List? Class Default
				Vertical Scroll? Yes
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Input Mask: Class Default
				List Initialization
				Message Actions
					On SAM_Create
						Call COUNTRY.Init( hWndItem )
						Call COUNTRY.Populate( hSql(),"COUNTRY", "NAME", "COUNTRY"," ORDER BY NAME" )
						Call COUNTRY.SetSelectById( dfCK )
					On SAM_Click
						Set dfCK = COUNTRY.GetKey( SalListQuerySelection( hWndItem ) )
			Background Text: Адрес:
				Resource Id: 34215
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.683"
					Top:    2.929"
					Width:  1.05"
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
			Data Field: dfDK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 50
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   1.783"
						Top:    2.91"
						Width:  6.1"
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
			Background Text: Код B010:
				Resource Id: 40415
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.483"
					Top:    3.179"
					Width:  1.25"
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
			Data Field: dfB010
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 10
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   1.783"
						Top:    3.155"
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
			Background Text: BIC-код:
				Resource Id: 39335
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   3.85"
					Top:    3.202"
					Width:  1.45"
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
			Data Field: dfBIC
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
						Left:   5.383"
						Top:    3.155"
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
			Background Text: Банк:
				Resource Id: 39333
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.583"
					Top:    3.429"
					Width:  1.15"
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
			Data Field: dfBK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 50
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   1.783"
						Top:    3.405"
						Width:  5.6"
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
			Background Text: Страна банка:
				Resource Id: 38391
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    3.702"
					Width:  1.517"
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
			Data Field: dfBCK
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
						Left:   1.783"
						Top:    3.655"
						Width:  0.533"
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
						If SalIsNull( dfBCK )
							Call SalListSetSelect( BANKCOUNTRY, -1 )
							Return VALIDATE_OkClearFlag
						Call BANKCOUNTRY.SetSelectById( dfBCK )
						If BANKCOUNTRY.nCurrentId
							Return VALIDATE_Ok
						Else
							Call SalMessageBox( 'Неверно указан код страны банка!', 'Ошибка', MB_IconStop )
							Return VALIDATE_Cancel
			Combo Box: BANKCOUNTRY
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_NumId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   2.3"
					Top:    3.667"
					Width:  5.083"
					Width Editable? Class Default
					Height: 2.429"
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
						Call BANKCOUNTRY.Init( hWndItem )
						Call BANKCOUNTRY.Populate( hSql(),"COUNTRY", "NAME", "COUNTRY"," ORDER BY NAME" )
						Call BANKCOUNTRY.SetSelectById( dfBCK )
					On SAM_Click
						Set dfBCK = BANKCOUNTRY.GetKey( SalListQuerySelection( hWndItem ) )
			Background Text: Счет:
				Resource Id: 39334
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.783"
					Top:    3.929"
					Width:  0.95"
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
			Data Field: dfAK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 50
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   1.783"
						Top:    3.905"
						Width:  6.1"
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
			Group Box: Дополнительно
				Resource Id: 34454
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    4.405"
					Width:  7.9"
					Width Editable? Yes
					Height: 1.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 12
				Font Enhancement: Bold
				Text Color: 3D Shadow Color
				Background Color: Default
			Background Text: Лицензия на продление сроков:
				Resource Id: 40418
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.24"
					Top:    4.631"
					Width:  3.3"
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
			Data Field: dfLITS
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 80
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   3.483"
						Top:    4.571"
						Width:  4.367"
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
			Background Text: Условия контракта:
				Resource Id: 40419
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    4.845"
					Width:  3.3"
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
			Data Field: dfCOND
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
						Left:   3.483"
						Top:    4.821"
						Width:  4.367"
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
			Background Text: Предмет контракта:
				Resource Id: 40420
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    5.095"
					Width:  3.3"
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
			Data Field: dfAIM
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
						Left:   3.483"
						Top:    5.071"
						Width:  4.367"
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
			Background Text: Вид эк. деятельности:
				Resource Id: 64332
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.883"
					Top:    5.345"
					Width:  2.6"
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
			Data Field: dfOE
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
						Left:   3.483"
						Top:    5.321"
						Width:  0.5"
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
						Call OE.SetSelectById( dfOE )
			Combo Box: OE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_StrId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   3.983"
					Top:    5.321"
					Width:  3.867"
					Width Editable? Class Default
					Height: 1.655"
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
						Call OE.Init( hWndItem )
						Call OE.Populate( hSql(),"K113", "TXT", "KL_K113"," ORDER BY K113" )
						Call OE.SetSelectById( dfOE )
					On SAM_Click
						Set dfOE = OE.GetKey(SalListQuerySelection(OE))
			!
			Group Box: Подразделение банка
				Resource Id: 13303
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    5.69"
					Width:  7.9"
					Width Editable? Yes
					Height: 0.607"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 12
				Font Enhancement: Bold
				Text Color: 3D Shadow Color
				Background Color: Default
			Data Field: dfBRANCH
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
						Left:   1.983"
						Top:    5.964"
						Width:  1.483"
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
						If SalIsNull(dfBRANCH)
							Set dfBRANCH = '0'
						Call cmbBRANCH.SetSelectById(dfBRANCH)
						If cmbBRANCH.strCurrentId
							Return VALIDATE_Ok
						Else
							Call SalMessageBox('Неверно указан код подразделения банка!', 'Ошибка', MB_IconStop)
							Return VALIDATE_Cancel
			Combo Box: cmbBRANCH
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenComboBox_StrId
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   3.483"
					Top:    5.952"
					Width:  4.367"
					Width Editable? Class Default
					Height: 1.19"
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
						Call cmbBRANCH.Init(hWndItem)
						Call cmbBRANCH.Populate(hSql(), "TOBO", "NAME", "TOBO"," WHERE DATE_CLOSED IS NULL ORDER BY TOBO" )
						Call cmbBRANCH.SetSelectById(dfBRANCH)
					On SAM_Click
						Set dfBRANCH = cmbBRANCH.GetKey(SalListQuerySelection( hWndItem))
			!
			Group Box: Подробности контракта
				Resource Id: 34453
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.183"
					Top:    6.345"
					Width:  7.9"
					Width Editable? Yes
					Height: 1.0"
					Height Editable? Yes
				Visible? Yes
				Font Name: MS Sans Serif
				Font Size: 12
				Font Enhancement: Bold
				Text Color: 3D Shadow Color
				Background Color: Default
			Multiline Field: mlDETAILS
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 250
					String Type: String
					Editable? Yes
				Display Settings
					Border? Yes
					Word Wrap? Yes
					Vertical Scroll? Yes
					Window Location and Size
						Left:   0.383"
						Top:    6.595"
						Width:  7.5"
						Width Editable? Yes
						Height: 0.667"
						Height Editable? Yes
					Visible? Yes
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
				Message Actions
			Background Text: Подразделение:
				Resource Id: 13302
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.25"
					Top:    6.012"
					Width:  1.65"
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
			Function: CheckData
				Description: Проверка заполнения обязательных полей
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					String: strErrorList
					Number: nErrorCount
				Actions
					Set strErrorList = ''
					Set nErrorCount = 0
					!
					If SalIsNull( dfNAME )
						Set nErrorCount = nErrorCount + 1
						Set strErrorList = strErrorList || SalNumberToStrX(nErrorCount,0) || ': ' ||
								'Не заполнен реквизит <Номер контракта>' || PutCrLf()
					If SalIsNull(dfS100 )
						Set nErrorCount = nErrorCount + 1
						Set strErrorList = strErrorList || SalNumberToStrX(nErrorCount,0) || ': ' ||
								'Не заполнен реквизит <Сумма контракта>' || PutCrLf()
					If SalIsNull(dfKV)
						Set nErrorCount = nErrorCount + 1
						Set strErrorList = strErrorList || SalNumberToStrX(nErrorCount,0) || ': ' ||
								'Не заполнен реквизит <Валюта контракта>' || PutCrLf()
					If SalIsNull( dfRNK )
						Set nErrorCount = nErrorCount + 1
						Set strErrorList = strErrorList || SalNumberToStrX(nErrorCount,0) || ': ' ||
								'Не заполнен реквизит <Клиент>' || PutCrLf()
					If SalIsNull( dfDAT1 )
						Set nErrorCount = nErrorCount + 1
						Set strErrorList = strErrorList || SalNumberToStrX(nErrorCount,0) || ': ' ||
								'Не заполнен реквизит <Дата открытия контракта>' || PutCrLf()
					If SalIsNull( dfNK )
						Set nErrorCount = nErrorCount + 1
						Set strErrorList = strErrorList || SalNumberToStrX(nErrorCount,0) || ': ' ||
								'Не заполнен реквизит <Наименование контрагента>' || PutCrLf()
					If SalIsNull( dfCK )
						Set nErrorCount = nErrorCount + 1
						Set strErrorList = strErrorList || SalNumberToStrX(nErrorCount,0) || ': ' ||
								'Не заполнен реквизит <Страна контрагента>' || PutCrLf()
					If SalIsNull( dfOE )
						Set nErrorCount = nErrorCount + 1
						Set strErrorList = strErrorList || SalNumberToStrX(nErrorCount,0) || ': ' ||
								'Не заполнен реквизит <Вид эконом.деятельности>' || PutCrLf()
					If nErrorCount > 0
						Call SalMessageBox( strErrorList, 'Ошибка заполнения реквизитов', MB_Ok )
						Return FALSE
					Return TRUE
			Function: Dublicate
				Description: Проверка на наличие контракта - дубликата 
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					Number: nDubl
				Actions
					Set nDubl = 0
					If SqlPrepareAndExecute( hSql(), 
							     "SELECT count(*) INTO :nDubl FROM top_contracts 
							      WHERE impexp=:EID.PAR  AND rnk=:EID.dfRNK AND 
							            name=:EID.dfNAME AND dateopen=:EID.dfDAT1" )
						Call SqlFetchNext( hSql(), nTmp )
					If nDubl > 0
						If SalMessageBox( 'Контракт с указанными параметрами (клиент, № и дата) '||PutCrLf(  )||
								                  'уже заведен! Продолжить?' , 'Внимание!', MB_IconQuestion|MB_YesNo )=IDNO
							Return FALSE
						Else
							Return TRUE
					Return TRUE
			Function: AskCtrlDays 
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
				Actions
					If IDK != 0 AND nCTRLDAYS_OLD != dfDAYS
						If SalMessageBox( 
								  'Изменить КОНТРОЛЬНЫЙ СРОК с '||Str(nCTRLDAYS_OLD)||' дней до '||Str(dfDAYS)||'дней?', 
								  'Внимание', 
								   MB_IconExclamation|MB_YesNo ) = IDNO
							Return FALSE
					Return TRUE
		Window Parameters
			! IDK - референс контракта
			Number: IDK
			! MODE = 0 - пустая карточка (открытие контракта)
			! MODE = 1 - карточка контракта (редактирование)
			! MODE = 9 - карточка контракта (просмотр)
			Number: MODE 
			! PAR  = 1 - импорт
			! PAR  = 0 - экспорт
			Number: PAR
			Window Handle: hWndParent
		Window Variables
			Window Handle: hChild
			Number: nFetchRes
			Number: nTmp
			String: sTmp
			Number: nCTRLDAYS_OLD
			Number: nIDKTmp
			Number: nCTRLDAYS_DFL
		Message Actions
			On SAM_Create
				Call SalCenterWindow( hWndForm )
				If SqlPrepareAndExecute(hSql(), 
						  "SELECT name INTO :EID.dfIMPEXP FROM contrtype WHERE r_impexp=:EID.PAR")
					Call SqlFetchNext( hSql(), nTmp )
					Call SalDisableWindow( dfIMPEXP )
				If MODE = 1 and IDK != 0
					Call SalDisableWindow( dfRNK )
					Call SalDisableWindow( dfNAMEK )
					Call SalDisableWindow( pbKlient )
				If IDK = 0
					Call SalDisableWindow( pbRefresh )
					Call SalDisableWindow( pbLicense )
					! умолчат.срок расчетов по контракту
					If SqlPrepareAndExecute(hSql(), 
							  "SELECT to_number(val) 
							     INTO :EID.nCTRLDAYS_DFL 
							     FROM birja 
							    WHERE par = 'CTRLDAYS' AND val IS NOT NULL")
							AND NOT SqlFetchNext(hSql(), nFetchRes)
						Set nCTRLDAYS_DFL = 90
				If MODE = 9
					Call SalDisableWindow( pbSave )
					Call SalDisableWindow( pbAlien )
				! Работа модуля в подразделениях банка
				If GetGlobalOptionEx('HAVETOBO') > 0
					Call SalEnableWindow(dfBRANCH)
					Call SalEnableWindow(cmbBRANCH)
				Else
					Call SalDisableWindow(dfBRANCH)
					Call SalDisableWindow(cmbBRANCH)
				!
				Call SalSendMsg( hWndForm, UM_Populate, 0, 0 )
			On SAM_CreateComplete
				Call SalSetWindowText( hWndForm, 'Карточка контракта  '|| dfNAME  )
			On UM_Populate
				If IDK != 0
					Call SalWaitCursor( TRUE )
					If SqlPrepareAndExecute ( hSql(),
							   "SELECT t.rnk, cust.nmk,
							           t.name, t.dateopen, t.dateclose, 
							           t.kv, v.lcv, v.name, 
							           t.s/100, t.s,
							           t.benefname, t.benefcountry, c.name,
							           t.benefacc, t.benefbank, t.benefbic, 
							           t.benefadr, t.bank_code, t.bankcountry,
							           t.continued, t.aim, t.cond, 
							           t.id_oper, t.details, t.oe, 
							           t.control_days, t.branch, b.name
							     INTO :EID.dfRNK,    :EID.dfNAMEK,
							          :EID.dfNAME,   :EID.dfDAT1,   :EID.dfDAT2,
							          :EID.dfKV,     :EID.dfISO,    :EID.cmb_Kv,
							          :EID.dfS,      :EID.dfS100,
							          :EID.dfNK,     :EID.dfCK,     :EID.COUNTRY,
							          :EID.dfAK,     :EID.dfBK,     :EID.dfBIC,
							          :EID.dfDK,     :EID.dfB010,   :EID.dfBCK,
							          :EID.dfLITS,   :EID.dfAIM,    :EID.dfCOND,
							          :EID.dfID_OPER,:EID.mlDETAILS,:EID.dfOE,
							          :EID.dfDAYS,   :EID.dfBRANCH, :EID.cmbBRANCH 
							     FROM top_contracts t, tabval v, country c, customer cust, tobo b
							    WHERE t.kv           = v.kv(+)   
							      AND t.benefcountry = c.country(+) 
							      AND t.rnk          = cust.rnk
							      AND t.branch       = b.tobo 
							      AND t.pid          = :EID.IDK")
						Call SqlFetchNext( hSql(), nTmp)
						If EID.dfID_OPER = 2
							Set rb2 = TRUE
						Else
							Set rb1 = TRUE
						!
						If EID.dfDAYS = 500
							Set rb500 = TRUE
						Else If EID.dfDAYS = 180
							Set rb180 = TRUE
						Else
							Set rb90 = TRUE
						Set nCTRLDAYS_OLD = dfDAYS
					Call SalWaitCursor( FALSE )
				Else
					Set dfDAYS = nCTRLDAYS_DFL 
					If dfDAYS = 500
						Set rb500 = TRUE
					Else If dfDAYS = 180
						Set rb180 = TRUE
					Else
						Set rb90 = TRUE
			On SAM_Destroy
				If hWndParent 
					Call SalSendMsg( hWndParent, UM_Populate, 0, 0)
	Table Window: KLIENT
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Поиск клиента
		Icon File:
		Accesories Enabled? Yes
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
				Width:  8.717"
				Width Editable? Class Default
				Height: 4.393"
				Height Editable? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: None
			Text Color: Class Default
			Background Color: Class Default
			View: Class Default
			Allow Row Sizing? Class Default
			Lines Per Row: Class Default
		Memory Settings
			Maximum Rows in Memory: 30000
			Discardable? Class Default
		Description: Выбор клиента из CUSTOMER
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
					Resource Id: 52000
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
				Line
					Resource Id: 52002
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
				Line
					Resource Id: 52001
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
				Pushbutton: pbSearch
					Class Child Ref Key: 38
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.05"
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
				Pushbutton: pbFilter
					Class Child Ref Key: 44
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.483"
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
				Pushbutton: pbExit
					Class Child Ref Key: 42
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.35"
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
				Pushbutton: pbOK
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.917"
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
							Set strTip = 'Выбрать '
						On SAM_Click
							Set nTmp= SalTblQueryContext( EID )
							If not SalTblQueryRowFlags( EID, nTmp, ROW_New ) 
								Call SalTblSetRowFlags( EID, nTmp, ROW_Edited, TRUE ) 
							Set EID.dfRNK=KLIENT.r1
							Set EID.dfNAMEK=KLIENT.n1
							Set EID.dfOE=KLIENT.v1
							Call EID.OE.SetSelectById( EID.dfOE )
							Call SalDestroyWindow(KLIENT)
		Contents
			Column: r1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Рег №
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
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
			Column: d1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: №
						договора
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
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
			Column: n1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Наименование
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  5.817"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: v1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Наименование
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  5.817"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
			Number: nTmp
			String: strFilter
		Message Actions
			On SAM_Create
				Call SalCenterWindow( hWndForm )
				Set KLIENT.fFilterAtStart=TRUE
				Set KLIENT.strFilterTblName="CUSTOMER"
				Call SalSendClassMessage( SAM_Create, 0, 0 )
				Set KLIENT.strSqlPopulate=
						    "SELECT customer.rnk, customer.nd, customer.nmk,k3.k113 
						       FROM customer, kl_k113 k3, (select k110, k113 from kl_k110 where d_close is null) k1 
						      WHERE customer.ved = k1.k110(+) 
						        AND k1.k113 = k3.k113(+)
						        AND date_off is null  "
			On SAM_DoubleClick
				Call SalSendMsg( pbOK, SAM_Click, 0, 0 )
			On UM_Populate
				If strSqlPopulate != ''
					If fFilterAtStart
						If SetQueryFilter( cF )
							Set fFilterAtStart = NOT fFilterAtStart
					If NOT fFilterAtStart
						Call SalWaitCursor(TRUE)
						Call SalTblDefineSplitWindow(hWndForm, 0, FALSE)
						! Set strDSql = cQ.GetFullSQLString(cF)
						Set strFilter = cF.GetFilterWhereClause(FALSE)
						Set strDSql = strSqlPopulate||IifS(strFilter = '', "", " and "||strFilter)||" ORDER BY customer.rnk "
						Call BindList.ActivateBinds()
						Call SalTblPopulate(hWndForm, cMain.hSql(), strDSql, nTabPopulateMethod)
						Call SalTblSetContext(hWndForm, 0)
						Call SalPostMsg(hWndForm, SAM_TblDoDetails, 0, 0)
						Call SalWaitCursor(FALSE)
					Else
						Call SalDestroyWindow( hWndForm )
	Table Window: SW_BANKS
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Поиск банка
		Icon File:
		Accesories Enabled? Yes
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
				Width:  10.833"
				Width Editable? Class Default
				Height: 4.69"
				Height Editable? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: None
			Text Color: Class Default
			Background Color: Class Default
			View: Class Default
			Allow Row Sizing? Class Default
			Lines Per Row: Class Default
		Memory Settings
			Maximum Rows in Memory: 30000
			Discardable? Class Default
		Description: Выбор банка из SW_BANKS
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
					Resource Id: 6444
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
				Line
					Resource Id: 6445
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
				Line
					Resource Id: 6446
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
				Pushbutton: pbSearch
					Class Child Ref Key: 38
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.05"
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
				Pushbutton: pbFilter
					Class Child Ref Key: 44
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.483"
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
				Pushbutton: pbExit
					Class Child Ref Key: 42
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.35"
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
				Pushbutton: pbOK
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.917"
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
							Set strTip = 'Выбрать '
						On SAM_Click
							Set nTmp= SalTblQueryContext( EID )
							If not SalTblQueryRowFlags( EID, nTmp, ROW_New ) 
								Call SalTblSetRowFlags( EID, nTmp, ROW_Edited, TRUE ) 
							Set EID.dfBIC        = SW_BANKS.cBIC
							Set EID.dfB010       = SW_BANKS.cB010
							Set EID.dfBK         = SW_BANKS.cNAME
							Set EID.dfBCK        = SW_BANKS.cCOUNTRY
							Set EID.BANKCOUNTRY  = SW_BANKS.cCOUNTRYNAME
							Call SalDestroyWindow(SW_BANKS)
		Contents
			Column: cB010
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код B010
				Visible? Yes
				Editable? No
				Maximum Data Length: 10
				Data Type: String
				Justify: Left
				Width:  1.533"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cBIC
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: BIC-код банка
				Visible? Yes
				Editable? No
				Maximum Data Length: 11
				Data Type: String
				Justify: Right
				Width:  1.533"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cNAME
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Наименование банка
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  4.55"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cCOUNTRY
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код страны
				Visible? No
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  1.967"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cCOUNTRYNAME
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Страна
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.967"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cADR
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Адрес
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
		Functions
		Window Parameters
			String: sBIC
			String: sB010
		Window Variables
			Number: nTmp
		Message Actions
			On SAM_Create
				Call SalCenterWindow( hWndForm )
				! Поиск банка по коду B010 (RC_BNK)
				If sB010 != STRING_Null
					Set SW_BANKS.strFilterTblName="RC_BNK"
					Set SW_BANKS.strSqlPopulate=
							   "SELECT rc_bnk.b010, rc_bnk.swift_code, substr(rc_bnk.name,1,50), 
							           rc_bnk.k040, country.name, rc_bnk.nnp
							      INTO :SW_BANKS.cB010,:SW_BANKS.cBIC,:SW_BANKS.cNAME,
							           :SW_BANKS.cCOUNTRY,:SW_BANKS.cCOUNTRYNAME,:SW_BANKS.cADR
							      FROM rc_bnk, country   
							     WHERE country.country=rc_bnk.k040 
							       AND rc_bnk.b010 LIKE '%"||sB010||"%'"||
							   " ORDER BY 1"  
				! Поиск банка по BIC-коду (SW_BANKS)
				Else
					Set SW_BANKS.strFilterTblName="SW_BANKS"
					Set SW_BANKS.strSqlPopulate=
							   " SELECT sw_banks.bic, substr(sw_banks.name,1,50), 
							            sw_banks.country, sw_banks.city 
							       INTO :SW_BANKS.cBIC,:SW_BANKS.cNAME,
							            :SW_BANKS.cCOUNTRYNAME,:SW_BANKS.cADR      
							       FROM sw_banks 
							      WHERE sw_banks.bic LIKE '%"||sBIC||"%'"||
							   " ORDER BY 1"  
				Call SalSendClassMessage( SAM_Create, 0, 0 )
			On SAM_DoubleClick
				Set nTmp= SalTblQueryContext( EID )
				If not SalTblQueryRowFlags( EID, nTmp, ROW_New ) 
					Call SalTblSetRowFlags( EID, nTmp, ROW_Edited, TRUE ) 
				Set EID.dfBIC        = SW_BANKS.cBIC
				Set EID.dfB010       = SW_BANKS.cB010
				Set EID.dfBK         = SW_BANKS.cNAME
				Set EID.dfBCK        = SW_BANKS.cCOUNTRY
				Set EID.BANKCOUNTRY  = SW_BANKS.cCOUNTRYNAME
				Call SalDestroyWindow(SW_BANKS)
	Table Window: RNK_ALIEN
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Справочник контрагентов для клиента
		Icon File:
		Accesories Enabled? Yes
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
				Width:  13.567"
				Width Editable? Class Default
				Height: 5.119"
				Height Editable? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: None
			Text Color: Class Default
			Background Color: Class Default
			View: Class Default
			Allow Row Sizing? Class Default
			Lines Per Row: Class Default
		Memory Settings
			Maximum Rows in Memory: 30000
			Discardable? Class Default
		Description: Справочник контрагентов
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Class Default
				Visible? Class Default
				Size: 0.44"
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
					Resource Id: 27044
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  4.15"
						Begin Y:  Class Default
						End X:  4.15"
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
						Left:   2.93"
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
					Resource Id: 27046
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  3.483"
						Begin Y:  Class Default
						End X:  3.483"
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
						Left:   4.283"
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
					Resource Id: 27045
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
				Pushbutton: pbChoose
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.6"
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
							Set strTip = 'Выбрать контрагента'
						On SAM_Click
							Set nTmp = SalTblQueryContext( EID )
							If not SalTblQueryRowFlags( EID, nTmp, ROW_New ) 
								Call SalTblSetRowFlags( EID, nTmp, ROW_Edited, TRUE ) 
							Set EID.dfNK    = RNK_ALIEN.cNMK
							Set EID.dfCK    = RNK_ALIEN.cCOUNTRY
							Set EID.COUNTRY = RNK_ALIEN.cNAME
							Set EID.dfBIC   = RNK_ALIEN.cBIC
							Set EID.dfB010  = RNK_ALIEN.cB010
							Set EID.dfBK    = RNK_ALIEN.cBANK
							Set EID.dfAK    = RNK_ALIEN.cACC
							Set EID.dfDK    = RNK_ALIEN.cADR
							Call SalDestroyWindow(RNK_ALIEN)
		Contents
			Column: cGLOBAL
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: 
						Общ.
						
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  0.55"
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
			Column: cRNK
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
				Width:  0.833"
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
			Column: cNMK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Наименование
						бенефициара
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 50
				Data Type: String
				Justify: Left
				Width:  2.917"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cCOUNTRY
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						страны
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 3
				Data Type: Number
				Justify: Right
				Width:  0.733"
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
					On SAM_Validate
						If cCOUNTRY = NUMBER_Null
							Return VALIDATE_Ok
						Else
							If SqlPrepareAndExecute( hSql(), 
									  "SELECT name INTO :RNK_ALIEN.cNAME
									     FROM country
									    WHERE country = :RNK_ALIEN.cCOUNTRY" ) 
									AND NOT SqlFetchNext( hSql(), nFetchRes )
								Call SalMessageBox( 'Введите правильный код страны!', 'Ошибка', MB_IconStop )
								Set cCOUNTRY = NUMBER_Null
								Set cNAME = STRING_Null
								Return VALIDATE_Cancel
			Column: cNAME
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Страна
						бенефициара
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
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
			Column: cB010
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						банка
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 10
				Data Type: String
				Justify: Left
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
					On SAM_Validate
						If cB010 = STRING_Null OR cB010 = '0'
							Return VALIDATE_Ok
						Else
							If SqlPrepareAndExecute( hSql(), 
									  "SELECT name, swift_code 
									     INTO :RNK_ALIEN.cBANK,:RNK_ALIEN.cBIC
									     FROM rc_bnk
									    WHERE b010 = :RNK_ALIEN.cB010" ) 
									AND NOT SqlFetchNext( hSql(), nFetchRes )
								Call SalMessageBox( 'Введите правильный код банка!', 'Ошибка', MB_IconStop )
								Set cB010 = STRING_Null
								Set cBIC  = STRING_Null
								Set cBANK = STRING_Null
								Return VALIDATE_Cancel
			Column: cBANK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Банк
						бенефициара
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 50
				Data Type: String
				Justify: Left
				Width:  2.05"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cBIC
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: BIC-код
						банка
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 11
				Data Type: String
				Justify: Left
				Width:  1.533"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
						If cBIC = STRING_Null
							Return VALIDATE_Ok
						Else
							If SqlPrepareAndExecute( hSql(), 
									  "SELECT bic INTO :sTmp
									     FROM sw_banks
									    WHERE bic = :RNK_ALIEN.cBIC" ) 
									AND NOT SqlFetchNext( hSql(), nFetchRes )
								Call SalMessageBox( 'Введите правильный BIC-код банка!', 'Ошибка', MB_IconStop )
								Set cBIC = STRING_Null
								Return VALIDATE_Cancel
			Column: cACC
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Счет
						бенефициара
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 50
				Data Type: String
				Justify: Left
				Width:  1.383"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: cADR
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Адрес
						бенефициара
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 50
				Data Type: String
				Justify: Left
				Width:  1.867"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
			! Рег.№ клиента
			Number: pRNK
			! 0 - просмотр, 1 - выбор 
			Number: pMODE
		Window Variables
			Number: nFetchRes
			String: sTmp
			Number: nTmp
			String: sNMK
		Message Actions
			On SAM_Create
				Call SalCenterWindow( hWndForm )
				!
				If SqlPrepareAndExecute( hSql(), 
						  "SELECT nmk INTO :RNK_ALIEN.sNMK 
						     FROM customer 
						    WHERE rnk=:RNK_ALIEN.pRNK" ) 
						AND SqlFetchNext( hSql(), nFetchRes )
					Call SalSetWindowText( RNK_ALIEN, 'Справочник контрагентов для '||sNMK)
				!
				Set RNK_ALIEN.strFilterTblName = "CONTRACTS_ALIEN"
				Set RNK_ALIEN.strPrintFileName = "RNK_ALIEN"
				If pMODE = 0 
					Call SalDisableWindow( pbChoose )
				Else
					Call SalEnableWindow( pbChoose )
				!
				Set RNK_ALIEN.strSqlPopulate =
						   "SELECT contracts_alien.benefrnk,     
						           contracts_alien.benefname, 
						           contracts_alien.benefcountry, 
						           country.name,
						           contracts_alien.benefadr, 
						           contracts_alien.bank_code,
						           contracts_alien.benefbank,
						           contracts_alien.benefbic, 
						           contracts_alien.benefacc,
						           decode(nvl(contracts_alien.rnk,0),0,1,0) 
						      INTO :RNK_ALIEN.cRNK,:RNK_ALIEN.cNMK,
						           :RNK_ALIEN.cCOUNTRY,:RNK_ALIEN.cNAME,
						           :RNK_ALIEN.cADR,:RNK_ALIEN.cB010,:RNK_ALIEN.cBANK,
						           :RNK_ALIEN.cBIC,:RNK_ALIEN.cACC,:RNK_ALIEN.cGLOBAL
						      FROM contracts_alien, country
						     WHERE contracts_alien.benefcountry = country.country (+)
						       AND (contracts_alien.rnk = :RNK_ALIEN.pRNK
						            OR
						            contracts_alien.rnk IS NULL) 
						     ORDER BY contracts_alien.benefname"
				!
				Set RNK_ALIEN.strSqlInsert = 
						   "INSERT INTO contracts_alien 
						      (rnk,benefrnk,benefname,benefcountry,
						       benefadr,bank_code,benefbank,benefbic,benefacc)
						    VALUES 
						      (:RNK_ALIEN.pRNK,0,:RNK_ALIEN.cNMK,:RNK_ALIEN.cCOUNTRY,
						       :RNK_ALIEN.cADR,:RNK_ALIEN.cB010,:RNK_ALIEN.cBANK,
						       :RNK_ALIEN.cBIC,:RNK_ALIEN.cACC)"
				!
				Set RNK_ALIEN.strSqlDelete = 
						   "DELETE FROM contracts_alien 
						     WHERE      rnk = :RNK_ALIEN.pRNK 
						       AND benefrnk = :RNK_ALIEN.cRNK"
				!
				Call SalSendClassMessage( SAM_Create, 0, 0 )
			On SAM_FetchRowDone
				If RNK_ALIEN.cGLOBAL = 1
					Call XSalTblSetRowBackColor( RNK_ALIEN, lParam, COLOR_LightAqua )
			On UM_Update
				Set RNK_ALIEN.strSqlUpdate = 
						   "UPDATE contracts_alien SET
						          benefname = :RNK_ALIEN.cNMK, 
						       benefcountry = :RNK_ALIEN.cCOUNTRY,
						           benefadr = :RNK_ALIEN.cADR,
						          bank_code = :RNK_ALIEN.cB010,
						          benefbank = :RNK_ALIEN.cBANK,
						           benefbic = :RNK_ALIEN.cBIC,
						           benefacc = :RNK_ALIEN.cACC, " ||
						    IifS(RNK_ALIEN.cGLOBAL = 1, 
						         " rnk = TO_NUMBER(NULL) ", 
						         " rnk = :RNK_ALIEN.pRNK " )||
						 "   WHERE benefrnk = :RNK_ALIEN.cRNK"
				Call SalSendClassMessage( UM_Update, 0, 0 )
	Table Window: REPORTS
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Выбор печатных форм
		Icon File:
		Accesories Enabled? Yes
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
				Width:  8.317"
				Width Editable? Class Default
				Height: 4.393"
				Height Editable? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: None
			Text Color: Class Default
			Background Color: Class Default
			View: Class Default
			Allow Row Sizing? Class Default
			Lines Per Row: Class Default
		Memory Settings
			Maximum Rows in Memory: 30000
			Discardable? Class Default
		Description: Выбор печатных форм
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
						Left:   0.917"
						Top:    0.048"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Yes
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\LOOK.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Просмотр'
						On SAM_Click
							If PARAMS > 0
								Set bAskParams = TRUE
							Else
								Set bAskParams = FALSE
							If IDK != NUMBER_Null
								Set sContractName=SalStrTrimX(SalStrMidX(Str(REPORTS.IDK),0,4))
								Set sBindVars=":Param0='" ||Str(IDK)|| "'"
							Else
								Set sContractName='0000'
								Set sBindVars=""
							! Формула имени файла
							If NAMEF != STRING_Null
								Set sFileName=SalStrTrimX(NAMEF)
								If SalStrLeftX( sFileName, 1 ) = '=' AND NOT KODR
									Set sFileName =SalStrMidX(sFileName,2,4)
								Else
									Set sFileName=IifS( PAR=0, 'IMP_','EXP_' )
							Else
								Set sFileName=IifS( PAR=0, 'IMP_','EXP_' )
							Set sFileName = GetPrnDir() || '\\' ||sFileName||sContractName|| '.TXT'
							If KODZ
								Call ExportCatQuery( KODZ, sFileName, 3, sBindVars, bAskParams )
								Call DirectView( sFileName )
							Else
								Call SalMessageBox('Не указан код каталог.запроса для формирования отчета!','Внимание',MB_IconStop )
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.35"
						Top:    0.048"
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
						On SAM_Create
							Set strTip = 'Печать'
						On SAM_Click
							If PARAMS > 0
								Set bAskParams = TRUE
							Else
								Set bAskParams = FALSE
							If IDK != NUMBER_Null
								Set sContractName=SalStrTrimX(SalStrMidX(Str(REPORTS.IDK),0,4))
								Set sBindVars=":Param0='" ||Str(IDK)|| "'"
							Else
								Set sContractName='0000'
								Set sBindVars=""
							! Формула имени файла
							If NAMEF != STRING_Null
								Set sFileName=SalStrTrimX(NAMEF)
								If SalStrLeftX( sFileName, 1 ) = '=' AND NOT KODR
									Set sFileName =SalStrMidX(sFileName,2,4)
								Else
									Set sFileName=IifS( PAR=0, 'IMP_','EXP_' )
							Else
								Set sFileName=IifS( PAR=0, 'IMP_','EXP_' )
							Set sFileName = GetPrnDir() || '\\' ||sFileName||sContractName|| '.TXT'
							If KODZ
								Call ExportCatQuery( KODZ, sFileName, 3, sBindVars, bAskParams )
								Call DosDirectPrint(sFileName )
							Else
								Call SalMessageBox('Не указан код каталог.запроса для формирования отчета!','Внимание',MB_IconStop )
				Line
					Resource Id: 151
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
				Line
					Resource Id: 152
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
				Line
					Resource Id: 153
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  1.883"
						Begin Y:  Class Default
						End X:  1.883"
						End Y:  Class Default
					Visible? Yes
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
						Left:   0.05"
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
				Pushbutton: pbFilter
					Class Child Ref Key: 44
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.483"
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
				Pushbutton: pbExit
					Class Child Ref Key: 42
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.05"
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
		Contents
			Column: KODZ
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
			Column: NAME
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Наименование
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  5.6"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: TYPE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Тип
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  0.867"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: NAMEF
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Имя файла
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.15"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: KODR
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
				Justify: Right
				Width:  0.85"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: PARAMS
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
		Functions
		Window Parameters
			! 0- Экспорт 1 -Импорт
			Number: PAR
			! Код контракта (0 - все)
			Number: IDK
		Window Variables
			String: sBindVars
			String: sContractName
			String: sFileName
			Boolean: bAskParams
		Message Actions
			On SAM_Create
				Call SalCenterWindow( hWndForm )
				Set REPORTS.strFilterTblName="ZAPROS"
				Set REPORTS.strSqlPopulate=
						    " SELECT zapros.kodz, zapros.name, substr(zapros.namef,3,4), 
						             zapros.namef, zapros.kodr, nvl(instr(zapros.bindvars,'dat'),0) 
						      FROM zapros
						      WHERE name like "||IifS(REPORTS.PAR=0," 'EXP%' ", " 'IMP%' ")||
						    " ORDER BY zapros.kodz"  
				Call SalSendClassMessage( SAM_Create, 0, 0 )
			On SAM_Destroy
				Set hWndPrint = hWndNULL
				Call SalSendClassMessage( SAM_Destroy, 0, 0 )
	Form Window: SOST_EXP
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
		Title: Текущее состояние контракта
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
				Width:  12.133"
				Width Editable? Class Default
				Height: 6.393"
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
				Size: 0.476"
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
						Left:   0.033"
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
							Set strTip = 'Добавить новую запись'
						On SAM_Click
							Call SalSendMsg( hWndLost, UM_Insert, 0, 0 )
				Pushbutton: pbDel
					Class Child Ref Key: 16
					Class ChildKey: 0
					Class: cGenericTableSpl
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.473"
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
							Set strTip = 'Пометить/Снять пометку на удаление'
						On SAM_Click
							Call SalSendMsg( hWndLost, UM_Delete, 0, 0 )
				Pushbutton: pbRefresh
					Class Child Ref Key: 17
					Class ChildKey: 0
					Class: cGenericTableSpl
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.905"
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
							Call SalTblQueryFocus(hWndForm, nFocusRow, hFocusCol)
							Call SalSendClassMessage(SAM_Click, 0, 0)
				Pushbutton: pbUpdate
					Class Child Ref Key: 18
					Class ChildKey: 0
					Class: cGenericTableSpl
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.33"
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
							Set strTip = 'Внести изменения в Базу Данных'
						On SAM_Click
							Call SalSendMsg(hWndForm, UM_Update, 0, 0)
				Line
					Resource Id: 52437
					Class Child Ref Key: 19
					Class ChildKey: 0
					Class: cGenericTableSpl
					Coordinates
						Begin X:  1.883"
						Begin Y:  Class Default
						End X:  1.883"
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbFind_PL
					Class Child Ref Key: 20
					Class ChildKey: 0
					Class: cGenericTableSpl
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.42"
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
							Set strTip = 'Найти платеж'
						On SAM_Click
							Call SalTblDefineSplitWindow(tblT, 0, FALSE)
							Call SalSendMsg(tblP, UM_Populate, 0, 0)
							Call SalSendMsg( tblP, UM_Search, 0, 0 )
				Pushbutton: pbFilt_TD
					Class Child Ref Key: 21
					Class ChildKey: 0
					Class: cGenericTableSpl
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.99"
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
							Set strTip = 'Установить фильтр по ТД'
						On SAM_Click
							Call SalSendMsg(tblT, UM_Filter, 0, 0)
				Pushbutton: pbDetails
					Class Child Ref Key: 31
					Class ChildKey: 0
					Class: cGenericTableSpl
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.855"
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
					Picture File Name: \BARS98\RESOURCE\BMP\VIEW.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Карточка контракта'
						On SAM_Click
							Call SalCreateWindow(EID, hWndMDI, hWndForm.SOST_EXP.IDK, IifN(MODE=9,9,1), 0, hWndForm )
				Pushbutton: pbPrint
					Class Child Ref Key: 22
					Class ChildKey: 0
					Class: cGenericTableSpl
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.15"
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
							Set strTip = 'Печать Карточки контракта'
						On SAM_Click
							If hWndPrint
								Call SalBringWindowToTop( hWndPrint )
							Else
								Set hWndPrint=SalCreateWindow(REPORTS, hWndMDI, 0, IDK)
				Line
					Resource Id: 52438
					Class Child Ref Key: 23
					Class ChildKey: 0
					Class: cGenericTableSpl
					Coordinates
						Begin X:  4.683"
						Begin Y:  0.405"
						End X:  4.683"
						End Y:  -0.012"
					Visible? No
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
						Left:   5.217"
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
					Resource Id: 52439
					Class Child Ref Key: 26
					Class ChildKey: 0
					Class: cGenericTableSpl
					Coordinates
						Begin X:  5.083"
						Begin Y:  0.405"
						End X:  5.083"
						End Y:  -0.012"
					Visible? Yes
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				! !
				Pushbutton: pbReestr
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbRelation
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.583"
						Top:    0.073"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\BROWSE.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Ввести № и дату реестра ТД'
						On SAM_Click
							Call F_Reestr()
							Call SalSendMsg( SOST_EXP.tblT, UM_Populate, 0, 0 )
				Pushbutton: pbAvansPL
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbHelp
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.717"
						Top:    0.065"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \BARS98\RESOURCE\BMP\CURRCONV.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Просмотр авансовых платежей'
						On SAM_Click
							If hWndAvansP
								Call SalDestroyWindow( hWndAvansP )
							Set hWndAvansP = SalCreateWindow( AvansRef, hWndMDI, 0, IifN(MODE=9,9,2), IDK, RNK, KVK, nSum2PayPL*100, hWndForm)
				Pushbutton: pbDocView
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbHelp
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.283"
						Top:    0.065"
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
							Set strTip = 'Просмотр документа'
						On SAM_Click
							If SOST_EXP.tblP.REF >0 
								Call DocViewContentsEx(hWndMDI, SOST_EXP.tblP.REF)
				! !
				Background Text: Сумма контр.
					Resource Id: 52426
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   5.8"
						Top:    0.05"
						Width:  1.5"
						Width Editable? Yes
						Height: 0.167"
						Height Editable? Yes
					Visible? Yes
					Justify: Center
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Bold
					Text Color: Dark Red
					Background Color: Default
				Data Field: dfSum_K
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
							Left:   5.783"
							Top:    0.2"
							Width:  1.5"
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
						Text Color: Dark Red
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
						On SAM_TooltipSetText
							Return XSalTooltipSetText( lParam, 'Сумма контракта' )
				Background Text: Сумма ТД
					Resource Id: 38691
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   7.283"
						Top:    0.05"
						Width:  1.5"
						Width Editable? Yes
						Height: 0.167"
						Height Editable? Yes
					Visible? Yes
					Justify: Center
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Bold
					Text Color: Purple
					Background Color: Default
				Data Field: dfSUM_TD
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
							Left:   7.283"
							Top:    0.2"
							Width:  1.5"
							Width Editable? Yes
							Height: 0.25"
							Height Editable? Yes
						Visible? Yes
						Border? Yes
						Justify: Right
						Format: ###000
						Country: Default
						Font Name: MS Sans Serif
						Font Size: 8
						Font Enhancement: Default
						Text Color: Purple
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
						On SAM_TooltipSetText
							Return XSalTooltipSetText( lParam, 'Общая сумма тамож.деклараций/актов по контракту' )
				Background Text: Сумма ПЛ
					Resource Id: 38690
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   8.783"
						Top:    0.05"
						Width:  1.5"
						Width Editable? Yes
						Height: 0.167"
						Height Editable? Yes
					Visible? Yes
					Justify: Center
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Bold
					Text Color: Midnight Blue
					Background Color: Default
				Data Field: dfSUM_PL
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
							Left:   8.783"
							Top:    0.2"
							Width:  1.5"
							Width Editable? Yes
							Height: 0.25"
							Height Editable? Yes
						Visible? Yes
						Border? Yes
						Justify: Right
						Format: ###000
						Country: Default
						Font Name: MS Sans Serif
						Font Size: 8
						Font Enhancement: Default
						Text Color: Midnight Blue
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
						On SAM_TooltipSetText
							Return XSalTooltipSetText( lParam, 'Общая сумма платежей по контракту' )
				Background Text: Аванс.ПЛ
					Resource Id: 52428
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   10.283"
						Top:    0.05"
						Width:  1.5"
						Width Editable? Yes
						Height: 0.167"
						Height Editable? Yes
					Visible? Yes
					Justify: Center
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Bold
					Text Color: Teal
					Background Color: Default
				Data Field: dfAvans_PL
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
							Left:   10.283"
							Top:    0.2"
							Width:  1.5"
							Width Editable? Yes
							Height: 0.25"
							Height Editable? Yes
						Visible? Yes
						Border? Yes
						Justify: Right
						Format: Decimal
						Country: Default
						Font Name: MS Sans Serif
						Font Size: 8
						Font Enhancement: Default
						Text Color: Teal
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
						On SAM_TooltipSetText
							Return XSalTooltipSetText( lParam, 'Сумма авансовых платежей' )
				Background Text: Долг по ТД
					Resource Id: 38689
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   11.783"
						Top:    0.05"
						Width:  1.5"
						Width Editable? Yes
						Height: 0.167"
						Height Editable? Yes
					Visible? Yes
					Justify: Center
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Bold
					Text Color: Red
					Background Color: Default
				Data Field: dfSum2Pay
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
							Left:   11.783"
							Top:    0.2"
							Width:  1.5"
							Width Editable? Yes
							Height: 0.25"
							Height Editable? Yes
						Visible? Yes
						Border? Yes
						Justify: Right
						Format: ###000
						Country: Default
						Font Name: Default
						Font Size: Default
						Font Enhancement: Default
						Text Color: Red
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
						On SAM_TooltipSetText
							Return XSalTooltipSetText( lParam, 'Долг ТД по контракту' )
				Background Text: Долг по ПЛ
					Resource Id: 34214
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   13.283"
						Top:    0.05"
						Width:  1.5"
						Width Editable? Yes
						Height: 0.167"
						Height Editable? Yes
					Visible? Yes
					Justify: Center
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Bold
					Text Color: Blue
					Background Color: Default
				Data Field: dfSum2PayPL
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
							Left:   13.283"
							Top:    0.2"
							Width:  1.5"
							Width Editable? Yes
							Height: 0.25"
							Height Editable? Yes
						Visible? Yes
						Border? Yes
						Justify: Right
						Format: ###000
						Country: Default
						Font Name: Default
						Font Size: Default
						Font Enhancement: Default
						Text Color: Blue
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
						On SAM_TooltipSetText
							Return XSalTooltipSetText( lParam, 'Долг ПЛ по контракту' )
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
						Top:    3.417"
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
			Child Table: tblT
				Class Child Ref Key: 28
				Class ChildKey: 0
				Class: cGenericTableSpl
				Property Template:
				Class DLL Name:
				Display Settings
					Window Location and Size
						Left:   0.0"
						Top:    -0.012"
						Width:  14.383"
						Width Editable? Class Default
						Height: 3.429"
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
					Maximum Rows in Memory: 30000
					Discardable? Class Default
				Contents
					Column: IDT
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Код
								ТД / 
								АКТа
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.067"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: ID
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
					Column: NAME
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Таможенный
								Документ / 
								АКТ
						Visible? Yes
						Editable? Yes
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  2.45"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: DATEDOC
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Дата
								ТД / 
								АКТа
						Visible? Yes
						Editable? Yes
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
							On SAM_Validate
								Call F_KURS_TD(SOST_EXP.tblT.DATEDOC, SOST_EXP.KVK, SOST_EXP.tblT.KV)
								If KURS_T!=0 AND KURS_T!=NUMBER_Null AND S!=NUMBER_Null
									Set SOST_EXP.tblT.SK=SOST_EXP.tblT.S/SOST_EXP.tblT.KURS_T
									Set SOST_EXP.tblT.SKs = Dig4( SOST_EXP.tblT.SK, SOST_EXP.tblT.DIG, SOST_EXP.tblT.DIG )
					Column: S
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма 
								ТД
								в нац.вал.
						Visible? Yes
						Editable? Yes
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.5"
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
								Set S100=S*100
								If KURS_T!=0 AND KURS_T!=NUMBER_Null AND S!=NUMBER_Null
									Set SOST_EXP.tblT.SK=SOST_EXP.tblT.S/SOST_EXP.tblT.KURS_T
									Set SOST_EXP.tblT.SKs = Dig4( SOST_EXP.tblT.SK, SOST_EXP.tblT.DIG, SOST_EXP.tblT.DIG )
									Set nRow=TBL_MinRow
									Set nTmp=0
									While SalTblFindNextRow( SOST_EXP.tblT, nRow, 0, ROW_MarkDeleted)
										Call SalTblSetContext( SOST_EXP.tblT, nRow )
										Set nTmp=nTmp+SOST_EXP.tblT.SK
									If nTmp>SUMK/100
										Call SalMessageBox( 'Сумма введенных ТД превышает остаток проплат по контратку!', 'Ошибка!', MB_IconStop )
										Return VALIDATE_Cancel
								Return VALIDATE_Ok
					Column: ISO
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Код
								вал
						Visible? Yes
						Editable? Yes
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
								If SalIsNull ( ISO ) 
									Set KV=0
									Return VALIDATE_Ok
								If SalIsValidInteger( ISO )
									Set sTmp='kv'
								Else
									Set sTmp='lcv'
									Set ISO=SalStrUpperX( ISO )
								Call SqlPrepareAndExecute( hSql(), 
										    "SELECT kv, lcv, dig 
										     INTO :SOST_EXP.tblT.KV, :SOST_EXP.tblT.ISO, :SOST_EXP.tblT.DIG 
										     FROM tabval WHERE "||sTmp||"=:ISO" )
								If not SqlFetchNext( hSql(), nFetchRes )
									Return VALIDATE_Cancel
								Call F_KURS_TD(SOST_EXP.tblT.DATEDOC, SOST_EXP.KVK, SOST_EXP.tblT.KV)
								If NOT SalIsNull(S) AND NOT SalIsNull(KURS_T) AND KURS_T!=0
									If SalIsNull( DIG )
										Set DIG=2
									Set SK=S/KURS_T
									Set SKs = Dig4( SK, DIG, DIG )
								Return VALIDATE_Ok
					Column: KV
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Код
								вал
								
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
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
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: DIG
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Код
								вал
								
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
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
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: KURS_T
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: 
								Курс
						Visible? Yes
						Editable? Yes
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
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
							On SAM_Validate
								If KURS_T!=0 AND KURS_T!=NUMBER_Null AND S!=NUMBER_Null
									Set SOST_EXP.tblT.SK=SOST_EXP.tblT.S/SOST_EXP.tblT.KURS_T
									Set SOST_EXP.tblT.SKs = Dig4( SOST_EXP.tblT.SK, SOST_EXP.tblT.DIG, SOST_EXP.tblT.DIG )
									Set nRow=TBL_MinRow
									Set nTmp=0
									While SalTblFindNextRow( SOST_EXP.tblT, nRow, ROW_New, ROW_MarkDeleted)
										Call SalTblSetContext( SOST_EXP.tblT, nRow )
										Set nTmp=nTmp+SOST_EXP.tblT.SK
									If nTmp>dfSum2Pay
										Call SalMessageBox( 'Сумма введенной ТД превышает остаток проплат по контратку!', 'Ошибка!', MB_IconStop )
										Return VALIDATE_Cancel
					Column: SKs
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма 
								ТД/АКТА
								в вал.контракта
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Right
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
					Column: REESTR
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: 
								№ реестра
						Visible? Yes
						Editable? Yes
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  2.02"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: DATR
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Дата
								реестра
						Visible? Yes
						Editable? Yes
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
					Column: SK
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма ТД
								в валюте
								контракта
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.667"
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
					Column: S100
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма
								из ТД
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.329"
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
					Column: Sum_PL
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Общая
								сумма ПЛ
								по ТД
						Visible? No
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
					Column: Sum_PLs
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Общая
								сумма ПЛ
								по ТД/АКТу
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
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
					Column: Debt_PL
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Долг
								по ТД
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.083"
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
					Column: Debt_PLs
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Долг
								по 
								ТД/АКТу
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Right
						Width:  1.083"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: Sum90_PL
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма
								ПЛ
								< 91 дня
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.117"
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
					Column: Sum90_PLs
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма
								ПЛ   ДО
								контр.дня
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
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
					Column: Sum91_PL
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма 
								ПЛ
								> 91 дня
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.133"
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
					Column: Sum91_PLs
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма
								ПЛ   ПОСЛЕ
								контр.дня
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
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
					Column: DAT91
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Контр.день 
								(1-ый день 
								нарушения)
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
					Column: REST
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Кол-во
								дней
								просрочки
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.067"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
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
					Function: F_KURS_TD
						Description: Вычисление курса ТД (кросс-курса или относит.ГРН)
						Returns
						Parameters
							Date/Time: dDAT
							Number: nKVK
							Number: nKVT
						Static Variables
						Local variables
							Number: nKurs
						Actions
							If dDAT != DATETIME_Null AND nKVK != NUMBER_Null AND nKVT != NUMBER_Null
								If nKVK = nKVT
									If AKT = 0
										If SqlPrepareAndExecute( hSqlAux2(),
												   "SELECT rate_o/bsum INTO :SOST_EXP.tblT.KURS_T
												    FROM cur_rates
												    WHERE kv=:nKVT AND VDATE =
												         (SELECT max(VDATE) FROM cur_rates
												          WHERE kv=:nKVT and vdate <=:dDAT)")
											Call SqlFetchNext( hSqlAux2(), nFetchRes )
									Else
										Set SOST_EXP.tblT.KURS_T = 1
								Else
									If GetXRate( nKurs, nKurs, nKurs, nKVK, nKVT, dDAT )
										Set SOST_EXP.tblT.KURS_T = SalStrToNumber(SalNumberToStrX(nKurs,8))
				Window Variables
					String: strSqlPopulate	! Строка SQL SELECT
					String: strSqlInsert	! Строка SQL INSERT
					String: strSqlInsert0	! Строка SQL INSERT
					String: strSqlDelete	! Строка SQL DELETE
					String: strSqlUpdate	! Строка SQL UPDATE
					String: strSqlUpdate1	! Строка SQL UPDATE
					!
					Number: nS_TD
					String: sISO
					Number: nDELTA
					Number: nID_Null
					String: sTmp
					!
					Number: bRes
					!
					: cQry
						Class: cGenQuery
					: cFlt
						Class: cGenFilter
					Number: nRowF
					Window Handle: hColF
					Number: nIDTF
					Number: nIDT_PARENT
					Number: nTruncSumP
				Message Actions
					On SAM_Create
						Set strSqlInsert0 = "INSERT INTO contracts (id, closed, pid) VALUES (:nID_NEW, 0, :SOST_EXP.IDK)" 
						Set strSqlInsert =
								   "INSERT INTO tamozhdoc
								      (idt, name, datedoc, kv, s, kurs, pid, 
								       registry_num, registry_dat, 
								       id, rnk, id_parent, impexp) 
								    VALUES 
								      (0, 
								       :SOST_EXP.tblT.NAME,
								       :SOST_EXP.tblT.DATEDOC,
								       :SOST_EXP.tblT.KV,
								       :nDELTA,
								       :SOST_EXP.tblT.KURS_T,
								       :SOST_EXP.IDK,
								       :SOST_EXP.tblT.REESTR,
								       :SOST_EXP.tblT.DATR,
								       :nID_Null,
								       :SOST_EXP.RNK,
								       :SOST_EXP.tblT.nIDT_PARENT,
								       0)" 
						Set strSqlUpdate = 
								   "UPDATE tamozhdoc 
								       SET name         = :SOST_EXP.tblT.NAME, 
								           datedoc      = :SOST_EXP.tblT.DATEDOC, 
								           kv           = :SOST_EXP.tblT.KV,
								           s            = :SOST_EXP.tblT.S100,
								           kurs         = :SOST_EXP.tblT.KURS_T,
								           registry_num = :SOST_EXP.tblT.REESTR,
								           registry_dat = :SOST_EXP.tblT.DATR,
								           id           = :nID_NEW,
								           pid          = :SOST_EXP.IDK,
								           rnk          = :SOST_EXP.RNK   
								     WHERE idt          = :SOST_EXP.tblT.IDT" 
						Set strSqlUpdate1 = 
								   "UPDATE tamozhdoc 
								       SET name         = :SOST_EXP.tblT.NAME, 
								           datedoc      = :SOST_EXP.tblT.DATEDOC, 
								           kv           = :SOST_EXP.tblT.KV,
								           s            = :SOST_EXP.tblT.S100,
								           kurs         = :SOST_EXP.tblT.KURS_T,
								           registry_num = :SOST_EXP.tblT.REESTR,
								           registry_dat = :SOST_EXP.tblT.DATR,
								           id           = :SOST_EXP.tblT.ID,
								           pid          = :SOST_EXP.IDK,
								           rnk          = :SOST_EXP.RNK   
								     WHERE idt          = :SOST_EXP.tblT.IDT" 
						Set strSqlDelete =
								   "UPDATE tamozhdoc 
								       SET id  = TO_NUMBER(NULL),
								           pid = TO_NUMBER(NULL) 
								     WHERE idt = :SOST_EXP.tblT.IDT"
						Set SOST_EXP.tblT.strSqlPopulate =
								   "SELECT t.idt, t.id, t.name, t.datedoc, t.dat91, 
								           t.kv, v.lcv, v.dig,
								           t.s/100, t.s, t.kurs, t.s/t.kurs/100,
								           t.registry_num, t.registry_dat, 
								           get_truncsum4contract(t.kv)
								      INTO :SOST_EXP.tblT.IDT, 
								           :SOST_EXP.tblT.ID, 
								           :SOST_EXP.tblT.NAME,
								           :SOST_EXP.tblT.DATEDOC,
								           :SOST_EXP.tblT.DAT91,
								           :SOST_EXP.tblT.KV,
								           :SOST_EXP.tblT.ISO,
								           :SOST_EXP.tblT.DIG,
								           :SOST_EXP.tblT.S,
								           :SOST_EXP.tblT.S100,
								           :SOST_EXP.tblT.KURS_T,
								           :SOST_EXP.tblT.SK,
								           :SOST_EXP.tblT.REESTR,
								           :SOST_EXP.tblT.DATR,
								           :nTruncSumP
								      FROM tamozhdoc t, contracts c, tabval v
								     WHERE t.id  = c.id 
								       AND t.kv  = v.kv 
								       AND c.pid = "||Str(IDK)||"  
								     ORDER BY t.datedoc, t.idt"    
						!
						Call cFlt.Init( 'tamozhdoc', 't' )
						Call cQry.Init( SOST_EXP.tblT.strSqlPopulate )
						Call SalSendClassMessage( SAM_Create, 0, 0 )
					On SAM_CreateComplete
						Call SalSendMsg( SOST_EXP.tblT, UM_Populate, 0, 0 )
					On SAM_FetchRowDone
						Set SKs = Dig4( SK, SOST_EXP.tblT.DIG, SOST_EXP.tblT.DIG )
						! Общая сумма платежей, сумма нарушителей и не очень
						If SqlPrepareAndExecute( hSqlAux2(), 
								   "SELECT nvl(sum(round((p.s+nvl(p.komiss,0))*p.kurs)),0),
								           nvl(sum(iif_d(p.fdat,t.dat91,
								                         0,
								                         round((p.s+nvl(p.komiss,0))*p.kurs),
								                         round((p.s+nvl(p.komiss,0))*p.kurs))),0)
								    INTO :SOST_EXP.tblT.Sum_PL, :SOST_EXP.tblT.Sum91_PL
								    FROM contracts c, tamozhdoc t, contract_p p  
								    WHERE t.idt=:SOST_EXP.tblT.IDT AND c.id=t.id AND c.id=p.id(+)" )
							Call SqlFetchNext( hSqlAux2(), nFetchRes )
							Set SOST_EXP.tblT.Sum90_PL=SOST_EXP.tblT.Sum_PL-SOST_EXP.tblT.Sum91_PL
							Set SOST_EXP.tblT.Debt_PL=
									           IifN(SOST_EXP.tblT.SK*100-SOST_EXP.tblT.Sum_PL<=0,0,SOST_EXP.tblT.SK*100-SOST_EXP.tblT.Sum_PL  )
							Set Sum_PLs   = Dig4( Sum_PL/100,   nDig, nDig )
							Set Sum90_PLs = Dig4( Sum90_PL/100, nDig, nDig )
							Set Sum91_PLs = Dig4( Sum91_PL/100, nDig, nDig )
							Set Debt_PLs  = Dig4( Debt_PL/100,  nDig, nDig )
						! Сумма долга по ТД
						If SalNumberRound(SOST_EXP.tblT.Debt_PL) > nTruncSumP
							Call SalTblSetCellTextColor( SOST_EXP.tblT.Debt_PLs, COLOR_Red, FALSE )
							! Кол-во дней просрочки
							Set SOST_EXP.tblT.REST=IifN(dDATA-SOST_EXP.tblT.DAT91+1>0,dDATA-SOST_EXP.tblT.DAT91+1,NUMBER_Null)
							If SOST_EXP.tblT.REST>0
								Call SalTblSetCellTextColor( SOST_EXP.tblT.REST, COLOR_Red, FALSE )
					On UM_Populate
						Call SalWaitCursor(TRUE)
						Call SalTblDefineSplitWindow(hWndForm, 0, FALSE)
						!
						Call SalTblQueryFocus( SOST_EXP.tblT, nRowF, hColF )
						Set nIDTF = SOST_EXP.tblT.IDT
						!
						Call SalTblQueryFocus(hWndForm, nFocusRow, hFocusCol)
						! Параметры контракта
						If SqlPrepareAndExecute(hSqlAux2(), 
								   "SELECT rnk, name, dateopen, dateclose, s, kv, control_days, 
								           decode(nvl(id_oper,1), 2, 1, 0)
								    INTO :RNK, :NAMEK, :DAT1K, :DAT2K, :SUMK, :KVK, :DAYS, :AKT
								    FROM top_contracts 
								    WHERE pid=:IDK") 
							Call SqlFetchNext( hSqlAux2(), nFetchRes )
						Call SqlPrepareAndExecute( hSql(), 
								     "SELECT dig, lcv INTO :nDig, :sISO FROM tabval WHERE kv = :KVK")
						If not SqlFetchNext( hSql(), nFetchRes )
							Set nDig=2
						Call SalSetWindowText( SOST_EXP, 'ЭКСПОРТ. Текущее состояние контракта № '|| NAMEK||' от '||SalFmtFormatDateTime( DAT1K, 'dd/MM/yyyy' ))
						Set dfSum_K=Dig4( SUMK/100, nDig, nDig )
						!
						Call SalTblPopulate(SOST_EXP.tblT, hSql(), T(SOST_EXP.tblT.strSqlPopulate),TBL_FillAll)
						! АКТ или ТД?
						If AKT = 1
							Call SalHideWindow( SOST_EXP.tblT.REESTR )
							Call SalHideWindow( SOST_EXP.tblT.DATR )
						Else
							Call SalShowWindow( SOST_EXP.tblT.REESTR )
							Call SalShowWindow( SOST_EXP.tblT.DATR )
						Call TITLE_TD (AKT)
						!
						If nIDTF
							Set nRowF = TBL_MinRow
							Loop
								If SalTblFindNextRow( SOST_EXP.tblT, nRowF, 0, 0 )
									Call SalTblSetContext( SOST_EXP.tblT, nRowF )
									If SOST_EXP.tblT.IDT = nIDTF
										Call SalTblSetFocusRow( SOST_EXP.tblT, nRowF )
										Call SalTblSetContext( SOST_EXP.tblT, nFocusRow )
										Call SalTblSetRowFlags( SOST_EXP.tblT, nFocusRow, ROW_Selected, TRUE )
										Break
								Else
									Call SalTblSetFocusRow( SOST_EXP.tblT, nRowF )
									Break
						! Общая сумма ТД по контракту
						Call SqlPrepareAndExecute(hSqlAux2(), 
								    "SELECT nvl(sum(round(t.s/t.kurs))/100,0) 
								       INTO :dfSUM_TD
								      FROM top_contracts tc, tamozhdoc t
								     WHERE tc.pid = t.pid AND tc.pid = :IDK")
						If NOT SqlFetchNext(hSqlAux2(), nFetchRes)
							Set dfSUM_TD=0
						Set SOST_EXP.dfSum2Pay=SOST_EXP.SUMK/100-dfSUM_TD
						! Общая сумма ТД по контракту с ID is not null (т.е. привязанные к К ТД, но без ID)
						Call SqlPrepareAndExecute(hSqlAux2(),
								     "SELECT nvl(sum(round(t.s/t.kurs))/100,0) INTO :dfSUM_TD_ID
								      FROM top_contracts tc, tamozhdoc t
								      WHERE tc.pid=t.pid AND tc.pid=:IDK AND t.id is not null")
						Call SqlFetchNext(hSqlAux2(), nFetchRes)
						! Общая сумма ПЛ по контракту
						Call SqlPrepareAndExecute(hSqlAux2(), 
								     "SELECT nvl(sum(round((p.s+nvl(p.komiss,0))*nvl(p.kurs,1))),0)/100 
								        INTO :dfSUM_PL   
								        FROM top_contracts tc, contracts c, contract_p p  
								       WHERE tc.pid = c.pid AND c.id = p.id(+) AND tc.pid = :IDK")
						If NOT SqlFetchNext(hSqlAux2(), nFetchRes)
							Set dfSUM_PL=0
						! Долг по платежам - незакрытая платежами сумма ТД
						Set SOST_EXP.nSum2PayPL=SOST_EXP.SUMK/100-dfSUM_PL-dfAvans_PL
						Set SOST_EXP.dfSum2PayPL=dfSUM_TD-dfSUM_PL-dfAvans_PL
						Call SalSendMsg(hWndForm, SAM_TblDoDetails, 0, 0)
						Call SalWaitCursor(FALSE)
					On SAM_TblDoDetails
						Set nID=SOST_EXP.tblT.ID
						! Set dDATX = SOST_EXP.tblT.DATEDOC
						Set dDATX = SOST_EXP.tblT.DAT91
						Call SalSendMsg(tblP, UM_Populate, 0, 0)
					On SAM_SetFocus
						If SalTblQueryRowFlags ( hWndForm, lParam, ROW_New )
							Set nID= SOST_EXP.tblT.ID
							! Set dDATX = SOST_EXP.tblT.DATEDOC
							Set dDATX = SOST_EXP.tblT.DAT91
					On SAM_KillFocus
						Set hWndLost=hWndForm
					On UM_Update
						Call SalWaitCursor(TRUE)
						Set nTmp = 0
						Set nRow = TBL_MinRow
						If strSqlInsert != ''
							While SalTblFindNextRow ( SOST_EXP.tblT, nRow, ROW_New, 0 )
								Call SalTblSetContext( SOST_EXP.tblT, nRow )
								If SqlPrepareAndExecute( hSql(),"SELECT s_contracts.NEXTVAL INTO :nID_NEW FROM DUAL" )
									Call SqlFetchNext( hSql(), nFetchRes )
								If SqlPrepareAndExecute(hSql(), T(strSqlInsert0))
									! Выбор из базы авансовых ТД
									If SOST_EXP.tblT.IDT !=NUMBER_Null
										Set SOST_EXP.tblT.S100=SOST_EXP.tblT.S*100
										! Call Debug('SOST_EXP.tblT.IDT='||Str(SOST_EXP.tblT.IDT))
										Call SqlPrepareAndExecute(hSql(),"SELECT s INTO :nS_TD FROM tamozhdoc WHERE idt=:SOST_EXP.tblT.IDT")
										If SqlFetchNext( hSql(), nFetchRes )
											Set nDELTA=nS_TD-SOST_EXP.tblT.S100
											! Call Debug('Излишек в ГРН '||Str(nDELTA))
										If SqlPrepareAndExecute(hSql(), T(strSqlUpdate))
											! Call Debug('Привязали ТД ')
											! Проблема нулевого аванса
											! Call Debug('Излишек в ВАЛ '||Str(SalNumberRound(nDELTA/SOST_EXP.tblT.KURS_T)))
											If SalNumberRound(nDELTA/SOST_EXP.tblT.KURS_T)>0
												! Call Debug('На остаток ТД создаем новую ТД и отправляем в аванс! ')
												Set nID_Null=NUMBER_Null
												Set nIDT_PARENT=SOST_EXP.tblT.IDT
												Call SqlPrepareAndExecute(hSql(), T(strSqlInsert))
									! Ввод вручную
									Else
										Set nDELTA=SOST_EXP.tblT.S*100
										Set nID_Null=nID_NEW
										Set nIDT_PARENT=NUMBER_Null
										Call SqlPrepareAndExecute(hSql(), T(strSqlInsert))
						Set nRow = TBL_MinRow
						While SalTblFindNextRow ( SOST_EXP.tblT, nRow, ROW_MarkDeleted, 0 )
							Call SalTblSetContext( SOST_EXP.tblT, nRow )
							If strSqlDelete != ''
								Call SqlPrepareAndExecute( hSqlAux2(),
										  " UPDATE contract_p SET kurs=TO_NUMBER(NULL), komiss=TO_NUMBER(NULL), id=TO_NUMBER(NULL), pid=TO_NUMBER(NULL)
										    WHERE id=:nID " )
								Call SqlPrepare(hSql(), T(strSqlDelete))
								Call SalTblDoDeletes(hWndForm, hSql(), ROW_MarkDeleted)
						Set nRow = TBL_MinRow
						While SalTblFindNextRow ( SOST_EXP.tblT, nRow, ROW_Edited, 0 )
							Call SalTblSetContext( SOST_EXP.tblT, nRow )
							If strSqlUpdate1 != ''
								Call SqlPrepare(hSql(), T(strSqlUpdate1))
								Call SalTblDoUpdates(hWndForm, hSql(), TRUE)
						Call SqlCommit(cMain.hSql())
						Call SalTblDefineSplitWindow(hWndForm, 0, FALSE)
						Call SalPostMsg(SOST_EXP, UM_Populate, 0, 0)
						Call SalWaitCursor(FALSE)
					On UM_Insert
						Set nRow=TBL_MinRow
						Set nTmp=0
						Set bRes=IDYES
						While SalTblFindNextRow(SOST_EXP.tblT, nRow, ROW_New, 0)
							Call SalTblSetContext( SOST_EXP.tblT, nRow )
							Set nTmp=nTmp+1
						If nTmp=0
							Set bRes=SalMessageBox( 'Если Вы хотите ввести ТД вручную, нажмите Да(Yes),'||PutCrLf(  )||
									                        'если Вы хотите выбрать ТД из авансовых ТД, нажмите Нет(No),'||PutCrLf(  )||
									                        'если Вы ничего не хотите, нажмите Отменить(Cancel)', 'Внимание', MB_IconQuestion|MB_YesNoCancel )
						If bRes=IDYES
							Call SalSendClassMessage( UM_Insert, 0, 0 )
							If AKT = 1
								Set NAME = 'АКТ '
							Set SOST_EXP.tblT.KV  = SOST_EXP.KVK
							Set SOST_EXP.tblT.ISO = SOST_EXP.tblT.sISO
							Set SOST_EXP.tblT.DIG = SOST_EXP.nDig
						Else If bRes=IDNO
							If hWndAvansT
								Call SalDestroyWindow(hWndAvansT)
							Set hWndAvansT = SalCreateWindow(AvansTD, hWndMDI, 0, 0, RNK, IDK, NAMEK, KVK, NUMBER_Null, 
									SalNumberRound(SOST_EXP.SUMK/100-dfSUM_TD_ID)*100, hWndForm)
						Else
							Call SalSendMsg(SOST_EXP.tblT, UM_Populate, 0, 0)
					On UM_Filter
						If SetQueryFilter( cFlt )
							Set strSqlPopulate = cQry.GetFullSQLString( cFlt )
							Call SalSendMsg( tblT, UM_Populate, 0, 0 )
							Call SelFirstRow( tblT )
							Call SalSendMsg( tblT, SAM_RowSetContext, 0, 0 )
			Child Table: tblP
				Class Child Ref Key: 27
				Class ChildKey: 0
				Class: cGenericTableSpl
				Property Template:
				Class DLL Name:
				Display Settings
					Window Location and Size
						Left:   -0.017"
						Top:    3.488"
						Width:  14.383"
						Width Editable? Class Default
						Height: 1.381"
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
					Maximum Rows in Memory: 30000
					Discardable? Class Default
				Contents
					Column: IDP
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Код
								платежа
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
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
					Column: REF
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Референс
								платежа
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.25"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: ID
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
						Justify: Right
						Width:  1.067"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: FDAT
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Дата
								валютир
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
					Column: S
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма
								Платежа
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.571"
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
					Column: KOMISS
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма
								комиссии
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.571"
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
					Column: Ss
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма
								платежа
								S_PL
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
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
					Column: KOMISSs
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма
								комиссии
								S_KOM
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Right
						Width:  1.083"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
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
								вал
						Visible? No
						Editable? No
						Maximum Data Length: 3
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
					Column: ISO
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Код 
								вал
						Visible? Yes
						Editable? No
						Maximum Data Length: 3
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
					Column: KURS
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Курс
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
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
							On SAM_Validate
								Set SOST_EXP.tblP.SK=(SOST_EXP.tblP.S+SOST_EXP.tblP.KOMISS)*SOST_EXP.tblP.KURS
								Set SOST_EXP.tblP.SKs = Dig4( SOST_EXP.tblP.SK, nDig, nDig )
					Column: SK
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма
								Платежа
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.571"
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
					Column: SKs
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма платежа
								в вал.контр.
								S_PL + S_KOM
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Right
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
					Column: ACC
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Код 
								вал
						Visible? No
						Editable? No
						Maximum Data Length: 3
						Data Type: Number
						Justify: Right
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
					Column: NLS
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Лицевой
								счет
						Visible? Yes
						Editable? No
						Maximum Data Length: 14
						Data Type: String
						Justify: Left
						Width:  2.02"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: OVERD
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Просрочка
								(дней)
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
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
					Column: SOS
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
					Column: NAZN
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Назначение платежа
						Visible? Yes
						Editable? No
						Maximum Data Length: 160
						Data Type: String
						Justify: Left
						Width:  5.843"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: DIG
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
					String: strSqlPopulate	! Строка SQL SELECT
					String: strSqlInsert	! Строка SQL INSERT
					String: strSqlDelete	! Строка SQL DELETE
					String: strSqlUpdate	! Строка SQL UPDATE
					!
					Number: n2Del
					Number: nS100
					Number: nS_REF
					Number: nDELTA
					Number: nIdp2Add
					Number: nPAYD
					Number: nChanged
					Number: nPID_Avans
				Message Actions
					On SAM_Create
						Set strSqlPopulate=
								 "SELECT r.ref,r.id,r.idp,r.fdat,r.kv,nvl(r.s,o.s)/100,r.kurs,
								         r.acc,a.nls,nvl(r.details,o.nazn),o.sos,nvl(r.komiss,0)/100   
								  INTO :SOST_EXP.tblP.REF,:SOST_EXP.tblP.ID,:SOST_EXP.tblP.IDP,
								       :SOST_EXP.tblP.FDAT,:SOST_EXP.tblP.KV,:SOST_EXP.tblP.S,
								       :SOST_EXP.tblP.KURS,:SOST_EXP.tblP.ACC,:SOST_EXP.tblP.NLS,
								       :SOST_EXP.tblP.NAZN,:SOST_EXP.tblP.SOS,:SOST_EXP.tblP.KOMISS
								  FROM contract_p r, oper o, accounts a
								  WHERE r.ref=o.ref(+) AND r.acc=a.acc(+) AND  r.id=:nID        
								  ORDER BY r.fdat, r.idp "
						Set strSqlInsert=
								    "INSERT INTO contract_p (idp,pid,ref,fdat,kv,s,kurs,komiss,rnk,impexp,acc, id_parent) VALUES 
								     (0,:SOST_EXP.tblP.nPID_Avans,:SOST_EXP.tblP.REF,:SOST_EXP.tblP.FDAT,:SOST_EXP.tblP.KV,
								      :SOST_EXP.tblP.nDELTA,:SOST_EXP.tblP.KURS,0,:SOST_EXP.RNK,0,:SOST_EXP.tblP.ACC,:SOST_EXP.tblP.IDP )"
						Set strSqlUpdate="UPDATE contract_p SET 
								                     kurs=:SOST_EXP.tblP.KURS, 
								                     s=:SOST_EXP.tblP.nS100, 
								                     komiss=:SOST_EXP.tblP.KOMISS,                 
								                     pid=:SOST_EXP.IDK,                      
								                     id=:nID 
								                  WHERE idp=:SOST_EXP.tblP.IDP"
						Set strSqlDelete="UPDATE contract_p SET 
								                     komiss=TO_NUMBER(NULL),
								                     id=TO_NUMBER(NULL), 
								                     pid=TO_NUMBER(NULL),      
								                     kurs=TO_NUMBER(NULL)                 
								                  WHERE idp=:SOST_EXP.tblP.IDP"
						If DigInit() != -1
							Set nMaxDig = DigInit()
						Else
							! ?
						Call SalSendClassMessage( SAM_Create, 0, 0 )
					On SAM_FetchRowDone
						Call SqlPrepareAndExecute( hSqlAux2(),
								     "SELECT v.lcv, v.dig  
								      INTO :SOST_EXP.tblP.ISO,:SOST_EXP.tblP.DIG
								      FROM tabval v
								      WHERE v.kv=:SOST_EXP.tblP.KV  " )
						If SqlFetchNext( hSqlAux2(), nFetchRes )
							Set SOST_EXP.tblP.Ss      = Dig4( SOST_EXP.tblP.S, DIG, nMaxDig )
							Set SOST_EXP.tblP.KOMISSs = Dig4( SOST_EXP.tblP.KOMISS, DIG, nMaxDig )
							Set SOST_EXP.tblP.SK      = (SOST_EXP.tblP.S+SOST_EXP.tblP.KOMISS)*SOST_EXP.tblP.KURS
							Set SOST_EXP.tblP.SKs     = Dig4( SOST_EXP.tblP.SK, DIG, nMaxDig )
						! Признак документа
						If SOST_EXP.tblP.REF
							If SOST_EXP.tblP.SOS<0
								Call SetTblRowColor( SOST_EXP.tblP, COLOR_Red )
							Else If SOST_EXP.tblP.SOS=1
								Call SetTblRowColor( SOST_EXP.tblP, COLOR_DarkGreen )
							Else If SOST_EXP.tblP.SOS=3
								Call SetTblRowColor( SOST_EXP.tblP, COLOR_Blue )
							Else
								Call SetTblRowColor( SOST_EXP.tblP, COLOR_Black )
						Else
							Call SetTblRowColor( SOST_EXP.tblP, COLOR_Black )
						! Сколько дней просрочки
						! Set OVERD = FDAT - (dDATX + DAYS)
						Set OVERD = FDAT - dDATX + 1
						If OVERD > 0
							Call SalTblSetCellTextColor( SOST_EXP.tblP.OVERD, COLOR_Red, FALSE )
						Else
							Set OVERD=NUMBER_Null
					On UM_Populate
						Call SalWaitCursor(TRUE)
						Call SalTblDefineSplitWindow(hWndForm, 0, FALSE)
						Call SalTblPopulate(hWndForm, hSql(), T(strSqlPopulate),TBL_FillAll)
						If SqlPrepareAndExecute( hSqlAux2(),
								  "SELECT sum((p.s+nvl(p.komiss,0))*NVL(p.kurs,1)/power(10,v.dig))
								   INTO :SOST_EXP.dfAvans_PL 
								   FROM tabval v, contract_p p
								   WHERE v.kv=:SOST_EXP.KVK AND p.id IS NULL AND p.pid=:SOST_EXP.IDK" )
							Call SqlFetchNext( hSqlAux2(), nFetchRes )
						Call SalWaitCursor(FALSE)
					On SAM_CreateComplete
						Call SalSendMsg( hWndForm, UM_Populate, 0, 0 )
					On SAM_KillFocus
						Set hWndLost=hWndItem
					On UM_Insert
						If SalMessageBox( 'Искать документ?', 'Внимание', MB_IconQuestion|MB_YesNo )=IDYES
							If hWndAvansP
								Call SalDestroyWindow( hWndAvansP )
							Set hWndAvansP = SalCreateWindow( AvansRef, hWndMDI, 0, 1, IDK, RNK, KVK, SOST_EXP.tblT.Debt_PL, hWndForm )
					On SAM_DoubleClick
						Call SalSendMsg( SOST_EXP.pbDocView, SAM_Click, 0, 0 )
					On UM_Delete
						Set nRow = TBL_MinRow
						While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
							If NOT SalTblQueryRowFlags(hWndForm, nRow, ROW_New)
								Call SalTblSetRowFlags(hWndForm, nRow, ROW_MarkDeleted,
										     not SalTblQueryRowFlags(hWndForm, nRow, ROW_MarkDeleted))
							Else
								Call SalTblDeleteRow(hWndForm, nRow, TBL_NoAdjust)
					On UM_Update
						Set nTmp = 0
						Set nChanged=0
						Set nRow = TBL_MinRow
						While SalTblFindNextRow ( SOST_EXP.tblP, nRow, ROW_MarkDeleted, 0 )
							Call SalTblSetContext( SOST_EXP.tblP, nRow )
							Set nChanged=1
							If strSqlDelete != ''
								! Есть ли авансовый платеж с таким референсом
								If SqlPrepareAndExecute( hSqlAux2(),
										   "SELECT min(idp) INTO :nIdp2Add FROM contract_p 
										    WHERE pid IS NULL AND id IS NULL AND ref=:SOST_EXP.tblP.REF
										    HAVING min(idp)>0") AND
										NOT SqlFetchNext( hSqlAux2(), nFetchRes )
									! Авансового платежа с таким РЕФ нет => спокойно перемещаем в аванс 
									Call SqlPrepare(hSql(), T(strSqlDelete))
									Call SalTblDoDeletes(hWndForm, hSql(), ROW_MarkDeleted)
								Else
									Set n2Del=SOST_EXP.tblP.S*100
									! Физически удаляем часть платежа 
									If SqlPrepareAndExecute( hSqlAux2(),"DELETE FROM contract_p WHERE idp=:SOST_EXP.tblP.IDP")
									! Увеличиваем сумму авансового платежа 
									If SqlPrepareAndExecute(hSqlAux2(),"UPDATE contract_p SET s=s+:n2Del WHERE idp=:nIdp2Add")
						Set nRow = TBL_MinRow
						While SalTblFindNextRow ( SOST_EXP.tblP, nRow, ROW_New, 0 )
							Call SalTblSetContext( SOST_EXP.tblP, nRow )
							Set nChanged=1
							If strSqlUpdate != ''
								Set nS100=SOST_EXP.tblP.S*100
								Set nDELTA=nPAYD-nS100
								! Call Debug('nDELTA='||Str(nDELTA))
								Call SqlPrepare(hSql(), T(strSqlUpdate))
								If SalTblDoInserts(hWndForm, hSql(), FALSE)
									If nDELTA>0
										! Остаток платежа отправляем в аванс
										If SOST_EXP.tblP.REF=NUMBER_Null
											Set nPID_Avans=SOST_EXP.IDK
										Else
											Set nPID_Avans=NUMBER_Null
										Call SqlPrepare(hSql(), T(strSqlInsert))
										Call SalTblDoInserts(hWndForm, hSql(), TRUE)
						Set nRow = TBL_MinRow
						While SalTblFindNextRow ( SOST_EXP.tblP, nRow, ROW_Edited, 0 )
							Call SalTblSetContext( SOST_EXP.tblP, nRow )
							Set nChanged=1
							If strSqlUpdate != ''
								Set nS100=SOST_EXP.tblP.S*100
								Call SqlPrepare(hSql(), T(strSqlUpdate))
								Call SalTblDoUpdates(hWndForm, hSql(), TRUE)
						Call SqlCommit(hSql())
						If nChanged!=0
							Call SalPostMsg(SOST_EXP, UM_Populate, 0, 0)
					On UM_Search
						Call TblFindString(tblP,  DFIND_First)
		Functions
			Function: F_Reestr
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					String: rNAME
					Date/Time: rDAT
					Number: nTmp
				Actions
					Call SalModalDialog(dlg_REESTR, hWndForm, rNAME, rDAT)
					If rNAME != STRING_Null AND rDAT != DATETIME_Null
						Set nTmp = TBL_MinRow
						Loop
							If SalTblFindNextRow (SOST_EXP.tblT, nTmp, ROW_Selected, 0)
								Call SalTblSetContext(SOST_EXP.tblT, nTmp)
								If nTmp >= 0
									If SqlPrepareAndExecute(hSql(),
											  "UPDATE tamozhdoc 
											      SET registry_num = :rNAME,
											          registry_dat = :rDAT
											    WHERE idt          = :SOST_EXP.tblT.IDT")
										Call SqlCommit( hSql() )
									Else
										Call Debug('Ошибка при сохранении изменений!')
										Call SqlRollback(hSql())
							Else
								Break
					Else
						Call Debug('Не указан номер и/или дата реестра!')
						Return FALSE
					Return TRUE
			Function: TITLE_TD
				Description:
				Returns
					Boolean: bOK
				Parameters
					Number: nAct
				Static Variables
				Local variables
				Actions
					If nAct = 0
						Call SalTblSetColumnTitle( SOST_EXP.tblT.IDT, 
								'Код 
								ТД ')
						Call SalTblSetColumnTitle( SOST_EXP.tblT.NAME,
								'Номер 
								ТД')
						Call SalTblSetColumnTitle( SOST_EXP.tblT.DATEDOC,
								'Дата 
								ТД')
						Call SalTblSetColumnTitle( SOST_EXP.tblT.S,
								'Сумма ТД 
								в нац.валюте' )
						Call SalTblSetColumnTitle( SOST_EXP.tblT.ISO,
								'Вал 
								ТД')
						Call SalTblSetColumnTitle( SOST_EXP.tblT.SKs,
								'Сумма ТД 
								в вал.контр.' )
						Call SalTblSetColumnTitle( SOST_EXP.tblT.Sum_PLs,
								'Общая
								сумма ПЛ
								по ТД' )
						Call SalTblSetColumnTitle( SOST_EXP.tblT.Debt_PLs,
								'Долг
								по 
								ТД' )
					Else
						Call SalTblSetColumnTitle( SOST_EXP.tblT.IDT,
								'Код 
								АКТа')
						Call SalTblSetColumnTitle( SOST_EXP.tblT.NAME,
								'Номер 
								АКТа')
						Call SalTblSetColumnTitle( SOST_EXP.tblT.DATEDOC,
								'Дата 
								АКТа')
						Call SalTblSetColumnTitle( SOST_EXP.tblT.S,
								'Сумма 
								АКТа')
						Call SalTblSetColumnTitle( SOST_EXP.tblT.ISO,
								'Вал 
								 АКТа')
						Call SalTblSetColumnTitle( SOST_EXP.tblT.SKs,
								'Сумма АКТа 
								в валюте
								контракта' )
						Call SalTblSetColumnTitle( SOST_EXP.tblT.KURS_T,
								'Кросс-
								курс' )
						!
						Call SalTblSetColumnTitle( SOST_EXP.tblT.Sum_PLs,
								'Общая
								сумма ПЛ
								по АКТу' )
						Call SalTblSetColumnTitle( SOST_EXP.tblT.Debt_PLs,
								'Долг
								по 
								АКТу' )
					Return TRUE
		Window Parameters
			Number: IDK
			Number: MODE  !! 0 - редактирование, 9 - просмотр 
		Window Variables
			String: NAMEK
			Number: KVK
			Number: RNK
			Number: SUMK
			Number: DAYS
			Number: AKT
			Date/Time: DAT1K
			Date/Time: DAT2K
			!
			Number: nID
			Number: nID_NEW
			Date/Time: dDATX
			Date/Time: dDATA
			Number: nRow
			Number: nSum2PayPL
			Number: nFetchRes
			Number: nTmp
			Number: nDig
			Number: nMaxDig
			: cMain
				Class: cABSConnect
			Window Handle: hWndLost
			Number: dfSUM_TD_ID
			!
			Number: nFocusRow
			Window Handle: hFocusCol
		Message Actions
			On SAM_Create
				Set dDATA=GetBankDate(  )
				Set nTabInstance1 = 1
				Set nTabInstance2 = 1
				Call SalMapEnterToTab( TRUE )
				Set SOST_EXP.strFilterTblName='TAMOZHDOC'
				!
				If MODE = 9
					Set SOST_EXP.nFlags = GT_ReadOnly
					Call SalDisableWindow( pbReestr )
				!
				Call PrepareWindowEx( hWndForm )
				Call SetWindowFullSize( hWndForm )
				Call SalSendClassMessage( SAM_Create, 0, 0 )
				!
				Call SalFontSet(SOST_EXP.dfSum_K,     "MS Sans Serif", 8, FONT_EnhBold)
				Call SalFontSet(SOST_EXP.dfSUM_TD,    "MS Sans Serif", 8, FONT_EnhBold)
				Call SalFontSet(SOST_EXP.dfSUM_PL,    "MS Sans Serif", 8, FONT_EnhBold)
				Call SalFontSet(SOST_EXP.dfAvans_PL,  "MS Sans Serif", 8, FONT_EnhBold)
				Call SalFontSet(SOST_EXP.dfSum2Pay,   "MS Sans Serif", 8, FONT_EnhBold)
				Call SalFontSet(SOST_EXP.dfSum2PayPL, "MS Sans Serif", 8, FONT_EnhBold)
			On UM_Populate
				Call SalSendMsg( tblP, UM_Populate, 0, 0 )
				Call SalSendMsg( tblT, UM_Populate, 0, 0 )
			On UM_Update
				Call SalSendMsg( tblP, UM_Update, 0, 0 )
				Call SalSendMsg( tblT, UM_Update, 0, 0 )
			On SAM_Close
				Call SalMapEnterToTab( FALSE )
	Form Window: SOST_IMP
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
		Title: Текущее состояние контракта
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
				Width:  11.417"
				Width Editable? Class Default
				Height: 6.393"
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
				Size: 0.488"
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
						Left:   0.033"
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
							Set strTip = 'Добавить новую запись'
						On SAM_Click
							Call SalSendMsg( hWndLost, UM_Insert, 0, 0 )
				Pushbutton: pbDel
					Class Child Ref Key: 16
					Class ChildKey: 0
					Class: cGenericTableSpl
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.473"
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
							Set strTip = 'Пометить/Снять пометку на удаление'
						On SAM_Click
							Call SalSendMsg( hWndLost, UM_Delete, 0, 0 )
				Pushbutton: pbRefresh
					Class Child Ref Key: 17
					Class ChildKey: 0
					Class: cGenericTableSpl
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.905"
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
							Call SalTblQueryFocus(hWndForm, nFocusRow, hFocusCol)
							Call SalSendClassMessage(SAM_Click, 0, 0)
				Pushbutton: pbUpdate
					Class Child Ref Key: 18
					Class ChildKey: 0
					Class: cGenericTableSpl
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.33"
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
							Set strTip = 'Внести изменения в Базу Данных'
						On SAM_Click
							Call SalSendMsg(hWndLost, UM_Update, 0, 0)
				Line
					Resource Id: 47914
					Class Child Ref Key: 19
					Class ChildKey: 0
					Class: cGenericTableSpl
					Coordinates
						Begin X:  1.883"
						Begin Y:  Class Default
						End X:  1.883"
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				!
				Pushbutton: pbFilt_PL
					Class Child Ref Key: 21
					Class ChildKey: 0
					Class: cGenericTableSpl
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   1.99"
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
							Set strTip='Установить фильтр по платежам'
						On SAM_Click
							Call SalSendMsg( tblP, UM_Filter, 0, 0 )
				Pushbutton: pbFind_TD
					Class Child Ref Key: 20
					Class ChildKey: 0
					Class: cGenericTableSpl
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.42"
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
							Set strTip = 'Найти тамож.декларацию/акт'
						On SAM_Click
							Call SalTblDefineSplitWindow(tblP, 0, FALSE)
							Call SalSendMsg(tblT, UM_Populate, 0, 0)
							Call SalSendMsg( tblT, UM_Search, 0, 0 )
				!
				Pushbutton: pbDetails
					Class Child Ref Key: 31
					Class ChildKey: 0
					Class: cGenericTableSpl
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   2.855"
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
					Picture File Name: \BARS98\RESOURCE\BMP\VIEW.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Карточка контракта'
						On SAM_Click
							Call SalCreateWindow(EID,hWndMDI, hWndForm.SOST_IMP.IDK, IifN(MODE=9,9,1), 1, hWndForm)
				Pushbutton: pbPrint
					Class Child Ref Key: 22
					Class ChildKey: 0
					Class: cGenericTableSpl
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.15"
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
							Set strTip = 'Печать Карточки контракта'
						On SAM_Click
							If hWndPrint
								Call SalBringWindowToTop( hWndPrint )
							Else
								Set hWndPrint=SalCreateWindow(REPORTS, hWndMDI, 1, IDK)
				Line
					Resource Id: 47915
					Class Child Ref Key: 23
					Class ChildKey: 0
					Class: cGenericTableSpl
					Coordinates
						Begin X:  3.783"
						Begin Y:  0.405"
						End X:  3.783"
						End Y:  0.0"
					Visible? No
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
						Left:   5.183"
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
					Resource Id: 47916
					Class Child Ref Key: 26
					Class ChildKey: 0
					Class: cGenericTableSpl
					Coordinates
						Begin X:  5.083"
						Begin Y:  Class Default
						End X:  5.083"
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbAvansTD
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbHelp
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.717"
						Top:    0.065"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
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
							Set strTip = 'Просмотр авансовых ТД'
						On SAM_Click
							If hWndAvansT
								Call SalDestroyWindow( hWndAvansT )
							Set hWndAvansT = SalCreateWindow(AvansTD, hWndMDI, 1, MODE, RNK, IDK, NAMEK, KVK, NUMBER_Null, 0, hWndForm)
				Pushbutton: pbDocView
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbHelp
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   3.283"
						Top:    0.065"
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
							Set strTip = 'Просмотр документа'
						On SAM_Click
							If SOST_IMP.tblP.REF >0 
								Call DocViewContentsEx(hWndMDI, SOST_IMP.tblP.REF)
				Pushbutton: pbReestr
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbRelation
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
					Picture File Name: \BARS98\RESOURCE\BMP\BROWSE.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Ввести № и дату реестра ТД'
						On SAM_Click
							Call F_Reestr()
							Call SalSendMsg( SOST_IMP.tblT, UM_Populate, 0, 0 )
				!
				Background Text: Сумма контр.
					Resource Id: 52730
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   5.8"
						Top:    0.05"
						Width:  1.5"
						Width Editable? Yes
						Height: 0.167"
						Height Editable? Yes
					Visible? Yes
					Justify: Center
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Bold
					Text Color: Dark Red
					Background Color: Default
				Data Field: dfSum_K
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
							Left:   5.783"
							Top:    0.2"
							Width:  1.5"
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
						Text Color: Dark Red
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
						On SAM_TooltipSetText
							Return XSalTooltipSetText( lParam, 'Сумма контракта' )
				Background Text: Сумма ПЛ
					Resource Id: 52729
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   7.283"
						Top:    0.05"
						Width:  1.5"
						Width Editable? Yes
						Height: 0.167"
						Height Editable? Yes
					Visible? Yes
					Justify: Center
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Bold
					Text Color: Midnight Blue
					Background Color: Default
				Data Field: dfSUM_PL
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
							Left:   7.283"
							Top:    0.2"
							Width:  1.5"
							Width Editable? Yes
							Height: 0.25"
							Height Editable? Yes
						Visible? Yes
						Border? Yes
						Justify: Right
						Format: ###000
						Country: Default
						Font Name: MS Sans Serif
						Font Size: 8
						Font Enhancement: Default
						Text Color: Midnight Blue
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
						On SAM_TooltipSetText
							Return XSalTooltipSetText( lParam, 'Общая сумма платежей по контракту' )
				Background Text: Сумма ТД
					Resource Id: 52728
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   8.783"
						Top:    0.05"
						Width:  1.5"
						Width Editable? Yes
						Height: 0.167"
						Height Editable? Yes
					Visible? Yes
					Justify: Center
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Bold
					Text Color: Purple
					Background Color: Default
				Data Field: dfSUM_TD
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
							Left:   8.783"
							Top:    0.2"
							Width:  1.5"
							Width Editable? Yes
							Height: 0.25"
							Height Editable? Yes
						Visible? Yes
						Border? Yes
						Justify: Right
						Format: ###000
						Country: Default
						Font Name: MS Sans Serif
						Font Size: 8
						Font Enhancement: Default
						Text Color: Purple
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
						On SAM_TooltipSetText
							Return XSalTooltipSetText( lParam, 'Общая сумма тамож.деклараций/актов по контракту' )
				Background Text: Аванс.ТД
					Resource Id: 52727
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   10.283"
						Top:    0.05"
						Width:  1.5"
						Width Editable? Yes
						Height: 0.167"
						Height Editable? Yes
					Visible? Yes
					Justify: Center
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Bold
					Text Color: Teal
					Background Color: Default
				Data Field: dfAvans_TD
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
							Left:   10.283"
							Top:    0.2"
							Width:  1.5"
							Width Editable? Yes
							Height: 0.25"
							Height Editable? Yes
						Visible? Yes
						Border? Yes
						Justify: Right
						Format: Decimal
						Country: Default
						Font Name: MS Sans Serif
						Font Size: 8
						Font Enhancement: Default
						Text Color: Teal
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
						On SAM_TooltipSetText
							Return XSalTooltipSetText( lParam, 'Сумма авансовых ТД' )
				Background Text: Долг по ПЛ
					Resource Id: 52731
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   11.783"
						Top:    0.05"
						Width:  1.5"
						Width Editable? Yes
						Height: 0.167"
						Height Editable? Yes
					Visible? Yes
					Justify: Center
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Bold
					Text Color: Red
					Background Color: Default
				Data Field: dfSum2Pay
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
							Left:   11.783"
							Top:    0.2"
							Width:  1.5"
							Width Editable? Yes
							Height: 0.25"
							Height Editable? Yes
						Visible? Yes
						Border? Yes
						Justify: Right
						Format: ###000
						Country: Default
						Font Name: Default
						Font Size: Default
						Font Enhancement: Default
						Text Color: Red
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
						On SAM_TooltipSetText
							Return XSalTooltipSetText( lParam, 'Долг ПЛ по контракту' )
				Background Text: Долг по ТД
					Resource Id: 34213
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   13.283"
						Top:    0.05"
						Width:  1.5"
						Width Editable? Yes
						Height: 0.167"
						Height Editable? Yes
					Visible? Yes
					Justify: Center
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Bold
					Text Color: Blue
					Background Color: Default
				Data Field: dfSum2PayTD
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
							Left:   13.283"
							Top:    0.2"
							Width:  1.5"
							Width Editable? Yes
							Height: 0.25"
							Height Editable? Yes
						Visible? Yes
						Border? Yes
						Justify: Right
						Format: ###000
						Country: Default
						Font Name: Default
						Font Size: Default
						Font Enhancement: Default
						Text Color: Blue
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
						On SAM_TooltipSetText
							Return XSalTooltipSetText( lParam, 'Долг ТД по контракту' )
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
						Top:    3.417"
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
			Child Table: tblP
				Class Child Ref Key: 28
				Class ChildKey: 0
				Class: cGenericTableSpl
				Property Template:
				Class DLL Name:
				Display Settings
					Window Location and Size
						Left:   0.0"
						Top:    0.821"
						Width:  14.833"
						Width Editable? Class Default
						Height: 2.595"
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
					Maximum Rows in Memory: 30000
					Discardable? Class Default
				Contents
					Column: IDP
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Код
								платежа
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Left
						Width:  1.067"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: ID
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Реф
								Пл
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.067"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: REF
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Референс
								платежа
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
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
					Column: FDAT
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Дата
								валютир
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
					Column: S
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма
								Платежа
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.571"
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
					Column: Ss
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма
								платежа
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
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
					Column: KV
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Код 
								вал
						Visible? No
						Editable? No
						Maximum Data Length: 3
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
					Column: ISO
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Код 
								вал
						Visible? Yes
						Editable? No
						Maximum Data Length: 3
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
					Column: KURS
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Курс
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
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
							On SAM_Validate
								Set SOST_IMP.tblP.SK=SOST_IMP.tblP.S*SOST_IMP.tblP.KURS
								Set SOST_IMP.tblP.SKs = Dig4( SOST_IMP.tblP.SK, DIG, nMaxDig )
							On SAM_AnyEdit
								If SOST_IMP.tblP.KOD=0
									Set SOST_IMP.tblP.KURS=nTmp
									Call SalTblSetRowFlags( SOST_IMP.tblP, SalTblQueryContext( SOST_IMP.tblP ), ROW_Edited, FALSE )
							On SAM_SetFocus
								Set nTmp = SOST_IMP.tblP.KURS
					Column: SK
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма
								Платежа
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.571"
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
					Column: SKs
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма
								платежа
								в вал.контр.
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
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
					Column: ACC
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Код 
								вал
						Visible? No
						Editable? No
						Maximum Data Length: 3
						Data Type: Number
						Justify: Right
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
					Column: NLS
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Лицевой
								счет
						Visible? Yes
						Editable? No
						Maximum Data Length: 14
						Data Type: String
						Justify: Left
						Width:  2.02"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: Sum_TD
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Общая
								сумма ПЛ
								по ТД
						Visible? No
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
					Column: Sum_TDs
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Общая
								сумма ТД
								по платежу
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
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
					Column: Sum_TD_PL
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
					Column: Debt_TD
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Долг
								по ТД
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.083"
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
					Column: Debt_TDs
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Долг
								в валюте
								контракта
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Right
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
					Column: Debt_TD_KV
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Долг
								по ТД
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.083"
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
					Column: Debt_TD_KVs
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Долг
								в валюте
								платежа
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Right
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
					Column: Sum90_TD
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма
								ПЛ
								< 91 дня
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.117"
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
					Column: Sum90_TDs
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма
								ТД   ДО
								контр.дня
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
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
					Column: Sum91_TD
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма
								ПЛ
								> 91 дня
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.133"
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
					Column: Sum91_TDs
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма
								ТД   ПОСЛЕ
								контр.дня
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
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
					Column: DAT91
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Контр.день 
								(1-ый день 
								нарушения)
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
					Column: REST
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Кол-во
								дней
								просрочки
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
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
					Column: SOS
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
					Column: NAZN
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Назначение платежа
						Visible? Yes
						Editable? No
						Maximum Data Length: 160
						Data Type: String
						Justify: Left
						Width:  4.883"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: DIG
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
					Column: CHK
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
					Column: KOD
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
					Function: F_CHECK
						Description: Наложение визы валютного контроля
						Returns
							Boolean: bOK
						Parameters
							Number: nRef
							String: sChk
						Static Variables
						Local variables
						Actions
							If nGrp=NUMBER_Null
								Call SalMessageBox( 'Не определена группа визирования валютного контроля!', 'Ошибка!', MB_IconStop|MB_OK )
								Return FALSE
							If DocumentCheck(nRef, nGrp, sChk, FALSE) = MBEx_Cancel
								Return FALSE
							Return TRUE
				Window Variables
					String: strSqlPopulate
					String: strSqlInsert	
					String: strSqlDelete	
					String: strSqlUpdate
					String: strSqlDelete2Avans
					String: strSqlInsertAvans
					!
					Number: nS100
					Number: nS_REF
					Number: nDELTA
					Number: nSumP
					Number: nVisaExist
					!
					: cQry
						Class: cGenQuery
					: cFlt
						Class: cGenFilter
					Number: nRowF
					Window Handle: hColF
					Number: nIDPF
					Number: nTruncSumK
					Number: nTruncSumP
				Message Actions
					On SAM_Create
						Set strSqlInsert = "INSERT INTO contracts (id,name,closed,pid)
								                    VALUES (:nID_NEW,:nID_NEW,0,:SOST_IMP.IDK)" 
						Set strSqlUpdate = "UPDATE contract_p SET 
								                       id=:nID_NEW,
								                       pid=:SOST_IMP.IDK,
								                       s=:SOST_IMP.tblP.nS100,
								                       kurs=:SOST_IMP.tblP.KURS  
								                    WHERE idp=:SOST_IMP.tblP.IDP"
						Set strSqlInsertAvans =
								    "INSERT INTO contract_p (idp,ref,fdat,kv,s,acc,rnk,impexp,details) 
								     VALUES (0,:SOST_IMP.tblP.REF,:SOST_IMP.tblP.FDAT,:SOST_IMP.tblP.KV,
								             :SOST_IMP.tblP.nSumP,:SOST_IMP.tblP.ACC,  
								             :SOST_IMP.RNK,1,:SOST_IMP.tblP.NAZN)"
						Set strSqlDelete  = "DELETE FROM contract_p 
								                     WHERE ref=:SOST_IMP.tblP.REF AND (id IS NULL OR id=:SOST_IMP.tblP.ID) "
						Set strSqlDelete2Avans = "UPDATE contract_p SET id=TO_NUMBER(NULL), pid=TO_NUMBER(NULL), kurs=TO_NUMBER(NULL)                     
								                          WHERE idp=:SOST_IMP.tblP.IDP"
						Set strSqlPopulate = 
								    "SELECT r.id, r.ref, r.idp, r.fdat, r.dat91, r.kv,
								            r.s/100, r.kurs, decode(o.dk,0,o.nlsb,o.nlsa),
								            nvl(r.details,o.nazn), nvl(o.sos,5), get_truncsum4contract(r.kv), v.lcv, v.dig
								     INTO :SOST_IMP.tblP.ID,  :SOST_IMP.tblP.REF,  :SOST_IMP.tblP.IDP, 
								          :SOST_IMP.tblP.FDAT,:SOST_IMP.tblP.DAT91,:SOST_IMP.tblP.KV,
								          :SOST_IMP.tblP.S,   :SOST_IMP.tblP.KURS, :SOST_IMP.tblP.NLS,
								          :SOST_IMP.tblP.NAZN,:SOST_IMP.tblP.SOS,  :nTruncSumP, :SOST_IMP.tblP.ISO, :SOST_IMP.tblP.DIG
								     FROM contract_p r, oper o, contracts c, tabval v
								     WHERE r.ref=o.ref(+) AND r.id=c.id AND r.kv=v.kv AND c.pid="||Str(IDK)||"     
								     ORDER BY r.fdat, r.idp"
						Call cFlt.Init( 'oper', 'o' )
						Call cQry.Init( SOST_IMP.tblP.strSqlPopulate )
						!
						If DigInit() != -1
							Set nMaxDig = DigInit()
						Else
							! ?
						Call SalSendClassMessage( SAM_Create, 0, 0 )
					On SAM_CreateComplete
						Call SalSendMsg( SOST_IMP.tblP, UM_Populate, 0, 0 )
					On SAM_FetchRowDone
						Set SOST_IMP.tblP.Ss  = Dig4( SOST_IMP.tblP.S, DIG, nMaxDig )
						Set SOST_IMP.tblP.SK  = SOST_IMP.tblP.S*SOST_IMP.tblP.KURS
						Set SOST_IMP.tblP.SKs = Dig4( SOST_IMP.tblP.SK, DIG, nMaxDig )
						!
						If SOST_IMP.tblP.REF
							If SOST_IMP.tblP.SOS<0
								Call SetTblRowColor( SOST_IMP.tblP, COLOR_Red )
							Else If SOST_IMP.tblP.SOS=1
								Call SetTblRowColor( SOST_IMP.tblP, COLOR_DarkGreen )
							Else If SOST_IMP.tblP.SOS=3
								Call SetTblRowColor( SOST_IMP.tblP, COLOR_Blue )
							Else
								Call SetTblRowColor( SOST_IMP.tblP, COLOR_Black )
						Else
							Call SetTblRowColor( SOST_IMP.tblP, COLOR_Black )
						!
						! ! Общая сумма ТД, сумма нарушителей и не очень
						If SqlPrepareAndExecute( hSqlAux2(),
								   "SELECT sum(round(t.s/t.kurs)),
								           sum(iif_d(t.datedoc,p.dat91,
								                     0,
								                     nvl(round(t.s/t.kurs),0),
								                     nvl(round(t.s/t.kurs),0))),
								           sum(round(decode(t.kv, p.kv, t.s/t.kurs, t.s * t.kurs_pl)))
								     INTO :SOST_IMP.tblP.Sum_TD, 
								          :SOST_IMP.tblP.Sum91_TD,
								          :SOST_IMP.tblP.Sum_TD_PL
								     FROM contracts c, tamozhdoc t, contract_p p
								    WHERE p.idp = :SOST_IMP.tblP.IDP
								      AND c.id = t.id(+) 
								      AND c.id = p.id 
								  " )
							Call SqlFetchNext( hSqlAux2(), nFetchRes )
							Set SOST_IMP.tblP.Sum90_TD = SOST_IMP.tblP.Sum_TD - SOST_IMP.tblP.Sum91_TD
							! Сумма незакрытых ТД по платежу в валюте контракта
							Set SOST_IMP.tblP.Debt_TD = 
									    IifN( SOST_IMP.tblP.SK*100 - SOST_IMP.tblP.Sum_TD <= 0,
									          0,
									          SOST_IMP.tblP.SK*100 - SOST_IMP.tblP.Sum_TD )
							!
							Set Sum_TDs     = Dig4( Sum_TD/100,     nDig, nDig )
							Set Sum90_TDs   = Dig4( Sum90_TD/100,   nDig, nDig )
							Set Sum91_TDs   = Dig4( Sum91_TD/100,   nDig, nDig )
							Set Debt_TDs    = Dig4( Debt_TD/100,    nDig, nDig )
						! Сумма незакрытых ТД по платежу в валюте платежа
						Set SOST_IMP.tblP.Debt_TD_KV =  
								IifN( SOST_IMP.tblP.S*100 - SOST_IMP.tblP.Sum_TD_PL <= 0,
								          0,
								          SOST_IMP.tblP.S*100 - SOST_IMP.tblP.Sum_TD_PL )
						! If AKT = 1
							                                            Set SOST_IMP.tblP.Debt_TD_KV =  
									IifN( SOST_IMP.tblP.S*100 - SOST_IMP.tblP.Sum_TD_PL <= 0,
									          0,
									          SOST_IMP.tblP.S*100 - SOST_IMP.tblP.Sum_TD_PL )
						! Else
							                                            Set SOST_IMP.tblP.Debt_TD_KV =  
									IifN( SOST_IMP.tblP.S*100 - SOST_IMP.tblP.Sum_TD/SOST_IMP.tblP.KURS <= 0,
									      0,
									      SOST_IMP.tblP.S*100 - SOST_IMP.tblP.Sum_TD/SOST_IMP.tblP.KURS )
						Set SOST_IMP.tblP.Debt_TD_KVs = Dig4( Debt_TD_KV/100, nDig, nDig )
						!
						If SalNumberRound(SOST_IMP.tblP.Debt_TD)    > nTruncSumK
							Call SalTblSetCellTextColor( SOST_IMP.tblP.Debt_TDs, COLOR_Red, FALSE )
							! Кол-во дней просрочки
							Set SOST_IMP.tblP.REST=IifN(dDATA-SOST_IMP.tblP.DAT91+1>0,dDATA-SOST_IMP.tblP.DAT91+1,NUMBER_Null)
							If SOST_IMP.tblP.REST>0
								Call SalTblSetCellTextColor( SOST_IMP.tblP.REST, COLOR_Red, FALSE )
						If SalNumberRound(SOST_IMP.tblP.Debt_TD_KV) > nTruncSumP
							Call SalTblSetCellTextColor( SOST_IMP.tblP.Debt_TD_KVs, COLOR_Red, FALSE )
					On UM_Populate
						Call SalWaitCursor(TRUE)
						Call SalTblDefineSplitWindow(hWndForm, 0, FALSE)
						!
						Call SalTblQueryFocus( SOST_IMP.tblP, nRowF, hColF )
						Set nIDPF = SOST_IMP.tblP.IDP
						! ! Параметры контракта
						If SqlPrepareAndExecute(hSqlAux2(),
								     "SELECT rnk, name, dateopen, dateclose, s, kv, control_days,
								             decode(nvl(id_oper,1), 2, 1, 0), get_truncsum4contract(kv)
								      INTO :RNK, :NAMEK, :DAT1K, :DAT2K, :SUMK, :KVK, :DAYS, :AKT, :nTruncSumK
								      FROM top_contracts WHERE pid=:IDK")
							Call SqlFetchNext( hSqlAux2(), nFetchRes )
						Call SqlPrepareAndExecute( hSql(),
								     "SELECT dig INTO :nDig FROM tabval WHERE kv = :KVK")
						If not SqlFetchNext( hSql(), nFetchRes )
							Set nDig=2
						Set dfSum_K=Dig4( SUMK/100, nDig, nDig )
						Call SalSetWindowText( SOST_IMP, 'ИМПОРТ. Текущее состояние контракта № '|| NAMEK||' от '||SalFmtFormatDateTime( DAT1K, 'dd/MM/yyyy' )  )
						! АКТ или ТД
						If AKT = 1
							Call SalHideWindow( SOST_IMP.tblT.REESTR )
							Call SalHideWindow( SOST_IMP.tblT.DATR )
							Call SalShowWindow( SOST_IMP.tblT.SPs )
						Else
							Call SalShowWindow( SOST_IMP.tblT.REESTR )
							Call SalShowWindow( SOST_IMP.tblT.DATR )
							Call SalHideWindow( SOST_IMP.tblT.SPs )
						Call TITLE_TD (AKT)
						!
						Call SalTblQueryFocus(hWndForm, nFocusRow, hFocusCol)
						Call SalTblPopulate(SOST_IMP.tblP, hSql(), T(SOST_IMP.tblP.strSqlPopulate),TBL_FillAll)
						If nIDPF
							Set nRowF = TBL_MinRow
							Loop
								If SalTblFindNextRow( SOST_IMP.tblP, nRowF, 0, 0 )
									Call SalTblSetContext( SOST_IMP.tblP, nRowF )
									If SOST_IMP.tblP.IDP = nIDPF
										Call SalTblSetFocusRow( SOST_IMP.tblP, nRowF )
										Call SalTblSetContext( SOST_IMP.tblP, nFocusRow )
										Call SalTblSetRowFlags( SOST_IMP.tblP, nFocusRow, ROW_Selected, TRUE )
										Break
								Else
									Call SalTblSetFocusRow( SOST_IMP.tblP, nRowF )
									Break
						! ! Общая сумма ТД по контракту
						Call SqlPrepareAndExecute( hSqlAux2(),
								    "SELECT nvl(sum(round(t.s/t.kurs)), 0)/100
								       INTO :dfSUM_TD
								       FROM top_contracts tc, tamozhdoc t, contracts c
								      WHERE tc.pid = c.pid AND c.id = t.id(+) AND tc.pid = :IDK" )
						If NOT SqlFetchNext( hSqlAux2(), nFetchRes )
							Set dfSUM_TD=0
						! Долг ТД - незакрытая таможками сумма платежей по контракту
						Set SOST_IMP.dfSum2PayTD=SOST_IMP.dfSUM_PL-dfSUM_TD-dfAvans_TD
						! ! Общая сумма ПЛ по контракту
						Call SqlPrepareAndExecute( hSqlAux2(),
								    "SELECT nvl(sum(round(nvl(p.s,0)*nvl(p.kurs,1))),0)/100
								       INTO :dfSUM_PL
								       FROM top_contracts tc, contracts c, contract_p p
								      WHERE tc.pid = c.pid AND c.id = p.id(+) AND tc.pid = :IDK")
						If NOT SqlFetchNext( hSqlAux2(), nFetchRes )
							Set dfSUM_PL=0
						Set SOST_IMP.dfSum2Pay=SOST_IMP.SUMK/100-dfSUM_PL
						Call SalSendMsg( hWndForm, SAM_TblDoDetails, 0, 0 )
						Call SalWaitCursor(FALSE)
					On SAM_TblDoDetails
						Set nID=SOST_IMP.tblP.ID
						! Set dDATX = SOST_IMP.tblP.FDAT
						Set dDATX = SOST_IMP.tblP.DAT91
						Call SalSendMsg(tblT, UM_Populate, 0, 0)
					On SAM_SetFocus
						If SalTblQueryRowFlags ( hWndForm, lParam, ROW_New )
							Set nID=SOST_IMP.tblP.ID
							! Set dDATX = SOST_IMP.tblP.FDAT
							Set dDATX = SOST_IMP.tblP.DAT91
					On SAM_KillFocus
						Set hWndLost=hWndForm
					On UM_Insert
						If SalMessageBox( 'Искать документ?', 'Внимание', MB_IconQuestion|MB_YesNo )=IDYES
							If hWndAvansP
								Call SalDestroyWindow( hWndAvansP )
							Set hWndAvansP = SalCreateWindow(AvansRef, hWndMDI, 1, 2, IDK, RNK, KVK, dfSum2Pay, hWndForm)
					On UM_Update
						Call SalWaitCursor(TRUE)
						If strSqlInsert != '' AND SalTblAnyRows( SOST_IMP.tblP, ROW_New, 0 )
							If SqlPrepareAndExecute(hSql(),"SELECT s_contracts.NEXTVAL INTO :nID_NEW FROM DUAL")
								Call SqlFetchNext( hSql(), nFetchRes )
								Set SOST_IMP.tblP.nS100=SOST_IMP.tblP.S*100
								Call SqlPrepare(hSql(), T(strSqlInsert))
								! Call Debug('Создаем субконтракт с кодом '||Str(nID_NEW))
								If SalTblDoInserts(hWndForm, hSql(), FALSE)
									Call SqlPrepare(hSql(), T(strSqlUpdate))
									If SalTblDoInserts(hWndForm, hSql(), FALSE)
										! Call Debug('Привязали платеж с кодом '||Str(IDP))
										If nSumP > 0
											Call SqlPrepare(hSql(), T(strSqlInsertAvans))
											! Call Debug('Отправим в аванс сумму '||Str(nSumP))
											Call SalTblDoInserts(hWndForm, hSql(), TRUE)
										! Проверим наличие визы валютного контроля на документе
										Call SqlPrepareAndExecute( hSqlAux2(), 
												    "SELECT nvl(max(o.status),0) INTO :nVisaExist 
												     FROM oper_visa o, params p
												     WHERE o.ref=:SOST_IMP.tblP.REF   AND o.status<3 AND 
												           o.groupid=to_number(p.val) AND p.par='VALKVISA'" )
										If NOT SqlFetchNext( hSqlAux2(), nFetchRes )
											Set nVisaExist = 0
										If SOST_IMP.tblP.REF = NUMBER_Null 
												OR SOST_IMP.tblP.REF = 0 
												OR SOST_IMP.tblP.SOS = 5
											Set nVisaExist=1
										!
										If nVisaExist=0
											If SalMessageBox( 'Визировать?', 'Внимание', MB_IconQuestion|MB_YesNo )=IDYES
												If NOT F_CHECK(SOST_IMP.tblP.REF,SOST_IMP.tblP.CHK) 
													Call SalMessageBox( 'Ошибка при наложении визы!', 'Внимание', MB_IconStop|MB_OK )
													Call SQL_ROLLBACK(  )
											Else
												Call SqlRollback(hSql())
						If strSqlDelete != ''  AND SalTblAnyRows( SOST_IMP.tblP, ROW_MarkDeleted, 0 )
							! Сторнированный документ при удалении физически убиваем
							If SOST_IMP.tblP.SOS<0
								Call SqlPrepareAndExecute( hSqlAux2(), 
										    "UPDATE tamozhdoc SET pid=TO_NUMBER(NULL), id=TO_NUMBER(NULL)  
										     WHERE id=:SOST_IMP.tblP.ID" )
								Call SqlPrepare(hSql(), T(strSqlDelete))
								Call SalTblDoDeletes(hWndForm, hSql(), ROW_MarkDeleted) 
							! "Хороший" документ при удалении перемещаем в аванс
							Else
								If strSqlDelete2Avans != ''
									Call SqlPrepareAndExecute( hSqlAux2(), 
											    "UPDATE tamozhdoc SET pid=TO_NUMBER(NULL), id=TO_NUMBER(NULL)  
											     WHERE id=:SOST_IMP.tblP.ID" )
									Call SqlPrepare(hSql(), T(strSqlDelete2Avans))
									Call SalTblDoDeletes(hWndForm, hSql(), ROW_MarkDeleted)
						Call SqlCommit(hSql())
						Call SalTblDefineSplitWindow(hWndForm, 0, FALSE)
						Call SalPostMsg(SOST_IMP, UM_Populate, 0, 0)
						Call SalWaitCursor(FALSE)
					On UM_Filter		
						If SetQueryFilter( cFlt )
							Set strSqlPopulate = cQry.GetFullSQLString( cFlt )
							Call SalSendMsg( tblP, UM_Populate, 0, 0 )
							Call SelFirstRow( tblP )
							Call SalSendMsg( tblP, SAM_RowSetContext, 0, 0 )
					On SAM_DoubleClick
						Call SalSendMsg( pbDocView, SAM_Click, 0, 0 )
			Child Table: tblT
				Class Child Ref Key: 27
				Class ChildKey: 0
				Class: cGenericTableSpl
				Property Template:
				Class DLL Name:
				Display Settings
					Window Location and Size
						Left:   -0.017"
						Top:    3.488"
						Width:  13.683"
						Width Editable? Class Default
						Height: 0.786"
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
					Maximum Rows in Memory: 30000
					Discardable? Class Default
				Contents
					Column: IDT
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Код
								ТД / 
								АКТа
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.067"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: ID
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
					Column: NAME
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Таможенный
								Документ / 
								АКТ
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  2.55"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: DATEDOC
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Дата
								ТД / 
								АКТа
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
							On SAM_Validate
					Column: S
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма
								ТД
								в нац.вал.
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.5"
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
								Set S100=S*100
								Return VALIDATE_Ok
					Column: ISO
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Код
								вал
								
						Visible? Yes
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
								вал
								
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
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
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: KURS_T
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: 
								Курс
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
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
					Column: SKs
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма 
								ТД/АКТА
								в вал.контракта
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Right
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
					Column: KURS_PL
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Кросс-курс
								к валюте
								платежа
						Visible? Yes
						Editable? Yes
						Maximum Data Length: Default
						Data Type: Number
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
					Column: SPs
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма 
								ТД/АКТА
								в вал.платежа
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Right
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
					Column: REESTR
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: № реестра
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  2.02"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: DATR
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Дата
								реестра
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Date/Time
						Justify: Center
						Width:  1.2"
						Width Editable? Yes
						Format: dd-MM-yyyy
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: SK
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма ТД
								в валюте
								контракта
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.667"
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
					Column: SP
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Сумма ТД
								в валюте
								контракта
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.667"
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
					Column: S100
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: !!! Сумма
								из ТД
						Visible? No
						Editable? Yes
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.329"
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
								Set S100=S*100
								Return VALIDATE_Ok
					Column: OVERD
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Просрочка
								(дней)
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
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
					Column: DIG
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
					String: strSqlPopulate	! Строка SQL SELECT
					String: strSqlInsert	! Строка SQL INSERT
					String: strSqlDelete	! Строка SQL DELETE
					String: strSqlUpdate	! Строка SQL UPDATE
					Number: nDELTA
					Number: nS_TD
				Message Actions
					On SAM_Create
						Set strSqlInsert = 
								   "INSERT INTO tamozhdoc 
								       (idt, name, datedoc, s, kv, kurs, kurs_pl, pid, 
								        registry_num, registry_dat, rnk, id_parent, impexp) 
								    VALUES 
								       (0,
								        :SOST_IMP.tblT.NAME,
								        :SOST_IMP.tblT.DATEDOC,
								        :SOST_IMP.tblT.nDELTA,
								        :SOST_IMP.tblT.KV,
								        :SOST_IMP.tblT.KURS_T,
								        :SOST_IMP.tblT.KURS_PL,
								        :IDK,
								        :SOST_IMP.tblT.REESTR,
								        :SOST_IMP.tblT.DATR,
								        :SOST_IMP.RNK,
								        :SOST_IMP.tblT.IDT,
								        1)" 
						Set strSqlUpdate = 
								   "UPDATE tamozhdoc 
								       SET pid          = :IDK,
								           name         = :SOST_IMP.tblT.NAME,
								           rnk          = :SOST_IMP.RNK,
								           datedoc      = :SOST_IMP.tblT.DATEDOC,
								           s            = :SOST_IMP.tblT.S100,
								           kurs         = :SOST_IMP.tblT.KURS_T,
								           kv           = :SOST_IMP.tblT.KV,
								           registry_num = :SOST_IMP.tblT.REESTR,
								           registry_dat = :SOST_IMP.tblT.DATR, 
								           id           = :nID,
								           kurs_pl      = :SOST_IMP.tblT.KURS_PL
								     WHERE idt          = :SOST_IMP.tblT.IDT" 
						Set strSqlDelete = 
								   "UPDATE tamozhdoc 
								       SET id  = TO_NUMBER(NULL) 
								     WHERE idt = :SOST_IMP.tblT.IDT"
						Set SOST_IMP.tblT.strSqlPopulate =
								   "SELECT t.idt, t.id, t.name, t.datedoc, 
								           t.s/100, t.s, t.kv, t.kurs, t.kurs_pl,
								           t.registry_num, t.registry_dat, 
								           v.lcv, v.dig, t.s/t.kurs/100, t.s*t.kurs_pl/100
								      INTO :SOST_IMP.tblT.IDT, 
								           :SOST_IMP.tblT.ID, 
								           :SOST_IMP.tblT.NAME,
								           :SOST_IMP.tblT.DATEDOC, 
								           :SOST_IMP.tblT.S,  
								           :SOST_IMP.tblT.S100,
								           :SOST_IMP.tblT.KV,  
								           :SOST_IMP.tblT.KURS_T, 
								           :SOST_IMP.tblT.KURS_PL,
								           :SOST_IMP.tblT.REESTR, 
								           :SOST_IMP.tblT.DATR,
								           :SOST_IMP.tblT.ISO, 
								           :SOST_IMP.tblT.DIG, 
								           :SOST_IMP.tblT.SK,  
								           :SOST_IMP.tblT.SP
								      FROM tamozhdoc t, tabval v
								     WHERE t.kv = v.kv AND t.id = :nID 
								     ORDER BY t.datedoc, t.idt"    
						!
						Call SalSendClassMessage( SAM_Create, 0, 0 )
					On SAM_FetchRowDone
						Set SKs = Dig4( SK, DIG, DIG )
						Set SPs = Dig4( SP, DIG, DIG )
						! Сколько дней просрочки
						! Set OVERD = DATEDOC -(dDATX + DAYS)
						Set OVERD = DATEDOC - dDATX + 1
						If OVERD>0
							Call SalTblSetCellTextColor( SOST_IMP.tblT.OVERD, COLOR_Red, FALSE )
						Else
							Set OVERD=NUMBER_Null
					On UM_Populate
						Call SalWaitCursor(TRUE)
						Call SalTblDefineSplitWindow(hWndForm, 0, FALSE)
						Call SalTblPopulate(hWndForm, hSql(), T(strSqlPopulate),TBL_FillAll)
						If SqlPrepareAndExecute( hSqlAux2(), 
								  "SELECT sum(round(t.s/t.kurs/power(10,v.dig),2)) 
								   INTO :SOST_IMP.dfAvans_TD
								   FROM tabval v, tamozhdoc t 
								   WHERE v.kv=t.kv AND t.id IS NULL AND t.pid=:SOST_IMP.IDK" )
							Call SqlFetchNext( hSqlAux2(), nFetchRes )
						Call SalWaitCursor(FALSE)
					On SAM_CreateComplete
						Call SalSendMsg( hWndForm, UM_Populate, 0, 0 )
					On SAM_KillFocus
						Set hWndLost=hWndItem
					On UM_Delete
						Set nRow = TBL_MinRow
						While SalTblFindNextRow(hWndForm, nRow, ROW_Selected, 0)
							If NOT SalTblQueryRowFlags(hWndForm, nRow, ROW_New)
								Call SalTblSetRowFlags(hWndForm, nRow, ROW_MarkDeleted,
										     not SalTblQueryRowFlags(hWndForm, nRow, ROW_MarkDeleted))
							Else
								Call SalTblDeleteRow(hWndForm, nRow, TBL_NoAdjust)
					On UM_Update
						Call SalWaitCursor(TRUE)
						Set nRow = TBL_MinRow
						If strSqlDelete != '' AND SalTblAnyRows( SOST_IMP.tblT, ROW_MarkDeleted, 0 )
							Call SqlPrepare(hSql(), T(strSqlDelete))
							Call SalTblDoDeletes(hWndForm, hSql(), ROW_MarkDeleted)
						Set nRow = TBL_MinRow
						If strSqlInsert != '' AND SalTblAnyRows( SOST_IMP.tblT, ROW_New, 0 )
							Set nRow = TBL_MinRow
							While SalTblFindNextRow( SOST_IMP.tblT, nRow, 0, 0 )
								Call SalTblSetContext( SOST_IMP.tblT, nRow )
								If SqlPrepareAndExecute( hSqlAux2(), 
										    "SELECT s INTO :nS_TD FROM tamozhdoc WHERE idt=:SOST_IMP.tblT.IDT" ) AND
										   SqlFetchNext( hSqlAux2(), nFetchRes )
									Set nDELTA=nS_TD-S100
									If SalNumberRound(nDELTA/SOST_IMP.tblT.KURS_T)>0>0
										! Call Debug('создаем аванс на сумму '||Str(nDELTA))
										Call SqlPrepare(hSql(), T(strSqlInsert))
										Call SalTblDoInserts(hWndForm, hSql(), FALSE)
									! Call Debug('Привяжем к контракту сумму '||Str(S100))
									Call SqlPrepare(hSql(), T(strSqlUpdate))
									Call SalTblDoInserts(hWndForm, hSql(), TRUE)
								Else
									Call SQL_ROLLBACK(  )
						Call SqlCommit(hSql())
						Call SalPostMsg(SOST_IMP, UM_Populate, 0, 0)
						Call SalWaitCursor(FALSE)
					On UM_Insert
						If hWndAvansT
							Call SalDestroyWindow( hWndAvansT )
						Set hWndAvansT = SalCreateWindow( AvansTD, hWndMDI, 1, 0, RNK, IDK, NAMEK, KVK, SOST_IMP.tblP.KV, SOST_IMP.tblP.Debt_TD, hWndForm )
					On UM_Search
						Call TblFindString(tblT,  DFIND_First)
		Functions
			Function: F_Reestr
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					String: rNAME
					Date/Time: rDAT
					Number: nTmp
				Actions
					Call SalModalDialog(dlg_REESTR, hWndForm, rNAME, rDAT)
					If rNAME != STRING_Null AND rDAT != DATETIME_Null
						Set nTmp = TBL_MinRow
						Loop
							If SalTblFindNextRow (SOST_IMP.tblT, nTmp, ROW_Selected, 0)
								Call SalTblSetContext(SOST_IMP.tblT,nTmp)
								If nTmp >=0
									If SqlPrepareAndExecute( hSql(),
											  "UPDATE tamozhdoc 
											      SET registry_num = :rNAME,
											          registry_dat = :rDAT
											    WHERE idt          = :SOST_IMP.tblT.IDT")
										Call SqlCommit( hSql() )
									Else
										Call Debug('Ошибка при сохранении изменений!')
										Call SqlRollback(hSql())
							Else
								Break
					Else
						Call Debug('Не указан номер и/или дата реестра!')
						Return FALSE
					Return TRUE
			Function: TITLE_TD
				Description:
				Returns
					Boolean: bOK
				Parameters
					Number: nAct
				Static Variables
				Local variables
				Actions
					If nAct = 0
						Call SalTblSetColumnTitle( SOST_IMP.tblT.IDT, 
								'Код 
								ТД ')
						Call SalTblSetColumnTitle( SOST_IMP.tblT.NAME,
								'Номер 
								ТД')
						Call SalTblSetColumnTitle( SOST_IMP.tblT.DATEDOC,
								'Дата 
								ТД')
						Call SalTblSetColumnTitle( SOST_IMP.tblT.S,
								'Сумма ТД 
								в нац.валюте' )
						Call SalTblSetColumnTitle( SOST_IMP.tblT.ISO,
								'Вал 
								ТД')
						Call SalTblSetColumnTitle( SOST_IMP.tblT.SKs,
								'Сумма ТД 
								в вал.контр.' )
						Call SalTblSetColumnTitle( SOST_IMP.tblT.SPs,
								'Сумма ТД 
								в вал.платежа' )
					Else
						Call SalTblSetColumnTitle( SOST_IMP.tblT.IDT,
								'Код 
								АКТа')
						Call SalTblSetColumnTitle( SOST_IMP.tblT.NAME,
								'Номер 
								АКТа')
						Call SalTblSetColumnTitle( SOST_IMP.tblT.DATEDOC,
								'Дата 
								АКТа')
						Call SalTblSetColumnTitle( SOST_IMP.tblT.S,
								'Сумма 
								АКТа')
						Call SalTblSetColumnTitle( SOST_IMP.tblT.ISO,
								'Вал 
								 АКТа')
						Call SalTblSetColumnTitle( SOST_IMP.tblT.SKs,
								'Сумма АКТа 
								в вал.контр.' )
						Call SalTblSetColumnTitle( SOST_IMP.tblT.SPs,
								'Сумма АКТа 
								в вал.платежа' )
						Call SalTblSetColumnTitle( SOST_IMP.tblT.KURS_T,
								'Кросс-
								курс' )
					Return TRUE
		Window Parameters
			Number: IDK
			Number: MODE  !! 0 - редактирование, 9 - просмотр 
		Window Variables
			String: NAMEK
			Number: KVK
			Number: RNK
			Number: SUMK
			Number: DAYS
			Number: AKT
			Date/Time: DAT1K
			Date/Time: DAT2K
			!
			Number: nID
			Number: nID_NEW
			Number: nRow
			Date/Time: dDATX
			Date/Time: dDATA
			Window Handle: hWndLost
			Number: nFetchRes
			Number: nDig
			Number: nMaxDig
			Number: nTmp
			! Визирование
			Number: nUserId
			Number: nGrp
			!
			Number: nFocusRow
			Window Handle: hFocusCol
		Message Actions
			On SAM_Create
				Set dDATA=GetBankDate(  )
				Set nTabInstance1 = 1
				Set nTabInstance2 = 1
				Set nUserId=GetUserId(  )
				Set nGrp=SalStrToNumber(GetGlobalOption('VALKVISA'))
				Set SOST_IMP.strFilterTblName='CONTRACT_P'
				!
				If MODE = 9
					Set SOST_IMP.nFlags = GT_ReadOnly
					Call SalDisableWindow( pbReestr )
				!
				Call SalMapEnterToTab( TRUE )
				Call PrepareWindowEx( hWndForm )
				Call SetWindowFullSize( hWndForm )
				!
				Call SalSendClassMessage( SAM_Create, 0, 0 )
				Call SalFontSet(SOST_IMP.dfSum_K,     "MS Sans Serif", 8, FONT_EnhBold)
				Call SalFontSet(SOST_IMP.dfSUM_PL,    "MS Sans Serif", 8, FONT_EnhBold)
				Call SalFontSet(SOST_IMP.dfSUM_TD,    "MS Sans Serif", 8, FONT_EnhBold)
				Call SalFontSet(SOST_IMP.dfAvans_TD,  "MS Sans Serif", 8, FONT_EnhBold)
				Call SalFontSet(SOST_IMP.dfSum2Pay,   "MS Sans Serif", 8, FONT_EnhBold)
				Call SalFontSet(SOST_IMP.dfSum2PayTD, "MS Sans Serif", 8, FONT_EnhBold)
			On UM_Update
				Call SalSendMsg( tblT,     UM_Update, 0, 0 )
				Call SalSendMsg( tblP,     UM_Update, 0, 0 )
			On UM_Populate
				Call SalSendMsg( tblT,     UM_Populate, 0, 0 )
				Call SalSendMsg( tblP,     UM_Populate, 0, 0 )
			On SAM_Close
				Call SalMapEnterToTab( FALSE )
	Table Window: F98
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: База (не)резидентов, в отношении которых введены/аннулированы санкции Министерства Экономики Украины
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
				Width:  15.917"
				Width Editable? Class Default
				Height: 6.595"
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
				Size: 0.417"
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
					Resource Id: 12580
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
							Set strTip = "Выполнить импорт файла F98*"
						On SAM_Click
							Call SalDlgOpenFile ( hWndForm, 'Выбрать файл...', strFilters, 2, nIndex, strFileIn, strPathIn )
							If SalStrLeftX( SalStrUpperX(strFileIn), 3 ) != 'F98'
								Call SalMessageBox( 'Неверное имя файла!', 'Ошибка', MB_IconStop )
							Else
								Set SqlDatabase = 'dBase_Files'
								If SqlConnect(hSqlA)
									Call SalWaitCursor( TRUE )
									If SqlPrepareAndExecute( hSql(), "DELETE FROM f98" )
										If SqlPrepareAndExecute( hSqlA,
												  "SELECT val(np), dt, ek_pok, ko, mfo, ku, 
												          val(k030), ko_1, r1_1, r2_1, k020,
												          djerpod, nakaz, datanak, nomnak,
												          djerpods, datnaksk, nomnaksk, 
												          val(v_sank), sanksia1, srsank11, srsank12,
												          r4, val(r030), t071, val(k040), data_m
												     INTO :Np,:Dat,:Ek_pok,:Ko,:Mfo,:Ku,
												          :Rezid,:Obl,:Nmk,:Adr,:Okpo, 
												          :Sour_on,:Type_on,:Date_on,:Name_on,
												          :Sour_off,:Date_off,:Name_off,
												          :V_sank,:Sank,:Sank_on,:Sank_off,
												          :Benef,:Kv,:Debt_sum,:Country,:Rec_dat
												     FROM " || Left(strFileIn, Len(strFileIn)-4))
										While SqlFetchNext( hSqlA, nFetchRes )
											Set Ek_pok = SalStrTrimX(StrDosToWinX(Ek_pok))
											Set Ko = SalStrTrimX(StrDosToWinX(Ko))
											Set Mfo = SalStrTrimX(StrDosToWinX(Mfo))
											Set Ku = SalStrTrimX(StrDosToWinX(Ku))
											Set Obl = SalStrTrimX(StrDosToWinX(Obl))
											Set Nmk = SalStrTrimX(StrDosToWinX(Nmk))
											Set Adr = SalStrTrimX(StrDosToWinX(Adr))
											Set Okpo = SalStrTrimX(StrDosToWinX(Okpo))
											Set Sour_on = SalStrTrimX(StrDosToWinX(Sour_on))
											Set Type_on = SalStrTrimX(StrDosToWinX(Type_on))
											Set Name_on = SalStrTrimX(StrDosToWinX(Name_on))
											Set Sour_off = SalStrTrimX(StrDosToWinX(Sour_off))
											Set Name_off = SalStrTrimX(StrDosToWinX(Name_off))
											Set Sank = SalStrTrimX(StrDosToWinX(Sank))
											Set Benef = SalStrTrimX(StrDosToWinX(Benef))
											!
											Set Okpo = SalStrRightX( '00000000'||Okpo, 8)
											If SqlPrepareAndExecute( hSql(), 
													   "SELECT max(rnk) INTO :Rnk 
													      FROM customer 
													     WHERE date_off IS NULL AND okpo=:Okpo" )
												Call SqlFetchNext( hSql(), nFetchRes )
												If Rnk != NUMBER_Null
													If SqlPrepareAndExecute( hSql(), 
															   "SELECT nd INTO :Nd 
															      FROM customer 
															     WHERE rnk=:Rnk" )
														Call SqlFetchNext( hSql(), nFetchRes )
											!
											If SqlPrepareAndExecute( hSql(),
													   "INSERT INTO f98
													      (np, dat, ek_pok, ko, mfo, ku, 
													       rnk, rezid, obl, nmk, adr, okpo, nd, 
													       sour_on, type_on, date_on, name_on,
													       sour_off, date_off, name_off,
													       v_sank, sank, sank_on, sank_off,
													       benef, kv, debt_sum, country, rec_dat)
													    VALUES
													      (:Np,:Dat,:Ek_pok,:Ko,:Mfo,:Ku,
													       :Rnk,:Rezid,:Obl,:Nmk,:Adr,:Okpo,:Nd, 
													       :Sour_on,:Type_on,:Date_on,:Name_on,
													       :Sour_off,:Date_off,:Name_off,
													       :V_sank,:Sank,:Sank_on,:Sank_off,
													       :Benef,:Kv,:Debt_sum,:Country,:Rec_dat)")
										Call SalMessageBox( 'База успешно обновлена!', 'Внимание', MB_IconInformation )
										Call SqlCommit( hSql() )
									Call SqlDisconnect(hSqlA)
									!
									Call SalSendMsg( F98, UM_Populate, 0, 0 )
									Call SalWaitCursor( FALSE )
								Else
									Call MessageAttention('Ошибка подсоединения к Базе данных: ' ||SqlDatabase)
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
					Resource Id: 12581
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
					Resource Id: 12582
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
			Column: NP
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: №
						пери-
						ода
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
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
			Column: DAT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: 
						Дата
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.0"
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
			Column: EK_POK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Эк.
						пока-
						затель
				Visible? Yes
				Editable? No
				Maximum Data Length: 5
				Data Type: String
				Justify: Right
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
			Column: KO
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: 
						Код
						обл.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
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
			Column: MFO
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: 
						МФО
						банка
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
				Width:  0.867"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: KU
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: 
						Код
						упр.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
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
			Column: REZID
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Санкц.
						рез(1)
						нерез(2)
				Visible? Yes
				Editable? No
				Maximum Data Length: 1
				Data Type: Number
				Justify: Center
				Width:  0.85"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: RNK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Регистр.
						№
						клиента
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  0.933"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: ND
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: №
						договора
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
			Column: NMK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Наименование
						предприятия-
						резидента
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.5"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Title: Адрес
						предприятия-
						резидента
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.917"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Title: Код ОКПО
						предприятия-
						резидента
				Visible? Yes
				Editable? No
				Maximum Data Length: 10
				Data Type: String
				Justify: Right
				Width:  1.267"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: OBL
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						обл.
						резид.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
				Width:  0.667"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: BENEF
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Наименование
						иностранного
						партнера
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.5"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: COUNTRY
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Страна
						иностранного
						партнера
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
			Column: KV
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						вал
						ISO
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
				Data Type: String
				Justify: Center
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
			Column: SUM
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: 
						Сумма
						долга
				Visible? Yes
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
			!
			Column: SOUR_ON
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Инициатор
						введения
						санкции
				Visible? Yes
				Editable? No
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
			Column: TYPE_ON
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: 
						Тип
						приказа
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
			Column: DATE_ON
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						приказа о
						введении
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.0"
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
			Column: NAME_ON
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: № 
						приказа
						о введении
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.18"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: SOUR_OFF
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Инициатор
						отмены
						санкции
				Visible? Yes
				Editable? No
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
			Column: DATE_OFF
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата 
						приказа 
						об отмене
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.0"
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
			Column: NAME_OFF
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: № 
						приказа 
						об отмене
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.18"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: V_SANK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Флаг 
						1-введ
						2-отме
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Center
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
			Column: SANK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Вид
						санк-
						ции
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  0.633"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: SANK_ON
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Начало
						действия
						санкции
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.0"
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
			Column: SANK_OFF
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Окончание
						действия
						санкции
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.0"
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
			Column: REC_DAT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						записи 
						в БД
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.0"
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
			Number: nPar
			String: sPar01
			String: sPar02
		Window Variables
			Number: nFetchRes
			Number: nEIK_ND
			!
			String: strFilters[*]
			Number: nIndex
			String: strFileIn
			String: strPathIn
			Sql Handle: hSqlA
			!
			Number: Np
			Date/Time: Dat
			String: Ek_pok
			String: Ko
			String: Mfo
			String: Ku
			Number: Rnk
			Number: Rezid
			String: Obl
			String: Nmk
			String: Adr
			String: Okpo
			String: Nd
			String: Sour_on
			String: Name_on
			String: Type_on
			Date/Time: Date_on
			String: Sour_off
			Date/Time: Date_off
			String: Name_off
			String: V_sank
			String: Sank
			Date/Time: Sank_on
			Date/Time: Sank_off
			String: Benef
			Number: Kv
			Number: Debt_sum
			Number: Country
			Date/Time: Rec_dat
		Message Actions
			On SAM_Create
				Call SalWaitCursor( TRUE )
				Call PrepareWindow( hWndForm )
				Call SetWindowFullSize( hWndForm )
				Set F98.nTabInstance = 1
				Set F98.fFilterAtStart = TRUE
				Set F98.strPrintFileName = 'F98'
				Set F98.strFilterTblName = 'F98'
				Set strFilters[0]='Список файлов F98*.*'
				Set strFilters[1]='F98_1.DBF'
				!
				! Показ поля "Номер договора с клиентом"
				If SqlPrepareAndExecute( hSql(), 
						   "SELECT nvl(to_number(val),0) 
						      INTO :nEIK_ND 
						      FROM birja 
						     WHERE par='EIK_ND'") 
						AND NOT SqlFetchNext( hSql(), nFetchRes )
					Set nEIK_ND = 0
				If nEIK_ND = 0  
					Call SalHideWindow( ND )
				Else
					Call SalShowWindow( ND )
				!
				Call SalDisableWindow( pbIns )
				Call SalDisableWindow( pbDel )
				Call SalDisableWindow( pbUpdate )
				Set F98.strSqlPopulate = 
						   "SELECT f98.np, f98.dat, f98.ek_pok, f98.ko, f98.mfo, f98.ku, 
						           f98.rnk, f98.rezid, f98.obl, f98.nmk, f98.adr, f98.okpo, f98.nd,
						           f98.sour_on, f98.type_on, f98.date_on, f98.name_on, 
						           f98.sour_off, f98.date_off, f98.name_off,
						           f98.v_sank, f98.sank, f98.sank_on, f98.sank_off,  
						           f98.benef, nvl(t.lcv,f98.kv), f98.debt_sum/100, c.name, f98.rec_dat      
						      INTO :F98.NP,:F98.DAT,:F98.EK_POK,:F98.KO,:F98.MFO,:F98.KU,
						           :F98.RNK,:F98.REZID,:F98.OBL,:F98.NMK,:F98.ADR,:F98.OKPO,:F98.ND,
						           :F98.SOUR_ON,:F98.TYPE_ON,:F98.DATE_ON,:F98.NAME_ON, 
						           :F98.SOUR_OFF,:F98.DATE_OFF,:F98.NAME_OFF,
						           :F98.V_SANK,:F98.SANK,:F98.SANK_ON,:F98.SANK_OFF,  
						           :F98.BENEF,:F98.KV,:F98.SUM,:F98.COUNTRY,:F98.REC_DAT
						      FROM f98, tabval t, country c
						     WHERE f98.kv = t.kv(+) AND f98.country = c.country(+)
						     ORDER BY f98.dat, f98.np"
				!
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On SAM_FetchRowDone
				If NOT SalIsNull( F98.RNK  )
					Call SetTblRowColor( F98, COLOR_Marigold )
				If F98.V_SANK = 2
					Call XSalTblSetRowBackColor( F98, lParam, COLOR_Sky )
			On UM_Populate
				If fFilterAtStart
					Set fFilterAtStart = NOT fFilterAtStart
					If NOT SetQueryFilter( cF )
						Call SalDestroyWindow( hWndForm )
				Call SalWaitCursor(TRUE)
				Call SalTblDefineSplitWindow(hWndForm, 0, FALSE)
				Set strDSql = cQ.GetFullSQLString(cF)
				Call BindList.ActivateBinds()
				Call SalTblPopulate(hWndForm, cMain.hSql(), T(strDSql), TBL_FillAllBackground)
				Call SalTblSetContext(hWndForm, 0)
				Call SalWaitCursor(FALSE)
			On SAM_Destroy
				Set hWndF98 = hWndNULL
				Call SalSendClassMessage( SAM_Destroy, 0, 0 )
	Table Window: Tbl_License
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
				Width:  8.0"
				Width Editable? Class Default
				Height: 5.0"
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
					Resource Id: 48540
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
					Resource Id: 48541
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
					Resource Id: 48542
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
				Title:
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
			Column: colLicName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Номер
						лицензии
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 50
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
			Column: colLicDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						лицензии
				Visible? Yes
				Editable? Yes
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
			Column: colDateOn
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Начало
						действия
				Visible? Yes
				Editable? Yes
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
			Column: colDateOff
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Окончание
						действия
				Visible? Yes
				Editable? Yes
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
		Functions
		Window Parameters
			Number: MODE	! 9-ReadOnly
			Number: IDK
		Window Variables
			String: sContractName
		Message Actions
			On SAM_Create
				Call SalCenterWindow(hWndForm)
				If MODE = 9
					Set hWndForm.Tbl_License.nFlags = GT_ReadOnly
				Call SalDisableWindow(pbDetails)
				Set sContractName = GetValueStr("SELECT name FROM top_contracts WHERE pid="||Str(IDK))
				Call SalSetWindowText(hWndForm, 'Лицензии контракта ' || sContractName)
				Set hWndForm.Tbl_License.strSqlPopulate = 
						"SELECT id, licname, licdate, date_on, date_off 
						 INTO :hWndForm.Tbl_License.colId, 
						      :hWndForm.Tbl_License.colLicName, :hWndForm.Tbl_License.colLicDate, 
						      :hWndForm.Tbl_License.colDateOn,  :hWndForm.Tbl_License.colDateOff
						 FROM contracts_licence 
						 WHERE pid=:hWndForm.Tbl_License.IDK"
				Set hWndForm.Tbl_License.strSqlInsert = 
						"INSERT INTO contracts_licence(pid,licname,licdate,date_on,date_off) 
						 VALUES(:hWndForm.Tbl_License.IDK, 
						        :hWndForm.Tbl_License.colLicName, :hWndForm.Tbl_License.colLicDate, 
						        :hWndForm.Tbl_License.colDateOn,  :hWndForm.Tbl_License.colDateOff)"
				Set hWndForm.Tbl_License.strSqlUpdate = 
						"UPDATE contracts_licence 
						 SET licname =:hWndForm.Tbl_License.colLicName, 
						     licdate =:hWndForm.Tbl_License.colLicDate, 
						     date_on =:hWndForm.Tbl_License.colDateOn, 
						     date_off=:hWndForm.Tbl_License.colDateOff 
						 WHERE id=:hWndForm.Tbl_License.colId"
				Set hWndForm.Tbl_License.strSqlDelete = 
						"DELETE FROM contracts_licence
						 WHERE id=:hWndForm.Tbl_License.colId"
				Call SalSendClassMessage(SAM_Create, 0, 0)
