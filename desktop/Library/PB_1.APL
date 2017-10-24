Application Description: _____________ АБС БАРС98
		****************************************************
		* Разработчики: ______________ 	*
		*                     			*
		* (C) Унити-БАРС, 1997-2001      	*
		****************************************************
		История:
		30/11/2001 16:15 - Изменен выбор клиента в форме CASH, Самойленко В.С.
		4/12/2001 0:44 - Добавлено автонаполнение заявок на календарный год в форме CASH, Самойленко В.С.
	Outline Version - 4.0.26
	Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000B30000 002C000000020000 0003000000000000 0082020000FCFFFF
0040: FFE2FFFFFFFFFFFF FF000000007C0200 004D010000010000 0001000000010000
0060: 000F4170706C6963 6174696F6E497465 6D02000000075769 6E646F7773045042
0080: 5F31
.enddata
.data DT_MAKERUNDLG
0000: 020000000016713A 5C6261727339385C 62696E5C50425F31 2E61706418713A5C
0020: 6261727339385C62 696E5C6E65776170 702E646C6C18713A 5C6261727339385C
0040: 62696E5C6E657761 70702E6170630000 01010115433A5C43 454E545552415C6E
0060: 65776170702E7275 6E15433A5C43454E 545552415C6E6577 6170702E646C6C15
0080: 433A5C43454E5455 52415C6E65776170 702E617063000001 0101145C42415253
00A0: 39385C62696E5C70 625F312E61706416 5C4241525339385C 62696E5C6E657761
00C0: 70702E646C6C165C 4241525339385C62 696E5C6E65776170 702E617063000001
00E0: 010115433A5C4345 4E545552415C6E65 776170702E61706C 15433A5C43454E54
0100: 5552415C6E657761 70702E646C6C1543 3A5C43454E545552 415C6E6577617070
0120: 2E61706300000101 01
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
		Reject Multiple Window Instances? Yes
		Enable Runtime Checks Of External References? Yes
		Use Release 4.0 Scope Rules? No
	Libraries
		File Include: Gentbl.apl
		File Include: GentblD.apl
		File Include: Genlist.apl
		File Include: XSALCPT.APL
		File Include: VTTBLWIN.APL
		File Include: XSALIMG.APL
		File Include: Winbars2.apl
		!
		Dynalib: Absapi.apd
		Dynalib: Global.apd
		Dynalib: Custacnt.apd
		Dynalib: Docview.apd
		Dynalib: Bars000.apd
		File Include: Genbutn.apl
		Dynalib: impexp.apd
		!
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
			Number: nFetchRes
			Window Handle: hWinPBF
			Window Handle: hWndSUPK
			Window Handle: hWndEIK
			Window Handle: h10
			Window Handle: h11
			! cABSConnect: connect
.winattr class :
				Class: cABSConnect
.end
			! Sql Handle: hSqlTmp1
			! Sql Handle: hSqlTmp2
			! Sql Handle: hSqlTmp3
			! Window Handle: hWndJ
			! Window Handle: hWndS
			! Window Handle: hWndM
			! Window Handle: hWndT
			! Window Handle: hWndP
			! Window Handle: hR3
			! Number: z1
			! Number: z2
			! Number: z3
			! Number: z4
			! Number: z5
			! Boolean: fzay1
			! Boolean: fzay2
			! Boolean: fzay3
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
			Function: IMP_EX		!__exported
				Description:
				Returns
					Window Handle:
				Parameters
					Window Handle: hW
					Number: nParam
				Static Variables
				Local variables
				Actions
					Select Case nParam
						! Бюджет
						Case 0 !! Доп реквизиты для задачи бюджке-2
							Return SalCreateWindow(BU, hW)
							Break
						Case 10 !! Кассовые заявки клиентов
							If not IsWindow(h10)
								Set h10 = SalCreateWindow( CASH, hW )
							Else
								Call SalBringWindowToTop ( CASH )
							Break
						Case 11 !! Кассовые заявки. Итоги
							If not IsWindow(h11)
								Set h11 = SalCreateWindow( CASHI, hW )
							Else
								Call SalBringWindowToTop ( CASHI )
							Break
						! Резерв
							                                        If not IsWindow(hR3)
								                                        Set hR3 = SalCreateWindow( R3, hW)
							                                        Else 
								                                        Call SalBringWindowToTop ( R3 )
							                                        Break 
						Case 20 !! Резерв
							! Return SalCreateWindow( TB_P, hW )
							Break
						Default
							Return hWndNULL
							Break
			Function: PB1			!__exported
				Description:
				Returns
					Window Handle:
				Parameters
					Window Handle: hW
				Static Variables
				Local variables
				Actions
					Return SalCreateWindow(PB_1, hW)
			Function: PBF			!__exported
				Description:
				Returns
					Window Handle:
				Parameters
					Window Handle: hW
				Static Variables
				Local variables
				Actions
					! Return SalCreateWindow(PB_F, hW)
					If not IsWindow(hWinPBF)
						Set hWinPBF = SalCreateWindow(PB_F, hW)
					Else
						Call SalBringWindowToTop(hWinPBF)
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
			Pushbutton: ctb_pbOk
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
	Table Window: BU
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Доп реквизиты для задачи бюджет-2
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
				Left:   0.26"
				Top:    0.292"
				Width:  13.533"
				Width Editable? Class Default
				Height: 6.469"
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
				Location? Top
				Visible? Class Default
				Size: 1.427"
				Size Editable? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
			Contents
				Data Field: REF
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
							Left:   1.986"
							Top:    0.405"
							Width:  1.8"
							Width Editable? Yes
							Height: 0.25"
							Height Editable? Yes
						Visible? Yes
						Border? Yes
						Justify: Left
						Format: #0
						Country: Default
						Font Name: Default
						Font Size: Default
						Font Enhancement: Default
						Text Color: Default
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
				Data Field: TT
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
							Left:   3.786"
							Top:    0.405"
							Width:  0.6"
							Width Editable? Yes
							Height: 0.229"
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
				Data Field: STT
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
							Left:   4.386"
							Top:    0.405"
							Width:  8.3"
							Width Editable? Yes
							Height: 0.229"
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
				Data Field: NLSA
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
							Left:   1.986"
							Top:    0.656"
							Width:  1.8"
							Width Editable? Yes
							Height: 0.229"
							Height Editable? Yes
						Visible? Yes
						Border? Yes
						Justify: Left
						Format: Unformatted
						Country: Default
						Font Name: Default
						Font Size: 8
						Font Enhancement: Default
						Text Color: Default
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
				Data Field: KVA
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
							Left:   3.786"
							Top:    0.656"
							Width:  0.6"
							Width Editable? Yes
							Height: 0.229"
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
				Data Field: NAMA
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
							Left:   4.386"
							Top:    0.656"
							Width:  8.3"
							Width Editable? Yes
							Height: 0.229"
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
				Data Field: NLSB
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
							Left:   1.986"
							Top:    0.906"
							Width:  1.8"
							Width Editable? Yes
							Height: 0.229"
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
				Data Field: KVB
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
							Left:   3.786"
							Top:    0.906"
							Width:  0.6"
							Width Editable? Yes
							Height: 0.229"
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
				Data Field: NAMB
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
							Left:   4.386"
							Top:    0.906"
							Width:  8.3"
							Width Editable? Yes
							Height: 0.229"
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
				Data Field: NAZN
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
							Left:   1.986"
							Top:    1.156"
							Width:  10.7"
							Width Editable? Yes
							Height: 0.229"
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
				Pushbutton: pbIns
					Class Child Ref Key: 33
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.083"
						Top:    -0.012"
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
						Left:   0.517"
						Top:    -0.012"
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
						Left:   1.483"
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
						Left:   4.986"
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
							Set i = TBL_MinRow
							While SalTblFindNextRow(hWndForm, i, 0,0 )
								Call SalTblFetchRow(hWndForm, i )
								If BU.colB=2 
									If SqlPrepareAndExecute( hSqlAux2(),
											 "UPDATE operw SET value=:BU.KEKB WHERE ref=:BU.colREF AND tag='BU2' ")
										! Call SqlCommit( hSqlAux2())
								If BU.colB=3 
									If SqlPrepareAndExecute( hSqlAux2(),
											 "INSERT INTO operw (ref,tag,value) 
											  VALUES ("||Str(BU.colREF)||",'BU2',"||Str(BU.KEKB)||")")
										! Call SqlCommit( hSqlAux2() )
								If BU.colG=2 
									If SqlPrepareAndExecute( hSqlAux2(),
											 "UPDATE operw SET value=:BU.IDP WHERE ref=:BU.colREF AND tag='BU1' ")
										! Call SqlCommit( hSqlAux2())
								If BU.colG=3 
									If SqlPrepareAndExecute( hSqlAux2(),
											"INSERT INTO operw (ref,tag,value) 
											 VALUES ("||Str(BU.colREF)||",'BU1',"||Str(BU.IDP)||")")
										! Call SqlCommit( hSqlAux2() )
							Call SqlCommit( hSqlAux2() )
							Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
				Line
					Resource Id: 40051
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
						Left:   3.986"
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
						Left:   7.367"
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
						On SAM_Create
							Set strTip = 'Оригинал документа ...'
						On SAM_Click
							If SalTblAnyRows( hWndForm, ROW_Selected, 0 )
								Call DocViewContentsEx(hWndMDI, BU.colREF)
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   10.183"
						Top:    0.821"
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
					Resource Id: 40052
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
						Left:   5.483"
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
					Resource Id: 40053
					Class Child Ref Key: 43
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  1.95"
						Begin Y:  -0.024"
						End X:  1.95"
						End Y:  0.44"
					Visible? No
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Data Field: dDATA
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
							Left:   0.083"
							Top:    0.071"
							Width:  1.4"
							Width Editable? Yes
							Height: 0.321"
							Height Editable? Yes
						Visible? Yes
						Border? Yes
						Justify: Left
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
							Set sdat=SalFmtFormatDateTime( dDATA,'MM-dd-yyyy' )
							Call SalSendMsg( pbRefresh, SAM_Click,0, 0 )
				Pushbutton: pbDEB
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cTBarButton
					Property Template:
					Class DLL Name:
					Title: D
					Window Location and Size
						Left:   1.986"
						Top:    0.071"
						Width:  0.5"
						Width Editable? Yes
						Height: 0.321"
						Height Editable? Yes
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: Default
					Font Size: 12
					Font Enhancement: Bold-Underline
					Picture File Name:
					Picture Transparent Color: None
					Image Style: Single
					Text Color: Dark Red
					Background Color: Default
					Message Actions
						On SAM_Create
							Set strTip = 'Только ДЕБЕТ '
						On SAM_Click
							Call SalDisableWindow( pbDEB )
							Set nD0=0
							Set nD1=0
							Call SalEnableWindow( pbALL )
							Call SalEnableWindow( pbKRD )
							Set tolko=strTip
							Call SalSendMsg( pbRefresh, SAM_Click,0, 0 )
				Pushbutton: pbALL
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cTBarButton
					Property Template:
					Class DLL Name:
					Title: D+C
					Window Location and Size
						Left:   2.567"
						Top:    0.083"
						Width:  0.7"
						Width Editable? Class Default
						Height: 0.321"
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: 12
					Font Enhancement: Bold-Underline
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'ВСЕ документы' 
						On SAM_Click
							Call SalDisableWindow( pbALL )
							Set nD0=0
							Set nD1=1
							Call SalEnableWindow( pbDEB )
							Call SalEnableWindow( pbKRD )
							Set tolko=strTip
							Call SalSendMsg( pbRefresh, SAM_Click,0, 0 )
				Pushbutton: pbKRD
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cTBarButton
					Property Template:
					Class DLL Name:
					Title: C
					Window Location and Size
						Left:   3.386"
						Top:    0.071"
						Width:  0.5"
						Width Editable? Class Default
						Height: 0.321"
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: 12
					Font Enhancement: Bold-Underline
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Blue
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Только КРЕДИТ' 
						On SAM_Click
							Call SalDisableWindow( pbKRD )
							Set nD0=1
							Set nD1=1
							Call SalEnableWindow( pbALL )
							Call SalEnableWindow( pbDEB )
							Set tolko=strTip
							Call SalSendMsg( pbRefresh, SAM_Click,0, 0 )
				Data Field: tolko
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
							Left:   7.886"
							Top:    0.071"
							Width:  3.4"
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
				Pushbutton: pbFilter
					Class Child Ref Key: 44
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.486"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Background Text: Референс
					Resource Id: 40054
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   0.886"
						Top:    0.427"
						Width:  1.1"
						Width Editable? Yes
						Height: 0.229"
						Height Editable? Yes
					Visible? Yes
					Justify: Right
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
				Background Text: Счет А
					Resource Id: 40055
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   1.286"
						Top:    0.677"
						Width:  0.7"
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
				Background Text: Счет Б
					Resource Id: 40056
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   1.286"
						Top:    0.927"
						Width:  0.714"
						Width Editable? Yes
						Height: 0.229"
						Height Editable? Yes
					Visible? Yes
					Justify: Left
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
				Background Text: Назнач.
					Resource Id: 40057
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   1.186"
						Top:    1.177"
						Width:  0.829"
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
		Contents
			Column: colNLS
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ЛицСчет
				Visible? Yes
				Editable? No
				Maximum Data Length: 14
				Data Type: String
				Justify: Left
				Width:  1.557"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Class:
				Property Template:
				Class DLL Name:
				Title: № докум
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
			Column: colS
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сумма
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.314"
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
			Column: cKEKB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: С
						О
				Visible? Yes
				Editable? No
				Maximum Data Length: 1
				Data Type: String
				Justify: Left
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
			Column: KEKB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Символ
				Visible? Yes
				Editable? No
				Maximum Data Length: 6
				Data Type: Number
				Justify: Right
				Width:  0.814"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
					! On SAM_Validate
						                                        If SqlPrepareAndExecute( hSqlAux(),
								"SELECT kekb INTO :sKEKB FROM bu2 
								 WHERE kekb=:KEKB and mod(kekb,100)>0" ) and 
								not SqlFetchNext( hSqlAux(), nI )
							                                        Call Debug('Ош.код')
							                                        Set KEKB=NUMBER_Null
							                                        Return VALIDATE_Ok
						                                        Set colB=FLAGI(colB)
						                                        Return VALIDATE_Ok
			Column: sKEKB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Наименование
						 символа
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.414"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Drop Down List
					Multiline Cell? No
					Cell DropDownList
						Sorted? No
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? No
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
					On SAM_Create
						! If SqlPrepareAndExecute(hSql(), " 
								SELECT kekb,name INTO :nD,:sD FROM bu2 WHERE mod(kekb,100)>0 ORDER by 1")
							                                        Set i=0
							                                        Call SalArraySetUpperBound(mB, 1, -1)
							                                        Call SalListClear(hWndItem)
							                                        While SqlFetchNext(hSql(), nI)
								                                        Call SalListAdd(hWndItem, sD)
								                                        Set mB[i]=nD
								                                        Set i=i+1
					On SAM_Validate
						!
						Set i = SalListQuerySelection(hWndItem)
						Set KEKB = IifN(i>=0, mB[i], 0)
						Set colB=FLAGI(colB)
						Return VALIDATE_Ok
			Column: cIDP
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: С
						О
				Visible? Yes
				Editable? No
				Maximum Data Length: 1
				Data Type: String
				Justify: Left
				Width:  0.271"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
						ЦП
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
				Data Type: Number
				Justify: Right
				Width:  0.571"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
					! On SAM_Validate
						                                        If SqlPrepareAndExecute( hSqlAux(),
								"SELECT name  INTO :sIDP FROM bu1 WHERE id = :IDP " )
								and not SqlFetchNext( hSqlAux(), nI )
							                                        Call Debug('Ош.код')
							                                        Set IDP=NUMBER_Null
							                                        Return VALIDATE_Ok
						                                        Set colG=FLAGI(colG)
						                                        Return VALIDATE_Ok
			Column: sIDP
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Наименование 
						Центра Прибыли
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.957"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Drop Down List
					Multiline Cell? No
					Cell DropDownList
						Sorted? No
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? No
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
					On SAM_Create
						! If SqlPrepareAndExecute(hSql(), T(" 
								SELECT id,name INTO :nD,:sD FROM bu1 ORDER by 1"))
							                                        Set i=0
							                                        Call SalArraySetUpperBound(mG, 1, -1)
							                                        Call SalListClear(hWndItem)
							                                        While SqlFetchNext(hSql(), nI)
								                                        Call SalListAdd(hWndItem, sD)
								                                        Set mG[i]=nD
								                                        Set i=i+1
					On SAM_Validate
						!
						Set i = SalListQuerySelection(hWndItem)
						Set IDP = IifN( i>=0, mG[i], 0)
						Set colG=FLAGI(colG)
						Return VALIDATE_Ok
			!
			Column: colVDAT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						ввода
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Left
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
			Column: colPDAT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						валют.
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Left
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
			Column: colTT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ОП
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.05"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Class:
				Property Template:
				Class DLL Name:
				Title: РЕФ
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  1.05"
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
			Column: colISP
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ISP
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  1.05"
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
			Column: colDK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ДК
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  1.05"
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
			Column: colKVA
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: KVA
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.05"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colKVB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: KVB
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.05"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Class:
				Property Template:
				Class DLL Name:
				Title: NLSA
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.05"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colNAMA
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: NLSA
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.05"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Class:
				Property Template:
				Class DLL Name:
				Title: NLSA
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.05"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colNAMB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: NLSA
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.05"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Class:
				Property Template:
				Class DLL Name:
				Title: NLSA
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.05"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ДК
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  1.05"
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
			Column: colG
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ДК
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  1.05"
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
				Width:  1.05"
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
			Function: FLAGI
				Description:
				Returns
					Number: FLAG
				Parameters
					Number: FLAG1
				Static Variables
				Local variables
					Number: FLAG2
				Actions
					If FLAG1=NUMBER_Null !! вставка
						Set FLAG2=3
					Else If FLAG1=1 !! обновление
						Set FLAG2=2
					Else !! сохранить состояние флага
						Set FLAG2=FLAG1
					Return FLAG2
		Window Parameters
		Window Variables
			Number: nKV
			Number: nD0
			Number: nD1
			Number: nD
			String: sD
			String: ss1
			String: fs
			String: sdat
			Number: nI
			Number: i
			Number: mG[*]
			Number: mB[*]
		Message Actions
			On SAM_Create
				Call SalTblSetLockedColumns( hWndForm, 3)
				! Call SalSetWindowText( hWndForm, '1_ПБ: Дополнительные реквизиты' )
				!
				Call BU.cF.Init( 'Accounts', 'a' )
				!
				Set nKV=GetBaseVal()
				Set dDATA=GetBankDate()
				Set sdat=SalFmtFormatDateTime( dDATA,'MM-dd-yyyy' )
				Call SalMapEnterToTab(TRUE)
				Call SalCenterWindow( hWndForm )
				Set nD0=0
				Set nD1=1
				Call SalDisableWindow( pbALL )
				Call SalEnableWindow( pbDEB )
				Call SalEnableWindow( pbKRD )
				Set tolko="Документы дня"
			On SAM_FetchRowDone 
				If SqlPrepareAndExecute( hSql(),
						   "SELECT o.acc, o.nls, b1.id, b1.name, b2.kekb, b2.name 
						    INTO :colAcc, :colNLS,:IDP,:sIDP,:KEKB,:sKEKB 
						    FROM opl o, bu_acc b , bu1 b1,bu2 b2
						    WHERE o.ref=:colREF AND o.acc=b.acc AND 
						          b.idp=b1.id AND b.kekb=b2.kekb" )
					If SqlFetchNext( hSql(), nI )
						Set cKEKB='с'
						Set cIDP ='с'
				!
				If SqlPrepareAndExecute( hSql(),
						  "SELECT to_number(w.value), b.name, 1 
						   INTO :IDP, :sIDP, :colG  FROM operw w, bu1 b 
						   WHERE w.ref=:colREF AND w.tag='BU1' AND to_number(w.value)=b.id" )
					If SqlFetchNext( hSql(), nI )
						Set cIDP ='О'
				!
				If SqlPrepareAndExecute( hSql(),
						   "SELECT to_number(w.value), b.name , 1 
						    INTO :KEKB, :sKEKB, :colB FROM operw w, bu2 b 
						    WHERE  w.ref=:colREF AND w.tag='BU2' AND 
						       to_number(w.value) = b.kekb")
					If SqlFetchNext( hSql(), nI )
						Set cKEKB='О'
				!
			On UM_Update 
			On UM_Populate 
				Call SalWaitCursor( TRUE )
				Set fs = cF.GetFilterWhereClause( FALSE )
				Set BU.strSqlPopulate =
						"SELECT nd,tt,ref, kv,kv2,dk,s,nlsa,nam_a,nlsb,nam_b,nazn
						 INTO :BU.colND,  :BU.colTT,  :BU.colREF,:BU.colKVA,
						      :BU.colKVB, :BU.colDK,  :BU.colS,  :BU.colNLSA,:BU.colNAMA,
						      :BU.colNLSB,:BU.colNAMB,:BU.colNAZN   
						 FROM oper  WHERE ref in 
						(select p.ref 
						 from accounts a, opldok p, bu_acc b
						 where "||IifS(fs !="",fs||" and ","")||
						       "a.acc=p.acc AND p.sos=5 AND a.acc=b.acc AND p.fdat= :sdat )"  
				Set ss1=''
				If nD0+nD1=0 !! только дебет
					Set ss1=" and p.dk=0"
				Else If nD0+nD1=2  !! толькл кредит
					Set ss1=" and p.dk=1"
				If nD0+nD1>0  !! +ARC_RRP
				Call SalTblPopulate( hWndForm, hSqlAux(), T(BU.strSqlPopulate ||" ORDER BY 3"),0 )
				Call SalTblSetContext( hWndForm, 0 )
				Call SalTblSetRowFlags( hWndForm, 0, ROW_Selected, TRUE )
				Call SalSendMsg( hWndForm, SAM_TblDoDetails, 0,0)
				Call SalWaitCursor( FALSE )
			On SAM_TblDoDetails
				Set REF=colREF 
				Set TT=colTT
				If SqlPrepareAndExecute( hSqlAux(),"SELECT t.name INTO :STT FROM tts t WHERE tt=:colTT ") 
					If SqlFetchNext( hSqlAux(), nI )
						Set NLSA=colNLSA
						Set KVA=colKVA
						Set NAMA=colNAMA
						Set NLSB=colNLSB
						Set KVB=colKVB
						Set NAMB=colNAMB
						Set NAZN=colNAZN
				!
				If SqlPrepareAndExecute(hSqlAux(),
						"SELECT b.kekb,b.name INTO :nD,:sD FROM bu2 b, bu_acc a
						 WHERE a.acc=:colAcc and a.kekb=b.kekb AND mod(b.kekb,100)>0 
						 GROUP BY  b.kekb,b.name ORDER by 1")
					Set i=0
					Call SalArraySetUpperBound(mB, 1, -1)
					Call SalListClear(sKEKB)
					While SqlFetchNext(hSqlAux(), nI)
						Call SalListAdd(sKEKB, sD)
						Set mB[i]=nD
						Set i=i+1
				!
				If SqlPrepareAndExecute(hSqlAux(), 
						"SELECT b.id,b.name INTO :nD,:sD FROM bu1 b, bu_acc a 
						 WHERE a.acc=:colAcc and a.idp=b.id 
						 GROUP BY  b.id,b.name ORDER by 1")
					Set i=0
					Call SalArraySetUpperBound(mG, 1, -1)
					Call SalListClear(sIDP)
					While SqlFetchNext(hSqlAux(), nI)
						Call SalListAdd(sIDP, sD)
						Set mG[i]=nD
						Set i=i+1
	Table Window: PB_1
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
				Left:   0.62"
				Top:    0.3"
				Width:  17.15"
				Width Editable? Class Default
				Height: 6.469"
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
			Maximum Rows in Memory: 32000
			Discardable? Class Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Top
				Visible? Class Default
				Size: 1.458"
				Size Editable? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
			Contents
				Data Field: REF
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
							Left:   1.986"
							Top:    0.405"
							Width:  1.8"
							Width Editable? Yes
							Height: 0.25"
							Height Editable? Yes
						Visible? Yes
						Border? Yes
						Justify: Left
						Format: #0
						Country: Default
						Font Name: Default
						Font Size: Default
						Font Enhancement: Default
						Text Color: Default
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
				Data Field: TT
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
							Left:   3.786"
							Top:    0.405"
							Width:  0.6"
							Width Editable? Yes
							Height: 0.229"
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
				Data Field: STT
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
							Left:   4.386"
							Top:    0.427"
							Width:  8.3"
							Width Editable? Yes
							Height: 0.229"
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
				Data Field: NLSA
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
							Left:   1.986"
							Top:    0.656"
							Width:  1.8"
							Width Editable? Yes
							Height: 0.229"
							Height Editable? Yes
						Visible? Yes
						Border? Yes
						Justify: Left
						Format: Unformatted
						Country: Default
						Font Name: Default
						Font Size: 8
						Font Enhancement: Default
						Text Color: Default
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
				Data Field: KVA
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
							Left:   3.786"
							Top:    0.656"
							Width:  0.6"
							Width Editable? Yes
							Height: 0.229"
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
				Data Field: NAMA
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
							Left:   4.386"
							Top:    0.656"
							Width:  8.3"
							Width Editable? Yes
							Height: 0.229"
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
				Data Field: NLSB
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
							Left:   1.986"
							Top:    0.906"
							Width:  1.8"
							Width Editable? Yes
							Height: 0.229"
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
				Data Field: KVB
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
							Left:   3.786"
							Top:    0.906"
							Width:  0.6"
							Width Editable? Yes
							Height: 0.229"
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
				Data Field: NAMB
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
							Left:   4.386"
							Top:    0.906"
							Width:  8.3"
							Width Editable? Yes
							Height: 0.229"
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
				Data Field: NAZN
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
							Left:   1.986"
							Top:    1.146"
							Width:  10.714"
							Width Editable? Yes
							Height: 0.229"
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
				Pushbutton: pbIns
					Class Child Ref Key: 33
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.083"
						Top:    -0.012"
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
						Left:   0.517"
						Top:    -0.012"
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
						Left:   1.483"
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
						Left:   4.986"
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
					Resource Id: 31502
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
						Left:   3.986"
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
						Left:   7.367"
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
						On SAM_Create
							Set strTip = 'Оригинал документа ...'
						On SAM_Click
							If SalTblAnyRows( hWndForm, ROW_Selected, 0 )
								Call DocViewContentsEx(hWndMDI, PB_1.colREF)
								! If PB_1.colREC>0 !! Просмотр реквизитов документа СЭП
									 Call DocViewContents(hWndMDI, PB_1.colREC)
								! Else !! Просмотр реквизитов внутреннего документа
									 Call DocViewContentsEx(hWndMDI, PB_1.colREF)
				Pushbutton: pbPrint
					Class Child Ref Key: 40
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   10.183"
						Top:    0.821"
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
					Resource Id: 31503
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
						Left:   5.483"
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
					Resource Id: 31504
					Class Child Ref Key: 43
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  1.95"
						Begin Y:  -0.024"
						End X:  1.95"
						End Y:  0.44"
					Visible? No
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Data Field: dDATA
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
							Left:   0.083"
							Top:    0.071"
							Width:  1.4"
							Width Editable? Yes
							Height: 0.321"
							Height Editable? Yes
						Visible? Yes
						Border? Yes
						Justify: Left
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
							Set sdat=SalFmtFormatDateTime( dDATA,'MM-dd-yyyy' )
							If SqlPrepareAndExecute( hSql(),
									  "SELECT val INTO :sTmp FROM params WHERE par ='D_POROG' " )
									and not SqlFetchNext( hSql(), nFetchRes )
								Set sTmp ='840,5000000'
							If SqlPrepareAndExecute( hSql(),
									  "SELECT gl.p_icurval(" || sTmp ||",:dDATA ) INTO :nPorog  FROM dual" )
									and SqlFetchNext( hSql(), nFetchRes )
							! Call DebugN(nPorog)
							! Call SalSendMsg( pbRefresh, SAM_Click,0, 0 )
						On SAM_Create
							Call SalSendMsg( dDATA, SAM_Validate, 0, 0 )
				Pushbutton: pbDEB
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cTBarButton
					Property Template:
					Class DLL Name:
					Title: D
					Window Location and Size
						Left:   1.986"
						Top:    0.071"
						Width:  0.5"
						Width Editable? Yes
						Height: 0.321"
						Height Editable? Yes
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: Default
					Font Size: 12
					Font Enhancement: Bold-Underline
					Picture File Name:
					Picture Transparent Color: None
					Image Style: Single
					Text Color: Dark Red
					Background Color: Default
					Message Actions
						On SAM_Create
							Set strTip = 'Только ДЕБЕТ '
						On SAM_Click
							Call SalDisableWindow( pbDEB )
							Set nD0=0
							Set nD1=0
							Call SalEnableWindow( pbALL )
							Call SalEnableWindow( pbKRD )
							Set tolko=strTip
							Call SalSendMsg( pbRefresh, SAM_Click,0, 0 )
				Pushbutton: pbALL
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cTBarButton
					Property Template:
					Class DLL Name:
					Title: D+C
					Window Location and Size
						Left:   2.567"
						Top:    0.083"
						Width:  0.7"
						Width Editable? Class Default
						Height: 0.321"
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: 12
					Font Enhancement: Bold-Underline
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'ВСЕ документы' 
						On SAM_Click
							Call SalDisableWindow( pbALL )
							Set nD0=0
							Set nD1=1
							Call SalEnableWindow( pbDEB )
							Call SalEnableWindow( pbKRD )
							Set tolko=strTip
							Call SalSendMsg( pbRefresh, SAM_Click,0, 0 )
				Pushbutton: pbKRD
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cTBarButton
					Property Template:
					Class DLL Name:
					Title: C
					Window Location and Size
						Left:   3.386"
						Top:    0.071"
						Width:  0.5"
						Width Editable? Class Default
						Height: 0.321"
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: 12
					Font Enhancement: Bold-Underline
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Blue
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Только КРЕДИТ' 
						On SAM_Click
							Call SalDisableWindow( pbKRD )
							Set nD0=1
							Set nD1=1
							Call SalEnableWindow( pbALL )
							Call SalEnableWindow( pbDEB )
							Set tolko=strTip
							Call SalSendMsg( pbRefresh, SAM_Click,0, 0 )
				Data Field: tolko
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
							Left:   7.886"
							Top:    0.071"
							Width:  3.4"
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
				Pushbutton: pbFilter
					Class Child Ref Key: 44
					Class ChildKey: 0
					Class: cGenericTable
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.486"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Background Text: Референс
					Resource Id: 58063
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   0.886"
						Top:    0.427"
						Width:  1.1"
						Width Editable? Yes
						Height: 0.229"
						Height Editable? Yes
					Visible? Yes
					Justify: Right
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
				Background Text: Счет А
					Resource Id: 58060
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   1.286"
						Top:    0.677"
						Width:  0.7"
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
				Background Text: Счет Б
					Resource Id: 58062
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   1.286"
						Top:    0.927"
						Width:  0.714"
						Width Editable? Yes
						Height: 0.229"
						Height Editable? Yes
					Visible? Yes
					Justify: Left
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
				Background Text: Назнач.
					Resource Id: 58061
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   1.186"
						Top:    1.177"
						Width:  0.829"
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
		Contents
			Column: colNls
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ЛС
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
			Column: colKv
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Вал
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
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
			Column: col_DC
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Д
						К
				Visible? Yes
				Editable? No
				Maximum Data Length: 1
				Data Type: String
				Justify: Left
				Width:  0.271"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Class:
				Property Template:
				Class DLL Name:
				Title: №док
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.05"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Title: Сумма
						проводки
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
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
			!
			Column: colKOD_N
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						НП
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 7
				Data Type: String
				Justify: Center
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
					! On SAM_Validate
						! If SqlPrepareAndExecute(hSqlAux(), "
								   SELECT transdesc, KIND
								   INTO   :colTEX_N, :col_DC1
								   FROM   bopcode
								   WHERE  transcode=:colKOD_N") and not SqlFetchNext(hSqlAux(), nFetchRes)
							     Call Debug('Ош.код')
							! Set colKOD_N = STRING_Null
							 Return VALIDATE_Ok
						 Set colN = FLAGI(colN)
						 Return VALIDATE_Ok
					On SAM_AnyEdit
						If SalStrLength(colKOD_N) >= 4
							If SalListSelectString(colTEX_N, 0, colKOD_N) = LB_Err
								If SalListSelectString(colTEX_N, 0, Left(colKOD_N, 4)) = LB_Err
									Set colTEX_N = STRING_Null
							! Else
								 Set colN=FLAGI(colN)
					On SAM_Validate
						If colKOD_N = STRING_Null
							Set colTEX_N = STRING_Null
						! Call SaveInfoToLog('colKOD_N = ' || colKOD_N)
						! Call SaveInfoToLog('colTEX_N = ' || colTEX_N)
			Column: colTEX_N
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: НАЗНАЧЕНИЕ платежа
						Текст
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.129"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Drop Down List
					Multiline Cell? No
					Cell DropDownList
						Sorted? No
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? No
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
					On SAM_Create
						If SqlPrepareAndExecute(hSql(), " 
								   SELECT transcode, transcode||'/'||transdesc
								   INTO   :nD, :sD
								   FROM   bopcode
								   ORDER by transcode")
							! Set i=0
							! Call SalArraySetUpperBound(mN, 1, -1)
							Call SalListClear(hWndItem)
							While SqlFetchNext(hSql(), nFetchRes)
								Call SalListAdd(hWndItem, sD)
								! Set mN[i]=nD
								! Set i=i+1
					On SAM_Validate
						If colTEX_N != STRING_Null
							Set colKOD_N = Left(colTEX_N, 7)
							Set colTEX_N = Right(colTEX_N, Len(colTEX_N)-8)
							! Set colN = FLAGI(colN)
			Column: col_DC1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: D
						C
				Visible? Yes
				Editable? No
				Maximum Data Length: 1
				Data Type: String
				Justify: Left
				Width:  0.243"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
			Column: colKOD_G
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						ГБ
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 3
				Data Type: String
				Justify: Right
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
					On SAM_Validate
						Set colKOD_G = SalStrUpperX(colKOD_G)
						! If SqlPrepareAndExecute( hSqlAux(), "
								   SELECT country
								   INTO   :colTEX_G
								   FROM   bopcount
								   WHERE  ISO_COUNTR=:colKOD_G")
							     If not SqlFetchNext(hSqlAux(), nFetchRes) and SqlPrepareAndExecute(hSqlAux(), "
									   SELECT country
									   INTO   :colTEX_G
									   FROM   bopcount
									   WHERE  KODC=:colKOD_G") and not SqlFetchNext(hSqlAux(), nFetchRes)
								     Call Debug('Ош.код')
								     Set colKOD_G = STRING_Null
								     Return VALIDATE_Ok
						! If SqlPrepareAndExecute( hSqlAux(), "
								   SELECT txt
								   INTO   :colTEX_G
								   FROM   kl_k040
								   WHERE  KOD_LIT=:colKOD_G")
						If SqlPrepareAndExecute(hSqlAux(), "
								   SELECT K040||'/'||txt
								   INTO   :colTEX_G
								   FROM   kl_k040
								   WHERE  K040=:colKOD_G")
							If not SqlFetchNext(hSqlAux(), nFetchRes) and SqlPrepareAndExecute(hSqlAux(), "
									   SELECT K040||'/'||txt
									   INTO   :colTEX_G
									   FROM   kl_k040
									   WHERE  KOD_LIT=:colKOD_G") and not SqlFetchNext(hSqlAux(), nFetchRes)
								! Call Debug('Ош.код')
								Call MessageNoWait('Помилковий код!', 'УВАГА!', 17, 1)
								Set colKOD_G = STRING_Null
								Return VALIDATE_Ok
						! Set colG = FLAGI(colG)
						Return VALIDATE_Ok
			Column: colTEX_G
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ГОСУДАРСТВО бенефиц.
						Текст
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.486"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Drop Down List
					Multiline Cell? No
					Cell DropDownList
						Sorted? No
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? No
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
					On SAM_Create
						! If SqlPrepareAndExecute(hSql(), "
								   SELECT ISO_COUNTR, ISO_COUNTR||'/'||country
								   INTO   :s1D, :sD
								   FROM   bopcount
								   ORDER by country")
							 Set i = 0
							 Call SalArraySetUpperBound(mG, 1, -1)
							 Call SalListClear(hWndItem)
							 While SqlFetchNext(hSql(), nFetchRes)
								 Call SalListAdd(hWndItem, sD)
								 Set mG[i] = s1D
								 Set i = i+1
						! If SqlPrepareAndExecute(hSql(), "
								   SELECT KOD_LIT, KOD_LIT||'/'||txt
								   INTO   :s1D, :sD
								   FROM   kl_k040
								   ORDER by txt")
						If SqlPrepareAndExecute(hSql(), "
								   SELECT K040, K040||'/'||txt
								   INTO   :s1D, :sD
								   FROM   kl_k040
								   ORDER by txt")
							Set i = 0
							Call SalArraySetUpperBound(mG, 1, -1)
							Call SalListClear(hWndItem)
							While SqlFetchNext(hSql(), nFetchRes)
								Call SalListAdd(hWndItem, sD)
								Set mG[i] = s1D
								Set i = i+1
					On SAM_Validate
						Set i = SalListQuerySelection(hWndItem)
						Set colKOD_G = IifS(i>=0, mG[i], '')
						! Set colG = FLAGI(colG)
						Return VALIDATE_Ok
			!
			Column: colKOD_B
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						БК
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
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
					On SAM_Validate
						If colKOD_B = STRING_Null
							Set colTEX_B = STRING_Null
						Else
							! If SqlPrepareAndExecute(hSqlAux(), "
									   SELECT name
									   INTO   :colTEX_B
									   FROM   bopbank
									   WHERE  regnum=:colKOD_B") and not SqlFetchNext(hSqlAux(), nFetchRes)
								     Call Debug('Ош.код')
								     Set colKOD_B = STRING_Null
								     Return VALIDATE_Ok
							If colKOD_B != '999'
								If SqlPrepareAndExecute(hSqlAux(), "
										   SELECT knb
										   INTO   :colTEX_B
										   FROM   rcukru
										   WHERE  glb=:colKOD_B") and not SqlFetchNext(hSqlAux(), nFetchRes)
									! Call Debug('Ош.код')
									Call MessageNoWait('Помилковий код!', 'УВАГА!', 17, 1)
									Set colKOD_B = STRING_Null
									Return VALIDATE_Ok
							Else
								Set colTEX_B = '999/інше'
						! Set colB = FLAGI(colB)
						Return VALIDATE_Ok
			Column: colTEX_B
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: БАНК-корреспондент
						Текст
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.243"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Drop Down List
					Multiline Cell? No
					Cell DropDownList
						Sorted? No
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? No
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
					On SAM_Create
						! If SqlPrepareAndExecute(hSql(), T("
								   SELECT regnum, regnum||'/'||name
								   INTO   :nD, :sD
								   FROM   bopbank
								   ORDER by name"))
						If SqlPrepareAndExecute(hSql(), T("
								   SELECT glb, glb||'/'||knb gkcp, knb
								   INTO   :nD, :sD, :sTmp
								   FROM   rcukru
								   WHERE  glb>0
								   union all
								   select 999 glb, '999/інше' gkcp, 'Я' knb
								   from   dual
								   ORDER by 3"))
							Set i = 0
							Call SalArraySetUpperBound(mB, 1, -1)
							Call SalListClear(hWndItem)
							While SqlFetchNext(hSql(), nFetchRes)
								Call SalListAdd(hWndItem, sD)
								Set mB[i] = nD
								Set i = i + 1
					On SAM_Validate
						Set i = SalListQuerySelection(hWndItem)
						Set colKOD_B = IifS(i>=0, mB[i], '0')
						! Set colB = FLAGI(colB)
						Return VALIDATE_Ok
			!
			Column: colVDAT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						ввода
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Left
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
			Column: colREF
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: РЕФ
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  1.05"
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
			Column: colPDAT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						валют.
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Left
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
			Column: colTT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ОП
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.05"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colREC
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: REC
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  1.05"
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
			Column: colISP
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ISP
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  1.05"
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
			Column: colDK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ДК
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  1.05"
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
			Column: colKVA
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: KVA
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.05"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colKVB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: KVB
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.05"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Class:
				Property Template:
				Class DLL Name:
				Title: NLSA
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.05"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colNAMA
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: NLSA
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.05"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Class:
				Property Template:
				Class DLL Name:
				Title: NLSA
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.05"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: colNAMB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: NLSA
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.05"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Class:
				Property Template:
				Class DLL Name:
				Title: NLSA
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  1.05"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			! Column: colB
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ДК
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  1.05"
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
.end
				 List Values 
				 Message Actions 
			! Column: colG
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ДК
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  1.05"
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
.end
				 List Values 
				 Message Actions 
			! Column: colN
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ДК
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Left
				Width:  1.05"
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
.end
				 List Values 
				 Message Actions 
			Column: SQ
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ЭКВ
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.486"
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
			Column: nRuch
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Доп
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  0.333"
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
			Column: nSum
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ЭКВ
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
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
		Functions
			Function: FLAGI
				Description:
				Returns
					Number: FLAG
				Parameters
					Number: FLAG1
				Static Variables
				Local variables
					Number: FLAG2
				Actions
					If FLAG1=NUMBER_Null !! вставка
						Set FLAG2=3
					Else If FLAG1=1 !! обновление
						Set FLAG2=2
					Else !! сохранить состояние флага
						Set FLAG2=FLAG1
					Return FLAG2
		Window Parameters
		Window Variables
			Number: nPorog  !!! Сума - порог для десларування
			Number: nRow
			Number: nNBU  !!! Признак НБУ
			String: sTmp
			String: sNBSk
			!
			Number: nKV
			Number: nD0
			Number: nD1
			String: nD
			String: sD
			String: ss1
			String: fs
			String: s1D
			String: sdat
			Number: i
			String: mG[*]
			! Number: mN[*]
			String: mB[*]
			!
			Number: nCount
		Message Actions
			On SAM_Create
				Call SalTblSetLockedColumns( hWndForm, 5)
				Call SalSetWindowText( hWndForm, '1_ПБ: Дополнительные реквизиты' )
				!
				Call PB_1.cF.Init( 'Accounts', 'a' )
				!
				Set nKV=GetBaseVal()
				Set dDATA=GetBankDate()
				Set sdat=SalFmtFormatDateTime( dDATA,'MM-dd-yyyy' )
				Call SalMapEnterToTab(TRUE)
				Call SalCenterWindow( hWndForm )
				Set nD0=0
				Set nD1=1
				Call SalDisableWindow( pbALL )
				Call SalEnableWindow( pbDEB )
				Call SalEnableWindow( pbKRD )
				! Set tolko="Документы дня"
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On SAM_CreateComplete
			On UM_Populate
				Call SalWaitCursor( TRUE )
				Set fs = cF.GetFilterWhereClause( FALSE )
				! НБУ или КБ 
				If SqlPrepareAndExecute( hSql(),"SELECT val FROM params WHERE par='NBUBANK' and val='1'" )
						and SqlFetchNext( hSql(), nFetchRes )
					Set PB_1.strSqlPopulate =
							"SELECT aa.NLS, aa.KV, DECODE(aa.DK,1,'D','C'), aa.S,
							        o.nd,o.tt,o.ref, 0, o.kv,o.kv2,o.dk,
							        o.nlsa,o.nam_a,o.nlsb,o.nam_b,o.nazn
							 INTO :PB_1.colNls,:PB_1.colKv,:PB_1.col_DC,:PB_1.nSum,
							      :PB_1.colND,:PB_1.colTT,:PB_1.colREF, :PB_1.colREC, :PB_1.colKVA,
							      :PB_1.colKVB,:PB_1.colDK,:PB_1.colNLSA,:PB_1.colNAMA,
							      :PB_1.colNLSB,:PB_1.colNAMB,:PB_1.colNAZN
							 FROM oper o,
							(select p.ref REF, a.nls NLS, a.kv KV, p.dk DK, p.s S
							 from accounts a, opldok p
							 where "||IifS(fs !="",fs||" and ","")||
							       "a.acc=p.acc and 
							       p.sos=5     and 
							       p.fdat= :sdat  and 
							       p.s>0   and
							       (a.nbs in ('1011','1100','1110') and a.kv<>980 OR 
							        a.nbs in ('1201','1202','1221','3201') and a.acc in 
							          (select cu.acc 
							           from cust_acc cu,customer c 
							           where cu.rnk=c.rnk and c.CODCAGENT=2))
							 group by p.ref, a.nls, a.kv, p.dk,p.s) aa 
							 WHERE o.ref = aa.REF "  
					Set nNBU = 1
				Else
					Set PB_1.strSqlPopulate =
							"SELECT aa.NLS, aa.KV, DECODE(aa.DK,1,'D','C'), aa.S,
							        o.nd,o.tt,o.ref, 0, o.kv,o.kv2,o.dk,
							        o.nlsa,o.nam_a,o.nlsb,o.nam_b,o.nazn
							 INTO :PB_1.colNls,:PB_1.colKv,:PB_1.col_DC,:PB_1.nSum,
							      :PB_1.colND,:PB_1.colTT,:PB_1.colREF, :PB_1.colREC, :PB_1.colKVA,
							      :PB_1.colKVB,:PB_1.colDK,:PB_1.colNLSA,:PB_1.colNAMA,
							      :PB_1.colNLSB,:PB_1.colNAMB,:PB_1.colNAZN 
							 FROM oper o,
							(select p.ref REF, a.nls NLS, a.kv KV, p.dk DK, p.s S
							 from accounts a, opldok p
							 where "||IifS(fs !="",fs||" and ","")||
							       "a.acc=p.acc and 
							       p.sos=5     and 
							       p.fdat= :sdat  and 
							       p.s>0   and
							       (a.nbs in ('1001','1002','1003','1007') and a.kv<>980 OR 
							        a.nbs in ('1500','1505','1600','1605') and a.acc in 
							          (select cu.acc 
							           from cust_acc cu,customer c 
							           where cu.rnk=c.rnk and c.CODCAGENT=2))
							 group by p.ref, a.nls, a.kv, p.dk,p.s) aa 
							 WHERE o.ref = aa.REF "  
					Set nNBU = 0
				!
				Set ss1=''
				If nD0+nD1=0 !! только дебет
					Set ss1=" and aa.dk=0"
				Else If nD0+nD1=2  !! толькл кредит
					Set ss1=" and aa.dk=1"
				Set PB_1.strSqlPopulate = PB_1.strSqlPopulate || ss1
				Set PB_1.strSqlPopulate =T(PB_1.strSqlPopulate ||" ORDER BY 1,2,3,4")     
				Call SalTblPopulate( hWndForm, hSql(), PB_1.strSqlPopulate, TBL_FillAll )
				Call SalTblSetContext( hWndForm, 0 )
				Call SalTblSetRowFlags( hWndForm, 0, ROW_Selected, TRUE )
				Call SalSendMsg( hWndForm, SAM_TblDoDetails, 0,0)
				Call SalWaitCursor( FALSE )
			On SAM_FetchRowDone
				! подлежит декларированию по сумме
				! С кем корреспондирует наш корсчет
				Set nRuch =0
				! If SqlPrepareAndExecute( hSqlAux2(),
						  "SELECT gl.p_icurval(:colKv, :PB_1.nSum, :dDATA ), Substr(a.NBS,1,2), 
						Substr( TO_CHAR( "||Str(nSum)||"/POWER(10,t.DIG),'999,999,999,999'||
						 rpad('.',1+t.DIG,'9') ), 1,20) 
						   INTO :SQ , :sNBSk, :PB_1.colS 
						FROM accounts a, opldok o, TABVAL t 
						   WHERE t.kv=a.Kv and 
						   o.ref=:colREF and o.dk=DECODE(:col_DC,'D',0,1) and o.acc=a.acc and rownum=1 " )
						and SqlFetchNext( hSqlAux2(), nFetchRes )
						
				If SqlPrepareAndExecute(hSqlAux2(), "
						   SELECT gl.p_icurval(:colKv,:PB_1.nSum,:dDATA), Substr(a.NBS,1,2), Substr(TO_CHAR(" || Str(nSum) ||
						          "/POWER(10,t.DIG),'999,999,999,990'||rpad('.',1+t.DIG,'9')),1,20)
						   INTO   :SQ, :sNBSk, :PB_1.colS
						   FROM   accounts a, opldok o, TABVAL t
						   WHERE  t.kv=a.Kv and o.ref=:colREF and o.ref not in (select ref
						                                                        from   operw
						                                                        where ref>=o.ref and tag='NOS_R') and
						          o.dk=DECODE(:col_DC,'D',0,1) and o.acc=a.acc and rownum=1
						   UNION ALL
						   SELECT gl.p_icurval(:colKv,:PB_1.nSum,:dDATA), Substr(a.NBS,1,2), Substr(TO_CHAR(" || Str(nSum) ||
						          "/POWER(10,t.DIG),'999,999,999,990'||rpad('.',1+t.DIG,'9')),1,20)
						   FROM   accounts a, opldok o, TABVAL t
						   WHERE  t.kv=a.Kv and o.ref in (select to_number(trim(value))
						                                  from   operw
						                                  where  ref=:colREF and tag='NOS_R') and o.dk=DECODE(:col_DC,'D',0,1) and o.acc=a.acc and
						          rownum=1") and SqlFetchNext(hSqlAux2(), nFetchRes)
				!
				! If SqlPrepareAndExecute( hSqlAux2(),
						  "SELECT Substr( TO_CHAR( "||Str(nSum)||"/POWER(10,DIG),'999,999,999,999'||
						 rpad('.',1+DIG,'9') ), 1,20) 
						      INTO :PB_1.colS 
						   FROM  TABVAL  WHERE kv=:nKv" )
						and SqlFetchNext( hSqlAux2(), nFetchRes )
				!
				! If SqlPrepareAndExecute(hSqlAux2(), "
						   SELECT w.value, b.name, 1 
						   INTO   :colKOD_B, :colTEX_B, :colB
						   FROM   operw w, bopbank b 
						   WHERE  w.ref=:colREF AND w.tag='KOD_B' AND ltrim(rtrim(w.value))=ltrim(rtrim(b.regnum(+)))") and
						   SqlFetchNext(hSqlAux2(), nFetchRes)
				If SqlPrepareAndExecute(hSqlAux2(), "
						   SELECT w.value, decode(w.value, '999', '999/інше', b.knb)
						   INTO   :colKOD_B, :colTEX_B
						   FROM   operw w, rcukru b 
						   WHERE  w.ref=:colREF AND w.tag='KOD_B' AND ltrim(rtrim(w.value))=ltrim(rtrim(b.glb(+)))") and
						   SqlFetchNext(hSqlAux2(), nFetchRes)
				!
				! If SqlPrepareAndExecute(hSqlAux2(), "
						   SELECT w.value, b.country, 1
						   INTO   :colKOD_G, :colTEX_G, :colG
						   FROM   operw w, bopcount b
						   WHERE  w.ref=:colREF AND w.tag='KOD_G' AND w.value=b.ISO_COUNTR") and SqlFetchNext(hSqlAux2(), nFetchRes) or
						   SqlPrepareAndExecute(hSqlAux2(), "
						   SELECT w.value, b.country, 1
						   INTO   :colKOD_G, :colTEX_G, :colG
						   FROM   operw w, bopcount b
						   WHERE  w.ref=:colREF AND w.tag='KOD_G' AND w.value=b.KODC(+)") and SqlFetchNext(hSqlAux2(), nFetchRes)
				! If SqlPrepareAndExecute(hSqlAux2(), "
						   SELECT lpad(w.value,3,'0'), b.txt, 1
						   INTO   :colKOD_G, :colTEX_G, :colG
						   FROM   operw w, kl_k040 b
						   WHERE  w.ref=:colREF AND w.tag='KOD_G' AND lpad(w.value,3,'0')=b.K040") and SqlFetchNext(hSqlAux2(), nFetchRes) or
						   SqlPrepareAndExecute(hSqlAux2(), "
						   SELECT w.value, b.txt, 1
						   INTO   :colKOD_G, :colTEX_G, :colG
						   FROM   operw w, kl_k040 b
						   WHERE  w.ref=:colREF AND w.tag='KOD_G' AND w.value=b.KOD_LIT") and SqlFetchNext(hSqlAux2(), nFetchRes)
				If SqlPrepareAndExecute(hSqlAux2(), "
						   SELECT lpad(w.value,3,'0'), b.txt
						   INTO   :colKOD_G, :colTEX_G
						   FROM   operw w, kl_k040 b
						   WHERE  w.ref=:colREF AND w.tag='KOD_G' AND lpad(w.value,3,'0')=b.K040") and SqlFetchNext(hSqlAux2(), nFetchRes) or
						   SqlPrepareAndExecute(hSqlAux2(), "
						   SELECT b.K040, b.txt
						   INTO   :colKOD_G, :colTEX_G
						   FROM   operw w, kl_k040 b
						   WHERE  w.ref=:colREF AND w.tag='KOD_G' AND w.value=b.KOD_LIT") and SqlFetchNext(hSqlAux2(), nFetchRes) 
				!
				If SqlPrepareAndExecute(hSqlAux2(), "
						   SELECT w.value, b.transdesc, b.KIND
						   INTO   :colKOD_N, :colTEX_N, :col_DC1
						   FROM   operw w, bopcode b
						   WHERE  w.ref=:colREF AND w.tag='KOD_N' AND ltrim(rtrim(w.value))=ltrim(rtrim(b.transcode(+)))") and
						   SqlFetchNext(hSqlAux2(), nFetchRes)
				!
				If Subs(colKOD_N, 1, 4) = '8447' and Subs(colKOD_G, 1, 3) != '804' and Subs(colKOD_G, 1, 3) != 'UKR'
					Call SalTblSetCellTextColor(colKOD_N, COLOR_Red, FALSE)
					Call SalTblSetCellTextColor(colKOD_G, COLOR_Red, FALSE)
				If SQ >= nPorog and Subs(colKOD_N, 1, 4) != '8444'
					! Свои клиенты
					If nNBU = 1 and sNBSk = '35' or nNBU = 0 and sNBSk = '26'
						Call XSalTblSetRowBackColor(hWndForm, lParam, COLOR_LightGreen)
					! клиенты ЛОРО-банка 
					Else If nNBU = 0 and (sNBSk='16' or sNBSk='39')
						Call XSalTblSetRowBackColor( hWndForm, lParam, COLOR_Green)
						Set nRuch =1
				If (col_DC = 'C' and col_DC1 = 'D') or (col_DC1 = 'C' and col_DC = 'D')
					Call SalTblSetCellTextColor(col_DC1, COLOR_Red, FALSE)
			On SAM_DoubleClick
				If nRuch = 1
					! Call Sel000(hWndMDI, 111, colREF, '', '' )
					Call SalModalDialog( dlg_Decl, hWndForm, colREF )
			On UM_Update
				Call SalWaitCursor(TRUE)
				Set i = TBL_MinRow
				While SalTblFindNextRow(PB_1, i, ROW_Edited, 0)
					Call SalTblFetchRow(PB_1, i)
					! If colB = 2 and SqlPrepareAndExecute(hSql(), "
							   UPDATE operw
							   SET   value=:colKOD_B
							   WHERE ref=:colREF AND tag='KOD_B'")
						 Call SqlCommit(hSql())
					! If colB = 3 and SqlPrepareAndExecute(hSql(), "
							   INSERT
							   INTO   operw (ref,tag,value)
							         VALUES (:colREF,'KOD_B',:colKOD_B)")
						 Call SqlCommit(hSql())
					! If colN = 2 and SqlPrepareAndExecute(hSql(), "
							   UPDATE operw
							   SET    value=:colKOD_N
							   WHERE  ref=:colREF AND tag='KOD_N'")
						 Call SqlCommit(hSql())
					! If colN = 3 and SqlPrepareAndExecute(hSql(), "
							   INSERT
							   INTO   operw (ref,tag,value)
							         VALUES (:colREF,'KOD_N',:colKOD_N)")
						 Call SqlCommit(hSql())
					! If colG = 2 and SqlPrepareAndExecute(hSql(), "
							   UPDATE operw
							   SET    value=:colKOD_G
							   WHERE  ref=:colREF AND tag='KOD_G'")
						 Call SqlCommit(hSql())
					! If colG = 3 and SqlPrepareAndExecute(hSql(), "
							   INSERT
							   INTO   operw (ref,tag,value) 
							         VALUES (:colREF,'KOD_G',:colKOD_G)")
						 Call SqlCommit(hSql())
					! KOD_B
					If colKOD_B != STRING_Null
						If SqlPrepareAndExecute(hSql(), "
								   UPDATE operw
								   SET   value=:colKOD_B
								   WHERE ref=:colREF AND tag='KOD_B'")
							If SqlGetModifiedRows(hSql(), nCount)
								If nCount = 0
									If SqlPrepareAndExecute(hSql(), "
											   INSERT
											   INTO   operw (ref,tag,value)
											         VALUES (:colREF,'KOD_B',:colKOD_B)")
										Call SqlCommit(hSql())
								Else
									Call SqlCommit(hSql())
					Else
						If SqlPrepareAndExecute(hSql(), "
								   DELETE
								   FROM   operw
								   WHERE  ref=:colREF AND tag='KOD_B'")
							Call SqlCommit(hSql())
					! KOD_N
					If colKOD_N != STRING_Null
						! Call SaveInfoToLog('updins colKOD_N for ref = ' || Str(colREF))
						If SqlPrepareAndExecute(hSql(), "
								   UPDATE operw
								   SET    value=:colKOD_N
								   WHERE  ref=:colREF AND tag='KOD_N'")
							If SqlGetModifiedRows(hSql(), nCount)
								If nCount = 0
									If SqlPrepareAndExecute(hSql(), "
											   INSERT
											   INTO   operw (ref,tag,value)
											         VALUES (:colREF,'KOD_N',:colKOD_N)")
										Call SqlCommit(hSql())
								Else
									Call SqlCommit(hSql())
					Else
						! Call SaveInfoToLog('delete colKOD_N for ref = ' || Str(colREF))
						If SqlPrepareAndExecute(hSql(), "
								   DELETE
								   FROM   operw
								   WHERE  ref=:colREF AND tag='KOD_N'")
							Call SqlCommit(hSql())
							! Call SaveInfoToLog('delete colKOD_N for ref = ' || Str(colREF) || ' ... Ok')
					! KOD_G
					If colKOD_G != STRING_Null
						If SqlPrepareAndExecute(hSql(), "
								   UPDATE operw
								   SET    value=:colKOD_G
								   WHERE  ref=:colREF AND tag='KOD_G'")
							If SqlGetModifiedRows(hSql(), nCount)
								If nCount = 0
									If SqlPrepareAndExecute(hSql(), "
											   INSERT
											   INTO   operw (ref,tag,value) 
											         VALUES (:colREF,'KOD_G',:colKOD_G)")
										Call SqlCommit(hSql())
								Else
									Call SqlCommit(hSql())
					Else
						If SqlPrepareAndExecute(hSql(), "
								   DELETE
								   FROM   operw
								   WHERE  ref=:colREF AND tag='KOD_G'")
							Call SqlCommit(hSql())
					Call SalWaitCursor(FALSE)
				Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
			On SAM_TblDoDetails
				If Len(colKOD_N) >= 4
					If SalListSelectString(colTEX_N, 0, colKOD_N ) = LB_Err
						If SalListSelectString(colTEX_N, 0, Subs(colKOD_N, 1, 4)) = LB_Err
				Set REF = colREF 
				Set TT  = colTT
				If SqlPrepareAndExecute(hSqlAux(), "
						   SELECT t.name
						   INTO   :STT
						   FROM   tts t
						   WHERE  tt=:colTT") and SqlFetchNext(hSqlAux(), nFetchRes)
					Set NLSA = colNLSA
					Set KVA  = colKVA
					Set NAMA = colNAMA
					Set NAMB = colNAMB
					Set NAZN = colNAZN
					! Set NAMA=IifS(TT='R01', StrDosToWinX(colNAMA), colNAMA)
					! Set NAMB=IifS(TT='R01', StrDosToWinX(colNAMB), colNAMB)
					! Set NAZN=IifS(TT='R01', StrDosToWinX(colNAZN), colNAZN)
					Set NLSB = colNLSB
					Set KVB  = colKVB
	Form Window: PB_F_OLD_NOT_USED
		Class:
		Property Template:
		Class DLL Name:
		Title:
		Icon File:
		Accesories Enabled? Yes
		Visible? Yes
		Display Settings
			Display Style? Etched
			Visible at Design time? Yes
			Automatically Created at Runtime? No
			Initial State: Maximized
			Maximizable? Yes
			Minimizable? Yes
			System Menu? Yes
			Resizable? Yes
			Window Location and Size
				Left:   0.025"
				Top:    0.208"
				Width:  16.367"
				Width Editable? Yes
				Height: 8.214"
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
				Display Style? Etched
				Location? Top
				Visible? Yes
				Size: 0.69"
				Size Editable? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Contents
				Combo Box: cmbMES
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Property Template:
					Class DLL Name:
					Window Location and Size
						Left:   0.183"
						Top:    0.071"
						Width:  2.2"
						Width Editable? Yes
						Height: 2.119"
						Height Editable? Yes
					Visible? Yes
					Editable? Yes
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
							Call SalWaitCursor( TRUE )
							Call SqlPrepareAndExecute(hSql(), T(" 
									SELECT distinct  to_char(d.fdat,'YYYY-MM')||' '||m.NAME_PLAIN 
									INTO :sD 
									FROM fdat d, meta_month m 
									WHERE to_char(d.fdat,'MM')+0=m.n
									ORDER  by 1 desc "))
							While SqlFetchNext(hSql(), i)
								Call SalListAdd(hWndItem, sD)
							Call SalListSetSelect(hWndItem, 1)
							Call SalWaitCursor( FALSE )
							Call SalPostMsg(cmbMES, SAM_Click, 0, 0)
						On SAM_Click
							Call SalSetWindowText( PB_F, '1_ПБ за месяц: '||cmbMES )
							Set sD=SalStrLeftX( cmbMES,4)||SalStrMidX( cmbMES, 5, 2)
				Pushbutton: ASPLA
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Property Template:
					Class DLL Name:
					Title: ASPLA
					Window Location and Size
						Left:   10.183"
						Top:    0.0"
						Width:  1.2"
						Width Editable? Yes
						Height: 0.5"
						Height Editable? Yes
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Picture File Name: \BARS98\RESOURCE\BMP\Nextrec.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_Click
							Call SalWaitCursor(TRUE)
							Set sD1='ABON'||SalStrMidX(sD,4,2)||SalStrMidX(sD,2,2)||'.dbf'
							Call SalUseRegistry(FALSE, '')
							Call SalGetProfileString('ASPLA','ASPLAPATH', 
									SalStrLeftX(SalFileGetDrive(),1)||':\\BARS98\\ODBC.DSN\\OPER',
									 sODBCDir, GetIniFileName())
							If SalFileSetCurrentDirectory(sODBCDir)
								Set SqlDatabase='dBase_Files'
								Set sDP=sODBCDir||'\\'||sD1
								If SqlConnect(hSqlA)
									Set YNC=IDYES
									If SalFileOpen( hF,sDP, OF_Exist)  !! уже существует
										Call SalFileClose( hF )
										Set YNC=SalMessageBox("Удалить данные ?","Файл "||sDP||" уже существует !", MB_YesNoCancel | MB_IconHand )
										If YNC=IDYES	!! YES - Удалить данные
											Call SqlPrepareAndExecute(hSqlA,"DROP TABLE "|| sD1 )
									If YNC=IDYES	!! YES - Удалить данные
										Call CREATE_DBF()
								Else
									Call MessageAttention('Ошибка подсоединения к Базе данных:'|| SqlDatabase)
							Else
								Call MessageAttention('Нет каталога: ' ||   sODBCDir)
							Call SalWaitCursor(FALSE)
				Pushbutton: DBF
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Property Template:
					Class DLL Name:
					Title: в 1_PB.dbf
					Window Location and Size
						Left:   8.983"
						Top:    0.071"
						Width:  1.2"
						Width Editable? Yes
						Height: 0.5"
						Height Editable? Yes
					Visible? No
					Keyboard Accelerator: (none)
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Picture File Name: \BARS98\RESOURCE\BMP\Nextrec.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_Click
							Call SalWaitCursor(TRUE)
							Set sD1='1_PB.dbf'
							Call SalUseRegistry(FALSE, '')
							Call SalGetProfileString('Import','OperNBPath', 
									SalStrLeftX(SalFileGetDrive(),1)||':\\BARS98\\ODBC.DSN\\OPER',
									 sODBCDir, GetIniFileName())
							If SalFileSetCurrentDirectory(sODBCDir)
								Set SqlDatabase='dBase_Files'
								If SqlConnect(hSqlA)
									Call SqlPrepareAndExecute(hSqlA,"DELETE from "|| sD1 )
									Call SqlPrepareAndExecute(hSqlA,"PACK "|| sD1 )
									!
									Set i = TBL_MinRow
									Set ie=0
									While SalTblFindNextRow( tblPB1, i, 0, 0 )
										Call SalTblFetchRow( tblPB1, i )
										Set aa=StrWinToDosX(tblPB1.PARTN)
										Set bb=StrWinToDosX(tblPB1.OPER)
										If not SqlPrepareAndExecute( hSqlA,
												"INSERT into "||sD1||"(LN,DEN,MEC,GOD,BAKOD,COUNKOD,PARTN,VALKOD,NLS,KRE,DEB,COUN,KOD,OPER,BANK,KOR) 
												VALUES (:tblPB1.LN,   :tblPB1.DEN,    :tblPB1.MEC, :tblPB1.GOD,
												        :tblPB1.BAKOD,:tblPB1.COUNKOD,:aa,         :tblPB1.VALKOD,
												        :tblPB1.NLS,  :tblPB1.KRE,    :tblPB1.DEB, :tblPB1.COUN,
												        :tblPB1.KOD,  :bb,            :tblPB1.BANK,:tblPB1.KOR) ") 
											Set ie=1
											Break
									If ie=1
										Call SqlRollback(hSqlA )
										Call SalMessageBox( "НЕУСПЕШНАЯ Выгрузка в " || sD1 || " !", "Экспорт", MB_Ok)
									Else
										Call SqlCommit(hSqlA)
										Call SalMessageBox( "Выгрузка в " || sD1 || " завершена!", "Экспорт", MB_Ok)
									Call SqlDisconnect(hSqlA)
								Else
									Call MessageAttention('Ошибка подсоединения к Базе данных:'|| SqlDatabase)
							Else
								Call MessageAttention('Нет каталога: ' ||   sODBCDir)
							Call SalWaitCursor(FALSE)
				Pushbutton: EXI
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Property Template:
					Class DLL Name:
					Title: Выход
					Window Location and Size
						Left:   11.383"
						Top:    0.0"
						Width:  1.2"
						Width Editable? Yes
						Height: 0.5"
						Height Editable? Yes
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Picture File Name: \BARS98\RESOURCE\BMP\Discard.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_Click
							Call SalDestroyWindow( hWndForm )
				Pushbutton: pbPrint
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cpbPrint
					Property Template:
					Class DLL Name:
					Title: Печать
					Window Location and Size
						Left:   8.871"
						Top:    0.052"
						Width:  1.2"
						Width Editable? Yes
						Height: 0.45"
						Height Editable? Yes
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Default
					Picture File Name: \BARS98\RESOURCE\BMP\print.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_Click
							! Call TablePrint(tblPB1, '1-ПБ эа '||cmbMES,
									 GetPrnDir() || '\\' || 'pb1', '')
							Call TablePrint(tblPB1, '1-ПБ эа '||cmbMES,
									 Path_PB || '\\' || 'pb1', '')
				Pushbutton: pbDok
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cpbPrint
					Property Template:
					Class DLL Name:
					Title: Документ
					Window Location and Size
						Left:   7.571"
						Top:    0.052"
						Width:  1.2"
						Width Editable? Yes
						Height: 0.45"
						Height Editable? Yes
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Default
					Picture File Name: \BARS98\RESOURCE\BMP\Open.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_Click
							If SalTblAnyRows( tblPB1, ROW_Selected, 0 ) and tblPB1.REFE >0 
								If tblPB1.tt='R01' !! СЭП
									Call DocViewContents(hWndMDI, tblPB1.REFE)
								Else !! Просмотр реквизитов внутреннего документа
									Call DocViewContentsEx(hWndMDI, tblPB1.REFE)
				Pushbutton: pbOk
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cpbPrint
					Property Template:
					Class DLL Name:
					Title: Выполнить
					Window Location and Size
						Left:   2.457"
						Top:    0.052"
						Width:  1.2"
						Width Editable? Yes
						Height: 0.45"
						Height Editable? Yes
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Default
					Picture File Name: \BARS98\RESOURCE\BMP\Execute.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_Click
							Call SalSendMsg( tblPB1, SAM_User, 0,0 )
				! cpbPrint: pbFiltr
.winattr class Pushbutton:
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cpbPrint
					Property Template:
					Class DLL Name:
					Title: Фильтр
					Window Location and Size
						Left:   6.314"
						Top:    0.042"
						Width:  1.2"
						Width Editable? Yes
						Height: 0.45"
						Height Editable? Yes
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Default
					Picture File Name: Q:\BARS98\RESOURCE\BMP\Filter.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
.end
					                                        Message Actions 
						                                        On SAM_Click
							                                        If SetQueryFilter( cFi )
								                                        Set Sfi=""
								                                        Set Sfi = cFi.GetFilterWhereClause ( FALSE )
								                                        Call Debug (Sfi)
								                                        Set sTmp=
										"SELECT a.refc,a.tt,a.LN,a.DEN,a.MEC,a.GOD,a.BAKOD,
										        a.COUNKOD,a.PARTN,a.VALKOD, 
										        a.NLS,a.KRE,a.DEB,a.COUN,a.KOD,a.OPER,a.BANK  
										 INTO  :REFE, :tt, :LN, :DEN, :MEC, :GOD, :BAKOD,
										       :COUNKOD, :PARTN, :VALKOD, 
										       :NLS, :KRE, :DEB, :COUN, :KOD, :OPER, :BANK 
										 FROM PB_1 a "|| IifS( Sfi="",""," WHERE "||Sfi)||"  
										 ORDER by NLS,VALKOD,decode(substr(kod,1,1),'9',0,1),
										    decode(substr(kod,1,1),'9',kod,den) "
								                                        Call Debug (sTmp)
								                                        Call SalTblPopulate( tblPB1, hSqlAux2(), sTmp, 1 )
								                                        Call SalDisableWindow( ASPLA )
		Contents
			Child Table: tblPB1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Display Settings
					Window Location and Size
						Left:   0.0"
						Top:    0.0"
						Width:  15.917"
						Width Editable? Yes
						Height: 6.774"
						Height Editable? Yes
					Visible? Yes
					Font Name: Arial Cyr
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					View: Table
					Allow Row Sizing? No
					Lines Per Row: Default
				Memory Settings
					Maximum Rows in Memory: 32300
					Discardable? No
				Contents
					Column: LN
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: L
								N
						Visible? No
						Editable? No
						Maximum Data Length: 1
						Data Type: String
						Justify: Right
						Width:  0.25"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: DEN
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: День
						Visible? Yes
						Editable? No
						Maximum Data Length: 2
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
					Column: MEC
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Мес
						Visible? No
						Editable? No
						Maximum Data Length: 2
						Data Type: Number
						Justify: Left
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
					Column: GOD
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Год
						Visible? No
						Editable? No
						Maximum Data Length: 2
						Data Type: Number
						Justify: Left
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
					Column: BAKOD
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Банк
						Visible? No
						Editable? No
						Maximum Data Length: 4
						Data Type: String
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
					Column: COUNKOD
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Гос.
								КС
						Visible? Yes
						Editable? No
						Maximum Data Length: 3
						Data Type: String
						Justify: Left
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
					Column: PARTN
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Наименование
								KC
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
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
					Column: VALKOD
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: ВАЛ
								KC
						Visible? Yes
						Editable? No
						Maximum Data Length: 3
						Data Type: String
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
						Title: KоррСчет
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
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
					Column: KOR
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
					Column: KRE
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: КРД
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  Default
						Width Editable? Yes
						Format: 0000
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: DEB
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: ДЕБ
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  Default
						Width Editable? Yes
						Format: #0000
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: col21
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title:
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
					Column: COUN
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Гос.
								бен
						Visible? Yes
						Editable? No
						Maximum Data Length: 3
						Data Type: String
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
					Column: KOD
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Код
								назн
						Visible? Yes
						Editable? No
						Maximum Data Length: 7
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
					Column: PODK
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
					Column: OPER
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Назначение пл
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  4.483"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: NAL
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
					Column: BANK
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: КБ
						Visible? Yes
						Editable? No
						Maximum Data Length: 4
						Data Type: String
						Justify: Right
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
					Column: REFE
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: REF/
								REC
								
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  1.071"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: tt
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: REF/
								REC
								
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Right
						Width:  1.071"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
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
					On SAM_User
						Call SalWaitCursor( TRUE )
						If SalStrTrimX(SalStrUpperX( GetDBMS() ))='ORACLE'
							Set strTemp = GetGlobalOption( 'RNBURBCK' )
							If strTemp != ''
								Call SqlPrepareAndExecute(hSql(), 'SET TRANSACTION USE ROLLBACK SEGMENT ' || SalStrUpperX(strTemp) )
							!
							If SqlPrepareAndExecute(hSql(), 
									  "SELECT status 
									   INTO :strTemp
									   FROM all_objects 
									   WHERE owner='BARS' AND object_name='FPB1'")
									and SqlFetchNext(hSql(), nTmp)
									and SalStrTrimX(strTemp) = 'INVALID'
									and SqlPrepareAndExecute(hSql(), 
									   "ALTER  PROCEDURE FPB1 COMPILE")
							If SqlPLSQLCommand( hSql(), "FPB1(sKOD_B,sD)")
								Call SqlCommit( hSql() )
								Call SalTblPopulate( tblPB1, hSql(), "
										SELECT refc,tt,LN,DEN,MEC,GOD,BAKOD,COUNKOD,PARTN,VALKOD, 
										       NLS,KRE,DEB, COUN, KOD, OPER,BANK,KOR 
										INTO  :REFE,:tt,:LN,:DEN,:MEC,:GOD,:BAKOD,:COUNKOD,:PARTN,:VALKOD,
										      :NLS,:KRE,:DEB,:COUN,:KOD,:OPER,:BANK,:KOR
										FROM pb_1 
										ORDER by NLS,   VALKOD,
										         decode(substr(kod,1,1),'9',0,1),
										         decode(substr(kod,1,1),'9',kod, to_char(100+den)),
										         DEB, KRE ",1 )
								! Call SalTblPopulate( tblPB1, hSql(), "
										SELECT refc,tt,LN,DEN,MEC,GOD,BAKOD,COUNKOD,PARTN,VALKOD, 
										       NLS,KRE,DEB, COUN, KOD, OPER,BANK 
										INTO  :REFE,:tt,:LN,:DEN,:MEC,:GOD,:BAKOD,:COUNKOD,:PARTN,:VALKOD,
										      :NLS,:KRE,:DEB,:COUN,:KOD,:OPER,:BANK
										FROM pb_1 a
										ORDER by NLS,
										         VALKOD,
										         decode(substr(kod,1,1),'9',0,1),
										         decode(substr(kod,1,1),'9',kod, to_char(100+den) )",1 )
								! Call SalEnableWindow( pbFiltr )
								Call SalEnableWindow( ASPLA )
						Call SalWaitCursor( FALSE )
					On SAM_FetchRowDone
						If Subs(tblPB1.OPER,1,1) = '|'
							Call XSalTblSetRowBackColor( hWndForm, lParam, COLOR_Green )
		Functions
			Function: CREATE_DBF
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
					Call SqlPrepareAndExecute(hSqlA, "CREATE table "||sD1||" (
							MEC numeric(2,0) ,
							GOD numeric(2,0) ,
							BAKOD char(4)    ,
							COUNKOD char(3)  ,
							PARTN char(47)   ,
							VALKOD char(3)   ,
							KOR char(4)      ,
							KOD char(4)      ,
							COUN char(3)     ,
							KRE numeric(14,3),
							DEB numeric(14,3),
							OPER char(110)   ,
							BANK char(4) ,
							NAL char(2)  
							)" )
					Set i = TBL_MinRow
					Set ie=0
					While SalTblFindNextRow( tblPB1, i, 0, 0 )
						Call SalTblFetchRow( tblPB1, i )
						Set aa=StrWinToDosX(tblPB1.PARTN)
						Set bb=StrWinToDosX(tblPB1.OPER)
						Set kor=StrWinToDosX(tblPB1.KOR)
						If not SqlPrepareAndExecute( hSqlA,
								"INSERT into "||sD1||"(MEC,GOD,BAKOD,COUNKOD,PARTN,VALKOD,KRE,DEB,COUN,KOD,OPER,BANK,KOR) 
								VALUES (:tblPB1.MEC,   :tblPB1.GOD, :tblPB1.BAKOD,:tblPB1.COUNKOD,:aa, 
								        :tblPB1.VALKOD,:tblPB1.KRE, :tblPB1.DEB,  :tblPB1.COUN,
								        :tblPB1.KOD,   :bb,            :tblPB1.BANK,:kor) ") 
							Set ie=1
							Break
					If ie=1
						Call SqlRollback(hSqlA )
						Call SalMessageBox( "НЕУСПЕШНАЯ Выгрузка в " || sDP || " !", "Экспорт", MB_Ok)
					Else
						Call SqlCommit(hSqlA)
						Call SalMessageBox( "Выгрузка в " || sDP || " завершена!", "Экспорт", MB_Ok)
					Call SqlDisconnect(hSqlA)
		Window Parameters
		Window Variables
			Number: YNC
			: cFi
				Class: cGenFilter
			String: Sfi
			String: sTmp
			Number: i
			Number: ie
			String: strTemp
			Number: nTmp
			String: sDP
			String: sD
			String: sD1
			String: sODBCDir
			String: aa
			String: bb
			String: kor
			String: sKOD_B
			Sql Handle: hSqlA 
			Date/Time: dTmp
			File Handle: hF
			String: Path_PB
		Message Actions
			On SAM_Create
				Set sKOD_B=GetValueStr("SELECT val from params where par='1_PB' ") 
				If Val(sKOD_B) =30
					Call SalDisableWindow( pbDok )
				Call cFi.Init('PB_1','a')
				! Call SalDisableWindow( pbFiltr )
				Call SalDisableWindow( ASPLA )
				! Путь для печати
				Call SalUseRegistry( FALSE, '' )
				Call SalGetProfileString( 'Export', 'PathPB1', GetPrnDir(), Path_PB, GetIniFileName() )
	!
	Table Window: CASHI
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Кассовые заявки. Итоговые суммы
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
				Left:   1.34"
				Top:    2.0"
				Width:  11.686"
				Width Editable? Class Default
				Height: 4.635"
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
				Size: 0.406"
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
						Left:   7.886"
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
						Left:   8.386"
						Top:    0.073"
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
						Left:   0.643"
						Top:    0.052"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
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
						Left:   8.886"
						Top:    0.073"
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
					Resource Id: 47589
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
						Left:   1.071"
						Top:    0.052"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
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
						Left:   10.386"
						Top:    0.073"
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
						Left:   10.386"
						Top:    0.073"
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
						Left:   1.5"
						Top:    0.052"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
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
					Resource Id: 47590
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
						Left:   2.129"
						Top:    0.052"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
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
					Resource Id: 47591
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
				!
				Pushbutton: pbSkp
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbGetValue
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.029"
						Top:    0.052"
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
							Set strTip = 'С учетом СКП / Без учета СПК '
						On SAM_Click
							Set nFL=1-nFL
							Call SalSendMsg( pbRefresh, SAM_Click, 0, 0 )
		Contents
			Column: DAT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: План-Дата
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.3"
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
			Column: ISO
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Валюта
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.386"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Drop Down List
					Multiline Cell? No
					Cell DropDownList
						Sorted? No
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? No
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
				Title: План-сумма
				Visible? No
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  2.1"
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
				Title: План-сумма
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
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
					On SAM_Validate
						Set Ss = Dig4( S, Dig, nMaxDig )
			Column: SK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: СКП
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 3
				Data Type: Number
				Justify: Right
				Width:  0.586"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: sSK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Наименование СКП
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  4.629"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: Dig
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
		Window Parameters
		Window Variables
			Number: nTmp
			Number: nFL
			Number: nKV
			Number: nOrderBy
			Window Handle: hColumn
			!
			Number: nMaxDig
			Number: nFetchRes
		Message Actions
			On SAM_Create
				Call SalWaitCursor( TRUE )
				Set nFL=1
				! Call SetWindowFont( hWndForm )
				! Call SetWindowFullSize( hWndForm )
				Call SalTblSetTableFlags( hWndForm, TBL_Flag_SelectableCols, TRUE )
				Set CASHI.strPrintFileName='CASHI'
				!
				If DigInit() != -1
					Set nMaxDig = DigInit()
				Else
					! ?
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On SAM_ColumnSelectClick
				Call SalWaitCursor( TRUE )
				Set hColumn=SalNumberToWindowHandle( wParam )
				Set nOrderBy=Not nOrderBy
				Call SalTblSortRows( hWndForm, SalTblQueryColumnID( hColumn ), nOrderBy )
				Call SalTblSetColumnFlags( hColumn, COL_Selected, FALSE )
				Call SalWaitCursor( FALSE )
			On SAM_FetchRowDone
				If nFL=1
					Call SqlPrepareAndExecute( hSqlAux2(),
							"SELECT t.name,s.name INTO :ISO,:sSK FROM tabval t,sk s WHERE t.kv="||Str(nKV)||" AND s.sk="||Str(SK))
				Else
					Call SqlPrepareAndExecute( hSqlAux2(),
							"SELECT t.name INTO :ISO FROM tabval t WHERE t.kv="||Str(nKV))
				Call SqlFetchNext( hSqlAux2(), nTmp )
				! проверка на 3 знака
				! Call SqlPrepareAndExecute( hSqlAux(), "
						SELECT dig INTO :nDig
						FROM tabval
						WHERE name=:ISO" )
				! If not SqlFetchNext( hSqlAux(), nFetchRes )
					                                        Return FALSE
				If S != NUMBER_Null
					! Set Ss = SalNumberToStrX( S*SalNumberPower( 10, 2-nDig ), nDig )
					Set Ss = Dig4( S, Dig, nMaxDig )
				!
			On UM_Populate
				Call SalWaitCursor( TRUE )
				Call SalTblDefineSplitWindow( hWndForm, 0, FALSE )
				If nFL=1
					Call SalShowWindow(CASHI.SK)
					Call SalShowWindow(CASHI.sSK)
					Set CASHI.strSqlPopulate =
							"SELECT z.fdat,a.kv,z.sk,SUM(z.s)/100, t.dig 
							 INTO :CASHI.DAT,:CASHI.nKV,:CASHI.SK,:CASHI.S, :CASHI.Dig 
							 FROM cash_z z,accounts a, tabval t
							 WHERE z.acc=a.acc AND a.kv=t.kv 
							 GROUP BY z.fdat,a.kv,z.sk,t.dig ORDER BY z.fdat,a.kv,z.sk"  
				Else
					Call SalHideWindow(CASHI.SK)
					Call SalHideWindow(CASHI.sSK)
					Set CASHI.strSqlPopulate =
							"SELECT z.fdat,a.kv,SUM(z.s)/100, t.dig 
							 INTO :CASHI.DAT,:CASHI.nKV,:CASHI.S, :CASHI.Dig 
							 FROM cash_z z,accounts a, tabval t
							 WHERE z.acc=a.acc AND a.kv=t.kv 
							 GROUP BY z.fdat,a.kv,t.dig ORDER BY z.fdat,a.kv"  
				! Call Debug(CASHI.strSqlPopulate)
				Call SalTblPopulate( hWndForm, hSql(), CASHI.strSqlPopulate, TBL_FillAll )
				Call SalTblSetContext( hWndForm, 0 )
				Call SalPostMsg( hWndForm, SAM_TblDoDetails, 0, 0)
				Call SalWaitCursor( FALSE )
				!
				!
				! Call SalSendClassMessage(UM_Populate, 0, 0)
	Table Window: CASH
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Кассовые заявки клиентов
		Icon File:
		Accesories Enabled? Class Default
		Visible? No
		Display Settings
			Visible at Design time? Yes
			Automatically Created at Runtime? Class Default
			Initial State: Class Default
			Maximizable? Class Default
			Minimizable? Class Default
			System Menu? Class Default
			Resizable? Class Default
			Window Location and Size
				Left:   0.21"
				Top:    0.3"
				Width:  15.367"
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
			Maximum Rows in Memory: 5000
			Discardable? Class Default
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Class Default
				Visible? Yes
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
						Left:   7.957"
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
						Left:   8.386"
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
						Left:   9.386"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
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
						Left:   8.814"
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
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 4917
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
						Left:   9.814"
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
						Left:   10.243"
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
						Left:   10.386"
						Top:    0.073"
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
						Left:   10.671"
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
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 4918
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
						Left:   11.9"
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
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
				Line
					Resource Id: 4919
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
				!
				Pushbutton: pbKlient
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbGetValue
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   7.5"
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
					Picture File Name: \BARS98\RESOURCE\BMP\Book.bmp
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Искать клиента '
						On SAM_Click
							Set nTmp= SalTblQueryContext( CASH )
							If not SalTblQueryRowFlags( CASH, nTmp, ROW_New ) 
								Call SalTblSetRowFlags( CASH, nTmp, ROW_Edited, TRUE ) 
							! Если есть строка в гл таблице
							If SalTblQueryRowFlags( CASH, nTmp, ROW_New | ROW_Selected ) 
								Call SalTblSetContext(CASH,nTmp)
								Set CASHKV = CASH.KV
								Set CASHRNK =  CASH.RNK
								Set CASHNMK =  CASH.NMK
								Set CASHACC =  CASH.ACC
								Set CASHNMS =  CASH.NMS
								Set CASHNLS =  CASH.NLS
								Call SalModalDialog( dlg_Clients, hWndForm,fClientChoose,CASHKV,CASHRNK,CASHNMK,CASHACC,CASHNMS,CASHNLS )
								If fClientChoose
									Set CASH.RNK =  CASHRNK
									Set CASH.NMK =  CASHNMK
									Set CASH.ACC =  CASHACC
									Set CASH.NMS =  CASHNMS
									Set CASH.NLS =  CASHNLS
				Pushbutton: pbSum
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbGetValue
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   11.286"
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
					Picture File Name: \BARS98\RESOURCE\BMP\Summ.bmp
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Итоговые суммы '
						On SAM_Click
							If not IsWindow(h11)
								Set h11 = SalCreateWindow( CASHI, hWndForm)
							Else
								Call SalBringWindowToTop ( CASHI )
				Pushbutton: pbFill
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbExecute
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.55"
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
					Picture File Name:
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Light Green
					Message Actions
						On SAM_Create
							Set strTip = 'Размножить на 12 месяцев вперед от текущей даты'
						On SAM_Click
							Call Razbyt ( 1 )
				Pushbutton: pbFill_24
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbExecute
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   6.483"
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
					Background Color: Green
					Message Actions
						On SAM_Create
							Set strTip = 'Размножить на 24 полумесяцев вперед от текущей даты'
						On SAM_Click
							Call Razbyt ( 2 )
				Data Field: nD1
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
							Left:   5.017"
							Top:    0.071"
							Width:  0.7"
							Width Editable? Yes
							Height: 0.321"
							Height Editable? Yes
						Visible? Yes
						Border? Yes
						Justify: Left
						Format: #0
						Country: Default
						Font Name: Default
						Font Size: 10
						Font Enhancement: Bold
						Text Color: Default
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
						On SAM_TooltipSetText
							Return XSalTooltipSetText( lParam, 'День ПЕРВОЙ выплаты в месяце' )
						On SAM_Create
							Set nD1 = 1
						On SAM_Validate
							If nD1 <1 or  nD1 > 31
								Return VALIDATE_Cancel
							Return VALIDATE_Ok
				Data Field: nD2
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
							Left:   5.75"
							Top:    0.071"
							Width:  0.7"
							Width Editable? Yes
							Height: 0.321"
							Height Editable? Yes
						Visible? Yes
						Border? Yes
						Justify: Left
						Format: #0
						Country: Default
						Font Name: Default
						Font Size: 10
						Font Enhancement: Bold
						Text Color: Default
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
						On SAM_TooltipSetText
							Return XSalTooltipSetText( lParam, 'День ВТОРОЙ выплаты в месяце' )
						On SAM_Create
							Set nD2 = 16
						On SAM_Validate
							If nD2 < 1 or  nD2 > 31 
								Return VALIDATE_Cancel
							Return VALIDATE_Ok
		Contents
			Column: RNK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Рег.№ 
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
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
				Title: Наименование клиента
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.343"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Title: Наименование ЛС
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  2.171"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Title: ACC
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
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
			Column: NLS
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Лиц.cчет
				Visible? Yes
				Editable? Yes
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
					On SAM_Validate
						Call SqlPrepareAndExecute( hSqlAux2(),
								"SELECT aa.acc,aa.nms,a.rnk,a.nmk 
								 INTO :ACC,:NMS,:RNK,:NMK 
								 FROM accounts aa, cust_acc u, customer a 
								 WHERE aa.nls=:NLS AND aa.kv=:KV AND u.acc=aa.acc AND u.rnk=a.rnk" )
						Return IifN( SqlFetchNext( hSqlAux2(), nTmp ), VALIDATE_Ok, VALIDATE_Cancel)
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
				Class: cGenColComboBox_NumId
				Property Template:
				Class DLL Name:
				Title: Валюта
				Visible? Class Default
				Editable? Class Default
				Maximum Data Length: Class Default
				Data Type: Class Default
				Justify: Class Default
				Width:  0.786"
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
						Call ISO.Init( hWndItem )
						Call ISO.Populate( hSql(), 
								"KV", "LCV", "TABVAL"," ORDER BY SKV" )
					On SAM_Validate
						Set KV = ISO.GetKey( SalListQuerySelection( hWndItem ) )
			Column: SK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: СКП
				Visible? Yes
				Editable? Yes
				Maximum Data Length: 3
				Data Type: Number
				Justify: Right
				Width:  0.586"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
						Call SqlPrepareAndExecute( hSqlAux2(),
								"SELECT name INTO :sSK FROM sk WHERE sk=:SK AND 
								UPPER(substr(name,1,1))='В' " )
						Return IifN( SqlFetchNext( hSqlAux2(), nTmp ), VALIDATE_Ok, VALIDATE_Cancel)
			Column: DAT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: План-Дата
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.3"
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
						Set DAT = CorrectDate(980, DAT, DAT - 1)
								!! валюта =980 - так как праздники для кассовых заявок в Украине
								!! не выходной и не праздник
			! Column: S
.winattr
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: План-сумма
				Visible? Yes
				Editable? Yes
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.586"
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
					                                        On SAM_Validate
						                                        Set S100=S*100
						                                        Return VALIDATE_Ok
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
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
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
				Title: План-сумма
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
						Call SqlPrepareAndExecute( hSqlAux(), "
								SELECT dig INTO :CASH.Dig
								FROM tabval
								WHERE kv=:KV" )
						If not SqlFetchNext( hSqlAux(), nFetchRes )
							Return FALSE
						! Set S100 = SalStrToNumber( Ss )*SalNumberPower( 10, nDig )
						Set S100 = SalStrToNumber( Ss )*SalNumberPower( 10, Dig )
						Set Ss = Dig4( S100/100, Dig, nMaxDig )
			Column: RI
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: rowid
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
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
			Column: sSK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Наименование СКП
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  3.157"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: Dig
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
			Function: Razbyt
				Description:
				Returns
					Boolean:
				Parameters
					Number: k
				Static Variables
				Local variables
					Date/Time: dDat
					Date/Time: dDat0
					Date/Time: dDat12 
					Number: i
				Actions
					!
					Set nRow =  SalTblQueryContext( CASH )
					Set CASH.CASHACC = CASH.ACC
					Set CASH.CASHNLS = CASH.NLS
					Set CASH.CASHISO = CASH.ISO
					Set CASH.CASHSK = CASH.SK
					If DigInit() != -1
						Set nMaxDig = DigInit()
					Else
						! ?
					! Set CASH.CASHDAT = CASH.DAT
					Set CASH.CASHS100 = CASH.S100
					Set CASH.CASHDig = CASH.Dig
					Set dDat0 = SalDateConstruct( SalDateYear( bDat ), SalDateMonth( bDat ), nD1, 0, 0, 0 )
					If dDat0 < bDat 
						Set dDat0 = AddMonths( dDat0, 1 )
					Set dDat12 = AddMonths( dDat0, 12 )
					Set i = 1
					Set dDat =  dDat0
					While dDat < dDat12
						Call Razbyt1(dDat)
						! If k =2 
							                                   Call Razbyt1(dDat + 15)
						Set dDat = AddMonths( dDat0, i )
						Set i = i + 1
					!
					If k = 2 and nD1 != nD2 
						Set dDat0 = SalDateConstruct( SalDateYear( bDat ), SalDateMonth( bDat ), nD2, 0, 0, 0 )
						If dDat0 < bDat 
							Set dDat0 = AddMonths( dDat0, 1 )
						Set dDat12 = AddMonths( dDat0, 12 )
						Set i = 1
						Set dDat =  dDat0
						While dDat < dDat12
							Call Razbyt1(dDat)
							Set dDat = AddMonths( dDat0, i )
							Set i = i + 1
					Return TRUE
			Function: Razbyt1
				Description:
				Returns
					Boolean:
				Parameters
					Date/Time: dDat
				Static Variables
				Local variables
					Date/Time: cDat
				Actions
					Set cDat = CorrectDate(GetBaseVal(), dDat, dDat - 1)
					Call SalTblInsertRow( CASH, TBL_MaxRow)
					Call SalTblSetContext(CASH, TBL_MaxRow)
					Set CASH.ACC = CASH.CASHACC
					Set CASH.ISO = CASH.CASHISO
					Set CASH.NLS = CASH.CASHNLS
					Set CASH.SK = CASH.CASHSK
					Set CASH.S100 = CASH.CASHS100
					Set CASH.Dig = CASH.CASHDig
					Set CASH.Ss = Dig4( CASH.S100/100, CASH.Dig, nMaxDig )
					Set CASH.DAT = cDat 
					Return TRUE
			! Function: Razbyt
				                                     Description: 
				                                     Returns 
					                                     Boolean: 
				                                     Parameters 
					                                     Number: k12
					                                     Number: i1
				                                     Static Variables 
				                                     Local variables 
				                                     Actions 
					!
					                                     Set nRow =  SalTblQueryContext( CASH )
					                                     Set CASH.CASHACC = CASH.ACC
					                                     Set CASH.CASHNLS = CASH.NLS
					                                     Set CASH.CASHISO = CASH.ISO
					                                     Set CASH.CASHSK = CASH.SK
					                                     Set CASH.CASHDAT = CASH.DAT
					                                     Set CASH.CASHS100 = CASH.S100
					                                     Set CASH.CASHDig = CASH.Dig
					                                     If CASH.DAT != DATETIME_Null
						                                     Set nTmp = 0
						                                     Loop 
							                                     If nTmp < k12
								                                     Set bMonthes[nTmp] = FALSE
								                                     Set nTmp = nTmp + i1
							                                     Else 
								                                     Break 
						                                     Call SalTblSetFlagsAnyRows( CASH, ROW_Selected, FALSE, 0, 0 )
						                                     Call SalTblSetFlagsAnyRows( CASH, ROW_Selected, TRUE, 0, 0 )
						!
						                                     Set nTmp = TBL_MinRow
						                                     Loop 
							                                     If SalTblFindNextRow( CASH, nTmp, ROW_Selected, 0 )
								                                     Call SalTblSetContext( CASH, nTmp )
								                                     If CASH.CASHACC = CASH.ACC AND CASH.CASHSK = CASH.SK  AND CASH.CASHS100 = CASH.S100 AND 
										   SalDateYear(CASH.CASHDAT) = SalDateYear(CASH.DAT) AND SalDateDay(CASH.CASHDAT) = SalDateDay(CASH.DAT)
									                                     Set bMonthes[SalDateMonth(CASH.DAT)-i1] = TRUE
							                                     Else 
								                                     Break 
						                                     Call SalTblSetFlagsAnyRows( CASH, ROW_Selected, FALSE, 0, 0 )
						!
						                                     Set nTmp = 0
						                                     Loop 
							                                     If nTmp < k12
								                                     If bMonthes[nTmp] = FALSE
									                                     Call SalTblInsertRow( CASH, TBL_MaxRow)
									                                     Call SalTblSetContext(CASH, TBL_MaxRow)
									                                     Set CASH.ACC = CASH.CASHACC
									                                     Set CASH.ISO = CASH.CASHISO
									                                     Set CASH.NLS = CASH.CASHNLS
									                                     Set CASH.SK = CASH.CASHSK
									                                     Set CASH.S100 = CASH.CASHS100
									                                     Set CASH.Dig = CASH.CASHDig
									                                     If DigInit() != -1
										                                     Set nMaxDig = DigInit()
									                                     Else 
										! ?
									                                     Set CASH.Ss = Dig4( CASH.S100/100, CASH.Dig, nMaxDig )
									                                     If SalDateMonth(CASH.CASHDAT) < nTmp + i1
										                                     Set CASH.DAT = SalDateConstruct( SalDateYear( CASH.CASHDAT ), nTmp + i1, SalDateDay( CASH.CASHDAT), 0, 0, 0 )
										                                     Set dtTmp = CASH.CASHDAT
										                                     While SalDateMonth(CASH.DAT) > nTmp + i1 OR SalDateYear(CASH.DAT) > SalDateYear(dtTmp)
											                                     Set dtTmp = dtTmp - 1
											                                     Set CASH.DAT = SalDateConstruct( SalDateYear( dtTmp ), nTmp + i1, SalDateDay( dtTmp), 0, 0, 0 )
										                                     Set CASH.DAT = CorrectDate(GetBaseVal(), CASH.DAT, CASH.DAT - 1)
												!! валюта =980 - так как праздники для кассовых заявок в Украине
												!! не выходной и не праздник
									                                     Else 
										                                     Set CASH.DAT = SalDateConstruct( SalDateYear( CASH.CASHDAT )+1, nTmp + i1, SalDateDay( CASH.CASHDAT),0, 0, 0 )
										                                     Set dtTmp = CASH.CASHDAT
										                                     While SalDateMonth(CASH.DAT) > nTmp + i1 OR SalDateYear(CASH.DAT) > SalDateYear(dtTmp)+1
											                                     Set dtTmp = dtTmp - 1
											                                     Set CASH.DAT = SalDateConstruct( SalDateYear( dtTmp ) + 1, nTmp+1, SalDateDay( dtTmp), 0, 0, 0 )
										                                     Set CASH.DAT = CorrectDate(980, CASH.DAT, CASH.DAT - 1)
												!! валюта =980 - так как праздники для кассовых заявок в Украине
												!! не выходной и не праздник
								                                     Set nTmp = nTmp + i1
							                                     Else 
								                                     Break 
		Window Parameters
		Window Variables
			Number: nTmp
			Number: n980
			Number: nClose
			String: sTmp
			String: s980
			String: sZP
			: cCust
				Class: cGenFilter
			Number: nOrderBy
			Window Handle: hColumn
			!
			Number: nMaxDig
			Number: nFetchRes
			Boolean: fClientChoose
			Number: CASHKV
			Number: CASHRNK
			String: CASHNMK
			String: CASHNMS
			String: CASHNLS
			String: CASHISO
			Number: CASHACC
			Number: CASHSK
			Number: CASHDig
			Number: CASHSs
			Number: CASHS100
			Date/Time: CASHDAT
			Date/Time: dtTmp
			Date/Time: bDat
			Boolean: bMonthes[24]
			! Boolean: bMonthes[12]
			Number: nRow
			Number: nRowFirst
		Message Actions
			On SAM_Create
				Call SalWaitCursor( TRUE )
				!
				Set n980=GetBaseVal()
				Set s980=GetBaseLcv()
				Set bDat = GetBankDate()
				Call cCust.Init('Customer', 'a')
				Call SalTblSetTableFlags( hWndForm, TBL_Flag_SelectableCols, TRUE )
				!
				Set CASH.strPrintFileName = 'CASH'
				!
				Set CASH.strFilterTblName = 'CASH_Z'
				Set CASH.strSqlPopulate =
						"SELECT a.rnk, substr(a.nmk,1,30),CASH_Z.acc, ACCOUNTS.kv, ACCOUNTS.nls,
						        ACCOUNTS.nms, CASH_Z.fdat, CASH_Z.s, CASH_Z.sk, CASH_Z.rowid, t.dig
						 INTO :CASH.RNK,:CASH.NMK,:CASH.ACC,:CASH.KV, :CASH.NLS,
						      :CASH.NMS,:CASH.DAT,:CASH.S100,:CASH.SK, :CASH.RI, :CASH.Dig  
						 FROM CASH_Z, customer a, cust_acc u, ACCOUNTS, tabval t 
						 WHERE CASH_Z.acc=ACCOUNTS.acc AND CASH_Z.acc=u.acc AND u.rnk=a.rnk AND ACCOUNTS.kv=t.kv  
						 ORDER BY CASH_Z.fdat, a.rnk, ACCOUNTS.nls, CASH_Z.sk"  
				!
				!
				Set CASH.strSqlInsert =
						"INSERT INTO cash_z (acc,sk,fdat,s) VALUES (:CASH.ACC,:CASH.SK,:CASH.DAT,:CASH.S100)" 
				Set CASH.strSqlDelete ="DELETE FROM cash_z WHERE rowid=:CASH.RI"
				Set CASH.strSqlUpdate =
						"UPDATE cash_z SET 
						acc=:CASH.ACC,sk=:CASH.SK,fdat=:CASH.DAT,s=:CASH.S100 WHERE rowid=:CASH.RI"    
				Call SalTblSetLockedColumns( hWndForm, 7)
				If DigInit() != -1
					Set nMaxDig = DigInit()
				Else
					! ?
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On SAM_CreateComplete
				Call SalEnableWindow(pbFilter)
				Call SalWaitCursor( FALSE )
				Call SalSendMsg(CASH.pbFilter,SAM_Click, 0, 0)
			On SAM_ColumnSelectClick
				Call SalWaitCursor( TRUE )
				Set hColumn = SalNumberToWindowHandle( wParam )
				Set nOrderBy = Not nOrderBy
				Call SalTblSortRows( hWndForm, SalTblQueryColumnID( hColumn ), nOrderBy )
				Call SalTblSetColumnFlags( hColumn, COL_Selected, FALSE )
				Call SalWaitCursor( FALSE )
			On UM_Insert
				Call SalSendClassMessage(UM_Insert, 0, 0)
				Set CASH.KV =n980
				Set CASH.ISO=s980
				Set CASH.SK=40
				Set sZP=GetValueStr("SELECT name FROM sk WHERE sk=40")
			On SAM_FetchRowDone
				Call SqlPrepareAndExecute( hSqlAux2(),
						"SELECT v.lcv,s.name INTO :ISO,:sSK FROM tabval v,sk s WHERE  v.kv=:KV AND s.sk =:SK")
				Call SqlFetchNext( hSqlAux2(), nTmp )
				If S100 != NUMBER_Null
					Set Ss = Dig4( S100/100, Dig, nMaxDig )
	! cGenericTable: TB_P
.winattr class Table Window:
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Зачисление начисленных процентов со счетов начислений на основные счета
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
				Left:   0.35"
				Top:    0.842"
				Width:  13.514"
				Width Editable? Yes
				Height: 5.781"
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
			Maximum Rows in Memory: 20000
			Discardable? No
.end
		                                        Description: 
		                                        Named Menus 
		                                        Menu 
		                                        Tool Bar 
			                                        Contents 
				                                        Pushbutton: pbIns
					                                        Message Actions 
				                                        Pushbutton: pbDel
					                                        Message Actions 
				                                        Pushbutton: pbRefresh
					                                        Message Actions 
				                                        Pushbutton: pbUpdate
					                                        Message Actions 
				                                        Line 
				                                        Pushbutton: pbSearch
					                                        Message Actions 
				                                        Pushbutton: pbFilter
					                                        Message Actions 
				                                        Pushbutton: pbDetails
					                                        Message Actions 
				                                        Pushbutton: pbPrint
					                                        Message Actions 
				                                        Pushbutton: pbExec
					                                        Message Actions 
						                                        On SAM_Create
							                                        Set strTip = 'Выполнить проект проводок '
						                                        On SAM_Click
							                                        Call Oplata(0)
				                                        Line 
				                                        Pushbutton: pbExit
					                                        Message Actions 
				                                        Line 
				                                        Data Field: RD
					                                        Message Actions 
						                                        On SAM_Validate
							                                        If RD>BD
								                                        Set RD=BD
								! Return VALIDATE_Cancel
				                                        Data Field: nKol
					                                        Message Actions 
				                                        Background Text: Количество
				                                        Background Text: Сумма
				                                        Data Field: nSum
					                                        Message Actions 
		                                        Contents 
			                                        Column: NMS
				                                        List Values 
				                                        Message Actions 
			                                        Column: KV
				                                        List Values 
				                                        Message Actions 
			                                        Column: NLS
				                                        List Values 
				                                        Message Actions 
			                                        Column: NLSN
				                                        List Values 
				                                        Message Actions 
			                                        Column: SR
				                                        List Values 
				                                        Message Actions 
			                                        Column: ST
				                                        List Values 
				                                        Message Actions 
			                                        Column: OTM
				                                        List Values 
				                                        Message Actions 
			                                        Column: DAPR
				                                        List Values 
				                                        Message Actions 
			                                        Column: DAPP
				                                        List Values 
				                                        Message Actions 
			                                        Column: ACC
				                                        List Values 
				                                        Message Actions 
			                                        Column: ACCN
				                                        List Values 
				                                        Message Actions 
		                                        Functions 
			                                        Function: Oplata
				                                        Description: 
				                                        Returns 
				                                        Parameters 
					                                        Number: nRow1
				                                        Static Variables 
				                                        Local variables 
					                                        Number: nRow
					                                        Number: nRef
					                                        String: sBankMfo
					                                        String: sBankName
					                                        String: sBankDay
					                                        String: sOperID
					                                        Number: nKOL
					                                        Long String: lsSign
				                                        Actions 
					                                        Set nTmp=TBL_MinRow
					                                        Set sBankMfo=GetBankMfo()
					                                        Set sBankDay=GetBankDateEx( )
					                                        Set sBankName=GetBankName()
					                                        Set sOperID=GetIdOper()
					                                        Set nKOL=0
					                                        Set nRow=0
					                                        Loop 
						                                        If SalTblFindNextRow (  hWndForm, nTmp,nRow, 0 )
							                                        Call SalTblSetContext( hWndForm,nTmp )
							                                        If nTmp >=0
								                                        If TB_P.OTM=1
									                                        Set nRef = NUMBER_Null
									                                        If not cDoc.P_Doc(nRef, 'PS1', 6,
											 Str(nKOL+1), sBankDay, sBankDay, TB_P.KV, 1, SalNumberAbs(TB_P.SR*100),
											 0, NUMBER_Null, sBankDay, sBankDay, "Счет нач.%", TB_P.NLSN, sBankMfo,
											 TB_P.NMS, TB_P.NLS, sBankMfo, "Зачисление % на основной счет",
											 STRING_Null, STRING_Null, STRING_Null, sOperID,  lsSign,0)
										                                        Call SqlRollback(hSql())
										                                        Break 
									                                        Set nKOL=nKOL+1
									                                        Call SqlPrepareAndExecute(hSql(),
											"UPDATE int_acc SET apl_dat="||sRD||" WHERE acc=:TB_P.ACC")
						                                        Else 
							                                        Call SqlCommit( hSql())
							                                        Call SaveFInfoToLog('Выполнено зачисление % на основные счета')
							                                        Call SalMessageBox('Проект из '|| Str(nKOL) ||' проводок','Выполнен успешно',MB_IconInformation)
							                                        Break 
					                                        Call SalSendMsg( pbRefresh, SAM_Click, 0, 0 )
					                                        Return 0
		                                        Window Parameters 
		                                        Window Variables 
			                                        String: sTmp
			                                        String: sRD
			                                        Date/Time: BD
			                                        Number: nTmp
			                                        : cDoc
		                                        Message Actions 
			                                        On SAM_Create
				                                        Set TB_P.strPrintFileName = 'PP1'
				                                        Set RD=GetBankDate()
				                                        Set BD=RD
				                                        Set TB_P.strFilterTblName = 'ACCOUNTS'
				                                        Call SalSendClassMessage(SAM_Create, 0, 0)
			                                        On UM_Populate
				                                        Call SalWaitCursor( TRUE )
				                                        Set sRD="TO_DATE('"|| SalFmtFormatDateTime(RD,'MM-dd-yyyy') || "','mm-dd-yyyy')"
				                                        Set TB_P.strSqlPopulate =
						"SELECT accounts.nms, accounts.kv, accounts.nls, a1.nls, i.apl_dat,
						        fost(i.acrk,"||sRD||")/100,a1.ostc/100, 
						        i.acc,i.acrk
						 INTO :TB_P.NMS,:TB_P.KV,:TB_P.NLS,:TB_P.NLSN,:TB_P.DAPR,
						      :TB_P.SR,:TB_P.ST,:TB_P.ACC,:TB_P.ACCN
						 FROM accounts accounts, int_acc i, accounts a1, cust_acc u, cust_acc u1
						 WHERE u.rnk=u1.rnk AND u.acc=accounts.acc AND u1.acc=a1.acc AND 
						       a1.acc=i.acrk AND i.acc=accounts.acc AND i.acc<>i.acrk AND
						       accounts.dazs IS NULL AND 
						       (i.apl_dat<"||sRD||" OR i.apl_dat IS NULL ) AND 
						       ( accounts.blkk is NULL OR accounts.blkk=0 ) AND 
						      fost(i.acrk,"||sRD||")<=a1.ostc AND fost(i.acrk,"||sRD||")>0 and
						      accounts.acc NOT IN (SELECT acc FROM dpt_deposit)
						 ORDER BY accounts.kv, accounts.nls"
				                                        Call TB_P.cQ.Init( TB_P.strSqlPopulate )
				                                        Set nKol=0
				                                        Set nSum=0
				                                        Call SalSendClassMessage(UM_Populate, 0, 0)
			                                        On SAM_FetchRowDone
				                                        Call SqlPrepareAndExecute(hSqlAux(),
						"SELECT max(fdat) INTO :DAPP FROM saldoa WHERE acc=:ACCN AND dos>0")
				                                        Call SqlFetchNext(hSqlAux(),nTmp)
				                                        If ST<SR or DAPP>=RD 
					                                        Set OTM=0
				                                        Else 
					                                        Set OTM=1
					                                        Set nKol=nKol+1
					                                        Set nSum=nSum+SR
	Dialog Box: dlg_Clients
		Class: cGenericTableDlg
		Property Template:
		Class DLL Name:
		Title: Клиенты
		Accesories Enabled? Class Default
		Visible? Class Default
		Display Settings
			Display Style? Class Default
			Visible at Design time? Yes
			Type of Dialog: Class Default
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  Class Default
				Width Editable? Class Default
				Height: Class Default
				Height Editable? Class Default
			Absolute Screen Location? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: Class Default
			Text Color: Class Default
			Background Color: Class Default
		Description:
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
					Class Child Ref Key: 11
					Class ChildKey: 0
					Class: cGenericTableDlg
					Property Template:
					Class DLL Name:
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
					Class Child Ref Key: 12
					Class ChildKey: 0
					Class: cGenericTableDlg
					Property Template:
					Class DLL Name:
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
					Class Child Ref Key: 20
					Class ChildKey: 0
					Class: cGenericTableDlg
					Property Template:
					Class DLL Name:
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
					Class Child Ref Key: 15
					Class ChildKey: 0
					Class: cGenericTableDlg
					Property Template:
					Class DLL Name:
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
					Resource Id: 16839
					Class Child Ref Key: 19
					Class ChildKey: 0
					Class: cGenericTableDlg
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
					Class Child Ref Key: 13
					Class ChildKey: 0
					Class: cGenericTableDlg
					Property Template:
					Class DLL Name:
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
					Class Child Ref Key: 23
					Class ChildKey: 0
					Class: cGenericTableDlg
					Property Template:
					Class DLL Name:
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
					Class Child Ref Key: 14
					Class ChildKey: 0
					Class: cGenericTableDlg
					Property Template:
					Class DLL Name:
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
					Resource Id: 16840
					Class Child Ref Key: 21
					Class ChildKey: 0
					Class: cGenericTableDlg
					Coordinates
						Begin X:  Class Default
						Begin Y:  Class Default
						End X:  Class Default
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbOk
					Class Child Ref Key: 16
					Class ChildKey: 0
					Class: cGenericTableDlg
					Property Template:
					Class DLL Name:
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
							Set fOk=TRUE
							Set CASHRNK=dlg_Clients.tbl.r1
							Set CASHNMK=dlg_Clients.tbl.n1
							Set CASHACC=dlg_Clients.tbl.a1
							Set CASHNMS=dlg_Clients.tbl.m1
							Set CASHNLS=dlg_Clients.tbl.s1
							Call SalSendClassMessage( SAM_Click, 0, 0 )
				Pushbutton: pbExit
					Class Child Ref Key: 17
					Class ChildKey: 0
					Class: cGenericTableDlg
					Property Template:
					Class DLL Name:
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
							Set fOk=FALSE
							Call SalSendClassMessage( SAM_Click, 0, 0 )
				Line
					Resource Id: 16841
					Class Child Ref Key: 22
					Class ChildKey: 0
					Class: cGenericTableDlg
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
			Child Table: tbl
				Class Child Ref Key: 8
				Class ChildKey: 0
				Class: cGenericTableDlg
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
					Font Enhancement: None
					Text Color: Class Default
					Background Color: Class Default
					View: Class Default
					Allow Row Sizing? Class Default
					Lines Per Row: Class Default
				Memory Settings
					Maximum Rows in Memory: Class Default
					Discardable? Class Default
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
						Width:  0.871"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
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
						Width:  3.843"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: a1
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
						Justify: Right
						Width:  0.871"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: m1
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Наименование ЛС
						Visible? No
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  4.657"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: s1
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: ЛС
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.757"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
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
					On SAM_DoubleClick
						Call SalSendMsg( pbOk, SAM_Click, 0, 0 )
		Functions
		Window Parameters
			Receive Boolean: fOk
			Number: CASHKV
			Receive Number: CASHRNK
			Receive String: CASHNMK
			Receive Number: CASHACC
			Receive String: CASHNMS
			Receive String: CASHNLS
		Window Variables
		Message Actions
			On SAM_Create
				Call SalCenterWindow( hWndForm )
				Set strSqlPopulate="SELECT 
						a.rnk, 
						a.nmk, 
						aa.acc, 
						aa.nms, 
						aa.nls 
						INTO 
						:dlg_Clients.tbl.r1, 
						:dlg_Clients.tbl.n1, 
						:dlg_Clients.tbl.a1, 
						:dlg_Clients.tbl.m1, 
						:dlg_Clients.tbl.s1 
						 FROM customer a,accounts aa, cust_acc u 
						 WHERE a.rnk=u.rnk 
							AND u.acc=aa.acc 
							AND aa.nbs<8000 
							AND aa.kv = :dlg_Clients.CASHKV  "
				Set strSqlInsert=""
				Set strSqlUpdate=""
				Set strSqlDelete=""
				Set strFilterTblName="Customer"
				Set strPrintFileName=""
				Set nFlags=GT_ReadOnly
				Call SalSendClassMessage( UM_Create, 0, 0 )
	Dialog Box: dlg_Decl
		Class: cGenericTableDlg
		Property Template:
		Class DLL Name:
		Title: Клиенты ЛОРО-банков (для декларирования платежей в 1-ПБ)
		Accesories Enabled? Class Default
		Visible? Class Default
		Display Settings
			Display Style? Class Default
			Visible at Design time? Yes
			Type of Dialog: Class Default
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  12.45"
				Width Editable? Class Default
				Height: Class Default
				Height Editable? Class Default
			Absolute Screen Location? Class Default
			Font Name: Class Default
			Font Size: Class Default
			Font Enhancement: Class Default
			Text Color: Class Default
			Background Color: Class Default
		Description:
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Class Default
				Visible? Class Default
				Size: 0.429"
				Size Editable? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
			Contents
				Pushbutton: pbIns
					Class Child Ref Key: 11
					Class ChildKey: 0
					Class: cGenericTableDlg
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   6.583"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
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
					Class Child Ref Key: 12
					Class ChildKey: 0
					Class: cGenericTableDlg
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   7.017"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
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
					Class Child Ref Key: 20
					Class ChildKey: 0
					Class: cGenericTableDlg
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   7.45"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
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
					Class Child Ref Key: 15
					Class ChildKey: 0
					Class: cGenericTableDlg
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   7.883"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
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
					Resource Id: 18303
					Class Child Ref Key: 19
					Class ChildKey: 0
					Class: cGenericTableDlg
					Coordinates
						Begin X:  8.4"
						Begin Y:  Class Default
						End X:  8.4"
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbSearch
					Class Child Ref Key: 13
					Class ChildKey: 0
					Class: cGenericTableDlg
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   8.55"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
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
					Class Child Ref Key: 23
					Class ChildKey: 0
					Class: cGenericTableDlg
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   8.983"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
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
					Class Child Ref Key: 14
					Class ChildKey: 0
					Class: cGenericTableDlg
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   9.417"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
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
					Resource Id: 18304
					Class Child Ref Key: 21
					Class ChildKey: 0
					Class: cGenericTableDlg
					Coordinates
						Begin X:  9.95"
						Begin Y:  Class Default
						End X:  9.95"
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Pushbutton: pbOk
					Class Child Ref Key: 16
					Class ChildKey: 0
					Class: cGenericTableDlg
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   10.083"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
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
							If SqlPrepareAndExecute( hSqlAux(), 
									  "DELETE FROM OPERW where ref=:REF and tag in ('ASP_N','ASP_K','ASP_S')" )
									and SqlPrepareAndExecute( hSqlAux(), 
									  "INSERT INTO OPERW (REF, TAG, VALUE) values(:REF,'ASP_N',:dlg_Decl.tbl.NAME ) " )
									and SqlPrepareAndExecute( hSqlAux(), 
									  "INSERT INTO OPERW (REF, TAG, VALUE) values(:REF,'ASP_K',:dlg_Decl.tbl.OKPO ) " )
									and SqlPrepareAndExecute( hSqlAux(), 
									  "INSERT INTO OPERW (REF, TAG, VALUE) values(:REF,'ASP_S',:dlg_Decl.tbl.STAT ) " )
								Call SqlCommitEx( hSqlAux(), 'Декл.1_ПБ Реф='||Str(REF) )
							Call SalSendClassMessage( SAM_Click, 0, 0 )
				Pushbutton: pbExit
					Class Child Ref Key: 17
					Class ChildKey: 0
					Class: cGenericTableDlg
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   10.517"
						Top:    Class Default
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
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
					Resource Id: 18305
					Class Child Ref Key: 22
					Class ChildKey: 0
					Class: cGenericTableDlg
					Coordinates
						Begin X:  11.067"
						Begin Y:  Class Default
						End X:  11.067"
						End Y:  Class Default
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Data Field: OKPO1
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
							Left:   0.317"
							Top:    0.119"
							Width:  1.617"
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
				Data Field: NAME1
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
							Left:   1.983"
							Top:    0.119"
							Width:  3.8"
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
				Data Field: STAT1
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
							Left:   5.833"
							Top:    0.119"
							Width:  0.417"
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
		Contents
			Child Table: tbl
				Class Child Ref Key: 8
				Class ChildKey: 0
				Class: cGenericTableDlg
				Property Template:
				Class DLL Name:
				Display Settings
					Window Location and Size
						Left:   Class Default
						Top:    Class Default
						Width:  11.967"
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: None
					Text Color: Class Default
					Background Color: Class Default
					View: Class Default
					Allow Row Sizing? Class Default
					Lines Per Row: Class Default
				Memory Settings
					Maximum Rows in Memory: Class Default
					Discardable? Class Default
				Contents
					Column: OKPO
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: ОКПО
								Клиента
						Visible? Yes
						Editable? Yes
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
							On SAM_Validate
								If OKPO != V_Okpo(OKPO)
									Call Debug('Ош.ОКПО')
									Call SalSetFocus( OKPO )
									Return VALIDATE_Cancel
					Column: NAME
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Наименование
								клиента
						Visible? Yes
						Editable? Yes
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  3.283"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: STAT
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Статус
								клиента 
								( U, S, F )
						Visible? Yes
						Editable? Yes
						Maximum Data Length: Default
						Data Type: String
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
							On SAM_Validate
								If STAT != 'U' and STAT != 'S' and STAT != 'F' 
									Call Debug('Ош.Статус')
									Call SalSetFocus( STAT )
									Return VALIDATE_Cancel
					Column: MFO
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Код
								ЛОРО-
								банка
						Visible? Yes
						Editable? Yes
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
					Column: NB
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Наименование 
								ЛОРО-
								банка
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  3.25"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
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
					On SAM_DoubleClick
						Call SalSendMsg( pbOk, SAM_Click, 0, 0 )
		Functions
		Window Parameters
			Number: REF
		Window Variables
		Message Actions
			On SAM_Create
				Call SalCenterWindow( hWndForm )
				If SqlPrepareAndExecute( hSqlAux(),
						  "SELECT min(decode(tag,'ASP_N',value,NULL)), 
						          min(decode(tag,'ASP_K',value,NULL)),
						          min(decode(tag,'ASP_S',value,NULL))
						 INTO :NAME1, :OKPO1, :STAT1 
						 FROM operw WHERE ref=:REF ") 
						and  SqlFetchNext( hSqlAux(), nFetchRes )
				Set strSqlPopulate=
						"SELECT asp_loro.OKPO, asp_loro.NAME, asp_loro.STAT, asp_loro.MFO , b.nb   
						 INTO :dlg_Decl.tbl.OKPO, :dlg_Decl.tbl.NAME, :dlg_Decl.tbl.STAT, :dlg_Decl.tbl.MFO, :dlg_Decl.tbl.NB
						 FROM  asp_loro, banks b
						 WHERE asp_loro.mfo=b.mfo (+) 
						 ORDER BY asp_loro.MFO, asp_loro.NAME "
				Set strSqlInsert=
						"INSERT INTO asp_loro (OKPO,NAME,STAT,MFO) values (:dlg_Decl.tbl.OKPO, :dlg_Decl.tbl.NAME, :dlg_Decl.tbl.STAT, :dlg_Decl.tbl.MFO)"
				Set strSqlUpdate=
						"UPDATE asp_loro SET NAME=:dlg_Decl.tbl.NAME, STAT= :dlg_Decl.tbl.STAT, MFO=:dlg_Decl.tbl.MFO 
						 WHERE OKPO=:dlg_Decl.tbl.OKPO "
				Set strSqlDelete="DELETE FROM asp_loro WHERE OKPO=:dlg_Decl.tbl.OKPO "
				Set strFilterTblName="ASP_LORO"
				Set strPrintFileName="ASP_LORO"
				! Set nFlags=GT_ReadOnly
				Call SalSendClassMessage( UM_Create, 0, 0 )
	! cGenericTableSpl: R3
.data CLASSPROPS
0000: 56543A53706C6974 746572002B000100 00000000000090B0 A800C8D8D8005880
0020: 7800020000000000 0000010000000100 0000000000000001 00000000
.enddata
.data CLASSPROPSSIZE
0000: 3C00
.enddata
		                                        Description: 
		                                        Named Menus 
		                                        Menu 
		                                        Tool Bar 
			                                        Contents 
				                                        Pushbutton: pbIns
					                                        Message Actions 
				                                        Pushbutton: pbDel
					                                        Message Actions 
				                                        Pushbutton: pbRefresh
					                                        Message Actions 
				                                        Pushbutton: pbUpdate
					                                        Message Actions 
				                                        Line 
				                                        Pushbutton: pbSearch
					                                        Message Actions 
				                                        Pushbutton: pbFilter
					                                        Message Actions 
				                                        Pushbutton: pbDetails
					                                        Message Actions 
				                                        Pushbutton: pbPrint
					                                        Message Actions 
				                                        Line 
				                                        Pushbutton: pbExit
					                                        Message Actions 
				                                        Line 
		                                        Contents 
			                                        Custom Control: ccSplitter
				                                        Message Actions 
			                                        Child Table: tbl
				                                        Contents 
					                                        Column: REF
						                                        List Values 
						                                        Message Actions 
					                                        Column: STMT
						                                        List Values 
						                                        Message Actions 
					                                        Column: TT
						                                        List Values 
						                                        Message Actions 
					                                        Column: ND
						                                        List Values 
						                                        Message Actions 
					                                        Column: FDAT
						                                        List Values 
						                                        Message Actions 
					                                        Column: KV
						                                        List Values 
						                                        Message Actions 
					                                        Column: NLSD
						                                        List Values 
						                                        Message Actions 
					                                        Column: NLSK
						                                        List Values 
						                                        Message Actions 
					                                        Column: S
						                                        List Values 
						                                        Message Actions 
					                                        Column: NAZN
						                                        List Values 
						                                        Message Actions 
				                                        Functions 
				                                        Window Variables 
				                                        Message Actions 
					                                        On SAM_RowSetContext
						                                        Call SalWaitCursor(TRUE)
						                                        Call SalTblPopulate(R3.tbl2, hSqlAux2(), 
								"SELECT r.REF, r.STMT, a.NLS, r.DK, r.S, r.PFM, r.FP, r.MVZ, r.VZ, r.NDR, r.ISP, r.ISPK, r.acc
								 INTO :R3.tbl2.REF, :R3.tbl2.STMT,:R3.tbl2.NLS, :R3.tbl2.DK, :R3.tbl2.S,
								      :R3.tbl2.PFM, :R3.tbl2.FP,  :R3.tbl2.MVZ, :R3.tbl2.VZ, :R3.tbl2.NDR,
								      :R3.tbl2.ISP, :R3.tbl2.ISPK,:R3.tbl2.ACC            
								 FROM  R3_IS r, accounts a 
								 WHERE r.ref="||Str(R3.tbl.REF)||" and r.acc=a.acc 
								 ORDER BY a.nls,r.STMT", 
								TBL_FillAll)
						                                        Call SalWaitCursor(FALSE)
			                                        Child Table: tbl2
				                                        Contents 
					                                        Column: ACC
						                                        List Values 
						                                        Message Actions 
					                                        Column: NLS
						                                        List Values 
						                                        Message Actions 
					                                        Column: DK
						                                        List Values 
						                                        Message Actions 
					                                        Column: PFM
						                                        List Values 
						                                        Message Actions 
					                                        Column: FP
						                                        List Values 
						                                        Message Actions 
					                                        Column: MVZ
						                                        List Values 
						                                        Message Actions 
					                                        Column: VZ
						                                        List Values 
						                                        Message Actions 
					                                        Column: NDR
						                                        List Values 
						                                        Message Actions 
					                                        Column: S
						                                        List Values 
						                                        Message Actions 
							                                        On SAM_Validate
								                                        If SqlPrepareAndExecute( hSqlAux2(),
										"UPDATE r3_is Set s=:R3.tbl2.S where 
										 REF=:R3.tbl.REF and STMT=:R3.tbl2.STMT and 
										 DK=:R3.tbl2.DK and SOS=0 and S=:R3.tbl2.S1 and 
										 ACC=:R3.tbl2.ACC")     
										and SqlCommit( hSqlAux2() )
								                                        Set R3.nSTMT=R3.tbl2.STMT
								                                        Set R3.nDK=R3.tbl2.DK
								                                        Set R3.sNLS=R3.tbl2.NLS
								                                        Set R3.nACC=R3.tbl2.ACC
								                                        Set R3.nS=R3.tbl2.S1 - R3.tbl2.S
								                                        Set R3.tbl2.S1 = R3.tbl2.S
								                                        Call SalTblDefineSplitWindow( R3.tbl2 , 1, TBL_Split_Adjustable)
								                                        Set R3.nRow = SalTblInsertRow( R3.tbl2, TBL_MinRow)
								! Set hCol = GetFirstEditableColumn(hWndForm)
								                                        Call SalTblSetContext( R3.tbl2, R3.nRow)
								                                        Set R3.tbl2.REF=:R3.tbl.REF
								                                        Set R3.tbl2.STMT=R3.nSTMT
								                                        Set R3.tbl2.DK= R3.nDK
								                                        Set R3.tbl2.NLS= R3.sNLS
								                                        Set R3.tbl2.ACC= R3.nACC
								                                        Set R3.tbl2.S= R3.nS
								                                        If SqlPrepareAndExecute( hSqlAux2(),
										"INSERT INTO r3_is (ISP,REF,STMT,DK,SOS,S,ACC) 
										     VALUES (:R3.nID, :R3.tbl.REF,  :R3.tbl2.STMT, :R3.tbl2.DK, 0, :R3.tbl2.S, :R3.tbl2.ACC )" ) 
										and SqlCommit( hSqlAux2() )
								! Call SalTblSetFocusCell(hWndForm, nRow, hCol, 0, 1)
					                                        Column: SOS
						                                        List Values 
						                                        Message Actions 
					                                        Column: ISP
						                                        List Values 
						                                        Message Actions 
					                                        Column: ISPK
						                                        List Values 
						                                        Message Actions 
					                                        Column: S1
						                                        List Values 
						                                        Message Actions 
				                                        Functions 
				                                        Window Variables 
				                                        Message Actions 
					                                        On SAM_FetchRowDone
						                                        Set R3.tbl2.S1=R3.tbl2.S
		                                        Functions 
		                                        Window Parameters 
		                                        Window Variables 
			                                        Number: nID
			                                        Number: n980
			                                        Number: nRow
			                                        Number: nSTMT
			                                        Number: nDK
			                                        Number: nACC
			                                        Number: nS
			                                        String: sNLS
		                                        Message Actions 
			                                        On SAM_Create
				                                        Call SalWaitCursor( TRUE )
				                                        Set R3.nID=GetUserId()
				                                        Set R3.n980=GetBaseVal()
				                                        Call SalMapEnterToTab(TRUE)
				                                        Call SalCenterWindow( R3 )
				                                        Call SalTblSetLockedColumns( R3.tbl2, 5)
				                                        Set R3.strFilterTblName = 'OPER'
				!
				                                        Set R3.strSqlPopulate =
						"SELECT p.REF, d.STMT, d.TT, p.ND, d.FDAT, ad.KV, ad.NLS, ak.NLS, d.S, p.NAZN 
						 INTO :R3.tbl.REF, :R3.tbl.STMT, :R3.tbl.TT,  :R3.tbl.ND, :R3.tbl.FDAT,
						      :R3.tbl.KV,  :R3.tbl.NLSD, :R3.tbl.NLSK,:R3.tbl.S,  :R3.tbl.NAZN 
						 FROM OPER p, opldok d, opldok k, accounts ad, accounts ak
						 WHERE p.ref=d.ref and d.ref=k.ref and d.stmt=k.stmt and d.dk=0 and k.dk=1 and d.sos=5 and 
						       d.acc=ad.acc and k.acc=ak.acc and 
						      (d.ref,d.stmt) in (select ref,stmt from r3_is where sos=0) and 
						      (p.userid=:R3.nID or 
						       (p.tt   in ('R01','D01') and 
						        p.nlsb in (select nls from accounts where kv=:R3.n980) and isp=:R3.nID ) 
						       )
						      )
						 ORDER BY ref "
				                                        Call SalSendClassMessage(SAM_Create, 0, 0)
	Table Window: PB_F
		Class:
		Property Template:
		Class DLL Name:
		Title:
		Icon File:
		Accesories Enabled? Yes
		Visible? No
		Display Settings
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
				Width:  12.8"
				Width Editable? Yes
				Height: 6.393"
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
			Maximum Rows in Memory: 2000000
			Discardable? Yes
		Description:
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Default
				Location? Top
				Visible? Yes
				Size: 0.583"
				Size Editable? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
			Contents
				Combo Box: cmbMES
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Property Template:
					Class DLL Name:
					Window Location and Size
						Left:   0.35"
						Top:    0.179"
						Width:  2.2"
						Width Editable? Yes
						Height: 1.81"
						Height Editable? Yes
					Visible? Yes
					Editable? Yes
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
							Call SalWaitCursor( TRUE )
							Call SqlPrepareAndExecute(hSql(), T(" 
									SELECT distinct  to_char(d.fdat,'YYYY-MM')||' '||m.NAME_PLAIN 
									INTO :sD 
									FROM fdat d, meta_month m 
									WHERE to_char(d.fdat,'MM')+0=m.n
									ORDER  by 1 desc "))
							While SqlFetchNext(hSql(), i)
								Call SalListAdd(hWndItem, sD)
							Call SalListSetSelect(hWndItem, 1)
							Call SalWaitCursor( FALSE )
							Call SalPostMsg(cmbMES, SAM_Click, 0, 0)
						On SAM_Click
							Call SalSetWindowText( PB_F, '1_ПБ за місяць: '||cmbMES )
							Set sD=SalStrLeftX( cmbMES,4)||SalStrMidX( cmbMES, 5, 2)
				Pushbutton: pbOk		! Виконати
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cpbPrint
					Property Template:
					Class DLL Name:
					Title: Виконати
					Window Location and Size
						Left:   2.617"
						Top:    0.071"
						Width:  1.2"
						Width Editable? Yes
						Height: 0.45"
						Height Editable? Yes
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Default
					Picture File Name: \BARS98\RESOURCE\BMP\Execute.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_Click
							Call SalSendMsg( hWndForm, SAM_User, 0,0 )
				Pushbutton: pbAppendData	! Консолід.
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cpbPrint
					Property Template:
					Class DLL Name:
					Title: Консолід.
					Window Location and Size
						Left:   3.883"
						Top:    0.071"
						Width:  1.2"
						Width Editable? Yes
						Height: 0.45"
						Height Editable? Yes
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Default
					Picture File Name: \BARS98\RESOURCE\BMP\CHILDS.BMP
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_Click
							If SalDlgOpenFile(hWndForm, 'Open File', sFilters, nFilters, nIndex, sFileName, sFilePathName)
								Call SalWaitCursor(TRUE)
								Call SalListQueryText( cmbMES, SalListQuerySelection(cmbMES), sChooseDate )
								Set sMonth = SalStrMidX(sChooseDate, 5, 2)
								Set sYear  = SalStrMidX(sChooseDate, 2, 2)
								Set sFileMonth = SalStrMidX(sFileName, 4,2) 
								Set sFileYear = SalStrMidX(sFileName, 6,2) 
								Call SalWaitCursor(FALSE)
								!
								If sMonth != sFileMonth OR sYear != sFileYear
									Call SalMessageBox('Файл не відповідає вибраній даті. Дата файлу: 20'||sFileYear||' рік, '||sFileMonth||' місяць', 'Увага!', MB_IconAsterisk|MB_Ok)
								Else
									Set sFilePathName = SalStrLeftX(sFilePathName, SalStrScan(sFilePathName, sFileName)-1)
									Call GeneralImpExp(hWndForm, 2,4,sFilePathName||','||sFileName||',V_PB2,UKG,3,1', '')
									!
									! Для Аваля
									! Выполнить консолидацию по кодам '9111', '9221', '9112', '9222' для Аваля
									If GetGlobalOption('BANKTYPE') = 'AVAL'
										If not SqlPLSQLCommand(hSql(), "bars.p_conspb1(1)")
											Call SalMessageBox('Помилка при виклику функції консолідації','Увага!',MB_Ok)
										Else
											Call SqlCommit(hSql())
									!
									Call SalTblPopulate( hWndForm, hSql(), sSql,1 )
									Call SalEnableWindow ( ASPLA )
				Line
					Resource Id: 31100
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  5.283"
						Begin Y:  -0.012"
						End X:  5.283"
						End Y:  0.571"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: Default
				Pushbutton: pbDok		! Документ
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cpbPrint
					Property Template:
					Class DLL Name:
					Title: Документ
					Window Location and Size
						Left:   5.533"
						Top:    0.071"
						Width:  1.2"
						Width Editable? Yes
						Height: 0.45"
						Height Editable? Yes
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Default
					Picture File Name: \BARS98\RESOURCE\BMP\Open.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_Click
							If SalTblAnyRows( hWndForm, ROW_Selected, 0 ) and REFE >0 
								If tt='R01' !! СЭП
									Call DocViewContents(hWndMDI, REFE)
								Else !! Просмотр реквизитов внутреннего документа
									Call DocViewContentsEx(hWndMDI, REFE)
				Pushbutton: pbPrint	! Друк
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: cpbPrint
					Property Template:
					Class DLL Name:
					Title: Друк
					Window Location and Size
						Left:   6.733"
						Top:    0.071"
						Width:  1.2"
						Width Editable? Yes
						Height: 0.45"
						Height Editable? Yes
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: MS Sans Serif
					Font Size: 8
					Font Enhancement: Default
					Picture File Name: \BARS98\RESOURCE\BMP\print.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_Click
							! Call TablePrint(tblPB1, '1-ПБ эа '||cmbMES,
									 GetPrnDir() || '\\' || 'pb1', '')
							Call TablePrint(hWndForm, '1-ПБ эа ' || cmbMES, Path_PB || '\\' || 'pb1', '')
				Pushbutton: ASPLA
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Property Template:
					Class DLL Name:
					Title: ASPLA
					Window Location and Size
						Left:   7.933"
						Top:    0.071"
						Width:  1.2"
						Width Editable? Yes
						Height: 0.45"
						Height Editable? Yes
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Picture File Name: \BARS98\RESOURCE\BMP\Nextrec.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_Click
							Call SalWaitCursor(TRUE)
							Set sD1='ABON'||SalStrMidX(sD,4,2)||SalStrMidX(sD,2,2)||'.dbf'
							Call SalUseRegistry(FALSE, '')
							Call SalGetProfileString('ASPLA','ASPLAPATH', 
									SalStrLeftX(SalFileGetDrive(),1)||':\\BARS98\\ODBC.DSN\\OPER',
									 sODBCDir, GetIniFileName())
							If SalFileSetCurrentDirectory(sODBCDir)
								Set SqlDatabase='dBase_Files'
								Set sDP=sODBCDir||'\\'||sD1
								If SqlConnect(hSqlA)
									Set YNC=IDYES
									If SalFileOpen( hF,sDP, OF_Exist)  !! уже существует
										Call SalFileClose( hF )
										Set YNC=SalMessageBox("Видалити дані ?", "Файл "||sDP||" вже існує !", MB_YesNoCancel | MB_IconHand )
										If YNC=IDYES	!! YES - Удалить данные
											Call SqlPrepareAndExecute(hSqlA,"DROP TABLE "|| sD1 )
									If YNC=IDYES	!! YES - Удалить данные
										Call CREATE_DBF()
								Else
									Call MessageAttention('Помилка підключення до Бази даних:'|| SqlDatabase)
							Else
								Call MessageAttention('Немає каталога: ' ||   sODBCDir)
							Call SalWaitCursor(FALSE)
				Pushbutton: EXI		! Вихід
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Property Template:
					Class DLL Name:
					Title: Вихід
					Window Location and Size
						Left:   9.45"
						Top:    0.071"
						Width:  1.133"
						Width Editable? Yes
						Height: 0.45"
						Height Editable? Yes
					Visible? Yes
					Keyboard Accelerator: (none)
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Picture File Name: \BARS98\RESOURCE\BMP\Discard.bmp
					Picture Transparent Color: Gray
					Image Style: Single
					Text Color: Default
					Background Color: Default
					Message Actions
						On SAM_Click
							Call SalDestroyWindow( hWndForm )
				Line
					Resource Id: 27925
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  9.283"
						Begin Y:  -0.012"
						End X:  9.283"
						End Y:  0.571"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: Default
		Contents
			Column: LN
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: L
						N
				Visible? No
				Editable? No
				Maximum Data Length: 1
				Data Type: String
				Justify: Right
				Width:  0.25"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: DEN		! День
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: День
				Visible? Yes
				Editable? No
				Maximum Data Length: 2
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
			Column: MEC		! Міс
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Міс
				Visible? No
				Editable? No
				Maximum Data Length: 2
				Data Type: Number
				Justify: Left
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
			Column: GOD		! Рік
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Рік
				Visible? No
				Editable? No
				Maximum Data Length: 2
				Data Type: Number
				Justify: Left
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
			Column: BAKOD		! Банк
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Банк
				Visible? No
				Editable? No
				Maximum Data Length: 4
				Data Type: String
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
			Column: COUNKOD		! Країна КР
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Країна
						КР
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
				Data Type: String
				Justify: Left
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
			Column: PARTN		! Назва КР
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Назва
						КР
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
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
			Column: VALKOD		! ВАЛ KР
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ВАЛ
						KР
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
				Data Type: String
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
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: NLS		! KорРахунок
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: KорРахунок
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
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
			Column: KOR
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
			Column: KRE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: КРД
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  Default
				Width Editable? Yes
				Format: 0000
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: DEB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ДЕБ
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  Default
				Width Editable? Yes
				Format: #0000
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: COUN		! Країна бен
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Країна
						бен
				Visible? Yes
				Editable? No
				Maximum Data Length: 3
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
			Column: KOD		! Код призн
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Код
						призн
				Visible? Yes
				Editable? No
				Maximum Data Length: 7
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
			Column: PODK
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
			Column: OPER		! Призначення пл.
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Призначення пл.
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Left
				Width:  4.483"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: NAL
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
			Column: BANK		! КБ
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: КБ
				Visible? Yes
				Editable? No
				Maximum Data Length: 4
				Data Type: String
				Justify: Right
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
			Column: REFE
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: REF/
						REC
						
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: Number
				Justify: Right
				Width:  1.071"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: tt
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: REF/
						REC
						
				Visible? No
				Editable? No
				Maximum Data Length: Default
				Data Type: String
				Justify: Right
				Width:  1.071"
				Width Editable? Yes
				Format: Unformatted
				Country: Default
				Input Mask: Unformatted
				Cell Options
					Cell Type? Standard
					Multiline Cell? No
					Cell DropDownList
						Sorted? Yes
						Vertical Scroll? Yes
						Auto Drop Down? No
						Allow Text Editing? Yes
					Cell CheckBox
						Check Value:
						Uncheck Value:
						Ignore Case? Yes
				List Values
				Message Actions
			Column: KOST
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
			Function: CREATE_DBF
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
					Call SqlPrepareAndExecute(hSqlA, "CREATE table "||sD1||" (
							MEC numeric(2,0) ,
							GOD numeric(2,0) ,
							BAKOD char(4)    ,
							COUNKOD char(3)  ,
							PARTN char(47)   ,
							VALKOD char(3)   ,
							KOR char(4)      ,
							KOD char(4)      ,
							COUN char(3)     ,
							KRE numeric(14,3),
							DEB numeric(14,3),
							OPER char(110)   ,
							BANK char(4) ,
							NAL char(2)  
							)" )
					Set i = TBL_MinRow
					Set ie=0
					While SalTblFindNextRow( hWndForm, i, 0, 0 )
						Call SalTblFetchRow( hWndForm, i )
						Set aa=StrWinToDosX(PARTN)
						Set bb=StrWinToDosX(OPER)
						Set kor=StrWinToDosX(KOR)
						If not SqlPrepareAndExecute( hSqlA,
								"INSERT into "||sD1||"(MEC,GOD,BAKOD,COUNKOD,PARTN,VALKOD,KRE,DEB,COUN,KOD,OPER,BANK,KOR) 
								VALUES (:PB_F.MEC,   :PB_F.GOD, :PB_F.BAKOD,:PB_F.COUNKOD,:aa, 
								        :PB_F.VALKOD,:PB_F.KRE, :PB_F.DEB,  :PB_F.COUN,
								        :PB_F.KOD,   :bb,            :PB_F.BANK,:kor) ") 
							Set ie=1
							Break
					If ie=1
						Call SqlRollback(hSqlA )
						Call SalMessageBox( "НЕУСПЕШНАЯ Выгрузка в " || sDP || " !", "Экспорт", MB_Ok)
					Else
						Call SqlCommit(hSqlA)
						Call SalMessageBox( "Выгрузка в " || sDP || " завершена!", "Экспорт", MB_Ok)
					Call SqlDisconnect(hSqlA)
		Window Parameters
		Window Variables
			Number: YNC
			: cFi
				Class: cGenFilter
			String: Sfi
			String: sTmp
			Number: i
			Number: ie
			String: strTemp
			Number: nTmp
			String: sDP
			String: sD
			String: sD1
			String: sODBCDir
			String: aa
			String: bb
			String: kor
			String: sKOD_B
			Sql Handle: hSqlA 
			Date/Time: dTmp
			File Handle: hF
			String: Path_PB
			!
			String: sFileName
			String: sFilePath
			String: sFilePathName
			String: sFilters[0:2]
			Number: nFilters
			Number: nIndex
			File Handle: hFile
			String: sErrMsg
			String: sYear
			String: sMonth
			String: sFileYear
			String: sFileMonth
			String: sChooseDate
			Number: nLength
			String: sSql
		Message Actions
			On SAM_Create
				Set sKOD_B = GetValueStr("SELECT val from params where par='1_PB' ") 
				If Val(sKOD_B) = 30
					Call SalDisableWindow(pbDok)
				If GetGlobalOption('BANKTYPE') = 'AVAL'
					Call SalDisableWindow(pbDok)
				Call cFi.Init('PB_1','a')
				Call SalDisableWindow( ASPLA )
				! Путь для печати
				Call SalUseRegistry( FALSE, '' )
				Call SalGetProfileString( 'Export', 'PathPB1', GetPrnDir(), Path_PB, GetIniFileName() )
				!
				Set sFilters[0] = 'DBF files'
				Set sFilters[1] = '*.dbf'
				Set nFilters = 2
				Set nIndex = 1
				Set sSql = "
						SELECT srt, refc, tt, LN, 
						       DEN, MEC, GOD, BAKOD, COUNKOD, PARTN, VALKOD, 
						       NLS, KRE, DEB, COUN, KOD, OPER, BANK, KOR  
						INTO  :PB_F.KOST,:PB_F.REFE,
						             :PB_F.tt,
						             :PB_F.LN,
						             :PB_F.DEN,
						             :PB_F.MEC,
						             :PB_F.GOD,
						             :PB_F.BAKOD,
						             :PB_F.COUNKOD,
						             :PB_F.PARTN,
						             :PB_F.VALKOD,
						             :PB_F.NLS,
						             :PB_F.KRE,
						             :PB_F.DEB,
						             :PB_F.COUN,
						             :PB_F.KOD,
						             :PB_F.OPER,
						             :PB_F.BANK,
						             :PB_F.KOR
						FROM (
						SELECT   DECODE (SUBSTR (kod, 1, 1), '9', '0', '1') srt, refc, tt, LN, den,
						                 mec, god, bakod, counkod, partn, valkod, nls, kre, deb, coun,
						                 kod, oper, bank, kor
						            FROM pb_1
						           WHERE (SUBSTR (kod, 1, 1) <> '9' ) AND
						                 (kre <> 0 OR deb <> 0)
						UNION ALL 
						SELECT   DECODE (SUBSTR (kod, 1, 1), '9', '0', '1') srt, refc, tt, LN, den,
						                 mec, god, bakod, counkod, partn, valkod, nls, kre, deb, coun,
						                 kod, oper, bank, kor
						            FROM pb_1
						           WHERE (SUBSTR (kod, 1, 1) ='9' AND partn<>'ГОТІВКА') 
						UNION ALL 
						SELECT   DECODE (SUBSTR (kod, 1, 1), '9', '0'||substr(kod,2), '1') srt,
						                 TO_NUMBER (NULL) refc, '' tt, '' ln, TO_NUMBER (NULL) den, mec, god,
						                 bakod, counkod, partn, valkod, SUBSTR(nls,1,3), SUM (kre) kre, SUM (deb) deb,
						                 coun, kod, oper, bank, kor
						            FROM pb_1
						           WHERE SUBSTR (kod, 1, 1) = '9' AND partn='ГОТІВКА'
						        GROUP BY mec,
						                 god,
						                 bakod,
						                 counkod,
						                 partn,
						                 valkod,
						                 coun,
						                 kod,
						                 oper,
						                 bank,
						                 kor, 
						                 SUBSTR(nls,1,3))
						ORDER BY VALKOD, PARTN, NLS, srt, god, mec, den, kod"
				Call SalCenterWindow(hWndForm)
				!
			On SAM_User
				Call SalWaitCursor( TRUE )
				If SalStrTrimX(SalStrUpperX( GetDBMS() ))='ORACLE'
					Set strTemp = GetGlobalOption( 'RNBURBCK' )
					If strTemp != ''
						Call SqlPrepareAndExecute(hSql(), 'SET TRANSACTION USE ROLLBACK SEGMENT ' || SalStrUpperX(strTemp) )
					!
					If SqlPrepareAndExecute(hSql(), 
							  "SELECT status 
							   INTO :strTemp
							   FROM all_objects 
							   WHERE owner='BARS' AND object_name='FPB1'")
							and SqlFetchNext(hSql(), nTmp)
							and SalStrTrimX(strTemp) = 'INVALID'
							and SqlPrepareAndExecute(hSql(), 
							   "ALTER  PROCEDURE FPB1 COMPILE")
					If SqlPLSQLCommand( hSql(), "FPB1(sKOD_B,sD)")
						Call SqlCommit( hSql() )
						Call SalTblPopulate( hWndForm, hSql(), sSql,1 )
						! Call SalTblPopulate( tblPB1, hSql(), "
								SELECT refc,tt,LN,DEN,MEC,GOD,BAKOD,COUNKOD,PARTN,VALKOD, 
								       NLS,KRE,DEB, COUN, KOD, OPER,BANK 
								INTO  :REFE,:tt,:LN,:DEN,:MEC,:GOD,:BAKOD,:COUNKOD,:PARTN,:VALKOD,
								      :NLS,:KRE,:DEB,:COUN,:KOD,:OPER,:BANK
								FROM pb_1 a
								ORDER by NLS,
								         VALKOD,
								         decode(substr(kod,1,1),'9',0,1),
								         decode(substr(kod,1,1),'9',kod, to_char(100+den) )",1 )
						! Call SalEnableWindow( pbFiltr )
						Call SalEnableWindow( ASPLA )
				Call SalWaitCursor( FALSE )
			On SAM_FetchRowDone
				If Subs(OPER,1,1) = '|'
					Call XSalTblSetRowBackColor( hWndForm, lParam, COLOR_Green )
